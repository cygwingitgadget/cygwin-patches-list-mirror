Return-Path: <cygwin-patches-return-3034-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22666 invoked by alias); 24 Sep 2002 06:49:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22652 invoked from network); 24 Sep 2002 06:49:30 -0000
Date: Mon, 23 Sep 2002 23:49:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fhandler_tty doecho change
Message-ID: <20020924015053.A21742@eris.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-SW-Source: 2002-q3/txt/msg00482.txt.bz2

Hi,
A week or so ago, I found that rxvt hangs could be fixed by making
the tty pipe non-blocking.  As I look into this more, I discovered
that fhandler_pty_master::doecho uses the slave's side of the
pipe to accomplish echoing characters to the terminal.  A clever
and simple solution, but it causes a deadlock when the slave's 
write pipe is full.  

The solution presented in this patch is to use a buffer to store the
echo characters, similar to the readahead buffer.  I wanted to use
the readahead buffer, but convinced myself that the data was 
different enough that folding it in would create more complex code
than necessary. 

Fixing this deadlock revealed a deadlock in the 
fhandler_pty_master::accept_input code which will be the subject of 
my next patch.

Thanks,
-steve

Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.140
diff -c -r1.140 fhandler.h
*** fhandler.h  19 Sep 2002 03:30:20 -0000      1.140
--- fhandler.h  24 Sep 2002 06:27:19 -0000
***************
*** 918,923 ****
--- 918,934 ----
  
    void set_close_on_exec (int val);
    bool hit_eof ();
+ 
+   bool get_echobuf_valid () { return ebixget < ebixput; }
+ 
+  protected:
+   char *ebbuf;                /* used for buffering echo chars */
+   size_t ebixget;
+   size_t ebixput;
+   size_t ebbuflen;
+   HANDLE ebguard;
+   int get_echobuf_into_buffer (char *buf, size_t buflen);
+   void clear_echobuf ();
  };
  
  class cygthread;
Index: fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.73
diff -c -r1.73 fhandler_tty.cc
*** fhandler_tty.cc     22 Sep 2002 12:04:15 -0000      1.73
--- fhandler_tty.cc     24 Sep 2002 06:27:22 -0000
***************
*** 128,142 ****
  }
  
  /* Process tty input. */
! 
  void
  fhandler_pty_master::doecho (const void *str, DWORD len)
  {
!   acquire_output_mutex (INFINITE);
!   if (!WriteFile (get_ttyp ()->to_master, str, len, &len, NULL))
!     termios_printf ("Write to %p failed, %E", get_ttyp ()->to_master);
! //  WaitForSingleObject (output_done_event, INFINITE);
!   release_output_mutex ();
  }
  
  int
--- 128,181 ----
  }
  
  /* Process tty input. */
! #define ECHOBUF_MAXSIZE 4096
  void
  fhandler_pty_master::doecho (const void *str, DWORD len)
  {
!   const char *s = (const char *)str; 
!   if (ebguard == NULL)
!     ebguard = CreateMutex (&sec_all, FALSE, NULL);
!   WaitForSingleObject(ebguard,INFINITE);
!   if (ebixput + len > ebbuflen && ebbuflen < ECHOBUF_MAXSIZE) 
!     {
!       int roundlen = (len + 31) & ~31;
!       char *newbuf = (char *) realloc (ebbuf, ebbuflen + roundlen);
!       if (newbuf) 
!       {
!         ebbuf = newbuf;
!         ebbuflen += roundlen;
!       }
!     }
!   while (len-- >0 && ebixput < ebbuflen) 
!     ebbuf[ebixput++] = *s++;
!   ReleaseMutex(ebguard);
! }
! 
! int
! fhandler_pty_master::get_echobuf_into_buffer (char *buf, size_t buflen)
! {
!   size_t copied_chars = 0;
!   WaitForSingleObject(ebguard,INFINITE);
!   while (copied_chars < buflen && ebixget < ebixput)
!       buf[copied_chars++] = ebbuf[ebixget++];
! 
!   if (ebixget >= ebixput)
!     ebixget = ebixput = 0;
!   termios_printf ("echoed %d chars %d",copied_chars,buflen);
!   ReleaseMutex(ebguard);
!   return (int)copied_chars;
! }
! 
! void 
! fhandler_pty_master::clear_echobuf ()
! {
!   ebixput = ebixget = ebbuflen = 0;
!   if (ebbuf) 
!     free(ebbuf);
!   ebbuf = NULL;
!   if (ebguard) 
!     ForceCloseHandle(ebguard);
!   ebguard = NULL;
  }
  
  int
***************
*** 255,261 ****
  
        HANDLE handle = get_io_handle ();
  
!       n = 0; // get_readahead_into_buffer (outbuf, len);
        if (!n)
        {
          /* Doing a busy wait like this is quite inefficient, but nothing
--- 294,300 ----
  
        HANDLE handle = get_io_handle ();
  
!       n = get_echobuf_into_buffer (outbuf, rlen);
        if (!n)
        {
          /* Doing a busy wait like this is quite inefficient, but nothing
***************
*** 952,958 ****
   fhandler_pty_master
  */
  fhandler_pty_master::fhandler_pty_master (DWORD devtype, int unit)
!   : fhandler_tty_common (devtype, unit)
  {
  }
  
--- 991,1002 ----
   fhandler_pty_master
  */
  fhandler_pty_master::fhandler_pty_master (DWORD devtype, int unit)
!   : fhandler_tty_common (devtype, unit),
!     ebbuf (NULL),
!     ebixget (0),
!     ebixput (0),
!     ebbuflen (0),
!     ebguard (NULL)
  {
  }
  
***************
*** 967,972 ****
--- 1011,1017 ----
    inuse = get_ttyp ()->create_inuse (TTY_MASTER_ALIVE);
    set_flags ((flags & ~O_TEXT) | O_BINARY);
    set_open_status ();
+   clear_echobuf();
  
    termios_printf ("opened pty master tty%d<%p>", ttynum, this);
    return 1;
***************
*** 1031,1037 ****
        CloseHandle (get_ttyp ()->to_master);
        get_ttyp ()->init ();
      }
! 
    return 0;
  }
  
--- 1076,1082 ----
        CloseHandle (get_ttyp ()->to_master);
        get_ttyp ()->init ();
      }
!   clear_echobuf();
    return 0;
  }
  
Index: select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.80
diff -c -r1.80 select.cc
*** select.cc   23 Sep 2002 00:31:30 -0000      1.80
--- select.cc   24 Sep 2002 06:27:25 -0000
***************
*** 431,437 ****
        {
        case FH_PTYM:
        case FH_TTYM:
!         if (((fhandler_pty_master *)fh)->need_nl)
            {
              gotone = s->read_ready = true;
              goto out;
--- 431,438 ----
        {
        case FH_PTYM:
        case FH_TTYM:
!         if (((fhandler_pty_master *)fh)->need_nl 
!             || ((fhandler_pty_master *)fh)->get_echobuf_valid ())
            {
              gotone = s->read_ready = true;
              goto out;

Return-Path: <cygwin-patches-return-6900-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31202 invoked by alias); 13 Jan 2010 21:26:04 -0000
Received: (qmail 31062 invoked by uid 22791); 13 Jan 2010 21:25:57 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 13 Jan 2010 21:25:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id CB7826D4190; Wed, 13 Jan 2010 22:25:37 +0100 (CET)
Date: Wed, 13 Jan 2010 21:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100113212537.GB14511@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00016.txt.bz2

Hi,

the below patch implements the Linux dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
extension.  I hope I didn't miss anything important since it affects
quite a few fhandlers.  Fortunately most is mechanical change, except
for a few places (dtable.cc, pipe.cc, fhandeler_fifo.cc, syscalls.cc).
Nevertheless, I'd be glad if somebody could have a second look into
this.

Eric, you asked for it in the first place, do you have a fine testcase
for this functionality?


Thanks,
Corinna


    Newlib:

	* libc/include/sys/_default_fcntl.h (O_CLOEXEC): Define as _FNOINHERIT.
	(F_DUPFD_CLOEXEC): Define for Cygwin.
	* libc/include/sys/unistd.h (dup3): Define for Cygwin.

    Cygwin:

	* cygwin.din (dup3): Export.
	* dtable.cc (dtable::dup_worker): Take additional flags parameter.
	Handle O_CLOEXEC flag.
	(dtable::dup3): Rename from dup2.  Take additional flags parameter,
	check for valid flags.
	* dtable.h (dtable::dup_worker): Add flags parameter.
	(dtable::dup3): Rename from dup2.
	* fcntl.cc (fcntl64): Add F_DUPFD_CLOEXEC case.
	* fhandler.h (fhandler_mailslot::get_object_attr): Add flags parameter.
	* fhandler.cc (fhandler_base::open): Handle O_CLOEXEC flag.
	* fhandler_console.cc (fhandler_console::open): Ditto.
	* fhandler_disk_file.cc (fhandler_cygdrive::open): Ditto.
	* fhandler_dsp.cc (fhandler_dev_dsp::open): Ditto.
	* fhandler_fifo.cc (fhandler_fifo::open): Ditto.
	(fhandler_fifo::wait): Ditto.
	* fhandler_mailslot.cc (fhandler_mailslot::get_object_attr): Take
	additional flags parameter.  Handle O_CLOEXEC flag.
	(fhandler_mailslot::open): Call get_object_attr with flags parameter.
	* fhandler_mem.cc (fhandler_dev_mem::open): Handle O_CLOEXEC flag.
	* fhandler_random.cc (fhandler_dev_random::open): Ditto.
	* fhandler_registry.cc (fhandler_registry::open): Ditto.
	* fhandler_tape.cc (fhandler_dev_tape::open): Ditto.
	* fhandler_tty.cc (fhandler_tty_slave::open): Ditto.
	* fhandler_virtual.cc (fhandler_virtual::open): Ditto.
	* fhandler_zero.cc (fhandler_dev_zero::open): Ditto.
	* pipe.cc: Replace usage of O_NOINHERIT with O_CLOEXEC.
	(fhandler_pipe::open): Simplify setting close_on_exec flag.
	(fhandler_pipe::create): Handle O_CLOEXEC flag.
	* syscalls.cc (dup): Accommodate renaming of dtable::dup2 toh
	dtable::dup3.
	(dup2): Ditto.
	(dup3): New function.  Check "oldfd==newfd" condition not shared
	with dup2.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.


Index: newlib/libc/include/sys/_default_fcntl.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/_default_fcntl.h,v
retrieving revision 1.4
diff -u -p -r1.4 _default_fcntl.h
--- newlib/libc/include/sys/_default_fcntl.h	8 Dec 2009 13:50:41 -0000	1.4
+++ newlib/libc/include/sys/_default_fcntl.h	13 Jan 2010 21:22:11 -0000
@@ -51,6 +51,8 @@ extern "C" {
 #define O_BINARY	_FBINARY
 #define O_TEXT		_FTEXT
 #define O_NOINHERIT	_FNOINHERIT
+/* O_CLOEXEC is the Linux equivalent to O_NOINHERIT */
+#define O_CLOEXEC	_FNOINHERIT
 
 /* The windows header files define versions with a leading underscore.  */
 #define _O_RDONLY	O_RDONLY
@@ -122,6 +124,9 @@ extern "C" {
 #define	F_CNVT 		12	/* Convert a fhandle to an open fd */
 #define	F_RSETLKW 	13	/* Set or Clear remote record-lock(Blocking) */
 #endif	/* !_POSIX_SOURCE */
+#ifdef __CYGWIN__
+#define	F_DUPFD_CLOEXEC	14	/* As F_DUPFD, but set close-on-exec flag */
+#endif
 
 /* fcntl(2) flags (l_type field of flock structure) */
 #define	F_RDLCK		1	/* read lock */
Index: newlib/libc/include/sys/unistd.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/unistd.h,v
retrieving revision 1.75
diff -u -p -r1.75 unistd.h
--- newlib/libc/include/sys/unistd.h	22 Dec 2009 13:07:24 -0000	1.75
+++ newlib/libc/include/sys/unistd.h	13 Jan 2010 21:22:11 -0000
@@ -38,6 +38,7 @@ int	_EXFUN(daemon, (int nochdir, int noc
 int     _EXFUN(dup, (int __fildes ));
 int     _EXFUN(dup2, (int __fildes, int __fildes2 ));
 #if defined(__CYGWIN__)
+int     _EXFUN(dup3, (int __fildes, int __fildes2, int flags));
 int	_EXFUN(eaccess, (const char *__path, int __mode));
 void	_EXFUN(endusershell, (void));
 int	_EXFUN(euidaccess, (const char *__path, int __mode));
Index: winsup/cygwin/cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.217
diff -u -p -r1.217 cygwin.din
--- winsup/cygwin/cygwin.din	12 Nov 2009 14:40:47 -0000	1.217
+++ winsup/cygwin/cygwin.din	13 Jan 2010 21:22:12 -0000
@@ -297,6 +297,7 @@ dup SIGFE
 _dup = dup SIGFE
 dup2 SIGFE
 _dup2 = dup2 SIGFE
+dup3 SIGFE
 eaccess = euidaccess SIGFE
 ecvt SIGFE
 _ecvt = ecvt SIGFE
Index: winsup/cygwin/dtable.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.211
diff -u -p -r1.211 dtable.cc
--- winsup/cygwin/dtable.cc	12 Jan 2010 10:14:59 -0000	1.211
+++ winsup/cygwin/dtable.cc	13 Jan 2010 21:22:13 -0000
@@ -559,7 +559,7 @@ build_fh_pc (path_conv& pc, bool set_nam
 }
 
 fhandler_base *
-dtable::dup_worker (fhandler_base *oldfh)
+dtable::dup_worker (fhandler_base *oldfh, int flags)
 {
   /* Don't call set_name in build_fh_pc.  It will be called in
      fhandler_base::operator= below.  Calling it twice will result
@@ -579,7 +579,11 @@ dtable::dup_worker (fhandler_base *oldfh
 	}
       else
 	{
-	  newfh->close_on_exec (false);
+	  /* The O_CLOEXEC flag enforces close-on-exec behaviour. */
+	  if (flags & O_CLOEXEC)
+	    newfh->set_close_on_exec (true);
+	  else
+	    newfh->close_on_exec (false);
 	  debug_printf ("duped '%s' old %p, new %p", oldfh->get_name (), oldfh->get_io_handle (), newfh->get_io_handle ());
 	}
     }
@@ -587,13 +591,13 @@ dtable::dup_worker (fhandler_base *oldfh
 }
 
 int
-dtable::dup2 (int oldfd, int newfd)
+dtable::dup3 (int oldfd, int newfd, int flags)
 {
   int res = -1;
   fhandler_base *newfh = NULL;	// = NULL to avoid an incorrect warning
 
   MALLOC_CHECK;
-  debug_printf ("dup2 (%d, %d)", oldfd, newfd);
+  debug_printf ("dup3 (%d, %d, %d)", oldfd, newfd, flags);
   lock ();
 
   if (not_open (oldfd))
@@ -602,21 +606,25 @@ dtable::dup2 (int oldfd, int newfd)
       set_errno (EBADF);
       goto done;
     }
-
   if (newfd < 0)
     {
       syscall_printf ("new fd out of bounds: %d", newfd);
       set_errno (EBADF);
       goto done;
     }
-
+  if ((flags & ~O_CLOEXEC) != 0)
+    {
+      syscall_printf ("invalid flags value %x", flags);
+      set_errno (EINVAL);
+      return -1;
+    }
   if (newfd == oldfd)
     {
       res = newfd;
       goto done;
     }
 
-  if ((newfh = dup_worker (fds[oldfd])) == NULL)
+  if ((newfh = dup_worker (fds[oldfd], flags)) == NULL)
     {
       res = -1;
       goto done;
@@ -644,7 +652,7 @@ dtable::dup2 (int oldfd, int newfd)
 done:
   MALLOC_CHECK;
   unlock ();
-  syscall_printf ("%d = dup2 (%d, %d)", res, oldfd, newfd);
+  syscall_printf ("%d = dup3 (%d, %d, %d)", res, oldfd, newfd, flags);
 
   return res;
 }
Index: winsup/cygwin/dtable.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.h,v
retrieving revision 1.51
diff -u -p -r1.51 dtable.h
--- winsup/cygwin/dtable.h	12 Jan 2010 10:14:59 -0000	1.51
+++ winsup/cygwin/dtable.h	13 Jan 2010 21:22:13 -0000
@@ -51,7 +51,7 @@ public:
   int vfork_child_dup ();
   void vfork_parent_restore ();
   void vfork_child_fixup ();
-  fhandler_base *dup_worker (fhandler_base *oldfh);
+  fhandler_base *dup_worker (fhandler_base *oldfh, int flags);
   int extend (int howmuch);
   void fixup_after_fork (HANDLE);
   inline int not_open (int fd)
@@ -65,7 +65,7 @@ public:
   int find_unused_handle () { return find_unused_handle (first_fd_for_open);}
   void release (int fd);
   void init_std_file_from_handle (int fd, HANDLE handle);
-  int dup2 (int oldfd, int newfd);
+  int dup3 (int oldfd, int newfd, int flags);
   void fixup_after_exec ();
   inline fhandler_base *&operator [](int fd) const { return fds[fd]; }
   bool select_read (int fd, select_stuff *);
Index: winsup/cygwin/fcntl.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fcntl.cc,v
retrieving revision 1.31
diff -u -p -r1.31 fcntl.cc
--- winsup/cygwin/fcntl.cc	22 Sep 2009 04:09:03 -0000	1.31
+++ winsup/cygwin/fcntl.cc	13 Jan 2010 21:22:13 -0000
@@ -1,7 +1,7 @@
 /* fcntl.cc: fcntl syscall
 
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2008,
-   2009 Red Hat, Inc.
+   2009, 2010 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -49,6 +49,15 @@ fcntl64 (int fd, int cmd, ...)
 	  res = -1;
 	}
       break;
+    case F_DUPFD_CLOEXEC:
+      if ((int) arg >= 0 && (int) arg < OPEN_MAX_MAX)
+	res = dup3 (fd, cygheap_fdnew (((int) arg) - 1), O_CLOEXEC);
+      else
+	{
+	  set_errno (EINVAL);
+	  res = -1;
+	}
+      break;
     case F_GETLK:
     case F_SETLK:
     case F_SETLKW:
Index: winsup/cygwin/fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.359
diff -u -p -r1.359 fhandler.cc
--- winsup/cygwin/fhandler.cc	18 Dec 2009 20:32:03 -0000	1.359
+++ winsup/cygwin/fhandler.cc	13 Jan 2010 21:22:13 -0000
@@ -1,7 +1,7 @@
 /* fhandler.cc.  See console.cc for fhandler_console functions.
 
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
-   2005, 2006, 2007, 2008, 2009 Red Hat, Inc.
+   2005, 2006, 2007, 2008, 2009, 2010 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -469,7 +469,7 @@ fhandler_base::open (int flags, mode_t m
 
   syscall_printf ("(%S, %p)", pc.get_nt_native_path (), flags);
 
-  pc.get_object_attr (attr, sec_none);
+  pc.get_object_attr (attr, (flags & O_CLOEXEC) ? sec_none_nih : sec_none);
 
   switch (query_open ())
     {
@@ -620,6 +620,7 @@ fhandler_base::open (int flags, mode_t m
 
   set_io_handle (fh);
   set_flags (flags, pc.binmode ());
+  close_on_exec (!!(flags & O_CLOEXEC));
 
   res = 1;
   set_open_status ();
Index: winsup/cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.389
diff -u -p -r1.389 fhandler.h
--- winsup/cygwin/fhandler.h	10 Jan 2010 11:12:52 -0000	1.389
+++ winsup/cygwin/fhandler.h	13 Jan 2010 21:22:13 -0000
@@ -399,7 +399,7 @@ class fhandler_base
 
 class fhandler_mailslot : public fhandler_base
 {
-  POBJECT_ATTRIBUTES get_object_attr (OBJECT_ATTRIBUTES &, PUNICODE_STRING);
+  POBJECT_ATTRIBUTES get_object_attr (OBJECT_ATTRIBUTES &, PUNICODE_STRING, int);
  public:
   fhandler_mailslot ();
   int __stdcall fstat (struct __stat64 *buf) __attribute__ ((regparm (2)));
Index: winsup/cygwin/fhandler_clipboard.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_clipboard.cc,v
retrieving revision 1.44
diff -u -p -r1.44 fhandler_clipboard.cc
--- winsup/cygwin/fhandler_clipboard.cc	24 Jul 2009 20:54:33 -0000	1.44
+++ winsup/cygwin/fhandler_clipboard.cc	13 Jan 2010 21:22:13 -0000
@@ -1,7 +1,6 @@
 /* fhandler_dev_clipboard: code to access /dev/clipboard
 
-   Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2008, 2009
-   Red Hat, Inc
+   Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2008, 2009, 2010 Red Hat, Inc
 
    Written by Charles Wilson (cwilson@ece.gatech.edu)
 
@@ -71,6 +70,7 @@ fhandler_dev_clipboard::open (int flags,
   if (!cygnativeformat)
     cygnativeformat = RegisterClipboardFormat (CYGWIN_NATIVE);
   nohandle (true);
+  close_on_exec (!!(flags & O_CLOEXEC));
   set_open_status ();
   return 1;
 }
Index: winsup/cygwin/fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.213
diff -u -p -r1.213 fhandler_console.cc
--- winsup/cygwin/fhandler_console.cc	25 Dec 2009 17:38:46 -0000	1.213
+++ winsup/cygwin/fhandler_console.cc	13 Jan 2010 21:22:13 -0000
@@ -1,7 +1,7 @@
 /* fhandler_console.cc
 
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
-   2006, 2008, 2009 Red Hat, Inc.
+   2006, 2008, 2009, 2010 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -705,7 +705,8 @@ fhandler_console::open (int flags, mode_
 
   /* Open the input handle as handle_ */
   h = CreateFile ("CONIN$", GENERIC_READ | GENERIC_WRITE,
-		  FILE_SHARE_READ | FILE_SHARE_WRITE, &sec_none,
+		  FILE_SHARE_READ | FILE_SHARE_WRITE,
+		  flags & O_CLOEXEC ? &sec_none_nih : &sec_none,
 		  OPEN_EXISTING, 0, 0);
 
   if (h == INVALID_HANDLE_VALUE)
@@ -717,7 +718,8 @@ fhandler_console::open (int flags, mode_
   uninterruptible_io (true);	// Handled explicitly in read code
 
   h = CreateFile ("CONOUT$", GENERIC_READ | GENERIC_WRITE,
-		  FILE_SHARE_READ | FILE_SHARE_WRITE, &sec_none,
+		  FILE_SHARE_READ | FILE_SHARE_WRITE,
+		  flags & O_CLOEXEC ? &sec_none_nih : &sec_none,
 		  OPEN_EXISTING, 0, 0);
 
   if (h == INVALID_HANDLE_VALUE)
@@ -737,6 +739,7 @@ fhandler_console::open (int flags, mode_
 
   tc->rstcons (false);
   set_open_status ();
+  close_on_exec (!!(flags & O_CLOEXEC));
   cygheap->manage_console_count ("fhandler_console::open", 1);
 
   DWORD cflags;
Index: winsup/cygwin/fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.320
diff -u -p -r1.320 fhandler_disk_file.cc
--- winsup/cygwin/fhandler_disk_file.cc	12 Jan 2010 14:47:46 -0000	1.320
+++ winsup/cygwin/fhandler_disk_file.cc	13 Jan 2010 21:22:14 -0000
@@ -2168,6 +2168,7 @@ fhandler_cygdrive::open (int flags, mode
   flags |= O_DIROPEN;
   set_flags (flags);
   nohandle (true);
+  close_on_exec (!!(flags & O_CLOEXEC));
   return 1;
 }
 
Index: winsup/cygwin/fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.52
diff -u -p -r1.52 fhandler_dsp.cc
--- winsup/cygwin/fhandler_dsp.cc	24 Jul 2009 20:54:33 -0000	1.52
+++ winsup/cygwin/fhandler_dsp.cc	13 Jan 2010 21:22:14 -0000
@@ -1,6 +1,6 @@
 /* Fhandler_dev_dsp: code to emulate OSS sound model /dev/dsp
 
-   Copyright 2001, 2002, 2003, 2004, 2008 Red Hat, Inc
+   Copyright 2001, 2002, 2003, 2004, 2008, 2010 Red Hat, Inc
 
    Written by Andy Younger (andy@snoogie.demon.co.uk)
    Extended by Gerd Spalink (Gerd.Spalink@t-online.de)
@@ -978,6 +978,7 @@ fhandler_dev_dsp::open (int flags, mode_
       set_open_status ();
       need_fork_fixup (true);
       nohandle (true);
+      close_on_exec (!!(flags & O_CLOEXEC));
 
       // FIXME: Do this better someday
       fhandler_dev_dsp *arch = (fhandler_dev_dsp *) cmalloc_abort (HEAP_ARCHETYPES, sizeof (*this));
Index: winsup/cygwin/fhandler_fifo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_fifo.cc,v
retrieving revision 1.38
diff -u -p -r1.38 fhandler_fifo.cc
--- winsup/cygwin/fhandler_fifo.cc	18 Dec 2009 20:32:03 -0000	1.38
+++ winsup/cygwin/fhandler_fifo.cc	13 Jan 2010 21:22:14 -0000
@@ -1,6 +1,6 @@
 /* fhandler_fifo.cc - See fhandler.h for a description of the fhandler classes.
 
-   Copyright 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Red Hat, Inc.
+   Copyright 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010 Red Hat, Inc.
 
    This file is part of Cygwin.
 
@@ -94,7 +94,9 @@ fhandler_fifo::open (int flags, mode_t)
     {
       char char_sa_buf[1024];
       LPSECURITY_ATTRIBUTES sa_buf =
-	sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
+	flags & O_CLOEXEC
+	? sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid())
+	: sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
       bool do_seterrno = true;
 
       HANDLE h;
@@ -147,6 +149,7 @@ fhandler_fifo::open (int flags, mode_t)
       else
 	{
 	  set_io_handle (h);
+	  close_on_exec (!!(flags & O_CLOEXEC));
 	  set_flags (flags);
 	  res = 1;
 	}
@@ -205,7 +208,9 @@ fhandler_fifo::wait (bool iswrite)
       fifo_name (npname);
       char char_sa_buf[1024];
       LPSECURITY_ATTRIBUTES sa_buf;
-      sa_buf = sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
+      sa_buf = close_on_exec ()
+	       ? sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid())
+	       : sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
       while (1)
 	{
 	  if (WaitNamedPipe (npname, 10))
Index: winsup/cygwin/fhandler_mailslot.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_mailslot.cc,v
retrieving revision 1.11
diff -u -p -r1.11 fhandler_mailslot.cc
--- winsup/cygwin/fhandler_mailslot.cc	11 Nov 2009 18:16:57 -0000	1.11
+++ winsup/cygwin/fhandler_mailslot.cc	13 Jan 2010 21:22:14 -0000
@@ -1,7 +1,6 @@
 /* fhandler_mailslot.cc.  See fhandler.h for a description of the fhandler classes.
 
-   Copyright 2005, 2007, 2008, 2009
-   Red Hat, Inc.
+   Copyright 2005, 2007, 2008, 2009, 2010 Red Hat, Inc.
 
    This file is part of Cygwin.
 
@@ -47,12 +46,15 @@ fhandler_mailslot::fstat (struct __stat6
 
 POBJECT_ATTRIBUTES
 fhandler_mailslot::get_object_attr (OBJECT_ATTRIBUTES &attr,
-				    PUNICODE_STRING path)
+				    PUNICODE_STRING path,
+				    int flags)
 {
   
   RtlCopyUnicodeString (path, pc.get_nt_native_path ());
   RtlAppendUnicodeStringToString (path, &installation_key);
-  InitializeObjectAttributes (&attr, path, OBJ_CASE_INSENSITIVE | OBJ_INHERIT,
+  InitializeObjectAttributes (&attr, path,
+			      OBJ_CASE_INSENSITIVE
+			      | (flags & O_CLOEXEC ? 0 : OBJ_INHERIT),
 			      NULL, NULL);
   return &attr;
 }
@@ -76,7 +78,7 @@ fhandler_mailslot::open (int flags, mode
     case O_RDONLY:	/* Server */
       timeout.QuadPart = (flags & O_NONBLOCK) ? 0LL : 0x8000000000000000LL;
       status = NtCreateMailslotFile (&x, GENERIC_READ | SYNCHRONIZE,
-				     get_object_attr (attr, &path),
+				     get_object_attr (attr, &path, flags),
 				     &io, FILE_SYNCHRONOUS_IO_NONALERT,
 				     0, 0, &timeout);
       if (!NT_SUCCESS (status))
@@ -97,7 +99,7 @@ fhandler_mailslot::open (int flags, mode
 	      break;
 	    }
 	  status = NtOpenFile (&x, GENERIC_READ | SYNCHRONIZE,
-			       get_object_attr (attr, &path), &io,
+			       get_object_attr (attr, &path, flags), &io,
 			       FILE_SHARE_VALID_FLAGS,
 			       FILE_SYNCHRONOUS_IO_NONALERT);
 #endif
@@ -122,7 +124,7 @@ fhandler_mailslot::open (int flags, mode
 	  break;
 	}
       status = NtOpenFile (&x, GENERIC_WRITE | SYNCHRONIZE,
-			   get_object_attr (attr, &path), &io,
+			   get_object_attr (attr, &path, flags), &io,
 			   FILE_SHARE_VALID_FLAGS,
 			   FILE_SYNCHRONOUS_IO_NONALERT);
       if (!NT_SUCCESS (status))
Index: winsup/cygwin/fhandler_mem.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_mem.cc,v
retrieving revision 1.55
diff -u -p -r1.55 fhandler_mem.cc
--- winsup/cygwin/fhandler_mem.cc	24 Jul 2009 20:54:33 -0000	1.55
+++ winsup/cygwin/fhandler_mem.cc	13 Jan 2010 21:22:14 -0000
@@ -1,7 +1,7 @@
 /* fhandler_mem.cc.  See fhandler.h for a description of the fhandler classes.
 
-   Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2008, 2009
-   Red Hat, Inc.
+   Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2008, 2009,
+   2010 Red Hat, Inc.
 
    This file is part of Cygwin.
 
@@ -79,7 +79,8 @@ fhandler_dev_mem::open (int flags, mode_
 
   OBJECT_ATTRIBUTES attr;
   InitializeObjectAttributes (&attr, &ro_u_pmem,
-			      OBJ_CASE_INSENSITIVE | OBJ_INHERIT,
+			      OBJ_CASE_INSENSITIVE
+			      | (flags & O_CLOEXEC ? 0 : OBJ_INHERIT),
 			      NULL, NULL);
 
   ACCESS_MASK section_access;
@@ -110,6 +111,7 @@ fhandler_dev_mem::open (int flags, mode_
 
   set_io_handle (mem);
   set_open_status ();
+  close_on_exec (!!(flags & O_CLOEXEC));
   return 1;
 }
 
Index: winsup/cygwin/fhandler_random.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_random.cc,v
retrieving revision 1.40
diff -u -p -r1.40 fhandler_random.cc
--- winsup/cygwin/fhandler_random.cc	30 Oct 2009 10:53:54 -0000	1.40
+++ winsup/cygwin/fhandler_random.cc	13 Jan 2010 21:22:15 -0000
@@ -1,7 +1,7 @@
 /* fhandler_random.cc: code to access /dev/random and /dev/urandom
 
-   Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2007, 2009
-   Red Hat, Inc.
+   Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2007, 2009,
+   2010 Red Hat, Inc.
 
    Written by Corinna Vinschen (vinschen@cygnus.com)
 
@@ -33,6 +33,7 @@ fhandler_dev_random::open (int flags, mo
 {
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   nohandle (true);
+  close_on_exec (!!(flags & O_CLOEXEC));
   set_open_status ();
   dummy_offset = 0;
   return 1;
Index: winsup/cygwin/fhandler_registry.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_registry.cc,v
retrieving revision 1.58
diff -u -p -r1.58 fhandler_registry.cc
--- winsup/cygwin/fhandler_registry.cc	18 Dec 2009 17:14:21 -0000	1.58
+++ winsup/cygwin/fhandler_registry.cc	13 Jan 2010 21:22:15 -0000
@@ -1,6 +1,7 @@
 /* fhandler_registry.cc: fhandler for /proc/registry virtual filesystem
 
-   Copyright 2002, 2003, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Red Hat, Inc.
+   Copyright 2002, 2003, 2003, 2004, 2005, 2006, 2007, 2008, 2009,
+   2010 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -771,6 +772,7 @@ fhandler_registry::open (int flags, mode
 	flags |= O_DIROPEN;
 
       set_io_handle (handle);
+      set_close_on_exec (!!(flags & O_CLOEXEC));
       value_name = cwcsdup (dec_file);
 
       if (!(flags & O_DIROPEN) && !fill_filebuf ())
Index: winsup/cygwin/fhandler_tape.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tape.cc,v
retrieving revision 1.72
diff -u -p -r1.72 fhandler_tape.cc
--- winsup/cygwin/fhandler_tape.cc	18 Dec 2009 20:32:04 -0000	1.72
+++ winsup/cygwin/fhandler_tape.cc	13 Jan 2010 21:22:15 -0000
@@ -2,7 +2,7 @@
    classes.
 
    Copyright 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007,
-   2008 Red Hat, Inc.
+   2008, 2010 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -1174,7 +1174,7 @@ fhandler_dev_tape::open (int flags, mode
       set_errno (ENOENT);
       return 0;
     }
-  if (!(mt_mtx = CreateMutex (&sec_all, TRUE, NULL)))
+  if (!(mt_mtx = CreateMutex (&sec_all, !!(flags & O_CLOEXEC), NULL)))
     {
       __seterrno ();
       return 0;
Index: winsup/cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.192
diff -u -p -r1.192 fhandler_tty.cc
--- winsup/cygwin/fhandler_tty.cc	13 Jan 2010 11:06:21 -0000	1.192
+++ winsup/cygwin/fhandler_tty.cc	13 Jan 2010 21:22:15 -0000
@@ -581,6 +581,7 @@ fhandler_tty_slave::open (int flags, mod
 
   set_io_handle (from_master_local);
   set_output_handle (to_master_local);
+  set_close_on_exec (!!(flags & O_CLOEXEC));
 
   set_open_status ();
   if (cygheap->manage_console_count ("fhandler_tty_slave::open", 1) == 1
Index: winsup/cygwin/fhandler_virtual.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v
retrieving revision 1.51
diff -u -p -r1.51 fhandler_virtual.cc
--- winsup/cygwin/fhandler_virtual.cc	24 Jul 2009 20:54:33 -0000	1.51
+++ winsup/cygwin/fhandler_virtual.cc	13 Jan 2010 21:22:15 -0000
@@ -1,6 +1,6 @@
 /* fhandler_virtual.cc: base fhandler class for virtual filesystems
 
-   Copyright 2002, 2003, 2004, 2005, 2007, 2008, 2009 Red Hat, Inc.
+   Copyright 2002, 2003, 2004, 2005, 2007, 2008, 2009, 2010 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -220,6 +220,7 @@ fhandler_virtual::open (int flags, mode_
   wbinary (true);
 
   set_flags ((flags & ~O_TEXT) | O_BINARY);
+  close_on_exec (!!(flags & O_CLOEXEC));
 
   return 1;
 }
Index: winsup/cygwin/fhandler_zero.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_zero.cc,v
retrieving revision 1.31
diff -u -p -r1.31 fhandler_zero.cc
--- winsup/cygwin/fhandler_zero.cc	24 Jul 2009 20:54:33 -0000	1.31
+++ winsup/cygwin/fhandler_zero.cc	13 Jan 2010 21:22:15 -0000
@@ -1,6 +1,6 @@
 /* fhandler_dev_zero.cc: code to access /dev/zero
 
-   Copyright 2000, 2001, 2002, 2003, 2004, 2005 Red Hat, Inc.
+   Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2010 Red Hat, Inc.
 
    Written by DJ Delorie (dj@cygnus.com)
 
@@ -26,6 +26,7 @@ fhandler_dev_zero::open (int flags, mode
 {
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   nohandle (true);
+  close_on_exec (!!(flags & O_CLOEXEC));
   set_open_status ();
   return 1;
 }
Index: winsup/cygwin/pipe.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pipe.cc,v
retrieving revision 1.120
diff -u -p -r1.120 pipe.cc
--- winsup/cygwin/pipe.cc	18 Dec 2009 20:32:04 -0000	1.120
+++ winsup/cygwin/pipe.cc	13 Jan 2010 21:22:15 -0000
@@ -53,7 +53,7 @@ fhandler_pipe::init (HANDLE f, DWORD a, 
   bool opened_properly = a & FILE_CREATE_PIPE_INSTANCE;
   a &= ~FILE_CREATE_PIPE_INSTANCE;
   fhandler_base::init (f, a, mode);
-  if (mode & O_NOINHERIT)
+  if (mode & O_CLOEXEC)
     close_on_exec (true);
   setup_overlapped (opened_properly);
   return 1;
@@ -116,7 +116,7 @@ fhandler_pipe::open (int flags, mode_t m
       set_errno (EACCES);
       goto out;
     }
-  inh = !(flags & O_NOINHERIT);
+  inh = !(flags & O_CLOEXEC);
   if (!DuplicateHandle (proc, pipe_hdl, GetCurrentProcess (), &nio_hdl,
 			0, inh, DUPLICATE_SAME_ACCESS))
     {
@@ -124,8 +124,7 @@ fhandler_pipe::open (int flags, mode_t m
       goto out;
     }
   init (nio_hdl, fh->get_access (), mode & O_TEXT ?: O_BINARY);
-  if (flags & O_NOINHERIT)
-    close_on_exec (true);
+  close_on_exec (!inh);
   uninterruptible_io (fh->uninterruptible_io ());
   cfree (fh);
   CloseHandle (proc);
@@ -312,7 +311,7 @@ int
 fhandler_pipe::create (fhandler_pipe *fhs[2], unsigned psize, int mode)
 {
   HANDLE r, w;
-  SECURITY_ATTRIBUTES *sa = (mode & O_NOINHERIT) ?  &sec_none_nih : &sec_none;
+  SECURITY_ATTRIBUTES *sa = (mode & O_CLOEXEC) ?  &sec_none_nih : &sec_none;
   int res;
 
   int ret = create_selectable (sa, r, w, psize);
Index: winsup/cygwin/syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.551
diff -u -p -r1.551 syscalls.cc
--- winsup/cygwin/syscalls.cc	13 Jan 2010 09:45:18 -0000	1.551
+++ winsup/cygwin/syscalls.cc	13 Jan 2010 21:22:16 -0000
@@ -119,7 +119,7 @@ close_all_files (bool norelease)
 int
 dup (int fd)
 {
-  return cygheap->fdtab.dup2 (fd, cygheap_fdnew ());
+  return cygheap->fdtab.dup3 (fd, cygheap_fdnew (), 0);
 }
 
 int
@@ -131,7 +131,25 @@ dup2 (int oldfd, int newfd)
       set_errno (EBADF);
       return -1;
     }
-  return cygheap->fdtab.dup2 (oldfd, newfd);
+  return cygheap->fdtab.dup3 (oldfd, newfd, 0);
+}
+
+int
+dup3 (int oldfd, int newfd, int flags)
+{
+  if (newfd >= OPEN_MAX_MAX)
+    {
+      syscall_printf ("-1 = dup3 (%d, %d, %d) (%d too large)", oldfd, newfd, flags, newfd);
+      set_errno (EBADF);
+      return -1;
+    }
+  if (!cygheap->fdtab.not_open (oldfd) && oldfd == newfd)
+    {
+      syscall_printf ("-1 = dup3 (%d, %d, %d) (newfd==oldfd)", oldfd, newfd, flags);
+      set_errno (EINVAL);
+      return -1;
+    }
+  return cygheap->fdtab.dup3 (oldfd, newfd, flags);
 }
 
 static char desktop_ini[] =
Index: winsup/cygwin/include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.305
diff -u -p -r1.305 version.h
--- winsup/cygwin/include/cygwin/version.h	9 Dec 2009 16:52:43 -0000	1.305
+++ winsup/cygwin/include/cygwin/version.h	13 Jan 2010 21:22:16 -0000
@@ -372,12 +372,13 @@ details. */
       216: CW_SET_EXTERNAL_TOKEN added.
       217: CW_GET_INSTKEY added.
       218: Export get_nprocs, get_nprocs_conf, get_phys_pages, get_avphys_pages.
+      219: Export dup3, O_CLOEXEC, F_DUPFD_CLOEXEC.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 218
+#define CYGWIN_VERSION_API_MINOR 219
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

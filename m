Return-Path: <cygwin-patches-return-2960-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16679 invoked by alias); 13 Sep 2002 07:18:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16656 invoked from network); 13 Sep 2002 07:18:58 -0000
Date: Fri, 13 Sep 2002 00:18:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] tty.cc nonblocking pipe
Message-ID: <20020913022004.B17744@eris.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-SW-Source: 2002-q3/txt/msg00408.txt.bz2

Hi,
  I've been tracking down why rxvt hangs when a paste
is too big, or if you simply cat a file with control
chars, like rxvt.exe.  What I discovered is that 
Windows will block writing to an anonymous pipe.  The
behavior I was seeing was that the child was pretty
much waiting on writes, which works as long as rxvt
keeps reading, but if rxvt writes as well (and blocks)
then deadlock occurs. 
  So the fix is to make the pipe non-blocking.  In tty.cc
the to_slave part is set to non-blocking, but the to_master
isn't.  Odd.  However, setting to_master to non-blocking
cures the rxvt deadlock.  This fix only works on NT/2K/XP.
Serious modification would be needed to get 98 to work.
-steve

*** tty-orig.cc Thu Sep 12 23:54:32 2002
--- tty.cc      Thu Sep 12 23:54:08 2002
***************
*** 375,380 ****
--- 375,382 ----
    DWORD pipe_mode = PIPE_NOWAIT;
    if (!SetNamedPipeHandleState (to_slave, &pipe_mode, NULL, NULL))
      termios_printf ("can't set to_slave to non-blocking mode");
+   if (!SetNamedPipeHandleState (to_master, &pipe_mode, NULL, NULL))
+     termios_printf ("can't set to_master to non-blocking mode");
    ptym->set_io_handle (from_slave);
    ptym->set_output_handle (to_slave);
    return TRUE;

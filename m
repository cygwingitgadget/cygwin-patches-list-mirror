Return-Path: <cygwin-patches-return-3853-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6206 invoked by alias); 9 May 2003 15:12:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6150 invoked from network); 9 May 2003 15:12:33 -0000
Message-ID: <3EBBC560.4080402@hekimian.com>
Date: Fri, 09 May 2003 15:12:00 -0000
X-Sybari-Trust: e6a3bb23 36b09be0 4b210cf9 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  jbuehler@hekimian.com
Organization: Spirent Communications, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [PATCH] show full process invocation in strace output
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00080.txt.bz2

This is a trivial patch to show more of the command line used when
starting a new process in spawn_guts().  The maximum string size
chosen is based on knowledge of the internals of syscall_printf().
Let me know if this is a problem.  We could perhaps put a #define in
strace.h.

2003-05-09  Joe Buehler  <jhpb@hekimian.com>

	* spawn.cc (spawn_guts): show more command line in strace output for new process

Index: spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.120
diff -u -r1.120 spawn.cc
--- spawn.cc	13 Feb 2003 02:52:41 -0000	1.120
+++ spawn.cc	9 May 2003 15:07:24 -0000
@@ -341,7 +341,7 @@
        return -1;
      }

-  syscall_printf ("spawn_guts (%d, %.132s)", mode, prog_arg);
+  syscall_printf ("spawn_guts (%d, %.9500s)", mode, prog_arg);

    if (argv == NULL)
      {
@@ -613,7 +613,7 @@

    const char *runpath = null_app_name ? NULL : (const char *) real_path;

-  syscall_printf ("null_app_name %d (%s, %.132s)", null_app_name, runpath, one_line.buf);
+  syscall_printf ("null_app_name %d (%s, %.9500s)", null_app_name, runpath, one_line.buf);

    void *newheap;
    /* Preallocated buffer for `sec_user' call */
@@ -727,7 +727,7 @@
      cygpid = myself->pid;

    /* We print the original program name here so the user can see that too.  */
-  syscall_printf ("%d = spawn_guts (%s, %.132s)",
+  syscall_printf ("%d = spawn_guts (%s, %.9500s)",
  		  rc ? cygpid : (unsigned int) -1, prog_arg, one_line.buf);

    /* Name the handle similarly to proc_subproc. */
-- 
Joe Buehler

Return-Path: <cygwin-patches-return-3396-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15275 invoked by alias); 15 Jan 2003 16:34:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15264 invoked from network); 15 Jan 2003 16:34:52 -0000
Date: Wed, 15 Jan 2003 16:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] system-cancel part2
Message-ID: <20030115163540.GF15975@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0301151113240.93-300000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0301151113240.93-300000@algeria.intern.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00045.txt.bz2

On Wed, Jan 15, 2003 at 12:23:14PM +0100, Thomas Pfaff wrote:
>
>This patch will make sure that the signal handlers that are saved in the
>system call are restored even if the thread got cancelled. Since
>spawn_guts uses waitpid when mode is _P_WAIT spawn_guts is a cancellation
>point.
>
>Attached is the patch and a new test case.
>
>2003-01-15  Thomas Paff  <tpfaff@gmx.net>
>
>	* syscalls.cc (struct system_cleanup_args): New struct.
>	(system_cleanup): New function.
>	(system): Use pthread_cleanup_push and _pop to save and restore
>	signal handlers and sigprocmask.

Please do not check this in.  You are changing other parts of the code than the
pthreads code and I want to study what you've done before you are approved to
check this in.

In other words, Robert's "as long as you have a test case" only applies to
trivial changes or changes to pthread.cc, thread.cc, or thread.h.

cgf

>diff -urp src.old/winsup/cygwin/syscalls.cc src/winsup/cygwin/syscalls.cc
>--- src.old/winsup/cygwin/syscalls.cc	2003-01-14 11:35:51.000000000 +0100
>+++ src/winsup/cygwin/syscalls.cc	2003-01-15 09:42:04.000000000 +0100
>@@ -1371,6 +1371,21 @@ done:
>   return res;
> }
> 
>+struct system_cleanup_args
>+{
>+  _sig_func_ptr oldint, oldquit;
>+  sigset_t old_mask;
>+};
>+
>+static void system_cleanup (void *args)
>+{
>+  struct system_cleanup_args *cleanup_args = (struct system_cleanup_args *) args;
>+
>+  signal (SIGINT, cleanup_args->oldint);
>+  signal (SIGQUIT, cleanup_args->oldquit);
>+  (void) sigprocmask (SIG_SETMASK, &cleanup_args->old_mask, 0);
>+}  
>+
> extern "C" int
> system (const char *cmdstring)
> {
>@@ -1382,23 +1397,25 @@ system (const char *cmdstring)
>   sigframe thisframe (mainthread);
>   int res;
>   const char* command[4];
>-  _sig_func_ptr oldint, oldquit;
>-  sigset_t child_block, old_mask;
>+  struct system_cleanup_args cleanup_args;
>+  sigset_t child_block;
> 
>   if (cmdstring == (const char *) NULL)
> 	return 1;
> 
>-  oldint = signal (SIGINT, SIG_IGN);
>-  oldquit = signal (SIGQUIT, SIG_IGN);
>+  cleanup_args.oldint = signal (SIGINT, SIG_IGN);
>+  cleanup_args.oldquit = signal (SIGQUIT, SIG_IGN);
>   sigemptyset (&child_block);
>   sigaddset (&child_block, SIGCHLD);
>-  (void) sigprocmask (SIG_BLOCK, &child_block, &old_mask);
>+  (void) sigprocmask (SIG_BLOCK, &child_block, &cleanup_args.old_mask);
> 
>   command[0] = "sh";
>   command[1] = "-c";
>   command[2] = cmdstring;
>   command[3] = (const char *) NULL;
> 
>+  pthread_cleanup_push (system_cleanup, (void *) &cleanup_args);
>+
>   if ((res = spawnvp (_P_WAIT, "sh", command)) == -1)
>     {
>       // when exec fails, return value should be as if shell
>@@ -1406,9 +1423,8 @@ system (const char *cmdstring)
>       res = 127;
>     }
> 
>-  signal (SIGINT, oldint);
>-  signal (SIGQUIT, oldquit);
>-  (void) sigprocmask (SIG_SETMASK, &old_mask, 0);
>+  pthread_cleanup_pop (1);
>+
>   return res;
> }
> 

>/*
> * File: cancel11.c
> *
> * Test Synopsis: Test if system is a cancellation point.
> *
> * Test Method (Validation or Falsification):
> * - 
> *
> * Requirements Tested:
> * -
> *
> * Features Tested:
> * - 
> *
> * Cases Tested:
> * - 
> *
> * Description:
> * - 
> *
> * Environment:
> * - 
> *
> * Input:
> * - None.
> *
> * Output:
> * - File name, Line number, and failed expression on failure.
> * - No output on success.
> *
> * Assumptions:
> * - have working pthread_create, pthread_cancel, pthread_setcancelstate
> *   pthread_join
> *
> * Pass Criteria:
> * - Process returns zero exit status.
> *
> * Fail Criteria:
> * - Process returns non-zero exit status.
> */
>
>#include "test.h"
>
>static void *Thread(void *punused)
>{
>  system ("sleep 10");
>
>  return NULL;
>}
>
>int main (void)
>{
>  void * result;
>  pthread_t t;
>
>  assert (pthread_create (&t, NULL, Thread, NULL) == 0);
>  sleep (5);
>  assert (pthread_cancel (t) == 0);
>  assert (pthread_join (t, &result) == 0);
>  assert (result == PTHREAD_CANCELED);
>
>  return 0;
>}

Return-Path: <cygwin-patches-return-2829-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21160 invoked by alias); 15 Aug 2002 20:25:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21140 invoked from network); 15 Aug 2002 20:25:49 -0000
Date: Thu, 15 Aug 2002 13:25:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_fork
Message-ID: <20020815202601.GA21949@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0208151941420.-376009@thomas.kefrig-pfaff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0208151941420.-376009@thomas.kefrig-pfaff.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00277.txt.bz2

On Thu, Aug 15, 2002 at 08:27:38PM +0200, Thomas Pfaff wrote:
>
>This patch will fix the pthread key related problems with fork (key value
>is restored after fork) and some minor fork related fixes.
>
>Changelog:
>
>2002-08-15  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* fork.cc (fork_child): fixup_after_fork call changed.
>	(fork_parent): Added call to MTinterface->fixup_before_fork to
>	save TLS values.

Sorry, but this is incorrect wording for a ChangeLog.  It should be
something like:

	* fork.cc (fork_child): Remove extra thread related fork fixup.
	(fork_parent): Add call to MTinterface->fixup_before_fork to
	save TLS values.

The tense should be "present" as in say "Add" rather than "Added". I can
see that a few incorrect usages have slipped in but I would appreciate
it if future submissions adhere to this policy.

And, FWIW, I guarantee that I will flame anyone within an inch of their
lives if they scour old ChangeLog entries trying to find occurrences
that are counter to this rule.

>diff -urp src.old/winsup/cygwin/fork.cc src/winsup/cygwin/fork.cc
>--- src.old/winsup/cygwin/fork.cc	Wed Aug 14 14:20:24 2002
>+++ src/winsup/cygwin/fork.cc	Wed Aug  7 17:14:54 2002
>@@ -652,11 +654,15 @@ fork ()
>   child_info_fork ch;
> 
>   int res = setjmp (ch.jmp);
>-
>   if (res)
>     res = fork_child (grouped.hParent, grouped.first_dll, grouped.load_dlls);
>   else
>-    res = fork_parent (grouped.hParent, grouped.first_dll, grouped.load_dlls, esp, ch);
>+    {
>+      /* Protect pthread_keys local buf from being overwritten by simultanous forks */
>+      EnterCriticalSection (&MT_INTERFACE->fork_lock);
>+      res = fork_parent (grouped.hParent, grouped.first_dll, grouped.load_dlls, esp, ch);
>+      LeaveCriticalSection (&MT_INTERFACE->fork_lock);
>+    }

Please just add additional locks close to the existing malloc lock/unlock.  It doesn't make
sense for the critical section to be the entire fork_parent function. 

>   MALLOC_CHECK;
>   syscall_printf ("%d = fork()", res);
>diff -urp src.old/winsup/cygwin/init.cc src/winsup/cygwin/init.cc
>--- src.old/winsup/cygwin/init.cc	Wed Aug 14 14:20:24 2002
>+++ src/winsup/cygwin/init.cc	Wed Aug 14 14:23:30 2002
>@@ -18,6 +18,9 @@ int NO_COPY dynamically_loaded;
> extern "C" int
> WINAPI dll_entry (HANDLE h, DWORD reason, void *static_load)
> {
>+  if (reason == DLL_THREAD_DETACH || reason == DLL_PROCESS_DETACH)
>+    MT_INTERFACE->run_key_dtors ();
>+

An if just before a switch that deals with the same variable?  Use the
switch/case, please.  You can remove the FIXME: block, if that helps.

cgf

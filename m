Return-Path: <cygwin-patches-return-2835-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28306 invoked by alias); 16 Aug 2002 08:11:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28292 invoked from network); 16 Aug 2002 08:11:50 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 16 Aug 2002 01:11:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_fork
In-Reply-To: <20020815202601.GA21949@redhat.com>
Message-ID: <Pine.WNT.4.44.0208160959420.191-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00283.txt.bz2



On Thu, 15 Aug 2002, Christopher Faylor wrote:

> On Thu, Aug 15, 2002 at 08:27:38PM +0200, Thomas Pfaff wrote:
> >
>
> >diff -urp src.old/winsup/cygwin/fork.cc src/winsup/cygwin/fork.cc
> >--- src.old/winsup/cygwin/fork.cc	Wed Aug 14 14:20:24 2002
> >+++ src/winsup/cygwin/fork.cc	Wed Aug  7 17:14:54 2002
> >@@ -652,11 +654,15 @@ fork ()
> >   child_info_fork ch;
> >
> >   int res = setjmp (ch.jmp);
> >-
> >   if (res)
> >     res = fork_child (grouped.hParent, grouped.first_dll, grouped.load_dlls);
> >   else
> >-    res = fork_parent (grouped.hParent, grouped.first_dll, grouped.load_dlls, esp, ch);
> >+    {
> >+      /* Protect pthread_keys local buf from being overwritten by simultanous forks */
> >+      EnterCriticalSection (&MT_INTERFACE->fork_lock);
> >+      res = fork_parent (grouped.hParent, grouped.first_dll, grouped.load_dlls, esp, ch);
> >+      LeaveCriticalSection (&MT_INTERFACE->fork_lock);
> >+    }
>
> Please just add additional locks close to the existing malloc lock/unlock.  It doesn't make
> sense for the critical section to be the entire fork_parent function.

Sorry that i have overseen that lock. If Rob agrees than i move
atfork_prepare after the malloc lock (and call fixup_fore_fork in
atfork_prepare).

It should just make sure that the buffers in pthread_key are not
overwritten until the child has read parents memory.

>
> >   MALLOC_CHECK;
> >   syscall_printf ("%d = fork()", res);
> >diff -urp src.old/winsup/cygwin/init.cc src/winsup/cygwin/init.cc
> >--- src.old/winsup/cygwin/init.cc	Wed Aug 14 14:20:24 2002
> >+++ src/winsup/cygwin/init.cc	Wed Aug 14 14:23:30 2002
> >@@ -18,6 +18,9 @@ int NO_COPY dynamically_loaded;
> > extern "C" int
> > WINAPI dll_entry (HANDLE h, DWORD reason, void *static_load)
> > {
> >+  if (reason == DLL_THREAD_DETACH || reason == DLL_PROCESS_DETACH)
> >+    MT_INTERFACE->run_key_dtors ();
> >+
>
> An if just before a switch that deals with the same variable?  Use the
> switch/case, please.  You can remove the FIXME: block, if that helps.

I will.

Thomas

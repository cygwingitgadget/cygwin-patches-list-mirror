From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Use _REENT_INIT to initialize the reent structure of newlib.
Date: Thu, 26 Apr 2001 15:29:00 -0000
Message-id: <20010426182948.D360@redhat.com>
References: <s1sk847o183.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00171.html

I'll let Robert comment on this one.  It looks right to me.

cgf

On Fri, Apr 27, 2001 at 05:27:56AM +0900, Kazuhiro Fujieda wrote:
>The thread_init_wrapper doesn't properly initialize the reent
>structure of newlib. It has some non-zero fields other than
>_stdin, _stdout, and _stderr.
>
>2001-04-27  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* thread.cc (thread_init_wrapper): Use _REENT_INIT to initialize
>	the reent structure of newlib.
>
>Index: thread.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
>retrieving revision 1.28
>diff -u -p -r1.28 thread.cc
>--- thread.cc	2001/04/23 02:56:19	1.28
>+++ thread.cc	2001/04/26 20:20:00
>@@ -737,7 +737,7 @@ thread_init_wrapper (void *_arg)
>   pthread *thread = (pthread *) _arg;
>   struct __reent_t local_reent;
>   struct _winsup_t local_winsup;
>-  struct _reent local_clib;
>+  struct _reent local_clib = _REENT_INIT(local_clib);
> 
>   struct sigaction _sigs[NSIG];
>   sigset_t _sig_mask;		/* one set for everything to ignore. */
>@@ -748,13 +748,7 @@ thread_init_wrapper (void *_arg)
>   thread->sigmask = &_sig_mask;
>   thread->sigtodo = _sigtodo;
> 
>-  memset (&local_clib, 0, sizeof (struct _reent));
>   memset (&local_winsup, 0, sizeof (struct _winsup_t));
>-
>-  local_clib._errno = 0;
>-  local_clib._stdin = &local_clib.__sf[0];
>-  local_clib._stdout = &local_clib.__sf[1];
>-  local_clib._stderr = &local_clib.__sf[2];
> 
>   local_reent._clib = &local_clib;
>   local_reent._winsup = &local_winsup;
>
>____
>  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
>  | HOKURIKU  School of Information Science
>o_/ 1990      Japan Advanced Institute of Science and Technology

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/

Return-Path: <cygwin-patches-return-5119-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8171 invoked by alias); 12 Nov 2004 03:53:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8144 invoked from network); 12 Nov 2004 03:53:45 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.170.214)
  by sourceware.org with SMTP; 12 Nov 2004 03:53:45 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I71SAN-002ZFP-7T
	for cygwin-patches@cygwin.com; Thu, 11 Nov 2004 22:56:47 -0500
Message-Id: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 12 Nov 2004 03:53:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1100249337==_"
X-SW-Source: 2004-q4/txt/msg00120.txt.bz2

--=====================_1100249337==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1271

Now that 1.5.12 is out, here is a patch to fix the 
PROCESS_DUP_HANDLE security hole. It uses a new approach
to reparenting: the parent duplicates the exec'ed process 
handle when signaled by the child.

It also handles correctly the case of a quick re-exec 
(2 simultaneous reparenting), which is a weak point of
the current version.

Pierre

P.S.: I have no news about the recent patch to /bin/kill -f

2004-11-12  Pierre Humblet <pierre.humblet@ieee.org>

	* pinfo.h (_pinfo::isreparenting): New element.
	(_pinfo::ppid_sendsig): Ditto.
	(_pinfo::exit): Suppress second argument.
	* child_info.h: Update CURR_CHILD_INFO_MAGIC.
	(child_info::pppid_sendsig): New element.
	* sigproc.h: Add __SIGREPARENT.
	(enum procstuff): Add PROC_REPARENT.
	* pinfo.cc (_pinfo::exit): Suppress second argument.
	If required, send reparenting signal and wait.
	* spawn.cc (spawn_guts): Implement new reparenting strategy.
	* sigproc.cc (proc_subproc): Reduce access to vchild->pid_handle
	and vchild->ppid_handle. Set ppid_sendsig by duplication.
	Add PROC_REPARENT case and simplify PROC_CHILDTERMINATED case.
	(sig_send): Use ppid_sendsig to signal parent.
	(init_child_info): Set pppid_sendsig.
	(wait_sig): Add __SIGREPARENT case.
	* dcrto.cc (dll_crt0_0): Close pppid_sendsig.
	
	
--=====================_1100249337==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="reparent.diff"
Content-length: 20040

Index: pinfo.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pinfo.h,v
retrieving revision 1.64
diff -u -p -r1.64 pinfo.h
--- pinfo.h	12 Sep 2004 03:55:42 -0000	1.64
+++ pinfo.h	29 Oct 2004 18:56:55 -0000
@@ -36,12 +36,16 @@ public:
      constants below. */
   DWORD process_state;

-  /* If hProcess is set, it's because it came from a
-     CreateProcess call.  This means it's process relative
-     to the thing which created the process.  That's ok because
-     we only use this handle from the parent. */
+  /* hProcess comes from a CreateProcess or DuplicateHandle call.
+     This means it's process relative to the thing which created
+     the process.  That's ok because we only use this handle in
+     the parent, duplicating it if was temporarily set by the
+     child during reparenting. */
   HANDLE hProcess;

+  /* A reparenting operation is in progress */
+  volatile bool isreparenting;
+
 #define PINFO_REDIR_SIZE ((char *) &myself.procinfo->hProcess - (char *) m=
yself.procinfo)

   /* Handle associated with initial Windows pid which started it all. */
@@ -88,7 +92,7 @@ public:
   HANDLE tothem;
   HANDLE fromthem;

-  void exit (UINT n, bool norecord =3D 0) __attribute__ ((noreturn, regpar=
m(2)));
+  void exit (UINT n) __attribute__ ((noreturn, regparm(1)));

   inline void set_has_pgid_children ()
   {
@@ -118,6 +122,7 @@ public:

   /* signals */
   HANDLE sendsig;
+  HANDLE ppid_sendsig;
 private:
   sigset_t sig_mask;
   CRITICAL_SECTION lock;
Index: sigproc.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sigproc.h,v
retrieving revision 1.70
diff -u -p -r1.70 sigproc.h
--- sigproc.h	12 Sep 2004 03:47:57 -0000	1.70
+++ sigproc.h	29 Oct 2004 18:56:55 -0000
@@ -26,7 +26,8 @@ enum
   __SIGDELETE	    =3D -(NSIG + 5),
   __SIGFLUSHFAST    =3D -(NSIG + 6),
   __SIGHOLD	    =3D -(NSIG + 7),
-  __SIGNOHOLD	    =3D -(NSIG + 8)
+  __SIGNOHOLD	    =3D -(NSIG + 8),
+  __SIGREPARENT	    =3D -(NSIG + 9)
 };
 #endif

@@ -38,7 +39,8 @@ enum procstuff
   PROC_CHILDTERMINATED	=3D 2,	// a child died
   PROC_CLEARWAIT	=3D 3,	// clear all waits - signal arrived
   PROC_WAIT		=3D 4,	// setup for wait() for subproc
-  PROC_NOTHING		=3D 5	// nothing, really
+  PROC_REPARENT		=3D 5,	// reparenting signal arrived
+  PROC_NOTHING		=3D 6	// nothing, really
 };

 struct sigpacket
Index: child_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/child_info.h,v
retrieving revision 1.45
diff -u -p -r1.45 child_info.h
--- child_info.h	12 Sep 2004 18:10:15 -0000	1.45
+++ child_info.h	29 Oct 2004 18:56:55 -0000
@@ -29,7 +29,7 @@ enum

 #define EXEC_MAGIC_SIZE sizeof(child_info)

-#define CURR_CHILD_INFO_MAGIC 0x19c16fb6U
+#define CURR_CHILD_INFO_MAGIC 0xb2f6689eU

 /* NOTE: Do not make gratuitous changes to the names or organization of the
    below class.  The layout is checksummed to determine compatibility betw=
een
@@ -46,6 +46,7 @@ public:
   HANDLE user_h;
   HANDLE parent;
   HANDLE pppid_handle;
+  HANDLE pppid_sendsig;
   init_cygheap *cygheap;
   void *cygheap_max;
   DWORD cygheap_reserve_sz;
Index: pinfo.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.121
diff -u -p -r1.121 pinfo.cc
--- pinfo.cc	5 Oct 2004 02:10:15 -0000	1.121
+++ pinfo.cc	29 Oct 2004 18:56:56 -0000
@@ -102,22 +102,38 @@ pinfo_init (char **envp, int envc)
 }

 void
-_pinfo::exit (UINT n, bool norecord)
+_pinfo::exit (UINT n)
 {
   exit_state =3D ES_FINAL;
   cygthread::terminate ();
-  if (norecord)
-    sigproc_terminate ();
   if (this)
     {
-      if (!norecord)
-	process_state =3D PID_EXITED;
-
+      extern HANDLE hExeced;
       /* FIXME:  There is a potential race between an execed process and i=
ts
 	 parent here.  I hated to add a mutex just for this, though.  */
       struct rusage r;
       fill_rusage (&r, hMainProc);
       add_rusage (&rusage_self, &r);
+      if (!isreparenting)
+	process_state =3D PID_EXITED;
+      else if (hExeced)
+	{
+	  /* Tell parent about my successor */
+	  DWORD nb;
+	  struct sigpacket pack;
+	  pack.pid =3D pid;
+	  pack.wakeup =3D NULL;
+	  pack.si.si_signo =3D __SIGREPARENT;
+          hProcess =3D hExeced;
+	  if (!WriteFile (myself->ppid_sendsig, &pack, sizeof (pack), &nb, NULL)
+	      || nb !=3D sizeof (pack))
+	    debug_printf ("WriteFile for pipe %p to pid %d failed, %E",
+			  myself->ppid_sendsig, ppid);
+	  else
+	    /* Wait to be terminated by my parent */
+	    WaitForSingleObject (myself->ppid_handle, INFINITE);
+	}
+      isreparenting =3D false;
     }

   sigproc_printf ("Calling ExitProcess %d", n);
@@ -199,7 +215,7 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
       else
 	{
 	  if (GetLastError () =3D=3D ERROR_INVALID_HANDLE)
-	    api_fatal ("MapViewOfFileEx(%p, in_h %p) failed, %E", h, in_h);
+            api_fatal ("MapViewOfFileEx(%p, in_h %p) failed, %E", h, in_h);
 	  else
 	    {
 	      debug_printf ("MapViewOfFileEx(%p, in_h %p) failed, %E", h, in_h);
Index: sigproc.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v
retrieving revision 1.201
diff -u -p -r1.201 sigproc.cc
--- sigproc.cc	20 Sep 2004 04:58:36 -0000	1.201
+++ sigproc.cc	29 Oct 2004 18:56:56 -0000
@@ -275,6 +275,8 @@ mychild (int pid)
 /* Handle all subprocess requests
  */
 #define vchild (*((pinfo *) val))
+#define wval   ((waitq *) val)
+#define pval   ((pid_t) val)
 int __stdcall
 proc_subproc (DWORD what, DWORD val)
 {
@@ -285,8 +287,6 @@ proc_subproc (DWORD what, DWORD val)
   waitq *w;
   int thiszombie;

-#define wval	 ((waitq *) val)
-
   sigproc_printf ("args: %x, %d", what, val);

   if (!get_proc_lock (what, val))	// Serialize access to this function
@@ -308,14 +308,18 @@ proc_subproc (DWORD what, DWORD val)
 	}
       pchildren[nchildren] =3D vchild;
       hchildren[nchildren] =3D vchild->hProcess;
-      if (!DuplicateHandle (hMainProc, vchild->hProcess, hMainProc, &vchil=
d->pid_handle,
-			    0, 0, DUPLICATE_SAME_ACCESS))
+      if (!DuplicateHandle (hMainProc, vchild->hProcess, hMainProc,
+			    &vchild->pid_handle, 0, 0, 0))
 	system_printf ("Couldn't duplicate child handle for pid %d, %E", vchild->=
pid);
       ProtectHandle1 (vchild->pid_handle, pid_handle);

-      if (!DuplicateHandle (hMainProc, hMainProc, vchild->hProcess, &vchil=
d->ppid_handle,
-			    SYNCHRONIZE | PROCESS_DUP_HANDLE, TRUE, 0))
+      if (!DuplicateHandle (hMainProc, hMainProc, vchild->hProcess,
+			    &vchild->ppid_handle, SYNCHRONIZE, TRUE, 0))
 	system_printf ("Couldn't duplicate my handle<%p> for pid %d, %E", hMainPr=
oc, vchild->pid);
+      if (!DuplicateHandle (hMainProc, myself->sendsig, vchild->hProcess,
+			    &vchild->ppid_sendsig, FILE_GENERIC_WRITE, TRUE, 0))
+	system_printf ("Couldn't duplicate my sendsig handle<%p> for pid %d, %E",=
 myself->sendsig, vchild->pid);
+      debug_printf("Duplicated myself->sendsig %x to vchild->ppid_sendsig =
%x", myself->sendsig, vchild->ppid_sendsig);
       vchild->ppid =3D myself->pid;
       vchild->uid =3D myself->uid;
       vchild->gid =3D myself->gid;
@@ -332,31 +336,43 @@ proc_subproc (DWORD what, DWORD val)
       wake_wait_subproc ();
       break;

+    case PROC_REPARENT:
+      /* Cygwin implements an exec() as a "handoff" from one windows
+	 process to another. */
+      for (int i =3D 0; i < nchildren; i++)
+	if (pchildren[i]->pid =3D=3D pval)
+	  {
+	    HANDLE h =3D hchildren[i];
+	    DWORD res =3D DuplicateHandle (h, pchildren[i]->hProcess, hMainProc, =
&pchildren[i]->hProcess,
+					 0, FALSE, DUPLICATE_SAME_ACCESS); /* want query, sync and duplicate =
*/
+	    pchildren[i]->isreparenting =3D false;
+	    if (!res)
+	      system_printf("Reparenting pid %d[%d] DuplicateHandle, %E", val, i);
+	    else
+	      {
+		sigproc_printf ("pid %d[%d], reparented old hProcess %p, new %p",
+				pval, i, h, pchildren[i]->hProcess);
+		ProtectHandle1 (pchildren[i]->hProcess, childhProc);
+		hchildren[i] =3D pchildren[i]->hProcess;
+		wake_wait_subproc ();
+	      }
+	    TerminateProcess (h, 0);
+	    if (res)
+	      ForceCloseHandle1 (h, childhProc);
+	    goto out;
+	  }
+      system_printf ("Unknown child, %d", pval);
+      break;
+
     /* A child process had terminated.
-       Possibly this is just due to an exec().  Cygwin implements an exec()
-       as a "handoff" from one windows process to another.  If child->hPro=
cess
-       is different from what is recorded in hchildren, then this is an ex=
ec().
-       Otherwise this is a normal child termination event.
        (called from wait_subproc thread) */
     case PROC_CHILDTERMINATED:
-      if (hchildren[val] !=3D pchildren[val]->hProcess)
-	{
-	  sigproc_printf ("pid %d[%d], reparented old hProcess %p, new %p",
-			  pchildren[val]->pid, val, hchildren[val], pchildren[val]->hProcess);
-	  HANDLE h =3D hchildren[val];
-	  hchildren[val] =3D pchildren[val]->hProcess; /* Filled out by child */
-	  ForceCloseHandle1 (h, childhProc);
-	  ProtectHandle1 (pchildren[val]->hProcess, childhProc);
-	  rc =3D 0;
-	  goto out;			// This was an exec()
-	}
-
       sigproc_printf ("pid %d[%d] terminated, handle %p, nchildren %d, nzo=
mbies %d",
 		  pchildren[val]->pid, val, hchildren[val], nchildren, nzombies);

-      thiszombie =3D nzombies;
-      zombies[nzombies] =3D pchildren[val];	// Add to zombie array
-      zombies[nzombies++]->process_state =3D PID_ZOMBIE;// Walking dead
+      thiszombie =3D nzombies++;
+      zombies[thiszombie] =3D pchildren[val];	// Add to zombie array
+      zombies[thiszombie]->hProcess =3D hchildren[val]; /* hProcess may be=
 invalid */

       sigproc_printf ("zombifying [%d], pid %d, handle %p, nchildren %d",
 		      val, pchildren[val]->pid, hchildren[val], nchildren);
@@ -370,12 +386,16 @@ proc_subproc (DWORD what, DWORD val)
 	 filled up our table or if we're ignoring SIGCHLD, then we immediately
 	 remove the process and move on. Otherwise, this process becomes a zombie
 	 which must be reaped by a wait() call.  FIXME:  This is a very inelegant
-	 way to deal with this and could lead to process hangs.  */
-      if (nzombies >=3D NZOMBIES)
+	 way to deal with this and could lead to process hangs.
+         Also discard processes that have exec'ed but failed reparenting. =
*/
+      if (nzombies >=3D NZOMBIES || zombies[thiszombie]->isreparenting)
 	{
-	  sigproc_printf ("zombie table overflow %d", thiszombie);
+	  sigproc_printf ("zombie discarded %d", thiszombie);
+	  zombies[thiszombie]->ppid =3D 1;    /* Important if reparenting failed =
*/
 	  remove_zombie (thiszombie);
 	}
+      else
+        zombies[thiszombie]->process_state =3D PID_ZOMBIE;// Walking dead

       /* Don't scan the wait queue yet.  Caller will send SIGCHLD to this =
process.
 	 This will cause an eventual scan of waiters. */
@@ -705,6 +725,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cyg

   if (its_me)
     sendsig =3D myself->sendsig;
+  else if (p->pid =3D=3D myself->ppid)
+    sendsig =3D myself->ppid_sendsig;
   else
     {
       for (int i =3D 0; !p->dwProcessId && i < 10000; i++)
@@ -796,7 +818,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cyg
       rc =3D WAIT_OBJECT_0;
       sigproc_printf ("Not waiting for sigcomplete.  its_me %d signal %d",
 		      its_me, si.si_signo);
-      if (!its_me)
+      if (!(its_me || p->pid =3D=3D myself->ppid))
 	ForceCloseHandle (sendsig);
     }

@@ -865,6 +887,7 @@ init_child_info (DWORD chtype, child_inf
   ch->type =3D chtype;
   ch->subproc_ready =3D subproc_ready;
   ch->pppid_handle =3D myself->ppid_handle;
+  ch->pppid_sendsig =3D myself->ppid_sendsig;
   ch->fhandler_union_cb =3D sizeof (fhandler_union);
   ch->user_h =3D cygwin_user_h;
 }
@@ -1130,7 +1153,6 @@ wait_sig (VOID *self)
 #endif
 	  continue;
 	}
-
       sigset_t dummy_mask;
       if (!pack.mask)
 	{
@@ -1174,6 +1196,9 @@ wait_sig (VOID *self)
 		clearwait =3D true;
 	    }
 	  break;
+	case __SIGREPARENT:
+	  proc_subproc (PROC_REPARENT, (DWORD) pack.pid);
+	  break;
 	default:
 	  if (pack.si.si_signo < 0)
 	    sig_clear (-pack.si.si_signo);
Index: spawn.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.153
diff -u -p -r1.153 spawn.cc
--- spawn.cc	7 Oct 2004 16:49:30 -0000	1.153
+++ spawn.cc	29 Oct 2004 18:56:57 -0000
@@ -629,10 +629,23 @@ spawn_guts (const char * prog_arg, const
     flags |=3D DETACHED_PROCESS;
   if (mode !=3D _P_OVERLAY)
     flags |=3D CREATE_SUSPENDED;
-#if 0 //someday
   else
-    myself->dwProcessId =3D 0;
+    {
+      /* An exec'ing exec'ed process must wait for its parent to have
+	 reparented. Such a wait is very unlikely, so we simply poll.
+	 As with the previous method, if the initial exec'ing process is
+         terminated from Windows after exec'ing, reparenting may not take
+         place. That will be detected by the logical parent at process
+         termination, and it will set ppid to 1. If the logical parent is
+         not alive, there is no point in waiting. */
+      while (myself->isreparenting && myself->ppid !=3D 1
+             && my_parent_is_alive ())
+	low_priority_sleep (0);
+      myself->isreparenting =3D true;
+#if 0 //someday
+      myself->dwProcessId =3D 0;
 #endif
+    }

   /* Some file types (currently only sockets) need extra effort in the
      parent after CreateProcess and before copying the datastructures
@@ -732,10 +745,13 @@ spawn_guts (const char * prog_arg, const
     {
       __seterrno ();
       syscall_printf ("CreateProcess failed, %E");
-#if 0 // someday
       if (mode =3D=3D _P_OVERLAY)
-	myself->dwProcessId =3D GetCurrentProcessId ();
+        {
+	  myself->isreparenting =3D false;
+#if 0 // someday
+	  myself->dwProcessId =3D GetCurrentProcessId ();
 #endif
+	}
       if (subproc_ready)
 	ForceCloseHandle (subproc_ready);
       cygheap_setup_for_child_cleanup (newheap, &ciresrv, 0);
@@ -833,95 +849,65 @@ spawn_guts (const char * prog_arg, const

   sigproc_printf ("spawned windows pid %d", pi.dwProcessId);

-  bool exited;
-
   res =3D 0;
-  exited =3D false;
-  MALLOC_CHECK;
-  if (mode =3D=3D _P_OVERLAY)
-    {
-      int nwait =3D 3;
-      HANDLE waitbuf[3] =3D {pi.hProcess, signal_arrived, subproc_ready};
-      for (int i =3D 0; i < 100; i++)
-	{
-	  switch (WaitForMultipleObjects (nwait, waitbuf, FALSE, INFINITE))
-	    {
-	    case WAIT_OBJECT_0:
-	      sigproc_printf ("subprocess exited");
-	      DWORD exitcode;
-	      if (!GetExitCodeProcess (pi.hProcess, &exitcode))
-		exitcode =3D 1;
-	      res |=3D exitcode;
-	      exited =3D true;
-	      break;
-	    case WAIT_OBJECT_0 + 1:
-	      sigproc_printf ("signal arrived");
-	      reset_signal_arrived ();
-	      continue;
-	    case WAIT_OBJECT_0 + 2:
-	      if (my_parent_is_alive ())
-		res |=3D EXIT_REPARENTING;
-	      else if (!myself->ppid_handle)
-		{
-		  nwait =3D 2;
-		  sigproc_terminate ();
-		  continue;
-		}
-	      break;
-	    case WAIT_FAILED:
-	      system_printf ("wait failed: nwait %d, pid %d, winpid %d, %E",
-			     nwait, myself->pid, myself->dwProcessId);
-	      system_printf ("waitbuf[0] %p %d", waitbuf[0],
-			     WaitForSingleObject (waitbuf[0], 0));
-	      system_printf ("waitbuf[1] %p %d", waitbuf[1],
-			     WaitForSingleObject (waitbuf[1], 0));
-	      system_printf ("waitbuf[w] %p %d", waitbuf[2],
-			     WaitForSingleObject (waitbuf[2], 0));
-	      set_errno (ECHILD);
-	      try_to_debug ();
-	      return -1;
-	    }
-	  break;
-	}
-
-      ForceCloseHandle (subproc_ready);
-
-      sigproc_printf ("res %p", res);
-
-      if (res & EXIT_REPARENTING)
-	{
-	  /* Try to reparent child process.
-	   * Make handles to child available to parent process and exit with
-	   * EXIT_REPARENTING status. Wait() syscall in parent will then wait
-	   * for newly created child.
-	   */
-	  HANDLE oldh =3D myself->hProcess;
-	  HANDLE h =3D myself->ppid_handle;
-	  sigproc_printf ("parent handle %p", h);
-	  int rc =3D DuplicateHandle (hMainProc, pi.hProcess, h, &myself->hProces=
s,
-				    0, FALSE, DUPLICATE_SAME_ACCESS);
-	  sigproc_printf ("%d =3D DuplicateHandle, oldh %p, newh %p",
-			  rc, oldh, myself->hProcess);
-	  VerifyHandle (myself->hProcess);
-	  if (!rc && my_parent_is_alive ())
-	    {
-	      system_printf ("Reparent failed, parent handle %p, %E", h);
-	      system_printf ("my dwProcessId %d, myself->dwProcessId %d",
-			     GetCurrentProcessId (), myself->dwProcessId);
-	      system_printf ("old hProcess %p, hProcess %p", oldh, myself->hProce=
ss);
-	    }
-	}
-
-    }
-
+
   MALLOC_CHECK;

   switch (mode)
     {
     case _P_OVERLAY:
-      ForceCloseHandle1 (pi.hProcess, childhProc);
-      myself->exit (res, 1);
-      break;
+      {
+	int nwait =3D 3;
+	HANDLE waitbuf[3] =3D {pi.hProcess, signal_arrived, subproc_ready};
+	for (int i =3D 0; i < 100; i++)
+	  {
+	    switch (WaitForMultipleObjects (nwait, waitbuf, FALSE, INFINITE))
+	      {
+	      case WAIT_OBJECT_0:
+		sigproc_printf ("subprocess exited");
+		DWORD exitcode;
+		if (!GetExitCodeProcess (pi.hProcess, &exitcode))
+		  exitcode =3D 1;
+		res =3D exitcode;
+		ForceCloseHandle1 (pi.hProcess, childhProc);
+		myself->isreparenting =3D false;
+		break;
+	      case WAIT_OBJECT_0 + 1:
+		sigproc_printf ("signal arrived");
+		reset_signal_arrived ();
+		continue;
+	      case WAIT_OBJECT_0 + 2:
+		if (myself->ppid_handle)
+		  break;
+		else
+		  {
+		    nwait =3D 2;
+		    sigproc_terminate ();
+		    myself->isreparenting =3D false;
+		    continue;
+		  }
+		break;
+	      case WAIT_FAILED:
+		system_printf ("wait failed: nwait %d, pid %d, winpid %d, %E",
+			       nwait, myself->pid, myself->dwProcessId);
+		system_printf ("waitbuf[0] %p %d", waitbuf[0],
+			       WaitForSingleObject (waitbuf[0], 0));
+		system_printf ("waitbuf[1] %p %d", waitbuf[1],
+			       WaitForSingleObject (waitbuf[1], 0));
+		system_printf ("waitbuf[w] %p %d", waitbuf[2],
+			       WaitForSingleObject (waitbuf[2], 0));
+		set_errno (ECHILD);
+		try_to_debug ();
+		myself->isreparenting =3D false;
+		return -1;
+	      }
+	    break;
+	  }
+
+	ForceCloseHandle (subproc_ready);
+	sigproc_terminate ();
+	myself->exit (res);
+      }
     case _P_WAIT:
     case _P_SYSTEM:
       if (waitpid (cygpid, (int *) &res, 0) !=3D cygpid)
Index: dcrt0.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.223
diff -u -p -r1.223 dcrt0.cc
--- dcrt0.cc	7 Oct 2004 16:59:02 -0000	1.223
+++ dcrt0.cc	29 Oct 2004 18:56:57 -0000
@@ -700,7 +700,10 @@ dll_crt0_0 ()
       if (close_hexec_proc)
 	CloseHandle (spawn_info->hexec_proc);
       if (close_ppid_handle)
-	CloseHandle (child_proc_info->pppid_handle);
+        {
+	  CloseHandle (child_proc_info->pppid_handle);
+	  CloseHandle (child_proc_info->pppid_sendsig);
+	}
     }

   _cygtls::init ();

--=====================_1100249337==_--

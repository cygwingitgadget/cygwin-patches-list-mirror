Return-Path: <cygwin-patches-return-4544-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20254 invoked by alias); 31 Jan 2004 19:19:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20221 invoked from network); 31 Jan 2004 19:19:47 -0000
Message-Id: <3.0.5.32.20040131141848.008138b0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 31 Jan 2004 19:19:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: ciresrv.parent
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1075594728==_"
X-SW-Source: 2004-q1/txt/msg00034.txt.bz2

--=====================_1075594728==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1048

Now that 1.5.7 is out I am continuing to look at security issues
in the Cygwin core. I can refresh the tty patch of mid December
on demand.

Meanwhile here is a very straightforward patch involving only
deletions.

ciresrv.parent is a handle to the parent process for fork 
and spawn fixups. It has the DUPLICATE_HANDLE security risk.
Fortunately it is never used in the case of spawn: all handles are
inherited, or the parent does the work (sockets). 
In the case of fork there is no security issue.

This initial patch simply removes the creation and closing of the handle.
If no trouble develop (I have been running for several weeks), a second
patch will remove the unused parent argument in the numerous 
fixup_after_exec calls.

Pierre

2004-01-31  Pierre Humblet <pierre.humblet@ieee.org>

	* spawn.cc (spawn_guts): Do not set ciresrv.parent.
	* child_info.h (~child_info_spawn): Do not close parent.
	Update CURR_CHILD_INFO_MAGIC.
	* dcrt0.cc (dll_crt0_0): Do not close spawn_info->parent.
	Pass NULL to cygheap->fdtab.fixup_after_exec().


--=====================_1075594728==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="parent.diff"
Content-length: 2750

Index: spawn.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.142
diff -u -p -r1.142 spawn.cc
--- spawn.cc	23 Jan 2004 23:05:33 -0000	1.142
+++ spawn.cc	31 Jan 2004 19:10:23 -0000
@@ -397,12 +397,6 @@ spawn_guts (const char * prog_arg, const

   init_child_info (chtype, &ciresrv, (mode =3D=3D _P_OVERLAY) ? myself->pi=
d : 1,
 		   subproc_ready);
-  if (!DuplicateHandle (hMainProc, hMainProc, hMainProc, &ciresrv.parent, =
0, 1,
-			DUPLICATE_SAME_ACCESS))
-     {
-       system_printf ("couldn't create handle to myself for child, %E");
-       return -1;
-     }

   VerifyHandle (ciresrv.parent);
   ciresrv.moreinfo =3D (cygheap_exec_info *) ccalloc (HEAP_1_EXEC, 1, size=
of (cygheap_exec_info));
Index: child_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/child_info.h,v
retrieving revision 1.39
diff -u -p -r1.39 child_info.h
--- child_info.h	1 Oct 2003 12:36:38 -0000	1.39
+++ child_info.h	31 Jan 2004 19:10:23 -0000
@@ -29,7 +29,7 @@ enum

 #define EXEC_MAGIC_SIZE sizeof(child_info)

-#define CURR_CHILD_INFO_MAGIC 0x1e4c5751U
+#define CURR_CHILD_INFO_MAGIC 0x4239088U

 /* NOTE: Do not make gratuitous changes to the names or organization of the
    below class.  The layout is checksummed to determine compatibility betw=
een
@@ -88,8 +88,6 @@ public:
   child_info_spawn (): moreinfo (NULL) {}
   ~child_info_spawn ()
   {
-    if (parent)
-      CloseHandle (parent);
     if (moreinfo)
       {
 	if (moreinfo->old_title)
Index: dcrt0.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.208
diff -u -p -r1.208 dcrt0.cc
--- dcrt0.cc	26 Jan 2004 18:52:02 -0000	1.208
+++ dcrt0.cc	31 Jan 2004 19:10:25 -0000
@@ -703,9 +703,8 @@ dll_crt0_0 ()
 	    envp =3D spawn_info->moreinfo->envp;
 	    envc =3D spawn_info->moreinfo->envc;
 	    envp =3D spawn_info->moreinfo->envp;
-	    cygheap->fdtab.fixup_after_exec (spawn_info->parent);
+	    cygheap->fdtab.fixup_after_exec (NULL);
 	    signal_fixup_after_exec ();
-	    CloseHandle (spawn_info->parent);
 	    if (spawn_info->moreinfo->old_title)
 	      {
 		old_title =3D strcpy (title_buf, spawn_info->moreinfo->old_title);

--=====================_1075594728==_--

Return-Path: <cygwin-patches-return-4558-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30677 invoked by alias); 5 Feb 2004 16:00:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30664 invoked from network); 5 Feb 2004 16:00:37 -0000
Message-ID: <402268A4.243CE18E@phumblet.no-ip.org>
Date: Thu, 05 Feb 2004 16:00:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [Patch]: well_known_sids
References: <3.0.5.32.20040204221719.007ce3f0@incoming.verizon.net> <20040205103858.GB9090@cygbert.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------387CE5BFD62E92B03C7D9269"
X-SW-Source: 2004-q1/txt/msg00048.txt.bz2

This is a multi-part message in MIME format.
--------------387CE5BFD62E92B03C7D9269
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1135



Corinna Vinschen wrote:
> 
> On Feb  4 22:17, Pierre A. Humblet wrote:
> > 2004-02-04  Pierre Humblet <pierre.humblet@ieee.org>
> >
> >       * security.h (SID): New macro.
> >       (well_known_*_sid): Change type to cygpsid.
> >       (cygsid::init): Delete declaration.
> >       * sec_helper.cc (well_known_*_sid): Define as cygpsid and initialize.
> >       (cygsid::init): Delete.
> >       * dcrt0.cc (dll_crt0_0): Do not call cygsid::init.
> >       * security.cc (get_user_local_groups): Change the second argument type to
> > cygpsid.
> 
> What about this definition of SID instead:

Wonderful!
I assume you will apply everything.

Here is the next one.

Now that the well_known_sids are usable early, 
cygheap_user::init can be greatly simplified and, as a bonus,
fork and spawn can use the default (sec_none_nih) security
attributes.

Pierre

2004-02-05  Pierre Humblet <pierre.humblet@ieee.org>

	* uinfo.cc (cygheap_user::init): Use sec_user_nih to build a
	security descriptor. Set both the process and the default DACLs.
	* fork.cc (fork_parent): Use sec_none_nih security attributes.
	* spawn.cc (spawn_guts): Ditto.
--------------387CE5BFD62E92B03C7D9269
Content-Type: text/plain; charset=us-ascii;
 name="uinfo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uinfo.diff"
Content-length: 6211

Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.124
diff -u -p -r1.124 uinfo.cc
--- uinfo.cc	23 Dec 2003 16:26:31 -0000	1.124
+++ uinfo.cc	5 Feb 2004 15:15:33 -0000
@@ -46,8 +46,7 @@ cygheap_user::init ()
 
   HANDLE ptok;
   DWORD siz;
-  char pdacl_buf [sizeof (PTOKEN_DEFAULT_DACL) + ACL_DEFAULT_SIZE];
-  PTOKEN_DEFAULT_DACL pdacl = (PTOKEN_DEFAULT_DACL) pdacl_buf;
+  PSECURITY_DESCRIPTOR psd;
 
   if (!OpenProcessToken (hMainProc, TOKEN_ADJUST_DEFAULT | TOKEN_QUERY,
 			 &ptok))
@@ -70,34 +69,24 @@ cygheap_user::init ()
   if (!SetTokenInformation (ptok, TokenOwner, &effec_cygsid, sizeof (cygsid)))
     debug_printf ("SetTokenInformation(TokenOwner): %E");
 
-  /* Add the user in the default DACL if needed */
-  if (!GetTokenInformation (ptok, TokenDefaultDacl, pdacl, sizeof (pdacl_buf), &siz))
-    system_printf ("GetTokenInformation (TokenDefaultDacl): %E");
-  else if (pdacl->DefaultDacl) /* Running with security */
-    {
-      PACL pAcl = pdacl->DefaultDacl;
-      PACCESS_ALLOWED_ACE pAce;
+  /* Standard way to build a security descriptor with the usual DACL */
+  char sa_buf[1024];
+  psd = (PSECURITY_DESCRIPTOR) (sec_user_nih (sa_buf, sid()))->lpSecurityDescriptor;
 
-      for (int i = 0; i < pAcl->AceCount; i++)
-        {
-	  if (!GetAce (pAcl, i, (LPVOID *) &pAce))
-	    system_printf ("GetAce: %E");
-	  else if (pAce->Header.AceType == ACCESS_ALLOWED_ACE_TYPE
-		   && effec_cygsid == &pAce->SidStart)
-	    goto out;
-	}
-      pAcl->AclSize = &pdacl_buf[sizeof (pdacl_buf)] - (char *) pAcl;
-      if (!AddAccessAllowedAce (pAcl, ACL_REVISION, GENERIC_ALL, effec_cygsid))
-	system_printf ("AddAccessAllowedAce: %E");
-      else if (FindFirstFreeAce (pAcl, (LPVOID *) &pAce), !(pAce))
-	debug_printf ("FindFirstFreeAce %E");
-      else
-        {
-          pAcl->AclSize = (char *) pAce - (char *) pAcl;
-	  if (!SetTokenInformation (ptok, TokenDefaultDacl, pdacl, sizeof (* pdacl)))
-	    system_printf ("SetTokenInformation (TokenDefaultDacl): %E");
-        }
+  BOOL acl_exists, dummy;
+  TOKEN_DEFAULT_DACL dacl;
+  if (GetSecurityDescriptorDacl (psd, &acl_exists, 
+				 &dacl.DefaultDacl, &dummy)
+      && acl_exists && dacl.DefaultDacl)
+    {
+      /* Set the default DACL and the process DACL */
+      if (!SetTokenInformation (ptok, TokenDefaultDacl, &dacl, sizeof (dacl)))
+	system_printf ("SetTokenInformation (TokenDefaultDacl): %E");
+      if (!SetKernelObjectSecurity (hMainProc, DACL_SECURITY_INFORMATION, psd))
+	system_printf ("SetKernelObjectSecurity: %E");
     }
+  else
+    system_printf("Cannot get dacl: %E");
  out:
   CloseHandle (ptok);
 }
Index: fork.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.125
diff -u -p -r1.125 fork.cc
--- fork.cc	1 Feb 2004 18:29:11 -0000	1.125
+++ fork.cc	5 Feb 2004 15:15:34 -0000
@@ -456,8 +456,6 @@ fork_parent (HANDLE& hParent, dll *&firs
  out:
 #endif
 
-  char sa_buf[1024];
-  PSECURITY_ATTRIBUTES sec_attribs = sec_user_nih (sa_buf);
   syscall_printf ("CreateProcess (%s, %s, 0, 0, 1, %x, 0, 0, %p, %p)",
 		  myself->progname, myself->progname, c_flags, &si, &pi);
   __malloc_lock ();
@@ -465,8 +463,8 @@ fork_parent (HANDLE& hParent, dll *&firs
   newheap = cygheap_setup_for_child (&ch, cygheap->fdtab.need_fixup_before ());
   rc = CreateProcess (myself->progname, /* image to run */
 		      myself->progname, /* what we send in arg0 */
-		      sec_attribs,
-		      sec_attribs,
+		      &sec_none_nih,
+		      &sec_none_nih,
 		      TRUE,	  /* inherit handles from parent */
 		      c_flags,
 		      NULL,	  /* environment filled in later */
Index: spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.143
diff -u -p -r1.143 spawn.cc
--- spawn.cc	2 Feb 2004 21:00:07 -0000	1.143
+++ spawn.cc	5 Feb 2004 15:15:34 -0000
@@ -639,8 +639,6 @@ spawn_guts (const char * prog_arg, const
   syscall_printf ("null_app_name %d (%s, %.9500s)", null_app_name, runpath, one_line.buf);
 
   void *newheap;
-  /* Preallocated buffer for `sec_user' call */
-  char sa_buf[1024];
 
   cygbench ("spawn-guts");
 
@@ -656,14 +654,13 @@ spawn_guts (const char * prog_arg, const
 	  && cygheap->user.saved_gid == cygheap->user.real_gid
 	  && !cygheap->user.groups.issetgroups ()))
     {
-      PSECURITY_ATTRIBUTES sec_attribs = sec_user_nih (sa_buf);
       ciresrv.moreinfo->envp = build_env (envp, envblock, ciresrv.moreinfo->envc,
 					  real_path.iscygexec ());
       newheap = cygheap_setup_for_child (&ciresrv, cygheap->fdtab.need_fixup_before ());
       rc = CreateProcess (runpath,	/* image name - with full path */
 			  one_line.buf,	/* what was passed to exec */
-			  sec_attribs,	/* process security attrs */
-			  sec_attribs,	/* thread security attrs */
+			  &sec_none_nih,/* process security attrs */
+			  &sec_none_nih,/* thread security attrs */
 			  TRUE,		/* inherit handles from parent */
 			  flags,
 			  envblock,	/* environment */
@@ -673,14 +670,10 @@ spawn_guts (const char * prog_arg, const
     }
   else
     {
-      PSID sid = cygheap->user.sid ();
       /* Give access to myself */
       if (mode == _P_OVERLAY)
 	myself.set_acl();
 
-      /* Set security attributes with sid */
-      PSECURITY_ATTRIBUTES sec_attribs = sec_user_nih (sa_buf, sid);
-
       /* allow the child to interact with our window station/desktop */
       HANDLE hwst, hdsk;
       SECURITY_INFORMATION dsi = DACL_SECURITY_INFORMATION;
@@ -704,8 +697,8 @@ spawn_guts (const char * prog_arg, const
       rc = CreateProcessAsUser (cygheap->user.token (),
 		       runpath,		/* image name - with full path */
 		       one_line.buf,	/* what was passed to exec */
-		       sec_attribs,     /* process security attrs */
-		       sec_attribs,     /* thread security attrs */
+		       &sec_none_nih,   /* process security attrs */
+		       &sec_none_nih,   /* thread security attrs */
 		       TRUE,		/* inherit handles from parent */
 		       flags,
 		       envblock,	/* environment */

--------------387CE5BFD62E92B03C7D9269--

Return-Path: <cygwin-patches-return-2155-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29265 invoked by alias); 5 May 2002 15:44:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29251 invoked from network); 5 May 2002 15:44:23 -0000
Message-Id: <3.0.5.32.20020505114157.00815a40@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 05 May 2002 08:44:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Security patches
In-Reply-To: <20020412095426.B20149@cygbert.vinschen.de>
References: <3CB58D37.52F084E@ieee.org>
 <3.0.5.32.20020309192813.007fcb70@pop.ne.mediaone.net>
 <20020314133309.Q29574@cygbert.vinschen.de>
 <3C90B0D7.EB06F222@ieee.org>
 <3CB58D37.52F084E@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1020627717==_"
X-SW-Source: 2002-q2/txt/msg00139.txt.bz2

--=====================_1020627717==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 571

At 09:54 AM 4/12/2002 +0200, Corinna Vinschen wrote:
>I hope you don't mind that I'm asking you to send the patch again
>to cygwin-patches, relative to the current CVS. 

Getting back to security. I will resend the patches in independent,
self contained, installments as I recreate and retest. 
These 3 are very minor.

Pierre

2002-05-05  Pierre Humblet <pierre.humblet@ieee.org>
	* spawn.cc (spawn_guts): Move call to set_process_privilege()
	to load_registry_hive().
	* registry.cc (load_registry_hive): ditto.
	* fork.cc (fork_parent): Call sec_user_nih() only once.

--=====================_1020627717==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="spawn.cc.diff"
Content-length: 389

--- spawn.cc.orig	Sun May  5 10:49:34 2002
+++ spawn.cc	Sun May  5 11:04:14 2002
@@ -665,13 +665,6 @@
 	  && cygheap->user.token != INVALID_HANDLE_VALUE)
 	RevertToSelf ();
 
-      static BOOL first_time = TRUE;
-      if (first_time)
-	{
-	  set_process_privilege (SE_RESTORE_NAME);
-	  first_time = FALSE;
-	}
-
       /* Load users registry hive. */
       load_registry_hive (sid);
 

--=====================_1020627717==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="registry.cc.diff"
Content-length: 597

--- registry.cc.orig	Sun May  5 11:00:52 2002
+++ registry.cc	Sun May  5 11:02:16 2002
@@ -235,12 +235,13 @@
   /* Check if user hive is already loaded. */
   cygsid csid (psid);
   csid.string (sid);
-  if (!RegOpenKeyExA (HKEY_USERS, csid.string (sid), 0, KEY_READ, &hkey))
+  if (!RegOpenKeyExA (HKEY_USERS, sid, 0, KEY_READ, &hkey))
     {
       debug_printf ("User registry hive for %s already exists", sid);
       RegCloseKey (hkey);
       return;
     }
+  set_process_privilege (SE_RESTORE_NAME);
   if (get_registry_hive_path (psid, path))
     {
       strcat (path, "\\NTUSER.DAT");

--=====================_1020627717==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="fork.cc.diff"
Content-length: 802

--- fork.cc.orig	Sun May  5 10:49:30 2002
+++ fork.cc	Sun May  5 11:03:10 2002
@@ -466,6 +466,7 @@
 #endif
 
   char sa_buf[1024];
+  PSECURITY_ATTRIBUTES sec_attribs = sec_user_nih (sa_buf);
   syscall_printf ("CreateProcess (%s, %s, 0, 0, 1, %x, 0, 0, %p, %p)",
 		  myself->progname, myself->progname, c_flags, &si, &pi);
   __malloc_lock (_reent_clib ());
@@ -473,8 +474,8 @@
   newheap = cygheap_setup_for_child (&ch,cygheap->fdtab.need_fixup_before ());
   rc = CreateProcess (myself->progname, /* image to run */
 		      myself->progname, /* what we send in arg0 */
-		      sec_user_nih (sa_buf),
-		      sec_user_nih (sa_buf),
+		      sec_attribs,
+		      sec_attribs,
 		      TRUE,	  /* inherit handles from parent */
 		      c_flags,
 		      NULL,	  /* environment filled in later */

--=====================_1020627717==_--

Return-Path: <cygwin-patches-return-8517-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60914 invoked by alias); 30 Mar 2016 19:24:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60895 invoked by uid 89); 30 Mar 2016 19:24:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=absent, 35,7, sk:obcasei, tape
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 30 Mar 2016 19:24:02 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLG1-0002Fz-JJ; Wed, 30 Mar 2016 20:54:22 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLG0-00025O-Ew; Wed, 30 Mar 2016 20:54:21 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 30 Mar 2016 20:54:20 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 5/6] forkables: Keep hardlinks disabled via shared mem.
Date: Wed, 30 Mar 2016 19:24:00 -0000
Message-Id: <1459364024-24891-6-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q1/txt/msg00223.txt.bz2

To avoid the need for each process to check the filesystem to detect
that hardlink creation is impossible or disabled, cache this fact in
shared memory.  Removing cygfork directory while in use does disable
hardlinks creation.  To (re-)enable hardlinks creation, the cygfork
directory has to exist before the first cygwin process does fork.

	* forkable.cc (dll_list::forkable_ntnamesize): Short cut
	forkables needs to impossible when disabled via shared memory.
	(dll_list::update_forkables_needs): When detecting hardlink
	creation as impossible (not on NTFS) while still (we are the
	first one checking) enabled via shared memory, disable the
	shared memory value.
	* (dll_list::request_forkables): Disable the shared memory value
	when hardlinks creation is disabled, that is when the cygfork
	directory is (or became) absent.
---
 winsup/cygwin/forkable.cc              | 13 +++++++++++++
 winsup/cygwin/include/cygwin/version.h |  5 +++--
 winsup/cygwin/shared.cc                |  1 +
 winsup/cygwin/shared_info.h            |  3 ++-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index 0a8a528..83b5731 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -412,6 +412,11 @@ dll::create_forkable ()
 size_t
 dll_list::forkable_ntnamesize (dll_type type, PCWCHAR fullntname, PCWCHAR modname)
 {
+  /* per process, this is the first forkables-method ever called */
+  if (forkables_needs == forkables_unknown &&
+      !cygwin_shared->prefer_forkable_hardlinks)
+      forkables_needs = forkables_impossible; /* short cut */
+
   if (forkables_needs == forkables_impossible)
     return 0;
 
@@ -553,6 +558,7 @@ dll_list::update_forkables_needs ()
 	{
 	  debug_printf ("impossible, not on NTFS %W", fn.Buffer);
 	  forkables_needs = forkables_impossible;
+	  cygwin_shared->prefer_forkable_hardlinks = 0;
 	}
     }
 
@@ -1048,6 +1054,13 @@ dll_list::request_forkables ()
 
   set_forkables_inheritance (true);
 
+  if (forkables_needs == forkables_disabled)
+    {
+      /* we do not support (re-)enabling on the fly */
+      forkables_needs = forkables_impossible;
+      cygwin_shared->prefer_forkable_hardlinks = 0;
+    }
+
   if (forkables_needs <= forkables_needless)
     return;
 
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 8b1a8fc..7ac5899 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -503,9 +503,10 @@ details. */
 	shared mutexes, semaphores, etc.   The arbitrary starting
 	version was 0 (cygwin release 98r2).
 	Bump to 4 since this hasn't been rigorously updated in a
-	while.  */
+	while.
+	6. Add prefer_forkable_hardlinks (using /var/run/cygfork/). */
 
-#define CYGWIN_VERSION_SHARED_DATA 5
+#define CYGWIN_VERSION_SHARED_DATA 6
 
      /* An identifier used in the names used to create shared objects.
 	The full names include the CYGWIN_VERSION_SHARED_DATA version
diff --git a/winsup/cygwin/shared.cc b/winsup/cygwin/shared.cc
index 202d8cc..2bc9c7a 100644
--- a/winsup/cygwin/shared.cc
+++ b/winsup/cygwin/shared.cc
@@ -331,6 +331,7 @@ shared_info::initialize ()
       init_obcaseinsensitive ();	/* Initialize obcaseinsensitive */
       tty.init ();			/* Initialize tty table  */
       mt.initialize ();			/* Initialize shared tape information */
+      prefer_forkable_hardlinks = 1;    /* Yes */
       /* Defer debug output printing the installation root and installation key
 	 up to this point.  Debug output except for system_printf requires
 	 the global shared memory to exist. */
diff --git a/winsup/cygwin/shared_info.h b/winsup/cygwin/shared_info.h
index 90b386f..dd4cb3d 100644
--- a/winsup/cygwin/shared_info.h
+++ b/winsup/cygwin/shared_info.h
@@ -35,7 +35,7 @@ public:
 /* Data accessible to all tasks */
 
 
-#define CURR_SHARED_MAGIC 0x8fe4d9eeU
+#define CURR_SHARED_MAGIC 0xbc5d6a9cU
 
 #define USER_VERSION   1
 
@@ -51,6 +51,7 @@ class shared_info
   LONG last_used_bindresvport;
   DWORD obcaseinsensitive;
   mtinfo mt;
+  char prefer_forkable_hardlinks; /* single byte access always is atomic */
 
   void initialize ();
   void init_obcaseinsensitive ();
-- 
2.7.3

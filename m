Return-Path: <cygwin-patches-return-6604-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13956 invoked by alias); 29 Aug 2009 14:05:05 -0000
Received: (qmail 13934 invoked by uid 22791); 29 Aug 2009 14:05:03 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Check-By: sourceware.org
Received: from mailout03.t-online.de (HELO mailout03.t-online.de) (194.25.134.81)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 29 Aug 2009 14:04:55 +0000
Received: from fwd04.aul.t-online.de  	by mailout03.t-online.de with smtp  	id 1MhOXz-0001rx-00; Sat, 29 Aug 2009 16:04:51 +0200
Received: from [10.3.2.2] (SrFhxvZaZha0-H7cb7Nbfa5qv+3n2Xyrdtdw3VgBH+VUf6COqqZr8R0B3X0Fd0LZSw@[217.235.197.223]) by fwd04.aul.t-online.de 	with esmtp id 1MhOXx-1Kbowq0; Sat, 29 Aug 2009 16:04:49 +0200
Message-ID: <4A993580.4060604@t-online.de>
Date: Sat, 29 Aug 2009 14:05:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090403 SeaMonkey/1.1.16
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] Allow to disable root privileges with CYGWIN=noroot
Content-Type: multipart/mixed;  boundary="------------000909050604050205010303"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00058.txt.bz2

This is a multi-part message in MIME format.
--------------000909050604050205010303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 804

For members of administrator group, Cygwin runs with root access rights. 
Cygwin enables the Windows backup and restore privileges which are not 
enabled by default.

This is IMO not desirable under all circumstances.

This patch adds a new flag to the Cygwin environment variable.
If 'CYGWIN=noroot' is set, the extra privileges are removed after Cygwin 
startup.

This allows to run a Cygwin shell with the same default access rights as 
cmd or explorer.


Testcase:

$ cd /cygdrive/c

$ ls -l 'System Volume Information'
----rwx---  1 root SYSTEM   0 Feb 22  2009 MountPointManagerRemoteDatabase
...

$ CYGWIN=noroot ls -l 'System Volume Information'
ls: cannot open directory System Volume Information: Permission denied


I'm sure there is something missing, so no changelog for now :-)

Christian


--------------000909050604050205010303
Content-Type: text/x-patch;
 name="cygwin-1.7-env-noroot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.7-env-noroot.patch"
Content-length: 2753

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index d4e003f..eff982d 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -33,6 +33,7 @@ details. */
 extern bool dos_file_warning;
 extern bool ignore_case_with_glob;
 extern bool allow_winsymlinks;
+extern bool use_root_privileges;
 bool reset_com = false;
 static bool envcache = true;
 static bool create_upcaseenv = false;
@@ -565,6 +566,23 @@ set_proc_retry (const char *buf)
   child_info::retry_count = strtoul (buf, NULL, 0);
 }
 
+static void
+set_root_mode (const char *buf)
+{
+  bool old_state = use_root_privileges;
+
+  if (!buf || !*buf)
+    use_root_privileges = false;
+  else
+    use_root_privileges = true;
+
+  if (use_root_privileges != old_state)
+    {
+      OpenProcessToken (hMainProc, MAXIMUM_ALLOWED, &hProcToken);
+      set_cygwin_privileges (hProcToken);
+    }
+}
+
 /* The structure below is used to set up an array which is used to
    parse the CYGWIN environment variable or, if enabled, options from
    the registry.  */
@@ -596,6 +614,7 @@ static struct parse_thing
   {"glob", {func: &glob_init}, isfunc, NULL, {{0}, {s: "normal"}}},
   {"proc_retry", {func: set_proc_retry}, isfunc, NULL, {{0}, {5}}},
   {"reset_com", {&reset_com}, justset, NULL, {{false}, {true}}},
+  {"root", {func: &set_root_mode}, isfunc, NULL, {{s:NULL}, {s:"yes"}}},
   {"strip_title", {&strip_title_path}, justset, NULL, {{false}, {true}}},
   {"title", {&display_title}, justset, NULL, {{false}, {true}}},
   {"tty", {NULL}, set_process_state, NULL, {{0}, {PID_USETTY}}},
diff --git a/winsup/cygwin/sec_helper.cc b/winsup/cygwin/sec_helper.cc
index 63be25c..c567dfd 100644
--- a/winsup/cygwin/sec_helper.cc
+++ b/winsup/cygwin/sec_helper.cc
@@ -406,15 +406,22 @@ out:
   return ret;
 }
 
+/* This may be set to false by 'CYGWIN=noroot' or by parent process
+   through fork().  */
+bool use_root_privileges = true;
+
 /* This is called very early in process initialization.  The code must
-   not depend on anything. */
+   not depend on anything.
+   Note: During fork() this is called twice:
+   first with use_root_privileges = always_true,
+   then with  use_root_privileges = inherited_from_parent.  */
 void
 set_cygwin_privileges (HANDLE token)
 {
-  set_privilege (token, SE_RESTORE_PRIVILEGE, true);
-  set_privilege (token, SE_BACKUP_PRIVILEGE, true);
+  set_privilege (token, SE_RESTORE_PRIVILEGE, use_root_privileges);
+  set_privilege (token, SE_BACKUP_PRIVILEGE, use_root_privileges);
   if (wincap.has_create_global_privilege ())
-    set_privilege (token, SE_CREATE_GLOBAL_PRIVILEGE, true);
+    set_privilege (token, SE_CREATE_GLOBAL_PRIVILEGE, use_root_privileges);
 }
 
 /* Function to return a common SECURITY_DESCRIPTOR that

--------------000909050604050205010303--

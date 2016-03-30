Return-Path: <cygwin-patches-return-8518-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61429 invoked by alias); 30 Mar 2016 19:24:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61378 invoked by uid 89); 30 Mar 2016 19:24:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=xref, UD:faq-api.xml, faqapixml, faq-api.xml
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 30 Mar 2016 19:24:17 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLG6-0002G4-In; Wed, 30 Mar 2016 20:54:27 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLG5-00025R-E6; Wed, 30 Mar 2016 20:54:26 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 30 Mar 2016 20:54:25 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 6/6] forkables: Document hardlink creation at forktime.
Date: Wed, 30 Mar 2016 19:24:00 -0000
Message-Id: <1459364024-24891-7-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q1/txt/msg00224.txt.bz2

	* faq-api.xml: Mention hardlink creation by fork.
	* highlights.xml: Describe hardlink creation.
---
 winsup/doc/faq-api.xml    |  5 +++++
 winsup/doc/highlights.xml | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/winsup/doc/faq-api.xml b/winsup/doc/faq-api.xml
index 993274a..4c1f138 100644
--- a/winsup/doc/faq-api.xml
+++ b/winsup/doc/faq-api.xml
@@ -155,6 +155,11 @@ child, releases the mutex the child is waiting on and returns from the
 fork call.  Child wakes from blocking on mutex, recreates any mmapped
 areas passed to it via shared area and then returns from fork itself.
 </para>
+<para>When the executable or any dll in use by the parent was renamed
+or moved into the hidden recycle bin, fork tries to create hardlinks
+for the old executable and any dll into per-user subdirectories in the
+/var/run/cygfork/ directory, when that one exists and resides on NTFS.
+</para>
 </answer></qandaentry>
 
 <qandaentry id="faq.api.globbing">
diff --git a/winsup/doc/highlights.xml b/winsup/doc/highlights.xml
index 65407ab..c000f24 100644
--- a/winsup/doc/highlights.xml
+++ b/winsup/doc/highlights.xml
@@ -195,6 +195,47 @@ difficult to implement correctly.  Currently, the Cygwin fork is a
 non-copy-on-write implementation similar to what was present in early
 flavors of UNIX.</para>
 
+<para>As the child process is created as new process, both the main
+executable and all the dlls loaded either statically or dynamically have
+to be identical as to when the parent process has started or loaded a dll.
+While Windows does not allow to remove binaries in use from the file
+system, they still can be renamed or moved into the recycle bin, as
+outlined for unlink(2) in <xref linkend="ov-new1.7-file"></xref>.
+To allow an existing process to fork, the original binary files need to be
+available via their original file names, but they may reside in
+different directories when using the <ulink
+url="https://social.msdn.microsoft.com/search/en-US?query=dotlocal%20dll%20redirection"
+>DotLocal (.local) Dll Redirection</ulink> feature.
+Since NTFS does support hardlinks, we create a private directory
+containing hardlinks to the original files as well as the .local file.
+The private directory for the hardlinks is /var/run/cygfork/, which you
+have to create manually for now if you need to protect fork against exe-
+and dll- updates on your Cygwin instance.  As hardlinks cannot be used
+across multiple NTFS file systems, please make sure your exe- and dll-
+replacing operations operate on the same single NTFS file system as your
+Cygwin instance and the /var/run/cygfork/ directory.</para>
+
+<para>We create one directory per user, application and application age,
+and remove it when no more processes use that directory.  To indicate
+whether a directory still is in use, we define a mutex name similar to
+the directory name.  As mutexes are destroyed when no process holds a
+handle open any more, we can clean up even after power loss or similar:
+Both the parent and child process, at exit they lock the mutex with
+almost no timeout, and close it.
+If the lock succeeded before closing, directory cleanup is started:
+For each directory found, the corresponding mutex is created with lock.
+If that succeeds, the directory is removed, as it is unused now, and the
+corresponding mutex handle is closed.</para>
+
+<para>Before fork, when about to create hardlinks for the first time, the
+mutex is opened and locked with infinite timeout, to wait for the cleanup
+that may run at the same time.  Once locked, the mutex is unlocked
+immediately, but the mutex handle stays open until exit, and the hardlinks
+are created.  It is fine for multiple processes to concurrently create
+the same hardlinks, as the result really should be identical.  Once the
+mutex is open, we can create more hardlinks within this one directory
+without the need to lock the mutex again.</para>
+
 <para>The first thing that happens when a parent process
 forks a child process is that the parent initializes a space in the
 Cygwin process table for the child.  It then creates a suspended
-- 
2.7.3

Return-Path: <SRS0=dU+G=QN=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 0B8DA3858D20
	for <cygwin-patches@cygwin.com>; Sun, 15 Sep 2024 08:09:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0B8DA3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0B8DA3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1726387796; cv=none;
	b=Y5FgINfcQtjFaz30dKqBN9bAYULRa14/PNaMOaDBye3dBkgGMWrFZoWFVyJrHN75qzmvMnEOOcUzG1uaeaNnbFgfdO+YfH5nmY4cFrGYuyRJdvLtugF9MZTjkc9d+nHO9WEIplMwUR4WdjabZRNtZPwde6GRk5Yuuk0GGFBgEOk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726387796; c=relaxed/simple;
	bh=iyzjTOGlVI9F5mbc+bLI1HrSZNbLhZJsaRxJzrCdK0w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QQ3wYdCObW4+kneRSPDU/txeAsgFd4tbMKYaokv9sc0OrCpF8gfHKvMni+Yoxo0RAQd42msFGHM4A8XQHKQMkNK5ITzuFW6IpLe9Q07q2glDiia26VHRAM5xJScdOLHF5/MxCH2U1+qtI/sOHWatFKUD7GmDjFLEFbdgH/mEHTs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 48F8DgTA011556;
	Sun, 15 Sep 2024 01:13:42 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdWDUEXZ; Sun Sep 15 01:13:38 2024
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Fix pthread_sigqueue to accept thread id
Date: Sun, 15 Sep 2024 01:09:23 -0700
Message-ID: <20240915080934.334-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Change the prototype for pthread_sigqueue() so the first parameter is a
thread id. Change the code of the function to deal with the changed
parameter. This involves adding cheap iteration to the list of threads.

[I have questions about the code (see below) so there will be a v2 patch
with these paragraphs deleted and Reported-By:, Fixes:, etc lines added.

Q1: In pthread_sigqueue(), is there a better way to get the lowest 32
bits of thread_id? I tried various ways of casting and/or masking but
all were rejected by g++ with a suggestion to add "-fpermissive".

Q2: Same func, are the sanity checks I've flagged with a FIXME comment
still useful? Previously users could pass in an arbitrary pointer for
the first arg so such validation was required for safety. Now they will
pass in a thread id, which is searched for in Cygwin's thread list.
Presumably the pointer to a thread with a valid id is valid, right?]

---
 winsup/cygwin/include/pthread.h       |  2 +-
 winsup/cygwin/local_includes/thread.h | 18 ++++++++++++++++++
 winsup/cygwin/thread.cc               | 23 +++++++++++++++++++----
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
index 66d367d62..a0ec32526 100644
--- a/winsup/cygwin/include/pthread.h
+++ b/winsup/cygwin/include/pthread.h
@@ -244,7 +244,7 @@ int pthread_getattr_np (pthread_t, pthread_attr_t *);
 int pthread_getname_np (pthread_t, char *, size_t) __attribute__((__nonnull__(2)));
 int pthread_setaffinity_np (pthread_t, size_t, const cpu_set_t *);
 int pthread_setname_np (pthread_t, const char *) __attribute__((__nonnull__(2)));
-int pthread_sigqueue (pthread_t *, int, const union sigval);
+int pthread_sigqueue (pthread_t, int, const union sigval);
 int pthread_timedjoin_np (pthread_t, void **, const struct timespec *);
 int pthread_tryjoin_np (pthread_t, void **);
 #endif
diff --git a/winsup/cygwin/local_includes/thread.h b/winsup/cygwin/local_includes/thread.h
index b3496281e..a6e9c9b6b 100644
--- a/winsup/cygwin/local_includes/thread.h
+++ b/winsup/cygwin/local_includes/thread.h
@@ -199,6 +199,16 @@ template <class list_node> class List
   fast_mutex mx;
   list_node *head;
 
+  list_node *first ()
+  {
+    return head;
+  }
+
+  list_node *next (list_node *cur)
+  {
+    return cur->next;
+  }
+
 protected:
   void mx_init ()
   {
@@ -439,6 +449,14 @@ public:
     return t1 == t2;
   }
 
+  static pthread* lookup_by_id (DWORD thread_id)
+  {
+    for (pthread *ptr = threads.first (); ptr; ptr = threads.next (ptr))
+      if (thread_id == ptr->get_thread_id ())
+        return ptr;
+    return NULL;
+  }
+
   /* List support calls */
   class pthread *next;
   static void fixup_after_fork ()
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 0c6f57032..627488d23 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -3300,16 +3300,31 @@ pthread_sigmask (int operation, const sigset_t *set, sigset_t *old_set)
   return res;
 }
 
-int
-pthread_sigqueue (pthread_t *thread, int sig, const union sigval value)
-{
-  siginfo_t si = {0};
+/* This is likely the only pthread_ API function taking a thread id argument.
+   Note how it's prototyped pthread_t to cosmetically match the func family. */
+int
+pthread_sigqueue (pthread_t thread_id, int sig, const union sigval value)
+{
+  // Deal with cockamamie use of "pthread_t" to pass in an integer thread id
+  union {
+    pthread_t thread_id;
+    DWORD tid;
+  } u;
+  u.thread_id = thread_id;
+
+  // This convolution seems to be needed for the sanity checks below.
+  void *tmp = (void *) pthread::lookup_by_id (u.tid);
+  pthread_t const* thread = (pthread_t const*) &tmp;
+  if (!*thread)
+    return ESRCH;
 
+  //FIXME possibly superfluous sanity checks from when pthread_t* passed in
   if (!pthread::is_good_object (thread))
     return EINVAL;
   if (!(*thread)->valid)
     return ESRCH;
 
+  siginfo_t si = {0};
   si.si_signo = sig;
   si.si_code = SI_QUEUE;
   si.si_value = value;
-- 
2.45.1


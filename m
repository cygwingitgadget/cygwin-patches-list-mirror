Return-Path: <SRS0=9P8N=QR=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 5BDC63858CD9
	for <cygwin-patches@cygwin.com>; Thu, 19 Sep 2024 09:13:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5BDC63858CD9
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5BDC63858CD9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1726737236; cv=none;
	b=uZUkBGv+bi2ZBWC30A6EUI8cr1dB2IFroQykmPTOTvlj8yXw3KAQzYmxBTNzRopNYss+FX/EXVd3c0V8/9AmzvOhiNu5nU59gtRo3RSfL+SDXmB7JF5EnU41/E4YenkJ9MEuU3rzMEoJz/pJso8Kk1we58ijvn4frgJpHMJ9yoc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726737236; c=relaxed/simple;
	bh=XU7hmyehQGDrOz4yfkywR/ziwEQQ9qp3cMXB8GgAGZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q8d0Yi2xCpjrI9EB+kHsxUIi496AYDOP1ABnjFRdli5TR6uLKqqiA7AN+Cn1o+fWYRxKWGKyFk1jbYbAw/OHcOA4kPsjMMI0jP/kxfdYvTGg6OSOmTLphbsOzkPUVNpEXjZXRR0Ap/mQ8u/jjm/BPgYhiIamHxoJQ+LleQUm+Q8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 48J9HcFw089889;
	Thu, 19 Sep 2024 02:17:38 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdnUCIEH; Thu Sep 19 02:17:28 2024
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
Date: Thu, 19 Sep 2024 02:13:20 -0700
Message-ID: <20240919091331.1534-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Change the first parameter of pthread_sigqueue() to be a thread id rather
than a thread pointer. The change is to match the Linux implementation of
this function.

The user-visible function prototype is changed. Simple list iteration is
added to the threadlist code. A lookup-by-id function is added to class
pthread. The pthread_sigqueue() function is modified to work with a
passed-in thread id rather than an indirect thread pointer as before.
(It was "pthread_t *thread", i.e., class pthread **.) The release note
for Cygwin 3.6.0 is updated.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2024-September/256439.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 2041af1a535a (cygwin.din (pthread_sigqueue): Export.)

---
 winsup/cygwin/include/pthread.h       |  2 +-
 winsup/cygwin/local_includes/thread.h | 18 ++++++++++++++++++
 winsup/cygwin/release/3.6.0           |  3 +++
 winsup/cygwin/thread.cc               | 12 ++++++++++--
 4 files changed, 32 insertions(+), 3 deletions(-)

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
diff --git a/winsup/cygwin/release/3.6.0 b/winsup/cygwin/release/3.6.0
index 240550715..8dfa4c385 100644
--- a/winsup/cygwin/release/3.6.0
+++ b/winsup/cygwin/release/3.6.0
@@ -34,3 +34,6 @@ What changed:
 - Expose //tsclient (Microsoft Terminal Services) shares as well as
   //wsl$ (Plan 9 Network Provider) shares, i. e., WSL installation
   root dirs.
+
+- Change pthread_sigqueue() to accept a thread id as first parameter
+  as Linux does.
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 0c6f57032..7905935a3 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -3301,15 +3301,23 @@ pthread_sigmask (int operation, const sigset_t *set, sigset_t *old_set)
 }
 
 int
-pthread_sigqueue (pthread_t *thread, int sig, const union sigval value)
+pthread_sigqueue (pthread_t thread_id, int sig, const union sigval value)
 {
-  siginfo_t si = {0};
+  DWORD tid = (DWORD) (long) thread_id;
+
+  //FIXME This convolution is needed for ::is_good_object below
+  void *tmp = (void *) pthread::lookup_by_id (tid);
+  pthread_t const *thread = (pthread_t const *) &tmp;
+  if (!*thread)
+    return ESRCH;
 
+  //FIXME possibly superfluous sanity checks from older version of function
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


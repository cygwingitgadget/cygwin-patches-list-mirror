Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 40D193857C43
 for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2020 04:59:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 40D193857C43
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 07O4xUhV095804;
 Sun, 23 Aug 2020 21:59:30 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdu50mhu; Sun Aug 23 21:59:26 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: malloc tune-up
Date: Sun, 23 Aug 2020 21:59:13 -0700
Message-Id: <20200824045913.1216-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 24 Aug 2020 04:59:36 -0000

1. Replace global malloc lock with finer-grained internal locks.
2. Enable MSPACES, i.e. thread-specific memory pools.

Porting and testing of several dlmalloc-related malloc implementations
(ptmalloc, ptmalloc2, ptmalloc3, nedalloc) shows that they are no faster
than the current dlmalloc used by Cygwin, when the latter is tuned.  This
could be because the others are forks of earlier dlmalloc versions.  For
the record, I could not get jemalloc or tcmalloc running at all due to
chicken-egg issues, nor could I get a Win32 Heap-based malloc to work
across fork(), which was expected.

I think I can see a way to get Win32 Heap-based malloc to work across
fork()s, but it would depend on undocumented info and would likely be
subject to breakage in future Windows versions.  Too bad, because that
form of malloc package would be 2 to 8 times faster in practice.

---
 winsup/cygwin/cygmalloc.h       |  21 +++-
 winsup/cygwin/fork.cc           |   7 --
 winsup/cygwin/malloc_wrapper.cc | 163 +++++++++++++++++++-------------
 3 files changed, 113 insertions(+), 78 deletions(-)

diff --git a/winsup/cygwin/cygmalloc.h b/winsup/cygwin/cygmalloc.h
index 84bad824c..302ce59c8 100644
--- a/winsup/cygwin/cygmalloc.h
+++ b/winsup/cygwin/cygmalloc.h
@@ -33,15 +33,30 @@ void *mmap64 (void *, size_t, int, int, int, off_t);
 # define mmap mmap64
 # define MALLOC_FAILURE_ACTION	__set_ENOMEM ()
 # define USE_DL_PREFIX 1
+# define USE_LOCKS 1
+# define MSPACES 1
+# define FOOTERS 1
 
 #elif defined (__INSIDE_CYGWIN__)
 
-# define __malloc_lock() mallock.acquire ()
-# define __malloc_unlock() mallock.release ()
-extern muto mallock;
+# define MSPACES 0
 
 #endif
 
+#if MSPACES
+void __reg2 *create_mspace (size_t, int);
+void __reg2 mspace_free (void *m, void *p);
+void __reg2 *mspace_malloc (void *m, size_t size);
+void __reg3 *mspace_realloc (void *m, void *p, size_t size);
+void __reg3 *mspace_calloc (void *m, size_t nmemb, size_t size);
+void __reg3 *mspace_memalign (void *m, size_t alignment, size_t bytes);
+void __reg2 *mspace_valloc (void *m, size_t bytes);
+size_t __reg1 mspace_usable_size (const void *p);
+int __reg2 mspace_malloc_trim (void *m, size_t);
+int __reg2 mspace_mallopt (int p, int v);
+void __reg1 mspace_malloc_stats (void *m);
+#endif
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 38172ca1e..82f95dafe 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -296,8 +296,6 @@ frok::parent (volatile char * volatile stack_here)
   si.lpReserved2 = (LPBYTE) &ch;
   si.cbReserved2 = sizeof (ch);
 
-  bool locked = __malloc_lock ();
-
   /* Remove impersonation */
   cygheap->user.deimpersonate ();
   fix_impersonation = true;
@@ -448,9 +446,6 @@ frok::parent (volatile char * volatile stack_here)
 		   "stack", stack_here, ch.stackbase,
 		   impure, impure_beg, impure_end,
 		   NULL);
-
-  __malloc_unlock ();
-  locked = false;
   if (!rc)
     {
       this_errno = get_errno ();
@@ -533,8 +528,6 @@ cleanup:
 
   if (fix_impersonation)
     cygheap->user.reimpersonate ();
-  if (locked)
-    __malloc_unlock ();
 
   /* Remember to de-allocate the fd table. */
   if (hchild)
diff --git a/winsup/cygwin/malloc_wrapper.cc b/winsup/cygwin/malloc_wrapper.cc
index 3b245800a..f1c23b4a8 100644
--- a/winsup/cygwin/malloc_wrapper.cc
+++ b/winsup/cygwin/malloc_wrapper.cc
@@ -27,6 +27,33 @@ extern "C" struct mallinfo dlmallinfo ();
 static bool use_internal = true;
 static bool internal_malloc_determined;
 
+/* If MSPACES (thread-specific memory pools) are enabled, use a
+   thread-local variable to store a pointer to that thread's mspace.
+ */
+#if MSPACES
+static DWORD tls_mspace; // index into thread's TLS array
+#define MSPACE_SIZE (8 * 1024 * 1024)
+
+static void *
+get_current_mspace ()
+{
+  if (unlikely(tls_mspace == 0))
+    api_fatal ("a malloc-related function was called before malloc_init");
+
+  void *m = TlsGetValue (tls_mspace);
+  if (unlikely(m == 0))
+    {
+      m = create_mspace (MSPACE_SIZE, 0);
+      if (!m)
+        api_fatal ("unable to create mspace");
+      TlsSetValue (tls_mspace, m);
+    }
+  return m;
+}
+
+#define MSPACE get_current_mspace()
+#endif
+
 /* These routines are used by the application if it
    doesn't provide its own malloc. */
 
@@ -37,11 +64,11 @@ free (void *p)
   if (!use_internal)
     user_data->free (p);
   else
-    {
-      __malloc_lock ();
-      dlfree (p);
-      __malloc_unlock ();
-    }
+#if MSPACES
+    mspace_free (MSPACE, p);
+#else
+    dlfree (p);
+#endif
 }
 
 extern "C" void *
@@ -51,11 +78,11 @@ malloc (size_t size)
   if (!use_internal)
     res = user_data->malloc (size);
   else
-    {
-      __malloc_lock ();
-      res = dlmalloc (size);
-      __malloc_unlock ();
-    }
+#if MSPACES
+    res = mspace_malloc (MSPACE, size);
+#else
+    res = dlmalloc (size);
+#endif
   malloc_printf ("(%ld) = %p, called by %p", size, res,
 					     caller_return_address ());
   return res;
@@ -68,11 +95,11 @@ realloc (void *p, size_t size)
   if (!use_internal)
     res = user_data->realloc (p, size);
   else
-    {
-      __malloc_lock ();
-      res = dlrealloc (p, size);
-      __malloc_unlock ();
-    }
+#if MSPACES
+    res = mspace_realloc (MSPACE, p, size);
+#else
+    res = dlrealloc (p, size);
+#endif
   malloc_printf ("(%p, %ld) = %p, called by %p", p, size, res,
 						 caller_return_address ());
   return res;
@@ -96,11 +123,11 @@ calloc (size_t nmemb, size_t size)
   if (!use_internal)
     res = user_data->calloc (nmemb, size);
   else
-    {
-      __malloc_lock ();
-      res = dlcalloc (nmemb, size);
-      __malloc_unlock ();
-    }
+#if MSPACES
+    res = memspace_calloc (MSPACE, nmemb, size);
+#else
+    res = dlcalloc (nmemb, size);
+#endif
   malloc_printf ("(%ld, %ld) = %p, called by %p", nmemb, size, res,
 						  caller_return_address ());
   return res;
@@ -116,9 +143,11 @@ posix_memalign (void **memptr, size_t alignment, size_t bytes)
     return user_data->posix_memalign (memptr, alignment, bytes);
   if ((alignment & (alignment - 1)) != 0)
     return EINVAL;
-  __malloc_lock ();
+#if MSPACES
+  res = mspace_memalign (MSPACE, alignment, bytes);
+#else
   res = dlmemalign (alignment, bytes);
-  __malloc_unlock ();
+#endif
   if (!res)
     return ENOMEM;
   *memptr = res;
@@ -135,11 +164,11 @@ memalign (size_t alignment, size_t bytes)
       res = NULL;
     }
   else
-    {
-      __malloc_lock ();
-      res = dlmemalign (alignment, bytes);
-      __malloc_unlock ();
-    }
+#if MSPACES
+    res = mspace_memalign (MSPACE, alignment, bytes);
+#else
+    res = dlmemalign (alignment, bytes);
+#endif
 
   return res;
 }
@@ -154,11 +183,11 @@ valloc (size_t bytes)
       res = NULL;
     }
   else
-    {
-      __malloc_lock ();
-      res = dlvalloc (bytes);
-      __malloc_unlock ();
-    }
+#if MSPACES
+    res = mspace_valloc (MSPACE, bytes);
+#else
+    res = dlvalloc (bytes);
+#endif
 
   return res;
 }
@@ -173,11 +202,11 @@ malloc_usable_size (void *p)
       res = 0;
     }
   else
-    {
-      __malloc_lock ();
-      res = dlmalloc_usable_size (p);
-      __malloc_unlock ();
-    }
+#if MSPACES
+    res = memspace_usable_size (p);
+#else
+    res = dlmalloc_usable_size (p);
+#endif
 
   return res;
 }
@@ -192,11 +221,11 @@ malloc_trim (size_t pad)
       res = 0;
     }
   else
-    {
-      __malloc_lock ();
-      res = dlmalloc_trim (pad);
-      __malloc_unlock ();
-    }
+#if MSPACES
+    res = mspace_trim (MSPACE, pad);
+#else
+    res = dlmalloc_trim (pad);
+#endif
 
   return res;
 }
@@ -211,11 +240,11 @@ mallopt (int p, int v)
       res = 0;
     }
   else
-    {
-      __malloc_lock ();
-      res = dlmallopt (p, v);
-      __malloc_unlock ();
-    }
+#if MSPACES
+    res = mspace_mallopt (p, v);
+#else
+    res = dlmallopt (p, v);
+#endif
 
   return res;
 }
@@ -226,11 +255,11 @@ malloc_stats ()
   if (!use_internal)
     set_errno (ENOSYS);
   else
-    {
-      __malloc_lock ();
-      dlmalloc_stats ();
-      __malloc_unlock ();
-    }
+#if MSPACES
+    memspace_stats (MSPACE);
+#else
+    dlmalloc_stats ();
+#endif
 }
 
 extern "C" struct mallinfo
@@ -243,11 +272,11 @@ mallinfo ()
       set_errno (ENOSYS);
     }
   else
-    {
-      __malloc_lock ();
-      m = dlmallinfo ();
-      __malloc_unlock ();
-    }
+#if MSPACES
+    m = mspace_mallinfo (MSPACE);
+#else
+    m = dlmallinfo ();
+#endif
 
   return m;
 }
@@ -262,20 +291,9 @@ strdup (const char *s)
   return p;
 }
 
-/* We use a critical section to lock access to the malloc data
-   structures.  This permits malloc to be called from different
-   threads.  Note that it does not make malloc reentrant, and it does
-   not permit a signal handler to call malloc.  The malloc code in
-   newlib will call __malloc_lock and __malloc_unlock at appropriate
-   times.  */
-
-muto NO_COPY mallock;
-
 void
 malloc_init ()
 {
-  mallock.init ("mallock");
-
   /* Check if malloc is provided by application. If so, redirect all
      calls to malloc/free/realloc to application provided. This may
      happen if some other dll calls cygwin's malloc, but main code provides
@@ -290,6 +308,15 @@ malloc_init ()
       malloc_printf ("using %s malloc", use_internal ? "internal" : "external");
       internal_malloc_determined = true;
     }
+
+#if MSPACES
+  if (use_internal)
+    {
+      tls_mspace = TlsAlloc ();
+      if (tls_mspace == 0)
+        api_fatal ("malloc_init couldn't init tls_mspace");
+    }
+#endif
 }
 
 extern "C" void
-- 
2.28.0


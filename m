Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 78C163857C65
 for <cygwin-patches@cygwin.com>; Tue, 22 Dec 2020 04:54:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 78C163857C65
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 0BM4s8JZ053994;
 Mon, 21 Dec 2020 20:54:08 -0800 (PST) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdrbfCzB; Mon Dec 21 20:53:59 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Interim malloc speedup
Date: Mon, 21 Dec 2020 20:53:48 -0800
Message-Id: <20201222045348.10562-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Tue, 22 Dec 2020 04:54:12 -0000

Replaces function-level lock with data-level lock provided by existing
dlmalloc.  Sets up to enable dlmalloc's MSPACES, but does not yet enable
them due to visible but uninvestigated issues.

Single-thread applications may or may not see a performance gain,
depending on how heavily it uses the malloc functions.  Multi-thread
apps will likely see a performance gain.

---
 winsup/cygwin/cygmalloc.h       |  28 +++-
 winsup/cygwin/fork.cc           |   8 -
 winsup/cygwin/malloc_wrapper.cc | 274 +++++++++++++++++++++-----------
 3 files changed, 202 insertions(+), 108 deletions(-)

diff --git a/winsup/cygwin/cygmalloc.h b/winsup/cygwin/cygmalloc.h
index 84bad824c..67a9f3b3f 100644
--- a/winsup/cygwin/cygmalloc.h
+++ b/winsup/cygwin/cygmalloc.h
@@ -26,20 +26,36 @@ void dlmalloc_stats ();
 #define MALLOC_ALIGNMENT ((size_t)16U)
 #endif
 
+/* As of Cygwin 3.2.0 we could enable dlmalloc's MSPACES */
+#define MSPACES 0 // DO NOT ENABLE: cygserver, XWin, etc will malfunction
+
 #if defined (DLMALLOC_VERSION)	/* Building malloc.cc */
 
 extern "C" void __set_ENOMEM ();
 void *mmap64 (void *, size_t, int, int, int, off_t);
 # define mmap mmap64
+
+/* These defines tune the dlmalloc implementation in malloc.cc */
 # define MALLOC_FAILURE_ACTION	__set_ENOMEM ()
 # define USE_DL_PREFIX 1
+# define USE_LOCKS 1
+# define LOCK_AT_FORK 0
+# define FOOTERS MSPACES
+#endif
 
-#elif defined (__INSIDE_CYGWIN__)
-
-# define __malloc_lock() mallock.acquire ()
-# define __malloc_unlock() mallock.release ()
-extern muto mallock;
-
+#if MSPACES
+# define MSPACE_SIZE (512 * 1024)
+void __reg2 *create_mspace (size_t, int);
+void __reg2 mspace_free (void *m, void *p);
+void __reg2 *mspace_malloc (void *m, size_t size);
+void __reg3 *mspace_realloc (void *m, void *p, size_t size);
+void __reg3 *mspace_calloc (void *m, size_t nmemb, size_t size);
+void __reg3 *mspace_memalign (void *m, size_t alignment, size_t bytes);
+size_t __reg1 mspace_usable_size (const void *p);
+int __reg2 mspace_trim (void *m, size_t);
+int __reg2 mspace_mallopt (int p, int v);
+void __reg1 mspace_malloc_stats (void *m);
+struct mallinfo mspace_mallinfo (void *m);
 #endif
 
 #ifdef __cplusplus
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 719217856..8f9ca45d1 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -22,7 +22,6 @@ details. */
 #include "tls_pbuf.h"
 #include "shared_info.h"
 #include "dll_init.h"
-#include "cygmalloc.h"
 #include "ntdll.h"
 
 #define NPIDS_HELD 4
@@ -296,8 +295,6 @@ frok::parent (volatile char * volatile stack_here)
   si.lpReserved2 = (LPBYTE) &ch;
   si.cbReserved2 = sizeof (ch);
 
-  bool locked = __malloc_lock ();
-
   /* Remove impersonation */
   cygheap->user.deimpersonate ();
   fix_impersonation = true;
@@ -448,9 +445,6 @@ frok::parent (volatile char * volatile stack_here)
 		   "stack", stack_here, ch.stackbase,
 		   impure, impure_beg, impure_end,
 		   NULL);
-
-  __malloc_unlock ();
-  locked = false;
   if (!rc)
     {
       this_errno = get_errno ();
@@ -533,8 +527,6 @@ cleanup:
 
   if (fix_impersonation)
     cygheap->user.reimpersonate ();
-  if (locked)
-    __malloc_unlock ();
 
   /* Remember to de-allocate the fd table. */
   if (hchild)
diff --git a/winsup/cygwin/malloc_wrapper.cc b/winsup/cygwin/malloc_wrapper.cc
index 3b245800a..51dbf8a59 100644
--- a/winsup/cygwin/malloc_wrapper.cc
+++ b/winsup/cygwin/malloc_wrapper.cc
@@ -27,6 +27,34 @@ extern "C" struct mallinfo dlmallinfo ();
 static bool use_internal = true;
 static bool internal_malloc_determined;
 
+#if MSPACES
+/* If mspaces (thread-specific memory pools) are enabled, use a thread-
+   local variable to store a pointer to the calling thread's mspace.
+
+   On any use of a malloc-family function, if the appropriate mspace cannot
+   be determined, the general (non-mspace) form of the corresponding malloc
+   function is substituted.  This is not expected to happen often.
+*/
+static NO_COPY DWORD tls_mspace; // index into thread's TLS array
+
+static void *
+get_current_mspace ()
+{
+  if (unlikely (tls_mspace == 0))
+    return 0;
+
+  void *m = TlsGetValue (tls_mspace);
+  if (unlikely (m == 0))
+    {
+      m = create_mspace (MSPACE_SIZE, 0);
+      if (!m)
+        return 0;
+      TlsSetValue (tls_mspace, m);
+    }
+  return m;
+}
+#endif
+
 /* These routines are used by the application if it
    doesn't provide its own malloc. */
 
@@ -34,28 +62,40 @@ extern "C" void
 free (void *p)
 {
   malloc_printf ("(%p), called by %p", p, caller_return_address ());
-  if (!use_internal)
-    user_data->free (p);
-  else
+  if (likely (use_internal))
     {
-      __malloc_lock ();
+#if MSPACES
+      void *m = get_current_mspace ();
+      if (likely (m))
+	mspace_free (m, p);
+      else
+	dlfree (p);
+#else
       dlfree (p);
-      __malloc_unlock ();
+#endif
     }
+  else
+    user_data->free (p);
 }
 
 extern "C" void *
 malloc (size_t size)
 {
   void *res;
-  if (!use_internal)
-    res = user_data->malloc (size);
-  else
+  if (likely (use_internal))
     {
-      __malloc_lock ();
+#if MSPACES
+      void *m = get_current_mspace ();
+      if (likely (m))
+	res = mspace_malloc (m, size);
+      else
+	res = dlmalloc (size);
+#else
       res = dlmalloc (size);
-      __malloc_unlock ();
+#endif
     }
+  else
+    res = user_data->malloc (size);
   malloc_printf ("(%ld) = %p, called by %p", size, res,
 					     caller_return_address ());
   return res;
@@ -65,14 +105,20 @@ extern "C" void *
 realloc (void *p, size_t size)
 {
   void *res;
-  if (!use_internal)
-    res = user_data->realloc (p, size);
-  else
+  if (likely (use_internal))
     {
-      __malloc_lock ();
+#if MSPACES
+      void *m = get_current_mspace ();
+      if (likely (m))
+	res = mspace_realloc (m, p, size);
+      else
+        res = dlrealloc (p, size);
+#else
       res = dlrealloc (p, size);
-      __malloc_unlock ();
+#endif
     }
+  else
+    res = user_data->realloc (p, size);
   malloc_printf ("(%p, %ld) = %p, called by %p", p, size, res,
 						 caller_return_address ());
   return res;
@@ -93,14 +139,20 @@ extern "C" void *
 calloc (size_t nmemb, size_t size)
 {
   void *res;
-  if (!use_internal)
-    res = user_data->calloc (nmemb, size);
-  else
+  if (likely (use_internal))
     {
-      __malloc_lock ();
+#if MSPACES
+      void *m = get_current_mspace ();
+      if (likely (m))
+	res = mspace_calloc (m, nmemb, size);
+      else
+        res = dlcalloc (nmemb, size);
+#else
       res = dlcalloc (nmemb, size);
-      __malloc_unlock ();
+#endif
     }
+  else
+    res = user_data->calloc (nmemb, size);
   malloc_printf ("(%ld, %ld) = %p, called by %p", nmemb, size, res,
 						  caller_return_address ());
   return res;
@@ -109,38 +161,50 @@ calloc (size_t nmemb, size_t size)
 extern "C" int
 posix_memalign (void **memptr, size_t alignment, size_t bytes)
 {
-  save_errno save;
-
   void *res;
-  if (!use_internal)
+  if (likely (use_internal))
+    {
+      if ((alignment & (alignment - 1)) != 0)
+	return EINVAL;
+#if MSPACES
+      void *m = get_current_mspace ();
+      if (likely (m))
+	res = mspace_memalign (m, alignment, bytes);
+      else
+	res = dlmemalign (alignment, bytes);
+#else
+      res = dlmemalign (alignment, bytes);
+#endif
+      if (!res)
+	return ENOMEM;
+      *memptr = res;
+      return 0;
+    }
+  else
     return user_data->posix_memalign (memptr, alignment, bytes);
-  if ((alignment & (alignment - 1)) != 0)
-    return EINVAL;
-  __malloc_lock ();
-  res = dlmemalign (alignment, bytes);
-  __malloc_unlock ();
-  if (!res)
-    return ENOMEM;
-  *memptr = res;
-  return 0;
 }
 
 extern "C" void *
 memalign (size_t alignment, size_t bytes)
 {
   void *res;
-  if (!use_internal)
+  if (likely (use_internal))
     {
-      set_errno (ENOSYS);
-      res = NULL;
+#if MSPACES
+      void *m = get_current_mspace ();
+      if (likely (m))
+	res = mspace_memalign (m, alignment, bytes);
+      else
+        res = dlmemalign (alignment, bytes);
+#else
+      res = dlmemalign (alignment, bytes);
+#endif
     }
   else
     {
-      __malloc_lock ();
-      res = dlmemalign (alignment, bytes);
-      __malloc_unlock ();
+      set_errno (ENOSYS);
+      res = NULL;
     }
-
   return res;
 }
 
@@ -148,18 +212,28 @@ extern "C" void *
 valloc (size_t bytes)
 {
   void *res;
-  if (!use_internal)
+  if (likely (use_internal))
     {
-      set_errno (ENOSYS);
-      res = NULL;
+#if MSPACES
+      static size_t syspagesize = 0;
+      if (unlikely (syspagesize == 0))
+	syspagesize = wincap.allocation_granularity ();
+
+      /* there is no mspace_valloc(), so fake it with *memalign() */
+      void *m = get_current_mspace ();
+      if (likely (m))
+	res = mspace_memalign (m, syspagesize, bytes);
+      else
+	res = dlmemalign (syspagesize, bytes);
+#else
+      res = dlvalloc (bytes);
+#endif
     }
   else
     {
-      __malloc_lock ();
-      res = dlvalloc (bytes);
-      __malloc_unlock ();
+      set_errno (ENOSYS);
+      res = NULL;
     }
-
   return res;
 }
 
@@ -167,18 +241,17 @@ extern "C" size_t
 malloc_usable_size (void *p)
 {
   size_t res;
-  if (!use_internal)
+  if (likely (use_internal))
+#if MSPACES
+    res = mspace_usable_size (p);
+#else
+    res = dlmalloc_usable_size (p);
+#endif
+  else
     {
       set_errno (ENOSYS);
       res = 0;
     }
-  else
-    {
-      __malloc_lock ();
-      res = dlmalloc_usable_size (p);
-      __malloc_unlock ();
-    }
-
   return res;
 }
 
@@ -186,18 +259,23 @@ extern "C" int
 malloc_trim (size_t pad)
 {
   size_t res;
-  if (!use_internal)
+  if (likely (use_internal))
     {
-      set_errno (ENOSYS);
-      res = 0;
+#if MSPACES
+      void *m = get_current_mspace ();
+      if (likely (m))
+	res = mspace_trim (m, pad);
+      else
+        res = dlmalloc_trim (pad);
+#else
+      res = dlmalloc_trim (pad);
+#endif
     }
   else
     {
-      __malloc_lock ();
-      res = dlmalloc_trim (pad);
-      __malloc_unlock ();
+      set_errno (ENOSYS);
+      res = 0;
     }
-
   return res;
 }
 
@@ -205,51 +283,61 @@ extern "C" int
 mallopt (int p, int v)
 {
   int res;
-  if (!use_internal)
+  if (likely (use_internal))
+#if MSPACES
+    res = mspace_mallopt (p, v);
+#else
+    res = dlmallopt (p, v);
+#endif
+  else
     {
       set_errno (ENOSYS);
       res = 0;
     }
-  else
-    {
-      __malloc_lock ();
-      res = dlmallopt (p, v);
-      __malloc_unlock ();
-    }
-
   return res;
 }
 
 extern "C" void
 malloc_stats ()
 {
-  if (!use_internal)
-    set_errno (ENOSYS);
-  else
+  if (likely (use_internal))
     {
-      __malloc_lock ();
+#if MSPACES
+      void *m = get_current_mspace ();
+      if (likely (m))
+	mspace_malloc_stats (m);
+      else
+        dlmalloc_stats ();
+#else
       dlmalloc_stats ();
-      __malloc_unlock ();
+#endif
     }
+  else
+    set_errno (ENOSYS);
 }
 
 extern "C" struct mallinfo
 mallinfo ()
 {
-  struct mallinfo m;
-  if (!use_internal)
+  struct mallinfo mal;
+  if (likely (use_internal))
     {
-      memset (&m, 0, sizeof m);
-      set_errno (ENOSYS);
+#if MSPACES
+      void *m = get_current_mspace ();
+      if (likely (m))
+	mal = mspace_mallinfo (m);
+      else
+        mal = dlmallinfo ();
+#else
+      mal = dlmallinfo ();
+#endif
     }
   else
     {
-      __malloc_lock ();
-      m = dlmallinfo ();
-      __malloc_unlock ();
+      memset (&mal, 0, sizeof mal);
+      set_errno (ENOSYS);
     }
-
-  return m;
+  return mal;
 }
 
 extern "C" char *
@@ -262,20 +350,9 @@ strdup (const char *s)
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
@@ -290,6 +367,15 @@ malloc_init ()
       malloc_printf ("using %s malloc", use_internal ? "internal" : "external");
       internal_malloc_determined = true;
     }
+
+#if MSPACES
+  if (use_internal)
+    {
+      tls_mspace = TlsAlloc ();
+      if (tls_mspace == 0)
+	api_fatal ("malloc_init() couldn't init tls_mspace");
+    }
+#endif
 }
 
 extern "C" void
-- 
2.29.2


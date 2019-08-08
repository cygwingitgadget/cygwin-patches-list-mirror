Return-Path: <cygwin-patches-return-9553-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91337 invoked by alias); 8 Aug 2019 08:55:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91328 invoked by uid 89); 8 Aug 2019 08:55:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-66.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=3835, ceiling
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 08 Aug 2019 08:55:34 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N1feo-1iJc7M2kPo-011xV9; Thu, 08 Aug 2019 10:55:28 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AAC0BA80704; Thu,  8 Aug 2019 10:55:27 +0200 (CEST)
From: corinna-cygwin@cygwin.com
To: cygwin-patches@cygwin.com
Cc: Ken Brown <kbrown@cornell.edu>,	Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] Cygwin: shmat: use mmap allocator strategy on 64 bit
Date: Thu, 08 Aug 2019 08:55:00 -0000
Message-Id: <20190808085527.29002-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2019-q3/txt/msg00073.txt.bz2

From: Corinna Vinschen <corinna-cygwin@cygwin.com>

This avoids collisions of shmat maps with Windows own datastructures
when allocating top-down.

This patch moves the mmap_allocator class definition into its
own files and just uses it from mmap and shmat.
---
 winsup/cygwin/Makefile.in   |  1 +
 winsup/cygwin/mmap.cc       | 89 +------------------------------------
 winsup/cygwin/mmap_alloc.cc | 80 +++++++++++++++++++++++++++++++++
 winsup/cygwin/mmap_alloc.h  | 21 +++++++++
 winsup/cygwin/shm.cc        |  8 +++-
 5 files changed, 110 insertions(+), 89 deletions(-)
 create mode 100644 winsup/cygwin/mmap_alloc.cc
 create mode 100644 winsup/cygwin/mmap_alloc.h

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index b687d922db2e..ca0633eb8c1f 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -341,6 +341,7 @@ DLL_OFILES:= \
 	miscfuncs.o \
 	mktemp.o \
 	mmap.o \
+	mmap_alloc.o \
 	msg.o \
 	msgcat.o \
 	mount.o \
diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
index 797373742d29..d8ef037f092e 100644
--- a/winsup/cygwin/mmap.cc
+++ b/winsup/cygwin/mmap.cc
@@ -20,6 +20,7 @@ details. */
 #include "cygheap.h"
 #include "ntdll.h"
 #include <sys/queue.h>
+#include "mmap_alloc.h"
 
 /* __PROT_ATTACH indicates an anonymous mapping which is supposed to be
    attached to a file mapping for pages beyond the file's EOF.  The idea
@@ -798,94 +799,6 @@ mmap_worker (mmap_list *map_list, fhandler_base *fh, caddr_t base, size_t len,
   return base;
 }
 
-#ifdef __x86_64__
-
-/* The memory region used for memory maps */
-#define MMAP_STORAGE_LOW	0x001000000000L	/* Leave 32 Gigs for heap. */
-/* Up to Win 8 only supporting 44 bit address space, starting with Win 8.1
-   48 bit address space. */
-#define MMAP_STORAGE_HIGH	wincap.mmap_storage_high ()
-
-/* FIXME?  Unfortunately the OS doesn't support a top down allocation with
-	   a ceiling value.  The ZeroBits mechanism only works for
-	   NtMapViewOfSection and it only evaluates the high bit of ZeroBits
-	   on 64 bit, so it's pretty much useless for our purposes.
-
-	   If the below simple mechanism to perform top-down allocations
-	   turns out to be too dumb, we need something else.  One idea is to
-	   dived the space in (3835) 4 Gig chunks and simply store the
-	   available free space per slot.  Then we can go top down from slot
-	   to slot and only try slots which are supposed to have enough space.
-	   Bookkeeping would be very simple and fast. */
-class mmap_allocator
-{
-  caddr_t mmap_current_low;
-
-public:
-  mmap_allocator () : mmap_current_low ((caddr_t) MMAP_STORAGE_HIGH) {}
-
-  PVOID alloc (PVOID in_addr, SIZE_T in_size, bool fixed)
-  {
-    MEMORY_BASIC_INFORMATION mbi;
-
-    SIZE_T size = roundup2 (in_size, wincap.allocation_granularity ());
-    /* First check for the given address. */
-    if (in_addr)
-      {
-	/* If it points to a free area, big enough to fulfill the request,
-	   return the address. */
-	if (VirtualQuery (in_addr, &mbi, sizeof mbi)
-	    && mbi.State == MEM_FREE
-	    && mbi.RegionSize >= size)
-	  return in_addr;
-	/* Otherwise, if MAP_FIXED was given, give up. */
-	if (fixed)
-	  return NULL;
-	/* Otherwise, fall through to the usual free space search mechanism. */
-      }
-    /* Start with the last allocation start address - requested size. */
-    caddr_t addr = mmap_current_low - size;
-    bool merry_go_round = false;
-    do
-      {
-	/* Did we hit the lower ceiling?  If so, restart from the upper
-	   ceiling, but note that we did it. */
-	if (addr < (caddr_t) MMAP_STORAGE_LOW)
-	  {
-	    addr = (caddr_t) MMAP_STORAGE_HIGH - size;
-	    merry_go_round = true;
-	  }
-	/* Shouldn't fail, but better test. */
-	if (!VirtualQuery ((PVOID) addr, &mbi, sizeof mbi))
-	  return NULL;
-	/* If the region is free... */
-	if (mbi.State == MEM_FREE)
-	  {
-	    /* ...and the region is big enough to fulfill the request... */
-	    if (mbi.RegionSize >= size)
-	      {
-		/* ...note the address as next start address for our simple
-		   merry-go-round and return the address. */
-		mmap_current_low = addr;
-		return (PVOID) addr;
-	      }
-	    /* Otherwise, subtract what's missing in size and try again. */
-	    addr -= size - mbi.RegionSize;
-	  }
-	/* If the region isn't free, skip to address below AllocationBase
-	   and try again. */
-	else
-	  addr = (caddr_t) mbi.AllocationBase - size;
-      }
-    /* Repeat until we had a full ride on the merry_go_round. */
-    while (!merry_go_round || addr >= mmap_current_low);
-    return NULL;
-  }
-};
-
-static mmap_allocator mmap_alloc;	/* Inherited by forked child. */
-#endif
-
 extern "C" void *
 mmap64 (void *addr, size_t len, int prot, int flags, int fd, off_t off)
 {
diff --git a/winsup/cygwin/mmap_alloc.cc b/winsup/cygwin/mmap_alloc.cc
new file mode 100644
index 000000000000..5e084b61a7bc
--- /dev/null
+++ b/winsup/cygwin/mmap_alloc.cc
@@ -0,0 +1,80 @@
+#ifdef __x86_64__
+
+#include "winsup.h"
+#include "mmap_alloc.h"
+#include <sys/param.h>
+
+mmap_allocator mmap_alloc;	/* Inherited by forked child. */
+
+/* FIXME?  Unfortunately the OS doesn't support a top down allocation with
+	   a ceiling value.  The ZeroBits mechanism only works for
+	   NtMapViewOfSection and it only evaluates the high bit of ZeroBits
+	   on 64 bit, so it's pretty much useless for our purposes.
+
+	   If the below simple mechanism to perform top-down allocations
+	   turns out to be too dumb, we need something else.  One idea is to
+	   dived the space in (3835) 4 Gig chunks and simply store the
+	   available free space per slot.  Then we can go top down from slot
+	   to slot and only try slots which are supposed to have enough space.
+	   Bookkeeping would be very simple and fast. */
+PVOID
+mmap_allocator::alloc (PVOID in_addr, SIZE_T in_size, bool fixed)
+{
+  MEMORY_BASIC_INFORMATION mbi;
+
+  SIZE_T size = roundup2 (in_size, wincap.allocation_granularity ());
+  /* First check for the given address. */
+  if (in_addr)
+    {
+      /* If it points to a free area, big enough to fulfill the request,
+	 return the address. */
+      if (VirtualQuery (in_addr, &mbi, sizeof mbi)
+	  && mbi.State == MEM_FREE
+	  && mbi.RegionSize >= size)
+	return in_addr;
+      /* Otherwise, if MAP_FIXED was given, give up. */
+      if (fixed)
+	return NULL;
+      /* Otherwise, fall through to the usual free space search mechanism. */
+    }
+  /* Start with the last allocation start address - requested size. */
+  caddr_t addr = mmap_current_low - size;
+  bool merry_go_round = false;
+  do
+    {
+      /* Did we hit the lower ceiling?  If so, restart from the upper
+	 ceiling, but note that we did it. */
+      if (addr < (caddr_t) MMAP_STORAGE_LOW)
+	{
+	  addr = (caddr_t) MMAP_STORAGE_HIGH - size;
+	  merry_go_round = true;
+	}
+      /* Shouldn't fail, but better test. */
+      if (!VirtualQuery ((PVOID) addr, &mbi, sizeof mbi))
+	return NULL;
+      /* If the region is free... */
+      if (mbi.State == MEM_FREE)
+	{
+	  /* ...and the region is big enough to fulfill the request... */
+	  if (mbi.RegionSize >= size)
+	    {
+	      /* ...note the address as next start address for our simple
+		 merry-go-round and return the address. */
+	      mmap_current_low = addr;
+	      return (PVOID) addr;
+	    }
+	  /* Otherwise, subtract what's missing in size and try again. */
+	  addr -= size - mbi.RegionSize;
+	}
+      /* If the region isn't free, skip to address below AllocationBase
+	 and try again. */
+      else
+	addr = (caddr_t) mbi.AllocationBase - size;
+    }
+  /* Repeat until we had a full ride on the merry_go_round. */
+  while (!merry_go_round || addr >= mmap_current_low);
+  return NULL;
+}
+
+#endif
+
diff --git a/winsup/cygwin/mmap_alloc.h b/winsup/cygwin/mmap_alloc.h
new file mode 100644
index 000000000000..01c195d525f0
--- /dev/null
+++ b/winsup/cygwin/mmap_alloc.h
@@ -0,0 +1,21 @@
+#ifdef __x86_64__
+
+/* The memory region used for memory maps */
+#define MMAP_STORAGE_LOW	0x001000000000L	/* Leave 32 Gigs for heap. */
+/* Up to Win 8 only supporting 44 bit address space, starting with Win 8.1
+   48 bit address space. */
+#define MMAP_STORAGE_HIGH	wincap.mmap_storage_high ()
+
+class mmap_allocator
+{
+  caddr_t mmap_current_low;
+
+public:
+  mmap_allocator () : mmap_current_low ((caddr_t) MMAP_STORAGE_HIGH) {}
+
+  PVOID alloc (PVOID in_addr, SIZE_T in_size, bool fixed);
+};
+
+extern mmap_allocator mmap_alloc;
+
+#endif
diff --git a/winsup/cygwin/shm.cc b/winsup/cygwin/shm.cc
index 805a24b807f7..40d8dcb10a30 100644
--- a/winsup/cygwin/shm.cc
+++ b/winsup/cygwin/shm.cc
@@ -17,6 +17,7 @@ details. */
 #include "cygtls.h"
 #include "sync.h"
 #include "ntdll.h"
+#include "mmap_alloc.h"
 
 /* __getpagesize is only available from libcygwin.a */
 #undef SHMLBA
@@ -220,8 +221,13 @@ shmat (int shmid, const void *shmaddr, int shmflg)
       return (void *) -1;
     }
   NTSTATUS status;
-  vm_object_t ptr = NULL;
   SIZE_T viewsize = ssh_entry->size;
+#ifdef __x86_64__
+  vm_object_t ptr = mmap_alloc.alloc (NULL, viewsize, false);
+#else
+  vm_object_t ptr = NULL;
+#endif
+
   ULONG access = (shmflg & SHM_RDONLY) ? PAGE_READONLY : PAGE_READWRITE;
   status = NtMapViewOfSection (ssh_entry->hdl, NtCurrentProcess (), &ptr, 0,
 			       ssh_entry->size, NULL, &viewsize, ViewShare,
-- 
2.20.1

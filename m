Return-Path: <cygwin-patches-return-4910-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32594 invoked by alias); 21 Aug 2004 16:37:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32582 invoked from network); 21 Aug 2004 16:37:38 -0000
X-Authentication-Warning: router.local.rw-it.net: robert set sender to robert@rw-it.net using -f
Date: Sat, 21 Aug 2004 16:37:00 -0000
From: Robert Wruck <robert@rw-it.net>
To: cygwin-patches@cygwin.com
Subject: [patch] w32api winddk.h interlocked lists
Message-ID: <20040821163737.GA27228@router.local.rw-it.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-Key-ID: 1024D/E3930872, 2048g/A89F0979
X-PGP-Key-Fingerprint: 122B E9B5 F359 2BEF B2A9 B417 ADD4 9D07 E393 0872
X-PGP-Key-URL: http://www.rw-it.net/pubkey.asc
X-SW-Source: 2004-q3/txt/msg00062.txt.bz2


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1674

I reported this as a bug at the MinGW sf.net site, but it seems that w32api is maintained here.

winddk.h defines some functions inline (ExAllocateFromNPagedLookasideList, ExInterlockedPushEntrySList etc.).
The problem I have is that those inline functions use InterlockedPushEntrySList and InterlockedPopEntrySList which 
do not exist in Win2k ntoskrnl.exe.

So I created the attached patch which includes the following changes:

- Add #if that checks WINVER (I don't know a better approach) and uses the ExInterlockedPushEntrySList and 
ExInterlockedPopEntrySList exported by ntoskrnl.exe instead of inline versions (why are those defined as inline 
anyway?).

- Altered ExAllocateFromNPagedLookasideList and ExFreeToNPagedLookasideList to use ExInterlockedX #if WINVER <= 
0x0500.

- Since ExInterlockedX are now used in the inline functions, I moved the Ex..NPagedLookasideList definitions down so 
that ExInterlockedX is declared above them (otherwise the compiler won't call them as fastcall).


Another point I came across is that I had to put some functions in my .def file since those are not included in 
libntoskrnl.a:

- The device types are declared in winddk.h but not included:
   ExDesktopObjectType
   ExEventObjectType
   ExSemaphoreObjectType
   ExWindowStationObjectType
   IoAdapterObjectType
   IoDeviceHandlerObjectSize
   IoDeviceHandlerObjectType
   IoDeviceObjectType
   IoDriverObjectType
   IoFileObjectType
   LpcPortObjectType
   MmSectionObjectType
   SeTokenObjectType

- _snwprintf and related functions are not included

- KeSetTimerEx is not included

- ExInterlockedPushEntrySList and ExInterlockedPopEntrySList are not included


robert

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="winddk.h.patch"
Content-length: 5480

--- winddk.h.orig	Fri Sep 12 10:14:08 2003
+++ winddk.h	Sat Aug 21 17:54:28 2004
@@ -5039,37 +5039,6 @@
   IN PERESOURCE  Resource,
   IN BOOLEAN  Wait);
 
-static __inline PVOID
-ExAllocateFromNPagedLookasideList(
-  IN PNPAGED_LOOKASIDE_LIST  Lookaside)
-{
-	PVOID Entry;
-
-	Lookaside->TotalAllocates++;
-  Entry = InterlockedPopEntrySList(&Lookaside->ListHead);
-	if (Entry == NULL) {
-		Lookaside->AllocateMisses++;
-		Entry = (Lookaside->Allocate)(Lookaside->Type, Lookaside->Size, Lookaside->Tag);
-	}
-  return Entry;
-}
-
-static __inline PVOID
-ExAllocateFromPagedLookasideList(
-  IN PPAGED_LOOKASIDE_LIST  Lookaside)
-{
-  PVOID Entry;
-
-  Lookaside->TotalAllocates++;
-  Entry = InterlockedPopEntrySList(&Lookaside->ListHead);
-  if (Entry == NULL) {
-    Lookaside->AllocateMisses++;
-    Entry = (Lookaside->Allocate)(Lookaside->Type,
-      Lookaside->Size, Lookaside->Tag);
-  }
-  return Entry;
-}
-
 NTOSAPI
 PVOID
 DDKAPI
@@ -5170,37 +5139,6 @@
   IN PVOID  P,
   IN ULONG  Tag);
 
-#define ExQueryDepthSList(ListHead) QueryDepthSList(ListHead)
-
-static __inline VOID
-ExFreeToNPagedLookasideList(
-  IN PNPAGED_LOOKASIDE_LIST  Lookaside,
-  IN PVOID  Entry)
-{
-  Lookaside->TotalFrees++;
-	if (ExQueryDepthSList(&Lookaside->ListHead) >= Lookaside->Depth) {
-		Lookaside->FreeMisses++;
-		(Lookaside->Free)(Entry);
-  } else {
-		InterlockedPushEntrySList(&Lookaside->ListHead,
-      (PSLIST_ENTRY)Entry);
-	}
-}
-
-static __inline VOID
-ExFreeToPagedLookasideList(
-  IN PPAGED_LOOKASIDE_LIST  Lookaside,
-  IN PVOID  Entry)
-{
-  Lookaside->TotalFrees++;
-  if (ExQueryDepthSList(&Lookaside->ListHead) >= Lookaside->Depth) {
-    Lookaside->FreeMisses++;
-    (Lookaside->Free)(Entry);
-  } else {
-    InterlockedPushEntrySList(&Lookaside->ListHead, (PSLIST_ENTRY)Entry);
-  }
-}
-
 /*
  * ERESOURCE_THREAD
  * ExGetCurrentResourceThread(
@@ -5348,6 +5286,14 @@
   IN PSINGLE_LIST_ENTRY  ListHead,
   IN PKSPIN_LOCK  Lock);
 
+#if (WINVER <= 0x0500)	// Use ntoskrnl.exe exported function for Win2K
+NTOSAPI
+PSINGLE_LIST_ENTRY
+DDKFASTAPI
+ExInterlockedPopEntrySList(
+  IN PSLIST_HEADER  ListHead,
+  IN PKSPIN_LOCK  Lock);
+#else
 /*
  * PSINGLE_LIST_ENTRY
  * ExInterlockedPopEntrySList(
@@ -5357,6 +5303,7 @@
 #define ExInterlockedPopEntrySList(_ListHead, \
                                    _Lock) \
   InterlockedPopEntrySList(_ListHead)
+#endif
 
 NTOSAPI
 PSINGLE_LIST_ENTRY
@@ -5366,6 +5313,15 @@
   IN PSINGLE_LIST_ENTRY  ListEntry,
   IN PKSPIN_LOCK  Lock);
 
+#if (WINVER <= 0x0500)	// Use ntoskrnl.exe exported function for Win2K
+NTOSAPI
+PSINGLE_LIST_ENTRY
+DDKFASTAPI
+ExInterlockedPushEntrySList(
+  IN PSLIST_HEADER  ListHead,
+  IN PSINGLE_LIST_ENTRY  ListEntry,
+  IN PKSPIN_LOCK  Lock);
+#else
 /*
  * PSINGLE_LIST_ENTRY FASTCALL
  * ExInterlockedPushEntrySList(
@@ -5377,6 +5333,7 @@
                                     _ListEntry, \
                                     _Lock) \
   InterlockedPushEntrySList(_ListHead, _ListEntry)
+#endif
 
 NTOSAPI
 PLIST_ENTRY
@@ -5384,6 +5341,99 @@
 ExInterlockedRemoveHeadList(
   IN PLIST_ENTRY  ListHead,
   IN PKSPIN_LOCK  Lock);
+
+// Moved down ...
+static __inline PVOID
+ExAllocateFromNPagedLookasideList(
+  IN PNPAGED_LOOKASIDE_LIST  Lookaside)
+{
+	PVOID Entry;
+
+    Lookaside->TotalAllocates++;
+#if (WINVER <= 0x0500)
+  Entry = ExInterlockedPopEntrySList(&Lookaside->ListHead, &Lookaside->Obsoleted);
+#else
+  Entry = InterlockedPopEntrySList(&Lookaside->ListHead);
+#endif
+	if (Entry == NULL) {
+		Lookaside->AllocateMisses++;
+		Entry = (Lookaside->Allocate)(Lookaside->Type, Lookaside->Size, Lookaside->Tag);
+	}
+
+  return Entry;
+}
+
+#if (WINVER <= 0x0500)	// Use ntoskrnl.exe exported function for Win2K
+NTOSAPI
+PVOID
+DDKAPI
+ExAllocateFromPagedLookasideList(
+  IN PPAGED_LOOKASIDE_LIST  Lookaside);
+#else
+static __inline PVOID
+ExAllocateFromPagedLookasideList(
+  IN PPAGED_LOOKASIDE_LIST  Lookaside)
+{
+  PVOID Entry;
+
+  Lookaside->TotalAllocates++;
+  Entry = InterlockedPopEntrySList(&Lookaside->ListHead);
+  if (Entry == NULL) {
+    Lookaside->AllocateMisses++;
+    Entry = (Lookaside->Allocate)(Lookaside->Type,
+      Lookaside->Size, Lookaside->Tag);
+  }
+  return Entry;
+}
+#endif
+
+#define ExQueryDepthSList(ListHead) QueryDepthSList(ListHead)
+
+static __inline VOID
+ExFreeToNPagedLookasideList(
+  IN PNPAGED_LOOKASIDE_LIST  Lookaside,
+  IN PVOID  Entry)
+{
+  Lookaside->TotalFrees++;
+	if (ExQueryDepthSList(&Lookaside->ListHead) >= Lookaside->Depth) {
+		Lookaside->FreeMisses++;
+		(Lookaside->Free)(Entry);
+  } else {
+#if (WINVER <= 0x0500)
+        ExInterlockedPushEntrySList(&Lookaside->ListHead,
+                                    (PSINGLE_LIST_ENTRY)Entry,
+                                    &Lookaside->Obsoleted);
+#else
+		InterlockedPushEntrySList(&Lookaside->ListHead,
+      (PSLIST_ENTRY)Entry);
+#endif
+	}
+}
+
+#if (WINVER <= 0x0500)	// Use ntoskrnl.exe exported function for Win2K
+NTOSAPI
+VOID
+DDKAPI
+ExFreeToPagedLookasideList(
+  IN PPAGED_LOOKASIDE_LIST  Lookaside,
+  IN PVOID  Entry);
+#else
+static __inline VOID
+ExFreeToPagedLookasideList(
+  IN PPAGED_LOOKASIDE_LIST  Lookaside,
+  IN PVOID  Entry)
+{
+  Lookaside->TotalFrees++;
+  if (ExQueryDepthSList(&Lookaside->ListHead) >= Lookaside->Depth) {
+    Lookaside->FreeMisses++;
+    (Lookaside->Free)(Entry);
+  } else {
+    InterlockedPushEntrySList(&Lookaside->ListHead, (PSLIST_ENTRY)Entry);
+  }
+}
+#endif
+
+// End
 
 NTOSAPI
 BOOLEAN

--vkogqOf2sHV7VnPd--

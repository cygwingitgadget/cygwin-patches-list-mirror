Return-Path: <cygwin-patches-return-9596-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79096 invoked by alias); 4 Sep 2019 01:45:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79014 invoked by uid 89); 4 Sep 2019 01:45:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=kernel32dll, UD:kernel32.dll, kernel32.dll, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 01:45:23 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x841iibH012450;	Wed, 4 Sep 2019 10:45:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x841iibH012450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567561519;	bh=Aq6JDSQ1U5hxUAkEp1gMKIsofx6Y4FKBzEybFbm8FzI=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=iKWO6K8TuNp0vGQJdjPi7L6rRtWrHg8CJu/BeAJVaAg6Vtf+/GQmErOi6jlRJPVgH	 rr7LMnXqIGqPji+xsWgv16c0Z1pQjqnpRd2vJL6JP+UyQPAN2axUUd3VU+WA4nd0mB	 ruLiW/S+TL9BJS4TP+ALbviW6V7sZyo9VTSAQQ9N9qpkQHD07RPuStyhw22gXg16Gy	 ij/8WmBiG+LBH63+lt1QAwRZwFSMZilnvUTSR6vgx6Vi3fEs5O9bS8E677bogCM+z7	 FtGbwV2LrKWyqLuCid2Lo2RwA1eUEgEP0h756tFc+oKb4hUHKpj7dQ916NRpHxqIYZ	 OzTRAzV4J2nGQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/4] Cygwin: pty: Move function hook_api() into hookapi.cc.
Date: Wed, 04 Sep 2019 01:45:00 -0000
Message-Id: <20190904014426.1284-4-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>
References: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00116.txt.bz2

- PTY uses Win32 API hook for pseudo console suppot. The function
  hook_api() is used for this purpose and defined in fhandler_tty.cc
  previously. This patch moves it into hookapi.cc.
---
 winsup/cygwin/fhandler_tty.cc | 44 -----------------------------------
 winsup/cygwin/hookapi.cc      | 34 +++++++++++++++++++++++++++
 winsup/cygwin/winsup.h        |  1 +
 3 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 94ef2f8d4..f76f7b262 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -75,50 +75,6 @@ static bool pcon_attached[NTTYS];
 static bool isHybrid;
 
 #if USE_API_HOOK
-/* Hook WIN32 API */
-static
-void *hook_api (const char *mname, const char *name, const void *fn)
-{
-  HMODULE hm = GetModuleHandle (mname);
-  PIMAGE_NT_HEADERS pExeNTHdr = PIMAGE_NT_HEADERS (PBYTE (hm)
-				   + PIMAGE_DOS_HEADER (hm)->e_lfanew);
-  DWORD importRVA = pExeNTHdr->OptionalHeader.DataDirectory
-    [IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;
-  PIMAGE_IMPORT_DESCRIPTOR pdfirst =
-    (PIMAGE_IMPORT_DESCRIPTOR) ((char *) hm + importRVA);
-  for (PIMAGE_IMPORT_DESCRIPTOR pd = pdfirst; pd->FirstThunk; pd++)
-    {
-      if (pd->OriginalFirstThunk == 0)
-	continue;
-      PIMAGE_THUNK_DATA pt =
-	(PIMAGE_THUNK_DATA) ((char *) hm + pd->FirstThunk);
-      PIMAGE_THUNK_DATA pn =
-	(PIMAGE_THUNK_DATA) ((char *) hm + pd->OriginalFirstThunk);
-      for (PIMAGE_THUNK_DATA pi = pt; pn->u1.Ordinal; pi++, pn++)
-	{
-	  if (IMAGE_SNAP_BY_ORDINAL (pn->u1.Ordinal))
-	    continue;
-	  PIMAGE_IMPORT_BY_NAME pimp =
-	    (PIMAGE_IMPORT_BY_NAME) ((char *) hm + pn->u1.AddressOfData);
-	  if (strcmp (name, (char *) pimp->Name) != 0)
-	    continue;
-#ifdef __x86_64__
-#define THUNK_FUNC_TYPE ULONGLONG
-#else
-#define THUNK_FUNC_TYPE DWORD
-#endif
-	  DWORD ofl = PAGE_READWRITE;
-	  if (!VirtualProtect (pi, sizeof (THUNK_FUNC_TYPE), ofl, &ofl))
-	    return NULL;
-	  void *origfn = (void *) pi->u1.Function;
-	  pi->u1.Function = (THUNK_FUNC_TYPE) fn;
-	  VirtualProtect (pi, sizeof (THUNK_FUNC_TYPE), ofl, &ofl);
-	  return origfn;
-	}
-    }
-  return NULL;
-}
-
 static void
 set_switch_to_pcon (void)
 {
diff --git a/winsup/cygwin/hookapi.cc b/winsup/cygwin/hookapi.cc
index 4078e65bd..dcd9b1df8 100644
--- a/winsup/cygwin/hookapi.cc
+++ b/winsup/cygwin/hookapi.cc
@@ -428,6 +428,40 @@ hook_or_detect_cygwin (const char *name, const void *fn, WORD& subsys, HANDLE h)
   return fh.origfn;
 }
 
+/* Hook a function in any DLL such as kernel32.dll */
+/* The DLL must be loaded in advance. */
+/* Used in fhandler_tty.cc */
+void *hook_api (const char *mname, const char *name, const void *fn)
+{
+  HMODULE hm = GetModuleHandle (mname);
+  PIMAGE_NT_HEADERS pExeNTHdr =
+    rva (PIMAGE_NT_HEADERS, hm, PIMAGE_DOS_HEADER (hm)->e_lfanew);
+  DWORD importRVA = pExeNTHdr->OptionalHeader.DataDirectory
+    [IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;
+  PIMAGE_IMPORT_DESCRIPTOR pdfirst =
+    rva (PIMAGE_IMPORT_DESCRIPTOR, hm, importRVA);
+  for (PIMAGE_IMPORT_DESCRIPTOR pd = pdfirst; pd->FirstThunk; pd++)
+    {
+      if (pd->OriginalFirstThunk == 0)
+	continue;
+      PIMAGE_THUNK_DATA pt = rva (PIMAGE_THUNK_DATA, hm, pd->FirstThunk);
+      PIMAGE_THUNK_DATA pn =
+	rva (PIMAGE_THUNK_DATA, hm, pd->OriginalFirstThunk);
+      for (PIMAGE_THUNK_DATA pi = pt; pn->u1.Ordinal; pi++, pn++)
+	{
+	  if (IMAGE_SNAP_BY_ORDINAL (pn->u1.Ordinal))
+	    continue;
+	  PIMAGE_IMPORT_BY_NAME pimp =
+	    rva (PIMAGE_IMPORT_BY_NAME, hm, pn->u1.AddressOfData);
+	  if (strcmp (name, (char *) pimp->Name) != 0)
+	    continue;
+	  void *origfn = putmem (pi, fn);
+	  return origfn;
+	}
+    }
+  return NULL;
+}
+
 void
 ld_preload ()
 {
diff --git a/winsup/cygwin/winsup.h b/winsup/cygwin/winsup.h
index 95ab41e6b..ab7b3bbdc 100644
--- a/winsup/cygwin/winsup.h
+++ b/winsup/cygwin/winsup.h
@@ -199,6 +199,7 @@ ino_t __reg2 hash_path_name (ino_t hash, const char *name);
 void __reg2 nofinalslash (const char *src, char *dst);
 
 void __reg3 *hook_or_detect_cygwin (const char *, const void *, WORD&, HANDLE h = NULL);
+void __reg3 *hook_api (const char *mname, const char *name, const void *fn);
 
 /* Time related */
 void __stdcall totimeval (struct timeval *, PLARGE_INTEGER, int, int);
-- 
2.21.0

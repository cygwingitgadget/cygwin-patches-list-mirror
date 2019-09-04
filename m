Return-Path: <cygwin-patches-return-9618-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62778 invoked by alias); 4 Sep 2019 13:47:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62703 invoked by uid 89); 4 Sep 2019 13:47:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=1006
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 13:47:19 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x84DkqTa014967;	Wed, 4 Sep 2019 22:47:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x84DkqTa014967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567604821;	bh=eejnc0t3EyrmDThZLE0pWkrDi4ZEq3RxjqMtAOZ8v/c=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=vnD+0DtUVPbyYPm2wS2PUV978PGiQ89I8XB5tO+oSmERGWX9QmRdl9+SESpXlm5au	 D11Nb9bcfcF5u+8hR33YMLGcjDYQaUkWAAFUSeqDxEYheq52ZhuE1Mbp/aJ3D8SZ9e	 yv4aCb1gSbjrM+HMY8e4ddxslfP7AYOVjEj2KQN7DyKez9e+o7olXi1NYWSPrl3JPp	 R+QKj09NHeTb1bgF4lExsB5yZz2lVB/Xky9x/wiTeQmdUumYS/wS07LuAf7+nYQXMD	 PRxhT9d34FFSrrj0qRLrZPAwpECWs2Kw0vREAWUOCchxTpvGf/QOrXH/XeIEJ7Rzq1	 YsVSZ7bDtVWbQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/1] Cygwin: pty: Limit API hook to the program linked with the APIs.
Date: Wed, 04 Sep 2019 13:47:00 -0000
Message-Id: <20190904134651.1750-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190904134651.1750-1-takashi.yano@nifty.ne.jp>
References: <20190904134651.1750-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00138.txt.bz2

- API hook used for pseudo console support causes slow down.
  This patch limits API hook to only program which is linked
  with the corresponding APIs. Normal cygwin program is not
  linked with such APIs (such as WriteFile, etc...) directly,
  therefore, no slow down occurs. However, console access by
  cygwin.dll itself cannot switch the r/w pipe to pseudo console
  side. Therefore, the code to switch it forcely to pseudo
  console side is added to smallprint.cc and strace.cc.
---
 winsup/cygwin/fhandler_tty.cc | 106 +++++++++++++++++++---------------
 winsup/cygwin/smallprint.cc   |   2 +
 winsup/cygwin/strace.cc       |  26 +--------
 winsup/cygwin/winsup.h        |   3 +
 4 files changed, 66 insertions(+), 71 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 262c41bfe..fadff59a3 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -88,6 +88,19 @@ set_switch_to_pcon (void)
       }
 }
 
+void
+set_ishybrid_and_switch_to_pcon (HANDLE h)
+{
+  DWORD dummy;
+  if (!isHybrid
+      && GetFileType (h) == FILE_TYPE_CHAR
+      && GetConsoleMode (h, &dummy))
+    {
+      isHybrid = true;
+      set_switch_to_pcon ();
+    }
+}
+
 #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
 DEF_HOOK (WriteFile);
 DEF_HOOK (WriteConsoleA);
@@ -100,6 +113,7 @@ DEF_HOOK (WriteConsoleOutputW);
 DEF_HOOK (WriteConsoleOutputCharacterA);
 DEF_HOOK (WriteConsoleOutputCharacterW);
 DEF_HOOK (WriteConsoleOutputAttribute);
+DEF_HOOK (SetConsoleTextAttribute);
 DEF_HOOK (WriteConsoleInputA);
 DEF_HOOK (WriteConsoleInputW);
 DEF_HOOK (ReadConsoleInputA);
@@ -107,140 +121,137 @@ DEF_HOOK (ReadConsoleInputW);
 DEF_HOOK (PeekConsoleInputA);
 DEF_HOOK (PeekConsoleInputW);
 
-#define CHK_CONSOLE_ACCESS(h) \
-{ \
-  DWORD dummy; \
-  if (!isHybrid \
-      && GetFileType (h) == FILE_TYPE_CHAR \
-      && GetConsoleMode (h, &dummy)) \
-    { \
-      isHybrid = true; \
-      set_switch_to_pcon (); \
-    } \
-}
 static BOOL WINAPI
 WriteFile_Hooked
      (HANDLE h, LPCVOID p, DWORD l, LPDWORD n, LPOVERLAPPED o)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteFile_Orig (h, p, l, n, o);
 }
 static BOOL WINAPI
 WriteConsoleA_Hooked
      (HANDLE h, LPCVOID p, DWORD l, LPDWORD n, LPVOID o)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteConsoleA_Orig (h, p, l, n, o);
 }
 static BOOL WINAPI
 WriteConsoleW_Hooked
      (HANDLE h, LPCVOID p, DWORD l, LPDWORD n, LPVOID o)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteConsoleW_Orig (h, p, l, n, o);
 }
 static BOOL WINAPI
 ReadFile_Hooked
      (HANDLE h, LPVOID p, DWORD l, LPDWORD n, LPOVERLAPPED o)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return ReadFile_Orig (h, p, l, n, o);
 }
 static BOOL WINAPI
 ReadConsoleA_Hooked
      (HANDLE h, LPVOID p, DWORD l, LPDWORD n, LPVOID o)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return ReadConsoleA_Orig (h, p, l, n, o);
 }
 static BOOL WINAPI
 ReadConsoleW_Hooked
      (HANDLE h, LPVOID p, DWORD l, LPDWORD n, LPVOID o)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return ReadConsoleW_Orig (h, p, l, n, o);
 }
 static BOOL WINAPI
 WriteConsoleOutputA_Hooked
      (HANDLE h, CONST CHAR_INFO *p, COORD s, COORD c, PSMALL_RECT r)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteConsoleOutputA_Orig (h, p, s, c, r);
 }
 static BOOL WINAPI
 WriteConsoleOutputW_Hooked
      (HANDLE h, CONST CHAR_INFO *p, COORD s, COORD c, PSMALL_RECT r)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteConsoleOutputW_Orig (h, p, s, c, r);
 }
 static BOOL WINAPI
 WriteConsoleOutputCharacterA_Hooked
      (HANDLE h, LPCSTR p, DWORD l, COORD c, LPDWORD n)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteConsoleOutputCharacterA_Orig (h, p, l, c, n);
 }
 static BOOL WINAPI
 WriteConsoleOutputCharacterW_Hooked
      (HANDLE h, LPCWSTR p, DWORD l, COORD c, LPDWORD n)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteConsoleOutputCharacterW_Orig (h, p, l, c, n);
 }
 static BOOL WINAPI
 WriteConsoleOutputAttribute_Hooked
      (HANDLE h, CONST WORD *a, DWORD l, COORD c, LPDWORD n)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteConsoleOutputAttribute_Orig (h, a, l, c, n);
 }
 static BOOL WINAPI
+SetConsoleTextAttribute_Hooked
+     (HANDLE h, WORD a)
+{
+  set_ishybrid_and_switch_to_pcon (h);
+  return SetConsoleTextAttribute_Orig (h, a);
+}
+static BOOL WINAPI
 WriteConsoleInputA_Hooked
      (HANDLE h, CONST INPUT_RECORD *r, DWORD l, LPDWORD n)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteConsoleInputA_Orig (h, r, l, n);
 }
 static BOOL WINAPI
 WriteConsoleInputW_Hooked
      (HANDLE h, CONST INPUT_RECORD *r, DWORD l, LPDWORD n)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return WriteConsoleInputW_Orig (h, r, l, n);
 }
 static BOOL WINAPI
 ReadConsoleInputA_Hooked
      (HANDLE h, PINPUT_RECORD r, DWORD l, LPDWORD n)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return ReadConsoleInputA_Orig (h, r, l, n);
 }
 static BOOL WINAPI
 ReadConsoleInputW_Hooked
      (HANDLE h, PINPUT_RECORD r, DWORD l, LPDWORD n)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return ReadConsoleInputW_Orig (h, r, l, n);
 }
 static BOOL WINAPI
 PeekConsoleInputA_Hooked
      (HANDLE h, PINPUT_RECORD r, DWORD l, LPDWORD n)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return PeekConsoleInputA_Orig (h, r, l, n);
 }
 static BOOL WINAPI
 PeekConsoleInputW_Hooked
      (HANDLE h, PINPUT_RECORD r, DWORD l, LPDWORD n)
 {
-  CHK_CONSOLE_ACCESS (h);
+  set_ishybrid_and_switch_to_pcon (h);
   return PeekConsoleInputW_Orig (h, r, l, n);
 }
 #else /* USE_API_HOOK */
 #define WriteFile_Orig 0
 #define ReadFile_Orig 0
 #define PeekConsoleInputA_Orig 0
+void set_ishybrid_and_switch_to_pcon (void) {}
 #endif /* USE_API_HOOK */
 
 bool
@@ -2871,25 +2882,26 @@ fhandler_pty_slave::fixup_after_exec ()
 	{ \
 	  void *api = hook_api (module, #name, (void *) name##_Hooked); \
 	  name##_Orig = (__typeof__ (name) *) api; \
-	  if (!api) system_printf("Hooking " #name " failed."); \
-	}
-      DO_HOOK ("kernel32.dll", WriteFile);
-      DO_HOOK ("kernel32.dll", WriteConsoleA);
-      DO_HOOK ("kernel32.dll", WriteConsoleW);
-      DO_HOOK ("kernel32.dll", ReadFile);
-      DO_HOOK ("kernel32.dll", ReadConsoleA);
-      DO_HOOK ("kernel32.dll", ReadConsoleW);
-      DO_HOOK ("kernel32.dll", WriteConsoleOutputA);
-      DO_HOOK ("kernel32.dll", WriteConsoleOutputW);
-      DO_HOOK ("kernel32.dll", WriteConsoleOutputCharacterA);
-      DO_HOOK ("kernel32.dll", WriteConsoleOutputCharacterW);
-      DO_HOOK ("kernel32.dll", WriteConsoleOutputAttribute);
-      DO_HOOK ("kernel32.dll", WriteConsoleInputA);
-      DO_HOOK ("kernel32.dll", WriteConsoleInputW);
-      DO_HOOK ("kernel32.dll", ReadConsoleInputA);
-      DO_HOOK ("kernel32.dll", ReadConsoleInputW);
-      DO_HOOK ("kernel32.dll", PeekConsoleInputA);
-      DO_HOOK ("kernel32.dll", PeekConsoleInputW);
+	  /*if (api) system_printf(#name " hooked.");*/ \
+	}
+      DO_HOOK (NULL, WriteFile);
+      DO_HOOK (NULL, WriteConsoleA);
+      DO_HOOK (NULL, WriteConsoleW);
+      DO_HOOK (NULL, ReadFile);
+      DO_HOOK (NULL, ReadConsoleA);
+      DO_HOOK (NULL, ReadConsoleW);
+      DO_HOOK (NULL, WriteConsoleOutputA);
+      DO_HOOK (NULL, WriteConsoleOutputW);
+      DO_HOOK (NULL, WriteConsoleOutputCharacterA);
+      DO_HOOK (NULL, WriteConsoleOutputCharacterW);
+      DO_HOOK (NULL, WriteConsoleOutputAttribute);
+      DO_HOOK (NULL, SetConsoleTextAttribute);
+      DO_HOOK (NULL, WriteConsoleInputA);
+      DO_HOOK (NULL, WriteConsoleInputW);
+      DO_HOOK (NULL, ReadConsoleInputA);
+      DO_HOOK (NULL, ReadConsoleInputW);
+      DO_HOOK (NULL, PeekConsoleInputA);
+      DO_HOOK (NULL, PeekConsoleInputW);
     }
 #endif /* USE_API_HOOK */
 }
diff --git a/winsup/cygwin/smallprint.cc b/winsup/cygwin/smallprint.cc
index a7a19132b..9310b9313 100644
--- a/winsup/cygwin/smallprint.cc
+++ b/winsup/cygwin/smallprint.cc
@@ -405,6 +405,7 @@ small_printf (const char *fmt, ...)
   count = __small_vsprintf (buf, fmt, ap);
   va_end (ap);
 
+  set_ishybrid_and_switch_to_pcon (GetStdHandle (STD_ERROR_HANDLE));
   WriteFile (GetStdHandle (STD_ERROR_HANDLE), buf, count, &done, NULL);
   FlushFileBuffers (GetStdHandle (STD_ERROR_HANDLE));
 }
@@ -431,6 +432,7 @@ console_printf (const char *fmt, ...)
   count = __small_vsprintf (buf, fmt, ap);
   va_end (ap);
 
+  set_ishybrid_and_switch_to_pcon (console_handle);
   WriteFile (console_handle, buf, count, &done, NULL);
   FlushFileBuffers (console_handle);
 }
diff --git a/winsup/cygwin/strace.cc b/winsup/cygwin/strace.cc
index b1eb5f3e4..f0aef3a36 100644
--- a/winsup/cygwin/strace.cc
+++ b/winsup/cygwin/strace.cc
@@ -264,6 +264,7 @@ strace::vprntf (unsigned category, const char *func, const char *fmt, va_list ap
   if (category & _STRACE_SYSTEM)
     {
       DWORD done;
+      set_ishybrid_and_switch_to_pcon (GetStdHandle (STD_ERROR_HANDLE));
       WriteFile (GetStdHandle (STD_ERROR_HANDLE), buf, len, &done, 0);
       FlushFileBuffers (GetStdHandle (STD_ERROR_HANDLE));
       /* Make sure that the message shows up on the screen, too, since this is
@@ -275,34 +276,11 @@ strace::vprntf (unsigned category, const char *func, const char *fmt, va_list ap
 				 &sec_none, OPEN_EXISTING, 0, 0);
 	  if (h != INVALID_HANDLE_VALUE)
 	    {
+	      set_ishybrid_and_switch_to_pcon (h);
 	      WriteFile (h, buf, len, &done, 0);
 	      CloseHandle (h);
 	    }
 	}
-#if 1 /* Experimental code */
-      /* PTY with pseudo console cannot display data written to
-	 STD_ERROR_HANDLE (output_handle) if the process is cygwin
-	 process. output_handle works only in native console apps.
-	 Therefore the data should be written to output_handle_cyg
-	 as well. */
-      fhandler_base *fh = ::cygheap->fdtab[2];
-      if (fh && fh->get_major () == DEV_PTYS_MAJOR)
-	{
-	  fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	  if (ptys->getPseudoConsole ())
-	    {
-	      HANDLE h_cyg = ptys->get_output_handle_cyg ();
-	      if (buf[len-1] == '\n' && len < NT_MAX_PATH - 1)
-		{
-		  buf[len-1] = '\r';
-		  buf[len] = '\n';
-		  len ++;
-		}
-	      WriteFile (h_cyg, buf, len, &done, 0);
-	      FlushFileBuffers (h_cyg);
-	    }
-	}
-#endif
     }
 
 #ifndef NOSTRACE
diff --git a/winsup/cygwin/winsup.h b/winsup/cygwin/winsup.h
index ab7b3bbdc..de9bfacda 100644
--- a/winsup/cygwin/winsup.h
+++ b/winsup/cygwin/winsup.h
@@ -216,6 +216,9 @@ void init_console_handler (bool);
 
 extern bool wsock_started;
 
+/* PTY related */
+void set_ishybrid_and_switch_to_pcon (HANDLE h);
+
 /* Printf type functions */
 extern "C" void vapi_fatal (const char *, va_list ap) __attribute__ ((noreturn));
 extern "C" void api_fatal (const char *, ...) __attribute__ ((noreturn));
-- 
2.21.0

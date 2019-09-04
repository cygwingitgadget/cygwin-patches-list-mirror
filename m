Return-Path: <cygwin-patches-return-9598-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85321 invoked by alias); 4 Sep 2019 01:45:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85311 invoked by uid 89); 4 Sep 2019 01:45:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 01:45:53 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x841iibJ012450;	Wed, 4 Sep 2019 10:45:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x841iibJ012450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567561522;	bh=9dsSF4TsdJUSk5998pLmAZh8JOkndkPZBq+lNlylwFo=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=m6D1gHfXfQ10Y7Z3WOmoSYkgrFNgmEhcLe2qmRq73X4UWmSDSzobOqOb23to3A8Pu	 ed/S6fgiguZ45q5BU5JYUFbm0/gHANKcN0hnI9JSGEVWZLytAOQw1YuTkHJ+6Mn+jw	 8BvE/TIcxz8qiTFz/va0qLQVPuDQMcCfZgMpAfMYoV3fVLO3wHwluLo5Kd2YX9aHzZ	 qdktncSQfnJ0EMBg57QmO6O9JYueFB6i9aRR/3ytZvO68c1Qdrn5qLsw8/elso+dbh	 QDshbTrc6IcB+GDDoRhyJH7CdZvixdcxf5Tet7nMJJMhY7U0SAaI+H0gSnDos0EUCa	 AXW7tSLs9QdcA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 4/4] Cygwin: pty: Limit API hook to the program linked with the APIs.
Date: Wed, 04 Sep 2019 01:45:00 -0000
Message-Id: <20190904014426.1284-5-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>
References: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00118.txt.bz2

- API hook used for pseudo console support causes slow down.
  This patch limits API hook to only program which is linked
  with the corresponding APIs. Normal cygwin program is not
  linked with such APIs (such as WriteFile, etc...) directly,
  therefore, no slow down occurs. However, console access by
  cygwin.dll itself cannot switch the r/w pipe to pseudo console
  side. Therefore, the code to switch it forcely to pseudo
  console side is added to smallprint.cc and strace.cc.
---
 winsup/cygwin/fhandler_tty.cc | 60 ++++++++++++++++++++++++-----------
 winsup/cygwin/smallprint.cc   |  5 +++
 winsup/cygwin/strace.cc       | 29 +++--------------
 3 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f76f7b262..3a23083de 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -89,6 +89,18 @@ set_switch_to_pcon (void)
       }
 }
 
+void set_ishybrid_and_switch_to_pcon (HANDLE h)
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
@@ -101,6 +113,7 @@ DEF_HOOK (WriteConsoleOutputW);
 DEF_HOOK (WriteConsoleOutputCharacterA);
 DEF_HOOK (WriteConsoleOutputCharacterW);
 DEF_HOOK (WriteConsoleOutputAttribute);
+DEF_HOOK (SetConsoleTextAttribute);
 DEF_HOOK (WriteConsoleInputA);
 DEF_HOOK (WriteConsoleInputW);
 DEF_HOOK (ReadConsoleInputA);
@@ -197,6 +210,13 @@ WriteConsoleOutputAttribute_Hooked
   return WriteConsoleOutputAttribute_Orig (h, a, l, c, n);
 }
 static BOOL WINAPI
+SetConsoleTextAttribute_Hooked
+     (HANDLE h, WORD a)
+{
+  CHK_CONSOLE_ACCESS (h);
+  return SetConsoleTextAttribute_Orig (h, a);
+}
+static BOOL WINAPI
 WriteConsoleInputA_Hooked
      (HANDLE h, CONST INPUT_RECORD *r, DWORD l, LPDWORD n)
 {
@@ -242,6 +262,7 @@ PeekConsoleInputW_Hooked
 #define WriteFile_Orig 0
 #define ReadFile_Orig 0
 #define PeekConsoleInputA_Orig 0
+void set_ishybrid_and_switch_to_pcon (void) {}
 #endif /* USE_API_HOOK */
 
 bool
@@ -2855,25 +2876,26 @@ fhandler_pty_slave::fixup_after_exec ()
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
index a7a19132b..bd19c1f5f 100644
--- a/winsup/cygwin/smallprint.cc
+++ b/winsup/cygwin/smallprint.cc
@@ -384,6 +384,9 @@ __small_sprintf (char *dst, const char *fmt, ...)
   return r;
 }
 
+/* Defined in fhandler_tty.cc */
+extern void set_ishybrid_and_switch_to_pcon (HANDLE);
+
 void
 small_printf (const char *fmt, ...)
 {
@@ -405,6 +408,7 @@ small_printf (const char *fmt, ...)
   count = __small_vsprintf (buf, fmt, ap);
   va_end (ap);
 
+  set_ishybrid_and_switch_to_pcon (GetStdHandle (STD_ERROR_HANDLE));
   WriteFile (GetStdHandle (STD_ERROR_HANDLE), buf, count, &done, NULL);
   FlushFileBuffers (GetStdHandle (STD_ERROR_HANDLE));
 }
@@ -431,6 +435,7 @@ console_printf (const char *fmt, ...)
   count = __small_vsprintf (buf, fmt, ap);
   va_end (ap);
 
+  set_ishybrid_and_switch_to_pcon (console_handle);
   WriteFile (console_handle, buf, count, &done, NULL);
   FlushFileBuffers (console_handle);
 }
diff --git a/winsup/cygwin/strace.cc b/winsup/cygwin/strace.cc
index b1eb5f3e4..fc3d0b783 100644
--- a/winsup/cygwin/strace.cc
+++ b/winsup/cygwin/strace.cc
@@ -243,6 +243,9 @@ strace::write_childpid (pid_t pid)
 static NO_COPY muto strace_buf_guard;
 static NO_COPY char *buf;
 
+/* Defined in fhandler_tty.cc */
+extern void set_ishybrid_and_switch_to_pcon (HANDLE);
+
 void
 strace::vprntf (unsigned category, const char *func, const char *fmt, va_list ap)
 {
@@ -264,6 +267,7 @@ strace::vprntf (unsigned category, const char *func, const char *fmt, va_list ap
   if (category & _STRACE_SYSTEM)
     {
       DWORD done;
+      set_ishybrid_and_switch_to_pcon (GetStdHandle (STD_ERROR_HANDLE));
       WriteFile (GetStdHandle (STD_ERROR_HANDLE), buf, len, &done, 0);
       FlushFileBuffers (GetStdHandle (STD_ERROR_HANDLE));
       /* Make sure that the message shows up on the screen, too, since this is
@@ -275,34 +279,11 @@ strace::vprntf (unsigned category, const char *func, const char *fmt, va_list ap
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
-- 
2.21.0

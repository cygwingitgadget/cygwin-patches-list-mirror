Return-Path: <cygwin-patches-return-9683-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55051 invoked by alias); 15 Sep 2019 04:36:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55041 invoked by uid 89); 15 Sep 2019 04:36:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=inherited, *if, country, Console
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 04:36:54 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x8F4aTwN011306;	Sun, 15 Sep 2019 13:36:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x8F4aTwN011306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568522194;	bh=X4yPMayBJzMIHoo4vuvxuwQurwnnq9j9GDJalD8RqK4=;	h=From:To:Cc:Subject:Date:From;	b=UsGhRYF8JqtNqNRx64b2MAu9a2NxsX55QJnIxQePTtR/Xd198gQSg0Y1hlRmIuyAl	 AhzN2cEAXsDKdQ/beTYEE/FXbHZLrgXzMavjwSO3jURy32XG5UKAR9V25fZiRHn4Cj	 UlQ3o+2oKzITmgtyC12ojOSiLKpzLGt0xqD0tOpBC5185n7DVvrvdJ50718E89FpxS	 GeRT4XE1huzHF7yRET1QyHA1dyLcYYMDVQ9B0PJmSBrGnWAxeNPRh+7YJ8Rdyj6uB2	 dX7uVG16KDRYV2z8rKtfKyThUdIgGVF4O4EirAM/M1XhKYhFcWFijQdSceRYoCKgxz	 4W2Z//4UmVOkw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Correct typos that do not fit the coding style.
Date: Sun, 15 Sep 2019 04:36:00 -0000
Message-Id: <20190915043623.916-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00203.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5c27510be..5072c6243 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -45,7 +45,7 @@ details. */
 #endif /* ENABLE_VIRTUAL_TERMINAL_INPUT */
 
 extern "C" int sscanf (const char *, const char *, ...);
-extern "C" int ttyname_r(int, char*, size_t);
+extern "C" int ttyname_r (int, char*, size_t);
 
 #define close_maybe(h) \
   do { \
@@ -2147,7 +2147,7 @@ fhandler_pty_master::close ()
   else if (obi.HandleCount == (getPseudoConsole () ? 2 : 1))
 			      /* Helper process has inherited one. */
     {
-      termios_printf("Closing last master of pty%d", get_minor ());
+      termios_printf ("Closing last master of pty%d", get_minor ());
       /* Close Pseudo Console */
       if (getPseudoConsole ())
 	{
@@ -2446,9 +2446,9 @@ get_locale_from_env (char *locale)
   char lang[ENCODING_LEN + 1] = {0, }, country[ENCODING_LEN + 1] = {0, };
   env = getenv ("LC_ALL");
   if (env == NULL || !*env)
-    env = getenv("LC_CTYPE");
+    env = getenv ("LC_CTYPE");
   if (env == NULL || !*env)
-    env = getenv("LANG");
+    env = getenv ("LANG");
   if (env == NULL || !*env)
     {
       if (GetLocaleInfo (LOCALE_CUSTOM_UI_DEFAULT,
@@ -2476,7 +2476,7 @@ get_locale_from_env (char *locale)
 			 LOCALE_SISO3166CTRYNAME,
 			 country, sizeof (country));
       if (strlen (lang) && strlen (country))
-	__small_sprintf (lang + strlen(lang), "_%s.UTF-8", country);
+	__small_sprintf (lang + strlen (lang), "_%s.UTF-8", country);
       else
 	strcpy (lang , "C.UTF-8");
       env = lang;
@@ -2492,7 +2492,7 @@ get_langinfo (char *locale_out, char *charset_out)
   get_locale_from_env (new_locale);
 
   __locale_t loc;
-  memset(&loc, 0, sizeof (loc));
+  memset (&loc, 0, sizeof (loc));
   const char *locale = __loadlocale (&loc, LC_CTYPE, new_locale);
   if (!locale)
     locale = "C";
@@ -2565,8 +2565,8 @@ get_langinfo (char *locale_out, char *charset_out)
     return 0;
 
   /* Set results */
-  strcpy(locale_out, new_locale);
-  strcpy(charset_out, charset);
+  strcpy (locale_out, new_locale);
+  strcpy (charset_out, charset);
   return lcid;
 }
 
@@ -2670,7 +2670,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 		get_ttyp ()->pcon_pid = myself->pid;
 	      get_ttyp ()->switch_to_pcon_out = true;
 	    }
-	  init_console_handler(false);
+	  init_console_handler (false);
 	}
       else if (fd == 0 && native_maybe)
 	/* Read from unattached pseudo console cause freeze,
@@ -2754,7 +2754,7 @@ fhandler_pty_slave::fixup_after_exec ()
 	{ \
 	  void *api = hook_api (module, #name, (void *) name##_Hooked); \
 	  name##_Orig = (__typeof__ (name) *) api; \
-	  /*if (api) system_printf(#name " hooked.");*/ \
+	  /*if (api) system_printf (#name " hooked.");*/ \
 	}
       DO_HOOK (NULL, WriteFile);
       DO_HOOK (NULL, WriteConsoleA);
@@ -3118,7 +3118,7 @@ fhandler_pty_master::setup_pseudoconsole ()
   if (res != S_OK)
     {
       system_printf ("CreatePseudoConsole() failed. %08x\n",
-		     GetLastError());
+		     GetLastError ());
       CloseHandle (from_master);
       CloseHandle (to_slave);
       from_master = from_master_cyg;
@@ -3230,7 +3230,7 @@ fhandler_pty_master::setup ()
     termios_printf ("can't set output_handle(%p) to non-blocking mode",
 		    get_output_handle ());
 
-  char pipename[sizeof("ptyNNNN-to-master-cyg")];
+  char pipename[sizeof ("ptyNNNN-to-master-cyg")];
   __small_sprintf (pipename, "pty%d-to-master", unit);
   res = fhandler_pipe::create (&sec_none, &from_slave, &to_master,
 			       fhandler_pty_common::pipesize, pipename, 0);
@@ -3406,7 +3406,7 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr, ssize_t& l
 		break;
 	      else
 		{
-		  set_errno(EAGAIN);
+		  set_errno (EAGAIN);
 		  len = -1;
 		  return TRUE;
 		}
-- 
2.21.0

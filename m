Return-Path: <cygwin-patches-return-9897-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22529 invoked by alias); 1 Jan 2020 06:51:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22427 invoked by uid 89); 1 Jan 2020 06:51:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Jan 2020 06:51:00 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 0016oh1b006898;	Wed, 1 Jan 2020 15:50:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 0016oh1b006898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1577861447;	bh=ldQTNGkOdVFZN9n+hClkko/4vwCX8A2aSHOQfcB4qCU=;	h=From:To:Cc:Subject:Date:From;	b=Ba/g6i/bfAFEllyHXP0VBKyyNZ/DNZmG1MQGhMge8pj5bpkk6LFbpC2EOoWU3euk4	 u61+VvJZYOm7KXf6qxmDMCIxw83UK2CXGgAmHWRlBmB7+BNBprV+GpMP3DJkXlDYS8	 4HJNHA2jM4R+0k8Ojhyr3giiXjaP5JiNCi2GgtK2FiKsaaAJXnNGyq3XfJAH0deZko	 Gd++4BBjy8JrLQEl0xxCr5uTOENYltLiC9TtBxnzCh9MHM7fB6eZh4XgJHgLDXT+rf	 h6DCOIkRCV6NXjvYFnsduTGpklRrrxC39xP3re1YYdrBmDlsshwPd1we8g2wK0OAP6	 fpDZ83+7dRQ2w==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Revise the code for setting code page of pseudo console.
Date: Wed, 01 Jan 2020 06:51:00 -0000
Message-Id: <20200101065036.8850-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00003.txt

- Fix the problem which overrides the code page setting, reported
  in https://www.cygwin.com/ml/cygwin/2019-12/msg00292.html.
---
 winsup/cygwin/fhandler_tty.cc | 52 +++++++++++++++++------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index d3d0d7430..e0aa5df9f 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2644,39 +2644,36 @@ fhandler_pty_slave::setup_locale (void)
   if (lcid == 0 || lcid == (LCID) -1)
     code_page = 20127; /* ASCII */
   else if (!GetLocaleInfo (lcid,
-			   LOCALE_IDEFAULTANSICODEPAGE | LOCALE_RETURN_NUMBER,
+			   LOCALE_IDEFAULTCODEPAGE | LOCALE_RETURN_NUMBER,
 			   (char *) &code_page, sizeof (code_page)))
     code_page = 20127; /* ASCII */
   SetConsoleCP (code_page);
   SetConsoleOutputCP (code_page);
 
-  if (get_ttyp ()->term_code_page == 0)
-    {
-      /* Set terminal code page from locale */
-      /* This code is borrowed from mintty: charset.c */
-      get_ttyp ()->term_code_page = 20127; /* Default ASCII */
-      char charset_u[ENCODING_LEN + 1] = {0, };
-      for (int i=0; charset[i] && i<ENCODING_LEN; i++)
-	charset_u[i] = toupper (charset[i]);
-      unsigned int iso;
-      UINT cp = 20127; /* Default for fallback */
-      if (sscanf (charset_u, "ISO-8859-%u", &iso) == 1 ||
-	  sscanf (charset_u, "ISO8859-%u", &iso) == 1 ||
-	  sscanf (charset_u, "ISO8859%u", &iso) == 1)
+  /* Set terminal code page from locale */
+  /* This code is borrowed from mintty: charset.c */
+  get_ttyp ()->term_code_page = 20127; /* Default ASCII */
+  char charset_u[ENCODING_LEN + 1] = {0, };
+  for (int i=0; charset[i] && i<ENCODING_LEN; i++)
+    charset_u[i] = toupper (charset[i]);
+  unsigned int iso;
+  UINT cp = 20127; /* Default for fallback */
+  if (sscanf (charset_u, "ISO-8859-%u", &iso) == 1 ||
+      sscanf (charset_u, "ISO8859-%u", &iso) == 1 ||
+      sscanf (charset_u, "ISO8859%u", &iso) == 1)
+    {
+      if (iso && iso <= 16 && iso !=12)
+	get_ttyp ()->term_code_page = 28590 + iso;
+    }
+  else if (sscanf (charset_u, "CP%u", &cp) == 1)
+    get_ttyp ()->term_code_page = cp;
+  else
+    for (int i=0; cs_names[i].cp; i++)
+      if (strcasecmp (charset_u, cs_names[i].name) == 0)
 	{
-	  if (iso && iso <= 16 && iso !=12)
-	    get_ttyp ()->term_code_page = 28590 + iso;
+	  get_ttyp ()->term_code_page = cs_names[i].cp;
+	  break;
 	}
-      else if (sscanf (charset_u, "CP%u", &cp) == 1)
-	get_ttyp ()->term_code_page = cp;
-      else
-	for (int i=0; cs_names[i].cp; i++)
-	  if (strcasecmp (charset_u, cs_names[i].name) == 0)
-	    {
-	      get_ttyp ()->term_code_page = cs_names[i].cp;
-	      break;
-	    }
-    }
 }
 
 void
@@ -2807,7 +2804,8 @@ fhandler_pty_slave::fixup_after_exec ()
     }
 
   /* Set locale */
-  setup_locale ();
+  if (get_ttyp ()->term_code_page == 0)
+    setup_locale ();
 
 #if USE_API_HOOK
   /* Hook Console API */
-- 
2.21.0

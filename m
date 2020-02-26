Return-Path: <cygwin-patches-return-10128-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 94155 invoked by alias); 26 Feb 2020 15:34:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 94087 invoked by uid 89); 26 Feb 2020 15:34:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=upto
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 15:34:08 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-03.nifty.com with ESMTP id 01QFXDfA021601;	Thu, 27 Feb 2020 00:33:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 01QFXDfA021601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582731231;	bh=xMH0XUbBPveVVxY764Cy6MPOfnkMcaBTsOPdOa4ISrk=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=DwUlpT1akCLqxmod0fUii7CE6GISMb7DM9QXgNiyUwU+Ukxqh/eH0rKdwIhubJgF3	 EXe1pjNEAjf9O2uQ3PKyaNKzxk86sE/VVZp4SeeT9MItIzXCeAABYdL3SWIqnTxFFr	 yvHNe9jxA1cIpnbISClo81C3yrSPYa4j/jMRJ8cV/jCJ40EYpf+Aw/rn5ZyZPRDmu0	 +CxUj0+h/LxL0BHaygNDF5T4JbrIPsAgAAHo1ZRKHs+4hHF8cTOflfxo9usCsg3L9+	 zrHP8i1ovpFifjsuky7tOb+u6scIqaVb2+pgC2PFcZssnAIqV7Q1U7WpOqm/I5uamK	 8TGHwCHjNr77A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 3/4] Cygwin: console: Add support for REP escape sequence to xterm mode.
Date: Wed, 26 Feb 2020 15:34:00 -0000
Message-Id: <20200226153302.584-4-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200226153302.584-1-takashi.yano@nifty.ne.jp>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00234.txt

- In Win10 upto 1809, xterm compatible mode does not have REP
  escape sequence which terminfo declares. This patch adds support
  for "CSI Ps b" (REP). With this patch, bvi (binary editor) works
  normally in Win10 1809. Also, xterm compatible mode does not have
  "CSI Pm `" (HPA), "CSI Pm a" (HPR) and "CSI Ps e" (VPR). However,
  they do not appear to be declared by terminfo. Therefore, these
  have been pending.
---
 winsup/cygwin/fhandler_console.cc | 33 +++++++++++++++++++++++++++++++
 winsup/cygwin/wincap.cc           | 10 ++++++++++
 winsup/cygwin/wincap.h            |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 3bd1d27d1..b0951497a 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -62,6 +62,7 @@ static struct fhandler_base::rabuf_t con_ra;
 #define WPBUF_LEN 256
 static unsigned char wpbuf[WPBUF_LEN];
 static int wpixput;
+static unsigned char last_char;
 #define wpbuf_put(x) \
   wpbuf[wpixput++] = x; \
   if (wpixput > WPBUF_LEN) \
@@ -2009,6 +2010,37 @@ fhandler_console::char_command (char c)
       DWORD wn;
       switch (c)
 	{
+#if 0 /* These sequences, which are supported by real xterm, are
+	 not supported by xterm compatible mode. Therefore they
+	 were implemented once. However, these are not declared
+	 in terminfo of xterm-256color, therefore, do not appear
+	 to be necessary. */
+	case '`': /* HPA */
+	  if (con.args[0] == 0)
+	    con.args[0] = 1;
+	  cursor_get (&x, &y);
+	  cursor_set (false, con.args[0]-1, y);
+	  break;
+	case 'a': /* HPR */
+	  if (con.args[0] == 0)
+	    con.args[0] = 1;
+	  cursor_rel (con.args[0], 0);
+	  break;
+	case 'e': /* VPR */
+	  if (con.args[0] == 0)
+	    con.args[0] = 1;
+	  cursor_rel (0, con.args[0]);
+	  break;
+#endif
+	case 'b': /* REP */
+	  wpbuf_put (c);
+	  if (wincap.has_con_esc_rep ())
+	    /* Just send the sequence */
+	    WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  else if (last_char && last_char != '\n')
+	    for (int i = 0; i < con.args[0]; i++)
+	      WriteConsoleA (get_output_handle (), &last_char, 1, &wn, 0);
+	  break;
 	case 'r': /* DECSTBM */
 	  con.scroll_region.Top = con.args[0] ? con.args[0] - 1 : 0;
 	  con.scroll_region.Bottom = con.args[1] ? con.args[1] - 1 : -1;
@@ -2746,6 +2778,7 @@ fhandler_console::write_normal (const unsigned char *src,
 	  break;
 	default:
 	  found += ret;
+	  last_char = *(found - 1);
 	  break;
 	}
     }
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index 714a6d49f..922705e65 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -44,6 +44,7 @@ wincaps wincap_vista __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
     has_con_broken_il_dl:false,
+    has_con_esc_rep:false,
   },
 };
 
@@ -73,6 +74,7 @@ wincaps wincap_7 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
     has_con_broken_il_dl:false,
+    has_con_esc_rep:false,
   },
 };
 
@@ -102,6 +104,7 @@ wincaps wincap_8 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
     has_con_broken_il_dl:false,
+    has_con_esc_rep:false,
   },
 };
 
@@ -131,6 +134,7 @@ wincaps wincap_8_1 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
     has_con_broken_il_dl:false,
+    has_con_esc_rep:false,
   },
 };
 
@@ -160,6 +164,7 @@ wincaps  wincap_10_1507 __attribute__((section (".cygwin_dll_common"), shared))
     has_con_24bit_colors:false,
     has_con_broken_csi3j:false,
     has_con_broken_il_dl:false,
+    has_con_esc_rep:false,
   },
 };
 
@@ -189,6 +194,7 @@ wincaps wincap_10_1703 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_con_24bit_colors:true,
     has_con_broken_csi3j:false,
     has_con_broken_il_dl:false,
+    has_con_esc_rep:false,
   },
 };
 
@@ -218,6 +224,7 @@ wincaps wincap_10_1709 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_con_24bit_colors:true,
     has_con_broken_csi3j:false,
     has_con_broken_il_dl:false,
+    has_con_esc_rep:false,
   },
 };
 
@@ -247,6 +254,7 @@ wincaps wincap_10_1803 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_con_24bit_colors:true,
     has_con_broken_csi3j:false,
     has_con_broken_il_dl:false,
+    has_con_esc_rep:false,
   },
 };
 
@@ -276,6 +284,7 @@ wincaps wincap_10_1809 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_con_24bit_colors:true,
     has_con_broken_csi3j:true,
     has_con_broken_il_dl:false,
+    has_con_esc_rep:false,
   },
 };
 
@@ -305,6 +314,7 @@ wincaps wincap_10_1903 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_con_24bit_colors:true,
     has_con_broken_csi3j:false,
     has_con_broken_il_dl:true,
+    has_con_esc_rep:true,
   },
 };
 
diff --git a/winsup/cygwin/wincap.h b/winsup/cygwin/wincap.h
index f85a88877..6d7a1eae6 100644
--- a/winsup/cygwin/wincap.h
+++ b/winsup/cygwin/wincap.h
@@ -38,6 +38,7 @@ struct wincaps
     unsigned has_con_24bit_colors		: 1;
     unsigned has_con_broken_csi3j		: 1;
     unsigned has_con_broken_il_dl		: 1;
+    unsigned has_con_esc_rep			: 1;
   };
 };
 
@@ -99,6 +100,7 @@ public:
   bool	IMPLEMENT (has_con_24bit_colors)
   bool	IMPLEMENT (has_con_broken_csi3j)
   bool	IMPLEMENT (has_con_broken_il_dl)
+  bool	IMPLEMENT (has_con_esc_rep)
 
   void disable_case_sensitive_dirs ()
   {
-- 
2.21.0

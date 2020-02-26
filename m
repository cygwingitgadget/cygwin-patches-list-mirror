Return-Path: <cygwin-patches-return-10129-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 94178 invoked by alias); 26 Feb 2020 15:34:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 94086 invoked by uid 89); 26 Feb 2020 15:34:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 15:34:08 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-03.nifty.com with ESMTP id 01QFXDf8021601;	Thu, 27 Feb 2020 00:33:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 01QFXDf8021601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582731220;	bh=IbHk38DF77ZGaWRdpfVqyi0t9Fe0aIg3X/6jJysuhtM=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=U6bg6pL28P0SBe5uqPNaWOxVac/EQ2qcXnwieY0hk7y9Nn/ZdI7kMqiFyXla6PHYI	 0HymheohLuBSgb5epCGzxzt0v1inJunVbr+5SzPIypos7LX6op9d3+tPnVFoLKR0kM	 n4mbUeWicEfSDHgAnAt8dJe/fT9dfXY54DCtlcqVoZGVRiB4XV2pGpPMxtx1hItPAm	 1Ga8Dt5ki/FqEfvPKlYBG0hrE0sMFskJj2EPwgN5GvP/vLLbmbM3Y4fo02rFoyZaOU	 R6O4c3rLPcHJUkB+y3TKdmanjt8p7vR7lTBhsxVQ0lvnIYrIpQLMmPq6N1gtWuVBOY	 DhG7DUKdF979A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 2/4] Cygwin: console: Unify workaround code for CSI3J and CSI?1049h/l.
Date: Wed, 26 Feb 2020 15:34:00 -0000
Message-Id: <20200226153302.584-3-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200226153302.584-1-takashi.yano@nifty.ne.jp>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00235.txt

- This patch unifies workaround code for CSI3J and CSI?1049h/l into
  the code handling other escape sequences in xterm mode.
---
 winsup/cygwin/fhandler_console.cc | 43 ++++++++++++++++---------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index c2198ea1e..3bd1d27d1 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1786,24 +1786,6 @@ static const wchar_t __vt100_conv[31] = {
 inline bool
 fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
 {
-  bool need_fix_tab_position = false;
-  /* Check if screen will be alternated. */
-  if (wincap.has_con_24bit_colors () && !con_is_legacy
-      && memmem (buf, len*sizeof (WCHAR), L"\033[?1049", 7*sizeof (WCHAR)))
-    need_fix_tab_position = true;
-  /* Workaround for broken CSI3J (ESC[3J) support in xterm compatible mode. */
-  if (wincap.has_con_24bit_colors () && !con_is_legacy &&
-      wincap.has_con_broken_csi3j ())
-    {
-      WCHAR *p = buf;
-      while ((p = (WCHAR *) memmem (p, (len - (p - buf))*sizeof (WCHAR),
-				    L"\033[3J", 4*sizeof (WCHAR))))
-	{
-	  memmove (p, p+4, (len - (p+4 - buf))*sizeof (WCHAR));
-	  len -= 4;
-	}
-    }
-
   if (con.iso_2022_G1
 	? con.vt100_graphics_mode_G1
 	: con.vt100_graphics_mode_G0)
@@ -1822,9 +1804,6 @@ fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
       len -= done;
       buf += done;
     }
-  /* Call fix_tab_position() if screen has been alternated. */
-  if (need_fix_tab_position)
-    fix_tab_position ();
   return true;
 }
 
@@ -2089,6 +2068,28 @@ fhandler_console::char_command (char c)
 	      WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
 	    }
 	  break;
+	case 'J': /* ED */
+	  wpbuf_put (c);
+	  /* Ignore CSI3J in Win10 1809 because it is broken. */
+	  if (con.args[0] != 3 || !wincap.has_con_broken_csi3j ())
+	    WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  break;
+	case 'h': /* DECSET */
+	case 'l': /* DECRST */
+	  wpbuf_put (c);
+	  /* Just send the sequence */
+	  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &wn, 0);
+	  if (con.saw_question_mark)
+	    {
+	      bool need_fix_tab_position = false;
+	      for (int i = 0; i < con.nargs; i++)
+		if (con.args[i] == 1049)
+		  need_fix_tab_position = true;
+	      /* Call fix_tab_position() if screen has been alternated. */
+	      if (need_fix_tab_position)
+		fix_tab_position ();
+	    }
+	  break;
 	default:
 	  /* Other escape sequences */
 	  wpbuf_put (c);
-- 
2.21.0

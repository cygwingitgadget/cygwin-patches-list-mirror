Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 02F1C4BA2E05
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:27:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 02F1C4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 02F1C4BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042871; cv=none;
	b=VFdstap3BkR6KrwjEiMEKJCYAWV5g+nCwi9/xUJcotoJcy3f4aCjAGEmowKu8h5vVsYLCeKcOZQro288G+P4Y018R74Ax1Y74syIuc20gSiSGNdPzYJSPvLFAC4t7t+MbUXj2KSLZvTqCV/losy2pTH3wxakycylNOQ4s7WqHxE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042871; c=relaxed/simple;
	bh=+c8WT3qEmLWGrNuhzVa3bljfTmP/yHDiR+brPm6KW1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=uZEGeQsRnCAKsbXAWRWHR2KNX8ZNe+JywSxaTjMddh8yKTMuiKE6Fp3I78VBuXSFEJ29byBVhwzBOwsbb+H3MODVdpn9kfmvCwYSDNKAFiZx2m1ATL+sm8mWmFQeYx5XryN8jlkJPFV6kNIeikaA18OYHABgHcC863nnmtICxD0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 02F1C4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kekZmkm+
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20251218072749312.HHFQ.4197.HP-Z230@nifty.com>;
          Thu, 18 Dec 2025 16:27:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2 2/2] Cygwin: pty: Add new workaround for rlwrap in pcon enabled mode
Date: Thu, 18 Dec 2025 16:27:03 +0900
Message-ID: <20251218072722.1634-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218072722.1634-1-takashi.yano@nifty.ne.jp>
References: <20251218072722.1634-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042869;
 bh=0gtaIWhZg9xvT4JYz9Eu+DEFpA73wu3O3Mbm4wYLP8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kekZmkm+yx+/0qqKMIEsjJ1P4CPFeOaZOSSSgXqMSgLMkzScVAep0WKDGEhllwc+Dng2spDG
 HC67/phT5d2RNg/fAlt8AK2KltES/o3taZMabCY51wbsRkpy+p8uE8f1Z96iylQRh3UDHJwOnW
 o0WO4OT1LMV6uGQDkKzzzvPUR/BpylWbYInvrDdRTFvw0mGdtE0qHQwCJLqo4g33B6b3Dbt79D
 C+ZVaC6YO+6UrVkyswztuDPyC1RJ4EyonTOs5K8AppzG5lujOedB+mg4lbep2NyT+vBCIwv1Fh
 DtrXU2mLfWIAWOtSdjvSa3IJfyBF31w1Fd29we2kXEOAWXgw==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, the command "rlwrap cmd" outputs garbaged screen.
This is because rlwrap treats text between NLs as a line, while
pseudo console sometimes omits NL before "CSIm;nH". This issue
does not happen in Windows 10. This patch fixes the issue by
adding CR NL before "CSIm:nH" into the output from the pseudo
console if the OS is Windows 11.

Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc         | 44 +++++++++++++++++++++++++++
 winsup/cygwin/local_includes/wincap.h |  2 ++
 winsup/cygwin/wincap.cc               | 11 +++++++
 3 files changed, 57 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 3b0b4f073..7acedc165 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2775,6 +2775,50 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	    else
 	      state = 0;
 
+	  /* Workaround for rlwrap in Win11. rlwrap treats text between
+	     NLs as a line, however, pseudo console in Win11 somtimes
+	     omits NL before "CSIm;nH". This does not happen in Win10. */
+	  if (wincap.has_pcon_omit_nl_before_cursor_move ())
+	    {
+	      state = 0;
+	      for (DWORD i = 0; i < rlen; i++)
+		if (state == 0 && outbuf[i] == '\033')
+		  {
+		    start_at = i;
+		    state++;
+		    continue;
+		  }
+		else if (state == 1 && outbuf[i] == '[')
+		  {
+		    state++;
+		    continue;
+		  }
+		else if (state == 2
+			 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
+		  continue;
+		else if (state == 2 && outbuf[i] == 'H')
+		  {
+		    /* Add omitted CR NL before "CSIm;nH". However, when the
+		       cusor is on the bottom-most line, adding NL might cause
+		       unexpected scrolling. To avoid this, add "CSI H" before
+		       CR NL. */
+		    const char *ins = "\033[H\r\n";
+		    const int ins_len = strlen (ins);
+		    if (rlen + ins_len <= NT_MAX_PATH)
+		      {
+			memmove (&outbuf[start_at + ins_len],
+				 &outbuf[start_at], rlen - start_at);
+			memcpy (&outbuf[start_at], ins, ins_len);
+			rlen += ins_len;
+			i += ins_len;
+		      }
+		    state = 0;
+		    continue;
+		  }
+		else
+		  state = 0;
+	    }
+
 	  if (p->ttyp->term_code_page != CP_UTF8)
 	    {
 	      size_t nlen = NT_MAX_PATH;
diff --git a/winsup/cygwin/local_includes/wincap.h b/winsup/cygwin/local_includes/wincap.h
index 2416eee1d..0496d807e 100644
--- a/winsup/cygwin/local_includes/wincap.h
+++ b/winsup/cygwin/local_includes/wincap.h
@@ -34,6 +34,7 @@ struct wincaps
     unsigned has_con_broken_tabs				: 1;
     unsigned has_user_shstk					: 1;
     unsigned has_alloc_console_with_options			: 1;
+    unsigned has_pcon_omit_nl_before_cursor_move		: 1;
   };
 };
 
@@ -92,6 +93,7 @@ public:
   bool	IMPLEMENT (has_con_broken_tabs)
   bool	IMPLEMENT (has_user_shstk)
   bool	IMPLEMENT (has_alloc_console_with_options)
+  bool	IMPLEMENT (has_pcon_omit_nl_before_cursor_move)
 
   void disable_case_sensitive_dirs ()
   {
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index 91caefe9b..f94b9f60b 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -33,6 +33,7 @@ static const wincaps wincap_8_1 = {
     has_con_broken_tabs:false,
     has_user_shstk:false,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:false,
   },
 };
 
@@ -56,6 +57,7 @@ static const wincaps  wincap_10_1507 = {
     has_con_broken_tabs:false,
     has_user_shstk:false,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:false,
   },
 };
 
@@ -79,6 +81,7 @@ static const wincaps  wincap_10_1607 = {
     has_con_broken_tabs:false,
     has_user_shstk:false,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:false,
   },
 };
 
@@ -102,6 +105,7 @@ static const wincaps wincap_10_1703 = {
     has_con_broken_tabs:true,
     has_user_shstk:false,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:false,
   },
 };
 
@@ -125,6 +129,7 @@ static const wincaps wincap_10_1709 = {
     has_con_broken_tabs:true,
     has_user_shstk:false,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:false,
   },
 };
 
@@ -148,6 +153,7 @@ static const wincaps wincap_10_1803 = {
     has_con_broken_tabs:true,
     has_user_shstk:false,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:false,
   },
 };
 
@@ -171,6 +177,7 @@ static const wincaps wincap_10_1809 = {
     has_con_broken_tabs:true,
     has_user_shstk:false,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:false,
   },
 };
 
@@ -194,6 +201,7 @@ static const wincaps wincap_10_1903 = {
     has_con_broken_tabs:true,
     has_user_shstk:false,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:false,
   },
 };
 
@@ -217,6 +225,7 @@ static const wincaps wincap_10_2004 = {
     has_con_broken_tabs:true,
     has_user_shstk:true,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:false,
   },
 };
 
@@ -240,6 +249,7 @@ static const wincaps wincap_11 = {
     has_con_broken_tabs:false,
     has_user_shstk:true,
     has_alloc_console_with_options:false,
+    has_pcon_omit_nl_before_cursor_move:true,
   },
 };
 
@@ -263,6 +273,7 @@ static const wincaps wincap_11_24h2 = {
     has_con_broken_tabs:false,
     has_user_shstk:true,
     has_alloc_console_with_options:true,
+    has_pcon_omit_nl_before_cursor_move:true,
   },
 };
 
-- 
2.51.0


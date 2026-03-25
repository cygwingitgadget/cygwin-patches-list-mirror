Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id E140C4BBC09F
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:11:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E140C4BBC09F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E140C4BBC09F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774444297; cv=none;
	b=qZr/zwof2EHROWizVPS6yLqO+2vrsl8YtlR1ep39NQwQKZ2a1H6VsHTfDL8b5U8D61UV1ZnJaB3UVuS5ihEpY43MtKC2Yk7K66ksE4NSXiI/F8MDp0n6rOcbYuHjg98qvEG0VduPE0QF6Q9su+Vp+d4CMUf6+aappBnDyhhLxvY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774444297; c=relaxed/simple;
	bh=PCm5GTJ87pdqFvCrYMeb8QKl47Z5Sl47Zou1ved3+k4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=SQd35+/UvMtJLPyvAudEgyn/zRMuwoGWeVi3zXWfEAMXnDLIqqG70NkaZ+Z5rFHiTcs1jDLLiMKhVVJRvr2Zeeeq0GNd6EgI9gHx3GH60ISGv+zUNm62K6EZhrcJHmr6VuIUVXhmgNCM8BrpfjKWdWTKk/rpFu/AlnMaWDshuOI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E140C4BBC09F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PBs3zyh3
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260325131135044.TVSW.127398.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:11:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 3/3] Cygwin: console: Fix master thread for OpenConsole.exe
Date: Wed, 25 Mar 2026 22:09:59 +0900
Message-ID: <20260325131056.69116-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325131056.69116-1-takashi.yano@nifty.ne.jp>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
 <20260325131056.69116-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774444295;
 bh=hw1/wVAju/BFFASN+rHV3sB6t5uRwqG8v39M1W+Ajd8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PBs3zyh3e9ipfCjNDrt4P7QnNQod5OHBk04WrpBJyLQ1ju4x7OnEiIhluGhW7hJNjd1SJgZ3
 28ZtbuHCLbg5E3+N/dYSAhBemE2fKuGQ/cMI+X8xLYLN3APnvzv14dPOUpkcbLpHAHsJGxIjPM
 CGrIE1UvznNG33xoPhhi9DaALLFMQfYthdPR7/hxbKq+ncYuDPPrjtNAY5deucX3Fwy0QxfSNh
 DDTrHRWsce6lpcLn9r+8oEKZHQmlQKZ6quuJa1cpeJZGhaVuis4LI5DsYmOy2fskPl660+nOy5
 iBrwmfA2zEMnLz25aNMO9nPj6GptJonjALe1/Go0UkSmw5lw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the console is originating from a pseudo console, current master
thread code does not work as expected. This is because the pseudo
console does not keep all the event as is. All bKeyDown == 0 events
will be omitted from the input record written by WriteConsoleInput().

This patch adds strip_inrec() function to remove all the key events
of bKeyDown == 0 before comparing/writing input record. This function
is called only when the console is originating from a pseudo console.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 1dd5dfa1d..1693a5be7 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -305,6 +305,23 @@ cons_master_thread (VOID *arg)
   return 0;
 }
 
+static inline DWORD
+strip_inrec (INPUT_RECORD *r, DWORD n)
+{
+  /* Pseudo console with OpenConsole.exe removes the events
+     whose bKeyDown is 0 as well as ones whose charcode is 0. */
+  DWORD j = 0;
+  for (DWORD i = 0; i < n; i++)
+    {
+      if (r[i].EventType != KEY_EVENT)
+	r[j++] = r[i];
+      else if (r[i].Event.KeyEvent.bKeyDown
+	       && r[i].Event.KeyEvent.uChar.UnicodeChar)
+	r[j++] = r[i];
+    }
+  return j;
+}
+
 /* Compare two INPUT_RECORD sequences */
 static inline bool
 inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
@@ -482,6 +499,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	      total_read += len;
 	    }
 	  release_attach_mutex ();
+	  if (inside_pcon)
+	    total_read = strip_inrec (input_rec, total_read);
 	  break;
 	case WAIT_TIMEOUT:
 	  con.num_processed = 0;
@@ -606,6 +625,8 @@ remove_record:
 	      acquire_attach_mutex (mutex_timeout);
 	      PeekConsoleInputW (p->input_handle, input_tmp, inrec_size, &n);
 	      release_attach_mutex ();
+	      if (inside_pcon)
+		n = strip_inrec (input_tmp, n);
 	      if (n < min (total_read, inrec_size))
 		break; /* Someone has read input without acquiring
 			  input_mutex. ConEmu cygwin-connector? */
@@ -624,6 +645,8 @@ remove_record:
 		  n += len;
 		}
 	      release_attach_mutex ();
+	      if (inside_pcon)
+		n = strip_inrec (input_tmp, n);
 	      bool fixed = false;
 	      for (DWORD ofs = n - total_read; ofs > 0; ofs--)
 		{
-- 
2.51.0


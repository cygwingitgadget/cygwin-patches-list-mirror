Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 607CE4BA2E21
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 02:27:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 607CE4BA2E21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 607CE4BA2E21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766111248; cv=none;
	b=b04nN9yQpw8cIwhNquyAQy+f9rI1+XDuL0f0DG3/jPiprIQxwy5BepzIyu/nkiFUrMKcAPocfe5BbHGNDZniFqs0yaBakQ1eij1yW/95ERWpSqyxNYq6dszcZdvo/kHky+ZRc0QLaIG/MYsQVk0+2ZAI93uQqTIRIB4wv20A+JA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766111248; c=relaxed/simple;
	bh=tYnjKIzt/bc9cukmCQbv3fnvSkgacT88HVR3WQZDOTU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=sU6miFxVUusx7fLyI1BMo8h7GndVi7zwqaip8Q4qmc9Zd0MVOrgcBCqzX1SN+44ia6Dha3loG6tX3V/LZpu2DnzQA4EzX4s1SOR/nQifoHWhWJRJvP+cBEEIyJt+1WDQNRqUFsogpnZaP6fyTk4ZC9nESR5x7LZOM36MEf1KYME=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 607CE4BA2E21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=c7XivDTc
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251219022726714.VHUD.116672.HP-Z230@nifty.com>;
          Fri, 19 Dec 2025 11:27:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 4/6] Cygwin: path: Implement path_conv::is_app_execution_alias()
Date: Fri, 19 Dec 2025 11:26:37 +0900
Message-ID: <20251219022650.2239-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
References: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766111246;
 bh=8Fc8FFavdfXvD5irYDXHmaD4QY+AM4o1VCwWuUc44I8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c7XivDTcl8BQ/tAbQY5YIaoCaxLKG0/3+8nLOl6pvaVkKrqJdTxCxCKLJbM4UIyYH3qkV/Fb
 SCeEMl69CUiSrPuuA+jvAZOHnheUfmqwITladNg6GgDGOiEnBVYC88eu23zkdf0WxcgBJMUeNu
 7L/CvvdC00oaCekxl27LrDlXs2d0AwitakNNbsZU/vlq67MqxbtPfvy8EOiWoUKxW+7oERuqAT
 JXHZm2HrkS0xn66KsTa3+H5RIYsAphyFOjXiEDZ+FNsITo5bmJWvTViRAfWQtelPx5SE7VR60P
 5BRS7aw9Yc6r2JfO7HHy+hs2ssG2tTOVtOQArc5yPIS0h1jg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

An app execution alias cannot be opened for read (CreateFile() with
GENERIC_READ fails with ERROR_CANT_ACCESS_FILE) because it does not
resolve the reparse point for app execution alias. Therefore, we need
to know if the path is an app execution alias when opening it.

This patch adds new api path_conv::is_app_execution_alias() for
that purpose.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/path.h | 5 +++++
 winsup/cygwin/path.cc               | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
index a9ce2c7e4..ad142ddd3 100644
--- a/winsup/cygwin/local_includes/path.h
+++ b/winsup/cygwin/local_includes/path.h
@@ -79,6 +79,7 @@ enum path_types
   PATH_SOCKET		= _BIT ( 5),	/* AF_UNIX socket file */
   PATH_RESOLVE_PROCFD	= _BIT ( 6),	/* fd symlink via /proc */
   PATH_REP_NOAPI	= _BIT ( 7),	/* rep. point unknown to WinAPI */
+  PATH_APPEXECLINK	= _BIT ( 8),	/* rep. point app execution alias */
   PATH_DONT_USE		= _BIT (31)	/* conversion to signed happens. */
 };
 
@@ -214,6 +215,10 @@ class path_conv
   {
     return (path_flags & (PATH_REP | PATH_REP_NOAPI)) == PATH_REP;
   }
+  int is_app_execution_alias () const
+  {
+    return path_flags & PATH_APPEXECLINK;
+  }
 
   int isfifo () const {return dev.is_device (FH_FIFO);}
   int iscygdrive () const {return dev.is_device (FH_CYGDRIVE);}
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 710775e38..625e60686 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2661,7 +2661,7 @@ check_reparse_point_target (HANDLE h, bool remote, PREPARSE_DATA_BUFFER rp,
 	  if (i == 2 && n > 0 && n < size)
 	    {
 	      RtlInitCountedUnicodeString (psymbuf, buf, n * sizeof (WCHAR));
-	      return PATH_SYMLINK | PATH_REP;
+	      return PATH_SYMLINK | PATH_REP | PATH_APPEXECLINK;
 	    }
 	  if (i == 2)
 	    break;
-- 
2.51.0


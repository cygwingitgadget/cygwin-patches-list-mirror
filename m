Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id 614EA4BA23CA
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:28:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 614EA4BA23CA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 614EA4BA23CA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042940; cv=none;
	b=wtUIya1MyjNdjAWl38fE8XDCZw8+4RGxRgSKeTOqwqI+5lNq06Nx4JIRVaKALmFH5lGJEq6RsE+wc4FwUc/kh06cKy3xVPp5uBAUIyQ+QeISK1Tg53qpDQ+20eCcviFGYJcaATEBHo9BNWCYGyLby4Jj20ggXq0kga33cXxpO+s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042940; c=relaxed/simple;
	bh=BfnNhmfepsQdD4+jgyCLLykccpFY0ZnxnsR6GhpPraY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Ucf1EpX72Af/UWne7tDiiJRKetLrHYWD2PC3A7TQtpLmjadPBpS2OmPtT2+MnITkB5f/Dor6razmxMywGkUSjxVo8OBjMaI3cg3tDV9EBGYkez07L0u3ak+TrbpYGxlnrq8rpf32S6dy/ZJbYRsbI0rxIXDCBzXxxX7Ahcz+/YY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 614EA4BA23CA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GVdDYAV8
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251218072852633.LNXR.36235.HP-Z230@nifty.com>;
          Thu, 18 Dec 2025 16:28:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 4/5] Cygwin: path: Implement path_conv::is_app_execution_alias()
Date: Thu, 18 Dec 2025 16:27:58 +0900
Message-ID: <20251218072813.1644-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042932;
 bh=U3M1qZTEFMbTThOdHIsjq7GpL7NGAUytaiazplQvLhg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GVdDYAV8U/c77RN693QCYJ3fgZ3YNYzALGUD3WK6hOHJllCwjd4SOfY+EHgEs6O+Avbn6tlI
 lIfKeALbUxaHtyVL+mvZRrTkKaQSfY8PZkpGb+SDtgc1MTVkjTETB/fhzr43V1PSdw7BrmEn5J
 0hCcDTUKAzB4BLk0SeXZSZJ7hUIxqUcprDq4igO0AQSykRsof9YfNvla+UPxuNxqOaQLE8jkDk
 SmdBv6oUtagOovzqGYOiwzzXFyeB1/L5Tt6Y///AmmZu80e81NionGRZzaHUvF+quY9s13Ulgz
 FNY/GMrvctpYpVGmx2suAC7cjDucXoqhUIh6OgsijAM/qR8g==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

An app execution alias cannot be opened for read (CreateFile() with
GENERIC_READ fails with ERROR_CANT_ACCESS_FILE) because it does not
resolve the reparse point for app execution alias. Therefore, we need
to know if the path is an app execution alias when opening it.

This patch adds new api path_conv::is_app_execution_alias() for
that purpose.

Reviewed-by:
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


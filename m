Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id DF1BA4BA2E23
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 09:30:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF1BA4BA2E23
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DF1BA4BA2E23
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765963819; cv=none;
	b=HPhMsIcIjvfNCyOH2jHl0Jt2/REP2HcmIkQEanQpoFLx9Ej08h/1dvRq1WYSSYbluJhg1qKPKknZpy0vBir8/ku79immbRsNTKIXjx1pjmQ7wWo7fCxphBfXS2wNPqZHlUkWD1uuUR92wpMSaT4gAd+l4ojvGabhUPNuN2/PeYc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765963819; c=relaxed/simple;
	bh=KmYRgft6YPn7qGsnIuVlTeXixfBnp/HxHOFe7mAL4Sk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=rMAZKE4hx5f5gwE62nr00CV7ZuNG6QH5sdR1iYv9UQvYPCcEo3OCX3bN/6pLmUGWL87aAm+TA7OI+ZIRK8StFRgPa1PH9Ypk0zbyXueH/UOhoDXUJbQOaom6jvX6CvOPH6AtHRldqOh5KQ59IAmW4eUfQDb0kxnejM8QA96tFIo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF1BA4BA2E23
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rb32wrNh
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20251217093016871.JYMO.38814.HP-Z230@nifty.com>;
          Wed, 17 Dec 2025 18:30:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 1/2] Cygwin: path: Implement path_conv::is_app_execution_alias()
Date: Wed, 17 Dec 2025 18:29:54 +0900
Message-ID: <20251217093003.375-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217093003.375-1-takashi.yano@nifty.ne.jp>
References: <20251217093003.375-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765963816;
 bh=mYiox/VB9hFtnjdfEeQP+PMnRZ5tjlONOxkRjAaJNIw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rb32wrNhgO8WFhZPlbafdbVY3ZgkmmJOvs9Rp54EiC3NO6fDSkfKPjmT9xlt+dEJLgewH1/v
 9Perde7YFHhCuUkkdxrqGgpXTQbjdY+X9vr1Mopjzj+Q1OMFYD9AbFL9e8WgEY7QytmNdSW1H8
 u/iGOPc4PNqVHRm5CS7BJfdEkaD+shUKZlSTmJHdP5G7BwtEbzxE7NKRmR698Ft4AbedDJoM19
 j+yg0OmDzBmjqaS0q79E/jEokrCeUWpy7kmg6IIV4D1Fv8GfvU9HEN2bVdv8yPq7LbiFNkT6qR
 vu9Rjwk9A1BHQdyjmRUK3BjywgnjFhaa3pcUsw1kVwU8cj5A==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

An app execution alias cannot be opened for read (CreateFile() with
GENERIC_READ fails with ERROR_CANT_ACCESS_FILE) because it does not
resolve the reparse point.  Therefore, we need to know if the path
is an app execution alias when opening it.

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


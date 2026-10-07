Return-Path: <SRS0=b9Qj=H5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id CDAE448FBCAA
	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2026 00:00:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CDAE448FBCAA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CDAE448FBCAA
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791331261; cv=none;
	b=ReU4c8vLdOrwcvDkTzJ8T6QxBzrc8+VHMpmZNhvV2VadHCcHnlmYlADn54eRLe4pr3Fzbt747Mb2mTAwH6cBD5QOww7c6cwgv3nF7q8zQPxAyL9f3mEdxtMQiN7dKFxfq8UbcY6ZXbe0RGa4lIovT+1CrsJVQvDNsZXyAebyHms=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791331261; c=relaxed/simple;
	bh=QcLflgh3C7mBOR0FpLE69hWAHlUG74DYHoGgKBWUtkM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=j0LMjz9D4EkwN5wx6Y7nW+fTbD603nGPZ+UmuNEW3FDQQUdwieFPXVptedwrGEWxKa5h1t9Q/ZCHlIGL71HxX46KgqtrEKx3RG2TbEUlTFrXqbDztcWkUgfppzbumd1q0SO7THn3DORt/0cnwUTxHf2xzFze7avRym07MTLO6xg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Uu8areD5
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CDAE448FBCAA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Uu8areD5
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20261007000056741.PLOK.44671.HP-Z230@nifty.com>;
          Wed, 7 Oct 2026 09:00:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: devices: Fix the code for device number handling
Date: Wed,  7 Oct 2026 09:00:41 +0900
Message-ID: <20261007000050.100799-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1791331256;
 bh=YfUQZv93Yydd6slmHk4SikoGCiSDNRg6PGaX6AHxbvQ=;
 h=From:To:Cc:Subject:Date;
 b=Uu8areD5etzYHjfU5/fJ2wMrguQzBY3HwneIRm0P4yKzeZ0nq45mPwUNE9dQGKM0Hgn2Q5uX
 IkRiPAw7PHw7kv0M07CDEwHSycVANiJR7unCJ64TJi4A9sXiBDFuxrKu7dtBWMf9p3mRCxpOgU
 4JkHC2gRuoxRKBg76/umKkZxWFGB+NtesJ1c7b9LnHqceNPeif7EsnH0zISFNndOcUzbXIhj9A
 yjSZm/tHiAAaJMGWbnhP+PAiMJSsEJVwjU1M8uAAgTBYvzg+cUtHMQR1nY08azaEpDsMxZarJL
 cU/2BWF/ZN+472WFD+Fj5LE65ZONg3fSnnZGAExcPXZfRK/w==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, the code handling the device number is not match with
the expected code intent. The shift width for the major device
number should be the size of _minor_t, rather than that of
_major_t.

Fixes: 7ac6173643b1 ("* devices.h: Renumber devices based on more Linux-like major/minor numbers.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/devices.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/local_includes/devices.h b/winsup/cygwin/local_includes/devices.h
index 10a46150e..8e02f60bc 100644
--- a/winsup/cygwin/local_includes/devices.h
+++ b/winsup/cygwin/local_includes/devices.h
@@ -11,9 +11,9 @@ details. */
 typedef unsigned short _major_t;
 typedef unsigned short _minor_t;
 
-#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_major_t) * 8)) | (unsigned) (min))
+#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_minor_t) * 8)) | (unsigned) (min))
 #define _minor(dev) ((dev) & ((1 << (sizeof (_minor_t) * 8)) - 1))
-#define _major(dev) ((dev) >> (sizeof (_major_t) * 8))
+#define _major(dev) ((dev) >> (sizeof (_minor_t) * 8))
 
 #include <dirent.h>
 #include "cygheap_malloc.h"
-- 
2.51.0


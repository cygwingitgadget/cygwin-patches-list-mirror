Return-Path: <SRS0=b9Qj=H5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 012E94BA23CE
	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2026 18:00:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 012E94BA23CE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 012E94BA23CE
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791396048; cv=none;
	b=dFV7DlLXCNur4jp4sTCACzD07ROPxpi0opP/n5gcKX1BSA1wYUTnbdhT8w8PEWF7rIjrr52TFXkc7bUF3oSRjX49PR9RASaPdAuYIXZDOiR7I0mIUz0F2Z3ev+ZCxMbG6CFNnM2MubbzZ4RYS8RT0aM1e0VBIY4RUxukLbVHkmE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791396048; c=relaxed/simple;
	bh=DZ+wg28MaYeh5UBZSTURkcP71fJEwXwhMX79DcaJs1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=KXE34wLbmq5tPV0Q/B53j/PsJoQYG1GbxxHWoUpCT9VZDCaTvoq0OGFzPeRB2U+tDeYT0n5a6IN5TRqn0cSwuvK1yySt7FUL0GDR0Yc3xq0K2VkSw3nl5g+WaQSvByWdOkfwEpTtZwDiLDivBFkn+ASIoIc4YTJ6G9Ji0gJyxwA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Lg3/O/Hm
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 012E94BA23CE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Lg3/O/Hm
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20261007180044416.LYR.18412.HP-Z230@nifty.com>;
          Thu, 8 Oct 2026 03:00:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: devices: Fix the code for device number handling
Date: Thu,  8 Oct 2026 03:00:26 +0900
Message-ID: <20261007180038.127193-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1791396044;
 bh=ZptWSS8f3R0+7/3ifOznlygKbGDi+b35LD+iKCYTVB0=;
 h=From:To:Cc:Subject:Date;
 b=Lg3/O/Hm72ojp0ozEUiWO3syPn3VjUU7qSB2O1k7pL2hQz++/03Py2p6eC3cwx8OWhiiOFav
 lFshd/NW0zygZHUTpvNZ9Ho8UM7/EIcr0HHWs+PUFw7+zerid0KR5rdnzhnwvj62Hil3d71eK3
 A7NtWRMMmsISzBkS+mSoxVUssx18Oh0ijvjjqJRerCFctEtlQ3AufiVMYOkr6P+6Sep4Trp8VC
 nTo36TvYlwfEhhkwK848jPhql89aeU6/MHneeR3422495byW8Y6kbcD85uvYR15/bd3qtslgoA
 kKBxXtSKNpR8R8OAFEESxcckhrJduzx7Tqka8vXgoZoba6iQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, the code handling the device number is not match with
the expected code intent. The shift width for the major device
number should be the size of _minor_t, rather than that of
_major_t.

Fixes: 7ac6173643b1 ("* devices.h: Renumber devices based on more Linux-like major/minor numbers.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/devices.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/local_includes/devices.h b/winsup/cygwin/local_includes/devices.h
index 10a46150e..a72bf57fa 100644
--- a/winsup/cygwin/local_includes/devices.h
+++ b/winsup/cygwin/local_includes/devices.h
@@ -11,9 +11,10 @@ details. */
 typedef unsigned short _major_t;
 typedef unsigned short _minor_t;
 
-#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_major_t) * 8)) | (unsigned) (min))
-#define _minor(dev) ((dev) & ((1 << (sizeof (_minor_t) * 8)) - 1))
-#define _major(dev) ((dev) >> (sizeof (_major_t) * 8))
+#define FHDEV(maj, min) \
+  ((((unsigned) (maj)) << (sizeof (_minor_t) * CHAR_BIT)) | (unsigned) (min))
+#define _minor(dev) ((dev) & ((1 << (sizeof (_minor_t) * CHAR_BIT)) - 1))
+#define _major(dev) ((dev) >> (sizeof (_minor_t) * CHAR_BIT))
 
 #include <dirent.h>
 #include "cygheap_malloc.h"
-- 
2.51.0


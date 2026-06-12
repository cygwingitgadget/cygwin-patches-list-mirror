Return-Path: <SRS0=9siz=EI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id B02624BA2E16
	for <cygwin-patches@cygwin.com>; Fri, 12 Jun 2026 12:47:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B02624BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B02624BA2E16
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781268457; cv=none;
	b=wE9+nHj7gFFtubXWj0mwc6YxoXQCkw7IlpHVfniV/O/upl8m/JFB9fKL1foCytG/9eaZOtmvddIxNpy2EeKlszZjJo/Uq5nMMaIy3NeMMyCgCuptMZJI0xgFiCfPPDn/rP99orRN9a5Q0R2YkSRDCm5AnLwIh9nB529xra4Hytk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781268457; c=relaxed/simple;
	bh=to9hZjv69gTgRB6Tmo18H/lLJ5Ydh77mFc/+5HueuVU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=aDHghNWxPj2fJroX5XeqdAB8LkYPeNNMJmoRvxGDXK0vdN/rmhuw6gcXyt4XGtHohquAfa/aetN0+uDgvjhHesAzrBOPmS/CfSebeqyx330l7Nk683AYVnzii64zaPSDm6csHcAp0MApmd6/JJGYmOPLFoEgUeTCmLaywaLjdZM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PIU2f1Vn
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B02624BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PIU2f1Vn
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260612124733661.FPCO.17441.HP-Z230@nifty.com>;
          Fri, 12 Jun 2026 21:47:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in transfer_input()
Date: Fri, 12 Jun 2026 21:47:21 +0900
Message-ID: <20260612124728.38921-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781268453;
 bh=D1qbscOZivncnWN0DG65YWWB936kNtTPie+Mdb3+yqo=;
 h=From:To:Cc:Subject:Date;
 b=PIU2f1VnGzmMdSkv4yArPhBMX6z1SLGz5oEaY/udJOshMzX2J+S5hCEQ+dpMU9Gb+wL1H+gA
 86CjVmv2GrB+mmE3H4+k9U8mlGThx7VIae0UPkTapyXCsPPhKpv1MM/l47FDmqW6rFOe/rWcr7
 1/vgoLX7Rza3vlHRXW3YV4m/sznFYgflGYz0x0wJcta+KU/OpA/Op+3J8vZCTNUTqV/yhbygeG
 vUgYEalXp4e3ZCHFmTOzSGkgw+i0G1F+zrto5aFVlidmM4Tq/oD69vjzUmGsClg77EtdgwLsYC
 Q1gsFCaf8uMEYqatqkG1A0R7zoV7EuMQt7ppkhH9fB+kOuUQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In transfer_input(), CR and NL in the data transferred to nat-pipe
is treated as follows:
  1) If pseudo console is activated, convert NL to CR.
  2) If pseudo console is disabled, convert CR to NL.
This conversion is necessary to ensure non-cygwin apps can handle
CR/NL as expected. Therefor, CR and NL should be treated as the
same way in accept_input() if the data is sent to nat-pipe.

Usually, when pseudo console is activated, the input data for non-
cygwin app is not treated by accept_input. However, accept_input()
handle the input data in pseudo console enabled mode, only in a
very short duration when pseudo console is about to setup, because
master::write() calls line_edit() in the pcon_start mode. If pseudo
console is disabled, accept_input() handles them, however usually
ICRNL flag is set, so line_edit() do this conversion. However, if
this flag is not set, the conversion added by this patch is needed
as well.

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index ef79ea679..30918c2f3 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -690,6 +690,14 @@ fhandler_pty_master::accept_input ()
 	  p = mbbuf;
 	  bytes_left = nlen;
 	}
+
+      char *p0 = p;
+      if (get_ttyp ()->pcon_activated)
+	while ((p0 = (char *) memchr (p0, '\n', bytes_left - (p0 - p))))
+	  *p0 = '\r';
+      else
+	while ((p0 = (char *) memchr (p0, '\r', bytes_left - (p0 - p))))
+	  *p0 = '\n';
     }
 
   if (!bytes_left)
-- 
2.51.0


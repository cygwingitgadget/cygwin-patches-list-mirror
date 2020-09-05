Return-Path: <arthur2e5@aosc.io>
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com
 [217.182.119.155])
 by sourceware.org (Postfix) with ESMTPS id 002173857C5B
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 05:27:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 002173857C5B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=arthur2e5@aosc.io
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id ACB0A3F1CC
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 07:27:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id D2F4B2A0F4
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 01:27:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1599283659;
 bh=+K8bnC+ka7DNLPSDUMP+o7g13Xqc9Qp5UuJhO9e1GKQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q6JhEidWgp+qT4OSEkSafFrglHba8vVMf7aYFRGAwQmaZM32ZwJ5K1OyXUWJ18yQA
 IIcMe/pnROiNkZbQ0svDqxyRzlizKSrB5hKF/DSdrggl/81IscD5/5KcqLpIp5Y3V3
 3sDy5vo7L03roHc+WlpDW5CejfPd5b+6kupQhRs4=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DsGLYqgoY6l for <cygwin-patches@cygwin.com>;
 Sat,  5 Sep 2020 01:27:39 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 01:27:38 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id C11B34083E;
 Sat,  5 Sep 2020 05:27:36 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=aosc.io header.i=@aosc.io header.b="YQnqI3S2"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from localhost.localdomain (unknown [222.70.42.237])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id CD7CD4083E;
 Sat,  5 Sep 2020 05:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1599283652; bh=+K8bnC+ka7DNLPSDUMP+o7g13Xqc9Qp5UuJhO9e1GKQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YQnqI3S21dGpB1PArkUmygAiHCUtESMVSrC4GuyEJZgxoEJYgbaeCGDZiZEggOZ3+
 oYzWb9hnln8S6V/hjACWabq/MVpS8leHac1U9oRITWiL58flrIuTPfzWaMQoIwIOwn
 t0UKDD/9gQPn3TuxBep11FUCPhWRqfCTnYzt6bTc=
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Cc: Mingye Wang <arthur2e5@aosc.io>
Subject: [PATCH v4 2/3] regparm: make code highlight happy
Date: Sat,  5 Sep 2020 13:27:10 +0800
Message-Id: <20200905052711.13008-2-arthur2e5@aosc.io>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20200905052711.13008-1-arthur2e5@aosc.io>
References: <20200905052711.13008-1-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C11B34083E
X-Spamd-Result: default: False [4.90 / 20.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[aosc.io:s=default];
 RECEIVED_SPAMHAUS_PBL(0.00)[222.70.42.237:received];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(0.00)[aosc.io];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(0.00)[~all];
 ML_SERVERS(-3.10)[213.133.102.83]; DKIM_TRACE(0.00)[aosc.io:+];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 RCVD_COUNT_TWO(0.00)[2];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_40, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 05 Sep 2020 05:27:43 -0000

---
 winsup/cygwin/regparm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/regparm.h b/winsup/cygwin/regparm.h
index cce1bab4a..a14c501db 100644
--- a/winsup/cygwin/regparm.h
+++ b/winsup/cygwin/regparm.h
@@ -8,7 +8,7 @@ details. */
 
 #pragma once
 
-#if defined (__x86_64__) || defined (__CYGMAGIC__)
+#if defined (__x86_64__) || defined (__CYGMAGIC__) || !defined (__GNUC__)
 # define __reg1
 # define __reg2
 # define __reg3
-- 
2.20.1.windows.1

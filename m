Return-Path: <arthur2e5@aosc.io>
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
 by sourceware.org (Postfix) with ESMTPS id BD27E3857C5B
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 05:27:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BD27E3857C5B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=arthur2e5@aosc.io
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay2.mymailcheap.com (Postfix) with ESMTPS id B80923ECD9
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 07:27:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 94F502A7D8
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 07:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1599283671;
 bh=ZZyt75LyZ9fFP26xgJ6VSyVu4JpMAjS5FblOKkb16WQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0FZ30znDAwaNakeVt8A/162NMndZQ3CMtB3KgaHhaYEd99REb5DZkCSPFd8DAle0L
 M1WzbIIGLEx7QGJmimwdhCV0r2b1m9RPLWcK8Qe2Z41620xFHqj+pYYBK81G42oXGR
 ztG+L3j3DqfWrlb1fC2fDY/ucGvHmbAx6hBgnPyQ=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BCY6ziMzPlBs for <cygwin-patches@cygwin.com>;
 Sat,  5 Sep 2020 07:27:50 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 07:27:50 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 57D284085B;
 Sat,  5 Sep 2020 05:27:50 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=aosc.io header.i=@aosc.io header.b="kY8RI/9r"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from localhost.localdomain (unknown [222.70.42.237])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 68E374083E;
 Sat,  5 Sep 2020 05:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1599283655; bh=ZZyt75LyZ9fFP26xgJ6VSyVu4JpMAjS5FblOKkb16WQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kY8RI/9r5d5Kmpk+mKY4JRsZz33gz4bu/L9Jp8dCkn93OyuzQ6EUTYcJk4JUrK3JF
 vxkEK9h4+kC4diAXOWOVt1N13SmNSi63tskaums1sF+MtRwUoZkhsWjdGruJkNW4j2
 R6orrzg0YZ6OIwk8LljP0pYlO/x8rauR/SFklQ+0=
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Cc: Mingye Wang <arthur2e5@aosc.io>
Subject: [PATCH v4 3/3] testsuite: don't strip dir from obj files
Date: Sat,  5 Sep 2020 13:27:11 +0800
Message-Id: <20200905052711.13008-3-arthur2e5@aosc.io>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20200905052711.13008-1-arthur2e5@aosc.io>
References: <20200905052711.13008-1-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57D284085B
X-Spamd-Result: default: False [4.90 / 20.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(0.00)[aosc.io:s=default];
 RECEIVED_SPAMHAUS_PBL(0.00)[222.70.42.237:received];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(0.00)[aosc.io];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(0.00)[~all:c];
 ML_SERVERS(-3.10)[148.251.23.173]; DKIM_TRACE(0.00)[aosc.io:+];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 05 Sep 2020 05:27:54 -0000

Make has no idea how to build an o file when the correspoinding c file
is not there. That happens when we strip the dir.
---
 winsup/testsuite/Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/testsuite/Makefile.in b/winsup/testsuite/Makefile.in
index bdc116d12..ad3656be8 100644
--- a/winsup/testsuite/Makefile.in
+++ b/winsup/testsuite/Makefile.in
@@ -75,7 +75,7 @@ endif
 RUNTIME=$(cygwin_build)/cygwin0.dll $(cygwin_build)/libcygwin0.a
 
 TESTSUP_LIB_NAME:=libltp.a
-TESTSUP_OFILES:=${sort ${addsuffix .o,${basename ${notdir ${wildcard $(libltp_srcdir)/lib/*.c}}}}}
+TESTSUP_OFILES:=${sort ${addsuffix .o,${basename ${wildcard $(libltp_srcdir)/lib/*.c}}}}
 
 override ALL_CFLAGS:=${filter-out -O%,$(ALL_CFLAGS)}
 override COMPILE_CC:=${filter-out -O%,$(COMPILE_CC)}
-- 
2.20.1.windows.1

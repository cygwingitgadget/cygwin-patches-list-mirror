Return-Path: <arthur2e5@aosc.io>
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
 by sourceware.org (Postfix) with ESMTPS id 9BCDD385800F
 for <cygwin-patches@cygwin.com>; Sat,  7 Nov 2020 12:13:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9BCDD385800F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=arthur2e5@aosc.io
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 374F53F201
 for <cygwin-patches@cygwin.com>; Sat,  7 Nov 2020 12:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 7DEE22A522
 for <cygwin-patches@cygwin.com>; Sat,  7 Nov 2020 13:13:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1604751183;
 bh=0spm3cq9pyWF9P7e3JDv39lSZJgGvlMZsHT4hftEAxA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=GqwXu+reFD0vQRdQVt3opmrN3IHX2pCDk86aITAGBqlsn/dW5Qm+THwIDHbPqQx25
 vsgPOjQIKHI1jEiDsm0ON+jcrZoyb1t+RzfARkP5C15H+vzVKDXrRfpOVcFsXw/nHb
 QUiSrTecH5dVl+UpPBa9jr5pDc7XTMqIh9sE+pHM=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3jqTnIi4ENQJ for <cygwin-patches@cygwin.com>;
 Sat,  7 Nov 2020 13:13:02 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS
 for <cygwin-patches@cygwin.com>; Sat,  7 Nov 2020 13:13:02 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 506F54102D
 for <cygwin-patches@cygwin.com>; Sat,  7 Nov 2020 12:13:00 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=aosc.io header.i=@aosc.io header.b="akiaTX3B"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from localhost.localdomain (unknown [61.170.181.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 373974102D
 for <cygwin-patches@cygwin.com>; Sat,  7 Nov 2020 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1604751174; bh=0spm3cq9pyWF9P7e3JDv39lSZJgGvlMZsHT4hftEAxA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=akiaTX3BhD0gHjhLI26ggI0gUmLR+bj8N9LmRyYRLm+JrzcTGnofdjfiBjKrszXYU
 rvsbuMP2dPUOVLy24fDvvdr6rCz1vFUwm5i2Rm54A7xCHYTSSZJJUPbhjSifKq1Vz8
 axS65Sd9uiI+o6NhIIXVqGYtw6CaY8zZeIVGA/s8=
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5] Cygwin: rewrite cmdline parser
Date: Sat,  7 Nov 2020 20:12:20 +0800
Message-Id: <20201107121221.6668-1-arthur2e5@aosc.io>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20200905052711.13008-3-arthur2e5@aosc.io>
References: <20200905052711.13008-3-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 506F54102D
X-Spamd-Result: default: False [4.90 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[aosc.io:s=default];
 RECEIVED_SPAMHAUS_PBL(0.00)[61.170.181.153:received];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[cygwin-patches@cygwin.com];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(0.00)[~all];
 RCPT_COUNT_ONE(0.00)[1]; TO_DN_NONE(0.00)[];
 ML_SERVERS(-3.10)[148.251.23.173]; DKIM_TRACE(0.00)[aosc.io:+];
 MID_CONTAINS_FROM(1.00)[]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2]; DMARC_NA(0.00)[aosc.io];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam: Yes
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_BARRACUDACENTRAL,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sat, 07 Nov 2020 12:13:06 -0000

This is the fifth version of the patch. I thought I sent this in
October...

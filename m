Return-Path: <cygwin-patches-return-9633-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64923 invoked by alias); 5 Sep 2019 04:23:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64905 invoked by uid 89); 5 Sep 2019 04:23:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 04:23:15 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x854N0rC007571;	Thu, 5 Sep 2019 13:23:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x854N0rC007571
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567657384;	bh=HRWiiFF/5/WlXCalSnHxVeeyoOCPE0EK1lZ14U+Ts28=;	h=From:To:Cc:Subject:Date:From;	b=P1FcG6pSiUllTWcc3pyxp1y/QJx+Uwi1GGVUCEw2XVC/eDwEvaCe2xJtWVKIXVanY	 6dWaRRJ96obrnnqzflZv+1miXNi5KslojYw40R1XlsvFk/+CCULKNXQCfs3qp3nym6	 1dU8Onu36nz52BdMl6+A4Gy1Fase014yYxLBHLQWYczUDhxMHG6fbDJULIYNVlNK9S	 opdMO/c6OxeTKqurkqaOhHmZdtTHQriSf1hT95sabp11y14SsgYRSJEUS7fQ7UrAxX	 zKCHeuANa1ZA11WhqZpoWUuN9HKby2qwp0Ph+RQ67blogz9cVsi7ekFQ8LWIF1ICT7	 YE15/4j9Yz2Yg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Cygwin: pty: Fix select() with pseudo console support.
Date: Thu, 05 Sep 2019 04:23:00 -0000
Message-Id: <20190905042254.1954-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00153.txt.bz2

- select() did not work correctly when both read and except are
  polled simultaneously for the same fd and the r/w pipe is switched
  to pseudo console side. This patch fixes this isseu.

Takashi Yano (1):
  Cygwin: pty: Fix select() with pseudo console support.

 winsup/cygwin/fhandler.h      |  15 +++
 winsup/cygwin/fhandler_tty.cc |  13 ++-
 winsup/cygwin/select.cc       | 192 ++++++++++++++++++++++++++++++++--
 winsup/cygwin/select.h        |   2 +
 4 files changed, 207 insertions(+), 15 deletions(-)

-- 
2.21.0

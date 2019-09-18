Return-Path: <cygwin-patches-return-9700-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92889 invoked by alias); 18 Sep 2019 20:50:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92877 invoked by uid 89); 18 Sep 2019 20:50:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 20:50:27 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x8IKo3NM004996;	Thu, 19 Sep 2019 05:50:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x8IKo3NM004996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568839821;	bh=5+G2j1mR7ncLij1A3ObnmR8ETLB0Wo5wF6T86SMBEfs=;	h=From:To:Cc:Subject:Date:From;	b=Za9UOsoXr01DWlgt07PX+D7oqDFQpwjXw07/q+xZANyQYrAXfgaJ/07C340Jyl3ie	 7NJtbBTjFusj9ld85BNd1M9BS1REG59LKF+KUdPfxbwTEVMcc7phBVxo/mCGoCKjkJ	 ck/ZZ1QSJSKbD0981rwg0W3DMsQySIHkDcM+By4CZhyKO+pmzkvrXxeXqq+96oUHEn	 wtt4RhCtHWU9dz1iGjZqjkkvBvNO+oZlRMWWCCufZPw5h9qSEzcGfYUJGvxErliJi8	 FKiihkeYPTtlf4K20moLwy1aEFcDcE3fI0rzc7mwtCJF2xIgqQlp1zO2f154NqJV9G	 RbWf15AmpHjpA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/1] Cygwin: console: Revive Win7 compatibility.
Date: Wed, 18 Sep 2019 20:50:00 -0000
Message-Id: <20190918204955.2131-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00220.txt.bz2

- The commit fca4cda7a420d7b15ac217d008527e029d05758e broke Win7
  compatibility. This patch fixes the issue.

v2:
Move definition of INREC_SIZE into fhandler.h from fhandler_console.cc
and select.cc.

Takashi Yano (1):
  Cygwin: console: Revive Win7 compatibility.

 winsup/cygwin/fhandler.h          | 6 ++++++
 winsup/cygwin/fhandler_console.cc | 6 ------
 winsup/cygwin/select.cc           | 1 -
 3 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.21.0

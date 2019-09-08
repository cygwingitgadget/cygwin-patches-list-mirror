Return-Path: <cygwin-patches-return-9664-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81103 invoked by alias); 8 Sep 2019 13:23:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81083 invoked by uid 89); 8 Sep 2019 13:23:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 08 Sep 2019 13:23:42 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x88DNRXV011391;	Sun, 8 Sep 2019 22:23:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x88DNRXV011391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567949012;	bh=Skear+i/mR/6PhHhEl4HDldl/BAWyOcDUwILihphBAI=;	h=From:To:Cc:Subject:Date:From;	b=j00iy24DlyUdymPBlmylD5ZxBTuX2sFrkF8SDtX6FS0246TL+dgtI0B7w4hiX6CRr	 rn6rlTxCN4kwe64IwB3/UHnK/JTmfX5mHECVNdQljInKCBwQi6tWgJBSopbgAmLtfF	 7awoOUWfDkR+ZMpxOOEGjTTs436AX+o9BWtsnJYDrzM/kSZfEmWXqcEAajxRhr5SzK	 ykubHOST1MNR4Sed+LYS4ewf1V2Mb6F+LN8B5CXtTXr3k8+mk3GN9y0jpgalAwVqSo	 u8CaiAWcw0MwcGxRIuB0er/WmD9ze0MwWiG2KSSYD/XTxbLBn6644MyiAJx8TdeJjF	 w3Pr5ngDCqg/g==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Cygwin: pty: Fix screen alternation while pseudo console switching.
Date: Sun, 08 Sep 2019 13:23:00 -0000
Message-Id: <20190908132323.860-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00184.txt.bz2

- If screen alternated while pseudo console switching, it sometimes
  failed. This might happen when the output of the non-cygwin program
  is piped to less. The problem 3 reported in
  https://cygwin.com/ml/cygwin-patches/2019-q3/msg00175.html
  is probably due to this. This patch fixes this issue.

Takashi Yano (1):
  Cygwin: pty: Fix screen alternation while pseudo console switching.

 winsup/cygwin/fhandler_tty.cc | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.21.0

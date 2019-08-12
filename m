Return-Path: <cygwin-patches-return-9562-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56987 invoked by alias); 12 Aug 2019 13:49:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56923 invoked by uid 89); 12 Aug 2019 13:49:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-11.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Aug 2019 13:49:02 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x7CDmj20022710;	Mon, 12 Aug 2019 22:48:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x7CDmj20022710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565617731;	bh=r2PLSJpo0uHK4qbWED57F/U/aqY/AsxVWuGmmc2MbI8=;	h=From:To:Cc:Subject:Date:From;	b=2U9o28TrmsDwdRde05SY0cd8fYdPeO8rPwUOt2ERtx7MCgxJroRgv2jqncTRfRnvU	 rWiaao7tumk7SLc+BzNbCqVgcAH5MPbwXkAuYKG+rVfk9ZHBbeWnzazzx2OrDYLfdF	 gHBxQB/v5z5S2AYn8DL4bJ/dGdy7FhmMhLkWErlw2M+InfNR1CKY2iju1+kfMVZUkr	 VIsPHkpCQC28zS+U3alZSVLX3dw2ZGlB1NV6beEQYqoJweQqwPd3eiuAH8bwRXowPR	 +fjTiM5OORD3EMhEJvIrNlbFy5SENdOupRyc+mnNYje4baFxVx8NfBuKa35od7AGZU	 j9w/8/v8ZDwrA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Fix cursor position restoration on console
Date: Mon, 12 Aug 2019 13:49:00 -0000
Message-Id: <20190812134845.2249-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00081.txt.bz2

In cygwin test release 3.1.0-0.1, the cursor position is not restored
correctly after screen alternation in the case of xterm compatible mode
is enabled. For example, the shell prompt is shown at incorrect position
after using vim. This patch fixes this problem.

Takashi Yano (1):
  Cygwin: console: Fix cursor position restore after screen alternation.

 winsup/cygwin/fhandler_console.cc | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.21.0

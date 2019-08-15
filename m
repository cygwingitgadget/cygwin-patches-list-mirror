Return-Path: <cygwin-patches-return-9569-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17211 invoked by alias); 15 Aug 2019 05:03:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17186 invoked by uid 89); 15 Aug 2019 05:03:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Aug 2019 05:03:22 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x7F539N1011273;	Thu, 15 Aug 2019 14:03:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x7F539N1011273
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565845394;	bh=sPEE1Kmqr9bSAWyyYUswXflmf/zJpNScvEkobw3aU0Q=;	h=From:To:Cc:Subject:Date:From;	b=WdFFvGhzq2DCxzjMU4ZGnwMgnYnD5NObN/3ODf2cR9Fr/Kfa8Qp2DHIL6BaZHcOqT	 ddUPKR35dTqqZMKD309IPVbifVR3rar5lt8ldLbmwKNzUaRD0US5x5Z+uLdh0zjHMw	 Dzfooi+CRuFwrd62mwkk+5zJBD42CBT/UjJwViAEKjmR0gp1LTC00sTYI5Z573FExi	 Sh3M6QZJbCJaKm4rzvfNPHoz4F7cjUPy8ylGolyZBdV/XBhZeWA/ipuyj6ZTL4NS7t	 YXyg4vknnfGThOPGFeo6WWXGYfd87n8ixghkn9sGHrV2DUU2H5XYmr5Ey+mScRXdot	 HcA+K4y8wHeGA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Fix select() regarding SIGWINCH in console
Date: Thu, 15 Aug 2019 05:03:00 -0000
Message-Id: <20190815050300.6380-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00089.txt.bz2

In cygwin test release 3.1.0-0.1, script command (from util-linux)
is terminated abnormaly if the window size is changed in the case
that cygwin is running in command prompt. This patch fixes this
issue.  This problem occurs when select() or poll() returns with
EINTR by SIGWINCH even though SIGWINCH is ignored. This patch adds
code so that select() is not interrupted by SIGWINCH when it is
ignored (SIG_IGN or SIG_DFL).

Takashi Yano (1):
  Cygwin: console: Fix the condition to interrupt select() by SIGWINCH

 winsup/cygwin/select.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.21.0

Return-Path: <cygwin-patches-return-9557-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51353 invoked by alias); 12 Aug 2019 13:46:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51321 invoked by uid 89); 12 Aug 2019 13:46:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit, H*F:D*jp
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Aug 2019 13:46:36 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x7CDkP1M012869;	Mon, 12 Aug 2019 22:46:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x7CDkP1M012869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565617590;	bh=ujxBNFbYwtiXQdPRTMnBojnMk+15R5C+zLuR/MTV9mA=;	h=From:To:Cc:Subject:Date:From;	b=pUMpBYaq9QLPcUrl4fe4V2FBG5w1SwqlPJSyIxjiZKYl6JWU4x7BgZbuoGqH5s5D8	 PwCFk5K7NMEsWPXrY9tt2WYwEbFYY4hPeRuT0FpaEKNkQStGX2aecMTij+97V/uSvI	 1/0FayETj5p/BYQH4kWHfPhiXJP9n/+YumPbz2IIMNFQVY3w+4L1jX7aw+u8HmCBgn	 biAAr+hsX4zB4jkQeJXw6lowWbPETcWcXprH9dNCMfAkJSqGbuEz1i0F/2+C96BOta	 dAP3WM6rs+L1rUbzT2eH0aoX2DSailQGkmJTqOn8K5X3S55iapT5TQ6OJvLUmItkDR	 1tk82N8GjJohA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Fix deadlock at calling fork() in console
Date: Mon, 12 Aug 2019 13:46:00 -0000
Message-Id: <20190812134623.2102-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00077.txt.bz2

In cygwin test release 3.1.0-0.1, calling fork on console ocasionally
falls into deadlock. The reason is not clear, however, this patch fixes
this problem anyway.

Takashi Yano (1):
  Cygwin: console: Fix deadlock at calling fork().

 winsup/cygwin/fhandler_console.cc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.21.0

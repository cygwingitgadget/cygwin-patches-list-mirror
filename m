Return-Path: <cygwin-patches-return-9646-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10575 invoked by alias); 6 Sep 2019 13:01:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10558 invoked by uid 89); 6 Sep 2019 13:01:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:386, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 13:01:53 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x86D1S7p006600;	Fri, 6 Sep 2019 22:01:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x86D1S7p006600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567774893;	bh=v0LCN+l0Wbo+e0shx3og6QNqUnJLgfuVhmOwEc80FlM=;	h=From:To:Cc:Subject:Date:From;	b=hbGdwxhY1IpjIYfEGBDvWBtOoXJMnmgTwIiU1kUxh6f7nVmIWUWwb0TuaBbDh0WzD	 oaqRn3k8DC5zv/6ilsqWqXwWYxY4bjqbI1RXuQCvsUrBfgYd8YVbpQG8UYUrhRZKf5	 oCcoxySWaUayDtXlClBvC/a1SJuh4959B7TMBObnhB6cnKCm1h45woZ/eL1bDg+1Ay	 LQmfWTkYBwktfMktAWJ2ZWzQYYrCBDQVIhH7ORNAYfHw8BcPNCwknrGUGR+bfnfCPO	 GBbm4mhXRGQ2Dm6w6HpeZj1pH2pFbzwC80F1S3BmHZqICZ17S3JqvtKedcarswX3GS	 5ad/Ym2zxp5uQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Cygwin: pty: Make SetConsoleCursorPosition() to be hooked.
Date: Fri, 06 Sep 2019 13:01:00 -0000
Message-Id: <20190906130127.1928-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00166.txt.bz2

- Win32 API SetConsoleCursorPosition() injects ANSI escape sequence
  to pseudo console. Therefore, it should be added to the API list
  to be hooked.

Takashi Yano (1):
  Cygwin: pty: Make SetConsoleCursorPosition() to be hooked.

 winsup/cygwin/fhandler_tty.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.21.0

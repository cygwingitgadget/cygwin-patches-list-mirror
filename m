Return-Path: <cygwin-patches-return-9667-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80447 invoked by alias); 13 Sep 2019 19:34:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80436 invoked by uid 89); 13 Sep 2019 19:34:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:jp, HX-Languages-Length:798, H*F:D*ne.jp, device
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 13 Sep 2019 19:34:15 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x8DJY1PW005787;	Sat, 14 Sep 2019 04:34:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x8DJY1PW005787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568403246;	bh=Szutu7EhZHjS0mLpfNq06y7HhOFyZH543D1BgEt29/U=;	h=From:To:Cc:Subject:Date:From;	b=evk0QHm+RFdPI9IZfGBP3ASli2DOSXQUDCxmBE6YslSIQQNSh6pZKqS6oTP+F94q8	 LC1UA6W+sqkFMsjpzQ18gn0qTPJXRayxePlO8t49mTtezgIv9q/jqgnAfNob7Gkhox	 pKrEyFB8MdiaC5VpBXSslNc2E8lH0IbozvgaJ3eIDrO4z4U94a5bquUXPNDptY6qsS	 hu6NXnlWJRHXaUe73e0xWIfH1fITuJXhTzSimIQhUgH+OUToI0ARVKy0vERU7fHSGZ	 IQvk2Dae81Fw4romi6AfjngLz8XKvBLPCagJFDnl+zH5VWYG2xGYIsljTL9bCvyqFD	 AfuywxXCmDwrA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Cygwin: pty: Switch input and output pipes individually.
Date: Fri, 13 Sep 2019 19:34:00 -0000
Message-Id: <20190913193356.1517-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00187.txt.bz2

- Previously, input and output pipes were switched together between
  the traditional pty and the pseudo console. However, for example,
  if stdin is redirected to another device, it is better to leave
  input pipe traditional pty side even for non-cygwin program. This
  patch realizes such behaviour.

Takashi Yano (1):
  Cygwin: pty: Switch input and output pipes individually.

 winsup/cygwin/dtable.cc           |   6 +-
 winsup/cygwin/fhandler.h          |   9 +-
 winsup/cygwin/fhandler_console.cc |   7 +-
 winsup/cygwin/fhandler_tty.cc     | 256 ++++++++++++++++++++----------
 winsup/cygwin/select.cc           |   4 +-
 winsup/cygwin/spawn.cc            |  44 +++--
 winsup/cygwin/tty.cc              |   5 +-
 winsup/cygwin/tty.h               |   5 +-
 8 files changed, 209 insertions(+), 127 deletions(-)

-- 
2.21.0

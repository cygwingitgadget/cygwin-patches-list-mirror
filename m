Return-Path: <cygwin-patches-return-9581-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44392 invoked by alias); 31 Aug 2019 22:55:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44382 invoked by uid 89); 31 Aug 2019 22:55:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Small, management, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 31 Aug 2019 22:55:07 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x7VMso1J015184;	Sun, 1 Sep 2019 07:54:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x7VMso1J015184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567292098;	bh=o/+/NE04vkfnyJ2BYTLNfPhB1jVdnisIA/gJFyNasQk=;	h=From:To:Cc:Subject:Date:From;	b=FJsifgNhWMVOgzGFCFAmfYN35QnHqy1GJR5RL8YJEDV0p2mhqq6OXKiNJ/63fYP9F	 k4cofjXeLgRdLvgPupKOMTzY+MHSt94xpBrklic3uMw+xK11I2QgocshvyUxeQqqg0	 E8CI0l1tct9uxjEFQfNgAVOGz/NqoTcXfie0p1gdo4ldcSxw4tnOc5ovtZyvRUY8Lw	 jTyv7NUWfTyKCGOc0YFB9xAdLFnn4MlYxnnJWMuEttly2Bg2yvr14cHChVuu8IuPY+	 ox3P4fg0JNoNoUt5IFVf/tOLw41LIcyU5+jRSwNlRMSXJwVJjrJmyblrHP1pghSpbw	 goOptxy+ECJMw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/1] Fix PTY state management in pseudo console support.
Date: Sat, 31 Aug 2019 22:55:00 -0000
Message-Id: <20190831225446.1506-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00101.txt.bz2

Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
has some bugs which cause mismatch between state variables and
real pseudo console state regarding console attaching and r/w
pipe switching. This patch fixes this issue by redesigning the
state management.

v2:
Small bug fixed from v1.

Takashi Yano (1):
  Cygwin: pty: Fix state management for pseudo console support.

 winsup/cygwin/dtable.cc           |  15 +-
 winsup/cygwin/fhandler.h          |   6 +-
 winsup/cygwin/fhandler_console.cc |   6 +-
 winsup/cygwin/fhandler_tty.cc     | 404 ++++++++++++++++--------------
 winsup/cygwin/fork.cc             |  24 +-
 winsup/cygwin/spawn.cc            |  65 ++---
 6 files changed, 283 insertions(+), 237 deletions(-)

-- 
2.21.0

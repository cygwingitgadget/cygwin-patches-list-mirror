Return-Path: <cygwin-patches-return-9588-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18140 invoked by alias); 1 Sep 2019 22:12:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18130 invoked by uid 89); 1 Sep 2019 22:12:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=management, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 01 Sep 2019 22:12:14 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x81MC2dl012304;	Mon, 2 Sep 2019 07:12:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x81MC2dl012304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567375926;	bh=lMLed4YDTVEcPTj2ukCIuiFho+9PQRwlwGbt/VIXDE0=;	h=From:To:Cc:Subject:Date:From;	b=G5usTRETCEvY3h0AkNqjSYui6g+aej7RIyJ0d4xMYVilZodf4o2A18a8oQWdxcp4c	 iLxq/t2YAHqtGMjtO07rZquakeGpAdeZ6p7w59BbhGfKCJiXvb9R+IxFi4hJzV3kWP	 i1D/V0bg2L2uYfmb0uFIVG3YAredQP7EJWpfuSXzZHPCPFtjGerBlUMO49Z5dWKHwS	 aDuaK182hTrR2MwDYVDAe6ztcfx3NQFVAr4o7Monp8SFtn6v8pboO4wNO4s3pd7uwO	 00DglatsBsRovIZR+3A73G9p4lMnj4d+X8EZkQp+YL9NvCMWcavc7gVPpcxamYMIVc	 sNYbbPoVUGqmQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 0/1] Fix PTY state management in pseudo console support.
Date: Sun, 01 Sep 2019 22:12:00 -0000
Message-Id: <20190901221156.1367-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00108.txt.bz2

Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
has some bugs which cause mismatch between state variables and
real pseudo console state regarding console attaching and r/w
pipe switching. This patch fixes this issue by redesigning the
state management.

v4:
Small bug fix again.

v3:
Fix the first issue (Bad file descriptor) reported in
https://cygwin.com/ml/cygwin-patches/2019-q3/msg00104.html

v2:
Small bug fixed from v1.


Takashi Yano (1):
  Cygwin: pty: Fix state management for pseudo console support.

 winsup/cygwin/dtable.cc           |  15 +-
 winsup/cygwin/fhandler.h          |   6 +-
 winsup/cygwin/fhandler_console.cc |   6 +-
 winsup/cygwin/fhandler_tty.cc     | 415 ++++++++++++++++--------------
 winsup/cygwin/fork.cc             |  24 +-
 winsup/cygwin/spawn.cc            |  65 +++--
 6 files changed, 289 insertions(+), 242 deletions(-)

-- 
2.21.0

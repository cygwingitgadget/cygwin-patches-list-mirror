Return-Path: <cygwin-patches-return-9586-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6244 invoked by alias); 1 Sep 2019 21:58:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6156 invoked by uid 89); 1 Sep 2019 21:58:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=management, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 01 Sep 2019 21:58:07 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x81LvkaL022613;	Mon, 2 Sep 2019 06:57:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x81LvkaL022613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567375072;	bh=D15+LpYHtw2h7YQnNNw0n43XqGvEQsryvuv09T7Q7iU=;	h=From:To:Cc:Subject:Date:From;	b=PgzIKLN8eYz1UTCP6RuO6yExK/rIgVoqCaSbqdy25/mG2Kc/UXY1vpJyE3oSL7d6D	 3bAsljW7FzedzoNqjUbam10QzHQtxd8A8gAVbdsKrxLn2CgupDyOnn6bL6GNajALQq	 a4m3ULCYMXHRuesE8Q7eInfH0e1+pOlWbAFR+FnBtGMUonWjInoewl0ZxTwlK13XFZ	 frvWhsJvjT9KQKyl6l9LdkNKuNWl5gYia+ARsLKWOuCUvhMRGTNR9DgQeNtCfyx19l	 JnojQQ6r5eBnjYRJkKuRuKmhfx6FJOtXPy07qZ1oWzW9brznyt2enrO+xLhsVM9w1m	 sEJM0aOU9v5jw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/1] Fix PTY state management in pseudo console support.
Date: Sun, 01 Sep 2019 21:58:00 -0000
Message-Id: <20190901215741.752-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00106.txt.bz2

Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
has some bugs which cause mismatch between state variables and
real pseudo console state regarding console attaching and r/w
pipe switching. This patch fixes this issue by redesigning the
state management.

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
 winsup/cygwin/fhandler_tty.cc     | 413 ++++++++++++++++--------------
 winsup/cygwin/fork.cc             |  24 +-
 winsup/cygwin/spawn.cc            |  65 +++--
 6 files changed, 288 insertions(+), 241 deletions(-)

-- 
2.21.0

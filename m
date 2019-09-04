Return-Path: <cygwin-patches-return-9599-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85964 invoked by alias); 4 Sep 2019 01:46:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85946 invoked by uid 89); 4 Sep 2019 01:46:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=cygwin-patches, cygwinpatches, HX-Languages-Length:1039, management
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 01:46:03 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x841jkKo032156;	Wed, 4 Sep 2019 10:45:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x841jkKo032156
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567561551;	bh=xXgLe6ecj+iHoBOdr2WUcRvONxIzet2V1HBAPjZtBT0=;	h=From:To:Cc:Subject:Date:From;	b=AxY0USAIS8wbLEyzBE9/NH3PpdzpzsmkapzfF5YbNZ6zDmoHe6VibnbhI8J0OQvrk	 1dRiRAfCU3Ufr5jX/m0AIOToQ4oNnxhUuCsjU3PajmWK2Bzj22qIIi9Asnevvn0AMN	 EOmC0uCO8yM3mrKTMn5T/Dkk/Jvw8p3MdZ1YYZxja5D6obcejvJOYfhe07GRiqsG+d	 cq7JNuY1WkktZrYWsXO3ObUnvAHNLvlfFl+VSB7UJx+mH3Ti3m5rpUYdiBsDqv+m6H	 S58rHbJExpLE0jRoMx2dQSnkt/N+clR0QsBQvtPisovSGuWKzfqmaj9pAVHlXj96a/	 G63/ghRD2EQWw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 0/1] Fix PTY state management in pseudo console support.
Date: Wed, 04 Sep 2019 01:46:00 -0000
Message-Id: <20190904014535.1328-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00119.txt.bz2

Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
has some bugs which cause mismatch between state variables and
real pseudo console state regarding console attaching and r/w
pipe switching. This patch fixes this issue by redesigning the
state management.

v5:
Revise based on
https://cygwin.com/ml/cygwin-patches/2019-q3/msg00111.html

v4:
Small bug fix again.

v3:
Fix the first issue (Bad file descriptor) reported in
https://cygwin.com/ml/cygwin-patches/2019-q3/msg00104.html

v2:
Small bug fixed from v1.

Takashi Yano (1):
  Cygwin: pty: Fix state management for pseudo console support.

 winsup/cygwin/dtable.cc           |  38 +--
 winsup/cygwin/fhandler.h          |   6 +-
 winsup/cygwin/fhandler_console.cc |  25 +-
 winsup/cygwin/fhandler_tty.cc     | 385 ++++++++++++++++--------------
 winsup/cygwin/fork.cc             |  24 +-
 winsup/cygwin/spawn.cc            |  65 ++---
 6 files changed, 289 insertions(+), 254 deletions(-)

-- 
2.21.0

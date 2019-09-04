Return-Path: <cygwin-patches-return-9619-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 71560 invoked by alias); 4 Sep 2019 13:47:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71550 invoked by uid 89); 4 Sep 2019 13:47:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 13:47:52 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x84DlhCH015236;	Wed, 4 Sep 2019 22:47:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x84DlhCH015236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567604868;	bh=UTftRihky+On58y1Rg1SHx06eUjiHmPA1oWAX7ma3DI=;	h=From:To:Cc:Subject:Date:From;	b=OGqys/D77PayaORO+l1rJdgDW6q32EMsRfLxqa9jI0ME5gAlCnODEFessNKRjKsSE	 /wjAe7N6FuAERzujwfBVLyMvPGT4BmWIDSs9myO6MBXwJbRo+PxI3wCpH0M/HO27Qj	 4HwqXmzphOCOJkUXtqJJTFXbXbkmXIwoHcru9THyUT0gCd6Z8/OFaNx5UehFJptl3w	 qLdThzA82wiDyRkB/jIRYyJHGW809KqqTBw12KmMmQJUyOKtuGN2wshAhwqoNqFCnq	 TOGTZ7lCuMOYpJ8lJTQfgeNIKJgvQgO6AUKCHm0w8fQinXWJdoVuYluYiEOyMKWjHt	 kTXBjeh5wn6zA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/1] Cygwin: pty: Add a workaround for ^C handling.
Date: Wed, 04 Sep 2019 13:47:00 -0000
Message-Id: <20190904134742.1799-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00139.txt.bz2

- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 sometimes cause random
  crash or freeze by pressing ^C while cygwin and non-cygwin
  processes are executed simultaneously in the same pty. This
  patch is a workaround for this issue.

v2:
Make the behaviour of pty and console identical.

Takashi Yano (1):
  Cygwin: pty: Add a workaround for ^C handling.

 winsup/cygwin/fork.cc  | 1 -
 winsup/cygwin/spawn.cc | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.21.0

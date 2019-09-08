Return-Path: <cygwin-patches-return-9661-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13875 invoked by alias); 8 Sep 2019 12:58:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13862 invoked by uid 89); 8 Sep 2019 12:58:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=furthermore, H*Ad:D*jp, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 08 Sep 2019 12:58:49 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x88CwdjN014113;	Sun, 8 Sep 2019 21:58:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x88CwdjN014113
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567947523;	bh=4jfvWgs/fGcpmFT8lcUN68vI2pWSSdQclgQlpnlMSrU=;	h=From:To:Cc:Subject:Date:From;	b=HVkrTfVK4fp2pEOl6kAZdIhWmisHoMtwKUka6dRwLtwz47Uqsh6X3GIHCkyWZPe/i	 VZFGPb7MM4pqrBh71e5DzeZJ7D+l7ENxNz3XUZm5CnzVB1f92mC2nPdIQsoRoifM+5	 JQfTZW/hJNjG2ZU3aX142l0Gch7IJCQkNSownKqn586bB7Vucres8MNYKCtUQYoRZ4	 7AbcFVvnrWye6dxSi7BcehvkRS/BUYxQMjQy992SJwy0bB+L0/o5g/XRmoki2HITF3	 JXlrcmnAh20733jz6wdRJmoQIwsEFsUi00512pTU1ledypVNYnoTPNekVrf8Lx79P0	 lKfWwqF5fIvrQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Sun, 08 Sep 2019 12:58:00 -0000
Message-Id: <20190908125835.5184-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00181.txt.bz2

- When the I/O pipe is switched to the pseudo console side, the
  behaviour of Ctrl-C was unstable. This rarely happens, however,
  for example, shell sometimes crashes by Ctrl-C in that situation.
  Furthermore, Ctrl-C was ignored if output of non-cygwin program
  is redirected to pipe. This patch fixes these issues.

v5:
Add a workaround for piped non-cygwin program.

v4:
Fix the problem 1 and 2 reported in
https://cygwin.com/ml/cygwin-patches/2019-q3/msg00175.html

v3:
Fix mistake in v2.

v2:
Remove the code which accidentally clears ENABLE_ECHO_INPUT flag.


Takashi Yano (1):
  Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.

 winsup/cygwin/fhandler.h      |  4 ----
 winsup/cygwin/fhandler_tty.cc | 44 +++++++++++++++++++++++++----------
 winsup/cygwin/select.cc       |  2 +-
 winsup/cygwin/spawn.cc        | 42 ++++++++++++++-------------------
 4 files changed, 50 insertions(+), 42 deletions(-)

-- 
2.21.0

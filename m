Return-Path: <cygwin-patches-return-9709-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129027 invoked by alias); 20 Sep 2019 21:10:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129005 invoked by uid 89); 20 Sep 2019 21:10:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*ne.jp, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Sep 2019 21:10:44 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x8KLAWxH011747;	Sat, 21 Sep 2019 06:10:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x8KLAWxH011747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1569013837;	bh=SotGVr7+rneKOWDPF0OTtY31Us5MJEDAsCcAaJSdd7k=;	h=From:To:Cc:Subject:Date:From;	b=uheHgknlBML2/G6Z953ukIr+9daNKNYKsqQ+18u3MBYmcVeX06lr0dq+Py9j3oVYu	 iNxXJH+6r5lLeqDaM2NIYSaeUzHGalICrJgkWqTkvLp2y0eSZpo5KT/btFS+wyXPpd	 OEe6cfMW3O30hIzsGDeDSpamdAQUBYznAumRmz3OaSznlrEjMnRSPHzQLhprhxAHKL	 /Yyjqg0ugUQL7EO3cS7KkN9+YZ9r8dUZEc5tswO79+yNeXQnBSL38kjH3SmGqUS7sS	 afYQuO79Z4y4lq1p6CS1UIXWxmBQkiQtNX1NRtWWsBPW/ribI3sX+AZfhhlxhF0zhi	 5vbG4D/n1Nf8g==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/1] Cygwin: console: Make console input work in GDB and strace.
Date: Fri, 20 Sep 2019 21:10:00 -0000
Message-Id: <20190920211035.952-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00229.txt.bz2

- After commit 2232498c712acc97a38fdc297cbe53ba74d0ec2c, console
  input cause error in GDB or strace. This patch fixes this issue.

v2:
Patch pinfo.cc rather than fhandler_termios.cc. This probably is
the right thing.

Takashi Yano (1):
  Cygwin: console: Make console input work in GDB and strace.

 winsup/cygwin/pinfo.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.21.0

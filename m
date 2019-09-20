Return-Path: <cygwin-patches-return-9708-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129020 invoked by alias); 20 Sep 2019 21:10:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129006 invoked by uid 89); 20 Sep 2019 21:10:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=sid, H*Ad:D*ne.jp, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Sep 2019 21:10:44 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x8KLAWxJ011747;	Sat, 21 Sep 2019 06:10:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x8KLAWxJ011747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1569013840;	bh=Vx/nb2QVZL3gR1Bnzs8JjWln4T9Ghvn/E+QviD5/Uwc=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=tvTxmc7VPsKXt2lLab3agvtLIcJEdE3k0g6o6AoJQfvCpi5va3BJ60ijNN8rSeFiQ	 Ii9m/1f0ZHZ+aKMwVW4AVM5Ln05tC0f/a6ngpmTfSn++2roiSVvWvo1a7BKIJsCBoy	 ERyhXNl0BOZr2t/kbu9sf1YcjQWdmfI2wHqvZj/zsatYxCiqI4TdCZeLvosY3GzfzM	 JKuaWot1ZlhI7fDwRM4fZCdrKR+BPDbsqJYii1RMktXui14JBFKPs7ysSSMRgeANhe	 Gyu1zRGZfNTOds9slcf5lUrfhz2nwZech14wriPLq/MgO6haKQ0PDQLWUpSTbg+7t5	 /3120jSJAlMmA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/1] Cygwin: console: Make console input work in GDB and strace.
Date: Fri, 20 Sep 2019 21:10:00 -0000
Message-Id: <20190920211035.952-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190920211035.952-1-takashi.yano@nifty.ne.jp>
References: <20190920211035.952-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00228.txt.bz2

- After commit 2232498c712acc97a38fdc297cbe53ba74d0ec2c, console
  input cause error in GDB or strace. This patch fixes this issue.
---
 winsup/cygwin/pinfo.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index ffd4c8cd9..35c1ffe25 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -570,7 +570,7 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
 	tc.setsid (sid);
       sid = tc.getsid ();
       /* See above */
-      if (!tc.getpgid () && pgid == pid)
+      if ((!tc.getpgid () || being_debugged ()) && pgid == pid)
 	tc.setpgid (pgid);
     }
   debug_printf ("cygheap->ctty now %p, archetype %p", cygheap->ctty, fh ? fh->archetype : NULL);
-- 
2.21.0

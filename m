Return-Path: <cygwin-patches-return-9697-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42809 invoked by alias); 18 Sep 2019 14:34:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42797 invoked by uid 89); 18 Sep 2019 14:34:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: condef-06.nifty.com
Received: from condef-06.nifty.com (HELO condef-06.nifty.com) (202.248.20.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 14:34:17 +0000
Received: from conuserg-06.nifty.com ([10.126.8.69])by condef-06.nifty.com with ESMTP id x8IETa9F023698	for <cygwin-patches@cygwin.com>; Wed, 18 Sep 2019 23:29:36 +0900
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x8IETKE1031962;	Wed, 18 Sep 2019 23:29:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x8IETKE1031962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568816972;	bh=7kklD5c98pFhOqdW0TrW1uPMvlr89QFwqLF3Fpzf1Dw=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=1Ne/4bXd3kt3QD1Ii4g6We7sdnLdMRyXYIqzz/WwD3E+uflV02yMhURSTjDVtKV4G	 32k3Alw8cuGaDRAjZ8yPwL9hpQa6ehDQzeZArHd7jz+h+Ry1p9sdW8zRwVtigc2Ci/	 zAy0gizIq0958mg6YA/AKmyo9un0dDjJxj18RezaRN3d+U6FEiDMmOW7EfQukMMkFn	 ceNaeumAamUz5LlSWDh5MHMin2pDUiE5FpnLt7mxfdjGC51W3ebdhNYZ8Wy07bMigo	 vAjHXmPKySyv0lerLtv/2Z12pp9kqvpJgJTNY7VrBmpkoCAahEVkdzc+2bkVQDVcpW	 7JdBXps3+wzww==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 4/5] Cygwin: pty: Add charset conversion for console apps in legacy PTY.
Date: Wed, 18 Sep 2019 14:34:00 -0000
Message-Id: <20190918142921.835-5-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
References: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00217.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f723ec7cf..2a92e44cf 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3054,6 +3054,12 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  mb_str_free (buf);
 	  continue;
 	}
+      size_t nlen;
+      char *buf = convert_mb_str
+	(get_ttyp ()->term_code_page, &nlen, GetConsoleOutputCP (), ptr, wlen);
+
+      ptr = buf;
+      wlen = rlen = nlen;
       acquire_output_mutex (INFINITE);
       while (rlen>0)
 	{
@@ -3066,6 +3072,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  wlen = (rlen -= wlen);
 	}
       release_output_mutex ();
+      mb_str_free (buf);
     }
   return 0;
 }
-- 
2.21.0

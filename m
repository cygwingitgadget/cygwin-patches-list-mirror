Return-Path: <cygwin-patches-return-9725-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92095 invoked by alias); 26 Sep 2019 10:53:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92086 invoked by uid 89); 26 Sep 2019 10:53:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=8888, pty, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Sep 2019 10:53:36 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x8QAr0R7001416;	Thu, 26 Sep 2019 19:53:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x8QAr0R7001416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1569495186;	bh=hDqRnY6JOUtEMUMjx728+ZabDcNWkagAy+WJmutc1yg=;	h=From:To:Cc:Subject:Date:From;	b=IX++t34t0wcR4FbOlPmK+RdWFOpf3N35MkORWgVkT3R8rv23jfHHUmV4rlc/mXlxe	 VLmYo+kBarCZIC29Ml/uojMvz9lBNFRyPe652szo3atCu8XGJkll+0OACQQILC4iBj	 +vC6pM05/ArzJrD/V8bekDtUPh1JqxJMpKgLPkZa85idYU+ifgV/gSgN1WAi2mLFO6	 q8jJ1P3RBe9J1IEmkue1Gq5ISYDW35ZR38jux+rRC9T7g8/7qZRnnnsSTMeTt5n3+i	 ZEbCP7FFtGY0dN8yAKS0eOo8t676hY+TCXtsJjAf68TRR4ULT30RIVuKmi5HZ+a5zm	 Pc3JcuK+TK+Zw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix PTY so that cygwin setup shows help with -h option.
Date: Thu, 26 Sep 2019 10:53:00 -0000
Message-Id: <20190926105246.914-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00245.txt.bz2

- After commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57, cygwin
  setup fails to show help message when -h option is specified, as
  reported in https://cygwin.com/ml/cygwin/2019-09/msg00248.html.
  This patch fixes the problem.
---
 winsup/cygwin/spawn.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 4d8bcc9fa..f8090a6a4 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -790,8 +790,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  NtClose (old_winpid_hdl);
 	  real_path.get_wide_win32_path (myself->progname); // FIXME: race?
 	  sigproc_printf ("new process name %W", myself->progname);
-	  if (!iscygwin ())
-	    close_all_files ();
 	}
       else
 	{
@@ -890,6 +888,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		wait_for_myself ();
 	    }
 	  myself.exit (EXITCODE_NOSET);
+	  if (!iscygwin ())
+	    close_all_files ();
 	  break;
 	case _P_WAIT:
 	case _P_SYSTEM:
-- 
2.21.0

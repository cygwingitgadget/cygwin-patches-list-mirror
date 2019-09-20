Return-Path: <cygwin-patches-return-9707-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75025 invoked by alias); 20 Sep 2019 03:05:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 74726 invoked by uid 89); 20 Sep 2019 03:05:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=armed, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Sep 2019 03:05:23 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x8K34gZ8025993;	Fri, 20 Sep 2019 12:05:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x8K34gZ8025993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568948712;	bh=Zxd/f4eysYO6eFC3kVT6Ef99PDL0PTulHbcbPlvyuiY=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=WUzIgBWPTTqj7fw//70MOGP//eJlHC+bEVEdPqel5MywLg9LGv5G/oCzhrG4hvReO	 J+yjfykafXPpaLYcYlH0oAtZHIhKDv5T+CPbVQACgCSosF3+5DgGSzB3maRom1y0rY	 4vNrfPY6s2k3rtwx9ouxGLLd0NYfPkZqCSoCwSkhHzA+NYSaf3rMCciPSNcD1C7glh	 iqkLJWVKYEaPNVs2FpJriaOcLWe8JpnG4LEQe1uid0UggPrJ09BWZkiBfMkKj+evqy	 EEqMYBMbUjvJqDHqzgcTCxnWC5AUqFTGVZR1bKty3Ik6DPdnJGlswFpSwV5HiXZt5h	 F/ofp5WWKcxRA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/1] Cygwin: Fix incorrect TTY for non-cygwin process.
Date: Fri, 20 Sep 2019 03:05:00 -0000
Message-Id: <20190920030436.973-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190920030436.973-1-takashi.yano@nifty.ne.jp>
References: <20190920030436.973-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00227.txt.bz2

- After commit d4045fdbef60d8e7e0d11dfe38b048ea2cb8708b, the TTY
  displayed by ps command is incorrect if the process is non-cygwin
  process. This patch fixes this issue.
---
 winsup/cygwin/exceptions.cc | 2 +-
 winsup/cygwin/spawn.cc      | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 848f9bd68..db0fe0867 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -949,7 +949,7 @@ _cygtls::interrupt_setup (siginfo_t& si, void *handler, struct sigaction& siga)
   if (incyg)
     set_signal_arrived ();
 
-  if (!have_execed)
+  if (!have_execed && ch_spawn.iscygwin ())
     proc_subproc (PROC_CLEARWAIT, 1);
   sigproc_printf ("armed signal_arrived %p, signal %d",
 		  signal_arrived, si.si_signo);
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 4396ec9e5..4d8bcc9fa 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -622,10 +622,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       si.cb = sizeof (si);
 
       if (!iscygwin ())
-	{
-	  init_console_handler (myself->ctty > 0);
-	  myself->ctty = 0;
-	}
+	init_console_handler (myself->ctty > 0);
 
     loop:
       /* When ruid != euid we create the new process under the current original
-- 
2.21.0

Return-Path: <cygwin-patches-return-9704-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106703 invoked by alias); 19 Sep 2019 12:34:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106693 invoked by uid 89); 19 Sep 2019 12:34:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=armed, UD:si_signo, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Sep 2019 12:34:40 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x8JCYSOI011049;	Thu, 19 Sep 2019 21:34:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x8JCYSOI011049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568896473;	bh=CjcEC50gM7hJhypJbT9cDUGuVqBef5gtoxbJz3e16ms=;	h=From:To:Cc:Subject:Date:From;	b=Yr2sjUCScCrroZu3HJeZpHUZH9XihSAJabqFmwWDuJk+060wXsZYt4I11ZaHoxHYE	 lDHAKyxTl1+hyCBftezbF8x8+QZ9vMuKTZqsSiuBH0bc+gv9IorYhVD6/uga3pzkt6	 1SYrMDXkmWneX3r35qe66uMDrtnnHcX8Az/IEQUrsLIbrxX1PJU45wFE/oshjasK9v	 5jNa+cEdPFvSaHVydNWfv4JCIwS1zE/OOuxy1Qc7cW0Z0AMVQ607KyFEuEDsWcsLDU	 rxwXhF+EvjKm9k9ChpKXnTuZ43HxKf9aTa4Gbk3WhLcMEpHXdi8KhBT3H7mQMhLMJM	 +l50/grvjNYDw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: Fix incorrect TTY for non-cygwin process.
Date: Thu, 19 Sep 2019 12:34:00 -0000
Message-Id: <20190919123428.452-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00224.txt.bz2

- After commit d4045fdbef60d8e7e0d11dfe38b048ea2cb8708b, the TTY
  displayed by ps command is incorrect if the process is non-cygwin
  process. This patch fixes this issue.
---
 winsup/cygwin/exceptions.cc | 2 +-
 winsup/cygwin/spawn.cc      | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 848f9bd68..76dceac3a 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -949,7 +949,7 @@ _cygtls::interrupt_setup (siginfo_t& si, void *handler, struct sigaction& siga)
   if (incyg)
     set_signal_arrived ();
 
-  if (!have_execed)
+  if (!have_execed && (ch_spawn.iscygwin () || ch_spawn.has_execed ()))
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

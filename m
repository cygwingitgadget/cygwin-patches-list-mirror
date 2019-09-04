Return-Path: <cygwin-patches-return-9614-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128568 invoked by alias); 4 Sep 2019 13:30:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128558 invoked by uid 89); 4 Sep 2019 13:30:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 13:30:54 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id x84DUj4s024983	for <cygwin-patches@cygwin.com>; Wed, 4 Sep 2019 22:30:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x84DUj4s024983
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567603845;	bh=ORirxc3K/iyZxkUKayvv7St6Uii1/EKllhFe0rsSjkg=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=V3nYCuTBt7xgqkjhn5n3SkOV4ZQGEHy0Givk9kFz2DEmdCSYwpgS9HAUWw9Ym4u/S	 QXnQafGiGCN6E5HYxiDwp0nz/SHjNpHsQzrj9ZTd5wxHdqJXiXqdOUQXJJg+7A+iWW	 q69T4nwtB9uqHHV3efPP991wqRBVZEaZnHldBApmu/luAlK24P4TY59ZtVaoflw85I	 q6t/mKaz0pstLvclaaojoKjQGIIunNqdCyo41ekgb1UcTbx4oHYCMzkDaQTLWlPcVF	 PBo9VAfSCkK0iCgH9peKFhV4DJ6g1qI8C0plI+yhsJMbjgkk75+OW7VF1h7ZLcdaQ/	 x53crhy0DjLYQ==
Date: Wed, 04 Sep 2019 13:30:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: pty: Add a workaround for ^C handling.
Message-Id: <20190904223054.e3debe5ca201ee5bb94f1203@nifty.ne.jp>
In-Reply-To: <20190904104222.GO4164@calimero.vinschen.de>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>	<20190904014618.1372-2-takashi.yano@nifty.ne.jp>	<20190904104222.GO4164@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00134.txt.bz2

On Wed, 4 Sep 2019 12:42:22 +0200
Corinna Vinschen wrote:
> If this workaround works, what about making it the standard behaviour,
> rather than pseudo-console only?  Would there be a downside?

I am not sure why, but console does not have this issue.
However, I do not notice any downside.

If making it standard, the patch will be very simple as follows.


diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index a3a7e7505..0a929dffd 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -213,7 +213,6 @@ frok::child (volatile char * volatile here)
      - terminate the current fork call even if the child is initialized. */
   sync_with_parent ("performed fork fixups and dynamic dll loading", true);

-  init_console_handler (myself->ctty > 0);
   ForceCloseHandle1 (fork_info->forker_finished, forker_finished);

   pthread::atforkchild ();
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 4bb28c47b..15cba3610 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -635,6 +635,12 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       if (ptys)
        ptys->fixup_after_attach (!iscygwin ());

+      if (!iscygwin ())
+       {
+         init_console_handler (myself->ctty > 0);
+         myself->ctty = 0;
+       }
+
     loop:
       /* When ruid != euid we create the new process under the current original
         account and impersonate in child, this way maintaining the different

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

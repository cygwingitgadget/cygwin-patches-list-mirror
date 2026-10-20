Return-Path: <SRS0=VONe=IK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 0351E48FEF74
	for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2026 04:39:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0351E48FEF74
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0351E48FEF74
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792471165; cv=none;
	b=FmOp7kFkIpMMC/N6J612aMRTajksFyb0DQ75uUKWcWrPomatN7S5DY/4f3mXodGOl2quj3ili1/eDRxAsWg9+ICtmt9KkiQm82i6B3P+Qw8xJJIuKs+65N/0VHjPtlVhwU1+KaQh/Q+Tcd6our41TkDz5V1CA5ZrIEgTGHDa7nQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792471165; c=relaxed/simple;
	bh=xTPtJmHPahIVbtbOnlI2fjMdmfh30DN5iLojiv1/dyI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=oRbM5KNBWEy5GoS7QK38aem/Dk/kLtAVkKWa2El/xsUS2kS6Ft3fEjyqaXm1IxYw+Sl9kbRyW2nUTcOJ8aX0Zb+rWMvwOOferebWcSqUsM3+5/vfShBkQFsZn7b1Es6mqOVc9Uyeu8iT/XW92dViOgi5W1M0iSfK3ALtL88tp8o=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=klHeuhHG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0351E48FEF74
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=klHeuhHG
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20261020043921231.BPZT.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2026 13:39:21 +0900
Date: Tue, 20 Oct 2026 13:39:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] tgid reported incorrectly in /proc/<pid>/status
Message-Id: <20261020133919.10b3f008d0f28349c776f8af@nifty.ne.jp>
In-Reply-To: <87wlreyhxi.fsf@Gerda.invalid>
References: <87wlreyhxi.fsf@Gerda.invalid>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1792471161;
 bh=wVPBZrdrD14UeYGmVLBx3fFwv2lNfpoLUqvxzTxZ2PY=;
 h=Date:From:To:Subject:In-Reply-To;
 b=klHeuhHGWz6T8KeeL1hWYQ2TNJSLqZaFRG85JKUuQOTYteDOI+6WtGOTFp/iacnzhpw2cldJ
 rNptaTrA2gdnZOo0jd325SNwVSICZL3pSE70Exy2KhQw0GqwaCZzIRCimmfimlsSC6BvCGZqn3
 o+65/3iePVrlrAPPui/ILJBYkaaUCOL6iGB4npVN14HHOf/nekCm7tSMQd5RbWX0zB7N0HvgQL
 rd96JXyYX5wkXM7+m30l6g4p58wCNxYbsSBa0lOLeRBZwnqmOzIY1VYz/IVGqnZuy4VUenoMPs
 6e38IhCxx34OIq07GjPq9cFYe/lNyMecV4goi2BK6+onK7CA==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Achim,

Thanks for the patch.

On Sun, 18 Oct 2026 20:36:41 +0200
ASSI wrote:
> From b9f66fe5a55ac39f0bbbcfe9d96cade9927f672d Mon Sep 17 00:00:00 2001
> From: Achim Gratz <Stromeko@Stromeko.DE>
> Date: Sun, 18 Oct 2026 19:56:13 +0200
> Subject: [PATCH] winsup/cygwin/fhandler/process.cc: correct tgid value
> 
> Cygwin has historically (and incorrectly) reported the pgid as the
> tgid in /proc/<pid>/status even though LWP don't exist on Cygwin.
> Since the Threads parameter was missing at the time, this latent bug
> was lying dormant as that signifies an invalid tgid on Linux (the same
> as for a Threads parameter of zero).  However, commit 9756b33 changed
> that to reporting a number of threads in the Threads parameter that is
> totally unrelated to LWP, which triggered the bug: procps now reports
> the tgid instead of the pid as it does on Linux and expects that only
> the leader process (tgid==pid) should get reported unless you ask for
> all LWP to be shown.  This either suppresses the output for that
> process completely or shows the wrong PID for many processes.  Regain
> some sanity by ensuring tgid==pid for all Cygwin processes as LWP
> don't exist.
> 
> This patch does not change the reporting of parameter Threads (which
> should probably always be 0 on Cygwin to conform to the expectations
> set by Linux), however it is currently unknown if that deviation is
> actually causing problems in existing programs.  Any program using
> this number should expect the number of threads to change between
> reading this parameter and actually getting to the point where it
> could enumerate them.  However, seeing a Thread value different from
> zero might reasonably enable code paths that try to open directory
> /proc/<pid>/task (which contains all threads in that thread group on
> Linux).  Cygwin doesn't have this unless someone whips up an LWP
> emulation for it, so for that reason it might be better to revert to
> reporting zero.
> 
> Signed-off-by: Achim Gratz <Stromeko@Stromeko.DE>
> Reported-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>  winsup/cygwin/fhandler/process.cc | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
> index 404668661..86ca05e5e 100644
> --- a/winsup/cygwin/fhandler/process.cc
> +++ b/winsup/cygwin/fhandler/process.cc
> @@ -1335,7 +1335,9 @@ format_process_status (void *data, char *&destbuf)
>  				   "SigIgn:\t%016lx\n",
>  			  cmd,
>  			  state, state_str,
> -			  p->pgid,
> +			  p->pid, /* this is the tgid on Linux, but
> +				     Cygwin doesn't have LWP -- treat
> +				     all processes as leaders */

This makes perfect sense to me.

>  			  p->pid,
>  			  p->ppid,
>  			  p->uid, p->uid, p->uid, p->uid,
> @@ -1343,7 +1345,11 @@ format_process_status (void *data, char *&destbuf)
>  			  vmsize * kb_per_page, 0UL, vmrss * kb_per_page,
>  			  vmdata * kb_per_page, 0UL, vmtext * kb_per_page,
>  			  vmlib * kb_per_page,
> -			  num_threads,
> +			  num_threads, /* should really be the number
> +					  of LWP in the same thread
> +					  group, not the number of NT
> +					  threads attached to this
> +					  process */

What is the practical difference? The only thing I can come up
with is whether it includes Cygwin’s internal threads (such as
the signal thread) or not. Is that right?

>  			  pnd, blk, ign
>  			  );
>  }
> -- 
> 2.56.0
> 
> 
> Regards,
> Achim.
> -- 
> +<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+
> 
> Waldorf MIDI Implementation & additional documentation:
> http://Synth.Stromeko.net/Downloads.html#WaldorfDocs


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

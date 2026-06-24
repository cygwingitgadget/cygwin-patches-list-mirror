Return-Path: <SRS0=3SWy=EU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 5E7A24BA2E19
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 12:33:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5E7A24BA2E19
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5E7A24BA2E19
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782304412; cv=none;
	b=gYMO1zZYWvunnH3AM2bIdjqgkHjb/oHFh5+3UGBCIFZHr/oQDVGvxyMOZrpjNbhkxTlzQqP7UO9IbxpLsKpi1xugSTHIELNoXRvGgWmAN12v6Bo0x8tAv/5fL/YpDZuLv8xNDVbE1nFrkqWXLGqFL9o/aqkmNliTRDjaVg6+NIw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782304412; c=relaxed/simple;
	bh=3102WPpwLVj0dpnOdTq1Jtglx/p6fQ7xFtn74GKVo9I=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=fOBCF25rI6cTCdb5jbdKcJYqd3Wc7bH0RnjzRwcVEqLABV+6zqwpLY8Pg2oXwEp6pGAp8kUh+Lw0JnfR6ltz6ojY4UyR5vV1d1tM2lZMorwJI3BeNoW4LPWUbkzCVnrOHffq4/bgicjidP56oqabxHKAFX1mNNqXSb/m1BJHS1U=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rZmtPTL4
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5E7A24BA2E19
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rZmtPTL4
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260624123329582.DMEW.3198.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 21:33:29 +0900
Date: Wed, 24 Jun 2026 21:33:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7] Cygwin: pty: Fix race issue between starting and
 exiting non-cygwin apps
Message-Id: <20260624213327.c3670a30618957fe3d482cdd@nifty.ne.jp>
In-Reply-To: <47a930e6-12ec-4512-a566-1bbccffcbaf2@maxrnd.com>
References: <20260623225137.263-1-takashi.yano@nifty.ne.jp>
	<47a930e6-12ec-4512-a566-1bbccffcbaf2@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782304409;
 bh=apoNyEt7i4Wa8CmCrDY9zMXnFCW++7rnepe56mCVclk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=rZmtPTL4auFr2hIrR2/o0iGKm8/vgvbADCV6Q/TZQuDSF92Nw96AkYCVB+tMBD0T+LckAu6Z
 e/FSEyv4WMa28BGmdUvNIUmQ/R0pxe88yNL7grKrfWmE3nnwHjCbiuyOX7Vcwzaf+mZCkISyI2
 goYn5ZPhE5foXr4GCyXVzNRLSu4F7AixDgZijcC8Te4RnXjXQVsdmxBFMPZtCl53Si487JgFcG
 FEgZe3IOP+Zn3ehlMWb1P/5HX4AJQqV+JdWFs5KUoU5eCssDvYIQygofGDpC6qWDlYlZExU6dC
 +hZ/nza1zbW1vE773+sY0giqfhcubndDze6q/ajtD8UN+ogQ==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Thanks Mark. Pushed.

On Wed, 24 Jun 2026 00:09:26 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> This v7 LGTM.  OK to push.
> Thanks,
> 
> ..mark
> 
> On 6/23/2026 3:51 PM, Takashi Yano wrote:
> > Without this patch, when a non-cygwin program (A) is about to exit, and
> > another non-cygwin program (B) is started, input transferring between
> > cyg-pipe and nat-pipe may not work as expected. When the non-cygwin
> > program (A) exits, input transferring from nat-pipe to cyg-pipe will be
> > performed. However, the the non-cygwin program (B) will performs input
> > transferring from cyg-pipe to nat-pipe at the same time. The mechanism
> > of the problem is as follows.
> >   1) The the non-cygwin program (A) checks current input pipe state,
> >      then it is nat-pipe since the this program is a non-cygwin program.
> >      The program (A) also checks if any handover target exists, but
> >      it is not found since the program (B) is not started yet. So,
> >      the program (A) decided to transfer input form nat-pipe to cyg-
> >      pipe.
> >   2) Before the non-cygwin (A) program performs input transferring,
> >      if the non-cygwin program (B) is started and checks the input
> >      pipe state, it is nat-pipe state, so the non-cygwin program (B)
> >      does not perform input transferring.
> >   3) However, just after that, the non-cygwin program (A) performs
> >      input transferring from nat-pipe to cyg-pipe, so typeahead input
> >      will be stored in cyg-pipe.
> >   4) The non-cygwin program (B) cannot read the typeahead input
> >      because it is now in the cyg-pipe.
> > 
> > The following code demonstrates the issue.
> >    #include <stdio.h>
> >    #include <stdlib.h>
> >    #include <unistd.h>
> > 
> >    int main(int argc, char *argv[])
> >    {
> >      int n = 1;
> >      if (argc > 1)
> >        n = atoi(argv[1]);
> >      if (fork()) {
> >        execlp("cmd.exe", "cmd", NULL);
> >        perror("execlp(\"cmd\"): ");
> >      }
> >      for (int i=0; i<n; i++) {
> >        if (fork() == 0) {
> >          execlp("./winsleep.exe", "winsleep", "0", NULL);
> >          perror("execlp(\"winsleep\"): ");
> >        }
> >      }
> >      return 0;
> >    }
> > 
> > Transferring input itself is guarded by input_mutex, but the pre-
> > check is not. With this patch, the guard is enhanced so that the
> > state check and transferring input are done in atomic way.
> > 
> > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Mark Geisert <mark@maxrnd.com>
> > ---
> >   winsup/cygwin/fhandler/pty.cc           | 99 +++++++++++++++----------
> >   winsup/cygwin/local_includes/fhandler.h |  2 +
> >   2 files changed, 60 insertions(+), 41 deletions(-)
> [...]


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

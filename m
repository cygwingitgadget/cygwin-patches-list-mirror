Return-Path: <SRS0=5WD9=G6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id 778FB4BBCD91
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 11:14:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 778FB4BBCD91
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 778FB4BBCD91
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788693279; cv=none;
	b=utYwL+fPOY23V2SIZV7vc/JCyBviU6WLlFkwKdt0YZLOQuu8lniHUkXJtZVRh/p9441gmRh40ITg/bHHHouU9MzElsYec09M6NClVnMYNbO81TdqHRslxE5SoO1myQlyI3FFSDwaoosycRwJv9EKv0X9s8pV5k53NfP2tvw4mLY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788693279; c=relaxed/simple;
	bh=XtPqxfQLS7PO0gvqItLPvViKgcSKjEBRyEQotLlZkFM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=jmrNimR8ZQntoGjSKQVgIxSlW4hk35UtNR2wlDuFI8A8A6i6FkPCBMlC1KZkyegI6MzhglYn0EABtYmxGREQhrKh2GtVSr3az5JYrRJgvUO/4ytJfwcv958zBlWsrnsJZ0N57VVPDDJfTm+Ekf6SttJdkvXjoG9x5aXB63bbG0o=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=E/SwyiZ6
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 778FB4BBCD91
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=E/SwyiZ6
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260906111436324.RLNV.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 6 Sep 2026 20:14:36 +0900
Date: Sun, 6 Sep 2026 20:14:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: proc: Fix loadavg calculation
Message-Id: <20260906201434.c5ea807138bd4c1aee0ee3c2@nifty.ne.jp>
In-Reply-To: <4ee063d7-90d7-46df-8d01-ce66fad4fa1d@maxrnd.com>
References: <20260904012420.456-1-takashi.yano@nifty.ne.jp>
	<4ee063d7-90d7-46df-8d01-ce66fad4fa1d@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788693276;
 bh=vZ+jf+VepNhJn1jwyQQ+w7CT5f4w3LJs9KsKoeCEP2Q=;
 h=Date:From:To:Subject:In-Reply-To;
 b=E/SwyiZ6PRUBZxts5WYoziWuszSHxzwfNNQWFFh/qvuq/LCj7vvdZzWsJt95OnBpT9ytm+hU
 Oljlf5Yi1JmwZg/q66eA2tFvpmt72uvhZjz+km9tbivN7hCFf4+d+uL//bDeED8aujuXpxEZV8
 lvtSASgGX25cN2gnhw/MFkFdOzienrOL8JzkAn3OG4OXV7G8PsEgF65+ZFix7i09DkaCkes1nd
 tIWz12nDKjXvROVDkG/wcvqyfDq2o0XuWr4P/ZvgxYQWKuLUS8bQWhkE7WnDcsvi8jFCFlWTgo
 1Bm3ru98BfAevgRRmvw7rZihBhTfjNBU3sQj4aTcXQCzoR5g==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for reviewing!

On Fri, 4 Sep 2026 23:32:26 -0700
Mark Geisert <mark@maxrnd.com> wrote:

> Hi Takashi,
> 
> On 9/3/2026 6:24 PM, Takashi Yano wrote:
> > Previously, format_proc_loadavg() wrongly passed an argument `i` to
> > get_process_state(). This should be windows process ID (pids[i]->
> > dwProcessId). This patch fix that.
> 
> Nice catch!
> 
> > Fixes: 9ca65531e0ed ("* fhandler_proc.cc (format_proc_loadavg): Add running/total processes as fourth component of output.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/proc.cc | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
> > index f1cd468fc..af3cfdb16 100644
> > --- a/winsup/cygwin/fhandler/proc.cc
> > +++ b/winsup/cygwin/fhandler/proc.cc
> > @@ -442,7 +442,7 @@ format_proc_loadavg (void *, char *&destbuf)
> >     winpids pids ((DWORD) 0);
> >   
> >     for (unsigned i = 0; i < pids.npids; i++)
> > -    switch (get_process_state (i)) {
> > +    switch (get_process_state (pids[i]->dwProcessId)) {
> >         case 'O':
> >         case 'R':
> >   	running++;
> 
> The code update LGTM.  As an aside, how did you determine the proper 
> Fixes: reference?  The original code here goes waaaayy back.

I use "git blame" several times and trace back to the commit which
introduce the code having the problem.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

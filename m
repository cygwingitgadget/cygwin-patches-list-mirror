Return-Path: <SRS0=9Zje=CO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 562FE4BA2E06
	for <cygwin-patches@cygwin.com>; Wed, 15 Apr 2026 04:14:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 562FE4BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 562FE4BA2E06
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776226465; cv=none;
	b=ca0fSXQfWIhWxRRtlwF0p8i69hV6Pz67cnQVp5uS6/4DeRiVHbv156r8VE2SFp/xPtQ/1ZrN0Tji8kJZdd6dAgMDbw06u9fTI/J8KPROIe2AZ5ndOGI7KXoDjL8h0sA4VSqWrkj1JknAT2r2cUe7zHkKL79nrKq3uH6n85AkYyk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776226465; c=relaxed/simple;
	bh=IwBF7vMIP91/aBhn/11SZvywKiPn0V+xrazE5S7MmeY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=sdfstMDqzXRrwp5xeXZY0bxPX26VhwoBdo6u/niZMEQl6Mf1pkw3lfx0fHsvsOqRv3q9LAih7L5j4trGi/F+n+mniZWbiJnHv2XBLNvzkieXBzShtWu12cOs4YoJQ5N8r+I7Yswr8Cg/zl/8v1rHbc7fRFtBReKrrtUY1go+26s=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 562FE4BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ePCfkFiq
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260415041423038.PXKE.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 15 Apr 2026 13:14:23 +0900
Date: Wed, 15 Apr 2026 13:14:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add missing
 DeleteProcThreadAttributeList() call
Message-Id: <20260415131423.569e4acb9c994e51ab860cdf@nifty.ne.jp>
In-Reply-To: <ad36ltx5N8HtFQcb@calimero.vinschen.de>
References: <20260407103022.1380-1-takashi.yano@nifty.ne.jp>
	<ad36ltx5N8HtFQcb@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776226463;
 bh=vmoCQEd2LsLqEV95ultC0Qp/OLdXQtOjuRFLGeESP0I=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ePCfkFiqITTqr70nsn5lNn9p6DAWZQFuZ4dQ6cbWsmt1k+thjQm8xxKIeANDdrpfOEuTDBC5
 sEpyGjtqIgw8ml+NWUB92j8ALbrzrkPkWBWQfuNDDJ/UAwGX4Me01+hMunAEhcs2Ek6Lp50h8v
 1BOGDiQxOhT+VISrcgpvqqgqtu2G9gylSWcRtUS5FMcnr3+FZf+nkXOx4NMZCFSBNS0nuowOdW
 hatb9PulNHrG6q1wSYl5u2lA5DPdGfd+2H2hZFetBUVKQk/Jw82MHumo8meKYAFeVYrwxCOXad
 64PVxxpZ6NzezRHZNja5JcWPB/sVICzlXNJa8AuDBTv4gxIg==
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENA_SUBJ_ODD_CASE,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 14 Apr 2026 10:28:06 +0200
Corinna Vinschen wrote:
> On Apr  7 19:30, Takashi Yano wrote:
> > Currently, the cleanup path of setup_pseudoconsole() is missing
> > DeleteProcThreadAttributeList() call, while microsoft's document
> > requires that and the normal path has it.
> > https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-initializeprocthreadattributelist
> > 
> > This patch adds DeleteProcThreadAttributeList() call to the cleanup
> > path.
> > 
> > Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
> > Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index e9191aaad..cdfb363c9 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -3730,7 +3730,7 @@ fhandler_pty_slave::setup_pseudoconsole ()
> >  				      PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
> >  				      hpcon, sizeof (hpcon), NULL, NULL))
> >  
> > -	goto cleanup_heap;
> > +	goto cleanup_proc_thread_attr;
> >  
> >        hello = CreateEvent (&sec_none, true, false, NULL);
> >        goodbye = CreateEvent (&sec_none, true, false, NULL);
> > @@ -3899,6 +3899,8 @@ skip_close_hello:
> >    CloseHandle (goodbye);
> >    CloseHandle (hr);
> >    CloseHandle (hw);
> > +cleanup_proc_thread_attr:
> > +  DeleteProcThreadAttributeList (si.lpAttributeList);
> >  cleanup_heap:
> >    HeapFree (GetProcessHeap (), 0, si.lpAttributeList);
> >  cleanup_pseudo_console:
> > -- 
> > 2.51.0
> 
> LGTM

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

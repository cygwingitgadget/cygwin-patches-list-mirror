Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 3E51D4BA2E0E
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 21:33:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E51D4BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E51D4BA2E0E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774474413; cv=none;
	b=D+PMlY9qhdEGylRUufLOzANmphcT0gQNxD577nULV9e5zpmBpjwXqLlkbUA/Dhh7MshrduiB4PIAZFEvdf6O5xBKYicAUaCrdqfGe/srgyYSsUo1EpTtv9mPFWzP+E2QEzAu0bkqf4Mz1HLtbvtgWAQ44TW6sGKOSQS1VmgNli4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774474413; c=relaxed/simple;
	bh=FvP67wJZ7ZADssog9nWPJWnImKGxnKCbTgwA2F5evFo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=QImEtQ0OE/v8tJtmzhWmRopT/tdfzSPSh7E53M0Y3NQJgQ7l+gmik84rajn3TZLkQ8p+thQ0TdC534S+P3YtGzHAOZhjCcUfsRp1H/qe1AzLeYDU2aoRqTnqZGwEqWNVu0DLLY5WprbsUki0L0l/2YcQ7E9hHACayfBfpc3+JKE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E51D4BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FmExZj71
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260325213330259.WLXI.58584.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Mar 2026 06:33:30 +0900
Date: Thu, 26 Mar 2026 06:33:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Omit CSI?1004h/l from pseudo console
 output
Message-Id: <20260326063329.f68046b88ee7c7bae3cf74fe@nifty.ne.jp>
In-Reply-To: <acQ155Qe0lamPNNA@calimero.vinschen.de>
References: <20260309092442.1502-1-takashi.yano@nifty.ne.jp>
	<acQzsE9p03u7UJsZ@calimero.vinschen.de>
	<acQ155Qe0lamPNNA@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774474410;
 bh=GvYmVgHSbxpgz2nREh9ztKT4VwwaBk6J/nJECSo5Tfo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=FmExZj71MUpMknkW19srjX0hsDxf+3SaeMA9NUa2XYzMNzshadth6d3elimsbdqreBLzjI4b
 XkwTebx+ssgDRvrAgfmBr3JqAxL+dw8v3AQq0KRW+I20lU4lq4GUntkFlbz96cYHTTx3Ziwwii
 wbg00RO+2U+VAvbywxuDf1sWAN7q9aT/cy8WuRuSg7qYqkg5ubtWF7X1g0EbS6hQmVRsfceHuK
 byTqMO41CiKoVvtmtuB2GfJ7F60G9u/vUkkrkE6AytZYhFTm+YwqzV0WnO7uPbq6bTfGg4aFsT
 Te1gbSr6mmag/ua+FKzYhihlKObrYDWiEH1uw1PZtENDKAKg==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Mar 2026 20:22:15 +0100
Corinna Vinschen wrote:
> On Mar 25 20:12, Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Mar  9 18:24, Takashi Yano wrote:
> > > "CSI?1004h" is the sequence that enabes focus event report. This
> >                                    enables
> > 
> > > can be handle correctly by pseudo console, however, if the pty
> > > input is not connected to pseudo console, the focus event responces
> >                                                             responses
> > 
> > > such as "CSI I/O" are sent to the foreground process. Due to this,
> > > `cat` receives these responces unexpectedly in the command below.
> >                        responses
> > > 
> > > $ cmd &
> > > $ cat
> > > 
> > > This seems to happen after Windows 11.
> > 
> > Not sure what this means. What is after W11?  Do you mean it happens
> > since W11 already?
> > 
> > > 
> > > To avoid this, this patch removes "CSI?1004h/l" from pseudo console
> > > output.
> > > 
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Reviewed-by:
> > > ---
> > >  winsup/cygwin/fhandler/pty.cc | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > > index 0717c043b..65b10dd62 100644
> > > --- a/winsup/cygwin/fhandler/pty.cc
> > > +++ b/winsup/cygwin/fhandler/pty.cc
> > > @@ -2760,7 +2760,8 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
> > >  	      }
> > >  	    state = 0;
> > >  	  }
> > > -	else if (saw_question_mark && arg == 9001
> > > +	else if (saw_question_mark
> > > +		 && (arg == 9001 || arg == 1004)
> > >  		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
> > >  	  {
> > >  	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> > > -- 
> > > 2.51.0
> 
> Other than the above commit message stuff, LGTM.

Thanks! Fixed and pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

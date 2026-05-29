Return-Path: <SRS0=Aef5=D2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 64B534BA2E2B
	for <cygwin-patches@cygwin.com>; Fri, 29 May 2026 02:36:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 64B534BA2E2B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 64B534BA2E2B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780022166; cv=none;
	b=j6I2XGJm/AkxbD4OSLYFJkQkJrxQR1ad3+Yu39ry6/8+nwY5Yu14lVvLURtHVRYWSNazQ8K2RH/m8Jx5fb9nJ++LVtxMHYzXpKq3hRGPx/Cijz5zpPfDmZS3T58V4+Y0l6IMG8u/52R5d3OTWr1lJ7luL+H30EM4R6WrWq77kFM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780022166; c=relaxed/simple;
	bh=oB1QBcPn4lDcLv3j9xve7ZnHZTGi7SpsuttEHBxHTXI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=tbLJMMNeP6I1pi1fE7l63NqtFh3hXIwHeoZqGllZ8grR26NWXo2wrugSMluOLrRDoNIOlTT+md75JVy3mGHr6XGA3iLGRogLoTLQaB0Eh8agrJgaKUKbTmrdrmsxf+Rt26HopDU4uzyPNcUKo2hmQMkN3otyBmmOq9R4vxhYeAg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oyD3UxWl
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 64B534BA2E2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oyD3UxWl
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260529023601466.XDFX.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 29 May 2026 11:36:01 +0900
Date: Fri, 29 May 2026 11:36:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix handling of surrogate pairs
Message-Id: <20260529113600.703bb0f24e91adb78cc1cb8d@nifty.ne.jp>
In-Reply-To: <7cbdd3da-8d1f-c836-8873-0b4207f0f98e@gmx.de>
References: <20260526095224.1958-1-takashi.yano@nifty.ne.jp>
	<7cbdd3da-8d1f-c836-8873-0b4207f0f98e@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780022161;
 bh=DJmryigeH+FaY0wAqCmCifp//moJZh4m7lnZGEib434=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=oyD3UxWlf/ZxLcIlS5daMYJfLGZeW/rTL7Q/2z3kdSYCMTgPk4fgEGQ0+/yRApfLGkaiEyJk
 Nq0aXSg1T2n/gm1fqp01nRV1RyaQsw/4MvJbf4v6gpa+Xey40wSodClNbLBMilRY++8skKRCYL
 3R78D540h/d+w6oz07HzOwhiyz9AoFbUgT38vNyCRF8pvGsOisEL4dPwaAZ3Yqct9czgdyPMuD
 A7ZHfMahh0l2G/GxvAuAFWT0KC3SwHPlTUWHH/V6fZ9aYdUYRyqt+2VLqFzuJq2vqdpSHZ/aFH
 VN0JCPv3344Y6ymZfmtJOTwcClkbjO8Ub0V4//Dgc4up6eWg==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 28 May 2026 15:33:24 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 26 May 2026, Takashi Yano wrote:
> 
> > The commit 782aac590af7 introduced surrogate-pair handling. However,
> > it does not work as expected in the legacy console. This is because
> > a KeyDown event for ALT key with UnicodeChar == 0 is inserted the
> > between surrogate pair. The current code reads the next key event
> > unconditionally for the second UnicodeChar, but it is not correct.
> > This patch searches the next appropriate key event with a valid
> > UnicodeChar, ensuring that the second code unit is valid.
> > 
> > Fixes: 782aac590af7 ("Cygwin: console: Handle Unicode surrogate pairs.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/console.cc | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 6fd4cd965..45eff6efe 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1452,9 +1452,21 @@ fhandler_console::process_input_message (void)
> >  	    }
> >  	  else
> >  	    {
> > -	      WCHAR second = unicode_char >= 0xd800 && unicode_char <= 0xdbff
> > -		  && i + 1 < total_read ?
> > -		  input_rec[i + 1].Event.KeyEvent.uChar.UnicodeChar : 0;
> > +	      WCHAR second = 0;
> > +	      DWORD second_pos = i;
> > +	      if (unicode_char >= 0xd800 && unicode_char <= 0xdbff)
> > +		for (DWORD j = i + 1; j < total_read; j++)
> > +		  {
> > +		    /* Do not check bKeyDown. bKeyDown is 0 for surrogate
> > +		       pair in legacy console */
> > +		    if (input_rec[j].EventType == KEY_EVENT &&
> > +			input_rec[j].Event.KeyEvent.uChar.UnicodeChar)
> > +		      {
> > +			second = input_rec[j].Event.KeyEvent.uChar.UnicodeChar;
> > +			second_pos = j;
> > +			break;
> > +		      }
> > +		  }
> >  
> >  	      if (second < 0xdc00 || second > 0xdfff)
> >  		{
> > @@ -1465,7 +1477,7 @@ fhandler_console::process_input_message (void)
> 
> It's a bit unfortunate that the diff here hides the fact that the
> following is in the `else` branch...
> 
> In any case, the patch makes sense to me, and I really appreciate the
> commit message that puts the diff into context.

Thanks for reviewing. Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

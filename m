Return-Path: <SRS0=MpmZ=CZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1010.nifty.com (mta-snd01006.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 09DFA385842A
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 22:59:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 09DFA385842A
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta1010.nifty.com with ESMTP
          id <20230707225910699.JFOL.19104.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 8 Jul 2023 07:59:10 +0900
Date: Sat, 8 Jul 2023 07:59:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: stat(): Fix "Bad address" error on stat()
 for /dev/tty.
Message-Id: <20230708075911.61d84f6053821845b39d6d34@nifty.ne.jp>
In-Reply-To: <ZKfe55PgjTJwWmIQ@calimero.vinschen.de>
References: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
	<20230707033458.1034-2-takashi.yano@nifty.ne.jp>
	<ZKfe55PgjTJwWmIQ@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Fri, 7 Jul 2023 11:46:15 +0200
Corinna Vinschen wrote:
> On Jul  7 12:34, Takashi Yano wrote:
> > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > index 18e0f3097..2aae2fd65 100644
> > --- a/winsup/cygwin/dtable.cc
> > +++ b/winsup/cygwin/dtable.cc
> > @@ -600,7 +600,13 @@ fh_alloc (path_conv& pc)
> >  	case FH_TTY:
> >  	  if (!pc.isopen ())
> >  	    {
> > -	      fhraw = cnew_no_ctor (fhandler_console, -1);
> > +	      if (CTTY_IS_VALID (myself->ctty))
> > +		{
> > +		  if (iscons_dev (myself->ctty))
> > +		    fhraw = cnew_no_ctor (fhandler_console, -1);
> > +		  else
> > +		    fhraw = cnew_no_ctor (fhandler_pty_slave, -1);
> > +		}
> 
> What happens if CTTY_IS_VALID fails at this point?  There's no
> `else' catching that situation?
> 
> >  	      debug_printf ("not called from open for /dev/tty");
> >  	    }
> >  	  else if (!CTTY_IS_VALID (myself->ctty) && last_tty_dev

That happens when CTTY is not assigned. In that case fhandler_nodevice
is assigned at:
https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/dtable.cc;h=18e0f3097823f00ff9651685be06583818eb2140;hb=e38f91d5a96c4554c69c833243e5afec8e3e90eb#l634

Then fhandler_base::fstat() is called when stat() is called.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

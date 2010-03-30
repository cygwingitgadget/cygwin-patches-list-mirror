Return-Path: <cygwin-patches-return-7010-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8854 invoked by alias); 30 Mar 2010 14:22:08 -0000
Received: (qmail 8840 invoked by uid 22791); 30 Mar 2010 14:22:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 30 Mar 2010 14:22:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id BE8A46D435B; Tue, 30 Mar 2010 16:22:00 +0200 (CEST)
Date: Tue, 30 Mar 2010 14:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
Message-ID: <20100330142200.GA12926@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net>  <20091216145627.GM8059@calimero.vinschen.de>  <4B29934A.80902@towo.net>  <4B2C0715.8090108@towo.net>  <20091221101216.GA5632@calimero.vinschen.de>  <20100125190806.GA9166@calimero.vinschen.de>  <4B5F0585.9070903@towo.net>  <20100330095912.GZ18364@calimero.vinschen.de>  <4BB1D83A.8010406@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BB1D83A.8010406@towo.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00126.txt.bz2

On Mar 30 12:53, Thomas Wolff wrote:
> Hi Corinna,
> 
> On 30.03.2010 11:59, Corinna Vinschen wrote:
> >Hi Thomas,
> For some reason this mail didn't make it into my cygwin mailbox, so
> it's good you sent me a personal CC.

Weird.  You should really check your mail chain.  I never had a problem
to receive mail from the list, execpt my own server(s) choked.

> >Since you were looking into the Cygwin console code lately, maybe you
> >could find out why `stty sane' doesn't reset the character set?
> stty sane isn't supposed to do anything "sane" to the terminal, I
> think, just to the tty device.
> The tool to use would be 'reset'. So I'll try to find out why
> 'reset' doesn't reset the character set :-\ .

Uh, ok.  Right reset doesn't work either.

> >A couple of minutes ago I printed the bytes from an ISO image unfiltered
> >to the console.  Afterwards, the console was using the alternate
> >charset.
> There are two methods to switch to the alternate character set. One
> is by just sending a Control-N. Most terminals "guard" this method
> by requiring an enable sequence before this works. I guess this
> would considerably reduce the risk that this happens, that's
> probably why they do it.
> I didn't implement the guarding mechanism in fhandler_console
> (although I prepared it somewhat) so I think I should fully
> implement that.
> Also I tuned mined to send the corresponding disable sequence on
> exit which it didn't, probably (and weird enough) because terminfo
> maintains the enable capability but no disable capability...
> 
> >`stty sane' does not switch back to the default charset for some reason.
> See above; I don't think it's supposed to do that.

I try to keep in mind :-}

> >If you have a bit of spare time, do you think you would like to have a look?
> Is it sufficient to complete this in 2 weeks (after Easter time)?

Sure!  It's not actually a pressing issue.  This request to look into
this problem is based on pure slackness on my side.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

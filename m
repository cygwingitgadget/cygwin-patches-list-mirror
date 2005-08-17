Return-Path: <cygwin-patches-return-5628-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21063 invoked by alias); 17 Aug 2005 15:56:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21039 invoked by uid 22791); 17 Aug 2005 15:56:18 -0000
Received: from pop.gmx.net (HELO mail.gmx.net) (213.165.64.20)
    by sourceware.org (qpsmtpd/0.30-dev) with SMTP; Wed, 17 Aug 2005 15:56:18 +0000
Received: (qmail invoked by alias); 17 Aug 2005 15:56:16 -0000
Received: from unknown (EHLO mordor) [213.91.247.38]
  by mail.gmx.net (mp028) with SMTP; 17 Aug 2005 17:56:16 +0200
X-Authenticated: #14308112
Date: Wed, 17 Aug 2005 15:56:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
X-X-Sender: ptsekov@mordor
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix for sending SIGHUP when the pty master side is
 close()-ed
In-Reply-To: <20050817153242.GD10757@trixie.casa.cgf.cx>
Message-ID: <Pine.CYG.4.58.0508171842310.1820@mordor>
References: <Pine.CYG.4.58.0508171731330.1696@mordor>
 <20050817153242.GD10757@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
X-SW-Source: 2005-q3/txt/msg00083.txt.bz2


On Wed, 17 Aug 2005, Christopher Faylor wrote:

> On Wed, Aug 17, 2005 at 06:30:25PM +0300, Pavel Tsekov wrote:
> >The attached patch solves this problem by rearranging the code a bit. It
> >tries to be non-intrusive. I offer it for discussion and comments. I hope
> >that my description of the problem and the patch will help to resolve the
> >issue even if the patch will get rejected in favour of a better one.
>
> It seems like your description and your rearrangement are probably
> correct.  This is a classic race.
>
> Want to provide a changelog?

Here it is - I didn't expect such a fast response :)

2005-08-17  Pavel Tsekov  <ptsekov@gmx.net>

	* fhandler_tty.cc (fhandler_tty_common::close): Rearrange the
	code so that the master end of the input and output pipes is
	closed before signalling an EOF event to the slave.
	(fhandler_pty_master::close): Likewise.

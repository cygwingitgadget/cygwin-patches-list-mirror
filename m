Return-Path: <cygwin-patches-return-5683-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14194 invoked by alias); 25 Nov 2005 19:52:59 -0000
Received: (qmail 14178 invoked by uid 22791); 25 Nov 2005 19:52:58 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 25 Nov 2005 19:52:58 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 548FE13D354; Fri, 25 Nov 2005 14:52:56 -0500 (EST)
Date: Fri, 25 Nov 2005 19:52:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Allow to send SIGQUIT via Ctrl+BREAK (patch included)
Message-ID: <20051125195256.GA11390@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <43863896.4080203@t-online.de> <20051125012622.GA12798@trixie.casa.cgf.cx> <1EfYLi-05iS2a0@fwd29.aul.t-online.de> <20051125164139.GD8670@trixie.casa.cgf.cx> <4387696F.9000409@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4387696F.9000409@t-online.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00025.txt.bz2

On Fri, Nov 25, 2005 at 08:43:43PM +0100, Christian Franke wrote:
>OK, let's forget the patch ;-)

Actually, I have done some more testing myself and Windows doesn't work
the way that I remembered.  It seems like CTRL-BREAK isn't handled by
signal(SIGINT, ...).  So, I was wrong about this.  I really should have
tested how it worked before rejecting your patch out of hand.

So, this code is probably just reflecting my misperceptions of what
Windows was doing.  I'll add your patch as it improves Cygwin's
functionality.

Thanks again for providing it.

cgf

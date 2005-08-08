Return-Path: <cygwin-patches-return-5612-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25494 invoked by alias); 8 Aug 2005 13:20:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25454 invoked by uid 22791); 8 Aug 2005 13:20:01 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 08 Aug 2005 13:20:01 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 84F1013C0EC; Mon,  8 Aug 2005 09:20:00 -0400 (EDT)
Date: Mon, 08 Aug 2005 13:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: Re: [Patch] /etc/termcap missing eA capabilities
Message-ID: <20050808132000.GB9516@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, cygwin@cygwin.com
References: <200508081119.j78BJQDm025624@ns-srv-2.bln1.siemens.de> <20050808114613.GA14783@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808114613.GA14783@calimero.vinschen.de>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00067.txt.bz2

On Mon, Aug 08, 2005 at 01:46:13PM +0200, Corinna Vinschen wrote:
>On Aug  8 13:19, Thomas Wolff wrote:
>> 2005-08-05  Thomas Wolff  <towo@computer.org>
>> 
>> 	* termcap: Updated xterm and rxvt (from /usr/share/terminfo 
>> 	using infocmp) to include the eA capability in order to enable 
>> 	programs to enable the alternate character set.
>
>Wrong mailing list.  cygwin-patches is for patches to the Cygwin package
>only.  Redirected to the cygwin ML.

And a hint:  Don't use termcap.  It's obsolete.

cgf

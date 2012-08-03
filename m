Return-Path: <cygwin-patches-return-7692-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16983 invoked by alias); 3 Aug 2012 10:40:29 -0000
Received: (qmail 16935 invoked by uid 22791); 3 Aug 2012 10:40:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 03 Aug 2012 10:39:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 845C52C02EE; Fri,  3 Aug 2012 12:39:48 +0200 (CEST)
Date: Fri, 03 Aug 2012 10:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Make `makewhatis` FAQ entry explicitly refer to `whatis`
Message-ID: <20120803103948.GA29616@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CE9C056E12502146A72FD81290379E9A4365635D@ENFIRHMBX1.datcon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CE9C056E12502146A72FD81290379E9A4365635D@ENFIRHMBX1.datcon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00013.txt.bz2

On Aug  3 09:07, Adam Dinwoodie wrote:
> All,
> 
> Minor FAQ patch below to make it explicit that `makewhatis` is used for
> `whatis` as well as `man -k` and `apropos`. Inspired by someone [apparently
> being confused][0] on Stack Overflow (yes, they were almost certainly being
> lazy, but I figure being more explicit will do no harm).
> 
> [0]: http://stackoverflow.com/questions/11774230/unix-cygwin-whatis-returns-all-commands-as-nothing-appropriate/11782300#comment15656666_11782300
> 
> I'm hoping this doesn't count as "significant" with regard to copyright
> assignment. I'd really rather not have to deal with that tedium.
> 
> This is my first submitted patch; I *think* I've got everything right, but
> apologies if not.

You didn't run make to check if it's working, did you?  The
<literal>apropos<literal> expression is missing a slash.

Anyway, thanks for the patch.  I also added a reference to whatis in the
actual text.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

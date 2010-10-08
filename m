Return-Path: <cygwin-patches-return-7122-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22724 invoked by alias); 8 Oct 2010 10:57:15 -0000
Received: (qmail 22675 invoked by uid 22791); 8 Oct 2010 10:57:03 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 08 Oct 2010 10:56:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C58966D42E4; Fri,  8 Oct 2010 12:56:56 +0200 (CEST)
Date: Fri, 08 Oct 2010 10:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to add C99 complex
Message-ID: <20101008105656.GA8659@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <915699.82111.qm@web25505.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <915699.82111.qm@web25505.mail.ukl.yahoo.com>
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
X-SW-Source: 2010-q4/txt/msg00001.txt.bz2

On Oct  6 08:01, Marco Atzeri wrote:
> here is the cygwin follow up of the patch 
> sent to newlib mailing list.
> 
> Marco
> 
> +        * cygwin.din ( cacos cacosf cacosh cacoshf carg cargf 
> +	   casin casinf casinh casinhf catan catanf catanh catanhf
> +	   ccos ccosf ccosh ccoshf cexp cexpf cimag cimagf clog clogf 
> +	   conj conjf cpow cpowf cproj cprojf creal crealf 
> +	   csin csinf csinh csinhf csqrt csqrtf 
> +	   ctan ctanf ctanh ctanhf): Export new complex math functions 
> +

Patch applied.  I also applied the matching patch to the documentation
and bumped the API version.

Thank you!


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

Return-Path: <cygwin-patches-return-7123-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18769 invoked by alias); 8 Oct 2010 15:18:01 -0000
Received: (qmail 18073 invoked by uid 22791); 8 Oct 2010 15:17:41 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-186-10.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.186.10)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 08 Oct 2010 15:17:37 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 3C1DD13C061	for <cygwin-patches@cygwin.com>; Fri,  8 Oct 2010 11:17:34 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id D83E52B352; Fri,  8 Oct 2010 11:17:33 -0400 (EDT)
Date: Fri, 08 Oct 2010 15:18:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to add C99 complex
Message-ID: <20101008151733.GA23848@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <915699.82111.qm@web25505.mail.ukl.yahoo.com> <20101008105656.GA8659@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101008105656.GA8659@calimero.vinschen.de>
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
X-SW-Source: 2010-q4/txt/msg00002.txt.bz2

On Fri, Oct 08, 2010 at 12:56:56PM +0200, Corinna Vinschen wrote:
>On Oct  6 08:01, Marco Atzeri wrote:
>> here is the cygwin follow up of the patch 
>> sent to newlib mailing list.
>> 
>> Marco
>> 
>> +        * cygwin.din ( cacos cacosf cacosh cacoshf carg cargf 
>> +	   casin casinf casinh casinhf catan catanf catanh catanhf
>> +	   ccos ccosf ccosh ccoshf cexp cexpf cimag cimagf clog clogf 
>> +	   conj conjf cpow cpowf cproj cprojf creal crealf 
>> +	   csin csinf csinh csinhf csqrt csqrtf 
>> +	   ctan ctanf ctanh ctanhf): Export new complex math functions 
>> +
>
>Patch applied.  I also applied the matching patch to the documentation
>and bumped the API version.
>
>Thank you!

I wanted to second the thanks.  Cygwin has needed this for many years.
I'm very glad that you took up the challenge of getting these functions
into newlib.

cgf

From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Re: gethostbyname/gethostbyaddr patch
Date: Thu, 23 Aug 2001 23:58:00 -0000
Message-id: <20010824085822.A10526@cygbert.vinschen.de>
References: <20010823161736.A1556@dothill.com>
X-SW-Source: 2001-q3/msg00086.html

On Thu, Aug 23, 2001 at 04:17:36PM -0400, Jason Tishler wrote:
> The following patch:
> 
>     http://www.cygwin.com/ml/cygwin-cvs/2001-q3/msg00100.html
> 
> broke gethostbyname() and gethostbyaddr() when the IP address contains
> zero components.  For example, my mail server is 24.0.95.227.  When I
> connect to it with a Cygwin app, the address actually used is 24.0.0.0.
> 
> The root cause is that dup_char_list() does not handle embedded null
> characters.  The attached patch is one way to correct this problem.
> 
> Jason

Thanks, applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

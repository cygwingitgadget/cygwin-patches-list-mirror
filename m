From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog autoload.cc autolo ...
Date: Thu, 03 May 2001 08:53:00 -0000
Message-id: <20010503175352.J24200@cygbert.vinschen.de>
References: <20010503093508.13491.qmail@sourceware.cygnus.com> <132246850181.20010503140017@logos-m.ru> <20010503130608.B24200@cygbert.vinschen.de> <20010503131328.C24200@cygbert.vinschen.de> <9258490099.20010503171417@logos-m.ru>
X-SW-Source: 2001-q2/msg00184.html

On Thu, May 03, 2001 at 05:14:17PM +0400, egor duda wrote:
> Hi!
> 
> Thursday, 03 May, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:
> 
> CV> Couldn't you use an instance of fhandler_dev_random?
> 
> ok, here it goes.
> 
> 2001-05-03  Egor Duda  <deo@logos-m.ru>
> 
>         * fhandler_socket.cc (set_connect_secret): Use /dev/random to
>         generate secret cookie.
> 
> Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

> i can. the only thing that worries me i that CryptGenRandom() may block
> for unpredictable and random amount of time.

I never saw that. It's true for /dev/random on U*X platforms but
I found no hint for that in the MSDN. Do you have a source for
that info?

A minor knit. I think it's better to use /dev/urandom instead
of /dev/random for that purpose since it uses the pseudo random
number generator if the CryptoAPI bails out. Base W95 don't have
a CryptoAPI for example and you can avoid an error in
read() when using /dev/urandom.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

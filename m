From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cygwin ChangeLog autoload.cc autolo ...
Date: Thu, 03 May 2001 03:03:00 -0000
Message-id: <132246850181.20010503140017@logos-m.ru>
References: <20010503093508.13491.qmail@sourceware.cygnus.com>
X-SW-Source: 2001-q2/msg00176.html

Hi!

Thursday, 03 May, 2001 corinna@sourceware.cygnus.com wrote:

cscc>         * net.cc (wsock_init): Add guard variable handling. Take care
cscc>         to call WSAStartup only once. Load WSAStartup without using
cscc>         autoload wrapper to eliminate recursion.  Eliminate FIONBIO
cscc>         and srandom stuff.

actually, srandom stuff was calles purposively in wsock_init. it's
supposed to make secret cookies for AF_UNIX sockets random. i know
that calling srandom() isn't the best way to assure this, but it's
better than nothing. I'll probably replace newlib's random to calls to
windows crypto-api, but until then, i think, srandom should be called
during init.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19


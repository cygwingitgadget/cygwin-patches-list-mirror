From: egor duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog autoload.cc autolo ...
Date: Thu, 03 May 2001 04:30:00 -0000
Message-id: <109252075495.20010503152723@logos-m.ru>
References: <20010503093508.13491.qmail@sourceware.cygnus.com> <132246850181.20010503140017@logos-m.ru> <20010503130608.B24200@cygbert.vinschen.de> <20010503131328.C24200@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00179.html

Hi!

Thursday, 03 May, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:

CV> On Thu, May 03, 2001 at 01:06:08PM +0200, Corinna Vinschen wrote:
>> On Thu, May 03, 2001 at 02:00:17PM +0400, egor duda wrote:
>> > cscc>         * net.cc (wsock_init): Add guard variable handling. Take care
>> > cscc>         to call WSAStartup only once. Load WSAStartup without using
>> > cscc>         autoload wrapper to eliminate recursion.  Eliminate FIONBIO
>> > cscc>         and srandom stuff.
>> > 
>> > actually, srandom stuff was calles purposively in wsock_init. it's
>> > supposed to make secret cookies for AF_UNIX sockets random. i know
>> > that calling srandom() isn't the best way to assure this, but it's
>> > better than nothing. I'll probably replace newlib's random to calls to
>> > windows crypto-api, but until then, i think, srandom should be called
>> > during init.
>> 
>> Calling srandom isn't correct since the random number generator
>> has to be initialized with a seed of 1 by default. Calling
>> srandom inside of Cygwin destroys that behaviour, unfortunately.

you're right. i've missed this.

CV> Couldn't you use an instance of fhandler_dev_random?

i can. the only thing that worries me i that CryptGenRandom() may block
for unpredictable and random amount of time.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19


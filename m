From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: RFP : shell defaults
Date: Sun, 16 Dec 2001 09:26:00 -0000
Message-ID: <20011216172634.GF28210@redhat.com>
References: <104801c18603$c811fb10$0200a8c0@lifelesswks> <Pine.LNX.4.21.0112161721240.2658-100000@lupus.ago.vpn>
X-SW-Source: 2001-q4/msg00325.html
Message-ID: <20011216092600.I2kLWASS7_qlypd846VXQ_1ujtHEl49YPaEjl-9ItFs@z>

On Sun, Dec 16, 2001 at 05:25:11PM +0100, Alexander Gottwald wrote:
>On Sun, 16 Dec 2001, Robert Collins wrote:
>> If someone wants to follow my notes in reply to Corinna and create a
>> shell defaults package, that would be great. AFAIK all distro's generate
>> a very simply prompt for you, and then leave it up to you.
>
>One thing that might be useful: 
>
>SuSE Linux sets PROFILEREAD=yes as first thing in /etc/profile and
>all $HOME/.profile depend on this and read /etc/profile if this is
>not set. 
>
>Running cygwin and accessing homes on a SuSE box will fall into an 
>never ending loop.

And, it sounds like (possibly) running Mandrake linux and accessing home
on a SuSE box will fall into an infinite loop, and (definitely) running
Red Hat will do so.

This sounds like a dubious feature to me.

cgf

From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Alexander Gottwald" <alexander.gottwald@informatik.tu-chemnitz.de>
Cc: <cygwin-xfree@sources.redhat.com>, <cygwin-patches@cygwin.com>
Subject: Re: [Patch] SIOCGIFCONF Win95
Date: Thu, 27 Sep 2001 02:24:00 -0000
Message-id: <002a01c14736$5b7561b0$01000001@lifelesswks>
References: <Pine.LNX.4.21.0109271045270.23288-200000@rotuma.informatik.tu-chemnitz.de>
X-SW-Source: 2001-q3/msg00205.html

----- Original Message -----
From: "Alexander Gottwald"
<alexander.gottwald@informatik.tu-chemnitz.de>
To: <cygwin@cygwin.com>
Cc: <cygwin-xfree@sources.redhat.com>
Sent: Thursday, September 27, 2001 7:15 PM
Subject: [Patch] SIOCGIFCONF Win95


> Hi,
>
> On Win95, the implementation of SIOCGIFCONF seems to be wrong. For
Win95a
> it seems to work, but Win95b and Win95c will onyl return the loopback
> device. Searching through the code, I found the reason in
winsup/cygwin/net.c
...
>
> I modified the function in net.c and the correct number of interfaces
is
> reported for win95a and win95c.
>
> I attached the patch. A patch cygwin1.dll is available at
> < http://www.tu-chemnitz.de/~goal/xfree/cygwin1.fixed-netdev.dll.bz2 >
>

Great work Alex,
You might like to cc cygwin-patches for any future stuff that turns up
:}.

The patch looks good to me and it's great for such a long standing bug
to be caught and fixed.

Rob

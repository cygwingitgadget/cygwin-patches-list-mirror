From: "Norman Vine" <nhv@cape.com>
To: "'Robert Collins'" <robert.collins@itdomain.com.au>, "'Jason Tishler'" <jason@tishler.net>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: fix cond_race... was RE: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Sun, 30 Sep 2001 08:58:00 -0000
Message-id: <000201c149c9$5e3d14c0$a300a8c0@nhv>
References: <006701c149be$0676afe0$01000001@lifelesswks>
X-SW-Source: 2001-q3/msg00246.html

 Robert Collins writes:
>>
>please try an updated dll, I've checked in a potential fix now. If that
>doesn't fix it, then..

YEA !!!

The Python thread regression tests seem to work after the this change :-)

Mon Oct  1 00:34:00 2001  Robert Collins <rbtcollins@hotmail.com>

	* thread.cc (pthread_cond_dowait): Hopefully eliminate a race on multiple
thread
	wakeups.

I have only tested this on Win2k sp2

Many thanks for your help !

Cheers

Norman



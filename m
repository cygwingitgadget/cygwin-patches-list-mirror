From: "Andy Younger" <andylyounger@hotmail.com>
To: cygwin-patches@cygwin.com
Subject: /dev/dsp
Date: Tue, 17 Apr 2001 08:36:00 -0000
Message-id: <F23AZndKaQf0Stamg6d00000c37@hotmail.com>
X-SW-Source: 2001-q2/msg00101.html

I have just been looking through the applied patch after failing to get the 
CVS version of /dev/dsp working on my "at work" machine.

It seems to be to do with the FH_OSS_DSP enumeration in fhandler.h, this has 
been set up as a fast device, where as in the original patch, it was a slow 
one. What exactly is the difference between slow & fast devices. Should it 
not be a slow device being that calls to write() can block for a good 
fraction of a second (depending on the size & number of fragments).

Making it a slow device enables it to work. Is this maybe just exposing a 
problem somewhere else? I don't have time to look at this right now, maybe 
later on, any hints welcomed.

As to how I got it too work last night, I'm not sure - maybe it was just 
tiredness.. Bahhh..

Thanks,

Andy.


_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com .

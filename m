From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/dsp
Date: Tue, 17 Apr 2001 09:24:00 -0000
Message-id: <20010417122430.B25694@redhat.com>
References: <F23AZndKaQf0Stamg6d00000c37@hotmail.com>
X-SW-Source: 2001-q2/msg00104.html

On Tue, Apr 17, 2001 at 03:36:17PM -0000, Andy Younger wrote:
>I have just been looking through the applied patch after failing to get the 
>CVS version of /dev/dsp working on my "at work" machine.
>
>It seems to be to do with the FH_OSS_DSP enumeration in fhandler.h, this has 
>been set up as a fast device, where as in the original patch, it was a slow 
>one. What exactly is the difference between slow & fast devices. Should it 
>not be a slow device being that calls to write() can block for a good 
>fraction of a second (depending on the size & number of fragments).
>
>Making it a slow device enables it to work. Is this maybe just exposing a 
>problem somewhere else? I don't have time to look at this right now, maybe 
>later on, any hints welcomed.
>
>As to how I got it too work last night, I'm not sure - maybe it was just 
>tiredness.. Bahhh..

This doesn't qualify as a slow device unless it can be interrupted.
That means that you have to provide the appropriate framework for doing
so in select.cc like you see with other slow devices.  If/when you do
that we can make it slow again.

The problem that you're seeing is due to the fact that I forgot to move
the \dev\dsp string in path.cc.  I have rectified this.

cgf

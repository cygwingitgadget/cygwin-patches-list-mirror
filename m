From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/dsp
Date: Tue, 17 Apr 2001 09:38:00 -0000
Message-id: <20010417183805.D15005@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00105.html

On Tue, Apr 17, 2001 at 07:42:56AM -0000, Andy Younger wrote:
> Thanks, for looking into clearing up the soundcard.h problems, I was 
> somewhat paranoid about this. Anyway,
> 
> The version in CVS, seems to work fine, I am currently listening to some 
> MP3's under Esound & mpg123.
> 
> I have been real busy at my real work as of late :-(. So have not had time 
> to do much with it. I have made a couple of small improvements, mostly to 
> improve compatibility with some OSS apps, now Esound & Mikmod's sound 
> drivers compile pretty much OOTB, (although there are some issues with with 
> noise when using Esound's sockets it seems to work pretty well). Anyway here 
> is my patch for the improvements.
> 
> Sorry about the use of machine/soundcard.h, I had a symbolic link for this, 
> as it helps compiling BSD based source. sys/soundcard.h seems to be a linux 
> thing.
> 
> Cheers,
> 
> Andy.
> 
> --
> 
> Mon Apr 16 23:20:00 2001  Andy Younger <andylyounger@hotmail.com>
> 
>     * fhandler_dsp.cc: Improved handling of 8 bit playback modes.
>     Put in mock support for SNDCTL_DSP_SETFRAGMENT. This permits
>     Esd & mikmod to compile out of the box.
> --

Your patch isn't ok. I can't apply it since it's malformed.
Could you please generate a new patch and send it to the list again?
And please send it only once and not inline _and_ as an attachment.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

From: "Andy Younger" <andylyounger@hotmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/dsp
Date: Wed, 18 Apr 2001 09:36:00 -0000
Message-id: <F52bMwDdKiXXc4QzPW800001ffd@hotmail.com>
X-SW-Source: 2001-q2/msg00111.html

>
>Your patch isn't ok. I can't apply it since it's malformed.
>Could you please generate a new patch and send it to the list again?
>And please send it only once and not inline _and_ as an attachment.
>

Ok. hopefully right this time, fingers crosse.

Patch created by

diff -up fhandler_dsp.cc.original fhandler_dsp.cc >fhandler_dsp.cc-patch 
2>&1

Changelog:

Mon Apr 16 23:20:00 2001  Andy Younger <andylyounger@hotmail.com>

    * fhandler_dsp.cc: Improved handling of 8 bit playback modes.
    Put in mock support for SNDCTL_DSP_SETFRAGMENT. This permits
    Esd & mikmod to compile out of the box.

Cheers,

  Andy.

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com .

From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/dsp
Date: Fri, 20 Apr 2001 06:20:00 -0000
Message-id: <20010420152034.D15499@cygbert.vinschen.de>
References: <F52bMwDdKiXXc4QzPW800001ffd@hotmail.com>
X-SW-Source: 2001-q2/msg00123.html

On Wed, Apr 18, 2001 at 04:35:55PM -0000, Andy Younger wrote:
> >
> >Your patch isn't ok. I can't apply it since it's malformed.
> >Could you please generate a new patch and send it to the list again?
> >And please send it only once and not inline _and_ as an attachment.
> >
> 
> Ok. hopefully right this time, fingers crosse.

Sorry Andy, but it's malformed again. I tried it both, w/ and w/o
-b option and I have even changed the below mystery to be correctly
indented but to no avail.

> --- fhandler_dsp.cc.original	Wed Apr 18 17:25:48 2001
> +++ fhandler_dsp.cc	Wed Apr 18 15:24:25 2001
> @@ -28,7 +28,7 @@ static void CALLBACK wave_callback(HWAVE
> class Audio
> {
> public:

That's the mystery: The aforementioned three lines are beginning
in column 0. That's not the output of a `diff -up' since the
first column inside of a hunk is reserved for the diff-symbols
(+ and - for unified diffs). Did you rework the patch in a
editor, perhaps???

Just for your information, I got the following output from
`patch -p0 -b < <your-patch-file>

patching file fhandler_dsp.cc
Hunk #2 FAILED at 40.
Hunk #4 succeeded at 294 with fuzz 1.
Hunk #5 FAILED at 525.
Hunk #6 FAILED at 601.
3 out of 6 hunks FAILED -- saving rejects to file fhandler_dsp.cc.rej

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: CTRL-U in bash changes color to black on black?
Date: Thu, 22 Mar 2001 18:48:00 -0000
Message-id: <20010322214836.A16566@redhat.com>
References: <20010321221952.A12182@redhat.com> <194675503.20010322180111@logos-m.ru>
X-SW-Source: 2001-q1/msg00246.html

On Thu, Mar 22, 2001 at 06:01:11PM +0300, Egor Duda wrote:
>Hi!
>
>Thursday, 22 March, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>CF> I just noticed that a CTRL-U in bash on Windows 95 either causes the
>CF> color in bash to change to black on black or somehow causes characters
>CF> to be output as spaces.  The cursor still moves but no characters are
>CF> displayed.
>
>CF> Does anyone have time to look into this?
>
>can anybody test this patch? i think it may help. i don't have w95
>around to test it myself, so please give some feedback.

It seems to fix the problem completely.  Wow.  Thanks for the quick
response, Egor!

I've checked this in.

cgf

From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Setup.exe "other URL" functionality
Date: Fri, 28 Dec 2001 03:08:00 -0000
Message-ID: <069b01c18f90$0a195720$0200a8c0@lifelesswks>
References: <NCBBIHCHBLCMLBLOBONKKEBICIAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00358.html
Message-ID: <20011228030800.LCvgcE9Q4PFYIkewrFfREHZ3h4oM4960xheB0JSuLB4@z>

Gary, can I ask that you do not bz2 your diffs, unless there is real
need for it?

It makes having a quick look at them much harder...

Rob
===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Sent: Friday, December 28, 2001 10:05 PM
Subject: [PATCH] Setup.exe "other URL" functionality


> Here's a patch that makes the "Other URL" functionality work.  I've
merged the
> IDD_SITE and IDD_OTHER_URL boxes into one, which seems more intuitive
(and yes,
> that list box is getting pretty stubby, it's on the proverbial plate).
>
> I also removed "test -f ./.bashrc && . ./.bashrc" from the generated
> /etc/profile.  Bash sources this automatically after it reads
/etc/profile, so
> all it was accomplishing with bash as your shell was to run .bashrc
twice, which
> I doubt was ever the intent, and I have to guess that users of other
shells
> don't really want to be running a ._bash_rc file.
>
> Note that I've attached two patches here.  The contents are the same,
but due to
> some wackiness in either "cvs diff" or indent (lemme make a WAG, sit
down for
> this one: CRLF probs? ;-)), the larger one (-pu'ed) ends up replacing
the entire
> contents of several files, while the smaller one (-pub'd) is rather
less
> agressive.
>
> Take your pick, it's Gair's Bimonthly 2-for-1 Sale!  Every diff must
go! ;-)
>
> --
> Gary R. Van Sickle
> Brewer.  Patriot.
>

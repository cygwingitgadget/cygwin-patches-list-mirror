From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Update 2 - Setup.exe property sheet patch
Date: Thu, 20 Dec 2001 12:22:00 -0000
Message-ID: <000601c18994$10e82920$2101a8c0@BRAEMARINC.COM>
References: <027c01c18957$0d5d6870$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00344.html
Message-ID: <20011220122200.k-KtlpmHyJC0dh-NrqiuFuqbg6a1mtlBE42wxHFidaM@z>

> Having had a good close look, there is a little more that is needed
> before committing to CVS.
>
> 1) You've skipped at least one dialog - IDD_S_FROM_CWD - which is what
> was breaking local_dir.

Ok, I'll get that fixed tonight.

> (Oh, and the functions weren't virtual in some
> child classes :}).

"Once virtual, always virtual", i.e., it isn't necessary to add "virtual" to
any overridden virtual functions, and in fact it's not possible to
"unvirtualize" once virtualized.  I do try to maintain them as a stylistic
convention, but even I fall short sometimes ;-).  Thanks for patching that.

> 2) See download.cc - is next_dialog still used, and should a
> fail result
> in the previous behaviour?
>

I believe it is still used in a few places (some of the "do_xxx"'s).  That
whole mechanism is one of the next things to go.  As far as behavior is
concerned, I'm trying hard to specifically *not* change any at this point,
but simply to get the new property page and class foundation laid ("simply"
he sez ;-)).  So you're saying that a download failure isn't being handled
properly?

> I've attached an updated patch for you with the virtual functions
> actually still virtual.
>

Thanks, and thanks for running it through indent.  It looks all GNUey now
;-).

> Rob
>

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337

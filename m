From: Corinna Vinschen <vinschen@cygnus.com>
To: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: preliminary patch2 for i18n: change the code page to ANSI.
Date: Tue, 04 Jul 2000 04:00:00 -0000
Message-id: <3961C3A6.A56E102@cygnus.com>
References: <s1saefyooqa.fsf@jaist.ac.jp> <20000703190459.A30846@cygnus.com> <s1s8zviodkm.fsf@jaist.ac.jp> <20000703222950.A5294@cygnus.com> <s1s7lb2oa1d.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00006.html

Kazuhiro Fujieda wrote:
> 
> >>> On Mon, 3 Jul 2000 22:29:50 -0400
> >>> Chris Faylor <cgf@cygnus.com> said:
> 
> > Maybe your changes to fhandler_console are all that is required but I
> > would appreciate it if you would remain vigilant for complaints on the
> > cygwin mailing list once this new version is released.
> 
> Yes I will.
> 
> By the way, I believe Corinna knows the issue of ANSI/OEM code
> pages well. Can I hear your opinion of my changes, Corinna?

Only one thing: Did you notice the use of OemToChar() in
security.cc::read_sd()?
It was necessary to get GetFileSecurity() working with umlauts.

Shouldn't this be changed then, too?

Corinna

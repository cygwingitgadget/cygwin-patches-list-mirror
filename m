From: Corinna Vinschen <vinschen@cygnus.com>
To: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: preliminary patch2 for i18n: change the code page to ANSI.
Date: Tue, 04 Jul 2000 07:27:00 -0000
Message-id: <3961F45F.D6B06C35@cygnus.com>
References: <s1saefyooqa.fsf@jaist.ac.jp> <20000703190459.A30846@cygnus.com> <s1s8zviodkm.fsf@jaist.ac.jp> <20000703222950.A5294@cygnus.com> <s1s7lb2oa1d.fsf@jaist.ac.jp> <3961C3A6.A56E102@cygnus.com> <s1s4s66ngar.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00008.html

Kazuhiro Fujieda wrote:
> 
> >>> On Tue, 04 Jul 2000 12:59:50 +0200
> >>> Corinna Vinschen <vinschen@cygnus.com> said:
> 
> > Only one thing: Did you notice the use of OemToChar() in
> > security.cc::read_sd()?
> > It was necessary to get GetFileSecurity() working with umlauts.
> >
> > Shouldn't this be changed then, too?
> 
> Yes, it should be changed. I failed to include the change of
> security.cc in my previous mail. Thank you for your notice.

Thanks for your reply. I will check that in today.

Corinna

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company

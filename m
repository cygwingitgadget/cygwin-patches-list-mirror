From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: "Cygwin-Patches" <cygwin-patches@sourceware.cygnus.com>
Cc: "Egor Duda" <deo@logos-m.ru>
Subject: RE: Patch for ssp on win2k
Date: Wed, 19 Sep 2001 11:02:00 -0000
Message-id: <000001c14135$e58204a0$af6407d5@BRAMSCHE>
X-SW-Source: 2001-q3/msg00168.html

> >
> > Hi!
> >
> > Tuesday, 18 September, 2001 Ralf Habacker Ralf.Habacker@freenet.de wrote:
> >
> > RH> I don't know if this a condition indicate a failure. rc contains
> > an adress which
> > RH> direct into the ntdll.dll.
> > RH> Perhaps it means something other as used currently, but examinig
> > the content
> > RH> under that adress produces no additional infos for me.
> >
> > you can take a look at gdb or dumper sources. they contain functions
> > that try to obtain dll name using "official" means (psapi.dll) on NT.
> >
> That's great. Do you know, where I can find a documentation for this api ?
>
Please don't misunderstand, the  hints with dumper and gdb are very good,
thanks,
but I like to know which things are able and which are not with this api.
And currently I cannot say if that what is implemented in gdb, is the whole api

> I ask because currently kde2 needs huge memory (about 200MB: the win2k task
> manager say this) and I like to look in which dlls all the memory is gone ?
> Or does anyone know about an already available tool for this ?
>
> Ralf
>
> > Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
> >
> >

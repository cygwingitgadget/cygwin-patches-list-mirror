From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: "egor duda" <cygwin-patches@cygwin.com>
Cc: "Cygwin-Patches" <cygwin-patches@sourceware.cygnus.com>
Subject: RE: Patch for ssp on win2k
Date: Wed, 19 Sep 2001 07:03:00 -0000
Message-id: <000101c14114$6d028e80$651c440a@BRAMSCHE>
References: <561543329.20010918162950@logos-m.ru>
X-SW-Source: 2001-q3/msg00166.html

> -----UrsprÃ¼ngliche Nachricht-----
> Von: egor duda [ mailto:deo@logos-m.ru ]
> Gesendet am: Dienstag, 18. September 2001 14:30
> An: Ralf Habacker
> Cc: cygwin-patches@cygwin.com
> Betreff: Re: Patch for ssp on win2k
>
> Hi!
>
> Tuesday, 18 September, 2001 Ralf Habacker Ralf.Habacker@freenet.de wrote:
>
> RH> I don't know if this a condition indicate a failure. rc contains
> an adress which
> RH> direct into the ntdll.dll.
> RH> Perhaps it means something other as used currently, but examinig
> the content
> RH> under that adress produces no additional infos for me.
>
> you can take a look at gdb or dumper sources. they contain functions
> that try to obtain dll name using "official" means (psapi.dll) on NT.
>
That's great. Do you know, where I can find a documentation for this api ?

I ask because currently kde2 needs huge memory (about 200MB: the win2k task
manager say this) and I like to look in which dlls all the memory is gone ?
Or does anyone know about an already available tool for this ?

Ralf

> Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
>
>

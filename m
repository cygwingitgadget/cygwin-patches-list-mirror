From: egor duda <deo@logos-m.ru>
To: "Ralf Habacker" <Ralf.Habacker@freenet.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: Patch for ssp on win2k
Date: Tue, 18 Sep 2001 05:32:00 -0000
Message-id: <561543329.20010918162950@logos-m.ru>
References: <000a01c1402b$461cd2b0$651c440a@BRAMSCHE>
X-SW-Source: 2001-q3/msg00164.html

Hi!

Tuesday, 18 September, 2001 Ralf Habacker Ralf.Habacker@freenet.de wrote:

RH> I don't know if this a condition indicate a failure. rc contains an adress which
RH> direct into the ntdll.dll.
RH> Perhaps it means something other as used currently, but examinig the content
RH> under that adress produces no additional infos for me.

you can take a look at gdb or dumper sources. they contain functions
that try to obtain dll name using "official" means (psapi.dll) on NT.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

From: egor duda <deo@logos-m.ru>
To: "Ralf Habacker" <Ralf.Habacker@freenet.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: Patch for ssp on win2k
Date: Wed, 19 Sep 2001 11:47:00 -0000
Message-id: <231632437.20010919224629@logos-m.ru>
References: <000001c14135$e58204a0$af6407d5@BRAMSCHE>
X-SW-Source: 2001-q3/msg00169.html

Hi!

Wednesday, 19 September, 2001 Ralf Habacker Ralf.Habacker@freenet.de wrote:

>> >
>> > Hi!
>> >
>> > Tuesday, 18 September, 2001 Ralf Habacker Ralf.Habacker@freenet.de wrote:
>> >
>> > RH> I don't know if this a condition indicate a failure. rc contains
>> > an adress which
>> > RH> direct into the ntdll.dll.
>> > RH> Perhaps it means something other as used currently, but examinig
>> > the content
>> > RH> under that adress produces no additional infos for me.
>> >
>> > you can take a look at gdb or dumper sources. they contain functions
>> > that try to obtain dll name using "official" means (psapi.dll) on NT.
>> >
>> That's great. Do you know, where I can find a documentation for this api ?
>>
RH> Please don't misunderstand, the  hints with dumper and gdb are very good,
RH> thanks,
RH> but I like to know which things are able and which are not with this api.
RH> And currently I cannot say if that what is implemented in gdb, is the whole api

as Corinna said, the answer is "MSDN" :)

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/perfmon/hh/winbase/psapi_0go9.asp

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

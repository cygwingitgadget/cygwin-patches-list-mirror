From: "Schaible, Jorg" <Joerg.Schaible@gft.com>
To: cygwin-patches@Cygwin.Com
Cc: gerrit.haase@convey.de
Subject: RE: patch for cygpath
Date: Wed, 08 Aug 2001 00:51:00 -0000
Message-id: <C2D7D58DBFE9D111B0480060086E963504AC52F7@mail.gft.de>
X-SW-Source: 2001-q3/msg00072.html

Hi Chris,

>>>Christopher Faylor wrote:
>>>> 
>>>> I don't have much of an opinion on this patch however it seems to
>>>> needlessly complicate cygpath for minimal gain.
>>>> 
>>>
>>>Ditto.
>>
>>Well, it just ensures that the physical name is the delivered one.
>
>But it really doesn't matter since Windows is case insensitive and
>we're using Windows' mechanism for retrieving the name anyway.  It
>just seems like "busy work".

maybe we should ask Gerrit for further reasons, he raised this issue as bug
in the list. Gerrit: It's the "cygpath -S" output.

>
>I'd like to get some opinions on it.  So far we've just heard 
>from Earnie.
>

and Corinna 
:)


Regads,
Jorg

From: "Gerrit P. Haase" <gp@familiehaase.de>
To: cygwin-patches@Cygwin.Com
Subject: RE: patch for cygpath
Date: Thu, 09 Aug 2001 04:58:00 -0000
Message-id: <3B7296E1.29941.F52A5B@localhost>
References: <C2D7D58DBFE9D111B0480060086E963504AC52F7@mail.gft.de>
X-SW-Source: 2001-q3/msg00073.html

Am 8 Aug 2001, um 9:51 hat Schaible, Jorg geschrieben:

>Hi Chris,
>
>>>>Christopher Faylor wrote:
>>>>> 
>>>>> I don't have much of an opinion on this patch however it seems to
>>>>> needlessly complicate cygpath for minimal gain.
>>>>> 
>>>>
>>>>Ditto.
>>>
>>>Well, it just ensures that the physical name is the delivered one.
>>
>>But it really doesn't matter since Windows is case insensitive and
>>we're using Windows' mechanism for retrieving the name anyway.  It
>>just seems like "busy work".
>
>maybe we should ask Gerrit for further reasons, he raised this issue as bug
>in the list. Gerrit: It's the "cygpath -S" output.

Hey, i thought it was not heard:-)
Well, i discovered this 'bug' by accident when executing an old script 
which converts man pages and displays them in IExplorer. (Platform 
independent script, thats why it uses cygpath).
It works o.k. at home on my server, even with case_check:strict setting on, 
what is dubious.
At my workstation i needed to call cmd.exe with an absolut path since the 
cygpath -S output is not correct and I want to use case-sensitive behaviour.

I think since there is now this option to be case_sensitve, it should be 
handled consequently. 
BTW, instead of discussing, which lasts some time, it could have been 
approved and committed in the same time.

>>
>>I'd like to get some opinions on it.  So far we've just heard 
>>from Earnie.
>>
>
>and Corinna 
>:)
>
>
>Regads,
>Jorg
>

gph


-- 
=^..^=

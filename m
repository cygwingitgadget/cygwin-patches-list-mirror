From: "Gareth Pearce" <tilps@hotmail.com>
To: robert.collins@itdomain.com.au, cygwin-patches@cygwin.com
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Fri, 09 Nov 2001 14:37:00 -0000
Message-id: <F255rNNOCTlI2N76PQ400005c19@hotmail.com>
X-SW-Source: 2001-q4/msg00178.html

>
>----- Original Message -----
>From: "Gareth Pearce" <tilps@hotmail.com>
>To: <cygwin-patches@cygwin.com>
>Sent: Friday, November 09, 2001 10:32 PM
>Subject: [Patch] setup.exe - no skip/keep option buggyness
>
>
> > Hi
> > lets see if i can stuff up a patch this small...
>
>You managed too :]. (A tiny thing, and I'd correct it when committing
>anyway - in the changelog, the (function) comes before the : not after.
>
>...
> > If it would be better labeling things as keep, thats easily done, but
>I sort
>
>Yes please. The concept is that skip applies to uninstalled packages,
>and keep applies to installed packages.
>
> > Ofcourse if you dont like it ... scrap it ... :), I will just keep it
>in my
> > local version since its so utterly useful.
>
>It's a bug I introduced whilst 'fixing' another bug, and I have had a
>machine down for a few days recently, so had not fixed. Thanks for this
>patch... but I'd really prefer one to allow 'keep' as an option for any
>package which has a currently installed version - even if that version
>is not in setup.ini.
>
>Rob
>

Would have submited another go ... but what you have done looks great (A 
more significant change then I would have submited, but then I am in newbie 
cautious mode), and I am in the middle of a 336meg download of debian 
unstable updates on a slow modem... (dual boot system so no windows for the 
next day or 2 for me...) - the trials of being too busy to run apt-get 
upgrade for a couple of months...

Gareth


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

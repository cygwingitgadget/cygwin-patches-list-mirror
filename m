From: Mark Paulus <mark.paulus@wcom.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Patch to syscalls.cc for statfs/df problem
Date: Mon, 12 Mar 2001 06:40:00 -0000
Message-id: <0GA300J0UA1I0V@pmismtp04.wcomnet.com>
References: <20010309233237.T3079@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00168.html

I re-worked it some more over the weekend, and have some new
code.  Should I submit it via this forum again?  And, if so, 
should I diff against the original code, or against my latest patch?

A bit more clarification.  It appears to be working more correct
now.  My one wierdness seems to occur when I try to do a statfs 2 or
more times against a SAMBA drive.  The first statfs call looks
like it returns good values.  But the second call seems to 
return some bogus stuff.  This is under WinME.  I don't have a way
to test Win2K to SAMBA (I only have WinME and Linux 
boxes at home, and only have Win2K and OS/2 boxes at work).


On Fri, 09 Mar 2001 23:32:37 +0100, Corinna Vinschen wrote:

>On Fri, Mar 09, 2001 at 01:52:07PM -0700, Mark Paulus wrote:
>> Enclosed is a patch to syscalls.cc which enables the use of
>> the GetDiskFreeSpaceEx call in statfs().  It seems to work
>> in my environment, except for one small problem.  It appears 
>> that under WinME, it does not recognize the free space of 
>> network mounted drives that have over 2GB of free space:
>> e.g.
>> 
>> in dos:
>> net use j: \\server\use
>> 
>> in cygwin:
>> mount j:/ /jdrive
>> 
>> if you then do a df, and J: has more than 2GB free, then 
>> it will show:
>> Filesystem           1k-blocks      Used Available Use% Mounted on
>> j:                     2097120         0   2097120   0% /jdrive
>> 
>> However, from the testing I have been able to do, it appears
>> this is a failure of the GetDiskFreeSpaceEx call...
>
>Hmmm, that's an interesting one. Is the network drive somehow
>using quotas, perhaps?
>
>Another one. Did you try your patch with UNC paths? I'm asking
>because MSDN states that UNC paths must end with a backslash
>when using this function (\\server\share\). It would be really
>nice if you could have a look.
>
>Thanks,
>Corinna
>
>-- 
>Corinna Vinschen                  Please, send mails regarding Cygwin to
>Cygwin Developer                                mailto:cygwin@cygwin.com
>Red Hat, Inc.



From: "'cgf@redhat.com'" <cygwin-patches@cygwin.com>
To: Victor Tsou <vtsou@good.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Serial code stack corruption
Date: Tue, 11 Dec 2001 12:15:00 -0000
Message-ID: <20011211201523.GC2260@redhat.com>
References: <E1740305C340D411AC5500B0D020FF7A010656FB@stmail01.good.com>
X-SW-Source: 2001-q4/msg00304.html
Message-ID: <20011211121500.Qe97Y1YTrvjdcgde0pUjpWGHJU-DCUDf3PnTWDMUtu8@z>

[redirected back to cygwin-patches]
On Tue, Dec 11, 2001 at 12:04:52PM -0800, Victor Tsou wrote:
>(Sorry for crummy formatting; I'm coping with the Outlook web
>interface).
>
>>Do you actually have a test case that illustrates this scenario?
>
>Not a simple one, though we have a reproducible process for achieving
>the crash on multiple machines.  Putting in the patch fixes the crash
>on all the affected machines.
>
>It's a bit tricky to pull off, but I may be able to hack together a
>test case.  Unfortunately, even then you might not be able to reproduce
>the results because we've only seen the problem using a custom serial
>port driver.  Our driver guy was the one who actually identified the
>problem.
>
>>I don't remember any more but I thought that raw_read wasn't supposed
>>to be exited unless I/O was complete.
>
>It probably isn't, but the control paths are so numerous and twisty
>that it'd be easy to forget to do so as the function is modified over
>time.
>
>>However, I've added an 'ev' field to the fhandler_serial class which
>>can be used for this.  I think that should eliminate any possibility of
>>stack corruption.
>
>Great, I made that fix initially before deciding on the C++ auto
>release solution.  That patch fixed the problem on the affected
>machines.
>
>Thanks for taking the fix; we'll be happy not to have to ship out
>custom DLLs.

I didn't take the fix, actually.  I just implemented the 'ev' solution
that I mentioned.  A new DLL with this feature is downloadable at the
snapshots page.

Also, not to sound like a broken record but since you mention the term
"ship out", I have to point out that if you are providing software to
people which uses the cygwin DLL you have to also provide source code
cygwin's licensing terms.

I mention this to everyone who seems to be shipping software which uses
the DLL.  I'm sure that you're already aware of this and maybe I've even
already mentioned it to you already, however, you can consider my
caveats part of the cygwin toll.  If you are adhering to the license
terms then you can just ignore me.

cgf

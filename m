From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Serial code stack corruption
Date: Mon, 10 Dec 2001 16:24:00 -0000
Message-ID: <20011211002507.GA31233@redhat.com>
References: <E1740305C340D411AC5500B0D020FF7A010656F2@stmail01.good.com>
X-SW-Source: 2001-q4/msg00298.html
Message-ID: <20011210162400.X-5QtI5gHF3Y4bRDnGy1FPO-L4Fkj0zmDpkkK03pGio@z>

On Mon, Dec 10, 2001 at 03:22:28PM -0800, Victor Tsou wrote:
>
>WaitCommEvent was called in overlapped mode with a pointer to a stack
>variable passed in for lpEvtMask. When the asynchronous request completes in
>the future, the function might no longer be in scope. In such cases, data on
>the stack is erroneously overwritten with the event mask.
>
>This patch cancels the WaitCommEvent request by calling SetCommMask. This is
>the only documented method of cancelling the eventmask update.

Do you actually have a test case that illustrates this scenario?

I don't remember any more but I thought that raw_read wasn't supposed to be
exited unless I/O was complete.

However, I've added an 'ev' field to the fhandler_serial class which can
be used for this.  I think that should eliminate any possibility of
stack corruption.

Thanks for the patch.

cgf

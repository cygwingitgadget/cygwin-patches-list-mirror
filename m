Return-Path: <cygwin-patches-return-4897-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20514 invoked by alias); 14 Aug 2004 17:38:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20501 invoked from network); 14 Aug 2004 17:38:21 -0000
Message-Id: <3.0.5.32.20040814133418.0081e220@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 14 Aug 2004 17:38:00 -0000
To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>,
 cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: RE: [Patch]: fhandler_dsp.cc
In-Reply-To: <01C4821C.DCA0AFF0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00049.txt.bz2

At 04:36 PM 8/14/2004 +0200, Gerd Spalink wrote:
>Hello,
>
>After some busy weeks with no spare time for cygwin and before leaving for 
>two weeks of summer vacation, I looked briefly at your patch.
>
>Your patch looks quite good. But I used two queues for a purpose:
>isr2app: buffers that have been Prepared and must be Unprepared before use
>app2app: buffers that are ready for use
>
>So I am afraid that in 
>fhandler_dev_dsp::Audio_out::sendcurrent
>the error handling is functionally not the same:
>If PrepareHeader has been successful, then (and only then)
>the driver must do UnprepareHeader for this header.
>This requirement is from the win32 API.
>And if PrepareHeader goes wrong, our driver should not lose that buffer.
>After your patch, headers that have not been "Prepared" might get
>"Unprepared" (if PrepareHeader fails).

Hi Gerd,

Thanks a lot for taking the time to review the patch. I agree that the
whole area of {un}prepareheader error handling needs work. In fact it's
the only spot where I added a FIXME. So lets review it.
Of course those calls should never fail if the driver is written
correctly, so we may be discussing moot cases. That's why I had just
put a FIXME and moved on.

To answer your specific point, MS says this in
<http://msdn.microsoft.com/library/default.asp?url=/library/en-us/multimed/h
tm/_win32_waveoutprepareheader.asp>
"Unpreparing a buffer that has not been prepared has no effect,
and the function returns zero". 
I admit this is a very unexpected statement, but in principle you
shouldn't have to worry.
The only MS requirement is to call UnprepareHeader AFTER the device
driver is finished with a data block and before freeing the buffer.
So perhaps there might be a problem because UnprepareHeader will be
called (again) without the buffer having been sent to the device driver.
I will address that below.

1) Audio_out::waitforspace: There is no error handling for UnprepareHeader.
Not sure what to do. It makes no sense to put it back on the queue and repeat
the call later. If we proceed (as currently), the subsequent PrepareHeader
should logically fail (the flag will have an invalid value for PrepareHeader,
see the PrepareHeader MS page). Putting it back on the queue at that point
doesn't make sense either. 
So perhaps we should just drop it and wait for the next buffer. 
But then a subsequent waitforallsend will wait forever...
The only decent options I see are either to clear the flag and proceed,
or abort the write and return an error.

2) Audio_out::sendcurrent, error handling for PrepareHeader
That's the area you commented on and where I have a FIXME. 
As discussed above, according to MS the point you raise should not pose
a problem, but there might be another one. To be on the safe side, we should
simply clear the flag so that UnprepareHeader won't be called subsequently.

A worse issue is that the buffer is not sent to the device, so the audio
will be garbled. I think the only clean way out is for the write to
return an error. But one could argue that a temporary glitch in the audio
is OK. 
The code currently does that, and returns the buffer to the queue.
So PrepareHeader will be called again on the same buffer (perhaps with the
flag cleared). Why would it succeed then?

3) Audio_in::queueblock , error handling for PrepareHeader.
Here as in 2, the block is not sent to the driver, and it is not put back
on the queue again. You write:

>For audio_in, buffers without data are queued to the device, after
>having been filled with recorded audio, the device ISR queues the "full"
>buffer in isr2app. In case of error we could queue to isr2app, but the
>dwBytesRecorded field would have to be set to zero because otherwise
>the driver would assume recorded audio in here. Currently, there is no
>error handling in this case.

That's a good option. Perhaps we should also clear the flag and add a test
in Audio_in::waitfordata to avoid calling UnprepareHeader (as we do for
write). 
But if the error occurs too often, the read will never return because
dwBytesRecorded is always 0. So alternatively we could have the read return
an error.

4) Audio_in::waitfordata, error handling for UnprepareHeader
There is currently no error handling. In principle the subsequent
call to PrepareHeader will fail. As above I am not sure how to best proceed.

Thinking again after having written all of that..
Given that these errors should never occur, I think the best solution is
for the read or write to return an error if errors ever occur (perhaps with
a "system_printf"), rather than try to continue, gliching the audio or risking
a hang.
There will then be a specific complaint to the list and we can address it
properly.  

>I hope the GETOSPACE ioctl still yields the correct result.
>
>I could not test your patch.
I tested that.

>It is good to hear that you are using the test suite for verification.
>Has my patch to the test suite been applied? I added a quite nasty test
>for dup.

I don't think it has been included. I will add your test, retest, and send
a joint testsuite patch, if it's OK with you.

Pierre

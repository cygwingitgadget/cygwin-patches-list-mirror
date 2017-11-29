Return-Path: <cygwin-patches-return-8940-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26037 invoked by alias); 29 Nov 2017 10:26:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25860 invoked by uid 89); 29 Nov 2017 10:25:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD autolearn=ham version=3.3.2 spammy=Waiting, H*u:6.1, H*UA:6.1
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Nov 2017 10:25:50 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id vATAPnff070123	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 02:25:49 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdP5mLHi; Wed Nov 29 02:25:41 2017
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <e7c6061c-be0e-5c36-b135-5796f9cd5da0@maxrnd.com>
Date: Wed, 29 Nov 2017 10:26:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20171128105334.GQ547@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00070.txt.bz2

Corinna Vinschen wrote:
> On Nov 28 02:28, Mark Geisert wrote:
>> Corinna Vinschen wrote:
>>> On Nov 28 00:03, Mark Geisert wrote:
>>>> Mark Geisert wrote:
>>>>> ---
>>>>>  winsup/cygwin/fhandler_disk_file.cc | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
>>>>> index 5dfcae4d9..2ead9948c 100644
>>>> [...]
>>>>
>>>> Oops, I neglected to include an explanatory comment. Issuing simultaneous
>>>> pwrite(s) on one file descriptor from multiple threads, as one might do in a
>>>> forthcoming POSIX aio implementation, sometimes results in garbage status in
>>>> the IO_STATUS_BLOCK on return from NtWriteFile(). Zeroing beforehand made
>>>> the issue go away.
>>>>
>>>> This is mildly concerning to me because there are many other uses of
>>>> IO_STATUS_BLOCK in the Cygwin DLL that haven't seemed to have needed
>>>> initialization.
>>>>
>>>> Puzzledly,
>>>
>>> Ok, let's start with, why did you tweak pread if you only observed
>>> a problem in pwrite?
>>
>> Optimism? :-)  No, you're correct; I was getting ahead of myself.
>>
>>>                       In terms of pread, we already have a very recent
>>> patch series:
>>>
>>> https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=46702f92ea49
>>> https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=c983aa48798d
>>> https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=181fe5d2edac
>>>
>>> In this case it turned out that the problem was related to hitting EOF.
>>> I wonder if we hit a similar problem here.
>>>
>>> Two points:
>>>
>>> - Did you check the status code returned by NtWriteFile?  Not all non-0
>>>   status codes fail the !NT_SUCCESS (status) test.
>>
>> I did check the status code but don't recall what it was.  The symptom I was
>> seeing was outlandish io.Information values being returned by pwrite().  Far
>> larger than the number requested in the call to pwrite() and NtWriteFile().
>
> That doesn't mean it has been returned by NtWriteFile.  Random values
> suggest NtWriteFile didn *set* a value in the first place, so what
> you see is the random value from the stack position io is in.  And
> that in turn suggests the status code should indicate why io wasn't
> written by NtWriteFile.  If you're playing with async IO, is it possible
> the status code indicates something like STATUS_TIMEOUT or STATUS_PENDING,
> both of which are treated as NT_SUCCESS?
>
>>> - Do you have a simple, self-contained testcase?
>>
>> That would be difficult.  I can supply an strace excerpt just showing the
>> region of these simultaneous pwrite() calls, without this patch.  If it's
>> too large I'll put it somewhere and post a link (but I don't think it will
>> be).
>
> Alternatively, what you should do is adding debug_printf statements
> before and after NtWriteFile, kind of like this...

I added the printf()s and, what do you know, it shows all the NtWriteFile()s
are returning STATUS_PENDING.  On return some of the IO_STATUS_BLOCKS have the
correct byte count but most of them have the same trash as before the call.

This is 8 threads each pwriting a 16MB chunk to different addresses in a new
128MB file.  4 threads pwriting 32MB chunks showed correct pwrite() results.

Does this mean pwrite() should be waiting for the status to change from
STATUS_PENDING to something else before returning?

..mark

18221 1193697 [aio6] heapxfer 3024 fhandler_disk_file::prw_open: 0x0 = NtOpenFile (0x1C4, 0x1B6, 
\??\C:\cygwin64\tmp\heapfile, io, 0x7, 0x0)
    53 1193750 [aio6] heapxfer 3024 fhandler_disk_file::pwrite: Before NtWF, io 0x3033207265667870
    60 1193810 [aio3] heapxfer 3024 fhandler_disk_file::pwrite: Before NtWF, io 0x5D336F69615B2038
    68 1193878 [aio2] heapxfer 3024 fhandler_disk_file::pwrite: Before NtWF, io 0x5D326F69615B2033
    70 1193948 [aio8] heapxfer 3024 fhandler_disk_file::pwrite: Before NtWF, io 0x3033207265667870
    40 1193988 [aio5] heapxfer 3024 fhandler_disk_file::pwrite: Before NtWF, io 0x3033207265667870
    33 1194021 [aio4] heapxfer 3024 fhandler_disk_file::pwrite: Before NtWF, io 0x3033207265667870
    29 1194050 [aio1] heapxfer 3024 fhandler_disk_file::pwrite: Before NtWF, io 0x5D316F69615B2036
  5652 1199702 [aio6] heapxfer 3024 fhandler_disk_file::pwrite: After NtWF, io 0x1000000, status 0x103
    74 1199776 [aio6] heapxfer 3024 pwrite: 16777216 = pwrite(3, 0x6FFF7FF0000, 16777216, 0)
    29 1199805 [aio6] heapxfer 3024 getpid: 3024 = getpid()
    24 1199829 [aio6] heapxfer 3024 sig_send: sendsig 0x80, pid 3024, signal 23, its_me 1
    32 1199861 [aio6] heapxfer 3024 sig_send: wakeup 0x1C8
    30 1199891 [aio6] heapxfer 3024 sig_send: Waiting for pack.wakeup 0x1C8
   239 1200130 [aio2] heapxfer 3024 fhandler_disk_file::pwrite: After NtWF, io 0x5D326F69615B2033, status 0x103
   307 1200437 [aio2] heapxfer 3024 pwrite: 1633361971 = pwrite(3, 0x6FFFAFF0000, 16777216, 50331648)
   179 1200616 [sig] heapxfer 3024 sigpacket::process: signal 23 processing
    27 1200643 [aio5] heapxfer 3024 fhandler_disk_file::pwrite: After NtWF, io 0x3033207265667870, status 0x103
    26 1200669 [aio5] heapxfer 3024 pwrite: 1701214320 = pwrite(3, 0x6FFFCFF0000, 16777216, 83886080)
    23 1200692 [aio5] heapxfer 3024 getpid: 3024 = getpid()
    24 1200716 [aio5] heapxfer 3024 sig_send: sendsig 0x80, pid 3024, signal 23, its_me 1
    28 1200744 [aio5] heapxfer 3024 sig_send: wakeup 0x1CC
    26 1200770 [aio5] heapxfer 3024 sig_send: Waiting for pack.wakeup 0x1CC
    22 1200792 [aio4] heapxfer 3024 fhandler_disk_file::pwrite: After NtWF, io 0x3033207265667870, status 0x103
    21 1200813 [aio4] heapxfer 3024 pwrite: 1701214320 = pwrite(3, 0x6FFFDFF0000, 16777216, 100663296)
    21 1200834 [aio4] heapxfer 3024 getpid: 3024 = getpid()
    19 1200853 [aio4] heapxfer 3024 sig_send: sendsig 0x80, pid 3024, signal 23, its_me 1
    19 1200872 [sig] heapxfer 3024 init_cygheap::find_tls: sig 23
    23 1200895 [sig] heapxfer 3024 sigpacket::process: using tls 0xFFFFCE00
    19 1200914 [aio4] heapxfer 3024 sig_send: wakeup 0x1D0
    22 1200936 [aio4] heapxfer 3024 sig_send: Waiting for pack.wakeup 0x1D0
    25 1200961 [aio2] heapxfer 3024 getpid: 3024 = getpid()
    20 1200981 [aio2] heapxfer 3024 sig_send: sendsig 0x80, pid 3024, signal 23, its_me 1
    24 1201005 [aio1] heapxfer 3024 fhandler_disk_file::pwrite: After NtWF, io 0x5D316F69615B2036, status 0x103
    21 1201026 [aio1] heapxfer 3024 pwrite: 1633361974 = pwrite(3, 0x6FFFEFF0000, 16777216, 117440512)
    22 1201048 [aio1] heapxfer 3024 getpid: 3024 = getpid()
    21 1201069 [aio1] heapxfer 3024 sig_send: sendsig 0x80, pid 3024, signal 23, its_me 1
    22 1201091 [aio3] heapxfer 3024 fhandler_disk_file::pwrite: After NtWF, io 0x5D336F69615B2038, status 0x103
    22 1201113 [aio3] heapxfer 3024 pwrite: 1633361976 = pwrite(3, 0x6FFF9FF0000, 16777216, 33554432)
    47 1201160 [aio8] heapxfer 3024 fhandler_disk_file::pwrite: After NtWF, io 0x3033207265667870, status 0x103

Return-Path: <cygwin-patches-return-9473-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75949 invoked by alias); 27 Jun 2019 05:48:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75930 invoked by uid 89); 27 Jun 2019 05:48:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 27 Jun 2019 05:48:02 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x5R5m1Ds064113	for <cygwin-patches@cygwin.com>; Wed, 26 Jun 2019 22:48:01 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdwp92cU; Wed Jun 26 22:47:58 2019
Subject: Re: [PATCH] Cygwin: Build cygwin-console-helper with correct compiler
To: cygwin-patches@cygwin.com
References: <20190625075441.1209-1-mark@maxrnd.com> <20190625112703.GH5738@calimero.vinschen.de> <e820c2e7-074c-f285-ec37-22ef18f12ff4@maxrnd.com> <20190626092744.GT5738@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <af4045a2-0722-bfe8-8683-3cfbcea00b77@maxrnd.com>
Date: Thu, 27 Jun 2019 05:48:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20190626092744.GT5738@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00180.txt.bz2

Corinna Vinschen wrote:
> On Jun 26 01:48, Mark Geisert wrote:
>> Corinna Vinschen wrote:
>>> On Jun 25 00:54, Mark Geisert wrote:
>>>> ---
>>>>    winsup/utils/Makefile.in | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
>>>> index b64f457e7..cebf39572 100644
>>>> --- a/winsup/utils/Makefile.in
>>>> +++ b/winsup/utils/Makefile.in
>>>> @@ -64,7 +64,7 @@ MINGW_BINS := ${addsuffix .exe,cygcheck cygwin-console-helper ldh strace}
>>>>    # List all objects to be compiled in MinGW mode.  Any object not on this
>>>>    # list will will be compiled in Cygwin mode implicitly, so there is no
>>>>    # need for a CYGWIN_OBJS.
>>>> -MINGW_OBJS := bloda.o cygcheck.o dump_setup.o ldh.o path.o strace.o
>>>> +MINGW_OBJS := bloda.o cygcheck.o cygwin-console-helper.o dump_setup.o ldh.o path.o strace.o
>>>>    MINGW_LDFLAGS:=-static
>>>>    CYGCHECK_OBJS:=cygcheck.o bloda.o path.o dump_setup.o
>>>> -- 
>>>> 2.21.0
>>>
>>> Careful!  This leads to a warning when building on 64 bit:
>>>
>>>     cygwin-console-helper.cc: In function 'int main(int, char**)':
>>>     cygwin-console-helper.cc:8:48: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>>      HANDLE h = (HANDLE) strtoul (argv[1], &end, 0);
>>>                                                   ^
>>>     cygwin-console-helper.cc:10:41: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>>      h = (HANDLE) strtoul (argv[2], &end, 0);
>>>                                            ^
>>>
>>> Note that strtoul returns an unsigned long.  Mingw compiles
>>> for native Windows, which is LLP64 rather than LP64:
>>>
>>>     mingw:sizeof(long) == 4
>>>     cygwin:sizeof(long) == 8
>>>
>>> This needs fixing as well (use strtoull).
>>
>> I appreciate the comments.  These warnings have "always" been present.

I have to amend my statement.  Warnings during whole-tree builds in general have 
"always" been present but I cannot be 100% sure this particular warning was 
present.  I looked through my most recent make log and there are only compiler 
warnings in newlib, not in winsup.  Sorry for my confusion.

> I don't see any warning in terms of building cygwin-console-helper in
> the current state.  However, it suddenly occured to me that, even without
> a warning, this was always wrong.  The compiler generates code for 8 byte
> long and the linker links against libs expecting 4 byte longs.
> 
> The fact that this works is ... not exactly magic, but first, the
> arguments and return values are in registers anyway, and second, HANDLEs
> are only using the lower 4 bytes even though they are 8 bytes in size.
> 
>> I didn't make clear the reason for this one-line patch to Makefile.in: A
>> 'make -j 6' over the Cygwin source tree would sometimes fail because the
>> link step for cygwin-console-helper uses a different gcc than the compile
>> step did in parallel builds.
> 
> Huh, really?  I'm building with make -j42 on a 32 core machine, but I
> never saw this problem.

Well that's a very good counterexample.  I attributed it to parallel make steps 
but it was rare even with that condition.  When the build failed it was because 
linking with cygwin-console-helper.o was provoking an error something like "file 
format not recognized".  Which now appears to me to possibly be a 32/64 issue of 
mismatched tools.

Let's drop this report for now and I'll be sure to report more accurately if it 
happens again.

>>    Can you accept this patch as-is for what it
>> does for builds?
> 
> Yes, we can do that, but it might be a good idea to order the patches
> so that the *first* patch fixes the actual problem in cygwin-console-helper
> and the *second* patch fixes the Makefile.  Consider this patch approved,
> I just wait for the other one, ok?

I've now submitted a patch for the actual problem separately.  Thanks for 
patiently helping me help where I can.

..mark

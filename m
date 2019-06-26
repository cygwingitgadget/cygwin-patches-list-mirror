Return-Path: <cygwin-patches-return-9467-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55555 invoked by alias); 26 Jun 2019 08:49:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55539 invoked by uid 89); 26 Jun 2019 08:49:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=Geisert, geisert, pay, H*u:6.1
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Jun 2019 08:49:05 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x5Q8n3DN011185	for <cygwin-patches@cygwin.com>; Wed, 26 Jun 2019 01:49:03 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpd0QFG1T; Wed Jun 26 01:48:53 2019
Subject: Re: [PATCH] Cygwin: Build cygwin-console-helper with correct compiler
To: cygwin-patches@cygwin.com
References: <20190625075441.1209-1-mark@maxrnd.com> <20190625112703.GH5738@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <e820c2e7-074c-f285-ec37-22ef18f12ff4@maxrnd.com>
Date: Wed, 26 Jun 2019 08:49:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20190625112703.GH5738@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00174.txt.bz2

Corinna Vinschen wrote:
> On Jun 25 00:54, Mark Geisert wrote:
>> ---
>>   winsup/utils/Makefile.in | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
>> index b64f457e7..cebf39572 100644
>> --- a/winsup/utils/Makefile.in
>> +++ b/winsup/utils/Makefile.in
>> @@ -64,7 +64,7 @@ MINGW_BINS := ${addsuffix .exe,cygcheck cygwin-console-helper ldh strace}
>>   # List all objects to be compiled in MinGW mode.  Any object not on this
>>   # list will will be compiled in Cygwin mode implicitly, so there is no
>>   # need for a CYGWIN_OBJS.
>> -MINGW_OBJS := bloda.o cygcheck.o dump_setup.o ldh.o path.o strace.o
>> +MINGW_OBJS := bloda.o cygcheck.o cygwin-console-helper.o dump_setup.o ldh.o path.o strace.o
>>   MINGW_LDFLAGS:=-static
>>   
>>   CYGCHECK_OBJS:=cygcheck.o bloda.o path.o dump_setup.o
>> -- 
>> 2.21.0
> 
> Careful!  This leads to a warning when building on 64 bit:
> 
>    cygwin-console-helper.cc: In function 'int main(int, char**)':
>    cygwin-console-helper.cc:8:48: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     HANDLE h = (HANDLE) strtoul (argv[1], &end, 0);
>                                                  ^
>    cygwin-console-helper.cc:10:41: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>     h = (HANDLE) strtoul (argv[2], &end, 0);
>                                           ^
> 
> Note that strtoul returns an unsigned long.  Mingw compiles
> for native Windows, which is LLP64 rather than LP64:
> 
>    mingw:sizeof(long) == 4
>    cygwin:sizeof(long) == 8
> 
> This needs fixing as well (use strtoull).

I appreciate the comments.  These warnings have "always" been present.  I will 
submit a separate patch to correct them.

I didn't make clear the reason for this one-line patch to Makefile.in: A 'make 
-j 6' over the Cygwin source tree would sometimes fail because the link step for 
cygwin-console-helper uses a different gcc than the compile step did in parallel 
builds.  Can you accept this patch as-is for what it does for builds?

I will over time pay more attention to the make log and submit more patches for 
the warnings I see flying by.  There's maybe a handful of them, mostly in newlib.

Cheers,

..mark

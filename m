Return-Path: <cygwin-patches-return-8937-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79847 invoked by alias); 28 Nov 2017 10:28:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79828 invoked by uid 89); 28 Nov 2017 10:28:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD autolearn=ham version=3.3.2 spammy=H*u:6.1, H*UA:6.1, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Nov 2017 10:28:41 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id vASASdRX096221	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 02:28:39 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdNJc5SH; Tue Nov 28 02:28:37 2017
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <42633315-b082-232c-e310-31e05306d06f@maxrnd.com>
Date: Tue, 28 Nov 2017 10:28:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20171128093240.GO547@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00067.txt.bz2

Corinna Vinschen wrote:
> On Nov 28 00:03, Mark Geisert wrote:
>> Mark Geisert wrote:
>>> ---
>>>  winsup/cygwin/fhandler_disk_file.cc | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
>>> index 5dfcae4d9..2ead9948c 100644
>> [...]
>>
>> Oops, I neglected to include an explanatory comment. Issuing simultaneous
>> pwrite(s) on one file descriptor from multiple threads, as one might do in a
>> forthcoming POSIX aio implementation, sometimes results in garbage status in
>> the IO_STATUS_BLOCK on return from NtWriteFile(). Zeroing beforehand made
>> the issue go away.
>>
>> This is mildly concerning to me because there are many other uses of
>> IO_STATUS_BLOCK in the Cygwin DLL that haven't seemed to have needed
>> initialization.
>>
>> Puzzledly,
>
> Ok, let's start with, why did you tweak pread if you only observed
> a problem in pwrite?

Optimism? :-)  No, you're correct; I was getting ahead of myself.

>                       In terms of pread, we already have a very recent
> patch series:
>
> https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=46702f92ea49
> https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=c983aa48798d
> https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=181fe5d2edac
>
> In this case it turned out that the problem was related to hitting EOF.
> I wonder if we hit a similar problem here.
>
> Two points:
>
> - Did you check the status code returned by NtWriteFile?  Not all non-0
>   status codes fail the !NT_SUCCESS (status) test.

I did check the status code but don't recall what it was.  The symptom I was 
seeing was outlandish io.Information values being returned by pwrite().  Far 
larger than the number requested in the call to pwrite() and NtWriteFile().

>
> - Do you have a simple, self-contained testcase?

That would be difficult.  I can supply an strace excerpt just showing the region 
of these simultaneous pwrite() calls, without this patch.  If it's too large 
I'll put it somewhere and post a link (but I don't think it will be).

..mark

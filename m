Return-Path: <cygwin-patches-return-8881-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1846 invoked by alias); 10 Oct 2017 14:28:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 425 invoked by uid 89); 10 Oct 2017 14:28:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=coffee, Hx-languages-length:1764, reserved, HTo:U*cygwin-patches
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Oct 2017 14:28:36 +0000
X-IPAS-Result: =?us-ascii?q?A2G/AgCs2NxZ/+shHKxbGwEBAQMBAQEJAQEBhD+BFYN6nAm?= =?us-ascii?q?YQQobgROEDQKFEBQBAgEBAQEBAQEDgRCEB1s8AQUjZgsYAgImAgJXEwgBAbJRg?= =?us-ascii?q?ieLIwEBAQcCJoEOgh+FaIJ+hVCCR4JhBYoMiSCOEIIuhTCPe4hxhy6RegGDZoE?= =?us-ascii?q?5NoEweIV4HIFpdIpAAQEB?=
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2017 16:28:10 +0200
Received: from [172.28.41.101]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1e1vVx-0006d1-Dd; Tue, 10 Oct 2017 16:28:09 +0200
Subject: Re: [PATCH] cygwin: fix potential buffer overflow in fork
To: cygwin-patches@cygwin.com
References: <1b4e1413-fa59-a954-f839-507abce7df11@ssi-schaefer.com> <20171010114832.GB30630@calimero.vinschen.de> <e6eb270a-1819-007c-d98e-c4f79177b3f7@ssi-schaefer.com> <20171010124436.GD30630@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <393b2fb1-e100-acfb-a0e6-2834c7a15298@ssi-schaefer.com>
Date: Tue, 10 Oct 2017 14:28:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171010124436.GD30630@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q4/txt/msg00011.txt.bz2

On 10/10/2017 02:44 PM, Corinna Vinschen wrote:
> On Oct 10 14:26, Michael Haubenwallner wrote:
>> On 10/10/2017 01:48 PM, Corinna Vinschen wrote:
>>> Hi Michael,
>>>
>>> On Oct  9 18:58, Michael Haubenwallner wrote:
>>>> When fork fails, we can use "%s" now with system_sprintf for the errmsg
>>>> rather than a (potentially too small) buffer for the format string.
>>>
>>> How could buf be too small?
>>
>> See below.
>>
>> Actually I've found this by searching for suspect char array definitions
>> while hunting the "uninitialized variable for RtlLookupFunctionEntry" bug.
>>
>>>> * fork.cc (fork): Use "%s" with system_printf now.
>>>> ---
>>>>  winsup/cygwin/fork.cc | 9 ++-------
>>>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
>>>> index 73a72f530..bcbef12d8 100644
>>>> --- a/winsup/cygwin/fork.cc
>>>> +++ b/winsup/cygwin/fork.cc
>>>> @@ -618,13 +618,8 @@ fork ()
>>>>        if (!grouped.errmsg)
>>>>  	syscall_printf ("fork failed - child pid %d, errno %d", grouped.child_pid, grouped.this_errno);
>>>>        else
>>>> -	{
>>>> -	  char buf[strlen (grouped.errmsg) + sizeof ("child %d - , errno 4294967295  ")];
>>
>> Usually child_pid is longer than the 2 characters counted by "%d", but
>> errno usually is shorther than the 10 characters counted by "4294967295",
>> and there is another 2 reserved characters counted by trailing "  ".
>>
>> In practice the buffer unlikely will be too small, so this is merely cosmetics.
> 
> But buf is just the format string.  It won't get manipulated by
> system_printf.  Which means the 4294967295 is nonsense, too, a %d
> would have been sufficient.

Indeed! (out of coffee exception)

Thanks!
/haubi/

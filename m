Return-Path: <cygwin-patches-return-8878-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63961 invoked by alias); 10 Oct 2017 12:27:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63947 invoked by uid 89); 10 Oct 2017 12:27:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=H*MI:sk:2017101, merely, hunting, H*M:1819
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Oct 2017 12:27:01 +0000
X-IPAS-Result: =?us-ascii?q?A2EIAwBPu9xZ/+shHKxcGwEBAQMBAQEJAQEBhD+BFYN6m2c?= =?us-ascii?q?imEEKG4EThA0ChQwVAQIBAQEBAQEBA4EQhAdbPAEFI2YLGAICJgICVxMIAQGyN?= =?us-ascii?q?YIniyMBAQEHAiaBDoIfhWgLgnOFUIJHgmEFigyJIIUyiF6CLoUwj3uIcYcukXo?= =?us-ascii?q?Bg2aBOTWBMXiFeByBaXSKQAEBAQ?=
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2017 14:26:59 +0200
Received: from [172.28.41.101]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1e1tcg-0004oY-98	for cygwin-patches@cygwin.com; Tue, 10 Oct 2017 14:26:58 +0200
Subject: Re: [PATCH] cygwin: fix potential buffer overflow in fork
To: cygwin-patches@cygwin.com
References: <1b4e1413-fa59-a954-f839-507abce7df11@ssi-schaefer.com> <20171010114832.GB30630@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <e6eb270a-1819-007c-d98e-c4f79177b3f7@ssi-schaefer.com>
Date: Tue, 10 Oct 2017 12:27:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171010114832.GB30630@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q4/txt/msg00008.txt.bz2

On 10/10/2017 01:48 PM, Corinna Vinschen wrote:
> Hi Michael,
> 
> On Oct  9 18:58, Michael Haubenwallner wrote:
>> When fork fails, we can use "%s" now with system_sprintf for the errmsg
>> rather than a (potentially too small) buffer for the format string.
> 
> How could buf be too small?

See below.

Actually I've found this by searching for suspect char array definitions
while hunting the "uninitialized variable for RtlLookupFunctionEntry" bug.

>> * fork.cc (fork): Use "%s" with system_printf now.
>> ---
>>  winsup/cygwin/fork.cc | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
>> index 73a72f530..bcbef12d8 100644
>> --- a/winsup/cygwin/fork.cc
>> +++ b/winsup/cygwin/fork.cc
>> @@ -618,13 +618,8 @@ fork ()
>>        if (!grouped.errmsg)
>>  	syscall_printf ("fork failed - child pid %d, errno %d", grouped.child_pid, grouped.this_errno);
>>        else
>> -	{
>> -	  char buf[strlen (grouped.errmsg) + sizeof ("child %d - , errno 4294967295  ")];

Usually child_pid is longer than the 2 characters counted by "%d", but
errno usually is shorther than the 10 characters counted by "4294967295",
and there is another 2 reserved characters counted by trailing "  ".

In practice the buffer unlikely will be too small, so this is merely cosmetics.

>> -	  strcpy (buf, "child %d - ");
>> -	  strcat (buf, grouped.errmsg);
>> -	  strcat (buf, ", errno %d");
>> -	  system_printf (buf, grouped.child_pid, grouped.this_errno);
>> -	}
>> +	system_printf ("child %d - %s, errno %d", grouped.child_pid,
>> +		       grouped.errmsg, grouped.this_errno);
>>  
>>        set_errno (grouped.this_errno);
>>      }
>> -- 
>> 2.14.2
> 
> I guess this also means we can drop the if/else, kind of like
> 
>   system_printf ("child %d %s%s, errno %d",
> 		 grouped.child_pid,
> 		 grouped.errmsg ? "- " : "",
> 		 grouped.errmsg ?: "",
> 		 grouped.this_errno);
> 
> What do you think?

Nothing I really take care of - yet suggesting:

  system_printf ("fork failed - child %d%s%s, errno %d",
		 grouped.child_pid,
		 grouped.errmsg ? " - " : "",
		 grouped.errmsg ?: "",
		 grouped.this_errno);

But wait, what's the difference between syscall_printf and system_printf?

/haubi/

Return-Path: <cygwin-patches-return-7970-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8371 invoked by alias); 13 Feb 2014 17:40:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8354 invoked by uid 89); 13 Feb 2014 17:40:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_50 autolearn=ham version=3.3.2
X-HELO: smtpout16.bt.lon5.cpcloud.co.uk
Received: from smtpout16.bt.lon5.cpcloud.co.uk (HELO smtpout16.bt.lon5.cpcloud.co.uk) (65.20.0.136) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 13 Feb 2014 17:40:02 +0000
X-CTCH-RefID: str=0001.0A090201.52FD036F.01D4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=7/97,refid=2.7.2:2014.2.13.132415:17:7.944,ip=,rules=__MOZILLA_MSGID, __HAS_MSGID, __SANE_MSGID, __HAS_FROM, __USER_AGENT, __MOZILLA_USER_AGENT, __MIME_VERSION, __TO_MALFORMED_2, __TO_NO_NAME, __BOUNCE_CHALLENGE_SUBJ, __BOUNCE_NDR_SUBJ_EXEMPT, __SUBJ_ALPHA_END, __IN_REP_TO, __CT, __CT_TEXT_PLAIN, __CTE, __SUBJ_ALPHA_NEGATE, __FORWARDED_MSG, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, BODY_SIZE_7000_LESS, NO_URI_FOUND
X-CTCH-Spam: Unknown
Received: from [192.168.1.72] (86.174.32.243) by smtpout16.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as jonturney@btinternet.com)        id 52F37306003C7039 for cygwin-patches@cygwin.com; Thu, 13 Feb 2014 17:39:59 +0000
Message-ID: <52FD0372.20306@dronecode.org.uk>
Date: Thu, 13 Feb 2014 17:40:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add minidump write utility
References: <52F50B71.8030608@dronecode.org.uk> <52F64682.4090208@dronecode.org.uk> <20140208204919.GA5199@ednor.casa.cgf.cx>
In-Reply-To: <20140208204919.GA5199@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SW-Source: 2014-q1/txt/msg00043.txt.bz2

On 08/02/2014 20:49, Christopher Faylor wrote:
> On Sat, Feb 08, 2014 at 03:00:18PM +0000, Jon TURNEY wrote:
>> On 07/02/2014 16:36, Jon TURNEY wrote:
>> Unfortunately there seems to be a bit of a problem with this patch. It seems
>> that cygwin assumes that the JIT debugger will terminate the debugged process.
>> I'm not sure if that's always been the case.
[snip]
>> dumper.exe does terminate the debugeee, but despite what utils.xml says about
>> this, I don't think this hasn't been a Windows API limitation since
>> DebugSetProcessKillOnExit() has existed.
>>
>> I could fix this by making minidumper also terminate the dumped process, but
>> that doesn't seem the right approach.

On reflection, given the below, adding an option so that, when running
minidumper standalone, terminating the dumped process can be disabled, but
defaulting to behaving in the same way as dumper seems like an adequate
solution for the moment.

>> I don't understand what debugging scenarios the waitloop part of
>> exceptions.cc:try_to_debug() is useful in, or why it doesn't wait until the
>> debugger process exits, so it's not clear to me how to fix this there, but
>> I'll note in passing that it seems that the thread's original priority is not
>> restored after running the debugger if waitloop=false, so perhaps at least the
>> following is needed:
>>
>> --- cygwin/exceptions.cc        8 Jan 2014 16:51:20 -0000       1.432
>> +++ cygwin/exceptions.cc        8 Feb 2014 14:49:59 -0000
>> @@ -504,10 +504,8 @@
>>
>>   if (!dbg)
>>     system_printf ("Failed to start debugger, %E");
>> -  else
>> +  else if (waitloop)
>>     {
>> -      if (!waitloop)
>> -       return dbg;
>>       SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
>>       while (!being_debugged ())
>>        Sleep (1);
> 
> Go ahead and check in the above but I don't see how it would be possible
> in a non-racy way for a dumper process to dump it's parents core unless
> the parent was guaranteed to still be alive.

This is a good point.   I think I was expecting to achieve that by the parent
waiting until the error_start process exits, but of course, that isn't what is
wanted if it's a debugger.

Looking into this a bit more, according to this ChangeLog entry, this is
deliberate, so I think I'll leave this alone until I understand it better...

2003-02-13  Christopher Faylor

	* exceptions.cc (try_to_debug): Don't reset priority when returning
	from non-waitloop call.

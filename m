Return-Path: <cygwin-patches-return-9094-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46485 invoked by alias); 20 Jun 2018 15:47:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46474 invoked by uid 89); 20 Jun 2018 15:47:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, suspended, UD:exe, Hx-languages-length:1662
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 20 Jun 2018 15:47:20 +0000
X-IPAS-Result: =?us-ascii?q?A2G+AwDPdSpb/+shHKxUBxwBAQEEAQEKAQGJS5YcCCGWeQu?= =?us-ascii?q?EbAKDGTgUAQIBAQEBAQECAgKBEYUrAQUjZgsYAgImAgJXEwgBAYMhrgOCHIRbg?= =?us-ascii?q?2ttgQuJXIEPJAyCXIRnYII0glUCmSQHAoFrjR+IDIU7kV+BWIF0cIM4giAXjhm?= =?us-ascii?q?ODimCHwEB?=
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 17:47:17 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1fVfKH-0003HP-6k; Wed, 20 Jun 2018 17:47:17 +0200
Subject: Re: [PATCH RFC] fork: remove cygpid.N sharedmem on fork failure
To: cygwin-patches@cygwin.com
References: <f45c9bb0-eb52-803f-ee42-1fc52725f3b1@ssi-schaefer.com> <20180607081955.GB30775@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <913f9a8e-16ef-0384-6a42-d2884efa4b32@ssi-schaefer.com>
Date: Wed, 20 Jun 2018 15:47:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607081955.GB30775@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2018-q2/txt/msg00051.txt.bz2

On 06/07/2018 10:19 AM, Corinna Vinschen wrote:
> On Jun  5 15:05, Michael Haubenwallner wrote:
>> Hi,
>>
>> I'm using attached patch for a while now, and orphan cygpid.N shared memory
>> instances are gone for otherwise completely unknown windows process ids.
>>
>> However, I do see defunct processes now which's PPID does not exist (any more),
>> causing the same trouble because their windows process handle is closed but
>> their cygpid.N shmem handle is not.
>>

>>
>> But I have no idea whether attached patch is causing or uncovering this issue...
>>
>> Any idea?
> 
> Not really.  Processes are kept around after exec to keep the PID
> blocked.  Perhaps your patch is breaking an assumption there.
> I wonder why you have a problem with failing forks in the first
> place...?

I'm successfully using the topic/forkables patches still, where
fork is retried using /var/run/cygfork/ when an exe or dll was
replaced (by some in-cygwin package manager).

Without this patch, for the first-try child process which the
cygwin1.dll fails to initialize for because of wrong dll loaded,
the process handle is released but the cygpid.N shmem handle is not.

Then, another completely independent process may get the same
windows process id again, and cygwin1.dll fails to initialize
because of the existing but orphaned cygpid.N shmem handle.

For those "Suspended" windows processes (sh.exe):
They seem to occur eventually when a shell script was executing some
native windows process (msvc toolchain). Interesting here is that
I got *4* Suspended sh.exe on the *4* core VirtualBox machine...

/haubi/

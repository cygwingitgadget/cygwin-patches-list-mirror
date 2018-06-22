Return-Path: <cygwin-patches-return-9099-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 94069 invoked by alias); 22 Jun 2018 09:04:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 94057 invoked by uid 89); 22 Jun 2018 09:04:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=understood, temporarily, H*RU:sk:michael, H*r:sk:michael
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Jun 2018 09:04:55 +0000
X-IPAS-Result: =?us-ascii?q?A2HFAgDduixb/+shHKxcGwEBAgMBAQoBAYlMlh8IIpZ5C4R?= =?us-ascii?q?sAoMfOBQBAgEBAQEBAQICAoERhSoBAQEBAgEjWwsLGAICJgICVxMIAQGDIYF4q?= =?us-ascii?q?3KCHIRbg2mBBYELiVyBNgyCXIVHgjSCVQKZJgcCgWuNH4gMhTuRYIFYgXRwgzi?= =?us-ascii?q?CIBeOGY5RKoIeAQE?=
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 11:04:53 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1fWHzv-00089U-Us; Fri, 22 Jun 2018 11:04:51 +0200
Subject: Re: [PATCH RFC] fork: remove cygpid.N sharedmem on fork failure
To: cygwin-patches@cygwin.com
References: <f45c9bb0-eb52-803f-ee42-1fc52725f3b1@ssi-schaefer.com> <20180607081955.GB30775@calimero.vinschen.de> <913f9a8e-16ef-0384-6a42-d2884efa4b32@ssi-schaefer.com> <20180621072756.GF11110@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <197571b7-9448-4a6c-0dc7-4b2407b7f19e@ssi-schaefer.com>
Date: Fri, 22 Jun 2018 09:04:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621072756.GF11110@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2018-q2/txt/msg00056.txt.bz2

On 06/21/2018 09:27 AM, Corinna Vinschen wrote:
> On Jun 20 17:47, Michael Haubenwallner wrote:
>> On 06/07/2018 10:19 AM, Corinna Vinschen wrote:
>>> On Jun  5 15:05, Michael Haubenwallner wrote:
>>>> Hi,
>>>>
>>>> I'm using attached patch for a while now, and orphan cygpid.N shared memory
>>>> instances are gone for otherwise completely unknown windows process ids.

>>
>> Without this patch, for the first-try child process which the
>> cygwin1.dll fails to initialize for because of wrong dll loaded,
>> the process handle is released but the cygpid.N shmem handle is not.
>>
>> Then, another completely independent process may get the same
>> windows process id again, and cygwin1.dll fails to initialize
>> because of the existing but orphaned cygpid.N shmem handle.
> 
> This problem appear to be a non-problem in the normal code path.

Well, the underlying OS may temporarily be low on resources,
and the parent process may retry to fork by itself...

Currently, when the child process can be created but not initialized
by cygwin1.dll for whatever reason, the process handle is closed, but
(as far as I have understood) the shmem handle actually is lost, and
the orphaned shmem entry exists until the parent process terminates.

> In case of restarting the 2nd-try child, wouldn't it make sense to reuse
> the shmem area instead of breaking it down?

The 2nd-try child usually does get another windows pid, and we would have
to *rename* the shmem: *before* closing the 1st-try windows process handle.

And when neither child can be initialized for low resource reasons?

/haubi/

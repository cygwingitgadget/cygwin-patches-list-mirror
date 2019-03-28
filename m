Return-Path: <cygwin-patches-return-9255-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 93544 invoked by alias); 28 Mar 2019 11:48:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93319 invoked by uid 89); 28 Mar 2019 11:48:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 11:48:23 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 12:48:08 +0100
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1h9TVv-0005Bl-Kj	for cygwin-patches@cygwin.com; Thu, 28 Mar 2019 12:48:07 +0100
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com>
Date: Thu, 28 Mar 2019 11:48:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328095818.GP4096@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q1/txt/msg00065.txt.bz2

On 3/28/19 10:58 AM, Corinna Vinschen wrote:
> On Mar 28 10:17, Michael Haubenwallner wrote:
>> As it is not some other dll being loaded at the colliding adress: any
>> idea how to find out _what_ is allocated there (in the forked child),
>> to find out whether we can reserve these areas even more early?
> 
> I'm not sure what addresses you're talking about ATM.  The addresses in
> the 0x4:00000000 - 0x6:00000000 range?

No, I'm thinking about the lower address that collides after relocation,
if there is some cygwin allocated object we may allocate later...

> These are the interesting ones.
> The relocation to some random low address should only occur if there's
> a collision in this range.

This should be easier to find out (by inspecting the loaded dlls).

> 
> I'm not quite sure how to find out what happens, unless you stop the
> process in reserve_space and inspect the memory layout with sysinternal's
> vmmap tool:
> 
> https://docs.microsoft.com/en-us/sysinternals/downloads/vmmap

Maybe I will try that one - thanks for the pointer!

Are you about to apply the patch?

Thanks!
/haubi/

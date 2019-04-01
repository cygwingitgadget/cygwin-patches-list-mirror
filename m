Return-Path: <cygwin-patches-return-9293-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39886 invoked by alias); 1 Apr 2019 14:28:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39076 invoked by uid 89); 1 Apr 2019 14:28:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Envelope-From:sk:michael, situations, inspecting, chances
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 01 Apr 2019 14:28:48 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 16:28:39 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hAxvS-0002Vp-Dl; Mon, 01 Apr 2019 16:28:38 +0200
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com>
Date: Mon, 01 Apr 2019 14:28:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328203056.GB4096@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------10D3D8D7EAB8D26CE39A622A"
X-SW-Source: 2019-q2/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------10D3D8D7EAB8D26CE39A622A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 1705

Hi Corinna,

On 3/28/19 9:30 PM, Corinna Vinschen wrote:
> On Mar 28 12:48, Michael Haubenwallner wrote:
>> On 3/28/19 10:58 AM, Corinna Vinschen wrote:
>>> On Mar 28 10:17, Michael Haubenwallner wrote:
>>>> As it is not some other dll being loaded at the colliding adress: any
>>>> idea how to find out _what_ is allocated there (in the forked child),
>>>> to find out whether we can reserve these areas even more early?
>>>
>>> I'm not sure what addresses you're talking about ATM.  The addresses in
>>> the 0x4:00000000 - 0x6:00000000 range?
>>
>> No, I'm thinking about the lower address that collides after relocation,
>> if there is some cygwin allocated object we may allocate later...
>>
>>> These are the interesting ones.
>>> The relocation to some random low address should only occur if there's
>>> a collision in this range.
>>
>> This should be easier to find out (by inspecting the loaded dlls).
> 
> can you please collect the base addresses of all DLLs generated during
> the build, plus their size and make a sorted list?  It would be
> interesting to know if the hash algorithm in ld is actually as bad
> as I conjecture.

Please find attached the output of rebase -i for the dlls after bootstrap
on Cygwin 3.0.4, each built with ld from binutils-2.31.1.

> 
> If we can improve on the distribution within the 8 Gigs area by changing
> ld's address generation(*), we may improve situations like these without
> too much hassle.  As always, not a foolproof way out, but heck, 8 Gigs
> is a lot of space for a couple 100 DLLs.

Feels like I need some Cygwin rebase step in Gentoo Prefix anyway, as there
are ~250 dlls right after bootstrap - without any application yet.

Thanks!
/haubi/

--------------10D3D8D7EAB8D26CE39A622A
Content-Type: application/x-xz;
 name="rebase-info.txt.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="rebase-info.txt.xz"
Content-length: 5267

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
YgqxxGf7AgAAAAAEWVo=

--------------10D3D8D7EAB8D26CE39A622A--

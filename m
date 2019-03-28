Return-Path: <cygwin-patches-return-9258-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 34594 invoked by alias); 28 Mar 2019 15:03:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 34581 invoked by uid 89); 28 Mar 2019 15:03:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=databases
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 15:02:56 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 16:02:53 +0100
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1h9WYP-0001Rt-CQ	for cygwin-patches@cygwin.com; Thu, 28 Mar 2019 16:02:53 +0100
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <20190328091507.GM4096@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Message-ID: <89dc8dca-c97b-ef79-6b90-bebb1b73c388@ssi-schaefer.com>
Date: Thu, 28 Mar 2019 15:03:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328091507.GM4096@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q1/txt/msg00068.txt.bz2

On 3/28/19 10:15 AM, Corinna Vinschen wrote:
> On Mar 28 09:34, Michael Haubenwallner wrote:
>> Hi Corinna,
>>
>> On 3/27/19 10:16 AM, Corinna Vinschen wrote:
>>> On Mar 27 09:26, Michael Haubenwallner wrote:
>>>> On 3/26/19 7:28 PM, Corinna Vinschen wrote:
>>> Wait, let me understand what's going on.  IIUC you're building DLLs
>>> which are then used during the build job itself, right?
>>
>> Exactly.
>> FWIW, the CI builds also set up a Cygwin instance from scratch,
>> as I'm also after testing Cygwin (v3) itself to some degree:
>> https://dev.azure.com/gentoo-prefix/ci-builds/_build
>>
>> However, I've not found a commandline option for setup.exe to install
>> "test" versions...
>>
>>> As you know, 64 bit has a defined memory layout.  Binutils ld is
>>> supposed to base the DLLs to a pseudo-random address in the area between
>>> 0x4:00000000 and 0x6:00000000.  This area is occupied by un-rebased DLLs
>>> only.  8 Gigs is a *lot* of space for DLLs.
>>>
>>> That also means that the DLLs should not at all collide with windows
>>> objects (typically reserved in the lesser 2 Gigs area), unless they
>>> collide with themselves.  At least that's the idea.
>>>
>>> Can you check what addresses the freshly built DLLs are based on by LD?
>>> Is there a chance that the algorithm used in LD is too dumb?
>>
>> I've also added system_printf to dll_list::reserve_space() when a dynloaded
>> dll was relocated, and each new address was below 0x0:01000000. The attached
>> output also contains the preferred address, above 0x4:00000000 each.
> 
> Do they actually collide with each other?  Did you check the addresses?

Yes, there is a real collision between installed dlls:
$ rebase -i /home/haubi/test-20190327/gentoo-prefix/usr/bin/cygcrypto-1.1.dll /home/haubi/test-20190327/gentoo-prefix/usr/lib/python2.7/lib-dynload/_locale.dll
/home/haubi/test-20190327/gentoo-prefix/usr/bin/cygcrypto-1.1.dll                 base 0x00041c650000 size 0x0027d000 *
/home/haubi/test-20190327/gentoo-prefix/usr/lib/python2.7/lib-dynload/_locale.dll base 0x00041c6a0000 size 0x0002c000 *

> 
> There must be collisions in your case.  Can you please check if
> Achim's solution works for you?

The flexibility of rebase regarding multiple rebase databases seems not there yet,
but in theory this can help to avoid conflicts between dlls finally *installed*.

It will not help for conflicts between dlls within a single package while this
package is built.  I'm thinking of python modules built within the python package
itself, where the just built modules are used within the very build process.  Not
sure if packages using local modules during build also do use fork then, though.

> 
> In the meantime I pushed your patch to the master branch (but not
> yet to the 3.0 branch).

Is the cygwin1.dll from master branch available via setup.exe cmdline somehow?

Thanks!
/haubi/

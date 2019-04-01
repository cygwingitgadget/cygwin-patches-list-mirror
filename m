Return-Path: <cygwin-patches-return-9296-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68580 invoked by alias); 1 Apr 2019 16:31:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68438 invoked by uid 89); 1 Apr 2019 16:31:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=databases
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 01 Apr 2019 16:31:37 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 18:31:35 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hAzqQ-000402-Rt; Mon, 01 Apr 2019 18:31:34 +0200
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
References: <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com> <20190328203056.GB4096@calimero.vinschen.de> <fe627231-6717-c702-b97b-d66cdc9409a3@ssi-schaefer.com> <20190401145658.GA6331@calimero.vinschen.de> <20190401155636.GN3337@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <c1e5901f-ae3e-2c22-46cd-895adadae358@ssi-schaefer.com>
Date: Mon, 01 Apr 2019 16:31:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401155636.GN3337@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SW-Source: 2019-q2/txt/msg00003.txt.bz2


On 4/1/19 5:56 PM, Corinna Vinschen wrote:
> On Apr  1 16:56, Corinna Vinschen wrote:
>> On Apr  1 16:28, Michael Haubenwallner wrote:
>>> On 3/28/19 9:30 PM, Corinna Vinschen wrote:
>>>> can you please collect the base addresses of all DLLs generated during
>>>> the build, plus their size and make a sorted list?  It would be
>>>> interesting to know if the hash algorithm in ld is actually as bad
>>>> as I conjecture.
>>>
>>> Please find attached the output of rebase -i for the dlls after bootstrap
>>> on Cygwin 3.0.4, each built with ld from binutils-2.31.1.
> 
> Oh, wait.  That's not what I was looking for.  The addresses are ok, but
> the paths *must* be the ones at the time the DLLs have been created,
> because that's what ld uses when creating the image base addresses.

Maybe I can provide that one as well.

> The
> addresses combined with the installation paths don't make sense anymore.
> 
> Apart from that, since you seem to be installing the DLLs anyway, can't
> you combine every crucial point during installation with a rebase?

This is what I'm after now, but I may need to introduce something like
additional readonly databases plus some --unregister option to rebase.

/haubi/

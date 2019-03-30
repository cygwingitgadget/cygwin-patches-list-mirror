Return-Path: <cygwin-patches-return-9279-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5046 invoked by alias); 30 Mar 2019 16:09:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5031 invoked by uid 89); 30 Mar 2019 16:09:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=permanently
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 30 Mar 2019 16:09:57 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id AGYMhqmrTldkPAGYNhBPSd; Sat, 30 Mar 2019 10:09:56 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <87y350ytpb.fsf@Rainer.invalid> <9c38ac1d-4dea-12d4-a63b-6e8ec59b3ae8@ssi-schaefer.com> <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com> <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> <87sgv65eyc.fsf@Rainer.invalid> <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca> <87pnq9jupk.fsf@Rainer.invalid> <a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca> <878sww93g9.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <97aec921-d9b1-3b0e-de7a-d492832ba481@SystematicSw.ab.ca>
Date: Sat, 30 Mar 2019 16:09:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <878sww93g9.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00089.txt.bz2

On 2019-03-30 02:22, Achim Gratz wrote:
> Brian Inglis writes:
>> On 2019-03-29 14:23, Achim Gratz wrote:
>>> Brian Inglis writes:
>>>>> If you are packaging your own exes and dlls with your own local Cygwin distro,
>>>>> you should point to your local utility directory with a path in a file under
>>>>> /var/lib/rebase/user.d/$USER for each Cygwin userid on each system, or perhaps
>>>>> you might also need to add your own production exes and dlls into
>>>>> /var/cache/rebase/rebase_user and /var/cache/rebase/rebase_user_exe: see
>>>>> /usr/share/doc/Cygwin/_autorebase.README.
>>
>> I was wondering as my first para above stated, whether rebase_user{,_exe} would
>> be the proper place to add 3rd party Cygwin dlls and exes, that are distributed
>> with Cygwin (internally)?
> 
> Well, if you are distributing something (even just locally), then
> preferrably you make proper Cygwin packages and you will never have to
> deal with rebase yourself.
> 
> The options you allude to above are meant for cases where that just
> isn't possible and so you install things without using setup and often
> also outside the Cygwin install (permanently, not temporarily until it
> gets packaged).  You still need to run setup after each change so
> autorebase can pick up on it.

Thanks Achim,

I think that those are possibly the answers the OP Michael was looking for,
depending on how they are using Gentoo Prefix: it did not seem like they were
installing their dlls and exes using Cygwin setup, but they could still run
autorebase under dash.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.

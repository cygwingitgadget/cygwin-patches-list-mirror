Return-Path: <cygwin-patches-return-8742-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125918 invoked by alias); 19 Apr 2017 15:52:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125895 invoked by uid 89); 19 Apr 2017 15:52:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*corinna-cygwin, love, HTo:U*cygwin-patches, learn
X-Spam-User: qpsmtpd, 2 recipients
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp2.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 19 Apr 2017 15:52:26 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id E67BC8AE57;	Wed, 19 Apr 2017 11:52:25 -0400 (EDT)
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD2D48AE56;	Wed, 19 Apr 2017 11:52:25 -0400 (EDT)
Received: from [192.168.1.4] (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 436288AE55;	Wed, 19 Apr 2017 11:52:25 -0400 (EDT)
Subject: Re: [PATCH] strace: Fix crash caused over-optimization
To: cygwin-patches@cygwin.com, Corinna Vinschen <corinna-cygwin@cygwin.com>
References: <20170415222750.28067-1-daniel.santos@pobox.com> <201db532-9a76-7358-d12a-469a1f5e7d71@dronecode.org.uk> <955dbe34-f515-1e39-1d9c-a5e92c33fd87@pobox.com> <20170418100400.GA29220@calimero.vinschen.de>
From: Daniel Santos <daniel.santos@pobox.com>
Message-ID: <b9c87890-f3f5-7e67-7509-9955f56b412c@pobox.com>
Date: Wed, 19 Apr 2017 15:52:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170418100400.GA29220@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 2EE353BA-2518-11E7-9F7F-C260AE2156B6-06139138!pb-smtp2.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00013.txt.bz2

On 04/18/2017 05:04 AM, Corinna Vinschen wrote:
> On Apr 17 03:39, Daniel Santos wrote:
>
>> I actually did try that, although I had guessed it wouldn't (and shouldn't)
>> work.  I believe that the reason is that rather the accesses are volatile or
>> not, gcc can see nothing else using it and memset can be a treated as a
>> compiler built-in (per the C spec, maybe C89?), so it can presume the
>> outcome.  If there's a cleaner way to do this, I would really love to learn
>> that.  __attribute__ ((used)) only works on variables with static storage.
>>
>> Now I suspect that I may have found a little bug in gcc, because if I call
>> memset by casting it directly as a volatile function pointer, it is still
>> optimized away, and it should not:
>>
>>    ((void *(*volatile)(void *, int, size_t))memset) (buf, 0, sizeof (buf));
>>
>> And most interestingly, if I first assign a local volatile function pointer
>> to the address, then gcc properly does *not* optimize it away:
>>
>>    void *(*volatile vol_memset)(void *, int, size_t) = memset;
>>    vol_memset (buf, 0, sizeof (buf));
>>
>> I'm actually really glad for your response and that I played with this
>> because I need to make sure that this problem doesn't exist in gcc7.  I have
>> changes going into gcc8 shortly and this could mask problems from my test
>> program where I cast functions as volatile w/o assigning using a local.
>>
>> Daniel
> What about using RtlSecureZeroMemory instead?
>
>
> Corinna

Well that's surprising.  Yes, it does solve the problem and I presume 
would be more portable. :)  It even inlines the "memset", but uses a 
single byte rep stos.  Technically, I think that a double-word stos 
could be used in this case, but I doubt that matters much.

Daniel

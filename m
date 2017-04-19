Return-Path: <cygwin-patches-return-8744-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13441 invoked by alias); 19 Apr 2017 18:46:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13326 invoked by uid 89); 19 Apr 2017 18:46:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*corinna-cygwin, love, cygwinpatchescygwincom, HTo:U*cygwin-patches
X-Spam-User: qpsmtpd, 2 recipients
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp2.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 19 Apr 2017 18:45:59 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id E84D78D025;	Wed, 19 Apr 2017 14:45:58 -0400 (EDT)
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id DFB618D024;	Wed, 19 Apr 2017 14:45:58 -0400 (EDT)
Received: from [192.168.1.4] (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA7978D021;	Wed, 19 Apr 2017 14:45:57 -0400 (EDT)
Subject: resend: Re: [PATCH] strace: Fix crash caused over-optimization
References: <b9c87890-f3f5-7e67-7509-9955f56b412c@pobox.com>
To: cygwin-patches@cygwin.com, Corinna Vinschen <corinna-cygwin@cygwin.com>
From: Daniel Santos <daniel.santos@pobox.com>
X-Forwarded-Message-Id: <b9c87890-f3f5-7e67-7509-9955f56b412c@pobox.com>
Message-ID: <993a416c-0783-38e3-63a3-cbe0e44aa8b8@pobox.com>
Date: Wed, 19 Apr 2017 18:46:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <b9c87890-f3f5-7e67-7509-9955f56b412c@pobox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 6D4B2E08-2530-11E7-B438-C260AE2156B6-06139138!pb-smtp2.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00015.txt.bz2

sourceware.org decided that I was a spammer for some weird reason... 
Maybe this one will go through...

On 04/19/2017 10:52 AM, MAILER-DAEMON@sourceware.org wrote:
> Hi. This is the qmail-send program at sourceware.org.
> I'm afraid I wasn't able to deliver your message to the following addresses.
> This is a permanent error; I've given up. Sorry it didn't work out.
>
> <cygwin@cygwin.com>:
> Mail rejected: List address must be in To: or Cc: headers.
> See http://sourceware.org/lists.html#sourceware-list-info for more information.
>       
> If you are not a "spammer", we apologize for the inconvenience.
> You can add yourself to the cygwin.com "global allow list"
> by sending email *from*the*blocked*email*address* to:
>    


-------- Forwarded Message --------
Subject: 	Re: [PATCH] strace: Fix crash caused over-optimization
Date: 	Wed, 19 Apr 2017 10:57:02 -0500
From: 	Daniel Santos <daniel.santos@pobox.com>
To: 	cygwin-patches@cygwin.com, Corinna Vinschen 
<corinna-cygwin@cygwin.com>



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

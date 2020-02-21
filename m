Return-Path: <cygwin-patches-return-10099-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85059 invoked by alias); 21 Feb 2020 09:43:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84914 invoked by uid 89); 21 Feb 2020 09:43:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=21022020
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 21 Feb 2020 09:43:35 +0000
Received: from [10.161.52.139] ([178.19.220.109]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M8xsm-1j7q0A3r9i-0066Et for <cygwin-patches@cygwin.com>; Fri, 21 Feb 2020 10:43:33 +0100
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
To: cygwin-patches@cygwin.com
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp> <20200220133531.GR4092@calimero.vinschen.de> <20200220134459.GS4092@calimero.vinschen.de> <20200220231312.8d7f478d578970fca29098bf@nifty.ne.jp> <20200220142245.GU4092@calimero.vinschen.de> <20200220234943.2d3bf6ca40d95166a5960051@nifty.ne.jp> <20200220160401.GV4092@calimero.vinschen.de> <db2b11d3-8499-55be-5384-8d6c623138f0@towo.net> <20200220163804.GW4092@calimero.vinschen.de> <20200221093253.GX4092@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
X-Tagtoolbar-Keys: D20200221104331833
Message-ID: <03af37e2-d04b-419e-06dc-f13fda58bedc@towo.net>
Date: Fri, 21 Feb 2020 09:43:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221093253.GX4092@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00205.txt

On 21.02.2020 10:32, Corinna Vinschen wrote:
> On Feb 20 17:38, Corinna Vinschen wrote:
>> On Feb 20 17:22, Thomas Wolff wrote:
>>> On 20.02.2020 17:04, Corinna Vinschen wrote:
>>>> On Feb 20 23:49, Takashi Yano wrote:
>>>>> On Thu, 20 Feb 2020 15:22:45 +0100
>>>>> Corinna Vinschen wrote:
>>>>>> On Feb 20 23:13, Takashi Yano wrote:
>>>>>>> On Thu, 20 Feb 2020 14:44:59 +0100
>>>>>>> Corinna Vinschen wrote:
>>>>>>>> But, here's a question: Why do we move the cursor to the right at all?
>>>>>>>> I assume this is compatible with legacy mode, right?
>>>>>>> Hmm. This may be a bug of legacy console.
>>>>>>> https://en.wikipedia.org/wiki/Null_character
>>>>>>> says
>>>>>>> (some terminals, however, incorrectly display it as space)
>>>>>>>
>>>>>>> What about ignoring NUL in legacy mode too?
>>>>>> I'd like that, but this may be a problem in terms of backward
>>>>>> compatibility.  The behaviour is so old, it actually precedes even the
>>>>>> import of Cygwin code into the original CVS repository, 20 years ago...
>>>>> If so, can't we say it is the *specification* of TERM=cygwin
>>>>> that NUL moves the cursor right?
>>>> Good point.  Yes, in that case it's "working as designed" and
>>>> we just leave it as is.  I push my patch.
>>> See `man 5 terminfo`: if NUL does anything else than just padding, the
>>> terminfo entry must contain a pad or npc entry, which it doesn't.
>>> Trouble to be expected. I'd rather suggest to align the design with
>>> applications' expectations.
>> Is that the cygwin terminfo or the xterm terminfo you're talking about?
>>
>> In case of the cygwin terminfo, that would mean the cygwin terminal
>> emulation behaves differently from the terminfo for ages.  I guess
>> you're right then, we should fix this in the cygwin terminal emulation
>> to make sure it behaves as descibed in its terminfo.
>>
>> In case of the xterm terminfo, that would be no problem because my patch
>> drops the cursor movement for NUL.
> Yeah, never mind, I checked the cygwin terminfo entry myself.
>
> I pushed a patch removing the cursor movement on NUL and added
> a matching comment instead.
Great, thanks! And sorry I'm sometimes a bit slow to respond...

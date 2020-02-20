Return-Path: <cygwin-patches-return-10095-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64159 invoked by alias); 20 Feb 2020 16:23:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64150 invoked by uid 89); 20 Feb 2020 16:22:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Feb 2020 16:22:57 +0000
Received: from [10.161.52.135] ([178.19.220.109]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MryKr-1jqCi20YoH-00o11f for <cygwin-patches@cygwin.com>; Thu, 20 Feb 2020 17:22:55 +0100
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
To: cygwin-patches@cygwin.com
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp> <20200220133531.GR4092@calimero.vinschen.de> <20200220134459.GS4092@calimero.vinschen.de> <20200220231312.8d7f478d578970fca29098bf@nifty.ne.jp> <20200220142245.GU4092@calimero.vinschen.de> <20200220234943.2d3bf6ca40d95166a5960051@nifty.ne.jp> <20200220160401.GV4092@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
X-Tagtoolbar-Keys: D20200220172253532
Message-ID: <db2b11d3-8499-55be-5384-8d6c623138f0@towo.net>
Date: Thu, 20 Feb 2020 16:23:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220160401.GV4092@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00201.txt

On 20.02.2020 17:04, Corinna Vinschen wrote:
> On Feb 20 23:49, Takashi Yano wrote:
>> On Thu, 20 Feb 2020 15:22:45 +0100
>> Corinna Vinschen wrote:
>>> On Feb 20 23:13, Takashi Yano wrote:
>>>> On Thu, 20 Feb 2020 14:44:59 +0100
>>>> Corinna Vinschen wrote:
>>>>> On Feb 20 14:35, Corinna Vinschen wrote:
>>>>>> On Feb 20 20:51, Takashi Yano wrote:
>>>>>>> - In xterm compatible mode, 0x00 on write() behaves incompatible
>>>>>>>    with real xterm. In xterm, 0x00 completely ignored. Therefore,
>>>>>>>    0x00 is ignored by console with this patch.
>>>>>>> ---
>>>>>>>   winsup/cygwin/fhandler_console.cc | 10 ++++++++++
>>>>>>>   1 file changed, 10 insertions(+)
>>>>>>> [...]
>>>>>> Counter-proposal:
>>>>>>
>>>>>> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
>>>>>> index 66e645aa1774..1b3aa0f34aa6 100644
>>>>>> --- a/winsup/cygwin/fhandler_console.cc
>>>>>> +++ b/winsup/cygwin/fhandler_console.cc
>>>>>> [...]
>>>>> Btw., I tested this with
>>>>>
>>>>>    write (1, "A\0B\0C\0D", 7);
>>>>>
>>>>> it turned out that this results in broken output even with your patch.
>>>>> The reason is that a NUL byte must not (cannot) be evaluated by
>>>>> dev_console::str_to_con() -> sys_cp_mbstowcs().  The latter doesn't
>>>>> handle embedded NUL bytes gracefully.
>>>> Indeed. Your patch is much better.
>>>>
>>>> On Thu, 20 Feb 2020 14:35:31 +0100
>>>> Corinna Vinschen wrote:
>>>>> But, here's a question: Why do we move the cursor to the right at all?
>>>>> I assume this is compatible with legacy mode, right?
>>>> Hmm. This may be a bug of legacy console.
>>>> https://en.wikipedia.org/wiki/Null_character
>>>> says
>>>> (some terminals, however, incorrectly display it as space)
>>>>
>>>> What about ignoring NUL in legacy mode too?
>>> I'd like that, but this may be a problem in terms of backward
>>> compatibility.  The behaviour is so old, it actually precedes even the
>>> import of Cygwin code into the original CVS repository, 20 years ago...
>> If so, can't we say it is the *specification* of TERM=cygwin
>> that NUL moves the cursor right?
> Good point.  Yes, in that case it's "working as designed" and
> we just leave it as is.  I push my patch.
See `man 5 terminfo`: if NUL does anything else than just padding, the 
terminfo entry must contain a pad or npc entry, which it doesn't.
Trouble to be expected. I'd rather suggest to align the design with 
applications' expectations.

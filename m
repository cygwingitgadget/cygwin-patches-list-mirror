Return-Path: <cygwin-patches-return-10066-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11888 invoked by alias); 11 Feb 2020 07:27:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11874 invoked by uid 89); 11 Feb 2020 07:27:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-0.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=10.02.2020, para
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 11 Feb 2020 07:27:13 +0000
Received: from [192.168.178.45] ([95.90.246.218]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MXXdn-1izzZB2ej9-00Yw7S for <cygwin-patches@cygwin.com>; Tue, 11 Feb 2020 08:27:10 +0100
Subject: Re: [PATCH v2] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
To: cygwin-patches@cygwin.com
References: <20200121222329.69f71c847e97da78955735a7@nifty.ne.jp> <20200121132513.3654-1-takashi.yano@nifty.ne.jp> <20200122100651.GT20672@calimero.vinschen.de> <a5724cea-edda-6ab9-fc7c-cbf3ad3091cc@towo.net> <20200210100710.GD4442@calimero.vinschen.de> <20200210212441.91b09887b3518b029560ff6a@nifty.ne.jp>
From: Thomas Wolff <towo@towo.net>
X-Tagtoolbar-Keys: D20200211082714086
Message-ID: <c65bd196-07a3-b0c5-6350-88d16f48a810@towo.net>
Date: Tue, 11 Feb 2020 07:27:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210212441.91b09887b3518b029560ff6a@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00172.txt

Am 10.02.2020 um 13:24 schrieb Takashi Yano:
> On Mon, 10 Feb 2020 11:07:10 +0100
> Corinna Vinschen wrote:
>> On Feb  8 18:13, Thomas Wolff wrote:
>>> On 22.01.2020 11:06, Corinna Vinschen wrote:
>>>> On Jan 21 22:25, Takashi Yano wrote:
>>>>> - For programs which does not work properly with pseudo console,
>>>>>     disable_pcon in environment CYGWIN is introduced. If disable_pcon
>>>>>     is set, pseudo console support is disabled.
>>>> Pushed.  I just fixed a missing </para> in the doc text.
>>>>
>>> Sorry I didn't notice this before. I think rather than having to decide and
>>> unconditionally switch on or off, a better approach would be to
>>> automatically enable pseudo console when forking a non-cygwin program only,
>>> or have that as a third option. (I think I had suggested this before.)
>>> It's good we had pseudo console in unconditionally now for a while, as that
>>> apparently helped identifying a bunch of issues, but targetting it to where
>>> it's really needed would further help to avoid future trouble, including any
>>> performance issues as recently reported.
>>> I'm willing to prepare a patch if desired, as I had implemented that
>>> condition already for my earlier "winpty injection" proposal.
>>> Thomas
>> Interesting idea, but given that all the Pseudo Console code in
>> Cygwin is from Takashi, he should decide how to go forward.
>>
>> Takashi?  What do you think?
> I cannot imagine how to realize this right now. Let me consider.
>
See https://cygwin.com/ml/cygwin-developers/2018-04/msg00002.html for my 
patch.

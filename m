Return-Path: <cygwin-patches-return-10120-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11750 invoked by alias); 25 Feb 2020 17:56:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11656 invoked by uid 89); 25 Feb 2020 17:56:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=Education, wine, enterprise, Enterprise
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Feb 2020 17:56:40 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 6eRij5lSERnrK6eRjj5izI; Tue, 25 Feb 2020 10:56:40 -0700
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Reply-To: Brian.Inglis@SystematicSw.ab.ca
To: cygwin-patches@cygwin.com
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp> <20200221194333.GZ4092@calimero.vinschen.de> <20200222170123.23099cf86117791daa1722c5@nifty.ne.jp> <20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp> <20200224100835.GD4045@calimero.vinschen.de> <20200225011011.7d2c6b5350c0738b705480ba@nifty.ne.jp> <20200224183318.GH4045@calimero.vinschen.de> <20200225120816.3abe69332aace2b7f1b392ae@nifty.ne.jp> <20200225125325.52039a023b7f21c497a05933@nifty.ne.jp>
Message-ID: <d22e398b-f655-3259-a29a-b7678c5b23fb@SystematicSw.ab.ca>
Date: Tue, 25 Feb 2020 17:56:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200225125325.52039a023b7f21c497a05933@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00226.txt

On 2020-02-24 20:53, Takashi Yano wrote:
> On Tue, 25 Feb 2020 12:08:16 +0900
> Takashi Yano wrote:
>> On Mon, 24 Feb 2020 19:33:18 +0100
>> Corinna Vinschen wrote:
>>> Is there some kind of workaround for that problem?  Otherwise defaulting
>>> to a (broken) xterm mode instead of a (working) cygwin mode is a bit
>>> questionable, isn't it?
>>
>> In my environment, legacy cygwin mode is not 'working' with
>> gray background and black foreground. You can confirm what
>> happens if xterm mode is disabled by reverting cygwin to 3.0.7.
>>
>> If you type 'aaa' in shell prompt and hit backspace, then
>> whole line after cursor gets black. Furthermore, if you run
>> vim, whole screen gets into black background and gray fore-
>> ground.
>>
>> Do not these happen in your environment?
>>
>> Oh, wait. I was setting foreground and background color in
>> "terminal" tab in property. If I set them in "colors" tab,
>> cmd.exe behaves differently. In this setting, your problem
>> does not seems to occur.

Terminal tab is only supported in latest W10 (Home - not necessarily Enterprise,
Education, etc.) and is "experimental" so properties could disappear, change,
work differently.

> I was wrong. The problem also occur with "colors" tab setting.
> However, in this case, ScrollConsoleScreenBuffer() test case
> does not cause the problem. Therefore it may be possible to
> make a workaround for this. I will try.

Please do not forget many users may still be running earlier W10 or pre-W10
releases as we still support Vista, 7, 8, 8.1, some may be running server
releases, and even running under Wine.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.

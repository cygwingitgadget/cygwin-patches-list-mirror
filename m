Return-Path: <cygwin-patches-return-10112-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13145 invoked by alias); 24 Feb 2020 21:08:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13135 invoked by uid 89); 24 Feb 2020 21:08:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=refresh
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Feb 2020 21:08:41 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 6KxyjnDQw17ZD6KxzjKkND; Mon, 24 Feb 2020 14:08:39 -0700
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
To: cygwin-patches@cygwin.com
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp> <20200221194333.GZ4092@calimero.vinschen.de> <20200222170123.23099cf86117791daa1722c5@nifty.ne.jp> <20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp> <20200224100835.GD4045@calimero.vinschen.de> <20200225011011.7d2c6b5350c0738b705480ba@nifty.ne.jp> <20200224183318.GH4045@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <a3046910-9c5c-d527-0499-9db87f4b0436@SystematicSw.ab.ca>
Date: Mon, 24 Feb 2020 21:08:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200224183318.GH4045@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00218.txt

On 2020-02-24 11:33, Corinna Vinschen wrote:
> On Feb 25 01:10, Takashi Yano wrote:
>> On Mon, 24 Feb 2020 11:08:35 +0100
>> Corinna Vinschen wrote:
>> [...]
>>> Btw., are you testing the console with black background?  I'm asking
>>> because I'm using the console with grey background and black characters,
>>> and I'm always seeing artifacts when using vim in xterm mode.
>>>
>>> E.g., open vim on the fork-setsid.c source in the console in xterm
>>> mode.  Move the cursor to the beginning of the word `setsid'.  Now
>>> press the three chars
>>>
>>>   c h <CR>
>>>
>>> this moves the setsid call to the next line.  But it also adds
>>> black background after `setsid();'.  Simiar further actions always
>>> create black background artifacts.
>>>
>>> Is there anything we can do against that?
>>
>> This seems to be a bug of windows console. It also occurs in wsl.
>> /bin/echo -e '\033[H\033[5L'
>> causes the similar result.
> 
> Oh well.
> 
>> The following code cause the problem as well.
>>
>> #include <windows.h>
>> int main()
>> {
>>     CONSOLE_SCREEN_BUFFER_INFO sbi;
>>     SMALL_RECT r;
>>     COORD c = {0, 0};
>>     CHAR_INFO f = {' ', 0};
>>     HANDLE h = GetStdHandle(STD_OUTPUT_HANDLE);
>>     DWORD n;
>>     ReadConsoleOutputAttribute(h, &f.Attributes, 1, c, &n);
>>     GetConsoleScreenBufferInfo(h, &sbi);
>>     c.X = 0;
>>     c.Y = sbi.srWindow.Top + 5;
>>     ScrollConsoleScreenBuffer(h, &sbi.srWindow, NULL, c, &f);
>>     return 0;
>> }
> 
> Is there some kind of workaround for that problem?  Otherwise defaulting
> to a (broken) xterm mode instead of a (working) cygwin mode is a bit
> questionable, isn't it?

I'm a windows with white backgrounds user and e.g. vim in latest Cygwin under
cmd requires typing ctrl-L to refresh the screen every couple of commands or
motions; looks okay under mintty in windows with white backgrounds.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.

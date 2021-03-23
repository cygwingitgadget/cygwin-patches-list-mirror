Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id B4BBE386100A
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 19:45:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B4BBE386100A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([68.147.0.90]) by shaw.ca with ESMTP
 id OmxplpZ4QnRGtOmxql8QKa; Tue, 23 Mar 2021 13:45:19 -0600
X-Authority-Analysis: v=2.4 cv=cagXElPM c=1 sm=1 tr=0 ts=605a454f
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=tb5krXdZlfIJ7iNKzAQA:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
To: cygwin-patches@cygwin.com
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
 <YFnit7OtFJeflMQT@calimero.vinschen.de>
 <ee1366d1-d7bb-0bb3-b9e1-7715eb476985@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Message-ID: <9836a8eb-6ced-fe7a-75ab-4bbfcf9a896a@SystematicSw.ab.ca>
Date: Tue, 23 Mar 2021 13:45:17 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ee1366d1-d7bb-0bb3-b9e1-7715eb476985@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIbUQMoG1F0lnfNmDBlEFSfydf7MVcJN2uouhONfFodHENiMWblUVtAk2JsXNnXthZf0WSuPGs0ZNlB6CSIgQinXqMY8yuL4MgZTyYaBiEhlUJ0pwKy1
 vbr8S1QlHLy5IGgivT/VXpP6+zhqXkhRodGCXiheOlwKRq9DBy4bgWqEGXVzDKjdxiKl1NNR1Wb4gjuY5zgrLcIJMDsMH3bVJsU=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 23 Mar 2021 19:45:22 -0000

On 2021-03-23 07:09, Jon Turney wrote:
> On 23/03/2021 12:44, Corinna Vinschen via Cygwin-patches wrote:
>> On Mar 23 21:32, Takashi Yano via Cygwin-patches wrote:
>>> On Tue, 23 Mar 2021 13:17:16 +0100
>>> Corinna Vinschen wrote:
>>>> On Mar 23 20:57, Takashi Yano via Cygwin-patches wrote:
>>>>> Corinna Vinschen wrote:
>>>>>>>> On Mar 22 08:07, Takashi Yano via Cygwin-patches wrote:
>>>>>>>>>> And also, following cygwin apps/dlls call GetStdHandle():
>>>>>>>>>> ccmake.exe
>>>>>>>>>> cmake.exe
>>>>>>>>>> cpack.exe
>>>>>>>>>> ctest.exe
>>>>>>>>>> run.exe

>>>>>> run creates its own conin/conout handles to create a hidden console.
>>>>>> The code calling GetStdHandle() is only for debug purposes and never
>>>>>> built into the executable.

>>>> Sorry, but this was utterly wrong.  run calls GetStdHandle, then
>>>> overwrites the handles, but only if it doesn't already is attached to a
>>>> console.

>>>>>> Looks right to me.  If we patch cmake to do the right thing, do we still
>>>>>> need this patch, Takashi?
>>>>> I don't think so. If all is well with current code, nothing to be fixed.

>>>> How do you evaluate this in light of the run behaviour above?

>>> I try to check run.exe behaviour and noticed that
>>> run cmd.exe
>>> and
>>> run cat.exe
>>> does not work with cygwin 3.0.7 and 3.2.0 (TEST) while these
>>> work in 3.1.7.
>>> Is this expected behaviour?

>> The problem is that I never used run.  I can't actually tell what
>> exactly is expected.  I *think* run was intended to start Cygwin
>> applications without console window in the first place, not
>> native Windows apps, but I could be wrong.
>> I don't even know if anybody is actually, seriously using it.

> 'run' is used by the start menu item which starts the X server.
> 
> If that doesn't use it, a visible console window is created for the bash process 
> it starts (which is the parent of the X server process and lives for it's 
> lifetime).
> 
> (As a separate issue, I'm not sure all the complex gymnastics run does to creste 
> the window invisibly are doing anything useful, since we seem to briefly show 
> the window and then hide it)

Shortcut does:
C:\...\cygwin64\bin\run.exe --quote /usr/bin/bash.exe -l -c "cd; exec 
/usr/bin/startxwin"

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]

Return-Path: <SRS0=pn5b=IJ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.62])
	by sourceware.org (Postfix) with ESMTP id C40ED4BA2E27
	for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2026 11:38:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C40ED4BA2E27
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C40ED4BA2E27
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792409933; cv=none;
	b=PeJePJEU6lD0emAe5X63Jz/FWIJpwPJQY5LzWT1NWpw86+8YJA4ht77bqckyFeznvDEbMtDPLC+jwH0rOtTG1t1VCrNuGWkv1qW04kWG6wNo7U7XQk/nJ59IE4uJOlsfGmQ7zgXadq/NawvHQb519XpEMhXHHntnBZf++E1hu3w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792409933; c=relaxed/simple;
	bh=A8C2aBZhsyFEb+SAiwBhD6I9MXD9IjPpeOixDbvXeN4=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=Cucv15DJIHMkJtiqciZx0NVYRvFrPByUNe4vmijZPaTOtxTdfMqcShu8KKl7Sjk8oGxt+1S3RAK+4mH2DfHdFahPxq0nxORoqdEAjxmVH8DxyqZk6au0cJ8WpVWEgTWOjaLASAUz45Tpuwqmc7qRm5VDJkPJbgCG53YhB2T0Z8s=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C40ED4BA2E27
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161380EF8F04D
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: dmFkZTFDJa3fysLjnDEwS/YZEEh8bzBY1Z0HNTv1BOWuvSDDEvwsLdVl2RPKeO2NeDV28zbeXCFt4VA+XojM2ubdzhkrf67DGU0gQXZ+p2llcj/GinhDuCmXkcAF/ozWG1NuV24DA2RGpvmQ6PQGsO8j1YEPqyB6R36DOQ7k2aU5CVeSbAuME3oReEec0PaYjozFgP4b+zdpuw0T1WBTc/z4uwQO22P+78ZviAmcJDf0D9IDHwWN0Lva0q4Cw90uydghjOk32qvv5vMWaB3PZeh/2OkRc9I+QW+JGYmi4HNnpgB7J63MqxfsBQDBBYWe29SksUgP4Xs//X2AI4a+ybrohFFdhzoarmwZobEdtHo2QY3a/iQ2l8aAHcQcUtpuzPnai9QJ3TwMkHIBfk0FqiOgcfeKDjYoRmV5DoaSTqZavPsMVdW19/0rW5w83VQ6ejvVsW4cos9G8vIXICFGEF6qZnqwQbv2cWxwt2HIqFa1vV0g/tfpbDbikMVNe84mtc20L078bq21n/zq7GOYCMZ4uK6ie/C2bHFwT2Hd5iRr95LH+mxiKPi3O9cHhWh7a3iwoKOwVnz8k6/qhDL5r4HzqTaUvuF6iqxPYtTB0djXb+LlPlcbNcq//WdpUWquCRFrtbhgRiG5wrT0MGj8IJcrAEXmpOpQVZPB9rvfp0rN4f2nHQ
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161380EF8F04D for cygwin-patches@cygwin.com; Mon, 19 Oct 2026 12:38:50 +0100
Message-ID: <10c80d37-7b83-465b-a041-8f64153a20d6@dronecode.org.uk>
Date: Mon, 19 Oct 2026 12:38:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: signal: preserve runtime nesting across user
 handlers
References: <pull.12.cygwin.1791398786755.gitgitgadget@gmail.com>
 <40c7ebb4-ff69-45d1-9106-b62457477e04@dronecode.org.uk>
 <20261015144134.a4eb492e28ac4c72891593e9@nifty.ne.jp>
 <20261017152549.d0583b317aa494345f79b18d@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20261017152549.d0583b317aa494345f79b18d@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 17/10/2026 07:25, Takashi Yano wrote:
> Hi Jon,
> 
> On Thu, 15 Oct 2026 14:41:34 +0900
> Takashi Yano wrote:
>> Hi Johannes,
>>
>> On Tue, 13 Oct 2026 19:47:43 +0100
>> Jon Turney wrote:
>>> On 07/10/2026 19:46, Johannes Schindelin via GitGitGadget wrote:
>>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>>
>>>> CMake/libuv `posix_spawn` callers can hang waiting for `SIGCHLD` after
>>>> nested signal delivery. Restoring `_cygtls::incyg` to `1` loses the
>>>> concrete nesting level; subsequent balancing can leave it at zero,
>>>> disabling the controlled signal-wakeup path.
>>>>
>>>> Preserve the incoming count, including zero, to keep runtime nesting
>>>> balanced. The public-API regression targets lost wakeups after nested
>>>> delivery, including within `pthread_once`.
>>>>
>>>> This was suggested by Takashi Yano on May 28th, 2025 in
>>>> https://inbox.sourceware.org/cygwin-patches/20250528125311.2589-1-takashi.yano@nifty.ne.jp/,
>>>> part of which was applied as 8201c57dd1 (Cygwin: signal: Revert
>>>> _cygtls::inside_kernel() change, 2025-05-28). The remaining part is what
>>>> is applied here, together with a regression test that exercises the code
>>>> path that is fixed by it.
>>>
>>> It seems like restoring the level was part of v1 of the patch, but
>>> dropped in v2, so maybe he has some context for this I'm missing.
>>
>> Embarrassingly, I have absolutely no recollection of why I
>> reverted part of the v1 changes in v2. But since that change
>> indeed fixes your test case, it clearly did have a purpose.
>> Thank you for resubmitting the patch!
>>
>>> But thank you so much for including a test!
>>>
>>>> Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>>>> Fixes: b7097ab39ed0 ("Cygwin: signal: Revive toggling incyg flag in call_signal_handler()")
>>>> Assisted-by: GPT-6.1
>>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>> ---
>>>>       Cygwin: signal: preserve runtime nesting across user handlers
>>>>       
>>>>       This patch addresses the hangs experienced in
>>>>       https://github.com/msys2/msys2-runtime/pull/375#issuecomment-5967746825.
> 
> If you have no objections, I’d like to apply the patch. What do you think?

Uh, I can't claim to have any deep understanding of this part of the 
code, but restoring the original nesting level seems obviously more 
correct, so go ahead.

(Some more commentary, or updating in DevDocs to say "incyg must be zero 
and sigstack unlocked while we call the signal handler because (i) it 
might longjmp rather than returning, and (ii) it can be interrupted by 
signals" or whatever the situation actually is might be nice.)


Return-Path: <SRS0=q+sW=FH=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.80])
	by sourceware.org (Postfix) with ESMTP id B897E4BA2E11
	for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2026 20:08:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B897E4BA2E11
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B897E4BA2E11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783973321; cv=none;
	b=sYw2KEzU1x0Bjai7Or1JsRpTAe/ENYy2niewxlnZFD8pSIWvTQavVTE+GP5yzaeg2BQR0CSNRxWOmjkQY1dODZvb4+vwFu7ixhRXHf8LfsgyjBNTiiW6Fpsqryy86jDGLcmtGqxjjeH/t/bkFFkxcItTKOOadBpJI77S6RfnTyU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783973321; c=relaxed/simple;
	bh=pBrhR5ZN4tKDeA6swzk27VORcrwPYpU7mxKI9Jn9VqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=US8MiHAAyX9osgvyu/F/WkSuZIY/3Fj3LU/7xd0taoV5sX9Rr8P9e5uhuAEeU4edIsYCnP4C9/MSuG3ha0XlINAv/BEM9qN7Z1Ym8VhfxdLYHSsiJ1Z3HFBw8nQohvKBi7XOvQ52Isyd2MDFnMVLIbqZFI5hD/lRiOj/Jf8DeRo=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B897E4BA2E11
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A03A6220501307A
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTFbHAR803SkD73F+iqzlyCEStPpymvv9c5qsfYuEqU5lVHnZrScfL0N6ZSMxE1N40mWM838P1JfxT1LuoaugYlPHbiRVtKBm2P1AjN6eOHg/vEV4rm4xAiyJ9sjhceAIXaZ9doQjAjd81zalxbACX4NkMrdAvlh9Zz+b8qqgr5XNC6UGbOSp5pinF6jMo5Rg4FYi3YLdxF1sG3Wa/dtEm+TjhYbpuTl1rXzYyu4aJAkBgk6Ivs5qURRqvqlyUKJ1HRIbfxaVvtPbsTybTTFOVn+HvncsilCFbMMyg/RVgVs4SSNsfPr761W0TjaIB1cLMVvKFzFkRMRQUiwPZ/8xPIULj2LmKxfanXgJrbaugQV9JZvR28cfIz2S93gfB3K84lHsa9+9XmdC1IHl2R48/8W1RIQ7AdTy5LeX+DBvtVFPeOiJkrQZlo65TNd8VQS6WdBZc6aNCNfEW5Hf2xQRKnhVIz7iY8U3qNsXrPU24+LZAg6v1r/wbzOLgTjaWZiUShl47J9teP/0P6D4dmWRaGdotq1igdn1NzzYX6dIc/mDq0+YesrROothcRjl5mp8fTHJsDhgd9eumEQz12AEyZ217rgLid9h0cV/ZkO/FBC3CmctvDl1HsgTJn8mc2At+uFnq1VOP/qGhpcVMzBUPNEghoLcdWRbTbt62AW07fAMQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A03A6220501307A; Mon, 13 Jul 2026 21:08:39 +0100
Message-ID: <cf39e10e-2b20-4c12-a769-ce73d61f4d9a@dronecode.org.uk>
Date: Mon, 13 Jul 2026 21:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
To: Sebastian Feld <sebastian.n.feld@gmail.com>
References: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de>
 <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com>
 <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com>
 <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de>
 <aIJ2kbx6UOK6mAnG@calimero.vinschen.de>
 <b05a2798-ce6a-28cf-f8e2-3f0cd7bf165b@jdrake.com>
 <CAHnbEGJT8vKZjR8aXqB+aANZ8J9P8G5bnLO6gf860FzAeCCXMA@mail.gmail.com>
 <8fadabda-8d77-4751-86a2-c9741624b648@dronecode.org.uk>
 <CAHnbEGLjarFbKBA37b5medyqcFAMuVo-dQB0n_Gwu_zWoHL90A@mail.gmail.com>
 <Pine.BSF.4.63.2603132030250.5777@m0.truegem.net>
 <CAHnbEG+a=UMEctqStWq_3otqhvcw5U38Z=JaFnViM117LWCvbQ@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <CAHnbEG+a=UMEctqStWq_3otqhvcw5U38Z=JaFnViM117LWCvbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 06/07/2026 11:11, Sebastian Feld wrote:
> On Sat, Mar 14, 2026 at 4:30 AM Mark Geisert <mark@maxrnd.com> wrote:
>>
>> On Fri, 13 Mar 2026, Sebastian Feld wrote:
>>
>>> On Thu, Mar 12, 2026 at 3:45 PM Jon Turney <jon.turney@dronecode.org.uk>
>> wrote:
>>>>
>>>> On 09/03/2026 09:54, Sebastian Feld wrote:
>>>>> Was this work ever merged into Cygwin1.dll?
>>>>
>>>> Unfortunately, not.  And Jeremy seems to have moved on to other ways to
>>>> apply his talents.
>>>>
>>>> It would be ideal if someone else would pick up that work and get it
>>>> finished off.

This still applies.

>>> That would require a cygwin.dll expert beyond my skill set.
>>>
>>> What about adding the current work as build option?
>>
>> If/when "someone" can be found for this work, it would be far better to
>> finish the work so it can be tested and merged.
>>
>> I can't imagine providing a build option for an unfinished, unsupported,
>> branch of the Cygwin DLL to "release" a lightning-rod feature to users who
>> won't know how to make use of the incomplete code.  That just sounds like
>> more future work for us, to be honest.
>>
>> You've reminded us of this unfinished work so it's again visible to us.
>> Thank you for that.
> 
> Monthly reminder that the posix_spawn() work is still not finished.
> but needed. because the fork(),exec() performance of Cygwin is very
> very bad.

Please don't do this! We are well aware of the status of these patches 
and don't require "monthly reminders" about them.

This is a place for actively contributing to the development of Cygwin, 
not a venue for you to try to badger our volunteer developers into 
working on whatever you happen to think is important.


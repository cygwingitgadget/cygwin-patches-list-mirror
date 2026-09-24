Return-Path: <SRS0=kM7z=HQ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id 464F24BA9000
	for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 15:32:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 464F24BA9000
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 464F24BA9000
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790263940; cv=none;
	b=EgzBJt/dr2oQPvXgp+4T8R81Q7vaA7M/Y+R7wndGfqjwoANUNdcudKiRKAl/cRjHMgwn+o9hDnhbCUnTlt9/cRzFwTo72c0i76BjTA+mhFhyODUR0shoEA2JGI4rC/KrckOSBtphnm93n5eDv1xsRSmVEFugdAoHZ/4SXoVHQGw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790263940; c=relaxed/simple;
	bh=+bvzCySsVbwlAefpSS3+j8nL7dXzEvNj5h9jDrxSZrA=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=wWxDSTRYC5r++xJVHBi1rXO+DaQIjDFaX+BOc6VBvW4LGaiv3Q4P8XlnA3ik2us7OOPxtveaaER4UV09/99VWkegov7Ho5bwbH94f/3ZBv2bHiFqwPQT+wGIOfHh7e+04ci3FDuFg0QFAevqDpVYi2EMMia2jI/bJzOM3HwBlQ0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 464F24BA9000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715D8109D8F61B
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: dmFkZTGl3efrSB2JUu8OHYv/5fBiwb0L+GYlf0ob4mEJfHg7O1Zcc4PlLTco19O66/xkoDkyeTjtziKWmC9e/pRULF0yEPSZpkFNDKteRgIZ0BTA+/XTbx5MfWkskafxZSx6/0DPxYzlpnTZOfH6bXECOgUyecg7FNY0l6zIYISHxixA1HU/QWSJ0oxrm2cBW2RcImblBoDQjR6P24kwp0z6I6SMF0b4s1FuRGDBXzlzA0GoJ8UiuzcmgTdDkxexn6CYcBWw8/esPNBhMFWTvzWnvFnEO3X5G8AILhfA0VT3ptMNRwJsUCLMaJulBenIZGCTxzstiSCSqHykmGQuzoB5b5DoHQxeB3OhpwW4krjF+WMA99/PfHUcu3gfahJLqdwyHQjKuUdHKaIM/1aGDuy6fnClXWl1TN2rolkEiP4FJNshX+3bKpwAwwYpgLT75mXhPJwcfKGB4sUax0fjg1sN6fSfXEmIIaf07E5HPvPvV+LVk0v8FI+mvCtGEhod8Z3MEk2gOqTl2xbR7xblFu/6ow+cyP41ISb67mpbZRkjb2ziEZsQedaw0+bhmRyL1pkSo1P+S5D7g2/VdhuO/NQK5BysLz5aXPOS/IR41hxV7a0d166hdXGUC4k3W2B5fPKT36iWuTUag6sJwCXL99jhm35tBJ9g5EHvOCkD3FJmlAPb+Q
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.83.178) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715D8109D8F61B for cygwin-patches@cygwin.com; Thu, 24 Sep 2026 16:32:19 +0100
Message-ID: <d3adc45a-1f24-4b18-bc5a-f5fd4a68555f@dronecode.org.uk>
Date: Thu, 24 Sep 2026 16:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix "unused but set variable" warnings with gcc 16
References: <20260922173737.111763-1-jon.turney@dronecode.org.uk>
 <20260923105544.d6411ade83fa326e6e1674a5@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260923105544.d6411ade83fa326e6e1674a5@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 23/09/2026 02:55, Takashi Yano wrote:
> On Tue, 22 Sep 2026 18:37:34 +0100
> Jon Turney <jon.turney@dronecode.org.uk> wrote:
>> Jon Turney (3):
>>    Cygwin: Variable 'looped' computed but never used
>>    Cygwin: Variable 'prot' computed but never used
>>    Cygwin: Variable 'nfences' computed but never used
>>
>>   winsup/cygserver/sysv_shm.cc | 6 ++++++
>>   winsup/cygwin/mm/malloc.cc   | 4 ++++
>>   winsup/cygwin/spawn.cc       | 2 --
>>   3 files changed, 10 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.51.0
> 
> All LGTM. Please go ahead.

Thanks!


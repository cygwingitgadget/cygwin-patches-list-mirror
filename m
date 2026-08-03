Return-Path: <SRS0=bbDc=F4=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo009.btinternet.com (btprdrgo009.btinternet.com [65.20.50.104])
	by sourceware.org (Postfix) with ESMTP id 4B2EA4BB1C22
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 16:02:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4B2EA4BB1C22
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4B2EA4BB1C22
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.104
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785772943; cv=none;
	b=kfAGyTiohaWF+spbi6Eye+LhDFHPpb00EQ0XYon3r4kv1Zhhy7f31pY+Y/LdcWyaqWMZOQZy4jCZN0k38hr0zdLlLNAUQcBGQYzqjQ7Xj4CoSYMrL4ZxSLO7eCI1dLpU7k0hqnmSWh0tbb8SiVWIWoZa3HHeo8Rk791BV1YhrN8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785772943; c=relaxed/simple;
	bh=dOh9Kr9essRoLBSN0jknB87Ru1Rkgac4IoSx40Imzyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=B33g2ZKYyRIimiVonB/Hug4UMC+PFLcH8agcaXgrjOUKMfGtb/5o2IBlZlmRnDOjNDwqwcXbg4lL3qhv6w2E0eAQkxP1+bhqyqw/Ug2FKjyC6qFfHG0pDY5sCFTHLdCviIrzjCSBfFaKWEzrjk59dxTIWsYUN/Fg8chDQ7OhKsM=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4B2EA4BB1C22
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A00E00B07399536
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTG3cpT3CEVP1tfLVB8yk9FPz3lnfbvQYvkRQ87CADBBayZf4imV0RFV5iMs07+eue0F7for4UMmi9CGSH9CUnAirG/kq+teSf/rBp32Wf8/HOhEZrz7TO8lPLH9Ymecz2w2z1lzymRJFRfBa27hlNVwnOzvuXENX+zXjw4kweNOrUBExfetCet3eX4K3T8f1uzhFCH6aZRThfTP4LJlYS6V+/RBLEQJnqjhDA0qWJPluNMD+kcDpZkATBzVBGWSH6tHibIVSNv2rmrkNLsugVJ4fs+Fum5uLdfdD7HocRQh3qxc95m4hb7tByoUvcIqgVasz8SSS2ZSfYgz7KeEY+lwVj3zDOCbW+Dyo8qlvFsT6SCvZqtMIhOD1eya1D9uJWB/BSCo1WtW6ZTMT1Cd/cH3mNzZvc7SYoeTa7eSnCEjFJJ4nqdbrrm3ZXIbgzW12Bkn7pFA4MmfR79PQdk7vdVMpuoORndnKYzuj+tYkBscJuXFAk52lLGdyGuAnZCeYLOYwJyeP13AT0JSphB2pfnsg0YS5NLfmA4XaoIVy0jcyXBb2KfeHWKACf8C+89fMfdGOm0o8NJKwes5zOqV430ormeHgIXcX72FduK+RWonhdj8OeHyNtlTh4Dz416puhMAxc9qEz9mvaCj2d8D1ZDtBz8v8QO8Eu13GPdx7S12Pw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo009.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A00E00B07399536; Mon, 3 Aug 2026 17:02:21 +0100
Message-ID: <4602838c-a08d-4a38-bc58-62b3c99ed59c@dronecode.org.uk>
Date: Mon, 3 Aug 2026 17:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exceptions: Fix AArch64 non-incyg signal handling
To: =?UTF-8?B?TcOhdMOpIERpbWFuZA==?= <mate.dimand@arm.com>
References: <3e05e02f-629a-42fa-947b-0e3f4dc2bdfe@arm.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <3e05e02f-629a-42fa-947b-0e3f4dc2bdfe@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 15/07/2026 14:22, Máté Dimand wrote:
> Hi everyone,
> 
> I have resolved the concerns raised by Jon Turney about nested signal 
> handling in the previous version by taking a different approach.

Thanks very much for taking another look at this.

Sorry about the delay in finding some time to look at it!


After raising the concern about the potential for nested signals, I was 
vaguely thinking "can't we stash the context on the stack in sigdelayed 
rather than having a single instance", so this implementation fits my 
prejudices. :)


I applied this, but I have a couple of follow up questions:

cygtls::sigdelayed_impl could probably be marked with 
__attribute__((noreturn))?

Elsewhere ([1], in the implementation of setcontext), the claim is made 
that RtlRestoreContext() can fail on synthetic contexts (meaning, not 
directly the result of RtlCaptureContext()).

Do you agree? Is there good reason to believe that the manipulations we 
perform on a context here are "safe"?

[1] https://cygwin.com/pipermail/cygwin-patches/2026q3/015206.html


Return-Path: <SRS0=bbDc=F4=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.240])
	by sourceware.org (Postfix) with ESMTP id 619724BA799A
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 14:04:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 619724BA799A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 619724BA799A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.240
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785765898; cv=none;
	b=tMWcMmgP7CqDued/CCz38Hz9lup1zwTnzSjT7RKpBwdE53mEW957XplQd9Hbwg3/kgRgKhgpBoTNI35b08Csz/tRPX3oxCFT3uUFUbUKPKw42IbDd2rQIBNqROUwiO41Tu6KmTSeD2Efrvg4PH40YOzVYBySQZC/uIII5O6RyfI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785765898; c=relaxed/simple;
	bh=VF5rfh1TkOBX+bkVzHjeBWTw7RL1N5GA2UJ2PZ8eIuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=sw39YthY2DHwIYHyoScG2lXJm22JrCs/ffA4sHwRsye6DnJcyb1XXYv2fv3u9qOm3XkPc1F2jfdgA224zzu41m1Wpj1x/s6PecXDG7aUzMcNRwzznz/OcF+rXYn5h7CT7H0ubOEo9dm8gkOIfgOsPIPGLc7ib8gykMoMk4Xb1Ho=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 619724BA799A
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A0252780727C1D4
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEFj6nJ8EcaQQogoMJ3erUhADl1tdFD0EJT7zrEOO/nVDNQh3Zx3xIRnFNcZ766poEfplDSkNZx5nw/YESEvzXNWZ6qDCTyVD2IJL18ILQGJhPXR8bP2570EAnmyd3Bw/pTm3lvBveJ8anNY4Tio2QtBkdLnb3BhPRu0ELi9wKTfCTd6lYMYh31XRh1Au/ooOjNs2osP5OAN3Ko80nTp2SRUuPVVnJTkrtHZDxjxqFJ2oHfWMDxlepEkqcX28XlrT7ye2toYxec/h92TyiMhkvKSKkMfmYjmmGFbYnKG7sXnofYi7mhPmU5Z4pXbuKycUmN7PnQrBEaQoatYpOKdO/qlaOMXPPcMzKepve5fXBaX8QFO8ciTvCIiZpHovp6rvxekJ9ABX1E9wZOmvFWICgAeGMaGjy/LqvZPnpvPgH4FCyTVilDdn6rlAWriebzk+oF0vjup3sOhsvmCOOVDwhLMpF6I3K+2F+FFjZG6mJnbXXMutq0jCEYcdhBiLs8+jG2tZZwWPPlMpsY2A0faYSKpXANHiQexz8jP98Px8orcxB4IxzM9pdS1UWqUeLIglgMj5cZW2M1nGKBA7KPxKN+oWWysKeT/oaGOl9db0x16sZs1nPfgNH+eWcpExj4sJC4gLqQ2KDoc/uEqTtxX0rOJgBC9hj2VF6OR5ZMMcO3Kg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A0252780727C1D4; Mon, 3 Aug 2026 15:04:56 +0100
Message-ID: <80f37fa3-a53f-4d62-8a04-34dfdb948475@dronecode.org.uk>
Date: Mon, 3 Aug 2026 15:04:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dumper: allow compiling with binutils 2.47
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.9.cygwin.1785235174913.gitgitgadget@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <pull.9.cygwin.1785235174913.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 28/07/2026 11:39, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In the latest version, binutils' BFD no longer declares a `bfd_boolean`,
> and the `bfd_record_phdr()` function accepts plain `bool` parameters
> instead.
> 
> Let's accommodate for that to avoid these build failures:

The obvious question I would ask is "does it still build with older 
bfd", to which the answer seems to be "yes".

So, applied. Thanks!

> 
>    .../winsup/utils/dumper.cc: In member function 'int dumper::prepare_core_dump()':
>    .../winsup/utils/dumper.cc:830:7: error: 'bfd_boolean' was not declared in this scope; did you mean 'boolean'?
>      830 |       bfd_boolean filehdr = 0;
>          |       ^~~~~~~~~~~
>          |       boolean
>    .../winsup/utils/dumper.cc:831:18: error: expected ';' before 'phdrs'
>      831 |       bfd_boolean phdrs = 0;
>          |                  ^~~~~~
>          |                  ;
>    [...]
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>      dumper: allow compiling with binutils 2.47
>      
[...]

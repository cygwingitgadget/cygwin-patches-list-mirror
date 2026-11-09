Return-Path: <SRS0=GRJh=I6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.127])
	by sourceware.org (Postfix) with ESMTP id 56ECC4BA2E26
	for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2026 17:42:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 56ECC4BA2E26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 56ECC4BA2E26
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.127
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794246171; cv=none;
	b=GTvbywePdo4y8MTIK4h4BM5DvagNUfN2j8p9WEhNi8FPY9s27W7xTSXXBY8f/2JQSsFa0wgMvUOq2R0edgmXz40UxV4VX/5042xrnRLTJlhSt8rBhk2h5mejggujlw1D+N7jgh9tRCNQbjGGqQi39HIu5GO4oVLogJkvOhXZB+4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794246171; c=relaxed/simple;
	bh=XGAY2WeC47DeGInydOMp8k58HOFNl9nfEclEdf11FmU=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=DiuU27o5DQc4JjFEHsv+UgYRmVJ3/sc4iCGSf43ngHm8qUQq8L+p8/7vxxIbagY7nuqCnlnaqqtdnLFdrk3k6mJj1kvamGseWqcgjK/mVXyimFrKx9eevBK8zcc1IPYNiY7uZOF+GEEx8XbBANTZkpuRyKNr0gIqBoPmx0dMkkQ=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 56ECC4BA2E26
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715D8114C6BD6F
X-Originating-IP: [80.176.81.8]
X-OWM-Source-IP: 80.176.81.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFY5KnYrgOURQDIY09rt0Z2zuF9r9FUNutJiodCSjRVpf0VmWxrHb+kbcVrRTH5zJ+yQVBXFnn0+qT/jKXaWbK1rbZALda4hi1nAfr96eqG6wMFnUE8NOtRNdRxcgctHaWpTf5HgozKhxCJEXELr6dFviUT88eW1wK9eZ4CeYV/U62PGDN1AViT5d32YeKEAwO1EF1zNT7Dd0G/kCMO0EakscdDWQS//y3z5liOUJmyTjr6GfahUKBzb3Fgh2XPiHQNNlY5CfPKHL+OiKXYzqkq9G1gr3TrWdvJzc+dZfGlVsQEwylvIZM/tcf+mMhUp8oT2zjlINQGnqRrJgm433TURMOA0stBWdgHBgvaGmhlnN/ljh597hprjfvH7vLIgsxxQT78sZLZQpo03f+nkCdEJhhg1GqqYxyElPgLdCxcc0DE8AU1R5xGxJpmfaMeuveo8k/59zXXRAJo4bxbHjr6U3XDy2HWrZ6ho3U6XQqWwIMc7yNJeoafn9CupVc4v151xucVj2asvPbQQG2Apubnj0hPDj96BL3qfw0Bz8Nnx//y6Om6CLQIqBVmyc6d5ClCdLM62BEbwkS4O3a8CMuT2AFiGcKQZxUfs10xWK84OqN/cNRy3hQLljqK0+F+FxfbpWdXj+8xctAm3dcSr0oisQM6JAHpBsDwf/w6ck2xCg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (80.176.81.8) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715D8114C6BD6F; Mon, 9 Nov 2026 17:42:49 +0000
Message-ID: <ea4baf13-8720-4125-b7b3-0d7f589f1162@dronecode.org.uk>
Date: Mon, 9 Nov 2026 17:42:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pthread_once: Use acquire semantics to load state
References: <40aee3ba-beea-48b2-8408-db28b9cc6770@maxrnd.com>
 <AS4PR02MB7902F8DEBCC6972D8C6BF34183672@AS4PR02MB7902.eurprd02.prod.outlook.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Luca Bacci <luca.bacci@outlook.com>
In-Reply-To: <AS4PR02MB7902F8DEBCC6972D8C6BF34183672@AS4PR02MB7902.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 20/10/2026 10:14, Luca Bacci wrote:
> Hello Mark,
> 
>> Thanks for the patch.  Is this to solve a particular error that you've
>> run into, or is it the result of code inspection?  Either is OK, but the
>> answer helps us decide what priority to give the report, and whether
>> more code needs to be audited to find similar issues.
> 
> This was found by visual inspection while reviewing the PThreads 
> implementation.
> 
I'm sorry, but I find this patch very difficult to evaluate.

At the moment the claim is "this is better", but the explanation as to 
how and why is very brief.

It doesn't sound like you've built and run it and verified the code 
still works as expected afterwards. Assuming that... uh, has it's downsides.

A microbenchmark that shows a performance improvement would be a 
convincing argument for this change.

At this level, maybe you could show the generated code before and after, 
and explain why the change is an improvement.


Return-Path: <SRS0=B3ed=IS=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.196])
	by sourceware.org (Postfix) with ESMTP id 9C6D54BA2E13
	for <cygwin-patches@cygwin.com>; Wed, 28 Oct 2026 12:39:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9C6D54BA2E13
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9C6D54BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.196
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793191160; cv=none;
	b=UvR6MZMSOwH4dYZjMV4eJMlvXp3zFOfL0nAUkrXD9lZb41JLuZhbpIEUMXOXoa8IC0rLQbhRW+jRXuS4ld/1FW1/+3nji7Bt0UlNb/8Euj96fQGqY92z7GLyp5uGnXhJC1dnrWbUIxe7HkLZwbys8eYru1cs2tKwifl/PhS6um0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793191160; c=relaxed/simple;
	bh=RcuWYBc6u6VXpBp9ZLfEamb8TDMGHqLtfe19UlOwAqI=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=T3+AQHh/fXBvpWx4mks2kK1AeXW200EHx3TF/IPmZevgQZdBexuK2Euo37zjzBjQJYITivTJgin4D/PQsBG1W9jKnn5JD9E7RAzOcnycjXt00xRLQ1NY9sbrGVGQVylN2+BiMEuZvGYFpSjsbEEYMQEUaOJp4EwZ3hl9SlgyfuI=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9C6D54BA2E13
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161CE1146B11F
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=spam score=230/300, class=phishing
X-RazorGate-Vade: dmFkZTGwW3cfDDAxnZZiSeSvhEmSCUS1Q6wpTsaXfsLCxHicHUGxYGSjO7zreJC4BOq5lgh1hUMcublh6IuAPBYHY5y2rp8omFQfH6aapUF1/tY0wn+oAqT9GH6XNJ7RSE4CYEd2JO1sf3rDiF54YAn4KQ4EVvX5w8QL3DEgC0gg3OuiaMRBsA5iEd+hHxpC4LXN3bkHyhmSgebBQtPif1Zve5NMM/YNHziaWCjbOv9OrdCKJMrWP2XPxZlrsjPp+fEvIRpNYV0PaQt5mHRiV4BqIZpg9Ud0DGqelwjZGf1lJgRPWibKDbnfHw8Wcaxybpn2aXnYDvY7bkDkk2NVVzukquI8tDNzYbK0omgF47Rzj6Qouw0XwKgQu7yLoHAO7e/dpUNr3IExM+n0Ren8R5CXhQv4wHXwTqczLQOtrQCJ3fmeu/NjOG3FIoMJ8Jz/dlXesxFdnLJRO0sL1/9LIdKgXZaehA6M0LRu+0kGu3khPzbg5yaeBUtJ/9DA2HmlWSoMBtlR2jtR9Vxf9lIv4cyLWlJ++YY/LRaXG6hXqDQU+i5kDWmCsrXiAb0vkAorIneCLhEir9QQkk9oVixNkZ+38DfDYHzBUDLSqA92uuA8+zD4lrjFI9sKj6lghMJn0kYsBPJNany1w8GZzwtbZhhLAi8fPXz94peZAT2049Jej/Qf/A
X-RazorGate-Vade-Verdict: spam 230
X-RazorGate-Vade-Classification: phishing
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161CE1146B11F; Wed, 28 Oct 2026 12:39:16 +0000
Message-ID: <58a2c092-09a0-4c61-944e-b29d5d27b257@dronecode.org.uk>
Date: Wed, 28 Oct 2026 12:39:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gendef: fix SEH directives in AArch64 sigdelayed
References: <9eed0ee5-428c-420a-9788-67d14368f3b1@arm.com>
 <69bf89b9-73dd-40eb-951f-356fbb7ff3d3@arm.com>
 <99c4757d-b886-411b-9887-464999d363a7@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Mate Dimand <Mate.Dimand@arm.com>,
 Evgeny Karpov <evgeny@kmaps.co>, Igor Podgainoi <Igor.Podgainoi@arm.com>
In-Reply-To: <99c4757d-b886-411b-9887-464999d363a7@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 27/09/2026 16:37, Jon Turney wrote:
> On 23/09/2026 10:56, Máté Dimand wrote:
>> The previously sent version of the patch used the wrong save_fplr
>> directive, sending the corrected version.
> 
> Applied the corrected version of the patch. Thanks.
> 
> (For patches which are straightforward fixes like this, at your option, 
> you may include a Fixes: line in the commentary, identifying the commit 
> which contains the original mistake)
> 
>> IMPORTANT NOTICE: The contents of this email and any attachments are 
>> confidential and may also be privileged. If you are not the intended 
>> recipient, please notify the sender immediately and do not disclose 
>> the contents to any other person, use it for any purpose, or store or 
>> copy the information in any medium. Thank you.
> 
> Sorry, this "notice" is invalidated by our existing disclaimer at [1].
> 
> But seriously, please avoid automatically appending such notices when 
> posting to a public mailing list, if possible.
> 
> [1] https://cygwin.com/lists.html#notes
  Actually, I shouldn't be so quick to joke. There is a somewhat serious 
issue here.

I don't see your name in winsup/CONTRIBUTORS, so I don't think we've had 
a statement about the licensing of your patches.

Can you please make a declaration about the licensing of this patch, as 
per [1]. Briefly:

1. To the extent that it is protectable, this (and all your other) patch 
submissions for Cygwin are licenced under the 2-clause BSD license.

2. If this material was produced under a "work-for-hire" contract, your 
employer has authorized that licencing.

Ideally, this statement would also cover any future contributions and/or 
contributions made by your colleagues Igor Podgainoi and Evgeny Karpov 
as well.)

Apologies for forcing this tedious nonsense on you. Thanks in advance.


[1] https://cygwin.com/contrib/dll.html#before_starting_legal

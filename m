Return-Path: <SRS0=e2Sx=HT=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.91])
	by sourceware.org (Postfix) with ESMTP id AD7814BA23C0
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 15:37:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AD7814BA23C0
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AD7814BA23C0
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.91
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790523475; cv=none;
	b=xOoReHceBfMpiXRphNsjjaSky9w2kZO5DcUk8FV6bYl7ANOh0Ng3gWM2IgMc61HbkO03klTXlWjb2QVHlKa1PJh/ia9AcaXtk1m+mTbO0ngYq1q+aGO683rXbcx6f3AfRN5nhYWIypOKSrQET13FkdDHWUpViJoryaOVAIQii9A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790523475; c=relaxed/simple;
	bh=NXCR62lkBpG6Ln+2tDdyan78HIaD02lGb48ahLv0SmA=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=i0wSUsY7pI020Tb81wemwYRVSrZW2guU5ManCM2JF7SrHS5koU/esXJwhe3zYjlOMAdZyQc/kk+0AiDb6ZFbjyYh37dc/O0cQlOhu4mXoAs76QaqJpmyKOX2WN1kr5+RMqyqM1iB9G0iZzVMhxTFO4yno+LVXVdQhvoVA9Gswgg=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AD7814BA23C0
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7159F40A77510B
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=spam score=230/300, class=phishing
X-RazorGate-Vade: dmFkZTGMHI6T3H5FmePY+oBsmjl4n1U46IxnZC9z+HFsZdYyZ/+e3kPPYzFKp7X469vnF+Qd+RrCvldQ+xlurnwzi0PQtGqvMCsvml9xtnNFizd8oR+bDqzrEVcrp9uu4unXvs+Q0+NknCSaZV6x1TW3pYxvblErgOnCbYXUTbK4iTXVJhEa+5fe9aeQmkujbeakt9JFNFHTgAGf741OwHd88btC06orIT+zvmOusuCngZ7qiB33/nwamrsQ0Ud3+7vMMv/WXq4lcZPo+EbiktWlNHnHmy/7TMaxJZVSsndXm39f3aCGaQTrcv5etKGldyr3JDNFxEIS9qdJZRARggG+PIClaep72C0uoRQng1nnyr/ukNQ/2yaXaYD8Q4WKRZYVwzFl00u0VDw37TW9V6f9uHB1lWk4Sl/aEUXQcIVUlx3Bbc+UeXRVFAcprcgko9nkz4ddxmokx2b4lfEhUbzjBXiKeSYV0R5UgFZzN6TzL8fkZjOk1Cw2AMh82gQBhgmxpt3V81MWc+u2cYVO/fwqg5wiO8nu/4ZvQjMVsRipk2daUXSpPePNdB3yGIGQFfq5p60HYsqymM3Et0C8xAv+T6T/R2J6JdUzMkSCwElQTqXsNTh3cszfJhL8/sivYTZbv79ykhEGDzWOHuuNpO10BaJqlFLheFPaUhqSfUFwVlBeeQ
X-RazorGate-Vade-Verdict: spam 230
X-RazorGate-Vade-Classification: phishing
Received: from [192.168.1.109] (62.56.83.178) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7159F40A77510B; Sun, 27 Sep 2026 16:37:52 +0100
Message-ID: <99c4757d-b886-411b-9887-464999d363a7@dronecode.org.uk>
Date: Sun, 27 Sep 2026 16:37:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gendef: fix SEH directives in AArch64 sigdelayed
References: <9eed0ee5-428c-420a-9788-67d14368f3b1@arm.com>
 <69bf89b9-73dd-40eb-951f-356fbb7ff3d3@arm.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Mate Dimand <Mate.Dimand@arm.com>
In-Reply-To: <69bf89b9-73dd-40eb-951f-356fbb7ff3d3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 23/09/2026 10:56, Máté Dimand wrote:
> The previously sent version of the patch used the wrong save_fplr
> directive, sending the corrected version.

Applied the corrected version of the patch. Thanks.

(For patches which are straightforward fixes like this, at your option, 
you may include a Fixes: line in the commentary, identifying the commit 
which contains the original mistake)

> IMPORTANT NOTICE: The contents of this email and any attachments are 
> confidential and may also be privileged. If you are not the intended 
> recipient, please notify the sender immediately and do not disclose the 
> contents to any other person, use it for any purpose, or store or copy 
> the information in any medium. Thank you.

Sorry, this "notice" is invalidated by our existing disclaimer at [1].

But seriously, please avoid automatically appending such notices when 
posting to a public mailing list, if possible.

[1] https://cygwin.com/lists.html#notes


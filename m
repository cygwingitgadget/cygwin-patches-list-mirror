Return-Path: <SRS0=gQMU=E3=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.6])
	by sourceware.org (Postfix) with ESMTP id DDFB74BA2E0E
	for <cygwin-patches@cygwin.com>; Wed,  1 Jul 2026 12:51:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DDFB74BA2E0E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DDFB74BA2E0E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.6
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782910284; cv=none;
	b=IBV08Q39Shk/XIadDqM5IklLYPnpxCNlDMHOZdY6RIVhm1f88R1ShTGT6L+F6J5LzKioaSHF+VxTNgMciwbVb2TxG9yiA1T3OUOmazUVMh3ALWYHeFqmgVvqpJgBT/+gjpAaH/V0/etdDGlOyPGDWgRiHA1aTXnux3MOEUhIDjI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782910284; c=relaxed/simple;
	bh=VwhUu74PIKxRQuASDqF3JuaBv0JfX9WBIKrY8hF2eT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=ETOubzC1oT2fhd2GW+JsJQc1zZgXBFCgqS4mEycA3Ic57gFnBjvJbf7hLKR7CbrXJDPIhwXpCdViAceqMNReUUkLrKdWITrlaLSxRAotdEzPmcyEfmfQhoTTDPKRSTHS3H9o8QqZ0uJJFDzHmpeUx1AwaJf4fkTAcNzNRSj8vhA=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DDFB74BA2E0E
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69E784C505CC459E
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEYVk60UCHOjnMuAE1neW29e4YUpQVt1uqDF149O3xOqEPB5gyby4uGHtFrroZ2FOnKjjgf6RJZlp38Q7+SQ04GxsW6ywS1nVfy9Tr/D+9pwxi/jaxi9IH2jgkDUkJFigNC9R4yLrhfPs1ng8/0N3Wcz8L1eRl4utP5h55+E/8/GyqSqvGXJlm8ncXay1xLQac++pOug3ugdpz8AwKaHM80gy1N+eF7w6A6xBLIBkK9fFXxmTNlcW0bSU2Y04kbxWsVpdatQIfv5ZpxortNgDfvKgCy/4oAEmf/N+5r/JJGgYJj6Y81+6YgULMv+u+3FtXIMgTtC3s+v9SqAUYdTBIdZiOKcMk0RR5SuXwJkteqaa/mAVYLUve1QWk1GsNiiGJcWqWf3+ugYuZmwtJmb58Mwbp7kWVcvdvVUQienc1cgyFL37fH8e88oHJzg1SEJjgPH5eLnbDBNPDqzioIUX3dOYLDrbG1U5HWPY78r6R7Yn92lhXr1X8WB8CvoN5TgVhnCLlsTh63oSVZy3oHxFYCNEFc0+fg8N6TEuIyiiFz+Jy9aSSTnNoLZrNhJCI5Cqu8vfxfxZgGKZZy7NofRIR5jmI1B3JsfiLbWwjZibfNgNzGr20T2xGahorQMz7GapeFl2P19akS3bSZg1Ahq/Csnl7WO02B9sFPjJKjufUbpQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E784C505CC459E; Wed, 1 Jul 2026 13:51:16 +0100
Message-ID: <259c44dc-9e05-4549-9768-e91c7fc8ca3f@dronecode.org.uk>
Date: Wed, 1 Jul 2026 13:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: autoload: fix ws2_32 chained init on AArch64
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
References: <PN0P287MB0295342E2109C2CB8EECCE6B92062@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <ag8IvAkqoNVM-AH2@arm.com>
 <PN0P287MB02951A11C49A1208A9BA66F392102@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <99590c72-bc88-4466-95c2-ae540a11c031@dronecode.org.uk>
 <PN0P287MB0295EC86F97A259F0C99818F92EB2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN0P287MB0295EC86F97A259F0C99818F92EB2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 26/06/2026 10:03, Chandru Kumaresan wrote:
[...]
> 
>> * Looking at the git history, the comment on the problem the
>> no_resolve_on_fork flag is working around has disappeared, but the
>> functionality is still there.  Is it still needed?
> 
> The no_resolve_on_fork removal addresses your question about whether
> that flag is still needed -- it was always 0 at every call site, so
> the patch drops it entirely.

Hmmm. Are you sure? It looks to me like it's non-zero in all the 
existing winmm uses.


Anyhow, the "fix ws2_32 chained init on AArch64" part of this looks 
reasonable and doesn't seem to be connected. Can you submit that as a 
separate patch?

Thanks.


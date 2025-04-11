Return-Path: <SRS0=4E8T=W5=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
	by sourceware.org (Postfix) with ESMTPS id C92A2385840F
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 16:08:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C92A2385840F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C92A2385840F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.81
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744387739; cv=none;
	b=HvBXfZKl2mYZSVZ8pHcOUuromJm9M+fNC8WM+5x7QA+hMeObD0i/nsFNZ5NHnN1pCFHbeqWhAYhrfo1+8ZofmEQWlZyjxW5XttLWPukiJ/ph804PlS6gYg1Aee4X86fNcZf1qVUMFdODS1dQMfrrgqF1HEVRhf7lfZL8dAiCF/k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744387739; c=relaxed/simple;
	bh=G1NcvYN9Fq8zwFJXvqW5hSlb4YI6Qke6wHTaELb3AO8=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=mPH+h/hnmuwu3bnCsbbXs9N9g52I1ShdV/KB0iFZsJ+9opzY37bul1InMlbywsH2dibu4pHeY6WBDqn3lRntUbCyJYV+MAqVO9ewxrabY5g8gN09I05GxJGx845sR75KVpeh2zCh3oA6aViZRBR1JIH7Sd+QfQtIyg4NiDGUSOY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C92A2385840F
Received: from fwd70.aul.t-online.de (fwd70.aul.t-online.de [10.223.144.96])
	by mailout03.t-online.de (Postfix) with SMTP id 3117C650
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 18:08:56 +0200 (CEST)
Received: from [192.168.2.101] ([87.187.37.162]) by fwd70.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u3Gw0-3D2vui0; Fri, 11 Apr 2025 18:08:53 +0200
Subject: Re: [PATCH 3/4] Cygwin: CI: Make stress test terser
To: cygwin-patches@cygwin.com, cygwin-patches@cygwin.com
References: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
 <20250411130846.3355-4-jon.turney@dronecode.org.uk>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <a4ea9b93-222e-f679-48bb-c8459bd797f8@t-online.de>
Date: Fri, 11 Apr 2025 18:08:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <20250411130846.3355-4-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1744387733-C27EEE43-8584A41F/0/0 CLEAN NORMAL
X-TOI-MSGID: 1c57d402-4c2c-4039-8341-b08637c2cf81
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney wrote:
> Don't echo the command being run

OK, but this breaks -n option which is occasionally useful, see below.

> Capture stress-ng output to file
> Only show test output if it fails
>
> Capture all test output in an artifact

Are messages cygwin prints itself also captured? See below.


> ---
>   .github/workflows/cygwin.yml      | 10 ++++++++++
>   winsup/testsuite/stress/cygstress | 13 ++++++++-----
>   2 files changed, 18 insertions(+), 5 deletions(-)
>
> ...
>   
>   
> -  echo '$' "${cmd[@]}"
>     ! $dryrun || return 0

Possibly better:

if $dryrun; then
   echo '$' "${cmd[@]}"
   return 0
fi


>     (
> @@ -520,7 +523,7 @@ stress()
>   
>     mkdir "$td"
>     local rc=0
> -  "${cmd[@]}" || rc=$?
> +  "${cmd[@]}" >/dev/null || rc=$?

Redirect stderr to capture Cygwin's "panic" messages ?


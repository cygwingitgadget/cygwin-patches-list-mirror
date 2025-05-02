Return-Path: <SRS0=OYBk=XS=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id 2D5A53858410
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 13:44:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2D5A53858410
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2D5A53858410
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746193475; cv=none;
	b=b0OQMVa27Va7UpZx4cWiNeBlSE7A3isLEraFEWoNkt60WVDFlrl2A3FlRjjaAEJq+lVVBsJsPjETGBgRBHpxdKUGiWqPlBLbVdcYBqaa18gJP0m9Rl7c96OPSsiA6zVqiam0/pTV//wREvYjbViFzC2RmXxxIalv9cEeUxiQOks=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746193475; c=relaxed/simple;
	bh=TUh4KHzh2sI1VfbYJXC57zkbQn0cqPVkbK85sOz6Zcc=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=H3DBeat7xfgxsG1A453iYGJLcMXLxP7w7Vj7mARGkUCxekKJwD2rEHwzRDfYuWIHYofzbgKgCbMX/BsLSpgWh+xAnVfji4Ln8PuFqNCF7rQ1m0cAjmMPOecnQjzy9930akvsBN16evy4omPhjfOUuPDC+0hQvpasCwYKrVgm9hE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2D5A53858410
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
	by mailout10.t-online.de (Postfix) with SMTP id 87804E67
	for <cygwin-patches@cygwin.com>; Fri,  2 May 2025 15:44:33 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd89.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uAqgp-0SKJN20; Fri, 2 May 2025 15:44:32 +0200
Subject: Re: [PATCH] Cygwin: CI: cygstress: improve error handling and add
 verbose mode
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <e739cc90-e0cb-672b-8cd2-2ad77b09be32@t-online.de>
Message-ID: <7d7e216d-9012-c9ef-737e-55d8932a87dd@t-online.de>
Date: Fri, 2 May 2025 15:44:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <e739cc90-e0cb-672b-8cd2-2ad77b09be32@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1746193472-D6FFA9D9-8530FF69/0/0 CLEAN NORMAL
X-TOI-MSGID: f8ee82fd-db9c-46f1-b5ac-7a44f4ca8322
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Christian Franke wrote:
>  A followup to:
> https://sourceware.org/pipermail/cygwin-patches/2025q2/013674.html
>

>  From b0a5ba548cc9041246b1d6396d16292c77399605 Mon Sep 17 00:00:00 2001
> From: Christian Franke<christian.franke@t-online.de>
> Date: Mon, 28 Apr 2025 14:32:34 +0200
> Subject: [PATCH] Cygwin: CI: cygstress: improve error handling and add verbose
>   mode
>
> Check for unexpected output (Cygwin error messages).  Combine multiple
> error findings into one FAILURE line per test.  Avoid a race in the
> watchdog process.  Print all outputs if the new -v option is used.

Pushed.


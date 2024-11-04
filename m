Return-Path: <SRS0=Dk67=R7=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	by sourceware.org (Postfix) with ESMTPS id A28163858D38
	for <cygwin-patches@cygwin.com>; Mon,  4 Nov 2024 11:50:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A28163858D38
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A28163858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730721009; cv=none;
	b=N9BHUrKn7IqdPznSjMgl5sONqpEuKwlI0NSVuhbt4fyCvNcmehs3XUPaQSkSxKFHAB/snCpU4VtV3y9PwOzV9f4EAoaaXQjWXL9LFgNuIMHRcgZqd1IYOMi8iSEMuScQP4pLrXys5MJxiBexrzEh2kMtr3u8wTYRL0n9KJevclM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730721009; c=relaxed/simple;
	bh=vUylzWjgoT76AjRv1bsfWZJFtqqv004ZVwIA64/t588=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=YtP8Fdsz4T5T0H87SoArAiquO5pE/cNFO0gvquwdYkG8UiQhqMdfcpGZYPrWUmo4U7hvS1luXCiHTUu+xQv3RCOXDepwL+CDJZFR5+nb+2kISih8ck8b2JINZjhPndL43GyapbUqDRuroIuOmit739YNJgSAik5vS1C6Z0yN6YQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
	by mailout04.t-online.de (Postfix) with SMTP id 7753CBE5
	for <cygwin-patches@cygwin.com>; Mon,  4 Nov 2024 12:50:03 +0100 (CET)
Received: from [192.168.2.101] ([79.230.175.122]) by fwd85.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1t7vas-0Y2lPc0; Mon, 4 Nov 2024 12:50:02 +0100
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
 <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
 <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
 <ZyiinKXESiXU4AvU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <683a0e8b-9a8c-4729-0594-353ff5e04ac6@t-online.de>
Date: Mon, 4 Nov 2024 12:50:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.18.2
MIME-Version: 1.0
In-Reply-To: <ZyiinKXESiXU4AvU@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1730721002-51FF940D-F43B586D/0/0 CLEAN NORMAL
X-TOI-MSGID: 242ccedb-0b7a-4fd5-b98d-ea4688adeabd
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> ...
>> - Invent a #define that allows to use the old function.
> We don't need this.  We only want backward compat to keep existing
> executables running.  So we need The old and wrong pthread_sigqueue only
> as exported symbol.  On recompiling the affected project, the bug
> hopefully shows up and can be easily fixed.

Providing such a feature (only) for a few upcoming Cygwin releases would 
allow maintainers (e.g. me maintaining stress-ng) to easily provide 
packages which are backward compatible with still available [prev] 
versions of the DLL.

-- 
Regards,
Christian


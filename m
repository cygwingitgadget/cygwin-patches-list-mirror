Return-Path: <SRS0=TxHU=UF=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id B57B53858D38
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 19:09:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B57B53858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B57B53858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736795357; cv=none;
	b=Hl+bRHozk9vWBQI9yX+812zuy3LUhf4DyrfJfW9yJ8LDlT7Wk6QZRnz0/NQ7OLr8+KsVsXe/6Arhitq3HV5nc7DwLUBdGfyFWezlNi2dutZQawY/rZXlJdbYgr5K+oK4lGOH1Ozf9KIIMFefPPGJ/TYB3tyGUxqSkiksh9oH2H8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736795357; c=relaxed/simple;
	bh=nW7knmgXJJT6g8oEOe0mF1T9UksQ2MMbUsZQPxXqxyY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=no3qoqYb7IAiLjl8RD2GV0AQl7SyqCdeCIqt2vOdjQ/cLKcuY5qksdCyHGS8KAnKEzeaexCsPifjzpB0WjQtAPtpCwCiCVYzOvB5/OM0rG8810mzZeSalnTqTQKXSsLxf+HkKVYTmHBCp5g99KG+8ReNv8UQz9roWmZ1Q4eHGEE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B57B53858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=TUT3vfsm
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 32B291C5E7C
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 19:09:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf18.hostedemail.com (Postfix) with ESMTPA id C398431
	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2025 19:09:15 +0000 (UTC)
Message-ID: <4b6d18cf-5f39-4576-b233-be3635eb8b0d@SystematicSW.ab.ca>
Date: Mon, 13 Jan 2025 12:09:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 8/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 abbrev variants of base function
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <6f43c54d894bc7b6e2a75596cf07d47ffb881d51.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4UXksHySN12NP1H@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z4UXksHySN12NP1H@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: wrcw7g8hh7hur46kpoaz35bggbe9r5n7
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: C398431
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19DESY/BhcBHKgCJ6Somxdp/IWycE1gQ+8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=jK1Q6zxBAVHr0X0k/BZqRhRb6WNOCfYICfz8z0OjIaI=; b=TUT3vfsmq6WyW620/inRbaVDoJVumR86fG0nnw1gW2CnVAhAqU9NMViFWr8KIgWQszv5WjW5CH0CU0LnOuBdD54LylSJ8BmT4LF/4ZiPsFtc32UgJLnf4TmXOZyWuI2gK9Kf7lA+bIgXAl0zwaG8mQSoXfIsltHVvQjmQnYqKKH+DDh5fVQAZ94AUino/KlBsPoiv+XxdasANVFgdd8bIERsjfQRfNl9MIRdziUddp5eFWuj4yVvXbBdNoWZmayI+mEEXAPKipomznfvXfsad1onx3ENhClABDsfTbMrIwlYjFumTM4r4l2IdeVXPc//rhlEQWwEeZ9S6YUAQpYD1w==
X-HE-Tag: 1736795355-482394
X-HE-Meta: U2FsdGVkX18igabTRDjcvVfgkP/ws28xim4Z8CKwF1b7XzZ3Q01LlP/cKLX+6/snZCoZ/HC6uInsRT//2Qxbfq+zk9euJmvMps5MHji7G4vnWSK2sUwRzUM0Tvq7zPI0EokPKmGIVJ2HYsEJGXdKiO3rENKt5j3eJsv2fX48yTjpMFkxoXP+b9b5y3NfqQrxs72GxAs5aLrTGwwKXxHxWvUiiEW/bj7ZS7qEVYVTRWJx9cbYASJPwDBFlx7sgWHdS0tUyK4QOwh03Rhdfe0sRIdj3i87qAIw1CTTY2mCV9uyaT4U3Qx3FsaKp4NaBpJWO7uNkrT7D8fD4066CZXvbFK6dyvVvp1e
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-13 06:39, Corinna Vinschen wrote:
> On Jan 10 17:01, Brian Inglis wrote:
>> Abbreviate circular F/Ff/Fl and similar function variants to /f/l dropping base name.
> 
> No, please no.  Abbreviating in this manner breaks searches too easily.

No problem - shorter representation - just ignore - why this is separate!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

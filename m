Return-Path: <SRS0=t6WS=SB=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 1F3D63858D21
	for <cygwin-patches@cygwin.com>; Wed,  6 Nov 2024 06:55:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1F3D63858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1F3D63858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730876143; cv=none;
	b=q6EO+Lp+bKmFe2rEltToHMYW4E+ebjAi5xyEPlq10hPdhBTOhdSIZHVu6zzqAV8XhgcylgWyRT6biPtVAqv1Jm/wJunYdOLeAjXCIE01JPYK1Ek9nxusXZGYOkJequKc46NL8jgn5+Vloj017LRHp+DfWLZuKdWvEB1NIIWczNE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730876143; c=relaxed/simple;
	bh=jqJSosCms5t+1/07ixmEV6lKPUVMOj4cTsqzlabqtxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=eG3j4wO+47qX1/OmMzqZBDXBZmyEPrGsB3QkWSEj4lHEmkLc1OEjmMYG4hJbY8ig9WTaxxxNbHGHBSYIFmEBFBP3SIMHAbEqpEGRnRdeErtzA+hi7tGB1gwS1Rc6j++FsaO/mFeqVjAud64++rM7QHdH/PyjlweHZ7L3/sR6DX0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4A66wniJ072765
	for <cygwin-patches@cygwin.com>; Tue, 5 Nov 2024 22:58:49 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdQKPcUh; Tue Nov  5 22:58:46 2024
Message-ID: <f52409db-6efe-4941-b90b-6323a3e3cd61@maxrnd.com>
Date: Tue, 5 Nov 2024 22:55:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
 <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
 <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
 <ZyiinKXESiXU4AvU@calimero.vinschen.de>
 <683a0e8b-9a8c-4729-0594-353ff5e04ac6@t-online.de>
 <ZyjbgeaHuJEZmP3m@calimero.vinschen.de>
 <ZyjfC6-UiQDuYwoH@calimero.vinschen.de>
 <bf4fbc09-f47d-61a9-3eaf-eaa6eef12197@t-online.de>
 <ZyoPuEidrxii1aN7@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <ZyoPuEidrxii1aN7@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/5/2024 4:29 AM, Corinna Vinschen wrote:
> On Nov  5 12:37, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> I guess if it's only part of the 3.5 backport, it's ok.
>>
>> A closer look might suggests that there are no use cases for packages in the
>> Cygwin distro:
>>
>> I did a quick check unpacking all *.dll *.exe *.so (with --backup=t) files
>> (~20GiB) from all x86_64/release/**tar* files from a local Cygwin mirror. An
>> 'objdump -p' on each file (total 24Gib) lists pthread_sigqueue only for the
>> various cygwin1.dll releases. Even the stress-ng package I maintain isn't
>> affected because the related stress test is guarded with #ifndef __CYGWIN__.
> 
> Thanks for pointing this out!

+1 super useful info

> 
> Then we should probably just make the plunge, fix the buggy
> pthread_sigqueue and be done with it, as in Mark's v2, just with
> the discussed changes (and a new entry for release/3.5.5).
> 
> Maybe you can enable the ifndef'ed out test with this change...
> 
> Mark, are you going to prepare a v3?

Will do, in the next day or two.

.mark

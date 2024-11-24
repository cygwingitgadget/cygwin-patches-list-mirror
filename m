Return-Path: <SRS0=oguS=ST=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 045703858D29
	for <cygwin-patches@cygwin.com>; Sun, 24 Nov 2024 09:48:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 045703858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 045703858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732441712; cv=none;
	b=AGL1F0fEiktt8ijmXI0R0hON79U+adVbbtvLRXRCEzPrZhICmYyRLR2oD9zmQed6N2nZA+taEzDf9a8OOB4lYwH9Zq/ZOnPKa9nTZoga86Q2HB5O2X2uPLVLnuaS5GHKSsqZXSgiqVu8s3a5/ij6MMNUBdIScnmWUyzURz2RRi0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732441712; c=relaxed/simple;
	bh=GRN2BzhP47WC5E5aoEp7MgC+2trlYmIPB8hJmSC+Xxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=jYpxv7dunKOi1RGARqHgV6otLD8R/esL9GI9xdaXudR+10T/88yqH6F2Y+8CES7S911/hNXSJG3sk/6Fp1iERVcRAWBr6l70pwhAl34EY78TIJzzqESDyDi1u/eU6XAWdIVv201mGUoVFNu3hZkR+eMr/2ykM0sLuFcDyppbzpU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 045703858D29
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4AO9pQMS029217
	for <cygwin-patches@cygwin.com>; Sun, 24 Nov 2024 01:51:26 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdjxOlCv; Sun Nov 24 01:51:24 2024
Message-ID: <2410821a-17e0-4436-89d6-3b0e15ad790d@maxrnd.com>
Date: Sun, 24 Nov 2024 01:48:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: New tool loadavg to maintain load averages
To: cygwin-patches@cygwin.com
References: <20241113062152.2225-1-mark@maxrnd.com>
 <3987e096-9510-4fc0-8121-ca32773c09e4@dronecode.org.uk>
 <ZzxXmgVc3aAkfJVJ@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <ZzxXmgVc3aAkfJVJ@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/19/2024 1:17 AM, Corinna Vinschen wrote:
> On Nov 18 20:58, Jon Turney wrote:
>> On 13/11/2024 06:21, Mark Geisert wrote:
>>> This program provides an up-to-the-moment load average measurement.  The
>>> user can take 1 sample, or obtain the average of N samples by number or
>>
>> Sorry about the inordinate time it's take for me to look at this.
>>
>>
>> So, this seems like two separate things shoved together
>>
>> * A daemon which calls getloadavg() every 5 seconds
>> * A tool which exercises the loadavg estimation code
>>
>> Does it really make sense to bundle them together?
> 
> The other question then is, why not just make it a standalone package?
> As a Cywin-only package it could go into its own git repo under
> https://sourceware.org/cygwin-apps/

I'm amenable to Corinna's proposal.

..mark

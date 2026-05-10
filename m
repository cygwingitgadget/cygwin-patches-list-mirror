Return-Path: <SRS0=ktEJ=DH=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 19A784BA23C3
	for <cygwin-patches@cygwin.com>; Sun, 10 May 2026 21:43:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 19A784BA23C3
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 19A784BA23C3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778449409; cv=none;
	b=Vz5l+Zp2wnpHdIdBbZ2noofgfOcQDJuvl/LXh+j0QUWcT270pdksWoVImD/K0W1VjOUPiIyijQmM3gJ1ocGd2TqifD4zcEtdXk5f7DZuqwC20O4alKqXEG/p9qHxYBnynWg1j8I0IJOUtT8o9dL+tX1HuRGXTHsS9ydhDVezkNw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778449409; c=relaxed/simple;
	bh=aIL1PdapVolh2ETb3RwxQpWcNBBvR0z9Wybs5e8icSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=rqRwyhiUM8QXUD+HgLKFEs06XpEfs4I/A0FqAex1VlW0lbngSKLt8h5dDg9RJOtm7UNR3GKToSV3SDENt6+EgavpyUEjHeskwP7Sd4Caq7xKcfuPHjk+1INAnuM5OQlRnRol1+UB7Y3WfbQ1ovIZYtUZU/Zu+4zz3zX2qOl9Stk=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 19A784BA23C3
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 64ALx1PA060395
	for <cygwin-patches@cygwin.com>; Sun, 10 May 2026 14:59:01 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpda4bPQv; Sun May 10 14:58:56 2026
Message-ID: <6936c6b8-9037-4037-862e-f7b2f56bbdcd@maxrnd.com>
Date: Sun, 10 May 2026 14:43:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Ensure unused handle available for open()
To: cygwin-patches@cygwin.com
References: <20260510073511.1346-1-mark@maxrnd.com>
 <23346.054756415$1778426898@news.gmane.org>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <23346.054756415$1778426898@news.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 5/10/2026 8:27 AM, ASSI via Cygwin-patches wrote:
> Mark Geisert writes:
>> The existing logic for open() assumes a handle is always available in
>> the fdtable for a created file.  This leads to a situation where, if
>> there is no handle available, the file is created but cannot be
>> referenced by a Cygwin fd.
> 
> That looks like race to me… if it need to ensure there is a handle, it
> needs to reserve / create one right then and there and then use it for
> the created file (and clean it up if the file can't get created due to
> other errors.

True, that.  I was swayed by a "but what are the odds?" argument. I will 
cogitate more deeply for a v2 patch; all racy logic must be avoided.
Thanks,

..mark

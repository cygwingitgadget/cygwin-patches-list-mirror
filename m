Return-Path: <SRS0=M9OL=DZ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id BA4D84BAE7FA
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 04:51:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BA4D84BAE7FA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BA4D84BAE7FA
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779943909; cv=none;
	b=OKcWsOj7p2HTxaqi5x8EXoWQ72Y5y3PRjIeYCKbKRUjlLl7eDu9uoOJ9QbsqhjRzupLyQAuM5iIV7Mrt+/ereBahd6dz/+msnt68Pp/ztk3gI3j4rFKYSZ7R4kyAHkp2Rw1u3M/wdr4lO8YsUF7Nb1JD/gIY1Nm+SaLDf+usHEM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779943909; c=relaxed/simple;
	bh=vvD0mqOGJHrY1msQ2kLevMc47FPpJ90rvS4PIyhO6IQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To; b=FbmyWLnLakQFclUUx2YPmnfWw7ihkbNFn7P5WuTYpl3ZWiohq0g7qvHqw2awon58EvUtYV3ab5WEYyIAJk9br7sOYBmaWEsckp1pBWTdM/xPBoH64uPL3KOWX8yan0/1Bqzf5IpiwYeXKYiZVUWj8Gc5ixRb8dz1MtqC30RZKbM=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA4D84BAE7FA
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 64S579cw022174
	for <cygwin-patches@cygwin.com>; Wed, 27 May 2026 22:07:09 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdwhexVM; Wed May 27 22:06:59 2026
Message-ID: <9bd8956c-7b08-4ab8-b9d2-e08d150f80ae@maxrnd.com>
Date: Wed, 27 May 2026 21:51:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] Cygwin: Implement 'reserved' marker in fdtable entries --
 withdrawn
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260522072913.574-1-mark@maxrnd.com>
 <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
 <d457a7fd-1eee-0dd0-b2f7-d46b84eeaa42@t-online.de>
 <ffa9dedb-810e-4e45-a7f9-e50dbb3a1e72@maxrnd.com>
Content-Language: en-US
In-Reply-To: <ffa9dedb-810e-4e45-a7f9-e50dbb3a1e72@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch is withdrawn because it mostly duplicates code already 
present in cygheap.h in a more fragile way.  And so it goes.

..mark

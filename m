Return-Path: <SRS0=gc88=CV=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id F0DD13858D28
	for <cygwin-patches@cygwin.com>; Mon,  3 Jul 2023 06:15:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F0DD13858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 3636H5c0046297
	for <cygwin-patches@cygwin.com>; Sun, 2 Jul 2023 23:17:05 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpdYGijza; Sun Jul  2 23:16:57 2023
Subject: Re: [PATCH v2] Cygwin: Fix type mismatch on sys/cpuset.h
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
References: <20230314085601.18635-1-mark@maxrnd.com>
 <1cf85bfc-9865-e4f7-5c2e-5acc89c3e77f@dronecode.org.uk>
 <8a69d717-64a0-dd79-77b1-7c95947b45ab@Shaw.ca>
 <38806d85-1afe-1218-0e9c-f641ca4c1a86@maxrnd.com>
Message-ID: <1e73e180-6484-2ba2-1838-8cccb185a501@maxrnd.com>
Date: Sun, 2 Jul 2023 23:15:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <38806d85-1afe-1218-0e9c-f641ca4c1a86@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mark Geisert wrote:
[...]
> Thanks for the report and investigations.  I'll address this shortly.

A candidate patch for 3.4.7 is incoming.  If it passes muster I'll fire off a 
patch for 3.3.6.  I don't know why I'm using military terminology.  Independence 
Day soon in the US, I guess.
Cheers,

..mark

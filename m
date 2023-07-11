Return-Path: <SRS0=jS4C=C5=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 5EF6E3858C62
	for <cygwin-patches@cygwin.com>; Tue, 11 Jul 2023 08:04:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5EF6E3858C62
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: from localhost (mark@localhost)
	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 36B85ZRj080731
	for <cygwin-patches@cygwin.com>; Tue, 11 Jul 2023 01:05:37 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Tue, 11 Jul 2023 01:05:35 -0700 (PDT)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: Where should relnote updates for Cygwin DLL patches be going?
Message-ID: <Pine.BSF.4.63.2307110101090.79963@m0.truegem.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

AIUI for cygwin-3_4-branch they currently go to release/3.4.8.
For the main|master branch they currently go where?
I hope to get it right the first time ;-).
Thank you,

..mark

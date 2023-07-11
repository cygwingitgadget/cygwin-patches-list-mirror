Return-Path: <SRS0=jS4C=C5=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 160033858D20
	for <cygwin-patches@cygwin.com>; Tue, 11 Jul 2023 08:49:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 160033858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 36B8oci6086699
	for <cygwin-patches@cygwin.com>; Tue, 11 Jul 2023 01:50:38 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpdhIWngF; Tue Jul 11 01:50:32 2023
Subject: Re: Where should relnote updates for Cygwin DLL patches be going?
To: cygwin-patches@cygwin.com
References: <Pine.BSF.4.63.2307110101090.79963@m0.truegem.net>
 <ZK0Q/o0zIKHWCJtK@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <29a23afe-7b8f-bee9-a18f-ccf6e8a66991@maxrnd.com>
Date: Tue, 11 Jul 2023 01:49:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <ZK0Q/o0zIKHWCJtK@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Corinna Vinschen wrote:
> On Jul 11 01:05, Mark Geisert wrote:
>> AIUI for cygwin-3_4-branch they currently go to release/3.4.8.
>> For the main|master branch they currently go where?
> 
> release/3.5.0
> 
> An entry there is only necessary if it doesn't get picked for 3.4
> anyway.

Ah, that helps me understand.

>> I hope to get it right the first time ;-).
> 
> Is the release model confusing?  If so, can you explain why?

I think I haven't been paying close enough attention and have been doing the 
relnote updates by rote.  But there being two active branches and I 
(understandably) don't determine which releases my commits go to means I should 
wait until they show up on the cvs-patches list, then I will know which relnote 
files to update.  That should work OK, right?

Is it preferred that relnote updates should be separate patches from the code updates?
Thanks,

..mark

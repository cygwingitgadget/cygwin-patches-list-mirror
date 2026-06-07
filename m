Return-Path: <SRS0=Q3Gq=ED=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 60EBB4C318B2
	for <cygwin-patches@cygwin.com>; Sun,  7 Jun 2026 22:55:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 60EBB4C318B2
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 60EBB4C318B2
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780872951; cv=none;
	b=X+iXdE1PGTPf2Ifq2e1Jo8j0JtmsjADhUnTf7FFB8AGgYsiGJm7uH+QUnsjYUn+MvQmaInkyW2lUoStMKEboOc5YJ+nJWGXYIdLqkeg+9V2WzMZu1QfXOSn0gKjMHzjdyvWU2AU+ZkuOVnb3qAtyUvBcQ3quV0XICQevfF9imw4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780872951; c=relaxed/simple;
	bh=bioXrVt/lpzHlFZlKA5khyJB1izJcLtYQ76OXRl/0n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=DrwUIcDZOPc6kAjcETLs+3YDfybXi6ph/sHy3+ycTUHsAYWMcrs6wb3JwVScAdEVJzZPdDf8m0urZ+NhLUMICk0TgASx6psjhoCyLK6+LCeBGL8+Vvx6n/XcSPld/KAEis8eUaqn4HQYPF7FVozJZLrJxrr4+WX4sdL5OixvqaY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60EBB4C318B2
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 657NB2oH063573
	for <cygwin-patches@cygwin.com>; Sun, 7 Jun 2026 16:11:02 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdupwCcj; Sun Jun  7 16:10:53 2026
Message-ID: <8696f846-931b-464f-8755-ec0b1ba9a964@maxrnd.com>
Date: Sun, 7 Jun 2026 15:55:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Ensure unused fd available for open()
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260528054307.16582-1-mark@maxrnd.com>
 <19ae30b8-610c-465f-94aa-4599b03c2363@dronecode.org.uk>
 <f907bb7e-8817-43e2-a384-6b848f184151@maxrnd.com>
 <aa0ac383-4e4f-4d05-b5f2-a98262403eb3@dronecode.org.uk>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <aa0ac383-4e4f-4d05-b5f2-a98262403eb3@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 6/7/2026 11:29 AM, Jon Turney wrote:
> On 07/06/2026 08:54, Mark Geisert wrote:
[...]
> 
> Thanks. Yes, that all makes sense.
> 
> Thanks for looking into this. I pushed the patch.
> 
> Is this a candidate for 3.6 branch as well?

If Christian routinely runs his stress-ng tests against 3.6.x then yes, 
otherwise I don't think it's necessary.  Unless we want to burn it in 
"against" the part of the user base that updates... I can't decide if 
that's worth it.

..mark

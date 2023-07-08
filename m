Return-Path: <SRS0=9nkE=C2=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id BFB8D3858C53
	for <cygwin-patches@cygwin.com>; Sat,  8 Jul 2023 21:53:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BFB8D3858C53
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 368LsrS4048338
	for <cygwin-patches@cygwin.com>; Sat, 8 Jul 2023 14:54:53 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpdwxIa3q; Sat Jul  8 14:54:49 2023
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
References: <20230707074121.7880-1-mark@maxrnd.com>
 <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
 <073cd700-c727-ee29-017e-df8d86a1db59@Shaw.ca>
 <1f7d3254-234e-378f-a852-63ca5d7ca01f@Shaw.ca>
 <589a2704-d690-60f4-4818-687233699c4c@maxrnd.com>
Message-ID: <ff935edc-154a-eb3b-600e-cea46dfc3d4f@maxrnd.com>
Date: Sat, 8 Jul 2023 14:53:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <589a2704-d690-60f4-4818-687233699c4c@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mark Geisert wrote:
[... blah blah ...]

I got tripped up by misspelling and not being able to link clang{,++} programs on 
my test system.  I checked the .o files with objdump: Clang and clang++ both 
support __builtin_popcountl, but they emit code for the Hackers Delight algorithm 
rather than using the single-instruction popcnt.  Sorry for the confustion [sic].

..mark


Return-Path: <SRS0=Si3O=C3=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id AEDE73858D28
	for <cygwin-patches@cygwin.com>; Sun,  9 Jul 2023 07:58:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AEDE73858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 369800PL027838
	for <cygwin-patches@cygwin.com>; Sun, 9 Jul 2023 01:00:00 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpdKXIYjB; Sun Jul  9 00:59:50 2023
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
To: cygwin-patches@cygwin.com
References: <20230707074121.7880-1-mark@maxrnd.com>
 <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
 <073cd700-c727-ee29-017e-df8d86a1db59@Shaw.ca>
 <1f7d3254-234e-378f-a852-63ca5d7ca01f@Shaw.ca>
 <589a2704-d690-60f4-4818-687233699c4c@maxrnd.com>
 <ff935edc-154a-eb3b-600e-cea46dfc3d4f@maxrnd.com>
 <e2c6b3f7-3493-90a2-e8c4-a8370a4336d2@Shaw.ca>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <c64c0dcb-5e74-deb8-4182-eafeecc0c730@maxrnd.com>
Date: Sun, 9 Jul 2023 00:58:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <e2c6b3f7-3493-90a2-e8c4-a8370a4336d2@Shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi all,

Brian Inglis wrote:
> On 2023-07-08 15:53, Mark Geisert wrote:
>> Mark Geisert wrote:
>> I got tripped up by misspelling and not being able to link clang{,++} programs 
>> on my test system.  I checked the .o files with objdump: Clang and clang++ both 
>> support __builtin_popcountl, but they emit code for the Hackers Delight 
>> algorithm rather than using the single-instruction popcnt.  Sorry for the 
>> confustion [sic].
> 
> That's what I meant - clang 8 "identifies as" gcc 4, and builtin and intrinsic 
> function support are almost the same (and fairly close to gcc 11) builtin and 
> intrinsic function support.
> 
> And as you mentioned, any support for builtins is better than what we can whip up 
> off the top of our heads (unless you use HD/2!)
> 
> For our purposes, the main differences between clang 8 and current are latest 
> language, library, and processor support, but it also supports useful tools like 
> the analyzer and formatter, which gcc does not provide.
> 
> And it is convenient to be able to run another compiler side by side for 
> comparisons without copying files and remoting to another system.

I now understand what you were getting at.  We are in agreement.  Thanks to your 
persistence and everybody elses comments and to my belatedly getting a working 
clang/clang++ build environment, there is a much smaller v2 patch incoming.
Thanks and Regards All,

..mark


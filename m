Return-Path: <SRS0=LD2m=CU=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 748A13858418
	for <cygwin-patches@cygwin.com>; Sun,  2 Jul 2023 22:05:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 748A13858418
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 362M6PGu088122
	for <cygwin-patches@cygwin.com>; Sun, 2 Jul 2023 15:06:25 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpdynW9Vh; Sun Jul  2 15:06:25 2023
Subject: Re: [PATCH v2] Cygwin: Fix type mismatch on sys/cpuset.h
To: cygwin-patches@cygwin.com
References: <20230314085601.18635-1-mark@maxrnd.com>
 <1cf85bfc-9865-e4f7-5c2e-5acc89c3e77f@dronecode.org.uk>
 <8a69d717-64a0-dd79-77b1-7c95947b45ab@Shaw.ca>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <38806d85-1afe-1218-0e9c-f641ca4c1a86@maxrnd.com>
Date: Sun, 2 Jul 2023 15:05:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <8a69d717-64a0-dd79-77b1-7c95947b45ab@Shaw.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi all,

Brian Inglis wrote:
> On 2023-07-01 08:20, Jon Turney wrote:
>> On 14/03/2023 08:56, Mark Geisert wrote:
>>> Addresses https://cygwin.com/pipermail/cygwin/2023-March/253220.html
>>>
>>> Take the opportunity to follow FreeBSD's and Linux's lead in recasting
>>> macro inline code as calls to static inline functions.  This allows the
>>> macros to be type-safe.  In addition, added a lower bound check to the
>>> functions that use a cpu number to avoid a potential buffer underrun on
>>> a bad argument.  h/t to Corinna for the advice on recasting.
>>>
>>> Fixes: 362b98b49af5 ("Cygwin: Implement CPU_SET(3) macros")
> 
>> There's been a couple of reports that this leads to compilation failures when 
>> this header is included in -std=c89 mode.
>> Solutions are probably something like:
>> * Use __inline__ rather than inline
>> * Don't use initial declaration inside the for loop's init-statement
>> e.g. https://github.com/tinyproxy/tinyproxy/issues/499
> 
> /usr/include/sys/cdefs.h appears to support using __inline instead of __inline__ 
> or inline, and is included many places __inline is used: it appears to be 
> necessary, but may not be sufficient.

Thanks for the report and investigations.  I'll address this shortly.

..mark

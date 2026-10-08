Return-Path: <SRS0=1mG0=H6=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 391294BA2E05
	for <cygwin-patches@cygwin.com>; Thu,  8 Oct 2026 02:57:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 391294BA2E05
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 391294BA2E05
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791428272; cv=none;
	b=u2fODwEOqPvDx75wE5DnJCZbxNeygHXWgNnWT0dsImyAIptp60SRKyHtIvyVHzqcWDCWEMQLM6syagsP1vJYEPccARCuFZ5plTMhXfebV2Jr/pmciantIIRHm5hOCxmiDYjLdjn+f18gFDkaLDI/U2kv32QIX50uLNYs5XEwJTA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791428272; c=relaxed/simple;
	bh=rZIXuvUF5igsQFTXnprrTQFGpSELQUaCy6G5AxRk2xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=v6bhCy3XAGjh/76pc24onw3DvdhMh6RySyftj5YRHwZBxjnx6uPFn42OgeIErm+w/gUMmgu9MUKKPqiSEjSA6j5bUAc/x5GemcF7HQy2c5fWCqnBRVZS7mP4UDm0BK3GQVi5VwrgjqrPPNPHBwBx965E+Qxw0cCMYa4yjK6Mfk4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 391294BA2E05
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6983BRPQ040267
	for <cygwin-patches@cygwin.com>; Wed, 7 Oct 2026 20:11:27 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdSExhqa; Wed Oct  7 20:11:25 2026
Message-ID: <b087383d-0d79-4ecb-88a4-42b0fecf0602@maxrnd.com>
Date: Wed, 7 Oct 2026 19:57:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: sequencer: Implement /dev/sequencer
To: cygwin-patches@cygwin.com
References: <20261007192542.1049-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20261007192542.1049-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 10/7/2026 12:25 PM, Takashi Yano wrote:
> This is an experimental implementation of /dev/sequencer for the
> external MIDI devices. Currently, only output is supported.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
> v2: Use archetype.
> 
>   winsup/cygwin/Makefile.am               |   1 +
>   winsup/cygwin/autoload.cc               |   7 +
>   winsup/cygwin/devices.cc                | 847 ++++++++++++------------
>   winsup/cygwin/devices.in                |   1 +
>   winsup/cygwin/dtable.cc                 |   3 +
>   winsup/cygwin/fhandler/sequencer.cc     | 452 +++++++++++++
>   winsup/cygwin/local_includes/devices.h  |   1 +
>   winsup/cygwin/local_includes/fhandler.h |  53 ++
>   8 files changed, 954 insertions(+), 411 deletions(-)
>   create mode 100644 winsup/cygwin/fhandler/sequencer.cc
I'm not familiar with how Cygwin defines its devices so I may be out to 
lunch with this observation, but...

Isn't devices.cc built by cygwin/scripts/gendevices?  cygwin/Makefile.in 
seems to show that.  Maybe I'm oversimplifying what's really going on 
(and am, thus, out to lunch).

..mark

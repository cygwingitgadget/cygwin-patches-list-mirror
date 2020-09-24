Return-Path: <arthur2e5@aosc.io>
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com
 [217.182.119.155])
 by sourceware.org (Postfix) with ESMTPS id 7B1F33857C4F;
 Thu, 24 Sep 2020 08:40:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7B1F33857C4F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=arthur2e5@aosc.io
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id 2E9223ECDF;
 Thu, 24 Sep 2020 10:40:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 7618B2A0F2;
 Thu, 24 Sep 2020 04:40:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1600936806;
 bh=FxUd7F1E3xj1ZyEz9JNAfAwqZg53bCLy95RpVg+bZEA=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=RFYb9wFLm/+PoGpHA3dH6Ng1xjus4iPL+MFhJwzxDyPDzktAsZpAT1AZMMSbHseCf
 /GMoLbudYXbdv1IsqObDYxLlAhjavFIPPQdg1FiJbR9zBjscHTWiQ9HaF84HtSJB6J
 M5rCYpeFsWMBWSnyECZLQhlLDxBj+CjLceX8E3MY=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CdxIRLzSdtVW; Thu, 24 Sep 2020 04:40:05 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Thu, 24 Sep 2020 04:40:05 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 097A940858;
 Thu, 24 Sep 2020 08:40:04 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=aosc.io header.i=@aosc.io header.b="pvalyJDI"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (unknown [58.120.138.18])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id E29FE40858;
 Thu, 24 Sep 2020 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1600936796; bh=FxUd7F1E3xj1ZyEz9JNAfAwqZg53bCLy95RpVg+bZEA=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=pvalyJDIc2sTg25q4K34dU0H0+pDkhxshOlMUpoRHHaV7VGhve/y9gb1FX9xIAY73
 EmZ341gBE29glaHv6c0iEP1zpwJR5PHmFzcM8WOeNtRDA+PvLjDZzYeJ2UW+8sjNVR
 89X5yQA4j23t5Ro7iimoSZTDzUmBDW3gG/WPVFqU=
Subject: Re: Re: [PATCH v4 1/3] Cygwin: rewrite and make public cmdline parser
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
References: <20200905052711.13008-1-arthur2e5@aosc.io>
 <20200907093943.GJ4127@calimero.vinschen.de>
Cc: cygwin-patches@cygwin.com
From: "Mingye Wang (Artoria2e5)" <arthur2e5@aosc.io>
Message-ID: <33c7b23a-5f59-bcaa-3b0a-6e6d4bc4f30b@aosc.io>
Date: Thu, 24 Sep 2020 16:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200907093943.GJ4127@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 097A940858
X-Spamd-Result: default: False [-0.10 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[aosc.io:s=default];
 RECEIVED_SPAMHAUS_PBL(0.00)[58.120.138.18:received];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DMARC_NA(0.00)[aosc.io]; R_SPF_SOFTFAIL(0.00)[~all];
 ML_SERVERS(-3.10)[148.251.23.173]; DKIM_TRACE(0.00)[aosc.io:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 24 Sep 2020 08:40:10 -0000

On 2020/9/7 17:39, Corinna Vinschen wrote:
> 
> Nope, we won't do that.  The command line parsing is an internal
> thing, and we won't export arbitrary internal functions using
> their own symbol.  *If* we should export this stuff at all, which
> I highly doubt as necessary, it should use the cygwin_internal API.

The idea is that the sort of thing get reimplemented incorrectly a lot, 
and since we have the extra @file feature and the Unix glob it would be 
nice to allow other people to use it. Win32 has CommandLineToArgvW, so I 
figured it wouldn't be too strange to have.

The escaping function is there mostly for symmetry and convenience, 
since it's basically the standard escape.

--
Regards,
Mingye

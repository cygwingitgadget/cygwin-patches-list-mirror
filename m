Return-Path: <arthur2e5@aosc.io>
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.155])
 by sourceware.org (Postfix) with ESMTPS id 14FC9388A402
 for <cygwin-patches@cygwin.com>; Thu, 13 May 2021 13:28:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 14FC9388A402
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=arthur2e5@aosc.io
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay4.mymailcheap.com (Postfix) with ESMTPS id E7A442006C
 for <cygwin-patches@cygwin.com>; Thu, 13 May 2021 13:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id CC9862A50F
 for <cygwin-patches@cygwin.com>; Thu, 13 May 2021 15:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1620912510;
 bh=RKd3P+9XMGJleD9yFJRh2P3nd7JCVjWeLLGe5s7mdxw=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=YcAZK/ByGSQY4SafobYSX1pPRWQ8FaM2d7wpV7LfnEmTZ0TMrLCVtWCHRK/pDCSal
 VkqXO1ltENirVK5p/4o3LhEfNcfZqSXGYnr3adw9qLXvpET0LK8QvCkzkeVkbKKLpK
 HBZJT2zZGT0NySep+V2j/4GSo5UHvYXJUhIQw7LI=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jvpxV7VJdN2D for <cygwin-patches@cygwin.com>;
 Thu, 13 May 2021 15:28:27 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS
 for <cygwin-patches@cygwin.com>; Thu, 13 May 2021 15:28:27 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id B1C57429EF
 for <cygwin-patches@cygwin.com>; Thu, 13 May 2021 13:28:26 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=aosc.io header.i=@aosc.io header.b="UEO9j8jU"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [IPv6:::1] (60-249-2-245.HINET-IP.hinet.net [60.249.2.245])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 4809341FEF
 for <cygwin-patches@cygwin.com>; Thu, 13 May 2021 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1620912493; bh=RKd3P+9XMGJleD9yFJRh2P3nd7JCVjWeLLGe5s7mdxw=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=UEO9j8jUEmCYu3xTh08IcJPMWzo1ZCvOH0mRrT/SOviBOAeT25C4b9KPlmlcjwrgH
 qgiNdY1uaa7llKOMGrhy/y2ObU3sV3KJz1ed/ldz7hlf3h2BqRxGkd8R/UnuPjVB1x
 wikv4opgVyzQuy2YsUbl6mWDor+o4d7EZ/a4d3JE=
Subject: Re: [PATCH v6] Cygwin: rewrite cmdline parser
To: cygwin-patches@cygwin.com
References: <20201107121221.6668-1-arthur2e5@aosc.io>
 <20210513131527.14904-1-arthur2e5@aosc.io>
From: Mingye Wang <arthur2e5@aosc.io>
Message-ID: <984787f1-c810-5b9a-3493-a665230bb0b0@aosc.io>
Date: Thu, 13 May 2021 21:28:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210513131527.14904-1-arthur2e5@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(0.00)[aosc.io:s=default]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[cygwin-patches@cygwin.com];
 TO_DN_NONE(0.00)[]; R_SPF_SOFTFAIL(0.00)[~all:c];
 RCPT_COUNT_ONE(0.00)[1]; DMARC_NA(0.00)[aosc.io];
 ML_SERVERS(-3.10)[213.133.102.83]; DKIM_TRACE(0.00)[aosc.io:+];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Queue-Id: B1C57429EF
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 13 May 2021 13:28:34 -0000

Oh, I should also mention that this patch does *not* fix globbing with 
Windows paths. Although stuff like (in node-js):

     child_process.spawnSync("C:\\cygwin64\\bin\\echo.exe", 
["C:\\Qt\\*"], {encoding: 'utf-8'})

is correctly fed to glob(3), the glob() function does not perform any 
interpretation of Windows paths.  The older parser have the same 
behavior and I didn't change that, seeing there are two ways this can 
play out:

* Cygwin goes to extend glob() with the ability to do Windows paths
   under a new flag.  Globify() is modified to use that flag too.
* Cygwin does not extend glob(), so globify() is modified to skip on
   is_dos_path much like how it already skips with a strpbrk.

Regards,
Artoria2e5

Return-Path: <arthur2e5@aosc.io>
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com
 [144.217.248.102])
 by sourceware.org (Postfix) with ESMTPS id F3A153858D34
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 14:49:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F3A153858D34
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=arthur2e5@aosc.io
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 8ECE53ECE3
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 10:49:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id D685A2A514
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 16:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1593096578;
 bh=T9YKyTEmNbi8CFm6l4rEi7mCfEjXSOMm1TgRr2Wl3sc=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=y0HtWX3/iScN+c7ylqPr8Hqit6UHvFX8Whgqmwr1D79iJ1NimI9Dakqf+kRmZF4Bw
 PskfG41YDnK5JWmrPxVuTwgqLFVIjPdNRKgyGm9D3YYWKmOssJvNeCwTmEb2o5Ta3T
 ZctqZl/0KbxOzqfwWt/CyolzrfJpJjXeahPI3mzU=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HvcHY_uu7T2r for <cygwin-patches@cygwin.com>;
 Thu, 25 Jun 2020 16:49:37 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 16:49:37 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 9D1E7403ED
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 14:49:36 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=aosc.io header.i=@aosc.io header.b="KZWYkZNx"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [IPv6:::] (42-98-198-124.static.netvigator.com [42.98.198.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 46C7D403ED
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1593096565; bh=T9YKyTEmNbi8CFm6l4rEi7mCfEjXSOMm1TgRr2Wl3sc=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=KZWYkZNxMvknWtjXLoFFXRQLoFAAwYFgzy7UTwSMSAAhw4cDoLn7gcRtXYHejIY+F
 lTNKggOPM/HVzf552Xj8Lx86pcDPGow9nCPrmxgIfduR5KFvu5baq9xzg6+cWXhHza
 WB0InYi2lhOWhR0QYwB1yCokF0P61MDICFmiABgU=
Subject: Re: [PATCH v2] Cygwin: rewrite cmdline parser
To: cygwin-patches@cygwin.com
References: <20200624223553.8892-1-arthur2e5@aosc.io>
 <20200625144315.12388-1-arthur2e5@aosc.io>
From: Mingye Wang <arthur2e5@aosc.io>
Message-ID: <36d4f94e-70fd-dbb9-2fa7-c597e9ebae59@aosc.io>
Date: Thu, 25 Jun 2020 22:49:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625144315.12388-1-arthur2e5@aosc.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9D1E7403ED
X-Spamd-Result: default: False [-0.10 / 10.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(0.00)[aosc.io:s=default]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[cygwin-patches@cygwin.com];
 TO_DN_NONE(0.00)[]; R_SPF_SOFTFAIL(0.00)[~all:c];
 RCPT_COUNT_ONE(0.00)[1]; DMARC_NA(0.00)[aosc.io];
 ML_SERVERS(-3.10)[148.251.23.173]; DKIM_TRACE(0.00)[aosc.io:+];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 25 Jun 2020 14:49:41 -0000

On 2020/6/25 22:43, Mingye Wang wrote:
> + free (word);

Grrr, this should not be in there. Waiting for reviews and saving that 
up for v3.

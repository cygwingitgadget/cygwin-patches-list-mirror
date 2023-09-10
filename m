Return-Path: <SRS0=1PbQ=E2=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 29F313858D33
	for <cygwin-patches@cygwin.com>; Sun, 10 Sep 2023 17:32:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 29F313858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=t-online.de
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
	by mailout05.t-online.de (Postfix) with SMTP id E4CE3EAC6
	for <cygwin-patches@cygwin.com>; Sun, 10 Sep 2023 19:32:24 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.246.1]) by fwd71.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1qfOIK-2ZJdnk0; Sun, 10 Sep 2023 19:32:24 +0200
Subject: Re: [PATCH] Add initial support for SOURCE_DATE_EPOCH
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <a1890367-b100-2321-aca4-17eec98ebba7@t-online.de>
 <ZPsrFKgcmt2qrH34@calimero.vinschen.de>
 <a691f19e-ec1b-3b5e-7495-77156799dbd0@dronecode.org.uk>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <c49587a3-61fe-8f91-9abb-7cdcecbb4df1@t-online.de>
Date: Sun, 10 Sep 2023 19:32:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <a691f19e-ec1b-3b5e-7495-77156799dbd0@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694367144-D2DC22DD-1451A4D2/0/0 CLEAN NORMAL
X-TOI-MSGID: 253bc685-f88d-48cd-bb6e-6bf6f38d77fa
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney wrote:
> On 08/09/2023 15:09, Corinna Vinschen wrote:
>> Jon,
>>
>> you did all the latest work in terms of the build machinery.
>> Would you mind to review this patch, please?
>
> Sure.
>
> Patch looks all right to me, so I applied it.

Thanks!

Please note that for reproducible *.exe files and release tarballs ...


>
>> On Sep  5 19:01, Christian Franke wrote:
>>> This patch enables reproducible builds of cygwin package in 
>>> conjunction with
>>> this cygport patch:
>>> https://sourceware.org/pipermail/cygwin-apps/2023-August/043108.html

... the above cygport patch is also required.

-- 
Regards,
Christian


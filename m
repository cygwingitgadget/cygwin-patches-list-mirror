Return-Path: <SRS0=f6sa=SU=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id A7E493858D29
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 14:06:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A7E493858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A7E493858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732543607; cv=none;
	b=SvRpY8JznPiHOLCc0aiVtNOnlWbT3H2b5AJGdXFyOIAeGQy9XRzKrLNzT0raas4X/QgBmlQwkEFpWoDmS/p4VhW/Kmko2n7vaE4WT4oeyilmsW9IIlyFG63Tml0RB4KYvrxSaPnfz1k8/zZKMODa9tJWOMWYCf5DoziU0LisCfw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732543607; c=relaxed/simple;
	bh=J6vBDclzJQsY5tT272sN5ibhpl5KPSBdsC7rGw+RnFM=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=sSC7bV5MH5eUiP8fv3gdyrRXR2PoiATJRFwIc7UxjACKqjZ3Vwc2LnG/omogGo7fTcsDoWakH1fEpiLlzdrtE7dyMtvkq1efSeY2+cBfRirBX5RDB8PL6EZJOq19dOxfiFJSyFPc1SYSzS/sWU50ntVFx8T/m0yWflhy/OFOueU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A7E493858D29
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
	by mailout10.t-online.de (Postfix) with SMTP id 99CDB148
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 15:06:42 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd71.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tFZje-4Obn5k0; Mon, 25 Nov 2024 15:06:42 +0100
Subject: Re: [PATCH] Cygwin: sched_getscheduler: fix error handling
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <36a9bf51-b331-bb30-1bd3-2e112d9ec3fa@t-online.de>
Message-ID: <99a63e87-5ab1-53ee-278c-dff0339696ec@t-online.de>
Date: Mon, 25 Nov 2024 15:06:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <36a9bf51-b331-bb30-1bd3-2e112d9ec3fa@t-online.de>
Content-Type: multipart/mixed;
 boundary="------------16FAE52428B271845E5F5510"
X-TOI-EXPURGATEID: 150726::1732543602-ACFE16C2-154A96DA/0/0 CLEAN NORMAL
X-TOI-MSGID: 837180ba-2290-420e-9b9f-9c72f9d699c4
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------16FAE52428B271845E5F5510
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Christian Franke wrote:
> Long standing (2001) minor issue.
>

v2 with "Fixes:" in log message.


--------------16FAE52428B271845E5F5510
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_getscheduler-fix-error-handling.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-sched_getscheduler-fix-error-handling.patch"

RnJvbSA2YzhjMDA1YTM2YTRmNzVmMGRmZDlmNGM4ZTFkYjgxZWYxZmVlZGNjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDI1IE5vdiAyMDI0IDE1OjAyOjM2ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzY2hlZF9nZXRzY2hlZHVsZXI6IGZpeCBlcnJv
ciBoYW5kbGluZwoKRml4ZXM6IDZiMmEyYWE0YWYxZSAoIkFkZCBtaXNzaW5nIGZpbGVzLiIp
ClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlzdGlhbi5mcmFua2VAdC1v
bmxpbmUuZGU+Ci0tLQogd2luc3VwL2N5Z3dpbi9zY2hlZC5jYyB8IDUgKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL3NjaGVkLmNjIGIvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYwppbmRl
eCAzMzM3ODZmNDQuLmEzNTQ2ZmNiOCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9zY2hl
ZC5jYworKysgYi93aW5zdXAvY3lnd2luL3NjaGVkLmNjCkBAIC0xNDAsNyArMTQwLDEwIEBA
IGludAogc2NoZWRfZ2V0c2NoZWR1bGVyIChwaWRfdCBwaWQpCiB7CiAgIGlmIChwaWQgPCAw
KQotICAgIHJldHVybiBFU1JDSDsKKyAgICB7CisgICAgICBzZXRfZXJybm8gKEVJTlZBTCk7
CisgICAgICByZXR1cm4gLTE7CisgICAgfQogICBlbHNlCiAgICAgcmV0dXJuIFNDSEVEX0ZJ
Rk87CiB9Ci0tIAoyLjQ1LjEKCg==
--------------16FAE52428B271845E5F5510--

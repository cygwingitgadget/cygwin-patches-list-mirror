Return-Path: <SRS0=O8Rr=KD=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id 36BF3385840F
	for <cygwin-patches@cygwin.com>; Mon, 26 Feb 2024 14:24:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 36BF3385840F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 36BF3385840F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1708957446; cv=none;
	b=DwfOhJnodkjxYhSg8ZCIuk8gy5xVcH1HDI16wSNjeAJNz3gw/DcHcuiO3jBEerKBXIylV2srznWSMeAfKUYIpqwQMCpcItxtke0Gigaw/xGFyD0fd2YLtHtSVwy06vKOdbGL5XsmpI9v7WKWnNSJvdIAgMwveaEhcqphHlaETGY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1708957446; c=relaxed/simple;
	bh=SZcph6Gk7HskUzOWxbILxGmslabzxXzYdw1wW6Z4ocU=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=BBJs7F/5yl7ZJVPVWWwQRfctwZ22uiVvvoLcZfAHHFjSH0wIwlkgpEmK7ObMhmLYaIQobGtZpefa8AdlQexZSZ3TkkQ0uptjsIpFmmp5kutg3wPiG2KA+603wbvGasG8DqFkUlo8roIyJRfB/QqPg5K8jxdwI8UadAWN9koaymU=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
	by mailout10.t-online.de (Postfix) with SMTP id 0558D9F0A
	for <cygwin-patches@cygwin.com>; Mon, 26 Feb 2024 15:24:04 +0100 (CET)
Received: from [192.168.2.102] ([87.187.47.57]) by fwd78.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rebth-0DXFGS0; Mon, 26 Feb 2024 15:24:01 +0100
Subject: [PATCH 2/4] Cygwin: errmap[]: reduce value size from 32 to 8 bits
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <7f17e15c-ef28-06fd-3a6d-cac60a651960@t-online.de>
Message-ID: <218ffbbb-b32b-af96-10b0-f3c1fb27aeaf@t-online.de>
Date: Mon, 26 Feb 2024 15:24:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <7f17e15c-ef28-06fd-3a6d-cac60a651960@t-online.de>
Content-Type: multipart/mixed;
 boundary="------------C6063460A9BF726193DD5040"
X-TOI-EXPURGATEID: 150726::1708957441-5CF5D979-AD08D0BC/0/0 CLEAN NORMAL
X-TOI-MSGID: c82ef4be-055e-482e-90a2-a04a3b551fae
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------C6063460A9BF726193DD5040
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------C6063460A9BF726193DD5040
Content-Type: text/plain; charset=UTF-8;
 name="0002-Cygwin-errmap-reduce-value-size-from-32-to-8-bits.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0002-Cygwin-errmap-reduce-value-size-from-32-to-8-bits.patch"

RnJvbSBiZWJjMTFjMmE5MDIyZTYxY2RjNzU0NGVkMmNiNTEwMWExNzBhZTkyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDI2IEZlYiAyMDI0IDE0OjAxOjU0ICswMTAw
ClN1YmplY3Q6IFtQQVRDSCAyLzRdIEN5Z3dpbjogZXJybWFwW106IHJlZHVjZSB2YWx1ZSBz
aXplIGZyb20gMzIgdG8gOCBiaXRzCgpPdmVyZmxvdyB3b3VsZCBiZSBkZXRlY3RlZCBhdCBj
b21waWxlIHRpbWUuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3Rp
YW4uZnJhbmtlQHQtb25saW5lLmRlPgotLS0KIHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVk
ZXMvZXJybWFwLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVz
L2Vycm1hcC5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9lcnJtYXAuaAppbmRl
eCA3MzdjMDFjOGIuLmVhY2Y5Y2QxYyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9sb2Nh
bF9pbmNsdWRlcy9lcnJtYXAuaAorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVz
L2Vycm1hcC5oCkBAIC0zLDcgKzMsNyBAQAogICAgdG8gdGhpcyBuZXcgYXJyYXkgbWFudWFs
bHkgb24gZGVtYW5kLiAqLwogCiAvKiBGSVhNRTogU29tZSBvZiB0aGVzZSBjaG9pY2VzIGFy
ZSBhcmJpdHJhcnkhICovCi1jb25zdGV4cHIgaW50IGVycm1hcFtdID0KK2NvbnN0ZXhwciB1
aW50OF90IGVycm1hcFtdID0KIHsKICAgMCwJCQkvKiBFUlJPUl9TVUNDRVNTICovCiAgIEVC
QURSUUMsCQkvKiBFUlJPUl9JTlZBTElEX0ZVTkNUSU9OICovCi0tIAoyLjQzLjAKCg==
--------------C6063460A9BF726193DD5040--

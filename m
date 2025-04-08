Return-Path: <SRS0=2woS=W2=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
	by sourceware.org (Postfix) with ESMTPS id A8A113858294
	for <cygwin-patches@cygwin.com>; Tue,  8 Apr 2025 11:51:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A8A113858294
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A8A113858294
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.84
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744113117; cv=none;
	b=g+/IPKgUJsKGqx9otvMUkWlHIv1hFqUZXPByQuoY2iOnymPFUTc9oeXI73zpXucDpfyQ1Vo5AYnxx6dOGYZi3CdY2iuj9uUah14TtEGpo3VvPCqjj7sjNnoqZ983r+trdANubQqfaVsUKBIdcDghwqLxBIIdsqmxM3I2/cbh3y4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744113117; c=relaxed/simple;
	bh=/sXgGDYwNGfDAmk8Q0diRAZ1QZMcmNoufdjiS274exw=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=d+D+e62Svva3KFP6MiN7IVzdl2iZpTpF46sFXWcgJPCqRVP72WNEZaXRyN+zMwfoz80dBWY2JdJBTz3sobPxQRXGtsAPyQbhHWkOvUnbFx3yxaZrA4BNUxKNjJM4LNr0Yefqk56LIqiBcf+kTOZdQyiSYbNaTPH6fGqrZlJqbYA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A8A113858294
Received: from fwd75.aul.t-online.de (fwd75.aul.t-online.de [10.223.144.101])
	by mailout09.t-online.de (Postfix) with SMTP id EA53C1801
	for <cygwin-patches@cygwin.com>; Tue,  8 Apr 2025 13:51:55 +0200 (CEST)
Received: from [192.168.2.101] ([87.187.37.162]) by fwd75.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u27Ug-1wMCCO0; Tue, 8 Apr 2025 13:51:54 +0200
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: faq: add lssparse to sparse file example
Message-ID: <245987b6-3d23-51ce-05d1-84bc0b4a12ba@t-online.de>
Date: Tue, 8 Apr 2025 13:51:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7A60D7F09019C3608CD088BE"
X-TOI-EXPURGATEID: 150726::1744113114-A4FFF286-A3446B74/0/0 CLEAN NORMAL
X-TOI-MSGID: 41fc969e-e2b7-4c3b-80ec-b33a44a5a2bb
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_BL,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------7A60D7F09019C3608CD088BE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------7A60D7F09019C3608CD088BE
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-faq-add-lssparse-to-sparse-file-example.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-faq-add-lssparse-to-sparse-file-example.patch"

RnJvbSAzOTQ0YjViMjE1MDJlNjU4MjFhNGMzMGQ1NjgyMDcyNzMzMjAzNDdhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDggQXByIDIwMjUgMTM6MzQ6MDIgKzAyMDAK
U3ViamVjdDogW1BBVENIXSBDeWd3aW46IGZhcTogYWRkIGxzc3BhcnNlIHRvIHNwYXJzZSBm
aWxlIGV4YW1wbGUKClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlzdGlh
bi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogd2luc3VwL2RvYy9mYXEtdXNpbmcueG1sIHwg
NSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3dpbnN1cC9kb2MvZmFxLXVzaW5nLnhtbCBiL3dpbnN1cC9kb2MvZmFxLXVzaW5nLnhtbApp
bmRleCBlNWU0NDc5ZjUuLjExMTcwMmM2ZiAxMDA2NDQKLS0tIGEvd2luc3VwL2RvYy9mYXEt
dXNpbmcueG1sCisrKyBiL3dpbnN1cC9kb2MvZmFxLXVzaW5nLnhtbApAQCAtODU1LDYgKzg1
NSwxMSBAQCBwb3NzaWJsZSB0byBwcmVzZXQgdGhlIHNwYXJzZSBhdHRyaWJ1dGUgd2l0aCA8
bGl0ZXJhbD5jaGF0dHI8L2xpdGVyYWw+LgogCS0tLWEtUy0tLS0tLS0tIDIvaXNfc3BhcnNl
CiAJLS0tYS1TLS0tLS0tLS0gMi9tYXliZV9zcGFyc2UKIAktLS1hLVMtLS0tLS0tLSAyL25v
dF9zcGFyc2UKKwkkIGxzc3BhcnNlIC1IIDAvaXNfc3BhcnNlICMgZnJvbSBjeWd1dGlscy1l
eHRyYSBwYWNrYWdlCisJSG9sZSByYW5nZVsxXTogb2Zmc2V0PTB4MCwgICAgICBsZW5ndGg9
MHgxMDAwMDAKKwlEYXRhIHJhbmdlWzJdOiBvZmZzZXQ9MHgxMDAwMDAsIGxlbmd0aD0weDQK
KwkkIGxzc3BhcnNlIC1IIDAvbm90X3NwYXJzZQorCURhdGEgcmFuZ2VbMV06IG9mZnNldD0w
eDAsICAgICAgbGVuZ3RoPTB4MTAwMDA0CiA8L3NjcmVlbj4KIDxwYXJhPldpdGggPGxpdGVy
YWw+c3BhcnNlPC9saXRlcmFsPiBtb3VudCBvcHRpb24gb3IgYSBTU0QsIGFsbAogPGxpdGVy
YWw+Py9tYXliZV9zcGFyc2U8L2xpdGVyYWw+IGZpbGVzIHdvdWxkIGJlIHNwYXJzZS4KLS0g
CjIuNDUuMQoK
--------------7A60D7F09019C3608CD088BE--

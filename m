Return-Path: <SRS0=BltL=ZM=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id 6E1A23853834
	for <cygwin-patches@cygwin.com>; Sun, 29 Jun 2025 17:13:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6E1A23853834
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6E1A23853834
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751217212; cv=none;
	b=uAOI7C3+loducBrP7VpqUoJZib5RQAyMOdRv/Y9YNac8+w4JKsMT15CpwCkpPGX+Gp93SptL6BHBbdKsWf/XdOoBKtCfDiBOlY+uKbdHq97kwpZUlr0BcDzOAyyFCAjKhLqfPCLQry/6v50P4XA4/V1yXWv7UpMM4kdqBBVZS/g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751217212; c=relaxed/simple;
	bh=7YWt6XDvdPIh6sEZ7/gEvyRW3Sr3CLgAtU7XOhHuAn0=;
	h=From:Subject:To:Message-ID:Date:MIME-Version; b=sDXIGhYK4C7XEesPvdM7xbXexNlE1erCqRTAsRvXjmtKVTSZFwYHt+Yt9RTmx6CQS1sPfiJZdjsnemGLSJhyFzEsUMBtCVIqCjmHcWtgrGfk+1pOufCT2y4xldCfG5AS5FZNlUOIel9y6wkW0NgRycreIfKiPJNiwVjBeGtyl3c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6E1A23853834
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
	by mailout01.t-online.de (Postfix) with SMTP id CA2381C046
	for <cygwin-patches@cygwin.com>; Sun, 29 Jun 2025 19:13:29 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd86.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uVvar-2HDzJA0; Sun, 29 Jun 2025 19:13:29 +0200
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] wcrtomb: fix CESU-8 value of leftover lone high surrogate
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
Message-ID: <6bdab1bf-192e-d1b0-22dc-c678e94e35d9@t-online.de>
Date: Sun, 29 Jun 2025 19:13:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7854F1960881366723595CFF"
X-TOI-EXPURGATEID: 150726::1751217209-A27FA548-B725C668/0/0 CLEAN NORMAL
X-TOI-MSGID: b8719183-285c-49b8-8d45-d1ea8f627104
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------7854F1960881366723595CFF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Fixes the CESU-8 value, but not the missing encoding if the high 
surrogate is at the very end of the string.

-- 
Regards,
Christian


--------------7854F1960881366723595CFF
Content-Type: text/plain; charset=UTF-8;
 name="0001-wcrtomb-fix-CESU-8-value-of-leftover-lone-high-surro.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-wcrtomb-fix-CESU-8-value-of-leftover-lone-high-surro.pa";
 filename*1="tch"

RnJvbSA5NmYyMzQ5NmYyNDk1NTg5NDk5MjNlNjAyNzBiOTU2ODk1NjkxMmJmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBTdW4sIDI5IEp1biAyMDI1IDE5OjAzOjM2ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gd2NydG9tYjogZml4IENFU1UtOCB2YWx1ZSBvZiBsZWZ0b3Zl
ciBsb25lIGhpZ2ggc3Vycm9nYXRlCgpBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9w
aXBlcm1haWwvY3lnd2luLzIwMjUtSnVuZS8yNTgzNzguaHRtbApGaXhlczogNmZmMjhmYzNi
MTIxICgiQWxsb3cgQ0VTVS04IHN1cnJvZ2F0ZSB2YWx1ZSBlbmNvZGluZyIpClNpZ25lZC1v
ZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlzdGlhbi5mcmFua2VAdC1vbmxpbmUuZGU+
Ci0tLQogbmV3bGliL2xpYmMvc3RkbGliL3djdG9tYl9yLmMgfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
bmV3bGliL2xpYmMvc3RkbGliL3djdG9tYl9yLmMgYi9uZXdsaWIvbGliYy9zdGRsaWIvd2N0
b21iX3IuYwppbmRleCA1ZWExZTEzZTQuLmVjNmFkZmE0OSAxMDA2NDQKLS0tIGEvbmV3bGli
L2xpYmMvc3RkbGliL3djdG9tYl9yLmMKKysrIGIvbmV3bGliL2xpYmMvc3RkbGliL3djdG9t
Yl9yLmMKQEAgLTYyLDggKzYyLDggQEAgX191dGY4X3djdG9tYiAoc3RydWN0IF9yZWVudCAq
ciwKIAkgb2YgdGhlIHN1cnJvZ2F0ZSBhbmQgcHJvY2VlZCB0byBjb252ZXJ0IHRoZSBnaXZl
biBjaGFyYWN0ZXIuICBOb3RlCiAJIHRvIHJldHVybiBleHRyYSAzIGJ5dGVzLiAqLwogICAg
ICAgd2NoYXJfdCB0bXA7Ci0gICAgICB0bXAgPSAoc3RhdGUtPl9fdmFsdWUuX193Y2hiWzBd
IDw8IDE2IHwgc3RhdGUtPl9fdmFsdWUuX193Y2hiWzFdIDw8IDgpCi0JICAgIC0gKDB4MTAw
MDAgPj4gMTAgfCAweGQ4MGQpOworICAgICAgdG1wID0gKCgoc3RhdGUtPl9fdmFsdWUuX193
Y2hiWzBdIDw8IDE2IHwgc3RhdGUtPl9fdmFsdWUuX193Y2hiWzFdIDw8IDgpCisJICAgIC0g
MHgxMDAwMCkgPj4gMTApIHwgMHhkODAwOwogICAgICAgKnMrKyA9IDB4ZTAgfCAoKHRtcCAm
IDB4ZjAwMCkgPj4gMTIpOwogICAgICAgKnMrKyA9IDB4ODAgfCAoKHRtcCAmICAweGZjMCkg
Pj4gNik7CiAgICAgICAqcysrID0gMHg4MCB8ICAodG1wICYgICAweDNmKTsKLS0gCjIuNDUu
MQoK
--------------7854F1960881366723595CFF--

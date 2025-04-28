Return-Path: <SRS0=zXwX=XO=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	by sourceware.org (Postfix) with ESMTPS id 2171D3858C60
	for <cygwin-patches@cygwin.com>; Mon, 28 Apr 2025 15:43:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2171D3858C60
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2171D3858C60
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745855016; cv=none;
	b=dbqIo6lbzI65jWI2zzFx3FXKokxtLk6d4F8nOhranoKgqYYfPKRJF49WJNbEu9daf+UIodIWM2ts6r2csUfa80UihKcEdDd8UMO00HBy9mEyhLfGZc63Z+l1D7wJdHgaks9btM5+4wMLWTrZML53RlsQ+Z1k/KFwDGm5jdmGDv4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745855016; c=relaxed/simple;
	bh=tvloIUm52hL6fPJ34AlKCYkwvSwWSKJW+vxzBLLXqKs=;
	h=From:Subject:To:Message-ID:Date:MIME-Version; b=OxdKyExg36Af/10hvkp3Uw+0zRExQSLaa+clklO+XyXtoc6B85exZJInabM+H3XcNuamC6DaxhTorATM7V8ZFrjNYlGFLZOKNpLdUiDg1kyM1jM+0EG5PhGfPCEte8AzYPo/duUc5bv0CE1wHIGdXP2JeUsCTMal3QOlSyMrjt0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
	by mailout04.t-online.de (Postfix) with SMTP id 7438329E
	for <cygwin-patches@cygwin.com>; Mon, 28 Apr 2025 17:43:09 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd76.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u9QdM-11iObQ0; Mon, 28 Apr 2025 17:43:04 +0200
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: clock_settime: fail with EINVAL if tv_nsec is
 negative
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Message-ID: <f21927b5-defe-529d-3095-0c1f51e23eb7@t-online.de>
Date: Mon, 28 Apr 2025 17:43:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C2F5FC1FE92F65691D35EAD2"
X-TOI-EXPURGATEID: 150726::1745854984-C7FFC94A-18C46564/0/0 CLEAN NORMAL
X-TOI-MSGID: 0aef5388-c690-47e7-8ed0-f66e82bba9f9
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------C2F5FC1FE92F65691D35EAD2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A followup to:
https://sourceware.org/pipermail/cygwin-patches/2025q2/013678.html

--
Regards,
Christian


--------------C2F5FC1FE92F65691D35EAD2
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-clock_settime-fail-with-EINVAL-if-tv_nsec-is-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-clock_settime-fail-with-EINVAL-if-tv_nsec-is-.pa";
 filename*1="tch"

RnJvbSBiYmRhZjRjZmI0ODdiN2QxMzRiNWZkYTAwNDQ3Zjc3YjZkMGNmZDI3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDI4IEFwciAyMDI1IDE3OjI3OjI4ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBjbG9ja19zZXR0aW1lOiBmYWlsIHdpdGggRUlO
VkFMIGlmIHR2X25zZWMgaXMKIG5lZ2F0aXZlCgpBZGRyZXNzZXM6IGh0dHBzOi8vc291cmNl
d2FyZS5vcmcvcGlwZXJtYWlsL2N5Z3dpbi1wYXRjaGVzLzIwMjVxMi8wMTM2NjUuaHRtbApG
aXhlczogNjc1OGQyYTNhYWU2ICgiKGNsb2NrX3NldHRpbWUpOiBOZXcgZnVuY3Rpb24uIikK
U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFuLmZyYW5rZUB0LW9u
bGluZS5kZT4KLS0tCiB3aW5zdXAvY3lnd2luL3RpbWVzLmNjIHwgMyArKy0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL3RpbWVzLmNjIGIvd2luc3VwL2N5Z3dpbi90aW1lcy5jYwppbmRleCBh
ODk5ODBkMDguLjNjM2JhOTIzNiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi90aW1lcy5j
YworKysgYi93aW5zdXAvY3lnd2luL3RpbWVzLmNjCkBAIC00OTAsNyArNDkwLDggQEAgY2xv
Y2tfc2V0dGltZSAoY2xvY2tpZF90IGNsa19pZCwgY29uc3Qgc3RydWN0IHRpbWVzcGVjICp0
cCkKICAgICAgIHJldHVybiAtMTsKICAgICB9CiAKLSAgaWYgKGNsa19pZCAhPSBDTE9DS19S
RUFMVElNRV9DT0FSU0UgJiYgY2xrX2lkICE9IENMT0NLX1JFQUxUSU1FKQorICBpZiAoKGNs
a19pZCAhPSBDTE9DS19SRUFMVElNRV9DT0FSU0UgJiYgY2xrX2lkICE9IENMT0NLX1JFQUxU
SU1FKQorICAgICAgfHwgdHAtPnR2X25zZWMgPCAwKSAvKiBPdGhlcndpc2UgLTk5OS4uLi0x
IHdvdWxkIGJlIGFjY2VwdGVkICovCiAgICAgewogICAgICAgc2V0X2Vycm5vIChFSU5WQUwp
OwogICAgICAgcmV0dXJuIC0xOwotLSAKMi40NS4xCgo=
--------------C2F5FC1FE92F65691D35EAD2--

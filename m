Return-Path: <SRS0=f6sa=SU=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
	by sourceware.org (Postfix) with ESMTPS id 1A4903858D29
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 14:00:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1A4903858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1A4903858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.81
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732543228; cv=none;
	b=pEae96tzFRzyQ29AzZg8yQS3Z8ALqn/H0zdUvJWMrXQPICoGO3EadPcJwTGaOIUZBfm+sdWSTuy2j4/7pbj9y0O0bbQUnlFU+d4IY8oegUADziiRup41j/3aTawFoVUqNXjvY1TQXBMDjqNY9aBVOAT0sc0Q/fNvB2Z6Sg/2H/E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732543228; c=relaxed/simple;
	bh=uAVYn8xebwYl6WUncVF/HpB32oadnl4ZoTcSNQHNP9c=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=Cx9xsIvaAm20dXmfai+gZfSbv/6t4W9VEfiM1pECafHhOVTGua5CXvN6gNdxGYQRh/OXTgpwtOOJ4R0s4+Jqaq70189NpeJyHeqLZ0AB0IjK9unZq2u7Vj2kNFLNxHVegAkx+5BvHtm65L2r7QurjNyJk7j60kUTfRLeTfNlg4A=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1A4903858D29
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
	by mailout03.t-online.de (Postfix) with SMTP id CD432AB3
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 15:00:25 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd87.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tFZdV-12SJlo0; Mon, 25 Nov 2024 15:00:21 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
To: cygwin-patches@cygwin.com
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
 <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
Date: Mon, 25 Nov 2024 15:00:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------7E8707D5F8B2BF74152410AB"
X-TOI-EXPURGATEID: 150726::1732543221-F1FF9700-C23C845B/0/0 CLEAN NORMAL
X-TOI-MSGID: c9fb1a51-9dab-403d-8955-38d3d42a0c4c
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------7E8707D5F8B2BF74152410AB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> Hi Christian,
>
>
> can you please add a Fixes: to the commit messages of both
> of your patches?
>
> On Nov 23 19:56, Christian Franke wrote:
>> sched_setscheduler(pid, sched_getscheduler(pid), param) should behave like
>> sched_setparam(pid, param).
>>
>> -- 
>> Regards,
>> Christian
>>
>>  From a67e6679cc2bb199713b1f783d5219cb8364f5f4 Mon Sep 17 00:00:00 2001
>> From: Christian Franke <christian.franke@t-online.de>
>> Date: Sat, 23 Nov 2024 19:50:29 +0100
>> Subject: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
>>
>> Behave like sched_setparam() if the requested policy is identical
>> to the fixed value (SCHED_FIFO) returned by sched_getscheduler().
>>
> Fixes: ...?

... the very first commit (cgf 2001) of sched.cc :-)

New patch attached.


--------------7E8707D5F8B2BF74152410AB
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_setscheduler-allow-changes-of-the-prior.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-sched_setscheduler-allow-changes-of-the-prior.pa";
 filename*1="tch"

RnJvbSBlOTVmYzFhY2ViNTI4N2Y5YWQ2NWM2YzA3ODEyNWZlY2JhNmM2ZGU5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDI1IE5vdiAyMDI0IDE0OjUxOjA0ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzY2hlZF9zZXRzY2hlZHVsZXI6IGFsbG93IGNo
YW5nZXMgb2YgdGhlIHByaW9yaXR5CgpCZWhhdmUgbGlrZSBzY2hlZF9zZXRwYXJhbSgpIGlm
IHRoZSByZXF1ZXN0ZWQgcG9saWN5IGlzIGlkZW50aWNhbAp0byB0aGUgZml4ZWQgdmFsdWUg
KFNDSEVEX0ZJRk8pIHJldHVybmVkIGJ5IHNjaGVkX2dldHNjaGVkdWxlcigpLgoKRml4ZXM6
IDZiMmEyYWE0YWYxZSAoIkFkZCBtaXNzaW5nIGZpbGVzLiIpClNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBGcmFua2UgPGNocmlzdGlhbi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogd2lu
c3VwL2N5Z3dpbi9yZWxlYXNlLzMuNi4wIHwgMyArKysKIHdpbnN1cC9jeWd3aW4vc2NoZWQu
Y2MgICAgICB8IDUgKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNi4w
IGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNi4wCmluZGV4IDQ2OGEyYWIyNC4uMDlhYTUz
NzZlIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAKKysrIGIvd2lu
c3VwL2N5Z3dpbi9yZWxlYXNlLzMuNi4wCkBAIC00MywzICs0Myw2IEBAIFdoYXQgY2hhbmdl
ZDoKIAogLSBOb3cgdXNpbmcgQVZYL0FWWDIvQVZYLTUxMiBpbnN0cnVjdGlvbnMgaW4gc2ln
bmFsIGhhbmRsZXIgZG9lcyBub3QKICAgYnJlYWsgdGhlaXIgY29udGV4dC4KKworLSBzY2hl
ZF9zZXRzY2hlZHVsZXIoMikgYWxsb3dzIHRvIGNoYW5nZSB0aGUgcHJpb3JpdHkgaWYgdGhl
IHBvbGljeSBpcworICBlcXVhbCB0byB0aGUgdmFsdWUgcmV0dXJuZWQgYnkgc2NoZWRfZ2V0
c2NoZWR1bGVyKDIpLgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYyBiL3dp
bnN1cC9jeWd3aW4vc2NoZWQuY2MKaW5kZXggNzFhMWU4NjhmLi4zMzM3ODZmNDQgMTAwNjQ0
Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9zY2hl
ZC5jYwpAQCAtMzk5LDggKzM5OSwxMSBAQCBpbnQKIHNjaGVkX3NldHNjaGVkdWxlciAocGlk
X3QgcGlkLCBpbnQgcG9saWN5LAogCQkgICAgY29uc3Qgc3RydWN0IHNjaGVkX3BhcmFtICpw
YXJhbSkKIHsKKyAgaWYgKHBvbGljeSA9PSBTQ0hFRF9GSUZPKSAvKiByZXR1cm5lZCBieSBz
Y2hlZF9nZXRzY2hlZHVsZXIuICovCisgICAgcmV0dXJuIHNjaGVkX3NldHBhcmFtIChwaWQs
IHBhcmFtKTsKKwogICAvKiBvbiB3aW4zMiwgeW91IGNhbid0IGNoYW5nZSB0aGUgc2NoZWR1
bGVyLiBEb2ghICovCi0gIHNldF9lcnJubyAoRU5PU1lTKTsKKyAgc2V0X2Vycm5vIChFSU5W
QUwpOwogICByZXR1cm4gLTE7CiB9CiAKLS0gCjIuNDUuMQoK
--------------7E8707D5F8B2BF74152410AB--

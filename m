Return-Path: <SRS0=mhqJ=SS=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
	by sourceware.org (Postfix) with ESMTPS id B00723858C42
	for <cygwin-patches@cygwin.com>; Sat, 23 Nov 2024 18:58:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B00723858C42
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B00723858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.85
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732388281; cv=none;
	b=XWEcIlvZBLYO/FWVsPiYEtdsAbwt1YC+PFgOpR5Wv5o/x2hyGe/IArNEtuu/oS6A1K44FuJP9fSf7fgr+7hy8iPHvNmYjpmsPMOtCfnVEx9sFYjjyVBZkARisKTTwxuBZqNDX2E+/FHCTM9goff5gMkB0RCCkLr4QJx4PnYjam4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732388281; c=relaxed/simple;
	bh=rKxMjptEed6rZjP/0LlEEDuRCW8YSSQo+OATIy54nJ8=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=L53Ee8usgsn3/F0FN5bfc16Oy85IEDd3nTWsmza/f9hqpoLkLyh5nRYv9tSc/7oDPUeoCp3/jfp05jUGLp9cLiHUqPxsoJpNaNFN5NO7bdg4ATuZghc+k4cgo7/o/ISpBIjLUSiO5/j83deWef/nj0JfmNXm0jKl0wbtjm4YDHQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B00723858C42
Received: from fwd75.aul.t-online.de (fwd75.aul.t-online.de [10.223.144.101])
	by mailout11.t-online.de (Postfix) with SMTP id 86EAB423
	for <cygwin-patches@cygwin.com>; Sat, 23 Nov 2024 19:56:53 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd75.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tEvJK-0nREAa0; Sat, 23 Nov 2024 19:56:50 +0100
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
Message-ID: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
Date: Sat, 23 Nov 2024 19:56:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------39D077BD8E8B90932BD903A2"
X-TOI-EXPURGATEID: 150726::1732388210-FDFF4C97-4DC78420/0/0 CLEAN NORMAL
X-TOI-MSGID: fa18fcc4-93aa-4b7b-86cd-c500636f8041
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------39D077BD8E8B90932BD903A2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

sched_setscheduler(pid, sched_getscheduler(pid), param) should behave like
sched_setparam(pid, param).

-- 
Regards,
Christian


--------------39D077BD8E8B90932BD903A2
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_setscheduler-allow-changes-of-the-prior.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-sched_setscheduler-allow-changes-of-the-prior.pa";
 filename*1="tch"

RnJvbSBhNjdlNjY3OWNjMmJiMTk5NzEzYjFmNzgzZDUyMTljYjgzNjRmNWY0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBTYXQsIDIzIE5vdiAyMDI0IDE5OjUwOjI5ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzY2hlZF9zZXRzY2hlZHVsZXI6IGFsbG93IGNo
YW5nZXMgb2YgdGhlIHByaW9yaXR5CgpCZWhhdmUgbGlrZSBzY2hlZF9zZXRwYXJhbSgpIGlm
IHRoZSByZXF1ZXN0ZWQgcG9saWN5IGlzIGlkZW50aWNhbAp0byB0aGUgZml4ZWQgdmFsdWUg
KFNDSEVEX0ZJRk8pIHJldHVybmVkIGJ5IHNjaGVkX2dldHNjaGVkdWxlcigpLgoKU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFuLmZyYW5rZUB0LW9ubGluZS5k
ZT4KLS0tCiB3aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAgfCAzICsrKwogd2luc3VwL2N5
Z3dpbi9zY2hlZC5jYyAgICAgIHwgNSArKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3Jl
bGVhc2UvMy42LjAgYi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAKaW5kZXggNDY4YTJh
YjI0Li4wOWFhNTM3NmUgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjYu
MAorKysgYi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAKQEAgLTQzLDMgKzQzLDYgQEAg
V2hhdCBjaGFuZ2VkOgogCiAtIE5vdyB1c2luZyBBVlgvQVZYMi9BVlgtNTEyIGluc3RydWN0
aW9ucyBpbiBzaWduYWwgaGFuZGxlciBkb2VzIG5vdAogICBicmVhayB0aGVpciBjb250ZXh0
LgorCistIHNjaGVkX3NldHNjaGVkdWxlcigyKSBhbGxvd3MgdG8gY2hhbmdlIHRoZSBwcmlv
cml0eSBpZiB0aGUgcG9saWN5IGlzCisgIGVxdWFsIHRvIHRoZSB2YWx1ZSByZXR1cm5lZCBi
eSBzY2hlZF9nZXRzY2hlZHVsZXIoMikuCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3Nj
aGVkLmNjIGIvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYwppbmRleCA3MWExZTg2OGYuLjMzMzc4
NmY0NCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYworKysgYi93aW5zdXAv
Y3lnd2luL3NjaGVkLmNjCkBAIC0zOTksOCArMzk5LDExIEBAIGludAogc2NoZWRfc2V0c2No
ZWR1bGVyIChwaWRfdCBwaWQsIGludCBwb2xpY3ksCiAJCSAgICBjb25zdCBzdHJ1Y3Qgc2No
ZWRfcGFyYW0gKnBhcmFtKQogeworICBpZiAocG9saWN5ID09IFNDSEVEX0ZJRk8pIC8qIHJl
dHVybmVkIGJ5IHNjaGVkX2dldHNjaGVkdWxlci4gKi8KKyAgICByZXR1cm4gc2NoZWRfc2V0
cGFyYW0gKHBpZCwgcGFyYW0pOworCiAgIC8qIG9uIHdpbjMyLCB5b3UgY2FuJ3QgY2hhbmdl
IHRoZSBzY2hlZHVsZXIuIERvaCEgKi8KLSAgc2V0X2Vycm5vIChFTk9TWVMpOworICBzZXRf
ZXJybm8gKEVJTlZBTCk7CiAgIHJldHVybiAtMTsKIH0KIAotLSAKMi40NS4xCgo=
--------------39D077BD8E8B90932BD903A2--

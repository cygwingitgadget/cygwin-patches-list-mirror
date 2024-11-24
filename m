Return-Path: <SRS0=YD5p=ST=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id 0C5223858D29
	for <cygwin-patches@cygwin.com>; Sun, 24 Nov 2024 10:11:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0C5223858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0C5223858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732443091; cv=none;
	b=KRvGPIYfou36ziVbATAlcsa/lNb9mNU2nKGL3g3WJ3qleBIxiPPEwA4RR+lsqLyUs5OA/I2QG2i1ay5FUWxQsHRosY81AqrhzI14B5ZyHepMtUHMBFzAB9qii6An8cF/PKPbsE11ZFHRmNS4lZMk3OLc+D4JoeanO2vh+pN//Q8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732443091; c=relaxed/simple;
	bh=YjR2+BSYIkVMsimC6tj2TGvk/JlgM6vynzt4Au1VJFc=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=uWjIVgOiq4WUxd9o2TetKsMHdGzDUdRnxZOqmV5CBv2jqxRvWdzikyoOjHrJTk1BZOuDrAFQ10ZUs/dPp6OESGg7WAcCQCUKQCFDBMIBu+/3rjg7R26eJzlpuNld0/xMxGLIDQWDvI6GISDjHn3jWIUTiq+VTLxC2xYmZy2xvx8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0C5223858D29
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
	by mailout02.t-online.de (Postfix) with SMTP id 70D9364A
	for <cygwin-patches@cygwin.com>; Sun, 24 Nov 2024 11:11:27 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd83.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tF9aN-2LOCES0; Sun, 24 Nov 2024 11:11:23 +0100
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: sched_getscheduler: fix error handling
Message-ID: <36a9bf51-b331-bb30-1bd3-2e112d9ec3fa@t-online.de>
Date: Sun, 24 Nov 2024 11:11:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------514BADEEE5E793B3B669BC68"
X-TOI-EXPURGATEID: 150726::1732443083-617ED96B-C9E2A44F/0/0 CLEAN NORMAL
X-TOI-MSGID: ee2e0782-ddc7-46dc-9590-82570852f49f
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------514BADEEE5E793B3B669BC68
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Long standing (2001) minor issue.

-- 
Regards,
Christian


--------------514BADEEE5E793B3B669BC68
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_getscheduler-fix-error-handling.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-sched_getscheduler-fix-error-handling.patch"

RnJvbSBlYjExYTllZTg1NTA4N2FkNWY5MmY3N2VjMzVjMTJjNDNhNzlkYjY0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBTdW4sIDI0IE5vdiAyMDI0IDEwOjQxOjIxICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzY2hlZF9nZXRzY2hlZHVsZXI6IGZpeCBlcnJv
ciBoYW5kbGluZwoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFu
LmZyYW5rZUB0LW9ubGluZS5kZT4KLS0tCiB3aW5zdXAvY3lnd2luL3NjaGVkLmNjIHwgNSAr
KysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MgYi93aW5zdXAvY3lnd2luL3Nj
aGVkLmNjCmluZGV4IDcxYTFlODY4Zi4uMjJmZjBjOGU4IDEwMDY0NAotLS0gYS93aW5zdXAv
Y3lnd2luL3NjaGVkLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKQEAgLTE0MCw3
ICsxNDAsMTAgQEAgaW50CiBzY2hlZF9nZXRzY2hlZHVsZXIgKHBpZF90IHBpZCkKIHsKICAg
aWYgKHBpZCA8IDApCi0gICAgcmV0dXJuIEVTUkNIOworICAgIHsKKyAgICAgIHNldF9lcnJu
byAoRUlOVkFMKTsKKyAgICAgIHJldHVybiAtMTsKKyAgICB9CiAgIGVsc2UKICAgICByZXR1
cm4gU0NIRURfRklGTzsKIH0KLS0gCjIuNDUuMQoK
--------------514BADEEE5E793B3B669BC68--

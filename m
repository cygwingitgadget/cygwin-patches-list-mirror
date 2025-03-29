Return-Path: <SRS0=lP0E=WQ=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id 6169C3858C39
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 15:46:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6169C3858C39
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6169C3858C39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743263219; cv=none;
	b=JI8s7O/Rb2wO2msTAcRispbVHFkRO/iIrlaZCIdMCd3E74VrHQ3XNHMioWJ0G0KSXdanqUA2QZo+KAij+k05SnXBjTCkBjFzljF9L1hLJSlpl9eus9b1W6xfw8LJbQqsIK5f/D9YoYThkLm9HGVW1QpQoFfm2yjpLpXdS2vuES4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743263219; c=relaxed/simple;
	bh=iNGptVR3+m8S3ICGU848Wvr7LlGfBJQow2cfnRwGQ9Y=;
	h=From:Subject:To:Message-ID:Date:MIME-Version; b=fa3yVriMxTVlRQlnDhDUZdJZrY5IP68O7z40IJFg3hQE39JHRVDNXtpgTGXBEpTI5DiT8B7N5Nf22XBUpF2xhoQztA4SvBC+SQlM8tUsVFlHWixhsnjOnkoR9mdJJlqPHUbfQ4cTTdpXF46k1Ff+qMuQQPqXLy46m5Dt5eH3l98=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6169C3858C39
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
	by mailout10.t-online.de (Postfix) with SMTP id 40A58190
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 16:45:47 +0100 (CET)
Received: from [192.168.2.101] ([87.187.37.162]) by fwd85.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tyYNU-1FS14K0; Sat, 29 Mar 2025 16:45:44 +0100
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: faq: add test of fork/exec slowdown by anti-virus
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
Message-ID: <03c6bc1f-8426-1c9c-aa72-29c52d58c803@t-online.de>
Date: Sat, 29 Mar 2025 16:45:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C0D8E3FC7F988A8929C54174"
X-TOI-EXPURGATEID: 150726::1743263144-AA7FB974-EFDE9AF6/0/0 CLEAN NORMAL
X-TOI-MSGID: cfa140cc-5e42-4415-8ffa-c0d08fd852e2
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------C0D8E3FC7F988A8929C54174
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Occasionally useful to see one significant effect of anti-virus software.

BTW, the documentation still uses C:\cygwin as the default install 
directory. This is no longer the case since the retirement of the 32-bit 
version.

-- 
Regards,
Christian


--------------C0D8E3FC7F988A8929C54174
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-faq-add-test-of-fork-exec-slowdown-by-anti-vi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-faq-add-test-of-fork-exec-slowdown-by-anti-vi.pa";
 filename*1="tch"

RnJvbSBhOTQzOGJlOTU2ZGM4MWFjMjM3ZWY3MGY5YzA3OTM0YmE0OTA2ZGFlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBTYXQsIDI5IE1hciAyMDI1IDE2OjM0OjMzICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBmYXE6IGFkZCB0ZXN0IG9mIGZvcmsvZXhlYyBz
bG93ZG93biBieSBhbnRpLXZpcnVzCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtl
IDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRlPgotLS0KIHdpbnN1cC9kb2MvZmFxLXVz
aW5nLnhtbCB8IDIwICsrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjAg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9kb2MvZmFxLXVzaW5nLnhtbCBi
L3dpbnN1cC9kb2MvZmFxLXVzaW5nLnhtbAppbmRleCA0ZGM0NjJhMGEuLmU1ZTQ0NzlmNSAx
MDA2NDQKLS0tIGEvd2luc3VwL2RvYy9mYXEtdXNpbmcueG1sCisrKyBiL3dpbnN1cC9kb2Mv
ZmFxLXVzaW5nLnhtbApAQCAtOTU2LDYgKzk1NiwyNiBAQCBjb250ZW50cyBhcmUgZXhlbXB0
IGZyb20gc2Nhbm5pbmcuICBJbiBhIGRlZmF1bHQgaW5zdGFsbGF0aW9uLCB0aGlzCiB3b3Vs
ZCBiZSA8bGl0ZXJhbD5DOlxjeWd3aW5cYmluPC9saXRlcmFsPi4gIE9idmlvdXNseSwgdGhp
cyBjb3VsZCBiZQogZXhwbG9pdGVkIGJ5IGEgaG9zdGlsZSBub24tQ3lnd2luIHByb2dyYW0s
IHNvIGRvIHRoaXMgYXQgeW91ciBvd24gcmlzay4KIDwvcGFyYT4KKzxwYXJhPkFudGktdmly
dXMgc29mdHdhcmUgdHlwaWNhbGx5IHJlZHVjZSB0aGUgc3BlZWQgb2YgV2luZG93cworPGxp
dGVyYWw+Q3JlYXRlUHJvY2VzczwvbGl0ZXJhbD4gY2FsbHMgd2hpY2ggYXJlIHVzZWQgYnkg
Q3lnd2luIHRvIHByb3ZpZGUKKzxsaXRlcmFsPmZvcmsoKTwvbGl0ZXJhbD4gYW5kIDxsaXRl
cmFsPmV4ZWMoKTwvbGl0ZXJhbD4uICBUaGlzIGluIHBhcnRpY3VsYXIKK3Nsb3dzIGRvd24g
c2hlbGwgc2NyaXB0cy4gIEluIHRoZSBzaW1wbGUgc3BlZWQgdGVzdCBzaG93biBiZWxvdywg
dGhlIGZpcnN0Citjb2x1bW4gc2hvd3MgdGhlIG51bWJlciBvZiA8bGl0ZXJhbD5kYXRlPC9s
aXRlcmFsPiBjb21tYW5kcyBydW4gcGVyIHNlY29uZC4KK0FudGktdmlydXMgd2FzIHR1cm5l
ZCBvZmYgYXQgdGhlIGxpbmUgbWFya2VkIHdpdGggPGxpdGVyYWw+KioqPC9saXRlcmFsPi4K
KzwvcGFyYT4KKzxzY3JlZW4+CisJYmFzaCQgd2hpbGUgOjsgZG8gZGF0ZSArJXM7IGRvbmUg
fCB1bmlxIC1jCisJLi4uCisJMTIyIDE3NDE3MTI0MzAKKwkxMTggMTc0MTcxMjQzMQorCTEx
OCAxNzQxNzEyNDMyCisJMTIxIDE3NDE3MTI0MzMKKwkxNDIgMTc0MTcxMjQzNCAgKioqCisJ
MTQwIDE3NDE3MTI0MzUKKwkxNDEgMTc0MTcxMjQzNgorCTE0NCAxNzQxNzEyNDM3CisJLi4u
Cis8L3NjcmVlbj4KIDxwYXJhPlNlZSBhbHNvIDx4cmVmIGxpbmtlbmQ9ImZhcS51c2luZy5i
bG9kYSI+PC94cmVmPgogZm9yIGEgbGlzdCBvZiBhcHBsaWNhdGlvbnMgdGhhdCBoYXZlIGJl
ZW4ga25vd24sIGF0IG9uZSB0aW1lIG9yIGFub3RoZXIsIHRvCiBpbnRlcmZlcmUgd2l0aCB0
aGUgbm9ybWFsIGZ1bmN0aW9uaW5nIG9mIEN5Z3dpbi4KLS0gCjIuNDUuMQoK
--------------C0D8E3FC7F988A8929C54174--

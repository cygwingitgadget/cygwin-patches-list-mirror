Return-Path: <SRS0=lhM5=QW=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	by sourceware.org (Postfix) with ESMTPS id C789F3858D26
	for <cygwin-patches@cygwin.com>; Tue, 24 Sep 2024 10:09:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C789F3858D26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C789F3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1727172553; cv=none;
	b=WhXbwqSCmHrTfsC6bbfUqfLnkWKZ/173x9yu+TMKsROPwahAdlHfc8/dHjh65J06O7Mn/oHL9CKH299q7UWF6UVaW7PCyqIIQwiOLBUVuYbod+d1I8rqAbQwUPi406GFw8Hl7OhnaqSupFafl4aCNm8WHKrNB+GxELKgAh8b/uI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1727172553; c=relaxed/simple;
	bh=KFqKPPIMGDZKtP2LEVSH1dlQiigc6qw6cvkiaW02B+4=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=ORyjMV/cxDuVmD9/dYNq1Leas6q/0Bav9ht3GmcwsAGdweqViK3HFKDcRy8vphuM1lAOebATAF8YUNr/5IM2ZUGE1CT0SM1UH65bed57thoyPa4h18E7ejIqTD9vR/cA6/cCNh+wuVgqv2bS46b8tg0Pi2DU4ngu4oS1TxUDHEs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
	by mailout04.t-online.de (Postfix) with SMTP id 374A2259FF
	for <cygwin-patches@cygwin.com>; Tue, 24 Sep 2024 12:09:09 +0200 (CEST)
Received: from [192.168.2.101] ([87.187.44.88]) by fwd80.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1st2Th-0PtcZM0; Tue, 24 Sep 2024 12:09:05 +0200
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] cygwin: pread/pwrite: prevent EBADF error after fork()
Message-ID: <9ef0c0ee-23fd-e74e-a925-2d7f973151b2@t-online.de>
Date: Tue, 24 Sep 2024 12:09:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.18.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DEC66751BD2AF3C64E053054"
X-TOI-EXPURGATEID: 150726::1727172545-077FC467-6235FDEE/0/0 CLEAN NORMAL
X-TOI-MSGID: f282e77c-df0d-4d0a-bfea-52316adf2e99
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------DEC66751BD2AF3C64E053054
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This addresses: 
https://sourceware.org/pipermail/cygwin/2024-September/256468.html

-- 
Regards,
Christian


--------------DEC66751BD2AF3C64E053054
Content-Type: text/plain; charset=UTF-8;
 name="0001-cygwin-pread-pwrite-prevent-EBADF-error-after-fork.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-cygwin-pread-pwrite-prevent-EBADF-error-after-fork.patc";
 filename*1="h"

RnJvbSBhNjg4ZTk2MmViNDkzMTQwMDEwYTc1ZGMyNGI2YjQ5YjM0YjdkNTU4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDI0IFNlcCAyMDI0IDExOjU2OjQzICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gY3lnd2luOiBwcmVhZC9wd3JpdGU6IHByZXZlbnQgRUJBREYg
ZXJyb3IgYWZ0ZXIgZm9yaygpCgpJZiB0aGUgcGFyZW50IHByb2Nlc3MgaGFzIGFscmVhZHkg
dXNlZCBwcmVhZCgpIG9yIHB3cml0ZSgpLCB0aGVzZQpmdW5jdGlvbnMgZmFpbCB3aXRoIEVC
QURGIGlmIHVzZWQgb24gdGhlIGluaGVyaXRlZCBmZC4gIEVuc3VyZSB0aGF0CmZpeF9hZnRl
cl9mb3JrKCkgaXMgY2FsbGVkIHRvIGludmFsaWRhdGUgdGhlIHByd19oYW5kbGUuIFRoaXMg
aXNzdWUKaGFzIGJlZW4gZGV0ZWN0ZWQgYnkgJ3N0cmVzcy1uZyAtLXBzZWVrIDEnLgoKU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFuLmZyYW5rZUB0LW9ubGlu
ZS5kZT4KLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyL2Rpc2tfZmlsZS5jYyB8IDMgKysr
CiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9maGFuZGxlci9kaXNrX2ZpbGUuY2MgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVy
L2Rpc2tfZmlsZS5jYwppbmRleCBmNGMyMWQzYjcuLjIwMDhmYjYxYiAxMDA2NDQKLS0tIGEv
d2luc3VwL2N5Z3dpbi9maGFuZGxlci9kaXNrX2ZpbGUuY2MKKysrIGIvd2luc3VwL2N5Z3dp
bi9maGFuZGxlci9kaXNrX2ZpbGUuY2MKQEAgLTE4MDMsNiArMTgwMyw5IEBAIGZoYW5kbGVy
X2Rpc2tfZmlsZTo6cHJ3X29wZW4gKGJvb2wgd3JpdGUsIHZvaWQgKmFpbykKICAgICAgIHJl
dHVybiAtMTsKICAgICB9CiAKKyAgLyogcHJ3X2hhbmRsZSBpcyBpbnZhbGlkIGFmdGVyIGZv
cmsuICovCisgIG5lZWRfZm9ya19maXh1cCAodHJ1ZSk7CisKICAgLyogcmVjb3JkIHByd19o
YW5kbGUncyBhc3luY25lc3MgZm9yIHN1YnNlcXVlbnQgcHJlYWQvcHdyaXRlIG9wZXJhdGlv
bnMgKi8KICAgcHJ3X2hhbmRsZV9pc2FzeW5jID0gISFhaW87CiAgIHJldHVybiAwOwotLSAK
Mi40NS4xCgo=
--------------DEC66751BD2AF3C64E053054--

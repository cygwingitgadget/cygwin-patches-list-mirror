Return-Path: <SRS0=fxJ1=FI=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	by sourceware.org (Postfix) with ESMTPS id 882914BA23E1
	for <cygwin-patches@cygwin.com>; Tue, 14 Jul 2026 16:41:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 882914BA23E1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 882914BA23E1
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=194.25.134.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784047291; cv=none;
	b=a2+YzOcFWZdk1JOG/ea/24NqXQGu7SngfWqdfDrxoVZNIegI493YkOoS3JxL5wZAQpE5OCMUsLp4evTVV18ocAaWPxTXCIKtRpNGcwDwGc49t/6k+7bSNb95I5mKLBvvKY39pLQ2rTMTHPB7tWEOF0PORrJFKUCVOSbgsLa5JGk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784047291; c=relaxed/simple;
	bh=Mx3t8iUMjxBHvDgBO4nb0Y9NVDh5S9PzFxuxeBXVdEY=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:DKIM-Signature; b=hNE/i6EU6puUwWl+VGEfGaqktjSJm2nkr1KdY84Re9pElL5tqrqsOZTW4XMdgR4gTiYp4PhUHXmAg+pWOgQL1nz5tt50cR7nOBMuKMWdjX0/hx71FNlaq1dAgPF1sZebIR6WlYOyBVcE/AQI6kPwCwfmhdr+ulc5ro1bcMahpOQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=kyRxoXc8
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 882914BA23E1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=kyRxoXc8
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
	by mailout04.t-online.de (Postfix) with SMTP id 326E652A
	for <cygwin-patches@cygwin.com>; Tue, 14 Jul 2026 18:41:08 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.161.37]) by fwd89.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1wjgBq-2G6Pw00; Tue, 14 Jul 2026 18:41:02 +0200
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: CI: cygstress: add GHA annotation and change exit
 status
Message-ID: <efcb054e-4e68-2e01-b90a-79c06c095fc4@t-online.de>
Date: Tue, 14 Jul 2026 18:41:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.23
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2D7CCF5895C0CB6A5058D9A8"
X-TOI-EXPURGATEID: 150726::1784047262-39FF896D-60A1EBF4/0/0 CLEAN NORMAL
X-TOI-MSGID: a01ed15f-b20e-47fa-9d63-609fa5da73a2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-online.de;
	s=20260216; t=1784047267; i=Christian.Franke@t-online.de;
	bh=muxU05NhK9tNij4MbUjCMB6Rc4d4+C26i99qk510r1s=;
	h=To:Reply-To:From:Subject:Date;
	b=kyRxoXc8th2lr4mRSHP/TYCMJ5vHRR0RadiT6ZMuynh39WjEhr3NieWZcsiuKyshM
	 +FFUtd3xSki+9zJDdwWydEmIdyz3MJhy+tHyM28cXCObwU/tBY0V3vLbyoPD1GG2jK
	 JCBEwFy5Em6k6slTo+9FfjY7BTprWqk3JYaqYyLxz6eS/rTIe7t4uhcRq5NFTz5Ka8
	 PnBzzBEggAbREgRTEx+TzMFE3dwDV+lzM5j7raemEWVhkig2dRiESGEMJd+RaN/zUz
	 v9Kbcctyv5UhaJSwB7l1uu0+TIzQtaPtoCFh8IPCdY8Hl3fcSPFfxWZHtuqXKd/x7X
	 xH2sVNUggSIag==
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TONLINE_FAKE_DKIM,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------2D7CCF5895C0CB6A5058D9A8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This makes the failed tests visible in the summary of a GH workflow run.

-- 
Regards,
Christian


--------------2D7CCF5895C0CB6A5058D9A8
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-CI-cygstress-add-GHA-annotation-and-change-ex.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-CI-cygstress-add-GHA-annotation-and-change-ex.pa";
 filename*1="tch"

RnJvbSBlMWEwODFiZTVlNjRiZmM1ZTU2NzE2NWRlMGUxZmM5Y2ZmYWNkZDUyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDE0IEp1bCAyMDI2IDE4OjMyOjU2ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBDSTogY3lnc3RyZXNzOiBhZGQgR0hBIGFubm90
YXRpb24gYW5kIGNoYW5nZSBleGl0CiBzdGF0dXMKClJlcG9ydCBsaXN0IG9mIGZhaWxlZCB0
ZXN0cyBhcyBhIEdIQSBjb21wYXRpYmxlIGFubm90YXRpb24uClVzZSBzZXBhcmF0ZSBleGl0
IHN0YXR1cyAyIGluc3RlYWQgb2YgMSBpZiBhbnkgdGVzdCBmYWlsZWQuCgpTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRlPgot
LS0KIHdpbnN1cC90ZXN0c3VpdGUvc3RyZXNzL2N5Z3N0cmVzcyB8IDE1ICsrKysrKysrKysr
KysrLQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS93aW5zdXAvdGVzdHN1aXRlL3N0cmVzcy9jeWdzdHJlc3MgYi93aW5z
dXAvdGVzdHN1aXRlL3N0cmVzcy9jeWdzdHJlc3MKaW5kZXggODBkZmE3OTVmLi5jN2I0YzU3
MjMgMTAwNzU1Ci0tLSBhL3dpbnN1cC90ZXN0c3VpdGUvc3RyZXNzL2N5Z3N0cmVzcworKysg
Yi93aW5zdXAvdGVzdHN1aXRlL3N0cmVzcy9jeWdzdHJlc3MKQEAgLTMxLDYgKzMxLDExIEBA
IFVzYWdlOiAkezAjIyovfSBbT1BUSU9OLi4uXSB7Q0l8V09SS3xGQUlMfHRlc3QuLi59CiAg
IFdPUksgICAgICBydW4gYWxsIHRlc3RzIHRhZ2dlZCBXT1JLUwogICBGQUlMICAgICAgcnVu
IGFsbCB0ZXN0cyB0YWdnZWQgRkFJTFMKICAgdGVzdC4uLiAgIHJ1biBpbmRpdmlkdWFsIHRl
c3QocykgKG1heSByZXF1aXJlICctZicpCisKKyAgRXhpdCBzdGF0dXM6CisgICAgMDogYWxs
IHRlc3RzIHN1Y2NlZWRlZAorICAgIDE6IG90aGVyIGVycm9yCisgICAgMjogc29tZSB0ZXN0
KHMpIGZhaWxlZAogRU9GCiAgIGV4aXQgMQogfQpAQCAtNzQxLDcgKzc0NiwxNSBAQCBpZiBb
ICR0b3RhbF9mYWlsZWQgIT0gMCBdOyB0aGVuCiAKICAgZWNobyAtbiAiPj4+IEZBSUxVUkU6
ICQodHMpOiAkeyN0ZXN0c19mYWlsZWRbKl19IG9mICR0b3RhbF90ZXN0Y2FzZXMgdGVzdCBj
YXNlKHMpIGZhaWxlZCIKICAgZWNobyAiOyB0b3RhbDogJHRvdGFsX2ZhaWxlZCBvZiAkdG90
YWxfdGVzdGVkIHRlc3QocykgZmFpbGVkIgotICBleGl0IDEKKworICAjIFJlcG9ydCBsaXN0
IG9mIGZhaWxlZCB0ZXN0cyBhcyBhIEdIQSBjb21wYXRpYmxlIGFubm90YXRpb24KKyAgZWNo
byAtbiAiOjplcnJvcjo6IHN0cmVzcy1uZyBmYWlsdXJlczoiCisgIGZvciAoKHQgPSAwOyB0
IDwgJHsjdGVzdHNbKl19OyB0KyspKTsgZG8KKyAgICB0ZXN0IC16ICIke3Rlc3RzX2ZhaWxl
ZFt0XX0iIHx8IGVjaG8gLW4gIiAke3Rlc3RzW3RdfSIKKyAgZG9uZQorICBlY2hvCisKKyAg
ZXhpdCAyCiBmaQogCiBlY2hvIC1uICI+Pj4gU1VDQ0VTUzogJCh0cyk6IGFsbCB0ZXN0KHMp
IG9mICR0b3RhbF90ZXN0Y2FzZXMgdGVzdCBjYXNlKHMpIHN1Y2NlZWRlZCIKLS0gCjIuNTEu
MAoK
--------------2D7CCF5895C0CB6A5058D9A8--

Return-Path: <SRS0=D0TC=VM=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 7C9A93858D20
	for <cygwin-patches@cygwin.com>; Fri, 21 Feb 2025 16:34:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7C9A93858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7C9A93858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740155641; cv=none;
	b=tNiqFoQOwO7938x/0stgJ0B5B0FkrFqB/w/zEYVwy4uhPgFvmyBBxPYy9GFJFA09pyQ/XR9mXZaHPRJlOqS7U/8nn06j+FPXrJ6uV9IpQWOviQl8YEVo1O9PDJeXEJzU4vJiOLQQBNMIGnAA8Smkk+u9Hk/TANOS7FFst7tkqGs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740155641; c=relaxed/simple;
	bh=PTBl6MxJ3WEjXZ2Wzg/rBXUKtVu/NKQnBZ1zvvwNtns=;
	h=From:To:Subject:Message-ID:Date:MIME-Version; b=dOxdUTUSZW/7125o+KpZnGPl1EtlqGuNaDDCpoQEO8mTVCRAAvmXKE9ofhkSVb8ArPK9VQrow39Fgt+6UJRRYYzXf//FudzFejo4h3XFR14bKSsa+skE6jfpxEWP95c3cBGWagcCIMcqn9xOTkxUijvf7arF+Uot3juLs+XcfWw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C9A93858D20
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
	by mailout05.t-online.de (Postfix) with SMTP id AC001937
	for <cygwin-patches@cygwin.com>; Fri, 21 Feb 2025 17:32:58 +0100 (CET)
Received: from [192.168.2.102] ([79.230.164.148]) by fwd80.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tlVxO-2xbRcO0; Fri, 21 Feb 2025 17:32:54 +0100
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: sched_setscheduler: Fix crash if pid of other process
 is used
Message-ID: <afe4a843-643e-1254-e1f2-795d3b52c3ac@t-online.de>
Date: Fri, 21 Feb 2025 17:32:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------F382CA8C7DD578FC17BCB788"
X-TOI-EXPURGATEID: 150726::1740155574-577FC501-9FF08A28/0/0 CLEAN NORMAL
X-TOI-MSGID: 11c33265-64f7-4cac-9a2e-b7661db01164
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------F382CA8C7DD578FC17BCB788
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Obviously my testcases for the SCHED_* enhancement were incomplete, sorry.

-- 
Regards,
Christian


--------------F382CA8C7DD578FC17BCB788
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_setscheduler-Fix-crash-if-pid-of-other-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-sched_setscheduler-Fix-crash-if-pid-of-other-.pa";
 filename*1="tch"

RnJvbSBhOWU0OGI1ZDczOGMyYTY4MzgyNmFiMjIwMTU1Nzc4ZjBmNTdmMDAzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBGcmksIDIxIEZlYiAyMDI1IDE3OjI1OjUxICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzY2hlZF9zZXRzY2hlZHVsZXI6IEZpeCBjcmFz
aCBpZiBwaWQgb2Ygb3RoZXIgcHJvY2VzcwogaXMgdXNlZAoKQWRkIG1pc3NpbmcgUElEX01B
UF9SVyB0byBhbGxvdyBjaGFuZ2VzIG9mIF9waW5mbzo6c2NoZWRfcG9saWN5LgoKRml4ZXM6
IDQ4YjE4OTI0NWExMyAoIkN5Z3dpbjogc2NoZWRfc2V0c2NoZWR1bGVyOiBhY2NlcHQgU0NI
RURfT1RIRVIsIFNDSEVEX0ZJRk8gYW5kIFNDSEVEX1JSIikKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFuLmZyYW5rZUB0LW9ubGluZS5kZT4KLS0tCiB3aW5z
dXAvY3lnd2luL3NjaGVkLmNjIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY2hlZC5j
YyBiL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKaW5kZXggNDNiMTczNTdiLi44Njk0MWIyYWMg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKKysrIGIvd2luc3VwL2N5Z3dp
bi9zY2hlZC5jYwpAQCAtNDA2LDcgKzQwNiw3IEBAIHNjaGVkX3NldHNjaGVkdWxlciAocGlk
X3QgcGlkLCBpbnQgcG9saWN5LAogICAgICAgcmV0dXJuIC0xOwogICAgIH0KIAotICBwaW5m
byBwIChwaWQgPyBwaWQgOiBnZXRwaWQgKCkpOworICBwaW5mbyBwICgocGlkID8gcGlkIDog
Z2V0cGlkICgpKSwgUElEX01BUF9SVyk7CiAgIGlmICghcCkKICAgICB7CiAgICAgICBzZXRf
ZXJybm8gKEVTUkNIKTsKLS0gCjIuNDUuMQoK
--------------F382CA8C7DD578FC17BCB788--

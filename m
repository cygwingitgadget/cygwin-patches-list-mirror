Return-Path: <SRS0=/OsX=RI=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 5445B3858D20
	for <cygwin-patches@cygwin.com>; Sat, 12 Oct 2024 16:58:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5445B3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5445B3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728752302; cv=none;
	b=ip+4KCxRUQBdQrl1vX2fGDb5x5fTUIEZncEOkIW0pAaPe2TP2Na3cJfd9yepD7miryhuT+Kc5PsDugb3mocS6kR6ei3OE0muNakfKbMK83LHFtSGASBzJVl45QxncdHydZGrp98DWXXe5b5ppojnc6UonFIupmcnn3/A7n0/G38=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728752302; c=relaxed/simple;
	bh=ZodhBfd9e6T8OUbJx16UwB6M+pHqQP5jN+ZnAufU9Qc=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=hD8s5eO7o95j+8fkWl532xaL9onfLATf2xqGTQ7ySqY1P0+mONAF+D0KP3xKTLU5/uqtw3BWAcqBj6W2OObyZlLUNmvY5RnLGMlAlCq/E/SmYc4u/ve4IjG/NT2hNX9dmfi41/XjUzZkEKiAOP9qhrkWUsF6ngiK6d+k/2tE5RA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
	by mailout05.t-online.de (Postfix) with SMTP id 9361B1D92C
	for <cygwin-patches@cygwin.com>; Sat, 12 Oct 2024 18:58:17 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.171.165]) by fwd71.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1szfRX-1lYc6q0; Sat, 12 Oct 2024 18:58:16 +0200
To: cygwin-patches@cygwin.com
Reply-To: cygwin@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] cygwin: timer_delete: Fix return value
Message-ID: <fb690e19-367f-0741-fffe-90c30df16351@t-online.de>
Date: Sat, 12 Oct 2024 18:58:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.18.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A2DDE4C1635868662D39FF1F"
X-TOI-EXPURGATEID: 150726::1728752296-C57F85D1-E6674A85/0/0 CLEAN NORMAL
X-TOI-MSGID: 316b9a01-9cc5-487e-9ada-cb6d3de1947a
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------A2DDE4C1635868662D39FF1F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Nobody checks the return value of functions which only free resources: 
close(), ..., timer_delete(), ... :-)

-- 
Regards,
Christian


--------------A2DDE4C1635868662D39FF1F
Content-Type: text/plain; charset=UTF-8;
 name="0001-cygwin-timer_delete-Fix-return-value.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-cygwin-timer_delete-Fix-return-value.patch"

RnJvbSAyZDBjNWI1M2JiYTJkZWQ4ZDg1ZWQ3MjU3NzQ0OThjZmZiYjRmMWRlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBTYXQsIDEyIE9jdCAyMDI0IDE4OjQ3OjAwICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gY3lnd2luOiB0aW1lcl9kZWxldGU6IEZpeCByZXR1cm4gdmFs
dWUKCnRpbWVyX2RlbGV0ZSgpIGFsd2F5cyByZXR1cm5lZCBmYWlsdXJlLiAgVGhpcyBpc3N1
ZSBoYXMgYmVlbgpkZXRlY3RlZCBieSAnc3RyZXNzLW5nIC0taHJ0aW1lcnMgMScuCgpTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5l
LmRlPgotLS0KIHdpbnN1cC9jeWd3aW4vcG9zaXhfdGltZXIuY2MgfCAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vcG9z
aXhfdGltZXIuY2MgYi93aW5zdXAvY3lnd2luL3Bvc2l4X3RpbWVyLmNjCmluZGV4IDlkODMy
ZjIwMS4uYTMzNmIyYmMyIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3Bvc2l4X3RpbWVy
LmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vcG9zaXhfdGltZXIuY2MKQEAgLTUzMCw2ICs1MzAs
NyBAQCB0aW1lcl9kZWxldGUgKHRpbWVyX3QgdGltZXJpZCkKIAkgIF9fbGVhdmU7CiAJfQog
ICAgICAgZGVsZXRlIGluX3R0OworICAgICAgcmV0ID0gMDsKICAgICB9CiAgIF9fZXhjZXB0
IChFRkFVTFQpIHt9CiAgIF9fZW5kdHJ5Ci0tIAoyLjQ1LjEKCg==
--------------A2DDE4C1635868662D39FF1F--

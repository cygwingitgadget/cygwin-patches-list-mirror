Return-Path: <SRS0=Juwb=Z5=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
	by sourceware.org (Postfix) with ESMTPS id 0105C3858C24
	for <cygwin-patches@cygwin.com>; Wed, 16 Jul 2025 09:38:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0105C3858C24
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0105C3858C24
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752658713; cv=none;
	b=WeFd6EHrve7vbEsnDhzHGnyykVGfJAWe46+VanzOH043HGqUEB+q3PTVfyfKfa+3Pv4ks3gUePlYADPFD7gkNmV/lTgWpAauuvu2NBR7v9mxOS1sYiFNLQhkeXnIO3R8tqd2+Q08XNqmcsG15XP4i7NOShHscazmwg8Hgj5ljtk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752658713; c=relaxed/simple;
	bh=5lgHQxK2nE+Bmjwn1w10RmMUH+66SmcVsrlcvLQ/v2A=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=sso56iGzYKOZZ9JQ6YTZB8H2AZXmsIkWDmllH+KxYb82ezbFOfrCoXFLJXmOWciymV2bgo8cqkjR9cK83JIZm+AvCjnYe4INtTq9a7CeFIh1chwTLLCvTuWonqym22U7q/ioxFtTt2HD1EdVy+6SEzXnn3+mnHVDFcO4c9Y5MpE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0105C3858C24
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
	by mailout12.t-online.de (Postfix) with SMTP id 437D2E36B
	for <cygwin-patches@cygwin.com>; Wed, 16 Jul 2025 11:38:31 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd80.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1ubyaj-00je7M0; Wed, 16 Jul 2025 11:38:22 +0200
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: doc: add note about raw devices of BitLocker
 partitions
Message-ID: <2c6df85b-efd1-2209-5bf4-41d90b6d27db@t-online.de>
Date: Wed, 16 Jul 2025 11:38:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------334EBEE8CDE53FD806A4B39F"
X-TOI-EXPURGATEID: 150726::1752658702-8A7EADFC-BAC8230E/0/0 CLEAN NORMAL
X-TOI-MSGID: eeb527f4-891c-40fd-b457-7e83f302bb5b
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------334EBEE8CDE53FD806A4B39F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Another un?documented Windows behavior -- occasionally useful in this 
case :)

-- 
Regards,
Christian


--------------334EBEE8CDE53FD806A4B39F
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-doc-add-note-about-raw-devices-of-BitLocker-p.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-doc-add-note-about-raw-devices-of-BitLocker-p.pa";
 filename*1="tch"

RnJvbSA5YTUwNjQzM2VhNDdhYWM3YjE5ZjFlMDNjOTlkODAwZWMyZTU1YjExIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBXZWQsIDE2IEp1bCAyMDI1IDExOjMzOjI1ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBkb2M6IGFkZCBub3RlIGFib3V0IHJhdyBkZXZp
Y2VzIG9mIEJpdExvY2tlcgogcGFydGl0aW9ucwoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFu
IEZyYW5rZSA8Y2hyaXN0aWFuLmZyYW5rZUB0LW9ubGluZS5kZT4KLS0tCiB3aW5zdXAvZG9j
L3NwZWNpYWxuYW1lcy54bWwgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9kb2Mvc3BlY2lhbG5hbWVzLnhtbCBiL3dp
bnN1cC9kb2Mvc3BlY2lhbG5hbWVzLnhtbAppbmRleCAwMjM3NWU3MzcuLjRiMjMyMDAyYSAx
MDA2NDQKLS0tIGEvd2luc3VwL2RvYy9zcGVjaWFsbmFtZXMueG1sCisrKyBiL3dpbnN1cC9k
b2Mvc3BlY2lhbG5hbWVzLnhtbApAQCAtMzYxLDYgKzM2MSwxMiBAQCB0aGUgaW5mb3JtYXRp
b24gYmV0d2VlbiA8ZmlsZW5hbWU+L3Byb2MvcGFydGl0aW9uczwvZmlsZW5hbWU+IGFuZCB0
aGUKIDxjb21tYW5kPmRmPC9jb21tYW5kPiBvdXRwdXQsIHlvdSBzaG91bGQgYmUgYWJsZSB0
byBmaWd1cmUgb3V0IHdoaWNoCiBleHRlcm5hbCBkcml2ZSBjb3JyZXNwb25kcyB0byB3aGlj
aCByYXcgZGlzayBkZXZpY2UgbmFtZS48L3BhcmE+CiAKKzxwYXJhPlJhdyBkZXZpY2VzIG9m
IHBhcnRpdGlvbnMgcHJvdGVjdGVkIGJ5IEJpdExvY2tlciBwcm92aWRlIGFjY2VzcyB0byB0
aGUKKzxlbXBoYXNpcz5kZWNyeXB0ZWQ8L2VtcGhhc2lzPiBOVEZTIGltYWdlLiAgSWYgdGhl
IHBhcnRpdGlvbiBpcyBsb2NrZWQsIHJlYWQKK2F0dGVtcHRzIGZhaWwgd2l0aCA8bGl0ZXJh
bD5QZXJtaXNzaW9uIGRlbmllZDwvbGl0ZXJhbD4uICBUaGUgY29ycmVzcG9uZGluZworYmxv
Y2sgcmFuZ2UgZnJvbSB0aGUgcmF3IGRldmljZSBvZiB0aGUgZnVsbCBkaXNrIHByb3ZpZGVz
IGFjY2VzcyB0byB0aGUKKzxlbXBoYXNpcz5lbmNyeXB0ZWQ8L2VtcGhhc2lzPiBpbWFnZSBh
cyBzdG9yZWQgb24gdGhlIGRpc2suPC9wYXJhPgorCiA8bm90ZT48cGFyYT5BcGFydCBmcm9t
IHRhcGUgZGV2aWNlcyB3aGljaCBhcmUgbm90IGJsb2NrIGRldmljZXMgYW5kIGFyZQogYnkg
ZGVmYXVsdCBhY2Nlc3NlZCBkaXJlY3RseSwgYWNjZXNzaW5nIG1hc3Mgc3RvcmFnZSBkZXZp
Y2VzIHJhdwogaXMgc29tZXRoaW5nIHlvdSBzaG91bGQgb25seSBkbyBpZiB5b3Uga25vdyB3
aGF0IHlvdSdyZSBkb2luZyBhbmQga25vdyBob3cgdG8KLS0gCjIuNDUuMQoK
--------------334EBEE8CDE53FD806A4B39F--

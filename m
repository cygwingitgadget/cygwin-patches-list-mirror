Return-Path: <SRS0=tYd+=Z3=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id 15D283858C54
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 12:58:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 15D283858C54
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 15D283858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752497890; cv=none;
	b=QHBq/N5blmXeGL6iR2dBUKB6BxMehCBU+gPLXq58R67DfcJAVIPV47vk+wccejKTRHRhTCn1srtFQyYpBsUroUetfNN1pE3+FruXcWZdZcFqq8Uc6FaaNjXwKyAfFvVekfXOT7eZLUEvadGCqv75gV3mvZkcfhWqT36N+trrcaM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752497890; c=relaxed/simple;
	bh=PbIqDRs+J6hveqbF4V7fzrqFIgzAXRszvEtOPgdB8+U=;
	h=From:Subject:To:Message-ID:Date:MIME-Version; b=eGDtzXEm9qmmWbuY/pnC3YEKisN0HMMpUJElaPEQuueVmK2kNfIZOXETCGIup55DPt4b4vuWnz6+nQAlYLEDCtJPIgz5LZfM+XWTTIyuD5zX3Belx8GwY136F/8ou/m50HnJXihNBPkP99vWmpH4ZyjDGva3Xt4SzGtioQoE490=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 15D283858C54
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
	by mailout02.t-online.de (Postfix) with SMTP id 14749E723
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 14:58:08 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd87.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1ubIkw-1XqMt60; Mon, 14 Jul 2025 14:58:06 +0200
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: doc: warn about unprivileged access to raw devices
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
Message-ID: <7d18c6c8-3d74-0f97-cf45-05a7a263c386@t-online.de>
Date: Mon, 14 Jul 2025 14:58:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E1A5C62D1A8C8AF1BD020007"
X-TOI-EXPURGATEID: 150726::1752497886-CB7EB165-6EB0C1BB/0/0 CLEAN NORMAL
X-TOI-MSGID: ca4283d5-1c9f-41cb-92b3-8592d66bd7eb
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------E1A5C62D1A8C8AF1BD020007
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Regards,
Christian


--------------E1A5C62D1A8C8AF1BD020007
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-doc-warn-about-unprivileged-access-to-raw-dev.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-doc-warn-about-unprivileged-access-to-raw-dev.pa";
 filename*1="tch"

RnJvbSAzNDRhMzI5YTU3MDZkZTEyNWIzZWYxMWRjNzMyNDEwMWIwOGIzYzY3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDE0IEp1bCAyMDI1IDE0OjQ0OjAxICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBkb2M6IHdhcm4gYWJvdXQgdW5wcml2aWxlZ2Vk
IGFjY2VzcyB0byByYXcgZGV2aWNlcwoKUmF3IGRldmljZXMgb2YgcGFydGl0aW9ucyBtYXkg
YmUgYWNjZXNzaWJsZSBmcm9tIHVucHJpdmlsZWdlZApwcm9jZXNzZXMsIGZvciBleGFtcGxl
IGlmIGNvbm5lY3RlZCB2aWEgVVNCLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5r
ZSA8Y2hyaXN0aWFuLmZyYW5rZUB0LW9ubGluZS5kZT4KLS0tCiB3aW5zdXAvZG9jL3NwZWNp
YWxuYW1lcy54bWwgfCAxMCArKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2RvYy9zcGVjaWFs
bmFtZXMueG1sIGIvd2luc3VwL2RvYy9zcGVjaWFsbmFtZXMueG1sCmluZGV4IGExZjlkM2Y1
ZS4uMDIzNzVlNzM3IDEwMDY0NAotLS0gYS93aW5zdXAvZG9jL3NwZWNpYWxuYW1lcy54bWwK
KysrIGIvd2luc3VwL2RvYy9zcGVjaWFsbmFtZXMueG1sCkBAIC0zNjgsNyArMzY4LDE1IEBA
IGhhbmRsZSB0aGUgaW5mb3JtYXRpb24uICA8ZW1waGFzaXMgcm9sZT0nYm9sZCc+V3JpdGlu
ZzwvZW1waGFzaXM+IHRvIGEgcmF3CiBtYXNzIHN0b3JhZ2UgZGV2aWNlIHlvdSBzaG91bGQg
b25seSBkbyBpZiB5b3UKIDxlbXBoYXNpcyByb2xlPSdib2xkJz5yZWFsbHk8L2VtcGhhc2lz
PiBrbm93IHdoYXQgeW91J3JlIGRvaW5nIGFuZCBhcmUgYXdhcmUKIG9mIHRoZSBmYWN0IHRo
YXQgYW55IG1pc3Rha2UgY2FuIGRlc3Ryb3kgaW1wb3J0YW50IGluZm9ybWF0aW9uLCBmb3Ig
dGhlCi1kZXZpY2UsIGFuZCBmb3IgeW91LiAgU28sIHBsZWFzZSwgaGFuZGxlIHRoaXMgYWJp
bGl0eSB3aXRoIGNhcmUuCitkZXZpY2UsIGFuZCBmb3IgeW91LiAgU28sIHBsZWFzZSwgaGFu
ZGxlIHRoaXMgYWJpbGl0eSB3aXRoIGNhcmUuPC9wYXJhPgorCis8cGFyYT48ZW1waGFzaXMg
cm9sZT0nYm9sZCc+SW1wb3J0YW50OjwvZW1waGFzaXM+IFdpbmRvd3MgbWF5IGFsbG93IHJh
dyByZWFkCis8ZW1waGFzaXMgcm9sZT0nYm9sZCc+YW5kIHdyaXRlPC9lbXBoYXNpcz4gYWNj
ZXNzIHRvIHBhcnRpdGlvbnMgKGZvciBleGFtcGxlCis8ZmlsZW5hbWU+L2Rldi9zZGEyPC9m
aWxlbmFtZT4pIGV2ZW4gZnJvbSB1bnByaXZpbGVnZWQgcHJvY2Vzc2VzLiAgVGhpcyBpcwor
dXN1YWxseSB0aGUgY2FzZSBmb3IgcGFydGl0aW9ucyBvbiAicmVtb3ZhYmxlIiBkcml2ZXMg
bGlrZSBVU0IgZmxhc2ggZHJpdmVzCitvciByZWd1bGFyIFNBVEEvTlZNZSBkcml2ZXMgYmVo
aW5kIFVTQiBkb2NraW5nIHN0YXRpb25zLiAgSWYKKzxjb21tYW5kPmNoa2RzayBYOjwvY29t
bWFuZD4gd29ya3MsIHJhdyBhY2Nlc3MgdG8gdGhlIHNhbWUgcGFydGl0aW9uIGlzCitwb3Nz
aWJsZSBmcm9tIHRoZSBzYW1lIHVzZXIgYWNjb3VudC4KIDxlbXBoYXNpcyByb2xlPSdib2xk
Jz5Zb3UgaGF2ZSBiZWVuIHdhcm5lZC48L2VtcGhhc2lzPjwvcGFyYT48L25vdGU+CiAKIDxw
YXJhPgotLSAKMi40NS4xCgo=
--------------E1A5C62D1A8C8AF1BD020007--

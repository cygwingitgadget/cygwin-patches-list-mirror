Return-Path: <SRS0=O8Rr=KD=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 9658A3858C62
	for <cygwin-patches@cygwin.com>; Mon, 26 Feb 2024 14:21:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9658A3858C62
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9658A3858C62
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1708957310; cv=none;
	b=deSQK+qk+JL0K4GcJIwPOTz+vl5MjuCT2JuaOz53yM6sZhSbliYT9374XcfhEzdX13yaWs+rgZD6VOaldgohhGIl5IVCgsPddOTl4bKfIarf1oQosWdWmQzowbn1dGVvzzXN4Ld2ueNUOW3VvVXrQn0A5/zeYOaUIYd+eygQKw8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1708957310; c=relaxed/simple;
	bh=ls5EOvU9aL/HTwuGeSe22GDFX69UjMK6rqOnKsJSOic=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=HyLjQRYEdtmCVxdl0qFyweHZZ97NMGtD5unl1kR51hYsrd7FRoLiNtaAhQPdsDIkuK+8HDkefyDo3EVE1QhvXn6TVSKkd1yFFgyE5qmrhoehl7zv6/KX9BoNEH6dMBHBrhqR4JF+qkKbXVJ43FKesfxNSZiFqV2KRcNEArZgMYk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
	by mailout05.t-online.de (Postfix) with SMTP id 456B716818
	for <cygwin-patches@cygwin.com>; Mon, 26 Feb 2024 15:21:46 +0100 (CET)
Received: from [192.168.2.102] ([87.187.47.57]) by fwd82.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rebrU-1VBeam0; Mon, 26 Feb 2024 15:21:44 +0100
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 1/4] Cygwin: introduce constexpr errmap_size and errmap[]
 consistency checks
Message-ID: <7f17e15c-ef28-06fd-3a6d-cac60a651960@t-online.de>
Date: Mon, 26 Feb 2024 15:21:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A4986363778FADF637476867"
X-TOI-EXPURGATEID: 150726::1708957304-04981954-7369F273/0/0 CLEAN NORMAL
X-TOI-MSGID: b73a1fe7-6404-4f9f-989e-8ac71d969e08
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------A4986363778FADF637476867
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------A4986363778FADF637476867
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-introduce-constexpr-errmap_size-and-errmap-co.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-introduce-constexpr-errmap_size-and-errmap-co.pa";
 filename*1="tch"

RnJvbSA5NDdkYWEwMmIwYjY0MTMxNjI2YzJlY2VkYjc0Y2E2ODkzYWFiNmM2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDI2IEZlYiAyMDI0IDEzOjM3OjMzICswMTAw
ClN1YmplY3Q6IFtQQVRDSCAxLzRdIEN5Z3dpbjogaW50cm9kdWNlIGNvbnN0ZXhwciBlcnJt
YXBfc2l6ZSBhbmQgZXJybWFwW10KIGNvbnNpc3RlbmN5IGNoZWNrcwoKVXNlIGNvbnN0ZXhw
ciBpbnN0ZWFkIG9mIGNvbnN0IGZvciBlcnJtYXBbXSB0byBhbGxvdyBzdGF0aWNfYXNzZXJ0
CmNoZWNrcyBvbiBpdHMgdmFsdWVzLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5r
ZSA8Y2hyaXN0aWFuLmZyYW5rZUB0LW9ubGluZS5kZT4KLS0tCiB3aW5zdXAvY3lnd2luL2Vy
cm5vLmNjICAgICAgICAgICAgICAgIHwgIDIgKy0KIHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5j
bHVkZXMvZXJybWFwLmggfCAxMSArKysrKysrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3
aW4vZXJybm8uY2MgYi93aW5zdXAvY3lnd2luL2Vycm5vLmNjCmluZGV4IDFjODVlOWEwNC4u
N2Q1OGU2MmVjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2Vycm5vLmNjCisrKyBiL3dp
bnN1cC9jeWd3aW4vZXJybm8uY2MKQEAgLTE4NSw3ICsxODUsNyBAQCBnZXRlcnJub19mcm9t
X3dpbl9lcnJvciAoRFdPUkQgY29kZSwgaW50IGRlZmVycm5vKQogewogICAvKiBBIDAtdmFs
dWUgaW4gZXJybWFwIG1lYW5zLCB3ZSBkb24ndCBoYW5kbGUgdGhpcyB3aW5kb3dzIGVycm9y
CiAgICAgIGV4cGxpY2l0ZWx5LiAgRmFsbCBiYWNrIHRvIGRlZmVycm5vIGluIHRoZXNlIGNh
c2VzLiAqLwotICBpZiAoY29kZSA8IHNpemVvZiBlcnJtYXAgLyBzaXplb2YgZXJybWFwWzBd
ICYmIGVycm1hcFtjb2RlXSkKKyAgaWYgKGNvZGUgPCBlcnJtYXBfc2l6ZSAmJiBlcnJtYXBb
Y29kZV0pCiAgICAgewogICAgICAgc3lzY2FsbF9wcmludGYgKCJ3aW5kb3dzIGVycm9yICV1
ID09IGVycm5vICVkIiwgY29kZSwgZXJybWFwW2NvZGVdKTsKICAgICAgIHJldHVybiBlcnJt
YXBbY29kZV07CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2Vy
cm1hcC5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9lcnJtYXAuaAppbmRleCBh
MGIzZmY0MDAuLjczN2MwMWM4YiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9p
bmNsdWRlcy9lcnJtYXAuaAorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2Vy
cm1hcC5oCkBAIC0zLDcgKzMsNyBAQAogICAgdG8gdGhpcyBuZXcgYXJyYXkgbWFudWFsbHkg
b24gZGVtYW5kLiAqLwogCiAvKiBGSVhNRTogU29tZSBvZiB0aGVzZSBjaG9pY2VzIGFyZSBh
cmJpdHJhcnkhICovCi1zdGF0aWMgY29uc3QgaW50IGVycm1hcFtdID0KK2NvbnN0ZXhwciBp
bnQgZXJybWFwW10gPQogewogICAwLAkJCS8qIEVSUk9SX1NVQ0NFU1MgKi8KICAgRUJBRFJR
QywJCS8qIEVSUk9SX0lOVkFMSURfRlVOQ1RJT04gKi8KQEAgLTkwMDYsMyArOTAwNiwxMiBA
QCBzdGF0aWMgY29uc3QgaW50IGVycm1hcFtdID0KICAgMCwJCQkvKiA4OTk4ICovCiAgIDAs
CQkJLyogODk5OSAqLwogfTsKKworY29uc3RleHByIHVuc2lnbmVkIGVycm1hcF9zaXplID0g
c2l6ZW9mIChlcnJtYXApIC8gc2l6ZW9mIChlcnJtYXBbMF0pOworCisvKiBTb21lIGNvbnNp
c3RlbmN5IGNoZWNrcy4gKi8KK3N0YXRpY19hc3NlcnQgKGVycm1hcF9zaXplID09IDg5OTkg
KyAxKTsKK3N0YXRpY19hc3NlcnQgKEVJTlRSID09IGVycm1hcFsvKiAxMDQgKi8gRVJST1Jf
SU5WQUxJRF9BVF9JTlRFUlJVUFRfVElNRV0pOworc3RhdGljX2Fzc2VydCAoRU5YSU8gPT0g
ZXJybWFwWy8qIDEwMDYgKi8gRVJST1JfRklMRV9JTlZBTElEXSk7CitzdGF0aWNfYXNzZXJ0
IChFQUdBSU4gPT0gZXJybWFwWy8qIDI0MDQgKi8gRVJST1JfREVWSUNFX0lOX1VTRV0pOwor
c3RhdGljX2Fzc2VydCAoRUlPID09IGVycm1hcFsvKiA4MzQxICovIEVSUk9SX0RTX0dFTkVS
SUNfRVJST1JdKTsKLS0gCjIuNDMuMAoK
--------------A4986363778FADF637476867--

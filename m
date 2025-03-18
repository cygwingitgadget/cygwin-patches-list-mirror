Return-Path: <SRS0=e1NL=WF=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by sourceware.org (Postfix) with ESMTPS id 9402D3858D29
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 11:20:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9402D3858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9402D3858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742296818; cv=none;
	b=wIQsvmPB24xlg+eswGwT+7iGF/ExHaF5Mo9HQz0JcxO8BFtIKSGtSzr21dnr90yj4MLVQqEfj3+kMm3NEw4W71N54kNyMUttfnrjGzMpP5+a6qOzOmmN4a8ttQAluZDg10UivSwcEH/f50MrqhmF9F1FA+xK2Ioi24BrQdokis0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742296818; c=relaxed/simple;
	bh=WetxkxtRfcwGz/1grpEmLKK9fmV1EbL45zr73ANYD/s=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=Jqzmsxq/d3VKgmABAyNHD8sz6pGHQdxYgxA6iE0ZUI6lW6UBO3STtOGcCu6NJLGTDYRqrV2LPWypT8zijoCud1FuO3vJUTXdASqbiFVXceWvV6rVZ3ASTQh7FReKmWltIkkj5N140KJS9eJTbb/kJ9JJgZjQCrz/E4+rTWGsSNs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9402D3858D29
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
	by mailout08.t-online.de (Postfix) with SMTP id 9774215C8
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 12:20:16 +0100 (CET)
Received: from [192.168.2.101] ([87.187.37.162]) by fwd87.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tuUzW-26V53A0; Tue, 18 Mar 2025 12:20:14 +0100
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: doc: rename sched_setpolicy(2) to
 sched_setscheduler(2)
Message-ID: <2e4668e3-17ac-8a5a-60b8-dbf2e8514798@t-online.de>
Date: Tue, 18 Mar 2025 12:20:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7531F7D6B7FE820AB0EA4701"
X-TOI-EXPURGATEID: 150726::1742296814-F67EDDA5-D44851FC/0/0 CLEAN NORMAL
X-TOI-MSGID: 1b09a53c-f307-43a7-ae95-59e87f6f4e9b
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------7531F7D6B7FE820AB0EA4701
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------7531F7D6B7FE820AB0EA4701
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-doc-rename-sched_setpolicy-2-to-sched_setsche.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-doc-rename-sched_setpolicy-2-to-sched_setsche.pa";
 filename*1="tch"

RnJvbSA0ZjRiNTEzNWUyMjljYWJhY2Q0NDVlNDczOGRiZGM3ZjhjZWU0NWE0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDE4IE1hciAyMDI1IDEyOjE1OjEyICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBkb2M6IHJlbmFtZSBzY2hlZF9zZXRwb2xpY3ko
MikgdG8KIHNjaGVkX3NldHNjaGVkdWxlcigyKQoKVGhlIGZ1bmN0aW9uIHNjaGVkX3NldHBv
bGljeSgyKSBkb2VzIG5vdCBleGlzdC4KCkZpeGVzOiA3NTc0MjRmNzQ0MDAgKCJDeWd3aW46
IGRvYzogZG9jdW1lbnQgc2NoZWRfc2V0cG9saWN5KDIpIGFuZCBwcmlvcml0eSBtYXBwaW5n
IikKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFuLmZyYW5rZUB0
LW9ubGluZS5kZT4KLS0tCiB3aW5zdXAvZG9jL3Bvc2l4LnhtbCB8IDQgKystLQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS93aW5zdXAvZG9jL3Bvc2l4LnhtbCBiL3dpbnN1cC9kb2MvcG9zaXgueG1sCmluZGV4IDc0
OGYyNDNmNi4uZDRhNGUwZDgzIDEwMDY0NAotLS0gYS93aW5zdXAvZG9jL3Bvc2l4LnhtbAor
KysgYi93aW5zdXAvZG9jL3Bvc2l4LnhtbApAQCAtMTkxNyw3ICsxOTE3LDcgQEAgYXRvbWlj
IGVpdGhlci4gIE92ZXItYWxsb2NhdGlvbiB3aXRoIEZBTExPQ19GTF9LRUVQX1NJWkUgaXMg
b25seQogdGVtcG9yYXJ5IG9uIFdpbmRvd3MgdW50aWwgdGhlIGxhc3QgaGFuZGxlIHRvIHRo
ZSBmaWxlIGlzIGNsb3NlZC4KIE92ZXItYWxsb2NhdGlvbiBvbiBzcGFyc2UgZmlsZXMgaXMg
ZW50aXJlbHkgaWdub3JlZCBvbiBXaW5kb3dzLjwvcGFyYT4KIAotPHBhcmE+PGZ1bmN0aW9u
PnNjaGVkX3NldHBvbGljeTwvZnVuY3Rpb24+IG9ubHkgZW11bGF0ZXMgQVBJIGJlaGF2aW9y
Cis8cGFyYT48ZnVuY3Rpb24+c2NoZWRfc2V0c2NoZWR1bGVyPC9mdW5jdGlvbj4gb25seSBl
bXVsYXRlcyBBUEkgYmVoYXZpb3IKIGJlY2F1c2UgV2luZG93cyBkb2VzIG5vdCBvZmZlciBh
bHRlcm5hdGl2ZSBzY2hlZHVsaW5nIHBvbGljaWVzLgogSWYgPGxpdGVyYWw+U0NIRURfT1RI
RVI8L2xpdGVyYWw+IG9yIDxsaXRlcmFsPlNDSEVEX0JBVENIPC9saXRlcmFsPiBpcwogc2Vs
ZWN0ZWQsIHRoZSBXaW5kb3dzIHByaW9yaXR5IGlzIHNldCBhY2NvcmRpbmcgdG8gdGhlIG5p
Y2UgdmFsdWUuCkBAIC0xOTMxLDcgKzE5MzEsNyBAQCBwb2xpY2llcyBhbmQgbmVnYXRpdmUg
bmljZSB2YWx1ZXMgYXJlIGRyb3BwZWQgb24KIDxmdW5jdGlvbj5mb3JrPC9mdW5jdGlvbj4u
PC9wYXJhPgogCiA8cGFyYT48ZnVuY3Rpb24+bmljZTwvZnVuY3Rpb24+LCA8ZnVuY3Rpb24+
c2V0cHJpb3JpdHk8L2Z1bmN0aW9uPiwKLTxmdW5jdGlvbj5zY2hlZF9zZXRwYXJhbTwvZnVu
Y3Rpb24+IGFuZCA8ZnVuY3Rpb24+c2NoZWRfc2V0cG9saWN5PC9mdW5jdGlvbj4KKzxmdW5j
dGlvbj5zY2hlZF9zZXRwYXJhbTwvZnVuY3Rpb24+IGFuZCA8ZnVuY3Rpb24+c2NoZWRfc2V0
c2NoZWR1bGVyPC9mdW5jdGlvbj4KIG1hcCB0aGUgbmljZSB2YWx1ZSAoPGxpdGVyYWw+U0NI
RURfT1RIRVI8L2xpdGVyYWw+LAogPGxpdGVyYWw+U0NIRURfQkFUQ0g8L2xpdGVyYWw+KSBv
ciB0aGUgPGxpdGVyYWw+c2NoZWRfcHJpb3JpdHk8L2xpdGVyYWw+CiAoPGxpdGVyYWw+U0NI
RURfRklGTzwvbGl0ZXJhbD4sIDxsaXRlcmFsPlNDSEVEX1JSPC9saXRlcmFsPikgdG8gV2lu
ZG93cwotLSAKMi40NS4xCgo=
--------------7531F7D6B7FE820AB0EA4701--

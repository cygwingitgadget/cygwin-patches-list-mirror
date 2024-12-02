Return-Path: <SRS0=uN41=S3=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
	by sourceware.org (Postfix) with ESMTPS id D9E7A3858C31
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 17:33:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D9E7A3858C31
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D9E7A3858C31
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.84
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733160795; cv=none;
	b=LRu9DXKeajZ9H8MUYfhUWvpjGJxo6WZKgGuwmm9ya7A6PK8+8gucJUfu/Ptrk6f1CKqayOXtnEElPKkVPsDFGDhbO3VIL3Kq7V692JUixEv9AW+qitHGvNax9xq7W/I5rDfynV9wLUvYOSMnZbELxF6TtSLjDRvlzyoweiaD99E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733160795; c=relaxed/simple;
	bh=DG9s8dqeOw0YqYOQcNIivU2Ug2dJ9iz9sMIKDBuGkb0=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=f++LWaTX8eBtXGInsPsqlGB9Dcm7HxQwUeReoFi/qKy0IMBdr+bz+GJ3O/hCQdnKxCbzH3Rb0i3DK02K8uDYRKfiSnxmU8nLBn90lIligxile+PyA30SPFKoKO/Ezk/aOmqaSPykTjYTxXi7Q3Gcg0JyANh4MjqrA0Y9YV7/pyM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D9E7A3858C31
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
	by mailout09.t-online.de (Postfix) with SMTP id E5CE1818
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 18:33:12 +0100 (CET)
Received: from [192.168.2.103] ([91.57.250.70]) by fwd77.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tIAIJ-2qxnP60; Mon, 2 Dec 2024 18:33:11 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
Date: Mon, 2 Dec 2024 18:33:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------A3BFEBC941498B957F20DE82"
X-TOI-EXPURGATEID: 150726::1733160791-727E2864-DC856EC3/0/0 CLEAN NORMAL
X-TOI-MSGID: 24946ac0-0c22-4349-8cdb-b7f89eea4241
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------A3BFEBC941498B957F20DE82
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On Nov 29 18:48, Christian Franke wrote:
>> A very first attempt to let sched_setscheduler() do something possibly
>> useful.
>>
>> This patch is on top of
>> Cygwin: setpriority, sched_setparam: add missing process access right
>
> Looks quite nice.  If you're confident this is ready for the main
> branch, just give the word!

Yes, initial tests look good. Related documentation update attached.


--------------A3BFEBC941498B957F20DE82
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-doc-document-sched_setpolicy-2-and-priority-m.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-doc-document-sched_setpolicy-2-and-priority-m.pa";
 filename*1="tch"

RnJvbSA3YjQyMmM1NWExMjBjNTIzNTUwZWZjMzQyM2YyMzA2MzBkMDgyZmFjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDIgRGVjIDIwMjQgMTg6Mjc6MjIgKzAxMDAK
U3ViamVjdDogW1BBVENIXSBDeWd3aW46IGRvYzogZG9jdW1lbnQgc2NoZWRfc2V0cG9saWN5
KDIpIGFuZCBwcmlvcml0eSBtYXBwaW5nCgpEb2N1bWVudCB0aGUgbG9uZyBzdGFuZGluZyBt
YXBwaW5nIGZyb20gbmljZSBvciBzY2hlZF9wcmlvcml0eQp2YWx1ZXMgdG8gV2luZG93cyBw
cmlvcml0eSBjbGFzc2VzIGFuZCB0aGUgbmV3IGJlaGF2aW9yIG9mCnNjaGVkX3NldHBvbGlj
eSg4KS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlzdGlhbi5mcmFu
a2VAdC1vbmxpbmUuZGU+Ci0tLQogd2luc3VwL2RvYy9wb3NpeC54bWwgfCAzNCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvZG9jL3Bvc2l4
LnhtbCBiL3dpbnN1cC9kb2MvcG9zaXgueG1sCmluZGV4IDg5MDU2OTE1Yi4uNDM2YWIwMGE3
IDEwMDY0NAotLS0gYS93aW5zdXAvZG9jL3Bvc2l4LnhtbAorKysgYi93aW5zdXAvZG9jL3Bv
c2l4LnhtbApAQCAtNjAxLDcgKzYwMSw3IEBAIGFsc28gSUVFRSBTdGQgMTAwMy4xLTIwMTcg
KFBPU0lYLjEtMjAxNykuPC9wYXJhPgogICAgIG5leHR0b3dhcmRmCiAgICAgbmV4dHRvd2Fy
ZGwKICAgICBuZnR3Ci0gICAgbmljZQorICAgIG5pY2UJCQkoc2VlIDx4cmVmIGxpbmtlbmQ9
InN0ZC1ub3RlcyI+Y2hhcHRlciAiSW1wbGVtZW50YXRpb24gTm90ZXMiPC94cmVmPikKICAg
ICBubF9sYW5naW5mbwogICAgIG5sX2xhbmdpbmZvX2wKICAgICBucmFuZDQ4CkBAIC04MTgs
OCArODE4LDggQEAgYWxzbyBJRUVFIFN0ZCAxMDAzLjEtMjAxNyAoUE9TSVguMS0yMDE3KS48
L3BhcmE+CiAgICAgc2NoZWRfZ2V0cGFyYW0KICAgICBzY2hlZF9nZXRzY2hlZHVsZXIKICAg
ICBzY2hlZF9ycl9nZXRfaW50ZXJ2YWwKLSAgICBzY2hlZF9zZXRwYXJhbQotICAgIHNjaGVk
X3NldHNjaGVkdWxlcgorICAgIHNjaGVkX3NldHBhcmFtCQkoc2VlIDx4cmVmIGxpbmtlbmQ9
InN0ZC1ub3RlcyI+Y2hhcHRlciAiSW1wbGVtZW50YXRpb24gTm90ZXMiPC94cmVmPikKKyAg
ICBzY2hlZF9zZXRzY2hlZHVsZXIJCShzZWUgPHhyZWYgbGlua2VuZD0ic3RkLW5vdGVzIj5j
aGFwdGVyICJJbXBsZW1lbnRhdGlvbiBOb3RlcyI8L3hyZWY+KQogICAgIHNjaGVkX3lpZWxk
CiAgICAgc2VlZDQ4CiAgICAgc2Vla2RpcgpAQCAtODU0LDcgKzg1NCw3IEBAIGFsc28gSUVF
RSBTdGQgMTAwMy4xLTIwMTcgKFBPU0lYLjEtMjAxNykuPC9wYXJhPgogICAgIHNldGxvZ21h
c2sKICAgICBzZXRwZ2lkCiAgICAgc2V0cGdycAotICAgIHNldHByaW9yaXR5CisgICAgc2V0
cHJpb3JpdHkJCQkoc2VlIDx4cmVmIGxpbmtlbmQ9InN0ZC1ub3RlcyI+Y2hhcHRlciAiSW1w
bGVtZW50YXRpb24gTm90ZXMiPC94cmVmPikKICAgICBzZXRwcm90b2VudAogICAgIHNldHB3
ZW50CiAgICAgc2V0cmVnaWQKQEAgLTE3NjksNiArMTc2OSwzMiBAQCBhdG9taWMgZWl0aGVy
LiAgT3Zlci1hbGxvY2F0aW9uIHdpdGggRkFMTE9DX0ZMX0tFRVBfU0laRSBpcyBvbmx5CiB0
ZW1wb3Jhcnkgb24gV2luZG93cyB1bnRpbCB0aGUgbGFzdCBoYW5kbGUgdG8gdGhlIGZpbGUg
aXMgY2xvc2VkLgogT3Zlci1hbGxvY2F0aW9uIG9uIHNwYXJzZSBmaWxlcyBpcyBlbnRpcmVs
eSBpZ25vcmVkIG9uIFdpbmRvd3MuPC9wYXJhPgogCis8cGFyYT48ZnVuY3Rpb24+c2NoZWRf
c2V0cG9saWN5PC9mdW5jdGlvbj4gb25seSBlbXVsYXRlcyBBUEkgYmVoYXZpb3IKK2JlY2F1
c2UgV2luZG93cyBkb2VzIG5vdCBvZmZlciBhbHRlcm5hdGl2ZSBzY2hlZHVsaW5nIHBvbGlj
aWVzLgorSWYgPGxpdGVyYWw+U0NIRURfT1RIRVI8L2xpdGVyYWw+IGlzIHNlbGVjdGVkLCB0
aGUgV2luZG93cyBwcmlvcml0eSBpcworc2V0IGFjY29yZGluZyB0byB0aGUgbmljZSB2YWx1
ZS4gIElmIDxsaXRlcmFsPlNDSEVEX0ZJRk88L2xpdGVyYWw+CitvciA8bGl0ZXJhbD5TQ0hF
RF9SUjwvbGl0ZXJhbD4gaXMgc2VsZWN0ZWQsIHRoZSBuaWNlIHZhbHVlIGlzIHByZXNlcnZl
ZAorYW5kIHRoZSBXaW5kb3dzIHByaW9yaXR5IGlzIHNldCBhY2NvcmRpbmcgdG8gdGhlCis8
bGl0ZXJhbD5zY2hlZF9wcmlvcml0eTwvbGl0ZXJhbD4gdmFsdWUuPC9wYXJhPgorCis8cGFy
YT48ZnVuY3Rpb24+bmljZTwvZnVuY3Rpb24+LCA8ZnVuY3Rpb24+c2V0cHJpb3JpdHk8L2Z1
bmN0aW9uPiwKKzxmdW5jdGlvbj5zY2hlZF9zZXRwYXJhbTwvZnVuY3Rpb24+IGFuZCA8ZnVu
Y3Rpb24+c2NoZWRfc2V0cG9saWN5PC9mdW5jdGlvbj4KK21hcCB0aGUgbmljZSB2YWx1ZSAo
PGxpdGVyYWw+U0NIRURfT1RIRVI8L2xpdGVyYWw+KSBvciB0aGUKKzxsaXRlcmFsPnNjaGVk
X3ByaW9yaXR5PC9saXRlcmFsPiAoPGxpdGVyYWw+U0NIRURfRklGTzwvbGl0ZXJhbD4sCis8
bGl0ZXJhbD5TQ0hFRF9SUjwvbGl0ZXJhbD4pIHRvIFdpbmRvd3MgcHJpb3JpdHkgY2xhc3Nl
cyBhcyBmb2xsb3dzOjwvcGFyYT4KKzxzY3JlZW4+CisgICAgbmljZSB2YWx1ZSAgIHNjaGVk
X3ByaW9yaXR5ICAgV2luZG93cyBwcmlvcml0eSBjbGFzcworICAgICAxMi4uLjE5ICAgICAg
MS4uLi42ICAgICAgICAgIElETEVfUFJJT1JJVFlfQ0xBU1MKKyAgICAgIDQuLi4xMSAgICAg
IDcuLi4xMiAgICAgICAgICBCRUxPV19OT1JNQUxfUFJJT1JJVFlfQ0xBU1MKKyAgICAgLTQu
Li4uMyAgICAgMTMuLi4xOCAgICAgICAgICBOT1JNQUxfUFJJT1JJVFlfQ0xBU1MKKyAgICAt
MTIuLi4tNSAgICAgMTkuLi4yNCAgICAgICAgICBBQk9WRV9OT1JNQUxfUFJJT1JJVFlfQ0xB
U1MKKyAgICAtMTMuLi0xOSAgICAgMjUuLi4zMCAgICAgICAgICBISUdIX1BSSU9SSVRZX0NM
QVNTCisgICAgICAgICAtMjAgICAgIDMxLi4uMzIgICAgICAgICAgUkVBTFRJTUVfUFJJT1JJ
VFlfQ0xBU1MKKzwvc2NyZWVuPgorVGhlIHVzZSBvZiB2YWx1ZXMgd2hpY2ggYXJlIG1hcHBl
ZCB0byB0aGUKKzxsaXRlcmFsPlJFQUxUSU1FX1BSSU9SSVRZX0NMQVNTPC9saXRlcmFsPiBy
ZXF1aXJlIGFkbWluaXN0cmF0aXZlCitwcml2aWxlZ2VzLgorCiA8L3NlY3QxPgogCiA8L2No
YXB0ZXI+Ci0tIAoyLjQ1LjEKCg==
--------------A3BFEBC941498B957F20DE82--

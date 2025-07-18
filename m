Return-Path: <SRS0=2pdT=Z7=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
	by sourceware.org (Postfix) with ESMTPS id 6209F3851AB3
	for <cygwin-patches@cygwin.com>; Fri, 18 Jul 2025 15:24:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6209F3851AB3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6209F3851AB3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752852277; cv=none;
	b=QremHsnHLPOnxCMvm9Z3wgvBF3qbc3YG0hUSFJbHgzo1LbznrWm0Rq89kSBNuxurVeFBE5g+CWv0X53L3KY8tAHKw0HiQv04F8IzXryrwCCs/l2aUzqG9JMs21CBVssSff7kyaW0D/CC9R2J3DzpnpYeYoV1c0BquqDlKbE07gM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752852277; c=relaxed/simple;
	bh=EQNujGt90xvy/ispAQlfdKbxs8KZsCiD35UKikG3VQk=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=SiOEJIhEHmvUXp2Tp44Nsr3Sir6F99q27C90yz0tjoSfKcruShRVBu132wbDNhrT7SWXvr2xLp7bAvBw68czC3NksXi9Yw5WF9Zm4z0gae1HekIYdpdZjz+GhddbsoRgL86bVQlU3LWkn1tHSjOcc3tTQ70vSt0SA6Xo8Sz9eNc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
	by mailout06.t-online.de (Postfix) with SMTP id 6320B1C7F8
	for <cygwin-patches@cygwin.com>; Fri, 18 Jul 2025 17:24:21 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd78.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1ucmwa-2zAmvo0; Fri, 18 Jul 2025 17:24:16 +0200
Subject: Re: [PATCH] Cygwin: doc: add note about raw devices of BitLocker
 partitions
To: cygwin-patches@cygwin.com
References: <2c6df85b-efd1-2209-5bf4-41d90b6d27db@t-online.de>
 <aHi1Wme5GNrCbYZl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <80cf416c-6382-6a6a-a148-bd17829b40f9@t-online.de>
Date: Fri, 18 Jul 2025 17:24:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <aHi1Wme5GNrCbYZl@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------DA430966780D1FB1C9F6C606"
X-TOI-EXPURGATEID: 150726::1752852256-AE7F253D-DC22253D/0/0 CLEAN NORMAL
X-TOI-MSGID: 126b844c-d860-4612-8095-2149697b4f69
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_BL,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------DA430966780D1FB1C9F6C606
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On Jul 16 11:38, Christian Franke wrote:
>> Another un?documented Windows behavior -- occasionally useful in this case
>> :)
> Ok.  Maybe as a <note>?
>

I'm not sure because unlike the other note nearby it is not a cautionary 
note. Alternative patch attached. Please vote :)

-- 
Regards,
Christian


--------------DA430966780D1FB1C9F6C606
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-doc-add-note-about-raw-devices-of-BitLocker-p.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-doc-add-note-about-raw-devices-of-BitLocker-p.pa";
 filename*1="tch"

RnJvbSBhZDAxZmQ2MWUxMDdmZGRjMTlkZGQyYzQzOWM1Yjg4NjBiMmNkOTAzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBGcmksIDE4IEp1bCAyMDI1IDE3OjE4OjE5ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBkb2M6IGFkZCBub3RlIGFib3V0IHJhdyBkZXZp
Y2VzIG9mIEJpdExvY2tlcgogcGFydGl0aW9ucwoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFu
IEZyYW5rZSA8Y2hyaXN0aWFuLmZyYW5rZUB0LW9ubGluZS5kZT4KLS0tCiB3aW5zdXAvZG9j
L3NwZWNpYWxuYW1lcy54bWwgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS93aW5zdXAvZG9jL3NwZWNpYWxuYW1lcy54bWwgYi93
aW5zdXAvZG9jL3NwZWNpYWxuYW1lcy54bWwKaW5kZXggMDIzNzVlNzM3Li5jMmM1ZDAwNjAg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9kb2Mvc3BlY2lhbG5hbWVzLnhtbAorKysgYi93aW5zdXAv
ZG9jL3NwZWNpYWxuYW1lcy54bWwKQEAgLTM2MSw2ICszNjEsMTMgQEAgdGhlIGluZm9ybWF0
aW9uIGJldHdlZW4gPGZpbGVuYW1lPi9wcm9jL3BhcnRpdGlvbnM8L2ZpbGVuYW1lPiBhbmQg
dGhlCiA8Y29tbWFuZD5kZjwvY29tbWFuZD4gb3V0cHV0LCB5b3Ugc2hvdWxkIGJlIGFibGUg
dG8gZmlndXJlIG91dCB3aGljaAogZXh0ZXJuYWwgZHJpdmUgY29ycmVzcG9uZHMgdG8gd2hp
Y2ggcmF3IGRpc2sgZGV2aWNlIG5hbWUuPC9wYXJhPgogCis8bm90ZT48cGFyYT5SYXcgZGV2
aWNlcyBvZiBwYXJ0aXRpb25zIHByb3RlY3RlZCBieSBCaXRMb2NrZXIgcHJvdmlkZSBhY2Nl
c3MKK3RvIHRoZSA8ZW1waGFzaXM+ZGVjcnlwdGVkPC9lbXBoYXNpcz4gTlRGUyBpbWFnZS4g
IElmIHRoZSBwYXJ0aXRpb24gaXMKK2xvY2tlZCwgcmVhZCBhdHRlbXB0cyBmYWlsIHdpdGgg
PGxpdGVyYWw+UGVybWlzc2lvbiBkZW5pZWQ8L2xpdGVyYWw+LiAgVGhlCitjb3JyZXNwb25k
aW5nIGJsb2NrIHJhbmdlIGZyb20gdGhlIHJhdyBkZXZpY2Ugb2YgdGhlIGZ1bGwgZGlzayBw
cm92aWRlcworYWNjZXNzIHRvIHRoZSA8ZW1waGFzaXM+ZW5jcnlwdGVkPC9lbXBoYXNpcz4g
aW1hZ2UgYXMgc3RvcmVkIG9uIHRoZQorZGlzay48L3BhcmE+PC9ub3RlPgorCiA8bm90ZT48
cGFyYT5BcGFydCBmcm9tIHRhcGUgZGV2aWNlcyB3aGljaCBhcmUgbm90IGJsb2NrIGRldmlj
ZXMgYW5kIGFyZQogYnkgZGVmYXVsdCBhY2Nlc3NlZCBkaXJlY3RseSwgYWNjZXNzaW5nIG1h
c3Mgc3RvcmFnZSBkZXZpY2VzIHJhdwogaXMgc29tZXRoaW5nIHlvdSBzaG91bGQgb25seSBk
byBpZiB5b3Uga25vdyB3aGF0IHlvdSdyZSBkb2luZyBhbmQga25vdyBob3cgdG8KLS0gCjIu
NDUuMQoK
--------------DA430966780D1FB1C9F6C606--

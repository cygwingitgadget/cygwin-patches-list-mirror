Return-Path: <SRS0=B7qI=SW=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
	by sourceware.org (Postfix) with ESMTPS id 72B443858D34
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 17:58:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 72B443858D34
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 72B443858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.85
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732730312; cv=none;
	b=kjwjTrpv9WiGH9S+OY+qGXOQixnW6VP7rrAWiru6XsDUetNTdgH6VMUFSNRobZpaIqZsIXwoL7wENBhcyrXdjekAie3l0W9vAl7f9zuKam7I9UoEwn08Mr3cO/FqY2jAn1HOH8+LYEHej9gNTJ1dpQRJ1kN7EJjou1AmIZjMvM0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732730312; c=relaxed/simple;
	bh=M3jcR6cMpHsUrG/TKYNub7yKIioEKGwiAWp4WOCCAgY=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=bF0qdC7qzQaEZTZ2wEf2qsb5io41pmaPZpuIjgUMX/gUeAaCorSPIWKMH6DXWqlGWrPfp9O7pZnu4IAKUDpdYw7TxWxq7PDE+Oxa8EJkXFc20k0kM3p5M8CzjIBaUlRPPlCpX1LgMklnxatpy179UAnaKtQFB3tGmpwdUSDsxgc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 72B443858D34
Received: from fwd75.aul.t-online.de (fwd75.aul.t-online.de [10.223.144.101])
	by mailout11.t-online.de (Postfix) with SMTP id 21788999
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 18:58:13 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd75.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tGMIl-0xdPbk0; Wed, 27 Nov 2024 18:58:12 +0100
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: nice: align return value and errno with POSIX and
 Linux
Message-ID: <c1fcf5de-517d-64cb-093b-ad65ca6e87de@t-online.de>
Date: Wed, 27 Nov 2024 18:58:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D5B6AA57282B5F7E8FDC4549"
X-TOI-EXPURGATEID: 150726::1732730292-057F5C97-7F94B9E3/0/0 CLEAN NORMAL
X-TOI-MSGID: 4ba38676-8ee9-44e2-9823-bec097210da5
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------D5B6AA57282B5F7E8FDC4549
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

No "Fixes:" in comment because the current behavior emulates old Linux 
behavior which is possibly not a bug.

SUS 1997 to POSIX 2024 require to return the new nice value.
https://pubs.opengroup.org/onlinepubs/007908799/xsh/nice.html
https://pubs.opengroup.org/onlinepubs/9799919799/functions/nice.html
https://man7.org/linux/man-pages/man2/nice.2.html

FreeBSD still returns 0:
https://man.freebsd.org/cgi/man.cgi?query=nice&sektion=3

Ancient Unix returned nothing :-)
http://man.cat-v.org/unix_10th/2/nice

-- 
Regards,
Christian


--------------D5B6AA57282B5F7E8FDC4549
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-nice-align-return-value-and-errno-with-POSIX-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-nice-align-return-value-and-errno-with-POSIX-.pa";
 filename*1="tch"

RnJvbSA0MGQxN2QzMmU0YzBhN2RjNjlmMzllNTdmM2QwZjlmMDdmY2E1Yzc1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBXZWQsIDI3IE5vdiAyMDI0IDE4OjU0OjM3ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBuaWNlOiBhbGlnbiByZXR1cm4gdmFsdWUgYW5k
IGVycm5vIHdpdGggUE9TSVggYW5kCiBMaW51eAoKUmV0dXJuIG5ldyBuaWNlIHZhbHVlIGlu
c3RlYWQgb2YgMCBvbiBzdWNjZXNzLgpTZXQgZXJybm8gdG8gRVBFUk0gaW5zdGVhZCBvZiBF
QUNDRVMgb24gZmFpbHVyZS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNo
cmlzdGlhbi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogd2luc3VwL2N5Z3dpbi9yZWxlYXNl
LzMuNi4wIHwgIDQgKysrKwogd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYyAgIHwgMTEgKysr
KysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjYuMCBiL3dpbnN1
cC9jeWd3aW4vcmVsZWFzZS8zLjYuMAppbmRleCBlZjdlNDAxOGYuLjFiMmYwMGFkOCAxMDA2
NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNi4wCisrKyBiL3dpbnN1cC9jeWd3
aW4vcmVsZWFzZS8zLjYuMApAQCAtNDgsMyArNDgsNyBAQCBXaGF0IGNoYW5nZWQ6CiAgIG9y
IEVQRVJNIGlmIFdpbmRvd3Mgd291bGQgc2lsZW50bHkgc2V0IGEgbG93ZXIgcHJpb3JpdHkK
ICAgKEhJR0hfUFJJT1JJVFlfQ0xBU1MgaW5zdGVhZCBvZiBSRUFMVElNRV9QUklPUklUWV9D
TEFTUykgZHVlIHRvCiAgIG1pc3NpbmcgYWRtaW5pc3RyYXRvciBwcml2aWxlZ2VzLgorCist
IG5pY2UoMikgbm93IHJldHVybnMgdGhlIG5ldyBuaWNlIHZhbHVlIGluc3RlYWQgb2YgMCBv
biBzdWNjZXNzCisgIGFuZCBzZXRzIGVycm5vIHRvIEVQRVJNIGluc3RlYWQgb2YgRUFDQ0VT
IG9uIGZhaWx1cmUuICBUaGlzIGNvbmZpcm1zCisgIHRvIFBPU0lYIGFuZCBMaW51eCAoZ2xp
YmMgPj0gMi4yLjQpIGJlaGF2aW9yLgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zeXNj
YWxscy5jYyBiL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MKaW5kZXggNzI1MzdiYzVhLi42
MDM1MGI2OTAgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MKKysrIGIv
d2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYwpAQCAtMzk1OSw3ICszOTU5LDE2IEBAIG91dDoK
IGV4dGVybiAiQyIgaW50CiBuaWNlIChpbnQgaW5jcikKIHsKLSAgcmV0dXJuIHNldHByaW9y
aXR5IChQUklPX1BST0NFU1MsIG15c2VsZi0+cGlkLCBteXNlbGYtPm5pY2UgKyBpbmNyKTsK
KyAgaWYgKHNldHByaW9yaXR5IChQUklPX1BST0NFU1MsIG15c2VsZi0+cGlkLCBteXNlbGYt
Pm5pY2UgKyBpbmNyKSkKKyAgICB7CisgICAgICAvKiBQT1NJWDogRVBFUk0gaW5zdGVhZCBv
ZiBFQUNDRVMuICovCisgICAgICBzZXRfZXJybm8gKEVQRVJNKTsKKyAgICAgIHJldHVybiAt
MTsKKyAgICB9CisKKyAgLyogUE9TSVg6IHJldHVybiB0aGUgbmV3IG5pY2UgdmFsdWUuICBM
aW51eCBnbGliYyA+PSAyLjIuNCBwcm92aWRlcworICAgICBjb25mb3JtYW5jZSB3aXRoIFBP
U0lYIChGcmVlQlNEIHJldHVybnMgMCkuICovCisgIHJldHVybiBteXNlbGYtPm5pY2U7CiB9
CiAKIHN0YXRpYyB2b2lkCi0tIAoyLjQ1LjEKCg==
--------------D5B6AA57282B5F7E8FDC4549--

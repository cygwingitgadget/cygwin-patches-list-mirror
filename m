Return-Path: <SRS0=YOlp=GV=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id DE1D63858C54
	for <cygwin-patches@cygwin.com>; Wed,  8 Nov 2023 16:40:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DE1D63858C54
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DE1D63858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699461618; cv=none;
	b=PCdwEhlY9bkoX5kND4mKqmaINFaa/ci9YQKwsNQfHKKQjbjXgBgZyavy00JKdfYMPgK0VGpl5gQe3/gKNTvqIKviBvXu8UqOt6OVcP2qnuZcQQ0hSzBA5egRK24dYY8bJu6bNJWtQhJ+g/szfAokjN7P3IXTwEBe/76hMInp4RY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699461618; c=relaxed/simple;
	bh=cvDLT6wJX958rS4ozFKiG9vgsUDTMpM6/cXOw0xqxEU=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=smDdgHAvYeLn2xOgpGJB6EVp9xKURNZ9IbpVALxAhjd90CgLZmilPkYnQiCxQExGtUsdR9xG3fVxMo735PrYkU3ycCg2obUPc1OBrXB8xyMBErBVoFSHlLoYBS/SmuwtrdygYTOEShwg2JDe4wW8KYgB7f3wb6+YFA/IQomC8qk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
	by mailout10.t-online.de (Postfix) with SMTP id 484932FBFD
	for <cygwin-patches@cygwin.com>; Wed,  8 Nov 2023 17:40:13 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd77.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r0lb9-1PPLrk0; Wed, 8 Nov 2023 17:40:11 +0100
To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: /dev/disk/by-id: Remove leading spaces from identify
 fields
Message-ID: <52791a04-ceb6-7b88-fb41-21d971e69b44@t-online.de>
Date: Wed, 8 Nov 2023 17:40:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------0AC2072D9C95773DD0BA131E"
X-TOI-EXPURGATEID: 150726::1699461611-3D7F9877-86DED560/0/0 CLEAN NORMAL
X-TOI-MSGID: ed6bf655-e100-4f1b-8d8f-5ef513a26941
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------0AC2072D9C95773DD0BA131E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Minor improvement, avoids "/dev/disk/by-id/sata-VENDOR_MODEL_______SERIAL".

-- 
Regards,
Christian


--------------0AC2072D9C95773DD0BA131E
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-dev-disk-by-id-Remove-leading-spaces-from-ide.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-dev-disk-by-id-Remove-leading-spaces-from-ide.pa";
 filename*1="tch"

RnJvbSA5OTI3Y2Q0NjQzNWRhOTdkMjM0YjBjN2U5N2I1ZmMyYTliNzYzMmQxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBXZWQsIDggTm92IDIwMjMgMTc6MDM6NTcgKzAxMDAK
U3ViamVjdDogW1BBVENIXSBDeWd3aW46IC9kZXYvZGlzay9ieS1pZDogUmVtb3ZlIGxlYWRp
bmcgc3BhY2VzIGZyb20gaWRlbnRpZnkKIGZpZWxkcwoKVmFyaW91cyBkcml2ZXMgYWxpZ24g
dGhlIHNlcmlhbCBudW1iZXIgdG8gdGhlIHJpZ2h0IG9mIHRoZSBmaXhlZApsZW5ndGggZmll
bGQuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtl
QHQtb25saW5lLmRlPgotLS0KIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXIvZGV2X2Rpc2suY2Mg
fCAzNCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyL2Rldl9kaXNrLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9k
ZXZfZGlzay5jYwppbmRleCBmY2QwZGU2NTEuLjExYjI0MDQyZiAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9maGFuZGxlci9kZXZfZGlzay5jYworKysgYi93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyL2Rldl9kaXNrLmNjCkBAIC0xNCwyNyArMTQsMzMgQEAgZGV0YWlscy4gKi8KICNp
bmNsdWRlIDx3Y3R5cGUuaD4KICNpbmNsdWRlIDx3aW5pb2N0bC5oPgogCi0vKiBSZXBsYWNl
IG5vbi1wcmludGluZyBhbmQgdW5leHBlY3RlZCBjaGFyYWN0ZXJzLCByZW1vdmUgdHJhaWxp
bmcgc3BhY2VzLAotICAgcmV0dXJuIHJlbWFpbmluZyBzdHJpbmcgbGVuZ3RoLiAqLworLyog
UmVwbGFjZSBzcGFjZXMsIG5vbi1wcmludGluZyBhbmQgdW5leHBlY3RlZCBjaGFyYWN0ZXJz
LiAgUmVtb3ZlCisgICBsZWFkaW5nIGFuZCB0cmFpbGluZyBzcGFjZXMuICBSZXR1cm4gcmVt
YWluaW5nIHN0cmluZyBsZW5ndGguICovCiBzdGF0aWMgaW50CiBzYW5pdGl6ZV9pZF9zdHJp
bmcgKGNoYXIgKnMpCiB7Ci0gIGludCBsYXN0c3BhY2UgPSAtMSwgaTsKLSAgZm9yIChpID0g
MDsgc1tpXTsgaSsrKQorICBpbnQgZmlyc3QgPSAwOworICB3aGlsZSAoc1tmaXJzdF0gPT0g
JyAnKQorICAgIGZpcnN0Kys7CisgIGludCBsYXN0ID0gLTEsIGk7CisgIGZvciAoaSA9IDA7
IHNbZmlyc3QgKyBpXTsgaSsrKQogICAgIHsKLSAgICAgIGNoYXIgYyA9IHNbaV07CisgICAg
ICBjaGFyIGMgPSBzW2ZpcnN0ICsgaV07CiAgICAgICBpZiAoYyAhPSAnICcpCi0JbGFzdHNw
YWNlID0gLTE7Ci0gICAgICBlbHNlIGlmIChsYXN0c3BhY2UgPCAwKQotCWxhc3RzcGFjZSA9
IGk7Ci0gICAgICBpZiAoKCcwJyA8PSBjICYmIGMgPD0gJzknKSB8fCBjID09ICcuJyB8fCBj
ID09ICctJwotCSAgfHwgKCdBJyA8PSBjICYmIGMgPD0gJ1onKSB8fCAoJ2EnIDw9IGMgJiYg
YyA8PSAneicpKQorCWxhc3QgPSAtMTsKKyAgICAgIGVsc2UgaWYgKGxhc3QgPCAwKQorCWxh
c3QgPSBpOworICAgICAgaWYgKCEoKCcwJyA8PSBjICYmIGMgPD0gJzknKSB8fCBjID09ICcu
JyB8fCBjID09ICctJworCSAgfHwgKCdBJyA8PSBjICYmIGMgPD0gJ1onKSB8fCAoJ2EnIDw9
IGMgJiYgYyA8PSAneicpKSkKKwljID0gJ18nOworICAgICAgZWxzZSBpZiAoIWZpcnN0KQog
CWNvbnRpbnVlOwotICAgICAgc1tpXSA9ICdfJzsKKyAgICAgIHNbaV0gPSBjOwogICAgIH0K
LSAgaWYgKGxhc3RzcGFjZSA+PSAwKQotICAgIHNbKGkgPSBsYXN0c3BhY2UpXSA9ICdcMCc7
Ci0gIHJldHVybiBpOworICBpZiAobGFzdCA8IDApCisgICAgbGFzdCA9IGk7CisgIHNbbGFz
dF0gPSAnXDAnOworICByZXR1cm4gbGFzdDsKIH0KIAogLyogRmV0Y2ggc3RvcmFnZSBwcm9w
ZXJ0aWVzIGFuZCBjcmVhdGUgdGhlIElEIHN0cmluZy4KLS0gCjIuNDIuMQoK
--------------0AC2072D9C95773DD0BA131E--

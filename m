Return-Path: <SRS0=jo1Y=SY=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
	by sourceware.org (Postfix) with ESMTPS id E307F3858D26
	for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 16:13:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E307F3858D26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E307F3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.85
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732896782; cv=none;
	b=bM300SgBMEyDnOL5LP82VqrT0VOdZd7tFxoK1lQUTNBMcILDzCAsx3csOMU8BEn4hDCtc9dp6qaHPGCLcurYjbnOp6ey8kP46qf0w1DVtcUjs/A85V25WPpiRA+eQNNUqQjgG6JFLgEi4V/7HYII097aIjBHs+7sRB2AHz6+xGE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732896782; c=relaxed/simple;
	bh=ZQ6JT7d9VC6HW7FGihw/LSh5maBkm01NZeRNn3JcasE=;
	h=To:From:Subject:Message-ID:Date:MIME-Version; b=eQ7vGYcJhccCePjvwUU5xBl43T3YCYbDE5UkhrZQehldqV3x9nOfYYLFi5IUNspvpuogSLEKf3dH/GABmDJ11F4PRgHilsQjmvgFx0/7dshD5QlNk2aH6wsuG93ycF03wBGwyxUDiCAgx3uPWwxLa2fJaDHT1ywp0QnvBngsJeA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E307F3858D26
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
	by mailout11.t-online.de (Postfix) with SMTP id 53E5BB56
	for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 17:12:58 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd77.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tH3c1-0MG8Su0; Fri, 29 Nov 2024 17:12:57 +0100
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: setpriority, sched_setparam: add missing process
 access right
Message-ID: <0f9951bf-ddfd-4545-a678-d697d2c974bb@t-online.de>
Date: Fri, 29 Nov 2024 17:12:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------9D7313281D2D168CDC41468C"
X-TOI-EXPURGATEID: 150726::1732896777-2DFE1864-2751F02A/0/0 CLEAN NORMAL
X-TOI-MSGID: 017b517b-169b-4be3-9d6a-851b9550f69b
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------9D7313281D2D168CDC41468C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Regression, sorry!

-- 
Regards,
Christian


--------------9D7313281D2D168CDC41468C
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-setpriority-sched_setparam-add-missing-proces.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-setpriority-sched_setparam-add-missing-proces.pa";
 filename*1="tch"

RnJvbSBmYWI3ZDg2NmZhOTk1YTM2MGRjMWI2OGY5NTY2MmE3YTI0MTcyYWViIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBGcmksIDI5IE5vdiAyMDI0IDE3OjEwOjI1ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzZXRwcmlvcml0eSwgc2NoZWRfc2V0cGFyYW06
IGFkZCBtaXNzaW5nIHByb2Nlc3MKIGFjY2VzcyByaWdodAoKc2V0X2FuZF9jaGVja193aW5w
cmlvKCkgYWxzbyByZXF1aXJlcyBQUk9DRVNTX1FVRVJZX0xJTUlURURfSU5GT1JNQVRJT04u
CgpGaXhlczogMTUzYjUxZWUwOGVmICgiQ3lnd2luOiBzZXRwcmlvcml0eSwgc2NoZWRfc2V0
cGFyYW06IGZhaWwgaWYgV2luZG93cyBzZXRzIGEgbG93ZXIgcHJpb3JpdHkiKQpTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRl
PgotLS0KIHdpbnN1cC9jeWd3aW4vbWlzY2Z1bmNzLmNjIHwgMiArKwogd2luc3VwL2N5Z3dp
bi9zY2hlZC5jYyAgICAgfCA0ICsrKy0KIHdpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MgIHwg
NSArKystLQogMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9taXNjZnVuY3MuY2MgYi93aW5zdXAv
Y3lnd2luL21pc2NmdW5jcy5jYwppbmRleCBlM2JmMzVjZjcuLmViZTQwMWI5MyAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9taXNjZnVuY3MuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9t
aXNjZnVuY3MuY2MKQEAgLTE5MCw2ICsxOTAsOCBAQCBib29sCiBzZXRfYW5kX2NoZWNrX3dp
bnByaW8gKEhBTkRMRSBwcm9jLCBEV09SRCBwcmlvKQogewogICBEV09SRCBwcmV2X3ByaW8g
PSBHZXRQcmlvcml0eUNsYXNzIChwcm9jKTsKKyAgaWYgKCFwcmV2X3ByaW8pCisgICAgcmV0
dXJuIGZhbHNlOwogICBpZiAocHJldl9wcmlvID09IHByaW8pCiAgICAgcmV0dXJuIHRydWU7
CiAKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MgYi93aW5zdXAvY3lnd2lu
L3NjaGVkLmNjCmluZGV4IGI4MDY3ZDU0Ny4uNjFkNWU3YmU0IDEwMDY0NAotLS0gYS93aW5z
dXAvY3lnd2luL3NjaGVkLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKQEAgLTI2
MCw3ICsyNjAsOSBAQCBzY2hlZF9zZXRwYXJhbSAocGlkX3QgcGlkLCBjb25zdCBzdHJ1Y3Qg
c2NoZWRfcGFyYW0gKnBhcmFtKQogICAgICAgc2V0X2Vycm5vIChFU1JDSCk7CiAgICAgICBy
ZXR1cm4gLTE7CiAgICAgfQotICBwcm9jZXNzID0gT3BlblByb2Nlc3MgKFBST0NFU1NfU0VU
X0lORk9STUFUSU9OLCBGQUxTRSwgcC0+ZHdQcm9jZXNzSWQpOworICBwcm9jZXNzID0gT3Bl
blByb2Nlc3MgKFBST0NFU1NfU0VUX0lORk9STUFUSU9OIHwKKwkJCSBQUk9DRVNTX1FVRVJZ
X0xJTUlURURfSU5GT1JNQVRJT04sCisJCQkgRkFMU0UsIHAtPmR3UHJvY2Vzc0lkKTsKICAg
aWYgKCFwcm9jZXNzKQogICAgIHsKICAgICAgIHNldF9lcnJubyAoRVNSQ0gpOwpkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYyBiL3dpbnN1cC9jeWd3aW4vc3lzY2Fs
bHMuY2MKaW5kZXggNjAzNTBiNjkwLi5kNGZiYTYzMmMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9j
eWd3aW4vc3lzY2FsbHMuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYwpAQCAt
Mzg2OSw4ICszODY5LDkgQEAgc2V0cHJpb3JpdHkgKGludCB3aGljaCwgaWRfdCB3aG8sIGlu
dCB2YWx1ZSkKIAkJY29udGludWU7CiAJICAgICAgYnJlYWs7CiAJICAgIH0KLQkgIEhBTkRM
RSBwcm9jX2ggPSBPcGVuUHJvY2VzcyAoUFJPQ0VTU19TRVRfSU5GT1JNQVRJT04sIEZBTFNF
LAotCQkJCSAgICAgICBwLT5kd1Byb2Nlc3NJZCk7CisJICBIQU5ETEUgcHJvY19oID0gT3Bl
blByb2Nlc3MgKFBST0NFU1NfU0VUX0lORk9STUFUSU9OIHwKKwkJCQkgICAgICAgUFJPQ0VT
U19RVUVSWV9MSU1JVEVEX0lORk9STUFUSU9OLAorCQkJCSAgICAgICBGQUxTRSwgcC0+ZHdQ
cm9jZXNzSWQpOwogCSAgaWYgKCFwcm9jX2gpCiAJICAgIGVycm9yID0gRVBFUk07CiAJICBl
bHNlCi0tIAoyLjQ1LjEKCg==
--------------9D7313281D2D168CDC41468C--

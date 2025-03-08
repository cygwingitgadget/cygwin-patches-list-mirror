Return-Path: <SRS0=u+O/=V3=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
	by sourceware.org (Postfix) with ESMTPS id 973083858D1E
	for <cygwin-patches@cygwin.com>; Sat,  8 Mar 2025 13:24:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 973083858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 973083858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.81
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741440294; cv=none;
	b=RgJ/dMmxVx5en+izU70bsrFKaO8lvAHRTH140o+QFqxQuuLJe3bIzLAn2Qzqdw5dnrJ6fEWnM8dPAxYDUmAXedFbC0+wtLKGeCdWXminDCVUHMej+Et/QZRB9ZyYl9BqSyI84xSuaoO6eVqmZ1kVbSiV/eIUTyQC0yGo1JWlfME=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741440294; c=relaxed/simple;
	bh=27GlhHJ8UNOdGxgqCi7LWIsn0alIxdQO+XNT/jQ5UlE=;
	h=From:Subject:To:Message-ID:Date:MIME-Version; b=LqD2tNLvSX6O4CJr7lxW2wQMO95XHNtWRmnTdYWEnysUwPPqLmTpsaresMWXJ2Oi7LcntApkJyvXEW5/JV+F0F3NTrotvur0k1Ge4bvu0NSs9n1QRKrSc0POlTH/6ecFOSAg3kxwNX1GL3+j9aBOY6Ue4YszS0xkvnR4EPxrEFk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 973083858D1E
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
	by mailout03.t-online.de (Postfix) with SMTP id 6CF3DFB8
	for <cygwin-patches@cygwin.com>; Sat,  8 Mar 2025 14:24:36 +0100 (CET)
Received: from [192.168.2.102] ([91.57.253.229]) by fwd89.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tquAL-3oemeG0; Sat, 8 Mar 2025 14:24:33 +0100
From: Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: sched_setaffinity: fix EACCES if pid of other process
 is used
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
Message-ID: <7a77c9b6-20e4-538f-4b8d-e91be879988f@t-online.de>
Date: Sat, 8 Mar 2025 14:24:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------52FE7FC1EA58E190D14C1C97"
X-TOI-EXPURGATEID: 150726::1741440273-837FDAEF-0B3AC539/0/0 CLEAN NORMAL
X-TOI-MSGID: 6e0084bd-82f6-4b4e-a912-4036b20474bc
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------52FE7FC1EA58E190D14C1C97
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This fixes:

$ taskset -p 0x1 1234
pid 1234's current affinity mask: fffffff
taskset: failed to set pid 1234's affinity: Permission denied

Perhaps older Windows versions were more relaxed if 
PROCESS_SET_INFORMATION is granted.

-- 
Regards,
Christian


--------------52FE7FC1EA58E190D14C1C97
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_setaffinity-fix-EACCES-if-pid-of-other-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-sched_setaffinity-fix-EACCES-if-pid-of-other-.pa";
 filename*1="tch"

RnJvbSAwMjc1YTM2NzIzZGQ0NTUyYTI2ODgwZTRhYzhiYTliNmRjNDFiMTdmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBTYXQsIDggTWFyIDIwMjUgMTQ6MDU6MjAgKzAxMDAK
U3ViamVjdDogW1BBVENIXSBDeWd3aW46IHNjaGVkX3NldGFmZmluaXR5OiBmaXggRUFDQ0VT
IGlmIHBpZCBvZiBvdGhlciBwcm9jZXNzCiBpcyB1c2VkCgpHZXRQcm9jZXNzR3JvdXBBZmZp
bml0eSgpIHJlcXVpcmVzIFBST0NFU1NfUVVFUllfTElNSVRFRF9JTkZPUk1BVElPTi4KCkZp
eGVzOiA2NDFlY2IwNzUzM2UgKCJDeWd3aW46IEltcGxlbWVudCBzY2hlZF9bZ3NdZXRhZmZp
bml0eSgpIikKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFuLmZy
YW5rZUB0LW9ubGluZS5kZT4KLS0tCiB3aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAgfCAy
ICsrCiB3aW5zdXAvY3lnd2luL3NjaGVkLmNjICAgICAgfCAzICsrLQogMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL3JlbGVhc2UvMy42LjAgYi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAK
aW5kZXggODIyNWYyY2NjLi40Yzk1M2E4NGQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4v
cmVsZWFzZS8zLjYuMAorKysgYi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAKQEAgLTEy
NiwzICsxMjYsNSBAQCBGaXhlczoKIAogLSBGaXggJ2xvc3QgY29ubmVjdGlvbicgZXJyb3Ig
aW4gc2NwLgogICBBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9waXBlcm1haWwvY3ln
d2luLzIwMjUtSmFudWFyeS8yNTcxNDMuaHRtbAorCistIEZpeCBFQUNDRVMgZXJyb3Igb2Yg
c2NoZWRfc2V0YWZmaW5pdHkoMikgaWYgcGlkIG9mIG90aGVyIHByb2Nlc3MgaXMgdXNlZC4K
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MgYi93aW5zdXAvY3lnd2luL3Nj
aGVkLmNjCmluZGV4IDg2OTQxYjJhYy4uMmY0ZmJjMzFhIDEwMDY0NAotLS0gYS93aW5zdXAv
Y3lnd2luL3NjaGVkLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKQEAgLTY2MSw3
ICs2NjEsOCBAQCBzY2hlZF9zZXRhZmZpbml0eSAocGlkX3QgcGlkLCBzaXplX3Qgc2l6ZW9m
X3NldCwgY29uc3QgY3B1X3NldF90ICpzZXQpCiAgIGlmIChwKQogICAgIHsKICAgICAgIHBy
b2Nlc3MgPSBwaWQgJiYgcGlkICE9IG15c2VsZi0+cGlkID8KLQkJT3BlblByb2Nlc3MgKFBS
T0NFU1NfU0VUX0lORk9STUFUSU9OLCBGQUxTRSwKKwkJT3BlblByb2Nlc3MgKFBST0NFU1Nf
U0VUX0lORk9STUFUSU9OIHwKKwkJCSAgICAgUFJPQ0VTU19RVUVSWV9MSU1JVEVEX0lORk9S
TUFUSU9OLCBGQUxTRSwKIAkJCSAgICAgcC0+ZHdQcm9jZXNzSWQpIDogR2V0Q3VycmVudFBy
b2Nlc3MgKCk7CiAgICAgICBpZiAoIUdldFByb2Nlc3NHcm91cEFmZmluaXR5IChwcm9jZXNz
LCAmZ3JvdXBjb3VudCwgZ3JvdXBhcnJheSkpCiAJewotLSAKMi40NS4xCgo=
--------------52FE7FC1EA58E190D14C1C97--

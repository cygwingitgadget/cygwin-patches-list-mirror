Return-Path: <cygwin-patches-return-9411-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47758 invoked by alias); 26 May 2019 15:10:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47691 invoked by uid 89); 26 May 2019 15:10:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730108.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.108) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 26 May 2019 15:10:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZwIA91vP0Fu1+j80zM8eQ3TASbKQfOesjCB/c7KTwWU=; b=BuaNCWvXn2YFptFGc1nZmu9Zbd9pu03HOgWuNPJV1dPj52+iIylPwAGOw3hrSJoLtCy0Siem7gY27npYv+9GlOy4k1ciFHVG0qbfybyWRS72VAAGotxS1jMLwpxRW7G6EmBa4CRzTMmMPIN0I0hU/5vHzxeC4AZ+9mxnaJOv3c4=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4777.namprd04.prod.outlook.com (20.176.107.206) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.15; Sun, 26 May 2019 15:10:36 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1922.021; Sun, 26 May 2019 15:10:36 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH draft 1/6] Cygwin: fhandler_pipe: derive from fhandler_base
Date: Sun, 26 May 2019 15:10:00 -0000
Message-ID: <20190526151019.2187-2-kbrown@cornell.edu>
References: <20190526151019.2187-1-kbrown@cornell.edu>
In-Reply-To: <20190526151019.2187-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:127;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00118.txt.bz2

TWFrZSBtaW5pbWFsIGNoYW5nZXMgc28gdGhhdCB0aGUgYnVpbGQgc3RpbGwg
c3VjY2VlZHMuDQoNClByZXZpb3VzbHkgZmhhbmRsZXJfcGlwZSB3YXMgZGVy
aXZlZCBmcm9tIGZoYW5kbGVyX2Jhc2Vfb3ZlcmxhcHBlZCwNCndoaWNoIHdl
IGFyZSBnb2luZyB0byByZW1vdmUgaW4gYSBmdXR1cmUgY29tbWl0Lg0KLS0t
DQogd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oICAgICAgIHwgIDUgKystLS0N
CiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3BpcGUuY2MgfCAxMSArKysrKy0t
LS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA5IGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlci5oIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oDQppbmRleCBmMjQ0
ZjM0ODYuLmJkZmU0YTI3MiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4v
ZmhhbmRsZXIuaA0KKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oDQpA
QCAtMTE4NywxNCArMTE4NywxNCBAQCBwdWJsaWM6DQogICBmcmllbmQgRFdP
UkQgV0lOQVBJIGZsdXNoX2FzeW5jX2lvICh2b2lkICopOw0KIH07DQogDQot
Y2xhc3MgZmhhbmRsZXJfcGlwZTogcHVibGljIGZoYW5kbGVyX2Jhc2Vfb3Zl
cmxhcHBlZA0KK2NsYXNzIGZoYW5kbGVyX3BpcGU6IHB1YmxpYyBmaGFuZGxl
cl9iYXNlDQogew0KIHByaXZhdGU6DQogICBwaWRfdCBwb3Blbl9waWQ7DQor
ICBzaXplX3QgbWF4X2F0b21pY193cml0ZTsNCiBwdWJsaWM6DQogICBmaGFu
ZGxlcl9waXBlICgpOw0KIA0KLQ0KICAgYm9vbCBpc3BpcGUoKSBjb25zdCB7
IHJldHVybiB0cnVlOyB9DQogDQogICB2b2lkIHNldF9wb3Blbl9waWQgKHBp
ZF90IHBpZCkge3BvcGVuX3BpZCA9IHBpZDt9DQpAQCAtMTIyMSw3ICsxMjIx
LDYgQEAgcHVibGljOg0KICAgew0KICAgICB4LT5wYy5mcmVlX3N0cmluZ3Mg
KCk7DQogICAgICpyZWludGVycHJldF9jYXN0PGZoYW5kbGVyX3BpcGUgKj4g
KHgpID0gKnRoaXM7DQotICAgIHJlaW50ZXJwcmV0X2Nhc3Q8ZmhhbmRsZXJf
cGlwZSAqPiAoeCktPmF0b21pY193cml0ZV9idWYgPSBOVUxMOw0KICAgICB4
LT5yZXNldCAodGhpcyk7DQogICB9DQogDQpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9maGFuZGxlcl9waXBlLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlcl9waXBlLmNjDQppbmRleCBlZGJhZGVkNjguLjJlYTY5ZjhlZCAxMDA2
NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfcGlwZS5jYw0KKysr
IGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9waXBlLmNjDQpAQCAtMjEsNyAr
MjEsNyBAQCBkZXRhaWxzLiAqLw0KICNpbmNsdWRlICJzaGFyZWRfaW5mby5o
Ig0KIA0KIGZoYW5kbGVyX3BpcGU6OmZoYW5kbGVyX3BpcGUgKCkNCi0gIDog
ZmhhbmRsZXJfYmFzZV9vdmVybGFwcGVkICgpLCBwb3Blbl9waWQgKDApDQor
ICA6IGZoYW5kbGVyX2Jhc2UgKCksIHBvcGVuX3BpZCAoMCkNCiB7DQogICBt
YXhfYXRvbWljX3dyaXRlID0gREVGQVVMVF9QSVBFQlVGU0laRTsNCiAgIG5l
ZWRfZm9ya19maXh1cCAodHJ1ZSk7DQpAQCAtNTQsOSArNTQsOCBAQCBmaGFu
ZGxlcl9waXBlOjppbml0IChIQU5ETEUgZiwgRFdPUkQgYSwgbW9kZV90IG1v
ZGUsIGludDY0X3QgdW5pcV9pZCkNCiAgIHNldF9pbm8gKHVuaXFfaWQpOw0K
ICAgc2V0X3VuaXF1ZV9pZCAodW5pcV9pZCB8ICEhKG1vZGUgJiBHRU5FUklD
X1dSSVRFKSk7DQogICBpZiAob3BlbmVkX3Byb3Blcmx5KQ0KLSAgICBzZXR1
cF9vdmVybGFwcGVkICgpOw0KLSAgZWxzZQ0KLSAgICBkZXN0cm95X292ZXJs
YXBwZWQgKCk7DQorICAgIC8qIC4uLiAqLw0KKyAgICA7DQogICByZXR1cm4g
MTsNCiB9DQogDQpAQCAtMTkyLDcgKzE5MSw3IEBAIGZoYW5kbGVyX3BpcGU6
OmR1cCAoZmhhbmRsZXJfYmFzZSAqY2hpbGQsIGludCBmbGFncykNCiAgIGZ0
cC0+c2V0X3BvcGVuX3BpZCAoMCk7DQogDQogICBpbnQgcmVzOw0KLSAgaWYg
KGdldF9oYW5kbGUgKCkgJiYgZmhhbmRsZXJfYmFzZV9vdmVybGFwcGVkOjpk
dXAgKGNoaWxkLCBmbGFncykpDQorICBpZiAoZ2V0X2hhbmRsZSAoKSAmJiBm
aGFuZGxlcl9iYXNlOjpkdXAgKGNoaWxkLCBmbGFncykpDQogICAgIHJlcyA9
IC0xOw0KICAgZWxzZQ0KICAgICByZXMgPSAwOw0KQEAgLTM1OSw3ICszNTgs
NyBAQCBmaGFuZGxlcl9waXBlOjpjcmVhdGUgKGZoYW5kbGVyX3BpcGUgKmZo
c1syXSwgdW5zaWduZWQgcHNpemUsIGludCBtb2RlKQ0KICAgaW50IHJlcyA9
IC0xOw0KICAgaW50NjRfdCB1bmlxdWVfaWQ7DQogDQotICBpbnQgcmV0ID0g
Y3JlYXRlIChzYSwgJnIsICZ3LCBwc2l6ZSwgTlVMTCwgRklMRV9GTEFHX09W
RVJMQVBQRUQsICZ1bmlxdWVfaWQpOw0KKyAgaW50IHJldCA9IGNyZWF0ZSAo
c2EsICZyLCAmdywgcHNpemUsIE5VTEwsIDAsICZ1bmlxdWVfaWQpOw0KICAg
aWYgKHJldCkNCiAgICAgX19zZXRlcnJub19mcm9tX3dpbl9lcnJvciAocmV0
KTsNCiAgIGVsc2UgaWYgKChmaHNbMF0gPSAoZmhhbmRsZXJfcGlwZSAqKSBi
dWlsZF9maF9kZXYgKCpwaXBlcl9kZXYpKSA9PSBOVUxMKQ0KLS0gDQoyLjE3
LjANCg0K

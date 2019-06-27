Return-Path: <cygwin-patches-return-9471-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1165 invoked by alias); 27 Jun 2019 01:10:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1152 invoked by uid 89); 27 Jun 2019 01:10:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=cygwindevelopers, cygwin-developers
X-HELO: NAM02-BL2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr750108.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) (40.107.75.108) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 27 Jun 2019 01:10:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=2JIrjVy6l/hW6O8KvMkmLWUQJD7rprYZQILx2HBL5qk=; b=DQ5uABlKWDuFDa3As9lrBYtbLsktFb7lJTOEGLaE2KigZQMZpYo4hhgNGP9m9hRLLVnoerc90ZqUDIdUnHd2g2XBP+zrLHF32PG+A2sBf+A/9f1wiX4GLspShoyFIouRZSe2SvFzQl/RcpQaaKjgP6rEOJNGB/HEfjYKbkcpHr8=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2172.namprd04.prod.outlook.com (10.167.8.26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.18; Thu, 27 Jun 2019 01:10:38 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40%3]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019 01:10:38 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: honor the O_PATH flag when opening a FIFO
Date: Thu, 27 Jun 2019 01:10:00 -0000
Message-ID: <20190627011018.35924-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:4502;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00178.txt.bz2

UHJldmlvdXNseSBmaGFuZGxlcl9maWZvOjpvcGVuIHdvdWxkIHRyZWF0IHRo
ZSBGSUZPIGFzIGEgcmVhZGVyIGFuZA0Kd291bGQgYmxvY2ssIHdhaXRpbmcg
Zm9yIGEgd3JpdGVyLg0KLS0tDQogd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9m
aWZvLmNjIHwgMTEgKysrKysrKysrKy0NCiB3aW5zdXAvY3lnd2luL3JlbGVh
c2UvMy4wLjggICAgfCAxMyArKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHdpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjAuOA0KDQpk
aWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjIGIv
d2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQppbmRleCA1NzMzZWM3
NzguLjkxMTIzMTRmZSAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vZmhh
bmRsZXJfZmlmby5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9m
aWZvLmNjDQpAQCAtODUsMTEgKzg1LDIwIEBAIGZoYW5kbGVyX2ZpZm86Om9w
ZW4gKGludCBmbGFncywgbW9kZV90KQ0KICAgYm9vbCByZWFkZXIsIHdyaXRl
ciwgZHVwbGV4ZXI7DQogICBEV09SRCBvcGVuX21vZGUgPSBGSUxFX0ZMQUdf
T1ZFUkxBUFBFRDsNCiANCisgIGlmIChmbGFncyAmIE9fUEFUSCkNCisgICAg
ew0KKyAgICAgIHF1ZXJ5X29wZW4gKHF1ZXJ5X3JlYWRfYXR0cmlidXRlcyk7
DQorICAgICAgbm9oYW5kbGUgKHRydWUpOw0KKyAgICB9DQorDQogICAvKiBE
ZXRlcm1pbmUgd2hhdCB3ZSdyZSBkb2luZyB3aXRoIHRoaXMgZmhhbmRsZXI6
IHJlYWRpbmcsIHdyaXRpbmcsIGJvdGggKi8NCiAgIHN3aXRjaCAoZmxhZ3Mg
JiBPX0FDQ01PREUpDQogICAgIHsNCiAgICAgY2FzZSBPX1JET05MWToNCi0g
ICAgICByZWFkZXIgPSB0cnVlOw0KKyAgICAgIGlmIChxdWVyeV9vcGVuICgp
KQ0KKwlyZWFkZXIgPSBmYWxzZTsNCisgICAgICBlbHNlDQorCXJlYWRlciA9
IHRydWU7DQogICAgICAgd3JpdGVyID0gZmFsc2U7DQogICAgICAgZHVwbGV4
ZXIgPSBmYWxzZTsNCiAgICAgICBicmVhazsNCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL3JlbGVhc2UvMy4wLjggYi93aW5zdXAvY3lnd2luL3JlbGVh
c2UvMy4wLjgNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAw
MDAuLmUzNzM0YzliNw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvd2luc3VwL2N5
Z3dpbi9yZWxlYXNlLzMuMC44DQpAQCAtMCwwICsxLDEzIEBADQorV2hhdCdz
IG5ldzoNCistLS0tLS0tLS0tLQ0KKw0KKw0KK1doYXQgY2hhbmdlZDoNCist
LS0tLS0tLS0tLS0tDQorDQorDQorQnVnIEZpeGVzDQorLS0tLS0tLS0tDQor
DQorLSBGaXggYSBoYW5nIHdoZW4gb3BlbmluZyBhIEZJRk8gd2l0aCBPX1BB
VEguDQorICBBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9tbC9jeWd3
aW4tZGV2ZWxvcGVycy8yMDE5LTA2L21zZzAwMDAxLmh0bWwNCi0tIA0KMi4y
MS4wDQoNCg==

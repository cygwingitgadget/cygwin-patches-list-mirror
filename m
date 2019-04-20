Return-Path: <cygwin-patches-return-9370-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25719 invoked by alias); 20 Apr 2019 18:58:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25664 invoked by uid 89); 20 Apr 2019 18:58:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-22.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:936
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770120.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 20 Apr 2019 18:58:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZMG3ssa4u+vQZpnvsmqElSn7J2WIaypsmL/qMjImf5U=; b=hdcHuleNSJQ9vno31i2ih7SQHfXes/NsL29GLxQvkdmVg/63T1GV1aA9ioBo6wcFJ23UVpCjoAgNXdlSCE/xiPkpGftghjZ1G1eRZqt0PIIIBvGmug6CZX9qFUu8JqD4eQTGiO6gG+Qy09C4h4NWrDkkW88Adz/qZsy2voP+JO4=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5113.namprd04.prod.outlook.com (20.176.111.158) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.16; Sat, 20 Apr 2019 18:58:49 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.013; Sat, 20 Apr 2019 18:58:49 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 2/5] Cygwin: FIFO: duplicate the i/o handle when opening a duplexer
Date: Sat, 20 Apr 2019 18:58:00 -0000
Message-ID: <20190420185834.4228-3-kbrown@cornell.edu>
References: <20190420185834.4228-1-kbrown@cornell.edu>
In-Reply-To: <20190420185834.4228-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00077.txt.bz2

RG9uJ3QgdXNlIHRoZSBzYW1lIGkvbyBoYW5kbGUgZm9yIHRoZSBmaXJzdCBj
bGllbnQgaGFuZGxlciBhcyBpcyB1c2VkDQpmb3IgdGhlIGZoYW5kbGVyIGl0
c2VsZjsgdGhpcyBjYW4gbGVhZCB0byBhIGxhdGVyIGF0dGVtcHQgdG8gY2xv
c2UgdGhlDQpzYW1lIGhhbmRsZSB0d2ljZS4gIEluc3RlYWQgdXNlIGEgZHVw
bGljYXRlLg0KLS0tDQogd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNj
IHwgOSArKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL2ZoYW5kbGVyX2ZpZm8uY2MgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVy
X2ZpZm8uY2MNCmluZGV4IDQwOTE0NGZkYS4uMGE2ZGMwNTkxIDEwMDY0NA0K
LS0tIGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQorKysgYi93
aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MNCkBAIC00ODAsNyArNDgw
LDE0IEBAIGZoYW5kbGVyX2ZpZm86Om9wZW4gKGludCBmbGFncywgbW9kZV90
KQ0KIAkgIHJlcyA9IGVycm9yX2Vycm5vX3NldDsNCiAJICBnb3RvIG91dDsN
CiAJfQ0KLSAgICAgIGZoLT5zZXRfaGFuZGxlIChwaCk7DQorICAgICAgaWYg
KCFEdXBsaWNhdGVIYW5kbGUgKEdldEN1cnJlbnRQcm9jZXNzICgpLCBwaCwg
R2V0Q3VycmVudFByb2Nlc3MgKCksDQorCQkJICAgICZmaC0+Z2V0X2hhbmRs
ZSAoKSwgMCwgdHJ1ZSwgRFVQTElDQVRFX1NBTUVfQUNDRVNTKSkNCisJew0K
KwkgIHJlcyA9IGVycm9yX3NldF9lcnJubzsNCisJICBmaC0+Y2xvc2UgKCk7
DQorCSAgZGVsZXRlIGZoOw0KKwkgIGdvdG8gb3V0Ow0KKwl9DQogICAgICAg
ZmgtPnNldF9mbGFncyAoZmxhZ3MpOw0KICAgICAgIGlmICghKGNvbm5lY3Rf
ZXZ0ID0gY3JlYXRlX2V2ZW50ICgpKSkNCiAJew0KLS0gDQoyLjE3LjANCg0K

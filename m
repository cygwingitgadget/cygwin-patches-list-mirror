Return-Path: <cygwin-patches-return-9343-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129742 invoked by alias); 14 Apr 2019 19:16:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129665 invoked by uid 89); 14 Apr 2019 19:16:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730117.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.117) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 14 Apr 2019 19:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=HokpX1WpIvtF6tk/XKjOUv/PV5//iazB2NPifnWtyQI=; b=SfsmKDC135G72Y+850kbG3BZIcILZSILnvZkbbz/liomgBNbP9Q3GO/GX55/FquabologgbyGoNhCW+KXjqxIgVIj3NOuURsp1AnD9JS0t05WPtLTfRFCYk+3HbcTVmabc5+JGEy1TJTBdtmpBL5IimxrfvxAG63zEjGqdc1gb8=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3963.namprd04.prod.outlook.com (20.176.87.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Sun, 14 Apr 2019 19:15:58 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019 19:15:58 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 05/14] Cygwin: FIFO: fix the error checking in raw_read
Date: Sun, 14 Apr 2019 19:16:00 -0000
Message-ID: <20190414191543.3218-6-kbrown@cornell.edu>
References: <20190414191543.3218-1-kbrown@cornell.edu>
In-Reply-To: <20190414191543.3218-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00049.txt.bz2

SWYgdGhlIHBpcGUgaXMgZW1wdHksIHdlIGNhbiBnZXQgZWl0aGVyIEVSUk9S
X05PX0RBVEEgb3INCkVSUk9SX1BJUEVfTElTVEVOSU5HLg0KLS0tDQogd2lu
c3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjIHwgMTMgKysrKystLS0tLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVy
X2ZpZm8uY2MgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MNCmlu
ZGV4IDc2NDQyMGZmZC4uMmRhNTc5Yjk1IDEwMDY0NA0KLS0tIGEvd2luc3Vw
L2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQorKysgYi93aW5zdXAvY3lnd2lu
L2ZoYW5kbGVyX2ZpZm8uY2MNCkBAIC03NDksMTkgKzc0OSwxNiBAQCBmaGFu
ZGxlcl9maWZvOjpyYXdfcmVhZCAodm9pZCAqaW5fcHRyLCBzaXplX3QmIGxl
bikNCiAJCWZpZm9fY2xpZW50X3VubG9jayAoKTsNCiAJCXJldHVybjsNCiAJ
ICAgICAgfQ0KLQkgICAgLyogSW4gdGhlIGR1cGxleCBjYXNlIHdpdGggbm8g
ZGF0YSwgd2Ugc2VlbSB0byBnZXQgbnJlYWQNCi0JICAgICAgID09IC0xIHdp
dGggRVJST1JfUElQRV9MSVNURU5JTkcgb24gdGhlIGZpcnN0IGF0dGVtcHQg
dG8NCi0JICAgICAgIHJlYWQgZnJvbSB0aGUgZHVwbGV4IHBpcGUgKGZjX2hh
bmRsZXJbMF0pLCBhbmQgbnJlYWQgPT0gMA0KLQkgICAgICAgb24gc3Vic2Vx
dWVudCBhdHRlbXB0cy4gKi8NCisJICAgIC8qIElmIHRoZSBwaXBlIGlzIGVt
cHR5LCB3ZSB1c3VhbGx5IGdldCBucmVhZCA9PSAtMSB3aXRoDQorCSAgICAg
ICBFUlJPUl9OT19EQVRBIG9yIEVSUk9SX1BJUEVfTElTVEVOSU5HLiAgQW4g
ZXhjZXB0aW9uIGlzDQorCSAgICAgICB0aGF0IGluIHRoZSBkdXBsZXggY2Fz
ZSB3ZSBtYXkgZ2V0IG5yZWFkID09IDAgd2hlbiB3ZQ0KKwkgICAgICAgYXR0
ZW1wdCB0byByZWFkIGZyb20gdGhlIGR1cGxleCBwaXBlIChmY19oYW5kbGVy
WzBdKS4gKi8NCiAJICAgIGVsc2UgaWYgKG5yZWFkIDwgMCkNCiAJICAgICAg
c3dpdGNoIChHZXRMYXN0RXJyb3IgKCkpDQogCQl7DQogCQljYXNlIEVSUk9S
X05PX0RBVEE6DQotCQkgIGJyZWFrOw0KIAkJY2FzZSBFUlJPUl9QSVBFX0xJ
U1RFTklORzoNCi0JCSAgaWYgKF9kdXBsZXhlciAmJiBpID09IDApDQotCQkg
ICAgYnJlYWs7DQotCQkgIC8qIEZhbGwgdGhyb3VnaC4gKi8NCisJCSAgYnJl
YWs7DQogCQlkZWZhdWx0Og0KIAkJICBmaWZvX2NsaWVudF91bmxvY2sgKCk7
DQogCQkgIGdvdG8gZXJyb3V0Ow0KLS0gDQoyLjE3LjANCg0K

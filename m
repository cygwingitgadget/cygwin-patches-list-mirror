Return-Path: <cygwin-patches-return-9350-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130937 invoked by alias); 14 Apr 2019 19:16:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130882 invoked by uid 89); 14 Apr 2019 19:16:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-22.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730131.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 14 Apr 2019 19:16:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Pca4+D+pWD7GRlCGEahiK/+lhaXA8oHi0Pu90WvA7WI=; b=IeeVufNvswyP+klNSZ9lc/HI4P9WjS9vtyrEzdd4/rx40y/leJBMtqQBBg2Ftb7zy+O+pROLv7D62MkUGXR8oS5wICEmiVhovJgEkeqkSufHZVY2op77Nnuzo3zJ41AUZQJqBhi+sZoNmVYyU8n941Xh0xySZmxgd0LlZgPeArE=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3963.namprd04.prod.outlook.com (20.176.87.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Sun, 14 Apr 2019 19:16:03 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019 19:16:03 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 12/14] Cygwin: FIFO: start the listen_client thread when duping a reader
Date: Sun, 14 Apr 2019 19:16:00 -0000
Message-ID: <20190414191543.3218-13-kbrown@cornell.edu>
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
X-SW-Source: 2019-q2/txt/msg00059.txt.bz2

T3RoZXJ3aXNlIGl0IGRvZXNuJ3QgZ2V0IHN0YXJ0ZWQgdW50aWwgdGhlIGR1
cCdkIGZkIHRyaWVzIHRvIHJlYWQsDQp3aGljaCBkZWxheXMgY2xpZW50IGNv
bm5lY3Rpb25zLg0KLS0tDQogd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZv
LmNjIHwgMjIgKysrKysrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjIGIvd2lu
c3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQppbmRleCBhM2VjYmViNGEu
LmZlNGM2N2JkZiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRs
ZXJfZmlmby5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZv
LmNjDQpAQCAtODUzLDE5ICs4NTMsMjAgQEAgZmhhbmRsZXJfZmlmbzo6Y2xv
c2UgKCkNCiBpbnQNCiBmaGFuZGxlcl9maWZvOjpkdXAgKGZoYW5kbGVyX2Jh
c2UgKmNoaWxkLCBpbnQgZmxhZ3MpDQogew0KKyAgaW50IHJldCA9IC0xOw0K
KyAgZmhhbmRsZXJfZmlmbyAqZmhmID0gTlVMTDsNCisNCiAgIGlmIChmaGFu
ZGxlcl9iYXNlOjpkdXAgKGNoaWxkLCBmbGFncykpDQotICAgIHsNCi0gICAg
ICBfX3NldGVycm5vICgpOw0KLSAgICAgIHJldHVybiAtMTsNCi0gICAgfQ0K
LSAgZmhhbmRsZXJfZmlmbyAqZmhmID0gKGZoYW5kbGVyX2ZpZm8gKikgY2hp
bGQ7DQorICAgIGdvdG8gb3V0Ow0KKw0KKyAgZmhmID0gKGZoYW5kbGVyX2Zp
Zm8gKikgY2hpbGQ7DQogICBpZiAoIUR1cGxpY2F0ZUhhbmRsZSAoR2V0Q3Vy
cmVudFByb2Nlc3MgKCksIHJlYWRfcmVhZHksDQogCQkJR2V0Q3VycmVudFBy
b2Nlc3MgKCksICZmaGYtPnJlYWRfcmVhZHksDQogCQkJMCwgdHJ1ZSwgRFVQ
TElDQVRFX1NBTUVfQUNDRVNTKSkNCiAgICAgew0KICAgICAgIGZoZi0+Y2xv
c2UgKCk7DQogICAgICAgX19zZXRlcnJubyAoKTsNCi0gICAgICByZXR1cm4g
LTE7DQorICAgICAgZ290byBvdXQ7DQogICAgIH0NCiAgIGlmICghRHVwbGlj
YXRlSGFuZGxlIChHZXRDdXJyZW50UHJvY2VzcyAoKSwgd3JpdGVfcmVhZHks
DQogCQkJR2V0Q3VycmVudFByb2Nlc3MgKCksICZmaGYtPndyaXRlX3JlYWR5
LA0KQEAgLTg3NCw3ICs4NzUsNyBAQCBmaGFuZGxlcl9maWZvOjpkdXAgKGZo
YW5kbGVyX2Jhc2UgKmNoaWxkLCBpbnQgZmxhZ3MpDQogICAgICAgQ2xvc2VI
YW5kbGUgKGZoZi0+cmVhZF9yZWFkeSk7DQogICAgICAgZmhmLT5jbG9zZSAo
KTsNCiAgICAgICBfX3NldGVycm5vICgpOw0KLSAgICAgIHJldHVybiAtMTsN
CisgICAgICBnb3RvIG91dDsNCiAgICAgfQ0KICAgZm9yIChpbnQgaSA9IDA7
IGkgPCBuaGFuZGxlcnM7IGkrKykNCiAgICAgew0KQEAgLTg5NSwxMyArODk2
LDE2IEBAIGZoYW5kbGVyX2ZpZm86OmR1cCAoZmhhbmRsZXJfYmFzZSAqY2hp
bGQsIGludCBmbGFncykNCiAJICBDbG9zZUhhbmRsZSAoZmhmLT53cml0ZV9y
ZWFkeSk7DQogCSAgZmhmLT5jbG9zZSAoKTsNCiAJICBfX3NldGVycm5vICgp
Ow0KLQkgIHJldHVybiAtMTsNCisJICBnb3RvIG91dDsNCiAJfQ0KICAgICB9
DQogICBmaGYtPmxpc3Rlbl9jbGllbnRfdGhyID0gTlVMTDsNCiAgIGZoZi0+
bGN0X3Rlcm1pbmF0aW9uX2V2dCA9IE5VTEw7DQogICBmaGYtPmZpZm9fY2xp
ZW50X3VubG9jayAoKTsNCi0gIHJldHVybiAwOw0KKyAgaWYgKCFyZWFkZXIg
fHwgZmhmLT5saXN0ZW5fY2xpZW50ICgpKQ0KKyAgICByZXQgPSAwOw0KK291
dDoNCisgIHJldHVybiByZXQ7DQogfQ0KIA0KIHZvaWQNCi0tIA0KMi4xNy4w
DQoNCg==

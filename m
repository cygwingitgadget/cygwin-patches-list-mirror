Return-Path: <cygwin-patches-return-9374-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103461 invoked by alias); 22 Apr 2019 12:23:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103452 invoked by uid 89); 22 Apr 2019 12:23:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HANDLE, HX-Spam-Relays-External:15.20.1813.14, H*r:15.20.1813.14, fork
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730137.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Apr 2019 12:23:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=GTlid2fB5GBcFfCxwUPj+blRFzP2lCeee39UZ1A03p8=; b=Sw74bnnxV4zY9tem0dz0nx+qBJYkf8RgryhpkeASQHe50TEDtA+27WoWZxOVkUhTHp7FMMK7dgG7liew4RobG2rSZG+unkKbhDrwXa5d+JvK6Y3CWtTcllCSLnLwHxmedGLg3LZHIzene3HamO8jhp7P9mwSoKZUy+ZdasbqDAU=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3946.namprd04.prod.outlook.com (20.176.87.15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.14; Mon, 22 Apr 2019 12:23:03 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019 12:23:03 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: FIFO: restart listen_client thread after fork/exec
Date: Mon, 22 Apr 2019 12:23:00 -0000
Message-ID: <20190422122248.3418-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00081.txt.bz2

VGhpcyBhbGxvd3Mgd3JpdGVycyB0byBjb25uZWN0IGltbWVkaWF0ZWx5LiAg
UHJldmlvdXNseSB0aGUgbGN0IHdhc24ndA0KcmVzdGFydGVkIHVudGlsIHRo
ZSByZWFkZXIgYXR0ZW1wdGVkIHRvIHJlYWQuDQotLS0NCiB3aW5zdXAvY3ln
d2luL2ZoYW5kbGVyX2ZpZm8uY2MgfCAxMiArKysrKy0tLS0tLS0NCiAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNj
IGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQppbmRleCA5Yjk0
YTZkYTkuLmFjMjE5NmM5MiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4v
ZmhhbmRsZXJfZmlmby5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxl
cl9maWZvLmNjDQpAQCAtNzU1LDcgKzc1NSw3IEBAIGZoYW5kbGVyX2ZpZm86
OnJhd19yZWFkICh2b2lkICppbl9wdHIsIHNpemVfdCYgbGVuKQ0KIHsNCiAg
IHNpemVfdCBvcmlnX2xlbiA9IGxlbjsNCiANCi0gIC8qIFN0YXJ0IHRoZSBs
aXN0ZW5fY2xpZW50IHRocmVhZCBpZiBuZWNlc3NhcnkgKGUuZy4sIGFmdGVy
IGZvcmsgb3IgZXhlYykuICovDQorICAvKiBTdGFydCB0aGUgbGlzdGVuX2Ns
aWVudCB0aHJlYWQgaWYgbmVjZXNzYXJ5IChzaG91bGRuJ3QgYmUpLiAqLw0K
ICAgaWYgKCFsaXN0ZW5fY2xpZW50X3RociAmJiAhbGlzdGVuX2NsaWVudCAo
KSkNCiAgICAgZ290byBlcnJvdXQ7DQogDQpAQCAtOTYwLDE4ICs5NjAsMTYg
QEAgZmhhbmRsZXJfZmlmbzo6Zml4dXBfYWZ0ZXJfZm9yayAoSEFORExFIHBh
cmVudCkNCiAgICAgICBmY19oYW5kbGVyW2ldLmZoLT5maGFuZGxlcl9iYXNl
OjpmaXh1cF9hZnRlcl9mb3JrIChwYXJlbnQpOw0KICAgICAgIGZvcmtfZml4
dXAgKHBhcmVudCwgZmNfaGFuZGxlcltpXS5jb25uZWN0X2V2dCwgImNvbm5l
Y3RfZXZ0Iik7DQogICAgIH0NCi0gIGxpc3Rlbl9jbGllbnRfdGhyID0gTlVM
TDsNCi0gIGxjdF90ZXJtaW5hdGlvbl9ldnQgPSBOVUxMOw0KLSAgZmlmb19j
bGllbnRfdW5sb2NrICgpOw0KKyAgaWYgKHJlYWRlciAmJiAhbGlzdGVuX2Ns
aWVudCAoKSkNCisgICAgZGVidWdfcHJpbnRmICgiZmFpbGVkIHRvIHN0YXJ0
IGxjdCwgJUUiKTsNCiB9DQogDQogdm9pZA0KIGZoYW5kbGVyX2ZpZm86OmZp
eHVwX2FmdGVyX2V4ZWMgKCkNCiB7DQogICBmaGFuZGxlcl9iYXNlOjpmaXh1
cF9hZnRlcl9leGVjICgpOw0KLSAgbGlzdGVuX2NsaWVudF90aHIgPSBOVUxM
Ow0KLSAgbGN0X3Rlcm1pbmF0aW9uX2V2dCA9IE5VTEw7DQotICBmaWZvX2Ns
aWVudF91bmxvY2sgKCk7DQorICBpZiAocmVhZGVyICYmICFsaXN0ZW5fY2xp
ZW50ICgpKQ0KKyAgICBkZWJ1Z19wcmludGYgKCJmYWlsZWQgdG8gc3RhcnQg
bGN0LCAlRSIpOw0KIH0NCiANCiB2b2lkDQotLSANCjIuMTcuMA0KDQo=

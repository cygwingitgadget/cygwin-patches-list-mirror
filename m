Return-Path: <cygwin-patches-return-9359-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95235 invoked by alias); 18 Apr 2019 15:39:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95225 invoked by uid 89); 18 Apr 2019 15:39:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-22.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*MI:edu
X-HELO: NAM05-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr710116.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) (40.107.71.116) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Apr 2019 15:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=WkLgAi4A74y/NyVQ+UtXkku5C9pddfO2LOvplVtESJo=; b=Sa7EO+nopbt0AK6bSG8aH7DaDEs0FwcwpplqHHil7NAGUhCt9FjhsGq2e1QmT/2Wekc6f5V09E+hraGiXbgq97Eax5T7QPRqjh0TVRJKyBSYh74jBSs2ZrsnYCv38Jul2vapb1Vm3zO1I3Qq85tIdcfboiA5Bhr8cUu1V/egwN8=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5065.namprd04.prod.outlook.com (20.176.111.146) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.14; Thu, 18 Apr 2019 15:39:53 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019 15:39:53 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: FIFO: avoid hang after exec
Date: Thu, 18 Apr 2019 15:39:00 -0000
Message-ID: <20190418153941.2171-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00066.txt.bz2

RGVmaW5lIGZoYW5kbGVyOmZpZm86OmZpeHVwX2FmdGVyX2V4ZWMsIHdoaWNo
IHNldHMgbGlzdGVuX2NsaWVudF90aHINCmFuZCBsY3RfdGVybWluYXRpb25f
ZXZ0IHRvIE5VTEwuICBUaGlzIGZvcmNlcyB0aGUgbGlzdGVuX2NsaWVudCB0
aHJlYWQNCnRvIHJlc3RhcnQgb24gdGhlIGZpcnN0IGF0dGVtcHQgdG8gcmVh
ZCBhZnRlciBhbiBleGVjLiAgUHJldmlvdXNseSB0aGUNCmV4ZWMnZCBwcm9j
ZXNzIGNvdWxkIGhhbmcgaW4gZmhhbmRsZXJfZmlmbzo6cmF3X3JlYWQuDQot
LS0NCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmggICAgICAgfCAxICsNCiB3
aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MgfCA5ICsrKysrKysrKw0K
IDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oIGIvd2luc3VwL2N5Z3dp
bi9maGFuZGxlci5oDQppbmRleCA4ZmIxNzZiMjQuLmRhMDA3ZWU0NSAxMDA2
NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIuaA0KKysrIGIvd2lu
c3VwL2N5Z3dpbi9maGFuZGxlci5oDQpAQCAtMTMwMSw2ICsxMzAxLDcgQEAg
cHVibGljOg0KICAgc3NpemVfdCBfX3JlZzMgcmF3X3dyaXRlIChjb25zdCB2
b2lkICpwdHIsIHNpemVfdCB1bGVuKTsNCiAgIGJvb2wgYXJtIChIQU5ETEUg
aCk7DQogICB2b2lkIGZpeHVwX2FmdGVyX2ZvcmsgKEhBTkRMRSk7DQorICB2
b2lkIGZpeHVwX2FmdGVyX2V4ZWMgKCk7DQogICBpbnQgX19yZWcyIGZzdGF0
dmZzIChzdHJ1Y3Qgc3RhdHZmcyAqYnVmKTsNCiAgIHZvaWQgY2xlYXJfcmVh
ZGFoZWFkICgpDQogICB7DQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9m
aGFuZGxlcl9maWZvLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZv
LmNjDQppbmRleCAxZDAyYWRiYWEuLmJjOWMyMzk5OCAxMDA2NDQNCi0tLSBh
L3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlmby5jYw0KKysrIGIvd2luc3Vw
L2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQpAQCAtOTQyLDYgKzk0MiwxNSBA
QCBmaGFuZGxlcl9maWZvOjpmaXh1cF9hZnRlcl9mb3JrIChIQU5ETEUgcGFy
ZW50KQ0KICAgZmlmb19jbGllbnRfdW5sb2NrICgpOw0KIH0NCiANCit2b2lk
DQorZmhhbmRsZXJfZmlmbzo6Zml4dXBfYWZ0ZXJfZXhlYyAoKQ0KK3sNCisg
IGZoYW5kbGVyX2Jhc2U6OmZpeHVwX2FmdGVyX2V4ZWMgKCk7DQorICBsaXN0
ZW5fY2xpZW50X3RociA9IE5VTEw7DQorICBsY3RfdGVybWluYXRpb25fZXZ0
ID0gTlVMTDsNCisgIGZpZm9fY2xpZW50X3VubG9jayAoKTsNCit9DQorDQog
dm9pZA0KIGZoYW5kbGVyX2ZpZm86OnNldF9jbG9zZV9vbl9leGVjIChib29s
IHZhbCkNCiB7DQotLSANCjIuMTcuMA0KDQo=

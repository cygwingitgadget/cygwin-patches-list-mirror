Return-Path: <cygwin-patches-return-9454-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20348 invoked by alias); 24 Jun 2019 20:19:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20338 invoked by uid 89); 24 Jun 2019 20:19:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=timer, HX-Languages-Length:932
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820124.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.124) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Jun 2019 20:19:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=xWL5C6sy14FRy1R+03gGDjVUAxA0e1VpYDqY9zL567s=; b=DoPDIdimDwwjkCD/Nec1sKs+oV31UOuc1SACoMzIVK7QONRaLlPLCrJC3klRxV8V8/cA0aQyKqhv+Mg5dbDLrKbHvfiQA5Vpe0hNYMj3jVjSza1mt1hfh8JOFNUc2CQWper48MVTdtvBa47Ndfw9JLp6UlY06VXh9oLF7cghsAw=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2139.namprd04.prod.outlook.com (10.167.8.155) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Mon, 24 Jun 2019 20:19:21 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40%3]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019 20:19:21 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: timerfd: avoid a deadlock
Date: Mon, 24 Jun 2019 20:19:00 -0000
Message-ID: <20190624201852.26148-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:7691;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00161.txt.bz2

SWYgYSB0aW1lciBleHBpcmVzIHdoaWxlIHRoZSB0aW1lcmZkIHRocmVhZCBp
cyBpbiBpdHMgaW5uZXIgbG9vcCwNCmNoZWNrIGZvciB0aGUgdGhyZWFkIGNh
bmNlbGxhdGlvbiBldmVudCBiZWZvcmUgdHJ5aW5nIHRvIGVudGVyDQphX2Ny
aXRpY2FsX3NlY3Rpb24uICBJdCdzIHBvc3NpYmxlIHRoYXQgdGltZXJmZF90
cmFja2VyOjpkdG9yIGhhcw0KZW50ZXJlZCBpdHMgY3JpdGljYWwgc2VjdGlv
biBhbmQgaXMgdHJ5aW5nIHRvIGNhbmNlbCB0aGUgdGhyZWFkLiAgU2VlDQpo
dHRwOi8vd3d3LmN5Z3dpbi5vcmcvbWwvY3lnd2luLzIwMTktMDYvbXNnMDAw
OTYuaHRtbC4NCi0tLQ0KIHdpbnN1cC9jeWd3aW4vdGltZXJmZC5jYyB8IDUg
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3RpbWVyZmQuY2MgYi93aW5zdXAv
Y3lnd2luL3RpbWVyZmQuY2MNCmluZGV4IDhlNGM5NGU2Ni4uZTgyNjFlZjJl
IDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi90aW1lcmZkLmNjDQorKysg
Yi93aW5zdXAvY3lnd2luL3RpbWVyZmQuY2MNCkBAIC0xMzcsNiArMTM3LDEx
IEBAIHRpbWVyZmRfdHJhY2tlcjo6dGhyZWFkX2Z1bmMgKCkNCiAJICAgICAg
Y29udGludWU7DQogCSAgICB9DQogDQorCSAgLyogQXZvaWQgYSBkZWFkbG9j
ayBpZiBkdG9yIGhhcyBqdXN0IGVudGVyZWQgaXRzIGNyaXRpY2FsDQorCSAg
ICAgc2VjdGlvbiBhbmQgaXMgdHJ5aW5nIHRvIGNhbmNlbCB0aGUgdGhyZWFk
LiAqLw0KKwkgIGlmIChJc0V2ZW50U2lnbmFsbGVkIChjYW5jZWxfZXZ0KSkN
CisJICAgIGdvdG8gY2FuY2VsZWQ7DQorDQogCSAgaWYgKCFlbnRlcl9jcml0
aWNhbF9zZWN0aW9uICgpKQ0KIAkgICAgY29udGludWU7DQogCSAgLyogTWFr
ZSBzdXJlIHdlIGhhdmVuJ3QgYmVlbiBhYmFuZG9uZWQgYW5kL29yIGRpc2Fy
bWVkDQotLSANCjIuMjEuMA0KDQo=

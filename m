Return-Path: <cygwin-patches-return-9464-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1965 invoked by alias); 25 Jun 2019 14:25:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1951 invoked by uid 89); 25 Jun 2019 14:25:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:2014
X-HELO: NAM05-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr720112.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) (40.107.72.112) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 14:25:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=UzxDDQhnosSVGZqBY6ty5IrkU2EEIfshhtERTu9qrJw=; b=jwep6HeuoEL2ey5TssTOacD4JKUlWuh/SE75iTHYam80AzjGSJdjzco1abs7N+mGZy8lKVGPUnt/N9EFjOVpl2wAvaQoK11e8/kK7S7NX2N0v/W884p7YGP3ItxojEtb3LggiYCUWY2f2WgKmaAPN5k2JZk113vQZyKU3ak4MDQ=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2330.namprd04.prod.outlook.com (10.166.204.11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.15; Tue, 25 Jun 2019 14:25:16 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40%3]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019 14:25:16 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2] Cygwin: timerfd: avoid a deadlock
Date: Tue, 25 Jun 2019 14:25:00 -0000
Message-ID: <20190625142502.46350-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00171.txt.bz2

QWRkIGEgZnVuY3Rpb24gdGltZXJmZF90cmFja2VyOjplbnRlcl9jcml0aWNh
bF9zZWN0aW9uX2NhbmNlbGFibGUsDQp3aGljaCBpcyBsaWtlIGVudGVyX2Ny
aXRpY2FsX3NlY3Rpb24gYnV0IGhvbm9ycyBhIGNhbmNlbCBldmVudC4gIENh
bGwNCnRoaXMgd2hlbiBhIHRpbWVyIGV4cGlyZXMgd2hpbGUgdGhlIHRpbWVy
ZmQgdGhyZWFkIGlzIGluIGl0cyBpbm5lcg0KbG9vcC4gIFRoaXMgYXZvaWRz
IGEgZGVhZGxvY2sgaWYgdGltZXJmZF90cmFja2VyOjpkdG9yIGhhcyBlbnRl
cmVkIGl0cw0KY3JpdGljYWwgc2VjdGlvbiBhbmQgaXMgdHJ5aW5nIHRvIGNh
bmNlbCB0aGUgdGhyZWFkLiAgU2VlDQpodHRwOi8vd3d3LmN5Z3dpbi5vcmcv
bWwvY3lnd2luLzIwMTktMDYvbXNnMDAwOTYuaHRtbC4NCi0tLQ0KIHdpbnN1
cC9jeWd3aW4vdGltZXJmZC5jYyB8IDI0ICsrKysrKysrKysrKysrKysrKysr
KysrLQ0KIHdpbnN1cC9jeWd3aW4vdGltZXJmZC5oICB8ICAyICsrDQogMiBm
aWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3RpbWVyZmQuY2MgYi93
aW5zdXAvY3lnd2luL3RpbWVyZmQuY2MNCmluZGV4IDhlNGM5NGU2Ni4uZjFh
NGMyODA0IDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi90aW1lcmZkLmNj
DQorKysgYi93aW5zdXAvY3lnd2luL3RpbWVyZmQuY2MNCkBAIC04OSw2ICs4
OSwyNSBAQCB0aW1lcmZkX3RyYWNrZXI6OmhhbmRsZV90aW1lY2hhbmdlX3dp
bmRvdyAoKQ0KICAgICB9DQogfQ0KIA0KKy8qIExpa2UgZW50ZXJfY3JpdGlj
YWxfc2VjdGlvbiwgYnV0IHJldHVybnMgLTEgb24gYSBjYW5jZWwgZXZlbnQu
ICovDQoraW50DQordGltZXJmZF90cmFja2VyOjplbnRlcl9jcml0aWNhbF9z
ZWN0aW9uX2NhbmNlbGFibGUgKCkNCit7DQorICBIQU5ETEUgd1syXSA9IHsg
Y2FuY2VsX2V2dCwgX2FjY2Vzc19tdHggfTsNCisgIERXT1JEIHdhaXRyZXQg
PSBXYWl0Rm9yTXVsdGlwbGVPYmplY3RzICgyLCB3LCBGQUxTRSwgSU5GSU5J
VEUpOw0KKw0KKyAgc3dpdGNoICh3YWl0cmV0KQ0KKyAgICB7DQorICAgIGNh
c2UgV0FJVF9PQkpFQ1RfMDoNCisgICAgICByZXR1cm4gLTE7DQorICAgIGNh
c2UgV0FJVF9PQkpFQ1RfMCArIDE6DQorICAgIGNhc2UgV0FJVF9BQkFORE9O
RURfMCArIDE6DQorICAgICAgcmV0dXJuIDE7DQorICAgIGRlZmF1bHQ6DQor
ICAgICAgcmV0dXJuIDA7DQorICAgIH0NCit9DQorDQogRFdPUkQNCiB0aW1l
cmZkX3RyYWNrZXI6OnRocmVhZF9mdW5jICgpDQogew0KQEAgLTEzNyw3ICsx
NTYsMTAgQEAgdGltZXJmZF90cmFja2VyOjp0aHJlYWRfZnVuYyAoKQ0KIAkg
ICAgICBjb250aW51ZTsNCiAJICAgIH0NCiANCi0JICBpZiAoIWVudGVyX2Ny
aXRpY2FsX3NlY3Rpb24gKCkpDQorCSAgaW50IGVjID0gZW50ZXJfY3JpdGlj
YWxfc2VjdGlvbl9jYW5jZWxhYmxlICgpOw0KKwkgIGlmIChlYyA8IDApDQor
CSAgICBnb3RvIGNhbmNlbGVkOw0KKwkgIGVsc2UgaWYgKCFlYykNCiAJICAg
IGNvbnRpbnVlOw0KIAkgIC8qIE1ha2Ugc3VyZSB3ZSBoYXZlbid0IGJlZW4g
YWJhbmRvbmVkIGFuZC9vciBkaXNhcm1lZA0KIAkgICAgIGluIHRoZSBtZWFu
dGltZSAqLw0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vdGltZXJmZC5o
IGIvd2luc3VwL2N5Z3dpbi90aW1lcmZkLmgNCmluZGV4IDE1NGJlMDg0Ny4u
ODA2ODhlNzllIDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi90aW1lcmZk
LmgNCisrKyBiL3dpbnN1cC9jeWd3aW4vdGltZXJmZC5oDQpAQCAtODYsNiAr
ODYsOCBAQCBjbGFzcyB0aW1lcmZkX3RyYWNrZXIJCS8qIGN5Z2hlYXAhICov
DQogICAgICAgcmV0dXJuIChXYWl0Rm9yU2luZ2xlT2JqZWN0IChfYWNjZXNz
X210eCwgSU5GSU5JVEUpICYgfldBSVRfQUJBTkRPTkVEXzApDQogCSAgICAg
ID09IFdBSVRfT0JKRUNUXzA7DQogICAgIH0NCisgIC8qIEEgdmVyc2lvbiB0
aGF0IGhvbm9ycyBhIGNhbmNlbCBldmVudCwgZm9yIHVzZSBpbiB0aHJlYWRf
ZnVuYy4gKi8NCisgIGludCBlbnRlcl9jcml0aWNhbF9zZWN0aW9uX2NhbmNl
bGFibGUgKCk7DQogICB2b2lkIGxlYXZlX2NyaXRpY2FsX3NlY3Rpb24gKCkN
CiAgICAgew0KICAgICAgIFJlbGVhc2VNdXRleCAoX2FjY2Vzc19tdHgpOw0K
LS0gDQoyLjIxLjANCg0K

Return-Path: <cygwin-patches-return-9463-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67483 invoked by alias); 25 Jun 2019 13:25:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67461 invoked by uid 89); 25 Jun 2019 13:24:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr700107.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) (40.107.70.107) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 13:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none; b=FihZCfem8Bnc23KOzc+xs7aJc246tkeB5lybzc6tratax1CiNkNfAsPYS5Ub/QKp+AV2A5QOWMWxdJPKWlo4JsIyKkyAM0w8g7p2VyKxXsf6nkJY9HWNodfE/m185Kf6QBXpcmiBMb9kabi+N9WLet9mQeNr8Vw7RhUeWTQSWpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=testarcselector01; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=p35NZfUhmfkwSlowDB5XhAzUKmVjTHd4vw38uGmtC/E=; b=iTjtFihJsJaLtaDGqfs9mA8/oCteEfT8HvKbgwknyeHLjPS72UDriaTpoYXqfhhaXarsayN8T7Q0Q2vd64L53rwxUSLR60XjG10T8TFlWE4WNr5siVLlZCXuj+FIEbsvBlAn3dvy+vzmLhXqPOBUF1cy7KCm/aCKXRUOg4VNoi8=
ARC-Authentication-Results: i=1; test.office365.com 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=p35NZfUhmfkwSlowDB5XhAzUKmVjTHd4vw38uGmtC/E=; b=PdH5AnLijFke0dUiIfPr2WBJnkCn+0x68hK6HpFdIGL0kR82i3c5Tdfr05JIOjW7x2UB8REtXWJPF10BGYwq8LBFsVup/ZmfeFyHvfBjiEet/y4GURN/2Qcz7uuj6V7+irkWHg0W9C+3/iZwI0g64FDKKetu9Dd8Pw5wFs38w/Q=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2346.namprd04.prod.outlook.com (10.167.9.24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun 2019 13:24:52 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40%3]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019 13:24:52 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: timerfd: avoid a deadlock
Date: Tue, 25 Jun 2019 13:25:00 -0000
Message-ID: <190a9c87-a3bd-aeff-37c3-da5a7fe32279@cornell.edu>
References: <20190624201852.26148-1-kbrown@cornell.edu> <20190625074348.GF5738@calimero.vinschen.de>
In-Reply-To: <20190625074348.GF5738@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.2
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:5236;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <515BAD7F5CE45149BF13E88C7CCA5877@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00170.txt.bz2

T24gNi8yNS8yMDE5IDM6NDMgQU0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IEhpIEtlbiwNCj4gDQo+IE9uIEp1biAyNCAyMDoxOSwgS2VuIEJyb3du
IHdyb3RlOg0KPj4gSWYgYSB0aW1lciBleHBpcmVzIHdoaWxlIHRoZSB0aW1l
cmZkIHRocmVhZCBpcyBpbiBpdHMgaW5uZXIgbG9vcCwNCj4+IGNoZWNrIGZv
ciB0aGUgdGhyZWFkIGNhbmNlbGxhdGlvbiBldmVudCBiZWZvcmUgdHJ5aW5n
IHRvIGVudGVyDQo+PiBhX2NyaXRpY2FsX3NlY3Rpb24uICBJdCdzIHBvc3Np
YmxlIHRoYXQgdGltZXJmZF90cmFja2VyOjpkdG9yIGhhcw0KPj4gZW50ZXJl
ZCBpdHMgY3JpdGljYWwgc2VjdGlvbiBhbmQgaXMgdHJ5aW5nIHRvIGNhbmNl
bCB0aGUgdGhyZWFkLiAgU2VlDQo+PiBodHRwOi8vd3d3LmN5Z3dpbi5vcmcv
bWwvY3lnd2luLzIwMTktMDYvbXNnMDAwOTYuaHRtbC4NCj4+IC0tLQ0KPj4g
ICB3aW5zdXAvY3lnd2luL3RpbWVyZmQuY2MgfCA1ICsrKysrDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi90aW1lcmZkLmNjIGIvd2luc3VwL2N5Z3dp
bi90aW1lcmZkLmNjDQo+PiBpbmRleCA4ZTRjOTRlNjYuLmU4MjYxZWYyZSAx
MDA2NDQNCj4+IC0tLSBhL3dpbnN1cC9jeWd3aW4vdGltZXJmZC5jYw0KPj4g
KysrIGIvd2luc3VwL2N5Z3dpbi90aW1lcmZkLmNjDQo+PiBAQCAtMTM3LDYg
KzEzNywxMSBAQCB0aW1lcmZkX3RyYWNrZXI6OnRocmVhZF9mdW5jICgpDQo+
PiAgIAkgICAgICBjb250aW51ZTsNCj4+ICAgCSAgICB9DQo+PiAgIA0KPj4g
KwkgIC8qIEF2b2lkIGEgZGVhZGxvY2sgaWYgZHRvciBoYXMganVzdCBlbnRl
cmVkIGl0cyBjcml0aWNhbA0KPj4gKwkgICAgIHNlY3Rpb24gYW5kIGlzIHRy
eWluZyB0byBjYW5jZWwgdGhlIHRocmVhZC4gKi8NCj4+ICsJICBpZiAoSXNF
dmVudFNpZ25hbGxlZCAoY2FuY2VsX2V2dCkpDQo+PiArCSAgICBnb3RvIGNh
bmNlbGVkOw0KPiANCj4gVGhpcyBsb29rcyBzdGlsbCByYWN5LCB3aGF0IGlm
IGNhbmNlbF9ldnQgaXMgc2V0IGp1c3QgYmV0d2VlbiB0aGUNCj4gSXNFdmVu
dFNpZ25hbGxlZCgpIGFuZCBlbnRlcl9jcml0aWNhbF9zZWN0aW9uKCkgY2Fs
bHM/DQo+IA0KPiBIbW0uDQo+IA0KPiBXaGF0IGlmIHdlIHJlZGVmaW5lIGVu
dGVyX2NyaXRpY2FsX3NlY3Rpb24oKSB0byByZXR1cm4gdGhyZWUNCj4gc3Rh
dGVzLiAgSXQgY2FsbHMgV0ZNTyBvbiBjYW5jZWxfZXZ0IGFuZCBfYWNjZXNz
X210eCwgaW4gdGhpcyBvcmRlciwNCj4gc28gdGhhdCBhIGNhbmNlbCBldmVu
dCBpcyBob25vcmVkLiAgT3IgbWF5YmUgaW50cm9kdWNlIGFub3RoZXINCj4g
ZnVuY3Rpb24gbGlrZSBlbnRlcl9jcml0aWNhbF9zZWN0aW9uX2NhbmNlbGFi
bGUoKSB3aGljaCBpcyBvbmx5DQo+IGNhbGxlZCBpbiB0aGlzIHNpbmdsZSBp
bnN0YW5jZSBpbiB0aW1lcmZkX3RyYWNrZXI6OnRocmVhZF9mdW5jPw0KDQpZ
ZXMsIHRoYXQncyBtdWNoIGJldHRlci4gIEknbGwgc2VuZCB2MiBzaG9ydGx5
LCBhZnRlciBzb21lIHRlc3RpbmcuDQoNCktlbg0K

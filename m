Return-Path: <cygwin-patches-return-9759-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10992 invoked by alias); 17 Oct 2019 14:55:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10983 invoked by uid 89); 17 Oct 2019 14:55:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1691
X-HELO: NAM03-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr790093.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) (40.107.79.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Oct 2019 14:55:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=iYUWspYmd9lyPdC/TgaT4TSzCOqXjebyalN5Wg8U0kj1VK20/ew4pOQ8Yu2uPozi0ePNJytMxi5C9LC20NAF5QmLiaNGTteaRs1paXPMZD9s4Tx67CXMDkJILxRS/OxOwydEvto8EnDvv67siC2Q4gYsk0/ldJON4D3wGIP+5260+b+tFuN1InM2Jp48datHVPa+g6Vk7Sd46QnLow301JE9e/njwJH+0UPY7QGu1Pn4uhTxNhnwSmd2cl1ukH5apbKxHkAGyuJqrbD+sWpQbw5rvnxbKfKm/YVQ5vljaoNCI0KbQIH9H64ivLNO8r1olcU2HMxvge1qVA7RL7wv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=HjcD1vPQtPJgM5LtMk8Vqqt/MLALb69FzHS7LOKZQC0=; b=SWMQZtuEg6l4g0YV/oEFV0OUR6sz90ujsNBoK6tsawv9N4BNKhtt60poocBsYP/udxhOgpzrtpNmzlLZ4RTakQOI7UkQw6s0fn3nPVXwJ/OdIRuILnkL8vrpCbYg6CEeSABbk2vplxBj4sLW/grYAznbrUlTkW6wGRVIQYo0xhetfmMOWsv8eynst2szg7H2HAy+lGodcgEBOJx7T0Gj3xcbR0YWa5omxzB7b6LxNKnP7Z28Ua0H0fyVKpeSLE8B5BGFEs1pV01kR6U+iQWgR6M8ISpqDLXDrOpFFhNvcf+dMBT5Q+HePSBWCAhWx/xODQE4kS12+Ak7rvBOUCqdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=HjcD1vPQtPJgM5LtMk8Vqqt/MLALb69FzHS7LOKZQC0=; b=EcHDeF5O7mglo/lz6/xxeOo2gaxJ17UKFp/1Ok4opmG6DritRJjyshS5wTGImHihEjNVAql8oLwMqfAWpGm02lCuc6BopmNZKmm7jV/tVPxUD91cIuXJAVHcWxibQ0cw2us6i7Sew7sQUKgIrNkW3DRuJ5QU8b2J+AGpRvcUIKo=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4649.namprd04.prod.outlook.com (20.176.105.214) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Thu, 17 Oct 2019 14:55:20 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172%4]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019 14:55:20 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: Re: [PATCH] Cygwin: pty: Change the timing of clear screen.
Date: Thu, 17 Oct 2019 14:55:00 -0000
Message-ID: <0c90ed2b-ed1e-643c-5643-78f50444f97d@cornell.edu>
References: <20191016123409.457-1-takashi.yano@nifty.ne.jp> <20191016123409.457-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20191016123409.457-2-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:359;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D28ED50A5648747B0CCFCAC706E7004@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdF68CYjKoeS3os27qF5q433dVSh3d1SBx7+0hW0Na+zN0ZuXGB9OwYz6+BXB8RufPh2s0pEVHr4gp0gg6dVng==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00030.txt.bz2

T24gMTAvMTYvMjAxOSA4OjM0IEFNLCBUYWthc2hpIFlhbm8gd3JvdGU6DQo+
IC0tLQ0KPiAgIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjIHwgMjYg
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl90dHkuY2MgYi93
aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYw0KPiBpbmRleCAxMDk1Yzgy
ZWIuLmJhZjNjOTc5NCAxMDA2NDQNCj4gLS0tIGEvd2luc3VwL2N5Z3dpbi9m
aGFuZGxlcl90dHkuY2MNCj4gKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxl
cl90dHkuY2MNCj4gQEAgLTI3MTQsNiArMjcxNCwxOSBAQCBmaGFuZGxlcl9w
dHlfc2xhdmU6OmZpeHVwX2FmdGVyX2ZvcmsgKEhBTkRMRSBwYXJlbnQpDQo+
ICAgICAvLyBmb3JrX2ZpeHVwIChwYXJlbnQsIGludXNlLCAiaW51c2UiKTsN
Cj4gICAgIC8vIGZoYW5kbGVyX3B0eV9jb21tb246OmZpeHVwX2FmdGVyX2Zv
cmsgKHBhcmVudCk7DQo+ICAgICByZXBvcnRfdHR5X2NvdW50cyAodGhpcywg
ImluaGVyaXRlZCIsICIiKTsNCj4gKw0KPiArICBpZiAoZ2V0X3R0eXAgKCkt
Pm5lZWRfY2xlYXJfc2NyZWVuKQ0KPiArICAgIHsNCj4gKyAgICAgIGNvbnN0
IGNoYXIgKnRlcm0gPSBnZXRlbnYgKCJURVJNIik7DQo+ICsgICAgICBpZiAo
dGVybSAmJiBzdHJjbXAgKHRlcm0sICJkdW1iIikgJiYgIXN0cnN0ciAodGVy
bSwgImVtYWNzIikpDQo+ICsJew0KPiArCSAgLyogRklYTUU6IENsZWFyaW5n
IHNlcXVlbmNlIG1heSBub3QgYmUgIl5bW0heW1tKIg0KPiArCSAgICAgZGVw
ZW5kaW5nIG9uIHRoZSB0ZXJtaW5hbCB0eXBlLiAqLw0KPiArCSAgRFdPUkQg
bjsNCj4gKwkgIFdyaXRlRmlsZSAoZ2V0X291dHB1dF9oYW5kbGVfY3lnICgp
LCAiXDAzM1tIXDAzM1tKIiwgNiwgJm4sIE5VTEwpOw0KPiArCX0NCj4gKyAg
ICAgIGdldF90dHlwICgpLT5uZWVkX2NsZWFyX3NjcmVlbiA9IGZhbHNlOw0K
PiArICAgIH0NCj4gICB9DQo+ICAgDQo+ICAgdm9pZA0KPiBAQCAtMjc1Nywx
OSArMjc3MCw2IEBAIGZoYW5kbGVyX3B0eV9zbGF2ZTo6Zml4dXBfYWZ0ZXJf
ZXhlYyAoKQ0KPiAgIAl9DQo+ICAgICAgIH0NCj4gICANCj4gLSAgaWYgKGdl
dF90dHlwICgpLT5uZWVkX2NsZWFyX3NjcmVlbikNCj4gLSAgICB7DQo+IC0g
ICAgICBjb25zdCBjaGFyICp0ZXJtID0gZ2V0ZW52ICgiVEVSTSIpOw0KPiAt
ICAgICAgaWYgKHRlcm0gJiYgc3RyY21wICh0ZXJtLCAiZHVtYiIpICYmICFz
dHJzdHIgKHRlcm0sICJlbWFjcyIpKQ0KPiAtCXsNCj4gLQkgIC8qIEZJWE1F
OiBDbGVhcmluZyBzZXF1ZW5jZSBtYXkgbm90IGJlICJeW1tIXltbSiINCj4g
LQkgICAgIGRlcGVuZGluZyBvbiB0aGUgdGVybWluYWwgdHlwZS4gKi8NCj4g
LQkgIERXT1JEIG47DQo+IC0JICBXcml0ZUZpbGUgKGdldF9vdXRwdXRfaGFu
ZGxlX2N5ZyAoKSwgIlwwMzNbSFwwMzNbSiIsIDYsICZuLCBOVUxMKTsNCj4g
LQl9DQo+IC0gICAgICBnZXRfdHR5cCAoKS0+bmVlZF9jbGVhcl9zY3JlZW4g
PSBmYWxzZTsNCj4gLSAgICB9DQo+IC0NCj4gICAgIC8qIFNldCBsb2NhbGUg
Ki8NCj4gICAgIHNldHVwX2xvY2FsZSAoKTsNCg0KVGhpcyBhbmQgdGhlIHBy
ZXZpb3VzIHBhdGNoIGxvb2sgZ29vZCB0byBtZSwgYnV0IHdlIHNob3VsZCBw
cm9iYWJseSB3YWl0IA0KZm9yIEhhdWJpIHRvIGNvbmZpcm0gdGhhdCB0aGV5
IGZpeCB0aGUgcHJvYmxlbXMgaGUgcmVwb3J0ZWQuDQoNCktlbg0K

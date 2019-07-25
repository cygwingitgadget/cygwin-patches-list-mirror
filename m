Return-Path: <cygwin-patches-return-9527-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88435 invoked by alias); 25 Jul 2019 19:59:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88425 invoked by uid 89); 25 Jul 2019 19:59:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=emacs, HX-HELO:sk:NAM02-B
X-HELO: NAM02-BL2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr750104.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) (40.107.75.104) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 25 Jul 2019 19:59:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=ZFnPpDaOnRtkT8OstoBFKAx2u/XL85SDN2bUa12ldRjnJRP4RY750C3X8ZWtk+qLh/6xOYUMXq1iKrahN5/T10Bx6zt5ikFnZpfypGFE39+7RBh4xltTBM0odIQofQafai+2FEKmbV2TEDtXUr+okShxaLiMaKTLCvuiYF3nQRgY1bwlOabQcUvYqKhgEjqzQBwt7uw3fSC3efIGuxTaXxI5PxEQMmrkfJdL8hSWJJ0Ls/QHjJyNfkD/62iGDX2V9APyWWWkwOF8FPwlAN0pr9K1+v/B6JqW1+9NyDIhdyqQSX9zgxg8yayrS0QMFg0RZcEfClodVZ46odTB9Dd6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=KH8WDy/F9eQycARLx7+5zVMEmeIzCFDwy4kJbELqXAM=; b=ESVPTgHLOmJvuGVCbCbhcoYZGsf0GhKohxmMZwyZXDq+YpCxrKWo49jHg1CoCajRGeKCQWBt6W5XrMQ6CnlwyOdjKKSY2RvZk3xbhgKvx5kqFnFKxBrPUoO/d0AnDAnNibqgvE1uZubw4SBeI1Tj+DVf0tTaIhHbnctMWo4UHQiFw+5Zu1ha1N87dqA0G1xsohHK3IQso/w5XPdQKqz5VzQN27Fgq3UzEMnqBiRq3P1jHnE+HhVolt6F4WXv5+W3J8P5wzj5hdES8eQHpb+gwXxoC1OzgrUsjqy2l7L96JpmTlkq5wgHquZqfEXx4mTDYdNq2OsqtzhYXZHl5iCC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=KH8WDy/F9eQycARLx7+5zVMEmeIzCFDwy4kJbELqXAM=; b=M/88ZHmatFXo//x34bM4X4vo7KbD7HC5taVpjArjITz5k3OAQkAEZ6O26ls1tulZ6nK6luLXJ//L7W3/jJaOQ4Z2fuMeKW7+G8EHT1hF+MGYmF/G9aDhpOY7g2oolXjUHGHlgY0mbhafc/9MrHTYXhscYHR+l0fpXGXGDaT+P6c=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2363.namprd04.prod.outlook.com (10.167.8.141) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Thu, 25 Jul 2019 19:59:17 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.017; Thu, 25 Jul 2019 19:59:17 +0000
From: Ken Brown <kbrown@cornell.edu>
To: Jon Turney <jon.turney@dronecode.org.uk>, "cygwin-patches@cygwin.com"	<cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: Fix the address of myself
Date: Thu, 25 Jul 2019 19:59:00 -0000
Message-ID: <5b98b10f-73f8-4567-1aaf-934a1200dd75@cornell.edu>
References: <20190724162524.5604-1-corinna-cygwin@cygwin.com> <20190724165447.28339-1-corinna-cygwin@cygwin.com> <22d165b6-2b4b-4e94-7bbf-77449b662e8a@cornell.edu> <20190725133729.GB11632@calimero.vinschen.de>
In-Reply-To: <20190725133729.GB11632@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:2733;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <B01EE6F4482F4F44B69F53CBB4AEF90D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00047.txt.bz2

T24gNy8yNS8yMDE5IDk6MzcgQU0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IE9uIEp1bCAyNCAxOToxMSwgS2VuIEJyb3duIHdyb3RlOg0KPj4gT24g
Ny8yNC8yMDE5IDEyOjU0IFBNLCBDb3Jpbm5hIFZpbnNjaGVuIHdyb3RlOg0K
Pj4+IEZyb206IENvcmlubmEgVmluc2NoZW4gPGNvcmlubmFAdmluc2NoZW4u
ZGU+DQo+Pj4NCj4+PiB2MjogcmVwaHJhc2UgY29tbWl0IG1lc3NhZ2UNCj4+
Pg0KPj4+IEludHJvZHVjaW5nIGFuIGluZGVwZW5kZW50IEN5Z3dpbiBQSUQg
aW50cm9kdWNlZCBhIHJlZ3Jlc3Npb246DQo+Pj4NCj4+PiBUaGUgZXhwZWN0
YXRpb24gaXMgdGhhdCB0aGUgbXlzZWxmIHBpbmZvIHBvaW50ZXIgYWx3YXlz
IHBvaW50cyB0byBhDQo+Pj4gc3BlY2lmaWMgYWRkcmVzcyByaWdodCBpbiBm
cm9udCBvZiB0aGUgbG9hZGVkIEN5Z3dpbiBETEwuDQo+Pj4NCj4+PiBIb3dl
dmVyLCB0aGUgaW5kZXBlbmRlbnQgQ3lnd2luIFBJRCBjaGFuZ2VzIGJyb2tl
IHRoaXMuICBUbyBjcmVhdGUNCj4+PiBteXNlbGYgYXQgdGhlIHJpZ2h0IGFk
ZHJlc3MgcmVxdWlyZXMgdG8gY2FsbCBpbml0IHdpdGggaDAgc2V0IHRvDQo+
Pj4gSU5WQUxJRF9IQU5ETEVfVkFMVUUgb3IgYW4gZXhpc3RpbmcgYWRkcmVz
czoNCj4+Pg0KPj4+IHZvaWQNCj4+PiBwaW5mbzo6aW5pdCAocGlkX3Qgbiwg
RFdPUkQgZmxhZywgSEFORExFIGgwKQ0KPj4+IHsNCj4+PiAgICAgWy4uLl0N
Cj4+PiAgICAgaWYgKCFoMCB8fCBteXNlbGYuaCkNCj4+PiAgICAgICBbLi4u
XQ0KPj4+ICAgICBlbHNlDQo+Pj4gICAgICAgew0KPj4+ICAgICAgICAgc2hs
b2MgPSBTSF9NWVNFTEY7DQo+Pj4gICAgICAgICBpZiAoaDAgPT0gSU5WQUxJ
RF9IQU5ETEVfVkFMVUUpICAgICAgIDwtLSAhISENCj4+PiAgICAgICAgICAg
aDAgPSBOVUxMOw0KPj4+ICAgICAgIH0NCj4+Pg0KPj4+IFRoZSBhZm9yZW1l
bnRpb25lZCBjb21taXRzIGNoYW5nZWQgdGhhdCBzbyBoMCB3YXMgYWx3YXlz
IE5VTEwsIHRoaXMgd2F5DQo+Pj4gY3JlYXRpbmcgbXlzZWxmIGF0IGFuIGFy
Yml0cmFyeSBhZGRyZXNzLg0KPj4+DQo+Pj4gVGhpcyBwYXRjaCBtYWtlcyBz
dXJlIHRvIHNldCB0aGUgaGFuZGxlIHRvIElOVkFMSURfSEFORExFX1ZBTFVF
IGFnYWluDQo+Pj4gd2hlbiBjcmVhdGluZyBhIG5ldyBwcm9jZXNzLCBzbyBp
bml0IGtub3dzIHRoYXQgbXlzZWxmIGhhcyB0byBiZSBjcmVhdGVkDQo+Pj4g
aW4gdGhlIHJpZ2h0IHNwb3QuICBXaGlsZSBhdCBpdCwgZml4IGEgcG90ZW50
aWFsIHVuaW5pdGlhbGl6ZWQgaGFuZGxlDQo+Pj4gdmFsdWUgaW4gY2hpbGRf
aW5mb19zcGF3bjo6aGFuZGxlX3NwYXduLg0KPj4+DQo+Pj4gRml4ZXM6IGI1
ZTEwMDM3MjJjYiAoIkN5Z3dpbjogcHJvY2Vzc2VzOiB1c2UgZGVkaWNhdGVk
IEN5Z3dpbiBQSUQgcmF0aGVyIHRoYW4gV2luZG93cyBQSUQiKQ0KPj4+IEZp
eGVzOiA4ODYwNTI0M2ExOWIgKCJDeWd3aW46IGZpeCBjaGlsZCBnZXR0aW5n
IGFub3RoZXIgcGlkIGFmdGVyIHNwYXdudmUiKQ0KPj4+IFNpZ25lZC1vZmYt
Ynk6IENvcmlubmEgVmluc2NoZW4gPGNvcmlubmFAdmluc2NoZW4uZGU+DQo+
Pj4gLS0tDQo+Pj4gICAgd2luc3VwL2N5Z3dpbi9kY3J0MC5jYyB8IDIgKy0N
Cj4+PiAgICB3aW5zdXAvY3lnd2luL3BpbmZvLmNjIHwgMyArLS0NCj4+PiAg
ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4+PiBbLi4uXQ0KPj4NCj4+IEknbGwgYmUgZ2xhZCB0byB0YWtl
IGEgY2xvc2UgbG9vayBhdCB0aGlzIGFzIHlvdSBhc2tlZC4gIEJ1dCBJJ20g
bm90IGZhbWlsaWFyDQo+PiB3aXRoIHRoaXMgcGFydCBvZiB0aGUgY29kZSwg
c28gaXQgd2lsbCB0YWtlIG1lIGEgbGl0dGxlIHRpbWUuDQo+Pg0KPj4gS2Vu
DQo+IA0KPiBUaGFua3MhICBJIGFjY2lkZW50YWxseSBwdXNoZWQgdGhlIHBh
dGNoIGEgZmV3IG1pbnV0ZXMgYWdvIHdoZW4gSQ0KPiB3YXMgYWN0dWFsbHkg
anVzdCBwbGFubmluZyB0byBwdXNoIHRoZSBuZGJtLmggcGF0Y2guICBBbnl3
YXksIEkNCj4gdG9vayB0aGUgb3Bwb3J0dW5pdHkgdG8gY3JlYXRlIG5ldyBz
bmFwc2hvdHMgd2l0aCBhbGwgcGF0Y2hlcyBmcm9tDQo+IHllc3RlcmRheSBh
bmQgdG9kYXksIHNvIHRoZSBnZXRwZ3JwIHByb2JsZW1zIGluIEdEQiA4LjEu
MSBhbmQgOC4yLjENCj4gc2hvdWxkIGJvdGggYmUgZml4ZWQgdGhlcmUgYXMg
d2VsbC4NCj4gDQo+IEknZCBzdGlsbCBiZSBnbGFkIGlmIHRoZSB0d28gb2Yg
eW91IGNvdWxkIGNoZWNrIGlmIG15IHBhdGNoIG1ha2VzDQo+IHNlbnNlIGFz
IGlzLg0KDQpJdCBsb29rcyBmaW5lIHRvIG1lLCB0aG91Z2ggSSBjYW4ndCBj
bGFpbSB0byBoYXZlIGdyYXNwZWQgYWxsIGl0cyBpbXBsaWNhdGlvbnMuIA0K
SW4gYW55IGNhc2UsIEkndmUgaW5zdGFsbGVkIGl0IGFuZCBoYXZlIGRvbmUg
YSBmZXcgdGhpbmdzIHRoYXQgb2Z0ZW4gY2F0Y2ggYnVncyANCihlLmcuLCBi
dWlsZGluZyBlbWFjcyBhbmQgcnVubmluZyBpdHMgdGVzdCBzdWl0ZSksIGFu
ZCB0aGVyZSBhcmUgbm8gcHJvYmxlbXMgc28gZmFyLg0KDQpNeSBuZXh0IHN0
ZXAgd2lsbCBiZSB0byBpbnN0YWxsIHRoZSBleHBlcmltZW50YWwgcGlwZSBj
b2RlIHRoYXQgSSBwb3N0ZWQgaW4gDQpodHRwczovL2N5Z3dpbi5jb20vbWwv
Y3lnd2luLXBhdGNoZXMvMjAxOS1xMi9tc2cwMDE0NC5odG1sIHRvIHNlZSBp
ZiB0aGF0IHNoYWtlcyANCmFueXRoaW5nIGxvb3NlLg0KDQpLZW4NCg==

Return-Path: <cygwin-patches-return-9541-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78120 invoked by alias); 31 Jul 2019 17:25:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78111 invoked by uid 89); 31 Jul 2019 17:25:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr720138.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) (40.107.72.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Jul 2019 17:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=dvkkYCpEUIUDU//P0KUgiqBbhncyjNmEQe6f5UkYllORj1ZgrtZXevksgOMypDqnEvRNq1EQY+DaYbTEKLTK6k3p6JFfYjUfogeRaaWPn/BR0tZ067/IGAoBYIFwBN2lCS716VsbOqJTcSrfAHEx/E3EdIlO0VlxcCBg+0omujtcWfUGi3qVLVVqvGdTt69HyEWNMxrDs7IzKm8iTCdL5D2tsq4qhbPNuWR8DzVu0VqfkC7RF+G8ZdRiJldazNdhzuoKWv9Ubnj87E8VxLsDTLu4iJXjpXOCIeRA/IFJ57YdF32CC7GCQNanqLanMMJkEymLEAp9lnflzXjZwjie4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=iqps25TN4514W+DWPQZ/ByPPXm936aav0dSRUzapgbE=; b=gKoOpl63aew1gdf3AiQqy/pJ2vKd9cMBAP7fXtfC9zcXTYCBpZLP5BAkvu39fxfl/Mqs4pdFtp1rtKRHTSvxx4rimEDAejEatbr91T1V5ny90rYIozfcy/ZlfzDki8oM/1VNeVbd8YZn1fAIuuDAiXark+vf8zje0uVx5qmGkfb2y7zTr2BeNjAonQ7bYgB4G9Q3YszIBvjbp1rBaLdDUzy4fa9z1otHOoQ8SAF1KzewhIMm1Gx/ZVw0nZEoJyU7+pP9y+3tgMvNe45pTaBeOYY3JCGUAAIRC6V+VCfTdLfWfX46D0RcOeacf2A3ulXpCVt3Z57qFzjcDxUsWoaLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=iqps25TN4514W+DWPQZ/ByPPXm936aav0dSRUzapgbE=; b=aR8GqfFDE0DtT/xUAeH5lCYFXF7AQKs9HUGRjgnMRdNcsX6U4H0VxbFXFM0aehW8siUnyFSau7WONb9m0vq5POBEafX0NGNgsPvQBmwa74NGYegKJLH0B3O+bYwlbAtdlaAoPHe6gxS/CEOTjAZrU5Wii0W3spL6hWRVfkiBBWg=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2348.namprd04.prod.outlook.com (10.167.17.149) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.15; Wed, 31 Jul 2019 17:25:20 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::fca1:913a:52cf:8705]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::fca1:913a:52cf:8705%3]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019 17:25:20 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/2] silent fork retry with shm (broke emacs-X11)
Date: Wed, 31 Jul 2019 17:25:00 -0000
Message-ID: <72d7798e-de3c-4e21-33bf-074e06e3e11d@cornell.edu>
References: <20190730160754.GZ11632@calimero.vinschen.de> <20190731103531.559-1-michael.haubenwallner@ssi-schaefer.com> <20190731165913.GB11632@calimero.vinschen.de>
In-Reply-To: <20190731165913.GB11632@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEB5486A4F5C81498802B9BE62580718@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00061.txt.bz2

T24gNy8zMS8yMDE5IDEyOjU5IFBNLCBDb3Jpbm5hIFZpbnNjaGVuIHdyb3Rl
Og0KPiBPbiBKdWwgMzEgMTI6MzUsIE1pY2hhZWwgSGF1YmVud2FsbG5lciB3
cm90ZToNCj4+IEhpIENvcmlubmEsDQo+Pg0KPj4gT24gNy8zMC8xOSA2OjA3
IFBNLCBDb3Jpbm5hIFZpbnNjaGVuIHdyb3RlOg0KPj4+IEhpIE1pY2hhZWws
DQo+Pj4NCj4+PiBPbiBKdWwgMzAgMTc6MjIsIE1pY2hhZWwgSGF1YmVud2Fs
bG5lciB3cm90ZToNCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+IGZvbGxvd2luZyB1
cA0KPj4+PiBodHRwczovL2N5Z3dpbi5jb20vbWwvY3lnd2luLXBhdGNoZXMv
MjAxOS1xMi9tc2cwMDE1NS5odG1sDQo+Pj4+DQo+Pj4+IEl0IHR1cm5zIG91
dCB0aGF0IGZpeHVwX3NobXNfYWZ0ZXJfZm9yayBkb2VzIHJlcXVpcmUgdGhl
IGNoaWxkIHBpbmZvIHRvDQo+Pj4+IGJlICJyZW1lbWJlciJlZCwgd2hpbGUg
dGhlIGZvcmsgcmV0cnkgdG8gYmUgc2lsZW50IG9uIGZhaWx1cmUgcmVxdWly
ZXMNCj4+Pj4gdGhlIGNoaWxkIHRvIG5vdCBiZSAiYXR0YWNoImVkIHlldC4N
Cj4+Pj4NCj4+Pj4gQXMgY3VycmVudCBwaW5mby5yZW1lbWJlciBwZXJmb3Jt
cyBib3RoICJyZW1lbWJlciIgYW5kICJhdHRhY2giIGF0IG9uY2UsDQo+Pj4+
IHRoZSBmaXJzdCBwYXRjaCBkb2VzIGludHJvZHVjZSBwaW5mby5yZW1lbWJl
cl93aXRob3V0X2F0dGFjaCwgdG8gbm90DQo+Pj4+IGNoYW5nZSBjdXJyZW50
IGJlaGF2aW91ciBvZiBwaW5mby5yZW1lbWJlciBhbmQga2VlcCBwYXRjaGVz
IHNtYWxsLg0KPj4+Pg0KPj4+PiBIb3dldmVyLCBteSBmaXJzdCB0aG91Z2h0
IHdhcyB0byBjbGVhbiB1cCBwaW5mbyBBUEkgYSBsaXR0bGUgYW5kIGhhdmUN
Cj4+Pj4gcmVtZW1iZXIgbm90IGRvIGJvdGggInJlbWVtYmVyK2F0dGFjaCIg
YXQgb25jZSwgYnV0IGludHJvZHVjZSBzb21lIG5ldw0KPj4+PiByZW1lbWJl
cl9hbmRfYXR0YWNoIG1ldGhvZCBpbnN0ZWFkLiAgQnV0IHRoZW4sIHdoZW4g
J2Jvb2wgZGV0YWNoJyBpcw0KPj4+PiB0cnVlLCB0aGUgIl9hbmRfYXR0YWNo
IiBkb2VzIGZlZWwgd3JvbmcuDQo+Pj4NCj4+PiBJJ2QgcHJlZmVyIHRvIGRy
b3AgdGhlIHJlYXR0YWNoIGNhbGwgZnJvbSByZW1lbWJlciwgY2FsbGluZyBi
b3RoIG9mIHRoZW0NCj4+PiB3aGVyZSBhcHByb3ByaWF0ZS4NCj4+Pg0KPj4N
Cj4+IEZpbmUgd2l0aCBtZSwgZXZlbiBpZiB0aGF0IGxvb2tzIGEgbGl0dGxl
IG1vcmUgY29tcGxpY2F0ZWQgZm9yIHNwYXduLg0KPiANCj4gUHVzaGVkLCB3
aXRoIGp1c3QgYSBzbWFsbCBmb3JtYXR0aW5nIHR3ZWFrLg0KDQpJIGNhbiBj
b25maXJtIHRoYXQgdGhpcyBmaXhlcyB0aGUgcHJvYmxlbSBJIHJlcG9ydGVk
IGluIA0KaHR0cHM6Ly9jeWd3aW4uY29tL21sL2N5Z3dpbi1wYXRjaGVzLzIw
MTktcTIvbXNnMDAxNTUuaHRtbC4NCg0KS2VuDQo=

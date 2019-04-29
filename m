Return-Path: <cygwin-patches-return-9388-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51363 invoked by alias); 29 Apr 2019 18:42:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51351 invoked by uid 89); 29 Apr 2019 18:42:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*f:sk:6fbdf20, H*i:sk:6fbdf20, Looking, third
X-HELO: NAM05-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr710120.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) (40.107.71.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Apr 2019 18:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QoJ7nmrh8xHG4rS8Iy22YLjXSV98PfsiVzEcYqUOV7M=; b=MkpdZLXaFLrdJ5rAbrqsASkc5CBB2PGpT7KP1Q36dblVImlE4qo+RokFW+sAACaN2rtMFcGtAiRtuxu/an3AqHigfUsMTiHa40ssqkfzWm2HsNYaoanXhOTCik9kOsmdPCWi7QboFqaLwZLI9D5fDe3iwUz7U1TNydC9il6W9zw=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4891.namprd04.prod.outlook.com (20.176.109.76) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.14; Mon, 29 Apr 2019 18:42:52 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1835.010; Mon, 29 Apr 2019 18:42:52 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Date: Mon, 29 Apr 2019 18:42:00 -0000
Message-ID: <93c33c8d-e303-9a06-f5da-4e6d8b7f195c@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu> <6fbdf204-4be5-24b8-1df3-aa5d6589619b@cornell.edu>
In-Reply-To: <6fbdf204-4be5-24b8-1df3-aa5d6589619b@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:4714;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E128A5FD3216647A23C7F3262BA5C8D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00095.txt.bz2

T24gNC8yOS8yMDE5IDI6MjkgUE0sIEtlbiBCcm93biB3cm90ZToNCj4gT24g
My8yNS8yMDE5IDc6MDYgUE0sIEtlbiBCcm93biB3cm90ZToNCj4+IFRoZSBz
ZWNvbmQgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgZW5hYmxlcyBvcGVuaW5nIGEg
RklGTyB3aXRoIE9fUkRXUg0KPj4gYWNjZXNzLiAgVGhlIHVuZGVybHlpbmcg
V2luZG93cyBuYW1lZCBwaXBlIGlzIGNyZWF0ZWQgd2l0aCBkdXBsZXgNCj4+
IGFjY2VzcywgYW5kIGl0cyBoYW5kbGUgaXMgbWFkZSB0aGUgSS9PIGhhbmRs
ZSBvZiB0aGUgZmlyc3QgY2xpZW50Lg0KPj4NCj4+IEkgdGVzdGVkIHRoZSBw
YXRjaCBpbiB0d28gd2F5cy4NCj4+DQo+PiBGaXJzdCwNCj4gDQo+IFsuLi5d
DQo+IA0KPj4gVGhlIHNlY29uZCB0ZXN0IHdhcyB0aGUgZm9sbG93aW5nIHNl
cXVlbmNlIG9mIGNvbW1hbmRzIGluIGEgYmFzaA0KPj4gc2hlbGw6DQo+Pg0K
Pj4gJCBta2ZpZm8gZm9vDQo+Pg0KPj4gJCBleGVjIDc8PmZvbw0KPj4NCj4+
ICQgZWNobyBibGFoID4gZm9vDQo+Pg0KPj4gJCByZWFkIGJhciA8JjcNCj4+
DQo+PiAkIGVjaG8gJGJhcg0KPj4gYmxhaA0KPiANCj4gSSBqdXN0IHJlYWxp
emVkIHRoYXQgdGhpcyBkb2Vzbid0IHRlc3QgKndyaXRpbmcqIHRvIHRoZSBm
ZCBvZiBhIEZJRk8gb3BlbmVkIHdpdGgNCj4gT19SRFdSLiAgSWYgSSBjaGFu
Z2UgdGhlIHRoaXJkIGNvbW1hbmQgdG8gImVjaG8gYmxhaCA+JjciLCBpdCBk
b2VzIHRlc3QgdGhpcywNCj4gYW5kIHRoZSB3cml0ZSBmYWlscyB3aXRoIEVD
T01NLiAgSXQgdHVybnMgb3V0IHRoYXQgdGhlIGNhbGwgdG8gTnRXcml0ZUZp
bGUgaW4NCj4gZmhhbmRsZXJfZmlmbzo6cmF3X3dyaXRlIGZhaWxzIHdpdGgg
U1RBVFVTX1BJUEVfTElTVEVOSU5HLg0KPiANCj4gQ29yaW5uYSwgSSdsbCB0
cnkgdG8gZGVidWcgdGhpcywgYnV0IHNpbmNlIEkga25vdyB5b3UncmUgYWJv
dXQgdG8gYmUgQUZLIGZvciBhDQo+IG1vbnRoLCBJIHRob3VnaHQgSSdkIGNo
ZWNrIHRvIHNlZSBpZiB5b3UgaGF2ZSBhbnkgaWRlYSB3aHkgdGhpcyB3b3Vs
ZCBoYXBwZW4uDQoNCkFjdHVhbGx5LCB0aGUgYW5zd2VyIG1pZ2h0IGJlIG9i
dmlvdXMuICBMb29raW5nIGF0IE1TRE4sIGl0IG5vdyBzZWVtcyBjbGVhciB0
byANCm1lIHRoYXQgeW91IGNhbid0IGRvIEkvTyBvbiB0aGUgc2VydmVyIHNp
ZGUgb2YgYSBwaXBlIHVudGlsIHRoZSBwaXBlIGNvbm5lY3RzIHRvIA0KYSBj
bGllbnQuICBTbyBJJ2xsIGhhdmUgdG8gcmV0aGluayBob3cgdG8gZGVhbCB3
aXRoIHRoZSBPX1JEV1IgY2FzZS4NCg0KS2VuDQo=

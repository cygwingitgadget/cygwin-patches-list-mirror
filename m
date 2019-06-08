Return-Path: <cygwin-patches-return-9448-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67911 invoked by alias); 8 Jun 2019 12:20:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67306 invoked by uid 89); 8 Jun 2019 12:20:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.8 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,UNSUBSCRIBE_BODY autolearn=no version=3.3.1 spammy=Ken, sk:michael, hour, H*f:sk:d3a6fca
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740131.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 08 Jun 2019 12:20:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=enpD6k0nsrlMts1iT/SdowsozholGedjMZz034hHVE4=; b=LL3RAz1gKvgzgD07aW5T8+CgJfobTI2LNil5ciPDN3Lbah847p0fwRQzG978vIoLFYA2J0xXfqMafBMhB22ZI4uttO0Dicudeyfmbf9xg5t3DVXygscu1lB3lKVrrwZLCWkjyeTL7XvVxzP173UjUCJZuYegNYf7goQImRqIt10=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4106.namprd04.prod.outlook.com (20.176.87.159) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Sat, 8 Jun 2019 12:20:42 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1965.011; Sat, 8 Jun 2019 12:20:42 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
Date: Sat, 08 Jun 2019 12:20:00 -0000
Message-ID: <798cfd05-a12d-4f42-0a8a-f74750e78547@cornell.edu>
References: <20190526151019.2187-1-kbrown@cornell.edu> <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu> <20190603163519.GJ3437@calimero.vinschen.de> <dac74739-7b66-56cb-ca8a-acbca7877eba@cornell.edu> <874l51p7rt.fsf@Rainer.invalid> <d3a6fcad-69c3-e6e6-07fa-3311ec833c69@cornell.edu> <b5a2e878-0282-d94e-92de-c4605dea4000@cornell.edu>
In-Reply-To: <b5a2e878-0282-d94e-92de-c4605dea4000@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:10000;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <411BB983FEC43549B472CF1799BBCD75@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00155.txt.bz2

T24gNi83LzIwMTkgNTo0MyBQTSwgS2VuIEJyb3duIHdyb3RlOg0KPiBPbiA2
LzcvMjAxOSAzOjEzIFBNLCBLZW4gQnJvd24gd3JvdGU6DQo+PiBPbiA2Lzcv
MjAxOSAyOjMxIFBNLCBBY2hpbSBHcmF0eiB3cm90ZToNCj4+PiBLZW4gQnJv
d24gd3JpdGVzOg0KPj4+PiBJIHRoaW5rIEkndmUgZm91bmQgdGhlIHByb2Js
ZW0uICBJIHdhcyBtaXNoYW5kbGluZyBzaWduYWxzIHRoYXQgYXJyaXZlZCBk
dXJpbmcgYQ0KPj4+PiByZWFkLiAgQnV0IGFmdGVyIEkgZml4IHRoYXQsIHRo
ZXJlJ3Mgc3RpbGwgb25lIG5hZ2dpbmcgaXNzdWUgaW52b2x2aW5nIHRpbWVy
ZmQNCj4+Pj4gY29kZS4gIEknbGwgd3JpdGUgdG8gdGhlIG1haW4gbGlzdCB3
aXRoIGRldGFpbHMuICBJICp0aGluayogaXQncyBhIHRpbWVyZmQgYnVnLA0K
Pj4+PiBidXQgaXQncyBwdXp6bGluZyB0aGF0IEkgb25seSBzZWUgaXQgd2hl
biB0ZXN0aW5nIG15IG5ldyBwaXBlIGltcGxlbWVudGF0aW9uLg0KPj4+DQo+
Pj4gQW55dGhpbmcgdHJpZ2dlcmluZyBhIHJhY2Ugb3IgZGVhZGxvY2sgd2ls
bCBkZXBlbmQgb24gc28gbWFueSBvdGhlcg0KPj4+IHRoaW5ncyB0aGF0IGl0
IHJlYWxseSBpcyBubyBzdXJwcmlzZSB0byBzZWUgc2VlbWluZ2x5IHVucmVs
YXRlZCBjaGFuZ2VzDQo+Pj4gbWFraW5nIHRoZSBidWcgYXBwZWFyIG9yIGRp
c2FwcGVhci4gIFRoZXJlIGFyZSBjZXJ0YWlubHkgcmFjZXMgbGVmdCBpbg0K
Pj4+IEN5Z3dpbiwgSSBzZWUgdGhlbSBmcm9tIHRpbWUgdG8gdGltZSBpbiB2
YXJpb3VzIFBlcmwgbW9kdWxlcywganVzdCBuZXZlcg0KPj4+IHJlcHJvZHVj
aWJsZSBlbm91Z2ggdG8gZ2l2ZSBhbnlvbmUgYW4gaWRlYSBvZiB3aGVyZSB0
byBsb29rLg0KPj4NCj4+IFRoYXQgbWFrZXMgc2Vuc2UuDQo+Pg0KPj4gSW4g
dGhlIG1lYW50aW1lLCBJJ3ZlIGFscmVhZHkgZGlzY292ZXJlZCBhbm90aGVy
IHByb2JsZW0sIHdpdGhpbiBhbiBob3VyIG9mDQo+PiBwb3N0aW5nIG15IGNs
YWltIHRoYXQgZXZlcnl0aGluZyB3YXMgd29ya2luZyBmaW5lOiBJZiBJIHN0
YXJ0IGVtYWNzLVgxMSB3aXRoDQo+PiBjeWdzZXJ2ZXIgcnVubmluZywgSSBj
YW4ndCBmb3JrIGFueSBzdWJwcm9jZXNzZXMgd2l0aGluIGVtYWNzLiAgSSBn
ZXQNCj4+DQo+PiAwIFttYWluXSBlbWFjcyAyNjg5IGRvZm9yazogY2hpbGQg
MjY5MyAtIGRpZWQgd2FpdGluZyBmb3IgZGxsIGxvYWRpbmcsIGVycm5vIDEx
DQo+Pg0KPj4gQmFjayB0byB0aGUgZHJhd2luZyBib2FyZC4uLi4gIEkndmUg
bmV2ZXIgbG9va2VkIGF0IHRoZSBjeWdzZXJ2ZXIgY29kZSwgYnV0DQo+PiBt
YXliZSBpdCB3aWxsIHR1cm4gb3V0IHRvIGJlIHNvbWV0aGluZyBlYXN5Lg0K
PiANCj4gR29vZCBuZXdzIChmb3IgbWUpOiBUaGlzIGlzbid0IHJlbGF0ZWQg
dG8gbXkgcGlwZSBjb2RlLiAgVGhlIHNhbWUgcHJvYmxlbSBvY2N1cnMNCj4g
aWYgSSBidWlsZCB0aGUgbWFzdGVyIGJyYW5jaC4gIEknbGwgYmlzZWN0IHdo
ZW4gSSBnZXQgYSBjaGFuY2UgKHByb2JhYmx5DQo+IHRvbW9ycm93KS4gIElu
IHRoZSBtZWFudGltZSwgYWxsIEkgY2FuIHNheSBpcyB0aGF0IHN0cmFjZSBz
aG93cyBhDQo+IFNUQVRVU19BQ0NFU1NfVklPTEFUSU9OIGF0IHNobS5jYzox
MjUuDQoNCkEgYmlzZWN0aW9uIHNob3dzIHRoYXQgdGhlIHByb2JsZW0gc3Rh
cnRzIHdpdGggdGhlIGZvbGxvd2luZyBjb21taXQ6DQoNCmNvbW1pdCBmMDNl
YThlMWM1N2JkNWNlYTgzZjZjZDQ3ZmEwMjg3MGJkZmViMWM1DQpBdXRob3I6
IE1pY2hhZWwgSGF1YmVud2FsbG5lciA8bWljaGFlbC5oYXViZW53YWxsbmVy
QHNzaS1zY2hhZWZlci5jb20+DQpEYXRlOiAgIFRodSBNYXkgMiAxMjoxMjo0
NCAyMDE5ICswMjAwDQoNCiAgICAgQ3lnd2luOiBmb3JrOiBSZW1lbWJlciBj
aGlsZCBub3QgYmVmb3JlIHN1Y2Nlc3MuDQoNCiAgICAgRG8gbm90IHJlbWVt
YmVyIHRoZSBjaGlsZCBiZWZvcmUgaXQgd2FzIHN1Y2Nlc3NmdWxseSBpbml0
aWFsaXplZCwgb3Igd2UNCiAgICAgd291bGQgbmVlZCBtb3JlIHNvcGhpc3Rp
Y2F0ZWQgY2xlYW51cCBvbiBjaGlsZCBpbml0aWFsaXphdGlvbiBmYWlsdXJl
LA0KICAgICBsaWtlIGNsZWFuaW5nIHVwIHRoZSBwcm9jZXNzIHRhYmxlIGFu
ZCBzdXBwcmVzc2luZyBTSUdDSElMRCBkZWxpdmVyeQ0KICAgICB3aXRoIG11
bHRpcGxlIHRocmVhZHMgKCJ3YWl0cHJvYyIpIGludm9sdmVkLiAgQ29tcGFy
ZWQgdG8gdGhhdCwgdGhlDQogICAgIHBvdGVudGlhbCBzbG93ZG93biBkdWUg
dG8gYW4gZXh0cmEgeWllbGQgKCkgY2FsbCBzaG91bGQgYmUgbmVnbGlnaWJs
ZS4NCg0KSSBoYXZlbid0IHRyaWVkIHRvIG1ha2UgYW4gU1RDLCBidXQgaGVy
ZSdzIHdoYXQgSSBkbyB0byByZXByb2R1Y2UgdGhlIHByb2JsZW06DQoNCjEu
IFN0YXJ0IGN5Z3NlcnZlci4NCg0KMi4gU3RhcnQgdGhlIFggc2VydmVyIChl
LmcuLCBieSB1c2luZyB0aGUgU3RhcnQgTWVudSBzaG9ydGN1dCBjcmVhdGVk
IGJ5IHRoZSANCnhpbml0IHBvc3RpbnN0YWxsIHNjcmlwdCkuDQoNCjMuIFN0
YXJ0IGFuIHh0ZXJtLg0KDQo0LiBSdW4gJ2VtYWNzLVgxMSAtUScgaW4gdGhl
IHh0ZXJtIHdpbmRvdy4NCg0KNS4gRG8gYW55dGhpbmcgdGhhdCBjYXVzZXMg
ZW1hY3MgdG8gdHJ5IHRvIGZvcmsgKGUuZy4sICdDLXggZCcgdG8gbGlzdCB0
aGUgDQpjdXJyZW50IGRpcmVjdG9yeSkuDQoNClRoZXJlIHdpbGwgYmUgYSBs
b25nIGRlbGF5IHdoaWxlIGVtYWNzIHRyaWVzIHRvIGZvcmssIGZvbGxvd2Vk
IGV2ZW50dWFsbHkgYnkgYW4gDQplcnJvciBtZXNzYWdlLg0KDQpzdHJhY2Ug
YW5kIGFkZHIybGluZSBzaG93IHRoYXQgdGhlcmUncyBhIGNyYXNoIGF0IHNo
bS5jYzoxMjUuDQoNCkkgaG9wZSB0aGlzIGlzIGVub3VnaCBpbmZvcm1hdGlv
biBmb3Igc29tZW9uZSB0byB0cmFjayBkb3duIHRoZSBwcm9ibGVtLiAgSWYg
DQpub3QsIEkgY291bGQgcHJvYmFibHkgbWFrZSBhbiBTVEMgdGhhdCBkb2Vz
bid0IGludm9sdmUgZW1hY3MuDQoNCktlbg0K

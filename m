Return-Path: <cygwin-patches-return-9451-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125010 invoked by alias); 11 Jun 2019 22:37:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125001 invoked by uid 89); 11 Jun 2019 22:37:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.4 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,UNSUBSCRIBE_BODY autolearn=no version=3.3.1 spammy=UD:msg00110.html, H*i:sk:70112bc, msg00110.html, HX-Languages-Length:2889
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740095.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.95) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 11 Jun 2019 22:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=MJuv69kdNbBypFIjIZZ7Re27fsEq6rMro80FZ14P9FI=; b=aXIbKpx/GoalUDj2Svhns+QRQIl1uvDeooNzijBou4f2i8FDPXJPnzjKrKGCuoAkTmO1tYWwwcoR63TuDScp4E10dy5fTwoNkPlDoqRkNGvi2h0zeM9VGM9qByvzOnQHU4SwjzkcQwToq0XxPmolcJr+7bIyknrn2hgeDzEpdi4=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5897.namprd04.prod.outlook.com (20.179.48.96) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15; Tue, 11 Jun 2019 22:37:31 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019 22:37:31 +0000
From: Ken Brown <kbrown@cornell.edu>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
Date: Tue, 11 Jun 2019 22:37:00 -0000
Message-ID: <04085a74-c0ec-6a4e-ff8e-f6fef2698105@cornell.edu>
References: <20190526151019.2187-1-kbrown@cornell.edu> <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu> <20190603163519.GJ3437@calimero.vinschen.de> <dac74739-7b66-56cb-ca8a-acbca7877eba@cornell.edu> <874l51p7rt.fsf@Rainer.invalid> <d3a6fcad-69c3-e6e6-07fa-3311ec833c69@cornell.edu> <b5a2e878-0282-d94e-92de-c4605dea4000@cornell.edu> <798cfd05-a12d-4f42-0a8a-f74750e78547@cornell.edu> <20190611084811.GB3520@calimero.vinschen.de> <70112bc2-54e0-7925-1bea-ccb3476dbcb9@ssi-schaefer.com>
In-Reply-To: <70112bc2-54e0-7925-1bea-ccb3476dbcb9@ssi-schaefer.com>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:10000;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8CE461BB63BF249AAA68029DAF24E8C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00158.txt.bz2

T24gNi8xMS8yMDE5IDEyOjQyIFBNLCBNaWNoYWVsIEhhdWJlbndhbGxuZXIg
d3JvdGU6DQo+IA0KPiANCj4gT24gNi8xMS8xOSAxMDo0OCBBTSwgQ29yaW5u
YSBWaW5zY2hlbiB3cm90ZToNCj4+IEhpIEtlbiwNCj4+DQo+PiBPbiBKdW4g
IDggMTI6MjAsIEtlbiBCcm93biB3cm90ZToNCj4+PiBPbiA2LzcvMjAxOSA1
OjQzIFBNLCBLZW4gQnJvd24gd3JvdGU6DQo+Pj4+IE9uIDYvNy8yMDE5IDM6
MTMgUE0sIEtlbiBCcm93biB3cm90ZToNCj4+Pj4+IE9uIDYvNy8yMDE5IDI6
MzEgUE0sIEFjaGltIEdyYXR6IHdyb3RlOg0KPj4+Pj4+IEtlbiBCcm93biB3
cml0ZXM6DQo+Pj4+Pj4+IEkgdGhpbmsgSSd2ZSBmb3VuZCB0aGUgcHJvYmxl
bS4gIEkgd2FzIG1pc2hhbmRsaW5nIHNpZ25hbHMgdGhhdCBhcnJpdmVkIGR1
cmluZyBhDQo+Pj4+Pj4+IHJlYWQuICBCdXQgYWZ0ZXIgSSBmaXggdGhhdCwg
dGhlcmUncyBzdGlsbCBvbmUgbmFnZ2luZyBpc3N1ZSBpbnZvbHZpbmcgdGlt
ZXJmZA0KPj4+Pj4+PiBjb2RlLiAgSSdsbCB3cml0ZSB0byB0aGUgbWFpbiBs
aXN0IHdpdGggZGV0YWlscy4gIEkgKnRoaW5rKiBpdCdzIGEgdGltZXJmZCBi
dWcsDQo+Pj4+Pj4+IGJ1dCBpdCdzIHB1enpsaW5nIHRoYXQgSSBvbmx5IHNl
ZSBpdCB3aGVuIHRlc3RpbmcgbXkgbmV3IHBpcGUgaW1wbGVtZW50YXRpb24u
DQo+Pj4+Pj4NCj4+Pj4+PiBBbnl0aGluZyB0cmlnZ2VyaW5nIGEgcmFjZSBv
ciBkZWFkbG9jayB3aWxsIGRlcGVuZCBvbiBzbyBtYW55IG90aGVyDQo+Pj4+
Pj4gdGhpbmdzIHRoYXQgaXQgcmVhbGx5IGlzIG5vIHN1cnByaXNlIHRvIHNl
ZSBzZWVtaW5nbHkgdW5yZWxhdGVkIGNoYW5nZXMNCj4+Pj4+PiBtYWtpbmcg
dGhlIGJ1ZyBhcHBlYXIgb3IgZGlzYXBwZWFyLiAgVGhlcmUgYXJlIGNlcnRh
aW5seSByYWNlcyBsZWZ0IGluDQo+Pj4+Pj4gQ3lnd2luLCBJIHNlZSB0aGVt
IGZyb20gdGltZSB0byB0aW1lIGluIHZhcmlvdXMgUGVybCBtb2R1bGVzLCBq
dXN0IG5ldmVyDQo+Pj4+Pj4gcmVwcm9kdWNpYmxlIGVub3VnaCB0byBnaXZl
IGFueW9uZSBhbiBpZGVhIG9mIHdoZXJlIHRvIGxvb2suDQo+Pj4+Pg0KPj4+
Pj4gVGhhdCBtYWtlcyBzZW5zZS4NCj4+Pj4+DQo+Pj4+PiBJbiB0aGUgbWVh
bnRpbWUsIEkndmUgYWxyZWFkeSBkaXNjb3ZlcmVkIGFub3RoZXIgcHJvYmxl
bSwgd2l0aGluIGFuIGhvdXIgb2YNCj4+Pj4+IHBvc3RpbmcgbXkgY2xhaW0g
dGhhdCBldmVyeXRoaW5nIHdhcyB3b3JraW5nIGZpbmU6IElmIEkgc3RhcnQg
ZW1hY3MtWDExIHdpdGgNCj4+Pj4+IGN5Z3NlcnZlciBydW5uaW5nLCBJIGNh
bid0IGZvcmsgYW55IHN1YnByb2Nlc3NlcyB3aXRoaW4gZW1hY3MuICBJIGdl
dA0KPj4+Pj4NCj4+Pj4+IDAgW21haW5dIGVtYWNzIDI2ODkgZG9mb3JrOiBj
aGlsZCAyNjkzIC0gZGllZCB3YWl0aW5nIGZvciBkbGwgbG9hZGluZywgZXJy
bm8gMTENCj4+Pj4+DQo+Pj4+PiBCYWNrIHRvIHRoZSBkcmF3aW5nIGJvYXJk
Li4uLiAgSSd2ZSBuZXZlciBsb29rZWQgYXQgdGhlIGN5Z3NlcnZlciBjb2Rl
LCBidXQNCj4+Pj4+IG1heWJlIGl0IHdpbGwgdHVybiBvdXQgdG8gYmUgc29t
ZXRoaW5nIGVhc3kuDQo+Pj4+DQo+Pj4+IEdvb2QgbmV3cyAoZm9yIG1lKTog
VGhpcyBpc24ndCByZWxhdGVkIHRvIG15IHBpcGUgY29kZS4gIFRoZSBzYW1l
IHByb2JsZW0gb2NjdXJzDQo+Pj4+IGlmIEkgYnVpbGQgdGhlIG1hc3RlciBi
cmFuY2guICBJJ2xsIGJpc2VjdCB3aGVuIEkgZ2V0IGEgY2hhbmNlIChwcm9i
YWJseQ0KPj4+PiB0b21vcnJvdykuICBJbiB0aGUgbWVhbnRpbWUsIGFsbCBJ
IGNhbiBzYXkgaXMgdGhhdCBzdHJhY2Ugc2hvd3MgYQ0KPj4+PiBTVEFUVVNf
QUNDRVNTX1ZJT0xBVElPTiBhdCBzaG0uY2M6MTI1Lg0KPj4+DQo+Pj4gQSBi
aXNlY3Rpb24gc2hvd3MgdGhhdCB0aGUgcHJvYmxlbSBzdGFydHMgd2l0aCB0
aGUgZm9sbG93aW5nIGNvbW1pdDoNCj4+DQo+PiBUaGFua3MgZm9yIGJpc2Vj
dGluZyENCj4+DQo+Pj4gY29tbWl0IGYwM2VhOGUxYzU3YmQ1Y2VhODNmNmNk
NDdmYTAyODcwYmRmZWIxYzUNCj4+PiBBdXRob3I6IE1pY2hhZWwgSGF1YmVu
d2FsbG5lciA8bWljaGFlbC5oYXViZW53YWxsbmVyQHNzaS1zY2hhZWZlci5j
b20+DQo+Pj4gRGF0ZTogICBUaHUgTWF5IDIgMTI6MTI6NDQgMjAxOSArMDIw
MA0KPj4+DQo+Pj4gICAgICAgQ3lnd2luOiBmb3JrOiBSZW1lbWJlciBjaGls
ZCBub3QgYmVmb3JlIHN1Y2Nlc3MuDQo+Pj4NCj4+PiAgICAgICBEbyBub3Qg
cmVtZW1iZXIgdGhlIGNoaWxkIGJlZm9yZSBpdCB3YXMgc3VjY2Vzc2Z1bGx5
IGluaXRpYWxpemVkLCBvciB3ZQ0KPj4+ICAgICAgIHdvdWxkIG5lZWQgbW9y
ZSBzb3BoaXN0aWNhdGVkIGNsZWFudXAgb24gY2hpbGQgaW5pdGlhbGl6YXRp
b24gZmFpbHVyZSwNCj4+PiAgICAgICBsaWtlIGNsZWFuaW5nIHVwIHRoZSBw
cm9jZXNzIHRhYmxlIGFuZCBzdXBwcmVzc2luZyBTSUdDSElMRCBkZWxpdmVy
eQ0KPj4+ICAgICAgIHdpdGggbXVsdGlwbGUgdGhyZWFkcyAoIndhaXRwcm9j
IikgaW52b2x2ZWQuICBDb21wYXJlZCB0byB0aGF0LCB0aGUNCj4+PiAgICAg
ICBwb3RlbnRpYWwgc2xvd2Rvd24gZHVlIHRvIGFuIGV4dHJhIHlpZWxkICgp
IGNhbGwgc2hvdWxkIGJlIG5lZ2xpZ2libGUuDQo+Pg0KPj4gUGxlYXNlIHJl
dmVydCB0aGUgcGF0Y2ggZm9yIHRoZSB0aW1lIGJlaW5nLiAgTWljaGFlbCwg
dGhpcyBuZWVkcyBzb21lDQo+PiBtb3JlIHdvcmssIGFwcGFyZW50bHkuDQo+
IA0KPiBCZWNhdXNlIG9mIGh0dHBzOi8vY3lnd2luLmNvbS9tbC9jeWd3aW4v
MjAxOS0wNi9tc2cwMDExMC5odG1sOg0KPiBJcyB0aGVyZSBzdGlsbCBzb21l
IHByb2JsZW0gcmVsYXRlZCB0byB0aGF0IGNvbW1pdCBJIG5lZWQgdG8gZmln
dXJlIG91dD8NCg0KWWVzLiAgVGhhdCB3YXMgYW4gdW5yZWxhdGVkIGlzc3Vl
IEFGQUlLLg0KDQpLZW4NCg==

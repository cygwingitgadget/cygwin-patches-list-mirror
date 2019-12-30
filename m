Return-Path: <cygwin-patches-return-9891-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125450 invoked by alias); 30 Dec 2019 21:47:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125440 invoked by uid 89); 30 Dec 2019 21:47:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*i:sk:f964457, H*f:sk:f964457, H*MI:sk:f964457
X-HELO: NAM12-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam12on2130.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) (40.107.237.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Dec 2019 21:47:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=EBVHMpx0MJRpgG3x2zh4sXS24uXiPAl2fTUJFzctIdBOFkIboGluSY2bbOYVZ4rwhc+0fCPLvGhVcK9ZYikCjicTBCSDxd3Kn0csU/YZyXpQXhiglYWcmMxva2It3ScHNY2cAnLcHtRgVlEgPLAkEETybSRfGIFTFrBBdB1XffkfZm+krA6gps5X84vQmGIv8GNQE+wjTbzwgRACfrNlUTieF5Hlz08gyrQHpzZz2h1gQZLptLEmUmRKnxXCgEJHYs1Pxs/LX1sGdnoHkWcSVWawwY5OAb3uREvJQmFpyNWApgyoq0f3NmWqIYu3pZcnqJgGoWy6CkhHwc1Uus0QnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Af4XCYJLy0VsCmjfuDKMvIhQJJJii2TTj1vLw5uiQLQ=; b=FdyZ0NX3Fga8pUekHDIyb3tdAEwFRQRbG5JZXxMnEX/KbQ0wHnYhQRWERdPuwRlBNgk5HYTxcOKoSUkegtg/VLY4wT8QxQtB+tveZUGpaz2ZbN+eoxWwGL2VPWv5BE8gDjZIYicesyN8ADiRlTrfgeANZJfLWACIKxD0REiIRp2orrYFpqnZQaD8OQ/GL1RtlupnSErT2iSPu9NdGLl/K5cgEqFOp7TOV2767plhunjHb405pVYPeUiYHLZ2JFIEsUMQB9i/uoUORPPQJ+IRKWwIq9i9u+mUKTJ+gjo+/EvsJQ07LxZ8ptOuJUtFy4+9ERiFZc1SvsH4HBcbMAsEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Af4XCYJLy0VsCmjfuDKMvIhQJJJii2TTj1vLw5uiQLQ=; b=AIdhcU/6EROTClGwZ7UwXq24atqtd3fNhm5EfGcafv+WoyGsqNPxKbl/PXC4hXGFcKPqwRx7KY0ueE4ubeI5d5m8hev+hoSl5/IZsee+cNgkxtd3TQKLNy1nfmZQtywpcZqqRzJ+e3AORBL0quqGIhLtO10ob42SKTHP5cqfisE=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB3803.namprd04.prod.outlook.com (20.176.87.155) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Mon, 30 Dec 2019 21:47:41 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019 21:47:41 +0000
Received: from [192.168.0.19] (68.175.129.7) by CH2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:610:57::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Mon, 30 Dec 2019 21:47:40 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Mon, 30 Dec 2019 21:47:00 -0000
Message-ID: <9d5d81ad-9692-1e4d-b693-ef5a287c1377@cornell.edu>
References: <20191229175637.1050-1-kbrown@cornell.edu> <d88c5dee-9457-3c39-960c-ea07842cd0c5@SystematicSw.ab.ca> <aafbc75d-11db-0faf-6e13-72681c5784a3@cornell.edu> <f964457b-9d33-a252-3cc9-e035a4fe1c1a@SystematicSw.ab.ca>
In-Reply-To: <f964457b-9d33-a252-3cc9-e035a4fe1c1a@SystematicSw.ab.ca>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:10000;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <53983894F678BE42990AC0C3D600A824@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBp6YVzQnJgirPEoQKTdgj5h9sH+bzjRpYe4TImjv50xdKYUjp4g/LQmUCLoGC8i0BaaimlNMK3jaPxSryNw/A==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00162.txt.bz2

T24gMTIvMzAvMjAxOSAzOjU1IFBNLCBCcmlhbiBJbmdsaXMgd3JvdGU6DQo+
IE9uIDIwMTktMTItMzAgMTI6NTMsIEtlbiBCcm93biB3cm90ZToNCj4+IE9u
IDEyLzMwLzIwMTkgMjoxOCBQTSwgQnJpYW4gSW5nbGlzIHdyb3RlOg0KPj4+
IE9uIDIwMTktMTItMjkgMTA6NTYsIEtlbiBCcm93biB3cm90ZToNCj4+Pj4g
Q3VycmVudGx5LCBvcGVuaW5nIGEgc3ltbGluayB3aXRoIE9fTk9GT0xMT1cg
ZmFpbHMgd2l0aCBFTE9PUC4NCj4+Pj4gRm9sbG93aW5nIExpbnV4LCB0aGUg
Zmlyc3QgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgYWxsb3dzIHRoZSBjYWxsIHRv
DQo+Pj4+IHN1Y2NlZWQgaWYgT19QQVRIIGlzIGFsc28gc3BlY2lmaWVkLg0K
Pj4+Pg0KPj4+PiBBY2NvcmRpbmcgdG8gdGhlIExpbnV4IG1hbiBwYWdlIGZv
ciAnb3BlbicsIHRoZSBmaWxlIGRlc2NyaXB0b3INCj4+Pj4gcmV0dXJuZWQg
YnkgdGhlIGNhbGwgc2hvdWxkIGJlIHVzYWJsZSBhcyB0aGUgZGlyZmQgYXJn
dW1lbnQgaW4gY2FsbHMNCj4+Pj4gdG8gZnN0YXRhdCBhbmQgcmVhZGxpbmth
dCB3aXRoIGFuIGVtcHR5IHBhdGhuYW1lLCB0byBoYXZlDQo+Pj4+IHRoZSBj
YWxscyBvcGVyYXRlIG9uIHRoZSBzeW1ib2xpYyBsaW5rLiAgVGhlIHNlY29u
ZCBhbmQgdGhpcmQgcGF0Y2hlcw0KPj4+PiBhY2hpZXZlIHRoaXMuICBGb3Ig
ZnN0YXRhdCwgd2UgZG8gdGhpcyBieSBhZGRpbmcgc3VwcG9ydA0KPj4+PiBm
b3IgdGhlIEFUX0VNUFRZX1BBVEggZmxhZy4NCj4+Pj4NCj4+Pj4gTm90ZTog
VGhlIG1hbiBwYWdlIG1lbnRpb25zIGZjaG93bmF0IGFuZCBsaW5rYXQgYWxz
by4gIGxpbmthdCBhbHJlYWR5DQo+Pj4+IHN1cHBvcnRzIHRoZSBBVF9FTVBU
WV9QQVRIIGZsYWcsIHNvIG5vdGhpbmcgbmVlZHMgdG8gYmUgZG9uZS4gIEJ1
dCBJDQo+Pj4+IGRvbid0IHVuZGVyc3RhbmQgaG93IHRoaXMgY291bGQgd29y
ayBmb3IgZmNob3duYXQsIGJlY2F1c2UgZmNob3duDQo+Pj4+IGZhaWxzIHdp
dGggRUJBREYgaWYgaXRzIGZkIGFyZ3VtZW50IHdhcyBvcGVuZWQgd2l0aCBP
X1BBVEguICBTbyBJDQo+Pj4+IGhhdmVuJ3QgdG91Y2hlZCBmY2hvd25hdC4N
Cj4+Pj4NCj4+Pj4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4+Pg0KPj4+
IFdTTCAkIG1hbiAyIGNob3duDQo+Pj4gLi4uDQo+Pj4gIkFUX0VNUFRZX1BB
VEggKHNpbmNlIExpbnV4IDIuNi4zOSkNCj4+PiBJZiBwYXRobmFtZSBpcyBh
biBlbXB0eSBzdHJpbmcsIG9wZXJhdGUgb24gdGhlIGZpbGUgcmVmZXJyZWQg
dG8NCj4+PiBieSBkaXJmZCAod2hpY2ggbWF5IGhhdmUgYmVlbiBvYnRhaW5l
ZCB1c2luZyB0aGUgb3BlbigyKSBPX1BBVEgNCj4+PiBmbGFnKS4gSW4gIHRo
aXMgY2FzZSwgZGlyZmQgY2FuIHJlZmVyIHRvIGFueSB0eXBlIG9mIGZpbGUs
IG5vdA0KPj4+IGp1c3QgYSBkaXJlY3RvcnkuIElmIGRpcmZkIGlzIEFUX0ZE
Q1dELCB0aGUgIGNhbGwgb3BlcmF0ZXMgb24NCj4+PiB0aGUgY3VycmVudCB3
b3JraW5nIGRpcmVjdG9yeS4gVGhpcyBmbGFnIGlzIExpbnV4LXNwZWNpZmlj
OyBkZeKAkA0KPj4+IGZpbmUgX0dOVV9TT1VSQ0UgdG8gb2J0YWluIGl0cyBk
ZWZpbml0aW9uLiINCj4+Pg0KPj4+IHNheXMgY2hvd24gdGhlIGRpcmZkLCBy
ZWdhcmRsZXNzIG9mIHdoYXQgaXQgaXMsDQo+Pj4gZXhjZXB0IGlmIEFUX0ZE
Q1dELCBjaG93biB0aGUgQ1dELg0KPj4+DQo+Pj4gV1NMICQgbWFuIDIgb3Bl
bg0KPj4+ICJPX1BBVEggKHNpbmNlIExpbnV4IDIuNi4zOSkNCj4+PiBPYnRh
aW4gYSBmaWxlIGRlc2NyaXB0b3IgdGhhdCBjYW4gYmUgdXNlZCBmb3IgdHdv
IHB1cnBvc2VzOiB0bw0KPj4+IGluZGljYXRlIGEgbG9jYXRpb24gaW4gdGhl
IGZpbGVzeXN0ZW0gdHJlZSBhbmQgdG8gcGVyZm9ybQ0KPj4+IG9wZXJhdGlv
bnMgdGhhdCBhY3QgcHVyZWx5IGF0IHRoZSBmaWxlIGRlc2NyaXB0b3IgbGV2
ZWwuICBUaGUNCj4+PiBmaWxlIGl0c2VsZiBpcyBub3Qgb3BlbmVkLCBhbmQg
b3RoZXIgZmlsZSBvcGVyYXRpb25zIChlLmcuLA0KPj4+IHJlYWQoMiksIHdy
aXRlKDIpLCBmY2htb2QoMiksIGZjaG93bigyKSwgZmdldHhhdHRyKDIpLA0K
Pj4+IGlvY3RsKDIpLCBtbWFwKDIpKSBmYWlsIHdpdGggdGhlIGVycm9yIEVC
QURGLiINCj4+Pg0KPj4+IE9fUEFUSCBkb2VzIG5vdCBvcGVuIHRoZSBmaWxl
LCBzbyBmY2hvd24gcmV0dXJucyBFQkFERiwNCj4+PiBhcyBpdCByZXF1aXJl
cyBhbiBmZCBvZiBhbiBvcGVuIGZpbGUuDQo+Pg0KPj4gSSB0aGluayB5b3Un
dmUganVzdCBjb25maXJtZWQgd2hhdCBJIGFscmVhZHkgc2FpZDogSWYgZmNo
b3duYXQgaXMgY2FsbGVkIHdpdGgNCj4+IEFUX0VNUFRZX1BBVEgsIHdpdGgg
YW4gZW1wdHkgcGF0aG5hbWUsIGFuZCB3aXRoIGRpcmZkIHJlZmVycmluZyB0
byBhIGZpbGUgdGhhdA0KPj4gd2FzIG9wZW5lZCB3aXRoIE9fUEFUSCwgdGhl
biBmY2hvd25hdCB3aWxsIGZhaWwgd2l0aCBFQkFERi4NCj4+DQo+PiBTbyBm
b3IgdGhlIHB1cnBvc2VzIG9mIHRoaXMgcGF0Y2ggc2VyaWVzLCBJIGRvbid0
IHNlZSB0aGUgcG9pbnQgb2YgYWRkaW5nDQo+PiBzdXBwb3J0IGZvciBBVF9F
TVBUWV9QQVRIIGluIGZjaG93bmF0Lg0KPj4NCj4+IEFtIEkgbWlzc2luZyBz
b21ldGhpbmc/DQo+IA0KPiBUaGF0IGlzIHRoZSB1c2VyJ3MgcHJvYmxlbTog
aXQgaXMgdGhlaXIgcmVzcG9uc2liaWxpdHkgdG8gcGFzcyBhbiBmZCBvcGVu
IGZvcg0KPiByZWFkaW5nIG9yIHNlYXJjaGluZywgbm90IG9uZSBvcGVuZWQg
d2l0aCBPX1BBVEggKG9uIExpbnV4IG9yIEN5Z3dpbiksIG9yDQo+IEFUX0ZE
Q1dEOyBpdCBpcyBDeWd3aW4ncyByZXNwb25zaWJpbGl0eSB0byBlbnN1cmUg
dGhhdCB2YWxpZCBhcmdzIHN1Y2NlZWQgYW5kDQo+IGludmFsaWQgYXJncyBy
ZXR1cm4gdGhlIGV4cGVjdGVkIGVycm5vLg0KDQpZZXMsIGJ1dCBDeWd3aW4g
ZG9lc24ndCBjbGFpbSB0byBzdXBwb3J0IHRoZSBBVF9FTVBUWV9QQVRIIGZs
YWcgZXhjZXB0IGluIA0KbGlua2F0LiAgU28gdGhlcmUgaXMgbm8gZXhwZWN0
ZWQgZXJybm8uICBUaGUgb25seSB3YXkgdGhlcmUgd291bGQgYmUgYW4gZXhw
ZWN0ZWQgDQplcnJubyBpcyBpZiB3ZSBkZWNpZGUgdG8gYWRkIHN1cHBvcnQg
Zm9yIEFUX0VNUFRZX1BBVEggdG8gZmNob3duYXQuICBJJ20gc2F5aW5nIA0K
dGhhdCBJIGRvbid0IHNlZSB0aGUgcG9pbnQgaW4gZG9pbmcgdGhhdCwgYW5k
IEknbSBhc2tpbmcgd2hldGhlciBJJ20gbWlzc2luZyANCnNvbWV0aGluZy4g
IElmIHlvdSB0aGluayBJIHNob3VsZCBhZGQgdGhhdCBzdXBwb3J0LCBwbGVh
c2UgZXhwbGFpbiB3aHkuDQoNCktlbg0K

Return-Path: <cygwin-patches-return-9436-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100365 invoked by alias); 7 Jun 2019 12:09:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100355 invoked by uid 89); 7 Jun 2019 12:09:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.5 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,UNSUBSCRIBE_BODY autolearn=no version=3.3.1 spammy=arrived, crazy, Ken, book
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810128.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.128) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Jun 2019 12:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=vdazz0t+iG9aici92X1h35CK/KJeY40fqyWTZhhqOYM=; b=Wj4UQmcbt035gp+GFo6kRtxsqr5YjohI/xAcvYRyLl1/sSAb6CZwWs0TPuK4A0+nPhxrK3CJEBOLwkIHyNlms0eUOYshxf+VYGmQPSBbh5Qg6LNC/ccxh0NaHVRROMwuB8M8IgqHKoNt0XoFV95Bm/4Nbp2JYkqo3yzi5XutgEk=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3868.namprd04.prod.outlook.com (20.176.86.149) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Fri, 7 Jun 2019 12:09:08 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019 12:09:08 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
Date: Fri, 07 Jun 2019 12:09:00 -0000
Message-ID: <dac74739-7b66-56cb-ca8a-acbca7877eba@cornell.edu>
References: <20190526151019.2187-1-kbrown@cornell.edu> <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu> <20190603163519.GJ3437@calimero.vinschen.de>
In-Reply-To: <20190603163519.GJ3437@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2733;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F6B0814CC2306499EAD11679CECEA85@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00143.txt.bz2

T24gNi8zLzIwMTkgMTI6MzUgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IE9uIE1heSAzMCAxMjo1NiwgS2VuIEJyb3duIHdyb3RlOg0KPj4gT24g
NS8yNi8yMDE5IDExOjEwIEFNLCBLZW4gQnJvd24gd3JvdGU6DQo+Pj4gZmhh
bmRsZXJfcGlwZSBpcyBjdXJyZW50bHkgdGhlIG9ubHkgY2xhc3MgZGVyaXZl
ZCBmcm9tDQo+Pj4gZmhhbmRsZXJfYmFzZV9vdmVybGFwcGVkLiAgVGhpcyBw
YXRjaCBzZXJpZXMgcmV3cml0ZXMgcGFydHMgb2YNCj4+PiBmaGFuZGxlcl9w
aXBlIHNvIHRoYXQgaXQgY2FuIGJlIGRlcml2ZWQgZnJvbSBmaGFuZGxlcl9i
YXNlIGluc3RlYWQuDQo+Pj4gV2UgY2FuIHRoZW4gc2ltcGxpZnkgdGhlIGNv
ZGUgYnkgcmVtb3ZpbmcgZmhhbmRsZXJfYmFzZV9vdmVybGFwcGVkLg0KPj4+
DQo+Pj4gSW4gcGFydGljdWxhciwgdGhpcyBnZXRzIHJpZCBvZiB0aGUgcGVj
dWxpYXIgc2l0dWF0aW9uIGluIHdoaWNoIGENCj4+PiBub24tYmxvY2tpbmcg
d3JpdGUgY2FuIHJldHVybiB3aXRoIEkvTyBwZW5kaW5nLCBsZWFkaW5nIHRv
IHRoZQ0KPj4+IHVnbGluZXNzIGluIGZoYW5kbGVyX2Jhc2Vfb3ZlcmxhcHBl
ZDo6Y2xvc2UuDQo+Pj4NCj4+PiBJJ3ZlIG1hcmtlZCB0aGVzZSBwYXRjaGVz
IGFzIGRyYWZ0cyBiZWNhdXNlIEkndmUgdW5kb3VidGVkbHkNCj4+PiBvdmVy
bG9va2VkIHNvbWUgdGhpbmdzLiAgQWxzbywgSSBoYXZlbid0IHN5c3RlbWF0
aWNhbGx5IGRvbmUgYW55DQo+Pj4gcmVncmVzc2lvbiB0ZXN0cy4gIEkgaGF2
ZSwgaG93ZXZlciwgcnVuIGFsbCB0aGUgc2FtcGxlIHBpcGUgcHJvZ3JhbXMN
Cj4+PiBpbiBLZXJyaXNrJ3MgYm9vayAiVGhlIExpbnV4IFByb2dyYW1taW5n
IEludGVyZmFjZTogTGludXggYW5kIFVOSVgNCj4+PiBTeXN0ZW0gUHJvZ3Jh
bW1pbmcgSGFuZGJvb2siLiAgSSd2ZSBhbHNvIHJ1biBlbWFjcy1YMTEsIGdk
YiwgZ2l0LA0KPj4+IG1ha2UsIGV0Yy4sIHNvIGZhciB3aXRob3V0IHByb2Js
ZW1zLg0KPj4NCj4+IFRoaXMgaXNuJ3QgcmVhZHkgZm9yIHByaW1lIHRpbWUg
eWV0LiAgSSd2ZSBydW4gaW50byBvY2Nhc2lvbmFsIGVycm9ycw0KPj4gbGlr
ZSB0aGlzIHdoZW4gZG9pbmcgYSBwYXJhbGxlbCBidWlsZCBvZiBlbWFjcyAo
LWoxMyBpbiB0aGlzIGNhc2UpOg0KPj4NCj4+IG1ha2U6IElOVEVSTkFMOiBF
eGl0aW5nIHdpdGggMTQgam9ic2VydmVyIHRva2VucyBhdmFpbGFibGU7IHNo
b3VsZCBiZQ0KPj4gMTMhDQo+Pg0KPj4gVGhpcyB3b3VsZCBzZWVtIHRvIGlu
ZGljYXRlIHByb2JsZW1zIHdpdGggbWFrZSdzIGpvYnNlcnZlciBwaXBlLiAg
SSd2ZQ0KPj4gYWxyZWFkeSBmb3VuZCB0d28gYnVncyBpbiBwYXRjaCA0LCBi
dXQgSSdtIHN0aWxsIHNlZWluZyB0aGlzIGVycm9yDQo+PiBvbmNlIGluIGEg
d2hpbGUuDQo+Pg0KPj4gSSdsbCBzZW5kIGEgdjIgaWYvd2hlbiBJIGZpbmQg
dGhlIHByb2JsZW0uDQo+IA0KPiBFaXRoZXIgd2F5LCB5b3UncmUgY29sbGVj
dGluZyBnb2xkc3RhcnMgbGlrZSBjcmF6eSBoZXJlIDopDQoNClRoYW5rcy4N
Cg0KSSB0aGluayBJJ3ZlIGZvdW5kIHRoZSBwcm9ibGVtLiAgSSB3YXMgbWlz
aGFuZGxpbmcgc2lnbmFscyB0aGF0IGFycml2ZWQgZHVyaW5nIGEgDQpyZWFk
LiAgQnV0IGFmdGVyIEkgZml4IHRoYXQsIHRoZXJlJ3Mgc3RpbGwgb25lIG5h
Z2dpbmcgaXNzdWUgaW52b2x2aW5nIHRpbWVyZmQgDQpjb2RlLiAgSSdsbCB3
cml0ZSB0byB0aGUgbWFpbiBsaXN0IHdpdGggZGV0YWlscy4gIEkgKnRoaW5r
KiBpdCdzIGEgdGltZXJmZCBidWcsIA0KYnV0IGl0J3MgcHV6emxpbmcgdGhh
dCBJIG9ubHkgc2VlIGl0IHdoZW4gdGVzdGluZyBteSBuZXcgcGlwZSBpbXBs
ZW1lbnRhdGlvbi4NCg0KS2VuDQo=

Return-Path: <cygwin-patches-return-9418-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109245 invoked by alias); 30 May 2019 12:56:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109229 invoked by uid 89); 30 May 2019 12:56:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.8 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Ken, j13, prime, handbook
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820098.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.98) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 30 May 2019 12:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=gFJiNTkOT+0dChmO0i0+V594vU+7gaTKAPNlRiFNdns=; b=K/muGsUQatobe0iFyvHqjJbqTLpWc65QQaf1pDOvSUs5gSK3asRANqOpQ8IzYy6z55qX6MVLNCaboJEpFRBODpFo1iqJK+OCpPK3fUmznRJr28CdWZrDIlfi46GL2+O8DmDkFjdrmP6pJvUNNOXJJ5j3EKKeKvgx1Mat5DRp45M=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4460.namprd04.prod.outlook.com (20.176.104.205) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.17; Thu, 30 May 2019 12:56:11 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1922.024; Thu, 30 May 2019 12:56:11 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
Date: Thu, 30 May 2019 12:56:00 -0000
Message-ID: <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu>
References: <20190526151019.2187-1-kbrown@cornell.edu>
In-Reply-To: <20190526151019.2187-1-kbrown@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <970C11C29181E042BFCD339ABC8EFF43@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00125.txt.bz2

T24gNS8yNi8yMDE5IDExOjEwIEFNLCBLZW4gQnJvd24gd3JvdGU6DQo+IGZo
YW5kbGVyX3BpcGUgaXMgY3VycmVudGx5IHRoZSBvbmx5IGNsYXNzIGRlcml2
ZWQgZnJvbQ0KPiBmaGFuZGxlcl9iYXNlX292ZXJsYXBwZWQuICBUaGlzIHBh
dGNoIHNlcmllcyByZXdyaXRlcyBwYXJ0cyBvZg0KPiBmaGFuZGxlcl9waXBl
IHNvIHRoYXQgaXQgY2FuIGJlIGRlcml2ZWQgZnJvbSBmaGFuZGxlcl9iYXNl
IGluc3RlYWQuDQo+IFdlIGNhbiB0aGVuIHNpbXBsaWZ5IHRoZSBjb2RlIGJ5
IHJlbW92aW5nIGZoYW5kbGVyX2Jhc2Vfb3ZlcmxhcHBlZC4NCj4gDQo+IElu
IHBhcnRpY3VsYXIsIHRoaXMgZ2V0cyByaWQgb2YgdGhlIHBlY3VsaWFyIHNp
dHVhdGlvbiBpbiB3aGljaCBhDQo+IG5vbi1ibG9ja2luZyB3cml0ZSBjYW4g
cmV0dXJuIHdpdGggSS9PIHBlbmRpbmcsIGxlYWRpbmcgdG8gdGhlDQo+IHVn
bGluZXNzIGluIGZoYW5kbGVyX2Jhc2Vfb3ZlcmxhcHBlZDo6Y2xvc2UuDQo+
IA0KPiBJJ3ZlIG1hcmtlZCB0aGVzZSBwYXRjaGVzIGFzIGRyYWZ0cyBiZWNh
dXNlIEkndmUgdW5kb3VidGVkbHkNCj4gb3Zlcmxvb2tlZCBzb21lIHRoaW5n
cy4gIEFsc28sIEkgaGF2ZW4ndCBzeXN0ZW1hdGljYWxseSBkb25lIGFueQ0K
PiByZWdyZXNzaW9uIHRlc3RzLiAgSSBoYXZlLCBob3dldmVyLCBydW4gYWxs
IHRoZSBzYW1wbGUgcGlwZSBwcm9ncmFtcw0KPiBpbiBLZXJyaXNrJ3MgYm9v
ayAiVGhlIExpbnV4IFByb2dyYW1taW5nIEludGVyZmFjZTogTGludXggYW5k
IFVOSVgNCj4gU3lzdGVtIFByb2dyYW1taW5nIEhhbmRib29rIi4gIEkndmUg
YWxzbyBydW4gZW1hY3MtWDExLCBnZGIsIGdpdCwNCj4gbWFrZSwgZXRjLiwg
c28gZmFyIHdpdGhvdXQgcHJvYmxlbXMuDQoNClRoaXMgaXNuJ3QgcmVhZHkg
Zm9yIHByaW1lIHRpbWUgeWV0LiAgSSd2ZSBydW4gaW50byBvY2Nhc2lvbmFs
IGVycm9ycyBsaWtlIHRoaXMgDQp3aGVuIGRvaW5nIGEgcGFyYWxsZWwgYnVp
bGQgb2YgZW1hY3MgKC1qMTMgaW4gdGhpcyBjYXNlKToNCg0KbWFrZTogSU5U
RVJOQUw6IEV4aXRpbmcgd2l0aCAxNCBqb2JzZXJ2ZXIgdG9rZW5zIGF2YWls
YWJsZTsgc2hvdWxkIGJlIDEzIQ0KDQpUaGlzIHdvdWxkIHNlZW0gdG8gaW5k
aWNhdGUgcHJvYmxlbXMgd2l0aCBtYWtlJ3Mgam9ic2VydmVyIHBpcGUuICBJ
J3ZlIGFscmVhZHkgDQpmb3VuZCB0d28gYnVncyBpbiBwYXRjaCA0LCBidXQg
SSdtIHN0aWxsIHNlZWluZyB0aGlzIGVycm9yIG9uY2UgaW4gYSB3aGlsZS4N
Cg0KSSdsbCBzZW5kIGEgdjIgaWYvd2hlbiBJIGZpbmQgdGhlIHByb2JsZW0u
DQoNCktlbg0K

Return-Path: <cygwin-patches-return-9437-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127467 invoked by alias); 7 Jun 2019 18:05:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127306 invoked by uid 89); 7 Jun 2019 18:05:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=book, arrive, ugliness, sk:fhandle
X-HELO: NAM04-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr700115.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) (40.107.70.115) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Jun 2019 18:05:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=X2qS7pSlLA2z6x6Jk0gHs32FvVATOj1H39wfjXMw80Y=; b=fHsnA1gWEeYAwWh3+o7gNhaG3vsoCArcl7raMK25P5HmvOBkGJpE22hUWhXl5vYIrAEmC043OHzXQix7WhQ21IVdoGyAo85KXaUUG1agGWKxhv85lkZRZ6BKzNMHs/o4+3bujpW8Yp7vUuNf2Hubh5ddG97hcAzzRl/Uds0aZjM=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4313.namprd04.prod.outlook.com (20.176.77.22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Fri, 7 Jun 2019 18:05:27 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019 18:05:26 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH draft v2 0/6] Remove the fhandler_base_overlapped class
Date: Fri, 07 Jun 2019 18:05:00 -0000
Message-ID: <20190607180511.46369-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00144.txt.bz2

ZmhhbmRsZXJfcGlwZSBpcyBjdXJyZW50bHkgdGhlIG9ubHkgY2xhc3MgZGVy
aXZlZCBmcm9tDQpmaGFuZGxlcl9iYXNlX292ZXJsYXBwZWQuICBUaGlzIHBh
dGNoIHNlcmllcyByZXdyaXRlcyBwYXJ0cyBvZg0KZmhhbmRsZXJfcGlwZSBz
byB0aGF0IGl0IGNhbiBiZSBkZXJpdmVkIGZyb20gZmhhbmRsZXJfYmFzZSBp
bnN0ZWFkLg0KV2UgY2FuIHRoZW4gc2ltcGxpZnkgdGhlIGNvZGUgYnkgcmVt
b3ZpbmcgZmhhbmRsZXJfYmFzZV9vdmVybGFwcGVkLg0KDQpJbiBwYXJ0aWN1
bGFyLCB0aGlzIGdldHMgcmlkIG9mIHRoZSBwZWN1bGlhciBzaXR1YXRpb24g
aW4gd2hpY2ggYQ0Kbm9uLWJsb2NraW5nIHdyaXRlIGNhbiByZXR1cm4gd2l0
aCBJL08gcGVuZGluZywgbGVhZGluZyB0byB0aGUNCnVnbGluZXNzIGluIGZo
YW5kbGVyX2Jhc2Vfb3ZlcmxhcHBlZDo6Y2xvc2UuDQoNCkkndmUgbWFya2Vk
IHRoZXNlIHBhdGNoZXMgYXMgZHJhZnRzIGJlY2F1c2UgSSd2ZSB1bmRvdWJ0
ZWRseQ0Kb3Zlcmxvb2tlZCBzb21lIHRoaW5ncy4gIEFsc28sIEkgaGF2ZW4n
dCBzeXN0ZW1hdGljYWxseSBkb25lIGFueQ0KcmVncmVzc2lvbiB0ZXN0cy4g
IEkgaGF2ZSwgaG93ZXZlciwgcnVuIGFsbCB0aGUgc2FtcGxlIHBpcGUgcHJv
Z3JhbXMNCmluIEtlcnJpc2sncyBib29rICJUaGUgTGludXggUHJvZ3JhbW1p
bmcgSW50ZXJmYWNlOiBMaW51eCBhbmQgVU5JWA0KU3lzdGVtIFByb2dyYW1t
aW5nIEhhbmRib29rIi4gIEkndmUgYWxzbyBydW4gZW1hY3MtWDExLCBnZGIs
IGdpdCwNCm1ha2UsIGV0Yy4sIGN1cnJlbnRseSB3aXRob3V0IHByb2JsZW1z
LCBleGNlcHQgcGVyaGFwcyBmb3IgYSB0aW1lcmZkDQpwcm9ibGVtIHRoYXQg
SSB0aGluayBpcyB1bnJlbGF0ZWQgdG8gbXkgcGF0Y2hlcw0KKGh0dHA6Ly93
d3cuY3lnd2luLm9yZy9tbC9jeWd3aW4vMjAxOS0wNi9tc2cwMDA5Ni5odG1s
KS4NCg0KdjI6IEZpeCBzb21lIGVycm9ycyBpbiB0aGUgaGFuZGxpbmcgb2Yg
c2lnbmFscyB0aGF0IGFycml2ZSBkdXJpbmcNCnJhd19yZWFkIG9yIHJhd193
cml0ZS4NCg0KS2VuIEJyb3duICg2KToNCiAgQ3lnd2luOiBmaGFuZGxlcl9w
aXBlOiBkZXJpdmUgZnJvbSBmaGFuZGxlcl9iYXNlDQogIEN5Z3dpbjogZmhh
bmRsZXJfcGlwZTogYWRkIHJhd19yZWFkIGFuZCByYXdfd3JpdGUNCiAgQ3ln
d2luOiBmaGFuZGxlcl9waXBlOiBjb250cm9sIGJsb2NraW5nIG1vZGUgb2Yg
dGhlIFdpbmRvd3MgcGlwZQ0KICBDeWd3aW46IGZoYW5kbGVyX3BpcGU6IGZp
eCBwZXJtaXNzaW9uIHByb2JsZW0NCiAgQ3lnd2luOiByZW1vdmUgdGhlIGZo
YW5kbGVyX2Jhc2Vfb3ZlcmxhcHBlZCBjbGFzcw0KICBDeWd3aW46IGFkZCBm
aGFuZGxlcl9iYXNlOjpucGZzX2hhbmRsZQ0KDQogd2luc3VwL2N5Z3dpbi9m
aGFuZGxlci5jYyAgICAgICAgICAgICB8IDM5NSArKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQogd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oICAgICAgICAg
ICAgICB8ICA5MCArLS0tLS0NCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2Zp
Zm8uY2MgICAgICAgIHwgIDMwIC0tDQogd2luc3VwL2N5Z3dpbi9maGFuZGxl
cl9waXBlLmNjICAgICAgICB8IDM5NiArKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXJfc29ja2V0X3VuaXguY2Mg
fCAgMzAgLS0NCiB3aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjICAgICAgICAg
ICAgIHwgICAxIC0NCiA2IGZpbGVzIGNoYW5nZWQsIDQyMiBpbnNlcnRpb25z
KCspLCA1MjAgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yMS4wDQoNCg==

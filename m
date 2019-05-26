Return-Path: <cygwin-patches-return-9410-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47445 invoked by alias); 26 May 2019 15:10:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47435 invoked by uid 89); 26 May 2019 15:10:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*MI:edu, draft, Programming, pipe
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730108.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.108) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 26 May 2019 15:10:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QQ+fCjnlfpwa3qnLK0xmQ8Ak2+ebu4K/CBBsk4LIvvI=; b=gQV4pPyPgIs8mLZAJ9LBd3gVsWx3pSI7N5X0sVOFddcL/1J9iYtX0vAxbGGYpkbWhfpaYB7S8LYZGx5Kh9qZN9Fcal/rHpStlVS69+mQRCeoWTNAUhOnBsVSA0TQy4AR1rFvxnH/sBcaOhEZ7dYYBnQ38H34s6UtIEBQvm+lDaQ=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4777.namprd04.prod.outlook.com (20.176.107.206) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.15; Sun, 26 May 2019 15:10:35 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1922.021; Sun, 26 May 2019 15:10:35 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
Date: Sun, 26 May 2019 15:10:00 -0000
Message-ID: <20190526151019.2187-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00117.txt.bz2

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
IGdpdCwNCm1ha2UsIGV0Yy4sIHNvIGZhciB3aXRob3V0IHByb2JsZW1zLg0K
DQpLZW4gQnJvd24gKDYpOg0KICBDeWd3aW46IGZoYW5kbGVyX3BpcGU6IGRl
cml2ZSBmcm9tIGZoYW5kbGVyX2Jhc2UNCiAgQ3lnd2luOiBmaGFuZGxlcl9w
aXBlOiBhZGQgcmF3X3JlYWQgYW5kIHJhd193cml0ZQ0KICBDeWd3aW46IGZo
YW5kbGVyX3BpcGU6IHNldCB0aGUgYmxvY2tpbmcgbW9kZSBvZiB0aGUgV2lu
ZG93cyBwaXBlDQogIEN5Z3dpbjogZmhhbmRsZXJfcGlwZTogZml4IHBlcm1p
c3Npb24gcHJvYmxlbQ0KICBDeWd3aW46IHJlbW92ZSB0aGUgZmhhbmRsZXJf
YmFzZV9vdmVybGFwcGVkIGNsYXNzDQogIEN5Z3dpbjogYWRkIGZoYW5kbGVy
X2Jhc2U6Om5wZnNfaGFuZGxlDQoNCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVy
LmNjICAgICAgICAgICAgIHwgMzk1ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQogd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oICAgICAgICAgICAgICB8
ICA5MCArLS0tLS0NCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2Mg
ICAgICAgIHwgIDMwIC0tDQogd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9waXBl
LmNjICAgICAgICB8IDM1NCArKysrKysrKysrKysrKysrKysrKysrLQ0KIHdp
bnN1cC9jeWd3aW4vZmhhbmRsZXJfc29ja2V0X3VuaXguY2MgfCAgMzAgLS0N
CiB3aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjICAgICAgICAgICAgIHwgICAx
IC0NCiA2IGZpbGVzIGNoYW5nZWQsIDM4MCBpbnNlcnRpb25zKCspLCA1MjAg
ZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xNy4wDQoNCg==

Return-Path: <cygwin-patches-return-9445-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 101962 invoked by alias); 7 Jun 2019 19:13:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 101945 invoked by uid 89); 7 Jun 2019 19:13:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.8 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,UNSUBSCRIBE_BODY autolearn=no version=3.3.1 spammy=Ken, H*f:sk:dac7473, H*f:sk:826b6cd, hour
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780093.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Jun 2019 19:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=WGKA0amiUJR0UdX//hUBd4F1VXx2ts9jDXnHh6Yw16U=; b=HlqA79E8HIWYukBR9IEJq9zEor5TJwZRvoHAp70jdPFc/gPeVEo/vewJdexc54eQ0AqsvTn7sd9V7/qwuPzzLrMoM7V7pnLED4GxCG9VmP2CEQG3YqvNJ/jSBYZhcxNTwohDNW350qLoysrLHCLiWLir/Srf59oIZsFHBDY0t48=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5820.namprd04.prod.outlook.com (20.179.49.14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Fri, 7 Jun 2019 19:13:36 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019 19:13:36 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
Date: Fri, 07 Jun 2019 19:13:00 -0000
Message-ID: <d3a6fcad-69c3-e6e6-07fa-3311ec833c69@cornell.edu>
References: <20190526151019.2187-1-kbrown@cornell.edu> <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu> <20190603163519.GJ3437@calimero.vinschen.de> <dac74739-7b66-56cb-ca8a-acbca7877eba@cornell.edu> <874l51p7rt.fsf@Rainer.invalid>
In-Reply-To: <874l51p7rt.fsf@Rainer.invalid>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC7A7E4E9317D745A006F3430FACA5CB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00152.txt.bz2

T24gNi83LzIwMTkgMjozMSBQTSwgQWNoaW0gR3JhdHogd3JvdGU6DQo+IEtl
biBCcm93biB3cml0ZXM6DQo+PiBJIHRoaW5rIEkndmUgZm91bmQgdGhlIHBy
b2JsZW0uICBJIHdhcyBtaXNoYW5kbGluZyBzaWduYWxzIHRoYXQgYXJyaXZl
ZCBkdXJpbmcgYQ0KPj4gcmVhZC4gIEJ1dCBhZnRlciBJIGZpeCB0aGF0LCB0
aGVyZSdzIHN0aWxsIG9uZSBuYWdnaW5nIGlzc3VlIGludm9sdmluZyB0aW1l
cmZkDQo+PiBjb2RlLiAgSSdsbCB3cml0ZSB0byB0aGUgbWFpbiBsaXN0IHdp
dGggZGV0YWlscy4gIEkgKnRoaW5rKiBpdCdzIGEgdGltZXJmZCBidWcsDQo+
PiBidXQgaXQncyBwdXp6bGluZyB0aGF0IEkgb25seSBzZWUgaXQgd2hlbiB0
ZXN0aW5nIG15IG5ldyBwaXBlIGltcGxlbWVudGF0aW9uLg0KPiANCj4gQW55
dGhpbmcgdHJpZ2dlcmluZyBhIHJhY2Ugb3IgZGVhZGxvY2sgd2lsbCBkZXBl
bmQgb24gc28gbWFueSBvdGhlcg0KPiB0aGluZ3MgdGhhdCBpdCByZWFsbHkg
aXMgbm8gc3VycHJpc2UgdG8gc2VlIHNlZW1pbmdseSB1bnJlbGF0ZWQgY2hh
bmdlcw0KPiBtYWtpbmcgdGhlIGJ1ZyBhcHBlYXIgb3IgZGlzYXBwZWFyLiAg
VGhlcmUgYXJlIGNlcnRhaW5seSByYWNlcyBsZWZ0IGluDQo+IEN5Z3dpbiwg
SSBzZWUgdGhlbSBmcm9tIHRpbWUgdG8gdGltZSBpbiB2YXJpb3VzIFBlcmwg
bW9kdWxlcywganVzdCBuZXZlcg0KPiByZXByb2R1Y2libGUgZW5vdWdoIHRv
IGdpdmUgYW55b25lIGFuIGlkZWEgb2Ygd2hlcmUgdG8gbG9vay4NCg0KVGhh
dCBtYWtlcyBzZW5zZS4NCg0KSW4gdGhlIG1lYW50aW1lLCBJJ3ZlIGFscmVh
ZHkgZGlzY292ZXJlZCBhbm90aGVyIHByb2JsZW0sIHdpdGhpbiBhbiBob3Vy
IG9mIA0KcG9zdGluZyBteSBjbGFpbSB0aGF0IGV2ZXJ5dGhpbmcgd2FzIHdv
cmtpbmcgZmluZTogSWYgSSBzdGFydCBlbWFjcy1YMTEgd2l0aCANCmN5Z3Nl
cnZlciBydW5uaW5nLCBJIGNhbid0IGZvcmsgYW55IHN1YnByb2Nlc3NlcyB3
aXRoaW4gZW1hY3MuICBJIGdldA0KDQowIFttYWluXSBlbWFjcyAyNjg5IGRv
Zm9yazogY2hpbGQgMjY5MyAtIGRpZWQgd2FpdGluZyBmb3IgZGxsIGxvYWRp
bmcsIGVycm5vIDExDQoNCkJhY2sgdG8gdGhlIGRyYXdpbmcgYm9hcmQuLi4u
ICBJJ3ZlIG5ldmVyIGxvb2tlZCBhdCB0aGUgY3lnc2VydmVyIGNvZGUsIGJ1
dCANCm1heWJlIGl0IHdpbGwgdHVybiBvdXQgdG8gYmUgc29tZXRoaW5nIGVh
c3kuDQoNCktlbg0K

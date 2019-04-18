Return-Path: <cygwin-patches-return-9366-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19057 invoked by alias); 18 Apr 2019 21:00:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19035 invoked by uid 89); 18 Apr 2019 21:00:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.2 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:620, rights
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820125.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.125) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Apr 2019 21:00:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=f3USUGwD+umGrnvNj76ly5kDdKOoGaSSZBurWmhmcn0=; b=JIwyAj6Dr/leORC+4Ky5e0YHV/pjLECdBtKIEczrujOP7E69ohWATWMNVRcJ4EMfOgON4DFyAjWv+NSUJqg3xO5JLCXC8h0rRjDqoT9tmE8GYjD5QYR+7D701lkQIJDihBteBlaklijEcpIdjmZVNlUSfFomtOkHuazfxpsZHew=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5705.namprd04.prod.outlook.com (20.179.50.91) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Thu, 18 Apr 2019 21:00:49 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019 21:00:49 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Takashi Yano	<takashi.yano@nifty.ne.jp>, Mark Geisert <mark@maxrnd.com>
Subject: Re: Cygwin patches (was Re: [PATCH 00/14] FIFO bug fixes and code simplifications)
Date: Thu, 18 Apr 2019 21:00:00 -0000
Message-ID: <09dc74df-bda9-4dba-bb3e-f508afa31851@cornell.edu>
References: <20190414191543.3218-1-kbrown@cornell.edu> <20190416112243.GR3599@calimero.vinschen.de> <87o95435qo.fsf@Rainer.invalid> <f477bb3d-1918-3b25-9682-a3b187a12dc2@cornell.edu> <87h8awa278.fsf@Rainer.invalid> <0e2c6674-af17-a6e9-54e3-1ec374712832@cornell.edu> <87bm13dv5a.fsf@Rainer.invalid> <20190418190402.GI3599@calimero.vinschen.de>
In-Reply-To: <20190418190402.GI3599@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <175AA58C091BFC4A9AEABB39C3465614@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00073.txt.bz2

T24gNC8xOC8yMDE5IDM6MDQgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IEtlbiwgeW91IGhhdmUgYW4gYWNjb3VudCBvbiBzd2FyZSBhbmQgY2hl
Y2staW4gcmlnaHRzIHRvIHRoZSBjeWd3aW4gcmVwbw0KPiBhbnl3YXksIHNv
IHlvdSBkb24ndCByZWFsbHkgbmVlZCBtZSB0byBwdXNoIHBhdGNoZXMuDQo+
IA0KPiBJZiB5b3UgZmVlbCB1cCB0byB0aGUgdGFzaywgeW91IGNhbiBhbHNv
IGdvIGFoZWFkIGFuZCByZXZpZXcgYW5kDQo+IHVsdGltYXRlbHkgcHVzaCBw
YXRjaGVzIGZyb20gb3RoZXJzLiAgVGhpcyBhbHNvIGFwcGxpZXMgdG8gVGFr
YXNoaSdzDQo+IENvblBUWSBwYXRjaCBhcyBzb29uIGFzIGhlIHdhbnRzIHRv
IGdvIG1haW5saW5lLA0KDQpJIGNhbiBkbyB0aGF0Lg0KDQo+IGFzIHdlbGwg
YXMgTWFyaydzDQo+IHNjaGVkX1tnc11ldGFmZmluaXR5IHBhdGNoZXMsIGFm
dGVyIHJldmlldy4NCg0KSSdtIG5vdCBzdXJlIEknbSBxdWFsaWZpZWQgdG8g
cmV2aWV3IHRoZXNlLCBidXQgbWF5YmUgaGUgd29uJ3Qgd2FpdCB1bnRpbCBN
YXkgOikNCg0KS2VuDQo=

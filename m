Return-Path: <cygwin-patches-return-9516-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90291 invoked by alias); 24 Jul 2019 15:04:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90281 invoked by uid 89); 24 Jul 2019 15:04:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=1.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=no version=3.3.1 spammy=Hx-clientproxiedby:2603
X-HELO: NAM05-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr720121.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) (40.107.72.121) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Jul 2019 15:04:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=gIa30Zus0sJZVW90iMsWxKF8OFVAb1CYMd1CARCfKIIKcRVUgBx6leG1J/scYE2LuqhHNTC9zavPtZgUG5zapaMAAZgEZovqHhYty282XIXtQaGSxuVlKkKS5ErwGDEEhlT5bIbOmPwG1U7cuj5I4ne7vmKgGpQQ/qDaMA9848JitEcLVK5RbaE+YoXTY8GcBFfh34Y13pJU3PqJi7OnqtFtMChPMWao69IMwT5dif1zO5L1KB6ep9WozxTOk6yWrDDUlRVnn9A3viJEvb93/WTUNuweYyFhTpnoz1aHgkzoUnjncC5X46O52zaxO3Jf1hpthE9J9p8d5UxaohsAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8czdgs+9UZtHSvF2LObPdlyMr2jdgE8MLd9LnBX0H9E=; b=N43dO+ypJ5eKhhc8UjP7YKvwbK/9xqORjhWSxlkZnElZeANB5xGtdNjUzudiepQmNOnidqJpwVBGvkaYfPyVN3GoBMg7qhDTBU1Aic1FN/g9rhGoOenPp8BTYjnATwc5D+YzFV4Darn2VXLEHZKKInxc5j5MrLPBZ51xunhUJ4RP+aD2W09MtdD+jPQuMy71EObso789nSd+lY3t/rCB1ujMfPediKuck8h1FLyxKb+kdU9fMFCGexkmG9npLHzlhxJ9VV+B+UM8R1ht2V7rZm5pc1FPF2Ij206mSpI03g9d1cm1CiUEibwI+ngd44uytshomaahEuCobF0lBtrOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8czdgs+9UZtHSvF2LObPdlyMr2jdgE8MLd9LnBX0H9E=; b=BYucn23XQ0iQFg/JuEL7h1O45RmNYnQQzRcHWAV4T3rr8b7X0hpbYRNIKHa5j1ShFsH1/pcMKPzxTPs9RtWqGzAwe+U4hbh86t8G3UDH6FrmeH+GRJdI2Fl/ts4D5Dc4Aoj33IHTvs+RK6VImfLJOK16lJ9vfB933McqjVCzTmQ=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2202.namprd04.prod.outlook.com (10.166.206.136) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Wed, 24 Jul 2019 15:04:37 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.017; Wed, 24 Jul 2019 15:04:37 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 1/1] Cygwin: don't allow getpgrp() to fail
Date: Wed, 24 Jul 2019 15:04:00 -0000
Message-ID: <03431b8b-22aa-d288-aa11-87a9feedfb44@cornell.edu>
References: <20190723161100.1045-1-kbrown@cornell.edu> <20190723161100.1045-2-kbrown@cornell.edu> <20190723165458.GM21169@calimero.vinschen.de> <59c6529d-b411-fcf5-fa82-8a681d5b6378@dronecode.org.uk> <20190723191648.GP21169@calimero.vinschen.de>
In-Reply-To: <20190723191648.GP21169@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:10000;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BD00EE1A998554B8564E5E24D52C941@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00036.txt.bz2

T24gNy8yMy8yMDE5IDM6MTYgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IE9uIEp1bCAyMyAxOTowNywgSm9uIFR1cm5leSB3cm90ZToNCj4+IE9u
IDIzLzA3LzIwMTkgMTc6NTQsIENvcmlubmEgVmluc2NoZW4gd3JvdGU6DQo+
Pj4gSGkgS2VuLA0KPj4+DQo+Pj4gT24gSnVsIDIzIDE2OjEyLCBLZW4gQnJv
d24gd3JvdGU6DQo+Pj4+IEFjY29yZGluZyB0byBQT1NJWCwgIlRoZSBnZXRw
Z3JwKCkgZnVuY3Rpb24gc2hhbGwgYWx3YXlzIGJlIHN1Y2Nlc3NmdWwNCj4+
Pj4gYW5kIG5vIHJldHVybiB2YWx1ZSBpcyByZXNlcnZlZCB0byBpbmRpY2F0
ZSBhbiBlcnJvci4iICBDeWd3aW4ncw0KPj4+PiBnZXRwZ3JwKCkgaXMgZGVm
aW5lZCBpbiB0ZXJtcyBvZiBnZXRwZ2lkKCksIHdoaWNoIGlzIGFsbG93ZWQg
dG8gZmFpbC4NCj4+Pg0KPj4+IEJ1dCBpdCBzaG91bGRuJ3QgZmFpbCBmb3Ig
dGhlIGN1cnJlbnQgcHJvY2Vzcy4gIFdoeSBzaG91bGQgcGluZm86OmluaXQN
Cj4+PiBmYWlsIGZvciBteXNlbGYgaWYgaXQgYmVnaW5zIGxpa2UgdGhpcz8N
Cj4+Pg0KPj4+ICAgICBpZiAobXlzZWxmICYmIG4gPT0gbXlzZWxmLT5waWQp
DQo+Pj4gICAgICAgew0KPj4+ICAgICAgICAgcHJvY2luZm8gPSBteXNlbGY7
DQo+Pj4gICAgICAgICBkZXN0cm95ID0gMDsNCj4+PiAgICAgICAgIHJldHVy
bjsNCj4+PiAgICAgICB9DQo+Pj4NCj4+PiBJIGZlYXIgdGhpcyBwYXRjaCB3
b3VsZCBvbmx5IGNvdmVyIHVwIHRoZSBwcm9ibGVtIHN0aWxsIHBlcnNpc3Rp
bmcNCj4+PiB1bmRlciB0aGUgaG9vZC4NCj4+DQo+PiBJIGFncmVlLg0KPj4N
Cj4+IFRoZXJlIGlzIHByZXN1bWFibHkgYSBjbGFzcyBvZiBwcm9ncmFtcyB3
aGljaCByZXF1aXJlIGdldHBncnAoKSB0byByZXR1cm4NCj4+IHRoZSBjb3Jy
ZWN0IHZhbHVlIGZvciBjb3JyZWN0IG9wZXJhdGlvbiwgd2hpY2ggY2Fubm90
IGJlIDAgKHNpbmNlIHRoYXQNCj4+IGNhbm5vdCBiZSBhIHBpZCkuDQo+IA0K
PiBIb3dldmVyLCBkaWQgd2UgZXZlciBzZWUgdGhpcyBwcm9ibGVtIG91dHNp
ZGUgb2YgR0RCPw0KDQpJIHRoaW5rIEkndmUgZm91bmQgdGhlIHByb2JsZW0s
IGFzIEkganVzdCByZXBvcnRlZCBvbiB0aGUgbWFpbiBjeWd3aW4gbGlzdC4g
IEFuZCANCkkgYWdyZWUgdGhhdCBteSBwYXRjaCB3YXMgbWlzZ3VpZGVkLg0K
DQpCdXQgSSBzdGlsbCB0aGluayBnZXRwZ3JwKCkgc2hvdWxkIGJlIGNoYW5n
ZWQsIHBlcmhhcHMgYnkgaGF2aW5nIGl0IGp1c3QgcmV0dXJuIA0KbXlzZWxm
LT5wZ2lkIGFzIHlvdSBzdWdnZXN0ZWQgZWFybGllci4gIFRoZXJlJ3Mgbm8g
cG9pbnQgaW4gaGF2aW5nIGdldHBncnAoKSANCmNhbGwgZ2V0cGdpZCgpLCB3
aGljaCBkb2VzIGVycm9yIGNoZWNraW5nLCB3aGVuIFBPU0lYIHNwZWNpZmlj
YWxseSBzYXlzICJubyANCnJldHVybiB2YWx1ZSBbb2YgZ2V0cGdycCgpXSBp
cyByZXNlcnZlZCB0byBpbmRpY2F0ZSBhbiBlcnJvciIuICBQT1NJWC1jb21w
YXRpYmxlIA0KYXBwbGljYXRpb25zIHNob3VsZCBjYWxsIGdldHBnaWQoMCkg
aW5zdGVhZCBvZiBnZXRwZ3JwKCkgaWYgdGhleSB3YW50IHRvIGRvIA0KZXJy
b3IgY2hlY2tpbmcuDQoNCkknbGwgc2VuZCBhIGNvdXBsZSBvZiBwYXRjaGVz
LCBvbmUgZm9yIHRoaXMgaXNzdWUgYW5kIG9uZSBmb3IgdGhlIHRjc2V0cGdy
cCgpIA0KcHJvYmxlbSwgc28gdGhhdCB3ZSBjYW4gZGlzY3VzcyBpdCBmdXJ0
aGVyLg0KDQpLZW4NCg==

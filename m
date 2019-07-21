Return-Path: <cygwin-patches-return-9496-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49959 invoked by alias); 21 Jul 2019 01:46:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49949 invoked by uid 89); 21 Jul 2019 01:46:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=no version=3.3.1 spammy=brown, Brown, Ken, H*i:sk:8dce094
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780130.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 01:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Tep9D3Iitpw+7v6N56BViI1cgE+k6lZMTxNDLtn3p3qhoxToYwRZgqlNhG6SSEZx84IhNEVo5vrsiWZpaUSCDRiC33Y+EXkgeZ8TBKzbk+6JhzdChs07BXFV7GMCHJQBaGzd2eELUDrMuNq4lGPneU9QtUi5SgbHfcR+2kte/6n3DNt6uZjLGPR4KfcsRWDjlRdxFvHeXDr0fOq4lrxKXlnWM6JgyCzQVNs9uOA1REl3FHSpUPCx9yiMEEWUryfPiTCSixWQsLKiX0tT+oAYzbBH/Bm5vxyy87J65X6WHRj4V6MVl9oGOkx/FBdJmXXCknmZpFrEwILuv7TIcCKjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=iRcYYioW+Z8zeDaOpJfqqUT71yRukZCIuZcz7NyxJXA=; b=nI97ha39isiYzCLiMRRaP0Nnr985JcOZYiucYi4gy8kEaNX0imkCvyMPbn3ml/8PUgFZIkg5UiAwy43kRJ9BzhdNPb9Xg+fSihJ7PHqxAuyyTLKOyGiFMdIQI/MvDsgMP2bKoOnkaWDtOQP0rPvvu8V43DrZIk8QxBHj4lJtyLqw3U8vRB/xxkbmGOWP4jnER8grjSedEuGZ48eHDI/9WEfdg3mTEEJfcu/zfwRI3xNeab0AJdjJrXnOpL58I6r+y8uz1F2n9Cjv3zNUCPWNY8LTmDPKbfljZRs2b4iY8uquV/b6nwaIEup1J/n+m5JmmSCeJuHghCU9AfqFTi0WLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=iRcYYioW+Z8zeDaOpJfqqUT71yRukZCIuZcz7NyxJXA=; b=al5aJxSr2i8EEYYqPoa6vA5gZW6aKpH6DeRWb+OKIqqXHZeVWllYKgSsaqxISlv8qmggkMgBsOtwFW/vhYDjfpgqqIKV+DbgNf9E1qwhnrN6vjOnCTMPArlTigAbSUArUzi2aUlOpk73ZYukRhjyR9Lj++4ADx26kSxZdW7HCJc=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2204.namprd04.prod.outlook.com (10.167.10.6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14; Sun, 21 Jul 2019 01:46:11 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.013; Sun, 21 Jul 2019 01:46:11 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: make path_conv::isdevice() return false on socket files
Date: Sun, 21 Jul 2019 01:46:00 -0000
Message-ID: <e97cff22-2083-b5ec-1dac-31a34b0c86c3@cornell.edu>
References: <20190718200026.1377-1-kbrown@cornell.edu> <20190719082845.GO3772@calimero.vinschen.de> <8dce0946-6f7e-a3f4-62b1-98cdbbe277ef@cornell.edu>
In-Reply-To: <8dce0946-6f7e-a3f4-62b1-98cdbbe277ef@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6430;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4E0AF1713A47340A0A7BBA05E79EE44@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00016.txt.bz2

T24gNy8yMC8yMDE5IDY6NTMgUE0sIEtlbiBCcm93biB3cm90ZToNCj4gT24g
Ny8xOS8yMDE5IDQ6MjggQU0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6DQo+
PiBJIHNlZSB3aGF0IHlvdSdyZSBkb2luZyBoZXJlLCBidXQgaXQncyB0b3Rh
bGx5IG5vbi1vYnZpb3VzIGZyb20gdGhlDQo+PiBjb21taXQgbWVzc2FnZSB3
aHkgdGhpcyBmaXhlcyB0aGUgcHJvYmxlbSBhbmQgZG9lc24ndCBpbnRyb2R1
Y2Ugd2VpcmQNCj4+IHNpZGUtZWZmZWN0cy4NCj4gDQo+IFRoYW5rcy4gIEkg
d2FzIHByZXR0eSBjYXJlbGVzcyB3aXRoIHRoaXMgcGF0Y2guICBUaGVyZSdz
IGEgbmV3IHBhdGNoIHNlcmllcyBvbg0KPiB0aGUgd2F5IHRoYXQgKEkgaG9w
ZSkgZG9lcyBpdCByaWdodC4NCj4gDQo+PiBBbiBlZGl0b3JpYWwgbm90ZTog
V2hpbGUgbG9va2luZyBpbnRvIHlvdXIgcGF0Y2ggaXQgb2NjdXJlZCB0byBt
ZSB0aGF0DQo+PiBpdCB3b3VsZCBiZSBhYm91dCB0aW1lIHRvIGdvIG92ZXIg
YWxsIHRoZSBpcyoqKmRldmljZSgpIG1ldGhvZHMgYW5kDQo+PiBjbGVhbiB1
cCB0aGUgbWVzcy4gIEUuZy4sIGlzX2ZzX2RldmljZSgpIGlzIHVzZWQgYnkg
aXNfbG5rX3NwZWNpYWwoKQ0KPj4gb25seSwgaXNfYXV0b19kZXZpY2UoKSBk
b2Vzbid0IGhhdmUgbXVjaCBtZWFuaW5nLA0KPiANCj4gSSd2ZSByZW1vdmVk
IGlzX2ZzX2RldmljZSgpIGFuZCBpc19hdXRvX2RldmljZSgpDQo+IA0KPj4g
c29tZSBmdW5jcyBoYXZlDQo+PiB1bmRlcnNjb3Jlcywgc29tZSBkb24ndC4N
Cj4gDQo+IFRoZSBjb252ZW50aW9uIHNlZW1zIHRvIGJlIHRoYXQgaXM8c29t
ZXRoaW5nPiB1c2VzIHVuZGVyc2NvcmVzIGlmIGFuZCBvbmx5IGlmDQo+ICJz
b21ldGhpbmciIGlzIGEgc2luZ2xlIHdvcmQuDQogICAgICAgICAgICAgICAg
ICBeDQogICAgICAgICAgICAgICAgIG5vdA0KDQo+ICBUaGUgb25seSBleGNl
cHRpb24gSSBzYXcgaXMgaXNjdHR5X2NhcGFibGUuICBJDQo+IGRpZG4ndCBi
b3RoZXIgY2hhbmdpbmcgdGhpcywgYnV0IEkgY291bGQgaWYgeW91IHdhbnQg
bWUgdG8uDQo+IA0KPiBLZW4NCj4gDQo=

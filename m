Return-Path: <cygwin-patches-return-9406-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107942 invoked by alias); 9 May 2019 18:57:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107932 invoked by uid 89); 9 May 2019 18:57:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=listening, H*Ad:U*cygwin-patches
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740107.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.107) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 May 2019 18:57:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=2rHOCBYhYTfKmv4g92FLXAdkY7a7uZeSuz5LRE4ze90=; b=DbQhQQ8L00vKGSF9sB7GGqEcJFmxA0SmHfJ9Pe/m8w18W5J6+WR0vOc+czz2Vo+acayQvEN3K7PEYUc7Vx4BeXCOBZcZ2bBNL9yHUP0+TqQtjln9gRRYcgfF7UjIoUNGReKCg9aHEN9LwYTnal6pZcaz5jhOvDM+TM/aPashIKw=
Received: from BYAPR04MB5207.namprd04.prod.outlook.com (20.178.48.80) by BYAPR04MB6215.namprd04.prod.outlook.com (20.178.234.78) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.11; Thu, 9 May 2019 18:57:37 +0000
Received: from BYAPR04MB5207.namprd04.prod.outlook.com ([fe80::20a4:a681:4d9b:f6be]) by BYAPR04MB5207.namprd04.prod.outlook.com ([fe80::20a4:a681:4d9b:f6be%6]) with mapi id 15.20.1856.012; Thu, 9 May 2019 18:57:37 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Date: Thu, 09 May 2019 18:57:00 -0000
Message-ID: <0125b01f-8304-0f25-34ae-4f96ec46ba85@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu> <6fbdf204-4be5-24b8-1df3-aa5d6589619b@cornell.edu> <93c33c8d-e303-9a06-f5da-4e6d8b7f195c@cornell.edu> <20190429190614.GL3383@calimero.vinschen.de>
In-Reply-To: <20190429190614.GL3383@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:5797;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BFB08EB8109934A92C3926AB29F0B95@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00113.txt.bz2

T24gNC8yOS8yMDE5IDM6MDYgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IE9uIEFwciAyOSAxODo0MiwgS2VuIEJyb3duIHdyb3RlOg0KPj4gQWN0
dWFsbHksIHRoZSBhbnN3ZXIgbWlnaHQgYmUgb2J2aW91cy4gIExvb2tpbmcg
YXQgTVNETiwgaXQgbm93IHNlZW1zDQo+PiBjbGVhciB0byBtZSB0aGF0IHlv
dSBjYW4ndCBkbyBJL08gb24gdGhlIHNlcnZlciBzaWRlIG9mIGEgcGlwZSB1
bnRpbA0KPj4gdGhlIHBpcGUgY29ubmVjdHMgdG8gYSBjbGllbnQuICBTbyBJ
J2xsIGhhdmUgdG8gcmV0aGluayBob3cgdG8gZGVhbA0KPj4gd2l0aCB0aGUg
T19SRFdSIGNhc2UuDQo+IA0KPiBTb3JyeSBiZWluZyBsYXRlLCBidXQgeWVh
aCwgU1RBVFVTX1BJUEVfTElTVEVOSU5HIG1lYW5zIG5vIGNsaWVudCBpcw0K
PiBjb25uZWN0ZWQuICBUaGlzIGlzIG9uZSBvZiB0aGUgbW9yZSB1Z2x5IGlt
cGxlbWVudGF0aW9uIGRldGFpbHMgb2YNCj4gV2luZG93cyBwaXBlcy4gIFRo
ZXJlIGp1c3QgaXNuJ3QgYSBnZW5lcmljIGJ1ZmZlciB3aGljaCBjYW4gYmUg
ZmlsbGVkDQo+IGV2ZW4gaWYgbm8gb25lIGlzIGxpc3RlbmluZyB5ZXQgb24g
dGhlIG90aGVyIHNpZGUgOi1QDQoNClRoaXMgc2hvdWxkIGJlIGZpeGVkIG5v
dywgYWxvbmcgd2l0aCBhbm90aGVyIHNlcmlvdXMgYnVnIHRoYXQgd2FzIGV4
cG9zZWQgYWZ0ZXIgDQpJIGZpeGVkIHRoaXMgb25lLiAgKEkgaGFkIHNvbWUg
Zm9yay9leGVjIHRlc3RzIHRoYXQgd2VyZSBzdWNjZWVkaW5nIGJ5IGFjY2lk
ZW50IA0KYmVjYXVzZSBvZiB0aGUgZHVwbGV4IGJ1Zy4pDQoNCktlbg0K

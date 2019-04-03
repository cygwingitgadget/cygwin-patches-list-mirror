Return-Path: <cygwin-patches-return-9304-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9540 invoked by alias); 3 Apr 2019 12:39:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9530 invoked by uid 89); 3 Apr 2019 12:39:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=hundred
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770128.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.128) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 03 Apr 2019 12:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=MwRTx76uBYUA4iaAKI98UzYy486y+Gu5/pYGwn/skS4=; b=lnv5Qka4Q66j663kJNb/FumX8TRJgU8kKl6iFcjFJ/auaqoQxUs9U/IzW8a0h2S1Ct5TwA/N4IifxlCE5+uOBPT/ZSASRGnuxK5W3ZqQIsFIvMWqNpfs/Db6GzG7lDVDQ33I1cDMnCQ2L0qIqGiDhF5OOtizRC+VJd7IPvdmGrY=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4089.namprd04.prod.outlook.com (20.176.87.154) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.16; Wed, 3 Apr 2019 12:39:34 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019 12:39:34 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Date: Wed, 03 Apr 2019 12:39:00 -0000
Message-ID: <6123dba2-d6d0-f4fe-275f-f63fd3f01994@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu> <20190326083620.GI3471@calimero.vinschen.de> <1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu> <20190326190136.GC4096@calimero.vinschen.de> <20190327133059.GG4096@calimero.vinschen.de> <87k1gi3mle.fsf@Rainer.invalid> <20190328201317.GZ4096@calimero.vinschen.de> <d4cb62f1-5754-aff2-c23d-7ce65f5a5726@cornell.edu> <87o95u5eu0.fsf@Rainer.invalid> <f8b66caf-7673-f92b-ed2e-127b387f1f09@cornell.edu> <87tvfljvaa.fsf@Rainer.invalid> <87a7h7mfo8.fsf@Rainer.invalid>
In-Reply-To: <87a7h7mfo8.fsf@Rainer.invalid>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <1956BED21EDD224881327931C4DA8FCC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00011.txt.bz2

T24gNC8zLzIwMTkgODozMyBBTSwgQWNoaW0gR3JhdHogd3JvdGU6DQo+IEFj
aGltIEdyYXR6IHdyaXRlczoNCj4+IE9LLCBhIGJpdCBtb3JlIGluZm86IFRo
ZSB3aG9sZSB0aGluZyBydW5zIGZyb20gYSBwZXJsIHNjcmlwdCAoYWN0dWFs
bHkgYQ0KPj4gbW9kdWxlKSB0aGF0IG9wZW5zIHBpcGVzIHRvIGdudXBsb3Qg
YW5kIGdob3N0c2NyaXB0LiAgVGhpcyBjb2RlIGlzDQo+PiBfcmVhbGx5XyBv
bGQgYW5kIGhhcyBzZWVuIGEgbG90IG9mIEN5Z3dpbiByZWxlYXNlcywgc28g
aXQgaGFzIG9wdGlvbnMgdG8NCj4+IGVpdGhlciB1c2UgdGVtcG9yYXJ5IGZp
bGVzLCBuYW1lZCBwaXBlcyBha2EgRklGTyBvciBkaXJlY3QgcGlwZXMuICBV
c2luZw0KPj4gdGVtcG9yYXJ5IGZpbGVzIHNlcmlhbGl6ZXMgdGhlIGV4ZWN1
dGlvbiBhbmQgdXNpbmcgYSBwaXBlIGNoYWluIGlzDQo+PiBfcmVhbGx5XyBz
bG93IChsaWtlIGEgaHVuZHJlZCB0aW1lcywgd2hpY2ggaXMgbW9zdGx5IHRp
ZWQgdXAgaW4gc3lzdGVtDQo+PiBmb3IgYSByZWFzb24gdGhhdCBJIGRvbid0
IHVuZGVyc3RhbmQpLCBzbyB1c2luZyBGSUZPIGlzIHRoZSBkZWZhdWx0Lg0K
Pj4gWW91ciBuZXcgRklGTyBjb2RlIGluY3JlYXNlcyB0aGUgc3lzdGVtIHRp
bWUgYnkgYWJvdXQgYSBmYWN0b3Igb2YgMTAgaW4NCj4+IG15IHRlc3RzLCBi
dHcuDQo+IA0KPiBTbyBJJ3ZlIGZpbmFsw7ZseSBnb3QgYXJvdW5kIHRvIGZp
eGluZyB0aGUgcGlwZSBwZXJmb3JtYW5jZSBwcm9ibGVtIGJ5DQo+IGZvb2xp
bmcgdGhlIHByb2dyYW1zIGludm9sdmVkIHRvIHRoaW5rIHRoZXkgYXJlIHVz
aW5nIGZpbGVzOiBoYXZlIHRoZW0NCj4gcmVhZGluZyBmcm9tIC9wcm9jL3Nl
bGYvZmQvMCBhbmQgd3JpdGluZyB0byAvcHJvYy9zZWxmL2ZkLzEgZ2l2ZXMg
bWUgdGhlDQo+IHNhbWUgcGVyZm9ybWFuY2UgYXMgdXNpbmcgYSBuYW1lZCBG
SUZPLg0KPiANCj4gSW5jaWRlbnRhbGx5LCB0aGF0IHdvcmthcm91bmQgc3Rp
bGwgd29ya3Mgd2hlbiBJIHN3aXRjaCB0byB0aGUgMjAxOTA0MDINCj4gc25h
cHNob3QsIHdoaWxlIG5hbWVkIEZJRk8gZmFpbHMgYXMgd2l0aCB0aGUgb2xk
ZXIgc25hcHNob3QgKGFzDQo+IGV4cGVjdGVkKSwgc28gdGhhdCBzZWVtcyB0
byB0YWtlIGEgZGlmZmVyZW50IGNvZGUgcGF0aC4gIE1heWJlIHRoYXQNCj4g
aGVscHMgaW4gZmluZGluZyB0aGUgcHJvYmxlbT8NCg0KVGhhbmtzLg0KDQpJ
biB0aGUgbWVhbnRpbWUsIEkndmUgZml4ZWQgdGhlIHJhd193cml0ZSBidWcg
dGhhdCBJIG1lbnRpb25lZCBpbiBhbiBlYXJsaWVyIA0KcG9zdCwgYWxvbmcg
d2l0aCBzb21lIG90aGVyIGJ1Z3MgSSBmb3VuZC4gIEkgd2FudCB0byBkbyBh
IGxpdHRsZSBtb3JlIHRlc3RpbmcgDQpiZWZvcmUgSSBzZW5kIHRoZSBwYXRj
aGVzLg0KDQpLZW4NCg==

Return-Path: <cygwin-patches-return-9267-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3955 invoked by alias); 28 Mar 2019 22:54:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3934 invoked by uid 89); 28 Mar 2019 22:54:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1348, our
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780090.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 22:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ZrZy0gilrgjOenaD0iELa9JkflKzxot0PRyf7uQjEWA=; b=F44Ta9wcTnyBRhLIOQHy0aZ9yOQf14dUiwBaoEhhYH3Skr0gVdfH2L4h4OrjRE4tURb5j2oTvX1jndtThz0gcLyekYL6WwUltO3LAVz5YrC3+cGDe3ZwN6JmJbi70sECUBEDKkOuLnth+MCHiFU2UWetGsAkn6sPUNYaSBLUjvE=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5817.namprd04.prod.outlook.com (20.179.48.92) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.15; Thu, 28 Mar 2019 22:54:22 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1730.019; Thu, 28 Mar 2019 22:54:22 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Date: Thu, 28 Mar 2019 22:54:00 -0000
Message-ID: <d4cb62f1-5754-aff2-c23d-7ce65f5a5726@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu> <20190326083620.GI3471@calimero.vinschen.de> <1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu> <20190326190136.GC4096@calimero.vinschen.de> <20190327133059.GG4096@calimero.vinschen.de> <87k1gi3mle.fsf@Rainer.invalid> <20190328201317.GZ4096@calimero.vinschen.de>
In-Reply-To: <20190328201317.GZ4096@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <158921C0AAB4D64BA7FAA4A508C5190A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00077.txt.bz2

T24gMy8yOC8yMDE5IDQ6MTMgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IE9uIE1hciAyOCAxOTowMSwgQWNoaW0gR3JhdHogd3JvdGU6DQo+PiBD
b3Jpbm5hIFZpbnNjaGVuIHdyaXRlczoNCj4+PiBEb25lLiAgSSBhbHNvIHB1
c2hlZCBvdXQgbmV3IGRldiBzbmFwc2hvdHMuDQo+Pg0KPj4gTm8gZ29vZCBk
ZWVkIGdvZXMgdW5wdW5pc2hlZOKApg0KPj4NCj4+IFdoaXRoIHRoZSAyMDE5
MDMyNyBzbmFwc2hvdCBvdXIgbWFpbiBkYXRhIHByb2Nlc3NpbmcgYXBwbGlj
YXRpb24gaXMNCj4+IGJyb2tlbi4gIEl0IGxvb2tzIGxpa2UgaXQgc2hvdWxk
IGFsbW9zdCB3b3JrLCBpdCBkb2Vzbid0IGNyYXNoIG9yDQo+PiBhbnl0aGlu
ZywgYnV0IHRoZSBwaXBlIHRoYXQgZGVsaXZlcnMgYSBzY3JpcHQrZGF0YSBp
bnRvIGdudXBsb3Qgc2VlbXMgdG8NCj4+IGVpdGhlciBza2lwIG9yIG92ZXJ3
cml0ZSBkYXRhIGFuZCB0aGVuIGdudXBsb3QgYmFpbHMgd2l0aCBhIHN5bnRh
eA0KPj4gZXJyb3IuICBEZXBlbmRpbmcgb24gZXhhY3RseSB3aGljaCBkYXRh
IEkgdHJ5IHRvIHBsb3QgSSBnZXQgdGhlIGZpcnN0IG9yDQo+PiBmaXJzdCBm
ZXcgcGxvdHMgb3V0IHRocm91Z2ggdGhlIHdob2xlIHByb2Nlc3NpbmcgcGlw
ZSAodGhhdCBlbmRzIGluIGENCj4+IFBERiBmaWxlKSwgYWxiZWl0IHNvbWV0
aW1lcyB3aXRoIGluY29tcGxldGUgZGF0YS4gIERvaW5nIGVhY2ggb2YgdGhl
DQo+PiBzdGVwcyBtYW51YWxseSAoaS5lLiB3cml0aW5nIHRoZSBnbnVwbG90
IHNjcmlwdCBpbnRvIGEgZmlsZSwgdGhlbiBmZWVkDQo+PiB0aGF0IGludG8g
Z251cGxvdCwgdGhlbiB0aGUgb3V0cHV0IGZyb20gZ251cGxvdCBpbnRoIGdo
b3N0c2NyaXB0KSBkb2VzDQo+PiB3b3JrIGNvcnJlY3RseS4gIEkgaGF2ZSBu
b3QgeWV0IGJlZW4gYWJsZSB0byByZWR1Y2UgdGhpcyBkb3duIHRvIHNvbWUN
Cj4+IHNpbXBsZXIgdGVzdCBjYXNlLCBzbyBJIGhhZCB0byByb2xsIGJhY2sg
dG8gdGhlIHByZXZpb3VzIHNuYXBzaG90LiAgSQ0KPj4gc3RpbGwgaGF2ZSBp
dCBpbnN0YWxsZWQgb24gdGhlIGRldmVsb3BtZW50IHN5c3RlbSwgdGhvdWdo
Lg0KPiANCj4gSSdtIHByZXR0eSBzdXJlIEtlbiB3b3VsZCBiZSBoYXBweSBh
Ym91dCBhbiBTVEMuDQoNClllcywgcGxlYXNlLiAgQmFycmluZyB0aGF0LCBp
cyB0aGVyZSBhbnkgY2hhbmNlIEkgY291bGQgc2VlIHRoZSByZWxldmFudCBj
b2RlLCANCm9yIGF0IGxlYXN0IGVub3VnaCBvZiBpdCBzbyB0aGF0IEkgY2Fu
IHNlZSBob3cgRklGT3MgYXJlIGJlaW5nIHVzZWQ/DQoNClRoYW5rcywgYW5k
IHRoYW5rcyBmb3IgdGVzdGluZy4NCg0KS2VuDQo=

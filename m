Return-Path: <cygwin-patches-return-9225-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33196 invoked by alias); 23 Mar 2019 21:10:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33175 invoked by uid 89); 23 Mar 2019 21:10:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Youll, You'll
X-HELO: NAM04-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr700115.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) (40.107.70.115) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 21:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=EjaoAqxYH/pd4P8Bsw969CsgwdFeQpUwOeH16BIX2ko=; b=ctR5tjiXogrvgXESErM3PGaCOM3kloPai3WbkieKZZDej8lYVET5FEQ+E8YlBnY1racrQiBEn4qol16NP9x7RT416tpSEKUTub0lrZB76K82luZ93SJFTjrajbgXcgOwJHIu50VZydJ1lpcOqL3RnSZX7kmp4qZIqzRmEN/dg2Y=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB6252.namprd04.prod.outlook.com (20.178.228.19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.18; Sat, 23 Mar 2019 21:10:48 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1730.017; Sat, 23 Mar 2019 21:10:48 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 0/8] Allow a FIFO to have multiple writers
Date: Sat, 23 Mar 2019 21:10:00 -0000
Message-ID: <cc599da0-246d-149c-cf71-f41f6c3d066e@cornell.edu>
References: <20190322193020.565-1-kbrown@cornell.edu> <20190323200255.GC3471@calimero.vinschen.de>
In-Reply-To: <20190323200255.GC3471@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE90557F84894C4092C648A774F50193@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00035.txt.bz2

T24gMy8yMy8yMDE5IDQ6MDIgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IFlvdXIgcGF0Y2ggc2VyaWVzIGxvb2tzIHJlYWxseSBnb29kLiAgRm9y
IG5vdyBJIHB1c2hlZCBpdCBpbnRvIHRoZQ0KPiB0b3BpYy9maWZvIGJyYW5j
aCBhcyB5b3Ugc3VnZ2VzdGVkLg0KDQpUaGFua3MuDQoNCj4gSnVzdCBiZSBh
d2FyZSB0aGF0IGl0IHdvbid0IGdldCBtdWNoIDNyZCBwYXJ0eSB0ZXN0aW5n
IHRoaXMgd2F5LCBzbyBhcw0KPiBzb29uIGFzIHlvdSBmZWVsIG1vcmUgY29u
ZmlkZW50LCBsZXQncyBtb3ZlIGl0IGludG8gbWFzdGVyLiAgQXQgdGhhdA0K
PiB0aW1lIEknbGwgY3JlYXRlIGEgQ3lnd2luIDMuMC55IGJyYW5jaCBmb3Ig
YnVnZml4IHJlbGVhc2VzLCBidXQgdGhlDQo+IHNuYXBzaG90cyB3aWxsIGNv
bnRpbnVlIHRvIGJlIGNyZWF0ZWQgZnJvbSBtYXN0ZXIgc28gd2UgZ2V0IGF0
IGxlYXN0DQo+ICpzb21lKiBmb2xrcyB0ZXN0aW5nIGl0Lg0KDQpTb3VuZHMg
Z29vZC4gIEl0IHNob3VsZG4ndCBiZSB0b28gbG9uZy4NCg0KPiBBIGJpZyB0
aGFuayB5b3UgYWxyZWFkeSENCj4gDQo+IE9oLCB0aGVyZSdzIG9idmlvdXNs
eSBhIGRvd25zaWRlIHRvIHRoaXMsIHRvbzogIFlvdSdsbCBoYXZlIHRvIGNy
ZWF0ZQ0KPiBhIHJlbGVhc2Ugbm90ZSBmb3IgdGhpcyBjaGFuZ2UgYXQgb25l
IHBvaW50IDspDQoNCk9oIHllYWgsIEkgZm9yZ290IGFib3V0IHRoYXQuICBO
byBwcm9ibGVtLg0KDQpLZW4NCg==

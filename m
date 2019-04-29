Return-Path: <cygwin-patches-return-9387-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8243 invoked by alias); 29 Apr 2019 18:29:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8193 invoked by uid 89); 29 Apr 2019 18:29:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=brown, Brown, third, month
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820139.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Apr 2019 18:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=XipCE9X1Gh7hFfl2stUAAt95hRrAT17BpHFKjGxxxcs=; b=m30SUbZSlwowx8sKiwq3+GhKb1iK7uq7BnCA1ME/8Pq2uhORovwyb34v5in8f5/rzEFZBl+2tt2uiq/ppSpXB8TTvFJ5mtZGqioe+oMLlniz65qDFOdIUsYU5jE45Pwe+bXYKGlN5Dlj+TpUijEJquePoGzwK9yUdJ7oHqIU2zQ=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5324.namprd04.prod.outlook.com (20.178.26.81) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.12; Mon, 29 Apr 2019 18:29:55 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1835.010; Mon, 29 Apr 2019 18:29:55 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Date: Mon, 29 Apr 2019 18:29:00 -0000
Message-ID: <6fbdf204-4be5-24b8-1df3-aa5d6589619b@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu>
In-Reply-To: <20190325230556.2219-1-kbrown@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:4714;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <742841F4D4575A42845686FFCBFC84FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00094.txt.bz2

T24gMy8yNS8yMDE5IDc6MDYgUE0sIEtlbiBCcm93biB3cm90ZToNCj4gVGhl
IHNlY29uZCBwYXRjaCBpbiB0aGlzIHNlcmllcyBlbmFibGVzIG9wZW5pbmcg
YSBGSUZPIHdpdGggT19SRFdSDQo+IGFjY2Vzcy4gIFRoZSB1bmRlcmx5aW5n
IFdpbmRvd3MgbmFtZWQgcGlwZSBpcyBjcmVhdGVkIHdpdGggZHVwbGV4DQo+
IGFjY2VzcywgYW5kIGl0cyBoYW5kbGUgaXMgbWFkZSB0aGUgSS9PIGhhbmRs
ZSBvZiB0aGUgZmlyc3QgY2xpZW50Lg0KPiANCj4gSSB0ZXN0ZWQgdGhlIHBh
dGNoIGluIHR3byB3YXlzLg0KPiANCj4gRmlyc3QsDQoNClsuLi5dDQoNCj4g
VGhlIHNlY29uZCB0ZXN0IHdhcyB0aGUgZm9sbG93aW5nIHNlcXVlbmNlIG9m
IGNvbW1hbmRzIGluIGEgYmFzaA0KPiBzaGVsbDoNCj4gDQo+ICQgbWtmaWZv
IGZvbw0KPiANCj4gJCBleGVjIDc8PmZvbw0KPiANCj4gJCBlY2hvIGJsYWgg
PiBmb28NCj4gDQo+ICQgcmVhZCBiYXIgPCY3DQo+IA0KPiAkIGVjaG8gJGJh
cg0KPiBibGFoDQoNCkkganVzdCByZWFsaXplZCB0aGF0IHRoaXMgZG9lc24n
dCB0ZXN0ICp3cml0aW5nKiB0byB0aGUgZmQgb2YgYSBGSUZPIG9wZW5lZCB3
aXRoIA0KT19SRFdSLiAgSWYgSSBjaGFuZ2UgdGhlIHRoaXJkIGNvbW1hbmQg
dG8gImVjaG8gYmxhaCA+JjciLCBpdCBkb2VzIHRlc3QgdGhpcywgDQphbmQg
dGhlIHdyaXRlIGZhaWxzIHdpdGggRUNPTU0uICBJdCB0dXJucyBvdXQgdGhh
dCB0aGUgY2FsbCB0byBOdFdyaXRlRmlsZSBpbiANCmZoYW5kbGVyX2ZpZm86
OnJhd193cml0ZSBmYWlscyB3aXRoIFNUQVRVU19QSVBFX0xJU1RFTklORy4N
Cg0KQ29yaW5uYSwgSSdsbCB0cnkgdG8gZGVidWcgdGhpcywgYnV0IHNpbmNl
IEkga25vdyB5b3UncmUgYWJvdXQgdG8gYmUgQUZLIGZvciBhIA0KbW9udGgs
IEkgdGhvdWdodCBJJ2QgY2hlY2sgdG8gc2VlIGlmIHlvdSBoYXZlIGFueSBp
ZGVhIHdoeSB0aGlzIHdvdWxkIGhhcHBlbi4NCg0KVGhlIFdpbmRvd3MgbmFt
ZWQgcGlwZSB0aGF0IHdlJ3JlIHdyaXRpbmcgdG8gd2FzIGNyZWF0ZWQgYnkg
YSBjYWxsIHRvIA0KTnRDcmVhdGVOYW1lZFBpcGVGaWxlIHdpdGggYWNjZXNz
ID0gR0VORVJJQ19SRUFEIHxHRU5FUklDX1dSSVRFIHwgDQpGSUxFX1JFQURf
QVRUUklCVVRFUyB8IEZJTEVfV1JJVEVfQVRUUklCVVRFUyB8IFNZTkNIUk9O
SVpFLCBhbmQgaXQgd2FzIHB1dCBpbiANCm5vbmJsb2NraW5nIG1vZGUgYnkg
YSBjYWxsIHRvIE50U2V0SW5mb3JtYXRpb25GaWxlIHdpdGggZnBpLkNvbXBs
ZXRpb25Nb2RlID0gDQpGSUxFX1BJUEVfQ09NUExFVEVfT1BFUkFUSU9OLg0K
DQpUaGFua3MgZm9yIGFueSBzdWdnZXN0aW9ucy4NCg0KS2VuDQo=

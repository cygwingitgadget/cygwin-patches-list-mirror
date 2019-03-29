Return-Path: <cygwin-patches-return-9272-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53861 invoked by alias); 29 Mar 2019 18:05:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53845 invoked by uid 89); 29 Mar 2019 18:05:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=explain
X-HELO: NAM03-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr800107.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) (40.107.80.107) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 29 Mar 2019 18:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=gblqHpDu6QIkFzu3/WJbHbnPRb4onEIaPfchRD/jYAQ=; b=JgGCAZ3vD7xsr8gnR8a3DfsOv479ibT70ndqVevD7BVhJ88tVM9ocwv3T+4K+0QN2g1R6ujYQ+UCuo+WaUcSxcWnKBojzLtxUKcIdtPE2i2ClM4V3KxbJ46CdFPwBRrzmI6lAg9AqV9oApY43x71EoAd+N8HM8orK+KV3zT/4sY=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4154.namprd04.prod.outlook.com (20.176.76.31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.17; Fri, 29 Mar 2019 18:05:18 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019 18:05:18 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Date: Fri, 29 Mar 2019 18:05:00 -0000
Message-ID: <f8b66caf-7673-f92b-ed2e-127b387f1f09@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu> <20190326083620.GI3471@calimero.vinschen.de> <1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu> <20190326190136.GC4096@calimero.vinschen.de> <20190327133059.GG4096@calimero.vinschen.de> <87k1gi3mle.fsf@Rainer.invalid> <20190328201317.GZ4096@calimero.vinschen.de> <d4cb62f1-5754-aff2-c23d-7ce65f5a5726@cornell.edu> <87o95u5eu0.fsf@Rainer.invalid>
In-Reply-To: <87o95u5eu0.fsf@Rainer.invalid>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <29462332268BF74EBDABCE4134CF2EDE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00082.txt.bz2

T24gMy8yOS8yMDE5IDM6MTcgQU0sIEFjaGltIEdyYXR6IHdyb3RlOg0KPiBL
ZW4gQnJvd24gd3JpdGVzOg0KPj4+IEknbSBwcmV0dHkgc3VyZSBLZW4gd291
bGQgYmUgaGFwcHkgYWJvdXQgYW4gU1RDLg0KPj4NCj4+IFllcywgcGxlYXNl
LiAgQmFycmluZyB0aGF0LCBpcyB0aGVyZSBhbnkgY2hhbmNlIEkgY291bGQg
c2VlIHRoZSByZWxldmFudCBjb2RlLA0KPj4gb3IgYXQgbGVhc3QgZW5vdWdo
IG9mIGl0IHNvIHRoYXQgSSBjYW4gc2VlIGhvdyBGSUZPcyBhcmUgYmVpbmcg
dXNlZD8NCj4gDQo+IFdlbGwsIEknbSB0cnlpbmcgLS0gYnV0IGdvdCBub3Ro
aW5nIHNvIGZhci4gIEFzIHRoZSBpbmRpdmlkdWFsIEZJRk8gc2VlbQ0KPiB0
byB3b3JrIGFuZCB0aGUgZXJyb3IgaGFwcGVucyBwcmV0dHkgZWFybHksIEkg
dGhpbmsgaXQgaGFzIHNvbWV0aGluZyB0bw0KPiBkbyB3aXRoIGVpdGhlciBz
d2l0Y2hpbmcgYmV0d2VlbiBkaWZmZXJlbnQgRklGTyAod2hpY2ggdGhlIG9y
aWdpbmFsIGNvZGUNCj4gZG9lcykgb3Igc29tZSByYWNlIGJldHdlZW4gZmls
bCBhbmQgZHJhaW4sIHBvc3NpYmx5IGFyb3VuZCBhIGJ1ZmZlcg0KPiBib3Vu
ZGFyeSAoaW4gbXkgbGltaXRlZCB0ZXN0aW5nIGl0IGFsd2F5cyBzZWVtZWQg
dG8gaGFwcGVuIGluIHRoZSBzYW1lDQo+IHBsYWNlIGZvciB0aGUgc2FtZSBk
YXRhKS4NCg0KSSBmb3VuZCBhIGJ1ZyBpbiBteSBmaGFuZGxlcl9maWZvOjpy
YXdfd3JpdGUgY29kZSB0aGF0IGNvdWxkIGV4cGxhaW4gdGhlIA0KcHJvYmxl
bS4gIFRoZSBjYWxsIHRvIE50V3JpdGVGaWxlIGluIHRoYXQgZnVuY3Rpb24g
YWx3YXlzIHJldHVybnMgaW1tZWRpYXRlbHkgDQpiZWNhdXNlIHRoZSBXaW5k
b3dzIG5hbWVkIHBpcGUgdW5kZXJseWluZyB0aGUgRklGTyBpcyBub24tYmxv
Y2tpbmcuICBJZiBpdCBjYW4ndCANCndyaXRlIGJlY2F1c2UgdGhlIHBpcGUg
YnVmZmVyIGlzIGZ1bGwsIHJhd193cml0ZSByZXR1cm5zIC0xIHdpdGggZXJy
b3IgRUFHQUlOLiANClRoYXQncyB3cm9uZyBpZiB0aGUgRklGTyB3YXMgb3Bl
bmVkIGluIGJsb2NraW5nIG1vZGUuDQoNCkknbGwgaGF2ZSB0byB0aGluayBh
Ym91dCBob3cgdG8gYmVzdCBoYW5kbGUgdGhpcy4gIEkgdGhpbmsgSSBtaWdo
dCBiZSBhYmxlIHRvIA0KaW1pdGF0ZSB3aGF0J3MgZG9uZSBpbiBmaGFuZGxl
cl9zb2NrZXRfdW5peDo6c2VuZG1zZyBpbiB0aGUgdG9waWMvYWZfdW5peCBi
cmFuY2guDQoNCktlbg0K

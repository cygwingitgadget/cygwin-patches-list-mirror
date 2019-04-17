Return-Path: <cygwin-patches-return-9357-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 69845 invoked by alias); 17 Apr 2019 17:43:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 69822 invoked by uid 89); 17 Apr 2019 17:43:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.4 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=succeeds, our
X-HELO: NAM03-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr800110.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) (40.107.80.110) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Apr 2019 17:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=EFw7UFl0rRz4BWCSOkPmnu4OtO/c2lohQXz1az0t0v4=; b=OCr5VuiDxeW7qrtjEDJ1RotOtJoEFh8tu+6EWLeH7wFwRmrDh40c2VlW7lKqvWFosV+GAtA8tK6BiylFv3VBlcEym11oFyufcZD9ZhPxNkNX0teYe4vrEHDNn+eBJf9mh3BplbOeZoAnaD690uIFZxfsjBKphU2NyDCsyu9Calk=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4250.namprd04.prod.outlook.com (20.176.76.159) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.12; Wed, 17 Apr 2019 17:43:34 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.021; Wed, 17 Apr 2019 17:43:34 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 00/14] FIFO bug fixes and code simplifications
Date: Wed, 17 Apr 2019 17:43:00 -0000
Message-ID: <f477bb3d-1918-3b25-9682-a3b187a12dc2@cornell.edu>
References: <20190414191543.3218-1-kbrown@cornell.edu> <20190416112243.GR3599@calimero.vinschen.de> <87o95435qo.fsf@Rainer.invalid>
In-Reply-To: <87o95435qo.fsf@Rainer.invalid>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAEC1D7E886C1C44AAECA7AA9E03AB50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00064.txt.bz2

T24gNC8xNy8yMDE5IDE6MjMgUE0sIEFjaGltIEdyYXR6IHdyb3RlOg0KPiBD
b3Jpbm5hIFZpbnNjaGVuIHdyaXRlczoNCj4+IFB1c2hlZCB3aXRoIHYyIG9m
IHBhdGNoIDEzLiAgRGV2ZWxvcGVyIHNuYXBzIHNob3VsZCBiZSB1cCBzaG9y
dGx5Lg0KPiANCj4gSSBnYXZlIHRoZSBzbmFwc2hvdCBzb21lIHRlc3Rpbmcg
dG9kYXkuDQo+IA0KPiBUaGUgZ29vZCBuZXdzIGlzIHRoYXQgdGhlIG5hbWVk
IEZJRk8gYnJhbmNoIG9mIG91ciBjb2RlIHdvcmtzIGNvcnJlY3RseQ0KPiBh
Z2FpbiBhbmQgaXMgZmFzdGVyIHRoYW4gZ29pbmcgdGhyb3VnaCBwc2V1ZG8t
ZmlsZSBTVERJTyBwaXBlcy4NCj4gDQo+IFRoZSBiYWQgbmV3cyBpcyB0aGF0
IHRoZXJlIGlzIHN0aWxsIHNvbWUgcHJvYmxlbSB0aGF0IHNlZW1zIHRvIGhp
dCB3aGlsZQ0KPiBmb3JraW5nLiAgSSd2ZSBnb3QgYW4gZW1wdHkgc3RhY2tk
dW1wIGZpbGUgZnJvbSBzaCAod2hpY2ggZ2V0cyB1c2VkIHdoZW4NCj4gZXhl
YydpbmcgZHVlIHRvIHRoZSB3YXkgcGVybCBpbXBsZW1lbnRzIHRoYXQpIGEg
ZmV3IHRpbWVzIGFuZCBhbHNvIG9uZQ0KPiBlcnJvciBtZXNzYWdlIGFib3V0
IGEgdGVybWluYXRlZCB0aHJlYWQgZHVlIHRvICJXaW5kb3dzIFdGU08gZXJy
b3IgNiINCj4gKGhpbGFyaW91c2x5IHRoZSBvdXRwdXQgZmlsZSB3YXMgcHJv
ZHVjZWQgY29ycmVjdGx5IGluIHRoYXQgY2FzZSkuICBCdXQNCj4gbW9zdCBv
ZiB0aGUgdGltZSB0aGUgcHJvY2Vzc2VzIGluIG15IGRhdGEgcGlwZWxpbmUg
d291bGQgYWxsIGhhdmUgZXhlY2VkDQo+IGNvcnJlY3RseSwgYnV0IHRoZW4g
bm9uZSBvZiB0aGVtIGV2ZXIgZ2V0cyBydW5uYWJsZSBhZ2Fpbi4gIFNvIHRo
aXMNCj4gc2VlbXMgdG8gYmUgc29tZXRoaW5nIG9mIGEgcmFjZSBhcm91bmQg
dGhlIGV4ZWMuICBJZiBJIGtpbGwgdGhlIHN0YWxsZWQNCj4gcHJvY2Vzc2Vz
IGFuZCBzdGFydCB0aGUgc2FtZSBjb21tYW5kcyBhZ2FpbiwgdGhlbiBldmVy
eXRoaW5nIHdvcmtzIGFzIGl0DQo+IHNob3VsZCBtb3N0IG9mIHRoZSB0aW1l
Lg0KDQpUaGFua3MgZm9yIHRlc3RpbmcuICBJIGhhdmUgU1RDcyBmb3IgZm9y
ayBhbmQgZXhlYyB0aGF0IEkgdXNlZCB3aGVuIGZpcnN0IA0Kd3JpdGluZyB0
aGUgY29kZSwgYW5kIEkgZm9yZ290IHRvIHJldGVzdCB0aG9zZSBhZnRlciB0
aGUgcmVjZW50IGNoYW5nZXMuICBJIGp1c3QgDQp0cmllZCwgYW5kIHRoZSBm
b3JrIHRlc3Qgc3VjY2VlZHMgYnV0IHRoZSBleGVjIHRlc3QgZmFpbHMuICBJ
J2xsIHRyeSB0byBkZWJ1ZyB0aGF0Lg0KDQpLZW4NCg==

Return-Path: <cygwin-patches-return-9360-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107126 invoked by alias); 18 Apr 2019 15:43:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107097 invoked by uid 89); 18 Apr 2019 15:43:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.2 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730093.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Apr 2019 15:43:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=yGLgqgswFDxL4L8YZ/T0S30vtMCpui60HstyZl1J90o=; b=CNbLS9lEGCOeEvXQsVCzDRxtBA6GVEdM84U4QxMmKyoj7s2hveQd8x6UZIvokmK9bDdSWuDYUqZg8PS9yQUpBeNERDyw8KyBSTwuOeCz2VVPhhyiHZKN+0Ul73beIGylajQy/eo5fT35EKioMjJumxcWct40lsGQtZG4BcO80Wk=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5579.namprd04.prod.outlook.com (20.178.225.76) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.12; Thu, 18 Apr 2019 15:43:52 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019 15:43:52 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 00/14] FIFO bug fixes and code simplifications
Date: Thu, 18 Apr 2019 15:43:00 -0000
Message-ID: <0e2c6674-af17-a6e9-54e3-1ec374712832@cornell.edu>
References: <20190414191543.3218-1-kbrown@cornell.edu> <20190416112243.GR3599@calimero.vinschen.de> <87o95435qo.fsf@Rainer.invalid> <f477bb3d-1918-3b25-9682-a3b187a12dc2@cornell.edu> <87h8awa278.fsf@Rainer.invalid>
In-Reply-To: <87h8awa278.fsf@Rainer.invalid>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <218F1AB45EA23F4F8229527CC3D4CD79@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00067.txt.bz2

T24gNC8xNy8yMDE5IDI6NTggUE0sIEFjaGltIEdyYXR6IHdyb3RlOg0KPiBL
ZW4gQnJvd24gd3JpdGVzOg0KPj4gVGhhbmtzIGZvciB0ZXN0aW5nLiAgSSBo
YXZlIFNUQ3MgZm9yIGZvcmsgYW5kIGV4ZWMgdGhhdCBJIHVzZWQgd2hlbiBm
aXJzdA0KPj4gd3JpdGluZyB0aGUgY29kZSwgYW5kIEkgZm9yZ290IHRvIHJl
dGVzdCB0aG9zZSBhZnRlciB0aGUgcmVjZW50IGNoYW5nZXMuICBJIGp1c3QN
Cj4+IHRyaWVkLCBhbmQgdGhlIGZvcmsgdGVzdCBzdWNjZWVkcyBidXQgdGhl
IGV4ZWMgdGVzdCBmYWlscy4gIEknbGwgdHJ5IHRvIGRlYnVnIHRoYXQuDQo+
IA0KPiBUYWtlIHlvdXIgdGltZSBhbmQgdGhhbmtzIGZvciB3b3JraW5nIGlu
IHRoYXQgYXJlYS4NCg0KSSd2ZSBqdXN0IHNlbnQgYW4gYXR0ZW1wdGVkIGZp
eC4gIFRoZXJlIG1heSBzdGlsbCBiZSBtb3JlIGNoYW5nZXMgbmVlZGVkOyBJ
IGp1c3QgDQptYWRlIGEgbWluaW1hbCBjaGFuZ2UgdG8gbWFrZSBteSBTVEMg
c3VjY2VlZC4NCg0KS2VuDQo=

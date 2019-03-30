Return-Path: <cygwin-patches-return-9278-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88113 invoked by alias); 30 Mar 2019 14:37:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88090 invoked by uid 89); 30 Mar 2019 14:37:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=2017-03, 201703
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770133.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 30 Mar 2019 14:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=0hwo0GGxK34GP0MYzwRjXnIv1mestn1BywdEHSvp/jc=; b=K1B0xbOZTBCakv9S2rywUH8/yqDdw1nHIe+P95S9nwkycklA45RIW5G4xJK94peXqU2hA4uN4fImKee8ed2EDwGkdICVL45z/TQtcvZ2OdPY3Isfj+M1J9J7bOqLtQbfYlG3YnqgS3UW9BWUgmb5R0Cw5sSop4QSip+Kf6hiiFA=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB6187.namprd04.prod.outlook.com (20.178.227.27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.17; Sat, 30 Mar 2019 14:36:58 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1750.017; Sat, 30 Mar 2019 14:36:58 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 2/2] Cygwin: FIFO: add support for the duplex case
Date: Sat, 30 Mar 2019 14:37:00 -0000
Message-ID: <566ee07d-25d6-ee77-38e0-55ef02ba4241@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu> <20190325230556.2219-3-kbrown@cornell.edu> <20190330223059.443ad27b2c59de6372ff1eb8@nifty.ne.jp>
In-Reply-To: <20190330223059.443ad27b2c59de6372ff1eb8@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <C23264ADA1E5F14399F84E98FECCD9C6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00088.txt.bz2

SGkgVGFrYXNoaSwNCg0KT24gMy8zMC8yMDE5IDk6MzAgQU0sIFRha2FzaGkg
WWFubyB3cm90ZToNCj4gSGkgS2VuLA0KPiANCj4gRG8gdGhlc2UgcGF0Y2hl
cyBlbmFibGUgdG8gb3BlbiBGSUZPIG11bHRpcGxlIHRpbWVzIHdpdGggT19S
RFdSPw0KPiBtYyAobWlkbmlnaHQgY29tbWFuZGVyKSB0cmllcyB0byBvcGVu
IEZJRk8gdHdpY2Ugd2l0aCBPX1JEV1IgaWYNCj4gU0hFTEw9L2Jpbi90Y3No
LCBidXQgZmFpbHMuDQo+IGh0dHBzOi8vY3lnd2luLmNvbS9tbC9jeWd3aW4v
MjAxNy0wMy9tc2cwMDE4OC5odG1sDQoNCk5vLCBJJ20gc29ycnkuICBBdCB0
aGUgbW9tZW50LCBhIEZJRk8gY2FuIG9ubHkgYmUgb3BlbmVkIG9uY2UgZm9y
IHJlYWRpbmcuICBJIA0KcGxhbiB0byB3b3JrIG9uIHRoaXMgbmV4dCwgYnV0
IGZpcnN0IEkgaGF2ZSBzb21lIGJ1Z3MgdG8gZml4Lg0KDQpLZW4NCg==

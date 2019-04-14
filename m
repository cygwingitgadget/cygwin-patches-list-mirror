Return-Path: <cygwin-patches-return-9346-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130297 invoked by alias); 14 Apr 2019 19:16:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130189 invoked by uid 89); 14 Apr 2019 19:16:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-21.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730131.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 14 Apr 2019 19:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=jIwunm84PN0D90WbcegZQCOot0qsmc0ngmHhRFEOs3U=; b=D3hjQ0CyUPflH6o25Ufia98yt78ezMgFk/bedoaieRdwplr5g38OoOvxuocjsMFxrykw/gN3JfV2v5sPlmZXCEOn9PxaVeA5KDac3+2YI6bapJQ6NK6aPIyYKprtZZJ7r3UjIR/TcZYE4C4Y435zh5PSQ16RKgHcaOGKZExQ5hk=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3963.namprd04.prod.outlook.com (20.176.87.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Sun, 14 Apr 2019 19:16:00 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019 19:16:00 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 08/14] Cygwin: FIFO: fix fifo_client_handler::close
Date: Sun, 14 Apr 2019 19:16:00 -0000
Message-ID: <20190414191543.3218-9-kbrown@cornell.edu>
References: <20190414191543.3218-1-kbrown@cornell.edu>
In-Reply-To: <20190414191543.3218-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00057.txt.bz2

TWFrZSBzdXJlIHRoYXQgZmhhbmRsZXJfYmFzZTo6Y2xvc2UgcmF0aGVyIHRo
YW4gZmhhbmRsZXJfZmlmbzo6Y2xvc2UNCmlzIGNhbGxlZCBvbiB0aGUgZmhh
bmRsZXIuICBBbHNvLCBkZWxldGUgdGhlIGZoYW5kbGVyLCBzaW5jZSB3ZQ0K
YWxsb2NhdGVkIGl0Lg0KLS0tDQogd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9m
aWZvLmNjIHwgNSArKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXJfZmlmby5jYyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRs
ZXJfZmlmby5jYw0KaW5kZXggMmRhNTc5Yjk1Li5mOTc5NmYzMDAgMTAwNjQ0
DQotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MNCisrKyBi
L3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlmby5jYw0KQEAgLTgwOSw3ICs4
MDksMTAgQEAgZmlmb19jbGllbnRfaGFuZGxlcjo6Y2xvc2UgKCkNCiAgIGlu
dCByZXMgPSAwOw0KIA0KICAgaWYgKGZoKQ0KLSAgICByZXMgPSBmaC0+Y2xv
c2UgKCk7DQorICAgIHsNCisgICAgICByZXMgPSBmaC0+ZmhhbmRsZXJfYmFz
ZTo6Y2xvc2UgKCk7DQorICAgICAgZGVsZXRlIGZoOw0KKyAgICB9DQogICBp
ZiAoY29ubmVjdF9ldnQpDQogICAgIENsb3NlSGFuZGxlIChjb25uZWN0X2V2
dCk7DQogICBpZiAoZHVtbXlfZXZ0KQ0KLS0gDQoyLjE3LjANCg0K

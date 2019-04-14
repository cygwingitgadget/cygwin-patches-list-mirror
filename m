Return-Path: <cygwin-patches-return-9342-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129554 invoked by alias); 14 Apr 2019 19:16:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129501 invoked by uid 89); 14 Apr 2019 19:16:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:592
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730131.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 14 Apr 2019 19:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=6vSwTW1Q/tkqeUvkUEWXT1cT4kEki8Af1QzVqxd4Q5I=; b=mRrLSLHgoPwKeVCLmWZrvWzkYQsq+juNjMwph4RjYw6eHZCLUChDKBKSav2f5CD25htX5jiORv8kkZP6chLTSBtBiYnX2xpWbtI0RFflKvJQ0Up6j/uB4StFEv1CeVoVTxNcMzU0nLUmcjyTMrOj/Qzeyer852C1X3pgomJ2Wrc=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3963.namprd04.prod.outlook.com (20.176.87.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Sun, 14 Apr 2019 19:15:58 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019 19:15:58 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 04/14] Cygwin: FIFO: fix a thinko in listen_client_thread
Date: Sun, 14 Apr 2019 19:16:00 -0000
Message-ID: <20190414191543.3218-5-kbrown@cornell.edu>
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
X-SW-Source: 2019-q2/txt/msg00048.txt.bz2

LS0tDQogd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjIHwgNSArKysr
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJf
Zmlmby5jYyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlmby5jYw0KaW5k
ZXggMjU4YzNjZjhhLi43NjQ0MjBmZmQgMTAwNjQ0DQotLS0gYS93aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MNCisrKyBiL3dpbnN1cC9jeWd3aW4v
ZmhhbmRsZXJfZmlmby5jYw0KQEAgLTM2Miw3ICszNjIsMTAgQEAgZmhhbmRs
ZXJfZmlmbzo6bGlzdGVuX2NsaWVudF90aHJlYWQgKCkNCiAJCWZpZm9fY2xp
ZW50X3VubG9jayAoKTsNCiAJCWdvdG8gZXJyb3V0Ow0KIAkgICAgICB9DQot
CSAgICAvKiBGYWxsIHRocm91Z2guICovDQorCSAgICBlbHNlDQorCSAgICAg
IC8qIFJlY2hlY2sgZmNfaGFuZGxlcltpXS5zdGF0ZS4gKi8NCisJICAgICAg
aS0tOw0KKwkgICAgYnJlYWs7DQogCSAgY2FzZSBmY19jb25uZWN0ZWQ6DQog
CSAgICB3W2ldID0gZmNfaGFuZGxlcltpXS5kdW1teV9ldnQ7DQogCSAgICBi
cmVhazsNCi0tIA0KMi4xNy4wDQoNCg==

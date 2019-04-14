Return-Path: <cygwin-patches-return-9344-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129931 invoked by alias); 14 Apr 2019 19:16:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129826 invoked by uid 89); 14 Apr 2019 19:16:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=retry
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730131.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 14 Apr 2019 19:16:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=9RQ0dRrWObYanwTyBbhcOYr0c7yzya58pk5eawh4MVs=; b=IpcEaxpSTaQekH4cNXgykLoMxyAuwkTVEqLi6JY/mOmc0nKsEiv7kUAp0VMo+/BeyjFn4osaKCnHsNN75V1twM1bXE42Ait7TB6E2FLcBjH0aX4smSzi8r3JobiQpCjJdWYaxnzssPF37Su9pChbkjq3kfb6OX36mpRsD4sxJj4=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3963.namprd04.prod.outlook.com (20.176.87.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Sun, 14 Apr 2019 19:15:59 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019 19:15:59 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 06/14] Cygwin: check for STATUS_PENDING in fhandler_base::raw_read
Date: Sun, 14 Apr 2019 19:16:00 -0000
Message-ID: <20190414191543.3218-7-kbrown@cornell.edu>
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
X-SW-Source: 2019-q2/txt/msg00056.txt.bz2

SWYgTnRSZWFkRmlsZSByZXR1cm5zIFNUQVRVU19QRU5ESU5HLCB3YWl0IGZv
ciB0aGUgcmVhZCB0byBjb21wbGV0ZS4NClRoaXMgY2FuIGhhcHBlbiwgZm9y
IGluc3RhbmNlLCBpbiB0aGUgY2FzZSBvZiBhIEZJRk8gb3BlbmVkIHdpdGgN
Ck9fUkRSVy4NCi0tLQ0KIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXIuY2MgfCAx
NCArKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci5j
Yw0KaW5kZXggYjBjOWM1MGMzLi5hMGMzZGNjZTIgMTAwNjQ0DQotLS0gYS93
aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmNjDQorKysgYi93aW5zdXAvY3lnd2lu
L2ZoYW5kbGVyLmNjDQpAQCAtMjE1LDExICsyMTUsMjMgQEAgZmhhbmRsZXJf
YmFzZTo6cmF3X3JlYWQgKHZvaWQgKnB0ciwgc2l6ZV90JiBsZW4pDQogICBO
VFNUQVRVUyBzdGF0dXM7DQogICBJT19TVEFUVVNfQkxPQ0sgaW87DQogICBp
bnQgdHJ5X25vcmVzZXJ2ZSA9IDE7DQorICBEV09SRCB3YWl0cmV0ID0gV0FJ
VF9PQkpFQ1RfMDsNCiANCiByZXRyeToNCiAgIHN0YXR1cyA9IE50UmVhZEZp
bGUgKGdldF9oYW5kbGUgKCksIE5VTEwsIE5VTEwsIE5VTEwsICZpbywgcHRy
LCBsZW4sDQogCQkgICAgICAgTlVMTCwgTlVMTCk7DQotICBpZiAoTlRfU1VD
Q0VTUyAoc3RhdHVzKSkNCisgIGlmIChzdGF0dXMgPT0gU1RBVFVTX1BFTkRJ
TkcpDQorICAgIHsNCisgICAgICB3YWl0cmV0ID0gY3lnd2FpdCAoZ2V0X2hh
bmRsZSAoKSwgY3dfaW5maW5pdGUsDQorCQkJIGN3X2NhbmNlbCB8IGN3X3Np
Z19laW50cik7DQorICAgICAgaWYgKHdhaXRyZXQgPT0gV0FJVF9PQkpFQ1Rf
MCkNCisJc3RhdHVzID0gaW8uU3RhdHVzOw0KKyAgICB9DQorICBpZiAod2Fp
dHJldCA9PSBXQUlUX0NBTkNFTEVEKQ0KKyAgICBwdGhyZWFkOjpzdGF0aWNf
Y2FuY2VsX3NlbGYgKCk7DQorICBlbHNlIGlmICh3YWl0cmV0ID09IFdBSVRf
U0lHTkFMRUQpDQorICAgIHNldF9lcnJubyAoRUlOVFIpOw0KKyAgZWxzZSBp
ZiAoTlRfU1VDQ0VTUyAoc3RhdHVzKSkNCiAgICAgbGVuID0gaW8uSW5mb3Jt
YXRpb247DQogICBlbHNlDQogICAgIHsNCi0tIA0KMi4xNy4wDQoNCg==

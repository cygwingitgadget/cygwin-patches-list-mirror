Return-Path: <cygwin-patches-return-9339-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128955 invoked by alias); 14 Apr 2019 19:16:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128885 invoked by uid 89); 14 Apr 2019 19:16:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=retry
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730131.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 14 Apr 2019 19:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=E7J2A205l+lCL0VloPcMixnHnry7z4QkfIQ3VLa5ILE=; b=a9LA7qAG9SQ+vSmwmvW3XHaOq5qeDOZK/YHq+VUMZLsj5r/CXyUqaUNYbMgrTnc8wurDPOKBKSk8918oM4CbfaJVdpYfnavahLy17TicRIk/FPAkcDWaAs8EqukUc/+LBZNSektZKDQ5yLvWzHLNQCLJeeELBLpQm3/q4m82soU=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3963.namprd04.prod.outlook.com (20.176.87.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Sun, 14 Apr 2019 19:15:56 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019 19:15:56 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 02/14] Cygwin: FIFO: hit_eof: add a call to fifo_client_lock
Date: Sun, 14 Apr 2019 19:16:00 -0000
Message-ID: <20190414191543.3218-3-kbrown@cornell.edu>
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
X-SW-Source: 2019-q2/txt/msg00046.txt.bz2

VGhlIHNlY29uZCBjaGVjayBvZiBuY29ubmVjdGVkIG5lZWRzIHRvIGJlIHBy
b3RlY3RlZCBieSBhIGxvY2sgYXMgd2VsbA0KYXMgdGhlIGZpcnN0Lg0KLS0t
DQogd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjIHwgMjEgKysrKysr
KysrKysrKy0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MgYi93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX2ZpZm8uY2MNCmluZGV4IDkwMTY5NjQ0NC4uNzA1NTFlYmFjIDEwMDY0
NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQorKysg
Yi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MNCkBAIC03MDUsMTUg
KzcwNSwyMCBAQCBmaGFuZGxlcl9maWZvOjpyYXdfd3JpdGUgKGNvbnN0IHZv
aWQgKnB0ciwgc2l6ZV90IGxlbikNCiBib29sDQogZmhhbmRsZXJfZmlmbzo6
aGl0X2VvZiAoKQ0KIHsNCi0gIGZpZm9fY2xpZW50X2xvY2sgKCk7DQotICBi
b29sIGVvZiA9IChuY29ubmVjdGVkID09IDApOw0KLSAgZmlmb19jbGllbnRf
dW5sb2NrICgpOw0KLSAgaWYgKGVvZikNCi0gICAgew0KLSAgICAgIC8qIEdp
dmUgdGhlIGxpc3Rlbl9jbGllbnQgdGhyZWFkIHRpbWUgdG8gY2F0Y2ggdXAs
IHRoZW4gcmVjaGVjay4gKi8NCi0gICAgICBTbGVlcCAoMSk7DQorICBib29s
IGVvZjsNCisgIGJvb2wgcmV0cnkgPSB0cnVlOw0KKw0KK3JldHJ5Og0KKyAg
ICAgIGZpZm9fY2xpZW50X2xvY2sgKCk7DQogICAgICAgZW9mID0gKG5jb25u
ZWN0ZWQgPT0gMCk7DQotICAgIH0NCisgICAgICBmaWZvX2NsaWVudF91bmxv
Y2sgKCk7DQorICAgICAgaWYgKGVvZiAmJiByZXRyeSkNCisJew0KKwkgIHJl
dHJ5ID0gZmFsc2U7DQorCSAgLyogR2l2ZSB0aGUgbGlzdGVuX2NsaWVudCB0
aHJlYWQgdGltZSB0byBjYXRjaCB1cC4gKi8NCisJICBTbGVlcCAoMSk7DQor
CSAgZ290byByZXRyeTsNCisJfQ0KICAgcmV0dXJuIGVvZjsNCiB9DQogDQot
LSANCjIuMTcuMA0KDQo=

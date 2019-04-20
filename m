Return-Path: <cygwin-patches-return-9368-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25167 invoked by alias); 20 Apr 2019 18:58:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25154 invoked by uid 89); 20 Apr 2019 18:58:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770120.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 20 Apr 2019 18:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=mLGT3F26mHCsNlWi1hVcwTrqrijPxu7UwaQQ+L/Td8o=; b=D2bCzNku0SEWuvOTPkPQsD06/Bu1q1/aR/OqqeRdq9epHJOMu6pIk+6mVkHM+2c4CkzMr8vzqVPaEd0Ca0aGXgVCRtkmUMncVMYKspgnqI+Wn+GuPysbhk1Ht4nMpXBSByTApfOxs93pdW3WuOPnOEPNPIPVHPMCH5wiJUC0sgo=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5113.namprd04.prod.outlook.com (20.176.111.158) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.16; Sat, 20 Apr 2019 18:58:47 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.013; Sat, 20 Apr 2019 18:58:47 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 0/5] More FIFO bug fixes
Date: Sat, 20 Apr 2019 18:58:00 -0000
Message-ID: <20190420185834.4228-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00075.txt.bz2

SSdsbCBiZSBnbGFkIHRvIGNvbW1pdCB0aGVzZSBteXNlbGYsIGJ1dCBJIHRo
b3VnaHQgSSBzaG91bGQgc2VuZCB0aGVtDQpoZXJlIGZpcnN0IGZvciB0aGUg
cmVjb3JkIGFuZCBmb3IgcmV2aWV3Lg0KDQpLZW4gQnJvd24gKDUpOg0KICBD
eWd3aW46IEZJRk86IHN0b3AgdGhlIGxpc3Rlbl9jbGllbnQgdGhyZWFkIG9u
IGFuIG9wZW5pbmcgZXJyb3INCiAgQ3lnd2luOiBGSUZPOiBkdXBsaWNhdGUg
dGhlIGkvbyBoYW5kbGUgd2hlbiBvcGVuaW5nIGEgZHVwbGV4ZXINCiAgQ3ln
d2luOiBGSUZPOiBhdm9pZCBXRk1PIGVycm9yIGluIGxpc3Rlbl9jbGllbnRf
dGhyZWFkDQogIEN5Z3dpbjogRklGTzogY2xvc2UgY29ubmVjdF9ldnQgaGFu
ZGxlcyBhcyBzb29uIGFzIHBvc3NpYmxlDQogIEN5Z3dpbjogRklGTzogc3Rv
cCB0aGUgbGlzdGVuX2NsaWVudCB0aHJlYWQgYmVmb3JlIGZvcmsvZXhlYw0K
DQogd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oICAgICAgIHwgIDMgKysNCiB3
aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MgfCA1NSArKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA0
MiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3
LjANCg0K

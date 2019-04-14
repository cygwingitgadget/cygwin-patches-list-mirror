Return-Path: <cygwin-patches-return-9338-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128646 invoked by alias); 14 Apr 2019 19:15:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128636 invoked by uid 89); 14 Apr 2019 19:15:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=retry
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730131.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 14 Apr 2019 19:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=wHVtfNt/EeuZmPNyywgVwmnAmrACngzoprTmgKBa3+w=; b=FJ8F2yCOt4eBRqm+03lmcbOPY0ZfRQ/PrZuKTCNvjmcE1/UdIuN9BS2exR2nOg3C67v5ijlEWMkytPUe7At9IeLiopHntnKZSt1YC2hONEvG4y14YnTxtJ49xWPHc//OfFnQx5gZU3iw/MicDm5lt7hRXNU6VUYTDXixNm0+gg0=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3963.namprd04.prod.outlook.com (20.176.87.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Sun, 14 Apr 2019 19:15:55 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019 19:15:55 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 00/14] FIFO bug fixes and code simplifications
Date: Sun, 14 Apr 2019 19:15:00 -0000
Message-ID: <20190414191543.3218-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00045.txt.bz2

S2VuIEJyb3duICgxNCk6DQogIEN5Z3dpbjogRklGTzogcmVuYW1lIGNsaWVu
dFtdIHRvIGZjX2hhbmRsZXJbXQ0KICBDeWd3aW46IEZJRk86IGhpdF9lb2Y6
IGFkZCBhIGNhbGwgdG8gZmlmb19jbGllbnRfbG9jaw0KICBDeWd3aW46IEZJ
Rk86IHJlbWVtYmVyIHRoZSB0eXBlIG9mIHRoZSBmaGFuZGxlcg0KICBDeWd3
aW46IEZJRk86IGZpeCBhIHRoaW5rbyBpbiBsaXN0ZW5fY2xpZW50X3RocmVh
ZA0KICBDeWd3aW46IEZJRk86IGZpeCB0aGUgZXJyb3IgY2hlY2tpbmcgaW4g
cmF3X3JlYWQNCiAgQ3lnd2luOiBjaGVjayBmb3IgU1RBVFVTX1BFTkRJTkcg
aW4gZmhhbmRsZXJfYmFzZTo6cmF3X3JlYWQNCiAgQ3lnd2luOiBGSUZPOiBj
b2RlIHNpbXBsaWZpY2F0aW9uOiBkb24ndCBvdmVybG9hZCBnZXRfaGFuZGxl
DQogIEN5Z3dpbjogRklGTzogZml4IGZpZm9fY2xpZW50X2hhbmRsZXI6OmNs
b3NlDQogIEN5Z3dpbjogRklGTzogZml4IHRoZSB1c2Ugb2YgdGhlIHJlYWRf
cmVhZHkgZXZlbnQNCiAgQ3lnd2luOiBGSUZPOiB1c2UgYSByZXRyeSBsb29w
IHdoZW4gb3BlbmluZyBhIHdyaXRlcg0KICBDeWd3aW46IEZJRk86IGZpeCBj
bG9uZQ0KICBDeWd3aW46IEZJRk86IHN0YXJ0IHRoZSBsaXN0ZW5fY2xpZW50
IHRocmVhZCB3aGVuIGR1cGluZyBhIHJlYWRlcg0KICBDeWd3aW46IEZJRk86
IGltcHJvdmUgcmF3X3dyaXRlDQogIEN5Z3dpbjogRklGTzogZml4IGFuZCBz
aW1wbGlmeSBsaXN0ZW5fY2xpZW50X3RocmVhZA0KDQogd2luc3VwL2N5Z3dp
bi9maGFuZGxlci5jYyAgICAgIHwgIDE0ICstDQogd2luc3VwL2N5Z3dpbi9m
aGFuZGxlci5oICAgICAgIHwgIDQzICstLQ0KIHdpbnN1cC9jeWd3aW4vZmhh
bmRsZXJfZmlmby5jYyB8IDU4MCArKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0NCiB3aW5zdXAvY3lnd2luL3NlbGVjdC5jYyAgICAgICAgfCAg
IDQgKy0NCiA0IGZpbGVzIGNoYW5nZWQsIDM0MiBpbnNlcnRpb25zKCspLCAy
OTkgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xNy4wDQoNCg==

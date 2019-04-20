Return-Path: <cygwin-patches-return-9371-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25991 invoked by alias); 20 Apr 2019 18:58:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25938 invoked by uid 89); 20 Apr 2019 18:58:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-22.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770120.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 20 Apr 2019 18:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=CYfEH2bohCVpCf6GCKACfde2cFBX5iWAfAlFyCf2a1I=; b=HrPaKjnwx9tkUmhWz4/A3OmzJGEh4q2p4boSNICHYlc6bsCeGOtYJrDi/DLbhWwY+0rTZWoDLzvrslPSUIEnQDn/i8I1h31mxWUxng/uzc4fXTkPTE7ladiOAfPf8FZZxDJuBEsEQ2s2dAYuzx06wdKVlPlBpK4kwSsyY5RzhTY=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5113.namprd04.prod.outlook.com (20.176.111.158) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.16; Sat, 20 Apr 2019 18:58:49 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.013; Sat, 20 Apr 2019 18:58:49 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 3/5] Cygwin: FIFO: avoid WFMO error in listen_client_thread
Date: Sat, 20 Apr 2019 18:58:00 -0000
Message-ID: <20190420185834.4228-4-kbrown@cornell.edu>
References: <20190420185834.4228-1-kbrown@cornell.edu>
In-Reply-To: <20190420185834.4228-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00078.txt.bz2

RG9uJ3Qgc2V0IGxjdF90ZXJtaW5hdGlvbl9ldnQgdG8gTlVMTCB0b28gZWFy
bHkgaW4NCmZoYW5kbGVyX2ZpZm86OnN0b3BfbGlzdGVuX2NsaWVudC4gIERv
aW5nIHNvIGxlYWRzIHRvIGFuICJJbnZhbGlkDQpIYW5kbGUiIGVycm9yIGlu
IFdGTU8uDQotLS0NCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2Mg
fCAxMiArKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlcl9maWZvLmNjDQppbmRleCAwYTZkYzA1OTEuLjBlNGJmM2FlZSAxMDA2
NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlmby5jYw0KKysr
IGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQpAQCAtODQ0LDIy
ICs4NDQsMjQgQEAgaW50DQogZmhhbmRsZXJfZmlmbzo6c3RvcF9saXN0ZW5f
Y2xpZW50ICgpDQogew0KICAgaW50IHJldCA9IDA7DQotICBIQU5ETEUgZXZ0
ID0gSW50ZXJsb2NrZWRFeGNoYW5nZVBvaW50ZXIgKCZsY3RfdGVybWluYXRp
b25fZXZ0LCBOVUxMKTsNCi0gIEhBTkRMRSB0aHIgPSBJbnRlcmxvY2tlZEV4
Y2hhbmdlUG9pbnRlciAoJmxpc3Rlbl9jbGllbnRfdGhyLCBOVUxMKTsNCisg
IEhBTkRMRSB0aHIsIGV2dDsNCisNCisgIHRociA9IEludGVybG9ja2VkRXhj
aGFuZ2VQb2ludGVyICgmbGlzdGVuX2NsaWVudF90aHIsIE5VTEwpOw0KICAg
aWYgKHRocikNCiAgICAgew0KLSAgICAgIGlmIChldnQpDQotCVNldEV2ZW50
IChldnQpOw0KKyAgICAgIGlmIChsY3RfdGVybWluYXRpb25fZXZ0KQ0KKwlT
ZXRFdmVudCAobGN0X3Rlcm1pbmF0aW9uX2V2dCk7DQogICAgICAgV2FpdEZv
clNpbmdsZU9iamVjdCAodGhyLCBJTkZJTklURSk7DQogICAgICAgRFdPUkQg
ZXJyOw0KICAgICAgIEdldEV4aXRDb2RlVGhyZWFkICh0aHIsICZlcnIpOw0K
ICAgICAgIGlmIChlcnIpDQogCXsNCiAJICByZXQgPSAtMTsNCi0JICBkZWJ1
Z19wcmludGYgKCJsaXN0ZW5fY2xpZW50X3RocmVhZCBleGl0ZWQgd2l0aCBl
cnJvciwgJUUiKTsNCisJICBkZWJ1Z19wcmludGYgKCJsaXN0ZW5fY2xpZW50
X3RocmVhZCBleGl0ZWQgd2l0aCBlcnJvciIpOw0KIAl9DQogICAgICAgQ2xv
c2VIYW5kbGUgKHRocik7DQogICAgIH0NCisgIGV2dCA9IEludGVybG9ja2Vk
RXhjaGFuZ2VQb2ludGVyICgmbGN0X3Rlcm1pbmF0aW9uX2V2dCwgTlVMTCk7
DQogICBpZiAoZXZ0KQ0KICAgICBDbG9zZUhhbmRsZSAoZXZ0KTsNCiAgIHJl
dHVybiByZXQ7DQotLSANCjIuMTcuMA0KDQo=

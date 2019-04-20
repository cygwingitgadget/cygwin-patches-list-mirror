Return-Path: <cygwin-patches-return-9369-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25451 invoked by alias); 20 Apr 2019 18:58:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25371 invoked by uid 89); 20 Apr 2019 18:58:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-22.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770120.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 20 Apr 2019 18:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=9BKhlTwr/tpGHUspm62SdymWbcIO+HTdYOTm8hig5UQ=; b=RXHp/+9y4ivO0mt7KA62op8W1bNm8TEIn8SQlfARG3rfOL++fboVxBRsbpGjHXXo4MMhAfgWwl/a1ksY/JEyr/wUxxEqsxuqmEaCse6GPOmm0hTfFI1FHy2VNF0ePGzBQtCnSSBsnW6xOTm/zreHAdBcLcnc0YNyIpP7LTQw6so=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5113.namprd04.prod.outlook.com (20.176.111.158) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.16; Sat, 20 Apr 2019 18:58:48 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.013; Sat, 20 Apr 2019 18:58:48 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 1/5] Cygwin: FIFO: stop the listen_client thread on an opening error
Date: Sat, 20 Apr 2019 18:58:00 -0000
Message-ID: <20190420185834.4228-2-kbrown@cornell.edu>
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
X-SW-Source: 2019-q2/txt/msg00076.txt.bz2

RG9uJ3QganVzdCBjbG9zZSB0aGUgdGhyZWFkIGhhbmRsZS4NCi0tLQ0KIHdp
bnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlmby5jYyB8IDIgKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlmby5jYyBiL3dp
bnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlmby5jYw0KaW5kZXggYmM5YzIzOTk4
Li40MDkxNDRmZGEgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX2ZpZm8uY2MNCisrKyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlm
by5jYw0KQEAgLTU2Myw3ICs1NjMsNyBAQCBvdXQ6DQogICAgICAgaWYgKGdl
dF9oYW5kbGUgKCkpDQogCUNsb3NlSGFuZGxlIChnZXRfaGFuZGxlICgpKTsN
CiAgICAgICBpZiAobGlzdGVuX2NsaWVudF90aHIpDQotCUNsb3NlSGFuZGxl
IChsaXN0ZW5fY2xpZW50X3Rocik7DQorCXN0b3BfbGlzdGVuX2NsaWVudCAo
KTsNCiAgICAgfQ0KICAgZGVidWdfcHJpbnRmICgicmVzICVkIiwgcmVzKTsN
CiAgIHJldHVybiByZXMgPT0gc3VjY2VzczsNCi0tIA0KMi4xNy4wDQoNCg==

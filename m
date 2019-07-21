Return-Path: <cygwin-patches-return-9504-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122478 invoked by alias); 21 Jul 2019 14:25:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122469 invoked by uid 89); 21 Jul 2019 14:25:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=no version=3.3.1 spammy=Anything, H*i:sk:619bf05, H*f:sk:619bf05, letter
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740123.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.123) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 14:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=RfUWjMgAUZ4yxoJN+n/rETTbtzuECIGSJVZ0RxB90ls/t4T8cIxnDyEW6djfVv0ftrrI+Q0chE67yls+LePbf4FmziHxhgsbqv6z62Gpp3Iw+9nTVt1suF/EHbqhum3r6udo5kefKiFyhFY9ijLPV93NRqlf/AN1bzu9EG5YWlskfay1FjgXMvNWBWApa9J04td3qQzUdXQfbA4C7sqxzBobdF9PMv7Q45AZA7AA/b7/bcEw6ORRfexHRVHQVU6F+jzHSFPTWZo7mUNLoIyrHPhnGomC0tN8JQ9ck3/yHasUQNXOty/HuRRYlOcdwAezbwuuxi77u3ygbWqTyDlltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=KIe8+hhwCV0uPb+I6mdZPTNmYdyn7+nxBVq14+WZUHg=; b=KTo6WdlC6ZObkfixnG9GXDSI4wvkIY1bFURElsZ/l0o8DVJVMiWydatSwAikCPANkj5qisVjSyEVZNVpJMQDMQibNpLUW+RanAB4u9yepVE3LXgOeKrnywfDELswfFAm0huz37WTh39m6zhz2KnzPqQIZWYTKDd22tKh40iSYnzoVL2WnCAoDZVv9nFK77FV6P6lLOJZPKquLeDSdcBaofmY3pgWTZYhQhcYrJns+yDC2ndopGyj8lOy+l0fcdyOZvx4lmcXNLao1byBzGNN0qjn2RXSRC+yeCEYpNF/Q7MtOUwinUgDGSGwSvmkJrLs6SAnPXO6Dl3Q0FBaTl7AVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=KIe8+hhwCV0uPb+I6mdZPTNmYdyn7+nxBVq14+WZUHg=; b=c25+/rluVAmyDeRBVWv7olGKpuycL6VVs/g5E06GeTM4N2nwlxEF/YrLkm265YeAv6MBF8rkqmj7+o0ch099O7dlJ00OUsRjiCwL+nRhYcLNzQppYlByVWWx2A49N7r5E+x9HlMrdHyCeuz2iN2ZLw3j8WP01mQrY9/i8jVlRtw=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2363.namprd04.prod.outlook.com (10.167.8.141) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Sun, 21 Jul 2019 14:25:36 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.013; Sun, 21 Jul 2019 14:25:36 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: make path_conv::isdevice() return false on socket files
Date: Sun, 21 Jul 2019 14:25:00 -0000
Message-ID: <29f31335-dc95-3ea2-c883-f5774d49b7e2@cornell.edu>
References: <20190718200026.1377-1-kbrown@cornell.edu> <20190719082845.GO3772@calimero.vinschen.de> <8dce0946-6f7e-a3f4-62b1-98cdbbe277ef@cornell.edu> <e97cff22-2083-b5ec-1dac-31a34b0c86c3@cornell.edu> <619bf054-ae39-75af-eb12-e9b3b6115555@SystematicSw.ab.ca>
In-Reply-To: <619bf054-ae39-75af-eb12-e9b3b6115555@SystematicSw.ab.ca>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:2958;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <D815E7F28CE55646A4BAADE5352B5909@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00024.txt.bz2

T24gNy8yMS8yMDE5IDM6MTUgQU0sIEJyaWFuIEluZ2xpcyB3cm90ZToNCj4g
QW55dGhpbmcgYmVnaW5uaW5nIGlzIG9yIHRvIGZvbGxvd2VkIGJ5IGEgbG93
ZXIgY2FzZSBsZXR0ZXIgbWF5IGJlIHVzZWQgYnkgdGhlDQo+IChsaWJyYXJ5
KSBpbXBsZW1lbnRhdGlvbiBhbmQgbWF5IGJlIGNvbnNpZGVyZWQgcmVzZXJ2
ZWQ6IGJlc3QgdG8gaW50ZXJwb3NlIGFuDQo+IHVuZGVyc2NvcmUgYXMgc3lz
dGVtcyB3aXRoIGJldHRlciBsYW5ndWFnZSBzdXBwb3J0IGluYy4gQlNEcyBh
cmUgYWRkaW5nIGNsYXNzZXMuDQoNCkkgYXNzdW1lIHlvdSdyZSByZWZlcnJp
bmcgdG8gdGhlIFBPU0lYIG5hbWUgc3BhY2UgcnVsZXMsIGFzIGluIFNlY3Rp
b24gMi4yLjIgb2YgDQpodHRwczovL3B1YnMub3Blbmdyb3VwLm9yZy9vbmxp
bmVwdWJzLzk2OTk5MTk3OTkvZnVuY3Rpb25zL1YyX2NoYXAwMi5odG1sLiAg
SSANCmRvbid0IHNlZSBob3cgdGhhdCdzIHJlbGF0ZWQgdG8gdGhlIHByZXNl
bnQgZGlzY3Vzc2lvbiAoaWRlbnRpZmllcnMgdXNlZCBpbiANCmNsYXNzZXMg
aW50ZXJuYWwgdG8gQ3lnd2luKS4NCg0KS2VuDQo=

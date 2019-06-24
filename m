Return-Path: <cygwin-patches-return-9455-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21765 invoked by alias); 24 Jun 2019 20:21:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21754 invoked by uid 89); 24 Jun 2019 20:21:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730117.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.117) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Jun 2019 20:21:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=0O8ympCSUMu75b8mEEf4hIbSYJOzMen6w/qtWNFVbPk=; b=PIP/vschaJB7+an3ROlR5pilkQ3vg+gliiKb9Z7NR2hzulsK70lTabpjAMsb0mXJLbwSSkUUpzqxSPKoBQeuP0uf3+Npr4tdOIY0ipywgy5hI4DL+BOFe6AjjF0A5OADqR7oyGoUHC5UjPvwKhYDz2zM5le6yLYfIwGEs9hfHcE=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2139.namprd04.prod.outlook.com (10.167.8.155) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Mon, 24 Jun 2019 20:21:23 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::e43c:48bc:36fd:1f40%3]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019 20:21:23 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: timerfd: avoid a deadlock
Date: Mon, 24 Jun 2019 20:21:00 -0000
Message-ID: <f5a074ad-2c6a-bd99-749b-741c04e0e026@cornell.edu>
References: <20190624201852.26148-1-kbrown@cornell.edu>
In-Reply-To: <20190624201852.26148-1-kbrown@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.2
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:311;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <E719951BFC0C28489BD5065E5F1F0B10@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00162.txt.bz2

T24gNi8yNC8yMDE5IDQ6MTkgUE0sIEtlbiBCcm93biB3cm90ZToNCj4gSWYg
YSB0aW1lciBleHBpcmVzIHdoaWxlIHRoZSB0aW1lcmZkIHRocmVhZCBpcyBp
biBpdHMgaW5uZXIgbG9vcCwNCj4gY2hlY2sgZm9yIHRoZSB0aHJlYWQgY2Fu
Y2VsbGF0aW9uIGV2ZW50IGJlZm9yZSB0cnlpbmcgdG8gZW50ZXINCj4gYV9j
cml0aWNhbF9zZWN0aW9uLiAgSXQncyBwb3NzaWJsZSB0aGF0IHRpbWVyZmRf
dHJhY2tlcjo6ZHRvciBoYXMNCj4gZW50ZXJlZCBpdHMgY3JpdGljYWwgc2Vj
dGlvbiBhbmQgaXMgdHJ5aW5nIHRvIGNhbmNlbCB0aGUgdGhyZWFkLiAgU2Vl
DQo+IGh0dHA6Ly93d3cuY3lnd2luLm9yZy9tbC9jeWd3aW4vMjAxOS0wNi9t
c2cwMDA5Ni5odG1sLg0KDQpUaGVyZSdzIGEgc3R1cGlkIHR5cG8gKCJhX2Ny
aXRpY2FsX3NlY3Rpb24iKSBhYm92ZS4gIEknbGwgZml4IGl0IGJlZm9yZSAN
CmNvbW1pdHRpbmcsIGlmIHRoZSBwYXRjaCBpcyBhY2NlcHRlZC4NCg0KS2Vu
DQo=

Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxwayst06.hub.nih.gov (nihcesxwayst06.hub.nih.gov
 [165.112.13.54])
 by sourceware.org (Postfix) with ESMTPS id 0EC623858D3C
 for <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022 18:29:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0EC623858D3C
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.88,296,1635220800"; d="scan'208";a="229054372"
Received: from unknown (HELO mail.nih.gov) ([165.112.194.63])
 by nihcesxwayst06.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jan 2022 13:29:02 -0500
Received: from NIHEXS4.nih.gov (165.112.194.64) by nihexs3.nih.gov
 (165.112.194.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 13:29:02 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (165.112.194.6)
 by NIHEXS4.nih.gov (165.112.194.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18 via Frontend Transport; Mon, 17 Jan 2022 13:29:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyrBz+wU89kS726mGr6pzIsr0aAOWV4d/1J6Apki+njAhNRaogFnsS3UHuS03z4fEtpr0i6SNpOv+db1jZ33mw741PARX9ItlvAJ90uu0QiKkaSu2WZ44mAsmoZkxjUlo+GrGlVTFbFvEdoiNkYrRX5FiBaugKlDvfc/jw3gp8oBnLyEBaLXh2uY31JHYzje810cVSdNSAWmvlIE4UWEOJv2TxMyIb4v/spUmhMZzn8JYm2jB/x4ATXFbW+/9U1gd4b4qcG+LDxQQUDer1cVamQr4GbBDsVp5Qokfo3GCkyp2cqW6xN0gGHG0D87SQ6PmIz72hiS89NO8It0S2ZcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvzIgLpVZboKtoaH7/RAV8Y36czyBhexbO1kl5X8qXg=;
 b=DvUL1Ce1wzTI48KWxz6Oz3xL0Njt5Dfkb2Mj+twLEXjJp+Vtqcc/mHg9nISQhuNwB0Yl/zhm4fYjgK76cvQkvpiwCQ/ib1jbLZmI3wPBunv7jgT3aoqK8nuomAc9CCIO3WzSCHh6+qKw+Lp2OlWPFz7DTBpHIGCuvXABWRDI51sba3n99ho66xZFiA7HaT4EiI+xQSxLxmQuqLvDMRV6VZh0Yu7ICiSFduASPR1itkgtEC5uwkGE8p65iRVhFjkzhtXmLDJgqz3JiQP9PUz9UKwCV870ytiB6eajZiM9Haav4XYicLNRTeogAQOCfII4mmPfIbwGxtofknhIWyLDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB6229.namprd09.prod.outlook.com (2603:10b6:5:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 18:29:01 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 18:29:01 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: resolver //Was: [PATCH 3/7] Debug output to show both IP and port
 # in native b.o., a few little cosmetic improvements for consistency
Thread-Topic: resolver //Was: [PATCH 3/7] Debug output to show both IP and
 port # in native b.o., a few little cosmetic improvements for consistency
Thread-Index: AdgL0BezYQr4Do7aRby7SMAZ2Smi1Q==
Date: Mon, 17 Jan 2022 18:29:01 +0000
Message-ID: <DM8PR09MB70952595CA9E93D575F033F9A5579@DM8PR09MB7095.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16542d48-3716-4a55-7d38-08d9d9e73c07
x-ms-traffictypediagnostic: DM8PR09MB6229:EE_
x-microsoft-antispam-prvs: <DM8PR09MB6229FD6937CB6C46BC89E02AA5579@DM8PR09MB6229.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKOLCehwPpKyHmBGTMa6k7BhDVAtR8eWLW+ggva3GGJJdUa4r/RJm52KPFoDErxqjjpDyShqm7EWdANpxoIyHzcoyJIx6xQjjkrF4KG8w7zm3bO8xVON2j+8xxkS89aoesaonPS24FrpEueEP30GEuoy/X5AGBCg2I7IGb8qOT6pMKHs+k4q4cE9B+pgC8iIFDFqpsufU2p9XGfVQWpvN+IQophlySXrfBrSxuMC5756Efq+88gljf44fgsaSMK9YbduXbMtDtYVIEYyUTdl+FhL7uZVoVRuHNqbh/QQKTwYie5cd5MYeomwJJwMD15GHsyPoDUZAj3B14Mtcz89SkhWTSXf34Y0+EQrrJ32LQMtu7VEZX+tImMfDDj2f5fEc0koSdFHhpD1n/0Yw7Vbycjt2Vne1k/xaBruXkKlmhgdEkBXQMpH12CPqm7g45YNdoxb9GVEaghqgx/Lj/snR4IeZpEpMkIyXYetcb5XzY7PGOSu86HT0MO2DQRiv1PPPI/32H8nQO6m4NBtVARiz9dC2dbUFZ4aQS9gdvED4RtIrMk2++n3x7jaoCo6aGm+JHthLIWSREC4idtEvzPAKxVEdKDbwAzPQAcnRXZMQTYbJT5EhoQ6Hs5uFrAIqr//MPz9OmQImQ9AdmwuN1JSPnm4NOIFSMXgSb1R3MR5VcjfvcfhzJHVSBOp6IsIOf1LRuH6qyopkh50bX7NVXfD+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(26005)(186003)(33656002)(86362001)(66556008)(6916009)(7696005)(64756008)(66476007)(66446008)(6506007)(8676002)(52536014)(76116006)(66946007)(71200400001)(8936002)(316002)(38070700005)(55016003)(9686003)(122000001)(83380400001)(508600001)(38100700002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFdxbVA4THVhUjhhM25YVGJ3VDU1TUN4cEV6dXplaUwxd1lhRWFsYUY4bjNE?=
 =?utf-8?B?MW1mQ1RvM2VuQjAwZW1tOW9VYzVNYnZDTVhMV1Fta3dzeXpBeUhTWHFXZDFL?=
 =?utf-8?B?ZlNxMjRITGgwZmZ5UmIrbE8vMHZIWU5WK3R6T0dCcTkwNWsySDhmQkkrdU0r?=
 =?utf-8?B?aG54TWRuQ2ZyNkZLYUFZQjQ1SDQ2bEpSWGMwSHgwZUVlWXpmdURmdWloZnNO?=
 =?utf-8?B?ZlRnbzFBbjVhRXNBaUk0aldMNWNpWGxRQnd6b3NrSmthVzZhUmg3SGo1WnFP?=
 =?utf-8?B?VElyRW5lcUk4MTFmYmlqMEtkS1lXOXllU3FiRzdFL3JWNEExeTZkNjE0c2Fl?=
 =?utf-8?B?blg0dVJXd0xLdVE0c2o3aFRvM3kvZkxLVFpOS050WHhmOC9CckdySFlIQTdl?=
 =?utf-8?B?QTBoQnFiNmRybTRsOVM3NXdXcGZ0cUh4bTdwejFWRHk2d0pDUVJ2ekZhTVBT?=
 =?utf-8?B?WjYvWnlKM3hHek5oNjJPV0lrQ1RxUmFTYlRqcC9yZkdMQ2VBeVp5OUw2QVA4?=
 =?utf-8?B?VDZyVW5XcG02aTNXc2pkTUw3Q2dLZlBXUTRFWHE0d05RZzVlcFRFUURCaVNM?=
 =?utf-8?B?MUpwdGNYaldwVDRuSGVvZUVPVG9MZUtqTGhqTVdjWllnYW8yU0NPRzh5SUxm?=
 =?utf-8?B?VlJrRlBQNUVJMldHOGI5R2p2VHVaQ3hObGNoYWlpTnl3dExWd0FSck5Xc29w?=
 =?utf-8?B?VnRIOEIvYkYweUxnZkZBOEpvTkZSUks3cUt3NHlmSE1waHEzWlRNWDhraWZl?=
 =?utf-8?B?UFZuSkdMVENtK20wWW5TSC9RQzRqU2g5NG1BVGdRN25RWktNQ0JpWk9iQndk?=
 =?utf-8?B?OHM5bXBUZUp4eEc3ODhIWlBUelVHTFpIM0VyMzgxVGYreG5IZHZPNWZZWkRF?=
 =?utf-8?B?K2dEQ3JvL3NtMGRicW0yQVVFMHhTcHZGU1ZUN1lia0hqTmd2dkJ3SUthbXJv?=
 =?utf-8?B?eThlTkxwZ2NVWXZ0ZWtRV1p0dGI2TTE2Zkt3dFFwbW00c2trNUpFdkhBejhV?=
 =?utf-8?B?YjFIbGMzWFhZbkN0TXpreVY1c1NnbTFudmk1aklZN3ZvV0cydDQzU2hibkI3?=
 =?utf-8?B?R0MzbFR1UFN0S1dCZ1pIbjhkMU0ydmpMS2laR0NMTVhrSFcwVE5yU1dEL094?=
 =?utf-8?B?UzEra1VOSEpUemNWQ2lHbm5ZSzdxYW1OSmdhTWpOeHhxUGRrK3JRZy9haExu?=
 =?utf-8?B?cTArcHpnSEhPOFJrVmxaM0pSV3cwb0VDOXI1UmFwVDNIMzZOY0lzUXJGY0o3?=
 =?utf-8?B?ZVVGSDQ1Wjl6SFZmQUZMVjRvOUx1bXRKYWl5OXNXWkFrTnpOTUk0QXg3b0xO?=
 =?utf-8?B?SFBxckVUNGZ4cFQ4YzdEbjZiVTNBc2VIeWRrVEZNWGtHL3UxNWtTcjRmZFBM?=
 =?utf-8?B?WFYzeXNWTVZZZWFjdndWUHJtOVFNYkltVlRxNVJSTzRrQlF4RStTdDc1QUR5?=
 =?utf-8?B?MTFONDY2TGhqeVYyRFpRdXZYZkJrVHljYW5WbWxDTndvT2pFSnIxNDNCZ0Vi?=
 =?utf-8?B?Y0s5WCtJMGFsaElKRWVZQVJ3Uzl2dHc2TWJWYmltQ3pQUkxOVnM2N3JEcS90?=
 =?utf-8?B?ZjloTG4rcUJGSHBPcERDQittSHlmanNmTkZ3cVRvN1JHdk1QaDlzNWswYSt4?=
 =?utf-8?B?RDlWYnVWaUdrZFEvbnI5TGd1ZlhKT09NNU5zWlhyZW9wVTk0bGlucGdIa1k5?=
 =?utf-8?B?UlkxemJSMmtURTFPaDNsQ3RCM1RBRS8xMHlraVlqZy9uakxMdWUzKzNWaERr?=
 =?utf-8?Q?1xuCrJKXBnrFFny32s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16542d48-3716-4a55-7d38-08d9d9e73c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 18:29:01.6327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6229
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_EF, SPF_PASS, TXREP,
 T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 17 Jan 2022 18:29:04 -0000

SGkgQ29yaW5uYSwNCg0KPiBPdGhlciB0aGFuIHRoYXQsIHRoZSByZW1haW5pbmcgcGF0Y2hlcyBs
b29rIGdvb2QsIGV4Y2VwdCwgYWRkaW5nIGEgc2hvcnQNCj4gZGVzY3JpcHRpb24gd2hhdCBwYXRj
aCA3IGRvZXMgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIHdvdWxkIGJlIGdyZWF0IGZvcg0KPiBsYXRl
ciByZWFkZXJzIG9mIHRoZSBnaXQgbG9nLg0KDQpJIHJlc3VibWl0dGVkIHRoZSBwYXRjaGVzIHdp
dGggYSBsaXR0bGUgaW1wcm92ZW1lbnQgYW5kIGEgYmV0dGVyIGRlc2NyaXB0aW9uDQp0byB0aGUg
IzcgKG5vdyAjNSkgYXMgcmVxdWVzdGVkLg0KDQpXaGlsZSBkb2luZyB0aGUgY29kZSByZXZpZXcg
YWZyZXNoIGluIHRoZXJlLCBJIG5vdGljZWQgYSBmZXcgbW9yZSBwcm9ibGVtczoNCg0KMS4NCm1p
bmlyZXMtb3MtaWYuYyBvbiBsaW5lIDI2MiBkb2VzIHRoaXM6DQogICAgMjYyICAgICAgICAgcHRy
ID0gTlVMTDsNCiAgICAyNjMgICAgICAgICBicmVhazsNCg0KYW5kIHRoZW4gYSBiaXQgbGF0ZXIg
dGhpczoNCiAgICAyOTAgICBsZW4gPSBwdHIgLSBBbnNQdHI7DQoNCndoaWNoIG1ha2VzIHRoZSBy
ZXR1cm4gdmFsdWUgImxlbiIgdG8gYmUgYSB0b3RhbCBub25zZW5zZSAoSSB0aGluayBpdCBzaG91
bGQNCnJldHVybiAtMSBpbiB0aGlzIGNhc2UsIGJ1dCBpdCdzIGRlYmF0YWJsZSkuDQoNCjIuDQpB
bHNvLCAicHRyIiBpbiB0aGUgY3lnd2luX3F1ZXJ5KCkgZnVuY3Rpb24gaXMgbm90IGNoZWNrZWQg
Zm9yIGJ1ZmZlciBvdmVycnVuDQppbiB0aGUgImRvbmU6IiBzZWN0aW9uIG9mIHRoZSBjb2RlIChh
ZnRlciBsaW5lIDI5MSksIHdoaWNoIGlzIG5vdCBnb29kIElNTy4NCg0KMy4NCkxhc3RseSwgYXQg
b3RoZXIgcGxhY2VzIHdoZXJlICJwdHIiIGlzIGNoZWNrZWQgZm9yIG92ZXJydW4gKG5vdGFibHks
IGluIHdyaXRlX3JlY29yZCgpKSwNCml0IGNhbiBsZWF2ZSBnYXJiYWdlIGluIHRoZSB1bmZpbGxl
ZCBwb3J0aW9uIG9mIHRoZSBhbnN3ZXIgYnVmZmVyIChiZWNhdXNlIGl0IHN0aWxsDQphZHZhbmNl
cyAicHRyIiBwcm9wZXJseSwgdG8gY2FsY3VsYXRlIHRoZSBmaW5hbCAid291bGQtYmUiIHNpemUg
b2YgdGhlIHJlc3BvbnNlKToNCnNvIGlmIHRoZSByZXR1cm4gdmFsdWUgaXMgZ3JlYXRlciB0aGFu
IHRoZSBwYXNzZWQgIkFuc0xlbmd0aCIsIHRoZSB1c2VyIGNhbm5vdCBhc3N1bWUNCnRoYXQgYXQg
bGVhc3QgYWxsIEFuc0xlbmd0aCBieXRlcyB3ZXJlIGZpbGxlZCBjb3JyZWN0bHkuICBUaGV5IGNh
bm5vdCBhY3R1YWxseSBhc3N1bWUNCmFueSAiYm91bmRhcnkiIHdoZXJlIHRoZSAiQW5zIiBidWZm
ZXIgd2FzIGFjdHVhbGx5IHN0b3BwZWQgYmVpbmcgdXBkYXRlZC4NCg0KTWF5YmUgIkFucyIgc2hv
dWxkIGJlIGNsZWFyZWQgdXBvbiBlbnRyeT8uLi4gQnV0IHRoYXQgd291bGQgbWVhbiBkb3VibGUt
d3JpdGUgb2YNCnRoZSBidWZmZXIgaW4gbW9zdCBvZiB0aGUgdXNlLWNhc2VzICh3aGVyZSBubyBv
dmVyZmxvdyBhY3R1YWxseSBvY2N1cnMgYmVjYXVzZSBvZg0KYW4gYWRlcXVhdGUgc2l6ZSBvZiB0
aGUgYnVmZmVyKS4NCg0KQW50b24gTGF2cmVudGlldg0KQ29udHJhY3RvciBOSUgvTkxNL05DQkkN
Cg0K

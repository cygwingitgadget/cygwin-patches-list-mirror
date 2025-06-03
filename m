Return-Path: <SRS0=JtNr=YS=intldatabase.com=brooks.edward@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id 46FA13858429
	for <cygwin-patches@cygwin.com>; Tue,  3 Jun 2025 10:28:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 46FA13858429
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=intldatabase.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=intldatabase.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 46FA13858429
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1748946502; cv=pass;
	b=XAK1YAyR0mf97QpZfX0kt1NE8r2cA2RUKyj7HnpkA6wUkeu0pY43e14jKVj/rbLJO+uUUskXqgN1Vg6cn1VW6oSY/Fx3e/7Jm/SzF5PlrSex5SAJ7oa5lrjo37aJJyDdZLXard8lUJXRH8CjavwL45isBM8re1j+lvWTFucrQmU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748946502; c=relaxed/simple;
	bh=9adzsfPCGxth78gofOhb9jpm0c1w5MxqYSiNhSKdFW8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=wAbnQ+3wNBv2RZNuaNXPcfYqNCJpi1JSOuT3JxyXtBQ2P59xqKEciWME3kkj8N5PAlemEATEZQD5bXssyeXEOgJkbiy3tH01APq6A2Jcm7iQpLnp4VK5Mjf6gozi+kqIDdjGiCKsICKqllN4ZXAD6E4AZ4luopXg8sgDvIagsuM=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7eB6uIz4ezIPytS50F+ppQbV5AqOktK+2WiLNqA4kJEyTL7jGD/35fz5mVMSATchxrX3v3cwYUljLRth7UlBcp9XN1noqIzQFJaxvvndOoybQVm1J7TosSA5mn9x0oWcOKEiVyQ0C8eZQpVbA7HjCur1/0xke6lLfpNi2it2H9EEirlfg4Dy9oROlOgUloNbosIEzUXfJsZ0wyszLWZUyilOa3NX08avullMwd41Nc8Eg8CpAsR+JeE1nB8mZxi7NXha+4Xf1agP8/r1fsHinq4IwSJg7FHybkVUnF5mEX603PUeVgzYZ2kXa9jDOIIMB3PxIOU2kV8WffXQ8QDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnABT8UK6vnJskOhynl2j1bz95l5QSCQlVXR5BBrpck=;
 b=hQr3t8jkscNBaKxMLpUMBct8+HyXZWLl7teVvZca47BEaGFdN6bLFF817dtWHDFjqLyTJE69M9itzlx+CIwuI3U3g/69kQjizUKOWvc3+R/gDw3b8luWFv2VRhiPdBAiLVmChQ4+QqYCWUZkUcEKyLTHwLsYP3BNmuUDZBJ8xSmOYDCOuskppQepalpn7vpUA+k9xnJRuZk1SxVY8dSI8XboUmhu/634MTkpF3RLXzrJUDzY+zgj8sELtxIeIR0qbl9TaI3gbqE3ybin9i5PXRgdQal4M/EymcTtKfNIh7wx+vbEVLmhLwdEIBYH9LlumqhQrDx3AXIprQPV9tgExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intldatabase.com; dmarc=pass action=none
 header.from=intldatabase.com; dkim=pass header.d=intldatabase.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intldatabase.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnABT8UK6vnJskOhynl2j1bz95l5QSCQlVXR5BBrpck=;
 b=NDJLHf0iyoN5dd5Wm1AwAThJ2WRy5GzoLpVL5A68OZx8u9XRyfY6vN7AZUnhdwyx6WxT5MGp9jmIYlQeyeIDdN9fU2t2RLxcxyMltvFkqL+1KZ15ibUOfQvJwCLIZWLP1l/mmafGpIStAS8xSzRa/CAEpqq7zbgXPE0K4GURiZfBhc1tRfD4KDsFaumDOS3ZSNptDwu0qQciDOT6A2ZyPcuyPJDS7jlbP03D8Raw6o7aPPJjeLM/Wi4y/Jx+L20IPe4ToYo13IsNNQMje3AJ94FpzUEUpwmRoLhdz1a4mBpsc5Oia1mnfNokEgJYctsGiTlq5F0rOTU/q8Z7BdjnJg==
Received: from PN0P287MB0624.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:166::9)
 by PN2PPFDCCBE1506.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::152) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 10:28:16 +0000
Received: from PN0P287MB0624.INDP287.PROD.OUTLOOK.COM
 ([fe80::10d8:5b2:87de:ae24]) by PN0P287MB0624.INDP287.PROD.OUTLOOK.COM
 ([fe80::10d8:5b2:87de:ae24%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 10:28:16 +0000
From: Brooks Edward <brooks.edward@intldatabase.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Electric & Hybrid Marine Expo Europe 2025, Industrial contacts
Thread-Topic: Electric & Hybrid Marine Expo Europe 2025, Industrial contacts
Thread-Index: AdvUcjNzH+B6bMseRyOXxecoFK2Mqw==
Date: Tue, 3 Jun 2025 10:28:16 +0000
Message-ID:
 <PN0P287MB06246BD24098CC26D673B812886DA@PN0P287MB0624.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intldatabase.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0624:EE_|PN2PPFDCCBE1506:EE_
x-ms-office365-filtering-correlation-id: 1890fadf-eeee-4d59-0d09-08dda2895a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|4022899009|376014|1800799024|8096899003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ozr3LWpZND5nef76vSPbYcsu3WgjhplrgeOTc1oT0pnZUiS8tWsOfmIA7Wu5?=
 =?us-ascii?Q?O+pN0dP5ml3eYrvcTQLyNJTr1we4jwBNRRLbmSw5GQ4czvHEOZPCw/Ysh83b?=
 =?us-ascii?Q?uZKQ5LLvFuA7WfCgaeY3P+QcCimZGwINmkRVxumTJHBDPy3RXs5P7SfkQ7NJ?=
 =?us-ascii?Q?qg1lBiQ115kpHj/Nd4c9Qplb6qo8iMnifsCFLTusY1xJe3zsu30Wic9YtyDo?=
 =?us-ascii?Q?zFBZzDDfA7Y2kMj0GKRoQzRC49im+4sHjaxaGAex84bUFe8FDKqohCqGuLFB?=
 =?us-ascii?Q?gFm1j0TUagfbFiwVjASkVbHI0tzeIbiPvdLvucieFxV8MMu1+qW0/2S9jO8F?=
 =?us-ascii?Q?51XiT+JZgKw1iH4Yn4wolHI2LwGNggD6n8y68vHaaeBSUGDomlJphnfqxZRH?=
 =?us-ascii?Q?viFbnNgMDGQZXxu4VDnOFLblRxxstMWtb8WgOT2GBVh9pOhnwsjbA6dZ3hLP?=
 =?us-ascii?Q?7GYtRBZZCnfp91S1GDYCDuC5QhkuvUBgLkJpv4XYzZRAJM99B8yaYbY+heRN?=
 =?us-ascii?Q?kOIaK4DWwgw2I5tOgho26bebr8LtEkIm9420ROJ9Wi3CbBVOWpjQgZilVhOz?=
 =?us-ascii?Q?58mzmgf3RVUjqp03OyoZ3Hc9roq9OGAFI6jWYIrj4F+aDE572cT0lCQM3ZKA?=
 =?us-ascii?Q?pkuKTEeaTLcWqMs0+PHmrY+Z99g+bs6ugPxvUN0OjLEJQF/a6+R3eCT0eOwH?=
 =?us-ascii?Q?BLoJ3ClhxmPaR06FGdP8LuUz/rvMdFW3U/rIalvSg9J3JRQaf3+0+rGZRZrI?=
 =?us-ascii?Q?WY6LI0O4MA71h1lTWIBsLw7BHttp/t7rRFYqJ34Owt4lwiwV9u/WI+Fgga1+?=
 =?us-ascii?Q?3X53HKchc2m6hdX4plnLbCX8FwIiLyqyYNa51Krl+7oO6NZ2OnUKg7+ffiZz?=
 =?us-ascii?Q?fdP0WcIDrnprxO2knWg3vQLZbxRmN6jvYNUe4oyCtHjY8VaWJYX+9diI5ODX?=
 =?us-ascii?Q?U0OHsgyb2ANuNjp138sfWhXASo73QkVpirCmWGYnf6T5peSrVhE9Mx0j0JWu?=
 =?us-ascii?Q?+jyKvglgkpqcoLAcphfkm6gvG+u3Zwc9Cw9utpUdfWLFOYvhH5U8RSCFBcfA?=
 =?us-ascii?Q?Ax93XjF7+q74mITsfas351aBtoew/Lkhi9ebmv7BMMc+nzQbfy99qu8sax+s?=
 =?us-ascii?Q?5CfU99K2UwJWJPTRfcjK9MeaOzpgpTVLgVPs6tLYo2TGSLucnFQzW9ppV2i5?=
 =?us-ascii?Q?7kXx8O1JuIlt5gLv4DhplZf7LzO7QUhcOoK98KN1Jmz/4EnhUizDFbrk7uKE?=
 =?us-ascii?Q?o1TWP/Q6YvSepFjRDY3OLdXcKD4sPexne4UXl5kWVeWl6mSQDZnGc3DBocNy?=
 =?us-ascii?Q?evzIhWjLxDUyTA4ZquLxAw+fJHaYeXEaLc8fTdjp9M+6NUoDw8gi78Ye+Q8p?=
 =?us-ascii?Q?a9COGCDPE57z8vPjr6bSJqZq49fooRT1ZI2SffESyZeX+Jvm8tQsgmfm7pKr?=
 =?us-ascii?Q?F3cdGn4mObhLspVKB2ysRgbR1dW4tXLbODk16HZ7z6Zk3PxoLiiyhg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0624.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024)(8096899003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3LWi1iM2zber2nErrcdNiKNNNB8+/RQriWTTUKhI1rE5wuvBf9oVUp/Xt++V?=
 =?us-ascii?Q?swaernmyy0EVXm5+61CaFVLfqTAF3VaDO7qecDl1XHOM8HJ3ejCpZE2neZTa?=
 =?us-ascii?Q?sR9Ay0K7Zaf2osiAL1r9c4YXOG+YTWVFN0nxfZe8mxzC8+7bDPxxp4FKZvlz?=
 =?us-ascii?Q?XQIsmxm6HBjigACdcbJZupVwkwKmjWGIGsj4nYY3KrQjkygDNL00iqZUpEJL?=
 =?us-ascii?Q?T9NgQN8b5MafPADJNUpuKrzysijrrQeEBUmWmFbGEHgZQ0cVwPEhMlKQHuL9?=
 =?us-ascii?Q?2bLgFmTxmiTViH6ryqPAvxcnx1hMjxZYXD7R3Sjqd8qQEiGjDDUPG16JSZEL?=
 =?us-ascii?Q?QjYykKRS1gJWyUqYhXN8Z9pDf7Qv9ezDEjo4rXtUUWuxDbiLF4xw4Suqx/rB?=
 =?us-ascii?Q?RbVqmhGece1AeqvAn/w30XV7gm3AFwzkmRZA/zMQhMOP5blv3cZOiQMeEMfz?=
 =?us-ascii?Q?ZlqUSQTB3+bQ7YUuQ2uASwy9HqFdY99w8U82mSOUrBrtukj8CmZQ/VvWht0d?=
 =?us-ascii?Q?qlVXS0VMrscIJVpkwzaNCg1c/zO4q2ZEDTNOsl434wBn+8Cw0TwgqUrei+DK?=
 =?us-ascii?Q?m2BWQ6M3YJqDzCgvymJHbm3H+24LBamH5rjVf1wp+3nFFVRUW5laZRdLwHqV?=
 =?us-ascii?Q?a/Q6QCez82mkvcBV87T2Frgbt4fcq/7ahppdAFui862G+JuOg6QINqSTq2fk?=
 =?us-ascii?Q?b/ENIqoMwJsrCOntZre2Cp5mggQzMMEAv5ESMhsgEKH5Hci5aFw38hXa/3wy?=
 =?us-ascii?Q?t25pa3x3vbiOlQZ0sSenQVwSfVUKSigldHCYZ7v81GB6HOw/tPwLAlJWYZFw?=
 =?us-ascii?Q?E5G59EX74ZsWgLtTd1E3aQ+XFwDvUWZNzeXE8a5B81JVAt1md5KJJAyTspfB?=
 =?us-ascii?Q?uaXXy/2n1wTES8SU74xaJY6j1fMYbQWXjvRAzwi3PyZFp5IeOkjmUY+cX6Ci?=
 =?us-ascii?Q?vKH3aLeMeQF9OsxPm2T7xfb4UpFrhTbx7g2wQnk3PR1GGZlUeQ5rCXHF26U1?=
 =?us-ascii?Q?+ABTD9a2nvnx6hRmy8pbMS3Hm/esuHS+bMGGEUAES6HWoVwNLHIryuHh7fGp?=
 =?us-ascii?Q?O1IvV6fp++CdrPc48STwjf5M+fIlNZqpSk5oUlc3PRVbfcqDNZBdw0RT80jD?=
 =?us-ascii?Q?Ef3HQ3YT5B0t3VTSkF0kwY2LfUxbtZodFUc1Ulg6ym4sWB8qs1tYOvh5jG+q?=
 =?us-ascii?Q?aBJT4H41oT92gFt4OCkHJxAkgHUSFiN1QsfVv+AUzC9VpRgRi2H5AHR2Dqj0?=
 =?us-ascii?Q?+bYh9Pr+QpAQ3PxnVc51OvaYroHskPuIqYE0t3beFM6ydOZiFf7sF4lyb22v?=
 =?us-ascii?Q?OH2GS8ivt4OMXR/ribMuVAxbp22UtKi8yctGBQ4iDiA2E5eHJOeXqDLTbLuZ?=
 =?us-ascii?Q?eanVSByPK+57OJRFJTNEG9cgUOjRtivSjcnu7sB+1zJ4n/lIQmRzTUvMfbEY?=
 =?us-ascii?Q?QEMxHFsxGaFvW/6ywxhOC6RvHsCw2l8REDD5UJ1Ys+ECjTh6n0LJJvaK3v8n?=
 =?us-ascii?Q?2jr/OsG6jKcNkzH/NjlA5ah+7q5nlxuFLdvs545Y5Is+cP78eLExLR95IW6n?=
 =?us-ascii?Q?VE2fI4RJe68kXwHROs6qmNd9ggqI5qh5+j2L9mAxQKfMAP4fdc2v0sGownQX?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB06246BD24098CC26D673B812886DAPN0P287MB0624INDP_"
MIME-Version: 1.0
X-OriginatorOrg: intldatabase.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0624.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1890fadf-eeee-4d59-0d09-08dda2895a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 10:28:16.7871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9b6381a4-a1ce-4d91-9b36-27e4aa06acbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ce/TATvB03/r2jafpXc3rsGUfiDZmI3gbBkd3qX4KnemDrYBCFxuVuf3D5+Jvag1QadyWNPoEV527JJcUPU3tOIg/G31fxVfjoNk9Dc4u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFDCCBE1506
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,KAM_UNSUB1,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN0P287MB06246BD24098CC26D673B812886DAPN0P287MB0624INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,



I would like to verify your interest in obtaining the relevant industrial c=
ontacts.

Electric & Hybrid Marine Expo Europe 2025

24 - 26 Jun 2025

RAI Amsterdam, Amsterdam, Netherlands

Total Contacts: 3,256



Flat 60% Discount on the list

If interested, kindly reply to know about the pricing and additional detail=
s.



Best Regards,

Brooks Edward - Marketing Specialist
Unsubscribe<mailto:brooks.edward@intldatabase.com?subject=3DUnsubscribe%200=
74AD649%2D718C%2D4947%2DB71E%2D63E507EC1CA8&body=3DPlease%20don%27t%20chang=
e%20the%20email%20content%20and%20send%20this%20email%20to%20unsubscribe.%0=
D%0A%0D%0Acygwin%2Dpatches@cygwin.com>

--_000_PN0P287MB06246BD24098CC26D673B812886DAPN0P287MB0624INDP_--

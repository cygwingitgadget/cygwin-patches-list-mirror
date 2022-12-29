Return-Path: <SRS0=s4gK=43=hotmail.com=nirbhaya_singh013@sourceware.org>
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2092.outbound.protection.outlook.com [40.92.43.92])
	by sourceware.org (Postfix) with ESMTPS id 0CAEF3858D20
	for <cygwin-patches@cygwin.com>; Thu, 29 Dec 2022 07:44:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0CAEF3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKEuXUI8FmS1TLN+S496ip6RfMAIAHIrkoRWFADKFtZ9HtZxzSpLu6R1Rg6v5jqfRKDzSUHBJZWXVox9u3xhEX413+5rVGTaXGsYIV56WcjeKtaNDq3bWTf3Y7S21MrGYyQBP5yAg4Qv+Yi9w1ks0JWVHEmTb+es/zaUaR1JnyAcUgO3gtZA/Ar4y8FCbE34ILOcQJ/gHq2QI3m2XtCIXOj8q8f1ogeolFhqKK2kbdNVzZUMAzLBgTlEfpM3Uv3/muBCCwHkyqogzq1oXn3bniLHyeXY0TXxWwcPgrHXDRR6cVTq8umRDlOUqS2GE8Me+thkSRUHDLKXWcDCBwEidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaI3277WgiWHTCGkBaAg5Ztwr6NdsC/u/BDf3i8wE1M=;
 b=S2AtMaDrvbDNtYU0z6R9I0bDZHTwwVH3/mATaZ6yuO6RDw1Eds5PloogIVtSegjp18vo9r3vUwX3o6cD7rgNcYfWzES/GvK9B5fkY3sde785mR5Lx7P9BhTf4koa4tYtzEYHd6ZhKCOyT416A94+A/XxNg9BMV40slCOY1IwjTNoMbGZwAiJY6zXQMLfzGs/qe7dl8jQmV0LAOVLNwyr8Q/nWGO1DCn83kxKn6y2qmoxzlvPMYRSK7cnPboR2A2T9KMBgHtOCQ1EWUyH6McD3HR5/rG6G1QYEHjwvLrVWv0s6/mT19kEbDa9bdq2QdwZqjcMtYZQjAkPuYzCNA+MIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaI3277WgiWHTCGkBaAg5Ztwr6NdsC/u/BDf3i8wE1M=;
 b=X8WYdxrrUtOgfR9vMeVR5IItVT6vVlCNsztEqjkUVfpIQHTrS5AsXLA7V3tySPMh6qxYML+wxraCH+UEYIJQ7Eq0o5olR4WmV8aPaAj/L00TD5pva+wVlhBGoTq6DYsYBQHBbL/d9di4uUusYsFZfrg5PsmQ18X1bkMFxSNT+C0DhOTuzVNUq8cGPknsnJdh+tIDwdSEzWJ03/rAwquB0ZIfQKJXAPVdn3g9WZ3B5SLjUmh3hcgZnI6EEJEWWQicMIaHbCPl95EeMZB/syakxhwZy0M/85DxbSa8ZCOhluwtWQrYIXSNwiPu8Z8HDeIdw7TSj8BK44yj52iKcHUfAw==
Received: from IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19)
 by BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 07:43:45 +0000
Received: from IA1PR12MB7567.namprd12.prod.outlook.com
 ([fe80::97dc:865d:d8e5:278e]) by IA1PR12MB7567.namprd12.prod.outlook.com
 ([fe80::97dc:865d:d8e5:278e%9]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 07:43:44 +0000
From: "Ajit" <nirbhaya_singh013@hotmail.com>
To: "Ajit" <nirbhaya_singh013@hotmail.com>
Subject: Apps
Date: Thu, 29 Dec 2022 13:11:50 +0530
Message-ID:
 <IA1PR12MB75679208FC76AA7F4FAE30F1DFF39@IA1PR12MB7567.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00DD_01D91B87.60B21A00"
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdkbVnFkylCdXamnTqOfJE7l1kN6QQ==
Content-Language: en-in
X-TMN: [flN2WvR5EPOIljvqwem8nmWrn6NJYqDT]
X-ClientProxiedBy: PN3PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::10) To IA1PR12MB7567.namprd12.prod.outlook.com
 (2603:10b6:208:42d::19)
X-Microsoft-Original-Message-ID: <00dc01d91b59$46f9de00$d4ed9a00$@com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7567:EE_|BL0PR12MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 431f0eee-1175-4cf0-7461-08dae970696a
X-MS-Exchange-SLBlob-MailProps:
	qHtzw5/dbHz14J6SrndFrMb+zYHxtgWylKSZvQpkfWcR+ylHlvIzZH0gTeLxCI+HpMsczAL9hQPOPUmJXx6Hs8bb1F7xKiCBfsByHFhn9+iZP3tTFnnRBcKcsHfKmeltn5VIbgHDxj0jdWkUk0XFr9UUgs5OL9itZUtrFUAFHJnDuVF4C2d/jE0EUKmh4iinB6OLE054XdQ+d6YS+snGrPr3Cw4LzhRbuKPLvdLsHZhI5zELMuozk3lrGh0jVZBGBbnAPlFTg4cvJpzcIQezp4+ei+RLQR0sEqDDR/XBh1Nf71EXMyrsmhM9jXbZiBvg0m1AqM5mj0DlxU+TdknbgRArO8vWNPCVlNgjKaHtIT6tffhoeg27GKHO5Hx0vnD6bytrY4Z3o4ST5rcwYguoKtneLZejCNwPPHRvuF5DisURgKL1uaUGIQSkJK2UDxBP5plkcnDXt0nRyCKIu+aq7sVzfRwAKbCI8LCZmxJNbJCnE4cGkei43I60sDBCVMVOXYKOeesXA6l67TnZvb+6DYSM6jQDS+zJNcYnriQV1SU0mkfh+fKT19GFm4UI9pazJaUawuXM3tNghx13LKSGFlqv1GFb/y8mgPS0WVLEEyxweidZRbi+qw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O/ExDlAoRDmieRP6Kb5I/GpeV516B8D0lFVbF1seBQPALyqIved9dE4UXosYee5VwyyMWNHiwWuauxFu1H57CyPyao1etQCAk1RShBLNtAzvDs6FJbXrkY6/845ehAqt2e1Efc3sDw4eHmCT6boI13QwiODoaR0VnVeU6lElv6SH+T7PlfCzhsWiMmGDw/x/B7Q3Y60pJTxiCbWCHs7ZOK9+WAtYWcoNaflshYpRKaZrbuK2rGMjf64n0BwFkVnEnfYJnTvFdC+Eg1OZ74OOLjZnyxnXx5/5Uda282Xgy1PJmfoTd3gpSTCWDVSOedbHOQV5JWy+3btyXxhRDdd3ciTg1zCmtzll5M1ULVrQ/lA24l3hgVKtwCUi+iwAeOLYVsWj+YOcUlPKQHLaDzy7yBttOgKqVvQKVsGkWEp38itFQtO/vuwwt5WGLlaSls2Y1CPq80JZOTUcv4PerVInEXzmAs34XCVGf4jbwVJkBUTJI9ZmIFp7F6ej+iZ9sfwxi/RsLYVva5aSDGpxy3r392OspWIOD686mN4CkTqfx1wrkdSKEhnLQr2pkZ1k46WD9dsQvT4LUmKAzSqXnGeEZusIj5oZ0uMb2KcYJqkx2UiyOCNg2ay7m0aTsSeLh5KaiBoc93fptwCqN+m86IM5uA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8HLaSWJdK06cFBMaMvI82SmCYtFEy0hJTg+hhVi8cJKcd0nZzrRoC/ze2tYg?=
 =?us-ascii?Q?4Tjy617Vc6n+80zHcCoz631SEzC2ckTs3vA9u2y8/pd1kpVQjZ3XvO5+pQzI?=
 =?us-ascii?Q?ALPqe21B8tfrs0UVaiJ7/uhO67zRNuoV0tmGI1lVmqqlmDD9daxVMIHfdypj?=
 =?us-ascii?Q?vu1cGOkYqFy3o8Jxk87uTUUaF8H1Y71uRsfQW+BCGqkhuHFba6A0j4dWOe5f?=
 =?us-ascii?Q?Gmm5wKTKo4XpVOm7ThLoXBEQn20N4NIon2D8SAIhLpNPjiXNnJkjjSDhxNIO?=
 =?us-ascii?Q?iIsCJtEOD2Zq1zd+gfNiUy15yPlMizc0hlz6rKN/iWv64t/eMuD9mfKn3+mU?=
 =?us-ascii?Q?dIgZJKlIzosUPRLbHhq/xN0OPImCAqXgNfv9TZt1NhUaUq7DuQVN6kBohelL?=
 =?us-ascii?Q?ay2oxVwNFASawuScuGG9Il/spHyZ934+6FwJpHHAZDGDEqDC78pLiel8bBIo?=
 =?us-ascii?Q?qUGFBVOHe6EfYQGUJGswa+P+DP8OwLUI54Ft6a0i2TcJhncT4jQhcElZChPj?=
 =?us-ascii?Q?pOCU9+7lqZGwTehsR/3UQoLRaiCdkdUzwtwkS+1/Ab2ugDjU5u2nldN+mRHk?=
 =?us-ascii?Q?4oS/JcM5wP/uGMGO3kUBrLl1R7pLl8arhIiDMPf6Wz6/Yo+l2p7NduvKUATr?=
 =?us-ascii?Q?h6SwmndKRqswY/hSbeattqkEYcTVUdknWx/9BlSa9DDLw/Nn7MqrwVL3ixS/?=
 =?us-ascii?Q?W+9n1HiNXvQIqJi54/JJfi28J3KJCz8VkdSmWxDGECE8OwDz4EnYOWjVQoSM?=
 =?us-ascii?Q?Qy1GlBPqimVAJ6Ff/lCVkNsbW2tqigFH1A8pwPz2Hmxnb9X4jO88vAHkhbm2?=
 =?us-ascii?Q?IpArF767YsfMEIgbfihOM+4HMlDGVR4jmgs7McIzCo2hd8VSnkbCEPWHDVGd?=
 =?us-ascii?Q?RNF13XWRh0kQ+VlB+a8xUVNthvFmn/8TUox5BiYXZ90ogd/eBrIMohYvPilJ?=
 =?us-ascii?Q?gwAX8LxwRx7tmYd8+8jjI2jN+I6g6O8aSfhLVxXse6cS2OedbPasAraM5o08?=
 =?us-ascii?Q?EUy3Tjg6CNLsYZli7KwL/QncbbBQnrBXPLpCJMk/gbUszp21LcXIMqbjDYxk?=
 =?us-ascii?Q?MpQ/9J0w8J1D45iJoZqon1ycufJau+ylRulyrFfLNShrOLO32H9gPHwiMQkK?=
 =?us-ascii?Q?SeMNQc3EyQNsERmZ4KA1IuOIF+be2psAEGyWBu6fNoL0jlKOlRkKMUHhJ62h?=
 =?us-ascii?Q?+zzpOx7DsS9Y7W/zEKCzl3l2tpsiA2If7P2mIyH3RRQFTPmN0JwOPlKQsMWN?=
 =?us-ascii?Q?UbrQnz/qwq5luxo1sLJGdRoGGv9OoFWJNYUga8fhoHOJHip3L8UZY4YluzS2?=
 =?us-ascii?Q?U7k=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 431f0eee-1175-4cf0-7461-08dae970696a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2022 07:43:44.6165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

------=_NextPart_000_00DD_01D91B87.60B21A00
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

Are you looking any type Apps for your current business? We have intensive
experience in creating apps for:

 

. Education Apps

. Food Delivery & Restaurants Booking Apps

. Logistics Apps

. E-Commerce & M-Commerce Apps

. Real Estate Apps

. Taxi Apps

. Business Apps (Billing, buying, booking, tracking, Finance)

. Lifestyle Apps (Health & Fitness) & many more type apps build regarding
your requirement.

 

Please let us know your App's idea, exact requirement with us which kinds of
Mobile App and for which service you want?

 

Thanks,

Ajit

(India)

 


------=_NextPart_000_00DD_01D91B87.60B21A00--

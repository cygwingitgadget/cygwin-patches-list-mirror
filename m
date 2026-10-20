Return-Path: <SRS0=dZds=IK=outlook.com=luca.bacci@sourceware.org>
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn190110001.outbound.protection.outlook.com [IPv6:2a01:111:f403:d207::1])
	by sourceware.org (Postfix) with ESMTPS id 530914AA29BD
	for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2026 09:20:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 530914AA29BD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=outlook.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 530914AA29BD
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d207::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792488021; cv=pass;
	b=Rih8shkPbzkH3yqnX6/Brh1+d+Z/kLNzYIs2YYLB6BtmBr27a3I8HUnc7WR8a2jmVFT+T4rNuOUro8DmNDvLkJ+zLmQM2+ILSlqdQfUpikco/lC9JncpGNKDI45Loh+3+DbpD67p+cg004xyAfKA82owrz2e/Zfni7dDfKyK/KI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792488021; c=relaxed/simple;
	bh=6PD+1RUZbl6/z7FaefIAXhOyFMKkIHB0w97WgUPbupc=;
	h=DKIM-Signature:Message-ID:Date:To:From:Subject:MIME-Version; b=C0zZR3Q6hPVt9vjlE7lKTIxO8dBlhA/LC3urg0BNGdkZ5Qh6Sa05cg4veys9gwZsBcKZSsmuZ3HonR1KipqIfzBMqj1M8nKgucPNEjO10s1qahMLQQQHXfGmWo/dLkGO7jvXtInUVnRlIAhbx7X9YF6whMNFDYr6Nn3oY5SDoS4=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=nToPFkU/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 530914AA29BD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=nToPFkU/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrX7klkqgpirD8AcohLCxIBAUt4uSiQt4wc3TKSB/l6FYU1QoglCDOjDCa/TO8qrU8DASmEGWSa4Vwz9VhIV6yU52QCay/7uFCymgSDnJPCeF2c9H7aNC0E9qJvZGMEFssudB7h4iVkAuMN3cnpms1ZzXbAHXhvTVnc/HfiVv4yMvdfNvexiOJKaO3+5HVQemLN4PCC0jtYJansULdbdDnSauO0DXnlie3xrQJj4d6BP/ZqNd68rts/4HG1eR2srHBGHHU9t3LrRXQOsr5fpCWR/9FPkBAFInVp8CZDJgikefYuuua79M9LGYRoVgrsaQeq44NTI2sz5rtgpnaAAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ots2syIVtGqAb8bljg3jLirwVBlpPCOcAmJ7QgzDmHo=;
 b=KpPBJeKWXGy0WV6JVE8fOfeDY2JIhKHrJr8Xv+ZzC0YcKOCZK/DFtPYa/XJCUy/yvInsL6Z2+iIwWxI56pVGOKKN60X1ym0OS4WuwCiW5y+SSVHZ/e6StbzpjQQg/OmgHrSYjM/9GcveLecx85J7JpxL96V2UmYpBCFCQ4c+yHRrQjZIuT7UoKRn5+lXJr+gGJ/lpBsF9hKX0A4w33Q3Ly5/xH9FeFQJ+vfcrW1LiA/jWRRNuH2v05+NbTXHO1OOCQtpb6iolI6GfV0tOwtptxto/RbOUhl+/Tti++LRc90iAx6h78qj58CD4h+F8X3GT1WEJIU85Rh1FT4B2VCAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ots2syIVtGqAb8bljg3jLirwVBlpPCOcAmJ7QgzDmHo=;
 b=nToPFkU/P6p3ySvLg0BkWOO0rPEVaL1xckYhvrLPNmoneOjOAEk4g+X4DUZtsUp6L0XBNN+fYHkS9ILoQnqbsBZ8WOZ+/4mW+fPpiYVlPdpOyEDqW7aja8llieRrRDNlap/lTQeflE9H9lVSuUH+w1A0NBSjQoQCwYpviiOM2o3wH/12vLRDTcCymeDG9YRBYtuIOrKl6kcjIuVA2tQxwWsEnXdCKhEQ4ME+H88XIbDpHqVOMUceGVDkGOzgazXXtPGDIzAiF2k23k5z6rnMdu6nqCb/PDP+nt7FUeyjnp2OkYF7zk3MZ70s4wypMo2vjeGr6PpSI54D207Qke/TPg==
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com (2603:10a6:20b:4b2::9)
 by PR3PR02MB6363.eurprd02.prod.outlook.com (2603:10a6:102:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:20:17 +0000
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8]) by AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 09:20:17 +0000
Content-Type: multipart/alternative;
 boundary="------------nBRWhD0YVWYA766GmN0dl9a6"
Message-ID:
 <AS4PR02MB7902BBEB59E65CAEEBA03EFA83672@AS4PR02MB7902.eurprd02.prod.outlook.com>
Date: Tue, 20 Oct 2026 11:20:09 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <42ba91ec-cdca-4148-be26-9f7bf78601fa@maxrnd.com>
References: <42ba91ec-cdca-4148-be26-9f7bf78601fa@maxrnd.com>
To: cygwin-patches@cygwin.com
From: Luca Bacci <luca.bacci@outlook.com>
Subject: Re: [PATCH 2/2] pthread_spinlock: Attempt exchange only when
 lock_counter is 0
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To AS4PR02MB7902.eurprd02.prod.outlook.com (2603:10a6:20b:4b2::9)
X-Microsoft-Original-Message-ID:
 <3db8c729-44cf-48d3-bb57-097e8c883c05@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR02MB7902:EE_|PR3PR02MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e58f06-423b-4b0a-8594-08df2e8b5b17
X-MS-Exchange-SLBlob-MailProps:
	uxBZ0XvJeHC5NqW+4n3kaiy8H436WkqZi2CLrsZyNJmdJjwx+GgwY8QulBJ1JiuhiT+NC8TzlihMRroiXj/HVGVXogOdoKAmeVQ8s35rR6VRMhWVAe7jjJ9WnOovvD7A+rYImZytVmYihtSx01z0f/TR11iWiD5D7I7qtXkL2ISbwCB4ewFEUsbXI49clh6Uq1XeCLKOa00v9Bv9vRP/ank7tnxTKyyv0jshsw+mnrromIC7KuRmYt+WzEnXzaY/BaR5aM0C4rkwkm1E2UQVznHjHORHQ+saKmijS+9Tu3s31/kIeHn0YEfzFmgfbKibUkqijcsoBuY40WL1H9muAHBQy6Q0UplQbLzKc7i2XoydgmSst9MTt/fq8BMU8AyjCXmXSiF3FfnJ2+z+Wv9XUGuEMQGWsvMJfDMXR0Xzo+kPXg71vR9qc5ddX9LU08qQzPIbL9Bem7fjL3HaEh4KWxBwlgVo1GWdpdsyxCgJBnzPIQkDWKklWnhlreInnrJu0wI1pkPhRyouHICcYiJLqsFwyWGgpRTpse1ZfnebppF+vI0usee/FBrju8W1jZ4aIyt3b2Kolen+4II155JPqvbbfiOX+NwvbyBde86DC0LrzI+EOAkxDJ/9jg//WQ0KuOjCm+oJd5/Wsnu2gLK08A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799012|23021999003|24021099003|51005399006|19110799012|8060799015|12121999013|25010399006|3412199025|440099028|14041999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmE0ZnNVWkdsZ1FPK1lTS0VkNS9PVVdMVm5sR2pzOVpVZlZJc0lkQndUOWZF?=
 =?utf-8?B?NU5uS3VYMFpFYzE0L3pNOUhRYWFjcytBNVB2cTNCT0xOSUFCK0hoVlVOT3ht?=
 =?utf-8?B?MDlDaTFmbVpiU1lNN2FCSXpqeXg1ajU1K1o3S1VaZTZSaUkveTZMcjdJZnI4?=
 =?utf-8?B?WXJHLy96MjRncDdsTktKRGFQVnRzem9ZQ1hpRTFpYzlYK2t3SWNPMFVvSWZ2?=
 =?utf-8?B?SG82bCtmQjhkRmdaN1ljcmhWRDBIZ2I0NjZnRSt4UTdqL0RJUDV1aWZWRmFm?=
 =?utf-8?B?Njg0NjI2dis5VFFnanFhZGJ3MThMNElneXkrendvR0IxOXZYZWJVUzZ6c1Bs?=
 =?utf-8?B?SzZWRVI2VnJWWFN0d016YVJRb0lYT0NJTXlOQkdYR1lKQWF6T3V4K00zcCtH?=
 =?utf-8?B?UG90Ky84a0F0STNyRWZHSkRDR0FuMXViaXBGZkw2L0dUSVVKVGJoTmVqVUQz?=
 =?utf-8?B?WXY4QlZBU0tkSS9aREd3dE1INGtQWG9oWmRnYWFOWVZwSGFIUW13K1BLWVhv?=
 =?utf-8?B?U2RkdG1Fdjg1WlpaMiszeEw0dHNwd2dZbEF4NTdlblkvSjBxNW9BYWtLMS9W?=
 =?utf-8?B?bGhQUE5qKzNTem1neUhEN09TempOQWYzbERTYU1DTnFoS0VFMmM1RGZlUThi?=
 =?utf-8?B?L2NHUEFQL3lxTWN3alJTT0hWMlladUFDTmxqSEtYYWZsb0pRZVNYeXo2cHA3?=
 =?utf-8?B?Ti9LTWliSlBBTGVCbUhuSzE4UXNZYmtGMFJEN3p2c0hsQjUxU05kQ1BabVkz?=
 =?utf-8?B?SFZjL0hrSHRKN3VnTVdQdm0zMEVCSTY4UWlkQ0h4dkNXYnRjaVpCRjBzekJs?=
 =?utf-8?B?eWNnTzJzdlB3L2F1aDRIYVkvYkN0aFVBa1hJNUF2Tk5hRVlUdU81RmpzNDRy?=
 =?utf-8?B?UWJjNDd4NHBhMTBEWFJSZnJyYnpKbVBIQk1ScS9iYk4xS3BCUmNCV0QraWVh?=
 =?utf-8?B?S3dzRnhacnQ0aGpoU0srWHR0VlNpdTlGeDRGVGQ0YVNnNDVRWHNUK1gyNXBR?=
 =?utf-8?B?bUExb2FFenk3TkdqZjVFRlBLeGxjNWxCdUhEU2UrU0JyU2JkU0hteHZUaFhT?=
 =?utf-8?B?K1lVVWtPcXFUZjBRS1lNVk1sSGwwR2N2ZnkzblFQeDRLbENNQTh0ODBHUFVN?=
 =?utf-8?B?VEtuTlRhUFdHRENLVWdqY2kyV0N1d0V2cW1odk1lVmNzWkpxR29uWXRsUTFa?=
 =?utf-8?B?LzQ3VUtscnRZSDJPc2o1cUpoM2FRNUtKT0I0QXllM1JaUGNNVmZld0JXZlJJ?=
 =?utf-8?B?OTVCZ0d6STFaRTRtdVVTODMyb2c4U3U4YXIwSldxZk9NbzZUN04zdUVLNmIx?=
 =?utf-8?Q?0MZ8JFdZqgOgk7pRyS9WdJ8EUfAqfvmuRy?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFdCdStKZWJZQ3JjaVJqQ2dmTTA4ODFSOGZLVmZPbm5Zcmt6eXhYdVBPNGEr?=
 =?utf-8?B?cHU4UktIREUwNllCUEJ6c2MxT3ZndWJQNnB3TnAyd3RSdUF6Q3dvVG8vMnlI?=
 =?utf-8?B?SFBqTDM4Rk1mcldmYWdLdFJ0UlAxc0ZDTlYzYXhNOU83YlZvNGJwbklIbzhI?=
 =?utf-8?B?bU1HN3JXbHdQZWloTDhGMVBFeFhpYlJHSjJuTUJ5bVBFeGJibFRqVWMweTJO?=
 =?utf-8?B?cjBhYUYybFBNRmFsUmt4YXNVVERPZ3RVTDlUYTZGK3ppaUl4all0enVmaHJL?=
 =?utf-8?B?Sng3TnRjQ2FSK1FWbHlqejVZRzZmTkxSdXM4OUhJSVFDeDFkYW9aYnBObzVl?=
 =?utf-8?B?RUs3eVJxZEsxVDBvV2ZWejI4TVpkN3BuU1hZSmpWMyt5N2FlUjVhNlBSUmQv?=
 =?utf-8?B?dXAxMlZaclNFNTJTaHJpYkh4TER3NW1ORUtxMUhNRHF4QUZBZzYrajArWlN6?=
 =?utf-8?B?SWJlWmxldkF1aWVwTU03RU5OMlZxTnlOT3JSWHRnQVZJL2U2MlVITFdSV3l3?=
 =?utf-8?B?RG5tcnpMRGJSWDhyTG9kZ25wNDJGaFlwYUVZaTBwRzJGTzZWbXJwWk82Yi9i?=
 =?utf-8?B?M2RnaEZNZktVeWhjdTN0R0MvODV1dWhucm5UMDIzYVBsT25QekYxdEdBZXRz?=
 =?utf-8?B?dUxJSEpWQjZnUkNFQVpXYS9KNmlVY0ZxcHJHQXhyUGpRcjc5WUdTRHM3b0Vi?=
 =?utf-8?B?STRPeDhrT1NpZlIwRDNvUWhJZTc5QmRKQ0JTbEREVXFnZGhqQWlHOGhMeGpZ?=
 =?utf-8?B?KzVzTVJvNXBxWUllTFZqZjc4aFdZZzR3T2JsTTBjejFzRTIzZWM4allaSUxV?=
 =?utf-8?B?WmpKTm5NNTFiamk4UVMrUk9RNlE3QUcvZVdIN3NEWDB5SUJjQkFaOHVNUmdz?=
 =?utf-8?B?TU9CeUVFL2tTTEhKZFNvT2kvLzZydXR2R3E4Wkl1aDFWS3V6Z2lQOGFCcnd1?=
 =?utf-8?B?UXdkOWoxTFRtclVJUmkrNGc5N0xINHladm81N2h2VVZmYXNUWk1XampMWWZm?=
 =?utf-8?B?OWMrTTZhejVjU0pUUmVJc2srVGFucmk1d2FZZXJ1ODZUT2tsVTRURTg2RlB4?=
 =?utf-8?B?ZmxZSlJIU0JORFdFV2pKWlppSkE4d0w4Z095K3dCaHYrdUYrcUx4ZDJQUlBG?=
 =?utf-8?B?Zk5ONjdTM0N1QTk1c3B4Vk95UGxyWDJRWjl1dlJ0ejgrVTE0NDI4bWNZRXpP?=
 =?utf-8?B?ZFVqd1AwWkVpdTlDa1lkL3ZDUEF2d1BlQ2QrMTJBNXhLL0JwZHdHSVp1SW8z?=
 =?utf-8?B?MVd4SUhvNkxDZTN1a1BtS3M4ckZhQkVJQlZqRlVmcGc4RHlUTjlIeVA1bzhm?=
 =?utf-8?B?c2FMdCtuZkZxN0hra0U5QWw5R0xrWWxyVE8rWG9TWVNUY0xyTG9abS95aStJ?=
 =?utf-8?B?bXdGdFJTTHRJcXFTVEZJckFBNjZmY0VZaTI2VHVzR3lXdkkwdWtBQkpUaXFO?=
 =?utf-8?B?ajlYZGNUQ3RtbkRhYXhqbmtqSjVQZzJVZ3c4QVlzMVVKNi9PZVA0RnZycnda?=
 =?utf-8?B?K3ZMaGh5ZTBqUXJ5ZHJIdWJTOUFXN2FXR2Myc2lqZFk4bS92eEJlZTAzRDN5?=
 =?utf-8?B?dWpUOWVlYXdoTEpyNWdRYWozVnRpK2krTExpNEdyZU5SZWhvSnpTb29vZFhW?=
 =?utf-8?B?aitCaVNaYWViZEtQQ2VPbTkyRC80RVZkN1BBaUVyNUdDOEpPeStpa1N6NFhv?=
 =?utf-8?B?WXZkRGgrOU5MQjdXa1V4eGZFNkdXcmMyMWdHV2RiSlpEcUgzRXEvVldJK0dP?=
 =?utf-8?B?bGlwaVVaU29GbXV5VXZtWXp3Y3Z0ZytIRlZEZURZM3NReGdDeUtxc1N5SFJx?=
 =?utf-8?B?RE5ReWNHZ3BiQjl4QzBOTEpJMHo4VzV1cnNDRnRqUHdUdEF1VStsbEhGRHJV?=
 =?utf-8?Q?CpHBru6Nn3alo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e58f06-423b-4b0a-8594-08df2e8b5b17
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB7902.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:20:17.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6363
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GB_MSAUTHSOURCE_EUROPE,HTML_MESSAGE,KAM_NUMSUBJECT,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------nBRWhD0YVWYA766GmN0dl9a6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Mark,

This was found by visual inspection, as with the other patch.

Thanks!
Luca


--------------nBRWhD0YVWYA766GmN0dl9a6--

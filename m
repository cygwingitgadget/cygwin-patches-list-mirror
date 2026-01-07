Return-Path: <SRS0=BppX=7M=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020095.outbound.protection.outlook.com [52.101.227.95])
	by sourceware.org (Postfix) with ESMTPS id 3CCF04BA2E05;
	Wed,  7 Jan 2026 17:49:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3CCF04BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3CCF04BA2E05
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=52.101.227.95
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1767808183; cv=pass;
	b=F8UbO95m2rBL0uDY2/3OnN51xfWLyMTMYkazDP6AlWNQXse0zx2mkY1Uwk5YRd/5DU8nUWMfebMBD3KL4hO/q/Yrz1rKShhH/8NNKYiAKcVbvpLYuK/AVIzFzQnkkSSRXTsvE8qyvklsdOv2ipm3YuhvSlmTOO0oRkOw5pKEqd8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767808183; c=relaxed/simple;
	bh=rzDLPt3PW4aRHtgqfLlewARW4TsxtrVPDhiJNBZ8rKo=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=oLNg4q5qdyXMUSyTamhk6KEOIlmUhrWB4AHPwYS4sB+X7sQCyf4GTUJyrzaUXE14M0vHyrybChmOAleChFQis4anbB5GL6KfxI72k6LXdHqQjqsBGAvHkcNqruUiib411B8Y5GdLz5eaHLQ95fDoaTgZeTWyrk2MA2s+VN11aqE=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3CCF04BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=bjdPZz0H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG6uOJC1ntocVAh5MPDVUOFjlpo6iAP/w7hzE8qbmc4q/iOCeU8hbL5c7FzORRTiXDaQcNg3k8R5SiGVJ58b3qCQchTD5WWrdjQEYmFySNw8gh1aQwyd5CtNWuuikVi7LbNmmvD9e8T/hNtm9+Ixw5rqGODHqfQpuXDP6YHrugDx3h5S52oCnLVElMlytLIPu4Q9RPWtLTt80QdNTBLNjENfbF5J2RTFsBG1XjC2Ziok21mh0fDE3M8ZexE+WimlPxw95OTgLue0AR7g+/8YhjJIwSJJZZNwFDCaXbjTkYk/tQMRWxO6qnXD8EDOthywAUX252k1NABqLVrDpG7fcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzDLPt3PW4aRHtgqfLlewARW4TsxtrVPDhiJNBZ8rKo=;
 b=UfmYymocTJfXEfXsgUIBK5AEqAEP+jQTI7W28Q1Oiw/wH+w1zt53/Tb9UZ2t2rEgPrCH05ZLr10X60H3eUY+GYcAW4qABhCqH0PIKb7tTq/E9qKkXtBQr4T8MSQcnQpBwAUIYWCDFqcxEu2vaqOXT9fbBYvXiKeS/2pCpAhBnFmKitUqgwAZFf2VBdFhnCcdKkDtw9ZuYH5zUKqmRti+XbEpY/AOZ859X/ctze7hM+Kr4XaM8NzbQ2yI0wNYuZDBBx/KhaxCPf+El57YDjbCNJ00to7ZDjNiG9FrB7Vi1L/VlqMFpNIKQlUwaccZ7yYyM1yOQHwDPVpdC69+TUa3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzDLPt3PW4aRHtgqfLlewARW4TsxtrVPDhiJNBZ8rKo=;
 b=bjdPZz0HgqTcbTKNw9geE+CLQ11d0ytQT+Kf9Q99cS0fGb3Jcxb84ZlU8OGmmCEouUkQvgQtaO8y7g9YAWnJCfzGMqTIktDfWvrCGS+kL0+sRBxx5eZOBM841QCfBgVmX9yQCZi1pVcQi9q0matGIck4J8gj5J2LRY5d3vT/6zGxpzZVq1fG3AlUqEvm82Z3tYpkcMJ8kIkw1T3vwPu5yMTouIVFGZ8vtQqw9LZRr6sFvQ+qyH6u/9GpgbA2xQtGYiyT6aXLtmCs5OkDNYDBH3SNrSM1EV/3awJo/l94Z4x5F8wFP2JZ526jRYtpf7BzUdW2uIwc5Ab/LQ56UOn0HQ==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN2P287MB0400.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.6; Wed, 7 Jan
 2026 17:49:36 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9478.005; Wed, 7 Jan 2026
 17:49:36 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jon Turney <jon.turney@dronecode.org.uk>, Corinna Vinschen
	<corinna-cygwin@cygwin.com>
Subject: RE: [PATCH] Cygwin: _endian.h: Add AArch64 implementations for
 `ntohl` and `ntohs`
Thread-Topic: [PATCH] Cygwin: _endian.h: Add AArch64 implementations for
 `ntohl` and `ntohs`
Thread-Index: Adx+QEk0XZ3dXM1KRUqKRVZ6HRTO8QBhvyQAAANs74AAAfN8gAAH4GXQ
Date: Wed, 7 Jan 2026 17:49:35 +0000
Message-ID:
 <MA0P287MB308292D9218B275DCD187FCD9F84A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <PN3P287MB30775977BEB79B12B2F3BCEE9F86A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
 <aV5A5ENx-xQdpgzR@calimero.vinschen.de>
 <2b722c24-9ba6-42d7-b353-cc2294f3f9aa@dronecode.org.uk>
 <aV5k-SLWTgfx1wVv@calimero.vinschen.de>
In-Reply-To: <aV5k-SLWTgfx1wVv@calimero.vinschen.de>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN2P287MB0400:EE_
x-ms-office365-filtering-correlation-id: 4fabf9cb-55fe-408f-9934-08de4e151f4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0NjeE9XaStseEpZTmErMU1RQ21Dc2pRNGFPWG9mdzV3QUdxcmR6VlgreXR2?=
 =?utf-8?B?RjRid0NSbklrNGlBb21NekNvWlRsMzd5dThhdi96c3Vrd0szanY0YUxUNXox?=
 =?utf-8?B?OXFoNkk4c0FmSGFHQyt2ck9WMHJtL0kxRkVzakcydUZYell4Vk8zdndTOThJ?=
 =?utf-8?B?T1E5ankvSDlxOUl0TzFaZGg3ZktUY1QyM3IwNW5WNUtDcVFFeUpqOWk0ZGFZ?=
 =?utf-8?B?NzlIcTU0ZUhqbkJ5Z3NSSUIvcHM2T1JMNjkzUi95clFaZmxLQ0wyWGJNUnVJ?=
 =?utf-8?B?cmppRjVVcmRFbzdZZFNDbmtPdHUrdDQ3VW8xM0dNL2hvdnAwYTJuMjlzVm9q?=
 =?utf-8?B?SjBLTXBKODB1UkFkN1M5Zko4STBHbnF1bG5HcDR6UlB5VWxLcW01dFE1cngz?=
 =?utf-8?B?WGc2ZkxJMDRUM09YRGhMQWZlREl0dlRKdFhwQkZYUWxLRXBiMTVza28xOUxO?=
 =?utf-8?B?TmR4MUIxU0lTTTRLZHAvd09mQ1dFbmFHK3J0cXllWE54cWEzMmRORzFBOFk5?=
 =?utf-8?B?aDJxaHl4RXQwSmh2UE92RUQwKzZjclBtUThOVnZDQlk4NlZXTjl0aDVJai81?=
 =?utf-8?B?OWRTMVFWbDY4T09oN083anhBNFhldEdpZ29KUTNpQlVhbi84NHFMWUZyRDIw?=
 =?utf-8?B?RkJzOTV6YktsT1BHRlJsbE1DMURlTm4vV0RqOG9uUWVYTEFtUHFvaVBLczYx?=
 =?utf-8?B?QS9rQnArMjk1anpvdzlMdTdCelFGcXpYMUgxMmoyQVhqMmN2VzVOMXJibHJD?=
 =?utf-8?B?TURic2NpRjRVT0xsYlM1aGNIQ2ZtYjE5VmE3aWtVU1lGVHdPZk1jTHZVQkpP?=
 =?utf-8?B?dVNkMUljUWJINjJQUUM3dGRGdkU2dGw1cjdNNVJXVXZwUVI2d2tZWXFwZE10?=
 =?utf-8?B?UERKVTM5UXBtTGpYUkhLdUt6ckMxVk81RGhoOGJRZlRZMFdUWXl4UzJjbDVB?=
 =?utf-8?B?Szl0cjl6NVVWUENlNVE0L1dMY2RLLy9pSHpZTFlLTEZhQk0wdmYzeERLOFJK?=
 =?utf-8?B?bEFTeU5yU0MvT3VKWDN5NEZEOGVESHB0R3RYZzNZQUM4Q1VJMjA0SE5OUG9M?=
 =?utf-8?B?cGRTTnBSSzY0cGhaWnVjKzBPSFZmQW9LMDBGUXlhWlRVTU14TmFpdHlHbS9N?=
 =?utf-8?B?YzB3aUVMQlJJUnFRTU05RVhMSkc1R3FheTRnaE1sVndHYm94QlY0SklvSTdV?=
 =?utf-8?B?MG1tNzVvRzZwam1FeU1Mb3BES3NWR3A1clBhYlM3UnFoL0MzcUZhSlFNdG9w?=
 =?utf-8?B?RmUzaHAwSjVkSHN1R1NrQzRsdkU2Zjk4WWF6ZzFjc0Fva3BxQTQ2SnRVYUda?=
 =?utf-8?B?bHN6S25NaGRmZ0lvMzZFZVdlNHV1Z1lkL2wxVEM1bU9XbTFuS1RuQWZYK2JJ?=
 =?utf-8?B?Slc0WjFuQndydXY3dGlzSitKZEk2elByN2FYazEzenlpNDFLSnFiQ0xxU0ZL?=
 =?utf-8?B?VkQrVWthT09EWE9aeXQ5TUp0WnJ2QWFwcTlWWEVocUxHbU1HdHM3cXhQMzZz?=
 =?utf-8?B?Y2NGZ0FjRGk2aGpaakpydXFFYXRueVNERTBPTFhuK3BVeERwT0VnSk1jcCt1?=
 =?utf-8?B?V1BpK1VoNnliU1oxM3dDUGJjNDdnT1NrTVk3M0xXSk54Nkdsc2wrK0pVVU44?=
 =?utf-8?B?RkViS0lTS2ozd0d2VTJQckIwZld2RDh6b3VVTnFJUlk1cnZjZjBKOUVCeXFV?=
 =?utf-8?B?TGUzRm5WWUMvYmZxSUl4Q21KdW5JNGtnc2g3NXdycHFMd2s0K3FhRjRxL0Fq?=
 =?utf-8?B?MHpHMmdxTkE5WEpJbnNxRk0xVG12ajZha29Ja3R3U1VSdFN1cTBZb1N2Tmpx?=
 =?utf-8?B?eEFZeGlMWTRYRWlvT1JuS1FaY0FvczZheGtZeWpHc3ZTQ0ZEYzlxZTRZWnFk?=
 =?utf-8?B?VUhWOHdRdXBjSURyNmpRSzdkOFpZTDZhWU5GMFM0Rk0ySGRsNzRpZDVJNmV0?=
 =?utf-8?B?ZTlpbHlaMTh3ZWNmQWR6UVdHVTZ5cTk3Vk5iZmJwalNMamNQeWlmaGZzL1Vp?=
 =?utf-8?B?OERUYWVNaXg4MmVRSnArKzV2YlNWMTRTQ1NpUnpEaThCcGlFdExtY0d6TW5k?=
 =?utf-8?Q?6wMn1I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVk2bFlBaElpNEpyNUR0akFaRkc4a1hHUFJoWEJSc1U5UUc0TVFuRis4ZXU1?=
 =?utf-8?B?TVU1QURXODhrRWN3bTFWczRDMmFLdTRaNzdNQVBxK0w2TjFSbC9LcU9abFRM?=
 =?utf-8?B?bkR2YWZrSE9SaDZnam8xNkgreGFSRTROTkZIRU56QUtYQ2tFbUpoRkxONDVZ?=
 =?utf-8?B?QVAvbSswV3ovSWFPckwxUDBlYTJMS1p5Z2FOaW1GN2orb1ZXRGJVU0V3TlZO?=
 =?utf-8?B?dzE1L3lPbThFMWRlaTk1NCtRNjhGanBiaWhlMW4zQkZoQ2hqd0NRbkZrWU0r?=
 =?utf-8?B?Nm1nZjg3YmZKSjhVMTJFY00xQWtSNUtlSDFmbkprMnJUY1ozL0tNcXdVWmI5?=
 =?utf-8?B?R3d1UFZ5UnR4R0JINnR6NzJyNUJDektBZ0dLeWpwU0h2L1J3RGU0aFhQQXc3?=
 =?utf-8?B?dy9nM3c1blFmNEJDZG81cjAvc0t6N2N2ODZtVFdoY0VMUG4yMWt6YkNiUngw?=
 =?utf-8?B?VUNEQ0l4K2Q3azFPMXlZSklOYTJnYU5Ednl3L1BYNUc3c3pGaHQ3bGh1QVZC?=
 =?utf-8?B?M2VBQjZ1YzBhTUFNcDFWbUtmNnRuSUJnUnFLR2dhL3hMZVBaYm5nNjhVSWF3?=
 =?utf-8?B?Vm9qb1prZlJZcEZOdmQvZnRxK0c2dGkycEFjLytCYlRYUWlLdlBLS0kvZ2Fs?=
 =?utf-8?B?c1RTOEZzUGM5OG5BbnN0SVYyb3hoQ3FlZ3lKYUFKU3FSUTdvVU5McFpmcll5?=
 =?utf-8?B?T3FFaGlZaS9LR2t4TFBpSGgwT3NnemlqSUNtWkc5T0FNdUZVQVFabWVLcm5T?=
 =?utf-8?B?NDI2aWxkUGlsRU5hNTJUY2EvbFZURWNnbEd3TWRqUFR6emladFZLWS9xOFZo?=
 =?utf-8?B?WmpSNThDZVkrZHJubHUvOVFxNDVteEJPS0h0NENZZURUaEdsUGdGUGMwMHRI?=
 =?utf-8?B?dEt6NWpSZzJaUEtrcklpR1lWenAwL2c0dFArWGticVhDRjZqWHRlNXhOa0Vu?=
 =?utf-8?B?K3lteXhYNTE3d3d1cFFJZjJYdkdPNERPcUlJT3liMFBXY2dDU3A2SkFka0sw?=
 =?utf-8?B?UDE4QjhEQ0I3dG14bmJVVUZJR0N1cWFmUDB0Ti9HT2JWS3RkV3NPdkIyeDdk?=
 =?utf-8?B?LzNnT3krZDlISktCN0xWTHVKcFlndXYzemtVMXM5QkVHNUQ0R2R6aWZlK01W?=
 =?utf-8?B?NDhLNGpYUFdmc2lybE4zSzlVTGVLT0M3MUQ2YkZ0QUQ0RGJZUVo2OGNSOVhG?=
 =?utf-8?B?eEtkNFEzaFBBYWFRTnV3WGp2WHNGcWYvZHdsaEZuOFUzcXM1d1o1M2NDN0FY?=
 =?utf-8?B?ZUhpYkYzaGY3VHFmRXhIeDVHSWZ3NFdPd2FNN09waWhHNWN5dmk5cTJiMkxQ?=
 =?utf-8?B?T1VmWVgrY1k5TmVNWGgrNS9LYkE0WTVZWEo4Z3VOVkNJRWI0bDB3NGd3a3F5?=
 =?utf-8?B?SXJxdXY5elBWMlA5TnZHeUVRZWVYZzdpNWlNUTVYdXhnTDQ0ckRjbng3cjhU?=
 =?utf-8?B?bHRvZ1Jjd0k4dnJvcXNRcExYUm9SY2FOQzlMWmJ4YmFNdmMrOFlaUEtXVzVX?=
 =?utf-8?B?cHdZQWY0Z093bk9tSG5SVnRRQTRRZGtnNExjVlJYc0FwQ2E2NElsb3h6T3dX?=
 =?utf-8?B?bmttWDQwcnY0MXl1UUxNOVQrdkJ1MmlpZUZoVzJxaDVtcmwzSVZMRnBFTm9p?=
 =?utf-8?B?SEoySUN0QVkyM1FiUXFRaHhqSGlDdGN3Q1Y1UmZmWWRvTlpXaWc3YXRlSmRC?=
 =?utf-8?B?Mzk5dHFJZ24rK1NxZnlyRi9qKzJqSC92OVJDamk4dUJUT3JFZmdpY3BqMTlB?=
 =?utf-8?B?NnpUK2Z5OFg0WGRJWEtibVdnWVJlT1Z1UlJtWEtWREtoNE82Q2s0eFU4Uk9o?=
 =?utf-8?B?cE1MbEt6T2RkMkZ1V05GWVpnKzN4dHBxOGhoUmp3c2RNU1FZMkdqL1pHZTFO?=
 =?utf-8?B?Y1NtWGJmSVhHMU1SQXNLRFB6eDZ2MkNxYkptUS9IbGhCaGswVUQyV090YlNS?=
 =?utf-8?B?OWJGY2QvN0x1Rnd6ZlpBVWl5aE5zekd6azJMWWtGbmwvRGIzWTlRUnZXWVZq?=
 =?utf-8?B?bjFLTU5DQ0RVUlF0aFc2dG1PQmJsb21LR2cyNERCbjM1YUIzQVRkOVloQjVq?=
 =?utf-8?B?MDJIdTBLeTlva21NdHBHV1N2TEUyVnYwVmtSQUQ1a1FnZWlZNVpBVHVRSElu?=
 =?utf-8?B?YW8wUHZMc3Y2K0lwakZHU2FlY28wWHhKeit6SXhKdlVDaUNUckplZ01XK2w4?=
 =?utf-8?B?a1JQeUgraG11ZncvZFZNbGRMbjR1d3BUd3N5QS9GRlg2aFFSVUFOS0xJYVFL?=
 =?utf-8?B?Qmh6WTgwaVhBUjhnTFQ2eUtUMmdNR2lBNEtUZzNjaHhuY0h1UFNQU2V6QUwz?=
 =?utf-8?B?N09LOWRIa2xGQXBrQWl3Ym1ybEtXMnBGYXZFeWJEUmlFMFZ4TXUvMExJL3lI?=
 =?utf-8?Q?06zuLWhdcMO4LaEkkwcs22r2c8+aa9ymrpsTjSzZpg+wZ?=
x-ms-exchange-antispam-messagedata-1:
 l2S9blBXqW19THUWnecwxfSoPluo3rIsZVhJ8uFXNCGwZYrVsAtFdxqc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fabf9cb-55fe-408f-9934-08de4e151f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:49:35.9416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w94lOBHeG2flc+WhlnwVAm+fTMlaoB1BgIdTFvz0NQfKNl5mlQnGClWZTXoLIVdfBn39k+eMjGgWp0gxrJ1H5H4m1LqU4PNZ1gTDveMkRPfPJla5rMs9tZ5ja0dEklhZ3cap6kzF2CAWzxtVb4ZNYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0400
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGkgQ29yaW5uYSAmIEp0dXJuZXkgLA0KDQo+IEZvciBhIGJpdCBvZiBmdXR1cmUgcHJvb2Zpbmcs
IG1heWJlIHRoaXMgc2hvdWxkIGVuZCB3aXRoDQo+ICNlbHNlDQo+ICNlcnJvciB1bmtub3duIGFy
Y2hpdGVjdHVyZQ0KPiByYXRoZXIgdGhhbiBwbG91Z2hpbmcgb24gdG8gc2lsZW50bHkgcmV0dXJu
IHRoZSB1bm1vZGlmaWVkIHg/DQoNCj5Zb3UncmUgcmlnaHQsIG9mIGNvdXJzZS4gIFRoaXJ1bWFs
YWksIGlmIHlvdSdkIGxpa2UgdG8gYWRkIHRoaXMgaW4gYW5vdGhlciBwYXRjaCwgdGhhdCB3b3Vs
ZCBiZSBncmVhdC4NCg0KVGhhbmtzIGJvdGggZm9yIHRoZSBmZWVkYmFjaywgSSdsbCBzZW5kIGEg
cGF0Y2ggc2hvcnRseS4NCg0KPiBBbHNvLCB0byBiZSBoeXBlcmNvcnJlY3QgKHRoYXQgaXMsIEkg
ZG8gbm90IGV4cGVjdCBhbnlvbmUgdG8gZG8gDQo+IGFueXRoaW5nIGFib3V0IHRoaXMpOiBzaW5j
ZSBiaWctZW5kaWFuIEFSTSBpcyBhIHRoaW5nIChhbHRob3VnaCBub3QgDQo+IGZvciBXaW5kb3dz
KSBpcyB0aGVyZSBhIG1vcmUgdGlnaHRseSBzY29wZWQgZGVmaW5lIHdlIG1pZ2h0IHVzZSBoZXJl
Pw0KDQo+SXNuJ3QgdGhlIGFhcmNoNjQgYXJjaGl0ZWN0dXJlIHN1cHBvcnQgb24gV2luZG93cyBy
ZXN0cmljdGVkIHRvIExFIGFueXdheT8NCg0KV2luZG93cyBvbiBBUk0gKGJvdGggMzItYml0IGFu
ZCA2NC1iaXQvQVJNNjQpIGFsd2F5cyBydW5zIGluIGxpdHRsZS1lbmRpYW4gbW9kZS4NClJlZ2Fy
ZGluZyBhIG1vcmUgdGlnaHRseSBzY29wZWQgY2hlY2ssIHdlIGNhbiB1c2UgZWl0aGVyDQoNCmAj
ZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKSAmJiBfX0JZVEVfT1JERVJfXyA9PSBfX09SREVSX0xJ
VFRMRV9FTkRJQU5fX2ANCihvcikNCnRoZSBjb21waWxlci1wcm92aWRlZCBgX19BQVJDSDY0RUxf
X2AgbWFjcm8gdG8gbWFrZSB0aGUgZ3VhcmQgbW9yZSBwcmVjaXNlLg0KDQpXaGljaCBvZiB0aGVz
ZSB3b3VsZCB5b3UgcHJlZmVyIG1lIHRvIGluY2x1ZGUgaWYgd2UgZGVjaWRlIHRvIGFkZCB0aGUN
CmVuZGlhbi1zcGVjaWZpYyBjaGVjayBpbiB0aGUgdXBjb21pbmcgcGF0Y2g/DQoNClRoYW5rcywN
ClRoaXJ1DQoNCg==

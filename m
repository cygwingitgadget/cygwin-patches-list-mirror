Return-Path: <SRS0=VOg+=5G=teachmailconnect.com=madison.morris@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id 467773858D20;
	Wed, 29 Oct 2025 12:11:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 467773858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=teachmailconnect.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=teachmailconnect.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 467773858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1761739897; cv=pass;
	b=moFmmpBCzA0soKRxx4JBh6wrG4awdV9hdLsBDNWqqsYSq5G6wezq3dCFkXx5RVpFNa2M7uMbNbm66xP9pEy5t1wfKWUcEeLXpYoNeAqA0Bs62mhzaJN8pEV/Glai2VKiP2RLvXPWBg4A/5wnl3pBjIq0ov674r9m5+XnEpUazrY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761739897; c=relaxed/simple;
	bh=GRlhBdXNUehiRJLVu9LdvSZ4iUt1tti8Bl28jZDIHVg=;
	h=From:Subject:Date:Message-ID:MIME-Version; b=TiNkBbylL1SBHzvVRl1mDqYOGrVsnvL38hyWtQHpxM+rOoCpRQfUmFm/+rFkuD45efQoCOMcJO8DxyXIfH+p6KRa1DMcjGJUlEcdVGW9FFpyCa7FfIKX38N4Tpavhp8d+YZ0ntwUQ4qHdbFW40Ief1rh6AcxjLoNHDrMhRdPowo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 467773858D20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLLnZe00aU4mcbRk6ocQ/TkK9cWpQ1EbZcR8X2J8IkaTA/rAkfnv7KFB9gihveNeGEDD5830/c8J5ZXOs8a5Vum0wYU/rMh5YpqM58PuLJ1UafBltG1hw+/Ip6Y0iBp+OZfG8j7fBq7sBUFc2geR93gC+AW+4OXW5dcG6KJGTaloZZj3zQvd0Y1RvxkZ2c4RhTLF5Q2hNa2GuvmudJ93erQqlmyorGrAJmwqBT3am7gFKWct0G7k3vUH2S2hvIXgstK8JmPsvqr+114jNHrPw7DPTHk7rgng10Tzd16LSrPxGZLm8pti0vhox5wfSMRpSCykXJOQTq94xnOFHqnzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+lR0ePyb7Fjcq3XTZruk2sHZfs1IGjTPvHxND+/bVE=;
 b=rFijJQNoBNR7WKkyE/rhbK+t4lKUH9hjvakgn466HoiHEk2JDPBExXoEj9/cznxRGdamsxb5+rZek5K9btOeq9zxEisb+Nyq3wq9wVDLIHOVG/vvlpxIPpAA50b76TR7DsknkEB2PRQIFcLHJSNFVUCGGZMcoODump59Gicxon8HsSDAdQ4U4PRBj78KqJRA7WMjZF87SHp7eZmkdkGzSyslaEu8+EXXKt19zXv0xTVsdrR2Gu3v+pN7GEzRi0DUdjZ48+F8StRiVpnG2Z+QgAY1vmNYJC1lJ024nLITKsf9jP8I5Mh7CkPl91Az2dTPmHerd4zIWiZrwHrtjM1LMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teachmailconnect.com; dmarc=pass action=none
 header.from=teachmailconnect.com; dkim=pass header.d=teachmailconnect.com;
 arc=none
Received: from PN1P287MB2631.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:213::10)
 by PN3P287MB0825.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 12:11:30 +0000
Received: from PN1P287MB2631.INDP287.PROD.OUTLOOK.COM
 ([fe80::1499:310e:a27f:3337]) by PN1P287MB2631.INDP287.PROD.OUTLOOK.COM
 ([fe80::1499:310e:a27f:3337%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 12:11:30 +0000
From: Madison Morris <madison.morris@teachmailconnect.com>
Subject: =?Windows-1252?Q?K=9612_Decision_Makers_Contacts?=
Thread-Topic: =?Windows-1252?Q?K=9612_Decision_Makers_Contacts?=
Thread-Index: AdxIy5YSzEbirvm0RrKdgjLXDQUnyQ==
Date: Wed, 29 Oct 2025 12:11:30 +0000
Message-ID:
 <PN1P287MB2631D29F0835724250A6DCECFCFAA@PN1P287MB2631.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=teachmailconnect.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN1P287MB2631:EE_|PN3P287MB0825:EE_
x-ms-office365-filtering-correlation-id: cea88292-89fa-4cce-6276-08de16e44b3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|8096899003|10085299006|7055299006|27013499003;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?YjjzcM+xu6Gh0Kl0gT7rY8dExX3eRLLVUdVHH4v9ZsNRDS0OYGvzIutT?=
 =?Windows-1252?Q?pVtnQqmOEjjRwNBSkXZK0EztHpL4u2ympWlnbyGOUBFmVzcpIQpGxmAF?=
 =?Windows-1252?Q?5w4LXlE8jBSBkgoszctOWePRvPRaFYSlN48m2kZBhOEIj3RXiAI3dvJd?=
 =?Windows-1252?Q?wdYtw87xgi++Wu/z7wT9dFTE11+7bk7//29dAEL12ZZn7ZdsavWPzoAV?=
 =?Windows-1252?Q?BF6A93Id0fikJQc9f/adMGcpCIQgAFMWYct3b78lkBxl70Bv5VPKmNVx?=
 =?Windows-1252?Q?2nYRQEmgl6L0GqhY5NDdjW0IvPKpyiRLDrW1P9nO0NUvtWOCxBTEnOMb?=
 =?Windows-1252?Q?+EkyaP94N/rZRUratFgoFYcNvSbIZMqvkxzFyEwmfJ603zzywqr4iQ59?=
 =?Windows-1252?Q?BlI5VcdP0KVl6r293jKADH1w7hvfGXRbzEmUe/7KMcRwmOSPvYNSWYhv?=
 =?Windows-1252?Q?RNhNz/A19Z9wdCeGpV/nxStrBogtEjBRwJVSGhmpw6bUhKYuP+WNH/Xu?=
 =?Windows-1252?Q?eus3TuWBTrvVF7jXIhqgKPK04k7vVXJefpAj2ErHbxoIncdYSowGmeiU?=
 =?Windows-1252?Q?aur2fnWkWaOrRExpspNKWSU/8nVvk5/pH5QXt+XpjFu3j56Dk+4mcaCC?=
 =?Windows-1252?Q?y5k7ytX1EPDvllBoB2h9WSmiKNhLg2Gnk/8OQbb6MZE5bczAtdrk82j1?=
 =?Windows-1252?Q?e8UfN6rnneVsDU1S3VtNWJ7CdSGRikpAG23LiGkf1how9etzx3Lp1rhY?=
 =?Windows-1252?Q?zyVk9YUlCZzPK6yEwjvlinmgsCcIDMG+cwKpeTRSjnQM8M+E23UuHjxz?=
 =?Windows-1252?Q?YeQlfVkM0YBOAGz/SfGVZKBfu67XEUGggsC7awXyo/iFzbq6M/jOZv+U?=
 =?Windows-1252?Q?ZkvkDrDpSljI1eVzGMRoe0TXOxOV+aqXAjIuQiStNm4QZqij4XuTI/7z?=
 =?Windows-1252?Q?cF3UmO/pIIive9Q0NEl7tHtwfILMRxfa6cNwTZ3vrOw8WT3hI58xwawL?=
 =?Windows-1252?Q?RACl0C56qDZ+H4VW5HqolmsM0DuH01CYqli+qqAVmuT64k0YbIt005I5?=
 =?Windows-1252?Q?A69HdI3JxXvuEo2Yf/Ohqr5Wmo22D95jKBiwstJ6UKyKCQNF2hJDBLBV?=
 =?Windows-1252?Q?6PkvB2+QIZwHDpLxkCOfeuIsm9oMWTyXBNfLh+ASYp+1wJRtiVZPH9aE?=
 =?Windows-1252?Q?DkI1c2Ps3bnsIdBZK3KxsTczeGH08mxRuqwL/rgTxFoW2jwAwbJbLdAA?=
 =?Windows-1252?Q?vhSWnLWNjjaU5OS3qDfD9xeihLtJlcktMhNXvU07i3LjaggtWv9GjFX1?=
 =?Windows-1252?Q?X/yFjRW5IwEKfsd10/IB6bGQW4YtHqE4tM/Ve3lqWZ/P7LwcgqS6w5yq?=
 =?Windows-1252?Q?q+sayi53r1MfcwTuya7mEk2hfh3nDyTffc9zJJnC+kspI8lP6pbNrjoD?=
 =?Windows-1252?Q?mTsaatwz+WZGOdtsabMCcS+cRAGUG9yvxok0HM4tMu+WPHyw/VFLCVPz?=
 =?Windows-1252?Q?qr/84biXVuKz8+dUGdMEL3KCPBi6y5gBybPvqzxkXdRGGRqo5gIQdvRZ?=
 =?Windows-1252?Q?DsbOCx5v9OaJgFBoyC9w0L5G2gLXc1YqXYqkYt/MvufUBhbNlhB7SfsV?=
 =?Windows-1252?Q?jYVzt5VQPTvGGDoZr81akuCyAs8tJZkvI2XZIsAKE4oQIphYxx5AZWru?=
 =?Windows-1252?Q?SoaghL7GS/P3uPGY6wXQV/zWlLD2fPh9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN1P287MB2631.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(8096899003)(10085299006)(7055299006)(27013499003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?V4DT+TJNS0nS1xhzY+KtcsHuni+sDJGszbDOSp7guO5veHVBhPM7V3tv?=
 =?Windows-1252?Q?49aZJcoiwtxijh3adKNfUJ3pY6+I0TkzZPAs1EyBbKkAaoKgvQ7ycrP4?=
 =?Windows-1252?Q?3DCr1aZOlXzm0ku0ppRz1jroWDrIn2Ttj+cS+nOzuA1sboeg6lIfjBty?=
 =?Windows-1252?Q?yqosvZ1j+0BjzyfRfTS/ySi2wTlA1PEklvWN94Pia1QGsCBBpi6zNP8g?=
 =?Windows-1252?Q?TtRVrkhKe3YYPsObbDHYnJWIPsrSo9wH4QAspRc1tnIR9dNk+1GdVNEs?=
 =?Windows-1252?Q?GPZYU/0a8UMhXeToKuOj0oKA04iON5i+qIRDj5AsQ4O1yJITz1D6KoOM?=
 =?Windows-1252?Q?o2oijQh6Wrq9T4GiROGRim2YQus2GCW5vWXeiejWUggbhrBEZsh8dZ6X?=
 =?Windows-1252?Q?Oa13DnqbbatE4TLIhsQZaJDJOmOqC9ruY2VdrkQP+k08AxI+jtJgL2hf?=
 =?Windows-1252?Q?17oZmebF/xYt3CIX24jjw1zsP9Hv7mhf894LTOqE76smHoUaExiYYW2F?=
 =?Windows-1252?Q?P5dM2eCTLPFgpMngufhZtCoKWDCCyTuNkj1iDCJfGAFzF3E15PUM5Sqn?=
 =?Windows-1252?Q?YxdksDtBndQ05f77oWpI2Z870jhVwm8gEenSPCrmOhlfyP7dlDQNcc3o?=
 =?Windows-1252?Q?k6hmyQX8HGZNWfcne6bR3uSORu/XQPnK6r3yccvB670TniiWqKKyfhvS?=
 =?Windows-1252?Q?XURhYQT4S3W69XKEMx/zBci6ohsdq2KPPtDng7PqLW7Diu1100GOtqjv?=
 =?Windows-1252?Q?maMCTa147qn/WS+r/rgXZBAL0hi4wTWxMJgzU+0vCJdbIQpsv+feeqxU?=
 =?Windows-1252?Q?VVAzVJyEb0XTG8EENsT4AB+rQWfB3SjgDqxWmgBHYiLHd/uRMbUcGLBu?=
 =?Windows-1252?Q?dayXeEA1ttSGjm6UjdqY62sFp2ZppfbQICAd5y59S8cIbyJzKoxFcoEL?=
 =?Windows-1252?Q?5LN7EIsO5ZojnBSW8qV99zAA37yMHK5XuypZ1hSQqB5JB78M4BbzMmlt?=
 =?Windows-1252?Q?o+UGv9QLdRcHRnqbpCd735w8rQ0VwlfEUjTEc60B+SKh+VxCjsXeU4ki?=
 =?Windows-1252?Q?VaUDy+90idC4oTfb/fYm4QICKD5oqg8yZB40/F4agqgp6kSyqyK4iQcX?=
 =?Windows-1252?Q?FGj0Z8UsOGma7x7U0Ut25svh5i55v5ec3XiIZx1dv5i6FSHiQpDf+rMF?=
 =?Windows-1252?Q?IUsXB5r2MDVY7HAXQRw4Z+ONkqpAAEUIJp2uyvZPdFWY/3R+/dT5WFAD?=
 =?Windows-1252?Q?jSEOocx46QQxgqUODWYIJZZEQKssYmJ7VOPajAjfQJdP1hwUgnJs5DQ7?=
 =?Windows-1252?Q?y9DVpXoOwgX3evJKPD+WY01oXpM3cCkAzbCjuStHUwK2EsOEmu8+TuXw?=
 =?Windows-1252?Q?4xvZY1am3JYsZWIyZ08LkSDXUqH/Bjf2JZPmARD8j1VRcNVuLDz6+dol?=
 =?Windows-1252?Q?y6EdExNLIhpVluqe/4JAryj269HhTMAV4dt7HEonX4OUzJr5eQzH86b7?=
 =?Windows-1252?Q?tEkzx3UulmhAXn8PuCKuobTxPt0kGVUVAtRFnPH7VEMXwyrrgAneDQgx?=
 =?Windows-1252?Q?HM+SU2ZGBo3tmqfnhk+x7AvHzyQoBOJo4Ilm/R91LfuaigMR95xLKZ/9?=
 =?Windows-1252?Q?N3MdXNgZNwfjX+df8cpw/QQzvEI69eJSUye6Bz+2jkIh0JRD0YHTjzhs?=
 =?Windows-1252?Q?o+JJ6olVdC7L3P1cqdPy8bR3155sU1PrHEynzA5T/f6c2quJhpXHFvVx?=
 =?Windows-1252?Q?epj5c5iKdZk593lpI6s/az8GZwX+LHAWUMjhEFB3?=
Content-Type: multipart/alternative;
	boundary="_000_PN1P287MB2631D29F0835724250A6DCECFCFAAPN1P287MB2631INDP_"
MIME-Version: 1.0
X-OriginatorOrg: teachmailconnect.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN1P287MB2631.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cea88292-89fa-4cce-6276-08de16e44b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 12:11:30.3871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a17c0155-44a1-47ec-850a-ebedd0d6b02d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOIVn4kWwIGw1ijzbyiNFo2dXgRszxZrsk4LWQZwA9WuQQgJzsonP3FLxAukirHgxcRr8x9HjcEIuxDOoeJ9qpO2/A5wyccmmkodI6H5t2+MWreiJ+jyYJhnGM/iXJmLqCU0IaZdd82stF+jSMtYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0825
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,HTML_MESSAGE,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN1P287MB2631D29F0835724250A6DCECFCFAAPN1P287MB2631INDP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi there,

Would you be interested in an email list of U.S. school districts?

We have verified contacts for Superintendents, IT Directors, K=9612 schools=
, dance & music schools, and athletic directors.

If yes, reply with your target geography and role and I=92ll send sample co=
unts and a short preview.

Thanks,
Madison Morris

(If this isn=92t relevant, just reply =93No=94 and I=92ll remove you.)


--_000_PN1P287MB2631D29F0835724250A6DCECFCFAAPN1P287MB2631INDP_--

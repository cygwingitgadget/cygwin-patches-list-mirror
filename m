Return-Path: <SRS0=kNIP=2F=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on20717.outbound.protection.outlook.com [IPv6:2a01:111:f403:2606::717])
	by sourceware.org (Postfix) with ESMTPS id 0C800385B51A
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 19:24:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0C800385B51A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0C800385B51A
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2606::717
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753385085; cv=pass;
	b=p1vk35vh9CUFRW4G7lI15cuNfJ9GxQjzMWQk7ROufmoCmQxzsvNtJ5aJNu5mtvgUENyHpyQBkUSmMPpgx5LTsmhzlUPI2AkC0m+EEz+YjP3C1tWuu7Lgc0mVWJRRY+xLpcroIiPrwdhvOv1A8+OZZOU+Tm3zToQmBDiUBIgGMMA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753385085; c=relaxed/simple;
	bh=IJ+MfTX+I9uFkjl52HAa0jJLkCHB7ZOC6bNOW+jsyIE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=lfMDbFX7lMK/EIkIsuNKDrrfvPSyyzb5CnHKaoadYzp65USkLKvf04M+cGQnb5msVGwQOXb8cWcotzE9RgKJnt2D00P1TbGPyiwRoKB3QVBtGC6EsQ/GyDlZF0SBn+vlpJkEUSLp//4Gqzi74q0QWLDxgKCibqrQ25zLa7ZcjwA=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0C800385B51A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=hBjZ/COS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfzrXkZ85ZFEOAhKPsOp6bg3OmO1Cee/cp3Iricg/g2KVWj272NNFRDtLghrUDfuVp/Hqwik4SvLmqeB6HNvBhZFw9Y5yK8e7zmvj68jR8kijhQTfqUCUBWWQm3pG8y6POMrfd2Tr8sNy6xpJVAx1BivEQp7/38JQvKdTjxcdgpK2b7nLERqkYQORij1SDhHjBV6ITo+S4Nn5ONtthxJPLGfQnuDaoWVTWf7YKf6kuoNOI9CXsodiTyx0W9pwwOWX+Ie1iNZkU4YLkc/ftwW0nxu4YY1p0X7ArZbhPX5tLofSt8Sp6O7QBUg8DFgybP41uOh+pftm1ktuVczw+5jDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ+MfTX+I9uFkjl52HAa0jJLkCHB7ZOC6bNOW+jsyIE=;
 b=e16IvFPmOn/vTYbKieBgOixq1IbGiO0jAcUMWvjmGJ6ybU6ys1UqavNvB35+UyNMZOuxq6IiYlxI3BG6bxVwRIi+8BuX5MKQRwcYKxRfFCcofGpl91qXgmb1floYRpWiXIfISJ5cFL3xmCpsKlcd5YnA/iNHf7k5S4EjMbOI4Q/TCfK/OuNOqwtjG7dNvQNGr/yhBDA7Unduc/zeXHUzZjAbrb6sDrAG4sfSmoZFx9/D0bkMAV6VIkFSRw7s8vNkay5xn7lXZZhh23d2KMywpHgAdop92aqie3pW6b7uRRfgORFEdzf2KZB7M+5BlZdTaf8Nz9tRoktu1dFo6+fkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ+MfTX+I9uFkjl52HAa0jJLkCHB7ZOC6bNOW+jsyIE=;
 b=hBjZ/COSWTk2zdY+6YKk2/qPestCmRw+Q4FQyKYn9M9XAyzwg9gMDsmFGWfH5c1eFDZ7QIlek1lF5YOLws/vs36jKMlP5e6YeF5rvR/rqj6DHO9g/HEplCSgcTX1/tL97EbXrjzSZ0mufNWfQi4XEPaPbPbcFQSO4CAMJf0sxns=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GVXPR83MB0653.EURPRD83.prod.outlook.com (2603:10a6:150:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.7; Thu, 24 Jul
 2025 19:24:41 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e%4]) with mapi id 15.20.8989.006; Thu, 24 Jul 2025
 19:24:41 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Topic: [PATCH v2] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
Thread-Index: AQHb/NCaikO8/3i4vUmqb09FyPnoXQ==
Date: Thu, 24 Jul 2025 19:24:41 +0000
Message-ID:
 <DB9PR83MB0923755B98F67AF6840E3284925EA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
 <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9jZCS92AGUaP-o@calimero.vinschen.de>
 <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com>
 <aICZuCg3tKXOj_mR@calimero.vinschen.de>
In-Reply-To: <aICZuCg3tKXOj_mR@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-24T19:24:39.829Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GVXPR83MB0653:EE_
x-ms-office365-filtering-correlation-id: 20745d38-c00d-4b2b-daa5-08ddcae7bcdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?S93LpFAqNqZZ+lwiMcRCZkyAvmfAZ+4/Ea3EHPpnLVUD8Aqttv8FkCwAcw?=
 =?iso-8859-1?Q?mWo7YSCRkaSXQ0Uw47WvDVs+iXsLv9Wo/6xhS7MxteHoGD7fs4yjbE8/+b?=
 =?iso-8859-1?Q?q0699eGD2LDbDAfq+YbSXbE+uyEwyzHTBLfpjTKivI5C1WgcL+aaqsd2/V?=
 =?iso-8859-1?Q?60cA+tw5GpNkgvneBfjBI1pf7b9qSftxHqluyyOf586F+IUKoZplcYaxVo?=
 =?iso-8859-1?Q?fkZhwa8zXRgmVtyIXAC2aOdzP6CHgzozhdDZYtjmt4gf0aO9l7k+VT/M/n?=
 =?iso-8859-1?Q?mlqK48jYWq2IkoGGI86xSrFnxutQ3isyGy5n9chu7gPhNDBY04lk3z9Ovp?=
 =?iso-8859-1?Q?JTgwkNmPDRPa0Ber+7+CDOvB5bnGYznA2qlOkaeTppxpdc1HceREsagjmE?=
 =?iso-8859-1?Q?R8z+4kwEc7i0DzI6wnrZ1NGSqQA8TbSyrvx0PYMQRx629c4dH5M9O1aB0b?=
 =?iso-8859-1?Q?9DaK21Rw7a1RobqF/7hwMs4Oo6/AUC/0Ecv6xfYNeRIvqdL0rJ/XSqVMFL?=
 =?iso-8859-1?Q?FDeYWOqfAOQMm3dGSHvepioewGTanhKRVDQCYJV0BNEE0vp8Pdgu1MOj0u?=
 =?iso-8859-1?Q?Z60pqDGgZ5ejr3MgBU0Fgz47f6p74S5ooeoiCDIn7m1dvZXeRqsvOVUHKE?=
 =?iso-8859-1?Q?8kS82z2CILtYcmYik8/fxOwEdyxveMX837K+1HWFep2OCBucoInYFPIL+s?=
 =?iso-8859-1?Q?3Xtd1BDvUIXd1pOhSnBeI9lZU8aShj332XZsmDvJQdD7bBsQaBrjUtFFzX?=
 =?iso-8859-1?Q?dHiAuUlcqnJtpGk/gFtjMPfo7yHe2/CW068azJ84+O95e8tRzNbRP1ANmW?=
 =?iso-8859-1?Q?PANmTE0VDGblUdVp8NbAhqtv3MveiyTeZeH9Hdr2sUXd6OokknZT3q1ZVy?=
 =?iso-8859-1?Q?e+Zn3QBNuxPfWPRFgAQ3T4lhVI4kifrCE2NAQyGYcwNK8nCE4FaEHPKT0b?=
 =?iso-8859-1?Q?PW2wkmYMrMUG1hV5wjQALsZrVCWVPT5Iv/ai72xdFdXa5zSNzG5Te7/CQM?=
 =?iso-8859-1?Q?y4NgKZ5LEEAexlxV48kZHjus6cTjEXW1bK4KKTkcM4cyLaz26vZAd+rkIP?=
 =?iso-8859-1?Q?heR4AHeoro7VvUce5FO38IV9bn1s/Q3FFDlvq1f0xKlVPOcXnMgNXxLg+J?=
 =?iso-8859-1?Q?an3scunW++m+VRy4LBDjFrLLtfTjmxHWEwg+x+7R4u1XYu7CT55pcvi7Ck?=
 =?iso-8859-1?Q?6BFf9/KRtCRQp5mmZRtrzmrWbAd4Dee1COCYJcKS+9IzoLYS53uoKrih9K?=
 =?iso-8859-1?Q?f767wXr9BUVp7Kq8XDoFQ3D+Zmh8GPniEARb0CU+CCvOfCvco6KO9A/8PK?=
 =?iso-8859-1?Q?m5/BVXS1wAWVoYInE4gNDQsD5wtf0s4FValFvzq3/HIN2f4gAaiMgogwev?=
 =?iso-8859-1?Q?+HrFZbjFST/D6fvP2CbLORY8LztZuG2OKqlu6BkBAn8/ky3n/FnS1wzs6e?=
 =?iso-8859-1?Q?APFFeiSQlTa6Jtm6zTVOKbdHdy9m2gnkJFOxLyJQpwUAS0IPoS/p2TgzM9?=
 =?iso-8859-1?Q?yWlCKgEeEvGraHmiAQH1+utU5fbLHGs/3Ow3z9kcTGew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nv3ZgYs0TpUxWKvNl0zwJK8XOGqmXYihHNk8h2lFfI6FkJYpQi7BBySwIC?=
 =?iso-8859-1?Q?1+pdt1BDGVZHp4HiWrUQZDeTUQL+/OfK+4ocOKa5q3JCe1M0bC5TlLYbk6?=
 =?iso-8859-1?Q?ywqe3h7r25Dqnnb5fFN9NI8xwuPdiR/sovFnNecjY2alFCbPdbegHwKrLX?=
 =?iso-8859-1?Q?E0fJUj+jaxJPTgyy76xTISyvp5dBVDvodn2+63RbC2pmyWSOXWcH/gN7xF?=
 =?iso-8859-1?Q?t8DYbYCsCq8Mmgya8NeLMReDGKzM5UhKyyGcf13LbP4YDDJH3v9CnUvduv?=
 =?iso-8859-1?Q?yWSYVyUfII9FfTkVbgn+vw9B5fYD1khBahuMDGpu+8rAYgs4PD4jWh4/nT?=
 =?iso-8859-1?Q?El1WUGtsGEDqs5u/YAIz0i19O3pOwCjJsAxBa6imURv6fBE0tEaxtA0cqc?=
 =?iso-8859-1?Q?c4/21zHIMB/SZWk7PpVVpzfDCj/AvNzh9cxBNTIN9Atq16LuRVCfb6T/fp?=
 =?iso-8859-1?Q?2S7GnD2Y1PQZ8Dd3xxPDX2SOsNi9RzvMFpp7vvBsjXBxhiZu3v2+uyQr7B?=
 =?iso-8859-1?Q?pT7pekuBrVOarcY7wBs3FWGljXkg23rXt1uNsYIvLm84jAfJ6j/F3CZRrK?=
 =?iso-8859-1?Q?LjVvbmKaWBOjDAvov69tS8wtmNadqf4uyyQmzQrQ0ufFx7V7kYQmo97ae9?=
 =?iso-8859-1?Q?LB8KpBTsml0ICohv7nvZuKCB2TAD14P/oV1uHAHMh3EdHKz0NDPWKL3Bt4?=
 =?iso-8859-1?Q?w9vUmUNyZU82+OHzRYWeYeXZyDhQZadOCx8FGFokfsYQvUiYUIbvVeUAcS?=
 =?iso-8859-1?Q?zFssG1a5wucUSB6YZOKKVMBQymPRMf83Wrvh9+SVYq0k/WvWeaxIlCt8n0?=
 =?iso-8859-1?Q?GbKZYS3BDraey7ZXPleC5K5ILZ3ZMNf8eqt9RMdypW112wcQsXgcyzJd1P?=
 =?iso-8859-1?Q?UP/slQDTJSaBPyEADLI2zAj0panV2dGRxtd6GgzOhRhXWfnaJ6EDh+yGOa?=
 =?iso-8859-1?Q?OexfC0JCnT6bhb6XST0i6SsOVu+XU/DzJN2qdJjW1xsWhtME7z62p1wwXR?=
 =?iso-8859-1?Q?L98gc4tZDjfsXo9E3XL4XaSbuptFul2yCfTlMvV0QKlK/5Q8/GyQDIdMyz?=
 =?iso-8859-1?Q?KR+UBhL8G82N1k4vGtNcBR3aMqIHuBJWcn7LOTOGbInfRwictt9zTKwYKc?=
 =?iso-8859-1?Q?h1xMY9/sPR34J1loUecvpzEDhToFmzUvsnlx3g2VaPcfAMoa97AXxo+F4z?=
 =?iso-8859-1?Q?DuoMsMgIpWsEXFUh6smpLSZhhBbDolDQNBH+YpMmX+892HyPlVuPmOE98e?=
 =?iso-8859-1?Q?i0MD42KXMqbICZs5YI9AXIPJWHFGZwVjffMfPxfy4ugeYMqftCFF5g6v+U?=
 =?iso-8859-1?Q?4V0Gbn6H0FKQYeQhkTD027E6pUZmeuExhQ8zzCz4trTUQKl1EJBzy901EY?=
 =?iso-8859-1?Q?zKTdiLCz7EynsDXEnAwsxcGU+TFq61KU34gSfeCim9PblcoGtRyiP9r7Di?=
 =?iso-8859-1?Q?F3Us0y9ux2CTkZTgYyAcojNvwIKqGRr6z+lLeO96eYrynItPZjjFOdqE13?=
 =?iso-8859-1?Q?OFLCVpMyxqlgVFxzNGbqkqEl0oAQzasThrNDRduWBiGwmA0ntkSq8LuQXS?=
 =?iso-8859-1?Q?XV0y6skOizRKL3EtsddWaNnzaKpy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20745d38-c00d-4b2b-daa5-08ddcae7bcdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 19:24:41.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/dSa7VhRXeqB7RzBDGNxvZjQxIDBabQAiD9iXtX5f0DedfAVoKozp2eKONa3JAfy1XyUB5ueIXvg65zDjIFzcKtRrLEEu3Cd7zw7Hg6lxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0653
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
Wrong thread, sorry.=0A=
=0A=
Radek=

Return-Path: <SRS0=FMPm=YU=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id 5EEDD3857439
	for <cygwin-patches@cygwin.com>; Thu,  5 Jun 2025 07:46:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5EEDD3857439
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5EEDD3857439
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1749109587; cv=pass;
	b=Sdlrp+50AFEXDnXoNPH1OtjJBe0FsOn29tCluSDqUwQU66vYKgACJ4lMNgpWXCsBWGxsntGq1m/vYb0flRuc6OlTgcZVoux7TOoDYVPP9AITZZ0ldnRncTwgM0Qk2n/6PbsOipeLx/ISGEymXF4880MC75itaX7ALx8eK0MID1c=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749109587; c=relaxed/simple;
	bh=u9JxHFDlmSYvPQXwU7m5CE+vIFEVAes1ICWBLEo0MZk=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ullVdDtsHgw0IV69BWH6+C2mOPg+op005bTXqmY3xL10a7SskZ9mG1yesNly/3R51NZv/D3hyXO9dmF06yRu3/FeB8dlGZD1utQdqWifVBsgXHgAZEIXadIL2NsHg74eNHlx7pzEWVOSJ/2rEV9r7AOIql07YiR764JjNaRFQeM=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5EEDD3857439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=StT2haPa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQe7Lkrssk6tszDnjfP0VItqVyhzRnfRtptQl7MVkUvBth2qbySLTzFguxazjS7mXH+i29Pp0815MpjcJDeYnMs36DmRkLYFq4qbXGT0VXUQvUg2YFGdxdWEnMXu69yK0wWVHhmRhDIAkngjuv6atbdJoM7JydCKypsAU6LVJlxfdOuuC6pwg1Ck0yuHgFL2pgF9Tqz70pBOaZ9MkvY63BloahXCz/1dEGpoyHhXkVy+0d+3e4f4EvpBcb8B9KM0yTHubXSnHHYW7He2ItzHpc5S5Tf0jk9Yr8saul26ylP0hho/te4w+wz0oIvY6wOHnA4NaeNFDaHmCDhmmSqYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOnIyjcpfH483J/qBfMEZwlkBJHL8dkHpFBwExgJM2o=;
 b=A2vPhss3dV9dMFBQ6nGRGGPASwNZIZbpUtNBu1+EsD85BAkXAqFYDCvu9oXT70BgD1zPcIK96/BKUAivzk7sKOysLgqJOUrmK9GgVqeUU+qTWlsgaY0c+KXxl4kJs85Qau8YUBWRJYLKagtfG4PBzMiXvRSVs/OyA304K5vVrAFqBHhtO7ZAAZfZkObIwFmGdhXne8aIva4n5aWHDGbZ28Ub6f1w6d9XVOKZFXRJKGMmV4+mFw0cUwDPAz0x8UAA5aEBxVjlbS6A9Qg+hvbuG7DethdpdghBKZR63Fwk85Z6DsRlHkJYQ9Q1hTWBIsOaozKmppXQpBh+ePTw6xV+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOnIyjcpfH483J/qBfMEZwlkBJHL8dkHpFBwExgJM2o=;
 b=StT2haPaCw248xRukRmKPsRdgXdqlTDgfGBGUDYo/LqH6sA/F2nb3g/0t89j9F9TofaXOJQ4rm6L6xMrb/941BrMc/es7WIE/xmodixslFcj0nIGmeaP0nexq7FHJ9TGHPXJzzTFgX6Rz80mz4OjpWPAJX46uFODgOdTumdASRhfEQ4s3lSlYSUTZg+UJbs9tnHUEa+wcrp/7ndd9GI8hGqfu9fQzWjKYY7XC9an5H22ehj4kOzmV9blScztS708Q0cWOqPZFf0+QOOSBTtjfSPByV2Peh0HNIF+kVqmsvhjFo6snhl0/MZuKlgtx4fyc0cZ33Y6+pXeV/WYdP/KSw==
Received: from PN2P287MB3085.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:234::18)
 by MAYP287MB3659.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:14b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 07:46:20 +0000
Received: from PN2P287MB3085.INDP287.PROD.OUTLOOK.COM
 ([fe80::8bab:1b7f:5ac3:8a46]) by PN2P287MB3085.INDP287.PROD.OUTLOOK.COM
 ([fe80::8bab:1b7f:5ac3:8a46%6]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 07:46:20 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: Aarch64: Add inline assembly pthread wrapper
Thread-Topic: [PATCH] Cygwin: Aarch64: Add inline assembly pthread wrapper
Thread-Index: AQHb1e1aFwA/tRfncUC0fNnxPwzHXQ==
Date: Thu, 5 Jun 2025 07:46:20 +0000
Message-ID:
 <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2P287MB3085:EE_|MAYP287MB3659:EE_
x-ms-office365-filtering-correlation-id: 3c94949c-ab79-46c6-325a-08dda4050ff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003|8096899003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?K4ANXl6xI1dueX/pp6qQT8qYgFFj55HNy90QmuzFwTX1eVLqEnUNHYaziE?=
 =?iso-8859-1?Q?5Kcee+rlLmydHVmn6jjq1471MQnPS8+Jo3+RQ8RBdD8pnFd5XaSxqaCIw1?=
 =?iso-8859-1?Q?aeKS7vB0+JrEUS1TcNXYHXNq7VShiuzEJM3nYpT+IEjfMHl72Dex1sbYtW?=
 =?iso-8859-1?Q?lknxfd5UNwsOSnV/zF6oOavtJAJdkhVZ2I6ZVwPPRUNr0D2KA0nZLo/sNE?=
 =?iso-8859-1?Q?W4ChJNvMiMRN4GWQ2BXyoHZp0nDTEfFlij6BjrgskcoG01WjbQs+wXjp6G?=
 =?iso-8859-1?Q?ksCGlRFgJVSamh81vaSNqLsb62vk/8azsJn0KJZamE446ZEaJFnHkPXDL6?=
 =?iso-8859-1?Q?B2D/t3YXbOJf5oePKvPRWLMbP4Gcfx4DlPdJyAvhYmMYuvwOBkDuE/nJlG?=
 =?iso-8859-1?Q?4MSvYb/VFBNa+VLAlkY2hJR2UWqfyDmxPbc0uBiNpxG/pxrM7vLTOt0EKr?=
 =?iso-8859-1?Q?bwfwpH8D1H0q0AHJ/iIAbtvO98Mp7C15L5sI2lECYQh/XRcEqB9KmhD3HX?=
 =?iso-8859-1?Q?w2dKs2gu4IS0jP+2JQ826ZNYZqeR/6x1tYM80TIOSoe9Cp5LqYIuspsoEG?=
 =?iso-8859-1?Q?cfkxN8h2CRY9A8h0RnBnJ93VS5NFphPmocY7UX+JLEAi+xqMaY1SMxb9yg?=
 =?iso-8859-1?Q?Sl6uwUc3MWQbSxJqlr2e2u/VAx1Ktj8Dt/+gHJi5DQa+xBRbRuotDhZHIh?=
 =?iso-8859-1?Q?icmNDcPM+yv2EZpTS1DlI8JHp2vIn8i1mQ8QHuD3xJ80kNigold2Bk8Zn9?=
 =?iso-8859-1?Q?VThIHORgFbMmEsEDiAFlOMfgxwaWfOIXeuZ+vwubuatTh+yar4Yo+FJ7T5?=
 =?iso-8859-1?Q?ou99dEsMinkjATgIbfShocpagWFIRNke5DnN4g0cuksfX4bEwENdiABPb7?=
 =?iso-8859-1?Q?oGcIzvvlJ+FfEYsV0q3TE0YDJQ3B3OfGaO6Z/H0ctU0royZMVSEGvm8M/9?=
 =?iso-8859-1?Q?74uZh5zIQ6WlzH2HTFTA2pRLj5HD9j5YJOdtMf+KtCuJCT8j09/1kVvzUz?=
 =?iso-8859-1?Q?N8cjSJYJKOGehiJjPFB/tI9sOSfpC6FEAeiKKkJ1Y3AI1GWdOi9NPX2AU1?=
 =?iso-8859-1?Q?AXEEYmzCGP1i0csRGgbmgxBfBqdAaIfM2j5GHGdRZjeFfbZll8llwsyyAT?=
 =?iso-8859-1?Q?95NoZ4H8JF+xB17ZvKrxu77hj/ZjTab0SSNU4OwSF4007jrD6uT8qlFGNN?=
 =?iso-8859-1?Q?CxZM8cgpVFJQ8ajtNNUS+eZ7nvw9Mo8wRcA/dGCd+q74ccvyoDaobo0PHQ?=
 =?iso-8859-1?Q?u/FB6SFmlZk4Z87XnpHuPJ70BnaIBHyW+XKzcK0MHrdDJRqbpiI5H+04Wi?=
 =?iso-8859-1?Q?uY44DQB7s0Gv6bgpqig7ghWQckoWv4Z0koBlXYcsq/8RH84Jk9rqJP2fcy?=
 =?iso-8859-1?Q?0xkstyUmRX+4Q79rlrE0HGizpGZVaRO7NBIT30BfZ7CI6GbgK2uCyR7Itt?=
 =?iso-8859-1?Q?QvECcJ5luOV9QinT/xqJZwIMxufJ9QXLbxqL8ji0L4Q3U7PDre3OuGdpVD?=
 =?iso-8859-1?Q?Bcq7vXuaWd3TNksGOeOYf/ngKUFVF8+G9ouddsYX3mIoAc6O1bOxG1kSTr?=
 =?iso-8859-1?Q?HK5eCCM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB3085.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DSZD0Yd+44eJlfWULL/SWTK4Apk3KofOiQHjQ4vWGmVs2LMl3gfTC/fqEF?=
 =?iso-8859-1?Q?a8z/jT6aSovPod+N6vOeJl2MmRPPBIjnm/A6jG1h/z1cB8dYf2o9PF3S2P?=
 =?iso-8859-1?Q?FZ5xV/8K8KK63LAZyoccL2iXN9pMpLUhj/5JD/8peNx8LPZaWeRyvVZzJV?=
 =?iso-8859-1?Q?o/V2vyFJfpxrwf0SFu3/GVHew2AAOSkcFFXN/+2wHW/eEBYA8dfqQ0B2cb?=
 =?iso-8859-1?Q?3NJh4QSjeZ7voSHBzsZvy47JSHJcxd4n34neG6gZR1XSGtT0iarnFDGDKR?=
 =?iso-8859-1?Q?BG9fOqgoqCitG5xy1T5Le6gwiyXFHYY4fixsf0rP/nY6XaC02XTp4pG+8v?=
 =?iso-8859-1?Q?o1pN3EZSLwafy52kGhZB1dj6lztgcNU5tMcbWiBDigArZXtG076zLC0waM?=
 =?iso-8859-1?Q?2RYOQzeiEHtVl2rXYUvyS8Gp4a+A6T7igfgrvOiz4xnPYS0v+lhmW0KcIF?=
 =?iso-8859-1?Q?0D8FWEuCOQaEJ6h+VAnQFY6zTuSL3bicODaKNR7LZAZjoPYojEntflzm3O?=
 =?iso-8859-1?Q?iHm/UrG9vJtmxUwdoFNzp1jVb/AAn0srRtJ2FCpk/FwJzoCJoruAca0hUc?=
 =?iso-8859-1?Q?f0vk7JnN9K2L500vJG9AhUemYg9N/qnD57ujsIv1c9G9+gycaoZ3fwhscz?=
 =?iso-8859-1?Q?VSyBYxje85Ec/cXXpVsKdmVr1F2mkxJ6ZUZhtNLeFvaLgLSg0oAFWT8YaW?=
 =?iso-8859-1?Q?Th/IFKv69bHAIHvrMwMq6JQS/1Cv6lsZcnJBTUNXvaii4JDwTmxlV4/aHD?=
 =?iso-8859-1?Q?kXQNdR+7uGTwKT5wNhw0sg0KqGQO9PX6AwRQ4RIOcJ4stVIK8Xll4CNL3k?=
 =?iso-8859-1?Q?EIg2Pj0U3TCcivXZeCxFi+2y1KkSe9Mlxqe1tj51FiuxqPTRZEtisCdAj/?=
 =?iso-8859-1?Q?a3Q9QoU3k3zoqL1wRJPzCEongS+IUQ4Lxhun6dbgBYdrYVcn8hjdZ0PRxl?=
 =?iso-8859-1?Q?3UnQupeZc84R2R7R5qzJo5SPfO83ylVNwfcS8w3Y+qny9IcHkDwVNKZMdX?=
 =?iso-8859-1?Q?e8TC3da+d4r9HDPpCD63Yl2oGkunJAgvP2RpYU3BBIB5bIcyZAroZy3+mm?=
 =?iso-8859-1?Q?jSlEcr+nuELXQyR5OP0VCdD+EYbZtHBE2dqUmFAbPPXG/JNvsDAKhFMGCw?=
 =?iso-8859-1?Q?6ws5j6+mXziZW7b8XR/DiJRFfgZKd06HkKBTmrwejCbUZOdBrSsmrcSp8w?=
 =?iso-8859-1?Q?lH4Bcjp97gUbYiFYAwe1+x2qHHzZhHkN2AbOBY7txiDX5HkcJEzbOwWj9s?=
 =?iso-8859-1?Q?zkWw+nhwXBx2V0z0Olj0bzwc0BE7wh7Sv8BgoGkUAUWvy1BCHyxkxDSwfJ?=
 =?iso-8859-1?Q?m5lI3MIw6Em1IGylT7AqGwIYMwNo/IoMzbvFXHXPULy4AIbrHd/F/oEHgK?=
 =?iso-8859-1?Q?xwpRXBwJyq2tEiOcfhr+1KBmd1dg41agIEt5F72Dg01L2a5mZ1vLEva4Oi?=
 =?iso-8859-1?Q?TkMhz70Yq7SqUeDBsjHhQeAtRb+J6Xf7r2naceZXmmHS5/Ssb/Sjuu4FoE?=
 =?iso-8859-1?Q?NGmSRZ7r/SOgw0Fk/9kG3HvA8krNd0ryDMTAe8hSokxPRhUipeFD8dHLxU?=
 =?iso-8859-1?Q?zFmy/PPoxMa6FZvCkDcsu3aCZAZk0GKYOKkbRu4W5EnPpuxFVtesiL5U8+?=
 =?iso-8859-1?Q?hGT0PCrLfMmKGmPJjudr9gtjP3qzr9KKPy+xgLsab4wqk/5AGvCABHnDhT?=
 =?iso-8859-1?Q?ZQeo/lbudctO4Wmkxfo=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN2P287MB308587EBC924A773A4F2182E9F6FAPN2P287MB3085INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB3085.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c94949c-ab79-46c6-325a-08dda4050ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 07:46:20.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBsDM0uNzZ6cSvDQ74rtHU6ppfBgjsAF1dmuBr3XLUtlSgmMDn5v/y8syzrdLMrBpJuhlGEvjeOL4okq9X+LuFlRARUtA88ot4qLgBxxoQufCH6D/q0czrNrGuOQyf/IVpjwUH3dj9Rh0Su34GnxuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3659
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN2P287MB308587EBC924A773A4F2182E9F6FAPN2P287MB3085INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN2P287MB308587EBC924A773A4F2182E9F6FAPN2P287MB3085INDP_"

--_000_PN2P287MB308587EBC924A773A4F2182E9F6FAPN2P287MB3085INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

Please find my patch attached for review.

This patch adds AArch64-specific inline assembly block for the pthread
wrapper used to bootstrap new threads. It sets up the thread stack,
adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original
stack via VirtualFree, and invokes the target thread function.

Thanks & regards
Thirumalai Nagalingam

--_000_PN2P287MB308587EBC924A773A4F2182E9F6FAPN2P287MB3085INDP_--

--_004_PN2P287MB308587EBC924A773A4F2182E9F6FAPN2P287MB3085INDP_
Content-Type: application/octet-stream;
	name="0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch"
Content-Description: 0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch
Content-Disposition: attachment;
	filename="0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch"; size=2643;
	creation-date="Thu, 05 Jun 2025 07:44:50 GMT";
	modification-date="Thu, 05 Jun 2025 07:44:55 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjODk3ZDczNjEzNTZjNzNiNTgzN2FmYTQ2NmY3OGE1ODUyMGMxZTll
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDAwOjMwOjQ4IC0wNzAw
ClN1YmplY3Q6IFtQQVRDSF0gQWFyY2g2NDogQWRkIGlubGluZSBhc3NlbWJs
eSBwdGhyZWFkIHdyYXBwZXIKClRoaXMgcGF0Y2ggYWRkcyBBQXJjaDY0LXNw
ZWNpZmljIGlubGluZSBhc3NlbWJseSBibG9jayBmb3IgdGhlIHB0aHJlYWQK
d3JhcHBlciB1c2VkIHRvIGJvb3RzdHJhcCBuZXcgdGhyZWFkcy4gSXQgc2V0
cyB1cCB0aGUgdGhyZWFkIHN0YWNrLAphZGp1c3RzIGZvciBfX0NZR1RMU19Q
QURTSVpFX18gYW5kIHNoYWRvdyBzcGFjZSwgcmVsZWFzZXMgdGhlIG9yaWdp
bmFsCnN0YWNrIHZpYSBWaXJ0dWFsRnJlZSwgYW5kIGludm9rZXMgdGhlIHRh
cmdldCB0aHJlYWQgZnVuY3Rpb24uCi0tLQogd2luc3VwL2N5Z3dpbi9jcmVh
dGVfcG9zaXhfdGhyZWFkLmNjIHwgMTkgKysrKysrKysrKysrKysrKysrLQog
MSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90
aHJlYWQuY2MgYi93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQu
Y2MKaW5kZXggOGUwNjA5OWU0Li5iMWQwY2JiNDMgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vY3JlYXRlX3Bvc2l4X3RocmVhZC5jYworKysgYi93aW5z
dXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQuY2MKQEAgLTc1LDcgKzc1
LDcgQEAgcHRocmVhZF93cmFwcGVyIChQVk9JRCBhcmcpCiAgIC8qIEluaXRp
YWxpemUgbmV3IF9jeWd0bHMuICovCiAgIF9teV90bHMuaW5pdF90aHJlYWQg
KHdyYXBwZXJfYXJnLnN0YWNrYmFzZSAtIF9fQ1lHVExTX1BBRFNJWkVfXywK
IAkJICAgICAgIChEV09SRCAoKikodm9pZCosIHZvaWQqKSkgd3JhcHBlcl9h
cmcuZnVuYyk7Ci0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194
ODZfNjRfXykKICAgX19hc21fXyAoIlxuXAogCSAgIGxlYXEgICVbV1JBUFBF
Ul9BUkddLCAlJXJieAkjIExvYWQgJndyYXBwZXJfYXJnIGludG8gcmJ4CVxu
XAogCSAgIG1vdnEgICglJXJieCksICUlcjEyCQkjIExvYWQgdGhyZWFkIGZ1
bmMgaW50byByMTIJXG5cCkBAIC05OSw2ICs5OSwyMyBAQCBwdGhyZWFkX3dy
YXBwZXIgKFBWT0lEIGFyZykKIAkgICBjYWxsICAqJSVyMTIJCQkjIENhbGwg
dGhyZWFkIGZ1bmMJCVxuIgogCSAgIDogOiBbV1JBUFBFUl9BUkddICJvIiAo
d3JhcHBlcl9hcmcpLAogCSAgICAgICBbQ1lHVExTXSAiaSIgKF9fQ1lHVExT
X1BBRFNJWkVfXykpOworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyAg
LyogU2V0cyB1cCBhIG5ldyB0aHJlYWQgc3RhY2ssIGZyZWVzIHRoZSBvcmln
aW5hbCBPUyBzdGFjaywKKyAgICogYW5kIGNhbGxzIHRoZSB0aHJlYWQgZnVu
Y3Rpb24gd2l0aCBpdHMgYXJnIHVzaW5nIEFBcmNoNjQgQUJJLiAqLworICBf
X2FzbV9fIF9fdm9sYXRpbGVfXyAoIlxuXAorCSAgIG1vdiAgICAgeDE5LCAl
W1dSQVBQRVJfQVJHXSAgICAgICAgICAgLy8geDE5ID0gJndyYXBwZXJfYXJn
ICAgICAgICAgICAgXG5cCisJICAgbGRyICAgICB4MTAsIFt4MTksICMyNF0g
ICAgICAgICAgICAgICAvLyB4MTAgPSB3cmFwcGVyX2FyZy5zdGFja2Jhc2Ug
ICBcblwKKwkgICBzdWIgICAgIHNwLCB4MTAsICVbQ1lHVExTXSAgICAgICAg
ICAgIC8vIHNwID0gc3RhY2tiYXNlIC0gKENZR1RMUyArIDMyKVxuXAorCSAg
IG1vdiAgICAgZnAsIHh6ciAgICAgICAgICAgICAgICAgICAgICAgLy8gY2xl
YXIgZnJhbWUgcG9pbnRlciAoeDI5KSAgICAgXG5cCisJICAgbW92ICAgICB4
MCwgc3AgICAgICAgICAgICAgICAgICAgICAgICAvLyB4MCA9IG5ldyBzdGFj
ayBwb2ludGVyICAgICAgICBcblwKKwkgICBtb3YgICAgIHgxLCB4enIgICAg
ICAgICAgICAgICAgICAgICAgIC8vIHgxID0gMCAoZHdTaXplKSAgICAgICAg
ICAgICAgIFxuXAorCSAgIG1vdiAgICAgeDIsICMweDgwMDAgICAgICAgICAg
ICAgICAgICAgLy8geDIgPSBNRU1fUkVMRUFTRSAgICAgICAgICAgICAgXG5c
CisJICAgYmwgICAgICBWaXJ0dWFsRnJlZSAgICAgICAgICAgICAgICAgICAv
LyBmcmVlIG9yaWdpbmFsIHN0YWNrICAgICAgICAgICBcblwKKwkgICBsZHAg
ICAgIHgxOSwgeDAsIFt4MTldICAgICAgICAgICAgICAgIC8vIHgxOSA9IGZ1
bmMsIHgwID0gYXJnICAgICAgICAgIFxuXAorCSAgIGJsciAgICAgeDE5ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLy8gY2FsbCB0aHJlYWQgZnVuY3Rp
b24gICAgICAgICAgXG4iCisJICAgOiA6IFtXUkFQUEVSX0FSR10gInIiICgm
d3JhcHBlcl9hcmcpLAorCSAgICAgICBbQ1lHVExTXSAiciIgKF9fQ1lHVExT
X1BBRFNJWkVfXyArIDMyKSAvLyBhZGQgMzIgYnl0ZXMgc2hhZG93IHNwYWNl
CisJICAgOiAieDAiLCAieDEiLCAieDIiLCAieDEwIiwgIngxOSIsICJ4Mjki
LCAibWVtb3J5Iik7CiAjZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9y
IHRoaXMgdGFyZ2V0CiAjZW5kaWYKLS0gCjIuMzQuMQoK

--_004_PN2P287MB308587EBC924A773A4F2182E9F6FAPN2P287MB3085INDP_--

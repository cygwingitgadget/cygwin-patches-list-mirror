Return-Path: <SRS0=3AqM=BY=analog.com=Ankush.Kumar@sourceware.org>
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by sourceware.org (Postfix) with ESMTPS id 675354B9DB55
	for <cygwin-patches@cygwin.com>; Tue, 24 Mar 2026 08:53:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 675354B9DB55
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=analog.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 675354B9DB55
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1774342409; cv=pass;
	b=BAzku2a3ICBHi71IPY8itpVdh9m2aCJGVgVbmEjiLyuBs34MnjE6ISC9/B/Fc6gIBAkTikNxvtn6scVh5s1MQMp6piy+9Z2yDc/bbQY8GQvj3nYmRp7cbZOWxZTUOYqrf1h3rVu9mTnIvqlnRs9JpSs/vndV28j2b0dsaBzgghM=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774342409; c=relaxed/simple;
	bh=FdBYm0/6mfVr/rEY8B1Py3CXw891yeMBIn/PzKMOSA0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=iDDNpa3Nc+zTdAjq1xYDjVacuXYYiWyefZ+bmTtxKiYk9n6l+QGf1Cx/MGt5+7lkkbhrCTv75+ZABg0Tdd8HcwjL/06kZwZIcrwcEYZfI5Kf2wbyTop5qfe9L8nIrwe0EUHYnPrm6TGXD3p0i4ksA8/z7DdMSPPOqc0aCGG/+nc=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 675354B9DB55
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=XIoe2xVY
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8caQ92271070;
	Tue, 24 Mar 2026 04:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=FdBYm0/6mfVr/rEY8B1Py3CXw891y
	eMBIn/PzKMOSA0=; b=XIoe2xVYdqSriQJGxLXAIyxMyDltLkMxVMrgCULxYhCQQ
	FBsXnaRrc3m7DTzGHcumj8grS7PxlL2VBJdGZ8HCK2n53bV0HqSZW5eSg5JUx3LX
	ypc8fzA++1OEjjIApNLcWFjnv1Yx8TKaQuSZvWIsex87zsYI42oyZi+ouMjsa0vn
	JaCXiXr1OxD3kMzFXhc2BdxooTCT9V72sc/MjddYYALY0TYv/z4/ZgztXxViSxzr
	m2khCXmOBg/tzLlLxg2YpaUS54KJ9XfPRnIli88K32aBOH1xrAz7HyX1NnGh/NHQ
	CzMGkTOEO89/fmWoD2zRsmAxhyWx0PYtgimny9E+g==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d2cnf0d8b-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 04:53:09 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbhxGgXMssjEhE7TGSN1XZlRHwTtRKtBpVa6HuqZQs/FsnXaBD3ZUB3Wu21mNZsgnq6/UG9asSiktUAVCox79mqM6zxe4T/rgep6kuPZ3p+8usGg7N8ELlln4IXQPZunrx1UnPb05TAUOaXKSedJRePU3YMIwiSjvsq4adGo7r/RGfxU2EEvdjc5sqTjqQ+j4FpbNbxkZCN3TxEfXPKK7J/kniQUDcd4XcpusTqx61NPnTRn600O3TAWl2umOBVs3G52BhtH+c+C5xc1O+vIwxdevgwE9wi9FvqRzn8Yird+eGaqtcw0rKhUxS1SoJu8fp467V1kfgseYKzrWJnHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdBYm0/6mfVr/rEY8B1Py3CXw891yeMBIn/PzKMOSA0=;
 b=UkgCIO/7zU5wrXY5lL4TdqB++tUqhYQZT0KtbL/5J3xDqAEAPfu2p2DyAKv3KYgK5Brzy+YdDXb1244PWuOKTmVT74mdZnV1ZDEGeUhWUVBd3+aaxSMx+ZhqbQfgdPx5gwmj/R2DKqIi3mfZlitAHkglGJZePKRh+Vyqs5BDoPu8o+EjhWkoJ1NURF5iUGA2Bp5jM2D2rPRRu/1f0rDIhjxnL9R5GgWJNT9kLmCo2YKsD+M/4a/Wb50YZaW1HBYf/4ODJU4/JRiiVq+xdXHOXF+pnkF7LqGBiQQIPXVxL1mXolALurzo6sqj6ctDOXCM/cN8g3Z4LrQ5XVoRWITJ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DS7PR03MB8314.namprd03.prod.outlook.com (2603:10b6:8:262::14)
 by BN9PR03MB6137.namprd03.prod.outlook.com (2603:10b6:408:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 08:52:32 +0000
Received: from DS7PR03MB8314.namprd03.prod.outlook.com
 ([fe80::c42:a936:f536:e237]) by DS7PR03MB8314.namprd03.prod.outlook.com
 ([fe80::c42:a936:f536:e237%7]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 08:52:30 +0000
From: "Kumar, Ankush" <Ankush.Kumar@analog.com>
To: "Kumar, Ankush" <Ankush.Kumar@analog.com>
Subject:
 =?utf-8?B?KFJFTUlOREVSIDIpIEFDVElPTiBSRVFVSVJFRDogQml0YnVja2V0IFBlcnNv?=
 =?utf-8?B?bmFsIFJlcG9zaXRvcmllcyDigJMgR2l0SHViIE1pZ3JhdGlvbg==?=
Thread-Topic:
 =?utf-8?B?KFJFTUlOREVSIDIpIEFDVElPTiBSRVFVSVJFRDogQml0YnVja2V0IFBlcnNv?=
 =?utf-8?B?bmFsIFJlcG9zaXRvcmllcyDigJMgR2l0SHViIE1pZ3JhdGlvbg==?=
Thread-Index: AQHcu2uMcg5R0NuZwk+ETgaAMRu1hw==
Date: Tue, 24 Mar 2026 08:52:30 +0000
Message-ID:
 <DS7PR03MB8314D4F438B2B7AADF43B440FB48A@DS7PR03MB8314.namprd03.prod.outlook.com>
References:
 <CH8PR03MB832282C8067513749ABFBAD7FB88A@CH8PR03MB8322.namprd03.prod.outlook.com>
 <CH8PR03MB8322C1CD2F3953EFF8F64190FB77A@CH8PR03MB8322.namprd03.prod.outlook.com>
In-Reply-To:
 <CH8PR03MB8322C1CD2F3953EFF8F64190FB77A@CH8PR03MB8322.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR03MB8314:EE_|BN9PR03MB6137:EE_
x-ms-office365-filtering-correlation-id: 6195caab-c773-4a3f-7348-08de8982ae91
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|22082099003|56012099003|8096899003;
x-microsoft-antispam-message-info:
 X44Vp1+8s0s23F0V6ZhN5fyGQSnyEbZ56SX7RJ2WBD+XUd1bUOFl4lsIOau9kXpuoJ5Xr5oXPk7HivVQ+y+R08OHxd/N4jQD0U7cdD424PCSzggAxJXNhRqxLQVNRMLfUaDN2mjqEKYS50mrSZJVbbb82SiVd/3bG3yH6dcfDFFr3DKL2liWM030ideGQte63qv8rHliZuQGl/g0FPnYXr0T9Foso5rOIbo422jJXoEdsHGk2/J48ZvmGb6zVmN7BmmyQNjSkZymEa9IlXyIZ8bKBrSbe2GZlMfGgY5IhKa9kOS/91f4uKqocTBWC6OI8ruHjc3mb0CpJeptgfLk7mJI306fWqdLCLSBEmCQUPsQID3qvEyKFde7nzcQIzcOKBGMNklXjl/Jp6xDKDnVLH4u5N5vZz5GpS6gLGjicJu71l50zdO6opYbIrBtYC04Q7UDHDBNPxb0vlJ+3Tcntr0XBkizsSz+2g3M0FFZJk5J+o2ETj6pJXskJFV9SjhN/HfKqujDFSJK3ZsFgmySQRKb5IeO0TMLPWUP6RS72N+A0BG9poqxheAn5YEpy52KpIMyuoF4wEWOTs/0dMAMAgvhvl3bgsn4CfOW0tevU6Xf2hAIvMwCJrx/lg0bneOmn1ThzBI0rKYTyrtf27pkJ8f5Ed20r57Vj6bcgLWUtsDMpMqr9H9rBPQSfGXpB4iH1CSsZ+HR8DjJ4RWBhMPaDu26CYY5requu5jpXWA0J8apWSN3fcVnBn+ZDPvZtHgLRx8CpSFVG9Jd6La8dWixxp8YZ62dcnChy1rhvz+p30g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB8314.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkdHRmJkK2JxcnJHUWNiVlNMcG92VEFnVFhQbGFHU1o0U2QxckpiOHREWnov?=
 =?utf-8?B?Zkd1QVF5UG4rRXFjQzZzRWNEY0I2Q2JaYkZnekNxN1BrdFltL2Q4NE9rczRU?=
 =?utf-8?B?T2k1Zm0wMG0zNVhiQnlWOFNsc25DZzNQUGtja3FnMWhxUHYwN1FKbSs5WG9X?=
 =?utf-8?B?OWw2V0F2MG1EQmFOSlUxSXNHUm5GQ2hLYnRYVU92Y1h0NC92WCtWaHhuK3hL?=
 =?utf-8?B?K3dpMFBlMS9vOVVCdkQ0NjdqMHFnL253RTlYTjNyYnVoS2N2YTVOVmVoTzU0?=
 =?utf-8?B?N09McDYzU3QvUGlOWERISEZsVDZqK1MvRXpNV1NZUjhWSzBTRm8rd2h5T1Z2?=
 =?utf-8?B?dmd0ZDRremRsekE4Mlg1cTJobjBnTzFtTGdEcjMrQ0VVaHdVZ21pQ0lWVXE1?=
 =?utf-8?B?K2NYTmpMamZGdGlCalJOUVFvRnZRdzYybWp4QktVdUcreTUxZzduY056V2lQ?=
 =?utf-8?B?enhOMlM4REYySjBXdEFpYjh6VXdUUENRb1BXOXNURlNrZldhTFp0N3Nsc05j?=
 =?utf-8?B?WnYvS1lQeDZDQ2F0WWI4NTBRb0VuWXg1a2xmdlNZaDZ2Y0J3aks3QVA1b2Vi?=
 =?utf-8?B?UFV0WmFUcTh0MnFZRVNyNzdPN2xVUytza0lZMVVEbmJLMUhzc0toRzJmdVpQ?=
 =?utf-8?B?UXBtVmdJRzZBRXhWcjVwZmJYQzBvbDdvc3hWN0JQOEN3NEl1V1p0M1BydUZh?=
 =?utf-8?B?bGZDOEJpY2VRYnJCMGpzVjJINEErbktCZ3F5ODRrTDlLemZmaVowTXdlRzFp?=
 =?utf-8?B?cENScUkzUHZRUHYrajJEOXJTZ25JRFcyTFppR1lqdHJ4bkRkcGNwTGNXTXE2?=
 =?utf-8?B?eER6TThJOFd5NDVOMHdMa2JBZG42U0NhNldYTCtabnRpR3pidjRnQjljZXFH?=
 =?utf-8?B?T0g5c1ZpeEJMamErWWxmNm9oWnFod1JYMm1ZZ21JMVhTbk1Oczc5VnBSeW1r?=
 =?utf-8?B?OGdmNXEzaEpWRy9uUlBCeE9wU2dJcVR2U0RqTUJzanFKdXpUS1hWRUdiR3lo?=
 =?utf-8?B?aStRUUpQblYwYnF2ZHZjazZiWkJQcUhzTmtNN09xRUZPUHU4VmV5eEl5bmxk?=
 =?utf-8?B?dlZpUlpPcGxBSXlMOUVHeHU4dk8zeUNYMUI4MzEwUU5oRmx0QitwcFpVSjdV?=
 =?utf-8?B?cFJxQzBYVlBsazZZMUJXWjlrYW9ZaEIwclNVY3ZPbFdMWGtDcGJLeVJGdkdJ?=
 =?utf-8?B?dlZTTCtyV2gxRTVrVENSNVd2NVNrRlNPaE84UTJMUVRhZk1Wa1g1cUs1M0hh?=
 =?utf-8?B?VXNGa0Y1c2M0Q0Yvay9UMDBVdW43SW1acFFERXVBWkovdVdJSWlHczZDcFhm?=
 =?utf-8?B?TTFZbWFJY2RndE1zalhsNkJQQjVadlVrdVM0VkJqbmV0bFB1QTFKZkVNS2lB?=
 =?utf-8?B?V2N2SDYyQkdIRkN6SDFDdEQ3QSszMHlEeDhNSTg2RWR4UDQ5UndRZWZyRUFU?=
 =?utf-8?B?NlFBRnRHWlI5U3A0VXlsb1ZuYTREWGNPYlJoTTlMTXBhc3h2aWVCU2xCWlRs?=
 =?utf-8?B?bnRveFNiZG9tZlhWVDJQa3JPOFhKS2R6dTFkekVuai85VkJldno4d2xINTY4?=
 =?utf-8?B?MVVDck4vMnpscnV1aCtiek1HQnhyS3RLL3F6dG5weEUzc2RlbXdxT2w2Skl1?=
 =?utf-8?B?WVFtcVNBMVNFSk1YemlqWWJ1STJ6djJWSlFLQXJlVmEvdStGZ0RMZkZRellt?=
 =?utf-8?B?c0M4TXQxWHZHVnplTGZzNkF3eDVndTBVb2RTbVA4SG5RWkM4bDZlTFpWZ2xt?=
 =?utf-8?B?cXhrbVB4amRlNXBIRHExMFllSjBrYllpUzB2U2JiTVFCamM4bFNuOFFRWFhM?=
 =?utf-8?B?eHFEazBoWWUzWEZjOW9ORWlTdHA3NmFMSGdlSVgwUHNBZ29OeWc1czN1T0Fj?=
 =?utf-8?B?MGRmQUpReTh2LzFmd0E2VUk0UGhGMkNDT2tmN1R5UGJaTW1sZE9WcDEzZTRk?=
 =?utf-8?B?NmlCcXNNKzBMWUxld2NqclhNWHFucGNPT0pnemlNa0lNNzdQZXpGVGRjZHVs?=
 =?utf-8?B?RmsvalA2L05tNjJQUWR0QUx6L2ZwTWw1aVNsQ0o5Wlo3NDRJZmtnVVpiZ3Jl?=
 =?utf-8?B?elpLb0k4KzV2UGZZU2VrajJqTkVsM0k2elhRdmh5THlFMUFBYVYrOWpqcEZF?=
 =?utf-8?B?cWx0UllkTWNPbWFhZEpDQWtHbDdxaHZKTEQ2aTlSZitzV09US2pOU2xueE15?=
 =?utf-8?B?UlB0KzZwZkdIQ3Bsck44YzIydll2dVdyZ09OeU8yOThGMmxUQmJsQlpYdmNH?=
 =?utf-8?B?cFhvWENXcnJNT0E1Tk9ZZkhnSnFNR2RiZmwxdGFtYXFVaW9lS2U1Uk5GeG5O?=
 =?utf-8?B?RlVIb1FmUC9ybzRUNzYxOUVPSG1aN2ROL0Eyc3RRYlBjYVA5T29yQT09?=
Content-Type: multipart/alternative;
	boundary="_000_DS7PR03MB8314D4F438B2B7AADF43B440FB48ADS7PR03MB8314namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	S6MRA+yYAkx7/uIbXz2pnJeO9g7HL9MKiftzwcn7ZxJpJurbtbxB3PcOPARaEZpIXhAinAiVDgzLO+6zEe67ISlzWdGfUGJKxGenSLgGGMj5JqezLQjtSONWJDxGi8BNNYWxSkyX1OOalpf9e08l32feKLHOA60TcNPpFeAapVVESvwK/bEnvd4sf1cHXmuo88MSNcZZpmXlNF2HchWLSr+ALChwjlsF+So9KuokDMdZghYkOQPIuasEEV/IMH3WKmzcqHNfgQ0HvOJaAbrdnK2IW9xVGJTl5XR8DPN8XJ7Fi1+6QycRHH+QrYGvCguKXNXLVemn4Uu4zPd1yt3Uig==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB8314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6195caab-c773-4a3f-7348-08de8982ae91
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 08:52:30.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8aFhOhQNzyPARvvOQWT4MQb6d3yTF+NP3KZxgr7tlwX+SXQHcGrljkkc3Jil8nIoMDT20Ic2nlfzWIPNLTAaag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6137
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=UcVciaSN c=1 sm=1 tr=0 ts=69c250f5 cx=c_pps
 a=Vy3FhvgG8Thl4oebyZnGOA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=5KLPUuaC_9wA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=mYwZfc-oHjdUWmC6CTsA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=fvepA52gz-ne2qlAx_UA:9 a=L7Opi32fIt6ctjhF:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-ORIG-GUID: mriWn0a4nM3YrFbyYE_M78KaYGpbmpZl
X-Proofpoint-GUID: pwM3Nfp-qOoGT0wbVQUN7hFBL56OZhCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3MSBTYWx0ZWRfXxnGPVbZ4uhAM
 W5giIJzIv8BETTN4rSJRywlZDnDsbnGDEeHMGq+76PJJHSx/2dEQ1Y0HaXBLk/qzbriIsQZ3ou0
 MMZgRWTNFj1y8yi0VQ5OO6esoTtI8OOEouLLTFfA5wm3srFgcsS8JV7euJy81EHcz17lJvkkLwT
 kanb1aPAj/krc9AwHfoMb4Uoa85GLJMFZQRnHlY7xgCb9ahwfABLnerxcbbS7/8p6A37Cx9rt3Z
 7V3CKgiKOLobvSO1TnIJwL56HvdTRRQWlMPLdwoDkK17aYrhHcxvehfoATpEgvQKhd4hL1BdfMM
 73ghR57r9WAgfnV7HY6RVQVTkpqjUxoGy4n1OhdgCSp4X7uSu8qGQ3Ztk6ETBrKw7Fr7MydTsfO
 MG6TArRa6DXw5ujfhpcYlaBE5QFqv7ybQS3ddP35W5kn5duP7+RvEgzwG6EtJMYZOUWILv7N0MG
 Te/8/8oIbZvURvB9vrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240071
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,LIKELY_SPAM_BODY,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_DS7PR03MB8314D4F438B2B7AADF43B440FB48ADS7PR03MB8314namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

U2Vjb25kIHJlbWluZGVyDQoNCkRlYXIgVGVhbSwNCg0KV2UgYXJlIG1pZ3Jh
dGluZyBmcm9tIEJpdGJ1Y2tldCB0byBHaXRIdWIgYXMgcGFydCBvZiBvdXIg
cGxhdGZvcm0gbW9kZXJuaXphdGlvbiBpbml0aWF0aXZlLg0KQWN0aW9uIGlz
IHJlcXVpcmVkIG9uIHlvdXIgcGVyc29uYWwgcmVwb3NpdG9yaWVzICh1bmRl
ciB+dXNlcm5hbWUgbmFtZXNwYWNlcykgbm8gbGF0ZXIgdGhhbiBNYXJjaCAz
MSwgMjAyNi4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQrw
n5eT77iPIEtleSBEYXRlcw0KDQogICogICBKYW4gMzEsIDIwMjYg4oCTIE5l
dyBwZXJzb25hbCByZXBvIGNyZWF0aW9uIGRpc2FibGVkDQogICogICBNYXIg
MzEsIDIwMjYg4oCTIEZpbmFsIG1pZ3JhdGlvbi9jbGVhbnVwIGRlYWRsaW5l
DQogICogICBBcHIgMSwgMjAyNiDigJMgVW5taWdyYXRlZCByZXBvcyBBcmNo
aXZlZA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCvCfk4sg
V2hhdCBZb3UgTmVlZCB0byBEbw0KDQogICogICBSZXZpZXcgeW91ciBwZXJz
b25hbCByZXBvc2l0b3JpZXMgaW4gQml0YnVja2V0DQogICogICBJbmFjdGl2
ZSBwZXJzb25hbCByZXBvc2l0b3JpZXMg4oaSIFdlIHdpbGwgbm90IG1pZ3Jh
dGUgaW5hY3RpdmUgcmVwb3NpdG9yaWVzOyB0aGV5IHdpbGwgYmUgYXJjaGl2
ZWQNCiAgKiAgIEFjdGl2ZSBwZXJzb25hbCByZXBvc2l0b3JpZXMg4oaSDQog
ICAgICogICBQZXJzb25hbCByZXBvc2l0b3JpZXMgd2lsbCBuZXZlciBiZSBt
aWdyYXRlZCBieSB0aGlzIHByb2dyYW0uDQogICAgICogICBJZiBhbiBvd25l
ciB3YW50cyBhIHBlcnNvbmFsIHJlcG9zaXRvcnkgbWlncmF0ZWQsIHRoZXkg
bXVzdCBmaXJzdCBjb252ZXJ0IGl0IHRvIGEgcHJvamVjdC1vd25lZCByZXBv
c2l0b3J5IGFuZCB0aGVuIHJhaXNlIGEgSklSQSBtaWdyYXRpb24gcmVxdWVz
dDxodHRwczovL2ppcmEuYW5hbG9nLmNvbS9zZXJ2aWNlZGVzay9jdXN0b21l
ci9wb3J0YWwvMTUvY3JlYXRlLzE0MDM+DQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCvCfjqsgSklSQSBSZXF1ZXN0IE11c3QgSW5jbHVk
ZQ0KDQogICogICBSZXBvIG5hbWUgJiBCaXRidWNrZXQgVVJMDQogICogICBU
YXJnZXQgR2l0SHViIG9yZw0KICAqICAgUmVwbyBkZXNjcmlwdGlvbg0KDQri
mqDvuI8gUmVwb3Mgbm90IG1pZ3JhdGVkIGJ5IE1hcmNoIDMxIHdpbGwgYmUg
YXJjaGl2ZWQuIFJlY292ZXJ5IHdpbGwgcmVxdWlyZSBKSVJBIGFwcHJvdmFs
IHdpdGgganVzdGlmaWNhdGlvbi4NCg0KUXVlc3Rpb25zPyBDb250YWN0IGFu
a3VzaC5rdW1hckBhbmFsb2cuY29tPG1haWx0bzphbmt1c2gua3VtYXJAYW5h
bG9nLmNvbT4NCg0KVGhhbmsgeW91LA0KQW5rdXNoDQoNCg0K

--_000_DS7PR03MB8314D4F438B2B7AADF43B440FB48ADS7PR03MB8314namp_--

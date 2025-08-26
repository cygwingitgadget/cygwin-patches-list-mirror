Return-Path: <SRS0=mZdz=3G=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id 94DA0385482F
	for <cygwin-patches@cygwin.com>; Tue, 26 Aug 2025 20:19:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 94DA0385482F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 94DA0385482F
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1756239582; cv=pass;
	b=T4jhSXOWRkJEUice34TnVBnnWAsWR4VDETP8alf1vIdGxiS9vfGy1fOcomg88w6wAISEdPxMOFs7bwjyFSi4XXdfq+xm/kV12vYzmhXkBN9Dj8Jv+kco8fMGk2Qnu9eqhgMQolaCbN3kfXTAQV4gcMYTcBk6Gd2YY/VmiCPZAV8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1756239582; c=relaxed/simple;
	bh=4O0JRJLmfFO6P8y2Tigi2mMlALc79Xro6rbIBXId/2s=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Iq9cIBjkQ+p8oRuKs2CGfpHchBU7Bl9Jm7k4kpVbL3r3lKqEe68fDnV4UgYdinuI7H/n5PgqCHLiS+pFWpoa8rhL3uaAy2Xo0eW2YxtPcDbZtgiQURo2l12Lgn855dLowA7NYzHKEUcGCdvx79txduo4yejCT+VWsPLul0zRzx8=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 94DA0385482F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=fgBvffEX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+/iUb7/TIHp1U7uoURAv6LnhtZ9S8FVHpkZYov6KyQjWIm1ustkSVjSxGImzG3oJjJj7WW/vDLvAcWHnc090rYS/H73Ke39FOTUZBbXl+5CdQefaTG7P/LS79yBB360CbmfLwfCHlEuHVfuAMsnlUSQBbYEC5Ughk/XG9e3bL05Zi8LkUleTkTrCkgzBU28RNFseF4pD1FPNJnmFHA2JJJeS4Kyz68AinHvS7YqNdtfRksUBRfbv5QHVXVKx065bnGxvK+6OaU5amUbhIzXwC3WBbepHrUwQ1KuCLxbE1TlrhPUzkzot+Xf13BEUm2AKUFCppttgP+E/yIDVXQerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2GATNJwg1n8kkJmQvyLnBI1JAiKDnph9Ga1AzTtwjs=;
 b=nNlzJLFjBF25S7xvgiyuqYMj/3wMV2LXc8yHdOqx005GsY2pxWW+KM/Cb4etKBhfUuigs8AJaZuMcWNZtBL7kQ3H0MoeYjMH7QJqrXPfYO1jC4WCP1dFc3olVFiVuVtMmDMrZ6hUMFr7sBpuUotYK7gNk04X+gQLA6t/GSBaSMP0SBCbCLbwrfcfaLyIdEmrCNa2TKbFNtB1brQ/PuDu5pvMyRmYhb46HYf3r/f9EPWYu3+osMGlAdYGRyl3w8RYW+KCNwArj5B7dPMv4FbDb9Z/h2OnmaY1DJPjgHNXY7TcWTmEGcgGaW//37zTFREC3LJxJxGVBvkO1pQq0/Nwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2GATNJwg1n8kkJmQvyLnBI1JAiKDnph9Ga1AzTtwjs=;
 b=fgBvffEXbFBvcJZGjuzNjtnGxER8CtMAVkhAHFzdgV4zggP5rn+rJesqEMx83kSeXFuYem1XJcxANCDH9xAzdWuR1cPfdsw2iE65/j+jtaJNclV9440vn4hvCgmKCMN6KLxDBG8oFThvX2zsbr4Rs4lCJ5sejncOZLS1d6pOZeozFrNPE/Z4I/1wUUDNtspZtYAZaK1A437GsWmTGipAq9Lf9C9Wt8myRIMGwLxqVvTMcKVQob2s2S7MiUeFpXpufMoh7I1QGa2KWtW3MONqkp1q1gzqThLNqLjv2x6AI2PO80j4P0mE2NH65kAZo2q3+P7oqTlhJuad2RJ/mypA2w==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA0P287MB1806.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Tue, 26 Aug
 2025 20:19:32 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%7]) with mapi id 15.20.9073.014; Tue, 26 Aug 2025
 20:19:32 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V2 3/3] Cygwin: math: Add AArch64 support for sqrt()
Thread-Topic: [PATCH V2 3/3] Cygwin: math: Add AArch64 support for sqrt()
Thread-Index: AQHcFsa7JKfOOChzXE2MKT0jzJTruA==
Date: Tue, 26 Aug 2025 20:19:32 +0000
Message-ID:
 <MA0P287MB30827B02B90CCF0EF3D829D19F39A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
 <MA0P287MB30824DEB5F7F550A558C30109F3EA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB30824DEB5F7F550A558C30109F3EA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA0P287MB1806:EE_
x-ms-office365-filtering-correlation-id: 31796478-8e8f-4c3e-29ec-08dde4ddde38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2NMTFFsT3loNnYrS1QxZDMvN0dYYWE5VVdNN0dzNFRFRWc0TkhKTTBKS3Bj?=
 =?utf-8?B?ajVnZmxZRHhWRG1rcTY1NlYvRTRPUDJKb0paMElNS3RDc2kvT21yb0ozd2w4?=
 =?utf-8?B?NU9MSVFDbkhtb2RORy9IMXhtM1Mzb1RuOXlRYXplS1VydFg4TS9MR3orQjFL?=
 =?utf-8?B?ekVmc2F6cWljYXFBT1pDSmxVaWVqWEYwSUFYS1F0MUZ4RS93eUU5eGlQZnRq?=
 =?utf-8?B?WXVoU3owdVdWWnBLTytmTmdzOUhIanBGd0lPK3BMdGZla0Q1Tjc5eGJJYzBF?=
 =?utf-8?B?UVpKYXY1NWxOa2pVNHp2aVVLSWlIR2ZlTDZIK1J0NUpoNTlleWo4a25IdnR5?=
 =?utf-8?B?dTF5b2NHUzRBajZpVklvMnZyNWRIYjhYaWM0L2J3M3F3cXM0bVNBRVZoMWtQ?=
 =?utf-8?B?REF6bDZhc2w3dHBPazNaN1Q0MzJYRzM0VEpDbjlPZG94cmpWdTZmdFA0RGE3?=
 =?utf-8?B?b2tzVTBtVVhKNUlGb3NqWUFLZkJtSHNGUkFUVnJTaXpPUXc1NFhXYWlUd1dM?=
 =?utf-8?B?LzBHbEJxTDRXODYyY0NFNFFhNmhQc0NCVzNMK2xtUkI5MjE5c0JsSzJTMmY0?=
 =?utf-8?B?cW5jaXJRMkRRSGpUK2tjc25KTWpSanY3ZCtYMjgyUS9LS0FUd1dUc25kWWF2?=
 =?utf-8?B?NW03cUJKUElCRXJmSFR4QmV2YTBjaDFCTkhHR2pYM2ZJTkhzTStaRkxHT2F6?=
 =?utf-8?B?aTdtK21RNklSdU5ycGx6SXk5dzdHZjdJMlA5UVZETU5KVE9KeHIrbmpRYS94?=
 =?utf-8?B?eXlNaVBzWUxYWk9yandpbkVrYVhvSVNYTzhSWU84dkk5c09jUFpHNSsra3g4?=
 =?utf-8?B?dUU1cENuNkdkQ0ZGMFZtaWJjODY1cGRNQjhlaUFldU5LazdWa0I5MkRIRk1n?=
 =?utf-8?B?WEY4Y3paSG9hZmRMam9HUkQ0Ui9YcHdxZmxYbytjK3V0MXVSODZTSkZNYm0w?=
 =?utf-8?B?Q0lndnordXNvTElKZ2lydEQydlRpMzFhcllrWDRUVzZxWnhzRllrUUErNUVG?=
 =?utf-8?B?amRhRGdXL2hJS3BxSmd3TGFQMzU4RUpWaEJ5VDcvUVBWTTVndW9mZFNJenY3?=
 =?utf-8?B?ZU5aTHgxUGwyZHBpZ0wrcklxYkF6MGxPakpoUnpxQWJtSEpLOHBuRlNXMDM2?=
 =?utf-8?B?QlhBT3BWNXpoK1l2L0tFR2J6NXRHdzIxTHNrSWVEQ0QvUTZOcUVXS21sWDlh?=
 =?utf-8?B?Tmg3UlpvUFBiMnIzbHBMamJuTENqMzRFNkhweUZWSENTTVJLSEw3OUZDK3ND?=
 =?utf-8?B?MG5Fek5xVlBxYWtubjAxNDlvNXBPTU5JTExYTm1jb0E3VlhPWktLSVE4dXk0?=
 =?utf-8?B?MUI5a3kzQVdTeGhvZHJtNEVXZGcydkd2aHVZU2h0eGlHNkx4bkJoZnFMV2VN?=
 =?utf-8?B?czY1TlovS2o1SmhTWGpJUzg0d1g2TVY2VXQydVFqdHB5aXA4WndGZWJsMFc4?=
 =?utf-8?B?ZldETHVnNnBwRXkyV3drSzNDWU9WeXpsWDVNWEl2UXdDRFhiaWtaVEkzYUs1?=
 =?utf-8?B?K2xVc2NIUm9LcHhKeDRuU21NMzlCRTEydFdQSGdzSFF6Qy9vdHM0QVpqRmtC?=
 =?utf-8?B?VTZ2a0VNUk4xblNuN21pemZQQkJkdnFYVlg1MXJLNklEQkpXNGVsaEtaek5r?=
 =?utf-8?B?NHBMS0E5N29ySnJUOTBFTDljNEM4dUo2LzUwV2o2a0RmdURiMHh5M3V5MDd3?=
 =?utf-8?B?ZUVyNVUrRFk2cnZhRmpCcW5YUEZ6dExkclBmRXdxdUJBZGdRWGNLUk5KcWFH?=
 =?utf-8?B?VCtTT3U2bm5aSHlRV2JWMFQrWWR6WDB4UFd2eWcxWElaTUtPRVFrVHhLaHRZ?=
 =?utf-8?B?UWt0SXhpYmpWVmVWSkV3N2RxTjlHZTQ3VHJwVnUwY0xXc1FPZk1vRmNib0Yw?=
 =?utf-8?B?d3EyTkoyNEwybE5kM1VGeDhKS1BlRmpMR0hxdDFhV3dnK05RTnl3ak1WWEZu?=
 =?utf-8?B?c1E2bHFUOHNOU1ZkOEZnMTFTTjdadHh1RlNvdlBXOG9OZEl0UW9nVDFxZnhz?=
 =?utf-8?Q?tXARkZpPLuK9Hkzt4FCYGhUjHf49DY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXoyNktQdFpSeVUvMTQ1b3VUTW1OdmRlYUNWcTBwOTZTTEw4VlB4d1BOV3o4?=
 =?utf-8?B?c2RpMnM3UC8wWDNteEtrL3BlVUdCV1Iva3JmMDAyeWhhUnB5dmhScmtJSTFt?=
 =?utf-8?B?WGkvazMwdFRwcmZCOEFmQkpJUGRSRFNpN2RoYWZaTHhCZVlSdmt1eDhtR3NF?=
 =?utf-8?B?YVA1dXBGbWMrS2hTZFhOcUkreEQwZGtYR3B5dG1iNTA5OWhrM3FGbUJnYUw1?=
 =?utf-8?B?YTZITmF5OG9xaHQ1NlF6RDNsUnhEQUtza3V5NFN1a3IvTDlZVTdGOUYvSFJJ?=
 =?utf-8?B?TnowRDNQS29nQ21iT1RCMFpCNTh2TFRHOHdrMVEzMDl5ajI5ZVhHUWlrc0lM?=
 =?utf-8?B?NWhCd2FZTG1KY3Q5U2hsMnNaNlZSY3h0djlyOS82aUtZWEhLQTNIM3N2S3h3?=
 =?utf-8?B?MGx2UjZQOC8wdnpuVlcyS29QVWFPWTJXdlJtVjVhbjI0TWFsZE8wUG9VUHM5?=
 =?utf-8?B?NCt6QmRNa2ZWNm8rQTNjWnM4Y3dna2ROajhleXN5alR6WE1mN2xWL05WWVE3?=
 =?utf-8?B?eHA2QlZVZnRsc2lmb0NYeXgvZGVJZS9teVNRTWtUMXM4THgrSmFCeGdCRENV?=
 =?utf-8?B?b3RydHl1eEhxWXY5Qk5aV1AvSXZtS2F0aG5GckovMDllckY1S3NVZGxPZS9r?=
 =?utf-8?B?c1VKRC9LbGcxV0xXYkhUUmp4RDBkY1pRMzNLTlpQZkNIWkFURkpKUTBJanZL?=
 =?utf-8?B?UmQ0TjdOU051Zm8rdzZSaDFWR2V3cHFWdHNoWmRMQy9Ra0FKZWoxc3MyU0NE?=
 =?utf-8?B?VCt4UHZPZVJXUC9YTlVBbEFvVGhnWnFlZy9qWEprNld6V2pLRERqNDZDUGZ6?=
 =?utf-8?B?MWQ1ekNYMWkrZDBCZE5yQUpmWE1MRFRBeWNMOG5JR1V3bkp3NGNVMlFNV1Z0?=
 =?utf-8?B?MTNSeGdxVG1wM2lwcUJxcjZQbGdzMHdQMlpSOFZtWXNPaXpXZVlHWkVrTmJI?=
 =?utf-8?B?RHpqSnV1R2t2eVRLeGRnbUF1alNLdG11RDFnWG5BcDBjcldMWHFRZGdzNkho?=
 =?utf-8?B?bEpBM0NCNTQ2bVFrTFllOFBhdjRPQzVUeHdNb3RLVTNleXVTY2ZxaW41cEFn?=
 =?utf-8?B?a0wwUC9jem9vLzhMSDZjdnpoZjNwVlUrMVZEVklMNnZQMWN2bjZuUC9JVDkr?=
 =?utf-8?B?SVZpZVR4dFZNaS9mWDk0SlNQRU9sbTR1L05Fb2IzMjRFT0dSZzZNMkdFWitG?=
 =?utf-8?B?MlF4L1ZlL2NIZ00ydzZmZlJTc2htNERwb3Nnc1d5QlBVbXhjZVdKbm5Wd21m?=
 =?utf-8?B?b2t5cjM5ajh1V0JJRERrOUVFVUx1b2dMQ0hyeVJvV2tnR2duTW8va0hab29L?=
 =?utf-8?B?V3lDLysxaFpkdXZuOU1QTDluQnBtM1VRM2M5MGl1T3phNW1wT3dxTjVRbURl?=
 =?utf-8?B?Q0J3cWFpYVljaEhmUlZiU29NL0g5c1laeE1CeWJtc0d6TEpHRWIxVTdGVDJD?=
 =?utf-8?B?U2dSaStXTjFYVXVOTzVEYmplamRVMVdCcllsOFR2cHRiVUN3NmQyYzFhMHND?=
 =?utf-8?B?b0JQV1U4cTlnaXdBbysreEE1T1p1THdsTUhMTy92MUlYRms1RUVmYk9qSitt?=
 =?utf-8?B?ZnZ4WXF2Z0w1dzZZVnYwdkhjZHVEVUNhNmNZL2QyOXlSSlJLVWt3Rm5lR3lQ?=
 =?utf-8?B?YjV4YTFNWFNmT1RKaU5xbWVyQ2ZzZm5jem55bDBOa2thVzBKcmpQMW54NlpR?=
 =?utf-8?B?SGxkek9DdVRvQVJUWEExS2x3MXVKaXZveCtVaW8vWThWU1l4eXhyeFIvUEN5?=
 =?utf-8?B?RDZwVHR5Qm8zNEN2WGF0VktHWVpockpES1czZStpMTRmV28zcFBaL3k2SUY4?=
 =?utf-8?B?VFU2dlB5SlZOVXRQQkduWmJhaTE0QmJQT1gyNXZqclFJcUVpUFAvOEVGTnEw?=
 =?utf-8?B?c3psdUoxTkdNZTEwTldqcHIwOC9meTNaZUl2QmFFSjVxMDhJcEVMWlVzbFZk?=
 =?utf-8?B?aGxkWGJTSDQrK3pRMzRzWWZUTGtGcnpmOTFLNlNGVmJXUHNUMXpBR21pazZE?=
 =?utf-8?B?SHMyVUFkZkpsOFdZK2ZaY1g1K0I5TjZwdnlCU1ZHK1grSFpiNWNBVm1CU1Q3?=
 =?utf-8?B?aVcrQUVZekxFdHM2cVgvam5YM0VhY0JCK004Y0xmQmtMUU5yTkR1NjQzNHJT?=
 =?utf-8?B?ck5vQTYwQXNtRnVabktBak1vR253UVpNQlNSV3d3cTA4NVNyMzRIUEQvOFJT?=
 =?utf-8?Q?w7i0gJx4mKrXrtSnbS3bniP6y0SlEnOBXhZbSP+eIrDI?=
Content-Type: multipart/mixed;
	boundary="_002_MA0P287MB30827B02B90CCF0EF3D829D19F39AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 31796478-8e8f-4c3e-29ec-08dde4ddde38
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 20:19:32.3190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CH2VEhZ8TFbIIvyzEp2OOKwZojM39bYP8ZGWuh3HtciMRPfc0KyLS8i/RQ7es/58GWNyYpas0QS0IRlHTVNZbtgmSAVML+gAFeG9dF3JO5d8zTUX35rLI+2zzRfLAjcK2NnftqmchFPNafY3PFpKHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1806
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_MA0P287MB30827B02B90CCF0EF3D829D19F39AMA0P287MB3082INDP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQpQbHMgZmluZCB0aGUgYXR0YWNoZWQgM3JkIHBhdGNoIG9mIHRoZSBzZXJpZXM6IC0gW1BB
VENIIFYyIDMvM10gLSBDeWd3aW46IGV4cG9ydCBzcXJ0bCBhcyBhbGlhcyB0byBzcXJ0IG9uIEFB
cmNoNjQNCg0KSW4tbGluZWQgcGF0Y2ggMy8zOg0KDQpGcm9tIDliZGQwZWU0OTM3NWQ4NDJmZjIy
N2M0NjMxOTRmYjJhZDliODQzNDUgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBUaGly
dW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5j
LmNvbT4NCkRhdGU6IFdlZCwgMjcgQXVnIDIwMjUgMDE6MjY6NDkgKzA1MzANClN1YmplY3Q6IFtQ
QVRDSCAzLzNdIEN5Z3dpbjogZXhwb3J0IHNxcnRsIGFzIGFsaWFzIHRvIHNxcnQgb24gQUFyY2g2
NA0KDQpPbiBBQXJjaDY0LCBgbG9uZyBkb3VibGVgIGlzIHRoZSBzYW1lIGFzIGBkb3VibGVgLCBz
byBgc3FydGxgDQpkb2VzIG5vdCByZXF1aXJlIGEgc2VwYXJhdGUgaW1wbGVtZW50YXRpb24gaW4g
Y3lnd2luL21hdGguDQoNClVwZGF0ZSBgY3lnd2luLmRpbmAgdG8gaGFuZGxlIHRoaXMgY29ycmVj
dGx5Og0KLSBPbiBBQXJjaDY0OiBgc3FydGxgIGlzIGV4cG9ydGVkIGFzIGFuIGFsaWFzIHRvIGBz
cXJ0YC4NCi0gT24gb3RoZXIgYXJjaGl0ZWN0dXJlczogYHNxcnRsYCBjb250aW51ZXMgdG8gZXhw
b3J0IGENCiAgc2VwYXJhdGUgaW1wbGVtZW50YXRpb24uDQoNClRoaXMgZW5zdXJlcyB0aGUgY29y
cmVjdCBBQkkgd2hpbGUgYXZvaWRpbmcgZHVwbGljYXRlIG1hdGgNCmltcGxlbWVudGF0aW9ucyBm
b3IgZXF1aXZhbGVudCB0eXBlcy4NCg0KU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGlu
Z2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+DQotLS0NCiB3
aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4gfCA0ICsrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2N5
Z3dpbi5kaW4gYi93aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4NCmluZGV4IGNkNzFkYTI3NC4uMTdi
ZDM2ZTBkIDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi9jeWd3aW4uZGluDQorKysgYi93aW5z
dXAvY3lnd2luL2N5Z3dpbi5kaW4NCkBAIC0xNDUzLDcgKzE0NTMsOSBAQCBzcGF3bnZwZSBTSUdG
RQ0KIHNwcmludGYgU0lHRkUNCiBzcXJ0IE5PU0lHRkUNCiBzcXJ0ZiBOT1NJR0ZFDQotc3FydGwg
Tk9TSUdGRQ0KKyMgT24gQUFyY2g2NCwgbG9uZyBkb3VibGUgPT0gZG91YmxlLCBzbyBhbGlhc2lu
ZyBzcXJ0bCDihpIgc3FydA0KK1thYXJjaDY0XSBzcXJ0bCA9IHNxcnQgTk9TSUdGRQ0KK1shYWFy
Y2g2NF0gc3FydGwgTk9TSUdGRQ0KIHNyYW5kIE5PU0lHRkUNCiBzcmFuZDQ4IE5PU0lHRkUNCiBz
cmFuZG9tIE5PU0lHRkUNCi0tIA0KMi41MC4xLndpbmRvd3MuMQ0KDQpUaGFua3MgJiByZWdhcmRz
wqANClRoaXJ1bWFsYWkgTg0K

--_002_MA0P287MB30827B02B90CCF0EF3D829D19F39AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0003-Cygwin-export-sqrtl-as-alias-to-sqrt-on-AArch64.patch"
Content-Description:
 0003-Cygwin-export-sqrtl-as-alias-to-sqrt-on-AArch64.patch
Content-Disposition: attachment;
	filename="0003-Cygwin-export-sqrtl-as-alias-to-sqrt-on-AArch64.patch";
	size=1281; creation-date="Tue, 26 Aug 2025 20:01:04 GMT";
	modification-date="Tue, 26 Aug 2025 20:19:32 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5YmRkMGVlNDkzNzVkODQyZmYyMjdjNDYzMTk0ZmIyYWQ5Yjg0MzQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogV2VkLCAyNyBBdWcgMjAyNSAwMToy
Njo0OSArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMy8zXSBDeWd3aW46IGV4cG9ydCBzcXJ0bCBhcyBh
bGlhcyB0byBzcXJ0IG9uIEFBcmNoNjQKCk9uIEFBcmNoNjQsIGBsb25nIGRvdWJsZWAgaXMgdGhl
IHNhbWUgYXMgYGRvdWJsZWAsIHNvIGBzcXJ0bGAKZG9lcyBub3QgcmVxdWlyZSBhIHNlcGFyYXRl
IGltcGxlbWVudGF0aW9uIGluIGN5Z3dpbi9tYXRoLgoKVXBkYXRlIGBjeWd3aW4uZGluYCB0byBo
YW5kbGUgdGhpcyBjb3JyZWN0bHk6Ci0gT24gQUFyY2g2NDogYHNxcnRsYCBpcyBleHBvcnRlZCBh
cyBhbiBhbGlhcyB0byBgc3FydGAuCi0gT24gb3RoZXIgYXJjaGl0ZWN0dXJlczogYHNxcnRsYCBj
b250aW51ZXMgdG8gZXhwb3J0IGEKICBzZXBhcmF0ZSBpbXBsZW1lbnRhdGlvbi4KClRoaXMgZW5z
dXJlcyB0aGUgY29ycmVjdCBBQkkgd2hpbGUgYXZvaWRpbmcgZHVwbGljYXRlIG1hdGgKaW1wbGVt
ZW50YXRpb25zIGZvciBlcXVpdmFsZW50IHR5cGVzLgoKU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxh
aSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+
Ci0tLQogd2luc3VwL2N5Z3dpbi9jeWd3aW4uZGluIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9jeWd3aW4uZGluIGIvd2luc3VwL2N5Z3dpbi9jeWd3aW4uZGluCmluZGV4IGNkNzFkYTI3NC4u
MTdiZDM2ZTBkIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4KKysrIGIvd2lu
c3VwL2N5Z3dpbi9jeWd3aW4uZGluCkBAIC0xNDUzLDcgKzE0NTMsOSBAQCBzcGF3bnZwZSBTSUdG
RQogc3ByaW50ZiBTSUdGRQogc3FydCBOT1NJR0ZFCiBzcXJ0ZiBOT1NJR0ZFCi1zcXJ0bCBOT1NJ
R0ZFCisjIE9uIEFBcmNoNjQsIGxvbmcgZG91YmxlID09IGRvdWJsZSwgc28gYWxpYXNpbmcgc3Fy
dGwg4oaSIHNxcnQKK1thYXJjaDY0XSBzcXJ0bCA9IHNxcnQgTk9TSUdGRQorWyFhYXJjaDY0XSBz
cXJ0bCBOT1NJR0ZFCiBzcmFuZCBOT1NJR0ZFCiBzcmFuZDQ4IE5PU0lHRkUKIHNyYW5kb20gTk9T
SUdGRQotLSAKMi41MC4xLndpbmRvd3MuMQoK

--_002_MA0P287MB30827B02B90CCF0EF3D829D19F39AMA0P287MB3082INDP_--

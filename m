Return-Path: <SRS0=wccw=A3=analog.com=Ankush.Kumar@sourceware.org>
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	by sourceware.org (Postfix) with ESMTPS id EEB0E4BA2E14
	for <cygwin-patches@cygwin.com>; Mon, 23 Feb 2026 08:49:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EEB0E4BA2E14
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=analog.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EEB0E4BA2E14
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1771836557; cv=pass;
	b=HoyP7GOsAlKGl3IDw6B6EesQdkLq5zIumR6ejn45jxxonZK+FvSc4I3Wi5ehurPYUHqGCeOQJuk+CSLHdwnH4TvWXkLMfhOvWiyObD+Z285D3Fma0iJIIrmi1SjeCm5V446HZwBK+HOM4vKQuj4FaStCs5ut3rTlIZ/0eDsyhGo=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771836557; c=relaxed/simple;
	bh=4NIjBBHeooD6AHx0ksybHqh3wr+Y1wx0i0RsJ5ZVlFQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=S/Eyye8H2g3TUcOfbmukiU2uy9rjwNH+Y+GjoKQ07dsoSTJY4HQ+fEYFWwE0YsjfxbK+47fn0BJfSvMIq5gSqyJCIhfHofNSUx63r0ExcaPeemiCdntaAMMZXNVw8J8DW7FxsSnIHpTBjbaKRurr+Pswu5M0yqEbrhnvlgfRI6E=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EEB0E4BA2E14
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xjQUqG32
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N4gRj52933751;
	Mon, 23 Feb 2026 03:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM; bh=4NIjBBHeooD6AHx0ksybHqh3wr+Y1
	wx0i0RsJ5ZVlFQ=; b=xjQUqG322h+Tq94bV6BHYDbA/EFAPyB9aRaVvZc4vhIz1
	ezlQfj/09hJE7YdRY59DuHcOE1m644ue6dpV9CTiqTTWKpSsv272gT6ynj3M8K8B
	i0Tiapxr7UkXXDc+El+0voxzATYxkIgew4zhu761oYZftvs/K8ppg1KMmlWxPZrX
	+JB5cFJak+t9xH5ja7up/NC3jvZuOr1mJkZ9RjWBEvfXmgxmQWl6KcMcQb8wVpRF
	tekPkNylgKQ5vEe0/1/7HZnRTy/7hSFPXoFqI0bmC9ih3pRa5Ygun7cUhow+3CaL
	B39n9LXRCiKaMKblDylvgQNnOobJjUfa+CWVPknIA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cf7b951wk-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 03:48:58 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtqE/vySFcqe9RgxXMrqtUbcPvgCB5LLhUnXp4xTXUnd6J7sJ2r+JbxpnM++UU0xT6PFsP2W/FF6/iBRKs3u8m6MXp/Khy9uMM8qk2hZDDKa3M5+DY9n5t8U7HOq8+HDXvaK2bV8tBKCbrP1OCFAcWzYpNkSVtua3BBUdxmuuOzhPaV9q57EF6PpF3MR289ywo8xHa1pjd3TfiokjoTbmhJAFgX/vdN0LzltwzB9f96CDQZ1qgRLuCO7Cswr2NBdiNlhgPfg0ggxdR0biPWN5L44r7m/ntxi+LgCeAFmrKunXIDA9/+23GCSI/9HCGM/gL5g6anL3A046sSYr8RfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NIjBBHeooD6AHx0ksybHqh3wr+Y1wx0i0RsJ5ZVlFQ=;
 b=eNTXNkgP3Kd+VaM+XRE8rjHhXJypmgIfqxUijIDOkGPMCsrNp5/czI6rd+9iwRCvzhiexlBWihvYRS9jk80RowBs0IxGLD//x9QnMdAtgbqpRQp0RcOhNR9i6WqmSsV7uejMO40U/u2SYK9pKQxC0eTDnOjwIjxn51hsfTobuUoe+8tISsejhyaRAttIcqJu4icyGKUXz1nVXtkQldt38a18CLfaoZJ9hfH2rZVrJFuFIxjDMKixQGfHfqvznIx9K3t7nynDmqx/w0ABHn7YnNYwSMB5QSLhq00W7eEAyGHjeBW2S6BSD2FdoBbTps61hYD+x4oHDe0RtRJjY0nM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CH8PR03MB8322.namprd03.prod.outlook.com (2603:10b6:610:2bf::11)
 by CO1PR03MB5764.namprd03.prod.outlook.com (2603:10b6:303:6c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 08:48:52 +0000
Received: from CH8PR03MB8322.namprd03.prod.outlook.com
 ([fe80::a581:e71e:4460:9cbe]) by CH8PR03MB8322.namprd03.prod.outlook.com
 ([fe80::a581:e71e:4460:9cbe%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 08:48:52 +0000
From: "Kumar, Ankush" <Ankush.Kumar@analog.com>
To: "Kumar, Ankush" <Ankush.Kumar@analog.com>
Subject:
 =?utf-8?B?KFJFTUlOREVSKSBBQ1RJT04gUkVRVUlSRUQ6IEJpdGJ1Y2tldCBQZXJzb25h?=
 =?utf-8?B?bCBSZXBvc2l0b3JpZXMg4oCTIEdpdEh1YiBNaWdyYXRpb24=?=
Thread-Topic:
 =?utf-8?B?KFJFTUlOREVSKSBBQ1RJT04gUkVRVUlSRUQ6IEJpdGJ1Y2tldCBQZXJzb25h?=
 =?utf-8?B?bCBSZXBvc2l0b3JpZXMg4oCTIEdpdEh1YiBNaWdyYXRpb24=?=
Thread-Index: AdyJQyS+K8UoCwdBQGef8AAb4fJSLwbXg+vw
Date: Mon, 23 Feb 2026 08:48:52 +0000
Message-ID:
 <CH8PR03MB8322C1CD2F3953EFF8F64190FB77A@CH8PR03MB8322.namprd03.prod.outlook.com>
References:
 <CH8PR03MB832282C8067513749ABFBAD7FB88A@CH8PR03MB8322.namprd03.prod.outlook.com>
In-Reply-To:
 <CH8PR03MB832282C8067513749ABFBAD7FB88A@CH8PR03MB8322.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR03MB8322:EE_|CO1PR03MB5764:EE_
x-ms-office365-filtering-correlation-id: 435100b8-76c6-40ed-6179-08de72b85ec6
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|8096899003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjZHL0lLRHhzSzlDY2dmeHFhMVpvWklkY1hmQVpEK3hDREdGN0ZnczduNytm?=
 =?utf-8?B?SzhRdVlYRXRIcHFGL2IvSnhTd1hIUDgzVjhidWo2MUNyWGNaRDFWL0NiaEN0?=
 =?utf-8?B?R0g0OG1OSXAya3M0eHVUSkJrYkt6eVVKOUtqRmZUYmtHNWNrNWEvZ1M1TWpP?=
 =?utf-8?B?aGNKV2ZxN3MvY1QzekEzUDVydHYwSC9ZSE1GMkliQTR2dGcxUGxsTklObnVz?=
 =?utf-8?B?ZW9ISm9vRHZCb0xqZ1NVWXAvNzJVZ1lMYkJJZlNBNWJQYjVNRFJ4Ry9sQ2Ry?=
 =?utf-8?B?N3gvZXRFUjVienF6NVJVSEZUbXpTYXBuSDM5YnRLNlZyM1BPYXlnMDNWY2JY?=
 =?utf-8?B?MDdsVTBiMDhpWnJnT1hPeFNRc3pWWGRuR0FjcmEzVUZyWFV0SXNlUzZHdjhK?=
 =?utf-8?B?azZtSHFiSEQ4UjdiRENKMWw2ZkxjeElYMkpROE8yQm5SOC9pWlR1b0h0bU5L?=
 =?utf-8?B?N25FVFFySzhmblBqUnAwS0pwb0F4TThIM0EwNFY3TXZPcHdWM0JCbFFTbkJq?=
 =?utf-8?B?aVFyOEt2UkI3R29GYVhlL25EVkptRFlrZm10OC9xUGlpOXBNV2F3ZEZuZXB2?=
 =?utf-8?B?YkxEL2gzOXhvcTQ2RDNkMWFlbTlQWWZ5Y3ZTYWNJRHRpNTdQQXZmTmo2UWV2?=
 =?utf-8?B?Y2dwdC9kMnU3LzUwMkxvQlpGMFJBQUJIZHgxeHljckcxMSs1Q0FEV09udnl2?=
 =?utf-8?B?ZVhpclFjMU0zUHluak9tNm9ZYXBRM0VnUkhJVnhkeTNOUXBtMDRqRlJuY2E4?=
 =?utf-8?B?TWpVeHN3OHFzS2VRa1YvTHNVR2JyNVFGbUsrNVRFZm9IME5jQStidGplMHJS?=
 =?utf-8?B?NFRacVpqeXpZOHprelVMaldGYmtxUVZsdmxVaWJoNnRuZEFnUHNEcUgvSDZo?=
 =?utf-8?B?S2pKbFlrZUlnQ25yWncxeUV5UFR4QUJnaDI3ZndCWk5ScHdqREdqWDJ2QnZz?=
 =?utf-8?B?RnluZXlyYnVlY0F5cjBENkxUM0IwY3gzdHJ0THBBcHNKY3piOEYwSXVMUkI1?=
 =?utf-8?B?VWhQcFQrQkhBbXR6YUNnM2ZyckVxbEhpSlhUbkIrVG5iaEVjUVVlUmJrYUxX?=
 =?utf-8?B?MG1mMWxyQWREUUxiSzE0cDFyZmZueVE2dkdybkpxalZGUDA5TG95NDFLbkli?=
 =?utf-8?B?TWNWR1JQdGhoSGRUWkQ2eUNOYllySmhMTTNwcXRMWkhaaVhuN3FmdFB1OWZ5?=
 =?utf-8?B?K3B6SVVhaXZJa1RxMTV3VG4rbk44ODBsOVRVSXVGSXpuM1hRWitMbEJzdi9P?=
 =?utf-8?B?N1NTV2duYmdpY0ZZUjdLb3BWY2x6a28reEx0eG12dFZkMlVhRVoxS2tHbkhj?=
 =?utf-8?B?TEkxTlJ4Wk9tNWp0eG94Z0ltOThyM3g1bmJmUmxhTkl0a0NvVURCY1FhQlNG?=
 =?utf-8?B?K05qQ3FqT3lsekt3SDNYd2hSRTZZMHRyUnJUaXFmTFM4L09rMURCWjFLVDNq?=
 =?utf-8?B?UTNqak14dXlGWVczeWV5TXhPY3A4WU1hUStjbUJlT2FxTCtOM09USTdNSG45?=
 =?utf-8?B?ckJOZTMrWUVTaFloeFR6ajNtcEY4bGlLRGlqU2MvUFFPRndhQkNKeUV5ZTBN?=
 =?utf-8?B?V2VoK1czTmNtRlVtQWhleEQwdjJPSktaNXJ6TkcwSmVZeHQ2ZDY4K2daN3Rl?=
 =?utf-8?B?S01XY2RsaGtRSnN1RU5UVzVFNnZIWXlIVTFDVVRTSGFHNDZaNWpIVW12aFhN?=
 =?utf-8?B?bXVFdCtjUWh3ZXRjNDVla1N5V05jQi9rV1J5bUtWUThFWEE2Nkt3K2poUUla?=
 =?utf-8?B?bU81OHY5Q2E3dVM0czJFRHFoTFcxanNaNFRRcUlGdUozS1liRGlvWHdZRkFa?=
 =?utf-8?B?U3J6bnRWTVVKQ2pOYzZiR3ZtL05SNWRBSHJuV24wWnFCVFdvNEhwaENCVits?=
 =?utf-8?B?d0hxY3FuUUMyVkFnUzFZUGxPcldaaTVUbkFMeEJoRUhGd2RuZWVqd0xXZ2hq?=
 =?utf-8?B?TXY5SktGeUNLbWFTd0RLQ2o2VzZwc2pCVDdXd1JZNHhmZmFKUkJnNFl1T3JC?=
 =?utf-8?B?Vyt4KzJZcm5Vb0txMmhuNEhHZkhjbFE1UzBiSnM2aUpYQnBSUnZoOFpydGJP?=
 =?utf-8?B?S1BzTisvVUt2dGZoNmJBcDZJN3ZrM2w2Y3RubU00VFlDVm11WFNUWEdndEY1?=
 =?utf-8?B?cmpBWGJFbUZLZTgzTVdnZVkvUTdOTVZwM3QvZlVDTGcxNU96S01IVkNnbG45?=
 =?utf-8?Q?8eoi2i77CGrF+bcpdnY0qeQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8322.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(8096899003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXA4R3h3TnB5b2hsdG5EV2NYcUdLdnJDSHRWUnVQai92M0wzdWRrc3F2alJz?=
 =?utf-8?B?bEJZdDRFQ2lBZUhSWU1pNU1lcDRucFlCZzc2bDBCMTZsZnZqL1NuY0N3TTZh?=
 =?utf-8?B?NXJYeDVIOUlYOWkvUDBBNDk4VVl1VmJKU1dsSDlTRzB6Z1R5cFpOTkVTdE9j?=
 =?utf-8?B?TVhrRUJFdUJpd09TcVVUVkVxQUFoVGNnbDN1WDFadGd4eEpPWFZTR200aUQ5?=
 =?utf-8?B?MkppT0JpeVY1TU9DanFGTkF6alJyK2MyajQ1aHQ2eE1kK0VIbjMvQkNLSUhN?=
 =?utf-8?B?c2JOdENwelBWcmdwMHhjT1MvSG5DZWRGUGdvRmQrN05ONXFVMjluZExlRXk4?=
 =?utf-8?B?ZzM0a1pQK1dRNzk4aUhJRUljQkxOdkd5SFVidHJzWDB2WFNKK1BkRlRvVGRQ?=
 =?utf-8?B?STl0MXRraThpY3ZYMGZtT0RjaW5tRWZtazFhMk45T3BiV3NxcnM5S1BhNjFs?=
 =?utf-8?B?VWZ4aVU0YVF2WFlXalFqTmk2S3ZraGFiUnFmZ0hFWlJGdlVobmhJbyt3SVBL?=
 =?utf-8?B?dUNCdWI3MWtoY3RXUVdVa25MMkVWMlg3RmlyNk9TSGZVWHRReEJRSDNNek91?=
 =?utf-8?B?ckFGdGUyZUFnd1RROWVmTitKck0wbG1PVitlS2xqVVppQmdpempCQmhhSFNX?=
 =?utf-8?B?bzBKaEhmeEpncDNlbXR1d0ozUkRCWHU3QnZTQVh3c3l0Zm1JdkRqTUszT3RF?=
 =?utf-8?B?bDcyUDB5N1QxSWZsTzV2NUE4ZEZ6V2xKV0ZDOTBPMkswN1N3M1BqTGcxc0hI?=
 =?utf-8?B?amVFRVlSQ3RhWmtER3I4c1dvRzZFWG55VkgrSVNXMUNOMzJJUFEvNDBVdlhX?=
 =?utf-8?B?andqVlpDUDZ3c2JYQUZvNTA1OWRDUG1lb2d2UnE5MFU4dkk0U1dQUjhJWGk3?=
 =?utf-8?B?bW80UGFZMHpVRTlqQTdWM29MRnYrU1ZzK2lxQ1pQUVI0MmIvVCt3d3NzL09G?=
 =?utf-8?B?ZHhadUt2U2J4NWdiUlpzQVJwaVlSenNVNjJzRTRUVW1HaEROTVZnUHM4ZFlL?=
 =?utf-8?B?WFhTaGNNM1MxWWwzeFdDanNZbEdnN2ZtMjJES2psWkxIOXAvMUpISmw4U3M3?=
 =?utf-8?B?ZWUyYmRoOWk2YmRySm55UXhYUlh1UVJYYTErc0pTQ0FwVHhuelZ1ditpL05P?=
 =?utf-8?B?QW5UT3kwNUxrQkFJdTdHcnc4cUxVN3FLanlVOElxZ0J2NUdxd2VuK1l1SlV5?=
 =?utf-8?B?cVNnUzFoUWZMNWFtWXRkVThWMmgvNUFSeThKUzBYdXI3S2kwc2l0N1YzRXh1?=
 =?utf-8?B?TXgxNWM5TWFTc3pVYU1zSlI0NzVZK2FGeWp2QlNVYXl6VU9zZlBYa2dtTnoy?=
 =?utf-8?B?WE10S1dPMjNOYVZSZkgwN2tpMVlJRDV3bjMxMjFSSnczQVo4R3RNY3gvM2ZX?=
 =?utf-8?B?UFNpdzNOZUtUczM1L0tibnJiT0RJWXJZZ2o5Mk5zbGdIb1oyaE1IdFYzL3hE?=
 =?utf-8?B?bDRWRG1NMC9CSE1ITlplYXF0U2RlRWhEekFmbVlTZzQ0ZHJOYmhyTVI4L1Ju?=
 =?utf-8?B?eXJRTHJXWHFZeGxqUGxWY2czWXp2NmRYYUk2aER5UVJaOFdjcUNoYm1MN1FW?=
 =?utf-8?B?YXd5bEthMWRFYStKNm1hZ2JBOFo5R2RTR0hwWndXNSsyOEllSTNKRUk4NW1j?=
 =?utf-8?B?RzYxZS81N1d6RjFpQUZuenJabkZqbDBtenVJRHhFOW1NdUw1TWhJek5YVm1m?=
 =?utf-8?B?T21TdGk5YmZyUEF3cjBQR3lHRThPc09kVktTQ0VZai9rekFpSHlQdk1RNjRy?=
 =?utf-8?B?aTNpQWVKWHRybnkxclFtSFoxZ3AweHJmcVlnN0c4ZXQ2MC9sTmJOS1lTZUhy?=
 =?utf-8?B?VWxEck9UY0JRWWxCL0VaVWxHbTFvS2paUENOMm9XZ091SlBFYzdtRjBoWDdU?=
 =?utf-8?B?M1p4VXdoUTdWNzNFZVNWL2pXSXpWVzI2OWFldWJBa0duYlFBWVh2WGZRN2VQ?=
 =?utf-8?B?RzcwdG4rYkF4b3d2bkxrcEF0Z3FPZEtzVS9OMVkwREh3bW5wVWpSRnl2alE4?=
 =?utf-8?B?L2dpNnRoZE1sL3d3RUVlS1ppcFgyb3hDeTllR0QreVpxc1oycXFNVCtQU2hh?=
 =?utf-8?B?ZnNXNUZnTVZTUmxrWVJnQmlnTVlzL0tsRDFjSUEyYStKUkh4MFIzQjNxUTFN?=
 =?utf-8?B?KzMrUE5lRVQzZmJMNzN0SGMrOG81TnRJTmUzVmk1UUJMOENSb3Y4bFl2MmE3?=
 =?utf-8?B?dnVJNVF1c0ExT2xpa3BCTUhpMnFhWERYYncyVTZwVHJzUXRXNnJIbGtjelc5?=
 =?utf-8?B?ems0T2Q1SWZDZExBa1E4U1lYU2ZXbG5sWk5qaGFXV3NjWWVGRHhHUHVmbVlC?=
 =?utf-8?B?VkZtK0pGK2kxUk13ZmU2dVZ6R1F1YkhCM0plWWJ1WUVYazI2MUlWZz09?=
Content-Type: multipart/alternative;
	boundary="_000_CH8PR03MB8322C1CD2F3953EFF8F64190FB77ACH8PR03MB8322namp_"
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435100b8-76c6-40ed-6179-08de72b85ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 08:48:52.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRDZmZ9wZAjo5RMUK3nYljvUbiB4BP0DqrmUU7L1i4jJCL38eB2w6HlS8+d0QD9ltGV/z2tkbM4Pxy+SGAQEDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5764
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NyBTYWx0ZWRfX0R7dWTgwQysv
 hLrju0MmWHnpeP2VD/N8wVW9jeX9s8lXZ+R4pL6yEIleS8jhDJB0k8xuekIx+mICwG92gr+SQV9
 3/4/YUJiizneP1vek7X7L9xVTrmdQM08uvHM5a6DhWqZAZxrkxHx/q5Z76saBx5AgnL4cOOVDsF
 FnWhs1UD8j1o5T5jUe+4DzU18WgR9ugdoDLQdW27kl2Z8Cw/GhpV8Eim0aqrQXoam8sEOlvnYTq
 iJnBYDDhaqbCsoJST9IlsbtMNgMlM0p+M8u/yZ4/KLgcKsrrl9JFRt98LtKTs/St9TIh2CN5ULc
 33p5gSImYJE64KvTgtKITob5U/cg92JMatvdUUOa3UbfsZapbARhtTCjncyR4iwpYpLcWnglMLl
 mWvo5aaUorjqvKAioGq8zyIN3ooC4KWYlrig/rJkpWPPYmv5UC2HzH8IpBqcMV77KwBplCA2ild
 zLZEksORwbQCvEQoEJA==
X-Authority-Analysis: v=2.4 cv=JrP8bc4C c=1 sm=1 tr=0 ts=699c147b cx=c_pps
 a=s4741YMcG+xsu4HPw1GdWw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=5KLPUuaC_9wA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22 a=gAnH3GRIAAAA:8
 a=mYwZfc-oHjdUWmC6CTsA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=fvepA52gz-ne2qlAx_UA:9 a=L7Opi32fIt6ctjhF:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-ORIG-GUID: TmXO4BAM3Mk9j_tKl0ASZdGy6fuB7wE9
X-Proofpoint-GUID: Wnz1gWLp0eUlRF1MygoUsGEBF5f67g2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230077
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,LIKELY_SPAM_BODY,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_CH8PR03MB8322C1CD2F3953EFF8F64190FB77ACH8PR03MB8322namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Rmlyc3QgcmVtaW5kZXINCg0KRGVhciBUZWFtLA0KDQpXZSBhcmUgbWlncmF0
aW5nIGZyb20gQml0YnVja2V0IHRvIEdpdEh1YiBhcyBwYXJ0IG9mIG91ciBw
bGF0Zm9ybSBtb2Rlcm5pemF0aW9uIGluaXRpYXRpdmUuDQpBY3Rpb24gaXMg
cmVxdWlyZWQgb24geW91ciBwZXJzb25hbCByZXBvc2l0b3JpZXMgKHVuZGVy
IH51c2VybmFtZSBuYW1lc3BhY2VzKSBubyBsYXRlciB0aGFuIE1hcmNoIDMx
LCAyMDI2Lg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCvCf
l5PvuI8gS2V5IERhdGVzDQoNCiAgKiAgIEphbiAzMSwgMjAyNiDigJMgTmV3
IHBlcnNvbmFsIHJlcG8gY3JlYXRpb24gZGlzYWJsZWQNCiAgKiAgIE1hciAz
MSwgMjAyNiDigJMgRmluYWwgbWlncmF0aW9uL2NsZWFudXAgZGVhZGxpbmUN
CiAgKiAgIEFwciAxLCAyMDI2IOKAkyBVbm1pZ3JhdGVkIHJlcG9zIEFyY2hp
dmVkDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K8J+TiyBX
aGF0IFlvdSBOZWVkIHRvIERvDQoNCiAgKiAgIFJldmlldyB5b3VyIHBlcnNv
bmFsIHJlcG9zaXRvcmllcyBpbiBCaXRidWNrZXQNCiAgKiAgIEluYWN0aXZl
IHBlcnNvbmFsIHJlcG9zaXRvcmllcyDihpIgV2Ugd2lsbCBub3QgbWlncmF0
ZSBpbmFjdGl2ZSByZXBvc2l0b3JpZXM7IHRoZXkgd2lsbCBiZSBhcmNoaXZl
ZA0KICAqICAgQWN0aXZlIHBlcnNvbmFsIHJlcG9zaXRvcmllcyDihpINCiAg
ICAgKiAgIFBlcnNvbmFsIHJlcG9zaXRvcmllcyB3aWxsIG5ldmVyIGJlIG1p
Z3JhdGVkIGJ5IHRoaXMgcHJvZ3JhbS4NCiAgICAgKiAgIElmIGFuIG93bmVy
IHdhbnRzIGEgcGVyc29uYWwgcmVwb3NpdG9yeSBtaWdyYXRlZCwgdGhleSBt
dXN0IGZpcnN0IGNvbnZlcnQgaXQgdG8gYSBwcm9qZWN0LW93bmVkIHJlcG9z
aXRvcnkgYW5kIHRoZW4gcmFpc2UgYSBKSVJBIG1pZ3JhdGlvbiByZXF1ZXN0
PGh0dHBzOi8vamlyYS5hbmFsb2cuY29tL3NlcnZpY2VkZXNrL2N1c3RvbWVy
L3BvcnRhbC8xNS9jcmVhdGUvMTQwMz4NCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0K8J+OqyBKSVJBIFJlcXVlc3QgTXVzdCBJbmNsdWRl
DQoNCiAgKiAgIFJlcG8gbmFtZSAmIEJpdGJ1Y2tldCBVUkwNCiAgKiAgIFRh
cmdldCBHaXRIdWIgb3JnDQogICogICBSZXBvIGRlc2NyaXB0aW9uDQoNCuKa
oO+4jyBSZXBvcyBub3QgbWlncmF0ZWQgYnkgTWFyY2ggMzEgd2lsbCBiZSBh
cmNoaXZlZC4gUmVjb3Zlcnkgd2lsbCByZXF1aXJlIEpJUkEgYXBwcm92YWwg
d2l0aCBqdXN0aWZpY2F0aW9uLg0KDQpRdWVzdGlvbnM/IENvbnRhY3QgYW5r
dXNoLmt1bWFyQGFuYWxvZy5jb208bWFpbHRvOmFua3VzaC5rdW1hckBhbmFs
b2cuY29tPg0KDQpUaGFuayB5b3UsDQpBbmt1c2gNCg0KDQo=

--_000_CH8PR03MB8322C1CD2F3953EFF8F64190FB77ACH8PR03MB8322namp_--

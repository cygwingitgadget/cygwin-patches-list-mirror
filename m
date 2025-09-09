Return-Path: <SRS0=g5SI=3U=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id D07B53858C42
	for <cygwin-patches@cygwin.com>; Tue,  9 Sep 2025 10:01:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D07B53858C42
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D07B53858C42
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1757412113; cv=pass;
	b=woRJHzPFj9ydkfLlMNPHjvJaOTOd6hkr6wNAOJvbue9HXiKP5Cj7MnO6Z6/3i3MIkFGTsugwH7QgO8vHsJFEeUu6YX4EN/6HM6cOprtD+7lazYyIqKXsb4ysaHu3N3DhnuHsYsGLfj2D7AYQ6nJ6ToBlVfELo2WedJkGa6gCX0w=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1757412113; c=relaxed/simple;
	bh=keeeGqXCPh+twUOcw1IgGg8a+6Yc0aMxMqFu7sjDkQY=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ZTik9hOqZJ0w8v94hc1hGjhcJ/4BPZ+bPcX81LJn2tVlKaVP/yjX5goDTgd0LP0sHsK+sBBMnMaKYsdKQcfh6XZNymyBPIGXfPZhddKox+S9BPb9UH4+U1nsjxbDecJVBAeidUQrm7DcyZTgecVCOauKCDmlfO9XjMzKPdREwIA=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D07B53858C42
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=2n57csq9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJJ5ydR4bhbnVm/aCPxrHXNgW+mCtw501Y5P2J3sqY3aHWMyZfdkUBqtvvGlxVux6qGl+adeftIQ7e/k8Zu5B49acvRDMhDwbxbXeHJSjclAN2FZE0E1b7KZA4A6APTLGURHJxxwV1uLI8RvYPGNdmXY196G949B+tHUbSJ+Kunbk1D4OmM/qOXn8fC+/JEPVdR+W+UqqfNFS3vpsoNODsMfWM2NVOWsEaN18u75/fbFTHJC02Pc+YrNB4euPLoaj2do71YtXMq7GyDFXlkroN0mApGZGT8xhl0CG9J96q9rp3BqZ5RpPUmTx3yXb0gxD/QY8NtebN/oU6aOmw3IKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD3SXytNGbQMktEEySV6pkT5W0Bqdy9Ym1Jv2Z4s4Sk=;
 b=h95ROM9gQG+aWPOIlL6h2x8Rv1CN2KXTIG6Gf1guVepxxniQXJXkoxfBXNuxAHn916Bo7ywMPA58PcoKBOxDaqvk4vVne/6tOQuAOYK4GIoNdmzhY3wMDzvk8ceTDNi0phqfeJzUtG1ACEQY5rMQPfWLIOSwVn4Q1QK/96n627ZfTv8KkD0tEh1xTFL3NJ6Sp1QZBhCwkxheqS4cNv/inpAuiYIIeY9/E5O73Na330CZoEL4YoIWXfTXFpYqILMQmWhIT1ETXf+GMO1T9nSjtUtHphXBGz2rkklOTOWWp5pYSJmCsE0T6uvL3Q43mQu+otBIocryhwN1iptYYkiI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD3SXytNGbQMktEEySV6pkT5W0Bqdy9Ym1Jv2Z4s4Sk=;
 b=2n57csq9ve2NstP8Wm1ZaRqCGaP/3m0themPTozY+66tJ/iUbrQ9roMTU5c+fu21rSYzyb493AVLKs1umBj6i2u/ycXcP/960K9YZiPbzp5VAorUUhEfJi+UN5QuShPb22vgoooNApcdSTON9CiJrZdo/kuQCVasKFSdtMzjqKsOa02+3/P894f31EQWAygOwfnFhO/3NwKYjhK2e1y+GtTXz2cAbMZSvyd/KCmwqAX8WsVFeqyYvdZnluhRSa1Bw9fmYygK0jb2SytNPmg43gY8dfQFZ/arZZx+7XI1hrgZ+YxO7KdT5x6cxEKUFNmhJcTtwEZo4oauW87nA0xisw==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN2P287MB1405.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 10:01:48 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:01:48 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V3] Cygwin: math: Add AArch64 support for sqrt()
Thread-Topic: [PATCH V3] Cygwin: math: Add AArch64 support for sqrt()
Thread-Index: AQHcIXDBxaYZgkfqmECqSFfxNzCyNQ==
Date: Tue, 9 Sep 2025 10:01:48 +0000
Message-ID:
 <MA0P287MB30823375C18D28AC2E103D189F0FA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
In-Reply-To: <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-Mentions: cygwin@jdrake.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN2P287MB1405:EE_
x-ms-office365-filtering-correlation-id: dd095d0f-25f5-4923-7d74-08ddef87e425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?MnpvMERnSVc0c0VRQ2c5eU1GNnkyTFRZaG80UTJQUFlJRFJ5TngvWmky?=
 =?iso-2022-jp?B?aWtRdWhPUDZocTJRTXpIYnNpZ2phTGVuenJENzlVZnMyV0VtMnVoek5p?=
 =?iso-2022-jp?B?WWxQQmVQM0JpcW5Bd0laUDNBWUNGSUlzWWh6S1kyb2Q0Yzlyam56VWVh?=
 =?iso-2022-jp?B?TzM4TzdKQ1RaSU9kTUxISW1Ebjg4dXl4ejVFbXkyQkZ3SHJ3Z2VxcFZr?=
 =?iso-2022-jp?B?ejZ2VnlvRzlKMWVGZEJ6S1RUVUFjR1NqR3J6VllHMTdBTHVOWlRwVWVY?=
 =?iso-2022-jp?B?eTBaODlySSttQW5rU3dNSW5NeklyRHVRd1pQMnlremdjTTZyaXh6bDJo?=
 =?iso-2022-jp?B?SFJ1U21ZdldqVU10MEYxVHRtUjJ3UkRuZE1wZnc1NElkQmZrMUhRV1VF?=
 =?iso-2022-jp?B?cHIrN0Z1dG01c2htMGNpNXE4OFRxYzRnY1VzMGRPbGtpV2srL0trOXJ2?=
 =?iso-2022-jp?B?NklYekpYTmtoalZaY09YRitoZE1hTFZ3bGV0QlJiNmkyZkh1alRJNWJT?=
 =?iso-2022-jp?B?VkdPb2YzNmpENno5cng3cUttMzBBaHJNUXNtWGpQNllEbWVuOS9XU3BD?=
 =?iso-2022-jp?B?NUpLSXFYM1l6VGxBNk9kQSsvbVFNZnZtNHhMY1ZYL09QSGNyNWllNWxC?=
 =?iso-2022-jp?B?SUJEWFZDYklUeWV5Z1FMWnc3YnhBNm9QRHBQRU1ObnRTTkZ4dVpNVUtj?=
 =?iso-2022-jp?B?RklodmZhZWxidGhqeUx1SncwZlFMQTUzNHRjZ3Y0TzRyWFRjNTNhc0ZU?=
 =?iso-2022-jp?B?aWsxQXVodnBzM0JWNVMyRm05Q1QxWHFpZklSaXJQL3JwVEcyVzU3L2xN?=
 =?iso-2022-jp?B?c3VLRGh3QVlKNUpqTEgwRmJiN0pLYWx3Y2E3WjZUMDNueCs1MlNoVFdy?=
 =?iso-2022-jp?B?ZVZCZ1pibFNhclhJYi9kdnZSU0dCdFRRS01OdW40aVpLUTRRNHhpVzBW?=
 =?iso-2022-jp?B?WUhLQUlIZzEreGpGS1gzcEJEOCtrTHNjZG83WExWVm9NOC81c3I3MlhY?=
 =?iso-2022-jp?B?dHVuaC95ek1sS0JhVjBwSnlubzgyY2NIdkRVMnJ1QVdqRS9kTm5TZ3Bx?=
 =?iso-2022-jp?B?RUduT0p5REZINDJSbHNhcit1d2EzSVQreGw4dEhCSVE5UnBqRm1kM3VT?=
 =?iso-2022-jp?B?RDd1eGQxUGdobUNoTFRkY0sySXd2RSt3VnhScGpkWndxbGd3TVQ1bXZG?=
 =?iso-2022-jp?B?Qk9keldVL3hPa1FEdTNJOFltL1kzbGlDaFN4R0pIRFAvN2oraUloVDlq?=
 =?iso-2022-jp?B?QnAzUjFRYTl0M1FFaEJDS2dDdVY5SkhiaUozRHhIMk80S08xZUY5MFlH?=
 =?iso-2022-jp?B?bldhdE9WUzdjU1pmOGcyNnF3cTlROUF1MVdidytRZWxaN3Q1Wm9xN1VB?=
 =?iso-2022-jp?B?ZnBmYkxGc1RaNnNmcFV6aXJ6WVdBZVZ0bkVKdFMrVXN2UHB6WFgvalhX?=
 =?iso-2022-jp?B?RnV0eG9OaVBmTDNGQmtIZ1Q1WS92Zjk2SmFuWkZZLzZlQXhWak9ZYXRD?=
 =?iso-2022-jp?B?SzZiTHRJOVdYU29qaXQ4eS93YXBPSlMxSlJkTHVpaUwwaTdTczU3SDhS?=
 =?iso-2022-jp?B?WW12M3R2ZEE3bFpnS1ZzdXNaRS9taGl4NWx5elNsU3QvdStkQVh0N0hE?=
 =?iso-2022-jp?B?T3lmWlRwVThoT3N0WVA4cGNGK2NNbHNrbTFBRXR1V25XS0JJRFh2VE9X?=
 =?iso-2022-jp?B?ZThBUnhIZnZERkFqdDlLRU5CbU9XcUxkdEFJa3Y5MlJkUnl0VGhqZC9U?=
 =?iso-2022-jp?B?NFE2S0htbnJDY0p3VVNJc1pPcXdVS05mYm9kVDd1NDdEUTlaTittdjVS?=
 =?iso-2022-jp?B?RExYZnNhd1lDaG1ZMVBML2lqK3Q1V2dUcGNjUkRLU2w0dDVNaEZMYkhk?=
 =?iso-2022-jp?B?OUZtR0l2NXNaMFZEMUVITURTd0xUSXFPYklpYjFvUnEybjJRcWlDekJl?=
 =?iso-2022-jp?B?ZjJ5YS9pZjdDanBiVWV0RTlZcjlVb2pOcEUrQ0Rsa28vTnZpV1JJS0w1?=
 =?iso-2022-jp?B?R0srcDdJcVYxNnJlSytTWUdVaWsrUmFaSnF6bTZCWEJyU0lYRHRzV00x?=
 =?iso-2022-jp?B?c1JrNStBZmtFU0xSaytLNS9xYUFyMEs5eGYvaEVlTnpTMTRqZWJaR2o1?=
 =?iso-2022-jp?B?cFhqT016ZU9oUVpwclBOL25UcXdHdnoweUJHNWcxcGJqTDR6ejdDOXZr?=
 =?iso-2022-jp?B?WSs0PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MDdzZVN4QmJJeUJpNlRncG9PM1M0YTRiL1A0Uk1qTU1CSHE4M0FuemxQ?=
 =?iso-2022-jp?B?Y3JlNVh0T2p3UlErMXU3YUM1VUVaMFR4RjAwaXI1WGNDRFZ4WnVGNmpq?=
 =?iso-2022-jp?B?THkrZDBsUDV5bWVFTnVuR2Mya3pwRW9zUGlrdVFCd0QwRjdhbTFUNFJD?=
 =?iso-2022-jp?B?eUY5THJJM21iREZ5QmdvcHBlWmRwMTdBUm01cFJwS3UwcjFSTjM3VTcy?=
 =?iso-2022-jp?B?a3dlc21XUnhaVDkwNzRkREtrUW5zZkEyOVZ3Ri9GM2xmdDFQYmZ5d1B6?=
 =?iso-2022-jp?B?T1E0c1BMQStNdzgvSlBuTllEc1I2a0FlWUlzdUVaTXBNZk1TVnk5TXZO?=
 =?iso-2022-jp?B?REZ6UWdHclgwQko1U1ExbDkvbFpsRk5pTDNzRTlVeUxrWFl6UHEyQk0x?=
 =?iso-2022-jp?B?aHBYYzZ4ZVQ3YWFpa3NCaTRIOXFMZWRGMnM1NHhJYk9QSTRjbFZRU2h0?=
 =?iso-2022-jp?B?UHRyMDFDS0ErVGtIR1F3MmZiV0pjU28rTDBiREVQZWhEZVB4N1pnVjhl?=
 =?iso-2022-jp?B?bzZBbGxoUjVYcHBJaEF3Z1puY0Z5R1d1Z0JjZDBjRzEzOVRpMUdBUTE3?=
 =?iso-2022-jp?B?YUsyNFUxZGtoQkRCVjNvMHZUTGl3NFROTGdEcGw2WmRSVDhXZWdCV3B2?=
 =?iso-2022-jp?B?WTRoZDBoOTBYOTd5VVJsR25NQ1pVbDIzMFRzc0d6RGhJbVYxTnRlSmd5?=
 =?iso-2022-jp?B?N2swWXA2VzZWWHVQT0N6SzZXeXo0MXBLSGEyeCtnOWVVeWJKWXpBd21N?=
 =?iso-2022-jp?B?eDNaYkgrbmMvZzhsZ2k3UlUyY1JtSjRUbHgwNjNHbjZsdUU5YmdTSVZn?=
 =?iso-2022-jp?B?UjFTZnZ2WkJnU2lHQVpZYzNzQ05nenNLM2J4K0duMXhxbmtJbng5NFRj?=
 =?iso-2022-jp?B?SC9jRDFmdzBEZHkzZ1lpWlY4dVQzK3pyajdnRFNuSlZ0elpkeDlmSXlN?=
 =?iso-2022-jp?B?OWlnNElrU3E5SFYxZnRKMG51aDJMREhVdHRDMGRFQ2YrVU1qV1hOZjF2?=
 =?iso-2022-jp?B?WjFWSStpRjRKajBTaDBKam1aY0hjN09Bc0I1cjRRTE16VllFdGhYRXV1?=
 =?iso-2022-jp?B?RG4wV0dSR2N5VVZWMjgrTXZxZVcvT0QvODdGRDExL0lick5CalZlRGl1?=
 =?iso-2022-jp?B?c1F5M21hWDFuTDdVbFRTUi9zd3F1ZTBnZjR5R0JReU5xWU90UXdFaDlU?=
 =?iso-2022-jp?B?YUJlcnh1Y21IOE54UkVqeGR3dVIrSE1yTFZQN3R6cFRIcmhDV2p5dmw1?=
 =?iso-2022-jp?B?bXJuZ0pSYW1waGtsWjJzSm1kOHJUUVhzbitRRHNlV2FQWlNOWVdvaHla?=
 =?iso-2022-jp?B?dDV3ZnBTNzdjdk5WTFZZTENqRXZQR3dxb1o4djVXNmpmdm4vOWVaVDRq?=
 =?iso-2022-jp?B?RkRhc1ByTE5vRzMzSVpZK1JSa01Cd0tidkJjbWJmSHppb1dtekR2Zkxw?=
 =?iso-2022-jp?B?Q2lON0FzUmcvZXVId1JnUUVySGhzSncwVENQOUZXSzI2d1BpN1JiWDNL?=
 =?iso-2022-jp?B?Mmp6TW9qWmYvdzNxVThBSm5CczdIU3BISXVEUnZuMDFsNFZTM3M3VFEx?=
 =?iso-2022-jp?B?Vit1WlZOSTFyWnBJYUdJS0NFaUxYS3JuTHREbTJNSzZEREJwVXZOQmdU?=
 =?iso-2022-jp?B?NzBZbEU4QXlKY3FHL0M4eGJZU2NKK2UyMHJQZms3TVdZM1c0clk4NW1u?=
 =?iso-2022-jp?B?TkRHSGI0UkNMSWo3LzJ5bWNQU1pqOGNoZ2hUNlhxOHk3anVtdGx1R05H?=
 =?iso-2022-jp?B?cE9NQUwrUFMwcG5oWGc3Zk83cU5hMHAvTVQvcFo3WG45aXcxdGRGZ0dG?=
 =?iso-2022-jp?B?NksrbTh5QkpKYUFqaUVzYU5KTk9QUUNyTlBsdjR6S0hWYk5kaUNROGpw?=
 =?iso-2022-jp?B?RFl2ZDdoL2tUa0ppVjJ2aG1iZHRrdFN0Yjg5T1lFaGRBV04zSEhXUHRh?=
 =?iso-2022-jp?B?T1dqUFUveUhNeDlIMWQ4TnVDOXRWTHhjdXZYODI2S3BFY3duQlEreG8x?=
 =?iso-2022-jp?B?bVAwMVhEejRJdHlnN3U5MXNBUmZGNFFQRUtuV1FKZ2dBMDdjank1K1Q4?=
 =?iso-2022-jp?B?OWFzRGNZQWhQaTgxTnlGTk1rWG5MdXlteVR1emVzSFcxK1FlU1dUK2hh?=
 =?iso-2022-jp?B?UmFTVEM3MHFsaTRualIzSnBzelRicWZ6L05EbGswV2pGU1l0SE1IMWdx?=
 =?iso-2022-jp?B?TzcxVzUwYVFHQ1dheVVudUJJaEpOcVdWSXM4bEx3d3htMnFSTjM0ZjFo?=
 =?iso-2022-jp?B?UkMxZ2d2MjNrZ3pEVjk1ell6eHU3UUxrRnEvbVN6UXRlRVRXRFFCYmdY?=
 =?iso-2022-jp?B?OXc0OEZIZTg2L2QrWG9BektaNDhHOHNGa29zT2RFamZvOUtQZGdydHdn?=
 =?iso-2022-jp?B?MWZ3bjBWbDQ2dzUzUktXWWVtTDNrZ2loMG5sMmFFOGdLdGJwalVINWR2?=
 =?iso-2022-jp?B?MDhqbUZySWhkdmdsL2tYRkE4LzRWNWZONksrMEdoQlhSeXNqWCtTRzQx?=
 =?iso-2022-jp?B?RkwxbU1t?=
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB30823375C18D28AC2E103D189F0FAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dd095d0f-25f5-4923-7d74-08ddef87e425
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 10:01:48.3305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2B243zAw5/foHcgsira0+H2lrRGQljlKCnPPvm6ziItjQsY7lGuvy2eUcAeO5Y+AkDyxNvKrhqHz4Yb78vpI/M8d0FcH6Lhd8mF2hKnWpK9rLlE6kjpEEc8FBTvNztNR5+wJgtdyzObjbP7p1bLy+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1405
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB30823375C18D28AC2E103D189F0FAMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi @Jeremy,

Please disregard my earlier V2 patches.
Based on review feedback, I=1B$B!G=1B(Bve updated the series and am now sub=
mitting V3.=20

This series still contains three patches:

- [PATCH V3 1/3] - Cygwin: gendef: Add support for [arch] entries & handle =
overwrites
- [PATCH V3 2/3] - Cygwin: math: split math sources into 2 groups
- [PATCH V3 3/3] - Cygwin: export sqrtl as alias to sqrt on AArch64

Thanks to Evgeny Karpov [evgeny@kmaps.co] for the suggestions.

Thanks,
Thirumalai Nagalingam

In-lined patch 1/3:

winsup/cygwin/scripts/gendef | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index d60d45431..b7c9eb2dd 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -39,6 +39,11 @@ my @nosigfuncs =3D ();
 my @text =3D ();
 for (@in) {
     chomp;
+	if (/^\[(\w+)\]\s+(.*)$/) {
+		my ($arch, $rest) =3D ($1, $2);
+		next unless ($cpu eq $arch);    # skip if not this arch
+		$_ =3D $rest;                     # strip [arch] prefix
+	}
     s/\s+DATA$//o and do {
 	push @data, $_;
 	next;
@@ -68,11 +73,23 @@ for (@in) {
     push @text, $_;
 }
=20
-for (@text) {
+# Final processing is done in reverse order to handle overwrites.
+my %overwrites;
+for (reverse @text) {
     my ($alias, $func) =3D /^(\S+)\s+=3D\s+(\S+)\s*$/o;
+    # Get the alias or the function name
+    my $name =3D ($alias) ? $alias : $_;
+    if (exists $overwrites{$name}) {
+        # The alias or function is already defined and should be skipped.
+        $_ =3D "";
+        next;
+    }
+    $overwrites{$name} =3D 1;
     $_ =3D $alias . ' =3D ' . $sigfe{$func}
       if defined($func) && $sigfe{$func};
 }
+# Remove empty lines resulting from overwrites.
+@text =3D grep { $_ ne "" } @text;
=20
 open OUT, '>', $output_def or die "$0: couldn't open \"$output_def\" - $!\=
n";
 push @top, (map {$_ . " DATA\n"} @data), (map {$_ . "\n"} @text);
--=20
2.50.1.windows.1


In-lined patch 2/3:
winsup/cygwin/Makefile.am | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 90a7332a8..6d6190488 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -243,12 +243,31 @@ MATH_FILES=3D \
 	math/sinhl.c \
 	math/sinl.c \
 	math/sinl_internal.S \
-	math/sqrtl.c \
 	math/tanhl.c \
 	math/tanl.S \
 	math/tgammal.c \
 	math/truncl.c
=20
+#
+# The below MATH_FILES are excluded on AArch64 platform, as long double =
=3D=3D double
+# So aliasing via cygwin.din them instead of duplicating it in cygwin/math
+#
+
+LONG_DOUBLE_MATH_FILES =3D \
+	math/sqrtl.c
+
+#
+# Select the math sources depending on the target architecture.
+# On AArch64: only common files are built.
+# On other architectures: build common files + long double math files.
+#
+
+if TARGET_AARCH64
+MATH_FILES =3D $(COMMON_MATH_FILES)
+else
+MATH_FILES =3D $(COMMON_MATH_FILES) $(LONG_DOUBLE_MATH_FILES)
+endif
+
 MM_FILES =3D \
 	mm/cygheap.cc \
 	mm/heap.cc \
--=20
2.50.1.windows.1

In-lined patch 3/3:

winsup/cygwin/cygwin.din | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index cd71da274..02ec629d2 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -1454,6 +1454,8 @@ sprintf SIGFE
 sqrt NOSIGFE
 sqrtf NOSIGFE
 sqrtl NOSIGFE
+# On AArch64, long double =3D=3D double, so aliasing sqrtl =1B$B"*=1B(B sq=
rt
+[aarch64] sqrtl =3D sqrt NOSIGFE
 srand NOSIGFE
 srand48 NOSIGFE
 srandom NOSIGFE
--=20
2.50.1.windows.1


--_004_MA0P287MB30823375C18D28AC2E103D189F0FAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-gendef-Add-support-for-arch-entries-handle-ov.patch"
Content-Description:
 0001-Cygwin-gendef-Add-support-for-arch-entries-handle-ov.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-gendef-Add-support-for-arch-entries-handle-ov.patch";
	size=2117; creation-date="Tue, 09 Sep 2025 07:59:38 GMT";
	modification-date="Tue, 09 Sep 2025 10:01:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzNmJiYjIzNGEyNTFmYTJkNmJiZDE5NzY2Yzc2YTg2MmE2ZjdkMDg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogTW9uLCA4IFNlcCAyMDI1IDE4OjIy
OjU1ICswNTMwClN1YmplY3Q6IFtQQVRDSCAxLzNdIEN5Z3dpbjogZ2VuZGVmOiBBZGQgc3VwcG9y
dCBmb3IgW2FyY2hdIGVudHJpZXMgJiBoYW5kbGUKIG92ZXJ3cml0ZXMKCkV4dGVuZCB0aGUgW2Fy
Y2hdIHN1cHBvcnQgaW4gZ2VuZGVmIHRvIGhhbmRsZSBjYXNlcyB3aGVyZSBhCmNvbmRpdGlvbmFs
IGV4cG9ydCBvdmVycmlkZXMgYW4gZWFybGllciBkZWZhdWx0IGRlZmluaXRpb24uCkluc3RlYWQg
b2YgZmlsdGVyaW5nIG91dCBvbGQgZW50cmllcyBkdXJpbmcgcGFyc2luZywgZ2VuZGVmCm5vdyBw
ZXJmb3JtcyBhIGZpbmFsIHBhc3MgaW4gcmV2ZXJzZSBvcmRlci4KVGhpcyBlbnN1cmVzIGNsZWFu
IGhhbmRsaW5nIG9mIGNvbmRpdGlvbmFsIG92ZXJyaWRlcyBpbiAuZGluCmZpbGVzIHdoaWxlIGF2
b2lkaW5nIHJlcGVhdGVkIHNjYW5zLgoKU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGlu
Z2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2lu
c3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiB8IDE5ICsrKysrKysrKysrKysrKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5k
ZWYKaW5kZXggZDYwZDQ1NDMxLi5iN2M5ZWIyZGQgMTAwNzU1Ci0tLSBhL3dpbnN1cC9jeWd3aW4v
c2NyaXB0cy9nZW5kZWYKKysrIGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZgpAQCAtMzks
NiArMzksMTEgQEAgbXkgQG5vc2lnZnVuY3MgPSAoKTsKIG15IEB0ZXh0ID0gKCk7CiBmb3IgKEBp
bikgewogICAgIGNob21wOworCWlmICgvXlxbKFx3KylcXVxzKyguKikkLykgeworCQlteSAoJGFy
Y2gsICRyZXN0KSA9ICgkMSwgJDIpOworCQluZXh0IHVubGVzcyAoJGNwdSBlcSAkYXJjaCk7ICAg
ICMgc2tpcCBpZiBub3QgdGhpcyBhcmNoCisJCSRfID0gJHJlc3Q7ICAgICAgICAgICAgICAgICAg
ICAgIyBzdHJpcCBbYXJjaF0gcHJlZml4CisJfQogICAgIHMvXHMrREFUQSQvL28gYW5kIGRvIHsK
IAlwdXNoIEBkYXRhLCAkXzsKIAluZXh0OwpAQCAtNjgsMTEgKzczLDIzIEBAIGZvciAoQGluKSB7
CiAgICAgcHVzaCBAdGV4dCwgJF87CiB9CiAKLWZvciAoQHRleHQpIHsKKyMgRmluYWwgcHJvY2Vz
c2luZyBpcyBkb25lIGluIHJldmVyc2Ugb3JkZXIgdG8gaGFuZGxlIG92ZXJ3cml0ZXMuCitteSAl
b3ZlcndyaXRlczsKK2ZvciAocmV2ZXJzZSBAdGV4dCkgewogICAgIG15ICgkYWxpYXMsICRmdW5j
KSA9IC9eKFxTKylccys9XHMrKFxTKylccyokL287CisgICAgIyBHZXQgdGhlIGFsaWFzIG9yIHRo
ZSBmdW5jdGlvbiBuYW1lCisgICAgbXkgJG5hbWUgPSAoJGFsaWFzKSA/ICRhbGlhcyA6ICRfOwor
ICAgIGlmIChleGlzdHMgJG92ZXJ3cml0ZXN7JG5hbWV9KSB7CisgICAgICAgICMgVGhlIGFsaWFz
IG9yIGZ1bmN0aW9uIGlzIGFscmVhZHkgZGVmaW5lZCBhbmQgc2hvdWxkIGJlIHNraXBwZWQuCisg
ICAgICAgICRfID0gIiI7CisgICAgICAgIG5leHQ7CisgICAgfQorICAgICRvdmVyd3JpdGVzeyRu
YW1lfSA9IDE7CiAgICAgJF8gPSAkYWxpYXMgLiAnID0gJyAuICRzaWdmZXskZnVuY30KICAgICAg
IGlmIGRlZmluZWQoJGZ1bmMpICYmICRzaWdmZXskZnVuY307CiB9CisjIFJlbW92ZSBlbXB0eSBs
aW5lcyByZXN1bHRpbmcgZnJvbSBvdmVyd3JpdGVzLgorQHRleHQgPSBncmVwIHsgJF8gbmUgIiIg
fSBAdGV4dDsKIAogb3BlbiBPVVQsICc+JywgJG91dHB1dF9kZWYgb3IgZGllICIkMDogY291bGRu
J3Qgb3BlbiBcIiRvdXRwdXRfZGVmXCIgLSAkIVxuIjsKIHB1c2ggQHRvcCwgKG1hcCB7JF8gLiAi
IERBVEFcbiJ9IEBkYXRhKSwgKG1hcCB7JF8gLiAiXG4ifSBAdGV4dCk7Ci0tIAoyLjUwLjEud2lu
ZG93cy4xCgo=

--_004_MA0P287MB30823375C18D28AC2E103D189F0FAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0002-Cygwin-math-split-math-sources-into-2-groups.patch"
Content-Description: 0002-Cygwin-math-split-math-sources-into-2-groups.patch
Content-Disposition: attachment;
	filename="0002-Cygwin-math-split-math-sources-into-2-groups.patch";
	size=1922; creation-date="Tue, 09 Sep 2025 07:59:38 GMT";
	modification-date="Tue, 09 Sep 2025 10:01:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3NTFlZjkzMTFmYzQ4MTJkMzU4NjRjZTNjMTA5Y2U5YmU3OWJkYzgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogTW9uLCA4IFNlcCAyMDI1IDE4OjIy
OjQ4ICswNTMwClN1YmplY3Q6IFtQQVRDSCAyLzNdIEN5Z3dpbjogbWF0aDogc3BsaXQgbWF0aCBz
b3VyY2VzIGludG8gMiBncm91cHMKClJlZmFjdG9yIGBNYWtlZmlsZS5hbWAgdG8gc2VwYXJhdGUg
bWF0aCBzb3VyY2VzIGludG8gdHdvIGdyb3VwczoKLSBgQ09NTU9OX01BVEhfRklMRVNgOiBzb3Vy
Y2VzIGFsd2F5cyBidWlsdCBvbiBhbGwgYXJjaGl0ZWN0dXJlcy4KLSBgTE9OR19ET1VCTEVfTUFU
SF9GSUxFU2A6IHNvdXJjZXMgb25seSBuZWVkZWQgd2hlbiBgbG9uZyBkb3VibGVgCiAgaXMgZGlz
dGluY3QgZnJvbSBgZG91YmxlYC4KCmBNQVRIX0ZJTEVTYCBpcyBub3cgc2VsZWN0ZWQgYmFzZWQg
b24gdGhlIHRhcmdldCBhcmNoaXRlY3R1cmU6Ci0gT24gQUFyY2g2NDogb25seSBjb21tb24gZmls
ZXMgYXJlIGJ1aWx0LgotIE9uIG90aGVyIGFyY2hpdGVjdHVyZXM6IGJvdGggY29tbW9uIGFuZCBs
b25nIGRvdWJsZSBmaWxlcyBhcmUgYnVpbHQuCgpUaGlzIGF2b2lkcyBkdXBsaWNhdGluZyBuZWFy
bHkgaWRlbnRpY2FsIGZpbGUgbGlzdHMgYW5kIHByZXBhcmVzIGZvcgpleGNsdWRpbmcgcmVkdW5k
YW50IGxvbmcgZG91YmxlIGltcGxlbWVudGF0aW9ucyBvbiBBQXJjaDY0LgoKU2lnbmVkLW9mZi1i
eTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jl
d2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5hbSB8IDIxICsrKysrKysr
KysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL01ha2VmaWxlLmFtIGIvd2luc3VwL2N5
Z3dpbi9NYWtlZmlsZS5hbQppbmRleCA5MGE3MzMyYTguLjZkNjE5MDQ4OCAxMDA2NDQKLS0tIGEv
d2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5hbQorKysgYi93aW5zdXAvY3lnd2luL01ha2VmaWxlLmFt
CkBAIC0yNDMsMTIgKzI0MywzMSBAQCBNQVRIX0ZJTEVTPSBcCiAJbWF0aC9zaW5obC5jIFwKIAlt
YXRoL3NpbmwuYyBcCiAJbWF0aC9zaW5sX2ludGVybmFsLlMgXAotCW1hdGgvc3FydGwuYyBcCiAJ
bWF0aC90YW5obC5jIFwKIAltYXRoL3RhbmwuUyBcCiAJbWF0aC90Z2FtbWFsLmMgXAogCW1hdGgv
dHJ1bmNsLmMKIAorIworIyBUaGUgYmVsb3cgTUFUSF9GSUxFUyBhcmUgZXhjbHVkZWQgb24gQUFy
Y2g2NCBwbGF0Zm9ybSwgYXMgbG9uZyBkb3VibGUgPT0gZG91YmxlCisjIFNvIGFsaWFzaW5nIHZp
YSBjeWd3aW4uZGluIHRoZW0gaW5zdGVhZCBvZiBkdXBsaWNhdGluZyBpdCBpbiBjeWd3aW4vbWF0
aAorIworCitMT05HX0RPVUJMRV9NQVRIX0ZJTEVTID0gXAorCW1hdGgvc3FydGwuYworCisjCisj
IFNlbGVjdCB0aGUgbWF0aCBzb3VyY2VzIGRlcGVuZGluZyBvbiB0aGUgdGFyZ2V0IGFyY2hpdGVj
dHVyZS4KKyMgT24gQUFyY2g2NDogb25seSBjb21tb24gZmlsZXMgYXJlIGJ1aWx0LgorIyBPbiBv
dGhlciBhcmNoaXRlY3R1cmVzOiBidWlsZCBjb21tb24gZmlsZXMgKyBsb25nIGRvdWJsZSBtYXRo
IGZpbGVzLgorIworCitpZiBUQVJHRVRfQUFSQ0g2NAorTUFUSF9GSUxFUyA9ICQoQ09NTU9OX01B
VEhfRklMRVMpCitlbHNlCitNQVRIX0ZJTEVTID0gJChDT01NT05fTUFUSF9GSUxFUykgJChMT05H
X0RPVUJMRV9NQVRIX0ZJTEVTKQorZW5kaWYKKwogTU1fRklMRVMgPSBcCiAJbW0vY3lnaGVhcC5j
YyBcCiAJbW0vaGVhcC5jYyBcCi0tIAoyLjUwLjEud2luZG93cy4xCgo=

--_004_MA0P287MB30823375C18D28AC2E103D189F0FAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0003-Cygwin-export-sqrtl-as-alias-to-sqrt-on-AArch64.patch"
Content-Description:
 0003-Cygwin-export-sqrtl-as-alias-to-sqrt-on-AArch64.patch
Content-Disposition: attachment;
	filename="0003-Cygwin-export-sqrtl-as-alias-to-sqrt-on-AArch64.patch";
	size=936; creation-date="Tue, 09 Sep 2025 07:59:38 GMT";
	modification-date="Tue, 09 Sep 2025 10:01:48 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMzgzOTcyNmVjOTc3MmVkZWMzODUxYjEwZTkzNWU4ZWI5YmY3MzAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogVHVlLCA5IFNlcCAyMDI1IDEzOjI4
OjMzICswNTMwClN1YmplY3Q6IFtQQVRDSCAzLzNdIEN5Z3dpbjogZXhwb3J0IHNxcnRsIGFzIGFs
aWFzIHRvIHNxcnQgb24gQUFyY2g2NAoKT24gQUFyY2g2NCwgYGxvbmcgZG91YmxlYCBpcyB0aGUg
c2FtZSBhcyBgZG91YmxlYCwgc28gYHNxcnRsYApkb2VzIG5vdCByZXF1aXJlIGEgc2VwYXJhdGUg
aW1wbGVtZW50YXRpb24gaW4gY3lnd2luL21hdGguCgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1hbGFp
IE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4K
LS0tCiB3aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4gfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9jeWd3aW4uZGluIGIvd2lu
c3VwL2N5Z3dpbi9jeWd3aW4uZGluCmluZGV4IGNkNzFkYTI3NC4uMDJlYzYyOWQyIDEwMDY0NAot
LS0gYS93aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4KKysrIGIvd2luc3VwL2N5Z3dpbi9jeWd3aW4u
ZGluCkBAIC0xNDU0LDYgKzE0NTQsOCBAQCBzcHJpbnRmIFNJR0ZFCiBzcXJ0IE5PU0lHRkUKIHNx
cnRmIE5PU0lHRkUKIHNxcnRsIE5PU0lHRkUKKyMgT24gQUFyY2g2NCwgbG9uZyBkb3VibGUgPT0g
ZG91YmxlLCBzbyBhbGlhc2luZyBzcXJ0bCDihpIgc3FydAorW2FhcmNoNjRdIHNxcnRsID0gc3Fy
dCBOT1NJR0ZFCiBzcmFuZCBOT1NJR0ZFCiBzcmFuZDQ4IE5PU0lHRkUKIHNyYW5kb20gTk9TSUdG
RQotLSAKMi41MC4xLndpbmRvd3MuMQoK

--_004_MA0P287MB30823375C18D28AC2E103D189F0FAMA0P287MB3082INDP_--

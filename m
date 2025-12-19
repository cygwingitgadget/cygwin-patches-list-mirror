Return-Path: <SRS0=H4g6=6Z=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021095.outbound.protection.outlook.com [40.107.57.95])
	by sourceware.org (Postfix) with ESMTPS id 25E234BA2E06;
	Fri, 19 Dec 2025 10:04:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 25E234BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 25E234BA2E06
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=40.107.57.95
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1766138677; cv=pass;
	b=ZdG8U11Cl9gOI3XGgQgVBI3r5bMbTc3E5uRBrVfCN0uD8fb5n1vb7TpvEfO/TCBwzJRY6WiX5Pgtl05DMiL0hVdD7kOIt0vzQvTd+L+KjDz9wF6kMcZsDWZvQB5FiIfw7u8sSHlHSlUqAkz4r7F/Uur2XX63XnMVP0SfrygtesU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766138677; c=relaxed/simple;
	bh=ln8c43FOLtQcd5fnlA8AWmTNsxqvpldVvcc4UDqtMOQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=GW+0ZIECmTvra09hdhIhIxos/Ct4/ExLd57xK597Hg081Io5lgSkijW/OTRzettUwcijIfcJ4NxlcLX17w1TMsDrCT9gc+/3QjDGi1vkFwZgSI7gEIkVmr6nY2CVH7/dHApZZGbecxMlDVf26D8e7FSjLSOhUf+B3wEBN6dgZCY=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 25E234BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=pNsxBOP7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmwOnAq0gWeHD8U0ZCSaIhzImgUEicnV/0PqLtHRDzcgMjBsnbCXEbJS45iYQJQIk2fUH+oItngRoiQfja6H5f8HoCZkDTOjacE0ZMZvKw2qhhgDxN5eu6jw8fknCdVLl8x5/X20S3QlIfINmIVZuLnqyl/krEpi0oN5pC0tWN6CKrtueC4zPPS7lnde7MBkXHlE271LUuDfU7yCVJhKYunBkleh88eyk1JtrkYdVP0qiVWh53SIcdB4h4DWZd4DT7W98DCh+Rqnvsj5KZ/62Y4bNfpC2VB9Qx24YPyONSSJVptJdi5NrktqreLT23CCcgRnYqGUlXW6oVVf8kjEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln8c43FOLtQcd5fnlA8AWmTNsxqvpldVvcc4UDqtMOQ=;
 b=jl1kucFjnYfaHaVl+KOizkTeD59gb/j3fpZyluxXGo8md4mpXUTbYNKPnn5jYur9C/7KBL69MDchr+/9ySnznBneX9wWpNDdAnm1+R7GIa1R1v2Oe6O1gY9/e7OKYRdZPsGwiT1OvMN4ZS2UZgMY1uZUnx8LN0u4uEg0QXf0CTDxU6jiOo9WcWShB03xJGbujupFXi8Aluu7agy6piGz+7AFf7YecswVGRYp9c880RsbvpBtkd6GtmtUuzo1VsEtBORs80WduW+BMjXIMigNo95vRHhi8MAD8DP0TueZMD4kAQoqtRG57vZN8t9F5M//2GK1B05fzPkJUMYIuZ/+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln8c43FOLtQcd5fnlA8AWmTNsxqvpldVvcc4UDqtMOQ=;
 b=pNsxBOP7cz7Yn+Vc0hSU0UWfkiM0PYDJIE+aGFN3ER1J3+Jt0uX67/UXecJ2VGVrbagaONokKxRq5oZEQhiSL8Mjt6ZFit1rbUgJVj01lEllJD+eYlBlVI+U1VbPVOQ+VZVu5aBQQw/dXDmPBvp5fq5qRfh7VhCzvo5chOB0B3Ok6pM1cM1+k2Vqzx3DUIDJM3xpn7GYdUDFW04L2wUcTDUwP9uWzlDNUoQ5MAq69B/YrsnkAcAHNerN++aUMhoWQWEU1R1ySY1mo6WyWj0WWoTkvGK4d19YNo8A0jYRRvXsvWU3Er59Ln+nWoLQ8OnFgn2x4Oho3dvr4xIT2ADPTw==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MAUP287MB5128.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 10:04:33 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 10:04:33 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "corinna-cygwin@cygwin.com" <corinna-cygwin@cygwin.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [WIP::PATCHES] [RFC] Preliminary ARM64 compilation support for
 Cygwin
Thread-Topic: [WIP::PATCHES] [RFC] Preliminary ARM64 compilation support for
 Cygwin
Thread-Index: AdxoKhFxMNzP67ZvSzuqLMsZVRNe9AB0YcGAAbSXvdA=
Date: Fri, 19 Dec 2025 10:04:33 +0000
Message-ID:
 <MA0P287MB30824A7CD2D09D49825C01809FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082C051C4E43AB64AD4B9959FA2A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aTmvvwfClr2suB2R@calimero.vinschen.de>
In-Reply-To: <aTmvvwfClr2suB2R@calimero.vinschen.de>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MAUP287MB5128:EE_
x-ms-office365-filtering-correlation-id: 467e345e-bd9f-46d5-d048-08de3ee60242
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEZIT0NKRHZIOGZJYWhTdjg5YTZWcTJNN2pYbitYZUlLVWQxRCtmcjl5Q2hG?=
 =?utf-8?B?QmRrWGRLdUVlRS9FcHdReDdpZUZjeldVNG82VTc5cTNRMTRpTUNRK0NRWE80?=
 =?utf-8?B?dG5WNVhNRHVJdXE1YnJhalFpVkZHenFTaXJlT0QrRFdCcVJ5OFF4YlpsVjdh?=
 =?utf-8?B?Z1ZrYzd3NHhaR09HZ1hNT0xiblN2Y21YbmRBQ2NDZEVhbkQrbjVkNlFJTlls?=
 =?utf-8?B?RW95WWJUM3BQbEtnRURHZXp0TGU5eStkNUhicVdrMThMcU4rOHowYU1QdU1K?=
 =?utf-8?B?aTQ0eFBIZUFtV2RYcWlzZ2ZBTDlKdW1jeTRIc1g3NWlyRkZMRWJqdWVlZHhH?=
 =?utf-8?B?dEQ2V2dpMGZIQlcxQjFqN0Q1dGY2MlpNT1JNTHpmRjlXcmFNQTYyUGdnc2gw?=
 =?utf-8?B?N0QxUjNYYzBmUWlSME5icHQ0WHd2ZkRJM2JuekRjL2FaNW40ZVMrQWRCaDUy?=
 =?utf-8?B?UTVtTXh0a1N2N0N6dHExc210Wnl0QjdHSzFyeDZraHVVR1k0VGRTbHM0bGY0?=
 =?utf-8?B?N0JuQ2ZLRVVNZGlVbmR5QWdleWVoSFVoYVVqN2tYSDloRTNKaFFDR2p6Nm1Z?=
 =?utf-8?B?QVV0VVE3M28xN0VXYWpmQmhMSytLRm5EMDE5aVhuS2FGZHc0UEV0cVZ2MWxz?=
 =?utf-8?B?TDlxc3hXQzJKdkZsaGRMZjlVcUlCNjAwaFA1RkJwamFudEcvY2lqZ2hsd3U3?=
 =?utf-8?B?VHJ3Zi83YVRZTjc4Q1BtaVNvZVNBM1lnZ1dkUlFha2h4YUpuT3RrWFZITHkr?=
 =?utf-8?B?bTYzbU1yZFcwM2cvcE9oZTk5eDMyWm55ZUZtSEVhTlZ5VnI0Ri9aL1hrelhn?=
 =?utf-8?B?RDVPOFNNYkRtc29KRkkxclBzN25wZ1ZSd1IrcHZQcE03T0hXWG9md25vcG4z?=
 =?utf-8?B?UmFLbVBwd0FsaEtob3hwY1FCOGVqbDBxeGJTdC9UUEVjZFRwZmZGZ0dkUDVG?=
 =?utf-8?B?bWxlM0pvYVEyd0YxYTVVeUVTMkEyWDNXMk5hbThneFh3cE5JZExScHhiWUlh?=
 =?utf-8?B?b2VXWTROZTFRM0pkMHFqL25XK2lya2NzY0JUVDdrWlNlL3FtNTBGWWZaaTEv?=
 =?utf-8?B?TlBYeTM4blRzWXRzemhKMGFHR2JrMFMwUWdscFJBU1JNWmxvUGRna3lMUHV0?=
 =?utf-8?B?b1RqSGlaM2JWUDdhdTRHQjdmOFNwcGF1eUF3eXlpb25pMUh2emlEUUpEV0l4?=
 =?utf-8?B?Y0gyQ21NY1FxK1lmbmJQVnBCNmQ2NHhLcFZTeWxWRjVBY050bTFhMkZXVGxn?=
 =?utf-8?B?WC9IUy9FTC9HV21PZzRydFowcC9GdWViYWY5b0JYV2Q3ZXpWTWtUdUo1SDdy?=
 =?utf-8?B?aTBHcjdMeCt0aDhKZXl0QnJlQXU2Z3ZHYkE0UE8xb3VkMkorZEpjR2xYREZP?=
 =?utf-8?B?NlJpZXBVMXhWMUI0SWlVZFUwVEUyQXg3eFpvcCt6NnRjZy9IZ2YvMHBEOHRj?=
 =?utf-8?B?TDhrVHIwd1lDUG4vM2RJMmNva1RrWDJ5V0dNbkF2M2ZqeWR4MkdScGxuZllJ?=
 =?utf-8?B?M1RZblRQcVhrMnZOTC9lUVRrSi9oWlZkNHZEK2VYS2ZIUzUxWDNEVGZOQWJy?=
 =?utf-8?B?b0RjZGZZMDFlUHd0dW44NklZZjBuaWhrakZ6UjNiR1U3TVZnZG9oeElsMDdl?=
 =?utf-8?B?NSs3aUpGNU9UMC8wQXo2N3lMb2pYUzBOa1k3TzdwK2RjMmMxN21oTG9QdFZO?=
 =?utf-8?B?anU4a1lhdGsrbmJMU3pxRG9Kb09hK1ZpWkVaakpRMXg2Tnk1Z3BrK1JnTTAr?=
 =?utf-8?B?eC9qOHhTNnhnZVZIelBDSDhCemNuQndvZ3UyL2JHam9qSlVJaU1QTDdqYllr?=
 =?utf-8?B?V3l0M1lsQWNTQmRDS2N6bWpBVlROQVZGTjdrbFpOS3NPVXhDZitaTks2WFJl?=
 =?utf-8?B?YlBBNWI0cTdHMDhXQ3pVb3JWK09DeHJhdG9nL2lGZGk1c2s2Q1B5UE1MdTlX?=
 =?utf-8?B?U0Z1OUgrcVcrUkxPRVF4QzBjOG1zbTFUS1lLdlE3dGVlbDJvU2NNV3lyT3l0?=
 =?utf-8?B?R3YzSEFtZmZhMHJQNXBzMmlEQk00OEtiNDBJaXZabWk2c2did3I5ZlFHWW9N?=
 =?utf-8?Q?IkhRbR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVZsRmIzQkJvdXh5WUQxanAxbEE3bnltQ0k4WTJUQlBTWWhkczlUcS9VWXZC?=
 =?utf-8?B?VmNGbXY2UC9ZYnQveGdlTmlWVi9GOHhsTlFEemZKTUQwY3JCbnNpb0JXbEpi?=
 =?utf-8?B?dWdJd3grNzd6TkU0TlJJWjVvMDFsbzZDMWpUTTZzbUtUREtMUzArTnhESDBh?=
 =?utf-8?B?ekZtRmI4M3N1eHUvdHEwT1FZZjFRdmJsNVBKYTBZTzE2eXRrV3gzMmNDNk1L?=
 =?utf-8?B?dGhQOEcvYklMVHpRUG5vWUpHQTU0QjJPWnU1aTI2R3NuNmxyakFNMHZQSG1n?=
 =?utf-8?B?aXBFYTl0R3dDaDQwYVU0YW1wclFiS0lOc3ZBV3lYalpyYmpTQkt3RElBOUxN?=
 =?utf-8?B?cVhyNjBXamF0YmZBNW5xQlFDT0o3NXovUGt0V2pyVVlacFNneFdZSGNMeC9w?=
 =?utf-8?B?ZE4rdHVxTGwvYXFwRHd1cHhPM2EyRHdjbW05RGc5SmhVMFZzbnNrTEhmY3pk?=
 =?utf-8?B?MkNZQ1lnMU83aHA5UjFaSFE3UGxmR0NTeUFMNy9NVGhHOWc4UEg1RkJkaVgw?=
 =?utf-8?B?ZUdRRnIrcGJMM2tMNHZHanN6OVFTbk1iUHRRbjJTbnh3RzcxcHFpMTJLbk1N?=
 =?utf-8?B?Z1NYKzVKNE8wVHJzczZPSjlVTUxHNUtTVU51ZUh5R3NuZXpNZnRLNGtBZWg4?=
 =?utf-8?B?VW92T3YzUXlhVjNxQ2cwbEg5OWFjMThjTDhuVksvaEtzM092ckpwUWp0T1pw?=
 =?utf-8?B?L2VYMjNpalNVYjBaSHhxeXpZaE5QNVpMUXhMdDhYeDdKS3kzc3FqeWc1TGJp?=
 =?utf-8?B?ZXg0a01XSElLcFVZb3k5Z2Q2ZzAvVjk2Ymo1YzRuSGUySit1bWlJMXE0bWhE?=
 =?utf-8?B?TW5XMktCMHZ0cVRUaE5UdXEvUEorb2JkeXVQNjlBQzgxbHBIaW9MK0crR1Zx?=
 =?utf-8?B?YVgrd1dCc2JTY21JUzBwRkpQcndVS05kWHhvazU0L3IyQ1ZOaktUdklxNGE4?=
 =?utf-8?B?WWtSV0dvVG5TNjBYOWRLdlV2V093T1dKWTlYamtsWmlVWlZpUHE2blI2Y1U0?=
 =?utf-8?B?Z01aSWRTcHhSWmtmeVVFV0UrNW1JVElYVjdJZUt2T2NWenJTYS9iVUUwT0RZ?=
 =?utf-8?B?dVNVWGpiNDFCNVNZQ0tQNTIraURTd29vVnR5RW5hQXNwZlRwZ2Q0NFkvcUtZ?=
 =?utf-8?B?dUJtZnlwa05oNW1Ca1BCWkMyS09aL21vNk5TN2o3M3VONnJWUFozbzBnUVdH?=
 =?utf-8?B?NE1ST2gvLzMrUVRwWXdtaGplQi8vUlNRVnNCck9RNXBKWXcxNXViOUhCOTB5?=
 =?utf-8?B?UE9rLzRBaW94MGVzUzB3Y0YzNXhwOEZiNEJtSHh4YnFPYXFGOG44SFJMbmUv?=
 =?utf-8?B?cGk3SVJHcjczQ21CSXJ2T2pUcis1SmxacXVYMnBtQWhSTjNQT00zb3lZRi9v?=
 =?utf-8?B?NytDRGl5amhnbU9CSFp3dkE0bzZRSXRaMkFkSHpvTVppdUQ5Z1E1ZUt5TG9i?=
 =?utf-8?B?WlNvNitJYnFpVzR2U0JGTWIyNER2bldDNDFqZ0wycFZKeG41dy9zSXR3VWR4?=
 =?utf-8?B?aDhkc3BBMHhNYkRZMEdkbENOWUZiZ3NUZ0tPYkJORGRQVEdDTGtsdjV3R0JY?=
 =?utf-8?B?eVdWKzdrb3l2YnU5ZGFqSStLZ3pCN0N5Z3dRVDNEV0JNZzErWUZIclExRGZa?=
 =?utf-8?B?TlIwcDUwOFMxRnNmOVVRWTJENHdIVEhHbU5IT3hNanN5QTB6b0N5NnBubUpO?=
 =?utf-8?B?RjZLMFpFMjlwb2FoelM5ejAxOU5MV3NyQk5raTRLQXpxTnFiZEg3TWNPZWZG?=
 =?utf-8?B?Q2pXZnc1TkxJaWtjVU1vUHJJcHlzQy8rdzFLRmowVmNOTllYbHFjbHBXZHRS?=
 =?utf-8?B?OUpSQjVLRUVMek5rQWd0UlV2dUNzNmx1RHRKaE5Gd0EyU3FGTm1KTjJ5MHFt?=
 =?utf-8?B?MVlyU0VVYWd4WFV0RzR3YXV2bThoMzV3UEpKQ1cxUGtiT01ySm1IMzFTbEkz?=
 =?utf-8?B?NjRKMjIzSG5WN1pyRjhnMkw0TC9UeFVmUHRvR3M0OXV0TXQ3Z01TcHBEY1FR?=
 =?utf-8?B?Wk9YNWxqaGxFV0RZYUhXNGY3NTJNc1kxUzRTNzRtRTFiSG1tVUUvRk5KSzRa?=
 =?utf-8?B?N3pwZXdoSmNHUVRtV3Nad2RleCt1cE1sdG5jeFNyeU1JL3NwUU5oQVlZVzYz?=
 =?utf-8?B?K3h6c3F0Snh2WDArUS9ibjVYZEY0eW5hY2NUQU04WGU5VG9pNjlPcTFOWTJJ?=
 =?utf-8?B?VkZLTFRKOWJ4YUJaTXdtTW1FbE0xRi92THIvQ2t6VjNsZFVNakIwVE5GWkxo?=
 =?utf-8?Q?ylXcIpeWG8IXt5N/j5zKTEP/ssFj0e+44lncSeb4qM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 467e345e-bd9f-46d5-d048-08de3ee60242
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 10:04:33.4306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/QIx8O8B7kDxENNMoWdkIP/44NJuF1ybI+iqTZ0fx2sS1jCPKva5ZCkWRk3Sa4HFmJVeJ/LLXwTOq7V4mu4DK6Uuk2BZ9qrcGNlq+Pa2/VV9s/Pwx0d1Sbxud1vVEagCNXlOgxOCPtozERWPKrk+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUP287MB5128
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

DQo+IEp1c3Qgb25lIG5pdCBmb3Igbm93LiAgVGhlIGZpcnN0IHBhdGNoIGNvbnRhaW5zIG5ld2xp
Yi9NYWtlZmlsZS5pbiBidXQgbm90IG5ld2xpYi9NYWtlZmlsZS5hbS4gIA0KPiBQbGVhc2UgbWFr
ZSBzdXJlIHRvIGNoYW5nZSBNYWtlZmlsZS5hbSBpbnN0ZWFkLg0KDQpIaSBDb3Jpbm5hLA0KIA0K
VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KIA0KVGhlIGNoYW5nZXMgaW4gTWFrZWZpbGUuaW4g
aXMgZGlyZWN0bHkgZHVlIHRvIHRoZSBDeWd3aW4gYnVpbGQgd29ya2Zsb3dbMV0gKGN5Z3dpbi55
bWwpLCB3aGljaCBkb2VzIG5vdCBydW4gYSBjb25maWd1cmUgc3RlcCBmb3INCnRoZSBuZXdsaWIg
c3VidHJlZSwgdW5saWtlIHdoYXQgaXMgZG9uZSBmb3IgdGhlIHdpbnN1cCBkaXJlY3RvcnkuIA0K
QXMgYSByZXN1bHQsIHRoZSBjaGFuZ2VzIG1hZGUgaW4gTWFrZWZpbGUuaW5jIChhcyBpbiB0aGlz
IGNhc2UpIHdvdWxkIG5vdCBwcm9wYWdhdGUgaW50byB0aGUgYnVpbGQuDQogDQpUaGUgZnVuY3Rp
b25hbCBjaGFuZ2VzIHRoZW1zZWx2ZXMgYXJlIGNvbmZpbmVkIHRvIG5ld2xpYi9saWJtL01ha2Vm
aWxlLmluYywgd2hpY2ggaXMgaW5jbHVkZWQgYnkgbmV3bGliL01ha2VmaWxlLmFtLA0KYW5kIHRo
ZXJlZm9yZSwgd291bGQgbm9ybWFsbHkgYmUgcmVmbGVjdGVkIGluIHRoZSBnZW5lcmF0ZWQgbmV3
bGliL01ha2VmaWxlLmluLg0KSG93ZXZlciwgc2luY2UgdGhlIG5ld2xpYiBzdWJ0cmVlIGlzIG5v
dCByZWNvbmZpZ3VyZWQgaW4gd29ya2Zsb3csIHRoZSBjb3JyZXNwb25kaW5nIHVwZGF0ZXMNCndl
cmUgYXBwbGllZCBkaXJlY3RseSB0byBNYWtlZmlsZS5pbiB3aGljaCB3ZXJlIHJlZ2VuZXJhdGVk
IHVzaW5nIGF1dG9tYWtlIGluIGxvY2FsIHNldHVwLg0KIA0KWzFdLSBodHRwczovL2dpdGh1Yi5j
b20vY3lnd2luL2N5Z3dpbi9ibG9iLzlmYWM5OTNiYTc0YmQ2YWIzZmM2MzhhMTY5ZmZkYzkyYjc4
YmQ2NzkvLmdpdGh1Yi93b3JrZmxvd3MvY3lnd2luLnltbCNMMTUwDQoNClRoYW5rcyAmIHJlZ2Fy
ZHMgDQpUaGlydW1hbGFpIE5hZ2FsaW5nYW0NCjxUaGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGlj
b3Jld2FyZWluYy5jb20+DQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0K
DQoNCg0KDQoNCg0KDQrimqDvuI8gRXh0ZXJuYWwgRW1haWwgV2FybmluZzogVGhpcyBtZXNzYWdl
IG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIHRoZSBvcmdhbml6YXRpb24gKE1jVykuDQpCZSBjYXV0
aW91cyAtIE5ldmVyIHNoYXJlIHBhc3N3b3JkcyBvciBjbGljayB1bmV4cGVjdGVkIGxpbmtzL2F0
dGFjaG1lbnRzLg0KDQo=

Return-Path: <SRS0=WkkJ=AO=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id 464EA4BB3B8B;
	Tue, 10 Feb 2026 09:01:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 464EA4BB3B8B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 464EA4BB3B8B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1770714088; cv=pass;
	b=krGt7xSntcso6134Bj3iFxTCYan79qPCqqVGSdWLYPfnCWGm20Nhdd6bXHS+hTXsLiPRne39eFYGikUojWSE1sEO+PVl0WpMcHNwxaewA3CaNLIjlFRpZRHCbcia9BPXadkrp6h2v1aYnq+0CZ3Q0fGx8YWtDdcZodL5TmyGPC4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770714088; c=relaxed/simple;
	bh=kd9nTvfZQH5GxEA7nd1oxBbAQadoOfSe+vOfg5ook+4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ekCwShMj5aTk2YGjoFSDWAZ9bwbCvhjLW3440K3lt9EQ1CmBVzcfWKeywA1lyjtD8hsrhQyUKF60kRWUCB5F5JjGGEYKqqNJIn3g1arkb6T07zCSUxZIUR3uMVG6+iaSZXpUzRHeF2DcLfpYXa9pMLuXKxTjyMYTlo1zWvm5It8=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 464EA4BB3B8B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=MNHU+AnL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErEQ8V6FAH//HUxD5Ao3HR75naURRvgX9P2u56iVNSfyK4ex/LeddsibKYzDaFzFz1eXz+oGuU+tdb6RgvK8GaktaHnIbT8z8Oqa/nVMAQjptR0KJr/IKUgPm/ThtKxi9iTWxA1tSXN9olcMMWut2a7xEsUiwI6cmrwdZX2A0E4ow+xUC2aCjH/0DGPiy6bxdt8doL4BvWaNeZeIUsLCy2E7sINI3jhN+Mw00FZ5YXVXpyzX7FIK3ErnZ9S7wcW4OwwuDKtVZY9p3L2ioDsGDP6nYBY7m5Ytx/V0xr/nAOB/Hd3xWPHYNoOf5HH82nmyfsc4rWkLU67GAXfavFkn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5JIfpqJAjx6cRM9i7Vj9NUsNjtxHUkbqXwjSI8bg4U=;
 b=lnFqlPgLK5JnEO08gg3OjSSKwMWG8ZMEzRjO1xGcvXesTz2WMnUCU+Jnum0IGqoCiimlbxWwbkLyrjG9+7ueZX07lz6C3HM8NrqJMoiCv/9gZZAwnSQQQ1ptAtPFJ2uNRprg6iOR4odPfjlsKI1+uR6vWLRVifs0b4C9R3mZkJ85uN6e/crHYKLo6Xhi4bjn3wxNXJjnbou8M6JANpb3WHs7PIVFojWGMuzsvd7Zj2gHZ+H/Fwi1rpPZhmc0PlT/BBe/LY7d564aQAL9awk88YBDWJNr5nzpXugdLpBZpyGNYMz3rotV6AlLHJAMjZSSBEXLC6Itv524e0mwrUiK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5JIfpqJAjx6cRM9i7Vj9NUsNjtxHUkbqXwjSI8bg4U=;
 b=MNHU+AnLWCTjHfN/DKUOwTdy4Sqf9F2ZNzfBkM3UVqA0UlrTq9Daiiepf/93VY1VI7dlQXn6xaskfhUwMjpy2xwvjKI0AQDM2g1MTvAoMb165uan0tL6Hs4QSlqFLeHMa6zAjjkzXldRdFId3ns9SNYk8v2CTsauth9YKhIeRhJcKDEvJdC5BEVHioJQa2QBXOhpR0uQ0MTpS8HhAbIVUI1sqJO9bw65pbmz61Dbr65VFX8P4dJDP81/RK3BGxDAd/omTnUcv7tLojLQKmZuV6TOtCnIVbgvlbB/TP5Zhly8TS9z4fwEj2Cv7w5UsNzlRsH2rkw6/22wEfiYyKC+UQ==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN6P287MB4961.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 09:01:24 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 09:01:24 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Corinna Vinschen <corinna-cygwin@cygwin.com>
Subject: RE: [PATCH 2/2 V2] Cygwin: gendef: export _alloca only on x86_64
Thread-Topic: [PATCH 2/2 V2] Cygwin: gendef: export _alloca only on x86_64
Thread-Index: AQHcmmvVWRxR/ddJJka6uN4TWBNuxg==
Date: Tue, 10 Feb 2026 09:01:24 +0000
Message-ID:
 <MA0P287MB3082A6AAABBF6611C1B989349F62A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082B2BA4E9D476168C4DB919F65A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aYpCJ6Tybk0mGTLa@calimero.vinschen.de>
In-Reply-To: <aYpCJ6Tybk0mGTLa@calimero.vinschen.de>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN6P287MB4961:EE_
x-ms-office365-filtering-correlation-id: 40758761-dd5f-4cc1-c2d4-08de6882f794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|366016|1800799024|376014|10070799003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGZTaFZGb2ZBMkpsMzBqUW5Ud1ZFZlFJQWdkWEN5ZW03OTFzQktWSVNKZTFx?=
 =?utf-8?B?dnRWSTFYdnpzWTZ3VElFWWNrbVRKU2tOVVdqQnI5TmJSd1JBcUNqa0pzaWNN?=
 =?utf-8?B?eHd4clRSeHh3YkcraDVXV056bkc5M2VVb0ZHY2E0QzBXOUhnODliZk50WERY?=
 =?utf-8?B?Vmp0YXEzSTdCMWdMUGIxSm5lSGorazBNLzFsOUE5VXhJYml6dEJILzY1RUp0?=
 =?utf-8?B?VDhTWThRU2NYNXl1aFprVDNLTyt2Y2tRbEU2YnJITnhZYUZXZ3kyVWNOeDdW?=
 =?utf-8?B?TE1STmRyaVpweXhUOHF4ZWF4YTIycGk2K1V1ckpBQmEvMGpjSGNsc1VXT243?=
 =?utf-8?B?VVhQcVVVRmtTV0JneDJ1bGIxZWZMU2FHMElXeFhsZHZWeis4RUNuMStLTW8r?=
 =?utf-8?B?dXBiMnh5b05GNjR3NFBCWlc3WDZ5VVR6a1BmZjJhbXBEWDk2TTIvclR2aWhY?=
 =?utf-8?B?VU9yeDNMVmZsQU93WklkSmtkQXpIc2pOOHVtcm9RekVHZDFpMFNWcjFERVN2?=
 =?utf-8?B?V3RIS1o4QmJjUHhEbU9QdkRLZk9PVGFNaGFnQlc4UjJZTU9yT2h2b09iSHYw?=
 =?utf-8?B?MVg0REhuaHFIOVA5SlRDZGM5Nm1CWUNMTHNiQklQWUtFL205RW50WnpGT1dy?=
 =?utf-8?B?T3oyRTFPS2VVeU1OZk0ydHN2MEJJTVRIUEhxaTY0Wjk1R09VWVhBWFlVUnNu?=
 =?utf-8?B?bnFRSTVuK3VaSEUzWWY0V1ptaDdacXFZVWF6SkZLZXRKQktJUUtWcDhrSlg1?=
 =?utf-8?B?NTBUVUdzT1N2Sm5PY2N5RWZZSmxtcDczcld1emt1bGxnZitzbkNFc1dPNk1o?=
 =?utf-8?B?Q1llS1NnWENidmRHd29hK1I4TFJDNjJ1MDBEQU5sRDIrODJiUDkreTRHeG9m?=
 =?utf-8?B?ejNDc0pvTXBRWndJdjB5R1NaTGRKZ3oxMDdwUXFaSXN5WFhoemhDeEtaOW1D?=
 =?utf-8?B?VkU5NmFoVWREMmV0NmZxYUJtQ3pUaG8zZWdNY05uYm1Pdk9XR1NERXdwNWFE?=
 =?utf-8?B?NlpUY2lwODRic1FsQk8yU1AzcldKeG9ia1JSRm1UOWtXOWthc0pVZlFYWVpZ?=
 =?utf-8?B?andZWndCMDhZU2h1RFRvVExEdGdXM3hEcmh2ZVM0bTdoenIzTWUzMWdpUWg2?=
 =?utf-8?B?QXRHYXF5c2x1dVo3VEFqUGYwUnFkQU9TQkZ0RmkySnpMN2dYTW92djZKQUJT?=
 =?utf-8?B?US95RWJJeWVXMUNodVIvZC90MnV3Y0o5c3BaUVFRVnZIbC9BUzNxVnBlUjhi?=
 =?utf-8?B?RlhFM3M1SXB3Ni95Y2VEWExKd3l0eVJHR3VaTDFxVlQ5LzVCN2tWRWlJbmI1?=
 =?utf-8?B?dXQ3QXEyb1l5SlFFN2R4VnB5WmhVVm5HcHhVck5WZXdrRVdXVC9BSitoMi9t?=
 =?utf-8?B?SnlTUUNHL0VWRzQ3U3JsVG16Q0RCS3NHMmd3aGxwQ0ZzckhVTFNiTEsxWm9V?=
 =?utf-8?B?eHk5YUY2aWFudjBheUdEbmZLMStDeXIrYjc1ZE1IcnlBdndZZTNyaXpHTjMw?=
 =?utf-8?B?dTR6Mi9Wby9XcnNTa2ROMWI1eHRTR3dtNlA3MTN0QXZHT29aS0IrSkd6bC9E?=
 =?utf-8?B?UDF4ZDhWOTdETlZocHVvRElKRDFDcEFsSnR5T2ZjcUhOMitKQVp3VmJwMkFz?=
 =?utf-8?B?NEtmc1VIazlMZFRnYi96SXQzNTdESkVhYVlsNjIrQ2pqNy8zR2hrSkhITTBK?=
 =?utf-8?B?Q2tkNVNCbm9DeFg3TFRseldlcGw0U1owMVpRMzZNaFRjK2JoQmkrc0I0SmZs?=
 =?utf-8?B?U0ZxOXhEb0x1U2pFdERRSkduRUJFckpmaVV0SjkrRVdZdTZVYTdBZ3luVS9D?=
 =?utf-8?B?bFBXL0E3ZkdYZ2dIbTdZUmlOTXlnajlHNFFHcEY0VXovREgxVjlob2YwYS85?=
 =?utf-8?B?TnpYUFhBYmJNMjY1YmpmZW5rRm9PTkRvN2pTbW5zZHA5SndjdG5MZytscjdB?=
 =?utf-8?B?ZlV5S3BEczBYZ1ZNRHU2cVB6RzhDMlM0K2x5dnJocDFUTXNIZ2FtQVlIc1JD?=
 =?utf-8?B?ZlNWM1BGcW9WMGxRVGErRWdwb0toVU5tdlYrSlhOZjVmc1o5MkZLZlI2NDRQ?=
 =?utf-8?B?M2l3VHF3dzN0UlJJM1ozZ2FpNElIWmNjWVh6TFhEWWhqQUMvUVVZYTFwOFFq?=
 =?utf-8?B?bnZrOHFncEFpV3Z4SEdGSEtodGxyOWhaWlo2bittWTYvaGZGOVU0dzM4Y2Zz?=
 =?utf-8?Q?83B/VRQ6AG8SnY3AmnRADZw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(1800799024)(376014)(10070799003)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTdBTVJIa3pQMGhOdlNzS3IraFFkNzgrc25iaUlIQysyOXdhR1RvR3hDOHB2?=
 =?utf-8?B?TStYYW9CNmxvNWVGblJkR1hFcW1NbDFYS1diY0J3WEtBTXBKaDNhcTIwVmts?=
 =?utf-8?B?ajYrRDFSYjhPMmVUQnd4S0FYaVNqUUxZQXlMQWFoUFRtWFByR0xyTWcxd01w?=
 =?utf-8?B?L0YxcjhIZTYwaktKMXdMZEJwNU5iK2xDcnAwWmYwMFN4b2ljNnJGdTY4blo2?=
 =?utf-8?B?Qmh1aVNOcEZYcWtvcG1GWTFPY3VFa1M5T2lXQk52eSt5RUQ2VFR3NFFERnBT?=
 =?utf-8?B?ZW84UFB2UkVFZWFCeW5GQU5CNWlpMFhVcUhPNlVSWVUxc2xCaWthWUdwQlBx?=
 =?utf-8?B?L2cybGxsSTJHN0NFMzhHV0RRdUFDWENDK2xkVnp0d0QzbE13VktnS2ZmRkdY?=
 =?utf-8?B?dmYzZHJEazR6cVkrY2xOK0FFQm1SdzJQcVczbGJ0OG1NQjl6cDhhYURZWXpB?=
 =?utf-8?B?VEcyOEsxSGJKcS9vVk5HNWxHVUxOczdnRy9SM0dCT0RFamFKTDU4M3o3dFBN?=
 =?utf-8?B?TDlBd3NDN2tIbXA3OWtTK3FKZzFYS2dpamRTS2Z4MS80UURDNEE1dURHSXhT?=
 =?utf-8?B?VkV0YXFRcmdmcnpvSnFDeHJZdmdtME9aNGREcnNXYjlWa1U2UEtYMjhUMzdi?=
 =?utf-8?B?dWZtUHpVMHowNlYvT2JLanpQeUVXQnNWemQvT3FEYUdFczNNb2pvV0lqOVNi?=
 =?utf-8?B?ME5VOHdaOXFjTENlOWx4MG9oK0x2OHkycjk1STd5U3dmUFRIMjE5UVc2K2Fx?=
 =?utf-8?B?Z3lqRWd6aVFnVmliMzJuS1pObVFScFFOUmZERzhsOWJOQXpUWmVJL3ZyalJu?=
 =?utf-8?B?UDJ1SWgzWHJSSkg2NmZwQjQ3a2I3TFp2Z09BRUNIYjB6bmJSWHhFc3FoVW1M?=
 =?utf-8?B?MXo0Mjg2M1pLZDk5UHZYNjNtM0doY1NySVlYUUcweDN5YkhiVTNWMmpaN3kx?=
 =?utf-8?B?MUZMakYxdTlkdFhlV0VCRi9VRkhiNUM4N0dBMUNqaUJzdW5iZGxXQlZvZzU4?=
 =?utf-8?B?eUlyV25QY05MN2lqK25YVE9QVURhWjNlbFNYRnVtOU0rS1hCNm81QUJuSG82?=
 =?utf-8?B?OE9pL2FOU3pQNkQ2NU04bjBhYXgzYVNWaVpsaXpHc1IrWlZvUytPTnphelJH?=
 =?utf-8?B?akRPQ2V5bnJqT2x2WEhSa05paG5VQmxyVEtKS0dUbW01a0F3eTNpYjlxdVZz?=
 =?utf-8?B?TXdpTFQ5azRWM3NyWXFNK3RIa3pMZktCYkRMSnBSeU52amYzNE9ZMkxvOUpE?=
 =?utf-8?B?Z2F0Ujl1SXo0YnBsVmJ6MXJtSDY4SVRFeVh0TUZJcFFQR1NxTitWcjBWUEN0?=
 =?utf-8?B?RjZBbWw0cmVBQTZUNE8xSGo4M0ZhalJmWmZscFJmbFBvKyszUVZ6YTNsQ0Iv?=
 =?utf-8?B?YnFueVdaSlFhb3RFT0NVSlBhZVBRa1JNMEtqYWtuNkZrRXpiMWZVc1NGU2kw?=
 =?utf-8?B?NThBUytSK1pmbktlZXlwYzNDTnRNTVU1WjNpc2lidG9xbnZIUFQ3bWZGblRK?=
 =?utf-8?B?MWpVcDIwNkRoZzZSZmttMm1wZVIzbW4wN0VxNVZXMndmUzRrOUx0RXBkWmp2?=
 =?utf-8?B?TWdRRkJqM1hBaFlzN3Uzd1pEWjRTbFRpMzJVVzBHME5YeXVXU2kwS1pvdkJn?=
 =?utf-8?B?cEJnY2xoTDR5Ly9yRUlMT3pvMWtlM3ZmZGhTQTE3QUtHSXR4dTZkSGZqd3JU?=
 =?utf-8?B?c0dyWE1ZUHZmNUN4b0d6TzZtNG5EdXhyS1FLNzQzZFM3cDExa3NNS1N3T1U3?=
 =?utf-8?B?Z3kvZEdCbnVERFVXNGZsRGE4MytLYTZqL3Zsc1hVUWU0QlptYnZCZFBqM2ZK?=
 =?utf-8?B?WHFudUhRd1RWaVVVODNFcFFLbUVwazVlSTBXMGJ4Vk1WblJIaWNZOXF3dHZv?=
 =?utf-8?B?dGtud3M1SzQ2VU5UWGF2UU5sQWVJZFN1RmVoMU1HaU52R1RiYitQU0RYMkQ3?=
 =?utf-8?B?QUtKQkwzeWQrUExWVllJSzAzR0V2Mk5QanlYeDNuVGdoQTU0RUVKaTVXL3ZB?=
 =?utf-8?B?VzZsOHpNL0ZkSnR2cmI3eXpIelZ4Vnphand1blZ3VW5MdTg0YWs1Si9zVWdQ?=
 =?utf-8?B?eWtlTUkvaGNaUVlSVFNtK1NsYUI0UFdiMG93aldVOWlLbXVhd0E4Q0xNL3Rn?=
 =?utf-8?B?UzBmdW42SEZvcGN4SUhUcUFSb3FlZ1drQ3B1bXQxRnd6V1NqMENJb3pTSlQz?=
 =?utf-8?B?L010RC9HVFNpSm5kQkcxazRtM1VIV05aN2IxZUhMT093SHNjZUNZejBYSGov?=
 =?utf-8?B?aU93ZVlqVVZ5YlAvb2p1NmJQcWd5bU5CVkxTTUt4QTZNbVlkdGcveHErZjZl?=
 =?utf-8?B?YmJmeldya3Q2UGcrdXdqazNramo4bzVhdjVOb0pPQnc4Y1kyVG9aNk12VGc5?=
 =?utf-8?Q?s8oB1oa+yed/jNRz9JkDLDpAQQmBcKCwTg6XP2GgT9DLa?=
x-ms-exchange-antispam-messagedata-1:
 xzsZ09BwTwzv5bRvjdN593Kd7mAO7E4HqXbRUeIhWO4FfHEsotlsaXgw
Content-Type: multipart/mixed;
	boundary="_002_MA0P287MB3082A6AAABBF6611C1B989349F62AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40758761-dd5f-4cc1-c2d4-08de6882f794
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:01:24.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFh67lgC0IJO5SEivIfJUe0FSHRu0DXnYxVcWOdyJ7VtVuY9p2YVvTFfXfhBUvmycRSERKjT2cy6FYVzd96iMsgVCxU8TBZVhr8gsGckKyb6I1WwjbS2CdEZdGzOc6u6YusebVFqptZpd1OFF0fmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN6P287MB4961
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_MA0P287MB3082A6AAABBF6611C1B989349F62AMA0P287MB3082INDP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQ29yaW5uYSwNCg0KPklzIHRoYXQgcmlnaHQ/ICBJJ20gbWlzc2luZyB0aGUgcGF0Y2ggaHVu
ayByZW1vdmluZyBfYWxsb2NhIGZyb20gdGhlIGNvbW1vbiBjeWd3aW4uZGluLi4uDQoNClRoYW5r
cyBmb3IgcG9pbnRpbmcgdGhhdCBvdXQsIEkgbWlzc2VkIHJlbW92aW5nIHRoZSBfYWxsb2NhIGVu
dHJ5IGZyb20gdGhlIGNvbW1vbg0KY3lnd2luLmRpbiBmaWxlLg0KSSBoYXZlIGF0dGFjaGVkIHRo
ZSAodjIpIHBhdGNoIHRvIHJlbW92ZSBfYWxsb2NhIGZyb20gdGhlIGNvbW1vbiBleHBvcnQNCmxp
c3QgYW5kIGFkZCBpdCB0byB0aGUgeDg2XzY0LXNwZWNpZmljIGN5Z3dpbi5kaW4gZmlsZS4NCg0K
VGhhbmtzLA0KVGhpcnVtYWxhaSBOYWdhbGluZ2FtDQoNCkluLWxpbmVkIHBhdGNoOg0KDQpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9jeWd3aW4uZGluIGIvd2luc3VwL2N5Z3dpbi9jeWd3aW4u
ZGluDQppbmRleCBjZDcxZGEyNzQuLmIyMGZmM2U4ZiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3
aW4vY3lnd2luLmRpbg0KKysrIGIvd2luc3VwL2N5Z3dpbi9jeWd3aW4uZGluDQpAQCAtMTQ3LDcg
KzE0Nyw2IEBAIF9feGRycmVjX2dldHJlYyBTSUdGRQ0KIF9feGRycmVjX3NldG5vbmJsb2NrIFNJ
R0ZFDQogX194cGdfc2lncGF1c2UgU0lHRkUNCiBfX3hwZ19zdHJlcnJvcl9yIFNJR0ZFDQotX2Fs
bG9jYSA9IF9fYWxsb2NhIE5PU0lHRkUNCiBfZGxsX2NydDAgTk9TSUdGRQ0KIF9FeGl0IFNJR0ZF
DQogX2V4aXQgU0lHRkUNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3g4Nl82NC9jeWd3aW4u
ZGluIGIvd2luc3VwL2N5Z3dpbi94ODZfNjQvY3lnd2luLmRpbg0KaW5kZXggMjI4ODk0NjIzLi5k
ZmQ1MGE0YzMgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL3g4Nl82NC9jeWd3aW4uZGluDQor
KysgYi93aW5zdXAvY3lnd2luL3g4Nl82NC9jeWd3aW4uZGluDQpAQCAtMSwyICsxLDQgQEANCiAj
IHg4Nl82NC1zcGVjaWZpYyBleHBvcnRzDQogIyBUaGVzZSBzeW1ib2xzIGFyZSBvbmx5IGF2YWls
YWJsZSBvbiB4ODYveDY0IGFyY2hpdGVjdHVyZXMNCisNCitfYWxsb2NhID0gX19hbGxvY2EgTk9T
SUdGRQ0KLS0NCg==

--_002_MA0P287MB3082A6AAABBF6611C1B989349F62AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0002-Cygwin-gendef-export-_alloca-only-on-x86_64.patch"
Content-Description: 0002-Cygwin-gendef-export-_alloca-only-on-x86_64.patch
Content-Disposition: attachment;
	filename="0002-Cygwin-gendef-export-_alloca-only-on-x86_64.patch"; size=1275;
	creation-date="Tue, 10 Feb 2026 08:53:15 GMT";
	modification-date="Tue, 10 Feb 2026 09:01:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzY2RmYmU1Mzk2ZWQyOTVkNmIzZTJhYThjNzgzZDEwZjE0NGE1OTE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogVHVlLCAxMCBGZWIgMjAyNiAxNDoy
Mjo0NSArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBDeWd3aW46IGdlbmRlZjogZXhwb3J0IF9h
bGxvY2Egb25seSBvbiB4ODZfNjQKClRoZSBfYWxsb2NhIHN5bWJvbCBpcyBleHBvcnRlZCBvbmx5
IG9uIHg4Nl82NCBhbmQgaXMgaW50ZW50aW9uYWxseQpvbWl0dGVkIG9uIEFBcmNoNjQgdG8gcHJl
dmVudCBsaW5rLXRpbWUgZXJyb3JzLgoKU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGlu
Z2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2lu
c3VwL2N5Z3dpbi9jeWd3aW4uZGluICAgICAgICB8IDEgLQogd2luc3VwL2N5Z3dpbi94ODZfNjQv
Y3lnd2luLmRpbiB8IDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9jeWd3aW4uZGluIGIvd2luc3Vw
L2N5Z3dpbi9jeWd3aW4uZGluCmluZGV4IGNkNzFkYTI3NC4uYjIwZmYzZThmIDEwMDY0NAotLS0g
YS93aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4KKysrIGIvd2luc3VwL2N5Z3dpbi9jeWd3aW4uZGlu
CkBAIC0xNDcsNyArMTQ3LDYgQEAgX194ZHJyZWNfZ2V0cmVjIFNJR0ZFCiBfX3hkcnJlY19zZXRu
b25ibG9jayBTSUdGRQogX194cGdfc2lncGF1c2UgU0lHRkUKIF9feHBnX3N0cmVycm9yX3IgU0lH
RkUKLV9hbGxvY2EgPSBfX2FsbG9jYSBOT1NJR0ZFCiBfZGxsX2NydDAgTk9TSUdGRQogX0V4aXQg
U0lHRkUKIF9leGl0IFNJR0ZFCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3g4Nl82NC9jeWd3
aW4uZGluIGIvd2luc3VwL2N5Z3dpbi94ODZfNjQvY3lnd2luLmRpbgppbmRleCAyMjg4OTQ2MjMu
LmRmZDUwYTRjMyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi94ODZfNjQvY3lnd2luLmRpbgor
KysgYi93aW5zdXAvY3lnd2luL3g4Nl82NC9jeWd3aW4uZGluCkBAIC0xLDIgKzEsNCBAQAogIyB4
ODZfNjQtc3BlY2lmaWMgZXhwb3J0cwogIyBUaGVzZSBzeW1ib2xzIGFyZSBvbmx5IGF2YWlsYWJs
ZSBvbiB4ODYveDY0IGFyY2hpdGVjdHVyZXMKKworX2FsbG9jYSA9IF9fYWxsb2NhIE5PU0lHRkUK
LS0KMi41My4wLndpbmRvd3MuMQoK

--_002_MA0P287MB3082A6AAABBF6611C1B989349F62AMA0P287MB3082INDP_--

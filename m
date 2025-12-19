Return-Path: <SRS0=H4g6=6Z=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021078.outbound.protection.outlook.com [40.107.57.78])
	by sourceware.org (Postfix) with ESMTPS id 2F5874BA2E04;
	Fri, 19 Dec 2025 11:58:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2F5874BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2F5874BA2E04
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=40.107.57.78
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1766145503; cv=pass;
	b=V8tSHEI8dYU9NXpq3eOCXPBAtzXcwIpWmgSEF0ACXGP5isoKhMC0NwQlhKCP0m9CVxDUptFiQCyL1AuStne1XHA0VrZkrCJjMOccLCf7eh2SzSl2US7UKMCJEj5GTANSoGPVm43mALPA0lpwJjjLjExCQ1ZDhbX0vjS2TK75C1M=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766145503; c=relaxed/simple;
	bh=moRfz4QzQIj5TFIxvdAqmWyNCkE/HNVTq7sfpGEgIxg=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=MCHWQT1dU3zrztH+nr5ibSFRAIyKoZ6E8giVOjKVGidyKhDhY6X6tb7ZYWNvB0FqhOf6Q34MvQrjcWRMOttba7bfj1VZ3psjJnVkfjhqbLxYptEFAUPxNcJaNlHHkSr6IxnCom2wPYcfisCZJkCYYI5a2C78/05az0FiF9SQyNg=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2F5874BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=O4C2CVAN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls5MuTFr1KCNQWgiB0tGJGwUhLL5W5htq0DGgzr+7G9nwL2U1+8WY16QD3Pz2hBfCT+EoDIruWv0q9TJSOx7ZPKYt8yNIiI3cPjo2UChUmUqt3H3nJ/3TvUG3A1XhoG2TxfUXnJ3T7e+NWjg4W4R4O3pKBj9GwUXTLm7hFLmG8YF1TBeklHB/jx9HYRFsOvXdtD1J4pEw4BjkxF3NWmB2oIYSWXdcxEOS0o53fSp1qyJdSgQH6GhB7eWfnhgZJFd9XW98ynlED13zTTlsdVxCEqyCgKg+TxqsOUcWV+7djGyJm2go7N5VUdCgWJxxVHkq5aHg6r+8QJ3rhjuqPgWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moRfz4QzQIj5TFIxvdAqmWyNCkE/HNVTq7sfpGEgIxg=;
 b=R0DUborlG2mqwNRgxjoScZ+meKBe9KcCyiI5EFGUunlcbxWcYcnkvbpKciG4cft+mz3pe1NK5XF646ecfFCbq+d9HRL/ARHNa2tEZahpbikPUCkdeL9kjlGbKPIkAPw6MaBiyv3GfrixXXeIUQ7rGWmSvraz8+qIhBw1qNtuFApGpdWz0POXVeMXLox24u4+QnJqirFmSmBx7ReFp/x1QM200tMIrMqV85Hex2dB+ABF+78GpSoGr8/YUNPfs9eJtt9wuJpWfvtuVG7n8y5m60+q9HAysAhoUfNkq0FeYL7yVrDcycBSc6Bsc61w1t+/wpsDmZXmRyicwuNhj2PuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moRfz4QzQIj5TFIxvdAqmWyNCkE/HNVTq7sfpGEgIxg=;
 b=O4C2CVANv2npoKcSKsIGnLkNl7aUsxj14oyy3BmdSYur0ap5Uj9famxo9iowBRFNVDBRPXfS3M9RFMSP2mVO9rE+UQBU0fipEYQttoXdQE6IUrbvzSeguKsDe1Bh1UaeCr7f5nCcBG0LcZFDzEJ8OXtu9rV5MIbIf4S2J/8rdJSolxvM2Q61xIrzF63/mHHF4pcXpSIgE2OC/ptGl5bVlYDyd5wnXoviGBvdL/K6t8E9sOWdz4EWFR461MZUA8QNwqb5MvhRXEZFJYLA8UWUT9ZHKu/37P7R8ax+jFcoZ98Ubv5T6svWD476EqdWzpIgKrngbXMUSAvBLz/ihqxFhA==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA5P287MB4396.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:169::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 11:58:19 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 11:58:19 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Corinna Vinschen <corinna-cygwin@cygwin.com>
Subject: RE: [WIP::PATCHES] [RFC] Preliminary ARM64 compilation support for
 Cygwin
Thread-Topic: [WIP::PATCHES] [RFC] Preliminary ARM64 compilation support for
 Cygwin
Thread-Index: AdxoKhFxMNzP67ZvSzuqLMsZVRNe9AB0YcGAAbSXvdAAAjbBgAABwwQQ
Date: Fri, 19 Dec 2025 11:58:19 +0000
Message-ID:
 <MA0P287MB3082E997271542FC9CDE099C9FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082C051C4E43AB64AD4B9959FA2A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aTmvvwfClr2suB2R@calimero.vinschen.de>
 <MA0P287MB30824A7CD2D09D49825C01809FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aUUwh5EFke-rrQTV@calimero.vinschen.de>
In-Reply-To: <aUUwh5EFke-rrQTV@calimero.vinschen.de>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA5P287MB4396:EE_
x-ms-office365-filtering-correlation-id: fcf17ef4-6c39-4c05-1e20-08de3ef5e6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDA4ZFQvODdMMzBsdUdoWkZZaHg4WGUrQVNvakprRnQzc3NyV21vTEVuaVlr?=
 =?utf-8?B?YzlyV3RYQ2l1YVlzemk5TDlRN002Y3h1bDZZeDFCT2o5SHdweDZKRnRyVjAy?=
 =?utf-8?B?aEJmODExWjg4Smh5K1Vnc1hDZjRJMEZyT2YySWVvcEUvQ3E0dUY3NEhFdWkx?=
 =?utf-8?B?R0Nid3dGRllzNWVFQU9KaEQ3bGF3MzBKME8wMExyZlVBK1Q2WG9FcmJVNVl3?=
 =?utf-8?B?Y2RoTytpaE8wSFBrRWhLZE1QRGhuYklCRXAySjB4eEJ0RUVHYzlhNEpjU3FW?=
 =?utf-8?B?WFVaTGozZG1kY0xRaXBXQXhIQWNhTGpZTm9pRDF3Sm5lUHo3VkVkWk41encz?=
 =?utf-8?B?eERIV01DTVE4MDlaQWs0MGgwRWtQYmsvVXAxMnhnOTVxL3I2bVQ5L2h3NXUr?=
 =?utf-8?B?aVRkOE10Ri94U2d3SUlsaVdsLzJ0Vy80SnNhSHYrdjAvSHJrNENnTnJHSVQ3?=
 =?utf-8?B?aithZHlJQ3ZuNEpFcVpNWmVIZjBCWFpHak53ZUo0eGxITHBCeUx5VHVXNGRZ?=
 =?utf-8?B?WktXbjlpL2xWVDJDN3BhSytLR1l5UVhNZ2QxUVlPUTBNSjMxZ0xPcW9EQUhs?=
 =?utf-8?B?U29vNFhHZUl4ZFBCdkpJeGdDUnB4K3p0UUNjMExiUHRNY3FIbkcyK2Zsblp1?=
 =?utf-8?B?dUtVNnlNWmFxRmh1aTFXS2M4Q2s5eC9RL290OFBWMXVjZEI2cEhETmQ3VHlY?=
 =?utf-8?B?cnhiUStTbFg3bTNoeldFV3hmakZwRmovSGJydDlkc1d5T0dYbFN4ZGFXdVY2?=
 =?utf-8?B?blpFbXFhQWd1QndpNzVzNm92cUYxTFdvME9vYmRuRUhDWHNpVWdqYzdhU0w5?=
 =?utf-8?B?c3RHbm9ZczR4MVYyS1RHbEhHeVRWbWI4NWhxUERJWm1NRVhId2plSGFLazFW?=
 =?utf-8?B?T3JhOWc3aVgvcjZPTWl5YS9nbWdGdlRZdDBrWG9lWkdKZWFveG1xZlhSUkNX?=
 =?utf-8?B?cGlOdVhQbzM4eFBHR2EvUFZ0b3ZPanJKSGFZZmZkRmloNXdQa1BrbzJ5SFVp?=
 =?utf-8?B?Q2tVVVZRVXpoR3h5YlFwVjBDZnEyVE5jeUl5ek9Pay9RWU9XSDVlUnYxSUR2?=
 =?utf-8?B?V0piMVZqalZpak56RW1YaVhLY2pCZHE1MUR0dU9LQS9ubTRzeWo2Rm5ETXRU?=
 =?utf-8?B?TG9DQnFhYS9mTVJwUXVVdWNNVmNOY3p5S08wa1JPMllQQysxdnB6c0NrNVMw?=
 =?utf-8?B?MUZRMzNTazlVYW9WN3NSSHFVcDI1WnU4TmhnbFM0eVRiTGxxTWl5OEYybGJS?=
 =?utf-8?B?Zys2THhaVzFhT3hKNnpoQkVmYUs1bklRMkRTemFiYVJDeXFJcERFbndsWHkx?=
 =?utf-8?B?ZW1tVWp1TWhsc1gweHJrb01rSTJUdUFsdExMR3lzejUvTThwRHo0Qk5DbnVS?=
 =?utf-8?B?a2xqcnE4TmMxVC9WdnB6T2NnbFEwd2RrUUtFTHFScFN5bTFDRGxFYjh1c1VQ?=
 =?utf-8?B?TTNHTTdnaGIyYlgxWVFFL1YrVkRHQnJQWVBTUmE2S01Cc1ZnMGVidFdPNmpK?=
 =?utf-8?B?cWUxNkovSW15SVlPTE5XU2h2a2lrVDRSNEt6WUJRQ0FONHAwYnZhOXRRek1E?=
 =?utf-8?B?WmgzbnM0TnI2UU5YU1pJV3FoRkw1V1p4SzdLUWtJSC93eE04U0FjMHhKVkk4?=
 =?utf-8?B?Sjd4TXdZemlDQXUxcFl4eHFDRTVUN0JlRjBPbWRYUlkzam1IbzFSVzUvWkxa?=
 =?utf-8?B?d05jWHZWdnU0dFgwQ1Y0VVJTck9YSGVpMVJrZFFVRXZyQUI3ZE9MQ1ozNHJv?=
 =?utf-8?B?dGxaTUtkb1NjYVVRdVRSRWQ5dFBjSVI4UE5BM1V1aEdBYXR1RVYvVXRBVFQy?=
 =?utf-8?B?RFRobjhGSDIzQVFJdXpnNllQS2N2Tk01Y21uS0xPK213OFBuL3hmbVlNVjJt?=
 =?utf-8?B?ZTl2ektZT1JvUEI4SU40T2lGVWxrSDQrT3p1VDlRbXV6MS9Jd05jb2xUYWw3?=
 =?utf-8?B?WGQ4dHhCMVY2MmhOVHFpWUNhWXd5NmZZTndnS0xERHRuWVpRN1N0L3lXOTlx?=
 =?utf-8?B?TEFrbVNnYURyWjUzTXBvZEh3U3VkazBaZ1U4V0JpeVY3QnVhc0FSUUg5TGtx?=
 =?utf-8?Q?6cl5yk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a01Ed3RPdTVmdDNUTjBsdXdlVlhLb2gwOXhwcTRHMHNZNHp6bDBYNVN0SU5V?=
 =?utf-8?B?RGlXaVRuaFVXWmdldEpZN0hOcVJNNk1KUEMwbHZvb2ZxMEtKcTRmV0trMDNm?=
 =?utf-8?B?R0h2bzFGNkdxRlN3cFBCVDhORDJUTjFLQzZ1MXR2OWV3aUEvY1ptQW9LUldr?=
 =?utf-8?B?NFlSQTRFVUxLcjFlMStTa3I4SFh0K1dtRkRlcFpreVhtS0V6SU1VTnp4aVNw?=
 =?utf-8?B?WVpLTGtqbzQ5WW95L3g3azc4NGpYTzh0bkErTUcvTjhWNnAvR09oNFNwd3BY?=
 =?utf-8?B?bXREMlhpd243SVUzUWVKVjRKbW56c2xRbzQrUURuMGZuOE5GM3hmUnAweWxC?=
 =?utf-8?B?WENiS1EweStYYjRFY09Vc1RqQmo0UlV2RjNoRU5pa3FGbDhOeXJtcDdTNTF2?=
 =?utf-8?B?VTVjZjd0b3dKb0N1d3hUbGJ0SXU4RXYyT3pEYTcydlVjWFlkVzMyYmZidml4?=
 =?utf-8?B?Yzl1dk9YVmVjTTlmeDloM3FKSDl4OFhYL3BuajlPSnNncW5rVVErejhKRHdE?=
 =?utf-8?B?bUVRYVYvcVJDSkVXdC9nYzdaS01BMVozOFdWRmVZVFU3eWs5ZnFyNXY0U3Rw?=
 =?utf-8?B?NHVrbE5mS3hCWUx1ajJFQTdMdjRnc3VUa29Dd2c1bVlnVllIOWNNYnpzZFhi?=
 =?utf-8?B?WDNtNUVqRXlJOWdwdFlWc1VKSDNnVzZwQlJSZnpnYmgxL1hqKzVHWW1qWWFS?=
 =?utf-8?B?akVkKzl3Y0E0SXJmd3E0anJyOEVZdzJ5UTlNQnJ1V0pqNFAzOEpFbWFWM2lo?=
 =?utf-8?B?TFp1UDZGNzB6SFhlRG8yS2FCMlcxL3hUMVM5YTZiU3daNWNGYTAyMW1zVUgy?=
 =?utf-8?B?bWpPOHZQR2JaaU1hRTJINS92eXpMQk1pWWFHYmNKbktZWlpDbEtZRUdCNmJl?=
 =?utf-8?B?NUhDdHlWendEYjNWcTFydjd6Y1Mya01sRW4xWDNpYXdYeXU2SGNsYWlzS3Bh?=
 =?utf-8?B?aDlPWUZUZGk4UGVXTTg1Rzdickp5ek02SVN1RmRDbVk5dkZyS3oxQlEzRGVr?=
 =?utf-8?B?SXVzOE94MEdVUG9ZNG5ubXNJVEZYaDZjSGVHbU1QbmhXUUdqTE9tNzQyMXpa?=
 =?utf-8?B?LzJGSnh3b0o5K2JyU21abU1JM0VJb0tzM25PSm9LUEhYSFhOK3UxYi9TdUxP?=
 =?utf-8?B?UUN0dDBXVWJ3UTVzemVLK3BGSjJWTkNlWU1mTU5aY3dmdHQyZmdyNDdOMURs?=
 =?utf-8?B?dW9yM1VsMjhPLzluZzFmdUJaMmxnUGZiNEFpUXZSTVJMWHNxRTVoNDh0WW9i?=
 =?utf-8?B?R2orUmpkUGJad01zSC80TnV0aXNMNFRsanVEVlZUeDlxUDVneGRsUmpjMmhK?=
 =?utf-8?B?NUxwMWVwSFpkU21kZS9ZVXRvRUJ3OVJzbmJObmtXc1Znc3ZZU0owU3pDK0tp?=
 =?utf-8?B?TlFKbjFLZ2RCK1VZaUQrZ2ZMS0dBcUhzQnJFYThuY3hYZmc5Q0xSU1U3ZEJt?=
 =?utf-8?B?amU0dSt5c0dTVzYrWXgyYlBSOHo2T1BwSG9MZlhKSW14M1FTRUtYdzF2dG13?=
 =?utf-8?B?eVhJOGRWTXJIck1UZUl5ZERLWEZuVVR1R3loUnlhSGdjc0hsZStzbnUxNGgw?=
 =?utf-8?B?ZW5HQnhtbXFienpRYU9sTG1PRG8rNkFZbzJrRklPVkpnY3E1YVRwcVlZQUxM?=
 =?utf-8?B?dFRyM3dUY3FkOVF3MnZYQ1F6c2hmdDZWVmlqd2Y3UDRmQlJLdFZYbW9lWTF3?=
 =?utf-8?B?Z01Gazg2OG1keEQ0TitaZGlsT21RWXNJVS9vVWVpdEg4VE9wdmVBUlJkdDBq?=
 =?utf-8?B?bzd3VmlCdnBjY3p0a3JJcHpCVGhBTnByaXFNMlg0K0QrQTNrNGhHVnZWOTdG?=
 =?utf-8?B?NERmbkhBTXVKd0xYMktBeXRYdS8xdzF1K3BkZ2tjT3l0aUFRaVNCVFNXcFFL?=
 =?utf-8?B?Y2NXczhKS0NsZzJKM3l6MHdZY2dIcHhmUEVrbnMwRW1YVy9RNVVOTXlES0tF?=
 =?utf-8?B?SHA0ZGpQY1RybnZwT3lTazNScE0zcTRKMXgzTEkyRTFrZ0ZmRGZHMG5TWSt0?=
 =?utf-8?B?WVYzZTFBVm10RDRZc0FScjBydGxBM0hLWXZ4NG8ybmpqUlhSWXZtQllZcWtZ?=
 =?utf-8?B?M0JXejhKeDkxbGRqWnduZmJHOExpK3UyZHFoaTBHV3U0b2wxRTd1cG9oRFJ0?=
 =?utf-8?B?N0hldksxejVnaTN4MXdDQjBWSU5aTUs5bkZzK09iRyt5bTZzaitsRlJKWG1h?=
 =?utf-8?B?YXcyTXdWVGViMUJNYVNZUXJWaVQzUFpTQWx1b2NvV0NlZGxuQU44aHUzdW9k?=
 =?utf-8?Q?qMiSQfPVAQ3hnhWg54LNoPvMGZGszFPahygfruGo8Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf17ef4-6c39-4c05-1e20-08de3ef5e6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 11:58:19.3766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAk0k1DfC3i7QqhxFMl4Ac6V10Fiwn1/nnlFWG3fIf+hzAlJIgc8RsEwYeASi3hsmnuBz66qaTeuBXYbN8RUGZkpwoVFkGedgkkL9esSwfk9kx0Hw4UhkAnbrFWSi9XBa5l//0B0mFx0uSNSuNo0IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB4396
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

PiBUaGUgcGF0Y2ggY2hhbmdpbmcgdGhlIGFmZmVjdGVkIE1ha2VmaWxlLmluYyBmaWxlcyBzaG91
bGQgY29udGFpbiBvbmx5IHRoZSBjaGFuZ2VzIHRvIHRoZSBpbmMgZmlsZS4gIA0KPiBKZWZmIG9y
IEkgd2lsbCB0aGVuIHJlZ2VuZXJhdGUgdGhlIE1ha2VmaWxlLmluIGFuZCBjb25maWd1cmUgZmls
ZXMgYXMgbmVjZXNzYXJ5Lg0KDQpHb3QgaXQsIHRoYW5rcy4NCg0KPiBZb3Ugc2hvdWxkIGNyZWF0
ZSBwYXRjaGVzIGZvciBuZXdsaWIgc2VwYXJhdGVseSBmcm9tIHBhdGNoZXMgZm9yIEN5Z3dpbiBh
bmQgc2VuZCB0aGVtIHRvIHRoZSBuZXdsaWIgbWFpbGluZyBsaXN0LiAgDQo+IEdpdmVuIHRoZSBv
cmRlciBpbiB3aGljaCB0aGluZ3MgYXJlIGJ1aWx0IGluIHRoZSByZXBvLCBpdCdzIHVzdWFsbHkg
YmV0dGVyIHRvIHNlbmQgdGhlIG5ld2xpYiBzdHVmZiBwcmlvciB0byBzZW5kaW5nIA0KPiBhbnkg
Y2hhbmdlcyB0byBDeWd3aW4gd2hpY2ggYXJlIGFmZmVjdGVkIGJ5IHRoZSBuZXdsaWIgY2hhbmdl
Lg0KDQpUaGFua3MgQ29yaW5uYSwgSeKAmWxsIGZvbGxvdyB0aGUgc3VnZ2VzdGVkIGFwcHJvYWNo
Lg0KDQpGb3Igbm93LCBJ4oCZbSB1c2luZyB0aGlzIHRocmVhZCB0byBtYWtlIHRoZSBwYXRjaGVz
IHB1YmxpYyBhbmQgdG8gY29udmV5IHRoZSBvbmdvaW5nIHdvcmsuDQpTb29uLCB0aGVzZSBjaGFu
Z2VzIHdpbGwgYmUgc3BsaXQgaW50byBhcHByb3ByaWF0ZSBjb21taXRzIGFuZCBzZW50IGFzIGlu
ZGl2aWR1YWwgcGF0Y2hlcyANCndpdGggYXBwcm9wcmlhdGUgY29tbWl0cyBtZXNzYWdlcyB3aWxs
IGJlIHNlbnQgdG8gdGhlIHJlbGV2YW50IG1haWxpbmcgbGlzdHMuDQpJIGJlbGlldmUgdGhhdCBp
bmRpdmlkdWFsIHRocmVhZHMgd2lsbCBtYWtlIHRoZW0gZWFzaWVyIHRvIHJldmlldyBhbmQgaW50
ZWdyYXRlLg0KIA0KUmVnYXJkcywNClRoaXJ1bWFsYWkgTmFnYWxpbmdhbQ0KPFRoaXJ1bWFsYWku
bmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4NCg==

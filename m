Return-Path: <SRS0=c1qK=7V=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id 67A7E4BA2E25
	for <cygwin-patches@cygwin.com>; Fri, 16 Jan 2026 18:01:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 67A7E4BA2E25
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 67A7E4BA2E25
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1768586488; cv=pass;
	b=E5UAMVTTL1hwGXBehliLUztEoK1CLlAHmJtz+nS8no7RRMJteRwPDh4VH13/XQOAA9gWi2lgBMK4OfSaER+e4xB5cT48wcB5fUlwCUlOIEIQnAJjcWas7tDgh48aVJODxyAbfuWdjE7652I6MOyHlQGl5GP7xeNhldebb0S63wY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768586488; c=relaxed/simple;
	bh=fDSDvRU/EUHy2WoP5dF4hZZbzBppM9VCsymliMnXVdw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=CcyZed06ZtknqdWH/a1e2RvViUbsYwuf2eiovzeUlD5GisPx39U1UQuTUpDHhsHDhGCiNbGkiPAXf5uPpTEh548r2YtYP69lj4rElM+X9CKyub3ZdEn0rn42NVNgpo6X6kyMqWfgFWhM3nmAnxoC6llCagy/08um4XOqvMcoHTQ=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 67A7E4BA2E25
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=zfhVNAzi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDV3nro8gVprrdHYwcY0x95UnJG29fU8k6whVyDaBHNPBf4NgUayOZ4sH6/4lx1rU6lLqsQcLj5XuSVfUJ1E5HbjVPJglHpSgPsNtUBpMh4dFoGJB+IXPkdG8Jh40zHZJTeduKrw9/W+kS7lbwZ2yxGX3pYg9+JMQK1qaLRvp56/IIAVaJqz4y/PJ4kR1oczPFJ7GKMkpFazNcezxbI9fc52QxRrb5LgmAnKQ3juZFJSxIlK+BXaFkH+HX7/ceXYkyoRHWqT+0OMXOKBR2c+szr4VGch8VjORPYZwWBBa5ISnS5DVR22L6pzNkWwwy2eMwIxsmWe8fL9YNeSoPGTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/63M6IGpKO2PbNcA42wYZ+QPWe5jjZsdMfOnvEgoTT0=;
 b=CjKA1Bjgp27Xyf7+qVxwwSNiacoAVPCp1qI2YsYpHQ2MpjdMvV8FCZNOCOdoxC6CN8XRI1+4nnLH/V7ttUZVlfgqinVjCNfLUJ0XIdjiA1sCnWu22ov0OLXbhhflr6dLgGmvUFzLlpLianpHinzFlV/61ieEvi2UG6/+fTIxPiHK6kAv9fkgTt98TLb9EwRSkgMeyFHORhgm0dYiyN5De5awWKyo8ZWySrkFpok96sEoPDTvLmpgnGNy5QPnyZriZMb1RGVG5tjTIkN+qD7bC5bnyVWkjvuyDeBaT4xoV3hBIAyl2uH4V/YrCrZZaBqTALx9+3oPkg5JQhcj6TPSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/63M6IGpKO2PbNcA42wYZ+QPWe5jjZsdMfOnvEgoTT0=;
 b=zfhVNAziopuJndU7cwW+5iwG48uIWiRANXN9xGx2X6ypqKCWUqx3TIbCFV6iN4Zp4cErwohPyiZTITG1zijaSZqSI1+5+mkaaE1qFA5T6njsD302hWPLuBwkZf64XojYNQX7nsCQWdYPidevOWlLBf1aP1r87tX4Y0qMJsJyRXYNmeCBzzzeV+TV4vJWqwiDXXxpDiGbsO/s0CI7ZXQnkTDNt7OLX7dAalsWIL2bwTD90Du1Yorr+dY85u6uRyJ2IQSSdhd/J1iaje/zB7HdEUkT3/pNhPidExOM38i3B1zJh//pzn1Fccli80TtEimpDbNFPTCJ8JCc7dOrUj55kw==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MAUP287MB4896.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.5; Fri, 16 Jan
 2026 18:01:24 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%3]) with mapi id 15.20.9542.003; Fri, 16 Jan 2026
 18:01:24 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH V2] Cygwin: gendef: Implement sigsetjmp for AArch64
Thread-Topic: [PATCH V2] Cygwin: gendef: Implement sigsetjmp for AArch64
Thread-Index: AQHchxIg7ajyZyvUKkW5jSD7MfQcsg==
Date: Fri, 16 Jan 2026 18:01:24 +0000
Message-ID:
 <MA0P287MB30827B90DE8B6EBE2F8918899F8DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082C7171807D783172246109FBEA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB3082C7171807D783172246109FBEA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
undefined: 4087715
drawingcanvaselements: []
composetype: reply
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MAUP287MB4896:EE_
x-ms-office365-filtering-correlation-id: 9c29920f-a344-4318-5f89-08de5529436f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|4053099003|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?YTSB64Hlb3xB7o1gFXAeQT1gHqpiLoPJARO9OCDROTEG4JYM31gDmehFgD?=
 =?iso-8859-1?Q?qYpoyO0RjFngAjuFvVpmarZNRK9LxbjyFH6C47dl8MdK4TBL6sVDiOnZHG?=
 =?iso-8859-1?Q?GcRcRyp6kN4Vi9zShqEE8CI31Vhw+YwQP1LxF3AlTsyJz4emYK4za7b02X?=
 =?iso-8859-1?Q?M1klxLvXbFr5SeqQmIuW3vbTC6w10/RRao9EmjFRdC1POCoSbVPelqXFLN?=
 =?iso-8859-1?Q?dYFAyoI1oj7UB9uaofQYNOyKbG05jlpfDyo5S5fmSiAR1O/iuZCg7GfFwQ?=
 =?iso-8859-1?Q?HSKYI2SXD8KYKO7/kOv/+i3t6ILTbdccVuH+NsqfO1zmT1f2LD76v2Gfyx?=
 =?iso-8859-1?Q?wmNkOUbP22kq6glpH5FG6p93BSL+qbUxRc35+P5jZxH9VVOU6Lac0+IwCn?=
 =?iso-8859-1?Q?VGxDY/oHIXvykoZ177CUzNFTCzpHkA16/khzCJMNae9vdBmkOaWZlctd9p?=
 =?iso-8859-1?Q?JBVH7MdPZ2Wbuv1WUHzJxRWogofzPV6H8LBTZv6BjKdnQNXb4FRscdWWap?=
 =?iso-8859-1?Q?zppE6KnIG/PPkuLSU4XJ3H1nGLsiCl4ixpbJ2bOTHoUnpzovwygiyE2QJ7?=
 =?iso-8859-1?Q?z7LZNmNUmPkL+zfC3guSiln8UeeMU1bNxt8QK5I96B0fo01h7j613Asust?=
 =?iso-8859-1?Q?F9RCyjPR8MXCHgO9FhNqzI4BvCyvJ/V/kZeNLCFg7TCOd4z/62nyF9aDn9?=
 =?iso-8859-1?Q?ojrtiPhKnu7Ri4Crfb7b2Qdvm0x3Xkp+Tm/ZU52epBqFAYd8X1+/EQhxcT?=
 =?iso-8859-1?Q?g+TZlW/S/PrnJU2QJ1FvyWfCg0qu1zIgkvSpPWEElFkbGAp+mleArDH8vK?=
 =?iso-8859-1?Q?MAXaMBg/QInKPo+rX62sp0mP2eS/qiRa4Ts6W3rkjt4PeVq7IJcgBHo3bz?=
 =?iso-8859-1?Q?aaGPvgaIDsMwkodjdWf15etAZSbWC96r/5iKajiGqir7sOY5zsmrz3MgDD?=
 =?iso-8859-1?Q?pM9ISejIYa+3WdpYDHnuBgcFBCtqlLSH90SESApz9CTh4Mj+kS95ayvWdv?=
 =?iso-8859-1?Q?ZJuhmqoxeAa3Nr5xVOtd/O7wUEg+BrkEIHHayL/Ydl+CkENZdvblvkcD1x?=
 =?iso-8859-1?Q?ZUBtMA05v4Fvry95HoHUgzyq8koiOdXVbxcOAFlBlfjrYrugUzt4k+BXNO?=
 =?iso-8859-1?Q?807Je5bAlcptedn98IgH1vVf/H4Ofe3kdMDlo7Fs3pEop9oGUv8DS6dGE5?=
 =?iso-8859-1?Q?7Nh+FV+cNSP8D2yhsWZjasUHbbFsTeIF/iHv/r0fmtl1HuWTgdEJTj0QEP?=
 =?iso-8859-1?Q?zSjGUAM+bsXjSYJyS8yLp3xgREUzLV/WWv9Kl9JnVRz9OdSGXIi7uO2naK?=
 =?iso-8859-1?Q?LWYtUCzJlY6ZfvQ4cN+rgq2Ud1+o3iGp+YctmrNVhzmlVX1ZJUxPiRYkQt?=
 =?iso-8859-1?Q?iG8674d34Q+arOpuylEhkGaou4huhUJQGdilPopqhz0jNYnVHwE4vWy1Go?=
 =?iso-8859-1?Q?FFq02ZLFE+5VuEph/LzrVw5CsfT+drLvuEiO7U7EiIFaL5xF6a2qYwwHkZ?=
 =?iso-8859-1?Q?uZJK7oeinxtJN+/fCyAnNhqgG9gZI0mn+B66Twia8z5Q1MQ7TYzL4YZppt?=
 =?iso-8859-1?Q?TkBM12WyaO/djUAcip+uDgLsbYL+EKWkOg7Ozyg5UB3S5XGILNHEsgg0Uk?=
 =?iso-8859-1?Q?XykqCeV/NsBOX7EMq2p4e437hCJj77J0olx7IdWIhhbT5Brd6X2XgmdsPL?=
 =?iso-8859-1?Q?6oGKodaOoeLox9WMxv8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(4053099003)(38070700021)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OAgR6i5Uv7f4YwJT4lZHqTP0Y3Hew6NsLojI9lxy3G+9yKtSS0aHMtWvMc?=
 =?iso-8859-1?Q?cFD42gAn4PZmusni0JagXh9oOwUaDILHx2XYzdwqX38VMeb8bSeW8dVkG7?=
 =?iso-8859-1?Q?cS61bBt09t9/5zO5m5wb4kvYkh9Cg9sD+rHQSYzB/oMauuD8T9q6QmRLBf?=
 =?iso-8859-1?Q?WZCoJ/OrkgNtSYOJb+jWGTf2sS9nyeJNMKUVz/SNategSzEofTk4KpnHs/?=
 =?iso-8859-1?Q?K1ZAGpCI9HytfGrJHa9+qDBVUJ6ADRWSqH2UsF/KPfagwrnPbudqKIKHdM?=
 =?iso-8859-1?Q?uMKcmj0KFcxRYaKYun6YUKct57H32yKyi0/fGuKf9hShfBmMjnqEEJjG5Q?=
 =?iso-8859-1?Q?3KNYkBr91EljilvIrQZrpsMXfwLgrrB04sj6NXd9UMGw+t+N91ac/vjXsW?=
 =?iso-8859-1?Q?nuW/keFejonZ99kjvlXQhju5jsFoS6JFo0+NmQS1Rc6zAfkNpmyvSZHPIf?=
 =?iso-8859-1?Q?KDv4s9BNyXxFn25I7nWTcluFvzFggXP91iu9IIFbKYxuH3UkT2VDfkkjnL?=
 =?iso-8859-1?Q?7VIUvfvrmB4OKS6m1fk6GZmf0SSdkPATl5bTzfHoLkZy3JduzlF76jGwch?=
 =?iso-8859-1?Q?bLQTHu5KLyGi3RQ6fxSMuiHxppVrPavmax8JhJuGAT+uGNPdA+CONLSMOG?=
 =?iso-8859-1?Q?PMBPx8SxoDX7J4hBDUm3FeXjtqPifLArPUuIsMV6hUZNhkZ9nUsiRGnize?=
 =?iso-8859-1?Q?g5gTKq1ms3Sh8RcRA107qBvg3Gvtobpka8aBrh3aNdqzdfuLgt2rW7S/Qe?=
 =?iso-8859-1?Q?iE6JCS/tq+XLdGuckbnTLUhSU+YimSUrkbi8tpkx/VupZKrGrSejfLZT9m?=
 =?iso-8859-1?Q?8XID+Hq0+e1nRa67NhavB/g5UmMdSaIFxOrfOW0/H1koHR0iTVRZUBljoN?=
 =?iso-8859-1?Q?WC4X7xLhXMQCC6CAJEz+MNsF9/S13O/TkvatXE6JHP8O+Llwyb3yS824le?=
 =?iso-8859-1?Q?t4aZ25eKy5+jq4b2Mm0HjyKKMrH0/3ehV7kTA6vMBMyVMKnPpG6FsSFpqv?=
 =?iso-8859-1?Q?guVH6M/H6QzsJKb+I2TM3lJiIO7l1gzTsrXO68R++k/20b+hQRezwGwfyP?=
 =?iso-8859-1?Q?zoj6VOwkwCiBAVhCPynPdfF9L9hGypJIOGr0wKAH6iWkzT+PZ7AfdMwTBq?=
 =?iso-8859-1?Q?TmUEFX53JD1Fe8KB6zPJbR6kBit6lE9ebm/oW4PNnMXiSXusZMn/FtGXZI?=
 =?iso-8859-1?Q?62kWhY+IfLoa2bZQ7Jt9UDK4q69lI/XgxMvxGVNlReWFp3thipKn9WYZU1?=
 =?iso-8859-1?Q?n//z76+zycfuFWiCLaGe87StWyVw5rRHh2rokY6JoGh54LUI7+XIRFQzm1?=
 =?iso-8859-1?Q?lUGfFuX9+ZYOzgw83zs5nCwGN986CXMLdOzvoudI8ouY6xSWOAjkQIwV5O?=
 =?iso-8859-1?Q?CzKhRCA8M5uiQ8EdGTyxbNwxdAFTOPJj1QPwOYmrU8KqDuQxzc1VMK8cLI?=
 =?iso-8859-1?Q?OaKfQi7Zxy2pvJ1TnH4soqrD11kHLlu9KvLdrUtj31Vw5TGyJPS7dARMGA?=
 =?iso-8859-1?Q?/S2yz5FdVe9VXnG9KT2nd6/j+LkpIRfR0sZgh2d+Cg8nqk4iI19JYkjWFF?=
 =?iso-8859-1?Q?5hYj1W1AL6sarpSVC/2xKTa0PbPILBeuLi/Tc2wqw9Ir36aItn1Qk9ihwY?=
 =?iso-8859-1?Q?vr2krSYMRYZcRgFsGuUDeGyC1QdJ1MuULicSNVsduT5KCxAeVkYQEF+O5W?=
 =?iso-8859-1?Q?OMImDSkO5yEY/1dIOKvQx9qkbK/UP/87ub9NeHXUX3o0cP9Eia4c/qB8iu?=
 =?iso-8859-1?Q?d0DCAU2mp2Bign3gn3onrOfi9M6EeVHO3F/DS9sxp3hU8Afzpu+wRLmpaE?=
 =?iso-8859-1?Q?4rsSbLZBIMtZB4mc69txuNsQxDmpjqAEvZ7UEURCCpM+rg70pBOzBixcxg?=
 =?iso-8859-1?Q?2i?=
x-ms-exchange-antispam-messagedata-1:
 gLBaAORQNKNYXYh7ghI0dIlyg3gQDuQDTWPlZhcXLb52oAt2YsuRQRFR
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB30827B90DE8B6EBE2F8918899F8DAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c29920f-a344-4318-5f89-08de5529436f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 18:01:24.6340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GDAI5J7xXAxFN6DCU7SbXrl7wzDkYWc0HTrbUifrkUNrirbhoRoxHadFXfdzT+M3R7z/XA3VyYuvs9yq1dDyI1GvOl4tbUYzjIZ4DyVQwtWSFQmj6/6avfxOyCJJYc+VL/hc7N538vFw90UvOsNnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUP287MB4896
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB30827B90DE8B6EBE2F8918899F8DAMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB30827B90DE8B6EBE2F8918899F8DAMA0P287MB3082INDP_"

--_000_MA0P287MB30827B90DE8B6EBE2F8918899F8DAMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,



No additional changes in this version.

This V2 patch was regenerated on top of `cygwin/main` and applies cleanly a=
s-is, without any additional dependencies.



Thanks,

Thirumalai Nagalingam



In-lined Patch:



diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef

index b0e4d2a3e..ff13f1daa 100755

--- a/winsup/cygwin/scripts/gendef

+++ b/winsup/cygwin/scripts/gendef

@@ -607,7 +607,28 @@ EOF

        # TODO: These are only stubs, they need to be implemented properly =
for AArch64.

        return <<EOF;

        .globl  sigsetjmp

+       .seh_proc sigsetjmp

 sigsetjmp:

+       // prologue

+       stp             fp, lr, [sp, #-0x10]!   // save FP and LR registers

+       mov             fp, sp                  // set FP to current SP

+       .seh_endprologue

+       str     w1, [x0, #0x100]                // buf->savemask =3D savema=
sk

+       cbz     w1, 1f                          // If savemask =3D=3D 0, sk=
ip fetching sigmask

+       mov     x3, x0                          // save buf in x3

+       sub     sp, sp, #32                     // Allocate 32 bytes on sta=
ck call

+       mov     x0, #0                          // SIG_SETMASK

+       mov     x1, xzr                         // newmask =3D NULL

+       add     x2, x3, #0x108                  // &buf->sigmask

+       bl      pthread_sigmask

+       add     sp, sp, #32

+1:

+       bl      setjmp

+       // epilogue

+       ldp     fp, lr, [sp], #0x10             // restore saved FP and LR =
registers

+       ret

+       .seh_endproc

+

        .globl  setjmp

 setjmp:

        .globl  siglongjmp

--

2.52.0.windows.1



--_000_MA0P287MB30827B90DE8B6EBE2F8918899F8DAMA0P287MB3082INDP_--

--_004_MA0P287MB30827B90DE8B6EBE2F8918899F8DAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0006-Cygwin-gendef-Implement-sigsetjmp-for-AArch64.patch"
Content-Description: 0006-Cygwin-gendef-Implement-sigsetjmp-for-AArch64.patch
Content-Disposition: attachment;
	filename="0006-Cygwin-gendef-Implement-sigsetjmp-for-AArch64.patch";
	size=1704; creation-date="Fri, 16 Jan 2026 17:36:59 GMT";
	modification-date="Fri, 16 Jan 2026 17:44:55 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3YmJhZDg5ZmJhOGRiNTViYjc0NjFkMzIyYWZhZWFmOWJkZTEzYjRm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE4OjEyOjQzICswNTMw
ClN1YmplY3Q6IFtQQVRDSCA2LzZdIEN5Z3dpbjogZ2VuZGVmOiBJbXBsZW1l
bnQgc2lnc2V0am1wIGZvciBBQXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNv
bnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50
LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpDby1hdXRob3JlZC1ieTogUmFk
ZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+CgpTaWdu
ZWQtb2ZmLWJ5OiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWku
bmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KLS0tCiB3aW5zdXAv
Y3lnd2luL3NjcmlwdHMvZ2VuZGVmIHwgMjEgKysrKysrKysrKysrKysrKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYgYi93aW5zdXAv
Y3lnd2luL3NjcmlwdHMvZ2VuZGVmCmluZGV4IGIwZTRkMmEzZS4uZmYxM2Yx
ZGFhIDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVm
CisrKyBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKQEAgLTYwNyw3
ICs2MDcsMjggQEAgRU9GCiAJIyBUT0RPOiBUaGVzZSBhcmUgb25seSBzdHVi
cywgdGhleSBuZWVkIHRvIGJlIGltcGxlbWVudGVkIHByb3Blcmx5IGZvciBB
QXJjaDY0LgogCXJldHVybiA8PEVPRjsKIAkuZ2xvYmwJc2lnc2V0am1wCisJ
LnNlaF9wcm9jIHNpZ3NldGptcAogc2lnc2V0am1wOgorCS8vIHByb2xvZ3Vl
CisJc3RwCQlmcCwgbHIsIFtzcCwgIy0weDEwXSEJLy8gc2F2ZSBGUCBhbmQg
TFIgcmVnaXN0ZXJzCisJbW92CQlmcCwgc3AJCQkvLyBzZXQgRlAgdG8gY3Vy
cmVudCBTUAorCS5zZWhfZW5kcHJvbG9ndWUKKwlzdHIJdzEsIFt4MCwgIzB4
MTAwXQkJLy8gYnVmLT5zYXZlbWFzayA9IHNhdmVtYXNrCisJY2J6ICAgICB3
MSwgMWYJCQkJLy8gSWYgc2F2ZW1hc2sgPT0gMCwgc2tpcCBmZXRjaGluZyBz
aWdtYXNrCisJbW92ICAgICB4MywgeDAgICAgICAgICAgICAgICAgICAgICAg
ICAJLy8gc2F2ZSBidWYgaW4geDMKKwlzdWIgICAgIHNwLCBzcCwgIzMyCQkJ
Ly8gQWxsb2NhdGUgMzIgYnl0ZXMgb24gc3RhY2sgY2FsbAorCW1vdiAgICAg
eDAsICMwICAgICAgICAgICAgICAgICAgICAgICAgIAkvLyBTSUdfU0VUTUFT
SworCW1vdiAgICAgeDEsIHh6ciAgICAgICAgICAgICAgICAgICAgICAgIAkv
LyBuZXdtYXNrID0gTlVMTAorCWFkZCAgICAgeDIsIHgzLCAjMHgxMDggICAg
ICAgICAgICAgICAgIAkvLyAmYnVmLT5zaWdtYXNrCisJYmwgICAgICBwdGhy
ZWFkX3NpZ21hc2sKKwlhZGQgICAgIHNwLCBzcCwgIzMyCisxOgorCWJsCXNl
dGptcAorCS8vIGVwaWxvZ3VlCisJbGRwCWZwLCBsciwgW3NwXSwgIzB4MTAJ
CS8vIHJlc3RvcmUgc2F2ZWQgRlAgYW5kIExSIHJlZ2lzdGVycworCXJldAor
CS5zZWhfZW5kcHJvYworCiAJLmdsb2JsICBzZXRqbXAKIHNldGptcDoKIAku
Z2xvYmwJc2lnbG9uZ2ptcAotLSAKMi41Mi4wLndpbmRvd3MuMQoK

--_004_MA0P287MB30827B90DE8B6EBE2F8918899F8DAMA0P287MB3082INDP_--

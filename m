Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::70f])
	by sourceware.org (Postfix) with ESMTPS id 5065E3857B8C
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 19:14:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5065E3857B8C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5065E3857B8C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2612::70f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752174851; cv=pass;
	b=IwORo+KWDnq0n9D9rndVNNAFSQ8eClZ+nqKNv8nVMnZVCvoI0u9DaWLfjfb2X3XOE7bvVoUSkRzYE0/Sk2EqcZEkqwTukxrqjTYBhD91dr1VLIol6lZIbz57hg7iAIbwhpzDYbHPDT8nSS2+DJNKbLs/+KifBMh7IDV/h5U6WAI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752174851; c=relaxed/simple;
	bh=ohqkS2uFYuUCzJrODcypL1hcG1Izf1C/Dtj5uK0YvU4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=h5r8GDvx8I4NvKcxbdNW5758nMAkNJgwvmQmUKaEkek7rOCkYYabolKL1Ej2hXCqKA3ZQpsb0OrTzeMTQhDX4MuTIGIsVgV6P7GuZQzpCDsLCA/NPX3T5/aXODKg1fYpfOIb9yeEg4+YSjREZrj4DTxULSHsB6onKel4GU0GLic=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5065E3857B8C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=WIOkBkAp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBhexmHOoOMPTJWOGMVCEnYknT82tSU6Zg82hSjdaBkYe1KzmcysmsUoEWijWrAUcvvDVMZXhzfQGxUwYislo/TbGNEkjYwoSJFuV0j0ghazh+YHrHjXN/eUaYg1mBOtqUp2DcBFaKGxrYyd4dppGaTWonyc8z/ZXbKIuznJh0f5BM+8TGeUnMBxyQErlHPXQznwQFzpaRSSVOXs2zjGRIFShQDBFMNaCunWV6VwBJsIumGRWoqlz6ip9oZ/Cpv9p/Nrufq3l/koim3qBGjYUyGNBlBhj+Q+fDuujamIiBX5S2lW1wxJvJbUQduMINaRH1e0fMNQ6lQEN7Vzrhet5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqeuPaTu9r9WHi3CMFTqNh4GTq96W+PA8BhfLefP24Q=;
 b=r6OoGfJPskl67WAyI/AVlJoV2f+V7OARCtNtCtMFvm3kjgzkbjfRnUNnWZR3AgSM/ohOb/d/uVlziMdGy5qq5BXmVlXUEEKpj2JYm48CUhhDEexwSZ/dloYtukjPvpiObxyleTpPO5GUMawF3luSO/SCDGBR1boVkbI3L3jWLJ2ljWBdMrGb4AfgVxqKadvZgArhxxSkbsRt9e2Jzv2IIVXg14poLWzf6VP2yRNRK+4OfFUoTc/QOXOBcwTFi1zwkTJtZXSiGGEEzp+j67vD4tSFdhLgaNzdWXbt9oHb+dsYCkViSOY0XJ6HRXhWnxGYSWSoyEjfGB8VdxEbmWQl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqeuPaTu9r9WHi3CMFTqNh4GTq96W+PA8BhfLefP24Q=;
 b=WIOkBkApS37F55rSoFCn22sgOASeoy77LW/IYnDr/uxUzgQ7Unpg2ZSlyoe0svqm5ySlRDzQTHZmFtrlR/dEBP44j0CX6diluHwDoE+f43Rknh9+MqhJNgTVEtnt/2+/RkZ0AtDKgP2ixLVHOvnctLNm1oOefjI0q6fTnvZ/1EM=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0680.EURPRD83.prod.outlook.com (2603:10a6:10:55d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Thu, 10 Jul
 2025 19:14:08 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%4]) with mapi id 15.20.8922.023; Thu, 10 Jul 2025
 19:14:06 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: resolve AArch64 linking by linking to onecore instead
 of kernel32
Thread-Topic: [PATCH] Cygwin: resolve AArch64 linking by linking to onecore
 instead of kernel32
Thread-Index: AQHb8c3S0rW8zKcc70Cc2xxiarf55g==
Date: Thu, 10 Jul 2025 19:14:06 +0000
Message-ID:
 <DB9PR83MB09239F1F48DD7D215E1A0B6E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T19:14:03.729Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0680:EE_
x-ms-office365-filtering-correlation-id: 90cd22d3-1406-407d-8845-08ddbfe5f0ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|13003099007|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?t/q8h24l8GJzrc5CaRAy19MCzRaeEs5NDxCdA8W+90btWYF3ho997kAaft?=
 =?iso-8859-2?Q?ZgqJt5jz4464L+MSsUb8Z4/pQsl7aTgsdienqNyf4/UyGtYBKjAJzK8r79?=
 =?iso-8859-2?Q?dkGCBLd7TXoj8w0U2P+g5ccAiQfKQZCi34+hiRYMG9257jDf2XRa97x81r?=
 =?iso-8859-2?Q?yoA3LsCNnwaaXsVUPbxLmZQYgt8MtcNayIY6Eai3KnAIUHMYmFPuZhExok?=
 =?iso-8859-2?Q?2rF0OeBgFedzOFwcBzCcIOWy8TZCsOXAixiD9cSd3IOj3mOHNogQBmitKt?=
 =?iso-8859-2?Q?mDyLeN3DsIC7aTB5+t7LvFFKfV2YJv1+Fjld1pgjV5vCguiXfq84OiDcvt?=
 =?iso-8859-2?Q?N15aCTb7s1/c8ytSu9T/Qv8CncfT8FtqQWz96e3Qnrg7vUxZAXMoWr4kEd?=
 =?iso-8859-2?Q?chJHPQY2iw6QxEiDRsMwKWsNGDtxSShDuc0Vf3uh/o+DuWQuJ3MtTPpZe3?=
 =?iso-8859-2?Q?BA1N39JFtE3r6bB17eTdf/dMXMcUqkDhI/1bbZY3tkHSb0pOmNam1L5Tzq?=
 =?iso-8859-2?Q?uCRYVW+Tn2IoFYPn7Kb2gMMH4KyUGk7wtyzpNASZyWMOKKL6tHHiQyL06X?=
 =?iso-8859-2?Q?qNDYW3EGilsw/KG8g02Fkxb3fUAKCT54p1kRUcyJiGhQ1NzDw+8SocjQF4?=
 =?iso-8859-2?Q?raV5FkWFi1wSGS7WCgLVlmuOU9zPuoT7ztg+dS1Zqug1DEZctA7ttjl+uh?=
 =?iso-8859-2?Q?n+CuV0741x29cnAuZ55hBBQ/4cXnDaCYnTmXT6j+p+YxTbSiNV21KMVQnA?=
 =?iso-8859-2?Q?PdYIal71z7xGDBfI0BQ6YUFrfEqzMNyW7E5cK6jRE29nC7IfYXsypNw4zE?=
 =?iso-8859-2?Q?WTQdqq2O3kThEjP5Yh2zua4FJj67TB6ykpppwKpjh5zx15Xw5+9LxkvAqA?=
 =?iso-8859-2?Q?WVo9ydr4UsAhiHC6MNWC+WqIaW4f14+llDU6PrOYx9YlaSmxFUteKVtTYO?=
 =?iso-8859-2?Q?R97cosmkCvPnUcw2PeXogAmuwGOvIlz24oE2Nc8YTPMYE5I/GCBOUelBs8?=
 =?iso-8859-2?Q?T52a/yD+Ohjnqn1GlIsNKeNs8iLeyXHGCttKFTTRZvEg/hPynJuy6DgULL?=
 =?iso-8859-2?Q?0sod+Y5JC7Wg0Hy4Yb4fBlJ1C2wNLYpUuj2FZ62w16JO/XkqWqYP2Hcxaj?=
 =?iso-8859-2?Q?PezNFk86kh8DQJsVzwm5Xxn4/32mcg9gzEx14L9zWEaaOjT7siAkulijdq?=
 =?iso-8859-2?Q?JEvF/T6alKPNAhM6tCUbf/SAyq3ASamemCCPNore5VmAIgn1qIRlhKoL5Q?=
 =?iso-8859-2?Q?jSZZLDk+MpR+tstjzmB2rc1FdkRN9EisAQmnrX3088VMnkfyBdrWurUjAX?=
 =?iso-8859-2?Q?uOpONc96odcqTBAwDORWVEJrzYDcL83n3jbgbMV6Sh2bot6vkV+NuGKanb?=
 =?iso-8859-2?Q?4znfFyqjDs+j8YSH1EIv2VEnXaAtpiOOQuTz28eaU8EMJSGjlN8Qa2tB3k?=
 =?iso-8859-2?Q?8CWTKsyZtbAv/lPv9XEM7ZZaVZDkRhgXUEuaituiyT0kvoehXAFK9O0cHW?=
 =?iso-8859-2?Q?ypC7AIp4vKI8AnLk7D/gL7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(13003099007)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?HJHDNYoqW8khu836+Q5e5Z82cOJKGt5Ll06qcdLHuTR6TdzCgMHZc62ked?=
 =?iso-8859-2?Q?ZiA3Erpm00j03PzQGESoHrJrf1Io3uyKFuCYRrHm8qTX0mTw6PXHS1i4rh?=
 =?iso-8859-2?Q?7LIN2fKnKe2xhodoyeIEPcZrAWhrPTI2QGsFaCyXQ/+hzFjAsGTon9gvUK?=
 =?iso-8859-2?Q?bnBEtljKfqwKEKfT6GAd0q5VwD4HZfxtGyWYSUq+uPNOFxY3ZejTvGqCNd?=
 =?iso-8859-2?Q?G8yQmLT6BUM1iaxvrbS3r9NFSsi4E0ohvvPOq+nwKUECZkomc1eWH50+bn?=
 =?iso-8859-2?Q?n5XfrIyDuwtn+LeGIsMXunOs5OFNprVnY+IXtD9YYkRcJsZMmTQm72SHF4?=
 =?iso-8859-2?Q?SQnWMV4GNw6jKuDIy2sp7Jwk4xEoRcLf2jvNnRuVefVoZ/ICN43bA42yMq?=
 =?iso-8859-2?Q?oFa4m4e3De8ZvIYR2OnNA5OemsytBKwz+JpVhDMoADJ7nvA0F5PpOQLIwv?=
 =?iso-8859-2?Q?SHdO/opuLzp/ezkwrVRBfYEZOjKoNZSiubUZa6XP4wRcF1g8Je0k39ZsYC?=
 =?iso-8859-2?Q?aIdUIUG3V03oqUz9rI2SFPoxnz+q2xbjSeD0yUL/f/QSDCgZaWvIodY73p?=
 =?iso-8859-2?Q?o24nbKR/wyledEZJDsHZM3sWwNmLESU5V4BGeegfjyrPuBVspvfCkZMndm?=
 =?iso-8859-2?Q?hJr4k11G+wyWm40CZHt20hXAPfRWySLPCX1kIdmUQHmIPynNl/3ugU43Vq?=
 =?iso-8859-2?Q?aEVqgxMQVXuDREszt70ak9O7HJKv/gLgeELFys9d1pP2oH3zbFc0BOC6gV?=
 =?iso-8859-2?Q?5cq9FK3kekxUOBgJGipW5YSXNsqlZbot4yep83wplM3mtB+axXPlO7fWsu?=
 =?iso-8859-2?Q?srGClIfSI2TVK7NbYgFLgMPZ6mvTkjTKCkJThiRfgkH26mOZN9CGpqbNHX?=
 =?iso-8859-2?Q?Sxd9dWTPECIq71E2f3zQunm1H6l6ivgSFxPvgiDSoXSigj4NpVGIdSYUTx?=
 =?iso-8859-2?Q?sV51h5GEIiRVVZq5K0gNhysF8oAmJVyYGlDQy3AZ52AB0S6yU+JFYEJ9i+?=
 =?iso-8859-2?Q?344w4OjBJZYWwc3LfzIdxGZZZf2Vkda8ggs0poTZD3ca5OQEbbVGciEMQ0?=
 =?iso-8859-2?Q?i6NiAXCvn2yU30LHPsintGymTfuoocPCsuDg9Int4yKlyYEQti3LzardEw?=
 =?iso-8859-2?Q?sGV4SmdqbkNcyzixXHtwlLALY5ZoymfrpM8ALd38BXGlYwGWe00w+GH8eK?=
 =?iso-8859-2?Q?XFBkrMT5T3qmzJt5ImfT9E77xk7OIajEh2vRFJe41FdXJOB8xL5AsA8XpV?=
 =?iso-8859-2?Q?ZPFL54cwSfrcGKNlHZuXce2wqqonnC/xRGIOPYBMTqu+NsrXovlaqQSA2P?=
 =?iso-8859-2?Q?W0J7daEKFD26lzHfwXjpTGju2fq32v07D/1qX8Vx0Rbqf9t/HPVlNw9jYc?=
 =?iso-8859-2?Q?8reY+BtV/hCPLoCM4sZgmRlE8wDeNkgG/+unvy/zAT6No0iVaRrwODWcRB?=
 =?iso-8859-2?Q?2i+dt1kgx6LYGkLbBBG3fZdD0/MjeaqewMYrjjnZi4QWgGWTpb9dglOSAl?=
 =?iso-8859-2?Q?py2dxFy7H/UAloD5+AkrwVJfqDbDKun5CDSWBl9A1RSebq7gKG9FjUtDR1?=
 =?iso-8859-2?Q?oDb7OqiOLVh2mgW8tkPsVL7t4iV9?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09239F1F48DD7D215E1A0B6E9248ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cd22d3-1406-407d-8845-08ddbfe5f0ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 19:14:06.2687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVTXVJ3WkBL7DCy/UtoiHHkeufzxh2EFdAVJeJnT8Z3tXn9c83D3ZblZwyTlPW/I/fSjd5zGpGmNIhd9hptcQiblrg30RLCIB5hvsgcFA4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0680
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,URI_TRY_3LD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09239F1F48DD7D215E1A0B6E9248ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
As Windows Arm64 platform does not carry historical compatibility layers, t=
he structure of Windows API DLLs is cleaner on Arm64 than on x64. For this =
reason, the x64 linking against `kernel32.dll` is not sufficient leading to=
 undefined references to many Windows API symbols that are in different DLL=
s that would have to be added to the linking command explicitly.=0A=
=0A=
To address that, there is a concept of umbrella DLLs (https://learn.microso=
ft.com/en-us/windows/win32/apiindex/windows-umbrella-libraries), that can b=
e added instead. The recommended replacement for `kernel32.dll` is `onecore=
.dll` (https://learn.microsoft.com/en-us/windows-hardware/drivers/develop/b=
uilding-for-onecore#building-for-onecore) that should be available since Wi=
ndows 7.=0A=
=0A=
In case of Cygwin linking, there is one exception, `pdh.dll` (Performance D=
ata Helper, https://learn.microsoft.com/en-us/windows/win32/perfctrs/perfor=
mance-counters-functions), that is not included in the `onecore.dll`.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 5a34927952b62bd273610ab85974922a7411375b Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Mon, 9 Jun 2025 13:08:09 +0200=0A=
Subject: [PATCH] Cygwin: resolve AArch64 linking by linking to onecore inst=
ead=0A=
 of kernel32=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
As Windows Arm64 platform does not carry historical compatibility layers,=
=0A=
he structure of Windows API DLLs is cleaner on Arm64 than on x64. For this=
=0A=
reason, the x64 linking against kernel32.dll is not sufficient leading to=
=0A=
undefined references to many Windows API symbols that are in different DLLs=
=0A=
that would have to be added to the linking command explicitly.=0A=
=0A=
To address that, there is a concept of umbrella DLLs=0A=
(https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-umbrella-=
libraries),=0A=
that can be added instead. The recommended replacement for kernel32.dll is=
=0A=
onecore.dll (https://learn.microsoft.com/en-us/windows-hardware/drivers/dev=
elop/building-for-onecore#building-for-onecore)=0A=
that should be available since Windows 7.=0A=
=0A=
In case of Cygwin linking, there is one exception, pdh.dll (Performance Dat=
a=0A=
Helper, https://learn.microsoft.com/en-us/windows/win32/perfctrs/performanc=
e-counters-functions),=0A=
that is not included in the onecore.dll.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/Makefile.am | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am=0A=
index 90a7332a8..96d1ab2f5 100644=0A=
--- a/winsup/cygwin/Makefile.am=0A=
+++ b/winsup/cygwin/Makefile.am=0A=
@@ -629,7 +629,7 @@ $(NEW_DLL_NAME): $(LDSCRIPT) libdll.a $(VERSION_OFILES)=
 $(LIBSERVER)\=0A=
 	$(LIBSERVER) \=0A=
 	$(newlib_build)/libm.a \=0A=
 	$(newlib_build)/libc.a \=0A=
-	-lgcc -lkernel32 -lntdll -Wl,-Map,cygwin.map=0A=
+	-lgcc -lpdh -lntdll -lonecore -Wl,-Map,cygwin.map=0A=
 	@$(MKDIR_P) ${target_builddir}/winsup/testsuite/testinst/bin/=0A=
 	$(AM_V_at)$(INSTALL_PROGRAM) $(NEW_DLL_NAME) ${target_builddir}/winsup/te=
stsuite/testinst/bin/$(DLL_NAME)=0A=
 =0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB09239F1F48DD7D215E1A0B6E9248ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-resolve-AArch64-linking-by-linking-to-onecore-instead-of-kernel32.patch"
Content-Description:
 0001-Cygwin-resolve-AArch64-linking-by-linking-to-onecore-instead-of-kernel32.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-resolve-AArch64-linking-by-linking-to-onecore-instead-of-kernel32.patch";
	size=2082; creation-date="Thu, 10 Jul 2025 19:10:51 GMT";
	modification-date="Thu, 10 Jul 2025 19:10:51 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1YTM0OTI3OTUyYjYyYmQyNzM2MTBhYjg1OTc0OTIyYTc0MTEzNzViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCA5IEp1biAyMDI1IDEzOjA4OjA5ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiByZXNvbHZlIEFBcmNoNjQgbGlua2luZyBieSBs
aW5raW5nIHRvIG9uZWNvcmUgaW5zdGVhZAogb2Yga2VybmVsMzIKTUlNRS1WZXJzaW9uOiAxLjAK
Q29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXIt
RW5jb2Rpbmc6IDhiaXQKCkFzIFdpbmRvd3MgQXJtNjQgcGxhdGZvcm0gZG9lcyBub3QgY2Fycnkg
aGlzdG9yaWNhbCBjb21wYXRpYmlsaXR5IGxheWVycywKaGUgc3RydWN0dXJlIG9mIFdpbmRvd3Mg
QVBJIERMTHMgaXMgY2xlYW5lciBvbiBBcm02NCB0aGFuIG9uIHg2NC4gRm9yIHRoaXMKcmVhc29u
LCB0aGUgeDY0IGxpbmtpbmcgYWdhaW5zdCBrZXJuZWwzMi5kbGwgaXMgbm90IHN1ZmZpY2llbnQg
bGVhZGluZyB0bwp1bmRlZmluZWQgcmVmZXJlbmNlcyB0byBtYW55IFdpbmRvd3MgQVBJIHN5bWJv
bHMgdGhhdCBhcmUgaW4gZGlmZmVyZW50IERMTHMKdGhhdCB3b3VsZCBoYXZlIHRvIGJlIGFkZGVk
IHRvIHRoZSBsaW5raW5nIGNvbW1hbmQgZXhwbGljaXRseS4KClRvIGFkZHJlc3MgdGhhdCwgdGhl
cmUgaXMgYSBjb25jZXB0IG9mIHVtYnJlbGxhIERMTHMKKGh0dHBzOi8vbGVhcm4ubWljcm9zb2Z0
LmNvbS9lbi11cy93aW5kb3dzL3dpbjMyL2FwaWluZGV4L3dpbmRvd3MtdW1icmVsbGEtbGlicmFy
aWVzKSwKdGhhdCBjYW4gYmUgYWRkZWQgaW5zdGVhZC4gVGhlIHJlY29tbWVuZGVkIHJlcGxhY2Vt
ZW50IGZvciBrZXJuZWwzMi5kbGwgaXMKb25lY29yZS5kbGwgKGh0dHBzOi8vbGVhcm4ubWljcm9z
b2Z0LmNvbS9lbi11cy93aW5kb3dzLWhhcmR3YXJlL2RyaXZlcnMvZGV2ZWxvcC9idWlsZGluZy1m
b3Itb25lY29yZSNidWlsZGluZy1mb3Itb25lY29yZSkKdGhhdCBzaG91bGQgYmUgYXZhaWxhYmxl
IHNpbmNlIFdpbmRvd3MgNy4KCkluIGNhc2Ugb2YgQ3lnd2luIGxpbmtpbmcsIHRoZXJlIGlzIG9u
ZSBleGNlcHRpb24sIHBkaC5kbGwgKFBlcmZvcm1hbmNlIERhdGEKSGVscGVyLCBodHRwczovL2xl
YXJuLm1pY3Jvc29mdC5jb20vZW4tdXMvd2luZG93cy93aW4zMi9wZXJmY3Rycy9wZXJmb3JtYW5j
ZS1jb3VudGVycy1mdW5jdGlvbnMpLAp0aGF0IGlzIG5vdCBpbmNsdWRlZCBpbiB0aGUgb25lY29y
ZS5kbGwuCgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9z
b2Z0LmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL01ha2VmaWxlLmFtIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9NYWtlZmlsZS5hbSBiL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuYW0KaW5kZXggOTBh
NzMzMmE4Li45NmQxYWIyZjUgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuYW0K
KysrIGIvd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5hbQpAQCAtNjI5LDcgKzYyOSw3IEBAICQoTkVX
X0RMTF9OQU1FKTogJChMRFNDUklQVCkgbGliZGxsLmEgJChWRVJTSU9OX09GSUxFUykgJChMSUJT
RVJWRVIpXAogCSQoTElCU0VSVkVSKSBcCiAJJChuZXdsaWJfYnVpbGQpL2xpYm0uYSBcCiAJJChu
ZXdsaWJfYnVpbGQpL2xpYmMuYSBcCi0JLWxnY2MgLWxrZXJuZWwzMiAtbG50ZGxsIC1XbCwtTWFw
LGN5Z3dpbi5tYXAKKwktbGdjYyAtbHBkaCAtbG50ZGxsIC1sb25lY29yZSAtV2wsLU1hcCxjeWd3
aW4ubWFwCiAJQCQoTUtESVJfUCkgJHt0YXJnZXRfYnVpbGRkaXJ9L3dpbnN1cC90ZXN0c3VpdGUv
dGVzdGluc3QvYmluLwogCSQoQU1fVl9hdCkkKElOU1RBTExfUFJPR1JBTSkgJChORVdfRExMX05B
TUUpICR7dGFyZ2V0X2J1aWxkZGlyfS93aW5zdXAvdGVzdHN1aXRlL3Rlc3RpbnN0L2Jpbi8kKERM
TF9OQU1FKQogCi0tIAoyLjUwLjEudmZzLjAuMAoK

--_002_DB9PR83MB09239F1F48DD7D215E1A0B6E9248ADB9PR83MB0923EURP_--

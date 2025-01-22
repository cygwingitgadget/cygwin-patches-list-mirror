Return-Path: <SRS0=ohbM=UO=microsoft.com=sebhernandez@sourceware.org>
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	by sourceware.org (Postfix) with ESMTPS id 032BD3858D28
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 23:15:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 032BD3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 032BD3858D28
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c110::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1737587713; cv=pass;
	b=EOasnHmBtULuXJL5e2acHFpRdRlq7dOy2UzxmopYzOXSApogMVjNFEhgNbqq6kEG70qXep0kPE+CfN4pid4r3qo55ySKLFMv0vnErbYHoeWmugL1i+GPooSemGr3SHIdMTuYAZjJn3V3kyQrDkE1wsEFl1KSBUaAZePkckjcGhc=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737587713; c=relaxed/simple;
	bh=REbcLgPxZDIUd8zsRqwB9OwAwhskv1i8omzW7gbeo5Y=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=o42pPQUa6KXYZCfcNPS01rt1WJHZmgr2W/llHucjSumDF6M8RkqUFiZIaOt0cWB0A7x5oMgcg0me4fEETf+CZrGFJysss9pYttOWdRUfJuH62AaiU5NSDPr3g039cManISpwkTDx0sAj8w4nyWfz8CFUrMK5USJ3sZ+bo7bq7X4=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 032BD3858D28
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=WIRuMvIk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRUy9s31ndIYQ0S9Veexev/BpIsspUdRRufct4oLpZQzs7dQ4VD4Tr2kbBiCZ1yh2cFfRS9ZPkuGUYtWfFPurRRRci94QNFr17Jmz2ZggeN/etbSCfhBRcGv1P+SDOVoCiC6r4GYITLkq1Tjhoq7gganCb4UjI1T2rq2Dmb6Yb5VBlPGi6YGCTkeULBUS8zKeKnhDhxu7dUEEn9te23azmd5n6AeKB0er+0XeptiUVRyl8N7646CzTlAfodxrRAO/xiMslw9LZ17whL47UoQDzs9lemg6hhqee9lFC7tHQs3Jk3CsZAni6dlV9ViRqIUIDfFmfA8sbABP9nLfV8aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXuK9nmdwrCtl4N07+++H5le4F3CzKYL8Zb3aJuUZ7A=;
 b=dvEWE1VNfXPmRcL6rg1fS5ESLvKhVav3zdeBmbKXpU0F2nB4s0fICxkwdvX+29xcdfZf0d/TWEF5TuohTXRkuTY+pthCogQue3Sqn2iHTTAHfJck7DKrqoHu4h4oRhK8yjAXUN1jv7jlAHk16JsWUL0sDDpOaHWNSZ4gkBWIdaJE7PZr3CAn7cNoLKC/q7Lv0FbfsIcHOCUzjaslMHrGMT4v/soXgUQYPF+ISascoGARHtcQ16wlM7b+w/MUU7/pT/ZXRpIMhTIkg/qhgxycrhzW+W9tCxfu6yfZUVNr9aBzJzvYdGwmSDShDM19RY5xIyjX/gALk5OpXU66kqYf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXuK9nmdwrCtl4N07+++H5le4F3CzKYL8Zb3aJuUZ7A=;
 b=WIRuMvIkil6niwfn3h8xp7+w5LiX9wlkmb9OgBmdKhoCApfNZntY9cCN0ZzSSiCDGw3SfzZXZw9oKEsn8pKqWQbb7mhTkqH9WaMMAQGzkJGuFNC4W2IjF97Ao2u2IpakNr2TUHt0MRsAjigp4e55AuuVUyqtSwjQ0V4DfPNgNqk=
Received: from CY5PR21MB3494.namprd21.prod.outlook.com (2603:10b6:930:d::14)
 by CY5PR21MB3662.namprd21.prod.outlook.com (2603:10b6:930:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.9; Wed, 22 Jan
 2025 23:15:10 +0000
Received: from CY5PR21MB3494.namprd21.prod.outlook.com
 ([fe80::be36:1fc:d542:4a54]) by CY5PR21MB3494.namprd21.prod.outlook.com
 ([fe80::be36:1fc:d542:4a54%5]) with mapi id 15.20.8398.005; Wed, 22 Jan 2025
 23:15:09 +0000
From: Sebastian Hernandez <sebhernandez@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Whitney Schmidt <whschm@microsoft.com>, Veronica Giaudrone
	<Veronica.Giaudrone@microsoft.com>, Johannes Schindelin
	<johasc@microsoft.com>
Subject: [PATCH 1/1] replace undocumented Nt* calls with documented win32 apis
Thread-Topic: [PATCH 1/1] replace undocumented Nt* calls with documented win32
 apis
Thread-Index: AQHbbR4A9QRS8ZZ0wUCyHBD6VqC2Kw==
Date: Wed, 22 Jan 2025 23:15:09 +0000
Message-ID:
 <CY5PR21MB3494C927EFE23AD59F5EB18CD0E12@CY5PR21MB3494.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-22T23:15:09.680Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3494:EE_|CY5PR21MB3662:EE_
x-ms-office365-filtering-correlation-id: ffa2d739-813d-44f8-0cab-08dd3b3a9dcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|8096899003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?H2COMFuo2SNFLYFw0Zy2/PnCKALGjFGorp3CT+gAwkeqbnHMIFuit/hBE1?=
 =?iso-8859-1?Q?tV6GEsxv9YAKMgTV1bD1MPFUnfoO+ZPioH1xjPAZsayhlq0o93XngHUMqp?=
 =?iso-8859-1?Q?GdnS+zh9oiiSnvKiTUmKq+BlP/S3/6cyJqv6+/8c5mmmsIz3BeLxLlPBUW?=
 =?iso-8859-1?Q?5CtJKv3GKV1NgcSNUesofXmgrvkPSHa3w4eMr8kC5ek77iQUB+eS4VOqY0?=
 =?iso-8859-1?Q?tjENpW6IR93NrWmjhaFIqGBjEnUlzCcN9QsiNuMFa1vDdirjejzYCOM+uA?=
 =?iso-8859-1?Q?UnaXh+2B63uWu0ST+ixiyivMUF9xO7XhiI5BC+CPcrFoGuqnIjnTL/tKS2?=
 =?iso-8859-1?Q?rHUoZJi+ZjEEbbd8PIzp5a112rN1k9G5yvzN4uxHImJWunX8GtgXx5nOj7?=
 =?iso-8859-1?Q?oXvl5gB3hWI9h7dQMkznv7w5QZIYf0vYMA1DK5Rmr2aLx+bqYttQSoqZDk?=
 =?iso-8859-1?Q?p4Jag7Mhwn8Vw20TTKN4eUzzthd2Ys/xGdRKR5FFPwcxCpIDbS6KERtWZ8?=
 =?iso-8859-1?Q?nxnI7Kze/DRcc94qaemtJ/Z0e/piOcrVkC2bxIliH1OZAFsmg2SvT31anV?=
 =?iso-8859-1?Q?za8LspiFGhRk7ajWm3+4o2ZlIjnarlmoqUC7VDbmbVx7qh+kEN0WJfE+S/?=
 =?iso-8859-1?Q?6V19TuKC6b598K6VNp317vMy5d9fSbh2vj1UhIc5SgsfFgGjA0OVdIXPI7?=
 =?iso-8859-1?Q?Rk018jsI0NOTLAJlq6CLdA1rg9DHrXYBvAjbNe7e/ZIBwi/io4sbRcmfOg?=
 =?iso-8859-1?Q?oQ6YzwvZ7ZVjOliasADNw9ZxAocxuJzoktHAIr6yiH/HN/tYpxgl3PtOnN?=
 =?iso-8859-1?Q?unCU846BTmZyFbvKvGa9oig5qydKGVByF4uztqBV2sfB8WZRboGOrUAGTZ?=
 =?iso-8859-1?Q?EBRZCwweI6qfDPw+xpbHHqF6eDtWMfyzYFHzxa/o41OCluryW98os1oeUZ?=
 =?iso-8859-1?Q?KJCwp6oJef1gMla6jn+LojPZFvTWYZorWI5XeoEdiPt3KG+EluoZIhHrWp?=
 =?iso-8859-1?Q?j2OXQcF+KvjGJNYzhxicWeTPEfRyebQwwC3/US4Fw4tqOnp6NktXlvkNf3?=
 =?iso-8859-1?Q?u7z2HWtdt0TVRfCNTErw+wQYMt/SvZaRAgb7QLkfB+M2H88F6uNjgUh4fV?=
 =?iso-8859-1?Q?CQGvJ8BXnRc840tG++PDUDrgvnfLDmODLJI+G8hpq+An47CsSYxJ6oBEWC?=
 =?iso-8859-1?Q?epg38/YJQolujwzGDCOx+BcA2BhVHa0EsUkC6S7BNpqmv4VPk6b0R66lct?=
 =?iso-8859-1?Q?zsANw+3sJNVe+wgOFYfu/Gl778rzkei2gU5M6fBJyLwCAvqHwtBRW7sV/R?=
 =?iso-8859-1?Q?xs5VmJTKSheUstuGP8wTr0TCLBAaRNvmeIBEV+QEc8H5RVZmzCMcZK0DH1?=
 =?iso-8859-1?Q?1g/jqhwKgVLSrcIN4X4l5wY9XvX2fIVKgZ71oNV/uqqHLCgGBl9eUnT1Je?=
 =?iso-8859-1?Q?PyH1+hQ4SA5LaB7VvdxV+TEqnn6tA7qxEcrp3k8mo32SAoFFXJm4rfgdq7?=
 =?iso-8859-1?Q?5m0AcVO2VnNqxkzS5Pn2mwuZHw1Q+G6CNUO1GG1HyfDw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3494.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(8096899003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MdMFwyp5w0B1RLMuTuA1JZAGWm04cg2k+tuKU3ktDjF+C0aCjj6ZsXM7SE?=
 =?iso-8859-1?Q?/azAuE71k2Z5Pmny77/+WsW0c2pZo2x18bM6xkWgMGDmQeXe/xSxhfTRtt?=
 =?iso-8859-1?Q?Jv67Vf8NeLHxINbbBoP4qDZZZIYQUWWn4d+WXv2l6jZ90PziHY0sb93auy?=
 =?iso-8859-1?Q?OY3Kh0jf38OLo0uCZ8pKl6j9Do49mIe96oQt4yl0rZ6jYAalG6uPxrj3++?=
 =?iso-8859-1?Q?cZRRrzU9P9nr3bJBmr29m18qYifaZsCI3dGv3NroHtBw3THtJ/utcTL+eb?=
 =?iso-8859-1?Q?WbIo4Lu/zhIkey9+Kte2XQK8pwE2iYjrCvjQLc9x0BVreLw514hfbo+jk/?=
 =?iso-8859-1?Q?nVDUf+KZt0voSz3B0wpAEI7hBPktfA4EUmAvyAOg37tD0tfa/hObfpC0wN?=
 =?iso-8859-1?Q?0bW1HI1uEW+tp0TuTuW7S7MwNV349MdtKck9B2ACZodDW68/KV1y3r7Z9o?=
 =?iso-8859-1?Q?fjPHxwWqLymqukc69b5oIsTZsi5rGM9ImZ4DBFLaFSPLq82CpzaKvsSe+7?=
 =?iso-8859-1?Q?RVtYlOjRIa3mx8O37NabfJcIYKaRfhlTa5lR60rfbdgqHpzeeVItahhBqb?=
 =?iso-8859-1?Q?xr1hzDkxqypUQeURi/ZS5MBu9qLWSu0n4Y58qdO7Wi8Ub9kSqLG8cKuIPx?=
 =?iso-8859-1?Q?NPDX1U25OxBT2WZ2vrtiBRcnuZ4ehiSneFc6SrPpqMbUY8yWYk9MoHDSDY?=
 =?iso-8859-1?Q?CV038ekYjx8OgIxWWk9clZW1KBy9b/kLllYJSpZlNtqxK/5z3g0GoPJB4P?=
 =?iso-8859-1?Q?kww3fCLUpEG7OzShN0YJ02bP0zF0rQY3gQO0XUrFd3499t0uRrU3arQqMT?=
 =?iso-8859-1?Q?5rjYZTgoC1ixy2iLuaP9Xq5NWgVWLX6keOexD5upTqCElh7SknKipaf9Vt?=
 =?iso-8859-1?Q?pgXLUexnNOIF1/In/1FewM6Pu8Q+FfL4/txC619jsXlvbHNFBpzCgd6rvK?=
 =?iso-8859-1?Q?39HpwTC6vCwmRCszRxPzOcc//ldhdT+U+uJjg7nEtrMcdO+rHh1DIc7InV?=
 =?iso-8859-1?Q?IaKv69kbzgxxbvoifdhELqq+CDcitZsWktOXpJriRws5i9wJaakp6sIU30?=
 =?iso-8859-1?Q?t2XA+2U1zrHtjRftUkExYkGLUr6HPZuMzD7VuLHwEjjEec1Q7czw0/Vf7u?=
 =?iso-8859-1?Q?A0yv345X4A+SLQ2gpULVKLD22C3lX9ajIq/JvQq8CoYV5R7eTMXMx0Rz6k?=
 =?iso-8859-1?Q?LRTkKdr5wVhTN2PnlTwfLva3OQizRVvPP4+Bd4k7HaN0akmJ2lJqdNYtC+?=
 =?iso-8859-1?Q?qqHaybD6Mba6YLwt8zmCapSn8p2rNfHUDgSURP+liUr2WJ2myrTjMcfCE3?=
 =?iso-8859-1?Q?fdo5+wnwoOIvU1eN5GLwOPdllU89QU8o5c5N6xep+cOCfOGb7zvbsWcACl?=
 =?iso-8859-1?Q?AjVJ2p05+Nvm06LfqY8n8vERGkTHlpRRPlECo7cxVOj1bdE3xPruBqN8//?=
 =?iso-8859-1?Q?JXbMQbRjWKIw6b2jFodCcfEt38QHT+FesL7B056oHvl3SDkvFSLuLuqFt0?=
 =?iso-8859-1?Q?j5P1HDtgl7DH5ufBAtxw59lSH3SFEHs9N9dH3D80dl9wb/AnDV2RCC3G4i?=
 =?iso-8859-1?Q?B5Rk0pA5FVFElzzEwjPbTxigTS1eiIddNHYVrey/IlHdGoid80i5F/CoIK?=
 =?iso-8859-1?Q?vOEjghhYKDAyvflziDhpSpCm3K5go3dKbf?=
Content-Type: multipart/mixed;
	boundary="_004_CY5PR21MB3494C927EFE23AD59F5EB18CD0E12CY5PR21MB3494namp_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3494.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa2d739-813d-44f8-0cab-08dd3b3a9dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 23:15:09.7402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpqUQInwtFjl8sgbLH54FVDomH5U1qV7FYaIqJevVL5iQ3m4LnYLmjTUYyOqrkBX1fHIwJpRX7JNvNlGBRXr1UtPBGy41OOmEoptU0pWO3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3662
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,URI_TRY_3LD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_CY5PR21MB3494C927EFE23AD59F5EB18CD0E12CY5PR21MB3494namp_
Content-Type: multipart/alternative;
	boundary="_000_CY5PR21MB3494C927EFE23AD59F5EB18CD0E12CY5PR21MB3494namp_"

--_000_CY5PR21MB3494C927EFE23AD59F5EB18CD0E12CY5PR21MB3494namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

Attaching the patch from the separate discussion in cygwin-developers - Re:=
 [Proposed changes/Incoming patch] Undocumented call to ntdll.dll!NtAssignP=
rocessToJobObject in msys2.0.dll / cygwin - included in mingit/Git for Wind=
ows.

The following patch includes the replacement of the following undocumented =
APIs and their documented counterparts.

  *   NtOpenJobObject - OpenJobObjectA<https://learn.microsoft.com/en-us/wi=
ndows/win32/api/winbase/nf-winbase-openjobobjecta>
  *   NtCreateJobObject - CreateJobObjectA<https://learn.microsoft.com/en-u=
s/windows/win32/api/winbase/nf-winbase-createjobobjecta>
  *   NtQueryInformationJobObject - QueryInformationJobObject<https://learn=
.microsoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-queryinformationj=
obobject>
  *   NtSetInformationJobObject - SetInformationJobObject<https://learn.mic=
rosoft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-setinformationjobobje=
ct>
  *
NTAssignProcessToJobObject - AssignProcessToJobObject<https://learn.microso=
ft.com/en-us/windows/win32/api/jobapi2/nf-jobapi2-assignprocesstojobobject>

Please let us know if you have any further questions or feedback regarding =
the changes.

Whitney & Sebastian

P.S.
Unfortunately the use of git send-email was not possible due to firewall is=
sues.

----

=46rom 2cf2176ee8dd35bc4fca8d420533dfb385241d24 Mon Sep 17 00:00:00 2001
From: "Sebastian Hernandez (from Dev Box)" <sebhernandez@microsoft.com>
Date: Wed, 22 Jan 2025 10:20:59 -0800
Subject: [PATCH 1/1] replace undocumented Nt* calls with documented win32 a=
pis

---
 winsup/cygwin/local_includes/ntdll.h |  6 --
 winsup/cygwin/resource.cc            | 93 ++++++++++++++++++----------
 2 files changed, 61 insertions(+), 38 deletions(-)

diff --git a/winsup/cygwin/local_includes/ntdll.h b/winsup/cygwin/local_inc=
ludes/ntdll.h
index 4497fe53f..9f07b37e4 100644
--- a/winsup/cygwin/local_includes/ntdll.h
+++ b/winsup/cygwin/local_includes/ntdll.h
@@ -1451,7 +1451,6 @@ extern "C"
   NTSTATUS NtAdjustPrivilegesToken (HANDLE, BOOLEAN, PTOKEN_PRIVILEGES, UL=
ONG,
                PTOKEN_PRIVILEGES, PULONG);
   NTSTATUS NtAllocateLocallyUniqueId (PLUID);
-  NTSTATUS NtAssignProcessToJobObject (HANDLE, HANDLE);
   NTSTATUS NtCancelTimer (HANDLE, PBOOLEAN);
   NTSTATUS NtClose (HANDLE);
   NTSTATUS NtCommitTransaction (HANDLE, BOOLEAN);
@@ -1461,7 +1460,6 @@ extern "C"
   NTSTATUS NtCreateFile (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES,
          PIO_STATUS_BLOCK, PLARGE_INTEGER, ULONG, ULONG, ULONG,
          ULONG, PVOID, ULONG);
-  NTSTATUS NtCreateJobObject (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES);
   NTSTATUS NtCreateKey (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES, ULONG,
         PUNICODE_STRING, ULONG, PULONG);
   NTSTATUS NtCreateMutant (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES, BOOLE=
AN);
@@ -1498,7 +1496,6 @@ extern "C"
   NTSTATUS NtOpenEvent (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES);
   NTSTATUS NtOpenFile (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES,
             PIO_STATUS_BLOCK, ULONG, ULONG);
-  NTSTATUS NtOpenJobObject (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES);
   NTSTATUS NtOpenKey (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES);
   NTSTATUS NtOpenMutant (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES);
   NTSTATUS NtOpenProcessToken (HANDLE, ACCESS_MASK, PHANDLE);
@@ -1520,8 +1517,6 @@ extern "C"
   NTSTATUS NtQueryEvent (HANDLE, EVENT_INFORMATION_CLASS, PVOID, ULONG, PU=
LONG);
   NTSTATUS NtQueryInformationFile (HANDLE, PIO_STATUS_BLOCK, PVOID, ULONG,
               FILE_INFORMATION_CLASS);
-  NTSTATUS NtQueryInformationJobObject (HANDLE, JOBOBJECTINFOCLASS, PVOID,
-              ULONG, PULONG);
   NTSTATUS NtQueryInformationProcess (HANDLE, PROCESSINFOCLASS, PVOID, ULO=
NG,
                  PULONG);
   NTSTATUS NtQueryInformationThread (HANDLE, THREADINFOCLASS, PVOID, ULONG,
@@ -1555,7 +1550,6 @@ extern "C"
   NTSTATUS NtSetEvent (HANDLE, PULONG);
   NTSTATUS NtSetInformationFile (HANDLE, PIO_STATUS_BLOCK, PVOID, ULONG,
             FILE_INFORMATION_CLASS);
-  NTSTATUS NtSetInformationJobObject (HANDLE, JOBOBJECTINFOCLASS, PVOID, U=
LONG);
   NTSTATUS NtSetInformationThread (HANDLE, THREADINFOCLASS, PVOID, ULONG);
   NTSTATUS NtSetInformationToken (HANDLE, TOKEN_INFORMATION_CLASS, PVOID,
              ULONG);
diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index 5ec436c2c..64c26c14d 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -177,27 +177,43 @@ job_shared_name (PWCHAR buf, LONG num)
 static void
 __get_rlimit_as (struct rlimit *rlp)
 {
-  UNICODE_STRING uname;
   WCHAR jobname[32];
-  OBJECT_ATTRIBUTES attr;
+  char jobnameA[32];
   HANDLE job =3D NULL;
-  NTSTATUS status;
+  BOOL result;
+  DWORD winError;
   JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo;

   if (cygheap->rlim_as_id)
     {
-      RtlInitUnicodeString (&uname,
-            job_shared_name (jobname,
-                   cygheap->rlim_as_id));
-      InitializeObjectAttributes (&attr, &uname, 0,
-             get_session_parent_dir (), NULL);
+      /* Get the wide-character job name from the function */
+      job_shared_name (jobname, cygheap->rlim_as_id);
+
+      /* Convert WCHAR job name to ANSI */
+      if (WideCharToMultiByte (CP_ACP, 0, jobname,
+                               -1, jobnameA, sizeof(jobnameA),
+                               NULL, NULL) =3D=3D 0)
+      {
+          winError =3D GetLastError();
+          __seterrno_from_win_error(winError);
+          return;
+      }
+
       /* May fail, just check NULL job in that case. */
-      NtOpenJobObject (&job, JOB_OBJECT_QUERY, &attr);
+      job =3D OpenJobObjectA (JOB_OBJECT_QUERY,
+                            FALSE,
+                            jobnameA);
+      winError =3D GetLastError ();
+      if (job =3D=3D NULL)
+      {
+        __seterrno_from_win_error (winError);
+        return;
+      }
     }
-  status =3D NtQueryInformationJobObject (job,
-              JobObjectExtendedLimitInformation,
-              &jobinfo, sizeof jobinfo, NULL);
-  if (NT_SUCCESS (status)
+  result =3D QueryInformationJobObject (job,
+          JobObjectExtendedLimitInformation,
+          &jobinfo, sizeof jobinfo, NULL);
+  if (result
       && (jobinfo.BasicLimitInformation.LimitFlags
     & JOB_OBJECT_LIMIT_PROCESS_MEMORY))
     rlp->rlim_cur =3D rlp->rlim_max =3D jobinfo.ProcessMemoryLimit;
@@ -209,11 +225,11 @@ static int
 __set_rlimit_as (unsigned long new_as_limit)
 {
   LONG new_as_id =3D 0;
-  UNICODE_STRING uname;
   WCHAR jobname[32];
-  OBJECT_ATTRIBUTES attr;
-  NTSTATUS status =3D STATUS_SUCCESS;
+  char jobnameA[32];
   HANDLE job =3D NULL;
+  BOOL result =3D 1;
+  DWORD winError =3D 0;
   JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo =3D { 0 };

   /* If we already have a limit, we must not change it because that
@@ -221,33 +237,46 @@ __set_rlimit_as (unsigned long new_as_limit)
      Just try to create another, nested job. */
   while (new_as_id =3D=3D 0)
     new_as_id =3D InterlockedIncrement (&job_serial_number);
-  RtlInitUnicodeString (&uname,
-        job_shared_name (jobname, new_as_id));
-  InitializeObjectAttributes (&attr, &uname, 0,
-              get_session_parent_dir (), NULL);
-  status =3D NtCreateJobObject (&job, JOB_OBJECT_ALL_ACCESS, &attr);
-  if (!NT_SUCCESS (status))
-    {
-      __seterrno_from_nt_status (status);
-      return -1;
-    }
+
+  /* Get the wide-character job name from the function */
+  job_shared_name (jobname, cygheap->rlim_as_id);
+  if (WideCharToMultiByte (CP_ACP, 0, jobname,
+                           -1, jobnameA, sizeof(jobnameA),
+                           NULL, NULL) =3D=3D 0)
+  {
+    winError =3D GetLastError ();
+    __seterrno_from_win_error (winError);
+    return -1;
+  }
+
+  job =3D CreateJobObjectA(NULL, jobnameA);
+  winError =3D GetLastError ();
+  if (job =3D=3D NULL)
+  {
+    __seterrno_from_win_error (winError);
+    return -1;
+  }
+
   jobinfo.BasicLimitInformation.LimitFlags
     =3D JOB_OBJECT_LIMIT_PROCESS_MEMORY;
   /* Per Linux man page, round down to system pagesize. */
   jobinfo.ProcessMemoryLimit
     =3D rounddown (new_as_limit, wincap.allocation_granularity ());
-  status =3D NtSetInformationJobObject (job,
+  result =3D SetInformationJobObject (job,
            JobObjectExtendedLimitInformation,
            &jobinfo, sizeof jobinfo);
   /* If creating the job and setting up the job limits succeeded,
      try to add the process to the job.  This must be the last step,
      otherwise we couldn't remove the job if anything failed. */
-  if (NT_SUCCESS (status))
-    status =3D NtAssignProcessToJobObject (job, NtCurrentProcess ());
+  if (result)
+    {
+      result =3D AssignProcessToJobObject (job, NtCurrentProcess ());
+      winError =3D GetLastError ();
+    }
   NtClose (job);
-  if (!NT_SUCCESS (status))
+  if (!result)
     {
-      __seterrno_from_nt_status (status);
+      __seterrno_from_win_error (winError);
       return -1;
     }
   cygheap->rlim_as_id =3D new_as_id;
@@ -345,4 +374,4 @@ setrlimit (int resource, const struct rlimit *rlp)
   __except (EFAULT)
   __endtry
   return -1;
-}
+}
\ No newline at end of file
--
2.47.1.windows.2






--_000_CY5PR21MB3494C927EFE23AD59F5EB18CD0E12CY5PR21MB3494namp_--

--_004_CY5PR21MB3494C927EFE23AD59F5EB18CD0E12CY5PR21MB3494namp_
Content-Type: application/octet-stream;
	name="0001-replace-undocumented-Nt-calls-with-documented-win32-.patch"
Content-Description:
 0001-replace-undocumented-Nt-calls-with-documented-win32-.patch
Content-Disposition: attachment;
	filename="0001-replace-undocumented-Nt-calls-with-documented-win32-.patch";
	size=7663; creation-date="Wed, 22 Jan 2025 22:55:34 GMT";
	modification-date="Wed, 22 Jan 2025 22:56:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyY2YyMTc2ZWU4ZGQzNWJjNGZjYThkNDIwNTMzZGZiMzg1MjQxZDI0
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiU2ViYXN0aWFuIEhl
cm5hbmRleiAoZnJvbSBEZXYgQm94KSIgPHNlYmhlcm5hbmRlekBtaWNyb3Nv
ZnQuY29tPgpEYXRlOiBXZWQsIDIyIEphbiAyMDI1IDEwOjIwOjU5IC0wODAw
ClN1YmplY3Q6IFtQQVRDSCAxLzFdIHJlcGxhY2UgdW5kb2N1bWVudGVkIE50
KiBjYWxscyB3aXRoIGRvY3VtZW50ZWQgd2luMzIgYXBpcwoKLS0tCiB3aW5z
dXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL250ZGxsLmggfCAgNiAtLQogd2lu
c3VwL2N5Z3dpbi9yZXNvdXJjZS5jYyAgICAgICAgICAgIHwgOTMgKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCA2MSBp
bnNlcnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL250ZGxsLmggYi93aW5zdXAv
Y3lnd2luL2xvY2FsX2luY2x1ZGVzL250ZGxsLmgKaW5kZXggNDQ5N2ZlNTNm
Li45ZjA3YjM3ZTQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxf
aW5jbHVkZXMvbnRkbGwuaAorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2lu
Y2x1ZGVzL250ZGxsLmgKQEAgLTE0NTEsNyArMTQ1MSw2IEBAIGV4dGVybiAi
QyIKICAgTlRTVEFUVVMgTnRBZGp1c3RQcml2aWxlZ2VzVG9rZW4gKEhBTkRM
RSwgQk9PTEVBTiwgUFRPS0VOX1BSSVZJTEVHRVMsIFVMT05HLAogCQkJCSAg
ICBQVE9LRU5fUFJJVklMRUdFUywgUFVMT05HKTsKICAgTlRTVEFUVVMgTnRB
bGxvY2F0ZUxvY2FsbHlVbmlxdWVJZCAoUExVSUQpOwotICBOVFNUQVRVUyBO
dEFzc2lnblByb2Nlc3NUb0pvYk9iamVjdCAoSEFORExFLCBIQU5ETEUpOwog
ICBOVFNUQVRVUyBOdENhbmNlbFRpbWVyIChIQU5ETEUsIFBCT09MRUFOKTsK
ICAgTlRTVEFUVVMgTnRDbG9zZSAoSEFORExFKTsKICAgTlRTVEFUVVMgTnRD
b21taXRUcmFuc2FjdGlvbiAoSEFORExFLCBCT09MRUFOKTsKQEAgLTE0NjEs
NyArMTQ2MCw2IEBAIGV4dGVybiAiQyIKICAgTlRTVEFUVVMgTnRDcmVhdGVG
aWxlIChQSEFORExFLCBBQ0NFU1NfTUFTSywgUE9CSkVDVF9BVFRSSUJVVEVT
LAogCQkJIFBJT19TVEFUVVNfQkxPQ0ssIFBMQVJHRV9JTlRFR0VSLCBVTE9O
RywgVUxPTkcsIFVMT05HLAogCQkJIFVMT05HLCBQVk9JRCwgVUxPTkcpOwot
ICBOVFNUQVRVUyBOdENyZWF0ZUpvYk9iamVjdCAoUEhBTkRMRSwgQUNDRVNT
X01BU0ssIFBPQkpFQ1RfQVRUUklCVVRFUyk7CiAgIE5UU1RBVFVTIE50Q3Jl
YXRlS2V5IChQSEFORExFLCBBQ0NFU1NfTUFTSywgUE9CSkVDVF9BVFRSSUJV
VEVTLCBVTE9ORywKIAkJCVBVTklDT0RFX1NUUklORywgVUxPTkcsIFBVTE9O
Ryk7CiAgIE5UU1RBVFVTIE50Q3JlYXRlTXV0YW50IChQSEFORExFLCBBQ0NF
U1NfTUFTSywgUE9CSkVDVF9BVFRSSUJVVEVTLCBCT09MRUFOKTsKQEAgLTE0
OTgsNyArMTQ5Niw2IEBAIGV4dGVybiAiQyIKICAgTlRTVEFUVVMgTnRPcGVu
RXZlbnQgKFBIQU5ETEUsIEFDQ0VTU19NQVNLLCBQT0JKRUNUX0FUVFJJQlVU
RVMpOwogICBOVFNUQVRVUyBOdE9wZW5GaWxlIChQSEFORExFLCBBQ0NFU1Nf
TUFTSywgUE9CSkVDVF9BVFRSSUJVVEVTLAogCQkgICAgICAgUElPX1NUQVRV
U19CTE9DSywgVUxPTkcsIFVMT05HKTsKLSAgTlRTVEFUVVMgTnRPcGVuSm9i
T2JqZWN0IChQSEFORExFLCBBQ0NFU1NfTUFTSywgUE9CSkVDVF9BVFRSSUJV
VEVTKTsKICAgTlRTVEFUVVMgTnRPcGVuS2V5IChQSEFORExFLCBBQ0NFU1Nf
TUFTSywgUE9CSkVDVF9BVFRSSUJVVEVTKTsKICAgTlRTVEFUVVMgTnRPcGVu
TXV0YW50IChQSEFORExFLCBBQ0NFU1NfTUFTSywgUE9CSkVDVF9BVFRSSUJV
VEVTKTsKICAgTlRTVEFUVVMgTnRPcGVuUHJvY2Vzc1Rva2VuIChIQU5ETEUs
IEFDQ0VTU19NQVNLLCBQSEFORExFKTsKQEAgLTE1MjAsOCArMTUxNyw2IEBA
IGV4dGVybiAiQyIKICAgTlRTVEFUVVMgTnRRdWVyeUV2ZW50IChIQU5ETEUs
IEVWRU5UX0lORk9STUFUSU9OX0NMQVNTLCBQVk9JRCwgVUxPTkcsIFBVTE9O
Ryk7CiAgIE5UU1RBVFVTIE50UXVlcnlJbmZvcm1hdGlvbkZpbGUgKEhBTkRM
RSwgUElPX1NUQVRVU19CTE9DSywgUFZPSUQsIFVMT05HLAogCQkJCSAgIEZJ
TEVfSU5GT1JNQVRJT05fQ0xBU1MpOwotICBOVFNUQVRVUyBOdFF1ZXJ5SW5m
b3JtYXRpb25Kb2JPYmplY3QgKEhBTkRMRSwgSk9CT0JKRUNUSU5GT0NMQVNT
LCBQVk9JRCwKLQkJCQkJVUxPTkcsIFBVTE9ORyk7CiAgIE5UU1RBVFVTIE50
UXVlcnlJbmZvcm1hdGlvblByb2Nlc3MgKEhBTkRMRSwgUFJPQ0VTU0lORk9D
TEFTUywgUFZPSUQsIFVMT05HLAogCQkJCSAgICAgIFBVTE9ORyk7CiAgIE5U
U1RBVFVTIE50UXVlcnlJbmZvcm1hdGlvblRocmVhZCAoSEFORExFLCBUSFJF
QURJTkZPQ0xBU1MsIFBWT0lELCBVTE9ORywKQEAgLTE1NTUsNyArMTU1MCw2
IEBAIGV4dGVybiAiQyIKICAgTlRTVEFUVVMgTnRTZXRFdmVudCAoSEFORExF
LCBQVUxPTkcpOwogICBOVFNUQVRVUyBOdFNldEluZm9ybWF0aW9uRmlsZSAo
SEFORExFLCBQSU9fU1RBVFVTX0JMT0NLLCBQVk9JRCwgVUxPTkcsCiAJCQkJ
IEZJTEVfSU5GT1JNQVRJT05fQ0xBU1MpOwotICBOVFNUQVRVUyBOdFNldElu
Zm9ybWF0aW9uSm9iT2JqZWN0IChIQU5ETEUsIEpPQk9CSkVDVElORk9DTEFT
UywgUFZPSUQsIFVMT05HKTsKICAgTlRTVEFUVVMgTnRTZXRJbmZvcm1hdGlv
blRocmVhZCAoSEFORExFLCBUSFJFQURJTkZPQ0xBU1MsIFBWT0lELCBVTE9O
Ryk7CiAgIE5UU1RBVFVTIE50U2V0SW5mb3JtYXRpb25Ub2tlbiAoSEFORExF
LCBUT0tFTl9JTkZPUk1BVElPTl9DTEFTUywgUFZPSUQsCiAJCQkJICBVTE9O
Ryk7CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3Jlc291cmNlLmNjIGIv
d2luc3VwL2N5Z3dpbi9yZXNvdXJjZS5jYwppbmRleCA1ZWM0MzZjMmMuLjY0
YzI2YzE0ZCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9yZXNvdXJjZS5j
YworKysgYi93aW5zdXAvY3lnd2luL3Jlc291cmNlLmNjCkBAIC0xNzcsMjcg
KzE3Nyw0MyBAQCBqb2Jfc2hhcmVkX25hbWUgKFBXQ0hBUiBidWYsIExPTkcg
bnVtKQogc3RhdGljIHZvaWQKIF9fZ2V0X3JsaW1pdF9hcyAoc3RydWN0IHJs
aW1pdCAqcmxwKQogewotICBVTklDT0RFX1NUUklORyB1bmFtZTsKICAgV0NI
QVIgam9ibmFtZVszMl07Ci0gIE9CSkVDVF9BVFRSSUJVVEVTIGF0dHI7Cisg
IGNoYXIgam9ibmFtZUFbMzJdOwogICBIQU5ETEUgam9iID0gTlVMTDsKLSAg
TlRTVEFUVVMgc3RhdHVzOworICBCT09MIHJlc3VsdDsKKyAgRFdPUkQgd2lu
RXJyb3I7CiAgIEpPQk9CSkVDVF9FWFRFTkRFRF9MSU1JVF9JTkZPUk1BVElP
TiBqb2JpbmZvOwogCiAgIGlmIChjeWdoZWFwLT5ybGltX2FzX2lkKQogICAg
IHsKLSAgICAgIFJ0bEluaXRVbmljb2RlU3RyaW5nICgmdW5hbWUsCi0JCQkg
ICAgam9iX3NoYXJlZF9uYW1lIChqb2JuYW1lLAotCQkJCQkgICAgIGN5Z2hl
YXAtPnJsaW1fYXNfaWQpKTsKLSAgICAgIEluaXRpYWxpemVPYmplY3RBdHRy
aWJ1dGVzICgmYXR0ciwgJnVuYW1lLCAwLAotCQkJCSAgZ2V0X3Nlc3Npb25f
cGFyZW50X2RpciAoKSwgTlVMTCk7CisgICAgICAvKiBHZXQgdGhlIHdpZGUt
Y2hhcmFjdGVyIGpvYiBuYW1lIGZyb20gdGhlIGZ1bmN0aW9uICovCisgICAg
ICBqb2Jfc2hhcmVkX25hbWUgKGpvYm5hbWUsIGN5Z2hlYXAtPnJsaW1fYXNf
aWQpOworCisgICAgICAvKiBDb252ZXJ0IFdDSEFSIGpvYiBuYW1lIHRvIEFO
U0kgKi8KKyAgICAgIGlmIChXaWRlQ2hhclRvTXVsdGlCeXRlIChDUF9BQ1As
IDAsIGpvYm5hbWUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LTEsIGpvYm5hbWVBLCBzaXplb2Yoam9ibmFtZUEpLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwpID09IDApCisgICAgICB7
CisgICAgICAgICAgd2luRXJyb3IgPSBHZXRMYXN0RXJyb3IoKTsKKyAgICAg
ICAgICBfX3NldGVycm5vX2Zyb21fd2luX2Vycm9yKHdpbkVycm9yKTsKKyAg
ICAgICAgICByZXR1cm47CisgICAgICB9CisKICAgICAgIC8qIE1heSBmYWls
LCBqdXN0IGNoZWNrIE5VTEwgam9iIGluIHRoYXQgY2FzZS4gKi8KLSAgICAg
IE50T3BlbkpvYk9iamVjdCAoJmpvYiwgSk9CX09CSkVDVF9RVUVSWSwgJmF0
dHIpOworICAgICAgam9iID0gT3BlbkpvYk9iamVjdEEgKEpPQl9PQkpFQ1Rf
UVVFUlksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgRkFMU0UsCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgam9ibmFtZUEpOworICAgICAg
d2luRXJyb3IgPSBHZXRMYXN0RXJyb3IgKCk7CisgICAgICBpZiAoam9iID09
IE5VTEwpCisgICAgICB7CisgICAgICAgIF9fc2V0ZXJybm9fZnJvbV93aW5f
ZXJyb3IgKHdpbkVycm9yKTsKKyAgICAgICAgcmV0dXJuOworICAgICAgfQog
ICAgIH0KLSAgc3RhdHVzID0gTnRRdWVyeUluZm9ybWF0aW9uSm9iT2JqZWN0
IChqb2IsCi0JCQkgICAgICBKb2JPYmplY3RFeHRlbmRlZExpbWl0SW5mb3Jt
YXRpb24sCi0JCQkgICAgICAmam9iaW5mbywgc2l6ZW9mIGpvYmluZm8sIE5V
TEwpOwotICBpZiAoTlRfU1VDQ0VTUyAoc3RhdHVzKQorICByZXN1bHQgPSBR
dWVyeUluZm9ybWF0aW9uSm9iT2JqZWN0IChqb2IsCisgICAgICAgICAgSm9i
T2JqZWN0RXh0ZW5kZWRMaW1pdEluZm9ybWF0aW9uLAorICAgICAgICAgICZq
b2JpbmZvLCBzaXplb2Ygam9iaW5mbywgTlVMTCk7CisgIGlmIChyZXN1bHQK
ICAgICAgICYmIChqb2JpbmZvLkJhc2ljTGltaXRJbmZvcm1hdGlvbi5MaW1p
dEZsYWdzCiAJICAmIEpPQl9PQkpFQ1RfTElNSVRfUFJPQ0VTU19NRU1PUlkp
KQogICAgIHJscC0+cmxpbV9jdXIgPSBybHAtPnJsaW1fbWF4ID0gam9iaW5m
by5Qcm9jZXNzTWVtb3J5TGltaXQ7CkBAIC0yMDksMTEgKzIyNSwxMSBAQCBz
dGF0aWMgaW50CiBfX3NldF9ybGltaXRfYXMgKHVuc2lnbmVkIGxvbmcgbmV3
X2FzX2xpbWl0KQogewogICBMT05HIG5ld19hc19pZCA9IDA7Ci0gIFVOSUNP
REVfU1RSSU5HIHVuYW1lOwogICBXQ0hBUiBqb2JuYW1lWzMyXTsKLSAgT0JK
RUNUX0FUVFJJQlVURVMgYXR0cjsKLSAgTlRTVEFUVVMgc3RhdHVzID0gU1RB
VFVTX1NVQ0NFU1M7CisgIGNoYXIgam9ibmFtZUFbMzJdOwogICBIQU5ETEUg
am9iID0gTlVMTDsKKyAgQk9PTCByZXN1bHQgPSAxOworICBEV09SRCB3aW5F
cnJvciA9IDA7CiAgIEpPQk9CSkVDVF9FWFRFTkRFRF9MSU1JVF9JTkZPUk1B
VElPTiBqb2JpbmZvID0geyAwIH07CiAKICAgLyogSWYgd2UgYWxyZWFkeSBo
YXZlIGEgbGltaXQsIHdlIG11c3Qgbm90IGNoYW5nZSBpdCBiZWNhdXNlIHRo
YXQKQEAgLTIyMSwzMyArMjM3LDQ2IEBAIF9fc2V0X3JsaW1pdF9hcyAodW5z
aWduZWQgbG9uZyBuZXdfYXNfbGltaXQpCiAgICAgIEp1c3QgdHJ5IHRvIGNy
ZWF0ZSBhbm90aGVyLCBuZXN0ZWQgam9iLiAqLwogICB3aGlsZSAobmV3X2Fz
X2lkID09IDApCiAgICAgbmV3X2FzX2lkID0gSW50ZXJsb2NrZWRJbmNyZW1l
bnQgKCZqb2Jfc2VyaWFsX251bWJlcik7Ci0gIFJ0bEluaXRVbmljb2RlU3Ry
aW5nICgmdW5hbWUsCi0JCQlqb2Jfc2hhcmVkX25hbWUgKGpvYm5hbWUsIG5l
d19hc19pZCkpOwotICBJbml0aWFsaXplT2JqZWN0QXR0cmlidXRlcyAoJmF0
dHIsICZ1bmFtZSwgMCwKLQkJCSAgICAgIGdldF9zZXNzaW9uX3BhcmVudF9k
aXIgKCksIE5VTEwpOwotICBzdGF0dXMgPSBOdENyZWF0ZUpvYk9iamVjdCAo
JmpvYiwgSk9CX09CSkVDVF9BTExfQUNDRVNTLCAmYXR0cik7Ci0gIGlmICgh
TlRfU1VDQ0VTUyAoc3RhdHVzKSkKLSAgICB7Ci0gICAgICBfX3NldGVycm5v
X2Zyb21fbnRfc3RhdHVzIChzdGF0dXMpOwotICAgICAgcmV0dXJuIC0xOwot
ICAgIH0KKyAgCisgIC8qIEdldCB0aGUgd2lkZS1jaGFyYWN0ZXIgam9iIG5h
bWUgZnJvbSB0aGUgZnVuY3Rpb24gKi8KKyAgam9iX3NoYXJlZF9uYW1lIChq
b2JuYW1lLCBjeWdoZWFwLT5ybGltX2FzX2lkKTsKKyAgaWYgKFdpZGVDaGFy
VG9NdWx0aUJ5dGUgKENQX0FDUCwgMCwgam9ibmFtZSwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC0xLCBqb2JuYW1lQSwgc2l6ZW9mKGpvYm5hbWVB
KSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwpID09
IDApCisgIHsKKyAgICB3aW5FcnJvciA9IEdldExhc3RFcnJvciAoKTsKKyAg
ICBfX3NldGVycm5vX2Zyb21fd2luX2Vycm9yICh3aW5FcnJvcik7CisgICAg
cmV0dXJuIC0xOworICB9CisKKyAgam9iID0gQ3JlYXRlSm9iT2JqZWN0QShO
VUxMLCBqb2JuYW1lQSk7CisgIHdpbkVycm9yID0gR2V0TGFzdEVycm9yICgp
OworICBpZiAoam9iID09IE5VTEwpCisgIHsKKyAgICBfX3NldGVycm5vX2Zy
b21fd2luX2Vycm9yICh3aW5FcnJvcik7CisgICAgcmV0dXJuIC0xOworICB9
CisKICAgam9iaW5mby5CYXNpY0xpbWl0SW5mb3JtYXRpb24uTGltaXRGbGFn
cwogICAgID0gSk9CX09CSkVDVF9MSU1JVF9QUk9DRVNTX01FTU9SWTsKICAg
LyogUGVyIExpbnV4IG1hbiBwYWdlLCByb3VuZCBkb3duIHRvIHN5c3RlbSBw
YWdlc2l6ZS4gKi8KICAgam9iaW5mby5Qcm9jZXNzTWVtb3J5TGltaXQKICAg
ICA9IHJvdW5kZG93biAobmV3X2FzX2xpbWl0LCB3aW5jYXAuYWxsb2NhdGlv
bl9ncmFudWxhcml0eSAoKSk7Ci0gIHN0YXR1cyA9IE50U2V0SW5mb3JtYXRp
b25Kb2JPYmplY3QgKGpvYiwKKyAgcmVzdWx0ID0gU2V0SW5mb3JtYXRpb25K
b2JPYmplY3QgKGpvYiwKIAkJCQlKb2JPYmplY3RFeHRlbmRlZExpbWl0SW5m
b3JtYXRpb24sCiAJCQkJJmpvYmluZm8sIHNpemVvZiBqb2JpbmZvKTsKICAg
LyogSWYgY3JlYXRpbmcgdGhlIGpvYiBhbmQgc2V0dGluZyB1cCB0aGUgam9i
IGxpbWl0cyBzdWNjZWVkZWQsCiAgICAgIHRyeSB0byBhZGQgdGhlIHByb2Nl
c3MgdG8gdGhlIGpvYi4gIFRoaXMgbXVzdCBiZSB0aGUgbGFzdCBzdGVwLAog
ICAgICBvdGhlcndpc2Ugd2UgY291bGRuJ3QgcmVtb3ZlIHRoZSBqb2IgaWYg
YW55dGhpbmcgZmFpbGVkLiAqLwotICBpZiAoTlRfU1VDQ0VTUyAoc3RhdHVz
KSkKLSAgICBzdGF0dXMgPSBOdEFzc2lnblByb2Nlc3NUb0pvYk9iamVjdCAo
am9iLCBOdEN1cnJlbnRQcm9jZXNzICgpKTsKKyAgaWYgKHJlc3VsdCkKKyAg
ICB7CisgICAgICByZXN1bHQgPSBBc3NpZ25Qcm9jZXNzVG9Kb2JPYmplY3Qg
KGpvYiwgTnRDdXJyZW50UHJvY2VzcyAoKSk7CisgICAgICB3aW5FcnJvciA9
IEdldExhc3RFcnJvciAoKTsKKyAgICB9CiAgIE50Q2xvc2UgKGpvYik7Ci0g
IGlmICghTlRfU1VDQ0VTUyAoc3RhdHVzKSkKKyAgaWYgKCFyZXN1bHQpCiAg
ICAgewotICAgICAgX19zZXRlcnJub19mcm9tX250X3N0YXR1cyAoc3RhdHVz
KTsKKyAgICAgIF9fc2V0ZXJybm9fZnJvbV93aW5fZXJyb3IgKHdpbkVycm9y
KTsKICAgICAgIHJldHVybiAtMTsKICAgICB9CiAgIGN5Z2hlYXAtPnJsaW1f
YXNfaWQgPSBuZXdfYXNfaWQ7CkBAIC0zNDUsNCArMzc0LDQgQEAgc2V0cmxp
bWl0IChpbnQgcmVzb3VyY2UsIGNvbnN0IHN0cnVjdCBybGltaXQgKnJscCkK
ICAgX19leGNlcHQgKEVGQVVMVCkKICAgX19lbmR0cnkKICAgcmV0dXJuIC0x
OwotfQorfQpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKLS0gCjIuNDcu
MS53aW5kb3dzLjIKCg==

--_004_CY5PR21MB3494C927EFE23AD59F5EB18CD0E12CY5PR21MB3494namp_--

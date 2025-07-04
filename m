Return-Path: <SRS0=s6lY=ZR=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20727.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::727])
	by sourceware.org (Postfix) with ESMTPS id E0DB338515E3
	for <cygwin-patches@cygwin.com>; Fri,  4 Jul 2025 08:04:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E0DB338515E3
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E0DB338515E3
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::727
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751616272; cv=pass;
	b=JLNTOWHaHgQqa6JyU/vpLtx6Rl2aOiyLy4dLGb7a87kbYmOmGr/CKzieA5sqtoCX67VkMacoQvGrxUOs3aGCS1PcWOe8WchANVi56JJ5v4O1oqY/DzhxqMshxZunV0temEYi72o6nZoLFtOcO8W0NqHXDgYC9i3z94VWG6nGYn8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751616272; c=relaxed/simple;
	bh=MwU6Q4JvN5rknzV8jqh9yYidmlYt5JIFHNaWwwvYoys=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=rDteFQDDsSfxv2AMy/NuH56+Qy21zUQ21cRlqvYUebwddd944gkY2Q/AFA6EZ4n57wneVxJi4qxUUx0pMN10JdsVeNkBKimk8b3IUTWEyCSEtFHc7617825+mFD8j6N4/Mj4gP/o43b2LA/vLpPVEeUfFsXp1za8C1prUPrdFNo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E0DB338515E3
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=dDbGEmuG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvHKkv8XCZH+g5gMVJ1LTrmF/E00LN5oC3LcobWJcPYPDQPS9OC0BLw5nE5tTTg7xh3MOAo/gZSQdbD6HNXbfKgsq36Tb48PyZsycUG03lqHB5j9QpWHt9NRJtfXjQ1mjq6uej/o96Fa1M6StV1pFXRuAL3jOYdPp0RHu+ElYf4M+GgEmZ/5vH4vjCpMV+c4U6KusZlQVcP9Cpp+kA51+VAAlyjyIFeRt+uWHQKZS7ubH7NRRETm8E1zVOIfM/lhzyY99nyTum7I9dsQJShS1vszijF9IewHkbnsZZzTRZZ2njPNTB21Fun+3iVHz+uvz2vgD2JMTFZHJOLNhX5i5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kAwlovkLhZ+jltEz8qWO4f7+Foppy9iBz/QYs9F/0A=;
 b=Ln0BX4G57/0WhrkPtCgL332yy9GD1kJ6IWw5Un3aOL3v08/jAaWEzh4QHxFWkbMoLTYaAR1Uaf3B9kHC91Bjm3dIYScN6mJp7kQgOL/HWG+1CSSEohxPF9E1Evb8Z9p3BbAX7CQHRVekuEVCLTZv6aTFSqNW8K5HdWdkfVont+jfUkTnbpFSVJnxnIvHTeG0HOBOiXspRnKVYXTWLTNZcsmlXyRe4IXm4heGBBiXA4kzxMkgqGsC0BcQzFjkCr2CT5Z3UieY8d0aGMAFwjClgVmNqlFdqQAmo6xVbCFcya66vQ49tS3+ak9LKHbgAEWDpVq5W87SzutE2orA/0gDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kAwlovkLhZ+jltEz8qWO4f7+Foppy9iBz/QYs9F/0A=;
 b=dDbGEmuGUyuPQSJQpn8z57AG5/cMwepP56jMBuZSKee39S4tp8XgWtnXmAcAWSWe7ZlAuCKWIjotrZ52k+r8hcqb5VHIoXCZUMv/I1ckzynZSc6znCm70zzI50u+sZaq5DxXUR4gvMOmeCq7CpEdiUZU16FZXqhB0kY3Y8ilwM0=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0794.EURPRD83.prod.outlook.com (2603:10a6:10:588::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.13; Fri, 4 Jul
 2025 08:04:23 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Fri, 4 Jul 2025
 08:04:23 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: gendef: stub implementations of routines for AArch64
Thread-Topic: [PATCH] Cygwin: gendef: stub implementations of routines for
 AArch64
Thread-Index: AQHb7LnT5YzgCfjSSUWM54tqz02ZVQ==
Date: Fri, 4 Jul 2025 08:04:23 +0000
Message-ID:
 <DB9PR83MB0923C9E8CCEA2C6CF37A60739242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-04T08:04:23.012Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0794:EE_
x-ms-office365-filtering-correlation-id: df44fa80-1b25-49ba-cea6-08ddbad16376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?QKT1y95YKVOqYE3cRLaXE5m8/GTJgUcWjt0P3kFz5FQs5gDrHOGGpUMBhG?=
 =?iso-8859-2?Q?k78hsIACnG1y44i8FXVpSKmpT/NNn1yNqtaa1cWQ3F3D01APPHowwsoy/M?=
 =?iso-8859-2?Q?GLSjSvzvS+1PQLDDwzFHXbwhnUarZQpBgfbRiyfrucxGkpLN6vX+MG5mLI?=
 =?iso-8859-2?Q?K8Kzv3XrwkH7rXwX7crwdbyraOHtPs519/ibCp0x5/taP4SOy4qr7ho2HD?=
 =?iso-8859-2?Q?OXzx9n9oP9OfUqo2pLFPKBlMNvuWpPDv12rmGCEsw64JqZ+P4bjTZRwWC/?=
 =?iso-8859-2?Q?Cysd5R4qaajVJE4bRxe+xOGZb+i+A0zWK8lo7iYM9C1nPTEalYYy9nDKCn?=
 =?iso-8859-2?Q?fUm+V+XJ0z6cHgTUOaMaPGdt17w5e7ZKP3k5IE+npDEx37+ZPBXhkFAqNS?=
 =?iso-8859-2?Q?Hp0Scgnii+OBM8E5ISrbxYh8qkpYi5R/DD3o7JDTkh2qA0B8WSksFKlmRb?=
 =?iso-8859-2?Q?LokKyUGlsyOjbGlc53Dv1pTiCjRpapcVpYqCpOWc82n2M+ynfkBpoO+o4a?=
 =?iso-8859-2?Q?lxNW2yBL1aAbdI2QiRjA4JZjnZxtdTy0SnkOtNbicrdRht85sUf3/Da/1d?=
 =?iso-8859-2?Q?yt+ceruqNH27xXLpDW5Y5GpFUPKrGEOsWF/9IyGPwkjSfG8zN36BPmlqPK?=
 =?iso-8859-2?Q?C5yk6E4XIKcc32SE8LLbC04VOn2yYDBTgSdEzuH3brb0xxso0VrtcFiL9i?=
 =?iso-8859-2?Q?lXv7REV78+L4g8BRPWOIkvebhPyFVo4tY59oHCw/3fiIJYwRiv91gzl5ZK?=
 =?iso-8859-2?Q?93BYOO4ucxJVbZpuJ5I8x19Pkb+MQ2BxfDP5ENZQyESWBDY9TbuompGdiL?=
 =?iso-8859-2?Q?MZxFbBvc+AXaF74AaHAhtd2w88m1Fhw+EEJpfuhlxxzBv2eHOJUjsuTHeh?=
 =?iso-8859-2?Q?zgYnodyPDFLFTBKE3h27DQL0ZobVeihL6pLLXP+M4qPXVyOHrocznedZYh?=
 =?iso-8859-2?Q?04Gzr7Ck6JqxLCBye6ssdZlBNhn+tok5nMaar/6CWf/iS4V02LHf+zFNJU?=
 =?iso-8859-2?Q?EjTbQt4V32EBF9uD05lX/BZh7c7kMZ5a5VbB4JNESvRHplSbHhDSLltkUU?=
 =?iso-8859-2?Q?wUTn9vDkYxqZrk3lhbdvaigUZK94jhZBCsL+S1vVm9DnomgcRHUZjriLZs?=
 =?iso-8859-2?Q?eqb4uiPgRPd6s6JQ+/9qsHSJ2UVjJEw6gko851jAzgLEKQoarivZGky62z?=
 =?iso-8859-2?Q?3xx6EZTF5uizdOj/EbIvzWQ4QNRn2XT25ve51icRGeUxM8vMyS7eJH2bpF?=
 =?iso-8859-2?Q?+Z3Kjva7X4YqZXULAPdzG9dYCowUGe3QO+FVr9BwWXLVONBjmCQHF2B0Wz?=
 =?iso-8859-2?Q?bzdtLMHOC6eCgwu7PloIhMmJljdfZOt1VDFBAiSH67yAR3aBKzucvTXrF4?=
 =?iso-8859-2?Q?lls9Rs8kIn/nfgYy8aJC7PwlH3FUVnLPlT8c3K0ILTzfogCPt0sPCdxTim?=
 =?iso-8859-2?Q?AErtSvG4fWyc38Du4zah6niVwE3LiPqbbBWyq9wE+j5FMO2RK8xJGSM5hV?=
 =?iso-8859-2?Q?p18M/kBgEQwFI3j0NBe5ew9QNawrRuiJX1ccB/Fz0ONQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?iu8AZTit17VTRJ8mTF+1n08P65kO2iLAd9V0TZijL5owxdyMHoayiZryPy?=
 =?iso-8859-2?Q?b0x1cL1D/W01rDGFDPV3XZlqPwPF/1WsuzzAlAWlOGqLxvIRyX9y1gwWWY?=
 =?iso-8859-2?Q?0oqPrD59F29OCpvsohjo7EYPQ6lX0bRbRVFvCyzbq1vYXAMVLSMM/JC/r7?=
 =?iso-8859-2?Q?ZfI4RvNbljuBE5wP2X2cMx9KuKLap9IPHXu+sEfgDJzYqoHoT2NSWnDGba?=
 =?iso-8859-2?Q?lQugpGYjB0c+TdoUqMbbrhwU8zU7GgMzX6yLZZNCdRUQ9CcQsG6XeN5q4P?=
 =?iso-8859-2?Q?HB8gfPJiqhj2TaxnKg7NKYkKEBFT4yRBiOj7sio5NRm5Nrg2cirIpjqSRN?=
 =?iso-8859-2?Q?4kyEbuTr2MppJ9/S28ft/o1HVMfwJRhMSnp2VgtV3cnn1IBSaIj2/cIphd?=
 =?iso-8859-2?Q?OVACCY7es5v51tKVeWYXeAz3q7nHPcNzIJuDYpEynrwRGnCq+28xhERM9F?=
 =?iso-8859-2?Q?ZRsolb9EkHSg29fNET4seEkvgmb2eh3q5FQyji48stHH55qaKyCLjXfOWJ?=
 =?iso-8859-2?Q?CLYA9Po7qxifs6vAyicCJQwBT0ykafoqcgzhX+1ufkbjI8Pig886EgYZ/9?=
 =?iso-8859-2?Q?hguFRQ45vsJWT16+cGtYcAgCAfmzHiwvt3RbLFuvVgXAdDJmlsf6V8TMCe?=
 =?iso-8859-2?Q?2eA5gufJhvtUtMCXMHqm+Lscgjc2Lfjf4QGQ3OqogCMWPQBXxWR3KjtDy4?=
 =?iso-8859-2?Q?JdRJmiaTrqjDSts+poexPCUR7zE6KXySzSMg5ukoKiLWlMKnoPH8SPjaXe?=
 =?iso-8859-2?Q?Vl/PzCRv7slCulKYwcSZgXzE51IWbZR9QoGaek1PUTe3FoaujuOKaCROx/?=
 =?iso-8859-2?Q?QRpvkxDjiNe+/kMXNZqfCJygTo+H9OkS323/U7VGkqT3pHFXb/x5RdnyYW?=
 =?iso-8859-2?Q?Ldj6rmplueNDhOG+LYwDlgOCKZXelXaadrvh1EdVR6lolIpTZhaoSrWiIz?=
 =?iso-8859-2?Q?uR5VrED1k9wyxXqGdAgxaEAQeOYES24fqC9ufemVJhL3+7KRX4Any8mR0F?=
 =?iso-8859-2?Q?k05QodJM9sF5ZE4BJ/2+mfz3DWkJdCI4o7FSX3egpLoMV4S0ML29iPP8FG?=
 =?iso-8859-2?Q?0YVVmWJTnknQ0L+DDB+7ie1ApHSZ8EaHP7iswGiRvRdcftfSgL3xt4XMKe?=
 =?iso-8859-2?Q?RCbu3OQWp0FLfj4B73YILwWyo1ZrSQJdadNaPaCoVbw/X3cSDhZx2OjYaa?=
 =?iso-8859-2?Q?rBqf/ntDfw1sg5BualI6Wi0TKUxvtEkK+tR7OUqxN2Xk0aZw1Pn2k9rQGl?=
 =?iso-8859-2?Q?8bzCWY3mtImPjoPF01B2613KlDJWqY12j78AW61gL9EJIgyIfVdcVO/Ljn?=
 =?iso-8859-2?Q?se+T6aXD+sRLb8D3k+8PgEu6ljiyFC7Ah+gRNgLc6GtoXZzIYI4bXmtIdW?=
 =?iso-8859-2?Q?BAcWIh2ZnXgM4j4XdJCet+HklWo/SkusBaqlcvH42lqCVoRRixh/mwsPLP?=
 =?iso-8859-2?Q?l6tlC/mbAXe6Cv8u46xhm3RtYg22uRzghworRHWWsS5Q3itjRLfq6T+Pjb?=
 =?iso-8859-2?Q?21CUs8nqYTPdC/J0VxPv6V1LEEvowDPE12yni6Vy8sniZZu3SQB3S3Gpln?=
 =?iso-8859-2?Q?3gZ8+z+Zb3tTsNnb7WUsq8zfpDC5?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923C9E8CCEA2C6CF37A60739242ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df44fa80-1b25-49ba-cea6-08ddbad16376
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 08:04:23.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sg1iZzVNpje7VhliPyM0pbH6y7KfOCkg06ZQgTBNOrNFQPhydgsNisvedbVD/lqbknnW4ea10VIJ7vhgxlfwJ4LCTFqfryxsBCh6r5oHccc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0794
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923C9E8CCEA2C6CF37A60739242ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch aspires to provide only minimal changes to `winsup/cygwin/script=
s/gendef` allowing to pass the AArch64 build. It does not provide any imple=
mentations of the generated routines.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From b6ca8c585dc63ae12de1d30f8684cdec29b3302b Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Fri, 6 Jun 2025 14:31:30 +0200=0A=
Subject: [PATCH] Cygwin: gendef: stub implementations of routines for AArch=
64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/scripts/gendef | 42 +++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 41 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef=0A=
index 861a2405b..1bd724511 100755=0A=
--- a/winsup/cygwin/scripts/gendef=0A=
+++ b/winsup/cygwin/scripts/gendef=0A=
@@ -21,6 +21,7 @@ if (!defined($cpu) || !defined($output_def)) {=0A=
     die "$0: missing required option\n";=0A=
 }=0A=
 =0A=
+my $is_aarch64 =3D $cpu eq 'aarch64';=0A=
 my $is_x86_64 =3D $cpu eq 'x86_64';=0A=
 # FIXME? Do other (non-32 bit) arches on Windows still use symbol prefixes=
?=0A=
 my $sym_prefix =3D '';=0A=
@@ -89,7 +90,7 @@ sub fefunc {=0A=
     my $func =3D $sym_prefix . shift;=0A=
     my $fe =3D $sym_prefix . shift;=0A=
     my $sigfe_func;=0A=
-    if ($is_x86_64) {=0A=
+    if ($is_x86_64 || $is_aarch64) {=0A=
 	$sigfe_func =3D ($fe =3D~ /^(.*)_${func}$/)[0];=0A=
     }=0A=
     my $extra;=0A=
@@ -109,6 +110,15 @@ $fe:=0A=
 =0A=
 EOF=0A=
     }=0A=
+    # TODO: This is only a stub, it needs to be implemented properly for A=
Arch64.=0A=
+    if ($is_aarch64) {=0A=
+	$res =3D <<EOF;=0A=
+	.extern $func=0A=
+	.global $fe=0A=
+$fe:=0A=
+EOF=0A=
+    }=0A=
+=0A=
     if (!$main::first++) {=0A=
 	if ($is_x86_64) {=0A=
 	  $res =3D <<EOF . longjmp () . $res;=0A=
@@ -338,6 +348,23 @@ stabilize_sig_stack:=0A=
 	popq	%r12=0A=
 	ret=0A=
 	.seh_endproc=0A=
+EOF=0A=
+	}=0A=
+	# TODO: These are only stubs, they need to be implemented properly for AA=
rch64.=0A=
+	if ($is_aarch64) {=0A=
+	  $res =3D <<EOF . longjmp () . $res;=0A=
+	.include "tlsoffsets"=0A=
+	.text=0A=
+=0A=
+_sigfe_maybe:=0A=
+	.global _sigbe=0A=
+_sigfe:=0A=
+_sigbe:=0A=
+	.global	sigdelayed=0A=
+sigdelayed:=0A=
+_sigdelayed_end:=0A=
+	.global _sigdelayed_end=0A=
+stabilize_sig_stack:=0A=
 EOF=0A=
 	}=0A=
     }=0A=
@@ -474,6 +501,19 @@ longjmp:=0A=
 	incl	%eax=0A=
 0:	ret=0A=
 	.seh_endproc=0A=
+EOF=0A=
+    }=0A=
+    if ($is_aarch64) {=0A=
+      	# TODO: These are only stubs, they need to be implemented properly =
for AArch64.=0A=
+      	return <<EOF;=0A=
+	.globl	sigsetjmp=0A=
+sigsetjmp:=0A=
+	.globl  setjmp=0A=
+setjmp:=0A=
+	.globl	siglongjmp=0A=
+siglongjmp:=0A=
+	.globl  longjmp=0A=
+longjmp:=0A=
 EOF=0A=
     }=0A=
 }=0A=
-- =0A=
2.49.0.vfs.0.4=0A=

--_002_DB9PR83MB0923C9E8CCEA2C6CF37A60739242ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-gendef-stub-implementations-of-routines-for-AArch64.patch"
Content-Description:
 0001-Cygwin-gendef-stub-implementations-of-routines-for-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-gendef-stub-implementations-of-routines-for-AArch64.patch";
	size=2330; creation-date="Fri, 04 Jul 2025 08:01:49 GMT";
	modification-date="Fri, 04 Jul 2025 08:01:49 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiNmNhOGM1ODVkYzYzYWUxMmRlMWQzMGY4Njg0Y2RlYzI5YjMzMDJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogRnJpLCA2IEp1biAyMDI1IDE0OjMxOjMwICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW5kZWY6IHN0dWIgaW1wbGVtZW50YXRpb25z
IG9mIHJvdXRpbmVzIGZvciBBQXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTog
dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0
CgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNv
bT4KLS0tCiB3aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmIHwgNDIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYg
Yi93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCmluZGV4IDg2MWEyNDA1Yi4uMWJkNzI0NTEx
IDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCisrKyBiL3dpbnN1cC9j
eWd3aW4vc2NyaXB0cy9nZW5kZWYKQEAgLTIxLDYgKzIxLDcgQEAgaWYgKCFkZWZpbmVkKCRjcHUp
IHx8ICFkZWZpbmVkKCRvdXRwdXRfZGVmKSkgewogICAgIGRpZSAiJDA6IG1pc3NpbmcgcmVxdWly
ZWQgb3B0aW9uXG4iOwogfQogCitteSAkaXNfYWFyY2g2NCA9ICRjcHUgZXEgJ2FhcmNoNjQnOwog
bXkgJGlzX3g4Nl82NCA9ICRjcHUgZXEgJ3g4Nl82NCc7CiAjIEZJWE1FPyBEbyBvdGhlciAobm9u
LTMyIGJpdCkgYXJjaGVzIG9uIFdpbmRvd3Mgc3RpbGwgdXNlIHN5bWJvbCBwcmVmaXhlcz8KIG15
ICRzeW1fcHJlZml4ID0gJyc7CkBAIC04OSw3ICs5MCw3IEBAIHN1YiBmZWZ1bmMgewogICAgIG15
ICRmdW5jID0gJHN5bV9wcmVmaXggLiBzaGlmdDsKICAgICBteSAkZmUgPSAkc3ltX3ByZWZpeCAu
IHNoaWZ0OwogICAgIG15ICRzaWdmZV9mdW5jOwotICAgIGlmICgkaXNfeDg2XzY0KSB7CisgICAg
aWYgKCRpc194ODZfNjQgfHwgJGlzX2FhcmNoNjQpIHsKIAkkc2lnZmVfZnVuYyA9ICgkZmUgPX4g
L14oLiopXyR7ZnVuY30kLylbMF07CiAgICAgfQogICAgIG15ICRleHRyYTsKQEAgLTEwOSw2ICsx
MTAsMTUgQEAgJGZlOgogCiBFT0YKICAgICB9CisgICAgIyBUT0RPOiBUaGlzIGlzIG9ubHkgYSBz
dHViLCBpdCBuZWVkcyB0byBiZSBpbXBsZW1lbnRlZCBwcm9wZXJseSBmb3IgQUFyY2g2NC4KKyAg
ICBpZiAoJGlzX2FhcmNoNjQpIHsKKwkkcmVzID0gPDxFT0Y7CisJLmV4dGVybiAkZnVuYworCS5n
bG9iYWwgJGZlCiskZmU6CitFT0YKKyAgICB9CisKICAgICBpZiAoISRtYWluOjpmaXJzdCsrKSB7
CiAJaWYgKCRpc194ODZfNjQpIHsKIAkgICRyZXMgPSA8PEVPRiAuIGxvbmdqbXAgKCkgLiAkcmVz
OwpAQCAtMzM4LDYgKzM0OCwyMyBAQCBzdGFiaWxpemVfc2lnX3N0YWNrOgogCXBvcHEJJXIxMgog
CXJldAogCS5zZWhfZW5kcHJvYworRU9GCisJfQorCSMgVE9ETzogVGhlc2UgYXJlIG9ubHkgc3R1
YnMsIHRoZXkgbmVlZCB0byBiZSBpbXBsZW1lbnRlZCBwcm9wZXJseSBmb3IgQUFyY2g2NC4KKwlp
ZiAoJGlzX2FhcmNoNjQpIHsKKwkgICRyZXMgPSA8PEVPRiAuIGxvbmdqbXAgKCkgLiAkcmVzOwor
CS5pbmNsdWRlICJ0bHNvZmZzZXRzIgorCS50ZXh0CisKK19zaWdmZV9tYXliZToKKwkuZ2xvYmFs
IF9zaWdiZQorX3NpZ2ZlOgorX3NpZ2JlOgorCS5nbG9iYWwJc2lnZGVsYXllZAorc2lnZGVsYXll
ZDoKK19zaWdkZWxheWVkX2VuZDoKKwkuZ2xvYmFsIF9zaWdkZWxheWVkX2VuZAorc3RhYmlsaXpl
X3NpZ19zdGFjazoKIEVPRgogCX0KICAgICB9CkBAIC00NzQsNiArNTAxLDE5IEBAIGxvbmdqbXA6
CiAJaW5jbAklZWF4CiAwOglyZXQKIAkuc2VoX2VuZHByb2MKK0VPRgorICAgIH0KKyAgICBpZiAo
JGlzX2FhcmNoNjQpIHsKKyAgICAgIAkjIFRPRE86IFRoZXNlIGFyZSBvbmx5IHN0dWJzLCB0aGV5
IG5lZWQgdG8gYmUgaW1wbGVtZW50ZWQgcHJvcGVybHkgZm9yIEFBcmNoNjQuCisgICAgICAJcmV0
dXJuIDw8RU9GOworCS5nbG9ibAlzaWdzZXRqbXAKK3NpZ3NldGptcDoKKwkuZ2xvYmwgIHNldGpt
cAorc2V0am1wOgorCS5nbG9ibAlzaWdsb25nam1wCitzaWdsb25nam1wOgorCS5nbG9ibCAgbG9u
Z2ptcAorbG9uZ2ptcDoKIEVPRgogICAgIH0KIH0KLS0gCjIuNDkuMC52ZnMuMC40Cgo=

--_002_DB9PR83MB0923C9E8CCEA2C6CF37A60739242ADB9PR83MB0923EURP_--

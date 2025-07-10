Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on20710.outbound.protection.outlook.com [IPv6:2a01:111:f403:2608::710])
	by sourceware.org (Postfix) with ESMTPS id 2DA343858CD9
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 10:10:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2DA343858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2DA343858CD9
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2608::710
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752142250; cv=pass;
	b=MdQBrUELhJU02/CcROD/Doi130zntQ8JbWdBCXyvyMdQxINC/wbBkwBF5cfalcp8Fo4qF/dabMdQEAYeQqduhKT9TYtk9KZ02DydH/2+3Wsv+mZurr13Rgr4HbQcb2KI5vzRUgfFqhhdEwFsYjWK2Bheu3F85W5ohUIvSMqbjLs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752142250; c=relaxed/simple;
	bh=AURtBBTtknEZ8iegpDC6sqKjG7X/6dGIRidaAi+YSSc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=dL+scnsud6PkCZ8RLtJeCMxoZT/LqrxZLoIOqVCQPkWC8owG5STPJQpRyhClqP808YN4umPJavKC8eG9ZhwPkXrohO5ksZnP3flNd19ctHyuuhIEVO2IDc9TWSvy9qnHaDrfhkhXXyexiXAe7jFJ6C/FGysK27dzzy099eWYzf8=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2DA343858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=EiueUHht
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEOGv4TAs4M0r6k2HDpNGa4VfN48i5SrRS+bBch/A1SostJcbxwkuhyShL5+zrv4oO4wzpNSfWX6tHZDlylu4UGjbrkW1jd0WIHTRC7hMfEfj6E4rqXtSFqAnEP22NODytxUp9u8t+PwRSVSvDT4acznCA+qsXKxcgVYiyeT7sjx+VItrYu0YpKoHVzS977UGo8jZGbUESp1b1Bo4WlRF7glc2Gbv/SXwaBDvON9Z9cGXJ11JSdW3M8LqdYo+e4+mmEFQF2kReiDS39L6bUSKFDcnBrIVYOSnceUPsxKOpZw/obs2zL0oRL+xyJoqtgQAie+jnWcXeAp1Zbr1bUypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InDs0l8lWza8Db5M2sh3JbJgfqJRMc1C5lvSXc3PT58=;
 b=tN135cYpjqXDJegOhF+67rtCmDK80iGDMO3Wc9LQeJxzOTmPCXKea77eRSIvGkymBhVgKzYUA7nko94t96t4oQ7A5AHCtD/Q+qRCywWoXSTLF6gORSv/5E1Tjdu+Clz0adXOO80Qavm2TTA/SjpnPBUftHvg1T1cVrzRoMFzHLc49hu6GEthEH1nJ0sICseN5YO2akFHEpfSnVQS80jUY+2ffiuwkQBDaTZMS3MZxlP+x/fbAcgtJhWyIs69IxRGPSUGylssJroE/ZWXfRrdjpmGp9JEnbhDm0KvBvu991EucRAts9wUK1w/GG+terPe7OGtwCNX2fon38hFTbCWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InDs0l8lWza8Db5M2sh3JbJgfqJRMc1C5lvSXc3PT58=;
 b=EiueUHhtb5tUO+poThlrDeHozEcbUbV84o2pN0oaFjps6PVeaOONUauMha1vpLXgKNE0wFwdNzlAhVjPAydgr3/xgiD3qm8oPhYQPLFEJ5WidpbVgqXzF2jb9WFtKHtKXvzFsCm9I40ZNOKjlu9XKJ/KW47r6PceEd2h1+qKH+0=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DBBPR83MB0564.EURPRD83.prod.outlook.com (2603:10a6:10:533::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.8; Thu, 10 Jul
 2025 10:10:47 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 10:10:47 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Radek Barton
	<radek.barton@microsoft.com>
Subject: [PATCH v2] Cygwin: cygcheck: port to AArch64
Thread-Topic: [PATCH v2] Cygwin: cygcheck: port to AArch64
Thread-Index: AQHb8YLnIvVq4bMax0qTxMOG1R8PUA==
Date: Thu, 10 Jul 2025 10:10:47 +0000
Message-ID:
 <DB9PR83MB09232BEB586BCF0576FD69CD9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB09236B2289D6307E787D64FC9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB09236B2289D6307E787D64FC9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T10:10:44.798Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DBBPR83MB0564:EE_
x-ms-office365-filtering-correlation-id: acc0adba-067e-4f2e-d479-08ddbf9a0a0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?3AgsNUMW2R1PW08fWeCTdSpxBv66XM2unzGcprFAgQkJntIp/fGHTKV+Z/?=
 =?iso-8859-2?Q?ph+FMmIjYEixl2rDbh2it3flvEq2X7RrW24/iKaLXo5vMdftGq1c+MUrPo?=
 =?iso-8859-2?Q?qn3BWwbD6IDDTJwGYixEUSEtY8LS8XxaHjxb8GqKBxSpbyhMpHqGIKRl90?=
 =?iso-8859-2?Q?TU1WEpWzgNKMvXUtwNjwm9s3jvREucODDzGk81cxgA5lx46qEEErxgCghq?=
 =?iso-8859-2?Q?fVIk6HHBTjRIFPyNUQXcQiqXd7UWKPs2ZB18BM5+5TM1yJVueo4BBQVKOd?=
 =?iso-8859-2?Q?Te/uEz9T/QYTToVdpGUg93d7pMy81WrC2M9UZhN1NaC3mTzIUDV9C+B89h?=
 =?iso-8859-2?Q?TF4mmeqdNYX3xgKcw5O9oeibzvmcoqcoJjOnD5HpIo+XlYxOVYfUU+EzCf?=
 =?iso-8859-2?Q?7wwpS0IChGxMy1M8rVPQ8FvXfEvM5uaO341ABtCo+VlYm85Y2fciEjdP9A?=
 =?iso-8859-2?Q?+DGgMNTIDwFbTrbMQNx2Y8Y1nvBNnsTC9HFp0+vCK4rSLuA5nSUqdxCEY8?=
 =?iso-8859-2?Q?E/dPwOSHKppcfAXhhT2vThKhK5o3AZXd1JXgcVsvjRg2ly2tgewkQOOdL3?=
 =?iso-8859-2?Q?qD8R+ExML73B2lS0KnqGADuxtsAGvd9jNWPAMgCOps2MfY1RTkyRagolNT?=
 =?iso-8859-2?Q?yfKREK0VDBMS6mtCp0vNQ9C8QgwosowLprcZczFy/H6wUvosg5jGAbinOk?=
 =?iso-8859-2?Q?rQNmtEu0TPCYJUV6t2+TtDOq2PURzZaidwp+ysvLw6Jhg2T+JjqzSuMGp7?=
 =?iso-8859-2?Q?ePHtMAZh62NbnZys4Y+0NUS85ikegns/rlxGfP/ACB918RjnFXMIu1P4Th?=
 =?iso-8859-2?Q?mc2yG3yrGPTudHW8LBztHprfMnjA4eP4vGIjC7LtXEQWEowTk/s5w13mwn?=
 =?iso-8859-2?Q?rulrZnpygux0zuIaDVW60lgDwwUiE+Er1qRaUcgtF8/IiljZjbke5J4tFz?=
 =?iso-8859-2?Q?XZL2rlWJCYGwYJvtAq5R4Za05hmXo/NDaCoStSIJR+lMGSPHpsBShXnnca?=
 =?iso-8859-2?Q?/y6ld/76HF4ERm4GMy/6FJrxWdPVnvSbyszaODYCHgW/Ph4kgcsMYmsJOV?=
 =?iso-8859-2?Q?ep49y00bthXx4m4ksSgS4Xa4w+mM2lGVOzrTVM/PdayLkXdaymfK9VXEvj?=
 =?iso-8859-2?Q?vj1GfSkFQIU4ImqUi3qsf6HMK7vNTyW+2yYngvu9zAFr7g66SxTBqao3By?=
 =?iso-8859-2?Q?bntp0tLm4/XZGDBWGJsOxlvUpW2wD2dEPXFfhsRLsIZJ8hDG2k5Y5nCm3o?=
 =?iso-8859-2?Q?BuSmWteGNbRAND95MSMjpF+sV6sgwZNikM9iIK7z36a5Cs1P5QSs2i+DRc?=
 =?iso-8859-2?Q?+V/WfLNMX3nLIKpn/AlIUDlBHcdLKgWY/7IP4iHenn61uX5SPXMtljF76W?=
 =?iso-8859-2?Q?f9Su9qY7Xhm3GdMA6R0LMHvXZah1mLS2gJcwKevmHslDqfrAbMPvuCDzFn?=
 =?iso-8859-2?Q?+aFSDIXi01zhcyw/wkGynmFizaKy32HxPmgmqnVQad3DmFAuZqE7i4MPev?=
 =?iso-8859-2?Q?s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?kQL46UZQJVcdtY6m2HbJu001BLFcW6UReMTCzK1V3lQRdVUJmZYM7WRrqX?=
 =?iso-8859-2?Q?rpsunt+rFtl4h3NtQaEklyeIJzNJkAQD59l+Noyw08QRrZ0BHV5zfq+vlG?=
 =?iso-8859-2?Q?OhVpebRhwjDvQLDe4U2W2EnMVOi8wZrrsGuG4z9hNjNyTupMJMXhdEjMZE?=
 =?iso-8859-2?Q?6NTWpPNGItNxHEVqdFkJEzlJQOC6fCMZP9Iml60MtpT+Cutr//iEZR8hR+?=
 =?iso-8859-2?Q?VJ+73NI/HCvVapGhFYjmwpaG28IUpSnRM6ooIXI52n6aoHLw92+j94GvJ6?=
 =?iso-8859-2?Q?3YxNh0g1rgRJ8/mqcA3f292q4Hd+Z1FCalCWIr9QByxkFEjxEJhLQGOs1m?=
 =?iso-8859-2?Q?0XgBQmw4JidJ8lYYWvSjFKIn8xS1nwCA7lw2A+t5yNMo+PwrOIzIoaBBMy?=
 =?iso-8859-2?Q?y4M1UeyyjVxPGtZxIpFMMfefhqldS4keIkyWRjxZMxuiGFRS0DurITx/w6?=
 =?iso-8859-2?Q?pt/PpYbKB+8AF2PDUvDbbGtwJY7pMdSOgKCjerwOm2t1E16TxCklrVJa1u?=
 =?iso-8859-2?Q?CmqPJGrYswl3KdGUsFI3fYGGjbvQUNVoeuZVEoLZMdTGh3vLgu/TTvVcCQ?=
 =?iso-8859-2?Q?+V9MVux/N7lHvIQH/nZTqxfDD/RVhImLtRIjMbtZSxwx8ZBa+cjU+v6qRw?=
 =?iso-8859-2?Q?vePcX7NcJZdCi9pNP4mS6iE5q/vt3MIglxXtepxJxh0tRIQ1Y9gg2Egvb/?=
 =?iso-8859-2?Q?hBt0uNaW96dJ3n8QLPFLjV6hhAKNYp0ujxt5xRVVRIWwof+55qCtryahYA?=
 =?iso-8859-2?Q?Uq55CvTMljVtcqjIA1GhZ11JYzegz+KibJOlQHMOAIXTCbwUum9Jzv2mRx?=
 =?iso-8859-2?Q?Agyfhdt1fP3dxL3lIDMqYmt6krj3XRHlsshkqxwaivAbOgd73Vzjjbi71N?=
 =?iso-8859-2?Q?2r36KyENwSUt9Y/0OgrwKfVt0mYTzgDLzsAwsEnKG2qKwe8trEn7Rwaxtt?=
 =?iso-8859-2?Q?nll0s4g0yYO1RZUC8jZnHctMWWEssmdXjsSw9jeO7memf9KsSVGapySzSz?=
 =?iso-8859-2?Q?R2Q3Q40roCxuPaVOVHZCQeeCmRldIQFejWRhIqJT1j2sCjWbjY0w92AIKt?=
 =?iso-8859-2?Q?q8+0W8Zq7M5A5i39OPi1BSjQlie75xvh1+CcN/CYLfCRbP45wqvtNmDNLl?=
 =?iso-8859-2?Q?Sh79q3xPkKbwDFEfrRnEe68ZSR03eYDbuesNO1YRp9KIw6rwZJigxEfXE/?=
 =?iso-8859-2?Q?XAds8833r1AspJA3Gimg+QLlJgLV4F1j7EEFk5GCWku7FQPOHcpMPzdhgs?=
 =?iso-8859-2?Q?4uvaPL2UAoOR0QtzAR9xPfbFvGdl58boO7zParGCX/TGo3zeX3K4y6t9D3?=
 =?iso-8859-2?Q?+ofSRHLVtaOHvnf6e+3k4OtICH9BDeMOhwC7iAt04zOb9Km/TPZyIyOaAK?=
 =?iso-8859-2?Q?uUVDo1Bujiwx4+Nt6D0tkiWYa6qGsgTGQPSgkJYnKLEarUADVUKnyD32FZ?=
 =?iso-8859-2?Q?Hgc8dFHdO3o4oQuUu/JLItxRRKodMDvDrZ8T/y6E4kBUIIaQApmyWNxFG5?=
 =?iso-8859-2?Q?UyWWIg2Ar/lT36b5M0sY6km91izQgL1qIj2MUsDfcvkI+umTZYEkEKvzhY?=
 =?iso-8859-2?Q?BPa3qFU+hsy+h7nzcod4KyHZg3fv?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09232BEB586BCF0576FD69CD9248ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc0adba-067e-4f2e-d479-08ddbf9a0a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 10:10:47.0505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8zW7In3W6bBipqFIfRSXa5ktSMGsaX0OoaPLesK6eQXKT4pQHy5t9X2so2Q8QYUYeM9yzkznMDvlDlUEa/S9c2N4yAerVz8jdxpNduI2MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR83MB0564
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09232BEB586BCF0576FD69CD9248ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending the same patch with more detailed commit message added.=0A=
=0A=
Radek=0A=
---=0A=
From ebec7171c9fdf162e0d193f7ba3468766191cc8d Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Mon, 9 Jun 2025 13:08:35 +0200=0A=
Subject: [PATCH v2] Cygwin: cygcheck: port to AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch ports `winsup/utils/mingw/cygcheck.cc` to AArch64:=0A=
 - Adds arch=3Daarch64 to packages API URL.=0A=
 - Ports dll_info function.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/utils/mingw/cygcheck.cc | 13 +++++++++++--=0A=
 1 file changed, 11 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.c=
c=0A=
index 89a08e560..6ec7bcf03 100644=0A=
--- a/winsup/utils/mingw/cygcheck.cc=0A=
+++ b/winsup/utils/mingw/cygcheck.cc=0A=
@@ -654,13 +654,20 @@ dll_info (const char *path, HANDLE fh, int lvl, int r=
ecurse)=0A=
   WORD arch =3D get_word (fh, pe_header_offset + 4);=0A=
   if (GetLastError () !=3D NO_ERROR)=0A=
     display_error ("get_word");=0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
   if (arch !=3D IMAGE_FILE_MACHINE_AMD64)=0A=
     {=0A=
       puts (verbose ? " (not x86_64 dll)" : "\n");=0A=
       return;=0A=
     }=0A=
   int base_off =3D 108;=0A=
+#elif defined (__aarch64__)=0A=
+  if (arch !=3D IMAGE_FILE_MACHINE_ARM64)=0A=
+    {=0A=
+      puts (verbose ? " (not aarch64 dll)" : "\n");=0A=
+      return;=0A=
+    }=0A=
+  int base_off =3D 112;=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
@@ -2108,8 +2115,10 @@ static const char safe_chars[] =3D "$-_.!*'(),";=0A=
 static const char grep_base_url[] =3D=0A=
 	"http://cygwin.com/cgi-bin2/package-grep.cgi?text=3D1&grep=3D";=0A=
 =0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
 #define ARCH_STR  "&arch=3Dx86_64"=0A=
+#elif defined(__aarch64__)=0A=
+#define ARCH_STR  "&arch=3Daarch64"=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
-- =0A=
2.50.1.vfs.0.0=0A=

--_002_DB9PR83MB09232BEB586BCF0576FD69CD9248ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-cygcheck-port-to-AArch64.patch"
Content-Description: v2-0001-Cygwin-cygcheck-port-to-AArch64.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-cygcheck-port-to-AArch64.patch"; size=1808;
	creation-date="Thu, 10 Jul 2025 10:10:16 GMT";
	modification-date="Thu, 10 Jul 2025 10:10:16 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlYmVjNzE3MWM5ZmRmMTYyZTBkMTkzZjdiYTM0Njg3NjYxOTFjYzhkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCA5IEp1biAyMDI1IDEzOjA4OjM1ICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQ3lnd2luOiBjeWdjaGVjazogcG9ydCB0byBBQXJjaDY0
Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYt
OApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpUaGlzIHBhdGNoIHBvcnRzIGB3aW5z
dXAvdXRpbHMvbWluZ3cvY3lnY2hlY2suY2NgIHRvIEFBcmNoNjQ6CiAtIEFkZHMgYXJjaD1hYXJj
aDY0IHRvIHBhY2thZ2VzIEFQSSBVUkwuCiAtIFBvcnRzIGRsbF9pbmZvIGZ1bmN0aW9uLgoKU2ln
bmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+Ci0t
LQogd2luc3VwL3V0aWxzL21pbmd3L2N5Z2NoZWNrLmNjIHwgMTMgKysrKysrKysrKystLQogMSBm
aWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvd2luc3VwL3V0aWxzL21pbmd3L2N5Z2NoZWNrLmNjIGIvd2luc3VwL3V0aWxzL21pbmd3L2N5
Z2NoZWNrLmNjCmluZGV4IDg5YTA4ZTU2MC4uNmVjN2JjZjAzIDEwMDY0NAotLS0gYS93aW5zdXAv
dXRpbHMvbWluZ3cvY3lnY2hlY2suY2MKKysrIGIvd2luc3VwL3V0aWxzL21pbmd3L2N5Z2NoZWNr
LmNjCkBAIC02NTQsMTMgKzY1NCwyMCBAQCBkbGxfaW5mbyAoY29uc3QgY2hhciAqcGF0aCwgSEFO
RExFIGZoLCBpbnQgbHZsLCBpbnQgcmVjdXJzZSkKICAgV09SRCBhcmNoID0gZ2V0X3dvcmQgKGZo
LCBwZV9oZWFkZXJfb2Zmc2V0ICsgNCk7CiAgIGlmIChHZXRMYXN0RXJyb3IgKCkgIT0gTk9fRVJS
T1IpCiAgICAgZGlzcGxheV9lcnJvciAoImdldF93b3JkIik7Ci0jaWZkZWYgX194ODZfNjRfXwor
I2lmIGRlZmluZWQoX194ODZfNjRfXykKICAgaWYgKGFyY2ggIT0gSU1BR0VfRklMRV9NQUNISU5F
X0FNRDY0KQogICAgIHsKICAgICAgIHB1dHMgKHZlcmJvc2UgPyAiIChub3QgeDg2XzY0IGRsbCki
IDogIlxuIik7CiAgICAgICByZXR1cm47CiAgICAgfQogICBpbnQgYmFzZV9vZmYgPSAxMDg7Cisj
ZWxpZiBkZWZpbmVkIChfX2FhcmNoNjRfXykKKyAgaWYgKGFyY2ggIT0gSU1BR0VfRklMRV9NQUNI
SU5FX0FSTTY0KQorICAgIHsKKyAgICAgIHB1dHMgKHZlcmJvc2UgPyAiIChub3QgYWFyY2g2NCBk
bGwpIiA6ICJcbiIpOworICAgICAgcmV0dXJuOworICAgIH0KKyAgaW50IGJhc2Vfb2ZmID0gMTEy
OwogI2Vsc2UKICNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCkBA
IC0yMTA4LDggKzIxMTUsMTAgQEAgc3RhdGljIGNvbnN0IGNoYXIgc2FmZV9jaGFyc1tdID0gIiQt
Xy4hKicoKSwiOwogc3RhdGljIGNvbnN0IGNoYXIgZ3JlcF9iYXNlX3VybFtdID0KIAkiaHR0cDov
L2N5Z3dpbi5jb20vY2dpLWJpbjIvcGFja2FnZS1ncmVwLmNnaT90ZXh0PTEmZ3JlcD0iOwogCi0j
aWZkZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKICNkZWZpbmUgQVJDSF9T
VFIgICImYXJjaD14ODZfNjQiCisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorI2RlZmluZSBB
UkNIX1NUUiAgIiZhcmNoPWFhcmNoNjQiCiAjZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9y
IHRoaXMgdGFyZ2V0CiAjZW5kaWYKLS0gCjIuNTAuMS52ZnMuMC4wCgo=

--_002_DB9PR83MB09232BEB586BCF0576FD69CD9248ADB9PR83MB0923EURP_--

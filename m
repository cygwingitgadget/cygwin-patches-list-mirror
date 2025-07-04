Return-Path: <SRS0=s6lY=ZR=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20731.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::731])
	by sourceware.org (Postfix) with ESMTPS id 3C7823858C56
	for <cygwin-patches@cygwin.com>; Fri,  4 Jul 2025 07:16:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3C7823858C56
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3C7823858C56
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::731
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751613413; cv=pass;
	b=bg5pcFCZs4UEBI99cDe2N6W0Y/Wq3pNjY9f5M7aoSzRg2Bn8zylyd1vLTxS8vUDrhgLS+uQUMuwnR6LoN8mSVGuT8RdYtdJuzONchofGqvUdXgittqIfydD79M4kAHnnErwXwk3yF218RIM5yF0eKX5o8uhnxgmyGBpci5BGiEk=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751613413; c=relaxed/simple;
	bh=jIkMwtZxnpZ516srIALAN9MMsYTYupohyR0At/qSasw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=eC788prkBK4IFB8i1KhjMFspMOCTCJ0D6IR0OSen5dSU6sM3oUB3WfvW+ygo56UTD/lKWccGv+SibCR5okNfka0LGuO82PLlWR9s2zQaJz6dTlAIrYksfLejYd4sMJv8rDLwNi3YbrILrLec1qmse4fDYYqj1KeuhgthuspZbeA=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3C7823858C56
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=CF4YJsrR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzhNrvXVqqe+jxdE/cPxLIjgPtodYEJC3oKOikI8YpL9nqVF39RohQPTqlN4BVlmgM1tNCeAeVetKZDQtk2qnXhiaDppTVmWHPbcwwPeXe6L+GoCU9sIfI0lK7WOAZmsDWk8Oi57SNqj2wBecQoXaOp7VvN2FE+kqK9veMBkx7zzsKNtCbBj4+9sy540+JTJATaGru3pYo29PxoNV1dY5eKAszsr+6BW1tPxqLiWLf8Vug1DVwxHn5F3Fi0BDHFyNscNTjdta2e5KRQQpQKfEWMfk0ectiyNdZB9wvoPpYxSzg0x89oEB1VMJtV3ketJYrxqPucXUEVKCysTsjEqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTwSKjg0u18D2ckM6r3x8N2jEy2WwdQJqlD2c51btX8=;
 b=J2R9cRXeB6vjqPPgROdNIeprOjdC5Gu2mOY+DAd2OVbtuQIeMq+ueU9/BlzBG8oLFrxl8W/HYMu9kRzRFA7Iw4AVhC4V1k36euErPR181v1oIfxM8bmlJeWs9SFboxrEEPrRh4b8v+r9kGBpkFxvcJEX9gnw6TlyFb0SqyCNHCHXiGZ9pbAJDxUVKlrKLPUt+mzbKkN+gzTxW51Sg4RR/NO72GSFPDHP6diC4DtcZF6HjKB6AueWb5I3h7OMIRKQkNO3xaF8xoHU5e1d18L6PL6gL3e0cnJerx3J3wsFxq2FrSgLW7lCWK1WYg6sL553vHaYS7VevQsLn347RNek3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTwSKjg0u18D2ckM6r3x8N2jEy2WwdQJqlD2c51btX8=;
 b=CF4YJsrRXO5COOjPb+hfN09CNeKilUbh8ztZ09rYL2GBAOIoqmglCwRgkqQImZIbyYUiujcoxHrS8A5Y8hRKbAH6Tg1rNCT/PmV8x0iic5iqnU8N3J8+IAmpi1P8sagVLDj72ahG49QdxmNk6b0Vr1gtNjwb7sTNpmgNXhl8V2s=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA1PR83MB0799.EURPRD83.prod.outlook.com (2603:10a6:102:492::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 07:16:49 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Fri, 4 Jul 2025
 07:16:49 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: cygcheck: port to AArch64
Thread-Topic: [PATCH] Cygwin: cygcheck: port to AArch64
Thread-Index: AQHb7LN1Z4q2uIZh80iIAaXe43berA==
Date: Fri, 4 Jul 2025 07:16:49 +0000
Message-ID:
 <DB9PR83MB09236B2289D6307E787D64FC9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-04T07:16:48.516Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA1PR83MB0799:EE_
x-ms-office365-filtering-correlation-id: 9a9f5a9d-3bf2-4802-83e1-08ddbacabe08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?XJ+3lPv2Ntrr5QI+yCfdFWEBVl+O1Q3df3iocLWLmtI/epUJ8iPbjkcrHl?=
 =?iso-8859-2?Q?21aW/rr19equjIqDpF+9vF0Jk85xkv6i7c9HpSBMPUzlikXUJCpdwpYlkp?=
 =?iso-8859-2?Q?iW1q+WF8L1k1LnHaVsxI0J2+G8YMFY6Ie1w0FwXGuFI2BTTheFm4waHM0Z?=
 =?iso-8859-2?Q?M5Rx+wef2zHlA+zbghXQVGXa0+l6entD0fffNyt7e2XLBxURvFbP+I9m9w?=
 =?iso-8859-2?Q?wxcJVlJx9gIaF/VTuyx3aBydOUHnnCe3NBkBuNjH3wWXJE+FDUfsjHqBtA?=
 =?iso-8859-2?Q?F0GaFQbwcD2FRFeHnPRAgk9qZKCCYPLr438u84bxP666qh4vav/VTcvOYv?=
 =?iso-8859-2?Q?1seW/avbOLMoBsBypSy14QM5fm+kf2DPa7ywXgsChIGi/tTIsMhZ2TPsF3?=
 =?iso-8859-2?Q?Ttkyy8cS5uc8URxAm6HuS3JNwT+HXTQT8jAXH+XJOSrRg7tkt2bwlFFljO?=
 =?iso-8859-2?Q?HNJdgUuV+j64PoRG+5ilh+WspmGxnfTNOIOWCO9mky7mu7pyCEaC/dO5wE?=
 =?iso-8859-2?Q?KvOCuNUi3GRJ3n5X4KWQ7BTqSavrEAD4xb1AThZcHzhOdJ+3nUHutCPSqt?=
 =?iso-8859-2?Q?lbOkeESDuTZ/fxjrYanidZDJckU9GQB72KwvLdKT9LBJVZGkFdXkgAXZ7F?=
 =?iso-8859-2?Q?pyZQIVScWDNDak/K/BsoErnYBllqzrKGBQ/Kp6ZaeDK34+QU8yW5PShT+m?=
 =?iso-8859-2?Q?2IhWxHsBixowH4z6hTVtgBhR92aDFVB2DX5QNo2fPRjzSiDl9VS/ZUcoTv?=
 =?iso-8859-2?Q?2eF5IxzEaF48rkKyCHft0PbqhlVYiJBncbHeD4QymK6dotYHVw55CyzYfk?=
 =?iso-8859-2?Q?EEUojuKq+7a3qPY8KCFXGahcFXPCbXXxYkoef9CRjMKWrOGb5g/GefO8WE?=
 =?iso-8859-2?Q?fNEEmc75DKxN15pBZbfsgz91n8hhMOiLGh9NBUplqQeJffpFjiqclZozq1?=
 =?iso-8859-2?Q?eRTBVVH/9r5nDfm/x26tzIEifShKfpe50ORI06wgfrO6ZYXX47bGEQLW2/?=
 =?iso-8859-2?Q?5LwQwl53qPkZzHQ4UeEQB7qB5oT4sXFPAGtAKD26z9PsX9zueUq8iELd24?=
 =?iso-8859-2?Q?jnDmwgZlIm2ozabS+GDqwer70RBuLW7/YIaGT7ikXmF5NTWrxuSpvYIdg7?=
 =?iso-8859-2?Q?wkFg7a6cr8yAOE/AygN2gYjLyMA5YgtLn0NCJ7dDefDTtpVdMTS903WPRN?=
 =?iso-8859-2?Q?uOu4ifM3UNrSyUt3/vU2ILuF05DMm0h1B6j37lAhQZzMpUA8lYQ+rPcukc?=
 =?iso-8859-2?Q?ll5rCjj4Yl7m217GI7iZAliY/htnBEtw5+INOPwSdmcjEd4moFdl9OlCBB?=
 =?iso-8859-2?Q?wtwW2yppk9Sn0pbhD3YQKGNRsAlUh6lEb1A4zdU84isGnLaj8xE4nJptSl?=
 =?iso-8859-2?Q?KQiGSvd2K2aMVCJoDaYUK59sBXXpXwaxQUUfve+SqRR1UMXcwWT/YlpaLv?=
 =?iso-8859-2?Q?I8F+XLNpTNWzD3jJVzj1sfcLhzI1b0XyL8Pe5cyyjQ2s6xAEAN88AlTU8W?=
 =?iso-8859-2?Q?k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?vwRQ86WV0NjyWkMyp/OxkQjnSEamPe4UHk9D3usqKDHZRjv2LDla1Jwiy5?=
 =?iso-8859-2?Q?mcAek9UHhndy50muaZr3d8YBf5MhclQ6/TnKxqWsKYIXvsYXyadEi5ABuB?=
 =?iso-8859-2?Q?064kiCnGTPp/O2grHP2hoG22TO7jF+GeTM1j+9St8lgy3Q9JIj5s+FwfgD?=
 =?iso-8859-2?Q?QvnQl5PBnjiqZi9bCJM6SwUFoEAzQ/GHSL1fCUY4a1PnFOsmoPTTcdEXYp?=
 =?iso-8859-2?Q?RUvamGPXwtgYZGolpkwYEbIw+nrmAAnZnCwvCcrtBKn3zpErcbLdxURO7W?=
 =?iso-8859-2?Q?q1nH+cH0DMKt51uyKE9DL0h6NNTYS3M2h4NIatkfZkVR+go8KLi5UzwK7D?=
 =?iso-8859-2?Q?G+WMfSB0BZkHFtpki3kbRc7dk/AbVeaLkg5CbOm9Q0cx3qQTpZFc7TBxov?=
 =?iso-8859-2?Q?tYFmtZpy2HLvKRqysgohwufbpsNHZBd3E3yHVWSBpL77FWgA6SBFmRok45?=
 =?iso-8859-2?Q?xTMSrrzYc6hFctG7MYV9SCfc7wkZDCn2QjshvPpnndx+tHy6OEGHzENZcx?=
 =?iso-8859-2?Q?EX5MyIgEdwOgdVu6mmHT8s5DElpcfkjwbKD1mlEdzwadIXzVewm4tfQYpK?=
 =?iso-8859-2?Q?JERK08kuDEItQIF6Fg/3bYYfSiF5MPSzQro29TqjUpanlPOMMl/ZtT9BHl?=
 =?iso-8859-2?Q?eKyNfdBx3T9I5FCsoofArgoToZSBvTDK45YxuTsiOLTjBoHsl7vEHXCR6Q?=
 =?iso-8859-2?Q?TG+OLS//zm2lFTN3j1LIPuIuvpgehnuee5geFCepR8zwcjdDHG1xoynimy?=
 =?iso-8859-2?Q?r9UUpKR5S1EOVf92iNkVnYbKSnz4rbc47BAwImyPPrvC2eFBYL4uIAMsru?=
 =?iso-8859-2?Q?QNU4BgpIPH9gjQ7YbXyYWZyL8RLkqqo6ZxPjuqFYDxzgT+67ANV2/mimcR?=
 =?iso-8859-2?Q?Ee7TmDJgdjJvWJmxknWoBcgWr0GI7FgbFmTB8Q63hx9BX/36IPM4vZUxXT?=
 =?iso-8859-2?Q?bJGZ/IN3iSCb7dIzPZ7q4Psa1Hj076leRP2kwTV3aNyMbR/wQIlnN9YCy1?=
 =?iso-8859-2?Q?67ftA3FU+atuxXiQ/rsxBmUB3+7Ky8THaplM57ozy4lrOI27gIynLPx/qg?=
 =?iso-8859-2?Q?mepW/0aYYN9A/UHU1pH7z+n4CO59uMyp49KF5m/l0SmLt6Nt7exoFxweNo?=
 =?iso-8859-2?Q?gefN0FoEpjEoigl0ck3mRbP8x9GbY0LIIJHzZJ1cUs/IGf9dG0ktkr51Rn?=
 =?iso-8859-2?Q?k+Ny8HaL2qFmNjpu+S7a7mfA1EbiXA200pjsY5KVoR2gPwaGxxMlhJC4Cj?=
 =?iso-8859-2?Q?Wngkd2/7SAuFnKej8Um9N188goUk8WyJjWrfb6XvRsV5L/bfipgyXUS+ro?=
 =?iso-8859-2?Q?vXLaZc1sWOPOFI6mLCG+m/ixiOwsuHHuLc0OVI7/aM42VwsncBzA7XIOL7?=
 =?iso-8859-2?Q?ePYrCx4NwstMXANFsklOhnCC7bnftFa4Y0+/LELi8GLQ9NQ751RoDtKCbi?=
 =?iso-8859-2?Q?snw9S3P5xMkcPC6twZqCQX61ByHzUsGm+8w8VtOBB9Qe+sWb9SIPR6FjZI?=
 =?iso-8859-2?Q?cNmkd2m/RuO84l/Mj7m8yjvitDEawMnkoFa3TLs7gKbnxdSvi3+Fmm5Mao?=
 =?iso-8859-2?Q?cE4mAxQosunA5MezqDxhYUTNBDuD?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09236B2289D6307E787D64FC9242ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9f5a9d-3bf2-4802-83e1-08ddbacabe08
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 07:16:49.0596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xAj+AWE1QUYVhqpak0AOlG/R22Du5JPIc7wyuNOefFmFRSehUqVsCeWYbim3XoI1fXPyAtzAPpSCunIyNTsgHZoyBrzSsQ4iO0PoQQORnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0799
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09236B2289D6307E787D64FC9242ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch ports `winsup/utils/mingw/cygcheck.cc` to AArch64.=0A=
=0A=
Radek=0A=
=0A=
From db2428722d0a01d61347a53ff8f1f1fecfc81368 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Mon, 9 Jun 2025 13:08:35 +0200=0A=
Subject: [PATCH] Cygwin: cygcheck: port to AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
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
2.49.0.vfs.0.4=0A=

--_002_DB9PR83MB09236B2289D6307E787D64FC9242ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-cygcheck-port-to-AArch64.patch"
Content-Description: 0001-Cygwin-cygcheck-port-to-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-cygcheck-port-to-AArch64.patch"; size=1672;
	creation-date="Fri, 04 Jul 2025 07:16:37 GMT";
	modification-date="Fri, 04 Jul 2025 07:16:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkYjI0Mjg3MjJkMGEwMWQ2MTM0N2E1M2ZmOGYxZjFmZWNmYzgxMzY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCA5IEp1biAyMDI1IDEzOjA4OjM1ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBjeWdjaGVjazogcG9ydCB0byBBQXJjaDY0Ck1J
TUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApD
b250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0
b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5zdXAvdXRpbHMvbWluZ3cv
Y3lnY2hlY2suY2MgfCAxMyArKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvdXRpbHMvbWluZ3cv
Y3lnY2hlY2suY2MgYi93aW5zdXAvdXRpbHMvbWluZ3cvY3lnY2hlY2suY2MKaW5kZXggODlhMDhl
NTYwLi42ZWM3YmNmMDMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC91dGlscy9taW5ndy9jeWdjaGVjay5j
YworKysgYi93aW5zdXAvdXRpbHMvbWluZ3cvY3lnY2hlY2suY2MKQEAgLTY1NCwxMyArNjU0LDIw
IEBAIGRsbF9pbmZvIChjb25zdCBjaGFyICpwYXRoLCBIQU5ETEUgZmgsIGludCBsdmwsIGludCBy
ZWN1cnNlKQogICBXT1JEIGFyY2ggPSBnZXRfd29yZCAoZmgsIHBlX2hlYWRlcl9vZmZzZXQgKyA0
KTsKICAgaWYgKEdldExhc3RFcnJvciAoKSAhPSBOT19FUlJPUikKICAgICBkaXNwbGF5X2Vycm9y
ICgiZ2V0X3dvcmQiKTsKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9f
KQogICBpZiAoYXJjaCAhPSBJTUFHRV9GSUxFX01BQ0hJTkVfQU1ENjQpCiAgICAgewogICAgICAg
cHV0cyAodmVyYm9zZSA/ICIgKG5vdCB4ODZfNjQgZGxsKSIgOiAiXG4iKTsKICAgICAgIHJldHVy
bjsKICAgICB9CiAgIGludCBiYXNlX29mZiA9IDEwODsKKyNlbGlmIGRlZmluZWQgKF9fYWFyY2g2
NF9fKQorICBpZiAoYXJjaCAhPSBJTUFHRV9GSUxFX01BQ0hJTkVfQVJNNjQpCisgICAgeworICAg
ICAgcHV0cyAodmVyYm9zZSA/ICIgKG5vdCBhYXJjaDY0IGRsbCkiIDogIlxuIik7CisgICAgICBy
ZXR1cm47CisgICAgfQorICBpbnQgYmFzZV9vZmYgPSAxMTI7CiAjZWxzZQogI2Vycm9yIHVuaW1w
bGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CiAjZW5kaWYKQEAgLTIxMDgsOCArMjExNSwxMCBAQCBz
dGF0aWMgY29uc3QgY2hhciBzYWZlX2NoYXJzW10gPSAiJC1fLiEqJygpLCI7CiBzdGF0aWMgY29u
c3QgY2hhciBncmVwX2Jhc2VfdXJsW10gPQogCSJodHRwOi8vY3lnd2luLmNvbS9jZ2ktYmluMi9w
YWNrYWdlLWdyZXAuY2dpP3RleHQ9MSZncmVwPSI7CiAKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYg
ZGVmaW5lZChfX3g4Nl82NF9fKQogI2RlZmluZSBBUkNIX1NUUiAgIiZhcmNoPXg4Nl82NCIKKyNl
bGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisjZGVmaW5lIEFSQ0hfU1RSICAiJmFyY2g9YWFyY2g2
NCIKICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgot
LSAKMi40OS4wLnZmcy4wLjQKCg==

--_002_DB9PR83MB09236B2289D6307E787D64FC9242ADB9PR83MB0923EURP_--

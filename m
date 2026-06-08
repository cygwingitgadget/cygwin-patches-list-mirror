Return-Path: <SRS0=GTBk=EE=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 729374C31833
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 06:08:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 729374C31833
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 729374C31833
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1780898922; cv=pass;
	b=CtCx+3o3Bdb+Oj53L0EVkORmGMZzJXBD/5L7MoPS5BjXvcFpUUtc++c5EDJg9NW2hzwIdBuoU5/E0JXrTHbmNJIxWfNAGs64ZdfLkhHP00GZHWKsut2M0n14NMzbMXLiHy1gkKTpFSc6SeDXMPdIc0wOI49HyyjzI9evk/XpENU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780898922; c=relaxed/simple;
	bh=iSVLHVNaSWK6Zgr5Se2Ir1r/GngSvDDLIqzJ9HGnl3Y=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=YWrko/BMvrooQL0GLhqs9RuP8Hn3pgC9BKGra6GGofgIfnzVEdS8cF4kfDNJHYVSpBPx6yLYVb7bPO5PYmRO/q/iDmxBW71QkLfsjDMLqdcUdk4/kdWwD32UnlntkizvwWqX9q0gTtMnT3ZVkcplqZx8nI8Gi3jDdgohhRVrwdI=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=rE1QdYs3
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 729374C31833
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=rE1QdYs3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z45YgV10KhRdwCYTXEY4heCjcLnK86jXphx7apSbTy94dMrJn4h+7DVQhwh5xROcDUX/LMi0fH14RLbSaeJ+T9Bg0DzckqDKLpM78ksA3HHbyrsh0MbXJ384yoJBsgy1Aivh8ybTNNrzqMvZd4w7BtzKmiPpx+veD7MqEQ0CybnMhJ3U2dfzsNekShHHWGiZYTuVzcilqX9ElCs0AXFZ6fRTIXB9TnXKu4uThsJSURiyDN2KSvEGMYFYxbRU6QBXJ8QdBQ8FU25+W0ErU9NcfjMmdSlBvwFnziubQxgP0RC9m6sLchBS4Iim3Ud1Ohr27qMF/Hc3rDgC68ix33ArMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62wCh7ggHvnlnSWVcs71s9YeLcrzUnJBuntblkliqWk=;
 b=RS5wODsVTqiKNlmjKXfztLIppD+SafPRcO/Bla11CA3HF2nJ5HM7kEYOFdvOMVxTNKv2ku1Pr8HfFN64vUb49zZxceVrQsFUxRP3dbv9nLB+i0dVV7TyuWNzfZc4JH/atCWIjROV3aw0sjFmKWUlCj75EhQNl2/yIRKoAjX1OVUGN0T2sizex6+Phj/43g9o0CkV7F2yrjsTur8B/6p7pGVRvJ9dgwwQUXRcXAblrV3V9IW6uayAtfgu2b5YQgRNiE4q9MGh2hAh/NjosM63mv7MiS9j0gFY/45F1F5IDjuL26oE+6ic4/0+zSTHh+OwfF7gpmaq88GmQfZtDWEddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62wCh7ggHvnlnSWVcs71s9YeLcrzUnJBuntblkliqWk=;
 b=rE1QdYs3vkhrf+K10zKrBVpuoIttXcQJP6W4bQLfOorx9yddXP9eVG0KnwMmwSr0lKB4ZmiiPoQKf3PpXj77hEbj1AMkdQdTlA/wApFgtyS1p2iLibWvEhVASK8oFmcu9qX3rjnGnd/Xb8KmtsMNLOcYsTDUKk3erzCK73f4QKEWjnjLgqxSDroC+rL3zu3w96RgCHw9Q9cOCjH2/Rd+RdmG0C4qM52hetMS/kKRz15re8GYRFY+eZuz9qZz9x/boeD0g9kTJme50pyg/lFKIsWykTbw19Ag9bPt70O6C2rCri03CwftxlexRmslbtdv8DrOq7nEAtG9eu+go8LdYg==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by PNYP287MB5836.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:324::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 06:08:34 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 06:08:34 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2] Cygwin: ssp: Add AArch64 implementation
Thread-Topic: [PATCH v2] Cygwin: ssp: Add AArch64 implementation
Thread-Index: AQHc9w08K8hFno2y5EW/kPABbRoQOg==
Date: Mon, 8 Jun 2026 06:08:34 +0000
Message-ID:
 <PN0P287MB0295F1D93B25FA3B90293E35921C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
References:
 <PN0P287MB02952FCE57C59FF18096B96D920E2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <34b42100-1722-4bdc-abf9-e9d159456ee0@dronecode.org.uk>
 <PN0P287MB0295E9D540A342B741B82CC592122@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN0P287MB0295E9D540A342B741B82CC592122@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|PNYP287MB5836:EE_
x-ms-office365-filtering-correlation-id: 3715167a-ce4c-4e5b-462d-08dec5245f67
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|1800799024|376014|366016|39142699007|31052699007|38070700021|6133799003|4053099003|22082099003|18002099003|55112099003|3023799007|56012099006|8096899003|4143699003;
x-microsoft-antispam-message-info:
 mc8VXtH8iHSkYIKerWSO0P9EqsguE7nMB0Ly9Y7V7HwUnNhhHL9O85OOR0EXPZuxIIKULUotgSFFiAyrDVe+iKakUiNPdfEfexeMm0Clk6+ZojubIXZv84o3JnVAQQN2Ti94VTer6MvVe7l3PHb6A1RQHQyqXrYiy3nw5a4VBMq5yI3FAJAWnysMHwsvKzMSOV4XxEQAhxj8Wcp8N7xf9PIx5RqJOQpUpc9BObSBnGIsA8eQUtg5YAz4+SMc+HWHJWog3I0UWwuUDa1tQfqDQqox5Iske3somPL0fomxreyufXjzjKpRKfzvdGvxR295hFBNnRJyrQZglY92m5JCBEI0RDcdKPOp7DLyIaqv6Y01tfQV70pGpst0Bi5nZKmqLrFFRxPBwDNi8LCDjPa4K5sbtaPOn4eXTYlrI6V3AR1nlpusD7WxUSjbkaDGZP5Z6t0ptqtQCO7rxNwSgzloKcOsEOWEeDw8kXApciMrpYaCgFtK/xMgulUBNZTi5GxieRWw9crG0QLqaBGcgqSoEhcG1ag+0cKmHi2c52TVpLDCVUDiFS9qfqkMXBFsKzda7Wo2mEWG8by/C0Y7WpEyeFVwMGBR5jMw+bSUUR+Gz1rv3OZrpzUnBfAByMKYv8fUKW7VTkpuGzma2kL+ysNQXbwuAOMGqwg5oWlb+5UaJJ4J6HaI5iz7fb3EoUWsSHjBXtU6Ik0Ao32J1xdO2lDEE+JLOjyMeEyc/twuzQ3VcyIRmUCn5KcC5i2NVHo2CD8Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(376014)(366016)(39142699007)(31052699007)(38070700021)(6133799003)(4053099003)(22082099003)(18002099003)(55112099003)(3023799007)(56012099006)(8096899003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GrYjdT2nOJXT26tGsQ0oo1e9+Qi2Xl0UKTzYbXHoFuJQLLQPjQ0qv9V5vY?=
 =?iso-8859-1?Q?dzJJbthv8X02zZ2GPZ3WXjjNH9r9/0GtZzHm33ZdHDOKGIw2Al/vAbHjEZ?=
 =?iso-8859-1?Q?w2p1+vaxY2smO+oTqZZJ3cyMH043oURBLJs71DYuKPhu9Hmb+FthOFtPZ6?=
 =?iso-8859-1?Q?z47X9mk6qhl+sLlWnlvzen/C2bjSc9H9dTW/J2H5nxmxWBVhGn05IEbExo?=
 =?iso-8859-1?Q?dbbdOGd0sTVJDHWqFDZPjy9YVYRjuiUNf2Jc+hN0sRyoMUrCsQUNYGWY6X?=
 =?iso-8859-1?Q?FfJtjgW1BkmxGY1Dz5p1MBuRgb+W+zS6pj3kVWuFT5YNN4k2ndmSOTWw+v?=
 =?iso-8859-1?Q?0uEsxEQfi3cHs4IY7KmXaOZuTWZECnVHQezS5JMgwp2e9XvqULCoyi9S6J?=
 =?iso-8859-1?Q?WdvcksQfeNT5k45XKhBFjuAnzKGiZhKI8o17BvChZuAQTIHtg3v69QnCuS?=
 =?iso-8859-1?Q?fP2FyQZh21SdRr+DH7INd7kJFssbTNDAkidK6MRznLQXQwJGRb1f2h+V2F?=
 =?iso-8859-1?Q?SmR+Ddvy2xTf3iCtioiuS+F0YJjyZ5p6I6u2C5RzUkEQxySyygnR2oLc9k?=
 =?iso-8859-1?Q?WS0/q2d2yuMdkD/VzEw0bp9865V8qKahfa+6e3VMTEyPNagt8n4ph3kNmk?=
 =?iso-8859-1?Q?q9tmbHUz9VjrnEn42OKP2U9nyhq/Rt4EBl04rqe2INLyv71u9/ToZjjo1S?=
 =?iso-8859-1?Q?rGraDQNU95thNURzBHmK0l/j6/jgkYKUb9a15sd1nH5l2gexL1ilSfcecF?=
 =?iso-8859-1?Q?+5gm3wbUOH7xj5N7bZW9SrR6Vl0kImdwk6OOrqk/ntQNMYLzyFaRsSbEaF?=
 =?iso-8859-1?Q?6FQAK4cxK/IZj+/FVeI5CGM8FgOxk9nadJRNjGvx9SFVS0xVe7RQPjKZhk?=
 =?iso-8859-1?Q?WNBf7gqGJXDC3lhNCMpH1Pfbs1aucfy0edLQExKlxh85MZ/y/OjpIpHCZI?=
 =?iso-8859-1?Q?TC24xCyn5X9AvF9RrHM7FLkwMf0szmM23/2JO8NHTJcsVjzMz58E6O3v9G?=
 =?iso-8859-1?Q?mazcqAr3oVVRBhswIqG428BIUqqhqYxt4Of5k5yp6BKBoLu3F9A5jHJDe3?=
 =?iso-8859-1?Q?nmsn5iLA19E+Pk2TtMo2YvKxdpeUNELfem3woVK9fayRVghF7HudlFDGBN?=
 =?iso-8859-1?Q?jSPi1sa2S/rs5/893D+hyV5/cJRMdPMlsKpA6iWp6pi/bwKHHQiw5Pmlka?=
 =?iso-8859-1?Q?ZpccMxSKP7VIiRUGXxhEKo1jt3jNZVHPsLjDsaQWIReIzLc41Z3eXA9pRj?=
 =?iso-8859-1?Q?di3xwoklyu3ZPFprfk/LmXRcPCDwPhAbYIRTZeDCqf8GyMELB574Dr11eV?=
 =?iso-8859-1?Q?Ag4oOUJzrU3mcX/Ndp40ZmhUdwkDJ3GgF8b7z7d0DlpOfov2v27hlpsuZz?=
 =?iso-8859-1?Q?LWFQSgvmOOT7Z+sA6fesbU0fOXxsQQBXIHBN+lOGGkdAUU2eF2WOu7wsvY?=
 =?iso-8859-1?Q?GmjDzWfpZIBveWHBiMDCk8e0nBcAWjx3Jq8uB1wmUIe8F8LyYRbfwXGrMK?=
 =?iso-8859-1?Q?BcJFpiAYqJIiYFCEax6IPQqrGrLAwiFZisulYkMv3609r/MFXA6/+3uTRv?=
 =?iso-8859-1?Q?gaWxf/urP9aMc8vVJA47HNV8U03ul6GgbOESWaKTVGAzNwTbDWFTYMVC8F?=
 =?iso-8859-1?Q?Vb0AsV35oKShgYRr5H0ychHghinscfc7RE0/sbGoJhoQs1iN94rfHXqgmf?=
 =?iso-8859-1?Q?9xy7kX1HnKdEGTO5IvmBDwZccf9wCUDDOy2uRKkI9vKdokIs4kKvy33h5s?=
 =?iso-8859-1?Q?BwH8Ds4Ikx9uK3ua7a8lx3ca2K/4P8zISHncMoJotygE8acHihiv39zash?=
 =?iso-8859-1?Q?BDvyHchrsdXCs9VZYAhdlvxxW5Gq3gc=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB0295F1D93B25FA3B90293E35921C2PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3715167a-ce4c-4e5b-462d-08dec5245f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 06:08:34.3121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blggXJ2lksF76q2ceRHm+eJHU+bSQFxFqMktlfy22dQ0GMSzMX69/kxcXCnYcxuHuB5pxux3VDDgt7KW/97S1Pu1Zniw9AGnktVEHeSzymaDAIdKGcj19xGIfjlbVhm7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYP287MB5836
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB0295F1D93B25FA3B90293E35921C2PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB0295F1D93B25FA3B90293E35921C2PN0P287MB0295INDP_"

--_000_PN0P287MB0295F1D93B25FA3B90293E35921C2PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for the review!
> did you consider writing something like (untested): [SW_BREAKPOINT_SIZE r=
efactor]
Yes, adopted in v2. I introduced SW_BREAKPOINT_SIZE as a macro (1 for x86/x=
86_64, 4
for aarch64, #error otherwise), unified the PendingBreakpoints struct to use
real_insn[SW_BREAKPOINT_SIZE] throughout, and renamed the variable to brk_i=
nsn on both
architectures. This eliminates the per-arch #ifdef blocks in add_breakpoint=
 and remove_breakpoint.

> Hmmm... this is probably just generically right, I guess.
> (re: only setting running=3D0 on !dwFirstChance for aarch64)
 On Windows/AArch64, the single-step mechanism (PSTATE.SS) triggers a first=
-chance STATUS_SINGLE_STEP
exception for every instruction we step through. If we set running=3D0 on f=
irst-chance exceptions,
the profiler would exit on the very first step. Limiting it to second-chanc=
e (i.e. unhandled) exceptions
means we only stop on genuine faults, matching the intent of the original x=
86 code.

All other issues (whitespace regression, spurious fprintf indent, missing c=
mdline_copy comment) are fixed in v2 as well.

Thanks and regards
K Chandru
Inline patch
---
 winsup/utils/ssp.c | 154 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 140 insertions(+), 14 deletions(-)

diff --git a/winsup/utils/ssp.c b/winsup/utils/ssp.c
index 96a90a1d9..6d4736c78 100644
--- a/winsup/utils/ssp.c
+++ b/winsup/utils/ssp.c
@@ -48,6 +48,13 @@ static char opts[] =3D "+cdehlstvV";
 typedef DWORD64 CONTEXT_REG;
 #define CONTEXT_REG_FMT "%016llx"
 #define ADDR_SSCANF_FMT "%lli"
+#elif defined(__aarch64__)
+#define KERNEL_ADDR 0x00007FF000000000
+#define CONTEXT_SP Sp
+#define CONTEXT_IP Pc
+typedef DWORD64 CONTEXT_REG;
+#define CONTEXT_REG_FMT "%016llx"
+#define ADDR_SSCANF_FMT "%lli"
 #else
 #error unimplemented for this target
 #endif
@@ -83,13 +90,26 @@ typedef struct {
   char *name;
 } DllInfo;

+/* Size in bytes of the software breakpoint instruction (INT3 on x86,
+   BRK on AArch64).  */
+#if defined(__i386__) || defined(__x86_64__)
+#define SW_BREAKPOINT_SIZE 1
+#elif defined(__aarch64__)
+#define SW_BREAKPOINT_SIZE 4
+#else
+#error unimplemented for this target
+#endif
+
 typedef struct {
   CONTEXT_REG address;
-  unsigned char real_byte;
+  unsigned char real_insn[SW_BREAKPOINT_SIZE];
 } PendingBreakpoints;

 CONTEXT_REG low_pc, high_pc=3D0;
 CONTEXT_REG last_pc=3D0, pc, last_sp=3D0, sp;
+#if defined(__aarch64__)
+CONTEXT_REG last_lr=3D0, lr;
+#endif
 int total_cycles, count;
 HANDLE hProcess;
 PROCESS_INFORMATION procinfo;
@@ -129,7 +149,13 @@ add_breakpoint (CONTEXT_REG address)
 {
   int i;
   SIZE_T rv;
-  static char int3[] =3D { 0xcc };
+#if defined(__i386__) || defined(__x86_64__)
+  static unsigned char brk_insn[] =3D { 0xcc };
+#elif defined(__aarch64__)
+  static unsigned char brk_insn[] =3D { 0x00, 0x00, 0x20, 0xd4 };
+#else
+#error unimplemented for this target
+#endif
   for (i=3D0; i<num_breakpoints; i++)
     {
       if (pending_breakpoints[i].address =3D=3D address)
@@ -142,12 +168,11 @@ add_breakpoint (CONTEXT_REG address)
   pending_breakpoints[i].address =3D address;
   ReadProcessMemory (hProcess,
             (void *)address,
-            &(pending_breakpoints[i].real_byte),
-            1, &rv);
-
+            pending_breakpoints[i].real_insn,
+            SW_BREAKPOINT_SIZE, &rv);
   WriteProcessMemory (hProcess,
              (void *)address,
-             (LPVOID)int3, 1, &rv);
+             (LPVOID)brk_insn, SW_BREAKPOINT_SIZE, &rv);
   if (i >=3D num_breakpoints)
     num_breakpoints =3D i+1;
 }
@@ -164,8 +189,8 @@ remove_breakpoint (CONTEXT_REG address)
      pending_breakpoints[i].address =3D 0;
      WriteProcessMemory (hProcess,
                  (void *)address,
-                 &(pending_breakpoints[i].real_byte),
-                 1, &rv);
+                 pending_breakpoints[i].real_insn,
+                 SW_BREAKPOINT_SIZE, &rv);
      return 1;
    }
     }
@@ -200,10 +225,19 @@ set_step_threads (int threadId, int trace)
   if (rv !=3D -1)
     {
       thread_step_flags[tix] =3D trace;
+#if defined(__i386__) || defined(__x86_64__)
       if (trace)
-   context.EFlags |=3D 0x100; /* TRAP (single step) flag */
+     context.EFlags |=3D 0x100; /* TRAP (single step) flag */
       else
-   context.EFlags &=3D ~0x100; /* TRAP (single step) flag */
+     context.EFlags &=3D ~0x100; /* TRAP (single step) flag */
+#elif defined(__aarch64__)
+      if (trace)
+     context.Cpsr |=3D 0x00200000; /* PSTATE.SS (single step) flag */
+      else
+     context.Cpsr &=3D ~0x00200000; /* PSTATE.SS (single step) flag */
+#else
+#error unimplemented for this target
+#endif
       SetThreadContext (thread, &context);
     }
 }
@@ -215,7 +249,13 @@ set_steps ()
   for (i=3D0; i<num_active_threads; i++)
     {
       GetThreadContext (active_threads[i], &context);
+#if defined(__i386__) || defined(__x86_64__)
       s =3D context.EFlags & 0x0100;
+#elif defined(__aarch64__)
+      s =3D context.Cpsr & 0x00200000; /* PSTATE.SS (single step) flag */
+#else
+#error unimplemented for this target
+#endif
       if (!s && thread_step_flags[i])
    {
      set_step_threads (active_thread_ids[i], 1);
@@ -257,6 +297,25 @@ dump_registers (HANDLE thread)
      context.Rax, context.Rbx, context.Rcx, context.Rdx);
   printf ("esi %016llx edi %016llx ebp %016llx esp %016llx %016llx\n",
      context.Rsi, context.Rdi, context.Rbp, context.Rsp, context.Rip);
+#elif defined(__aarch64__)
+  printf ("x0 %016llx x1 %016llx x2 %016llx x3 %016llx\n",
+     context.X[0], context.X[1], context.X[2], context.X[3]);
+  printf ("x4 %016llx x5 %016llx x6 %016llx x7 %016llx\n",
+     context.X[4], context.X[5], context.X[6], context.X[7]);
+  printf ("x8 %016llx x9 %016llx x10 %016llx x11 %016llx\n",
+     context.X[8], context.X[9], context.X[10], context.X[11]);
+  printf ("x12 %016llx x13 %016llx x14 %016llx x15 %016llx\n",
+     context.X[12], context.X[13], context.X[14], context.X[15]);
+  printf ("x16 %016llx x17 %016llx x18 %016llx x19 %016llx\n",
+     context.X[16], context.X[17], context.X[18], context.X[19]);
+  printf ("x20 %016llx x21 %016llx x22 %016llx x23 %016llx\n",
+     context.X[20], context.X[21], context.X[22], context.X[23]);
+  printf ("x24 %016llx x25 %016llx x26 %016llx x27 %016llx\n",
+     context.X[24], context.X[25], context.X[26], context.X[27]);
+  printf ("x28 %016llx fp %016llx lr %016llx\n",
+     context.X[28], context.Fp, context.Lr);
+  printf ("sp %016llx pc %016llx cpsr %08x\n",
+     context.Sp, context.Pc, context.Cpsr);
 #else
 #error unimplemented for this target
 #endif
@@ -450,11 +509,17 @@ run_program (char *cmdline)
        case STATUS_BREAKPOINT:
          if (remove_breakpoint ((CONTEXT_REG)event.u.Exception.ExceptionRe=
cord.ExceptionAddress))
        {
+#if defined(__aarch64__)
+         if (!rv)
+           SetThreadContext (hThread, &context);
+         thread_return_address[tix] =3D context.Lr;
+#else
          context.CONTEXT_IP --;
          if (!rv)
            SetThreadContext (hThread, &context);
          if (ReadProcessMemory (hProcess, (void *)context.CONTEXT_SP, &rv,=
 sizeof(rv), &rv))
              thread_return_address[tix] =3D rv;
+#endif
        }
          set_step_threads (event.dwThreadId, stepping_enabled);
          /*FALLTHRU*/
@@ -462,6 +527,9 @@ run_program (char *cmdline)
          opcode_count++;
          pc =3D (CONTEXT_REG)event.u.Exception.ExceptionRecord.ExceptionAd=
dress;
          sp =3D context.CONTEXT_SP;
+#if defined(__aarch64__)
+         lr =3D context.Lr;
+#endif
          if (tracing_enabled)
        fprintf (tracefile, CONTEXT_REG_FMT " %08x\n", pc, (int)event.dwThr=
eadId);
          if (trace_console)
@@ -493,13 +561,27 @@ run_program (char *cmdline)
          if (++qq % 100 =3D=3D 0)
            fprintf (stderr, " " CONTEXT_REG_FMT " %d %d \r",
                pc, ncalls, opcode_count);
-
+#if defined(__aarch64__)
+         if (lr !=3D last_lr && lr =3D=3D last_pc + 4)
+#else
          if (sp =3D=3D last_sp-sizeof(CONTEXT_REG))
+#endif
            {
              ncalls++;
              store_call_edge (last_pc, pc);
              if (last_pc < KERNEL_ADDR && pc > KERNEL_ADDR)
            {
+#if defined(__aarch64__)
+             CONTEXT_REG retaddr =3D lr;
+             if (verbose)
+               printf ("skip kernel call: " CONTEXT_REG_FMT " -> " CONTEXT=
_REG_FMT ", ret =3D " CONTEXT_REG_FMT "\n",
+                   last_pc, pc, retaddr);
+             if (retaddr && retaddr < KERNEL_ADDR)
+               {
+                 add_breakpoint (retaddr);
+                 set_step_threads (event.dwThreadId, 0);
+               }
+#else
 #if 0
              CONTEXT_REG retaddr;
              SIZE_T rv;
@@ -512,6 +594,7 @@ run_program (char *cmdline)
              /* experimental - try to skip kernel calls for speed */
              add_breakpoint (retaddr);
              set_step_threads (event.dwThreadId, 0);
+#endif
 #endif
            }
            }
@@ -520,6 +603,9 @@ run_program (char *cmdline)
          total_cycles++;
          last_sp =3D sp;
          last_pc =3D pc;
+#if defined(__aarch64__)
+         last_lr =3D lr;
+#endif
          if (pc >=3D low_pc && pc < high_pc)
        hits[(pc - low_pc)/2] ++;
          break;
@@ -534,7 +620,12 @@ run_program (char *cmdline)
            dump_registers (hThread);
        }
          contv =3D DBG_EXCEPTION_NOT_HANDLED;
+#if defined(__aarch64__)
+         if (!event.u.Exception.dwFirstChance)
+       running =3D 0;
+#else
          running =3D 0;
+#endif
          break;
        }

@@ -542,19 +633,39 @@ run_program (char *cmdline)
        {
          if (pc =3D=3D thread_return_address[tix])
        {
+#if defined(__i386__) || defined(__x86_64__)
          if (context.EFlags & 0x100)
            {
              context.EFlags &=3D ~0x100; /* TRAP (single step) flag */
              SetThreadContext (hThread, &context);
            }
+#elif defined(__aarch64__)
+         if (context.Cpsr & 0x00200000)
+           {
+             context.Cpsr &=3D ~0x00200000; /* PSTATE.SS (single step) fla=
g */
+             SetThreadContext (hThread, &context);
+           }
+#else
+#error unimplemented for this target
+#endif
        }
          else if (stepping_enabled)
        {
+#if defined(__i386__) || defined(__x86_64__)
          if (!(context.EFlags & 0x100))
            {
              context.EFlags |=3D 0x100; /* TRAP (single step) flag */
              SetThreadContext (hThread, &context);
            }
+#elif defined(__aarch64__)
+         if (!(context.Cpsr & 0x00200000))
+           {
+             context.Cpsr |=3D 0x00200000; /* PSTATE.SS (single step) flag=
 */
+             SetThreadContext (hThread, &context);
+           }
+#else
+#error unimplemented for this target
+#endif
        }
        }
      break;
@@ -918,8 +1029,23 @@ main (int argc, char **argv)

   fprintf (stderr, "prun: [" CONTEXT_REG_FMT "," CONTEXT_REG_FMT "] Runnin=
g '%s'\n",
      low_pc, high_pc, argv[optind]);
-
-  run_program (argv[optind]);
+  {
+    /* CreateProcess (called below with lpApplicationName =3D=3D NULL) is
+       documented to modify the lpCommandLine buffer in place.  argv[optin=
d]
+       points into our own argv, so passing it directly lets CreateProcess
+       scribble on it; this was observed on aarch64-cygwin as the command
+       line coming back mangled (e.g. 'test_hello.exe' -> 'st_hello.exxee')
+       on later use.  Pass a private writable copy instead.  It is not fre=
ed
+       because run_program() stores it in dll_info[0].name, which is read
+       later when printing the DLL-profile table.  */
+    char *cmdline_copy =3D strdup (argv[optind]);
+    if (!cmdline_copy)
+      {
+   fprintf (stderr, "Out of memory duplicating cmdline\n");
+   exit (1);
+      }
+    run_program (cmdline_copy);
+  }

   hdr.lpc =3D low_pc;
   hdr.hpc =3D high_pc;
@@ -935,7 +1061,7 @@ main (int argc, char **argv)

   if (dll_counts)
     {
-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__aarch64__)
       /*       1234567 123% 1234567 123% 1234567812345678 xxxxxxxxxxx */
       printf (" Main-Thread Other-Thread BaseAddr         DLL Name\n");
 #else
--
2.49.0.windows.1




--_000_PN0P287MB0295F1D93B25FA3B90293E35921C2PN0P287MB0295INDP_--

--_004_PN0P287MB0295F1D93B25FA3B90293E35921C2PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-ssp-Add-AArch64-implementation.patch"
Content-Description: Cygwin-ssp-Add-AArch64-implementation.patch
Content-Disposition: attachment;
	filename="Cygwin-ssp-Add-AArch64-implementation.patch"; size=11272;
	creation-date="Mon, 08 Jun 2026 06:07:11 GMT";
	modification-date="Mon, 08 Jun 2026 06:08:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlNTVkZWMyYmQ3ZmI2MGM0YjU1MmEyNjg5NmRiNGU5ZThhNTk4ZmFk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IFRodSwgMjEgTWF5IDIwMjYgMTM6MDc6MDkgKzA1MzAKU3ViamVjdDogW1BB
VENIIHYyXSBDeWd3aW46IHNzcDogQWRkIEFBcmNoNjQgaW1wbGVtZW50YXRp
b24KTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWlu
OyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhi
aXQKCkFkZCBBQXJjaDY0IHN1cHBvcnQgdG8gc3NwIGJ5IGltcGxlbWVudGlu
ZyBBUk02NCBicmVha3BvaW50cywKc2luZ2xlLXN0ZXAgaGFuZGxpbmcsIHJl
Z2lzdGVyIGR1bXBzLCBhbmQga2VybmVsLWNhbGwgdHJhY2luZy4KClVzZSBC
UksgaW5zdHJ1Y3Rpb25zIGZvciBicmVha3BvaW50cywgaGFuZGxlIFBTVEFU
RS5TUyBmb3IKc2luZ2xlLXN0ZXBwaW5nLCBhbmQgYWRkIEFSTTY0LXNwZWNp
ZmljIGNvbnRleHQvcmVnaXN0ZXIgc3VwcG9ydC4KCkFsc28gZml4IGNvbW1h
bmQtbGluZSBoYW5kbGluZyBieSBkdXBsaWNhdGluZyB0aGUgaW5wdXQgY29t
bWFuZApzdHJpbmcgYmVmb3JlIHBhc3NpbmcgaXQgdG8gcnVuX3Byb2dyYW0o
KS4KClNpZ25lZC1vZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRv
bkBtaWNyb3NvZnQuY29tPgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KU2lnbmVkLW9mZi1ieTogQ2hhbmRydSBLdW1hcmVzYW4gPGNo
YW5kcnUua3VtYXJlc2FuQG11bHRpY29yZXdhcmVpbmMuY29tPgotLS0KIHdp
bnN1cC91dGlscy9zc3AuYyB8IDE1NCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNDAg
aW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL3V0aWxzL3NzcC5jIGIvd2luc3VwL3V0aWxzL3NzcC5jCmluZGV4
IDk2YTkwYTFkOS4uNmQ0NzM2Yzc4IDEwMDY0NAotLS0gYS93aW5zdXAvdXRp
bHMvc3NwLmMKKysrIGIvd2luc3VwL3V0aWxzL3NzcC5jCkBAIC00OCw2ICs0
OCwxMyBAQCBzdGF0aWMgY2hhciBvcHRzW10gPSAiK2NkZWhsc3R2ViI7CiB0
eXBlZGVmIERXT1JENjQgQ09OVEVYVF9SRUc7CiAjZGVmaW5lIENPTlRFWFRf
UkVHX0ZNVCAiJTAxNmxseCIKICNkZWZpbmUgQUREUl9TU0NBTkZfRk1UICIl
bGxpIgorI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyNkZWZpbmUgS0VS
TkVMX0FERFIgMHgwMDAwN0ZGMDAwMDAwMDAwCisjZGVmaW5lIENPTlRFWFRf
U1AgU3AKKyNkZWZpbmUgQ09OVEVYVF9JUCBQYwordHlwZWRlZiBEV09SRDY0
IENPTlRFWFRfUkVHOworI2RlZmluZSBDT05URVhUX1JFR19GTVQgIiUwMTZs
bHgiCisjZGVmaW5lIEFERFJfU1NDQU5GX0ZNVCAiJWxsaSIKICNlbHNlCiAj
ZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgpA
QCAtODMsMTMgKzkwLDI2IEBAIHR5cGVkZWYgc3RydWN0IHsKICAgY2hhciAq
bmFtZTsKIH0gRGxsSW5mbzsKIAorLyogU2l6ZSBpbiBieXRlcyBvZiB0aGUg
c29mdHdhcmUgYnJlYWtwb2ludCBpbnN0cnVjdGlvbiAoSU5UMyBvbiB4ODYs
CisgICBCUksgb24gQUFyY2g2NCkuICAqLworI2lmIGRlZmluZWQoX19pMzg2
X18pIHx8IGRlZmluZWQoX194ODZfNjRfXykKKyNkZWZpbmUgU1dfQlJFQUtQ
T0lOVF9TSVpFIDEKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisjZGVm
aW5lIFNXX0JSRUFLUE9JTlRfU0laRSA0CisjZWxzZQorI2Vycm9yIHVuaW1w
bGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CisjZW5kaWYKKwogdHlwZWRlZiBz
dHJ1Y3QgewogICBDT05URVhUX1JFRyBhZGRyZXNzOwotICB1bnNpZ25lZCBj
aGFyIHJlYWxfYnl0ZTsKKyAgdW5zaWduZWQgY2hhciByZWFsX2luc25bU1df
QlJFQUtQT0lOVF9TSVpFXTsKIH0gUGVuZGluZ0JyZWFrcG9pbnRzOwogCiBD
T05URVhUX1JFRyBsb3dfcGMsIGhpZ2hfcGM9MDsKIENPTlRFWFRfUkVHIGxh
c3RfcGM9MCwgcGMsIGxhc3Rfc3A9MCwgc3A7CisjaWYgZGVmaW5lZChfX2Fh
cmNoNjRfXykKK0NPTlRFWFRfUkVHIGxhc3RfbHI9MCwgbHI7CisjZW5kaWYK
IGludCB0b3RhbF9jeWNsZXMsIGNvdW50OwogSEFORExFIGhQcm9jZXNzOwog
UFJPQ0VTU19JTkZPUk1BVElPTiBwcm9jaW5mbzsKQEAgLTEyOSw3ICsxNDks
MTMgQEAgYWRkX2JyZWFrcG9pbnQgKENPTlRFWFRfUkVHIGFkZHJlc3MpCiB7
CiAgIGludCBpOwogICBTSVpFX1QgcnY7Ci0gIHN0YXRpYyBjaGFyIGludDNb
XSA9IHsgMHhjYyB9OworI2lmIGRlZmluZWQoX19pMzg2X18pIHx8IGRlZmlu
ZWQoX194ODZfNjRfXykKKyAgc3RhdGljIHVuc2lnbmVkIGNoYXIgYnJrX2lu
c25bXSA9IHsgMHhjYyB9OworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykK
KyAgc3RhdGljIHVuc2lnbmVkIGNoYXIgYnJrX2luc25bXSA9IHsgMHgwMCwg
MHgwMCwgMHgyMCwgMHhkNCB9OworI2Vsc2UKKyNlcnJvciB1bmltcGxlbWVu
dGVkIGZvciB0aGlzIHRhcmdldAorI2VuZGlmCiAgIGZvciAoaT0wOyBpPG51
bV9icmVha3BvaW50czsgaSsrKQogICAgIHsKICAgICAgIGlmIChwZW5kaW5n
X2JyZWFrcG9pbnRzW2ldLmFkZHJlc3MgPT0gYWRkcmVzcykKQEAgLTE0Miwx
MiArMTY4LDExIEBAIGFkZF9icmVha3BvaW50IChDT05URVhUX1JFRyBhZGRy
ZXNzKQogICBwZW5kaW5nX2JyZWFrcG9pbnRzW2ldLmFkZHJlc3MgPSBhZGRy
ZXNzOwogICBSZWFkUHJvY2Vzc01lbW9yeSAoaFByb2Nlc3MsCiAJCSAgICAg
KHZvaWQgKilhZGRyZXNzLAotCQkgICAgICYocGVuZGluZ19icmVha3BvaW50
c1tpXS5yZWFsX2J5dGUpLAotCQkgICAgIDEsICZydik7Ci0KKwkJICAgICBw
ZW5kaW5nX2JyZWFrcG9pbnRzW2ldLnJlYWxfaW5zbiwKKwkJICAgICBTV19C
UkVBS1BPSU5UX1NJWkUsICZydik7CiAgIFdyaXRlUHJvY2Vzc01lbW9yeSAo
aFByb2Nlc3MsCiAJCSAgICAgICh2b2lkICopYWRkcmVzcywKLQkJICAgICAg
KExQVk9JRClpbnQzLCAxLCAmcnYpOworCQkgICAgICAoTFBWT0lEKWJya19p
bnNuLCBTV19CUkVBS1BPSU5UX1NJWkUsICZydik7CiAgIGlmIChpID49IG51
bV9icmVha3BvaW50cykKICAgICBudW1fYnJlYWtwb2ludHMgPSBpKzE7CiB9
CkBAIC0xNjQsOCArMTg5LDggQEAgcmVtb3ZlX2JyZWFrcG9pbnQgKENPTlRF
WFRfUkVHIGFkZHJlc3MpCiAJICBwZW5kaW5nX2JyZWFrcG9pbnRzW2ldLmFk
ZHJlc3MgPSAwOwogCSAgV3JpdGVQcm9jZXNzTWVtb3J5IChoUHJvY2VzcywK
IAkJCSAgICAgICh2b2lkICopYWRkcmVzcywKLQkJCSAgICAgICYocGVuZGlu
Z19icmVha3BvaW50c1tpXS5yZWFsX2J5dGUpLAotCQkJICAgICAgMSwgJnJ2
KTsKKwkJCSAgICAgIHBlbmRpbmdfYnJlYWtwb2ludHNbaV0ucmVhbF9pbnNu
LAorCQkJICAgICAgU1dfQlJFQUtQT0lOVF9TSVpFLCAmcnYpOwogCSAgcmV0
dXJuIDE7CiAJfQogICAgIH0KQEAgLTIwMCwxMCArMjI1LDE5IEBAIHNldF9z
dGVwX3RocmVhZHMgKGludCB0aHJlYWRJZCwgaW50IHRyYWNlKQogICBpZiAo
cnYgIT0gLTEpCiAgICAgewogICAgICAgdGhyZWFkX3N0ZXBfZmxhZ3NbdGl4
XSA9IHRyYWNlOworI2lmIGRlZmluZWQoX19pMzg2X18pIHx8IGRlZmluZWQo
X194ODZfNjRfXykKICAgICAgIGlmICh0cmFjZSkKLQljb250ZXh0LkVGbGFn
cyB8PSAweDEwMDsgLyogVFJBUCAoc2luZ2xlIHN0ZXApIGZsYWcgKi8KKwkg
IGNvbnRleHQuRUZsYWdzIHw9IDB4MTAwOyAvKiBUUkFQIChzaW5nbGUgc3Rl
cCkgZmxhZyAqLwogICAgICAgZWxzZQotCWNvbnRleHQuRUZsYWdzICY9IH4w
eDEwMDsgLyogVFJBUCAoc2luZ2xlIHN0ZXApIGZsYWcgKi8KKwkgIGNvbnRl
eHQuRUZsYWdzICY9IH4weDEwMDsgLyogVFJBUCAoc2luZ2xlIHN0ZXApIGZs
YWcgKi8KKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisgICAgICBpZiAo
dHJhY2UpCisJICBjb250ZXh0LkNwc3IgfD0gMHgwMDIwMDAwMDsgLyogUFNU
QVRFLlNTIChzaW5nbGUgc3RlcCkgZmxhZyAqLworICAgICAgZWxzZQorCSAg
Y29udGV4dC5DcHNyICY9IH4weDAwMjAwMDAwOyAvKiBQU1RBVEUuU1MgKHNp
bmdsZSBzdGVwKSBmbGFnICovCisjZWxzZQorI2Vycm9yIHVuaW1wbGVtZW50
ZWQgZm9yIHRoaXMgdGFyZ2V0CisjZW5kaWYKICAgICAgIFNldFRocmVhZENv
bnRleHQgKHRocmVhZCwgJmNvbnRleHQpOwogICAgIH0KIH0KQEAgLTIxNSw3
ICsyNDksMTMgQEAgc2V0X3N0ZXBzICgpCiAgIGZvciAoaT0wOyBpPG51bV9h
Y3RpdmVfdGhyZWFkczsgaSsrKQogICAgIHsKICAgICAgIEdldFRocmVhZENv
bnRleHQgKGFjdGl2ZV90aHJlYWRzW2ldLCAmY29udGV4dCk7CisjaWYgZGVm
aW5lZChfX2kzODZfXykgfHwgZGVmaW5lZChfX3g4Nl82NF9fKQogICAgICAg
cyA9IGNvbnRleHQuRUZsYWdzICYgMHgwMTAwOworI2VsaWYgZGVmaW5lZChf
X2FhcmNoNjRfXykKKyAgICAgIHMgPSBjb250ZXh0LkNwc3IgJiAweDAwMjAw
MDAwOyAvKiBQU1RBVEUuU1MgKHNpbmdsZSBzdGVwKSBmbGFnICovCisjZWxz
ZQorI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CisjZW5k
aWYKICAgICAgIGlmICghcyAmJiB0aHJlYWRfc3RlcF9mbGFnc1tpXSkKIAl7
CiAJICBzZXRfc3RlcF90aHJlYWRzIChhY3RpdmVfdGhyZWFkX2lkc1tpXSwg
MSk7CkBAIC0yNTcsNiArMjk3LDI1IEBAIGR1bXBfcmVnaXN0ZXJzIChIQU5E
TEUgdGhyZWFkKQogCSAgY29udGV4dC5SYXgsIGNvbnRleHQuUmJ4LCBjb250
ZXh0LlJjeCwgY29udGV4dC5SZHgpOwogICBwcmludGYgKCJlc2kgJTAxNmxs
eCBlZGkgJTAxNmxseCBlYnAgJTAxNmxseCBlc3AgJTAxNmxseCAlMDE2bGx4
XG4iLAogCSAgY29udGV4dC5Sc2ksIGNvbnRleHQuUmRpLCBjb250ZXh0LlJi
cCwgY29udGV4dC5Sc3AsIGNvbnRleHQuUmlwKTsKKyNlbGlmIGRlZmluZWQo
X19hYXJjaDY0X18pCisgIHByaW50ZiAoIngwICUwMTZsbHggeDEgJTAxNmxs
eCB4MiAlMDE2bGx4IHgzICUwMTZsbHhcbiIsCisJICBjb250ZXh0LlhbMF0s
IGNvbnRleHQuWFsxXSwgY29udGV4dC5YWzJdLCBjb250ZXh0LlhbM10pOwor
ICBwcmludGYgKCJ4NCAlMDE2bGx4IHg1ICUwMTZsbHggeDYgJTAxNmxseCB4
NyAlMDE2bGx4XG4iLAorCSAgY29udGV4dC5YWzRdLCBjb250ZXh0LlhbNV0s
IGNvbnRleHQuWFs2XSwgY29udGV4dC5YWzddKTsKKyAgcHJpbnRmICgieDgg
JTAxNmxseCB4OSAlMDE2bGx4IHgxMCAlMDE2bGx4IHgxMSAlMDE2bGx4XG4i
LAorCSAgY29udGV4dC5YWzhdLCBjb250ZXh0LlhbOV0sIGNvbnRleHQuWFsx
MF0sIGNvbnRleHQuWFsxMV0pOworICBwcmludGYgKCJ4MTIgJTAxNmxseCB4
MTMgJTAxNmxseCB4MTQgJTAxNmxseCB4MTUgJTAxNmxseFxuIiwKKwkgIGNv
bnRleHQuWFsxMl0sIGNvbnRleHQuWFsxM10sIGNvbnRleHQuWFsxNF0sIGNv
bnRleHQuWFsxNV0pOworICBwcmludGYgKCJ4MTYgJTAxNmxseCB4MTcgJTAx
NmxseCB4MTggJTAxNmxseCB4MTkgJTAxNmxseFxuIiwKKwkgIGNvbnRleHQu
WFsxNl0sIGNvbnRleHQuWFsxN10sIGNvbnRleHQuWFsxOF0sIGNvbnRleHQu
WFsxOV0pOworICBwcmludGYgKCJ4MjAgJTAxNmxseCB4MjEgJTAxNmxseCB4
MjIgJTAxNmxseCB4MjMgJTAxNmxseFxuIiwKKwkgIGNvbnRleHQuWFsyMF0s
IGNvbnRleHQuWFsyMV0sIGNvbnRleHQuWFsyMl0sIGNvbnRleHQuWFsyM10p
OworICBwcmludGYgKCJ4MjQgJTAxNmxseCB4MjUgJTAxNmxseCB4MjYgJTAx
NmxseCB4MjcgJTAxNmxseFxuIiwKKwkgIGNvbnRleHQuWFsyNF0sIGNvbnRl
eHQuWFsyNV0sIGNvbnRleHQuWFsyNl0sIGNvbnRleHQuWFsyN10pOworICBw
cmludGYgKCJ4MjggJTAxNmxseCBmcCAlMDE2bGx4IGxyICUwMTZsbHhcbiIs
CisJICBjb250ZXh0LlhbMjhdLCBjb250ZXh0LkZwLCBjb250ZXh0LkxyKTsK
KyAgcHJpbnRmICgic3AgJTAxNmxseCBwYyAlMDE2bGx4IGNwc3IgJTA4eFxu
IiwKKwkgIGNvbnRleHQuU3AsIGNvbnRleHQuUGMsIGNvbnRleHQuQ3Bzcik7
CiAjZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0
CiAjZW5kaWYKQEAgLTQ1MCwxMSArNTA5LDE3IEBAIHJ1bl9wcm9ncmFtIChj
aGFyICpjbWRsaW5lKQogCSAgICBjYXNlIFNUQVRVU19CUkVBS1BPSU5UOgog
CSAgICAgIGlmIChyZW1vdmVfYnJlYWtwb2ludCAoKENPTlRFWFRfUkVHKWV2
ZW50LnUuRXhjZXB0aW9uLkV4Y2VwdGlvblJlY29yZC5FeGNlcHRpb25BZGRy
ZXNzKSkKIAkJeworI2lmIGRlZmluZWQoX19hYXJjaDY0X18pCisJCSAgaWYg
KCFydikKKwkJICAgIFNldFRocmVhZENvbnRleHQgKGhUaHJlYWQsICZjb250
ZXh0KTsKKwkJICB0aHJlYWRfcmV0dXJuX2FkZHJlc3NbdGl4XSA9IGNvbnRl
eHQuTHI7CisjZWxzZQogCQkgIGNvbnRleHQuQ09OVEVYVF9JUCAtLTsKIAkJ
ICBpZiAoIXJ2KQogCQkgICAgU2V0VGhyZWFkQ29udGV4dCAoaFRocmVhZCwg
JmNvbnRleHQpOwogCQkgIGlmIChSZWFkUHJvY2Vzc01lbW9yeSAoaFByb2Nl
c3MsICh2b2lkICopY29udGV4dC5DT05URVhUX1NQLCAmcnYsIHNpemVvZihy
diksICZydikpCiAJCSAgICAgIHRocmVhZF9yZXR1cm5fYWRkcmVzc1t0aXhd
ID0gcnY7CisjZW5kaWYKIAkJfQogCSAgICAgIHNldF9zdGVwX3RocmVhZHMg
KGV2ZW50LmR3VGhyZWFkSWQsIHN0ZXBwaW5nX2VuYWJsZWQpOwogCSAgICAg
IC8qRkFMTFRIUlUqLwpAQCAtNDYyLDYgKzUyNyw5IEBAIHJ1bl9wcm9ncmFt
IChjaGFyICpjbWRsaW5lKQogCSAgICAgIG9wY29kZV9jb3VudCsrOwogCSAg
ICAgIHBjID0gKENPTlRFWFRfUkVHKWV2ZW50LnUuRXhjZXB0aW9uLkV4Y2Vw
dGlvblJlY29yZC5FeGNlcHRpb25BZGRyZXNzOwogCSAgICAgIHNwID0gY29u
dGV4dC5DT05URVhUX1NQOworI2lmIGRlZmluZWQoX19hYXJjaDY0X18pCisJ
ICAgICAgbHIgPSBjb250ZXh0LkxyOworI2VuZGlmCiAJICAgICAgaWYgKHRy
YWNpbmdfZW5hYmxlZCkKIAkJZnByaW50ZiAodHJhY2VmaWxlLCBDT05URVhU
X1JFR19GTVQgIiAlMDh4XG4iLCBwYywgKGludClldmVudC5kd1RocmVhZElk
KTsKIAkgICAgICBpZiAodHJhY2VfY29uc29sZSkKQEAgLTQ5MywxMyArNTYx
LDI3IEBAIHJ1bl9wcm9ncmFtIChjaGFyICpjbWRsaW5lKQogCQkgIGlmICgr
K3FxICUgMTAwID09IDApCiAJCSAgICBmcHJpbnRmIChzdGRlcnIsICIgIiBD
T05URVhUX1JFR19GTVQgIiAlZCAlZCBcciIsCiAJCQkgICAgcGMsIG5jYWxs
cywgb3Bjb2RlX2NvdW50KTsKLQorI2lmIGRlZmluZWQoX19hYXJjaDY0X18p
CisJCSAgaWYgKGxyICE9IGxhc3RfbHIgJiYgbHIgPT0gbGFzdF9wYyArIDQp
CisjZWxzZQogCQkgIGlmIChzcCA9PSBsYXN0X3NwLXNpemVvZihDT05URVhU
X1JFRykpCisjZW5kaWYKIAkJICAgIHsKIAkJICAgICAgbmNhbGxzKys7CiAJ
CSAgICAgIHN0b3JlX2NhbGxfZWRnZSAobGFzdF9wYywgcGMpOwogCQkgICAg
ICBpZiAobGFzdF9wYyA8IEtFUk5FTF9BRERSICYmIHBjID4gS0VSTkVMX0FE
RFIpCiAJCQl7CisjaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKwkJCSAgQ09O
VEVYVF9SRUcgcmV0YWRkciA9IGxyOworCQkJICBpZiAodmVyYm9zZSkKKwkJ
CSAgICBwcmludGYgKCJza2lwIGtlcm5lbCBjYWxsOiAiIENPTlRFWFRfUkVH
X0ZNVCAiIC0+ICIgQ09OVEVYVF9SRUdfRk1UICIsIHJldCA9ICIgQ09OVEVY
VF9SRUdfRk1UICJcbiIsCisJCQkJICAgIGxhc3RfcGMsIHBjLCByZXRhZGRy
KTsKKwkJCSAgaWYgKHJldGFkZHIgJiYgcmV0YWRkciA8IEtFUk5FTF9BRERS
KQorCQkJICAgIHsKKwkJCSAgICAgIGFkZF9icmVha3BvaW50IChyZXRhZGRy
KTsKKwkJCSAgICAgIHNldF9zdGVwX3RocmVhZHMgKGV2ZW50LmR3VGhyZWFk
SWQsIDApOworCQkJICAgIH0KKyNlbHNlCiAjaWYgMAogCQkJICBDT05URVhU
X1JFRyByZXRhZGRyOwogCQkJICBTSVpFX1QgcnY7CkBAIC01MTIsNiArNTk0
LDcgQEAgcnVuX3Byb2dyYW0gKGNoYXIgKmNtZGxpbmUpCiAJCQkgIC8qIGV4
cGVyaW1lbnRhbCAtIHRyeSB0byBza2lwIGtlcm5lbCBjYWxscyBmb3Igc3Bl
ZWQgKi8KIAkJCSAgYWRkX2JyZWFrcG9pbnQgKHJldGFkZHIpOwogCQkJICBz
ZXRfc3RlcF90aHJlYWRzIChldmVudC5kd1RocmVhZElkLCAwKTsKKyNlbmRp
ZgogI2VuZGlmCiAJCQl9CiAJCSAgICB9CkBAIC01MjAsNiArNjAzLDkgQEAg
cnVuX3Byb2dyYW0gKGNoYXIgKmNtZGxpbmUpCiAJICAgICAgdG90YWxfY3lj
bGVzKys7CiAJICAgICAgbGFzdF9zcCA9IHNwOwogCSAgICAgIGxhc3RfcGMg
PSBwYzsKKyNpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorCSAgICAgIGxhc3Rf
bHIgPSBscjsKKyNlbmRpZgogCSAgICAgIGlmIChwYyA+PSBsb3dfcGMgJiYg
cGMgPCBoaWdoX3BjKQogCQloaXRzWyhwYyAtIGxvd19wYykvMl0gKys7CiAJ
ICAgICAgYnJlYWs7CkBAIC01MzQsNyArNjIwLDEyIEBAIHJ1bl9wcm9ncmFt
IChjaGFyICpjbWRsaW5lKQogCQkgICAgZHVtcF9yZWdpc3RlcnMgKGhUaHJl
YWQpOwogCQl9CiAJICAgICAgY29udHYgPSBEQkdfRVhDRVBUSU9OX05PVF9I
QU5ETEVEOworI2lmIGRlZmluZWQoX19hYXJjaDY0X18pCisJICAgICAgaWYg
KCFldmVudC51LkV4Y2VwdGlvbi5kd0ZpcnN0Q2hhbmNlKQorCQlydW5uaW5n
ID0gMDsKKyNlbHNlCiAJICAgICAgcnVubmluZyA9IDA7CisjZW5kaWYKIAkg
ICAgICBicmVhazsKIAkgICAgfQogCkBAIC01NDIsMTkgKzYzMywzOSBAQCBy
dW5fcHJvZ3JhbSAoY2hhciAqY21kbGluZSkKIAkgICAgewogCSAgICAgIGlm
IChwYyA9PSB0aHJlYWRfcmV0dXJuX2FkZHJlc3NbdGl4XSkKIAkJeworI2lm
IGRlZmluZWQoX19pMzg2X18pIHx8IGRlZmluZWQoX194ODZfNjRfXykKIAkJ
ICBpZiAoY29udGV4dC5FRmxhZ3MgJiAweDEwMCkKIAkJICAgIHsKIAkJICAg
ICAgY29udGV4dC5FRmxhZ3MgJj0gfjB4MTAwOyAvKiBUUkFQIChzaW5nbGUg
c3RlcCkgZmxhZyAqLwogCQkgICAgICBTZXRUaHJlYWRDb250ZXh0IChoVGhy
ZWFkLCAmY29udGV4dCk7CiAJCSAgICB9CisjZWxpZiBkZWZpbmVkKF9fYWFy
Y2g2NF9fKQorCQkgIGlmIChjb250ZXh0LkNwc3IgJiAweDAwMjAwMDAwKQor
CQkgICAgeworCQkgICAgICBjb250ZXh0LkNwc3IgJj0gfjB4MDAyMDAwMDA7
IC8qIFBTVEFURS5TUyAoc2luZ2xlIHN0ZXApIGZsYWcgKi8KKwkJICAgICAg
U2V0VGhyZWFkQ29udGV4dCAoaFRocmVhZCwgJmNvbnRleHQpOworCQkgICAg
fQorI2Vsc2UKKyNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdl
dAorI2VuZGlmCiAJCX0KIAkgICAgICBlbHNlIGlmIChzdGVwcGluZ19lbmFi
bGVkKQogCQl7CisjaWYgZGVmaW5lZChfX2kzODZfXykgfHwgZGVmaW5lZChf
X3g4Nl82NF9fKQogCQkgIGlmICghKGNvbnRleHQuRUZsYWdzICYgMHgxMDAp
KQogCQkgICAgewogCQkgICAgICBjb250ZXh0LkVGbGFncyB8PSAweDEwMDsg
LyogVFJBUCAoc2luZ2xlIHN0ZXApIGZsYWcgKi8KIAkJICAgICAgU2V0VGhy
ZWFkQ29udGV4dCAoaFRocmVhZCwgJmNvbnRleHQpOwogCQkgICAgfQorI2Vs
aWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKwkJICBpZiAoIShjb250ZXh0LkNw
c3IgJiAweDAwMjAwMDAwKSkKKwkJICAgIHsKKwkJICAgICAgY29udGV4dC5D
cHNyIHw9IDB4MDAyMDAwMDA7IC8qIFBTVEFURS5TUyAoc2luZ2xlIHN0ZXAp
IGZsYWcgKi8KKwkJICAgICAgU2V0VGhyZWFkQ29udGV4dCAoaFRocmVhZCwg
JmNvbnRleHQpOworCQkgICAgfQorI2Vsc2UKKyNlcnJvciB1bmltcGxlbWVu
dGVkIGZvciB0aGlzIHRhcmdldAorI2VuZGlmCiAJCX0KIAkgICAgfQogCSAg
YnJlYWs7CkBAIC05MTgsOCArMTAyOSwyMyBAQCBtYWluIChpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpCiAKICAgZnByaW50ZiAoc3RkZXJyLCAicHJ1bjogWyIg
Q09OVEVYVF9SRUdfRk1UICIsIiBDT05URVhUX1JFR19GTVQgIl0gUnVubmlu
ZyAnJXMnXG4iLAogCSAgbG93X3BjLCBoaWdoX3BjLCBhcmd2W29wdGluZF0p
OwotCi0gIHJ1bl9wcm9ncmFtIChhcmd2W29wdGluZF0pOworICB7CisgICAg
LyogQ3JlYXRlUHJvY2VzcyAoY2FsbGVkIGJlbG93IHdpdGggbHBBcHBsaWNh
dGlvbk5hbWUgPT0gTlVMTCkgaXMKKyAgICAgICBkb2N1bWVudGVkIHRvIG1v
ZGlmeSB0aGUgbHBDb21tYW5kTGluZSBidWZmZXIgaW4gcGxhY2UuICBhcmd2
W29wdGluZF0KKyAgICAgICBwb2ludHMgaW50byBvdXIgb3duIGFyZ3YsIHNv
IHBhc3NpbmcgaXQgZGlyZWN0bHkgbGV0cyBDcmVhdGVQcm9jZXNzCisgICAg
ICAgc2NyaWJibGUgb24gaXQ7IHRoaXMgd2FzIG9ic2VydmVkIG9uIGFhcmNo
NjQtY3lnd2luIGFzIHRoZSBjb21tYW5kCisgICAgICAgbGluZSBjb21pbmcg
YmFjayBtYW5nbGVkIChlLmcuICd0ZXN0X2hlbGxvLmV4ZScgLT4gJ3N0X2hl
bGxvLmV4eGVlJykKKyAgICAgICBvbiBsYXRlciB1c2UuICBQYXNzIGEgcHJp
dmF0ZSB3cml0YWJsZSBjb3B5IGluc3RlYWQuICBJdCBpcyBub3QgZnJlZWQK
KyAgICAgICBiZWNhdXNlIHJ1bl9wcm9ncmFtKCkgc3RvcmVzIGl0IGluIGRs
bF9pbmZvWzBdLm5hbWUsIHdoaWNoIGlzIHJlYWQKKyAgICAgICBsYXRlciB3
aGVuIHByaW50aW5nIHRoZSBETEwtcHJvZmlsZSB0YWJsZS4gICovCisgICAg
Y2hhciAqY21kbGluZV9jb3B5ID0gc3RyZHVwIChhcmd2W29wdGluZF0pOwor
ICAgIGlmICghY21kbGluZV9jb3B5KQorICAgICAgeworCWZwcmludGYgKHN0
ZGVyciwgIk91dCBvZiBtZW1vcnkgZHVwbGljYXRpbmcgY21kbGluZVxuIik7
CisJZXhpdCAoMSk7CisgICAgICB9CisgICAgcnVuX3Byb2dyYW0gKGNtZGxp
bmVfY29weSk7CisgIH0KIAogICBoZHIubHBjID0gbG93X3BjOwogICBoZHIu
aHBjID0gaGlnaF9wYzsKQEAgLTkzNSw3ICsxMDYxLDcgQEAgbWFpbiAoaW50
IGFyZ2MsIGNoYXIgKiphcmd2KQogCiAgIGlmIChkbGxfY291bnRzKQogICAg
IHsKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9f
KSB8fCBkZWZpbmVkKF9fYWFyY2g2NF9fKQogICAgICAgLyogICAgICAgMTIz
NDU2NyAxMjMlIDEyMzQ1NjcgMTIzJSAxMjM0NTY3ODEyMzQ1Njc4IHh4eHh4
eHh4eHh4ICovCiAgICAgICBwcmludGYgKCIgTWFpbi1UaHJlYWQgT3RoZXIt
VGhyZWFkIEJhc2VBZGRyICAgICAgICAgRExMIE5hbWVcbiIpOwogI2Vsc2UK
LS0gCjIuNDkuMC53aW5kb3dzLjEKCg==

--_004_PN0P287MB0295F1D93B25FA3B90293E35921C2PN0P287MB0295INDP_--

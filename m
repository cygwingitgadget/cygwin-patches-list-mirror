Return-Path: <SRS0=Jf1Q=GL=multicorewareinc.com=aswin.kalies@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id D33FE4BA540B
	for <cygwin-patches@cygwin.com>; Tue, 18 Aug 2026 08:35:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D33FE4BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D33FE4BA540B
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1787042148; cv=pass;
	b=ZZTJZrBkSnX0JeQsinr08ue4hkRHBk9Gsib85dj2YVqAfzacLEZWjle91X49lzFy4suTMj0dYxKw9zymi2tuJ/l5AWAhinVupbw+5vw5D1B5rZJw5nW36Ea5yey/L79TPwSO0HwTPNv+B88ogHTOqbW+ZjnHgGiXfUKabkfvu6Y=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787042148; c=relaxed/simple;
	bh=Od6/iYIXbuQww8uzUPMEn5d2hCV5KWLU5lDMimewhQU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=YmYEGnj4nRKYoSWpL4ai7TC1uq9wv0nW9JbYdcoSsy7cB6nj3jKYZKVZS1xwgN8TchcNHyIe5kdJVPrhKVwcOstSxC0BNLAzQxL1RQV5jtRVMzFEUH0H7K3VMrzPgcB1NsYA3y7bNTchRArAvbMXVY+r4xwm5OKhKCwFuQNvuUM=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=jojlM8v6
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D33FE4BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=jojlM8v6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVZlDInP+KkxZERFYBxSo3etQoWQULnCRsbzqEtMJcBh/TiXqYKYKHfFhnHunby9Emukkcoxr5bjo38n+4rMTho7mWSYCfxJQS/qcaGiOQ1t7i69qBFvCkvlWnB0IiKGjWmhBzAGaMxc447wBcnj0GC0EmUwoyRssCuRFOuFiJ6dbylHVOTxv54OGYfZK/VgzLs/NOjvAp4TEmPAjR3ltInIydZCTB7rCcembLDDdgGJFv2I+xDfr7yPs5TZQnQ4QZcOxSQTDfIuOcXoeLs0N85SDYi6aZjeX+HsKjFi5R49zLkOVxC3nTxmJAL0w1nTuNLxUrI+Wdl+lGrrIcSydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxFAkkMSq2SEVCrJFpoJ9RJJQALvH6gaTxZpTr889oE=;
 b=owM/oLqo4dWgYwWNtf5lm9uobvPqbNl7sqJg7JJ0C3DuNkjEGl+QBEiZZM+cKAfwRoADwD0DElIZwFISahcOhhiDTD+F3h9vbHDTy6vCaiLeE5NQbswQvAQvZl74pAeusxydt5LWsPIQb4kaWB21/ikwhEyEUUswoEcSdsUDyRHNvRjtccq4vL7I4OGegWVKEBFA78uDfIBBcoRIzC5M+Noau1XqcAPEAK9zv/jlomQzCWckD9E/g3MAaldYSzy/I3xUn6qmG/Xs3rxXiUOm79X4dxlIlIafTE2cP6mg6vDe1vwF7h9YAC7Tc+CrZjaLMi1XaqAlFrPI3tG0y4RiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxFAkkMSq2SEVCrJFpoJ9RJJQALvH6gaTxZpTr889oE=;
 b=jojlM8v6OmqQ9+nHS+qXbyOmbaa6Y8syP8IF7Txu+hI7xu2SBQIu2BQ5AAPYottxSw7D+q56krXYC9GFBmjn3jl3DGYnIl8frz3YadKGhIF4YcFLlmWsXY9gZLx9hp0oUy1VRk8OgGIhQkG38NHP6AbeZkcKie3bLninmUheQ/XDWOMVEld/4Zb82FexwIj4WLAOmoqFKRDG6JfAxR2gmn/L0ljHsTgabtLb7L4FZDrgFwYHo1Sub9k7v6GbjWjCZUPM958IRQQhw5xw5wRs4NRn1IsX6YQf7R5cK68vuEWkRBIM+HAGlsgSkkzkBzcNGyL4rf7NoFrR2eYMEy7XbQ==
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:193::14)
 by MA0P287MB1792.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 08:35:41 +0000
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b]) by PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 08:35:40 +0000
From: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: autoload: drop the unused no_resolve_on_fork
 parameter
Thread-Topic: [PATCH] Cygwin: autoload: drop the unused no_resolve_on_fork
 parameter
Thread-Index: AQHdLust/7rWN5NIIkiSa2YonW37aQ==
Date: Tue, 18 Aug 2026 08:35:40 +0000
Message-ID:
 <PN3P287MB13209A14DE960126F3311558F7A62@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1320:EE_|MA0P287MB1792:EE_
x-ms-office365-filtering-correlation-id: aece75b6-b17e-4535-ede9-08defd03afc0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|6049299003|1800799024|366016|39142699007|31052699007|18002099003|55112099003|56012099006|8096899003|4053099003|13003099007|38070700021|6133799003|5023799004|10067099003;
x-microsoft-antispam-message-info:
 Yflnp8zVWXRHpw1CqnRVnQldERD3Lpp637BsT7PUT5K0s53W25dVd9Dz3tk0KvEvNx3N0ViMNuS7qscqy2o1lkpvBsBNA1nCCXIgFFrO81uXFf3XpfeWo43tUTtPqiN3PcDet2N78qIzwgGKaAHGa6XFfN2zbJ/8y/pEpVNks1fa4+JkXgO6tmBhRnrpK6hAvC94AQr3ljV2IW6BPAGlSPIJyG6AdOOB4Ox/3D7xkWqJVWnr+p2JYh7uGJcsxzHg12atbpmio4AKfbrHbboN/6RENITpAbqyPkFkCvKRwKnoVMLDEb8D6Ef0yIzmxI5s2s+r427/8OVzaPEi75Njb8Lw8rG84VV1dEYWcowdzwN3GvuRX10Wk4JIL9SnoJZnrMLwj+aRvNHPbuLhd3WsmKUDS8+W5WVEoWGT0pm+q6ddW+A/9+cdSC3zWB1uDtfHxZZaLV36zdKTG79xr7T3rn5iPN5QvU4ND/1CDRZCn9GJzqIaztI7+ItB3VV6KE9ILOoqGxzwPxpOdNYumc1J67V3KkxDnRV/jwBHir4nHQJsckJyq1N6ekT53AOec0OAjXysttBpTHvXjrLAumkxcC2Kljn3seKZwY+LhOGEvRtN9RS7gmlOjz1gT6KQqco1TD1boLhPzEaF8oiKj9iUaH03B5BMTwgRyTxWuzYOcbGz1yZxOB4WsX0Xk80poz5C
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1320.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(6049299003)(1800799024)(366016)(39142699007)(31052699007)(18002099003)(55112099003)(56012099006)(8096899003)(4053099003)(13003099007)(38070700021)(6133799003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NxULeshdp8SGR4gqpp2+nG5y668wAiGYIAUdaPBGKzxY4nXdDeqJgiMPgd?=
 =?iso-8859-1?Q?XuNhY+JsEyxLzGbz9mNlWaxeKIufzeA0HJIpgTN/pUDOzXqMyat/0SKGZJ?=
 =?iso-8859-1?Q?qOyGCuD56eFveRJmE6SAxb9ZZKSy77LM9SXk4kgjJQcP8cL7EjgUiVjtuA?=
 =?iso-8859-1?Q?xGfvduj7cP4UnLuiKsYK4fq/eFkJr6Bhm1e+Iy1hvQH9It8rT4nTtyOtnQ?=
 =?iso-8859-1?Q?ynz8BxHu+Wp/IYT1C5xHMBhDeMcYX7uc7g3fZR6RFB78Dg0LD4RCJ74Ec5?=
 =?iso-8859-1?Q?uQshQ2FWGSby//dpVevgvVaPz4oAzClye60ME2iI6NUZuym+dN4MoHrlPd?=
 =?iso-8859-1?Q?GcSayiqtYUsEzmC0KYiuM8OTBJVunylenukEQ7pXEdU14k2vmiEN5so7C1?=
 =?iso-8859-1?Q?LMil3UCelBCnGB/FZxc6UIOzynMKzuwbrXh4ffHMVaLE8lX9sdTRoudQ0T?=
 =?iso-8859-1?Q?NiCqiC2XjD+P9ww6HfIc5IqL5dZWLwOYlyutgnlkdTQkTgGaejP3KVwmRu?=
 =?iso-8859-1?Q?k7Lm/W1ueFCpkC2/eNfnQokXDH3s6WAGFE8PXZbgOVSczgB9nHCjMWFO6i?=
 =?iso-8859-1?Q?HI0P8qUst9lvKelJXhwCEyP+s2BzOLgJ1Cks4ewj/R0B8ToZsxqx+xodts?=
 =?iso-8859-1?Q?+GRySDD3HEm3VjSqiSImShfwgzwwTHLqxzerdN6m2ot5ChgsCHff07nm2l?=
 =?iso-8859-1?Q?Gb+gTbRqZiUf+2pT/SAd5fMH7KdSCiiSV2UewXsDZT02H2ndYrPS03QCJB?=
 =?iso-8859-1?Q?Uy8qxfKOlHoBGsbd68gJXJyC5PV0ITsD0iNSO7pMA+OfdjnoGCqfQoZqJj?=
 =?iso-8859-1?Q?3L1JJOBiqCaCwLx6eh5IEQKCeeFwAXPQhTF6WFdn31eaUmrgtCTIGu1GCT?=
 =?iso-8859-1?Q?0SzWj64BbM0GHUBMS6+/TKSksJksLdUr8KS6+55Mmdi39OXHBt1l/7I3KT?=
 =?iso-8859-1?Q?mCqBQAM4NJmCJ14wGv/vqFNq3gYXH0lfbSck3zU9zVNXNfpTVqwXGGIwZi?=
 =?iso-8859-1?Q?o4HeYCtTj/mDVi04qASjnHZaAVzUH/04ncLvk5DNel329b3Ghg/ZbSh+YR?=
 =?iso-8859-1?Q?3Ao9plWgccKsUN2fGkvstFu7E1biLqcuxB8mylHWSNf8MZq8kgguVphe0o?=
 =?iso-8859-1?Q?Uadjc4KkiWM6ELV/WIkWZGX8XA983FfYg4uhnbhaeON/TIqIufRpIEP6yF?=
 =?iso-8859-1?Q?PKgqDTH/RsN3mMiHoLvRREK74F0uTjvA4TA0ojOUh/KYNOkZ/Xr6hDGC5T?=
 =?iso-8859-1?Q?A5GPshZ70GDfM5IXabhjMgPyYU+EJ8VT3KqBXGkHYdfaT+/+D0FcksGuyM?=
 =?iso-8859-1?Q?ox5G9RAzJm04n0OXuAkWSJ+Fhlpe5oA/EtDK1co2Xeime20zfa6xcNpBHt?=
 =?iso-8859-1?Q?mbT6v6kl9IhgvGHMbHkG8LYNY93nTXbomTVf4N5eUre8DHas/71P6Zi1Mp?=
 =?iso-8859-1?Q?zboHjF+gZhHjj47u7hFoBmjdiE6CFIo8Zgb3vfoGQ8d+8y0LO3wifzrxt8?=
 =?iso-8859-1?Q?Nklow+APlvT6GmsOXescCanIKNdSg4QN+HVSe9GrpF5CH1ZwYFL+djzTiz?=
 =?iso-8859-1?Q?Db3DQnWrgWL/5H7El0cEo68ANLJxw2a5w2hZMb09x9Xrv/zQkkACXU2RrO?=
 =?iso-8859-1?Q?Z9SAjKB627gYPcyq8xXiyuHHSjaYzqPJdYvYYl22kl/IRLGppX20aar6ue?=
 =?iso-8859-1?Q?h2C+BIoNciVbkqZW0z/doL4PkPtVElqMv9ASviK76H7DUJkGo40llWjprt?=
 =?iso-8859-1?Q?RqkFCXpW5pNE9VC3aYLfVT/iK9G4azPw5ffgErUi70H3DYD+/YWH7qpZmG?=
 =?iso-8859-1?Q?VUsGFe7w8Oj5OxaytIDG1IGG7hOC1Vw=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB13209A14DE960126F3311558F7A62PN3P287MB1320INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aece75b6-b17e-4535-ede9-08defd03afc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 08:35:40.8002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +d8y4tXTelZjBGszrLAbnJ39m5maoBAQtNYiMskWB4TKoWLTtfS0wewEaVYnxKaJpo35NAt7eZnAwJwBLAN+2Hxf2Kqk+vfrwUq9BKbR+sjpsEjaAbEwvhr7ZoSDXblz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1792
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB13209A14DE960126F3311558F7A62PN3P287MB1320INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB13209A14DE960126F3311558F7A62PN3P287MB1320INDP_"

--_000_PN3P287MB13209A14DE960126F3311558F7A62PN3P287MB1320INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

This is the second half of the split you asked for in
https://cygwin.com/pipermail/cygwin-patches/2026q3/015146.html

You wrote:

> the "fix ws2_32 chained init on AArch64" part of this looks
> reasonable and doesn't seem to be connected. Can you submit that
> as a separate patch?

The ws2_32 half went out separately as
https://cygwin.com/pipermail/cygwin-patches/2026q3/015160.html
This patch is the remaining part: removing the no_resolve_on_fork
macro parameter.  It carries no ws2_32 changes and does not depend
on that patch; the two can go in in either order.

On the earlier thread we said the flag was never consumed but did
not identify when that became true.  It was commit 105f79b489d5
("Drop use_dont_resolve_hack flag", Jun 2016), which removed the
only reader:

  if (!h && handle && wincap.use_dont_resolve_hack ()
      && GetLastError () =3D=3D ERROR_INVALID_ADDRESS)
    h =3D LoadLibraryExW (dll_path, NULL, DONT_RESOLVE_DLL_REFERENCES);

The "&& handle" there was what the sentinel fed.  Once that went,
the only remaining reader of the field became

  else if ((uintptr_t) dll->handle <=3D 1)

in std_dll_init, which treats 1 exactly as it treats 0.  So the
nineteen winmm entries primed with 1 behave identically to every
other DLL, and nothing else in the tree examines the field.

The patch drops the parameter, initialises the slot to 0
unconditionally, and simplifies the two tests to !dll->handle,
which is equivalent once the field can no longer hold 1.  No
functional change.

Thanks and Regards,
Aswin Kalies

Inline patch

---
 winsup/cygwin/autoload.cc | 58 +++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index 7054511b6..37c4a3438 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -85,13 +85,13 @@ bool NO_COPY wsock_started;
    The macro WORD64 stands in for .quad/.xword, and .balign (which means
    "align to N bytes" on all targets, unlike .align) is used for
    alignment.  */
-#define LoadDLLprime(dllname, init_also, no_resolve_on_fork) __asm__ ("\n\
+#define LoadDLLprime(dllname, init_also) __asm__ ("\n\
 .ifndef " #dllname "_primed                              \n\
   .section   .data_cygwin_nocopy,\"w\"                   \n\
   .balign    8                                           \n\
 ." #dllname "_info:                                      \n\
   " WORD64 "   _std_dll_init                             \n\
-  " WORD64 "   " #no_resolve_on_fork "                   \n\
+  " WORD64 "   0                                         \n\
   .long      -1                                          \n\
   .balign    8                                           \n\
   " WORD64 "   " #init_also "                            \n\
@@ -108,12 +108,12 @@ bool NO_COPY wsock_started;
 #define LoadDLLfuncEx(name, dllname, notimp) \
   LoadDLLfuncEx2(name, dllname, notimp, 0)
 #define LoadDLLfuncEx2(name, dllname, notimp, err) \
-  LoadDLLfuncEx3(name, dllname, notimp, err, 0)
+  LoadDLLfuncEx3(name, dllname, notimp, err)

 /* Main DLL setup stuff. */
 #if defined(__x86_64__)
-#define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
-  LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) \
+#define LoadDLLfuncEx3(name, dllname, notimp, err) \
+  LoadDLLprime (dllname, dll_func_load) \
   __asm__ ("           \n\
   .section ." #dllname "_autoload_text,\"wx\"  \n\
   .global  " #name "       \n\
@@ -138,8 +138,8 @@ _win32_" #name ":         \n\
   .text              \n\
 ");
 #elif defined(__aarch64__)
-#define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
-  LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) \
+#define LoadDLLfuncEx3(name, dllname, notimp, err) \
+  LoadDLLprime (dllname, dll_func_load) \
   __asm__ ( "\n\
   .section   ." #dllname "_autoload_text,\"wx\"          \n\
   .global    " #name "                                   \n\
@@ -438,7 +438,7 @@ std_dll_init (struct func_info *func)
  yield ();
       }
     while (InterlockedIncrement (&dll->here));
-  else if ((uintptr_t) dll->handle <=3D 1)
+  else if (!dll->handle)
     {
       fenv_t fpuenv;
       fegetenv (&fpuenv);
@@ -461,7 +461,7 @@ std_dll_init (struct func_info *func)
    if (i < RETRY_COUNT)
      yield ();
  }
-      if ((uintptr_t) dll->handle <=3D 1)
+      if (!dll->handle)
  {
    if ((func->decoration & 1))
      dll->handle =3D INVALID_HANDLE_VALUE;
@@ -534,7 +534,7 @@ wsock_init (struct func_info *func)
   return ret.ll;
 }

-LoadDLLprime (ws2_32, _wsock_init, 0)
+LoadDLLprime (ws2_32, _wsock_init)

 LoadDLLfunc (CheckTokenMembership, advapi32)
 LoadDLLfunc (CreateProcessAsUserW, advapi32)
@@ -711,25 +711,25 @@ LoadDLLfuncEx2 (CreateProfile, userenv, 1, 1)
 LoadDLLfunc (DestroyEnvironmentBlock, userenv)
 LoadDLLfunc (LoadUserProfileW, userenv)

-LoadDLLfuncEx3 (waveInAddBuffer, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInClose, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInGetNumDevs, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInOpen, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInPrepareHeader, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInReset, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInStart, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveInUnprepareHeader, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutClose, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutGetNumDevs, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutGetVolume, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutOpen, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutPrepareHeader, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutReset, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutSetVolume, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutUnprepareHeader, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutWrite, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutMessage, winmm, 1, 0, 1)
-LoadDLLfuncEx3 (waveOutGetDevCapsA, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (waveInAddBuffer, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInClose, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInGetNumDevs, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInOpen, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInPrepareHeader, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInReset, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInStart, winmm, 1, 0)
+LoadDLLfuncEx3 (waveInUnprepareHeader, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutClose, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutGetNumDevs, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutGetVolume, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutOpen, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutPrepareHeader, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutReset, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutSetVolume, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutUnprepareHeader, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutWrite, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutMessage, winmm, 1, 0)
+LoadDLLfuncEx3 (waveOutGetDevCapsA, winmm, 1, 0)

 LoadDLLfunc (accept, ws2_32)
 LoadDLLfunc (bind, ws2_32)
--
2.49.0.windows.1




--_000_PN3P287MB13209A14DE960126F3311558F7A62PN3P287MB1320INDP_--

--_004_PN3P287MB13209A14DE960126F3311558F7A62PN3P287MB1320INDP_
Content-Type: application/octet-stream;
	name="cygwin-autoload-drop-no_resolve_on_fork.patch"
Content-Description: cygwin-autoload-drop-no_resolve_on_fork.patch
Content-Disposition: attachment;
	filename="cygwin-autoload-drop-no_resolve_on_fork.patch"; size=6509;
	creation-date="Tue, 18 Aug 2026 08:31:58 GMT";
	modification-date="Tue, 18 Aug 2026 08:32:46 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkNDQ0MTgzMzNlNWUwNDc2OTRiMmJmODgwYzUwZGY2NWFhNTA1YThk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBc3dpbiBLYWxpZXMg
UmFta3VtYXIgTWFuZ2F5YXJrYXJhc2kgPGFzd2luLmthbGllc0BtdWx0aWNv
cmV3YXJlaW5jLmNvbT4KRGF0ZTogVHVlLCAxOCBBdWcgMjAyNiAxMDowOToy
NyArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogYXV0b2xvYWQ6IGRy
b3AgdGhlIHVudXNlZCBub19yZXNvbHZlX29uX2ZvcmsKIHBhcmFtZXRlcgoK
VGhlIHNlY29uZCB3b3JkIG9mIGVhY2ggRExMIGluZm8gYmxvY2sgaXMgaW5p
dGlhbGlzZWQgZnJvbSB0aGUKbm9fcmVzb2x2ZV9vbl9mb3JrIG1hY3JvIHBh
cmFtZXRlciBhbmQgbGFuZHMgaW4gZGxsX2luZm86OmhhbmRsZS4gIEl0cwpv
bmx5IGNvbnN1bWVyIHdhcyB0aGUgRE9OVF9SRVNPTFZFX0RMTF9SRUZFUkVO
Q0VTIHJldHJ5IGluIGRsbF9sb2FkLAoKICBpZiAoIWggJiYgaGFuZGxlICYm
IHdpbmNhcC51c2VfZG9udF9yZXNvbHZlX2hhY2sgKCkKICAgICAgJiYgR2V0
TGFzdEVycm9yICgpID09IEVSUk9SX0lOVkFMSURfQUREUkVTUykKICAgIGgg
PSBMb2FkTGlicmFyeUV4VyAoZGxsX3BhdGgsIE5VTEwsIERPTlRfUkVTT0xW
RV9ETExfUkVGRVJFTkNFUyk7Cgp3aGljaCBjb21taXQgMTA1Zjc5YjQ4OWQ1
ICgiRHJvcCB1c2VfZG9udF9yZXNvbHZlX2hhY2sgZmxhZyIpIHJlbW92ZWQg
aW4KMjAxNi4gIFRoZSB2YWx1ZSBoYXMgYmVlbiBkZWFkIGV2ZXIgc2luY2U6
IHRoZSBuaW5ldGVlbiB3aW5tbSBlbnRyaWVzCmFyZSB0aGUgb25seSBvbmVz
IHByaW1lZCB3aXRoIDEsIGFuZCB0aGUgc29sZSByZW1haW5pbmcgdGVzdCwK
CiAgZWxzZSBpZiAoKHVpbnRwdHJfdCkgZGxsLT5oYW5kbGUgPD0gMSkKCmlu
IHN0ZF9kbGxfaW5pdCwgdHJlYXRzIDEgZXhhY3RseSBhcyBpdCB0cmVhdHMg
MCwgc28gdGhvc2UgZW50cmllcwpiZWhhdmUgaWRlbnRpY2FsbHkgdG8gZXZl
cnkgb3RoZXIgRExMLgoKRHJvcCB0aGUgcGFyYW1ldGVyIGZyb20gTG9hZERM
THByaW1lIGFuZCBMb2FkRExMZnVuY0V4MywgaW5pdGlhbGlzZSB0aGUKc2xv
dCB0byAwIHVuY29uZGl0aW9uYWxseSwgYW5kIHNpbXBsaWZ5IHRoZSB0d28g
dGVzdHMgdG8gIWRsbC0+aGFuZGxlCm5vdyB0aGF0IHRoZSBmaWVsZCBjYW4g
bmV2ZXIgaG9sZCAxLgoKTm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpTaWduZWQt
b2ZmLWJ5OiBBc3dpbiBLYWxpZXMgPGFzd2luLmthbGllc0BtdWx0aWNvcmV3
YXJlaW5jLmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL2F1dG9sb2FkLmNjIHwg
NTggKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9hdXRvbG9hZC5jYyBi
L3dpbnN1cC9jeWd3aW4vYXV0b2xvYWQuY2MKaW5kZXggNzA1NDUxMWI2Li4z
N2M0YTM0MzggMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vYXV0b2xvYWQu
Y2MKKysrIGIvd2luc3VwL2N5Z3dpbi9hdXRvbG9hZC5jYwpAQCAtODUsMTMg
Kzg1LDEzIEBAIGJvb2wgTk9fQ09QWSB3c29ja19zdGFydGVkOwogICAgVGhl
IG1hY3JvIFdPUkQ2NCBzdGFuZHMgaW4gZm9yIC5xdWFkLy54d29yZCwgYW5k
IC5iYWxpZ24gKHdoaWNoIG1lYW5zCiAgICAiYWxpZ24gdG8gTiBieXRlcyIg
b24gYWxsIHRhcmdldHMsIHVubGlrZSAuYWxpZ24pIGlzIHVzZWQgZm9yCiAg
ICBhbGlnbm1lbnQuICAqLwotI2RlZmluZSBMb2FkRExMcHJpbWUoZGxsbmFt
ZSwgaW5pdF9hbHNvLCBub19yZXNvbHZlX29uX2ZvcmspIF9fYXNtX18gKCJc
blwKKyNkZWZpbmUgTG9hZERMTHByaW1lKGRsbG5hbWUsIGluaXRfYWxzbykg
X19hc21fXyAoIlxuXAogLmlmbmRlZiAiICNkbGxuYW1lICJfcHJpbWVkICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCiAgIC5zZWN0aW9uICAg
LmRhdGFfY3lnd2luX25vY29weSxcIndcIiAgICAgICAgICAgICAgICAgICBc
blwKICAgLmJhbGlnbiAgICA4ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFxuXAogLiIgI2RsbG5hbWUgIl9pbmZvOiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCiAgICIgV09S
RDY0ICIgICBfc3RkX2RsbF9pbml0ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcblwKLSAgIiBXT1JENjQgIiAgICIgI25vX3Jlc29sdmVfb25fZm9y
ayAiICAgICAgICAgICAgICAgICAgIFxuXAorICAiIFdPUkQ2NCAiICAgMCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCiAg
IC5sb25nICAgICAgLTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcblwKICAgLmJhbGlnbiAgICA4ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAogICAiIFdPUkQ2NCAi
ICAgIiAjaW5pdF9hbHNvICIgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XG5cCkBAIC0xMDgsMTIgKzEwOCwxMiBAQCBib29sIE5PX0NPUFkgd3NvY2tf
c3RhcnRlZDsKICNkZWZpbmUgTG9hZERMTGZ1bmNFeChuYW1lLCBkbGxuYW1l
LCBub3RpbXApIFwKICAgTG9hZERMTGZ1bmNFeDIobmFtZSwgZGxsbmFtZSwg
bm90aW1wLCAwKQogI2RlZmluZSBMb2FkRExMZnVuY0V4MihuYW1lLCBkbGxu
YW1lLCBub3RpbXAsIGVycikgXAotICBMb2FkRExMZnVuY0V4MyhuYW1lLCBk
bGxuYW1lLCBub3RpbXAsIGVyciwgMCkKKyAgTG9hZERMTGZ1bmNFeDMobmFt
ZSwgZGxsbmFtZSwgbm90aW1wLCBlcnIpCiAKIC8qIE1haW4gRExMIHNldHVw
IHN0dWZmLiAqLwogI2lmIGRlZmluZWQoX194ODZfNjRfXykKLSNkZWZpbmUg
TG9hZERMTGZ1bmNFeDMobmFtZSwgZGxsbmFtZSwgbm90aW1wLCBlcnIsIG5v
X3Jlc29sdmVfb25fZm9yaykgXAotICBMb2FkRExMcHJpbWUgKGRsbG5hbWUs
IGRsbF9mdW5jX2xvYWQsIG5vX3Jlc29sdmVfb25fZm9yaykgXAorI2RlZmlu
ZSBMb2FkRExMZnVuY0V4MyhuYW1lLCBkbGxuYW1lLCBub3RpbXAsIGVycikg
XAorICBMb2FkRExMcHJpbWUgKGRsbG5hbWUsIGRsbF9mdW5jX2xvYWQpIFwK
ICAgX19hc21fXyAoIgkJCQkJCVxuXAogICAuc2VjdGlvbgkuIiAjZGxsbmFt
ZSAiX2F1dG9sb2FkX3RleHQsXCJ3eFwiCVxuXAogICAuZ2xvYmFsCSIgI25h
bWUgIgkJCQlcblwKQEAgLTEzOCw4ICsxMzgsOCBAQCBfd2luMzJfIiAjbmFt
ZSAiOgkJCQkJXG5cCiAgIC50ZXh0CQkJCQkJCVxuXAogIik7CiAjZWxpZiBk
ZWZpbmVkKF9fYWFyY2g2NF9fKQotI2RlZmluZSBMb2FkRExMZnVuY0V4Myhu
YW1lLCBkbGxuYW1lLCBub3RpbXAsIGVyciwgbm9fcmVzb2x2ZV9vbl9mb3Jr
KSBcCi0gIExvYWRETExwcmltZSAoZGxsbmFtZSwgZGxsX2Z1bmNfbG9hZCwg
bm9fcmVzb2x2ZV9vbl9mb3JrKSBcCisjZGVmaW5lIExvYWRETExmdW5jRXgz
KG5hbWUsIGRsbG5hbWUsIG5vdGltcCwgZXJyKSBcCisgIExvYWRETExwcmlt
ZSAoZGxsbmFtZSwgZGxsX2Z1bmNfbG9hZCkgXAogICBfX2FzbV9fICggIlxu
XAogICAuc2VjdGlvbiAgIC4iICNkbGxuYW1lICJfYXV0b2xvYWRfdGV4dCxc
Ind4XCIgICAgICAgICAgXG5cCiAgIC5nbG9iYWwgICAgIiAjbmFtZSAiICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcblwKQEAgLTQzOCw3
ICs0MzgsNyBAQCBzdGRfZGxsX2luaXQgKHN0cnVjdCBmdW5jX2luZm8gKmZ1
bmMpCiAJeWllbGQgKCk7CiAgICAgICB9CiAgICAgd2hpbGUgKEludGVybG9j
a2VkSW5jcmVtZW50ICgmZGxsLT5oZXJlKSk7Ci0gIGVsc2UgaWYgKCh1aW50
cHRyX3QpIGRsbC0+aGFuZGxlIDw9IDEpCisgIGVsc2UgaWYgKCFkbGwtPmhh
bmRsZSkKICAgICB7CiAgICAgICBmZW52X3QgZnB1ZW52OwogICAgICAgZmVn
ZXRlbnYgKCZmcHVlbnYpOwpAQCAtNDYxLDcgKzQ2MSw3IEBAIHN0ZF9kbGxf
aW5pdCAoc3RydWN0IGZ1bmNfaW5mbyAqZnVuYykKIAkgIGlmIChpIDwgUkVU
UllfQ09VTlQpCiAJICAgIHlpZWxkICgpOwogCX0KLSAgICAgIGlmICgodWlu
dHB0cl90KSBkbGwtPmhhbmRsZSA8PSAxKQorICAgICAgaWYgKCFkbGwtPmhh
bmRsZSkKIAl7CiAJICBpZiAoKGZ1bmMtPmRlY29yYXRpb24gJiAxKSkKIAkg
ICAgZGxsLT5oYW5kbGUgPSBJTlZBTElEX0hBTkRMRV9WQUxVRTsKQEAgLTUz
NCw3ICs1MzQsNyBAQCB3c29ja19pbml0IChzdHJ1Y3QgZnVuY19pbmZvICpm
dW5jKQogICByZXR1cm4gcmV0LmxsOwogfQogCi1Mb2FkRExMcHJpbWUgKHdz
Ml8zMiwgX3dzb2NrX2luaXQsIDApCitMb2FkRExMcHJpbWUgKHdzMl8zMiwg
X3dzb2NrX2luaXQpCiAKIExvYWRETExmdW5jIChDaGVja1Rva2VuTWVtYmVy
c2hpcCwgYWR2YXBpMzIpCiBMb2FkRExMZnVuYyAoQ3JlYXRlUHJvY2Vzc0Fz
VXNlclcsIGFkdmFwaTMyKQpAQCAtNzExLDI1ICs3MTEsMjUgQEAgTG9hZERM
TGZ1bmNFeDIgKENyZWF0ZVByb2ZpbGUsIHVzZXJlbnYsIDEsIDEpCiBMb2Fk
RExMZnVuYyAoRGVzdHJveUVudmlyb25tZW50QmxvY2ssIHVzZXJlbnYpCiBM
b2FkRExMZnVuYyAoTG9hZFVzZXJQcm9maWxlVywgdXNlcmVudikKIAotTG9h
ZERMTGZ1bmNFeDMgKHdhdmVJbkFkZEJ1ZmZlciwgd2lubW0sIDEsIDAsIDEp
Ci1Mb2FkRExMZnVuY0V4MyAod2F2ZUluQ2xvc2UsIHdpbm1tLCAxLCAwLCAx
KQotTG9hZERMTGZ1bmNFeDMgKHdhdmVJbkdldE51bURldnMsIHdpbm1tLCAx
LCAwLCAxKQotTG9hZERMTGZ1bmNFeDMgKHdhdmVJbk9wZW4sIHdpbm1tLCAx
LCAwLCAxKQotTG9hZERMTGZ1bmNFeDMgKHdhdmVJblByZXBhcmVIZWFkZXIs
IHdpbm1tLCAxLCAwLCAxKQotTG9hZERMTGZ1bmNFeDMgKHdhdmVJblJlc2V0
LCB3aW5tbSwgMSwgMCwgMSkKLUxvYWRETExmdW5jRXgzICh3YXZlSW5TdGFy
dCwgd2lubW0sIDEsIDAsIDEpCi1Mb2FkRExMZnVuY0V4MyAod2F2ZUluVW5w
cmVwYXJlSGVhZGVyLCB3aW5tbSwgMSwgMCwgMSkKLUxvYWRETExmdW5jRXgz
ICh3YXZlT3V0Q2xvc2UsIHdpbm1tLCAxLCAwLCAxKQotTG9hZERMTGZ1bmNF
eDMgKHdhdmVPdXRHZXROdW1EZXZzLCB3aW5tbSwgMSwgMCwgMSkKLUxvYWRE
TExmdW5jRXgzICh3YXZlT3V0R2V0Vm9sdW1lLCB3aW5tbSwgMSwgMCwgMSkK
LUxvYWRETExmdW5jRXgzICh3YXZlT3V0T3Blbiwgd2lubW0sIDEsIDAsIDEp
Ci1Mb2FkRExMZnVuY0V4MyAod2F2ZU91dFByZXBhcmVIZWFkZXIsIHdpbm1t
LCAxLCAwLCAxKQotTG9hZERMTGZ1bmNFeDMgKHdhdmVPdXRSZXNldCwgd2lu
bW0sIDEsIDAsIDEpCi1Mb2FkRExMZnVuY0V4MyAod2F2ZU91dFNldFZvbHVt
ZSwgd2lubW0sIDEsIDAsIDEpCi1Mb2FkRExMZnVuY0V4MyAod2F2ZU91dFVu
cHJlcGFyZUhlYWRlciwgd2lubW0sIDEsIDAsIDEpCi1Mb2FkRExMZnVuY0V4
MyAod2F2ZU91dFdyaXRlLCB3aW5tbSwgMSwgMCwgMSkKLUxvYWRETExmdW5j
RXgzICh3YXZlT3V0TWVzc2FnZSwgd2lubW0sIDEsIDAsIDEpCi1Mb2FkRExM
ZnVuY0V4MyAod2F2ZU91dEdldERldkNhcHNBLCB3aW5tbSwgMSwgMCwgMSkK
K0xvYWRETExmdW5jRXgzICh3YXZlSW5BZGRCdWZmZXIsIHdpbm1tLCAxLCAw
KQorTG9hZERMTGZ1bmNFeDMgKHdhdmVJbkNsb3NlLCB3aW5tbSwgMSwgMCkK
K0xvYWRETExmdW5jRXgzICh3YXZlSW5HZXROdW1EZXZzLCB3aW5tbSwgMSwg
MCkKK0xvYWRETExmdW5jRXgzICh3YXZlSW5PcGVuLCB3aW5tbSwgMSwgMCkK
K0xvYWRETExmdW5jRXgzICh3YXZlSW5QcmVwYXJlSGVhZGVyLCB3aW5tbSwg
MSwgMCkKK0xvYWRETExmdW5jRXgzICh3YXZlSW5SZXNldCwgd2lubW0sIDEs
IDApCitMb2FkRExMZnVuY0V4MyAod2F2ZUluU3RhcnQsIHdpbm1tLCAxLCAw
KQorTG9hZERMTGZ1bmNFeDMgKHdhdmVJblVucHJlcGFyZUhlYWRlciwgd2lu
bW0sIDEsIDApCitMb2FkRExMZnVuY0V4MyAod2F2ZU91dENsb3NlLCB3aW5t
bSwgMSwgMCkKK0xvYWRETExmdW5jRXgzICh3YXZlT3V0R2V0TnVtRGV2cywg
d2lubW0sIDEsIDApCitMb2FkRExMZnVuY0V4MyAod2F2ZU91dEdldFZvbHVt
ZSwgd2lubW0sIDEsIDApCitMb2FkRExMZnVuY0V4MyAod2F2ZU91dE9wZW4s
IHdpbm1tLCAxLCAwKQorTG9hZERMTGZ1bmNFeDMgKHdhdmVPdXRQcmVwYXJl
SGVhZGVyLCB3aW5tbSwgMSwgMCkKK0xvYWRETExmdW5jRXgzICh3YXZlT3V0
UmVzZXQsIHdpbm1tLCAxLCAwKQorTG9hZERMTGZ1bmNFeDMgKHdhdmVPdXRT
ZXRWb2x1bWUsIHdpbm1tLCAxLCAwKQorTG9hZERMTGZ1bmNFeDMgKHdhdmVP
dXRVbnByZXBhcmVIZWFkZXIsIHdpbm1tLCAxLCAwKQorTG9hZERMTGZ1bmNF
eDMgKHdhdmVPdXRXcml0ZSwgd2lubW0sIDEsIDApCitMb2FkRExMZnVuY0V4
MyAod2F2ZU91dE1lc3NhZ2UsIHdpbm1tLCAxLCAwKQorTG9hZERMTGZ1bmNF
eDMgKHdhdmVPdXRHZXREZXZDYXBzQSwgd2lubW0sIDEsIDApCiAKIExvYWRE
TExmdW5jIChhY2NlcHQsIHdzMl8zMikKIExvYWRETExmdW5jIChiaW5kLCB3
czJfMzIpCi0tIAoyLjQ5LjAud2luZG93cy4xCgo=

--_004_PN3P287MB13209A14DE960126F3311558F7A62PN3P287MB1320INDP_--

Return-Path: <SRS0=h1RM=FB=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id 5C0114BA5439
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 09:31:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5C0114BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5C0114BA5439
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1783416692; cv=pass;
	b=ah7WUm4WITHMQkfKvgOIN0v+Zw1zs4qvN95hlrizLFq2YPnaop3jja1QxLBreld+IWbVxrUrtRJHGaSH3j4wJbGgo3XTKYGVWh37iAaMBOG8WGksX7OtKH32a/n6fX4Xjgh3tJd4R0km8jMGg3b6Twzm116XyO3whmBFg3/yLUU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783416692; c=relaxed/simple;
	bh=iEEI9JnOOaYl6IArYSbwwVJNLUdIkDIwfTr1JYoAzCc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=B3PrgpecIExtGvOPJb6FxGEab0oi03fL/BkKu+OdOEXW/G/0lXab6cgL3rI2+zxIjxKRwdDliHmYbm7R/amRUqtsgRH2MrCIei38+oq72AZFGQL+45EC0pQO3eY/riBQ7Bwl4Tu+/9h2fozvm1hcu/fRt+Es9EE8DGItxdREGlE=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=rlOBDw2P
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5C0114BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=rlOBDw2P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMniym1CPSppudcVVum7EzH+UmKAhxie+U3Qn4geFVWoYCnyFLNJ6p11Yn+mEM1EK+syzf88hSXiNDPxNMH0Fv7nN5fY8UiCJkFshFYs5cLJ6rCxJi2tWq1/Tymgu/2krBZ2uhMTuG8020WxGmY1LCY5f5S4PA+el8/vqlhVkkro62qw4+KE6B7NGrwn7oAnu/Ld6gduDznnzGX52OEPfqC2kPRihXK2Zz8kNzfavLBUnGORyBFk/gjIN+M5jyEkTC0dMhmxxyCvp2ExM/s8WBPZmNV4LsWNQ3YdFr0yVVY4MGKkDoJ/f0Zk4CIbbzHwGFCwecBMDTSU+9r4j23/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdo1u9Qm+ZkIW8xa3V7abvPUEKpbNxWtX6HGBCPnjNs=;
 b=HjkMGYcqTpoGD5MzivKowraPEOpysQXv45nwZssxLwAYRdnzLCz6vYD27N9Z2V8tDUv0gzszt2kUdBnAW1HO6K2qkuEwcTq4WtLU+GQtI4tZjEg6oRbMqu9HOKmJxCEl23cD9QbqfyuSRGjPM+kio6D+befDlfXA4NSJrLlkSKx3qKyGz5qo4KjHSTexsgqnrzC+9Tmce+pwwvb1GLbGTliTIW7EsSa3gJNAcARf9PNVMmpXmGM5xmepw1gDAQui8VtBU+pE+HDOKCDx0SnXTnlVbcUz7uuY9BVcFey8t1Eoj1xlAW74C7QcMprQtrul/eBmmpATDEe7d/ILEjEZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdo1u9Qm+ZkIW8xa3V7abvPUEKpbNxWtX6HGBCPnjNs=;
 b=rlOBDw2PfQrbHOnIbutA97frTv6Y0D/7z0IAhYSqnshJsiFLj9eq3v8/IS9IGnQ/116jf8uPnkRlqGTAIX7VOUzZPbSfQG86FXT1cHuBP0EWh/WQ+G1HXCA1Oy5MQRMUW0RjvDUDA+Nh3ljJ8iM5bqBME+XzCbKvGi/9I5gHP7a5de1kdAZFdwp0NXyW7PdbFetwLWeKYwCWj8f+N2R90Fkjwc7BC6q/P5LVHwzHbkaxcyF3M4YEo2yMOShCyYsChOCdrZAr76js1gPhR6mzokVKc1Ixf1oTNQ7f/Efag4KFdYinxR4SQjLjqAy8m3gHp2wcfcHtQaXomEU6F3vpVA==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by PNXP287MB4230.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 09:31:25 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.21.0139.018; Tue, 7 Jul 2026
 09:31:25 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Topic: [PATCH] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Index: AQHdDfHuhjwZlj4wtEyJ4XngzUcd9A==
Date: Tue, 7 Jul 2026 09:31:25 +0000
Message-ID:
 <PN0P287MB0295C357517BE127B601D99092F02@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|PNXP287MB4230:EE_
x-ms-office365-filtering-correlation-id: f9b8a6ad-0b26-486f-2093-08dedc0a83de
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|1800799024|23010399003|366016|31052699007|39142699007|376014|38070700021|4053099003|18002099003|6133799003|56012099006|55112099003|8096899003;
x-microsoft-antispam-message-info:
 xbLh0Cj/cTGjlsQvw7wSm+1X5fROra120W4N0s1yEjitodvwtGPfDitwJ0KCYSeUa6r0k7CnfIxYOAKeWq/2DzvVPro8XKxDJEpLxjYp6tQqCXcXWgtV7MHzvoAm8w+ieoiCNfgdaQ33WII4QBi11sHY598UTM5oKRk8PlSE1pZvYoUpNNzOAiGkfwGoZsxZY0fHWAYSptbiE+/ISkmJF75Oyd/Ce5ukELMLxYgZ8OS1P5yMNV/uupvKrxbA6Ma9XnwLoi9NFDmDNnww3gNgRJvvCkqMhtVUQHMDAK0VWg6wBuguGY5HY/gA0708hV52bx6hexZ0vA0koDt7PnLX/9OVPWBZyOXQKU0NbV+FwWoks5Os1wN+7wC/k38r/JtnS5Qw3U43AQvGkKP5JUYlJTVvDDGJvjnAelO/O4no3QPR9gelKmH3qyavDqUlkOCRrzZbzbeQO+k0hktOBliXgiiQMRqvPW6pj/CaoqX7sia5kjvKcD9CTF+Img0G7AhYcMKSt3vsbwpfXp9sE27/JGMO1anix3vtZwlSnltyr81sNgEBWB6MW97noHse38osxZp3o/JVXo3aunthRPGWN/57WDU0r6P1+UN6fcpyAkyGScHp3iguqIIXp6Jp3w9jpAH9aKXUud5ewzDJEzVT0LUQ3/LybiW//jxa/Dat04bFb/AHwsMemLh+qWQgzzhKljwfL8G11O/SPaHYXSODpbeqtNa7g1Bzx0Vw5oETEsI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(23010399003)(366016)(31052699007)(39142699007)(376014)(38070700021)(4053099003)(18002099003)(6133799003)(56012099006)(55112099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MYSZV1iv43YtWXCMr3H7J+7E2lQ2H9I1mw4Zi2ozMNbMK3J1effUvg90J8?=
 =?iso-8859-1?Q?S4FnoZOUZohXcy2txc4oUxWgcVTLHP5h+52OPjvDjE3cxB+/mh4pXxqkVm?=
 =?iso-8859-1?Q?KgfTtHt/4DjtBiCkfrSzgzHS/E2qcQQOyD8WzBb62jcS+8yuGH2WotYeP3?=
 =?iso-8859-1?Q?nWUPlcbzkFbS6LVP2m7nasXOs+bJSBccPkrBQgkX+kPRoJHdvLc9qDdLFQ?=
 =?iso-8859-1?Q?acG8mF0eyh2fwq4WMyknLr8+FCvZI2yO+uDvmSNxKtsRQP33H/AHhZ99H+?=
 =?iso-8859-1?Q?eQTrKMBmWegyIA4BjjNPCJOayttltLalLDlW84fTvyY2uhoTChNC5jZXCn?=
 =?iso-8859-1?Q?1M0EjnykpBeI7fQAIk75hiC9LduQ4syUUTpWgJi8g8ZcYW/6Vhl8xw6zWy?=
 =?iso-8859-1?Q?1qjD2d+BtV7i+0Q8kzCvLA+7xLdBoamvWiSEyBprtes7eD55NbxLyuHhaM?=
 =?iso-8859-1?Q?LWFqRELDr8a4uFuAQ0WnpTkcLGkI5n7hE/3w4jSKoQA9NkZn3ozkaUsHMB?=
 =?iso-8859-1?Q?ADyYvHGyQ47+Ka3g5SPk4KuveY6ClMKtaknORbuLOtWEbRxL32yaiplaMX?=
 =?iso-8859-1?Q?Q4MFlx/nZUqsDu22FNxLBVyMqh6hezo1G3lomVllYFyNgTlHl88hgCSzqS?=
 =?iso-8859-1?Q?Wc4FU1rSlmaarlk2PZeGnFR32dObC4gv5h+XYdKmv1HVNh/9r46uhmKPEC?=
 =?iso-8859-1?Q?UC5IYLx5Y0sso3Aq+gwW59a/mwkS3geuFO0JcRWH7XqtE08PVNzPmLCoFX?=
 =?iso-8859-1?Q?fcvgt2t4ENLm+4OQVBC1+M6tAx4VG6DBlk/n+RUwdB0RKgApP6WySf13tq?=
 =?iso-8859-1?Q?ml24DWzHKjcIHy/yF1dfNaJk+4k8HZtYLUvFfW8NcyqUZl8Oih55tf3GGr?=
 =?iso-8859-1?Q?Ui06AhVch4k1ZS0NdtQYx9wwDNNLIDzywTSHRH2BSq4IqlOrl3ZPIiCKRJ?=
 =?iso-8859-1?Q?K1rJV4QGQH5h07Cg1X/c8J8+Los3RaKJ2gpvHw2FhcdNLHquCB+HXdiupK?=
 =?iso-8859-1?Q?Z26U957lDkZA0EgLAhb9nYOchl06Yt7LYoFmYRYYq0nCMF6NKPyejBpK6f?=
 =?iso-8859-1?Q?RXw/bNjNwbU2YLTCsevKOtxePCkH086/PM21mbKvaZ3YD2NXWqnHymv+lX?=
 =?iso-8859-1?Q?YU4Ce3M2ZHKjy9WbPASgOD3o1kVHsZ9jKraKexawSjwjmOoGdRgO8ulGcJ?=
 =?iso-8859-1?Q?EzSR1jnDHRLuxIvbiq07IAzH7wnAFGOCCQ4MBg3JUt0EiCE+p4iQGtfaX5?=
 =?iso-8859-1?Q?lR2M4K11yxfSkOUpITjDG+WIM5LPV/pUtgWJrs3mmj6bx8Zcm8VMiU4s2Y?=
 =?iso-8859-1?Q?nwB9W9ji5TXW3l3kVvWxyU6QsjkX3lB48xApg2ArotCQNdVRxFneDiqC6b?=
 =?iso-8859-1?Q?CwMal/QT9xz14iUtSNJVanPWTYGvbQFfPjXSP58t7F/TgqnIH3fBXVLNWL?=
 =?iso-8859-1?Q?AOH+dJVWIMdIQhoQH+L4tjXOoW61i3LqVOan70wKSDMo7wfO4g/JwrCEFv?=
 =?iso-8859-1?Q?RRnNc9eBfHFTxP/teY/0CUDlJ5IDtC179k+DlIJlRVFY7YpSstIpQpoeU2?=
 =?iso-8859-1?Q?2nOyP4TZrZy4Za2AKI71+9dmIOLSOa9qPsue8rh8RoGqvdHpzoD9ZM6RwV?=
 =?iso-8859-1?Q?bXdg/jv8TodCwIE1w0E+b+2AIJimn4O6zM2SpA5IXcWv3aWxTysVwrsTG7?=
 =?iso-8859-1?Q?By5BpiplVKYRXCVFd2yYpn5Mw8CAaJNTkz9aazb9vuwg7R1RlJoIc+aJyH?=
 =?iso-8859-1?Q?0tjR+WFUU8uGJVeQW0UDkoSUP7jbKF7FmkTtoOTTXATZfmygL7D/ePOLwp?=
 =?iso-8859-1?Q?KzwvESfjYSuDlXxM9t4atFTNrx+2qdw=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB0295C357517BE127B601D99092F02PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b8a6ad-0b26-486f-2093-08dedc0a83de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 09:31:25.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWuqCmnfoLvXgyx6tYVbNVW19shTGaqJt00j2rb+mE7AfTUdbGHWePrDU0q5/YP1hGFHjrgH7uhazZO/22kUDgwOftr+HaSaA2c3dzTN+SQ0sCDmqjjMrEco9KPxn8w/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXP287MB4230
X-Spam-Status: No, score=-12.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB0295C357517BE127B601D99092F02PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB0295C357517BE127B601D99092F02PN0P287MB0295INDP_"

--_000_PN0P287MB0295C357517BE127B601D99092F02PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

On AArch64, the autoload INIT_WRAPPER passes func_info* via x30 ("mov
x0, x30").  This works for the first init stage (std_dll_init), reached
by the trampoline's "blr".  It breaks for a chained second init, because
dll_chain reaches it via "br x1" without updating x30.

ws2_32 is the only DLL with such a chain (std_dll_init -> wsock_init ->
dll_func_load).  wsock_init received garbage in x0, so WSAStartup was
never called; every ws2_32 call failed with WSANOTINITIALISED / EFAULT.

dll_chain also runs twice for ws2_32, pushing a 16-byte frame each time.
wsock_init consumes its arg from x30, not the stack, so the first frame
strands.  dll_func_load then restores caller-save registers from a
shifted offset, corrupting the first call's arguments.

Fix: copy func_info into x30 in dll_chain before the tail-branch, and
give AArch64 a dedicated _wsock_init wrapper that drops the stranded
frame ("add sp, sp, #16") before chaining to dll_func_load.

Inline Patch

---
 winsup/cygwin/autoload.cc | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index 7054511b6..8d0f2a59e 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -302,6 +302,10 @@ dll_func_load:                                        =
   \n\
   .global    dll_chain                                   \n\
 dll_chain:                                               \n\
   stp        x0, xzr, [sp, #-16]! // x0 =3D func_info* (=3D ret.high); pus=
h for dll_func_load\n\
+  mov        x30, x0              // also pass func_info in x30: a chained=
 INIT_WRAPPER\n\
+                                  // (e.g. _wsock_init) reads its arg from=
 x30, but is\n\
+                                  // reached here via 'br' which would oth=
erwise leave\n\
+                                  // x30 stale.  dll_func_load ignores x30=
 (reads [sp]).\n\
   br         x1                   // x1 =3D dll->init (=3D ret.low); tail-=
call resolver\n\
 ");
 #else
@@ -481,9 +485,29 @@ std_dll_init (struct func_info *func)

 /* Initialization function for winsock stuff. */

-#if defined(__x86_64__) || defined(__aarch64__)
-/* See above comment preceeding std_dll_init. */
+#if defined(__x86_64__)
+/* See above comment preceding std_dll_init. */
 INIT_WRAPPER (wsock_init)
+#elif defined(__aarch64__)
+__asm__("\n\
+  .text                                                  \n\
+  .p2align 2                                             \n\
+  .seh_proc _wsock_init                                  \n\
+_wsock_init:                                             \n\
+  stp        x29, x30, [sp, #-16]!  // save fp/lr, open our 16-byte frame\=
n\
+  .seh_save_fplr_x 16                                   \n\
+  .seh_endprologue                                      \n\
+  mov        x0, x30              // x0 =3D func_info  (the wsock_init() a=
rgument)\n\
+  bl         wsock_init           // run WSAStartup; returns x0=3Dfunc_inf=
o, x1=3Ddll_func_load\n\
+  ldp        x29, xzr, [sp], #16  // restore fp, discard saved lr, close o=
ur frame\n\
+  add        sp, sp, #16          // drop the stranded dll_chain frame so =
the\n\
+                                  // downstream dll_func_load sees exactly=
 one\n\
+                                  // dll_chain frame above the trampoline =
frame\n\
+  adrp       x30, dll_chain       // x30 =3D &dll_chain ...\n\
+  add        x30, x30, #:lo12:dll_chain  // ... so the 'ret' below tail-ch=
ains there\n\
+  ret                             // -> dll_chain, which tail-calls x1 (dl=
l_func_load)\n\
+  .seh_endproc                                          \n\
+");
 #else
 #error unimplemented for this target
 #endif
--
2.49.0.windows.1




--_000_PN0P287MB0295C357517BE127B601D99092F02PN0P287MB0295INDP_--

--_004_PN0P287MB0295C357517BE127B601D99092F02PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-autoload-fix-ws2_32-chained-init-on-AArch64.patch"
Content-Description: Cygwin-autoload-fix-ws2_32-chained-init-on-AArch64.patch
Content-Disposition: attachment;
	filename="Cygwin-autoload-fix-ws2_32-chained-init-on-AArch64.patch";
	size=4017; creation-date="Tue, 07 Jul 2026 09:30:29 GMT";
	modification-date="Tue, 07 Jul 2026 09:31:25 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkNDA2NmJmN2Y2MWIzOWZiMjkxMjA0YTA2YTlhZTIwNzMwNzJhN2Y4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IE1vbiwgNiBKdWwgMjAyNiAxMjozMjowMyArMDUzMApTdWJqZWN0OiBbUEFU
Q0hdIEN5Z3dpbjogYXV0b2xvYWQ6IGZpeCB3czJfMzIgY2hhaW5lZCBpbml0
IG9uIEFBcmNoNjQKCk9uIEFBcmNoNjQsIHRoZSBhdXRvbG9hZCBJTklUX1dS
QVBQRVIgcGFzc2VzIGZ1bmNfaW5mbyogdmlhIHgzMCAoIm1vdgp4MCwgeDMw
IikuICBUaGlzIHdvcmtzIGZvciB0aGUgZmlyc3QgaW5pdCBzdGFnZSAoc3Rk
X2RsbF9pbml0KSwgcmVhY2hlZApieSB0aGUgdHJhbXBvbGluZSdzICJibHIi
LiAgSXQgYnJlYWtzIGZvciBhIGNoYWluZWQgc2Vjb25kIGluaXQsIGJlY2F1
c2UKZGxsX2NoYWluIHJlYWNoZXMgaXQgdmlhICJiciB4MSIgd2l0aG91dCB1
cGRhdGluZyB4MzAuCgp3czJfMzIgaXMgdGhlIG9ubHkgRExMIHdpdGggc3Vj
aCBhIGNoYWluIChzdGRfZGxsX2luaXQgLT4gd3NvY2tfaW5pdCAtPgpkbGxf
ZnVuY19sb2FkKS4gIHdzb2NrX2luaXQgcmVjZWl2ZWQgZ2FyYmFnZSBpbiB4
MCwgc28gV1NBU3RhcnR1cCB3YXMKbmV2ZXIgY2FsbGVkOyBldmVyeSB3czJf
MzIgY2FsbCBmYWlsZWQgd2l0aCBXU0FOT1RJTklUSUFMSVNFRCAvIEVGQVVM
VC4KCmRsbF9jaGFpbiBhbHNvIHJ1bnMgdHdpY2UgZm9yIHdzMl8zMiwgcHVz
aGluZyBhIDE2LWJ5dGUgZnJhbWUgZWFjaCB0aW1lLgp3c29ja19pbml0IGNv
bnN1bWVzIGl0cyBhcmcgZnJvbSB4MzAsIG5vdCB0aGUgc3RhY2ssIHNvIHRo
ZSBmaXJzdCBmcmFtZQpzdHJhbmRzLiAgZGxsX2Z1bmNfbG9hZCB0aGVuIHJl
c3RvcmVzIGNhbGxlci1zYXZlIHJlZ2lzdGVycyBmcm9tIGEKc2hpZnRlZCBv
ZmZzZXQsIGNvcnJ1cHRpbmcgdGhlIGZpcnN0IGNhbGwncyBhcmd1bWVudHMu
CgpGaXg6IGNvcHkgZnVuY19pbmZvIGludG8geDMwIGluIGRsbF9jaGFpbiBi
ZWZvcmUgdGhlIHRhaWwtYnJhbmNoLCBhbmQKZ2l2ZSBBQXJjaDY0IGEgZGVk
aWNhdGVkIF93c29ja19pbml0IHdyYXBwZXIgdGhhdCBkcm9wcyB0aGUgc3Ry
YW5kZWQKZnJhbWUgKCJhZGQgc3AsIHNwLCAjMTYiKSBiZWZvcmUgY2hhaW5p
bmcgdG8gZGxsX2Z1bmNfbG9hZC4KClNpZ25lZC1vZmYtYnk6IENoYW5kcnUg
S3VtYXJlc2FuIDxjaGFuZHJ1Lmt1bWFyZXNhbkBtdWx0aWNvcmV3YXJlaW5j
LmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL2F1dG9sb2FkLmNjIHwgMjggKysr
KysrKysrKysrKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDI2
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9hdXRvbG9hZC5jYyBiL3dpbnN1cC9jeWd3aW4vYXV0
b2xvYWQuY2MKaW5kZXggNzA1NDUxMWI2Li44ZDBmMmE1OWUgMTAwNjQ0Ci0t
LSBhL3dpbnN1cC9jeWd3aW4vYXV0b2xvYWQuY2MKKysrIGIvd2luc3VwL2N5
Z3dpbi9hdXRvbG9hZC5jYwpAQCAtMzAyLDYgKzMwMiwxMCBAQCBkbGxfZnVu
Y19sb2FkOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcblwKICAgLmdsb2JhbCAgICBkbGxfY2hhaW4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFxuXAogZGxsX2NoYWluOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCiAg
IHN0cCAgICAgICAgeDAsIHh6ciwgW3NwLCAjLTE2XSEgLy8geDAgPSBmdW5j
X2luZm8qICg9IHJldC5oaWdoKTsgcHVzaCBmb3IgZGxsX2Z1bmNfbG9hZFxu
XAorICBtb3YgICAgICAgIHgzMCwgeDAgICAgICAgICAgICAgIC8vIGFsc28g
cGFzcyBmdW5jX2luZm8gaW4geDMwOiBhIGNoYWluZWQgSU5JVF9XUkFQUEVS
XG5cCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gKGUu
Zy4gX3dzb2NrX2luaXQpIHJlYWRzIGl0cyBhcmcgZnJvbSB4MzAsIGJ1dCBp
c1xuXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIHJl
YWNoZWQgaGVyZSB2aWEgJ2JyJyB3aGljaCB3b3VsZCBvdGhlcndpc2UgbGVh
dmVcblwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyB4
MzAgc3RhbGUuICBkbGxfZnVuY19sb2FkIGlnbm9yZXMgeDMwIChyZWFkcyBb
c3BdKS5cblwKICAgYnIgICAgICAgICB4MSAgICAgICAgICAgICAgICAgICAv
LyB4MSA9IGRsbC0+aW5pdCAoPSByZXQubG93KTsgdGFpbC1jYWxsIHJlc29s
dmVyXG5cCiAiKTsKICNlbHNlCkBAIC00ODEsOSArNDg1LDI5IEBAIHN0ZF9k
bGxfaW5pdCAoc3RydWN0IGZ1bmNfaW5mbyAqZnVuYykKIAogLyogSW5pdGlh
bGl6YXRpb24gZnVuY3Rpb24gZm9yIHdpbnNvY2sgc3R1ZmYuICovCiAKLSNp
ZiBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmluZWQoX19hYXJjaDY0X18p
Ci0vKiBTZWUgYWJvdmUgY29tbWVudCBwcmVjZWVkaW5nIHN0ZF9kbGxfaW5p
dC4gKi8KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCisvKiBTZWUgYWJvdmUg
Y29tbWVudCBwcmVjZWRpbmcgc3RkX2RsbF9pbml0LiAqLwogSU5JVF9XUkFQ
UEVSICh3c29ja19pbml0KQorI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykK
K19fYXNtX18oIlxuXAorICAudGV4dCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIC5wMmFsaWduIDIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
blwKKyAgLnNlaF9wcm9jIF93c29ja19pbml0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFxuXAorX3dzb2NrX2luaXQ6ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG5cCisgIHN0cCAg
ICAgICAgeDI5LCB4MzAsIFtzcCwgIy0xNl0hICAvLyBzYXZlIGZwL2xyLCBv
cGVuIG91ciAxNi1ieXRlIGZyYW1lXG5cCisgIC5zZWhfc2F2ZV9mcGxyX3gg
MTYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxuXAorICAu
c2VoX2VuZHByb2xvZ3VlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcblwKKyAgbW92ICAgICAgICB4MCwgeDMwICAgICAgICAgICAg
ICAvLyB4MCA9IGZ1bmNfaW5mbyAgKHRoZSB3c29ja19pbml0KCkgYXJndW1l
bnQpXG5cCisgIGJsICAgICAgICAgd3NvY2tfaW5pdCAgICAgICAgICAgLy8g
cnVuIFdTQVN0YXJ0dXA7IHJldHVybnMgeDA9ZnVuY19pbmZvLCB4MT1kbGxf
ZnVuY19sb2FkXG5cCisgIGxkcCAgICAgICAgeDI5LCB4enIsIFtzcF0sICMx
NiAgLy8gcmVzdG9yZSBmcCwgZGlzY2FyZCBzYXZlZCBsciwgY2xvc2Ugb3Vy
IGZyYW1lXG5cCisgIGFkZCAgICAgICAgc3AsIHNwLCAjMTYgICAgICAgICAg
Ly8gZHJvcCB0aGUgc3RyYW5kZWQgZGxsX2NoYWluIGZyYW1lIHNvIHRoZVxu
XAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIGRvd25z
dHJlYW0gZGxsX2Z1bmNfbG9hZCBzZWVzIGV4YWN0bHkgb25lXG5cCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy8gZGxsX2NoYWluIGZy
YW1lIGFib3ZlIHRoZSB0cmFtcG9saW5lIGZyYW1lXG5cCisgIGFkcnAgICAg
ICAgeDMwLCBkbGxfY2hhaW4gICAgICAgLy8geDMwID0gJmRsbF9jaGFpbiAu
Li5cblwKKyAgYWRkICAgICAgICB4MzAsIHgzMCwgIzpsbzEyOmRsbF9jaGFp
biAgLy8gLi4uIHNvIHRoZSAncmV0JyBiZWxvdyB0YWlsLWNoYWlucyB0aGVy
ZVxuXAorICByZXQgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIC0+
IGRsbF9jaGFpbiwgd2hpY2ggdGFpbC1jYWxscyB4MSAoZGxsX2Z1bmNfbG9h
ZClcblwKKyAgLnNlaF9lbmRwcm9jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXG5cCisiKTsKICNlbHNlCiAjZXJyb3IgdW5p
bXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgotLSAKMi40OS4w
LndpbmRvd3MuMQoK

--_004_PN0P287MB0295C357517BE127B601D99092F02PN0P287MB0295INDP_--

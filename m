Return-Path: <SRS0=Un77=FE=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id 7F7634BA2E07
	for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2026 11:55:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7F7634BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7F7634BA2E07
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1783684518; cv=pass;
	b=LliSYglJjWyqZSOarUBI9pfaaQCarjB3kGiVrZ9Bm3O8mp1ZjmMASpSCV2H8yqdFjj29a5mS6bt4f+lTPsmIgc4TlFybWAESqRzek4YulQ0foTx7kyPcIdRh5EoGr9XHtoQTDZvkctGVRc636rH60B3GXZLwTYzCSCt5gODrk5M=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783684518; c=relaxed/simple;
	bh=9OEPRiFYW37mCj/86ZRSUDfL9UdAY6GKu1mdQHmTG+A=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=c7U7YODpG/b8/ZuLmBWv212axMcDEP8lYFIeQqWgFG3PJ2yP1sAuPWLDVb71/BW6F3MYeoTXl+I3w3uGMdkXQi1tUpIQum27a9GGuOh/0hIEaSF+UQEYVOp47WT0bYL9OA0y2Bu+E0y0DFBEBWonc/Cj0XraGzz3wfopPEgWiQg=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=GcbT6mtz
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F7634BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=GcbT6mtz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLvSPi3CulKdPxv+XHMS77cY1+mUVHy3KVNaevyuEs8WSp3+Fi7h0Fol4WtZfAwq5If85Xb0KpsdpoxTtDYK56d3TapTfEJacbScQzT/fnbMj6VplrmDIbkAFZisLyKhE6wkqshBJ2S+M87zh7AHqPB6CNyZKFJ6tQHcTdqJ+bfG5Ni92EIfjENClUljKbs1ZSxOj6Fk3ilyymNzCKn9b+G+diTkArmTIm2szH1Da20VHcPGf5cpfzcituUZ6uz0hFSLN3uAFsbWRxdrveindjU320fMCPtYEfwoYhR14R7iNNXb9GAES3Fi7CGjaCMRNTqw2Kxc+gaA0tlWVe69Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ0WUm4teFBhD8zbdiGRykZC5CrhOblo2STBIK6bsyQ=;
 b=irvOxNkxDoEJ904PA9kanY3Z21mzKPxyJa57oq5VZ2nbNKZ3glJt6lhqD3hRlvihtbgZzHtt2/C8y1JKBsZHkrVpcIQXzlIX0CaxeX1blQXJGWH+1kx5T7EaYbmIHqwOJEuWwQMrGHFizz/Rt5NTiDRCuaqjmS6q3P88NphRNAsWiq8sTED0kG8imYLDejxnf6473xhV56OpWcuJ0/krRQT8CO/ABsIGfY7T+S8cqdb7jE6sOyu8Wxvitrj7CrqrM4GAlTjtwqyPdn5g7wMpezMOMVfP6WdJPyOLtGaaQBKVu4nlC5BFKhAynleZqjBK3C8WVtzXanIoq6jVXuJDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ0WUm4teFBhD8zbdiGRykZC5CrhOblo2STBIK6bsyQ=;
 b=GcbT6mtz2wQOq2heHd3RW/jQXFoBGLd6tS5eJKzqiM6KtossTbVo/uMoVY3N1MkgUMEUpmxiQqwqkS5XawChwfJu06pkFscgan6LjsV2XwxWHSmjtDysXUAc1iVkJUK0uVGAgILU4E0RL99/qbmvu6InqbD3zfWUCEMOHlJpXdRX3L807jj3y0WER0mpWHBr8OJ9EE4f4wvdrzvbqBjXswbhCYvz1osGY7X04vGBjd/3pRkbPreyE3R/QXQlSE6jUMThMfAIwgV/ZqBnYxUTSHX1Z6kzaU1/UiPS1xN+fKWwmeYj9mr+/TuDB97/t1xUGIg3F36agL5JblIkbvcnxg==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by PNZP287MB3993.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:293::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 11:55:11 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 11:55:10 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2] Cygwin: Add AArch64 support for signal handling and
 ucontext
Thread-Topic: [PATCH v2] Cygwin: Add AArch64 support for signal handling and
 ucontext
Thread-Index: AQHdEGG+c/XSLPHoeUCcTD9HA/mxOg==
Date: Fri, 10 Jul 2026 11:55:10 +0000
Message-ID:
 <PN0P287MB029504FE0939EFA34AEC78E592FD2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|PNZP287MB3993:EE_
x-ms-office365-filtering-correlation-id: 883c0316-6575-42a9-08ff-08dede7a1854
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|39142699007|31052699007|1800799024|366016|376014|6049299003|23010399003|18002099003|5023799004|56012099006|3023799007|55112099003|8096899003|38070700021|4053099003;
x-microsoft-antispam-message-info:
 NaXo7j+q4uRWht7q2zzuZFLiMpaY3DZqfm8OVnIKCTQc7bn9Edl88zMGq54Mkm+Mv3wPbrOUe/I6B+5usZ+zAkwO7uYVsevvTgLlcp+eG5HWiJ2hc7pmkKeBDuokZiwmzM1LxBVjw9byGMyHxfN7UftG3vpjo17DGucz8aux4UIOMcbJ8vikMlrXrFiSVWn74YWlU95Ju6gW9/TTCnWvaHCJtNWLjjIhZi7+3PkC0ZHEmrvyV9m2n4xIHe+L123iLMk6NAwExM1n5NvxJW/Zv6L5nrefeO05NRXXEkHdvX+5muMjF15eZ1zxb6eWLHNwl5CzZalky47m3dZ0MdzJpIsZ1yXv5oCkvh0xRRFliHPDzyTtIKPaEaR38Po1n/q7XDqFRmOufewwaFImJVID9Xla0WAQJ4fYAeoG7TGqTc2yNVH5HB53tivGsUZmVTvZcw5hk6MHWegzB277QmMO+tODeYxvJZv4t7PsjB5YnWwbGtAck9bT2HHG3hDflnX4CKjRrwarHuXbEhaoRzzeq7/RjdlnnsT3OA6p0sy4gBTF+O3P/kOwwgXsQNGxvTrgYDw6eouNcJ1gWNE0nCSFiouqugGEBpaTjXe5APh/RJthbKS8hrwXKUNWdjoU91zapZWhizsC79odiDDASHBHZlUBij4dTbLnOxqCU5apvWlLSIWGHJDAXAFVPx0B/KSpdAI/OGwmwugoVT9lCrzAjA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(39142699007)(31052699007)(1800799024)(366016)(376014)(6049299003)(23010399003)(18002099003)(5023799004)(56012099006)(3023799007)(55112099003)(8096899003)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KRfWa3udwkEOzDsbPk04c5gLQyEKC6gs4/6yIxGBStmuvMGHSZ4UUzWjgS?=
 =?iso-8859-1?Q?J6Rb0bLwLOfEVBh8LEB8n9LTxNOcC6DWQv57/ntHhtexvdrUuJcrd97xuy?=
 =?iso-8859-1?Q?Gjqx2pmBSqAR9aaiQDSV91DbNVAqSifssm45w8rhC2Pb1lBDkAY5zhfoDz?=
 =?iso-8859-1?Q?m62fYxfnefT/m9pFI2716itXkatIyy8BJpFoJVkhQkNjQvae8cwYiVBFCc?=
 =?iso-8859-1?Q?+I2eeCi3p/SNAojD6EPXx/lBxgyeg/881g9IpJ2XY7b5PoGHlv+pvRzZ4a?=
 =?iso-8859-1?Q?2yw5D2kwfFpklcS9M82mAv92PQWRxaBd7udjyFi23vnItFn4BOADDubZRa?=
 =?iso-8859-1?Q?oaRzlFJQCK0NSF+oldXBMEBEfFq+k28x7pzhQNzL78wGZ7BXAC0MoIAAKx?=
 =?iso-8859-1?Q?MIAvVMauQdeJn5sqKFruFcOBgDtkWGgCw3DygmwJsEFqEeb7XU16knK9i4?=
 =?iso-8859-1?Q?j17qXzthcrJTFWN5vnWxgA3FVf+ltd/T5TazcH+V+GOVovJGr6NQL56OaM?=
 =?iso-8859-1?Q?p3O2OjnkZi/Lc8gtVrVaefRG+BJsDa8F8sxkiEDeq65OhouDj2QsRrz5bV?=
 =?iso-8859-1?Q?KvdBAUNeeDkvltyK7J+bGR2aO8/3M3Gw9Wc7On6ZcIMUY2kDYoCe4KOBG2?=
 =?iso-8859-1?Q?nkBasOlAGzJiEAfEWAs6iyWzS6Ol8wONPUVyMcZUL/x+ZRSLBBQ8XRAisg?=
 =?iso-8859-1?Q?dCb7vlDaNomTttgmJwTeMVSeytDk1cnfB0SlvNIbFZf2jDeEgpGqQvsdYy?=
 =?iso-8859-1?Q?KWQZvubtFQJAxRPgZZiTiGVG4c1ALMxn/x9WT/Mqy9WmpylaYKNi6RSHUc?=
 =?iso-8859-1?Q?XN/DgcqD8zxTdsy0KX+g8VTLJflCFpipmcHuPqQqMpmrFeAeAgh6qPs2jr?=
 =?iso-8859-1?Q?KXORljokIg1WOCkT5sNCYcWCTKpw67+RT150duy/LiLy1ijbzGvSuCqDkb?=
 =?iso-8859-1?Q?SnMYqzy2Dn1KfvvwAsV8zLZwzZ9ULctwUS5YvCeekxEA6h/wFq7oj6fdQ8?=
 =?iso-8859-1?Q?qludjixX/e9GlmTztP3JdE1KRrVTaNZ15dwcmxBwWG6dAz67yEBKMtfIY2?=
 =?iso-8859-1?Q?kRXbuvKKQAezw0dcIPS2ydlq9R6alLYdYIxsqMQgPk3/NP6I10gOrkbN/s?=
 =?iso-8859-1?Q?dWPfPnpDifkiBfVWGIjufYYUo38fo9KbGHShMWKVEM5rNJGzwjDu6F9dgJ?=
 =?iso-8859-1?Q?bynb4QgQPzOe7OcCN8c7EFCn0tWFU9fRSqzpicGjMrC10b6ZmgdkKPAzmh?=
 =?iso-8859-1?Q?rGkL+U8Pbbd8vc5wUu5xKGpTEih9z09q61t2spM0d8zKxiBzB8x3Xb7kom?=
 =?iso-8859-1?Q?LG1FdaLiotrKT7xkQy2anCk0lxo7BA/fS2LVtzL3igieJDlPUI7yfmC+et?=
 =?iso-8859-1?Q?tA7kMVOncGF0qIv/qFDxL0RqWcDVad+YVej4XHeeWrHhAzdl6vInsZQrL6?=
 =?iso-8859-1?Q?wIf0OzCwaLcNjChyFyDGl6G4fMESq6AxURSSZXddCKpMn7Tna1WG2ibpki?=
 =?iso-8859-1?Q?KQhbDsU+bz1BIVvh+8C6aWNXDB5wj2uXE1pmcOY/8boLF6sDIgzqkS/WWL?=
 =?iso-8859-1?Q?tb3lxvkPYAOCWkVrcitKT2CZkzlRIfGLN+3N++DpVi84E33oa1o4/P8dIX?=
 =?iso-8859-1?Q?wxFvTW8GOaKfmewlUvEMC60KoVL/FOFkSeMp5SFmG2RV/XQTyeY+onf1a1?=
 =?iso-8859-1?Q?Ye9iptyFLKcZ8r/iHakxoggU3vWAYeqjKqzPvgxTcF7voEFBBN8gJ6RX/b?=
 =?iso-8859-1?Q?oH+sqSPeqMFecXNFUb5vpObzyzvC5t28IA10gkl8smLbFNm3oPWg/tDxk0?=
 =?iso-8859-1?Q?V8VEQawZznZAs4OlV2tVRfEvlq97964=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB029504FE0939EFA34AEC78E592FD2PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 883c0316-6575-42a9-08ff-08dede7a1854
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 11:55:10.7312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1ZUpj7G2AlYSd7Xzkt0nh6gKJFUM7kMduMxqYVVfHXY4yExKLDyQEQoe+00OCc3QTHxrxRiuRU5XpmvuaX2DDRkz/rNTFRvCZc9tI+wz7STtYiN5LRM8c12uwJTirEf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZP287MB3993
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SCC_10_SHORT_WORD_LINES,SCC_5_SHORT_WORD_LINES,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB029504FE0939EFA34AEC78E592FD2PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB029504FE0939EFA34AEC78E592FD2PN0P287MB0295INDP_"

--_000_PN0P287MB029504FE0939EFA34AEC78E592FD2PN0P287MB0295INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

I've added inline comments to the AArch64 assembly implementation.

Thanks and Regards,

Chandru

Inline Patch
---
 winsup/cygwin/exceptions.cc | 318 +++++++++++++++++++++++++++++++-----
 1 file changed, 276 insertions(+), 42 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 1e129b319..cb5f1dc1d 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1892,7 +1892,7 @@ _cygtls::call_signal_handler ()

     /* In assembler: Save regs on new stack, move to alternate stack,
        call thisfunc, revert stack regs. */
-#ifdef __x86_64__
+#if defined(__x86_64__)
     /* Clobbered regs: rcx, rdx, r8, r9, r10, r11, rbp, rsp */
     __asm__ ("\n\
         movq  %[NEW_SP], %%rax  # Load alt stack into rax  \n\
@@ -1930,6 +1930,60 @@ _cygtls::call_signal_handler ()
             [FUNC]  "o" (thisfunc),
             [WRAPPER] "o" (altstack_wrapper)
         : "memory");
+#elif defined(__aarch64__)
+    __asm__ ("\n\
+        mov   x9, %[NEW_SP]     // Load alt stack into x9  \n\
+        sub   x9, x9, #0x60     // Make room on alt stack  \n\
+                 // for clobbered regs      \n\
+        str   x0, [x9, #0x00]      // Save clobbered regs     \n\
+        str   x1, [x9, #0x08]                  \n\
+        str   x2, [x9, #0x10]                  \n\
+        str   x3, [x9, #0x18]                  \n\
+        str   x4, [x9, #0x20]                  \n\
+        str   x5, [x9, #0x28]                  \n\
+        str   x6, [x9, #0x30]                  \n\
+        str   x7, [x9, #0x38]                  \n\
+        str   fp, [x9, #0x40]                  \n\
+        mov   x10, sp        // Copy sp into x10 for saving   \n\
+        str   x10, [x9, #0x48]              \n\
+        str   x30, [x9, #0x50]  // Save link register      \n\
+        mov   x0, %[SIG]     // thissig to 1st arg reg  \n\
+        mov   x1, %[SI]      // &thissi to 2nd arg reg  \n\
+        mov   x2, %[CTX]     // thiscontext to 3rd arg reg \n\
+        mov   x3, %[FUNC]    // thisfunc to x3    \n\
+        mov   x4, %[WRAPPER]    // wrapper address to x4   \n\
+        mov   sp, x9         // Move alt stack into sp  \n\
+        blr   x4       // Call wrapper         \n\
+        mov   x9, sp         // Restore clobbered regs  \n\
+        ldr   x30, [x9, #0x50]  // Restore link register   \n\
+        ldr   x10, [x9, #0x48]              \n\
+        ldr   fp,  [x9, #0x40]              \n\
+        ldr   x7,  [x9, #0x38]              \n\
+        ldr   x6,  [x9, #0x30]              \n\
+        ldr   x5,  [x9, #0x28]              \n\
+        ldr   x4,  [x9, #0x20]              \n\
+        ldr   x3,  [x9, #0x18]              \n\
+        ldr   x2,  [x9, #0x10]              \n\
+        ldr   x1,  [x9, #0x08]              \n\
+        ldr   x0,  [x9, #0x00]              \n\
+        mov   sp,  x10    // Restore stack pointer   \n"
+        : : [NEW_SP]    "r" (new_sp),
+            [SIG]    "r" (thissig),
+            [SI]  "r" (&thissi),
+            [CTX]    "r" (thiscontext),
+            [FUNC]   "r" (thisfunc),
+            [WRAPPER] "r" (altstack_wrapper)
+       /* altstack_wrapper is an ordinary C call, so every
+         caller-saved register may be clobbered.  x18 (the Windows
+         TEB pointer) and v8-v15 (callee-saved on Windows) are
+         preserved and thus omitted.  */
+        : "memory", "cc",
+          "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
+          "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
+          "x16", "x17", "x29", "x30",
+          "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
+          "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+          "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
 #else
 #error unimplemented for this target
 #endif
@@ -2009,10 +2063,78 @@ setcontext (const ucontext_t *ucp)
 {
   PCONTEXT ctx =3D (PCONTEXT) &ucp->uc_mcontext;
   set_signal_mask (_my_tls.sigmask, ucp->uc_sigmask);
+#if defined(__aarch64__)
+  /* On ARM64 Windows, RtlRestoreContext may fail (STATUS_ILLEGAL_INSTRUCT=
ION)
+     when restoring a synthetic CONTEXT that was constructed by makecontext
+     rather than captured by RtlCaptureContext / GetThreadContext.  This is
+     because RtlRestoreContext may perform validation or use internal
+     mechanisms (e.g. stack unwinding hints) that don't work with synthetic
+     contexts pointing to arbitrary PC addresses and non-thread stacks.
+
+     Instead, we manually restore all registers and branch to the saved PC.
+     This mirrors what glibc/musl do in their setcontext implementations
+     for aarch64-linux.  */
+  register PCONTEXT base __asm__ ("x16") =3D ctx;
+  __asm__ __volatile__ ("\n\
+  add   x17, x16, #272             \n\
+  ldp   q0, q1, [x17, #0]          \n\
+  ldp   q2, q3, [x17, #32]            \n\
+  ldp   q4, q5, [x17, #64]            \n\
+  ldp   q6, q7, [x17, #96]            \n\
+  ldp   q8, q9, [x17, #128]           \n\
+  ldp   q10, q11, [x17, #160]            \n\
+  ldp   q12, q13, [x17, #192]            \n\
+  ldp   q14, q15, [x17, #224]            \n\
+  ldp   q16, q17, [x17, #256]            \n\
+  ldp   q18, q19, [x17, #288]            \n\
+  ldp   q20, q21, [x17, #320]            \n\
+  ldp   q22, q23, [x17, #352]            \n\
+  ldp   q24, q25, [x17, #384]            \n\
+  ldp   q26, q27, [x17, #416]            \n\
+  ldp   q28, q29, [x17, #448]            \n\
+  ldp   q30, q31, [x17, #480]            \n\
+  /* Restore FPCR and FPSR */            \n\
+  ldr   w17, [x16, #784]           \n\
+  msr   fpcr, x17               \n\
+  ldr   w17, [x16, #788]           \n\
+  msr   fpsr, x17               \n\
+  /* Load PC into x17 (branch target, offset 264) */ \n\
+  ldr   x17, [x16, #264]           \n\
+  /* Restore callee-saved GPRs x18..x28, fp, lr */   \n\
+  ldp   x18, x19, [x16, #152]            \n\
+  ldp   x20, x21, [x16, #168]            \n\
+  ldp   x22, x23, [x16, #184]            \n\
+  ldp   x24, x25, [x16, #200]            \n\
+  ldp   x26, x27, [x16, #216]            \n\
+  ldp   x28, x29, [x16, #232]            \n\
+  ldr   x30, [x16, #248]           \n\
+  /* Restore caller-saved GPRs x2..x15 */         \n\
+  ldp   x2, x3, [x16, #24]            \n\
+  ldp   x4, x5, [x16, #40]            \n\
+  ldp   x6, x7, [x16, #56]            \n\
+  ldp   x8, x9, [x16, #72]            \n\
+  ldp   x10, x11, [x16, #88]          \n\
+  ldp   x12, x13, [x16, #104]            \n\
+  ldp   x14, x15, [x16, #120]            \n\
+  /* Restore x0, x1 */             \n\
+  ldp   x0, x1, [x16, #8]          \n\
+  /* Set SP from context (last use of x16 as base) */   \n\
+  ldr   x16, [x16, #256]           \n\
+  mov   sp, x16                 \n\
+  /* Branch to saved PC */            \n\
+  br x17                  \n\
+"
+  : /* no outputs (noreturn) */
+  : "r" (base)
+  : "memory"
+  );
+  __builtin_unreachable ();
+#else
   RtlRestoreContext (ctx, NULL);
   /* If we got here, something was wrong. */
   set_errno (EINVAL);
   return -1;
+#endif
 }

 extern "C" int
@@ -2049,7 +2171,7 @@ swapcontext (ucontext_t *oucp, const ucontext_t *ucp)
 /* Trampoline function to set the context to uc_link.  The pointer to the
    address of uc_link is stored in a callee-saved register, referenced by
    _MC_uclinkReg from the C code.  If uc_link is NULL, call exit. */
-#ifdef __x86_64__
+#if defined(__x86_64__)
 /* _MC_uclinkReg =3D=3D %rbx */
 __asm__ ("          \n\
   .global  __cont_link_context  \n\
@@ -2070,7 +2192,26 @@ __cont_link_context:        \n\
   nop            \n\
   .seh_endproc         \n\
   ");
-
+#elif defined(__aarch64__)
+/*   _MC_uclinkReg =3D=3D x19.  x19 holds the address of the uc_link slot =
but is
+  only 8-byte aligned, so read through it and mask into SP in one step
+  rather than moving the unaligned value into SP first.  setcontext and
+  cygwin_exit are noreturn, so tail-call them with 'b': this leaves x30
+  untouched and keeps the frame leaf, matching the empty SEH prologue. */
+__asm__ ("             \n\
+  .global  __cont_link_context     \n\
+  .seh_proc __cont_link_context    \n\
+__cont_link_context:            \n\
+  .seh_endprologue        \n\
+  ldr   x0, [x19]         \n\
+  and   sp, x19, #~0xf       \n\
+  cbnz  x0, 1f            \n\
+  mov   w0, #0xff         \n\
+  b  cygwin_exit       \n\
+1:                  \n\
+  b  setcontext        \n\
+  .seh_endproc            \n"
+  );
 #else
 #error unimplemented for this target
 #endif
@@ -2078,11 +2219,19 @@ __cont_link_context:       \n\
 /* makecontext is modelled after GLibc's makecontext.  The stack from uc_s=
tack
    is prepared so that it starts with a pointer to the linked context uc_l=
ink,
    followed by the arguments to func, and finally at the bottom the "retur=
n"
-   address set to __cont_link_context.  In the ucp context, rbx/ebx is set=
 to
-   point to the stack address where the pointer to uc_link is stored.  The
-   requirement to make this work is that rbx/ebx are callee-saved registers
-   per the ABI.  If any function is called which doesn't follow the ABI
-   conventions, e.g. assembler code, this method will break.  But that's o=
k. */
+   address set to __cont_link_context.
+
+   x86_64: In the ucp context, rbx is set to point to the stack address wh=
ere
+   the pointer to uc_link is stored.  The requirement to make this work is=
 that
+   rbx is a callee-saved register per the ABI.
+
+   ARM64: In the ucp context, x19 is set to point to the stack address whe=
re
+   the pointer to uc_link is stored.  The requirement is that x19 is a
+   callee-saved register per the ARM64 ABI.
+
+   If any function is called which doesn't follow the ABI conventions, e.g.
+   assembler code, this method will break.  But that's ok. */
+
 extern "C" void
 makecontext (ucontext_t *ucp, void (*func) (void), int argc, ...)
 {
@@ -2090,65 +2239,150 @@ makecontext (ucontext_t *ucp, void (*func) (void),=
 int argc, ...)
   uintptr_t *sp;
   va_list ap;

+#if defined(__x86_64__)
+  /* x86_64: Arguments beyond the first 4 go on the stack.
+     However, we allocate shadow space for all args including register arg=
s. */
+  int stack_args =3D argc;
+
+#elif defined(__aarch64__)
+  /* ARM64: Arguments beyond the first 8 go on the stack.
+     We only allocate stack space for args beyond registers. */
+  int stack_args =3D (argc > 8) ? (argc - 8) : 0;
+
+#else
+#error unimplemented for this target
+#endif
+
   /* Initialize sp to the top of the stack. */
   sp =3D (uintptr_t *) ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss=
_size);
-  /* Subtract slots required for arguments and the pointer to uc_link. */
-  sp -=3D (argc + 1);
-  /* Align. */
-  sp =3D (uintptr_t *) ((uintptr_t) sp & ~0xf);
-  /* Subtract one slot for setting the return address. */
+
+#if defined(__x86_64__)
+  /* x86_64: Subtract slots for all arguments + uc_link pointer
+     and return address.  */
+  sp -=3D (stack_args + 1);  /* argc + 1 for uc_link */
+  /* Align to 16 bytes. */
+  sp =3D (uintptr_t *) ((uintptr_t) sp & ~0xfUL);
+  /* Subtract one more slot for the return address. */
   --sp;
-  /* Set return address to the trampolin function __cont_link_context. */
+  /* Set return address to the trampoline function __cont_link_context. */
   sp[0] =3D (uintptr_t) __cont_link_context;
-  /* Fetch arguments and store them on the stack.

-     x86_64:
+#elif defined(__aarch64__)
+  /* ARM64: Subtract slots for stack arguments + uc_link pointer. */
+  sp -=3D (stack_args + 1);  /* stack_args + 1 for uc_link */
+  /* ARM64 requires 16-byte alignment at public interfaces. */
+  sp =3D (uintptr_t *) ((uintptr_t) sp & ~0xfUL);

-     - Store first four args in the AMD64 ABI arg registers.
+#endif

+  /* Fetch arguments and store them.
+     x86_64:
+     - Store first four args in the AMD64 ABI arg registers (rcx, rdx, r8,=
 r9).
      - Note that the stack is not short by these four register args.  The
        reason is the shadow space for these regs required by the AMD64 ABI.
-
      - The definition of makecontext only allows for "int" sized arguments=
 to
        func, 32 bit, likely for historical reasons.  However, the argument
        slots on x86_64 are 64 bit anyway, so we can fetch and store the ar=
gs
        as 64 bit values, and func can request 64 bit args without violating
        the definition.  This potentially allows porting 32 bit applications
-       providing pointer values to func without additional porting effort.=
 */
+       providing pointer values to func without additional porting effort.
+
+     ARM64:
+     - Store first eight args in ARM64 ABI arg registers (x0-x7).
+     - Arguments beyond 8 go on the stack.
+     - Similar to x86_64, we store as uintptr_t for pointer compatibility.=
 */
+
   va_start (ap, argc);
   for (int i =3D 0; i < argc; ++i)
-#ifdef __x86_64__
-    switch (i)
-      {
-      case 0:
-  ucp->uc_mcontext.rcx =3D va_arg (ap, uintptr_t);
-  break;
-      case 1:
-  ucp->uc_mcontext.rdx =3D va_arg (ap, uintptr_t);
-  break;
-      case 2:
-  ucp->uc_mcontext.r8 =3D va_arg (ap, uintptr_t);
-  break;
-      case 3:
-  ucp->uc_mcontext.r9 =3D va_arg (ap, uintptr_t);
-  break;
-      default:
-  sp[i + 1] =3D va_arg (ap, uintptr_t);
-  break;
-      }
-#else
-#error unimplemented for this target
+    {
+#if defined(__x86_64__)
+      switch (i)
+        {
+        case 0:
+          ucp->uc_mcontext.rcx =3D va_arg (ap, uintptr_t);
+          break;
+        case 1:
+          ucp->uc_mcontext.rdx =3D va_arg (ap, uintptr_t);
+          break;
+        case 2:
+          ucp->uc_mcontext.r8 =3D va_arg (ap, uintptr_t);
+          break;
+        case 3:
+          ucp->uc_mcontext.r9 =3D va_arg (ap, uintptr_t);
+          break;
+        default:
+          /* Stack arguments start at sp[i + 1] because sp[0] is return ad=
dress */
+          sp[i + 1] =3D va_arg (ap, uintptr_t);
+          break;
+        }
+
+#elif defined(__aarch64__)
+      switch (i)
+        {
+        case 0:
+          ucp->uc_mcontext.x0 =3D va_arg (ap, uintptr_t);
+          break;
+        case 1:
+          ucp->uc_mcontext.x1 =3D va_arg (ap, uintptr_t);
+          break;
+        case 2:
+          ucp->uc_mcontext.x2 =3D va_arg (ap, uintptr_t);
+          break;
+        case 3:
+          ucp->uc_mcontext.x3 =3D va_arg (ap, uintptr_t);
+          break;
+        case 4:
+          ucp->uc_mcontext.x4 =3D va_arg (ap, uintptr_t);
+          break;
+        case 5:
+          ucp->uc_mcontext.x5 =3D va_arg (ap, uintptr_t);
+          break;
+        case 6:
+          ucp->uc_mcontext.x6 =3D va_arg (ap, uintptr_t);
+          break;
+        case 7:
+          ucp->uc_mcontext.x7 =3D va_arg (ap, uintptr_t);
+          break;
+        default:
+          /* Stack arguments beyond the first 8 registers. */
+          sp[i - 8] =3D va_arg (ap, uintptr_t);
+          break;
+        }
 #endif
+    }
   va_end (ap);
-  /* Store pointer to uc_link at the top of the stack. */
+
+#if defined(__x86_64__)
+  /* Store pointer to uc_link at sp[argc + 1], after return address
+     and args.  */
   sp[argc + 1] =3D (uintptr_t) ucp->uc_link;
+
+#elif defined(__aarch64__)
+  /* Store pointer to uc_link at the top of our allocated area. */
+  sp[stack_args] =3D (uintptr_t) ucp->uc_link;
+
+#endif
+
   /* Last but not least set the register in the context at ucp so that a
      subsequent setcontext or swapcontext picks up the right values:
      - Set instruction pointer to the target function.
      - Set stack pointer to the just computed stack pointer value.
      - Set Cygwin-specific uclink register to the address of the pointer
-       to uc_link. */
+       to uc_link.
+
+     x86_64: uclink register is rbx (callee-saved)
+     ARM64:  uclink register is x19 (callee-saved) */
+
   ucp->uc_mcontext._MC_instPtr =3D (uint64_t) func;
   ucp->uc_mcontext._MC_stackPtr =3D (uint64_t) sp;
+
+#if defined(__x86_64__)
   ucp->uc_mcontext._MC_uclinkReg =3D (uint64_t) (sp + argc + 1);
+
+#elif defined(__aarch64__)
+  /* Set LR to __cont_link_context for ARM64 (used as return address). */
+  ucp->uc_mcontext.lr =3D (uint64_t) __cont_link_context;
+  ucp->uc_mcontext._MC_uclinkReg =3D (uint64_t) (sp + stack_args);
+
+#endif
 }
--
2.49.0.windows.1




--_000_PN0P287MB029504FE0939EFA34AEC78E592FD2PN0P287MB0295INDP_--

--_004_PN0P287MB029504FE0939EFA34AEC78E592FD2PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-exceptions-Add-AArch64-support-for-signal-han.patch"
Content-Description:
 Cygwin-exceptions-Add-AArch64-support-for-signal-han.patch
Content-Disposition: attachment;
	filename="Cygwin-exceptions-Add-AArch64-support-for-signal-han.patch";
	size=15890; creation-date="Fri, 10 Jul 2026 11:54:14 GMT";
	modification-date="Fri, 10 Jul 2026 11:55:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxYmFhMzI2NzEyNmI0NDBiM2FmZmIzMDllZWY3MTA5NjI0M2E5NTdl
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IEZyaSwgMTAgSnVsIDIwMjYgMTc6MTA6MTggKzA1MzAKU3ViamVjdDogW1BB
VENIIHYyXSBDeWd3aW46IGV4Y2VwdGlvbnM6IEFkZCBBQXJjaDY0IHN1cHBv
cnQgZm9yIHNpZ25hbAogaGFuZGxpbmcgYW5kIHVjb250ZXh0IHJvdXRpbmVz
Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsg
Y2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0
CgpBZGQgQUFyY2g2NCBzdXBwb3J0IGZvciBzaWduYWwgaGFuZGxpbmcgYW5k
IHVjb250ZXh0IHJvdXRpbmVzCihjYWxsX3NpZ25hbF9oYW5kbGVyLCBzZXRj
b250ZXh0LCBfX2NvbnRfbGlua19jb250ZXh0LCBtYWtlY29udGV4dCkKaW4g
ZXhjZXB0aW9ucy5jYywgZW5hYmxpbmcgQ3lnd2luIG9uIEFSTTY0IFdpbmRv
d3MuIHNldGNvbnRleHQgdXNlcwptYW51YWwgYXNtIGluc3RlYWQgb2YgUnRs
UmVzdG9yZUNvbnRleHQsIHdoaWNoIGZhaWxzIHdpdGggc3ludGhldGljCkNP
TlRFWFQgc3RydWN0cyBmcm9tIG1ha2Vjb250ZXh0LiAjaWZkZWYgZ3VhcmRz
IGFyZSBhbHNvIHVwZGF0ZWQgdG8KICNpZiBkZWZpbmVkKCkgZm9yIGNvbnNp
c3RlbmN5LgoKU2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/DhcuGIDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KU2lnbmVkLW9mZi1ieTogVGhpcnVt
YWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGlj
b3Jld2FyZWluYy5jb20+ClNpZ25lZC1vZmYtYnk6IEFzd2luIEthbGllcyA8
YXN3aW4ua2FsaWVzQG11bHRpY29yZXdhcmVpbmMuY29tPgpTaWduZWQtb2Zm
LWJ5OiBDaGFuZHJ1IEt1bWFyZXNhbiA8Y2hhbmRydS5rdW1hcmVzYW5AbXVs
dGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9leGNlcHRp
b25zLmNjIHwgMzE4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDI3NiBpbnNlcnRpb25zKCspLCA0MiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2V4Y2Vw
dGlvbnMuY2MgYi93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MKaW5kZXgg
MWUxMjliMzE5Li5jYjVmMWRjMWQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3
aW4vZXhjZXB0aW9ucy5jYworKysgYi93aW5zdXAvY3lnd2luL2V4Y2VwdGlv
bnMuY2MKQEAgLTE4OTIsNyArMTg5Miw3IEBAIF9jeWd0bHM6OmNhbGxfc2ln
bmFsX2hhbmRsZXIgKCkKIAogCSAgLyogSW4gYXNzZW1ibGVyOiBTYXZlIHJl
Z3Mgb24gbmV3IHN0YWNrLCBtb3ZlIHRvIGFsdGVybmF0ZSBzdGFjaywKIAkg
ICAgIGNhbGwgdGhpc2Z1bmMsIHJldmVydCBzdGFjayByZWdzLiAqLwotI2lm
ZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJICAv
KiBDbG9iYmVyZWQgcmVnczogcmN4LCByZHgsIHI4LCByOSwgcjEwLCByMTEs
IHJicCwgcnNwICovCiAJICBfX2FzbV9fICgiXG5cCiAJCSAgIG1vdnEgICVb
TkVXX1NQXSwgJSVyYXggICMgTG9hZCBhbHQgc3RhY2sgaW50byByYXgJXG5c
CkBAIC0xOTMwLDYgKzE5MzAsNjAgQEAgX2N5Z3Rsczo6Y2FsbF9zaWduYWxf
aGFuZGxlciAoKQogCQkgICAgICAgW0ZVTkNdCSJvIiAodGhpc2Z1bmMpLAog
CQkgICAgICAgW1dSQVBQRVJdICJvIiAoYWx0c3RhY2tfd3JhcHBlcikKIAkJ
ICAgOiAibWVtb3J5Iik7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQor
CSAgX19hc21fXyAoIlxuXAorCQkgICBtb3YJeDksICVbTkVXX1NQXQkJLy8g
TG9hZCBhbHQgc3RhY2sgaW50byB4OQlcblwKKwkJICAgc3ViCXg5LCB4OSwg
IzB4NjAJCS8vIE1ha2Ugcm9vbSBvbiBhbHQgc3RhY2sJXG5cCisJCQkJCQkv
LyBmb3IgY2xvYmJlcmVkIHJlZ3MJCVxuXAorCQkgICBzdHIJeDAsIFt4OSwg
IzB4MDBdCQkvLyBTYXZlIGNsb2JiZXJlZCByZWdzCQlcblwKKwkJICAgc3Ry
CXgxLCBbeDksICMweDA4XQkJCQkJCVxuXAorCQkgICBzdHIJeDIsIFt4OSwg
IzB4MTBdCQkJCQkJXG5cCisJCSAgIHN0cgl4MywgW3g5LCAjMHgxOF0JCQkJ
CQlcblwKKwkJICAgc3RyCXg0LCBbeDksICMweDIwXQkJCQkJCVxuXAorCQkg
ICBzdHIJeDUsIFt4OSwgIzB4MjhdCQkJCQkJXG5cCisJCSAgIHN0cgl4Niwg
W3g5LCAjMHgzMF0JCQkJCQlcblwKKwkJICAgc3RyCXg3LCBbeDksICMweDM4
XQkJCQkJCVxuXAorCQkgICBzdHIJZnAsIFt4OSwgIzB4NDBdCQkJCQkJXG5c
CisJCSAgIG1vdgl4MTAsIHNwCQkJLy8gQ29weSBzcCBpbnRvIHgxMCBmb3Ig
c2F2aW5nCVxuXAorCQkgICBzdHIJeDEwLCBbeDksICMweDQ4XQkJCQkJXG5c
CisJCSAgIHN0cgl4MzAsIFt4OSwgIzB4NTBdCS8vIFNhdmUgbGluayByZWdp
c3RlcgkJXG5cCisJCSAgIG1vdgl4MCwgJVtTSUddCQkvLyB0aGlzc2lnIHRv
IDFzdCBhcmcgcmVnCVxuXAorCQkgICBtb3YJeDEsICVbU0ldCQkvLyAmdGhp
c3NpIHRvIDJuZCBhcmcgcmVnCVxuXAorCQkgICBtb3YJeDIsICVbQ1RYXQkJ
Ly8gdGhpc2NvbnRleHQgdG8gM3JkIGFyZyByZWcJXG5cCisJCSAgIG1vdgl4
MywgJVtGVU5DXQkJLy8gdGhpc2Z1bmMgdG8geDMJCVxuXAorCQkgICBtb3YJ
eDQsICVbV1JBUFBFUl0JCS8vIHdyYXBwZXIgYWRkcmVzcyB0byB4NAlcblwK
KwkJICAgbW92CXNwLCB4OQkJCS8vIE1vdmUgYWx0IHN0YWNrIGludG8gc3AJ
XG5cCisJCSAgIGJscgl4NAkJCS8vIENhbGwgd3JhcHBlcgkJCVxuXAorCQkg
ICBtb3YJeDksIHNwCQkJLy8gUmVzdG9yZSBjbG9iYmVyZWQgcmVncwlcblwK
KwkJICAgbGRyCXgzMCwgW3g5LCAjMHg1MF0JLy8gUmVzdG9yZSBsaW5rIHJl
Z2lzdGVyCVxuXAorCQkgICBsZHIJeDEwLCBbeDksICMweDQ4XQkJCQkJXG5c
CisJCSAgIGxkcglmcCwgIFt4OSwgIzB4NDBdCQkJCQlcblwKKwkJICAgbGRy
CXg3LCAgW3g5LCAjMHgzOF0JCQkJCVxuXAorCQkgICBsZHIJeDYsICBbeDks
ICMweDMwXQkJCQkJXG5cCisJCSAgIGxkcgl4NSwgIFt4OSwgIzB4MjhdCQkJ
CQlcblwKKwkJICAgbGRyCXg0LCAgW3g5LCAjMHgyMF0JCQkJCVxuXAorCQkg
ICBsZHIJeDMsICBbeDksICMweDE4XQkJCQkJXG5cCisJCSAgIGxkcgl4Miwg
IFt4OSwgIzB4MTBdCQkJCQlcblwKKwkJICAgbGRyCXgxLCAgW3g5LCAjMHgw
OF0JCQkJCVxuXAorCQkgICBsZHIJeDAsICBbeDksICMweDAwXQkJCQkJXG5c
CisJCSAgIG1vdglzcCwgIHgxMAkJLy8gUmVzdG9yZSBzdGFjayBwb2ludGVy
CVxuIgorCQkgICA6IDogW05FV19TUF0JICJyIiAobmV3X3NwKSwKKwkJICAg
ICAgIFtTSUddCSAiciIgKHRoaXNzaWcpLAorCQkgICAgICAgW1NJXQkgInIi
ICgmdGhpc3NpKSwKKwkJICAgICAgIFtDVFhdCSAiciIgKHRoaXNjb250ZXh0
KSwKKwkJICAgICAgIFtGVU5DXQkgInIiICh0aGlzZnVuYyksCisJCSAgICAg
ICBbV1JBUFBFUl0gInIiIChhbHRzdGFja193cmFwcGVyKQorCQkgIC8qIGFs
dHN0YWNrX3dyYXBwZXIgaXMgYW4gb3JkaW5hcnkgQyBjYWxsLCBzbyBldmVy
eQorCQkJIGNhbGxlci1zYXZlZCByZWdpc3RlciBtYXkgYmUgY2xvYmJlcmVk
LiAgeDE4ICh0aGUgV2luZG93cworCQkJIFRFQiBwb2ludGVyKSBhbmQgdjgt
djE1IChjYWxsZWUtc2F2ZWQgb24gV2luZG93cykgYXJlCisJCQkgcHJlc2Vy
dmVkIGFuZCB0aHVzIG9taXR0ZWQuICAqLworCQkgICA6ICJtZW1vcnkiLCAi
Y2MiLAorCQkgICAgICJ4MCIsICJ4MSIsICJ4MiIsICJ4MyIsICJ4NCIsICJ4
NSIsICJ4NiIsICJ4NyIsCisJCSAgICAgIng4IiwgIng5IiwgIngxMCIsICJ4
MTEiLCAieDEyIiwgIngxMyIsICJ4MTQiLCAieDE1IiwKKwkJICAgICAieDE2
IiwgIngxNyIsICJ4MjkiLCAieDMwIiwKKwkJICAgICAidjAiLCAidjEiLCAi
djIiLCAidjMiLCAidjQiLCAidjUiLCAidjYiLCAidjciLAorCQkgICAgICJ2
MTYiLCAidjE3IiwgInYxOCIsICJ2MTkiLCAidjIwIiwgInYyMSIsICJ2MjIi
LCAidjIzIiwKKwkJICAgICAidjI0IiwgInYyNSIsICJ2MjYiLCAidjI3Iiwg
InYyOCIsICJ2MjkiLCAidjMwIiwgInYzMSIpOwogI2Vsc2UKICNlcnJvciB1
bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCkBAIC0yMDA5
LDEwICsyMDYzLDc4IEBAIHNldGNvbnRleHQgKGNvbnN0IHVjb250ZXh0X3Qg
KnVjcCkKIHsKICAgUENPTlRFWFQgY3R4ID0gKFBDT05URVhUKSAmdWNwLT51
Y19tY29udGV4dDsKICAgc2V0X3NpZ25hbF9tYXNrIChfbXlfdGxzLnNpZ21h
c2ssIHVjcC0+dWNfc2lnbWFzayk7CisjaWYgZGVmaW5lZChfX2FhcmNoNjRf
XykKKyAgLyogT24gQVJNNjQgV2luZG93cywgUnRsUmVzdG9yZUNvbnRleHQg
bWF5IGZhaWwgKFNUQVRVU19JTExFR0FMX0lOU1RSVUNUSU9OKQorICAgICB3
aGVuIHJlc3RvcmluZyBhIHN5bnRoZXRpYyBDT05URVhUIHRoYXQgd2FzIGNv
bnN0cnVjdGVkIGJ5IG1ha2Vjb250ZXh0CisgICAgIHJhdGhlciB0aGFuIGNh
cHR1cmVkIGJ5IFJ0bENhcHR1cmVDb250ZXh0IC8gR2V0VGhyZWFkQ29udGV4
dC4gIFRoaXMgaXMKKyAgICAgYmVjYXVzZSBSdGxSZXN0b3JlQ29udGV4dCBt
YXkgcGVyZm9ybSB2YWxpZGF0aW9uIG9yIHVzZSBpbnRlcm5hbAorICAgICBt
ZWNoYW5pc21zIChlLmcuIHN0YWNrIHVud2luZGluZyBoaW50cykgdGhhdCBk
b24ndCB3b3JrIHdpdGggc3ludGhldGljCisgICAgIGNvbnRleHRzIHBvaW50
aW5nIHRvIGFyYml0cmFyeSBQQyBhZGRyZXNzZXMgYW5kIG5vbi10aHJlYWQg
c3RhY2tzLgorCisgICAgIEluc3RlYWQsIHdlIG1hbnVhbGx5IHJlc3RvcmUg
YWxsIHJlZ2lzdGVycyBhbmQgYnJhbmNoIHRvIHRoZSBzYXZlZCBQQy4KKyAg
ICAgVGhpcyBtaXJyb3JzIHdoYXQgZ2xpYmMvbXVzbCBkbyBpbiB0aGVpciBz
ZXRjb250ZXh0IGltcGxlbWVudGF0aW9ucworICAgICBmb3IgYWFyY2g2NC1s
aW51eC4gICovCisgIHJlZ2lzdGVyIFBDT05URVhUIGJhc2UgX19hc21fXyAo
IngxNiIpID0gY3R4OworICBfX2FzbV9fIF9fdm9sYXRpbGVfXyAoIlxuXAor
CWFkZAl4MTcsIHgxNiwgIzI3MgkJCQkJXG5cCisJbGRwCXEwLCBxMSwgW3gx
NywgIzBdCQkJCVxuXAorCWxkcAlxMiwgcTMsIFt4MTcsICMzMl0JCQkJXG5c
CisJbGRwCXE0LCBxNSwgW3gxNywgIzY0XQkJCQlcblwKKwlsZHAJcTYsIHE3
LCBbeDE3LCAjOTZdCQkJCVxuXAorCWxkcAlxOCwgcTksIFt4MTcsICMxMjhd
CQkJCVxuXAorCWxkcAlxMTAsIHExMSwgW3gxNywgIzE2MF0JCQkJXG5cCisJ
bGRwCXExMiwgcTEzLCBbeDE3LCAjMTkyXQkJCQlcblwKKwlsZHAJcTE0LCBx
MTUsIFt4MTcsICMyMjRdCQkJCVxuXAorCWxkcAlxMTYsIHExNywgW3gxNywg
IzI1Nl0JCQkJXG5cCisJbGRwCXExOCwgcTE5LCBbeDE3LCAjMjg4XQkJCQlc
blwKKwlsZHAJcTIwLCBxMjEsIFt4MTcsICMzMjBdCQkJCVxuXAorCWxkcAlx
MjIsIHEyMywgW3gxNywgIzM1Ml0JCQkJXG5cCisJbGRwCXEyNCwgcTI1LCBb
eDE3LCAjMzg0XQkJCQlcblwKKwlsZHAJcTI2LCBxMjcsIFt4MTcsICM0MTZd
CQkJCVxuXAorCWxkcAlxMjgsIHEyOSwgW3gxNywgIzQ0OF0JCQkJXG5cCisJ
bGRwCXEzMCwgcTMxLCBbeDE3LCAjNDgwXQkJCQlcblwKKwkvKiBSZXN0b3Jl
IEZQQ1IgYW5kIEZQU1IgKi8JCQkJXG5cCisJbGRyCXcxNywgW3gxNiwgIzc4
NF0JCQkJXG5cCisJbXNyCWZwY3IsIHgxNwkJCQkJXG5cCisJbGRyCXcxNywg
W3gxNiwgIzc4OF0JCQkJXG5cCisJbXNyCWZwc3IsIHgxNwkJCQkJXG5cCisJ
LyogTG9hZCBQQyBpbnRvIHgxNyAoYnJhbmNoIHRhcmdldCwgb2Zmc2V0IDI2
NCkgKi8JXG5cCisJbGRyCXgxNywgW3gxNiwgIzI2NF0JCQkJXG5cCisJLyog
UmVzdG9yZSBjYWxsZWUtc2F2ZWQgR1BScyB4MTguLngyOCwgZnAsIGxyICov
CVxuXAorCWxkcAl4MTgsIHgxOSwgW3gxNiwgIzE1Ml0JCQkJXG5cCisJbGRw
CXgyMCwgeDIxLCBbeDE2LCAjMTY4XQkJCQlcblwKKwlsZHAJeDIyLCB4MjMs
IFt4MTYsICMxODRdCQkJCVxuXAorCWxkcAl4MjQsIHgyNSwgW3gxNiwgIzIw
MF0JCQkJXG5cCisJbGRwCXgyNiwgeDI3LCBbeDE2LCAjMjE2XQkJCQlcblwK
KwlsZHAJeDI4LCB4MjksIFt4MTYsICMyMzJdCQkJCVxuXAorCWxkcgl4MzAs
IFt4MTYsICMyNDhdCQkJCVxuXAorCS8qIFJlc3RvcmUgY2FsbGVyLXNhdmVk
IEdQUnMgeDIuLngxNSAqLwkJCVxuXAorCWxkcAl4MiwgeDMsIFt4MTYsICMy
NF0JCQkJXG5cCisJbGRwCXg0LCB4NSwgW3gxNiwgIzQwXQkJCQlcblwKKwls
ZHAJeDYsIHg3LCBbeDE2LCAjNTZdCQkJCVxuXAorCWxkcAl4OCwgeDksIFt4
MTYsICM3Ml0JCQkJXG5cCisJbGRwCXgxMCwgeDExLCBbeDE2LCAjODhdCQkJ
CVxuXAorCWxkcAl4MTIsIHgxMywgW3gxNiwgIzEwNF0JCQkJXG5cCisJbGRw
CXgxNCwgeDE1LCBbeDE2LCAjMTIwXQkJCQlcblwKKwkvKiBSZXN0b3JlIHgw
LCB4MSAqLwkJCQkJXG5cCisJbGRwCXgwLCB4MSwgW3gxNiwgIzhdCQkJCVxu
XAorCS8qIFNldCBTUCBmcm9tIGNvbnRleHQgKGxhc3QgdXNlIG9mIHgxNiBh
cyBiYXNlKSAqLwlcblwKKwlsZHIJeDE2LCBbeDE2LCAjMjU2XQkJCQlcblwK
Kwltb3YJc3AsIHgxNgkJCQkJCVxuXAorCS8qIEJyYW5jaCB0byBzYXZlZCBQ
QyAqLwkJCQlcblwKKwlicgl4MTcJCQkJCQlcblwKKyIKKwk6IC8qIG5vIG91
dHB1dHMgKG5vcmV0dXJuKSAqLworCTogInIiIChiYXNlKQorCTogIm1lbW9y
eSIKKyAgKTsKKyAgX19idWlsdGluX3VucmVhY2hhYmxlICgpOworI2Vsc2UK
ICAgUnRsUmVzdG9yZUNvbnRleHQgKGN0eCwgTlVMTCk7CiAgIC8qIElmIHdl
IGdvdCBoZXJlLCBzb21ldGhpbmcgd2FzIHdyb25nLiAqLwogICBzZXRfZXJy
bm8gKEVJTlZBTCk7CiAgIHJldHVybiAtMTsKKyNlbmRpZgogfQogCiBleHRl
cm4gIkMiIGludApAQCAtMjA0OSw3ICsyMTcxLDcgQEAgc3dhcGNvbnRleHQg
KHVjb250ZXh0X3QgKm91Y3AsIGNvbnN0IHVjb250ZXh0X3QgKnVjcCkKIC8q
IFRyYW1wb2xpbmUgZnVuY3Rpb24gdG8gc2V0IHRoZSBjb250ZXh0IHRvIHVj
X2xpbmsuICBUaGUgcG9pbnRlciB0byB0aGUKICAgIGFkZHJlc3Mgb2YgdWNf
bGluayBpcyBzdG9yZWQgaW4gYSBjYWxsZWUtc2F2ZWQgcmVnaXN0ZXIsIHJl
ZmVyZW5jZWQgYnkKICAgIF9NQ191Y2xpbmtSZWcgZnJvbSB0aGUgQyBjb2Rl
LiAgSWYgdWNfbGluayBpcyBOVUxMLCBjYWxsIGV4aXQuICovCi0jaWZkZWYg
X194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIC8qIF9NQ191
Y2xpbmtSZWcgPT0gJXJieCAqLwogX19hc21fXyAoIgkJCQlcblwKIAkuZ2xv
YmFsCV9fY29udF9saW5rX2NvbnRleHQJXG5cCkBAIC0yMDcwLDcgKzIxOTIs
MjYgQEAgX19jb250X2xpbmtfY29udGV4dDoJCQlcblwKIAlub3AJCQkJXG5c
CiAJLnNlaF9lbmRwcm9jCQkJXG5cCiAJIik7Ci0KKyNlbGlmIGRlZmluZWQo
X19hYXJjaDY0X18pCisvKglfTUNfdWNsaW5rUmVnID09IHgxOS4gIHgxOSBo
b2xkcyB0aGUgYWRkcmVzcyBvZiB0aGUgdWNfbGluayBzbG90IGJ1dCBpcwor
CW9ubHkgOC1ieXRlIGFsaWduZWQsIHNvIHJlYWQgdGhyb3VnaCBpdCBhbmQg
bWFzayBpbnRvIFNQIGluIG9uZSBzdGVwCisJcmF0aGVyIHRoYW4gbW92aW5n
IHRoZSB1bmFsaWduZWQgdmFsdWUgaW50byBTUCBmaXJzdC4gIHNldGNvbnRl
eHQgYW5kCisJY3lnd2luX2V4aXQgYXJlIG5vcmV0dXJuLCBzbyB0YWlsLWNh
bGwgdGhlbSB3aXRoICdiJzogdGhpcyBsZWF2ZXMgeDMwCisJdW50b3VjaGVk
IGFuZCBrZWVwcyB0aGUgZnJhbWUgbGVhZiwgbWF0Y2hpbmcgdGhlIGVtcHR5
IFNFSCBwcm9sb2d1ZS4gKi8KK19fYXNtX18gKCIJCQkJCVxuXAorCS5nbG9i
YWwJX19jb250X2xpbmtfY29udGV4dAkJXG5cCisJLnNlaF9wcm9jIF9fY29u
dF9saW5rX2NvbnRleHQJCVxuXAorX19jb250X2xpbmtfY29udGV4dDoJCQkJ
XG5cCisJLnNlaF9lbmRwcm9sb2d1ZQkJCVxuXAorCWxkcgl4MCwgW3gxOV0J
CQlcblwKKwlhbmQJc3AsIHgxOSwgI34weGYJCQlcblwKKwljYm56CXgwLCAx
ZgkJCQlcblwKKwltb3YJdzAsICMweGZmCQkJXG5cCisJYgljeWd3aW5fZXhp
dAkJCVxuXAorMToJCQkJCQlcblwKKwliCXNldGNvbnRleHQJCQlcblwKKwku
c2VoX2VuZHByb2MJCQkJXG4iCisJKTsKICNlbHNlCiAjZXJyb3IgdW5pbXBs
ZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgpAQCAtMjA3OCwxMSAr
MjIxOSwxOSBAQCBfX2NvbnRfbGlua19jb250ZXh0OgkJCVxuXAogLyogbWFr
ZWNvbnRleHQgaXMgbW9kZWxsZWQgYWZ0ZXIgR0xpYmMncyBtYWtlY29udGV4
dC4gIFRoZSBzdGFjayBmcm9tIHVjX3N0YWNrCiAgICBpcyBwcmVwYXJlZCBz
byB0aGF0IGl0IHN0YXJ0cyB3aXRoIGEgcG9pbnRlciB0byB0aGUgbGlua2Vk
IGNvbnRleHQgdWNfbGluaywKICAgIGZvbGxvd2VkIGJ5IHRoZSBhcmd1bWVu
dHMgdG8gZnVuYywgYW5kIGZpbmFsbHkgYXQgdGhlIGJvdHRvbSB0aGUgInJl
dHVybiIKLSAgIGFkZHJlc3Mgc2V0IHRvIF9fY29udF9saW5rX2NvbnRleHQu
ICBJbiB0aGUgdWNwIGNvbnRleHQsIHJieC9lYnggaXMgc2V0IHRvCi0gICBw
b2ludCB0byB0aGUgc3RhY2sgYWRkcmVzcyB3aGVyZSB0aGUgcG9pbnRlciB0
byB1Y19saW5rIGlzIHN0b3JlZC4gIFRoZQotICAgcmVxdWlyZW1lbnQgdG8g
bWFrZSB0aGlzIHdvcmsgaXMgdGhhdCByYngvZWJ4IGFyZSBjYWxsZWUtc2F2
ZWQgcmVnaXN0ZXJzCi0gICBwZXIgdGhlIEFCSS4gIElmIGFueSBmdW5jdGlv
biBpcyBjYWxsZWQgd2hpY2ggZG9lc24ndCBmb2xsb3cgdGhlIEFCSQotICAg
Y29udmVudGlvbnMsIGUuZy4gYXNzZW1ibGVyIGNvZGUsIHRoaXMgbWV0aG9k
IHdpbGwgYnJlYWsuICBCdXQgdGhhdCdzIG9rLiAqLworICAgYWRkcmVzcyBz
ZXQgdG8gX19jb250X2xpbmtfY29udGV4dC4KKworICAgeDg2XzY0OiBJbiB0
aGUgdWNwIGNvbnRleHQsIHJieCBpcyBzZXQgdG8gcG9pbnQgdG8gdGhlIHN0
YWNrIGFkZHJlc3Mgd2hlcmUKKyAgIHRoZSBwb2ludGVyIHRvIHVjX2xpbmsg
aXMgc3RvcmVkLiAgVGhlIHJlcXVpcmVtZW50IHRvIG1ha2UgdGhpcyB3b3Jr
IGlzIHRoYXQKKyAgIHJieCBpcyBhIGNhbGxlZS1zYXZlZCByZWdpc3RlciBw
ZXIgdGhlIEFCSS4KKworICAgQVJNNjQ6IEluIHRoZSB1Y3AgY29udGV4dCwg
eDE5IGlzIHNldCB0byBwb2ludCB0byB0aGUgc3RhY2sgYWRkcmVzcyB3aGVy
ZQorICAgdGhlIHBvaW50ZXIgdG8gdWNfbGluayBpcyBzdG9yZWQuICBUaGUg
cmVxdWlyZW1lbnQgaXMgdGhhdCB4MTkgaXMgYQorICAgY2FsbGVlLXNhdmVk
IHJlZ2lzdGVyIHBlciB0aGUgQVJNNjQgQUJJLgorCisgICBJZiBhbnkgZnVu
Y3Rpb24gaXMgY2FsbGVkIHdoaWNoIGRvZXNuJ3QgZm9sbG93IHRoZSBBQkkg
Y29udmVudGlvbnMsIGUuZy4KKyAgIGFzc2VtYmxlciBjb2RlLCB0aGlzIG1l
dGhvZCB3aWxsIGJyZWFrLiAgQnV0IHRoYXQncyBvay4gKi8KKwogZXh0ZXJu
ICJDIiB2b2lkCiBtYWtlY29udGV4dCAodWNvbnRleHRfdCAqdWNwLCB2b2lk
ICgqZnVuYykgKHZvaWQpLCBpbnQgYXJnYywgLi4uKQogewpAQCAtMjA5MCw2
NSArMjIzOSwxNTAgQEAgbWFrZWNvbnRleHQgKHVjb250ZXh0X3QgKnVjcCwg
dm9pZCAoKmZ1bmMpICh2b2lkKSwgaW50IGFyZ2MsIC4uLikKICAgdWludHB0
cl90ICpzcDsKICAgdmFfbGlzdCBhcDsKIAorI2lmIGRlZmluZWQoX194ODZf
NjRfXykKKyAgLyogeDg2XzY0OiBBcmd1bWVudHMgYmV5b25kIHRoZSBmaXJz
dCA0IGdvIG9uIHRoZSBzdGFjay4KKyAgICAgSG93ZXZlciwgd2UgYWxsb2Nh
dGUgc2hhZG93IHNwYWNlIGZvciBhbGwgYXJncyBpbmNsdWRpbmcgcmVnaXN0
ZXIgYXJncy4gKi8KKyAgaW50IHN0YWNrX2FyZ3MgPSBhcmdjOworCisjZWxp
ZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorICAvKiBBUk02NDogQXJndW1lbnRz
IGJleW9uZCB0aGUgZmlyc3QgOCBnbyBvbiB0aGUgc3RhY2suCisgICAgIFdl
IG9ubHkgYWxsb2NhdGUgc3RhY2sgc3BhY2UgZm9yIGFyZ3MgYmV5b25kIHJl
Z2lzdGVycy4gKi8KKyAgaW50IHN0YWNrX2FyZ3MgPSAoYXJnYyA+IDgpID8g
KGFyZ2MgLSA4KSA6IDA7CisKKyNlbHNlCisjZXJyb3IgdW5pbXBsZW1lbnRl
ZCBmb3IgdGhpcyB0YXJnZXQKKyNlbmRpZgorCiAgIC8qIEluaXRpYWxpemUg
c3AgdG8gdGhlIHRvcCBvZiB0aGUgc3RhY2suICovCiAgIHNwID0gKHVpbnRw
dHJfdCAqKSAoKHVpbnRwdHJfdCkgdWNwLT51Y19zdGFjay5zc19zcCArIHVj
cC0+dWNfc3RhY2suc3Nfc2l6ZSk7Ci0gIC8qIFN1YnRyYWN0IHNsb3RzIHJl
cXVpcmVkIGZvciBhcmd1bWVudHMgYW5kIHRoZSBwb2ludGVyIHRvIHVjX2xp
bmsuICovCi0gIHNwIC09IChhcmdjICsgMSk7Ci0gIC8qIEFsaWduLiAqLwot
ICBzcCA9ICh1aW50cHRyX3QgKikgKCh1aW50cHRyX3QpIHNwICYgfjB4Zik7
Ci0gIC8qIFN1YnRyYWN0IG9uZSBzbG90IGZvciBzZXR0aW5nIHRoZSByZXR1
cm4gYWRkcmVzcy4gKi8KKworI2lmIGRlZmluZWQoX194ODZfNjRfXykKKyAg
LyogeDg2XzY0OiBTdWJ0cmFjdCBzbG90cyBmb3IgYWxsIGFyZ3VtZW50cyAr
IHVjX2xpbmsgcG9pbnRlcgorICAgICBhbmQgcmV0dXJuIGFkZHJlc3MuICAq
LworICBzcCAtPSAoc3RhY2tfYXJncyArIDEpOyAgLyogYXJnYyArIDEgZm9y
IHVjX2xpbmsgKi8KKyAgLyogQWxpZ24gdG8gMTYgYnl0ZXMuICovCisgIHNw
ID0gKHVpbnRwdHJfdCAqKSAoKHVpbnRwdHJfdCkgc3AgJiB+MHhmVUwpOwor
ICAvKiBTdWJ0cmFjdCBvbmUgbW9yZSBzbG90IGZvciB0aGUgcmV0dXJuIGFk
ZHJlc3MuICovCiAgIC0tc3A7Ci0gIC8qIFNldCByZXR1cm4gYWRkcmVzcyB0
byB0aGUgdHJhbXBvbGluIGZ1bmN0aW9uIF9fY29udF9saW5rX2NvbnRleHQu
ICovCisgIC8qIFNldCByZXR1cm4gYWRkcmVzcyB0byB0aGUgdHJhbXBvbGlu
ZSBmdW5jdGlvbiBfX2NvbnRfbGlua19jb250ZXh0LiAqLwogICBzcFswXSA9
ICh1aW50cHRyX3QpIF9fY29udF9saW5rX2NvbnRleHQ7Ci0gIC8qIEZldGNo
IGFyZ3VtZW50cyBhbmQgc3RvcmUgdGhlbSBvbiB0aGUgc3RhY2suCiAKLSAg
ICAgeDg2XzY0OgorI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyAgLyog
QVJNNjQ6IFN1YnRyYWN0IHNsb3RzIGZvciBzdGFjayBhcmd1bWVudHMgKyB1
Y19saW5rIHBvaW50ZXIuICovCisgIHNwIC09IChzdGFja19hcmdzICsgMSk7
ICAvKiBzdGFja19hcmdzICsgMSBmb3IgdWNfbGluayAqLworICAvKiBBUk02
NCByZXF1aXJlcyAxNi1ieXRlIGFsaWdubWVudCBhdCBwdWJsaWMgaW50ZXJm
YWNlcy4gKi8KKyAgc3AgPSAodWludHB0cl90ICopICgodWludHB0cl90KSBz
cCAmIH4weGZVTCk7CiAKLSAgICAgLSBTdG9yZSBmaXJzdCBmb3VyIGFyZ3Mg
aW4gdGhlIEFNRDY0IEFCSSBhcmcgcmVnaXN0ZXJzLgorI2VuZGlmCiAKKyAg
LyogRmV0Y2ggYXJndW1lbnRzIGFuZCBzdG9yZSB0aGVtLgorICAgICB4ODZf
NjQ6CisgICAgIC0gU3RvcmUgZmlyc3QgZm91ciBhcmdzIGluIHRoZSBBTUQ2
NCBBQkkgYXJnIHJlZ2lzdGVycyAocmN4LCByZHgsIHI4LCByOSkuCiAgICAg
IC0gTm90ZSB0aGF0IHRoZSBzdGFjayBpcyBub3Qgc2hvcnQgYnkgdGhlc2Ug
Zm91ciByZWdpc3RlciBhcmdzLiAgVGhlCiAgICAgICAgcmVhc29uIGlzIHRo
ZSBzaGFkb3cgc3BhY2UgZm9yIHRoZXNlIHJlZ3MgcmVxdWlyZWQgYnkgdGhl
IEFNRDY0IEFCSS4KLQogICAgICAtIFRoZSBkZWZpbml0aW9uIG9mIG1ha2Vj
b250ZXh0IG9ubHkgYWxsb3dzIGZvciAiaW50IiBzaXplZCBhcmd1bWVudHMg
dG8KICAgICAgICBmdW5jLCAzMiBiaXQsIGxpa2VseSBmb3IgaGlzdG9yaWNh
bCByZWFzb25zLiAgSG93ZXZlciwgdGhlIGFyZ3VtZW50CiAgICAgICAgc2xv
dHMgb24geDg2XzY0IGFyZSA2NCBiaXQgYW55d2F5LCBzbyB3ZSBjYW4gZmV0
Y2ggYW5kIHN0b3JlIHRoZSBhcmdzCiAgICAgICAgYXMgNjQgYml0IHZhbHVl
cywgYW5kIGZ1bmMgY2FuIHJlcXVlc3QgNjQgYml0IGFyZ3Mgd2l0aG91dCB2
aW9sYXRpbmcKICAgICAgICB0aGUgZGVmaW5pdGlvbi4gIFRoaXMgcG90ZW50
aWFsbHkgYWxsb3dzIHBvcnRpbmcgMzIgYml0IGFwcGxpY2F0aW9ucwotICAg
ICAgIHByb3ZpZGluZyBwb2ludGVyIHZhbHVlcyB0byBmdW5jIHdpdGhvdXQg
YWRkaXRpb25hbCBwb3J0aW5nIGVmZm9ydC4gKi8KKyAgICAgICBwcm92aWRp
bmcgcG9pbnRlciB2YWx1ZXMgdG8gZnVuYyB3aXRob3V0IGFkZGl0aW9uYWwg
cG9ydGluZyBlZmZvcnQuCisKKyAgICAgQVJNNjQ6CisgICAgIC0gU3RvcmUg
Zmlyc3QgZWlnaHQgYXJncyBpbiBBUk02NCBBQkkgYXJnIHJlZ2lzdGVycyAo
eDAteDcpLgorICAgICAtIEFyZ3VtZW50cyBiZXlvbmQgOCBnbyBvbiB0aGUg
c3RhY2suCisgICAgIC0gU2ltaWxhciB0byB4ODZfNjQsIHdlIHN0b3JlIGFz
IHVpbnRwdHJfdCBmb3IgcG9pbnRlciBjb21wYXRpYmlsaXR5LiAqLworCiAg
IHZhX3N0YXJ0IChhcCwgYXJnYyk7CiAgIGZvciAoaW50IGkgPSAwOyBpIDwg
YXJnYzsgKytpKQotI2lmZGVmIF9feDg2XzY0X18KLSAgICBzd2l0Y2ggKGkp
Ci0gICAgICB7Ci0gICAgICBjYXNlIDA6Ci0JdWNwLT51Y19tY29udGV4dC5y
Y3ggPSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOwotCWJyZWFrOwotICAgICAg
Y2FzZSAxOgotCXVjcC0+dWNfbWNvbnRleHQucmR4ID0gdmFfYXJnIChhcCwg
dWludHB0cl90KTsKLQlicmVhazsKLSAgICAgIGNhc2UgMjoKLQl1Y3AtPnVj
X21jb250ZXh0LnI4ID0gdmFfYXJnIChhcCwgdWludHB0cl90KTsKLQlicmVh
azsKLSAgICAgIGNhc2UgMzoKLQl1Y3AtPnVjX21jb250ZXh0LnI5ID0gdmFf
YXJnIChhcCwgdWludHB0cl90KTsKLQlicmVhazsKLSAgICAgIGRlZmF1bHQ6
Ci0Jc3BbaSArIDFdID0gdmFfYXJnIChhcCwgdWludHB0cl90KTsKLQlicmVh
azsKLSAgICAgIH0KLSNlbHNlCi0jZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3Ig
dGhpcyB0YXJnZXQKKyAgICB7CisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQor
ICAgICAgc3dpdGNoIChpKQorICAgICAgICB7CisgICAgICAgIGNhc2UgMDoK
KyAgICAgICAgICB1Y3AtPnVjX21jb250ZXh0LnJjeCA9IHZhX2FyZyAoYXAs
IHVpbnRwdHJfdCk7CisgICAgICAgICAgYnJlYWs7CisgICAgICAgIGNhc2Ug
MToKKyAgICAgICAgICB1Y3AtPnVjX21jb250ZXh0LnJkeCA9IHZhX2FyZyAo
YXAsIHVpbnRwdHJfdCk7CisgICAgICAgICAgYnJlYWs7CisgICAgICAgIGNh
c2UgMjoKKyAgICAgICAgICB1Y3AtPnVjX21jb250ZXh0LnI4ID0gdmFfYXJn
IChhcCwgdWludHB0cl90KTsKKyAgICAgICAgICBicmVhazsKKyAgICAgICAg
Y2FzZSAzOgorICAgICAgICAgIHVjcC0+dWNfbWNvbnRleHQucjkgPSB2YV9h
cmcgKGFwLCB1aW50cHRyX3QpOworICAgICAgICAgIGJyZWFrOworICAgICAg
ICBkZWZhdWx0OgorICAgICAgICAgIC8qIFN0YWNrIGFyZ3VtZW50cyBzdGFy
dCBhdCBzcFtpICsgMV0gYmVjYXVzZSBzcFswXSBpcyByZXR1cm4gYWRkcmVz
cyAqLworICAgICAgICAgIHNwW2kgKyAxXSA9IHZhX2FyZyAoYXAsIHVpbnRw
dHJfdCk7CisgICAgICAgICAgYnJlYWs7CisgICAgICAgIH0KKworI2VsaWYg
ZGVmaW5lZChfX2FhcmNoNjRfXykKKyAgICAgIHN3aXRjaCAoaSkKKyAgICAg
ICAgeworICAgICAgICBjYXNlIDA6CisgICAgICAgICAgdWNwLT51Y19tY29u
dGV4dC54MCA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7CisgICAgICAgICAg
YnJlYWs7CisgICAgICAgIGNhc2UgMToKKyAgICAgICAgICB1Y3AtPnVjX21j
b250ZXh0LngxID0gdmFfYXJnIChhcCwgdWludHB0cl90KTsKKyAgICAgICAg
ICBicmVhazsKKyAgICAgICAgY2FzZSAyOgorICAgICAgICAgIHVjcC0+dWNf
bWNvbnRleHQueDIgPSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOworICAgICAg
ICAgIGJyZWFrOworICAgICAgICBjYXNlIDM6CisgICAgICAgICAgdWNwLT51
Y19tY29udGV4dC54MyA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7CisgICAg
ICAgICAgYnJlYWs7CisgICAgICAgIGNhc2UgNDoKKyAgICAgICAgICB1Y3At
PnVjX21jb250ZXh0Lng0ID0gdmFfYXJnIChhcCwgdWludHB0cl90KTsKKyAg
ICAgICAgICBicmVhazsKKyAgICAgICAgY2FzZSA1OgorICAgICAgICAgIHVj
cC0+dWNfbWNvbnRleHQueDUgPSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOwor
ICAgICAgICAgIGJyZWFrOworICAgICAgICBjYXNlIDY6CisgICAgICAgICAg
dWNwLT51Y19tY29udGV4dC54NiA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7
CisgICAgICAgICAgYnJlYWs7CisgICAgICAgIGNhc2UgNzoKKyAgICAgICAg
ICB1Y3AtPnVjX21jb250ZXh0Lng3ID0gdmFfYXJnIChhcCwgdWludHB0cl90
KTsKKyAgICAgICAgICBicmVhazsKKyAgICAgICAgZGVmYXVsdDoKKyAgICAg
ICAgICAvKiBTdGFjayBhcmd1bWVudHMgYmV5b25kIHRoZSBmaXJzdCA4IHJl
Z2lzdGVycy4gKi8KKyAgICAgICAgICBzcFtpIC0gOF0gPSB2YV9hcmcgKGFw
LCB1aW50cHRyX3QpOworICAgICAgICAgIGJyZWFrOworICAgICAgICB9CiAj
ZW5kaWYKKyAgICB9CiAgIHZhX2VuZCAoYXApOwotICAvKiBTdG9yZSBwb2lu
dGVyIHRvIHVjX2xpbmsgYXQgdGhlIHRvcCBvZiB0aGUgc3RhY2suICovCisK
KyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCisgIC8qIFN0b3JlIHBvaW50ZXIg
dG8gdWNfbGluayBhdCBzcFthcmdjICsgMV0sIGFmdGVyIHJldHVybiBhZGRy
ZXNzCisgICAgIGFuZCBhcmdzLiAgKi8KICAgc3BbYXJnYyArIDFdID0gKHVp
bnRwdHJfdCkgdWNwLT51Y19saW5rOworCisjZWxpZiBkZWZpbmVkKF9fYWFy
Y2g2NF9fKQorICAvKiBTdG9yZSBwb2ludGVyIHRvIHVjX2xpbmsgYXQgdGhl
IHRvcCBvZiBvdXIgYWxsb2NhdGVkIGFyZWEuICovCisgIHNwW3N0YWNrX2Fy
Z3NdID0gKHVpbnRwdHJfdCkgdWNwLT51Y19saW5rOworCisjZW5kaWYKKwog
ICAvKiBMYXN0IGJ1dCBub3QgbGVhc3Qgc2V0IHRoZSByZWdpc3RlciBpbiB0
aGUgY29udGV4dCBhdCB1Y3Agc28gdGhhdCBhCiAgICAgIHN1YnNlcXVlbnQg
c2V0Y29udGV4dCBvciBzd2FwY29udGV4dCBwaWNrcyB1cCB0aGUgcmlnaHQg
dmFsdWVzOgogICAgICAtIFNldCBpbnN0cnVjdGlvbiBwb2ludGVyIHRvIHRo
ZSB0YXJnZXQgZnVuY3Rpb24uCiAgICAgIC0gU2V0IHN0YWNrIHBvaW50ZXIg
dG8gdGhlIGp1c3QgY29tcHV0ZWQgc3RhY2sgcG9pbnRlciB2YWx1ZS4KICAg
ICAgLSBTZXQgQ3lnd2luLXNwZWNpZmljIHVjbGluayByZWdpc3RlciB0byB0
aGUgYWRkcmVzcyBvZiB0aGUgcG9pbnRlcgotICAgICAgIHRvIHVjX2xpbmsu
ICovCisgICAgICAgdG8gdWNfbGluay4KKworICAgICB4ODZfNjQ6IHVjbGlu
ayByZWdpc3RlciBpcyByYnggKGNhbGxlZS1zYXZlZCkKKyAgICAgQVJNNjQ6
ICB1Y2xpbmsgcmVnaXN0ZXIgaXMgeDE5IChjYWxsZWUtc2F2ZWQpICovCisK
ICAgdWNwLT51Y19tY29udGV4dC5fTUNfaW5zdFB0ciA9ICh1aW50NjRfdCkg
ZnVuYzsKICAgdWNwLT51Y19tY29udGV4dC5fTUNfc3RhY2tQdHIgPSAodWlu
dDY0X3QpIHNwOworCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogICB1Y3At
PnVjX21jb250ZXh0Ll9NQ191Y2xpbmtSZWcgPSAodWludDY0X3QpIChzcCAr
IGFyZ2MgKyAxKTsKKworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyAg
LyogU2V0IExSIHRvIF9fY29udF9saW5rX2NvbnRleHQgZm9yIEFSTTY0ICh1
c2VkIGFzIHJldHVybiBhZGRyZXNzKS4gKi8KKyAgdWNwLT51Y19tY29udGV4
dC5sciA9ICh1aW50NjRfdCkgX19jb250X2xpbmtfY29udGV4dDsKKyAgdWNw
LT51Y19tY29udGV4dC5fTUNfdWNsaW5rUmVnID0gKHVpbnQ2NF90KSAoc3Ag
KyBzdGFja19hcmdzKTsKKworI2VuZGlmCiB9Ci0tIAoyLjQ5LjAud2luZG93
cy4xCgo=

--_004_PN0P287MB029504FE0939EFA34AEC78E592FD2PN0P287MB0295INDP_--

Return-Path: <SRS0=LDhx=D5=multicorewareinc.com=aswin.kalies@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 680B44BA2E0E
	for <cygwin-patches@cygwin.com>; Mon,  1 Jun 2026 11:36:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 680B44BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 680B44BA2E0E
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1780313792; cv=pass;
	b=JkiW63iEmf0A7SE9KQXZqbn8EKPEvds97KWkvS3JSbeh2tAwh3SeZmmW+gi6ebCXRn07egN/CNbYdj5sp9cR6CXdalMi6EYS+QwoAmroOuvvX91VQi6Qbf2X6NLBnri+i3vSQvBg4eiFQznAo+pJqB/jzhloA7MYtlnkhEYqIM8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780313792; c=relaxed/simple;
	bh=iGW0mFkqXX1fKBhoy7X8L//paRZ4rjozSR3XXgxR6kA=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=cOM2VmiBXg5j59riFFlpWxBwuG/sZpPhvvaZKWdgzLR4+HJie2hfOSoEBctk6G79D2DWx7g/CZk2U3D4trC0c5mPKFPv95c5kEVHpAOlHgbKtneBTXbUE3rWl9nQdvj2lzu0v1KQJzE/VS87rw3mTMZMJMMeHyXE9b+mNn79IF8=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=jENIdSh/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 680B44BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=jENIdSh/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAnce06gFBnSGqqIcRklnpBpdX7leXrx1fT79034hCWVw46plxnd3MoEuSN5GsU8olQu8h7MXFBBFryjCzUkf908eoSc9AvW+5Zh0BudvY3rZOyiMHGH8zcMphiIfjXCKaVRShjZazq/8kYpOIsfboQTPYrR3hPNzsOtZt5rRjAEczVtefb2H5/fCtogFvkpYJOaoMJ6fIgktcGrE+rU5teyj2EYqjL+Bl364hnJCXkguon78RRo/G5PGjR3+9PW96u4MAg0a16wEFj39621+eOAcsAdlWYqShXz4nfrOBT3AWaFFZmQqjCJPgP2QGJJFI2iruYH6LRd7hder1Jv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJqjkn8is584vHcOwWr8YJa0azAljavqWwCBDrA/33c=;
 b=quf1FywnAlIoJL9ADYcnXFzB0S/5cIAO38IeL2tWtz6GIGAd3m4gwOmMKcVBPtxOhUGWpM9AmxvolMdbuwiA9Xg/Nzw1usVD/ZQuiNuCOA4S/SeZTpSxM0aT3FjTNSLOVip7t1tzt6GCdseAOkG8pq3x8sfYVQLGvUQqt30eR2aK4j4mwQSYkyYH/zj/sDs6VM+FKI5TsfLB514EEA+W8QjcVoT+Z8vKAKUAVHOLQbJyB7pUoBAFo/u426cByB3INceI8kfH/C94dJdkI1ecIhi/2EMuzVpPwdUzVRwBT3UwF85YL3DAJWwcvpRkTWKuPUlBxYEBeXItJ3jFQzEMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJqjkn8is584vHcOwWr8YJa0azAljavqWwCBDrA/33c=;
 b=jENIdSh/AQm1eBStrBFpqUzsq9lED4C/R1h4UmTA05zqnsLGdq3GRrbrxI7voDJaj/v/cLVJgy8ZTTUwX9VsVTnURDlLDxO+I5omFCIKPk24+8I2iRF8ayya65pzq/x8XPFVnQTzcXvuOT/c9ehzlNQ4HRC5F8D7qPb2Kd4jGxPmjbPZvTZON23q0oQAU3CO+0a5y5OLyG4gD7423idRdsGWkqL+PVKzc3EYaQVKeSkt3YuC0u270VbIlyoJaWtBEnJJbpoDmPrHmt9aq+44lSlO2g94XfkrF6P4q/+Q/aM9R9TGbzFbM9J3XNNuWcy2x8FnIbqQV0wIcuGzZnIYrw==
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:193::14)
 by MA5P287MB4746.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:197::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:36:25 +0000
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b]) by PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 11:36:25 +0000
From: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: Add AArch64 support for signal handling and ucontext
 routines
Thread-Topic: [PATCH] Cygwin: Add AArch64 support for signal handling and
 ucontext routines
Thread-Index: AQHc8bme85Y1r4cX60+LHFYAVo/91w==
Date: Mon, 1 Jun 2026 11:36:25 +0000
Message-ID:
 <PN3P287MB1320988B69BF5F0D12079191F7152@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1320:EE_|MA5P287MB4746:EE_
x-ms-office365-filtering-correlation-id: ad514337-ee2f-49c9-1cf0-08debfd20347
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|31052699007|39142699007|1800799024|6049299003|376014|366016|55112099003|8096899003|38070700021|4053099003|18002099003|56012099006|5023799004|3023799007;
x-microsoft-antispam-message-info:
 ZH5eINpD1aAtvXyPDkW8Qyzh46/KKO0Gd6Sh8HhrDMy1wwzeeH6PDX+A5oOi1nCvPR0KGYO0f7q+Phy2llFYELNRIKpy8DnFz6NuQMPFfRqJaQuI40kwms66c/LGSCM4xUDdAjfrH4sif9QHGj2FTlMLcQLMMZaH9GjRgT+Tmx6ZLfLVb/Nj7ag/5ow+pybxrbhLHzBO9WWDWInXLRzX7CZydT0SYzgi61awLoNlg4yj+EnjRiwrAmLVPzOqqrYl9wrMX0tS2SFIFfMrNHYS6/A97maDf3ee/5qiiC5B6N9ymOY3YLuKck6PX8KnUenULkD1DVfDL8ZhWg18mxaHdL56hPZNEicBQXJmU0Qo84J1Q7hiyTSAJnEiNGUIOJh2MKENHeg91ezTYy9/P+IXVjQTXfbFPAUQcxlqm4jMxq5ntDGAwp4XVC+bKSmbvr0YxbcVrBuYEvp+ZKcW+QQHmZQhomLFVjp7k6/mqAGSneGskSn7siezyVXRHz+GztuT9PSC9e3BLO9RI59psZ8JKnQwTlnTr+4Uv0S2zVfGnTsQzZWcRgRGJ6aYV9gAMRlYd+UepNjJUyI0/IY81nv5rqPIZ2MiXoorUWVXtR+c1cnxbBvxmut+V0FyYfhlyM8SW1gtZ6q+17TDOkVrCAHVdtvKy7yyAFSHksLW1nusi2Zo3jC1r6bfeF600F8wIR7Hcb9O/+PN5EsVd8UU7oMdOWn+haMyivEIqRords63o3WgyHu3E9LRntXp4e66YUOX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1320.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(31052699007)(39142699007)(1800799024)(6049299003)(376014)(366016)(55112099003)(8096899003)(38070700021)(4053099003)(18002099003)(56012099006)(5023799004)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7G2EyShizbWrAtPYXBaCO4Y9r4/hbffXb2MO06IS/eyQYFBB6iOasuVeJ8?=
 =?iso-8859-1?Q?hQCG0RAz+v9k/Os/H7BxMZhyqfD2NQPZevlC4W68dsKKNbmbkAd2O0Ql6o?=
 =?iso-8859-1?Q?x6rfVXA70cxqJcQMEoDSu5PbOGnCWuAhAaTDHZJeVu+iSFCebx6JncbLYz?=
 =?iso-8859-1?Q?VUYiRQ8HJ7JG7AymeRMlS1RNmEG0U2Lmj8uU4XhSZuXOawd5aAtoSNtyww?=
 =?iso-8859-1?Q?DDKbt7Zr6W3/sV1QFfjPwyYcE09Bh4AczSOp4VFJo0qCJJSpxYZCzM+tZ2?=
 =?iso-8859-1?Q?4eKwljTne4CZa55zC/B0x3DyWtff3FBZQmgWlhLPu4u06Th16QfxYMSET6?=
 =?iso-8859-1?Q?d+PUW16hlPw8rCM3TemAgwfYbQ7GJi7ZrV2SLkbV4Rl6TrTfdlOHYX/+dk?=
 =?iso-8859-1?Q?Mv2g++tFGJUk0EbweLUua9ySJq+vxJC5Z3azC0BuTy0KxUQOevI4EyX5ce?=
 =?iso-8859-1?Q?Tdmsgqe9LmTVQP/vdB9yMtmXRobEvW72cHvtY4wmPFzeqWQqr2XpRbknwG?=
 =?iso-8859-1?Q?CHxtjGJ0iOi4fSeA5QRF+wtHo23V8D6BT9PXgtMlsg1aE/PAAO0Wt95Ep1?=
 =?iso-8859-1?Q?pXGMSPLdqVYKn7gRIWU1vAAzgJ+r6stbhssAy5ZT/cBwvcfB50/KC7jmIC?=
 =?iso-8859-1?Q?PV7qQAQVOAs4lwQq6cHlu9f096JSGoDaw0g4ifQgt2C3lgcYFRv3A50r3G?=
 =?iso-8859-1?Q?dPaR0XRY4U9w/ZSiJ/E0kgSqUB95LfOLF/EygWapCD3BbCiV18YFVOKYt8?=
 =?iso-8859-1?Q?iT4H9/hMDSVt8ryUzXiVkyFmUGskd01OIGu8UeSvxDvPEn26fL/0mCE/Y1?=
 =?iso-8859-1?Q?YSoRWOdhRNjjABm3PQ3FXPjzaKiqK1RV/FjAaQjfmWOH3kJrz4rM5mL+5c?=
 =?iso-8859-1?Q?6fhrsPBZHcKP4N4W/Kkg5Yt9zPTd9bk60bL/7sX3AkxTu06GHRy5R2ZM1W?=
 =?iso-8859-1?Q?6JRU6xrJMgceLRk1nku0FsumJrrkre7zb9JkSusSXT+4YaKXlJnQnRELaX?=
 =?iso-8859-1?Q?Jk2Rwmc/a1x/E+rUwyF0qyij7yib2vsiLloNFXAhp6nU2NxFD/i5Egid5x?=
 =?iso-8859-1?Q?r38mBPMBwWYiVvvfwc0TuSvA88SrcL85zu13L9eCaQC2zKsRyotNzgfHOZ?=
 =?iso-8859-1?Q?IzFgJ8G6IXdjzoqNXpiuKpdZZ2tS2Ys7EOykPKDDsoVEWelWOoyKQQAwp8?=
 =?iso-8859-1?Q?uqpOqPus80z+/Br9t8FPDWSp482X+Ir+IGNo7QUuTqIRCZfF9pBkFgAQ4c?=
 =?iso-8859-1?Q?06AqVJ3hdmM7b9OMfRlkTX40d84GumtMsyymKN2aFOGrcx/pqljHeCTnp+?=
 =?iso-8859-1?Q?Ji7QU1Y+LhJlRpEwG6bTLd3wyzWDfz6moL5Qo9wFg6D0Gcl2phN37Qc6IS?=
 =?iso-8859-1?Q?a+EqxyWxREtLOlQc4lIa/wv8dPCt9c7b7+3xjv279z5L1S8Tfp6hWERvx2?=
 =?iso-8859-1?Q?fZ38aThiuR5YIDHZtsvYBNuMEfshjxIFCuP+9gPLbVi0UIq3l6t6twKZDG?=
 =?iso-8859-1?Q?rW3kxLEa/0kApcw0EQfockFO+aOcqdint2vssKnL9718sCx/HRWlv/I4jJ?=
 =?iso-8859-1?Q?ioyXTQyKjDlJolK/FWt5BgLT+f2eht025YZ9Dh8eKecAZax9sgD682gn/r?=
 =?iso-8859-1?Q?HfSVHZ2M4oEIvhwguvgSpp8vunYr4tSEM85rxCEt1vIVM3IRmq9HAqctoB?=
 =?iso-8859-1?Q?owijjkhfxm3HcQhEgUbAgQr8CWXr4/vdyCuUN9sHB+GaAKRWy+H3KqcKT4?=
 =?iso-8859-1?Q?DaqFGu8Uctbh1RJUV4t4XijnsoYtsPy/d6n5P1iBo9I7QfVeWPO1n4k/Pq?=
 =?iso-8859-1?Q?e62ZcrDT+kGs/CyOJnnmY1YByI6WQgE=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB1320988B69BF5F0D12079191F7152PN3P287MB1320INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ad514337-ee2f-49c9-1cf0-08debfd20347
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 11:36:25.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ci4Z9gRvy9iRpE9SbsqpZFDjxddO4Aj1M/vTSbryUj/C1zHVMOcI1qxvWt0OVjKjNZzV4LNEltYZXOE49izaAPeB4o/w1gEy2EEdKKvLVVgCpi5tccviQN1S+kPE8pw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB4746
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SCC_10_SHORT_WORD_LINES,SCC_5_SHORT_WORD_LINES,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB1320988B69BF5F0D12079191F7152PN3P287MB1320INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB1320988B69BF5F0D12079191F7152PN3P287MB1320INDP_"

--_000_PN3P287MB1320988B69BF5F0D12079191F7152PN3P287MB1320INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Corinna,

This patch adds AArch64 support for signal handling and ucontext routines (=
call_signal_handler, setcontext, __cont_link_context, makecontext) in excep=
tions.cc, enabling Cygwin on ARM64 Windows.

Kindly review the patch.


Thanks and Regards,
Aswin Kalies

Inline patch

---
 winsup/cygwin/exceptions.cc | 309 +++++++++++++++++++++++++++++++-----
 1 file changed, 267 insertions(+), 42 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 1e129b319..a2212cabd 100644
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
@@ -1930,6 +1930,56 @@ _cygtls::call_signal_handler ()
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
@@ -2009,10 +2059,78 @@ setcontext (const ucontext_t *ucp)
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
@@ -2049,7 +2167,7 @@ swapcontext (ucontext_t *oucp, const ucontext_t *ucp)
 /* Trampoline function to set the context to uc_link.  The pointer to the
    address of uc_link is stored in a callee-saved register, referenced by
    _MC_uclinkReg from the C code.  If uc_link is NULL, call exit. */
-#ifdef __x86_64__
+#if defined(__x86_64__)
 /* _MC_uclinkReg =3D=3D %rbx */
 __asm__ ("          \n\
   .global  __cont_link_context  \n\
@@ -2070,7 +2188,21 @@ __cont_link_context:        \n\
   nop            \n\
   .seh_endproc         \n\
   ");
-
+#elif defined(__aarch64__)
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
@@ -2078,11 +2210,19 @@ __cont_link_context:       \n\
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
@@ -2090,65 +2230,150 @@ makecontext (ucontext_t *ucp, void (*func) (void),=
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
2.50.1.windows.1






--_000_PN3P287MB1320988B69BF5F0D12079191F7152PN3P287MB1320INDP_--

--_004_PN3P287MB1320988B69BF5F0D12079191F7152PN3P287MB1320INDP_
Content-Type: application/octet-stream;
	name="Cygwin-Add-AArch64-support-for-signal-handling-and-u.patch"
Content-Description:
 Cygwin-Add-AArch64-support-for-signal-handling-and-u.patch
Content-Disposition: attachment;
	filename="Cygwin-Add-AArch64-support-for-signal-handling-and-u.patch";
	size=15213; creation-date="Mon, 01 Jun 2026 11:35:13 GMT";
	modification-date="Mon, 01 Jun 2026 11:35:50 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNzc4NzRjNzc1ZDI1NzA3NmNhMjA0YmNhOGViZWNiYjY0ZDdjZmRm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBc3dpbiBLYWxpZXMg
PGFzd2luLmthbGllc0BtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogTW9u
LCAxIEp1biAyMDI2IDE2OjMwOjM2ICswNTMwClN1YmplY3Q6IFtQQVRDSF0g
Q3lnd2luOiBBZGQgQUFyY2g2NCBzdXBwb3J0IGZvciBzaWduYWwgaGFuZGxp
bmcgYW5kIHVjb250ZXh0CiByb3V0aW5lcwpNSU1FLVZlcnNpb246IDEuMApD
b250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVu
dC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKQWRkIEFBcmNoNjQgc3VwcG9y
dCBmb3Igc2lnbmFsIGhhbmRsaW5nIGFuZCB1Y29udGV4dCByb3V0aW5lcwoo
Y2FsbF9zaWduYWxfaGFuZGxlciwgc2V0Y29udGV4dCwgX19jb250X2xpbmtf
Y29udGV4dCwgbWFrZWNvbnRleHQpCmluIGV4Y2VwdGlvbnMuY2MsIGVuYWJs
aW5nIEN5Z3dpbiBvbiBBUk02NCBXaW5kb3dzLiBzZXRjb250ZXh0IHVzZXMK
bWFudWFsIGFzbSBpbnN0ZWFkIG9mIFJ0bFJlc3RvcmVDb250ZXh0LCB3aGlj
aCBmYWlscyB3aXRoIHN5bnRoZXRpYwpDT05URVhUIHN0cnVjdHMgZnJvbSBt
YWtlY29udGV4dC4gI2lmZGVmIGd1YXJkcyBhcmUgYWxzbyB1cGRhdGVkIHRv
CiAjaWYgZGVmaW5lZCgpIGZvciBjb25zaXN0ZW5jeS4KClNpZ25lZC1vZmYt
Ynk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29t
PgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1
bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KU2lnbmVk
LW9mZi1ieTogQXN3aW4gS2FsaWVzIDxhc3dpbi5rYWxpZXNAbXVsdGljb3Jl
d2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNj
IHwgMzA5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDI2NyBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMu
Y2MgYi93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MKaW5kZXggMWUxMjli
MzE5Li5hMjIxMmNhYmQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZXhj
ZXB0aW9ucy5jYworKysgYi93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MK
QEAgLTE4OTIsNyArMTg5Miw3IEBAIF9jeWd0bHM6OmNhbGxfc2lnbmFsX2hh
bmRsZXIgKCkKIAogCSAgLyogSW4gYXNzZW1ibGVyOiBTYXZlIHJlZ3Mgb24g
bmV3IHN0YWNrLCBtb3ZlIHRvIGFsdGVybmF0ZSBzdGFjaywKIAkgICAgIGNh
bGwgdGhpc2Z1bmMsIHJldmVydCBzdGFjayByZWdzLiAqLwotI2lmZGVmIF9f
eDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJICAvKiBDbG9i
YmVyZWQgcmVnczogcmN4LCByZHgsIHI4LCByOSwgcjEwLCByMTEsIHJicCwg
cnNwICovCiAJICBfX2FzbV9fICgiXG5cCiAJCSAgIG1vdnEgICVbTkVXX1NQ
XSwgJSVyYXggICMgTG9hZCBhbHQgc3RhY2sgaW50byByYXgJXG5cCkBAIC0x
OTMwLDYgKzE5MzAsNTYgQEAgX2N5Z3Rsczo6Y2FsbF9zaWduYWxfaGFuZGxl
ciAoKQogCQkgICAgICAgW0ZVTkNdCSJvIiAodGhpc2Z1bmMpLAogCQkgICAg
ICAgW1dSQVBQRVJdICJvIiAoYWx0c3RhY2tfd3JhcHBlcikKIAkJICAgOiAi
bWVtb3J5Iik7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorCSAgX19h
c21fXyAoIlxuXAorCQkgICBtb3YJeDksICVbTkVXX1NQXQkJLy8gTG9hZCBh
bHQgc3RhY2sgaW50byB4OQlcblwKKwkJICAgc3ViCXg5LCB4OSwgIzB4NjAJ
CS8vIE1ha2Ugcm9vbSBvbiBhbHQgc3RhY2sJXG5cCisJCQkJCQkvLyBmb3Ig
Y2xvYmJlcmVkIHJlZ3MJCVxuXAorCQkgICBzdHIJeDAsIFt4OSwgIzB4MDBd
CQkvLyBTYXZlIGNsb2JiZXJlZCByZWdzCQlcblwKKwkJICAgc3RyCXgxLCBb
eDksICMweDA4XQkJCQkJCVxuXAorCQkgICBzdHIJeDIsIFt4OSwgIzB4MTBd
CQkJCQkJXG5cCisJCSAgIHN0cgl4MywgW3g5LCAjMHgxOF0JCQkJCQlcblwK
KwkJICAgc3RyCXg0LCBbeDksICMweDIwXQkJCQkJCVxuXAorCQkgICBzdHIJ
eDUsIFt4OSwgIzB4MjhdCQkJCQkJXG5cCisJCSAgIHN0cgl4NiwgW3g5LCAj
MHgzMF0JCQkJCQlcblwKKwkJICAgc3RyCXg3LCBbeDksICMweDM4XQkJCQkJ
CVxuXAorCQkgICBzdHIJZnAsIFt4OSwgIzB4NDBdCQkJCQkJXG5cCisJCSAg
IG1vdgl4MTAsIHNwCQkJLy8gQ29weSBzcCBpbnRvIHgxMCBmb3Igc2F2aW5n
CVxuXAorCQkgICBzdHIJeDEwLCBbeDksICMweDQ4XQkJCQkJXG5cCisJCSAg
IHN0cgl4MzAsIFt4OSwgIzB4NTBdCS8vIFNhdmUgbGluayByZWdpc3RlcgkJ
XG5cCisJCSAgIG1vdgl4MCwgJVtTSUddCQkvLyB0aGlzc2lnIHRvIDFzdCBh
cmcgcmVnCVxuXAorCQkgICBtb3YJeDEsICVbU0ldCQkvLyAmdGhpc3NpIHRv
IDJuZCBhcmcgcmVnCVxuXAorCQkgICBtb3YJeDIsICVbQ1RYXQkJLy8gdGhp
c2NvbnRleHQgdG8gM3JkIGFyZyByZWcJXG5cCisJCSAgIG1vdgl4MywgJVtG
VU5DXQkJLy8gdGhpc2Z1bmMgdG8geDMJCVxuXAorCQkgICBtb3YJeDQsICVb
V1JBUFBFUl0JCS8vIHdyYXBwZXIgYWRkcmVzcyB0byB4NAlcblwKKwkJICAg
bW92CXNwLCB4OQkJCS8vIE1vdmUgYWx0IHN0YWNrIGludG8gc3AJXG5cCisJ
CSAgIGJscgl4NAkJCS8vIENhbGwgd3JhcHBlcgkJCVxuXAorCQkgICBtb3YJ
eDksIHNwCQkJLy8gUmVzdG9yZSBjbG9iYmVyZWQgcmVncwlcblwKKwkJICAg
bGRyCXgzMCwgW3g5LCAjMHg1MF0JLy8gUmVzdG9yZSBsaW5rIHJlZ2lzdGVy
CVxuXAorCQkgICBsZHIJeDEwLCBbeDksICMweDQ4XQkJCQkJXG5cCisJCSAg
IGxkcglmcCwgIFt4OSwgIzB4NDBdCQkJCQlcblwKKwkJICAgbGRyCXg3LCAg
W3g5LCAjMHgzOF0JCQkJCVxuXAorCQkgICBsZHIJeDYsICBbeDksICMweDMw
XQkJCQkJXG5cCisJCSAgIGxkcgl4NSwgIFt4OSwgIzB4MjhdCQkJCQlcblwK
KwkJICAgbGRyCXg0LCAgW3g5LCAjMHgyMF0JCQkJCVxuXAorCQkgICBsZHIJ
eDMsICBbeDksICMweDE4XQkJCQkJXG5cCisJCSAgIGxkcgl4MiwgIFt4OSwg
IzB4MTBdCQkJCQlcblwKKwkJICAgbGRyCXgxLCAgW3g5LCAjMHgwOF0JCQkJ
CVxuXAorCQkgICBsZHIJeDAsICBbeDksICMweDAwXQkJCQkJXG5cCisJCSAg
IG1vdglzcCwgIHgxMAkJLy8gUmVzdG9yZSBzdGFjayBwb2ludGVyCVxuIgor
CQkgICA6IDogW05FV19TUF0JICJyIiAobmV3X3NwKSwKKwkJICAgICAgIFtT
SUddCSAiciIgKHRoaXNzaWcpLAorCQkgICAgICAgW1NJXQkgInIiICgmdGhp
c3NpKSwKKwkJICAgICAgIFtDVFhdCSAiciIgKHRoaXNjb250ZXh0KSwKKwkJ
ICAgICAgIFtGVU5DXQkgInIiICh0aGlzZnVuYyksCisJCSAgICAgICBbV1JB
UFBFUl0gInIiIChhbHRzdGFja193cmFwcGVyKQorCQkgICA6ICJtZW1vcnki
LCAiY2MiLAorCQkgICAgICJ4MCIsICJ4MSIsICJ4MiIsICJ4MyIsICJ4NCIs
ICJ4NSIsICJ4NiIsICJ4NyIsCisJCSAgICAgIng4IiwgIng5IiwgIngxMCIs
ICJ4MTEiLCAieDEyIiwgIngxMyIsICJ4MTQiLCAieDE1IiwKKwkJICAgICAi
eDE2IiwgIngxNyIsICJ4MjkiLCAieDMwIiwKKwkJICAgICAidjAiLCAidjEi
LCAidjIiLCAidjMiLCAidjQiLCAidjUiLCAidjYiLCAidjciLAorCQkgICAg
ICJ2MTYiLCAidjE3IiwgInYxOCIsICJ2MTkiLCAidjIwIiwgInYyMSIsICJ2
MjIiLCAidjIzIiwKKwkJICAgICAidjI0IiwgInYyNSIsICJ2MjYiLCAidjI3
IiwgInYyOCIsICJ2MjkiLCAidjMwIiwgInYzMSIpOwogI2Vsc2UKICNlcnJv
ciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCkBAIC0y
MDA5LDEwICsyMDU5LDc4IEBAIHNldGNvbnRleHQgKGNvbnN0IHVjb250ZXh0
X3QgKnVjcCkKIHsKICAgUENPTlRFWFQgY3R4ID0gKFBDT05URVhUKSAmdWNw
LT51Y19tY29udGV4dDsKICAgc2V0X3NpZ25hbF9tYXNrIChfbXlfdGxzLnNp
Z21hc2ssIHVjcC0+dWNfc2lnbWFzayk7CisjaWYgZGVmaW5lZChfX2FhcmNo
NjRfXykKKyAgLyogT24gQVJNNjQgV2luZG93cywgUnRsUmVzdG9yZUNvbnRl
eHQgbWF5IGZhaWwgKFNUQVRVU19JTExFR0FMX0lOU1RSVUNUSU9OKQorICAg
ICB3aGVuIHJlc3RvcmluZyBhIHN5bnRoZXRpYyBDT05URVhUIHRoYXQgd2Fz
IGNvbnN0cnVjdGVkIGJ5IG1ha2Vjb250ZXh0CisgICAgIHJhdGhlciB0aGFu
IGNhcHR1cmVkIGJ5IFJ0bENhcHR1cmVDb250ZXh0IC8gR2V0VGhyZWFkQ29u
dGV4dC4gIFRoaXMgaXMKKyAgICAgYmVjYXVzZSBSdGxSZXN0b3JlQ29udGV4
dCBtYXkgcGVyZm9ybSB2YWxpZGF0aW9uIG9yIHVzZSBpbnRlcm5hbAorICAg
ICBtZWNoYW5pc21zIChlLmcuIHN0YWNrIHVud2luZGluZyBoaW50cykgdGhh
dCBkb24ndCB3b3JrIHdpdGggc3ludGhldGljCisgICAgIGNvbnRleHRzIHBv
aW50aW5nIHRvIGFyYml0cmFyeSBQQyBhZGRyZXNzZXMgYW5kIG5vbi10aHJl
YWQgc3RhY2tzLgorCisgICAgIEluc3RlYWQsIHdlIG1hbnVhbGx5IHJlc3Rv
cmUgYWxsIHJlZ2lzdGVycyBhbmQgYnJhbmNoIHRvIHRoZSBzYXZlZCBQQy4K
KyAgICAgVGhpcyBtaXJyb3JzIHdoYXQgZ2xpYmMvbXVzbCBkbyBpbiB0aGVp
ciBzZXRjb250ZXh0IGltcGxlbWVudGF0aW9ucworICAgICBmb3IgYWFyY2g2
NC1saW51eC4gICovCisgIHJlZ2lzdGVyIFBDT05URVhUIGJhc2UgX19hc21f
XyAoIngxNiIpID0gY3R4OworICBfX2FzbV9fIF9fdm9sYXRpbGVfXyAoIlxu
XAorCWFkZAl4MTcsIHgxNiwgIzI3MgkJCQkJXG5cCisJbGRwCXEwLCBxMSwg
W3gxNywgIzBdCQkJCVxuXAorCWxkcAlxMiwgcTMsIFt4MTcsICMzMl0JCQkJ
XG5cCisJbGRwCXE0LCBxNSwgW3gxNywgIzY0XQkJCQlcblwKKwlsZHAJcTYs
IHE3LCBbeDE3LCAjOTZdCQkJCVxuXAorCWxkcAlxOCwgcTksIFt4MTcsICMx
MjhdCQkJCVxuXAorCWxkcAlxMTAsIHExMSwgW3gxNywgIzE2MF0JCQkJXG5c
CisJbGRwCXExMiwgcTEzLCBbeDE3LCAjMTkyXQkJCQlcblwKKwlsZHAJcTE0
LCBxMTUsIFt4MTcsICMyMjRdCQkJCVxuXAorCWxkcAlxMTYsIHExNywgW3gx
NywgIzI1Nl0JCQkJXG5cCisJbGRwCXExOCwgcTE5LCBbeDE3LCAjMjg4XQkJ
CQlcblwKKwlsZHAJcTIwLCBxMjEsIFt4MTcsICMzMjBdCQkJCVxuXAorCWxk
cAlxMjIsIHEyMywgW3gxNywgIzM1Ml0JCQkJXG5cCisJbGRwCXEyNCwgcTI1
LCBbeDE3LCAjMzg0XQkJCQlcblwKKwlsZHAJcTI2LCBxMjcsIFt4MTcsICM0
MTZdCQkJCVxuXAorCWxkcAlxMjgsIHEyOSwgW3gxNywgIzQ0OF0JCQkJXG5c
CisJbGRwCXEzMCwgcTMxLCBbeDE3LCAjNDgwXQkJCQlcblwKKwkvKiBSZXN0
b3JlIEZQQ1IgYW5kIEZQU1IgKi8JCQkJXG5cCisJbGRyCXcxNywgW3gxNiwg
Izc4NF0JCQkJXG5cCisJbXNyCWZwY3IsIHgxNwkJCQkJXG5cCisJbGRyCXcx
NywgW3gxNiwgIzc4OF0JCQkJXG5cCisJbXNyCWZwc3IsIHgxNwkJCQkJXG5c
CisJLyogTG9hZCBQQyBpbnRvIHgxNyAoYnJhbmNoIHRhcmdldCwgb2Zmc2V0
IDI2NCkgKi8JXG5cCisJbGRyCXgxNywgW3gxNiwgIzI2NF0JCQkJXG5cCisJ
LyogUmVzdG9yZSBjYWxsZWUtc2F2ZWQgR1BScyB4MTguLngyOCwgZnAsIGxy
ICovCVxuXAorCWxkcAl4MTgsIHgxOSwgW3gxNiwgIzE1Ml0JCQkJXG5cCisJ
bGRwCXgyMCwgeDIxLCBbeDE2LCAjMTY4XQkJCQlcblwKKwlsZHAJeDIyLCB4
MjMsIFt4MTYsICMxODRdCQkJCVxuXAorCWxkcAl4MjQsIHgyNSwgW3gxNiwg
IzIwMF0JCQkJXG5cCisJbGRwCXgyNiwgeDI3LCBbeDE2LCAjMjE2XQkJCQlc
blwKKwlsZHAJeDI4LCB4MjksIFt4MTYsICMyMzJdCQkJCVxuXAorCWxkcgl4
MzAsIFt4MTYsICMyNDhdCQkJCVxuXAorCS8qIFJlc3RvcmUgY2FsbGVyLXNh
dmVkIEdQUnMgeDIuLngxNSAqLwkJCVxuXAorCWxkcAl4MiwgeDMsIFt4MTYs
ICMyNF0JCQkJXG5cCisJbGRwCXg0LCB4NSwgW3gxNiwgIzQwXQkJCQlcblwK
KwlsZHAJeDYsIHg3LCBbeDE2LCAjNTZdCQkJCVxuXAorCWxkcAl4OCwgeDks
IFt4MTYsICM3Ml0JCQkJXG5cCisJbGRwCXgxMCwgeDExLCBbeDE2LCAjODhd
CQkJCVxuXAorCWxkcAl4MTIsIHgxMywgW3gxNiwgIzEwNF0JCQkJXG5cCisJ
bGRwCXgxNCwgeDE1LCBbeDE2LCAjMTIwXQkJCQlcblwKKwkvKiBSZXN0b3Jl
IHgwLCB4MSAqLwkJCQkJXG5cCisJbGRwCXgwLCB4MSwgW3gxNiwgIzhdCQkJ
CVxuXAorCS8qIFNldCBTUCBmcm9tIGNvbnRleHQgKGxhc3QgdXNlIG9mIHgx
NiBhcyBiYXNlKSAqLwlcblwKKwlsZHIJeDE2LCBbeDE2LCAjMjU2XQkJCQlc
blwKKwltb3YJc3AsIHgxNgkJCQkJCVxuXAorCS8qIEJyYW5jaCB0byBzYXZl
ZCBQQyAqLwkJCQlcblwKKwlicgl4MTcJCQkJCQlcblwKKyIKKwk6IC8qIG5v
IG91dHB1dHMgKG5vcmV0dXJuKSAqLworCTogInIiIChiYXNlKQorCTogIm1l
bW9yeSIKKyAgKTsKKyAgX19idWlsdGluX3VucmVhY2hhYmxlICgpOworI2Vs
c2UKICAgUnRsUmVzdG9yZUNvbnRleHQgKGN0eCwgTlVMTCk7CiAgIC8qIElm
IHdlIGdvdCBoZXJlLCBzb21ldGhpbmcgd2FzIHdyb25nLiAqLwogICBzZXRf
ZXJybm8gKEVJTlZBTCk7CiAgIHJldHVybiAtMTsKKyNlbmRpZgogfQogCiBl
eHRlcm4gIkMiIGludApAQCAtMjA0OSw3ICsyMTY3LDcgQEAgc3dhcGNvbnRl
eHQgKHVjb250ZXh0X3QgKm91Y3AsIGNvbnN0IHVjb250ZXh0X3QgKnVjcCkK
IC8qIFRyYW1wb2xpbmUgZnVuY3Rpb24gdG8gc2V0IHRoZSBjb250ZXh0IHRv
IHVjX2xpbmsuICBUaGUgcG9pbnRlciB0byB0aGUKICAgIGFkZHJlc3Mgb2Yg
dWNfbGluayBpcyBzdG9yZWQgaW4gYSBjYWxsZWUtc2F2ZWQgcmVnaXN0ZXIs
IHJlZmVyZW5jZWQgYnkKICAgIF9NQ191Y2xpbmtSZWcgZnJvbSB0aGUgQyBj
b2RlLiAgSWYgdWNfbGluayBpcyBOVUxMLCBjYWxsIGV4aXQuICovCi0jaWZk
ZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIC8qIF9N
Q191Y2xpbmtSZWcgPT0gJXJieCAqLwogX19hc21fXyAoIgkJCQlcblwKIAku
Z2xvYmFsCV9fY29udF9saW5rX2NvbnRleHQJXG5cCkBAIC0yMDcwLDcgKzIx
ODgsMjEgQEAgX19jb250X2xpbmtfY29udGV4dDoJCQlcblwKIAlub3AJCQkJ
XG5cCiAJLnNlaF9lbmRwcm9jCQkJXG5cCiAJIik7Ci0KKyNlbGlmIGRlZmlu
ZWQoX19hYXJjaDY0X18pCitfX2FzbV9fICgiCQkJCQlcblwKKwkuZ2xvYmFs
CV9fY29udF9saW5rX2NvbnRleHQJCVxuXAorCS5zZWhfcHJvYyBfX2NvbnRf
bGlua19jb250ZXh0CQlcblwKK19fY29udF9saW5rX2NvbnRleHQ6CQkJCVxu
XAorCS5zZWhfZW5kcHJvbG9ndWUJCQlcblwKKwlsZHIJeDAsIFt4MTldCQkJ
XG5cCisJYW5kCXNwLCB4MTksICN+MHhmCQkJXG5cCisJY2Juegl4MCwgMWYJ
CQkJXG5cCisJbW92CXcwLCAjMHhmZgkJCVxuXAorCWIJY3lnd2luX2V4aXQJ
CQlcblwKKzE6CQkJCQkJXG5cCisJYglzZXRjb250ZXh0CQkJXG5cCisJLnNl
aF9lbmRwcm9jCQkJCVxuIgorCSk7CiAjZWxzZQogI2Vycm9yIHVuaW1wbGVt
ZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CiAjZW5kaWYKQEAgLTIwNzgsMTEgKzIy
MTAsMTkgQEAgX19jb250X2xpbmtfY29udGV4dDoJCQlcblwKIC8qIG1ha2Vj
b250ZXh0IGlzIG1vZGVsbGVkIGFmdGVyIEdMaWJjJ3MgbWFrZWNvbnRleHQu
ICBUaGUgc3RhY2sgZnJvbSB1Y19zdGFjawogICAgaXMgcHJlcGFyZWQgc28g
dGhhdCBpdCBzdGFydHMgd2l0aCBhIHBvaW50ZXIgdG8gdGhlIGxpbmtlZCBj
b250ZXh0IHVjX2xpbmssCiAgICBmb2xsb3dlZCBieSB0aGUgYXJndW1lbnRz
IHRvIGZ1bmMsIGFuZCBmaW5hbGx5IGF0IHRoZSBib3R0b20gdGhlICJyZXR1
cm4iCi0gICBhZGRyZXNzIHNldCB0byBfX2NvbnRfbGlua19jb250ZXh0LiAg
SW4gdGhlIHVjcCBjb250ZXh0LCByYngvZWJ4IGlzIHNldCB0bwotICAgcG9p
bnQgdG8gdGhlIHN0YWNrIGFkZHJlc3Mgd2hlcmUgdGhlIHBvaW50ZXIgdG8g
dWNfbGluayBpcyBzdG9yZWQuICBUaGUKLSAgIHJlcXVpcmVtZW50IHRvIG1h
a2UgdGhpcyB3b3JrIGlzIHRoYXQgcmJ4L2VieCBhcmUgY2FsbGVlLXNhdmVk
IHJlZ2lzdGVycwotICAgcGVyIHRoZSBBQkkuICBJZiBhbnkgZnVuY3Rpb24g
aXMgY2FsbGVkIHdoaWNoIGRvZXNuJ3QgZm9sbG93IHRoZSBBQkkKLSAgIGNv
bnZlbnRpb25zLCBlLmcuIGFzc2VtYmxlciBjb2RlLCB0aGlzIG1ldGhvZCB3
aWxsIGJyZWFrLiAgQnV0IHRoYXQncyBvay4gKi8KKyAgIGFkZHJlc3Mgc2V0
IHRvIF9fY29udF9saW5rX2NvbnRleHQuCisKKyAgIHg4Nl82NDogSW4gdGhl
IHVjcCBjb250ZXh0LCByYnggaXMgc2V0IHRvIHBvaW50IHRvIHRoZSBzdGFj
ayBhZGRyZXNzIHdoZXJlCisgICB0aGUgcG9pbnRlciB0byB1Y19saW5rIGlz
IHN0b3JlZC4gIFRoZSByZXF1aXJlbWVudCB0byBtYWtlIHRoaXMgd29yayBp
cyB0aGF0CisgICByYnggaXMgYSBjYWxsZWUtc2F2ZWQgcmVnaXN0ZXIgcGVy
IHRoZSBBQkkuCisKKyAgIEFSTTY0OiBJbiB0aGUgdWNwIGNvbnRleHQsIHgx
OSBpcyBzZXQgdG8gcG9pbnQgdG8gdGhlIHN0YWNrIGFkZHJlc3Mgd2hlcmUK
KyAgIHRoZSBwb2ludGVyIHRvIHVjX2xpbmsgaXMgc3RvcmVkLiAgVGhlIHJl
cXVpcmVtZW50IGlzIHRoYXQgeDE5IGlzIGEKKyAgIGNhbGxlZS1zYXZlZCBy
ZWdpc3RlciBwZXIgdGhlIEFSTTY0IEFCSS4KKworICAgSWYgYW55IGZ1bmN0
aW9uIGlzIGNhbGxlZCB3aGljaCBkb2Vzbid0IGZvbGxvdyB0aGUgQUJJIGNv
bnZlbnRpb25zLCBlLmcuCisgICBhc3NlbWJsZXIgY29kZSwgdGhpcyBtZXRo
b2Qgd2lsbCBicmVhay4gIEJ1dCB0aGF0J3Mgb2suICovCisKIGV4dGVybiAi
QyIgdm9pZAogbWFrZWNvbnRleHQgKHVjb250ZXh0X3QgKnVjcCwgdm9pZCAo
KmZ1bmMpICh2b2lkKSwgaW50IGFyZ2MsIC4uLikKIHsKQEAgLTIwOTAsNjUg
KzIyMzAsMTUwIEBAIG1ha2Vjb250ZXh0ICh1Y29udGV4dF90ICp1Y3AsIHZv
aWQgKCpmdW5jKSAodm9pZCksIGludCBhcmdjLCAuLi4pCiAgIHVpbnRwdHJf
dCAqc3A7CiAgIHZhX2xpc3QgYXA7CiAKKyNpZiBkZWZpbmVkKF9feDg2XzY0
X18pCisgIC8qIHg4Nl82NDogQXJndW1lbnRzIGJleW9uZCB0aGUgZmlyc3Qg
NCBnbyBvbiB0aGUgc3RhY2suCisgICAgIEhvd2V2ZXIsIHdlIGFsbG9jYXRl
IHNoYWRvdyBzcGFjZSBmb3IgYWxsIGFyZ3MgaW5jbHVkaW5nIHJlZ2lzdGVy
IGFyZ3MuICovCisgIGludCBzdGFja19hcmdzID0gYXJnYzsKKworI2VsaWYg
ZGVmaW5lZChfX2FhcmNoNjRfXykKKyAgLyogQVJNNjQ6IEFyZ3VtZW50cyBi
ZXlvbmQgdGhlIGZpcnN0IDggZ28gb24gdGhlIHN0YWNrLgorICAgICBXZSBv
bmx5IGFsbG9jYXRlIHN0YWNrIHNwYWNlIGZvciBhcmdzIGJleW9uZCByZWdp
c3RlcnMuICovCisgIGludCBzdGFja19hcmdzID0gKGFyZ2MgPiA4KSA/IChh
cmdjIC0gOCkgOiAwOworCisjZWxzZQorI2Vycm9yIHVuaW1wbGVtZW50ZWQg
Zm9yIHRoaXMgdGFyZ2V0CisjZW5kaWYKKwogICAvKiBJbml0aWFsaXplIHNw
IHRvIHRoZSB0b3Agb2YgdGhlIHN0YWNrLiAqLwogICBzcCA9ICh1aW50cHRy
X3QgKikgKCh1aW50cHRyX3QpIHVjcC0+dWNfc3RhY2suc3Nfc3AgKyB1Y3At
PnVjX3N0YWNrLnNzX3NpemUpOwotICAvKiBTdWJ0cmFjdCBzbG90cyByZXF1
aXJlZCBmb3IgYXJndW1lbnRzIGFuZCB0aGUgcG9pbnRlciB0byB1Y19saW5r
LiAqLwotICBzcCAtPSAoYXJnYyArIDEpOwotICAvKiBBbGlnbi4gKi8KLSAg
c3AgPSAodWludHB0cl90ICopICgodWludHB0cl90KSBzcCAmIH4weGYpOwot
ICAvKiBTdWJ0cmFjdCBvbmUgc2xvdCBmb3Igc2V0dGluZyB0aGUgcmV0dXJu
IGFkZHJlc3MuICovCisKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCisgIC8q
IHg4Nl82NDogU3VidHJhY3Qgc2xvdHMgZm9yIGFsbCBhcmd1bWVudHMgKyB1
Y19saW5rIHBvaW50ZXIKKyAgICAgYW5kIHJldHVybiBhZGRyZXNzLiAgKi8K
KyAgc3AgLT0gKHN0YWNrX2FyZ3MgKyAxKTsgIC8qIGFyZ2MgKyAxIGZvciB1
Y19saW5rICovCisgIC8qIEFsaWduIHRvIDE2IGJ5dGVzLiAqLworICBzcCA9
ICh1aW50cHRyX3QgKikgKCh1aW50cHRyX3QpIHNwICYgfjB4ZlVMKTsKKyAg
LyogU3VidHJhY3Qgb25lIG1vcmUgc2xvdCBmb3IgdGhlIHJldHVybiBhZGRy
ZXNzLiAqLwogICAtLXNwOwotICAvKiBTZXQgcmV0dXJuIGFkZHJlc3MgdG8g
dGhlIHRyYW1wb2xpbiBmdW5jdGlvbiBfX2NvbnRfbGlua19jb250ZXh0LiAq
LworICAvKiBTZXQgcmV0dXJuIGFkZHJlc3MgdG8gdGhlIHRyYW1wb2xpbmUg
ZnVuY3Rpb24gX19jb250X2xpbmtfY29udGV4dC4gKi8KICAgc3BbMF0gPSAo
dWludHB0cl90KSBfX2NvbnRfbGlua19jb250ZXh0OwotICAvKiBGZXRjaCBh
cmd1bWVudHMgYW5kIHN0b3JlIHRoZW0gb24gdGhlIHN0YWNrLgogCi0gICAg
IHg4Nl82NDoKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisgIC8qIEFS
TTY0OiBTdWJ0cmFjdCBzbG90cyBmb3Igc3RhY2sgYXJndW1lbnRzICsgdWNf
bGluayBwb2ludGVyLiAqLworICBzcCAtPSAoc3RhY2tfYXJncyArIDEpOyAg
Lyogc3RhY2tfYXJncyArIDEgZm9yIHVjX2xpbmsgKi8KKyAgLyogQVJNNjQg
cmVxdWlyZXMgMTYtYnl0ZSBhbGlnbm1lbnQgYXQgcHVibGljIGludGVyZmFj
ZXMuICovCisgIHNwID0gKHVpbnRwdHJfdCAqKSAoKHVpbnRwdHJfdCkgc3Ag
JiB+MHhmVUwpOwogCi0gICAgIC0gU3RvcmUgZmlyc3QgZm91ciBhcmdzIGlu
IHRoZSBBTUQ2NCBBQkkgYXJnIHJlZ2lzdGVycy4KKyNlbmRpZgogCisgIC8q
IEZldGNoIGFyZ3VtZW50cyBhbmQgc3RvcmUgdGhlbS4KKyAgICAgeDg2XzY0
OgorICAgICAtIFN0b3JlIGZpcnN0IGZvdXIgYXJncyBpbiB0aGUgQU1ENjQg
QUJJIGFyZyByZWdpc3RlcnMgKHJjeCwgcmR4LCByOCwgcjkpLgogICAgICAt
IE5vdGUgdGhhdCB0aGUgc3RhY2sgaXMgbm90IHNob3J0IGJ5IHRoZXNlIGZv
dXIgcmVnaXN0ZXIgYXJncy4gIFRoZQogICAgICAgIHJlYXNvbiBpcyB0aGUg
c2hhZG93IHNwYWNlIGZvciB0aGVzZSByZWdzIHJlcXVpcmVkIGJ5IHRoZSBB
TUQ2NCBBQkkuCi0KICAgICAgLSBUaGUgZGVmaW5pdGlvbiBvZiBtYWtlY29u
dGV4dCBvbmx5IGFsbG93cyBmb3IgImludCIgc2l6ZWQgYXJndW1lbnRzIHRv
CiAgICAgICAgZnVuYywgMzIgYml0LCBsaWtlbHkgZm9yIGhpc3RvcmljYWwg
cmVhc29ucy4gIEhvd2V2ZXIsIHRoZSBhcmd1bWVudAogICAgICAgIHNsb3Rz
IG9uIHg4Nl82NCBhcmUgNjQgYml0IGFueXdheSwgc28gd2UgY2FuIGZldGNo
IGFuZCBzdG9yZSB0aGUgYXJncwogICAgICAgIGFzIDY0IGJpdCB2YWx1ZXMs
IGFuZCBmdW5jIGNhbiByZXF1ZXN0IDY0IGJpdCBhcmdzIHdpdGhvdXQgdmlv
bGF0aW5nCiAgICAgICAgdGhlIGRlZmluaXRpb24uICBUaGlzIHBvdGVudGlh
bGx5IGFsbG93cyBwb3J0aW5nIDMyIGJpdCBhcHBsaWNhdGlvbnMKLSAgICAg
ICBwcm92aWRpbmcgcG9pbnRlciB2YWx1ZXMgdG8gZnVuYyB3aXRob3V0IGFk
ZGl0aW9uYWwgcG9ydGluZyBlZmZvcnQuICovCisgICAgICAgcHJvdmlkaW5n
IHBvaW50ZXIgdmFsdWVzIHRvIGZ1bmMgd2l0aG91dCBhZGRpdGlvbmFsIHBv
cnRpbmcgZWZmb3J0LgorCisgICAgIEFSTTY0OgorICAgICAtIFN0b3JlIGZp
cnN0IGVpZ2h0IGFyZ3MgaW4gQVJNNjQgQUJJIGFyZyByZWdpc3RlcnMgKHgw
LXg3KS4KKyAgICAgLSBBcmd1bWVudHMgYmV5b25kIDggZ28gb24gdGhlIHN0
YWNrLgorICAgICAtIFNpbWlsYXIgdG8geDg2XzY0LCB3ZSBzdG9yZSBhcyB1
aW50cHRyX3QgZm9yIHBvaW50ZXIgY29tcGF0aWJpbGl0eS4gKi8KKwogICB2
YV9zdGFydCAoYXAsIGFyZ2MpOwogICBmb3IgKGludCBpID0gMDsgaSA8IGFy
Z2M7ICsraSkKLSNpZmRlZiBfX3g4Nl82NF9fCi0gICAgc3dpdGNoIChpKQot
ICAgICAgewotICAgICAgY2FzZSAwOgotCXVjcC0+dWNfbWNvbnRleHQucmN4
ID0gdmFfYXJnIChhcCwgdWludHB0cl90KTsKLQlicmVhazsKLSAgICAgIGNh
c2UgMToKLQl1Y3AtPnVjX21jb250ZXh0LnJkeCA9IHZhX2FyZyAoYXAsIHVp
bnRwdHJfdCk7Ci0JYnJlYWs7Ci0gICAgICBjYXNlIDI6Ci0JdWNwLT51Y19t
Y29udGV4dC5yOCA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7Ci0JYnJlYWs7
Ci0gICAgICBjYXNlIDM6Ci0JdWNwLT51Y19tY29udGV4dC5yOSA9IHZhX2Fy
ZyAoYXAsIHVpbnRwdHJfdCk7Ci0JYnJlYWs7Ci0gICAgICBkZWZhdWx0Ogot
CXNwW2kgKyAxXSA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7Ci0JYnJlYWs7
Ci0gICAgICB9Ci0jZWxzZQotI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRo
aXMgdGFyZ2V0CisgICAgeworI2lmIGRlZmluZWQoX194ODZfNjRfXykKKyAg
ICAgIHN3aXRjaCAoaSkKKyAgICAgICAgeworICAgICAgICBjYXNlIDA6Cisg
ICAgICAgICAgdWNwLT51Y19tY29udGV4dC5yY3ggPSB2YV9hcmcgKGFwLCB1
aW50cHRyX3QpOworICAgICAgICAgIGJyZWFrOworICAgICAgICBjYXNlIDE6
CisgICAgICAgICAgdWNwLT51Y19tY29udGV4dC5yZHggPSB2YV9hcmcgKGFw
LCB1aW50cHRyX3QpOworICAgICAgICAgIGJyZWFrOworICAgICAgICBjYXNl
IDI6CisgICAgICAgICAgdWNwLT51Y19tY29udGV4dC5yOCA9IHZhX2FyZyAo
YXAsIHVpbnRwdHJfdCk7CisgICAgICAgICAgYnJlYWs7CisgICAgICAgIGNh
c2UgMzoKKyAgICAgICAgICB1Y3AtPnVjX21jb250ZXh0LnI5ID0gdmFfYXJn
IChhcCwgdWludHB0cl90KTsKKyAgICAgICAgICBicmVhazsKKyAgICAgICAg
ZGVmYXVsdDoKKyAgICAgICAgICAvKiBTdGFjayBhcmd1bWVudHMgc3RhcnQg
YXQgc3BbaSArIDFdIGJlY2F1c2Ugc3BbMF0gaXMgcmV0dXJuIGFkZHJlc3Mg
Ki8KKyAgICAgICAgICBzcFtpICsgMV0gPSB2YV9hcmcgKGFwLCB1aW50cHRy
X3QpOworICAgICAgICAgIGJyZWFrOworICAgICAgICB9CisKKyNlbGlmIGRl
ZmluZWQoX19hYXJjaDY0X18pCisgICAgICBzd2l0Y2ggKGkpCisgICAgICAg
IHsKKyAgICAgICAgY2FzZSAwOgorICAgICAgICAgIHVjcC0+dWNfbWNvbnRl
eHQueDAgPSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOworICAgICAgICAgIGJy
ZWFrOworICAgICAgICBjYXNlIDE6CisgICAgICAgICAgdWNwLT51Y19tY29u
dGV4dC54MSA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7CisgICAgICAgICAg
YnJlYWs7CisgICAgICAgIGNhc2UgMjoKKyAgICAgICAgICB1Y3AtPnVjX21j
b250ZXh0LngyID0gdmFfYXJnIChhcCwgdWludHB0cl90KTsKKyAgICAgICAg
ICBicmVhazsKKyAgICAgICAgY2FzZSAzOgorICAgICAgICAgIHVjcC0+dWNf
bWNvbnRleHQueDMgPSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOworICAgICAg
ICAgIGJyZWFrOworICAgICAgICBjYXNlIDQ6CisgICAgICAgICAgdWNwLT51
Y19tY29udGV4dC54NCA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7CisgICAg
ICAgICAgYnJlYWs7CisgICAgICAgIGNhc2UgNToKKyAgICAgICAgICB1Y3At
PnVjX21jb250ZXh0Lng1ID0gdmFfYXJnIChhcCwgdWludHB0cl90KTsKKyAg
ICAgICAgICBicmVhazsKKyAgICAgICAgY2FzZSA2OgorICAgICAgICAgIHVj
cC0+dWNfbWNvbnRleHQueDYgPSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOwor
ICAgICAgICAgIGJyZWFrOworICAgICAgICBjYXNlIDc6CisgICAgICAgICAg
dWNwLT51Y19tY29udGV4dC54NyA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7
CisgICAgICAgICAgYnJlYWs7CisgICAgICAgIGRlZmF1bHQ6CisgICAgICAg
ICAgLyogU3RhY2sgYXJndW1lbnRzIGJleW9uZCB0aGUgZmlyc3QgOCByZWdp
c3RlcnMuICovCisgICAgICAgICAgc3BbaSAtIDhdID0gdmFfYXJnIChhcCwg
dWludHB0cl90KTsKKyAgICAgICAgICBicmVhazsKKyAgICAgICAgfQogI2Vu
ZGlmCisgICAgfQogICB2YV9lbmQgKGFwKTsKLSAgLyogU3RvcmUgcG9pbnRl
ciB0byB1Y19saW5rIGF0IHRoZSB0b3Agb2YgdGhlIHN0YWNrLiAqLworCisj
aWYgZGVmaW5lZChfX3g4Nl82NF9fKQorICAvKiBTdG9yZSBwb2ludGVyIHRv
IHVjX2xpbmsgYXQgc3BbYXJnYyArIDFdLCBhZnRlciByZXR1cm4gYWRkcmVz
cworICAgICBhbmQgYXJncy4gICovCiAgIHNwW2FyZ2MgKyAxXSA9ICh1aW50
cHRyX3QpIHVjcC0+dWNfbGluazsKKworI2VsaWYgZGVmaW5lZChfX2FhcmNo
NjRfXykKKyAgLyogU3RvcmUgcG9pbnRlciB0byB1Y19saW5rIGF0IHRoZSB0
b3Agb2Ygb3VyIGFsbG9jYXRlZCBhcmVhLiAqLworICBzcFtzdGFja19hcmdz
XSA9ICh1aW50cHRyX3QpIHVjcC0+dWNfbGluazsKKworI2VuZGlmCisKICAg
LyogTGFzdCBidXQgbm90IGxlYXN0IHNldCB0aGUgcmVnaXN0ZXIgaW4gdGhl
IGNvbnRleHQgYXQgdWNwIHNvIHRoYXQgYQogICAgICBzdWJzZXF1ZW50IHNl
dGNvbnRleHQgb3Igc3dhcGNvbnRleHQgcGlja3MgdXAgdGhlIHJpZ2h0IHZh
bHVlczoKICAgICAgLSBTZXQgaW5zdHJ1Y3Rpb24gcG9pbnRlciB0byB0aGUg
dGFyZ2V0IGZ1bmN0aW9uLgogICAgICAtIFNldCBzdGFjayBwb2ludGVyIHRv
IHRoZSBqdXN0IGNvbXB1dGVkIHN0YWNrIHBvaW50ZXIgdmFsdWUuCiAgICAg
IC0gU2V0IEN5Z3dpbi1zcGVjaWZpYyB1Y2xpbmsgcmVnaXN0ZXIgdG8gdGhl
IGFkZHJlc3Mgb2YgdGhlIHBvaW50ZXIKLSAgICAgICB0byB1Y19saW5rLiAq
LworICAgICAgIHRvIHVjX2xpbmsuCisKKyAgICAgeDg2XzY0OiB1Y2xpbmsg
cmVnaXN0ZXIgaXMgcmJ4IChjYWxsZWUtc2F2ZWQpCisgICAgIEFSTTY0OiAg
dWNsaW5rIHJlZ2lzdGVyIGlzIHgxOSAoY2FsbGVlLXNhdmVkKSAqLworCiAg
IHVjcC0+dWNfbWNvbnRleHQuX01DX2luc3RQdHIgPSAodWludDY0X3QpIGZ1
bmM7CiAgIHVjcC0+dWNfbWNvbnRleHQuX01DX3N0YWNrUHRyID0gKHVpbnQ2
NF90KSBzcDsKKworI2lmIGRlZmluZWQoX194ODZfNjRfXykKICAgdWNwLT51
Y19tY29udGV4dC5fTUNfdWNsaW5rUmVnID0gKHVpbnQ2NF90KSAoc3AgKyBh
cmdjICsgMSk7CisKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisgIC8q
IFNldCBMUiB0byBfX2NvbnRfbGlua19jb250ZXh0IGZvciBBUk02NCAodXNl
ZCBhcyByZXR1cm4gYWRkcmVzcykuICovCisgIHVjcC0+dWNfbWNvbnRleHQu
bHIgPSAodWludDY0X3QpIF9fY29udF9saW5rX2NvbnRleHQ7CisgIHVjcC0+
dWNfbWNvbnRleHQuX01DX3VjbGlua1JlZyA9ICh1aW50NjRfdCkgKHNwICsg
c3RhY2tfYXJncyk7CisKKyNlbmRpZgogfQotLSAKMi41MC4xLndpbmRvd3Mu
MQoK

--_004_PN3P287MB1320988B69BF5F0D12079191F7152PN3P287MB1320INDP_--

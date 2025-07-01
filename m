Return-Path: <SRS0=y+SQ=ZO=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id E223F3857002
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 10:31:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E223F3857002
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E223F3857002
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751365889; cv=pass;
	b=qDp+CmN4aA7zJKrKoykYfNI9Rel9hYupom7zYIP/L5y2hLc5a+n5wZ+eDpsPJfEnpQgdUBF8KWUZ1PD/eZYdhz5Dgn2cvyAGLAYXQ9b+fNcZF4HttoYSZWkNvhbMM6oOD/TqDMproapNdHb7pwsviU+xUYj6ksGsKqnU54Fz1n4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751365889; c=relaxed/simple;
	bh=a12qE3WVmQpcNE9FkDLCQiXwUY/ymNGYB+PLQBMSmL4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Xe/A5rqLvI29pRoiaqR0Pn9JxLFoSOTi+L64Fg+x/jz0Mev9xUSq3FXWeIn4yF3ftv7yRzL4aAKWkAN9eKYbCU289FThQf+80hqtMO0uASUO+ID1DEGgTtef7vLAxLGT5JaOy3lDwFhskvd53Pyj6vhBOSwn718gq8J2K/cE/aI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E223F3857002
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=FMaU4WIZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEDOFmu0c/dqwXnSPsdbBrSxsjMrcEyMht1ypLEHvipihb7yE5KbyqgUQJWK+wwe2IlUyWcN6B3WwRVwdzXyJ8NZe48ppqbXjTppFUivVGZOGAnVRQ1Jur+ML38l6TTsOFxh04jf52t7F0uTrVMgR/m6k+zVOLZpNR3o5r739varPeevZtgNR1dUI0QqwXJGAGetMYh9YhLwrdwmSDIxUCOstnLS1HJTLF1dI7UJ84a0v2LHVNUyOdvxmzZ47bo5djQBw3FBXNSdfj4fvfuVnBpqtidCADvtKGQS6Jxuogh1c+NrxQNQK8ZXq4N+j74EQqJ7X/Bh7FK3ShQEGNVCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPYHIKJLPetXCd0O6NLrLB60IYpqq6qzKhFZRbSkbGI=;
 b=LpgpBHiKwjRjdENXUE5qMfokb0G22W0SApgQMbPiiiIiooM94CbUtgijDoGjGcYLQo16QHyAi+QOeHf2z9sZwlBKiLbPUWvI769P2kKgz3FeZ1QiImp2HQp9HMVm0UVoln/XGx22MrL/BKBMTYsT3OglOVaT6S8OfXhVLZasRX72BwZJdr5Tv+H8NjVMqWXDZ6NZOf4fWqUn240pEFqWWZ8xgWluIcvWifv6YyU197yQ+fs8EiRAQIYh6XWAbuoXhWXewXkUY37T7WAd5e12flcUMnkUz4bs3g6Qh9dOi9fonBND0rr/z9YsCqMjufgM7kQedado2XNRHi6sKEBzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPYHIKJLPetXCd0O6NLrLB60IYpqq6qzKhFZRbSkbGI=;
 b=FMaU4WIZrtI2ARG4sFDcwH8ahnJWuYyjxTJeBvBWAWzEOohjlv/X4nc6KzINvyrCB/uo2rpAuv6UP4Xm+ND7W6iKfv73wTuQdPKjmm7YbnzlUPo+BrKiaYzCZFrvssDeg1Q6YBalA6hnGcgLwUFdDEElv8nOgFiz1zY2ttOjVvp05C30ORDJ3u//9MdqHBEaDwZlpUSx9qA9sakngrJMRZNGQFuqRIF9Oc4+jEQj/wYZtOguXppH2bHQYjGJmlPVmtWdCNtZ0jWn4r8nJSnQqXNtki2c/EsNNZh5ZscYz8tDyvUAc/7adRfpYubw2HLvpzD8JL16DKDYDhw4b/Xbkg==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA0P287MB0998.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 10:31:23 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%3]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 10:31:23 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Aarch64: Optimize pthread_wrapper by eliminating x19 and
 streamlining register usage
Thread-Topic: [PATCH] Aarch64: Optimize pthread_wrapper by eliminating x19 and
 streamlining register usage
Thread-Index: AdvqbfB6xDQp0DERQTCCiT3j81iHGw==
Date: Tue, 1 Jul 2025 10:31:23 +0000
Message-ID:
 <MA0P287MB3082799B10054C7B9C07F51F9F41A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA0P287MB0998:EE_
x-ms-office365-filtering-correlation-id: 515295ff-6fa4-4712-f58f-08ddb88a6d61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|8096899003|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LlwIJ9XJLOu9cWpISvz4oztZtIReWTKsL6rIG4Ee8IS4Dx3830N/ByPqysiT?=
 =?us-ascii?Q?yGB/KhEWgoJdTvy2s+97n++6EX7pJ1mivjLSPqOTMqJrGM8tRs2VuuNl54Jb?=
 =?us-ascii?Q?il5WQd4lwpg4hdSH7KwsID2qWhaWjYsOrUK1mIEOsC8GrzbQj7pKL/K0xcbC?=
 =?us-ascii?Q?07PeZvxLylmS1cUS9pN2j20HD5CuYcaQidH0Z/4idWsUNnQQymEBUhz4u1yQ?=
 =?us-ascii?Q?868EbhAoFeBNe6rGhSKHGdtSroFIgWb/5OtAoxyvFZXw9YzFA5XJkk3KKVef?=
 =?us-ascii?Q?/PzNryPxBAf1dHOzBAseaQTChrz/I1OkQ4R9eHMuUv04uF58cWpceJ++JRCO?=
 =?us-ascii?Q?DhRcy4MJX+xbPWIukERFvHVnItEYX0ZYjSiQvKx9aLvy4GDka6Wpyxtw+JA0?=
 =?us-ascii?Q?VWvUc3kLtSIII7rzKCDz10znNfTf/SVM+e6sFkzbeeJYSeFCiqELDy4W6vC4?=
 =?us-ascii?Q?0jBq7HzxcXcj+fj5h3XUksrLdvo9ftMZvTpuBRR5HZSHj7+cRfaV8mKjRkIT?=
 =?us-ascii?Q?LXDUCbTwlLdiu75hGpz5iikOL9EUlkIYoTzDbygKdmNElbrlnj3DGonRoFDJ?=
 =?us-ascii?Q?offJrpuyN+a5F7jW2XQbbDCnvOVLyL3JbqR1wNgssRjNYPzaqnhulOSo9hbG?=
 =?us-ascii?Q?x38OkPyhQrVyQJDed+VUwm7dRzAOxoDmB8rgL6Z6kwGrIrVaZhY2Ig+zmxh6?=
 =?us-ascii?Q?sM9b4DS9X9/sgtoarRDpAJZ8kB/kKpaSHX/1O3Wu7yp3qbBgziGm3wdW+qF5?=
 =?us-ascii?Q?4teqJoL9R0SHHEElxthX38UchfSwdkC8LrqB6t3E7zq1ch/jp08FsB3KlDaf?=
 =?us-ascii?Q?UV15e3zLZJ8Ie/MDLIJwGSDIdEkTjIDJBXcJeSSW/Ri2bcdGPVCZljA0bvfx?=
 =?us-ascii?Q?TRcZOFS95XSjFXZp/Z41YM1fW7mDlMVPMT01TTKlal0JR2bD/v0W3jCStvfB?=
 =?us-ascii?Q?ZlxNiN3aIH7hCT3DEZRuUV1ARU4EyJCbPzi4htLVb6KKXHIWRxJAWad/TjCS?=
 =?us-ascii?Q?Ekg0vr9IPYgjTlZv6bYJML80erDSalsSxavahbXLl5QMczS/SWbJdHattTwj?=
 =?us-ascii?Q?3Sz3+7HQQIOppb8uhAkM4DRkbF71cmRyE2LJ5075uJTrXPAK1/wGuqCQMiZ2?=
 =?us-ascii?Q?k7K4s/ehhNUwhb67xjZB/6pvQab3rgeAfD9/AA3y9SKumbSRLYLEyYYUOiPj?=
 =?us-ascii?Q?rw4p9oP+mbXWiP+YGEhIZ6V5RekDxMv+osg1iZMjvG20mFa/dG4TY7cMJvku?=
 =?us-ascii?Q?mrmWzn9PE4OYxMkVWmVVVFw7CyX6P6BvuPm+Vh9ZNrkSfFDk8PSCnjycOE5U?=
 =?us-ascii?Q?6NIokjj1tNw2cUdK+f3+taeypmEYnLRkEWBAvf8r7/HRV38s+d+E0U/CZ7Y4?=
 =?us-ascii?Q?sLwffmjwLrEEr+ua96/zBKhkFzPPy92AWzxZtM9ccdiss58dDN8spm38Fx6K?=
 =?us-ascii?Q?+DMUY4e1eRE4f0QIZE8y9v90JyLoYIe+Ev67KotJ1TVH/BYdRVpVj5E2QocR?=
 =?us-ascii?Q?nP8R8xNqdzAO0DQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?87bYiIagarQQPFrPh10PZgiUilYbeqqZD8V0WFJLpWkATmM0/VNINVb3H48j?=
 =?us-ascii?Q?RTBfju3L+oYx+eBME9M6jh7vmjGdcUEc7KZA18cP20hmjftCPHbpZ24inLC9?=
 =?us-ascii?Q?zrHgNU9cwkJwl+em4ZG6HmN2iS2MVv3flg1TttMBuImDhXG9bdjpHQMuDaGu?=
 =?us-ascii?Q?C9hxMsRFXo/zi035y1vb7aJ1J6AraD+VjLFZiIlaHBldLao1g+O1cpar1x2L?=
 =?us-ascii?Q?MHpmIOvUZbvZCSWLpYKYHSZ16ksJosfK8hbU94kNT7/Z0x1p6lzLO3ozDUFH?=
 =?us-ascii?Q?kKxCdpgMi9vO0qk8PMc96BVqCBYlWzd4GttsP+CY7C/d0ATHXxT6eNBpIw1N?=
 =?us-ascii?Q?7j2UnuhTLWUOQkeYKPlw7BOveyKR9VkmWdogffjJ83lsJt91yzz79vA9+oL9?=
 =?us-ascii?Q?/XSWtDYn+I5hPHzqdENnX/N/Vi4KBKigfYW7zkl5f+S8ARLW6G4aq/UsuiIs?=
 =?us-ascii?Q?oJq+2ljwxJHfK/M5EXPRJu9LKAdBmSyB+09/EsIwGGKKoyPWW2MWoFB7k+4L?=
 =?us-ascii?Q?C6IOOKjAY9wcykqWaUWZHYWf7GTSnxCvzeNx+6YTCgTcMwxnMtckqa10j73/?=
 =?us-ascii?Q?UIlNWnjUkW3wxnP5DRrUTWjnCgNLjNmw1qUZcQbfzVelOEyxxD3ibJrZYVsS?=
 =?us-ascii?Q?w+P1ddKIPw4FGfmCJReUvGdVWpJ90Y2yojFZqeJO9O844INzIcmRLUVZcFtK?=
 =?us-ascii?Q?CItqUxyG5shsEAjKja4rqyDmolcZHss7huY1422ERJV9c1jGfM6LiB7W7LeH?=
 =?us-ascii?Q?1iAoNWTInMPYOLOvTB1pdMfQk6DcbWOdwm2WOY/9Y/2SLdV+5O7bexsjZYUl?=
 =?us-ascii?Q?J6TerBBZ8KThN1x7MeLY9MMCxeDYoAtAFLlg2C6+7Ub8DLqBiZxO6SUgmYu6?=
 =?us-ascii?Q?P+E2Bw7SuFPZqOziS8iKMJqJ9MPd+6J3gCqDm9WpFiZekEXAXyOlWmZZzeZS?=
 =?us-ascii?Q?RtccJEuChX8VQqIPIfDHE5QDrKvlsGYkOkouK244d817atwq/qhcbYQsrIer?=
 =?us-ascii?Q?KsUKuoMkAYbn4NyoGtbY+j5KKbx987gpywr3SpfAhKOP+LuxS3x6G9hiC7jW?=
 =?us-ascii?Q?Kj0NhsJn1yayplL5NReRKKqu9UJk9xTyhMPk0P+LH5iVWZilF7DmX2O6uVvZ?=
 =?us-ascii?Q?GNIM4QCx5AdAUCOHc1CGcNwu0YP8j3ZlwekldUgW5EewgONunsmIKsXI0eDb?=
 =?us-ascii?Q?vRyZ0JMVMSE/6gBpb2Ft/Zf3ylfLk1CBsO1tSqMWqrVXVx662xLiE41C4qYq?=
 =?us-ascii?Q?NFdrLQfaVC29Z6rFjxVtZTcZ/5n6aH0QeYuHYAR2blQuScWtZfEB/fyunttC?=
 =?us-ascii?Q?Kc4Va2orYusGuvfuQYtBD+G0FYqIOrET9ogAVMbi6wTnjWDVIOqPVQO8W7M7?=
 =?us-ascii?Q?GUwy/+B7EhwN/FHNeTBF0TuUfTZmlo9S1h4xV8AkX1gBzY73tJlNrqWgdWTT?=
 =?us-ascii?Q?ZhF80TL4cGEN8RFaRAeSDNL6qW2WObdSInl2uk3B7eZxC9eBTNN5oO2SIyOa?=
 =?us-ascii?Q?uMgZJRjJ5GpYhYrux7DIaeGgLQmIu17tB2q0yBKBGpud23JLvU0caXHuqw4P?=
 =?us-ascii?Q?XR2pwjJpxKy7CHXkLAoun61Kf0GY+Mxj/T2Lds5a8jO0Qn7OL1cZhmdZCLR7?=
 =?us-ascii?Q?eqdTx+uSfvg4y5F1qaRhUiA=3D?=
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082799B10054C7B9C07F51F9F41AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 515295ff-6fa4-4712-f58f-08ddb88a6d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 10:31:23.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mZQdt3bvSRQ+CxMOutfPxlwoDFtDQ5qSANmWAx5tXk9ViRzgE1ief/s5XCMTMLYrw9t82rzmrRsh01a517mImJjJF4mEbcLMI5nY/nX/aOhTMErUORPnQsZo0PZIfw+CChC2yQgtpFH4lAPWjRVLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0998
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082799B10054C7B9C07F51F9F41AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082799B10054C7B9C07F51F9F41AMA0P287MB3082INDP_"

--_000_MA0P287MB3082799B10054C7B9C07F51F9F41AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch fixes existing issues in my earlier commit [https://github.com/c=
ygwin/cygwin/commit/f4ba145056dbe99adf4dbe632bec035e006539f8] and optimizes=
 the AArch64 thread startup sequence by eliminating the use of register x19=
 and streamlining register usage.
The key modifications are detailed in the patch's commit description. These=
 changes improve register efficiency while ensuring correct thread argument=
 in register `x0` after virtual free call, preventing from any segmentation=
 faults. The patch has been tested in our internal AArch64 environment wher=
e pthread related test cases are now passing as expected.

Inlined Patch:

=46rom e197e39452e542d18812f41ac2a3af2fa172b273 Mon Sep 17 00:00:00 2001
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Date: Tue, 1 Jul 2025 14:46:52 +0530
Subject: [PATCH] Aarch64: Optimize pthread_wrapper by eliminating x19 and
 streamlining register usage

- Removed use of x19 by directly loading the thread func and arg using LDP =
from [WRAPPER_ARG], freeing up one additional register
- Loaded thread function and argument into x20 and x21 before VirtualFree t=
o preserve their values across the virtual free call
- Used x1 as a temporary register to load stack base, subtract CYGTLS, and =
update SP
- Moved thread argument back into x0 after VirtualFree and before calling t=
he thread function

Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewarein=
c.com>
---
 winsup/cygwin/create_posix_thread.cc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_po=
six_thread.cc
index 592aaf1a5..17bb607f7 100644
--- a/winsup/cygwin/create_posix_thread.cc
+++ b/winsup/cygwin/create_posix_thread.cc
@@ -103,18 +103,19 @@ pthread_wrapper (PVOID arg)
   /* Sets up a new thread stack, frees the original OS stack,
    * and calls the thread function with its arg using AArch64 ABI. */
   __asm__ __volatile__ ("\n\
-     mov     x19, %[WRAPPER_ARG]  // x19 =3D &wrapper_arg              \n\
-     ldp     x0, x10, [x19, #16]  // x0 =3D stackaddr, x10 =3D stackbase \=
n\
-     sub     sp, x10, %[CYGTLS]   // sp =3D stackbase - (CYGTLS)       \n\
-     mov     fp, xzr              // clear frame pointer (x29)       \n\
-     mov     x1, xzr              // x1 =3D 0 (dwSize)                 \n\
-     mov     x2, #0x8000          // x2 =3D MEM_RELEASE                \n\
-     bl      VirtualFree          // free original stack             \n\
-     ldp     x19, x0, [x19]       // x19 =3D func, x0 =3D arg            \=
n\
-     blr     x19                  // call thread function            \n"
+     ldp     x20, x21, [%[WRAPPER_ARG]]    // x20 =3D thread func, x21 =3D=
 thread arg \n\
+     ldp     x0, x1, [%[WRAPPER_ARG], #16] // x0 =3D stackaddr, x1 =3D sta=
ckbase \n\
+     sub     sp, x1, %[CYGTLS]         // sp =3D stackbase - (CYGTLS)     =
  \n\
+     mov     fp, xzr                // clear frame pointer (x29)       \n\
+                  // x0 already has stackaddr     \n\
+     mov     x1, xzr                // x1 =3D 0 (dwSize)                 \=
n\
+     mov     x2, #0x8000            // x2 =3D MEM_RELEASE                \=
n\
+     bl      VirtualFree            // free original stack             \n\
+     mov     x0, x21          // Move arg into x0       \n\
+     blr     x20                    // call thread function            \n"
      : : [WRAPPER_ARG] "r" (&wrapper_arg),
          [CYGTLS] "r" (__CYGTLS_PADSIZE__)
-     : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
+     : "x0", "x1", "x2", "x20", "x21", "x29", "memory");
 #else
 #error unimplemented for this target
 #endif
--
2.49.0.windows.1

Thanks,
Thirumalai Nagalingam

--_000_MA0P287MB3082799B10054C7B9C07F51F9F41AMA0P287MB3082INDP_--

--_004_MA0P287MB3082799B10054C7B9C07F51F9F41AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Aarch64-Optimize-pthread_wrapper-by-eliminating-x19-.patch"
Content-Description:
 0001-Aarch64-Optimize-pthread_wrapper-by-eliminating-x19-.patch
Content-Disposition: attachment;
	filename="0001-Aarch64-Optimize-pthread_wrapper-by-eliminating-x19-.patch";
	size=2978; creation-date="Tue, 01 Jul 2025 09:17:31 GMT";
	modification-date="Tue, 01 Jul 2025 10:31:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMTk3ZTM5NDUyZTU0MmQxODgxMmY0MWFjMmEzYWYyZmExNzJiMjcz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogVHVlLCAxIEp1bCAyMDI1IDE0OjQ2OjUyICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQWFyY2g2NDogT3B0aW1pemUgcHRocmVhZF93
cmFwcGVyIGJ5IGVsaW1pbmF0aW5nIHgxOSBhbmQKIHN0cmVhbWxpbmluZyBy
ZWdpc3RlciB1c2FnZQoKLSBSZW1vdmVkIHVzZSBvZiB4MTkgYnkgZGlyZWN0
bHkgbG9hZGluZyB0aGUgdGhyZWFkIGZ1bmMgYW5kIGFyZyB1c2luZyBMRFAg
ZnJvbSBbV1JBUFBFUl9BUkddLCBmcmVlaW5nIHVwIG9uZSBhZGRpdGlvbmFs
IHJlZ2lzdGVyCi0gTG9hZGVkIHRocmVhZCBmdW5jdGlvbiBhbmQgYXJndW1l
bnQgaW50byB4MjAgYW5kIHgyMSBiZWZvcmUgVmlydHVhbEZyZWUgdG8gcHJl
c2VydmUgdGhlaXIgdmFsdWVzIGFjcm9zcyB0aGUgdmlydHVhbCBmcmVlIGNh
bGwKLSBVc2VkIHgxIGFzIGEgdGVtcG9yYXJ5IHJlZ2lzdGVyIHRvIGxvYWQg
c3RhY2sgYmFzZSwgc3VidHJhY3QgQ1lHVExTLCBhbmQgdXBkYXRlIFNQCi0g
TW92ZWQgdGhyZWFkIGFyZ3VtZW50IGJhY2sgaW50byB4MCBhZnRlciBWaXJ0
dWFsRnJlZSBhbmQgYmVmb3JlIGNhbGxpbmcgdGhlIHRocmVhZCBmdW5jdGlv
bgoKU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGly
dW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQog
d2luc3VwL2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjIHwgMjEgKysr
KysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjIGIvd2luc3VwL2N5Z3dp
bi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjCmluZGV4IDU5MmFhZjFhNS4uMTdi
YjYwN2Y3IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3Np
eF90aHJlYWQuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9jcmVhdGVfcG9zaXhf
dGhyZWFkLmNjCkBAIC0xMDMsMTggKzEwMywxOSBAQCBwdGhyZWFkX3dyYXBw
ZXIgKFBWT0lEIGFyZykKICAgLyogU2V0cyB1cCBhIG5ldyB0aHJlYWQgc3Rh
Y2ssIGZyZWVzIHRoZSBvcmlnaW5hbCBPUyBzdGFjaywKICAgICogYW5kIGNh
bGxzIHRoZSB0aHJlYWQgZnVuY3Rpb24gd2l0aCBpdHMgYXJnIHVzaW5nIEFB
cmNoNjQgQUJJLiAqLwogICBfX2FzbV9fIF9fdm9sYXRpbGVfXyAoIlxuXAot
CSAgIG1vdiAgICAgeDE5LCAlW1dSQVBQRVJfQVJHXSAgLy8geDE5ID0gJndy
YXBwZXJfYXJnICAgICAgICAgICAgICBcblwKLQkgICBsZHAgICAgIHgwLCB4
MTAsIFt4MTksICMxNl0gIC8vIHgwID0gc3RhY2thZGRyLCB4MTAgPSBzdGFj
a2Jhc2UgXG5cCi0JICAgc3ViICAgICBzcCwgeDEwLCAlW0NZR1RMU10gICAv
LyBzcCA9IHN0YWNrYmFzZSAtIChDWUdUTFMpICAgICAgIFxuXAotCSAgIG1v
diAgICAgZnAsIHh6ciAgICAgICAgICAgICAgLy8gY2xlYXIgZnJhbWUgcG9p
bnRlciAoeDI5KSAgICAgICBcblwKLQkgICBtb3YgICAgIHgxLCB4enIgICAg
ICAgICAgICAgIC8vIHgxID0gMCAoZHdTaXplKSAgICAgICAgICAgICAgICAg
XG5cCi0JICAgbW92ICAgICB4MiwgIzB4ODAwMCAgICAgICAgICAvLyB4MiA9
IE1FTV9SRUxFQVNFICAgICAgICAgICAgICAgIFxuXAotCSAgIGJsICAgICAg
VmlydHVhbEZyZWUgICAgICAgICAgLy8gZnJlZSBvcmlnaW5hbCBzdGFjayAg
ICAgICAgICAgICBcblwKLQkgICBsZHAgICAgIHgxOSwgeDAsIFt4MTldICAg
ICAgIC8vIHgxOSA9IGZ1bmMsIHgwID0gYXJnICAgICAgICAgICAgXG5cCi0J
ICAgYmxyICAgICB4MTkgICAgICAgICAgICAgICAgICAvLyBjYWxsIHRocmVh
ZCBmdW5jdGlvbiAgICAgICAgICAgIFxuIgorCSAgIGxkcCAgICAgeDIwLCB4
MjEsIFslW1dSQVBQRVJfQVJHXV0gICAgLy8geDIwID0gdGhyZWFkIGZ1bmMs
IHgyMSA9IHRocmVhZCBhcmcgXG5cCisJICAgbGRwICAgICB4MCwgeDEsIFsl
W1dSQVBQRVJfQVJHXSwgIzE2XSAvLyB4MCA9IHN0YWNrYWRkciwgeDEgPSBz
dGFja2Jhc2UJXG5cCisJICAgc3ViICAgICBzcCwgeDEsICVbQ1lHVExTXSAg
CQkgLy8gc3AgPSBzdGFja2Jhc2UgLSAoQ1lHVExTKSAgICAJXG5cCisJICAg
bW92ICAgICBmcCwgeHpyICAgICAgICAgICAgICAJIC8vIGNsZWFyIGZyYW1l
IHBvaW50ZXIgKHgyOSkgICAgCVxuXAorCQkJCQkJIC8vIHgwIGFscmVhZHkg
aGFzIHN0YWNrYWRkcgkJXG5cCisJICAgbW92ICAgICB4MSwgeHpyICAgICAg
ICAgICAgICAJIC8vIHgxID0gMCAoZHdTaXplKSAgICAgICAgICAgICAgCVxu
XAorCSAgIG1vdiAgICAgeDIsICMweDgwMDAgICAgICAgICAgCSAvLyB4MiA9
IE1FTV9SRUxFQVNFICAgICAgICAgICAgIAlcblwKKwkgICBibCAgICAgIFZp
cnR1YWxGcmVlICAgICAgICAgIAkgLy8gZnJlZSBvcmlnaW5hbCBzdGFjayAg
ICAgICAgICAJXG5cCisJICAgbW92ICAgICB4MCwgeDIxICAJCQkgLy8gTW92
ZSBhcmcgaW50byB4MAkJCVxuXAorCSAgIGJsciAgICAgeDIwICAgICAgICAg
ICAgICAgICAgCSAvLyBjYWxsIHRocmVhZCBmdW5jdGlvbiAgICAgICAgIAlc
biIKIAkgICA6IDogW1dSQVBQRVJfQVJHXSAiciIgKCZ3cmFwcGVyX2FyZyks
CiAJICAgICAgIFtDWUdUTFNdICJyIiAoX19DWUdUTFNfUEFEU0laRV9fKQot
CSAgIDogIngwIiwgIngxIiwgIngyIiwgIngxMCIsICJ4MTkiLCAieDI5Iiwg
Im1lbW9yeSIpOworCSAgIDogIngwIiwgIngxIiwgIngyIiwgIngyMCIsICJ4
MjEiLCAieDI5IiwgIm1lbW9yeSIpOwogI2Vsc2UKICNlcnJvciB1bmltcGxl
bWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCi0tIAoyLjQ5LjAud2lu
ZG93cy4xCgo=

--_004_MA0P287MB3082799B10054C7B9C07F51F9F41AMA0P287MB3082INDP_--

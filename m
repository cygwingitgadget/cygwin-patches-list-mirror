Return-Path: <SRS0=0OBO=ZC=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id C96213846E6E
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 20:12:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C96213846E6E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C96213846E6E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750363957; cv=pass;
	b=YY1f3v7KzQKEm6rIBAXncyNFrYccNKxu8ib0OgvPGkeUL3QlgEa+7TS7dxmJo3yiZVUSOgCL8zYfpYp4elmtxBWaKOxHQ4bHZE0zNpeQaz5YLGUjQckF7DcsYeo8DPPXBo8lKXQg23hCqakS3dLrYYwTEnj5MinxToO4f2xVtts=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750363957; c=relaxed/simple;
	bh=bUfaXaEwQCDtdxkClv430004rxW33zqdbiK46aR3nCw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=pdjyiF3bHFP8456zACgPY6AMc7SUAUX5ggxlcJmsPRQhW9BdO4LuxUkdNVQGuDybh4j7Jl0XIO1U4/xEmJY4iCob8MXfM57YYhdX5P5cmFzwj9lqDZn4kMgpxrpQZadh/09v4qoS/oa6tWiWoqrBMsRP5AKnxGTDkCNBr+PdOoc=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C96213846E6E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=0Aov4isF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZEtUDk2HwSUdRKdIwBIlSEZQOSHt8fHTtMmXUlGGGplFSaTYVi67IkThLjpo+fueZVA3+im5AEtMzkXgKGgH/9cjQWT+5Op2x18EwrObyVLn6vO4x2MZCoPicNEvk8nArud3NSWVu+wY18fZg4xBFgeVrmZv3ECi6N6+s9uznIOUlv27q+RjCrCcs+PYjWKV5Lxy8EMEhYGE4vgSvqRuWr+j5mp6UVtVk2p9kpCDz5Gi2nrYDjmOCVkWJ8jAEJZApxGvqfS2ErsBFqCbMQTD/Pm+/3YR6bpv8BAmaKfmVCAh/Mcebj5KTnI1fP5w/8Av+ejHGqfs+2TYSwAmtVo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKgYnP8ANEVanXXZfG9EXjDr1QX3la5NcaQ6ppz2Gqw=;
 b=rDsExLVgfKj2g1kebKXPEHojr9q8TzR8tHgFK4XcNMCxwf5ZXtCkKBVsEHljI7nIZ5qApM5IXWffC7Jf9f18NztNFPLIy/XWhVJhtlj02w5Fp8DhELX9DYqXV58YHsHiiu8GJA3upm5xwaFL9i3275j0FFdK3FUnXkNQYPX4TrjapjmtkxRtfGFtwcxLRVIE/kojqmAO+UQOd8hCleGqfvBafIHHD8yN2bhNQkfWI2H3VZe/LChfJJhnmrmfQQgZL/s5HWyzkF/HPdhwjoRSSLABOtGmzj9Q3oPy7+cDVQ2IONaihFNpYHZ+bw5Rp3rU/yxWVFv7q9zxjUAgvyeZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKgYnP8ANEVanXXZfG9EXjDr1QX3la5NcaQ6ppz2Gqw=;
 b=0Aov4isFpVbloM1Sx2EDVziO9Cv44TZLLcLVASalzgFuMXh2Mqul9JxwHR0jKtOHx1RFT4A9KBlRRLHLeMURHLWN4kWaN0T4qOdqmTQW4ytvM2eR9LoZwZ9uqPOCdYIOBLJr1mcplyzJ45jIMUCP5pRYAVjaggjwWh7yHvM8dM8CgcFff55pbqgJqeeMXX6bTzGYx1C8mjPvPohhrn/xeIDJ/N4NyM5OFPJWxaAu6tYLOBJRdohUnX6TaL1bPrkT4O8Khc3UJr3IhDcyh09aGwOzq//TNQeOHMLHGHTSTMriWTXKym1crgr1E0MofD/6Xihi4COeIgyuwJQO99L+1g==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA0P287MB1739.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 19 Jun
 2025 20:12:32 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%3]) with mapi id 15.20.8857.022; Thu, 19 Jun 2025
 20:12:31 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V2] Cygwin: Aarch64: Add inline assembly pthread wrapper
Thread-Topic: [PATCH V2] Cygwin: Aarch64: Add inline assembly pthread wrapper
Thread-Index: AQHb4VZ8WPp3IMLnNUqFEnOOGcpFyQ==
Date: Thu, 19 Jun 2025 20:12:31 +0000
Message-ID:
 <MA0P287MB30826BECED54F4DFB50996C89F7DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM>
 <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
In-Reply-To: <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA0P287MB1739:EE_
x-ms-office365-filtering-correlation-id: 3b0f8699-3ce0-4364-156d-08ddaf6d9f81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cxV55zlBTtFXUX2CuyHe64Y1gV/rLogF3q4SLkPmuNsIcvAXfRqNodeMyRTE?=
 =?us-ascii?Q?qB+8YaIecuoBGIgFaoqbjtkEfKkWCbVmCSIMEiVajLrvLTiSHUAgtIirLCr0?=
 =?us-ascii?Q?rB3r17H873YpsptRFB0Gfz9iusGGIaHo6uO5rCrgJsROvQ6m/XlAtsF9tb8L?=
 =?us-ascii?Q?fQnDdH6LqRebNEIwDGvF6aBjZN7UfxLMpL3D5pDIfKlU2DhX9A7YPgnklZbU?=
 =?us-ascii?Q?CjO0GdL+9JR/bDH5xpj3crotZv92/VZ9vReBzUOxtX4PBXmFZD4viaqKjFEP?=
 =?us-ascii?Q?qYqr6C27245K/nBXK8J0lML6Q3dlf/lG/oTgeR4MEEHw4bjoXozrnh2GqNBu?=
 =?us-ascii?Q?WWUx1AHF8pEFe6/WtVvHNlIdArQM3O2YMQfJ1S8P0F6hWiiTR8yjWeXGQaOO?=
 =?us-ascii?Q?AcK1pS63ncgueRl/tVxEEs3CWOoPazTRWO0k9/Vs8vp2lLJjmVpQHoFTIwP7?=
 =?us-ascii?Q?CIdVv4Jt/Qn3PcSGxILFxdlUdmvK61QaOcpbIKJFtOpJwnHl4ZenZzYrn11f?=
 =?us-ascii?Q?umLtI78DpDfMVRkf7sWdMRhMQ/aXQyu/5BVGu0NgxuUzptYoKV+6qvf16w9X?=
 =?us-ascii?Q?6tUec0EEZqBPrZDXbnZNOWMZhyCHKlkT4l3VQfPMPNPbg76POFYlKZfkSbMA?=
 =?us-ascii?Q?GXmSGCW7uhzSt5WjA8vsKJ+GAr8jkJTUjl5lLCNbZ38/XcE/Ajp2JFIxCHue?=
 =?us-ascii?Q?hct7aOiil1QcYyX3StLr7+ugV68YXO5FJGwX4Nw8luBTZGxqaJ8sibMCBcme?=
 =?us-ascii?Q?4zO8QTyi76/0LbjiDBn3oPSyJFSY4Kz40cN/swNt6/hJFQPF9t7W5uOqDbt7?=
 =?us-ascii?Q?VVyRp2wAsmlqTM4N0wkaCiJ2pVzUK4jVVslVnxoaB/Hxr9A8oAwNYB8xUU2q?=
 =?us-ascii?Q?SlS+l5rVrQ6Q3yVt6CypzZhjknauz0MkJfwfPHUVqwjYG7tyeBhi8ThollJc?=
 =?us-ascii?Q?kXAeiGmacIc/f6OZRRGgali9bKjSvgrgQ5lmvlYbb5fwcGFT2+WUSBaHHe9q?=
 =?us-ascii?Q?0PoGaLbtP88rE96b0ih4pkykyrPnbPvKIyYQRBA8cq61GBMpzwrqX2ufeMkT?=
 =?us-ascii?Q?+ZJL2pu0WrrtPFOM8cYwLon9Fe5u2YLwdAEq/0N988zltLlfcaSkJO1SCtPR?=
 =?us-ascii?Q?jmzE2L+YX9ORxv6k6UJ7rwAoMc8ImXxLWHNGv9O9mlYNdi5HPqGKCVOIc2IL?=
 =?us-ascii?Q?XOn9O3lRCLSWa6Eu1nH/jROlT61f8xa8PBIwNBBT1gkrzdXtF89hISjRXknc?=
 =?us-ascii?Q?2/ewpJviKB+D75TLQC8GnK/J6gDjv4nHM0SBebMxpJWVdAHfHSFbqp4g8Ei2?=
 =?us-ascii?Q?mRI1uXoMIpv5UlQm4bERi667WUQ+3KWHyTpkAonAIWlcAgD8W3EQhCIuV2yM?=
 =?us-ascii?Q?96Jqqyeb3DU7Tdb07iZCtEhrWGPdf7hXd0r2eiPYZDb09pRzRHWMCL5VPSJA?=
 =?us-ascii?Q?Iof5Bz2HngpPj/eqAURBqmwkN1VPyHmjFjr1cM8VO4M4xLf2/EpON/e0PMBX?=
 =?us-ascii?Q?id9tqjsqqg5kaWQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vu1bTZM/YUdh8veTVhHIWLZmFATJWkhTbu0MT+Ykl0MbxO74jtApHyfA/UWx?=
 =?us-ascii?Q?iOtwcCxPhvyPO732TC1NRwizGMma8azgpABZYHz511kcozmRo3iqQmNDnl1l?=
 =?us-ascii?Q?oLGje8+PU/G7YpM1pCw6neC1LPcuFZtb1LaRvmFyWAvLwZYYW+d5lW8h7d0W?=
 =?us-ascii?Q?DmqpsiXx+ME+NoxFqnStxarNFpBJceDNp3x+Sb90naBKM5awop5ax+sFmV7V?=
 =?us-ascii?Q?g6AVRs/pnMTTrPkuLcipFOJWEYG/2XwsRz8oPYlJDpjzjXtVjI1aZ4IzPTLE?=
 =?us-ascii?Q?CafmvljwC3vHu8oI4CrLKcum0phKcSOLk4k0OgwVdn7tRcyJFCzx791jiV+q?=
 =?us-ascii?Q?pkdXP6CZ4F29pJ+hPimuLUBIZVPcznREeUqdvrsAr6rUkvMEBVgoEbpJ2Mpw?=
 =?us-ascii?Q?dvVLd17tsNBL18HyX4bduQBHvhFtFYmUf5AFhlhccq7c741pus6nesmoGYNJ?=
 =?us-ascii?Q?9HrBCZQnptLW6k+9nSGWGY9QGg86BzaQp8vIy1EceLnrjKhyhYy4/5CCDK3G?=
 =?us-ascii?Q?F89DAi3a8VpO/6N5TfbJlYP0gQNhxUhlU5c+cpO8Yi6oM+GjShKDmIxIyDkF?=
 =?us-ascii?Q?jn4EVuOml2NCxO7+4SHukqv91sX6JLvecS88yUUvu5Sa5dezEuq+KnJr6sz9?=
 =?us-ascii?Q?z51ZdKW1MNgMygQ7ViydHVh91cczT7dHM8ZUFznp32p8W3oyqBq3xN4gGGUM?=
 =?us-ascii?Q?vom5TT03//Dps4ompRvTtIz4L933KNTBN+EGONBWYbuUA7IEy04hIcqEpvaT?=
 =?us-ascii?Q?DipTXaf+aGxoecylM20eFvG9TLNPJP1cr/dCYvj3lnrroN+e1+uWWXNUx6T/?=
 =?us-ascii?Q?5Kko7OGfC7ztsfrMkA9QIXidIL/wNHspKvyLz7P4BpiMfy/IynYn6c9xMqXX?=
 =?us-ascii?Q?S2pQlpcHFpCM9Co3zUBD1oL3yibDrtZU0sXV0Z40cLiojVm2tVCoEhxDJ42H?=
 =?us-ascii?Q?1vqJKbdYGe1kl/10akLAuhDjz4EHuK4CZyaXqPzGafheNJaQFRL1x6BI6lRX?=
 =?us-ascii?Q?P5UAytx5qRdjPAZ6Lq5/ChGzatACRUUjiLxUhgbr+bpjr5LpmV/zIm+gq+Mh?=
 =?us-ascii?Q?2AisYYX/3yIZFruBGW0zWKjaqsZFl/0FxEx4xegeU0/94YFDoJHrW5cGhlkE?=
 =?us-ascii?Q?goyf3eDh51g9JDqoJViVuMQ76l2b9qjXEN4YIQgty8cxWSW8l7c3LNbs/Eyn?=
 =?us-ascii?Q?MxqEOFjxwc4+ODRLry4JKEHxz7xlZMrye5irUKaEvyHHZxlmgDL2292Y3pdL?=
 =?us-ascii?Q?6Q+gVu4Q0F3F/2dC/2t61KRFTyGqadA3ygUNb3yB2jTEIWCIItFXcq/23tue?=
 =?us-ascii?Q?a7RONWZCYXKWNoPqzpLAln21Ud+bEQ6pwSMYRjeZL3Pn/qHB6/nGan8KqUFW?=
 =?us-ascii?Q?CndCPx6uO/CcigRVhGdyyTIteza6z+gLlBchAbYHU6fsXeY69A+5zO2hI+F1?=
 =?us-ascii?Q?MbPvo3p6yXd/7aVuuIUg68/2YQID3zXv2/m1v5kLqfTG1yWWmDSjlIQ9WlBt?=
 =?us-ascii?Q?4FkcKUSs5V8qeIS4gvIc+tcrDOg26m78cbqe86IFmOtE6k92GG+fZ+tWL2nf?=
 =?us-ascii?Q?7tQcyDbKhkbvM8No9oGkswd9OoU9IbblnCop78cnYYEMfG+n6vSXl54OwC6N?=
 =?us-ascii?Q?ONvJyLXwZmuk3RSCOyrGiMu9vvq6vTvxPJltnBuHvMzq?=
Content-Type: multipart/mixed;
	boundary="_002_MA0P287MB30826BECED54F4DFB50996C89F7DAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0f8699-3ce0-4364-156d-08ddaf6d9f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 20:12:31.8348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9Rl6h8UJK7ghBL0eGTGWCb3VBdoBKPe/3hriUwajiDYGMQmRFlHDk229m2fW9dx23b/jADNxSZv9Zvo5zRZRbvOnlIbJxPj0AKYIJcIQIN8V/8Scq4wf8sJv1JniNfOL13+k/UIRKkY4ziJomLPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1739
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_MA0P287MB30826BECED54F4DFB50996C89F7DAMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the feedback.
As per your request, I've included the updated patch v2 both inline below a=
nd as an attachment for easier review.

Q1 - 32-byte shadow area on AArch64
You're correct - unlike x64 Windows, the AArch64 (ARM64) calling convention=
 does not mandate a 32-byte shadow space. In my original patch, I included =
it to maintain parity with x64 behaviour. I re-tested without it and Cygwin=
 `pthread` tests pass on ARM64.
So, in this version, I've removed the shadow space allocation to better ali=
gn with standard AArch64 conventions.=20

Q2 - `mov x0, sp` to `mov x0, [x19, #16]`
You're right again. For the `VirtualFree` call, `x0` should point to the or=
iginal OS-provided stack (`stackaddr`), not the current `sp`.
I've corrected it as suggested. Thanks again for catching that.

Updated Patch (Inline):

From 0807c2681ac8e905a887a357a8334ff8ecdc3a54 Mon Sep 17 00:00:00 2001
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Date: Thu, 19 Jun 2025 21:19:41 +0530
Subject: [PATCH] Aarch64: Add inline assembly pthread wrapper

This patch adds AArch64-specific inline assembly block for the pthread
wrapper used to bootstrap new threads. It sets up the thread stack,
adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original
stack via VirtualFree, and invokes the target thread function.
---
 winsup/cygwin/create_posix_thread.cc | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_po=
six_thread.cc
index 3fcd61707..d0d3096b2 100644
--- a/winsup/cygwin/create_posix_thread.cc
+++ b/winsup/cygwin/create_posix_thread.cc
@@ -75,7 +75,7 @@ pthread_wrapper (PVOID arg)
   /* Initialize new _cygtls. */
   _my_tls.init_thread (wrapper_arg.stackbase - __CYGTLS_PADSIZE__,
 		       (DWORD (*)(void*, void*)) wrapper_arg.func);
-#ifdef __x86_64__
+#if defined(__x86_64__)
   __asm__ ("\n\
 	   leaq  %[WRAPPER_ARG], %%rbx	# Load &wrapper_arg into rbx	\n\
 	   movq  (%%rbx), %%r12		# Load thread func into r12	\n\
@@ -99,6 +99,23 @@ pthread_wrapper (PVOID arg)
 	   call  *%%r12			# Call thread func		\n"
 	   : : [WRAPPER_ARG] "o" (wrapper_arg),
 	       [CYGTLS] "i" (__CYGTLS_PADSIZE__));
+#elif defined(__aarch64__)
+  /* Sets up a new thread stack, frees the original OS stack,
+   * and calls the thread function with its arg using AArch64 ABI. */
+  __asm__ __volatile__ ("\n\
+	   mov     x19, %[WRAPPER_ARG]           // x19 =3D &wrapper_arg         =
 \n\
+	   ldr     x10, [x19, #24]               // x10 =3D wrapper_arg.stackbase=
 \n\
+	   sub     sp, x10, %[CYGTLS]            // sp =3D stackbase - (CYGTLS)  =
 \n\
+	   mov     fp, xzr                       // clear frame pointer (x29)   \=
n\
+	   mov     x0, [x19, #16]                // x0 =3D wrapper_arg.stackaddr =
 \n\
+	   mov     x1, xzr                       // x1 =3D 0 (dwSize)            =
 \n\
+	   mov     x2, #0x8000                   // x2 =3D MEM_RELEASE           =
 \n\
+	   bl      VirtualFree                   // free original stack         \=
n\
+	   ldp     x19, x0, [x19]                // x19 =3D func, x0 =3D arg     =
   \n\
+	   blr     x19                           // call thread function        \=
n"
+	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
+	       [CYGTLS] "r" (__CYGTLS_PADSIZE__)
+	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
 #else
 #error unimplemented for this target
 #endif
--=20
2.49.0.windows.1


Thanks,
Thirumalai

-----Original Message-----
From: Jeremy Drake <cygwin@jdrake.com>=20
Sent: 18 June 2025 23:22
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Aarch64: Add inline assembly pthread wrapper

On Thu, 5 Jun 2025, Thirumalai Nagalingam wrote:

> Hello,
>
> Please find my patch attached for review.

Please either send patches via something like git send-email that puts the =
patch in the body, or if you can't send patches in that way without some ma=
il software mangling them, please include the patch in the body of the emai=
l in addition to attaching it, for easier review.

>
> This patch adds AArch64-specific inline assembly block for the pthread=20
> wrapper used to bootstrap new threads. It sets up the thread stack,=20
> adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original=20
> stack via VirtualFree, and invokes the target thread function.
>
> Thanks & regards
> Thirumalai Nagalingam
>


> From c897d7361356c73b5837afa466f78a58520c1e9e Mon Sep 17 00:00:00 2001
> From: Thirumalai Nagalingam=20
> <thirumalai.nagalingam@multicorewareinc.com>
> Date: Thu, 5 Jun 2025 00:30:48 -0700
> Subject: [PATCH] Aarch64: Add inline assembly pthread wrapper
>
> This patch adds AArch64-specific inline assembly block for the pthread=20
> wrapper used to bootstrap new threads. It sets up the thread stack,=20
> adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original=20
> stack via VirtualFree, and invokes the target thread function.
> ---
>  winsup/cygwin/create_posix_thread.cc | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/create_posix_thread.cc=20
> b/winsup/cygwin/create_posix_thread.cc
> index 8e06099e4..b1d0cbb43 100644
> --- a/winsup/cygwin/create_posix_thread.cc
> +++ b/winsup/cygwin/create_posix_thread.cc
> @@ -75,7 +75,7 @@ pthread_wrapper (PVOID arg)
>    /* Initialize new _cygtls. */
>    _my_tls.init_thread (wrapper_arg.stackbase - __CYGTLS_PADSIZE__,
>  		       (DWORD (*)(void*, void*)) wrapper_arg.func); -#ifdef=20
> __x86_64__
> +#if defined(__x86_64__)
>    __asm__ ("\n\
>  	   leaq  %[WRAPPER_ARG], %%rbx	# Load &wrapper_arg into rbx	\n\
>  	   movq  (%%rbx), %%r12		# Load thread func into r12	\n\
> @@ -99,6 +99,23 @@ pthread_wrapper (PVOID arg)
>  	   call  *%%r12			# Call thread func		\n"
>  	   : : [WRAPPER_ARG] "o" (wrapper_arg),
>  	       [CYGTLS] "i" (__CYGTLS_PADSIZE__));
> +#elif defined(__aarch64__)
> +  /* Sets up a new thread stack, frees the original OS stack,
> +   * and calls the thread function with its arg using AArch64 ABI. */
> +  __asm__ __volatile__ ("\n\
> +	   mov     x19, %[WRAPPER_ARG]           // x19 =3D &wrapper_arg       =
     \n\
> +	   ldr     x10, [x19, #24]               // x10 =3D wrapper_arg.stackba=
se   \n\
> +	   sub     sp, x10, %[CYGTLS]            // sp =3D stackbase - (CYGTLS =
+ 32)\n\
> +	   mov     fp, xzr                       // clear frame pointer (x29)  =
   \n\
> +	   mov     x0, sp                        // x0 =3D new stack pointer   =
     \n\

This seems wrong.  Shouldn't it be
           mov     x0, [x19, #16]                // x0 =3D wrapper_arg.stac=
kaddr

> +	   mov     x1, xzr                       // x1 =3D 0 (dwSize)          =
     \n\
> +	   mov     x2, #0x8000                   // x2 =3D MEM_RELEASE         =
     \n\
> +	   bl      VirtualFree                   // free original stack        =
   \n\
> +	   ldp     x19, x0, [x19]                // x19 =3D func, x0 =3D arg   =
       \n\
> +	   blr     x19                           // call thread function       =
   \n"
> +	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
> +	       [CYGTLS] "r" (__CYGTLS_PADSIZE__ + 32) // add 32 bytes shadow=20
> +space

I asked this on another patch, but is the 32-byte shadow area actually part=
 of the aarch64 calling convention, or is this just following what x64 was =
doing (where it is part of the calling convention)

> +	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
>  #else
>  #error unimplemented for this target
>  #endif
> --
> 2.34.1
>

--_002_MA0P287MB30826BECED54F4DFB50996C89F7DAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch"
Content-Description: 0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch
Content-Disposition: attachment;
	filename="0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch"; size=2600;
	creation-date="Thu, 19 Jun 2025 19:52:54 GMT";
	modification-date="Thu, 19 Jun 2025 20:12:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwODA3YzI2ODFhYzhlOTA1YTg4N2EzNTdhODMzNGZmOGVjZGMzYTU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogVGh1LCAxOSBKdW4gMjAyNSAyMTox
OTo0MSArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEFhcmNoNjQ6IEFkZCBpbmxpbmUgYXNzZW1ibHkg
cHRocmVhZCB3cmFwcGVyCgpUaGlzIHBhdGNoIGFkZHMgQUFyY2g2NC1zcGVjaWZpYyBpbmxpbmUg
YXNzZW1ibHkgYmxvY2sgZm9yIHRoZSBwdGhyZWFkCndyYXBwZXIgdXNlZCB0byBib290c3RyYXAg
bmV3IHRocmVhZHMuIEl0IHNldHMgdXAgdGhlIHRocmVhZCBzdGFjaywKYWRqdXN0cyBmb3IgX19D
WUdUTFNfUEFEU0laRV9fIGFuZCBzaGFkb3cgc3BhY2UsIHJlbGVhc2VzIHRoZSBvcmlnaW5hbApz
dGFjayB2aWEgVmlydHVhbEZyZWUsIGFuZCBpbnZva2VzIHRoZSB0YXJnZXQgdGhyZWFkIGZ1bmN0
aW9uLgotLS0KIHdpbnN1cC9jeWd3aW4vY3JlYXRlX3Bvc2l4X3RocmVhZC5jYyB8IDE5ICsrKysr
KysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNj
IGIvd2luc3VwL2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjCmluZGV4IDNmY2Q2MTcwNy4u
ZDBkMzA5NmIyIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQu
Y2MKKysrIGIvd2luc3VwL2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjCkBAIC03NSw3ICs3
NSw3IEBAIHB0aHJlYWRfd3JhcHBlciAoUFZPSUQgYXJnKQogICAvKiBJbml0aWFsaXplIG5ldyBf
Y3lndGxzLiAqLwogICBfbXlfdGxzLmluaXRfdGhyZWFkICh3cmFwcGVyX2FyZy5zdGFja2Jhc2Ug
LSBfX0NZR1RMU19QQURTSVpFX18sCiAJCSAgICAgICAoRFdPUkQgKCopKHZvaWQqLCB2b2lkKikp
IHdyYXBwZXJfYXJnLmZ1bmMpOwotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2
XzY0X18pCiAgIF9fYXNtX18gKCJcblwKIAkgICBsZWFxICAlW1dSQVBQRVJfQVJHXSwgJSVyYngJ
IyBMb2FkICZ3cmFwcGVyX2FyZyBpbnRvIHJieAlcblwKIAkgICBtb3ZxICAoJSVyYngpLCAlJXIx
MgkJIyBMb2FkIHRocmVhZCBmdW5jIGludG8gcjEyCVxuXApAQCAtOTksNiArOTksMjMgQEAgcHRo
cmVhZF93cmFwcGVyIChQVk9JRCBhcmcpCiAJICAgY2FsbCAgKiUlcjEyCQkJIyBDYWxsIHRocmVh
ZCBmdW5jCQlcbiIKIAkgICA6IDogW1dSQVBQRVJfQVJHXSAibyIgKHdyYXBwZXJfYXJnKSwKIAkg
ICAgICAgW0NZR1RMU10gImkiIChfX0NZR1RMU19QQURTSVpFX18pKTsKKyNlbGlmIGRlZmluZWQo
X19hYXJjaDY0X18pCisgIC8qIFNldHMgdXAgYSBuZXcgdGhyZWFkIHN0YWNrLCBmcmVlcyB0aGUg
b3JpZ2luYWwgT1Mgc3RhY2ssCisgICAqIGFuZCBjYWxscyB0aGUgdGhyZWFkIGZ1bmN0aW9uIHdp
dGggaXRzIGFyZyB1c2luZyBBQXJjaDY0IEFCSS4gKi8KKyAgX19hc21fXyBfX3ZvbGF0aWxlX18g
KCJcblwKKwkgICBtb3YgICAgIHgxOSwgJVtXUkFQUEVSX0FSR10gICAgICAgICAgIC8vIHgxOSA9
ICZ3cmFwcGVyX2FyZyAgICAgICAgICBcblwKKwkgICBsZHIgICAgIHgxMCwgW3gxOSwgIzI0XSAg
ICAgICAgICAgICAgIC8vIHgxMCA9IHdyYXBwZXJfYXJnLnN0YWNrYmFzZSBcblwKKwkgICBzdWIg
ICAgIHNwLCB4MTAsICVbQ1lHVExTXSAgICAgICAgICAgIC8vIHNwID0gc3RhY2tiYXNlIC0gKENZ
R1RMUykgICBcblwKKwkgICBtb3YgICAgIGZwLCB4enIgICAgICAgICAgICAgICAgICAgICAgIC8v
IGNsZWFyIGZyYW1lIHBvaW50ZXIgKHgyOSkgICBcblwKKwkgICBtb3YgICAgIHgwLCBbeDE5LCAj
MTZdICAgICAgICAgICAgICAgIC8vIHgwID0gd3JhcHBlcl9hcmcuc3RhY2thZGRyICBcblwKKwkg
ICBtb3YgICAgIHgxLCB4enIgICAgICAgICAgICAgICAgICAgICAgIC8vIHgxID0gMCAoZHdTaXpl
KSAgICAgICAgICAgICBcblwKKwkgICBtb3YgICAgIHgyLCAjMHg4MDAwICAgICAgICAgICAgICAg
ICAgIC8vIHgyID0gTUVNX1JFTEVBU0UgICAgICAgICAgICBcblwKKwkgICBibCAgICAgIFZpcnR1
YWxGcmVlICAgICAgICAgICAgICAgICAgIC8vIGZyZWUgb3JpZ2luYWwgc3RhY2sgICAgICAgICBc
blwKKwkgICBsZHAgICAgIHgxOSwgeDAsIFt4MTldICAgICAgICAgICAgICAgIC8vIHgxOSA9IGZ1
bmMsIHgwID0gYXJnICAgICAgICBcblwKKwkgICBibHIgICAgIHgxOSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC8vIGNhbGwgdGhyZWFkIGZ1bmN0aW9uICAgICAgICBcbiIKKwkgICA6IDogW1dS
QVBQRVJfQVJHXSAiciIgKCZ3cmFwcGVyX2FyZyksCisJICAgICAgIFtDWUdUTFNdICJyIiAoX19D
WUdUTFNfUEFEU0laRV9fKQorCSAgIDogIngwIiwgIngxIiwgIngyIiwgIngxMCIsICJ4MTkiLCAi
eDI5IiwgIm1lbW9yeSIpOwogI2Vsc2UKICNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRh
cmdldAogI2VuZGlmCi0tIAoyLjQ5LjAud2luZG93cy4xCgo=

--_002_MA0P287MB30826BECED54F4DFB50996C89F7DAMA0P287MB3082INDP_--

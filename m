Return-Path: <SRS0=0OBO=ZC=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id D43A53850C7C
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 20:51:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D43A53850C7C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D43A53850C7C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750366288; cv=pass;
	b=JINi3Hn6nribJI5jRYaVRwj80QkoQGqWYdD829hi8XAGwI4Bojhq2P/v1sUs6CH1uszXvWjDmROaNMQNCxuDub7UV/w5CKeGuDwJWWYe4f6KjKP7NhvXAACWKiEgbeZVK38wPCaZGNMQ5tXDwWwZxWbnnjFQlURSDf8VI4dNl0w=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750366288; c=relaxed/simple;
	bh=tgpuVLz0dyvufZeuLsgNQv/n+SWUiMUe3p/KUvZQ1lE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=J/FaBw6Z+gmqc1y9cTgQWt4F8W6BBYIdaBWnm1+sYhBjKYhncqctjycj7/lO+fhl3lGxxdrLlNRrK0XKiytW6CJcqM03sJbgOQX3aS8p5OXz3GbkckQIKAasmfmldxNaRadxQu6Xm79OKFTlbsLd/Zl5r0Jo3AeNkFhQp9lOv40=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D43A53850C7C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=dks/OUvF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzgVMDpRjkARpYmqQqdL8e5i6pn4196o2s14K0WbvX4rPFpYqBHRj8DkSGbvZ1avNqyFis0FJEEIPm/721hKvUI1rlkH+I9vT25JtRGoDMdl/kEsX/M08KPslLgMpb2e86EGnMgKTHhOppJSYvXLuh/U0oZvUgt8k3LxxfqahoHF+e7Rws87p8ATZkBiAd+/n7+42b5RVEpLMOlL6fuHjb2ulai5r+DFqtSjLas7xcV+bmHxvz9eQCGpWTjLvO/n1KtA2avHN4SrIxa+E0WPD9yfnymF2XP6j07U7ppI5fdU6oversfH9yvajXhx2+/z+S5iSGNxwpkCwL5sF8Dh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+Z8knNeZ8eMTpCURceNUZVRxePMHVFNEvwbY/TWAGE=;
 b=fLKUPNfPYwSIrf8maWzqK2XA7PLs3LoOpYqwx1vZqfX0ezbttW7azHP/+earHs63XEjRxam9IW7RGsvA3/9ETWl1X9u4m4jlgsgk4VIwICogc8qbeJyP/JiuuC1VckNlR88bQWjFaj+2YedFgUnYbEr1CXOYTFoxy6y8SKSr/H17u3t1jLtHDIAEb6iRhne8mzZmZdYwEctYDP1NpzscStBRShN33UJYmxjDlZnY3e2GDgAkW2kKYI5R7UY9mx43+xVJD7s9Pq9bKcLwZwapotiJg5fV1qD/VVAU39upLwsMbH4Y6y1xwKflPIAho7k+XAtZWyzlapGwph/MfR7K/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+Z8knNeZ8eMTpCURceNUZVRxePMHVFNEvwbY/TWAGE=;
 b=dks/OUvFwSQyaNwPhIyGzfssvdxgSH8VoH1k8vGZYdezkqYiEdJzDgon8lje1gGldkH3I5Z6Cn6LQSzs+UI9yytW+ODpYtpYlqNqxYHhH6GgP5sCM6lCrw2+gW4ua38oAPFySiZc983CjAPytOhkh6TILbd4XR0ORBTdQSR1cSLrtBtEC36mg586lhg2syLrM17c2T4hBDTkUCQ4aakUMIZH4fo5uh7Bzq11cKX/tVUstcKx8Itvw2HJJLXlTwILBFjM6S21YUlgKSS9Ee5eksxkFW+zm49TB4wq4kG+ZTZ2H4XxYxyVDSQa1IzfPvkZiWImbV8ZDjA4pPTYRfKtPQ==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN0P287MB0134.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 20:51:23 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%3]) with mapi id 15.20.8857.022; Thu, 19 Jun 2025
 20:51:22 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V4] Cygwin: Aarch64: Add inline assembly pthread wrapper
Thread-Topic: [PATCH V4] Cygwin: Aarch64: Add inline assembly pthread wrapper
Thread-Index: AQHb4VvqSVUYuG2+C0CI0pTcCk+6Sg==
Date: Thu, 19 Jun 2025 20:51:22 +0000
Message-ID:
 <MA0P287MB30828CF024D946D3F575279B9F7DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM>
 <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
  <MA0P287MB30826BECED54F4DFB50996C89F7DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <e898c913-6728-8c0a-3f06-4481c1551853@jdrake.com>
In-Reply-To: <e898c913-6728-8c0a-3f06-4481c1551853@jdrake.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN0P287MB0134:EE_
x-ms-office365-filtering-correlation-id: 372460cd-9847-4db5-d04e-08ddaf730ce3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QkOjCCE/Ta0LGipLWkYdEAXpv5f8ktwBr9y7zhdb2HGpfrR2UpQAfRD1n9tg?=
 =?us-ascii?Q?iovQqbGgiTSe/xgK5Ig3uG+OkEKWb3pBmYZBrQuu8R7lWGVzbLsUH5k7Db2v?=
 =?us-ascii?Q?On/BGwjrnVlc7+OOD3UWqFyV/3ih4HB8LeOWPp1lMssG7vGvy4ygqzbV1mKi?=
 =?us-ascii?Q?sU6wX6Cmz+yB2ezV0YxzuSpKoATVbyYTV9MHheXQU7L+Ccr8wiHJpua+zcDs?=
 =?us-ascii?Q?wg75v7Y9AH4uxO/xuRLKYH1DC4DSrbwxsUUaN92IojMyKcGcG6jt8cPROfe2?=
 =?us-ascii?Q?UaGIdVmxOcNts5qQFDoPmyTCvmPqoImm4edrNsCcdgHv5DVyLE7f6Bi250ZZ?=
 =?us-ascii?Q?r0VsVzA8SNQDGdFX5o4c1DsVB0pv2A8bOoBnqvUBL7sVlYkJk3LqXd6Jz99T?=
 =?us-ascii?Q?TeBQy/I7t1d3iw8UVmuE6lWuAQjuRVFsmaG2KR9raFY+at2vaFsZ/xoSeisz?=
 =?us-ascii?Q?KNKWLUMl+zD3Odx1u2vrNuMcI2coKQbQjfZ7lcW6CXOgPuOSv8W/CC8aUFf4?=
 =?us-ascii?Q?VXc3TnSZkhmCjDh4HMp0tlY9eyYlJ8BqsNf+blfvKMalnNl2egqSyOTtN2c3?=
 =?us-ascii?Q?hhAqa3nQ0Opk18+PVfKSfNSk10KO6vrs5izwFkG8OBpaRqwIYa1cV6X4YPdc?=
 =?us-ascii?Q?MHdTxMFv6AyzODSwYgP/QS4L5Mut602ilYZo3ukQ6KwBXEBQZeaCYnwWqsNe?=
 =?us-ascii?Q?tQLRxfXTUdezuPJU4N8C6xyWtXuQqRk8Gd/qedkfMCqtg9F939fGhmY2CEab?=
 =?us-ascii?Q?+AQj9mhj9nI5a5ATQvKDp9wgWdVDP0tjTOUluGvBuTZhNVrIIaB2MONrpuHY?=
 =?us-ascii?Q?f19Rk4Bzrln25TJ1FxRHovbugLvNbtucbHSwDXBaZbHr4wZxPR6wLO6jyP4+?=
 =?us-ascii?Q?LkYsh0ah4Wl/qL17Gof88FHBL4OztnM1nv0sxyBXX3rs6+YeDZ8R4kmM7KU3?=
 =?us-ascii?Q?L8mNkDAMh3fx9ILfyUI6DxpozpdSEKXSQyo9IxrNoyFbvu6Sy3MGCIB6ob+m?=
 =?us-ascii?Q?vUSGfws4vUbIfN+1boPMtOoaw8P2/I++4PcSPReok3PsFJX78vqx8Hp08oaC?=
 =?us-ascii?Q?n6gV7yCSRMpCQ2aNo1TRzCDTKl2UsLzH927fGa0VRSdVR4S7Oz9PcH21+m/h?=
 =?us-ascii?Q?1mutD5oKIvs0VxJjPkGrFDbQPPL+sdlNHIaQQpzuWKvEULmp+JDu4GqyI0Ku?=
 =?us-ascii?Q?7dxRU2CW4icHkPcwVhRyJpD/YFooiKF0/imoPAxJtdxwI7f0EbZsFmHPuCgx?=
 =?us-ascii?Q?UTfy5GKUut4tdPDjx6xaJs0N6figjms0v07BBY40POp8kTLQfhkM8YpvCipY?=
 =?us-ascii?Q?isUpSG82no9Ymlb1RVW9kOP698TWXDRUBkdi9qB8A2erGhXB0atX87EIQHXW?=
 =?us-ascii?Q?wgFPWFu2uOL4IQtJ+IJUZnDDp1V46JepqnXU+xfHHM3tBHWFmNPi69zkJM9s?=
 =?us-ascii?Q?A6hmkco9tcyc+o3evUbaBJlSYCzIFI7zn7GrlVDAm00xT39DifwZ6TpQlgvd?=
 =?us-ascii?Q?fYkGgNwB6IPjrQg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LMSzxevUW16PbmZnSoYC0BMbqJnZ2aBnXg04UtbvKa5cJpryW/MVtIvV701g?=
 =?us-ascii?Q?h+FG4yWRTDVWQs8MiXbnkOMCllBqiKTEXdRFhaWUESGRdjQ8nB4Ja2M91Cdh?=
 =?us-ascii?Q?VrmM3nN/MoVPNRJaYg640gl7iHTtYqhpWJk2S2DVCTeyRpftdfKvXig7+4NY?=
 =?us-ascii?Q?QQL1eAEghxgBHe7jT2qfD7+BNwRsmEz0KXqxC79XwfpBQTLlQvmqvC2mCfAi?=
 =?us-ascii?Q?H4HGjiPGpDfL3FiBkQGn4/Slgithr3JFaRQbWvvxRmPjIuHHwutBDG32ccGa?=
 =?us-ascii?Q?Oo2p0ARNa3YtoHVr5MJU4BmoUEfkZntwSmeQxmomAeoRRzSKbpc58UG4tONw?=
 =?us-ascii?Q?/KNBH1h486xpqLm5MVlN+CfS5BIlNavTwy2P+JIDmo3Ss6vsgKRVZgm0dSkU?=
 =?us-ascii?Q?a+ujewQjzh28TAHbEGDWWteHCG1BzYZGL7D/CRR34IzA544dZCMca6onI/ax?=
 =?us-ascii?Q?J518eFQHrpjyAha+44sicbC23GoxGZfkhuHYRCc7ToVq1xe/IQLgnJpWEWNd?=
 =?us-ascii?Q?Jn62XSjm/sMei7Rz6pGbYKg7tYDdLumYbDXlZyTZULYDAJbrVZDmoW/Zg0bF?=
 =?us-ascii?Q?ZvsbNdZH0qktv8lnchzhaLqr8OIrQ1m/AugENT4UTaH4Ud/M92Pt/qYHX7sg?=
 =?us-ascii?Q?t3yYlp0EDtsAZtK7UXRZYbH1dI8tujxUKNOi1Ox+v4LgprfutkoND/vwK0gS?=
 =?us-ascii?Q?/6z+dlPFWipGdcpyq9kQXdpSiN4kf8xOzV/fbJ0tsL62EtvYV8DljqEqSO5R?=
 =?us-ascii?Q?PBJxDNmsBqNpswSrarRc0HY8NjIjV5ddU3bI8ZMCipHTAd32qLkn/JvfBhnp?=
 =?us-ascii?Q?jLhnuaDtvJYH+hjNKrzDje+1mATzCKi6X/HpANej6YhhtqtDf8zgF8k1NBC2?=
 =?us-ascii?Q?QoUHm+QeqFi4PjLzp4TbRpn7cyUhEjgECuT+XoKCspbHU8TZEopEqcZF0o87?=
 =?us-ascii?Q?PnOWcYMbrXLDC3+25Z9eJJanKhZY7/1kP+im5eNeJcVwFiNv/pWBR+YlVqKM?=
 =?us-ascii?Q?KBEjQSbgtewklJnpy9mSwrMpf49zKrNQ0bsj2hP1LiDhuhk7dN0ePvZTPALT?=
 =?us-ascii?Q?Jc6tw7bcjWkppbNmBiI8ERI5Ujli2v4NBCBwtfcaqgndCUOpL9Xhb+kgkGce?=
 =?us-ascii?Q?3dUTeCDZ0fx9yk8d9o1CR6BJPDRvdSrKGZ7lIpBsov0e7Tn5NaXjdO0eiRfk?=
 =?us-ascii?Q?fZtLV8SfPxVBBq/1bqP52bYgGA4+Py+esp2lY0QnCj+Q8IsxGX6N70kq4RRo?=
 =?us-ascii?Q?8Nub6UTJDeQ00fXKU0sf9fMNgPRsCuFWnR8GvoNKprMm5v3WaeJCIqtdhqBT?=
 =?us-ascii?Q?txvDOlMf3CwMytNv+Qf53QQq9A7NG+z/j3zQT0rMKq7PlrBSfIXTWns32ym/?=
 =?us-ascii?Q?rKj1h4AeIU4oib1jXmD8mKet6lSS98XlX0Q0HkfDMYY9sRKFSnAFZfOHgwuf?=
 =?us-ascii?Q?En2UyC4MGEpCIExjxFos2X+cHLwy1AorMevUFrxmVOvOqekhjEemtmGeGpWo?=
 =?us-ascii?Q?m2npJVoawQl0MX7knhU9yLzYm77K/oQq4MMELAUSaRsZ6HAWNO2b7qkTuU4T?=
 =?us-ascii?Q?b1an2BUqBLh9M1wQ+LB+89mE8/p1LrVvkg4eVh75AA+JfwJqmsZbwwQwV3Aj?=
 =?us-ascii?Q?90iX/pEhis8lZ/N4snxp2VmtBwhMVnE+s5X6XBjzaerO?=
Content-Type: multipart/mixed;
	boundary="_002_MA0P287MB30828CF024D946D3F575279B9F7DAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 372460cd-9847-4db5-d04e-08ddaf730ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 20:51:22.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9XW+mg9M5zJg5pAPosOGQihWrL5o+NKLSaXy96beeLfx/fS2luPz0ndkfperpgA5lFMRAPa63nezVpNDcdiOBOBfH7928TJSL2QbAjpgrop+T4Q7eG6Fc5DUS1ZlupbmeAyC0hLVjsiCTeWXdIvtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0134
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_MA0P287MB30828CF024D946D3F575279B9F7DAMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

Thanks again for the quick follow-up. `ldr` is the correct choice here, it'=
s a nice idea for reducing loads.=20
I've updated the patch to use it for loading stackaddr and stackbase.
Also added the Signed-off-by line to the commit message as requested.

Patch is In-lined below and attached.

In-lined patch:=20

From 609cc27fa50700ab135dff421f08473c29dcb533 Mon Sep 17 00:00:00 2001
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Date: Fri, 20 Jun 2025 02:12:51 +0530
Subject: [PATCH] Aarch64: Add inline assembly pthread wrapper

This patch adds AArch64-specific inline assembly block for the pthread
wrapper used to bootstrap new threads. It sets up the thread stack,
adjusts for __CYGTLS_PADSIZE__, releases the original stack via
VirtualFree, and invokes the target thread function.

Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewarein=
c.com>
---
 winsup/cygwin/create_posix_thread.cc | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_po=
six_thread.cc
index 3fcd61707..592aaf1a5 100644
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
@@ -99,6 +99,22 @@ pthread_wrapper (PVOID arg)
 	   call  *%%r12			# Call thread func		\n"
 	   : : [WRAPPER_ARG] "o" (wrapper_arg),
 	       [CYGTLS] "i" (__CYGTLS_PADSIZE__));
+#elif defined(__aarch64__)
+  /* Sets up a new thread stack, frees the original OS stack,
+   * and calls the thread function with its arg using AArch64 ABI. */
+  __asm__ __volatile__ ("\n\
+	   mov     x19, %[WRAPPER_ARG]  // x19 =3D &wrapper_arg              \n\
+	   ldp     x0, x10, [x19, #16]  // x0 =3D stackaddr, x10 =3D stackbase \n=
\
+	   sub     sp, x10, %[CYGTLS]   // sp =3D stackbase - (CYGTLS)       \n\
+	   mov     fp, xzr              // clear frame pointer (x29)       \n\
+	   mov     x1, xzr              // x1 =3D 0 (dwSize)                 \n\
+	   mov     x2, #0x8000          // x2 =3D MEM_RELEASE                \n\
+	   bl      VirtualFree          // free original stack             \n\
+	   ldp     x19, x0, [x19]       // x19 =3D func, x0 =3D arg            \n=
\
+	   blr     x19                  // call thread function            \n"
+	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
+	       [CYGTLS] "r" (__CYGTLS_PADSIZE__)
+	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
 #else
 #error unimplemented for this target
 #endif
--=20
2.49.0.windows.1

Thanks,=20
Thirumalai Nagalingam

-----Original Message-----
From: Jeremy Drake <cygwin@jdrake.com>=20
Sent: 20 June 2025 01:52
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
Subject: RE: [PATCH V2] Cygwin: Aarch64: Add inline assembly pthread wrappe=
r

On Thu, 19 Jun 2025, Thirumalai Nagalingam wrote:

> Hi,
>
> Thanks for the feedback.
> As per your request, I've included the updated patch v2 both inline below=
 and as an attachment for easier review.
>
> Q1 - 32-byte shadow area on AArch64
> You're correct - unlike x64 Windows, the AArch64 (ARM64) calling conventi=
on does not mandate a 32-byte shadow space. In my original patch, I include=
d it to maintain parity with x64 behaviour. I re-tested without it and Cygw=
in `pthread` tests pass on ARM64.
> So, in this version, I've removed the shadow space allocation to better a=
lign with standard AArch64 conventions.
>
> Q2 - `mov x0, sp` to `mov x0, [x19, #16]` You're right again. For the=20
> `VirtualFree` call, `x0` should point to the original OS-provided stack (=
`stackaddr`), not the current `sp`.
> I've corrected it as suggested. Thanks again for catching that.

I caught myself after sending that message, and figured that it should actu=
ally be ldr rather than mov.  Now I'm curious and will have to examine the =
aarch64 docs and assembler output to see what 'mov' would do in that case v=
s ldr. :)

Also, probably not important as far as saving a few cycles, but maybe it co=
uld be

+	   ldp     x0, x10, [x19, #16]               // x0 =3D wrapper_arg.stacka=
ddr\n\
+	                                             // x10 =3D=20
+wrapper_arg.stackbase \n\


In addition, please include a Signed-off-by trailer in the commit message.

--_002_MA0P287MB30828CF024D946D3F575279B9F7DAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch"
Content-Description: 0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch
Content-Disposition: attachment;
	filename="0001-Aarch64-Add-inline-assembly-pthread-wrapper.patch"; size=2542;
	creation-date="Thu, 19 Jun 2025 19:52:54 GMT";
	modification-date="Thu, 19 Jun 2025 20:51:22 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MDljYzI3ZmE1MDcwMGFiMTM1ZGZmNDIxZjA4NDczYzI5ZGNiNTMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogRnJpLCAyMCBKdW4gMjAyNSAwMjox
Mjo1MSArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEFhcmNoNjQ6IEFkZCBpbmxpbmUgYXNzZW1ibHkg
cHRocmVhZCB3cmFwcGVyCgpUaGlzIHBhdGNoIGFkZHMgQUFyY2g2NC1zcGVjaWZpYyBpbmxpbmUg
YXNzZW1ibHkgYmxvY2sgZm9yIHRoZSBwdGhyZWFkCndyYXBwZXIgdXNlZCB0byBib290c3RyYXAg
bmV3IHRocmVhZHMuIEl0IHNldHMgdXAgdGhlIHRocmVhZCBzdGFjaywKYWRqdXN0cyBmb3IgX19D
WUdUTFNfUEFEU0laRV9fLCByZWxlYXNlcyB0aGUgb3JpZ2luYWwgc3RhY2sgdmlhClZpcnR1YWxG
cmVlLCBhbmQgaW52b2tlcyB0aGUgdGFyZ2V0IHRocmVhZCBmdW5jdGlvbi4KClNpZ25lZC1vZmYt
Ynk6IFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5uYWdhbGluZ2FtQG11bHRpY29y
ZXdhcmVpbmMuY29tPgotLS0KIHdpbnN1cC9jeWd3aW4vY3JlYXRlX3Bvc2l4X3RocmVhZC5jYyB8
IDE4ICsrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90
aHJlYWQuY2MgYi93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQuY2MKaW5kZXggM2Zj
ZDYxNzA3Li41OTJhYWYxYTUgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vY3JlYXRlX3Bvc2l4
X3RocmVhZC5jYworKysgYi93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQuY2MKQEAg
LTc1LDcgKzc1LDcgQEAgcHRocmVhZF93cmFwcGVyIChQVk9JRCBhcmcpCiAgIC8qIEluaXRpYWxp
emUgbmV3IF9jeWd0bHMuICovCiAgIF9teV90bHMuaW5pdF90aHJlYWQgKHdyYXBwZXJfYXJnLnN0
YWNrYmFzZSAtIF9fQ1lHVExTX1BBRFNJWkVfXywKIAkJICAgICAgIChEV09SRCAoKikodm9pZCos
IHZvaWQqKSkgd3JhcHBlcl9hcmcuZnVuYyk7Ci0jaWZkZWYgX194ODZfNjRfXworI2lmIGRlZmlu
ZWQoX194ODZfNjRfXykKICAgX19hc21fXyAoIlxuXAogCSAgIGxlYXEgICVbV1JBUFBFUl9BUkdd
LCAlJXJieAkjIExvYWQgJndyYXBwZXJfYXJnIGludG8gcmJ4CVxuXAogCSAgIG1vdnEgICglJXJi
eCksICUlcjEyCQkjIExvYWQgdGhyZWFkIGZ1bmMgaW50byByMTIJXG5cCkBAIC05OSw2ICs5OSwy
MiBAQCBwdGhyZWFkX3dyYXBwZXIgKFBWT0lEIGFyZykKIAkgICBjYWxsICAqJSVyMTIJCQkjIENh
bGwgdGhyZWFkIGZ1bmMJCVxuIgogCSAgIDogOiBbV1JBUFBFUl9BUkddICJvIiAod3JhcHBlcl9h
cmcpLAogCSAgICAgICBbQ1lHVExTXSAiaSIgKF9fQ1lHVExTX1BBRFNJWkVfXykpOworI2VsaWYg
ZGVmaW5lZChfX2FhcmNoNjRfXykKKyAgLyogU2V0cyB1cCBhIG5ldyB0aHJlYWQgc3RhY2ssIGZy
ZWVzIHRoZSBvcmlnaW5hbCBPUyBzdGFjaywKKyAgICogYW5kIGNhbGxzIHRoZSB0aHJlYWQgZnVu
Y3Rpb24gd2l0aCBpdHMgYXJnIHVzaW5nIEFBcmNoNjQgQUJJLiAqLworICBfX2FzbV9fIF9fdm9s
YXRpbGVfXyAoIlxuXAorCSAgIG1vdiAgICAgeDE5LCAlW1dSQVBQRVJfQVJHXSAgLy8geDE5ID0g
JndyYXBwZXJfYXJnICAgICAgICAgICAgICBcblwKKwkgICBsZHAgICAgIHgwLCB4MTAsIFt4MTks
ICMxNl0gIC8vIHgwID0gc3RhY2thZGRyLCB4MTAgPSBzdGFja2Jhc2UgXG5cCisJICAgc3ViICAg
ICBzcCwgeDEwLCAlW0NZR1RMU10gICAvLyBzcCA9IHN0YWNrYmFzZSAtIChDWUdUTFMpICAgICAg
IFxuXAorCSAgIG1vdiAgICAgZnAsIHh6ciAgICAgICAgICAgICAgLy8gY2xlYXIgZnJhbWUgcG9p
bnRlciAoeDI5KSAgICAgICBcblwKKwkgICBtb3YgICAgIHgxLCB4enIgICAgICAgICAgICAgIC8v
IHgxID0gMCAoZHdTaXplKSAgICAgICAgICAgICAgICAgXG5cCisJICAgbW92ICAgICB4MiwgIzB4
ODAwMCAgICAgICAgICAvLyB4MiA9IE1FTV9SRUxFQVNFICAgICAgICAgICAgICAgIFxuXAorCSAg
IGJsICAgICAgVmlydHVhbEZyZWUgICAgICAgICAgLy8gZnJlZSBvcmlnaW5hbCBzdGFjayAgICAg
ICAgICAgICBcblwKKwkgICBsZHAgICAgIHgxOSwgeDAsIFt4MTldICAgICAgIC8vIHgxOSA9IGZ1
bmMsIHgwID0gYXJnICAgICAgICAgICAgXG5cCisJICAgYmxyICAgICB4MTkgICAgICAgICAgICAg
ICAgICAvLyBjYWxsIHRocmVhZCBmdW5jdGlvbiAgICAgICAgICAgIFxuIgorCSAgIDogOiBbV1JB
UFBFUl9BUkddICJyIiAoJndyYXBwZXJfYXJnKSwKKwkgICAgICAgW0NZR1RMU10gInIiIChfX0NZ
R1RMU19QQURTSVpFX18pCisJICAgOiAieDAiLCAieDEiLCAieDIiLCAieDEwIiwgIngxOSIsICJ4
MjkiLCAibWVtb3J5Iik7CiAjZWxzZQogI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFy
Z2V0CiAjZW5kaWYKLS0gCjIuNDkuMC53aW5kb3dzLjEKCg==

--_002_MA0P287MB30828CF024D946D3F575279B9F7DAMA0P287MB3082INDP_--

Return-Path: <SRS0=kNIP=2F=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on20731.outbound.protection.outlook.com [IPv6:2a01:111:f403:2606::731])
	by sourceware.org (Postfix) with ESMTPS id 8FC30385B83A
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 19:21:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8FC30385B83A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8FC30385B83A
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2606::731
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753384907; cv=pass;
	b=SXou+U5i60Oiuv+F3x8Wji6Dk1/e+heCKEeupaB4bPEqW4xkr+vg0cmdeuPW4/3Jais5hz3T9dhOrDKKEQ5fbqBsiPJPr+jnae3qoc5k/U9Z38RbKUvIuoLnkt4cpWjqYC2i3ro5tDkAtlBjB+gsaUWKOExNJZ8b7uQn8MLDUes=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753384907; c=relaxed/simple;
	bh=EvXT3OParikHzBBsF2qU6s+ykG2FSO4upYHYpOYgTxc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=o0mKyAOsxRKfRl1a+7wj4K/6GfEkfoWbP/9KY3jWxe8IvGSmaM6XvUMvxkBPgVUjTCe55TeBPke9uMcs1BU7ztY+mab98/t3Oi+7DORNitPmviKhJSfLt9LLydW3dEclFigrPSsQUwtbNq35wgigUXJAoA3n/oFIcivtBKmWtN0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8FC30385B83A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=L8gPbRIQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxL4o66nrt0MeKkn4ERxRmnjm+0Jp83sTq8azxtFiNd0RWIsbDfybW8caL8aXeCq+jihnDswRJYC+HUwQXnOUtC4dNZxAd7gI2p7kcLB3LmynldjhX2WMSLFlyrRVR2RAz+C4R+5EnFwDUH3CogPRTw5ZtiluZmylzFV7K2jjSTN2wJ1j5bXIh70u7gbrQGWIapGYik0R1lhVe4kU/g+dCp2TWBjQI92TsdFsIzHhpwfor++pXKOs0k4qp2BH+P56/WXOwS3QwHXhA8uOFYndRkBVKyfyQHgpgLVOCM/cxvyWf0N7w7lOGy/TnOt1b1b4JNSonpU+7YlNu2BK6bjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9i2bSP0PgX+0foCywo7E4zLbAOlQoQaTxZTrRni0BI=;
 b=cjWJj2FvxPnLClP5Bf+CKaaOex+89rEuJfemLLt9HiQJzLFTasY5rMzlDCQAftPKJAKd8xZyolzn8LohybfmMdU88//hDmwA8fJXU1J/bZvi9pDNVYpAbiEzK29gQzFkVmZ+G6l+Clxh83eruw0Jds6W0H5QhScnqJqla4jjLWpAYSNVz/BtfHPiPhMW+4Tz49ZEu+V5JDNevDGvEMsuq8odAZLTQDw783aZ8rfRp8zOJd0oabAnCRmo/0rD1DmSl6CT+7GA5LhXJnPAsGx3YRBlz4GAglB3KcJAWwn8Ro5TfghtutfB7seFlpYG6IWFWRiqHNCjYsJjry8bURtt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9i2bSP0PgX+0foCywo7E4zLbAOlQoQaTxZTrRni0BI=;
 b=L8gPbRIQFkjgV8AdahBCSyITQm5jIDqTKJEhjpeHuVzgp0nkjANAEyTcFnGOlXrUyojjmL+MfFRqOiT5nZ1NNPFP8+hY7DG+cZ7b5EYaayqYcbf4AjE389149JvtsS7hzA/iqGri+s0c2RZubS9Al9mpm0OyBwIRIMv4M5R3fzI=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GVXPR83MB0653.EURPRD83.prod.outlook.com (2603:10a6:150:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.7; Thu, 24 Jul
 2025 19:21:41 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e%4]) with mapi id 15.20.8989.006; Thu, 24 Jul 2025
 19:21:41 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Topic: [PATCH v2] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
Thread-Index: AQHb/NAvmut7XQOcSUatqKoOpDy5VA==
Date: Thu, 24 Jul 2025 19:21:41 +0000
Message-ID:
 <DB9PR83MB0923EE198FEF243F5A28E781925EA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
 <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9jZCS92AGUaP-o@calimero.vinschen.de>
 <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com>
 <aICZuCg3tKXOj_mR@calimero.vinschen.de>
In-Reply-To: <aICZuCg3tKXOj_mR@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-24T19:21:39.949Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GVXPR83MB0653:EE_
x-ms-office365-filtering-correlation-id: 732406dd-91cf-496d-7a5f-08ddcae751d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?OBtG0D/DkfkvSGBWtki/IEE8RG7rMTzPQds7foawWkKwdcOGdTHPd8e4I/?=
 =?iso-8859-2?Q?dyjNzlOAj34XPCefP6k9sroHdjYkp28iV2sVZDsi6d3fkFxwLPxRnNdnYb?=
 =?iso-8859-2?Q?hndqVJc/TQs7XFSSBkFAXS57CbcUUxHNntahahfh5AUuiPrNycovZgbmbw?=
 =?iso-8859-2?Q?Q8twCWHOtKft0h8Cb4o7R49cmTQeM+Q5GvstFUEMVsxbitsYYGXfCTBw7Y?=
 =?iso-8859-2?Q?W53fHl/n7E21FasMgDucAObj7Ooh1MlPQehcD68qe5cVx92q1Gd6+1eAO3?=
 =?iso-8859-2?Q?v/2IEyjpbQG3lSHGpMW/ZBynEKQR1omGJbQ8T58pC40B9vqsdItUZElh5o?=
 =?iso-8859-2?Q?voHvezEyTBgqmfFvzZsjmusDLRKOdbGJAh0D/0grMKXkaLqENUNCwaP13j?=
 =?iso-8859-2?Q?3Y6dGdaqfnx+YCgSFAMIhJt5wyQHFiU38+YCS3KdDt5JIR7NR9savxE8Eh?=
 =?iso-8859-2?Q?EddVuFBze0pbIGbYrqRzLJQNuiEznzscX5khyKHO5P5poOutjcxhxMTyGc?=
 =?iso-8859-2?Q?B0cerCIK/O9tOBz93WrdA96iN0ziuFH8YiSNTFqKgD8ZjgAVqThRadl+Pm?=
 =?iso-8859-2?Q?vS0OcyB2Tzl2gDfKl/y4W0MGlgHS2jLDx8Ndh/S3kVdjJ0M7bJU07sRcRT?=
 =?iso-8859-2?Q?HDjcUwBjNQVcIMzpMF6Fpx6GzfsR1/kdJ1fkY2sV6PEZZ0nq7on5Mp1J0f?=
 =?iso-8859-2?Q?KpvwXJKiAsNpfMWb5H/4iPXVX3KS0OlRK8xBK71Sga++X5tHBAkBvgzAaV?=
 =?iso-8859-2?Q?I38jNZi0wrd9Dx+yJsNVBKdz+0OqAnXk6n9YvAvhHZooYT9CKTl6047VxN?=
 =?iso-8859-2?Q?d+AfsIHbaxwvhfpNzEU1HRyRjLHRvu5f0gRkdaRt6S7lvlDYCVjHyho78v?=
 =?iso-8859-2?Q?5tHHmjuf7B8vM7XqJ29teNBMW5S/dg9gjHoVc5VwTNaoY6YQ7+97IL5r/o?=
 =?iso-8859-2?Q?7SC8WZ26Wk1p0mTCWDLZEM53LiCvLyFtm0rv3iuP+xb1JKpHvYGD4vcpvk?=
 =?iso-8859-2?Q?JjBKXObF8MSKZD7k+0P5Y3pseiTyM6i8HO0F8Q0f6pnEhZruNBDKGbbrwf?=
 =?iso-8859-2?Q?kEkzoags3ii5IPv1tNr8J1D/GUGUIIOdXt0TakF/SClO+fC4G5HGTSgSEK?=
 =?iso-8859-2?Q?RX6L46l69fuQ1rUsZAvpYBbWgBck1XpdmU/aXfgigupkogzps7e11UUt3b?=
 =?iso-8859-2?Q?J6T3Qt69YfhOCfCJeyCACqhKI8ltFFpJHDu0U5CknVsJjJTH0Ark9GbOen?=
 =?iso-8859-2?Q?+Zh/vIFhAvhmtQ1uz0IZyQeSs9fLrTk+xO8JeAITP/kpgaQqjpRlqrod6n?=
 =?iso-8859-2?Q?cJkK4tXMsglLmC142Dyr3ZMSYLzeFpjWf1VYCgT3USOkVzhj5JYLIEEH90?=
 =?iso-8859-2?Q?VAYuVLD3l4yEyky5vKpSA7YtOCEKo6M5U/lXC1Vh+SZxV3WqvuJSvJ1CPM?=
 =?iso-8859-2?Q?O7hC+mGKK2m8p8lpF4HHYrdy+zKY+PNzmTs3ATbC/txya/++HAQrcDUpfp?=
 =?iso-8859-2?Q?g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?XPYHJa1ZQFDz0y02tkXxSgdhn0uWlNPJCeLZVsytYyP+7yqO7Hp7vK7+jv?=
 =?iso-8859-2?Q?0osUmiYuT6RpfE3IRV9w1VZrdE2PbcTar02GeBcFIT1Qu1wrvhRfx7cEhT?=
 =?iso-8859-2?Q?1EYnKY1O4Q29mT+WNPHKgrSqRJASZclbF6RRHKabV+q8dhg/Vm3n3HnQOQ?=
 =?iso-8859-2?Q?6GLbpuDYCFpWda/den1G+Hr4E2HueerjF5x7ycEjcj3Vcm4/ONIFG96qCu?=
 =?iso-8859-2?Q?e6CC7DmxKUayRBZIAlmk4IF5XLcJsA9XWETPZYYekcfzZ8fr7pQWagSYsY?=
 =?iso-8859-2?Q?NdPdjkLpSSxIX+vDB8rlIaawe+8M4TibBhL+OWV3mUR75lVH8YDpkbrZ7E?=
 =?iso-8859-2?Q?gR9ThIDTaUKqOz2srGrxy9ndFBe5rcOvfaEl7LVYtTRYAcZzzmSzi3c7qq?=
 =?iso-8859-2?Q?VsZ2FlGQf38dDnDkSibctec+eWGBQ50s/9GFxkDw/Q24wJWspPEB25uCra?=
 =?iso-8859-2?Q?Jens+6bE9kKEb43Too1Yv2jGf/oBzNLZVBcBRICEDB7k4C5yxKYoy/Gc3P?=
 =?iso-8859-2?Q?M1TSaxh3YyuIgUGeaK4PCsjpWMCL7zoh4EbzCIfUX9XfdXCexbw9+iOMQN?=
 =?iso-8859-2?Q?oFuCc0jCuMeUbGPYzUNzgwwHhiQgWLXWCDDQTC3ljujntnmyc9ddhQIiKI?=
 =?iso-8859-2?Q?m1hkAK69tIxI7AlVP1jlyZyp22xPwTbkdt5qr8o9jfh648RjzWysGo/tai?=
 =?iso-8859-2?Q?93Dcv8cSM6u6Np5gein6qKeVMfQpLXM/BPgoggz7FJ9fteGf/mf131x8x3?=
 =?iso-8859-2?Q?0AGjLuMOzreUTwjxJEOkl+uDD/D4sp9QrC/eJiy+VumNVQSbcIqeM/VY4d?=
 =?iso-8859-2?Q?tj5p17q+byftosrWaAZWxWR4eB+KtJUi1PzKmieWdhFfErKJuV1YATB21b?=
 =?iso-8859-2?Q?5RJKFvrzD613jk4qbBa+hL+GdHGch1Sl9tlzoi5ornvGD/xr1qcd3ymyqj?=
 =?iso-8859-2?Q?2JVzs3mJ4tXJIR7R4IOuBzO21c133p0fD4j1fyBpiPB635+eqqMyc2ZZso?=
 =?iso-8859-2?Q?rgdUN3nv+8h+2ByjUrVF8eSapMdczLJG1OpxzdC1314nTmnC1312FzaO91?=
 =?iso-8859-2?Q?E04DOTZG5jSWl7h+vqrabk+fVSqWJaV4osO72g1M0Y4/cVwxZGzYGcGnBz?=
 =?iso-8859-2?Q?JKdo+KmbhPYiS8kaKmI85zURcrMQrD7wu/y3HSxZIG4UQT+P4/ZUBg3HuF?=
 =?iso-8859-2?Q?fXr7UqpcZ4tRU+H7Tpk9qf4llyT6VjgNvn5l+BclWWUjWMzAJ19rYMHaGn?=
 =?iso-8859-2?Q?po4ukDUsvatdCRRzZ5ELBujaKLpLwySDjnqEbHja6BpM/d8l340razvQzM?=
 =?iso-8859-2?Q?9712/ugxHdIdpYaTI/DwOf4du/GRb34nyNyZx2aHpK8fRIAsR89FeF0LTH?=
 =?iso-8859-2?Q?ZfuXPkQIllH5PkxEaITZWYZvLdsPp8TgrCw1Elo7oJcGwDlKtCCCyLjAtj?=
 =?iso-8859-2?Q?NLTQXuDpBcZQUNLmK4FnfvXmORmpar3WrKHtfUTYO13/ynRHGlIBM97EhC?=
 =?iso-8859-2?Q?6x8uiEV7x4H3KJ1Jn/WQzNBSYbOQU0fxG2rIKCCKgZwIJp+VZUS7KSGcRg?=
 =?iso-8859-2?Q?1eH/MollrUP2g+im8+hO/m/oPeJk?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923EE198FEF243F5A28E781925EADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732406dd-91cf-496d-7a5f-08ddcae751d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 19:21:41.4725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSUW2/63KcFcNMGibpbwUExgEqlm3XG9afRUJMOM+fC04xmCobL8gnp2MvIfq927lQlbGTaZw3gYAXjF4RNlgfUGnkkgXLelp1VwBjwxSOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0653
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923EE198FEF243F5A28E781925EADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Thank you for testing. I missed that hunk, sorry.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From b9d04d2359a258f4a08f7f50fe5a11c03859f2b5 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 19 Jul 2025 19:17:12 +0200=0A=
Subject: [PATCH v2] Cygwin: mkimport: implement AArch64 +/-4GB relocations=
=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Based on https://sourceware.org/pipermail/cygwin-patches/2025q3/014154.html=
=0A=
suggestion, this patch implements +/-4GB relocations for AArch64 in the mki=
mport=0A=
script by using adrp and ldr instructions. This change required update=0A=
in winsup\cygwin\mm\malloc_wrapper.cc where those instructions are=0A=
decoded to get target import address.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/mm/malloc_wrapper.cc | 26 +++++++++++++++++---------=0A=
 winsup/cygwin/scripts/mkimport     |  7 +++++--=0A=
 2 files changed, 22 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/malloc_w=
rapper.cc=0A=
index 863d3089c..991bd57be 100644=0A=
--- a/winsup/cygwin/mm/malloc_wrapper.cc=0A=
+++ b/winsup/cygwin/mm/malloc_wrapper.cc=0A=
@@ -51,16 +51,24 @@ import_address (void *imp)=0A=
   __try=0A=
     {=0A=
 #if defined(__aarch64__)=0A=
-      // If opcode is an adr instruction.=0A=
-      uint32_t opcode =3D *(uint32_t *) imp;=0A=
-      if ((opcode & 0x9f000000) =3D=3D 0x10000000)=0A=
+      // If opcode1 is an adrp and opcode2 is ldr instruction:=0A=
+      //   - https://www.scs.stanford.edu/~zyedidia/arm64/adrp.html=0A=
+      //   - https://www.scs.stanford.edu/~zyedidia/arm64/ldr_imm_gen.html=
=0A=
+      // NOTE: This implementation assumes that the relocation table is ma=
de of=0A=
+      // those specific AArch64 instructions as generated by the=0A=
+      // winsup\cygwin\scripts\mkimport script. Please, keep it in sync.=
=0A=
+      uint32_t opcode1 =3D *((uint32_t *) imp);=0A=
+      uint32_t opcode2 =3D *(((uint32_t *) imp) + 1);=0A=
+      if (((opcode1 & 0x9f000000) =3D=3D 0x90000000) && ((opcode2 & 0xbfc0=
0000) =3D=3D 0xb9400000))=0A=
 	{=0A=
-	  uint32_t immhi =3D (opcode >> 5) & 0x7ffff;=0A=
-	  uint32_t immlo =3D (opcode >> 29) & 0x3;=0A=
-	  int64_t sign_extend =3D (0l - (immhi >> 18)) << 21;=0A=
-	  int64_t imm =3D sign_extend | (immhi << 2) | immlo;=0A=
-	  uintptr_t jmpto =3D *(uintptr_t *) ((uint8_t *) imp + imm);=0A=
-	  return (void *) jmpto;=0A=
+	  uint32_t immhi =3D (opcode1 >> 5) & 0x7ffff;=0A=
+	  uint32_t immlo =3D (opcode1 >> 29) & 0x3;=0A=
+	  uint32_t imm12 =3D ((opcode2 >> 10) & 0xfff) * 8; // 64 bit scale=0A=
+	  int64_t sign_extend =3D (0l - ((int64_t) immhi >> 32)) << 33; // sign e=
xtend from 33 to 64 bits=0A=
+	  int64_t imm =3D sign_extend | (((immhi << 2) | immlo) << 12);=0A=
+	  int64_t base =3D (int64_t) imp & ~0xfff;=0A=
+	  uintptr_t* jmpto =3D (uintptr_t *) (base + imm + imm12);=0A=
+	  return (void *) *jmpto;=0A=
 	}=0A=
 #else=0A=
       if (*((uint16_t *) imp) =3D=3D 0x25ff)=0A=
diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimpor=
t=0A=
index 0c1bcafbf..33d8b08fb 100755=0A=
--- a/winsup/cygwin/scripts/mkimport=0A=
+++ b/winsup/cygwin/scripts/mkimport=0A=
@@ -73,8 +73,11 @@ EOF=0A=
 	.extern	$imp_sym=0A=
 	.global	$glob_sym=0A=
 $glob_sym:=0A=
-	adr x16, $imp_sym=0A=
-	ldr x16, [x16]=0A=
+	# NOTE: Using instructions that are used by MSVC and LLVM. Binutils are=
=0A=
+	# using adrp/add/ldr-0-offset though. Please, keep it in sync with=0A=
+  # import_address implementation in winsup/cygwin/mm/malloc_wrapper.cc.=
=0A=
+	adrp x16, $imp_sym=0A=
+	ldr x16, [x16, #:lo12:$imp_sym]=0A=
 	br x16=0A=
 EOF=0A=
 	} else {=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB0923EE198FEF243F5A28E781925EADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-newlib-libc-return-back-support-for-AArch64-ILP32.patch"
Content-Description:
 v2-0001-newlib-libc-return-back-support-for-AArch64-ILP32.patch
Content-Disposition: attachment;
	filename="v2-0001-newlib-libc-return-back-support-for-AArch64-ILP32.patch";
	size=8348; creation-date="Thu, 24 Jul 2025 19:21:33 GMT";
	modification-date="Thu, 24 Jul 2025 19:21:33 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjNmVhZDA0OWJlZTJlZmM1MzU1ZjczNDQyNWVmYWFhZjgzM2EwYTZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCAyNCBKdWwgMjAyNSAxMjozNjowMiAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIG5ld2xpYjogbGliYzogcmV0dXJuIGJhY2sgc3VwcG9y
dCBmb3IgQUFyY2g2NCBJTFAzMgpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQv
cGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKVGhp
cyBwYXRjaCBpcyByZXR1cm5pbmcgYmFjayBzdXBwb3J0IGZvciBBQXJjaDY0IElMUDMyIEFCSSB0
aGF0IHdhcwpyZW1vdmVkIGluIGRlNDc5YTU0ZTIyZThmY2I2MjYyNjM5YThlNjdmZThiMDBhMjdj
MzcgY29tbWl0IGJ1dCBpcyBuZWVkZWQKdG8gZW5zdXJlIHNvdXJjZSBjb2RlIGNvbXBhdGliaWxp
dHkgd2l0aCBHQ0MgMTQuCgpUaGUgY2hhbmdlIGluIG5ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2
NC9hc21kZWZzLmggbWFrZXMgaXQKb3V0LW9mLXRoZS1zeW5jIHdpdGggdGhlIGN1cnJlbnQgdXBz
dHJlYW0gaW1wbGVtZW50YXRpb24gaW4KaHR0cHM6Ly9naXRodWIuY29tL0FSTS1zb2Z0d2FyZS9v
cHRpbWl6ZWQtcm91dGluZXMgcmVwb3NpdG9yeS4KClNpZ25lZC1vZmYtYnk6IFJhZGVrIEJhcnRv
xYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIG5ld2xpYi9saWJjL21hY2hpbmUv
YWFyY2g2NC9hc21kZWZzLmggICB8IDQ4ICsrKysrKysrKysrKysrKysrKystLS0tLS0KIG5ld2xp
Yi9saWJjL21hY2hpbmUvYWFyY2g2NC9tZW1jaHIuUyAgICB8ICAyICsrCiBuZXdsaWIvbGliYy9t
YWNoaW5lL2FhcmNoNjQvbWVtY21wLlMgICAgfCAgNCArKysKIG5ld2xpYi9saWJjL21hY2hpbmUv
YWFyY2g2NC9tZW1jcHkuUyAgICB8ICAzICsrCiBuZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQv
bWVtcmNoci5TICAgfCAgMSArCiBuZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvbWVtc2V0LlMg
ICAgfCAgMyArKwogbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cmNoci5TICAgIHwgIDEg
KwogbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cmNocm51bC5TIHwgIDEgKwogbmV3bGli
L2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cmNtcC5TICAgIHwgIDIgKysKIG5ld2xpYi9saWJjL21h
Y2hpbmUvYWFyY2g2NC9zdHJjcHkuUyAgICB8ICAyICsrCiBuZXdsaWIvbGliYy9tYWNoaW5lL2Fh
cmNoNjQvc3RybGVuLlMgICAgfCAgMSArCiBuZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvc3Ry
bmNtcC5TICAgfCAgMyArKwogbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cm5sZW4uUyAg
IHwgIDIgKysKIG5ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9zdHJyY2hyLlMgICB8ICAxICsK
IDE0IGZpbGVzIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9hc21kZWZzLmggYi9uZXdsaWIv
bGliYy9tYWNoaW5lL2FhcmNoNjQvYXNtZGVmcy5oCmluZGV4IDZjOTlmYTcwNC4uMmFhYTQ1OWVl
IDEwMDY0NAotLS0gYS9uZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvYXNtZGVmcy5oCisrKyBi
L25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9hc21kZWZzLmgKQEAgLTMwLDE4ICszMCwzMiBA
QAogI2RlZmluZSBGRUFUVVJFXzFfUEFDIDIKIAogLyogQWRkIGEgTlRfR05VX1BST1BFUlRZX1RZ
UEVfMCBub3RlLiAgKi8KKyNpZmRlZiBfX0lMUDMyX18KICNkZWZpbmUgR05VX1BST1BFUlRZKHR5
cGUsIHZhbHVlKQlcCi0gIC5zZWN0aW9uIC5ub3RlLmdudS5wcm9wZXJ0eSwgImEiICBTRVAgXAot
ICAucDJhbGlnbiAzCQkJICAgIFNFUCBcCi0gIC53b3JkIDQJCQkgICAgU0VQIFwKLSAgLndvcmQg
MTYJCQkgICAgU0VQIFwKLSAgLndvcmQgNQkJCSAgICBTRVAgXAotICAuYXNjaXogIkdOVSIJCQkg
ICAgU0VQIFwKLSAgLndvcmQgdHlwZQkJCSAgICBTRVAgXAotICAud29yZCA0CQkJICAgIFNFUCBc
Ci0gIC53b3JkIHZhbHVlCQkJICAgIFNFUCBcCi0gIC53b3JkIDAJCQkgICAgU0VQIFwKKyAgLnNl
Y3Rpb24gLm5vdGUuZ251LnByb3BlcnR5LCAiYSI7CVwKKyAgLnAyYWxpZ24gMjsJCQkJXAorICAu
d29yZCA0OwkJCQlcCisgIC53b3JkIDEyOwkJCQlcCisgIC53b3JkIDU7CQkJCVwKKyAgLmFzY2l6
ICJHTlUiOwkJCQlcCisgIC53b3JkIHR5cGU7CQkJCVwKKyAgLndvcmQgNDsJCQkJXAorICAud29y
ZCB2YWx1ZTsJCQkJXAogICAudGV4dAorI2Vsc2UKKyNkZWZpbmUgR05VX1BST1BFUlRZKHR5cGUs
IHZhbHVlKQlcCisgIC5zZWN0aW9uIC5ub3RlLmdudS5wcm9wZXJ0eSwgImEiOwlcCisgIC5wMmFs
aWduIDM7CQkJCVwKKyAgLndvcmQgNDsJCQkJXAorICAud29yZCAxNjsJCQkJXAorICAud29yZCA1
OwkJCQlcCisgIC5hc2NpeiAiR05VIjsJCQkJXAorICAud29yZCB0eXBlOwkJCQlcCisgIC53b3Jk
IDQ7CQkJCVwKKyAgLndvcmQgdmFsdWU7CQkJCVwKKyAgLndvcmQgMDsJCQkJXAorICAudGV4dAor
I2VuZGlmCiAKIC8qIElmIHNldCB0aGVuIHRoZSBHTlUgUHJvcGVydHkgTm90ZSBzZWN0aW9uIHdp
bGwgYmUgYWRkZWQgdG8KICAgIG1hcmsgb2JqZWN0cyB0byBzdXBwb3J0IEJUSSBhbmQgUEFDLVJF
VC4gICovCkBAIC04OCw0ICsxMDIsMTggQEAgR05VX1BST1BFUlRZIChGRUFUVVJFXzFfQU5ELCBG
RUFUVVJFXzFfQlRJfEZFQVRVUkVfMV9QQUMpCiAKICNkZWZpbmUgTChsKSAuTCAjIyBsCiAKKyNp
ZmRlZiBfX0lMUDMyX18KKyAgLyogU2FuaXRpemUgcGFkZGluZyBiaXRzIG9mIHBvaW50ZXIgYXJn
dW1lbnRzIGFzIHBlciBhYXBjczY0ICovCisjZGVmaW5lIFBUUl9BUkcobikgIG1vdiB3IyNuLCB3
IyNuCisjZWxzZQorI2RlZmluZSBQVFJfQVJHKG4pCisjZW5kaWYKKworI2lmZGVmIF9fSUxQMzJf
XworICAvKiBTYW5pdGl6ZSBwYWRkaW5nIGJpdHMgb2Ygc2l6ZSBhcmd1bWVudHMgYXMgcGVyIGFh
cGNzNjQgKi8KKyNkZWZpbmUgU0laRV9BUkcobikgIG1vdiB3IyNuLCB3IyNuCisjZWxzZQorI2Rl
ZmluZSBTSVpFX0FSRyhuKQorI2VuZGlmCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvbmV3bGliL2xp
YmMvbWFjaGluZS9hYXJjaDY0L21lbWNoci5TIGIvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0
L21lbWNoci5TCmluZGV4IDA3NGEwMDRjZi4uYTBmMzA1ZTBmIDEwMDY0NAotLS0gYS9uZXdsaWIv
bGliYy9tYWNoaW5lL2FhcmNoNjQvbWVtY2hyLlMKKysrIGIvbmV3bGliL2xpYmMvbWFjaGluZS9h
YXJjaDY0L21lbWNoci5TCkBAIC01MCw2ICs1MCw4IEBACiAgKi8KIAogRU5UUlkgKG1lbWNocikK
KwlQVFJfQVJHICgwKQorCVNJWkVfQVJHICgyKQogCS8qIERvIG5vdCBkZXJlZmVyZW5jZSBzcmNp
biBpZiBubyBieXRlcyB0byBjb21wYXJlLiAgKi8KIAljYnoJY250aW4sIEwoemVyb19sZW5ndGgp
CiAJLyoKZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9tZW1jbXAuUyBi
L25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9tZW1jbXAuUwppbmRleCAyYTljNDQ2YmIuLjE4
ODc0ZDMyMSAxMDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L21lbWNtcC5T
CisrKyBiL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9tZW1jbXAuUwpAQCAtMzQsNiArMzQs
MTAgQEAKIAogCiBFTlRSWSAobWVtY21wKQorCVBUUl9BUkcgKDApCisJUFRSX0FSRyAoMSkKKwlT
SVpFX0FSRyAoMikKKwogCWNtcAlsaW1pdCwgMTYKIAliLmxvCUwobGVzczE2KQogCWxkcAlkYXRh
MSwgZGF0YTMsIFtzcmMxXQpkaWZmIC0tZ2l0IGEvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0
L21lbWNweS5TIGIvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L21lbWNweS5TCmluZGV4IDI1
MmQyNDUyYS4uMjQ4ZTc4NDNhIDEwMDY0NAotLS0gYS9uZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNo
NjQvbWVtY3B5LlMKKysrIGIvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L21lbWNweS5TCkBA
IC01OCw2ICs1OCw5IEBACiAKIEVOVFJZX0FMSUFTIChtZW1tb3ZlKQogRU5UUlkgKG1lbWNweSkK
KwlQVFJfQVJHICgwKQorCVBUUl9BUkcgKDEpCisJU0laRV9BUkcgKDIpCiAJYWRkCXNyY2VuZCwg
c3JjLCBjb3VudAogCWFkZAlkc3RlbmQsIGRzdGluLCBjb3VudAogCWNtcAljb3VudCwgMTI4CmRp
ZmYgLS1naXQgYS9uZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvbWVtcmNoci5TIGIvbmV3bGli
L2xpYmMvbWFjaGluZS9hYXJjaDY0L21lbXJjaHIuUwppbmRleCAyNTI1Y2YxOTAuLmJhOTkxNWNj
MyAxMDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L21lbXJjaHIuUworKysg
Yi9uZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvbWVtcmNoci5TCkBAIC00NSw2ICs0NSw3IEBA
CiAgICBleGFjdGx5IHdoaWNoIGJ5dGUgbWF0Y2hlZC4gICovCiAKIEVOVFJZIChtZW1yY2hyKQor
CVBUUl9BUkcgKDApCiAJYWRkCWVuZCwgc3JjaW4sIGNudGluCiAJc3ViCWVuZG0xLCBlbmQsIDEK
IAliaWMJc3JjLCBlbmRtMSwgMTUKZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL21hY2hpbmUvYWFy
Y2g2NC9tZW1zZXQuUyBiL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9tZW1zZXQuUwppbmRl
eCA1YmY0ODUxZjMuLmNhNzY0MzlhOSAxMDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvbWFjaGluZS9h
YXJjaDY0L21lbXNldC5TCisrKyBiL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9tZW1zZXQu
UwpAQCAtMjUsNiArMjUsOSBAQAogI2RlZmluZSB6dmFfdmFsCXg1CiAKIEVOVFJZIChtZW1zZXQp
CisJUFRSX0FSRyAoMCkKKwlTSVpFX0FSRyAoMikKKwogCWR1cAl2MC4xNkIsIHZhbHcKIAlhZGQJ
ZHN0ZW5kLCBkc3RpbiwgY291bnQKIApkaWZmIC0tZ2l0IGEvbmV3bGliL2xpYmMvbWFjaGluZS9h
YXJjaDY0L3N0cmNoci5TIGIvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cmNoci5TCmlu
ZGV4IGE0ZTA4OWI5OS4uNTAwZDlhZmYyIDEwMDY0NAotLS0gYS9uZXdsaWIvbGliYy9tYWNoaW5l
L2FhcmNoNjQvc3RyY2hyLlMKKysrIGIvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cmNo
ci5TCkBAIC01NCw2ICs1NCw3IEBACiAvKiBMb2NhbHMgYW5kIHRlbXBvcmFyaWVzLiAgKi8KIAog
RU5UUlkgKHN0cmNocikKKwlQVFJfQVJHICgwKQogCS8qIE1hZ2ljIGNvbnN0YW50IDB4YzAzMDBj
MDMgdG8gYWxsb3cgdXMgdG8gaWRlbnRpZnkgd2hpY2ggbGFuZQogCSAgIG1hdGNoZXMgdGhlIHJl
cXVlc3RlZCBieXRlLiAgRXZlbiBiaXRzIGFyZSBzZXQgaWYgdGhlIGNoYXJhY3RlcgogCSAgIG1h
dGNoZXMsIG9kZCBiaXRzIGlmIGVpdGhlciB0aGUgY2hhciBpcyBOVUwgb3IgbWF0Y2hlcy4gICov
CmRpZmYgLS1naXQgYS9uZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvc3RyY2hybnVsLlMgYi9u
ZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvc3RyY2hybnVsLlMKaW5kZXggNGQ2MDkzYmU3Li5j
ZWFmNGRjYTEgMTAwNjQ0Ci0tLSBhL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9zdHJjaHJu
dWwuUworKysgYi9uZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvc3RyY2hybnVsLlMKQEAgLTUw
LDYgKzUwLDcgQEAKIC8qIExvY2FscyBhbmQgdGVtcG9yYXJpZXMuICAqLwogCiBFTlRSWSAoc3Ry
Y2hybnVsKQorCVBUUl9BUkcgKDApCiAJLyogTWFnaWMgY29uc3RhbnQgMHg0MDEwMDQwMSB0byBh
bGxvdyB1cyB0byBpZGVudGlmeSB3aGljaCBsYW5lCiAJICAgbWF0Y2hlcyB0aGUgdGVybWluYXRp
b24gY29uZGl0aW9uLiAgKi8KIAltb3YJd3RtcDIsICMweDA0MDEKZGlmZiAtLWdpdCBhL25ld2xp
Yi9saWJjL21hY2hpbmUvYWFyY2g2NC9zdHJjbXAuUyBiL25ld2xpYi9saWJjL21hY2hpbmUvYWFy
Y2g2NC9zdHJjbXAuUwppbmRleCAxZDg1ZGE0MzIuLjY5MWExNzYwZSAxMDA2NDQKLS0tIGEvbmV3
bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cmNtcC5TCisrKyBiL25ld2xpYi9saWJjL21hY2hp
bmUvYWFyY2g2NC9zdHJjbXAuUwpAQCAtNTQsNiArNTQsOCBAQAogCiAKIEVOVFJZIChzdHJjbXAp
CisJUFRSX0FSRyAoMCkKKwlQVFJfQVJHICgxKQogCXN1YglvZmYyLCBzcmMyLCBzcmMxCiAJbW92
CXplcm9vbmVzLCBSRVA4XzAxCiAJYW5kCXRtcCwgc3JjMSwgNwpkaWZmIC0tZ2l0IGEvbmV3bGli
L2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cmNweS5TIGIvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJj
aDY0L3N0cmNweS5TCmluZGV4IDFmNWY3MDc5Mi4uNTdjNDZmMzkwIDEwMDY0NAotLS0gYS9uZXds
aWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvc3RyY3B5LlMKKysrIGIvbmV3bGliL2xpYmMvbWFjaGlu
ZS9hYXJjaDY0L3N0cmNweS5TCkBAIC01NSw2ICs1NSw4IEBACiAgICBleGFjdGx5IHdoaWNoIGJ5
dGUgbWF0Y2hlZC4gICovCiAKIEVOVFJZIChTVFJDUFkpCisJUFRSX0FSRyAoMCkKKwlQVFJfQVJH
ICgxKQogCWJpYwlzcmMsIHNyY2luLCAxNQogCWxkMQl7dmRhdGEuMTZifSwgW3NyY10KIAljbWVx
CXZoYXNfbnVsLjE2YiwgdmRhdGEuMTZiLCAwCmRpZmYgLS1naXQgYS9uZXdsaWIvbGliYy9tYWNo
aW5lL2FhcmNoNjQvc3RybGVuLlMgYi9uZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvc3RybGVu
LlMKaW5kZXggYTMzNDVhM2FiLi42OGE2ZjM1N2MgMTAwNjQ0Ci0tLSBhL25ld2xpYi9saWJjL21h
Y2hpbmUvYWFyY2g2NC9zdHJsZW4uUworKysgYi9uZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQv
c3RybGVuLlMKQEAgLTc4LDYgKzc4LDcgQEAKICAgIGNoYXJhY3RlciwgcmV0dXJuIHRoZSBsZW5n
dGgsIGlmIG5vdCwgY29udGludWUgaW4gdGhlIG1haW4gbG9vcC4gICovCiAKIEVOVFJZIChzdHJs
ZW4pCisJUFRSX0FSRyAoMCkKIAlhbmQJdG1wMSwgc3JjaW4sIE1JTl9QQUdFX1NJWkUgLSAxCiAJ
Y21wCXRtcDEsIE1JTl9QQUdFX1NJWkUgLSAzMgogCWIuaGkJTChwYWdlX2Nyb3NzKQpkaWZmIC0t
Z2l0IGEvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cm5jbXAuUyBiL25ld2xpYi9saWJj
L21hY2hpbmUvYWFyY2g2NC9zdHJuY21wLlMKaW5kZXggNmIxOTk0ZWY1Li4zNzM2OTU1MDMgMTAw
NjQ0Ci0tLSBhL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9zdHJuY21wLlMKKysrIGIvbmV3
bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cm5jbXAuUwpAQCAtNTgsNiArNTgsOSBAQAogI2Vu
ZGlmCiAKIEVOVFJZIChzdHJuY21wKQorCVBUUl9BUkcgKDApCisJUFRSX0FSRyAoMSkKKwlTSVpF
X0FSRyAoMikKIAljYnoJbGltaXQsIEwocmV0MCkKIAllb3IJdG1wMSwgc3JjMSwgc3JjMgogCW1v
dgl6ZXJvb25lcywgI1JFUDhfMDEKZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL21hY2hpbmUvYWFy
Y2g2NC9zdHJubGVuLlMgYi9uZXdsaWIvbGliYy9tYWNoaW5lL2FhcmNoNjQvc3Rybmxlbi5TCmlu
ZGV4IGRjOWZjYjJmZC4uMDkxMDAyZTBiIDEwMDY0NAotLS0gYS9uZXdsaWIvbGliYy9tYWNoaW5l
L2FhcmNoNjQvc3Rybmxlbi5TCisrKyBiL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9zdHJu
bGVuLlMKQEAgLTM5LDYgKzM5LDggQEAKICAgIGlkZW50aWZpZXMgdGhlIGZpcnN0IHplcm8gYnl0
ZS4gICovCiAKIEVOVFJZIChzdHJubGVuKQorCVBUUl9BUkcgKDApCisJU0laRV9BUkcgKDEpCiAJ
YmljCXNyYywgc3JjaW4sIDE1CiAJY2J6CWNudGluLCBMKG5vbWF0Y2gpCiAJbGQxCXt2ZGF0YS4x
NmJ9LCBbc3JjXQpkaWZmIC0tZ2l0IGEvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cnJj
aHIuUyBiL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9zdHJyY2hyLlMKaW5kZXggNjcwMTNl
MzlkLi5iMDU3NDIyOGIgMTAwNjQ0Ci0tLSBhL25ld2xpYi9saWJjL21hY2hpbmUvYWFyY2g2NC9z
dHJyY2hyLlMKKysrIGIvbmV3bGliL2xpYmMvbWFjaGluZS9hYXJjaDY0L3N0cnJjaHIuUwpAQCAt
NTgsNiArNTgsNyBAQAogICAgaWRlbnRpZnkgZXhhY3RseSB3aGljaCBieXRlIGlzIGNhdXNpbmcg
dGhlIHRlcm1pbmF0aW9uLCBhbmQgd2h5LiAgKi8KIAogRU5UUlkgKHN0cnJjaHIpCisJUFRSX0FS
RyAoMCkKIAkvKiBNYWdpYyBjb25zdGFudCAweDQwMTAwNDAxIHRvIGFsbG93IHVzIHRvIGlkZW50
aWZ5IHdoaWNoIGxhbmUKIAkgICBtYXRjaGVzIHRoZSByZXF1ZXN0ZWQgYnl0ZS4gIE1hZ2ljIGNv
bnN0YW50IDB4ODAyMDA4MDIgdXNlZAogCSAgIHNpbWlsYXJseSBmb3IgTlVMIHRlcm1pbmF0aW9u
LiAgKi8KLS0gCjIuNTAuMS52ZnMuMC4wCgo=

--_002_DB9PR83MB0923EE198FEF243F5A28E781925EADB9PR83MB0923EURP_--

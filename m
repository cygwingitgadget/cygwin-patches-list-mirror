Return-Path: <SRS0=iNfD=DS=arm.com=Evgeny.Karpov@sourceware.org>
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by sourceware.org (Postfix) with ESMTPS id F33CE4BAD14A
	for <cygwin-patches@cygwin.com>; Thu, 21 May 2026 13:30:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F33CE4BAD14A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F33CE4BAD14A
Authentication-Results: sourceware.org; arc=fail smtp.remote-ip=2a01:111:f403:c20f::7
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F33CE4BAD14A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Sf9FAb8p;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Sf9FAb8p
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=D5fA9KBD2+dZwyfINZfbTBadO7xiyOkblam2Xe3aKIdqXeZzbXwtsPM1bpWMBj0GoX5PyG0LZbq0ReYTA5lyx8+myQ9rsOrD/ko/n3xT5bNchfkl67PXxPfTRTqV4AJAPbcdVmGZRXwSwxYnoSZWW7byAn0ptLIyIUliqNDSnHn7L1suqssxYH33ete/gXodXA9xTeV+J4lNo5ViNqgChHCrc/5aA0k5b6kW0tZ//ab+P6m3BKqYzu5eRaBGUy7eEM0jR0GHFIHwcknVcZdoPvO3fk4VEKSPKK+RPMfPK0+Uj6jq2rLUa219rozjH3+LobodENyQ+N2Ig5n0tkkwuA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxjg9+EgO7/IwjU66A8gK4jDj/uvCotrUhnp5nZkIEs=;
 b=f6Z2bV6vueG2B1l0k77yqEtqqgR5notIvzs7SUEPJeFE0mwiiBXMr1aYKO4Ym7Ny4J0qSZ+HiuQFLL0GSNPWK1yQdtLoasx3Xpb8l2wiPbw9N/hc4hVe2bwq0MOkHjXyr3kqGtFCSq8SzXseSTdyVQX8RntRkvUKHQPZKPyF8LkAHk1yG22Oxo1UefHj2nDxXV72+b173432qlcxcVsuIQRi8PtjlTMRgCI5/mTaa8KfQHddgSdiWrZkuuBWeULaR6ZEa7tj2Ca06pYxe+UmOjM4mKz0eT//JNcbcTmarGHl0tqehPgWzm3KD2KBof+mSjk+fE9lb7+zT6SQ2h/3Gg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=fail (48)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxjg9+EgO7/IwjU66A8gK4jDj/uvCotrUhnp5nZkIEs=;
 b=Sf9FAb8pwT6T/xSIUmmsYT2JLexKM2BVbEmqJYS769NHVrrRFvQ1bPl12FoEhsXTzggJKrodfZ6PAW1qk8mAGhzaLqqFJYh4BBU6/ne4gNKqr7e8qvb/t5bQKwh52pc/Q/S7qK3+WGWlLF67kdygjK0hJd+fmUjiI6D8vHES0q8=
Received: from CWLP265CA0536.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::18)
 by VE1PR08MB5631.eurprd08.prod.outlook.com (2603:10a6:800:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Thu, 21 May
 2026 13:30:42 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:400:18d:cafe::28) by CWLP265CA0536.outlook.office365.com
 (2603:10a6:400:18d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 13:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 21 May 2026 13:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq3GlKQhR4D2ZqsDQmrMkscg+hVp0oH0lFnSdmXzhg16AiUZ8ccDH3T/c4B+cDuR9a/zDS8+M0sfEpjlSG3Ppw0ALiiIZin5J4VdXLqeqg8RAvAxTHpB0VNSw8BOExH7xpjAvam/yLaTgybC43Bvwxeyp5EWYZjOiNBIOLxuqXiv+Mb5c6Og7GB/frE0eo0xKc95MJko3vTTu4UfgUASh892Fln2RH/Py5zAZQn3yEhjS9/3UFTM2L6u2DotOZ/fi53cT0palbBB1xl9BG9tlhfnvaEBaCEDOpRHSZGAQkxFRweLrw5bE/2VgBeWdD6d3K14OG8lGTSQ3ywUbGG8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxjg9+EgO7/IwjU66A8gK4jDj/uvCotrUhnp5nZkIEs=;
 b=OPfNsDgT6m82ZiG8r0GK3aT6YKXkVcpknPT5Ny+AP3rDHDOy/+P0FvH6eBSrrEgvDCg9eAHnxSH90GmbK4zDq2PEgoD0T1zq4WwRV9/Yq/XOBjvDEWfP++tJM0t9kmYNj3zWifIKq38CCEx3waFivxIfbndDCQG8jMMe+5noEgGSZ9GeNfpa9S6DZ7fXAhxXQKPVfM5giB6jZRyzEx1mn4BtdRbAyX369tgSfOFDtbe9cxN/0PNsPy1akMj7MVSh2qTtdOUEiXsl6xOW+j4AyRLw1pnQlWuiAC2jlgvSWPe/qa19p38pcO0oipNG/oyKaNNmoT3Hy93/vN4MExLXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=multicorewareinc.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxjg9+EgO7/IwjU66A8gK4jDj/uvCotrUhnp5nZkIEs=;
 b=Sf9FAb8pwT6T/xSIUmmsYT2JLexKM2BVbEmqJYS769NHVrrRFvQ1bPl12FoEhsXTzggJKrodfZ6PAW1qk8mAGhzaLqqFJYh4BBU6/ne4gNKqr7e8qvb/t5bQKwh52pc/Q/S7qK3+WGWlLF67kdygjK0hJd+fmUjiI6D8vHES0q8=
Received: from CWLP123CA0073.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::13)
 by DU2PR08MB10132.eurprd08.prod.outlook.com (2603:10a6:10:49a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 13:29:34 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:401:5b:cafe::44) by CWLP123CA0073.outlook.office365.com
 (2603:10a6:401:5b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 13:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 13:29:34 +0000
Received: from AZ-NEU-EX03.Arm.com (10.240.25.137) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 21 May
 2026 13:29:34 +0000
Received: from arm.com (10.34.128.56) by mail.arm.com (10.240.25.137) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29 via Frontend
 Transport; Thu, 21 May 2026 13:29:34 +0000
Date: Thu, 21 May 2026 15:29:32 +0200
From: Evgeny Karpov <evgeny.karpov@arm.com>
To: <chandru.kumaresan@multicorewareinc.com>
CC: <cygwin-patches@cygwin.com>, <nd@arm.com>
Subject: Re: [PATCH] Cygwin: autoload: add AArch64 build stubs
Message-ID: <ag8IvAkqoNVM-AH2@arm.com>
References: <PN0P287MB0295342E2109C2CB8EECCE6B92062@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PN0P287MB0295342E2109C2CB8EECCE6B92062@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM4PEPF00027A69:EE_|DU2PR08MB10132:EE_|AM4PEPF00027A5F:EE_|VE1PR08MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: e98077e0-dcd6-427e-847c-08deb73d2731
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|22082099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 5nCjnuagM9uBEJH56zoAY5J2UENkX7rlUpwM3nQOjjfjPa9sk6XsMiIgHebgFOq7DN6PkP0HjkJVkfa8b19NiV1MoYcA/Pb3Ld2R6IrPOiCUgkYfNhYpV5HjWiYQDYVgM9mdAoqxvmB2FWDbciybQlfT4NKqa/NhAEvbgnv9Ibo52BwBYn36UDCHX7boScVP0t1goeRnouyBpqVuthceIu4EJAkU3Og/fFnTB9ljc+AdQf1Gv/mbxRVFgIiIhrkhrvVs0cf8rZDLgpMZYdiZTlNBoL8ZXXY8FA0U/67foArTZ8Lgv7giJ4gDeVrCr2dRoJh8c+DuGMUhvJlJqEgI0FQ19pZEWXdAgBin1J9tNlb9Ei7oL+G+oVAeHslD+mkBLLr8DMiCJMOJpQGldQzAiAqfMcbpux/1kj8mj0Ulavud2RKe1l9sx6v5UT9tIYQtPcBJudAeoMm/bsR9CtNRTFvCtjioiZgC64G5QMV4AIeqy9jUDee7rEBM7g78fHWfJl9mt7iDkWe61YflTJwXOADY50ZlBJs3aqeuuGLFLLgM+26u/dNissASRbLcTO27U5HoAwTZwWUlKLNXNjIgSgU09lTKX74p6Sw/VfuKL5ngTHwNuaMkARfhlPsjE6mGzyv4HhzPoEB44cRk8NHSz/oo+vaPtAatDg9VlnLon6FiSY8lRUK+vKLhLB9hUKlerog35GFrkSzv9TTCVhLfCqKKtHvKA2rOm1zXldLhnak=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 KMn1EhGa2IQ0mB9ntbeeWCVYQXCuxnufbY02Z/NlU7UJpMXaZsglgmb4A0yYdOo+lWyalC8cLWFMNJEoaRbcgXLgkp0cZJ8cdhCbMqwGbG/JU59i+U2H5mCz27x7xzjmMVrDSPPvJb3cHdjGZ5HyJGOXbmQppBIdZEIqXS2ACOjPD5Ag6rydmfr9VlG3yOpCdb3kFjRVWuyYJeMfXP2BH63yKH7C2CMG1Y9j9W76SSqLtPnMeSTgZQbWlRpOTXkpqIODSAs5QgtJJY3lMs4qb177TFcK4twHu1ks1+ap4UYqKdod5ZFGw49HxI8CCcZ2JGjihOQWbEypZpVAdg+dZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10132
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7167e349-50c1-4ab5-8c15-08deb73cff99
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|14060799003|35042699022|82310400026|3023799007|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	HOlqRFaA4AjwHqbxPRdEbJcBuyLnAB+cOpBAoU+75/i8Dy2O6MrUORT0fLU4drIzmf6dXZlbZ0O6/7A9D9J4ynJL1gjhsuLgfLfVpfsPRDV0qaSH712MuQwLBWOecG3bkh5R7vjO2W5pt4DvcbkXesLL0mjlo9zrFiSWEmuM5L6mWZwU1aPhbnBo2oWafzOAjJF9O0JPhiAnH2cpOzrxxOrcm7IR26Hx4cyGDh14A6Icix6GfBN86DeOp198aG/DWLSOycmYddbvEKPEJhx+qRuCk/C/0iudX4XMeNni+jwwqZ+oUmq3CsfM/SIyNEgDibrbT6EgyvGEXgrS5hT7kW0FxOECZQLTSAW4vN7/c7mT19ojCK8SlkxOalriXYOnAVN9PWzt0XfDYQj+sH7qniLNzFbScG1yfU4ObMkHn7r3ze9428A0WXYKMB6HCTDmWGOfbjEW/Hm5pEQRJb0Ltk0EmV2TPlBPJbOW2KRcTcEYE/3j/uhDltyyJq4FP6dP84gKVcXhytJMqaoni2IU87tuwy5wu0FWK1NgANtfCSD5ZO6d7cm98vmWaTS8nEF8EGAoBcvKBArcWqD8MhrFJVQPaIxRKsZ4fxTC7S1bWGNMvwRDfO9bu2t3dGHfKJO8SK5QOlO/NtnYEcMvoi3/vq5h5MMIcciyROpJhuZ4WHeIeJ9vcwTROYMiFp2VKb5s+6H6eF7cO4qVrbIfgyXvlbFw1paGs24u2Y0E/jj9Vu8=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(14060799003)(35042699022)(82310400026)(3023799007)(56012099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cbd4f0jwW+14C/JpjSE3RWbL6D9nKmRXIre9cs/pIE3gXVJPYhqMVqbrwRhNGAU3aEAmmb9T7DJRhSIv4tkFz6UhHS6OQMhZxHZHyMa04vIPVXW7nR8NZrRydUgtJMM3a9JFW008Q3M6XcMpkm8G01umLXSVB2trMES3EGi21MvnjMAp0bX2nxgN5K4lReNGk/Pe5862iZwNuQKZor1QZFM9WhLjYJMky52K61c9WMlnXabeebNJPFY+3+yAKjH6xV9qqLYv45qchx7K6JKNU2SeRhWt1eiHnRd3FWMOQC5iQugPp4m1VdbOAsXEs2Xrf6tEeNWoZO3y6qkC2LuLDjJrqNDI+vg0tficyew4J0tj73hC0ByjEEgFHCmyl4/ZidKhSPu9+IDbHFYEzIao7ePwLiSBAArdUA6IhkQGe6HFCfaeB749/G96yRoS5R2z
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:30:41.1266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98077e0-dcd6-427e-847c-08deb73d2731
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5631
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,LOCAL_AUTHENTICATION_FAIL_ARC,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 13 May 2026, Chandru Kumaresan wrote:
> +#define LoadDLLprime(dllname, init_also, no_resolve_on_fork) __asm__ ( "\n\
> +.ifndef " #dllname "_primed                              \n\
> +  .section   .data_cygwin_nocopy,\"w\"                   \n\
> +  .balign    8                                          \n\
> +." #dllname "_info:                                     \n\
> +  .xword     _std_dll_init                               \n\
> +  .xword     " #no_resolve_on_fork "                     \n\
> +  .long      -1                                         \n\
> +  .balign    8                                          \n\
> +  .xword     " #init_also "                              \n\
> +  .string16  \"" #dllname ".dll\"                        \n\
> +  .text                                                \n\
> +  .set       " #dllname "_primed, 1                      \n\
> +.endif                                                  \n\
> +");

LoadDLLprime contains only data. It might make sense to keep only
one version for x86_64 and aarch64, and use WORD64 for .quad/.xword.

> +#define LoadDLLfuncEx3(name, dllname, notimp, err, no_resolve_on_fork) \
> +  LoadDLLprime (dllname, dll_func_load, no_resolve_on_fork) \
> +  __asm__ ( "\n\
> +  .section   ." #dllname "_autoload_text,\"wx\"          \n\
> +  .global    " #name "                                   \n\
> +  .global    _win32_" #name "                            \n\
> +  .p2align   4                                           \n\
> +" #name ":                                               \n\
> +_win32_" #name ":                                       \n\
> +  adr        x16, 3f                                     \n\
> +  ldr        x16, [x16]                                  \n\
> +  br         x16                                         \n\
> +1:                                                      \n\

Why are these 3 instructions are needed?

> +  sub        sp, sp, #80                                 \n\
> +  stp        x0, x1, [sp, #0]                            \n\
> +  stp        x2, x3, [sp, #16]                           \n\
> +  stp        x4, x5, [sp, #32]                           \n\
> +  stp        x6, x7, [sp, #48]                           \n\
> +  stp        x8, x30, [sp, #64]                          \n\

The same question is here. How is it used?

> +  adr        x16, 2f                                     \n\
> +  ldur       x17, [x16]                                  \n\
> +  ldr        x17, [x17]                                  \n\
> +  blr        x17                                         \n\

Similar question to this block, why is 2f needed?

> +2:                                                      \n\
> +  .xword     ." #dllname "_info                          \n\
> +  .hword     " #notimp "                                 \n\
> +  .hword     ((" #err ") & 0xffff)                       \n\
> +3:                                                      \n\
> +  .xword     1b                                          \n\
> +  .asciz     \"" #name "\"                               \n\
> +  .text                                                \n\
> +");

How is extra information after the first .xword in labels 2 and 3 used?

>  ");
> +#elif defined(__aarch64__)
> +__asm__ ( "\n\
> +  .section .rdata,\"r\"                                  \n\
> +msg1:                                                    \n\
> +  .ascii \"couldn't dynamically determine load address for '%s' (handle %p), %E\\0\" \n\
> +                                                         \n\
> +  .text                                                  \n\
> +  .p2align 2                                             \n\
> +noload:                                                  \n\
> +  ldr        x2, [sp]            // func_info*           \n\
> +  ldr        w3, [x2, #8]        // decoration           \n\
> +  tbz        w3, #0, 1f                                  \n\
> +                                                         \n\
> +  asr        w4, w3, #16                                 \n\
> +  str        w4, [sp, #8]                                \n\
> +  mov        w0, #127            // ERROR_PROC_NOT_FOUND \n\
> +  bl         SetLastError                                \n\
> +  ldr        w0, [sp, #8]                                \n\
> +  ldr        x30, [sp, #88]                              \n\
> +  add        sp, sp, #96                                 \n\
> +  ret                                                   \n\
> +1:                                                      \n\
> +  add        x1, x2, #20                                 \n\
> +  ldur       x3, [x2]                                    \n\
> +  ldr        x2, [x3, #8]                                \n\
> +  adrp       x0, msg1                                   \n\
> +  add        x0, x0, #:lo12:msg1                         \n\
> +  bl         api_fatal                                  \n\
> +                                                         \n\
> +  .globl     dll_func_load                               \n\
> +dll_func_load:                                          \n\
> +  ldr        x2, [sp]                                    \n\
> +  ldur       x3, [x2]                                    \n\
> +  ldr        x0, [x3, #8]                                \n\
> +  add        x1, x2, #20                                 \n\
> +  bl         GetProcAddress                              \n\
> +  cbz        x0, noload                                  \n\
> +                                                         \n\
> +  ldr        x2, [sp]                                    \n\
> +  add        x3, x2, #12                                 \n\
> +  str        x0, [x3]                                    \n\
> +                                                         \n\
> +  sub        x16, x2, #52                                 \n\
> +                                                         \n\
> +  add        sp, sp, #16                                 \n\
> +  ldp        x0, x1, [sp, #0]                            \n\
> +  ldp        x2, x3, [sp, #16]                           \n\
> +  ldp        x4, x5, [sp, #32]                           \n\
> +  ldp        x6, x7, [sp, #48]                           \n\
> +  ldp        x8, x30, [sp, #64]                          \n\
> +  add        sp, sp, #80                                 \n\
> +  br         x16                                         \n\
> +                                                         \n\
> +  .global    dll_chain                                   \n\
> +dll_chain:                                              \n\
> +  stp        x0, xzr, [sp, #-16]!                        \n\
> +  br         x1                                         \n\
> +");

Comments for the execution flow should simplify reading and
maintainability. It would be good to have them for all
assembly changes.

Regards,
Evgeny


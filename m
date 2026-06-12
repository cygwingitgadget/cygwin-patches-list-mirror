Return-Path: <SRS0=9z8C=EI=arm.com=Mate.Dimand@sourceware.org>
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by sourceware.org (Postfix) with ESMTPS id 0FE844B920E3
	for <cygwin-patches@cygwin.com>; Fri, 12 Jun 2026 08:03:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0FE844B920E3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0FE844B920E3
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1781251425; cv=pass;
	b=eReaFC5hgJbMB+THSpIdSiquDjCO2j83WzGa3OqdhzrFxV3LEXsdl8WZNCT0ffn7EqrYbESk9bsnLBo0XOsBVXyoDsxlo7WG6N7um95x8wwh8zOQGRv1Z/tJmdy2895YDHIR0bo22VnXvteiLq02Dk4msnPUv/hVj9L02AbAE/s=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781251425; c=relaxed/simple;
	bh=hLTa36iINiWHvgDV+119X4vwH9hmueDBtOIyPVIuNeg=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:To:From:Subject:
	 MIME-Version; b=mL4vhTapsH1d8pPgBRnrT5ShC3cCcCyI9w8NsW5ZBOExgnkUrg9sbl+KUTiRphRmjAw8/qcDPf/dyacBJIVL3gY8cbB8TbmVXo3+y6MAHLCti3LuRN/oSXOqMwXmwM+nU2ng7D3zXcw5cmL1yPkg+2b5bfG5jVHQzuCKW3lW/sk=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LjlHuL9C; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LjlHuL9C
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0FE844B920E3
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LjlHuL9C;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LjlHuL9C
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TjRuks9FiOKlL2L5G+W92/5H/f2jT77IRjjlnZ5Lg62cnUwaix8s8+vdsVanJXlEAg7M0Yclxl6I2DpLCa5Uz6il+JChEp2Mx+R7rz/JB3MKSxkiqAI6yc/UcjrAN2j5/MMrqvvkq3At/fsoPG+0tCdhF3h2RNAbEDS+0NlMke3WSyuE+V55sYRwNaZ+74YwNHWI99xz08C2d11B+xEnjBn7BSaIJoef6eOjFTRT4s70x2WsEo9aJ8mJD7WMZQPY/rTsfVfFvG7091BV4pO87c3oZ1Ygu4gsDxSoNcV+/roM5cjrwsbvDfkaqmH84hOdiNfy4Y4UEUKdxsbFDEmLRg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6c7XRwevhJxBOSW6yZiDaQBkQnl4Zn0FC+BjyzWcbw=;
 b=U0+K7ekiSx6na+M/uxpYMfM+aOYBimE+gv7z78XuwHQ1HM+cnk8x84YvDaedxIb79Xi1ODefvqBnPITvzif4gGgn9qSFbaarojb0Cus+0HUkSuUs9fjtK4PHd7x8gM4GyYPOpd2yJI6VhSCEv1YBeBijbapcCdVHTrTDybb/5XhdHmQQIgTBMzELmeJ9VFxMIFp5ReOVicAinS6TmzEf4FENJaNpYV7ZjjagA7iARtmzFDW4OB+b6do9qefSmm+g8OBw6lUu0+xZofx8pidNn0MdIyl00+DsPA8UnsqSmGioK8K51PTPHSDOqKX5aFquN8Db0im5qtvEoCJgNUkyYA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6c7XRwevhJxBOSW6yZiDaQBkQnl4Zn0FC+BjyzWcbw=;
 b=LjlHuL9CK2Q8B3O7pMqKkd8sQFIRIeOiB/+W0GhUSyYZ1tWRpZGK137TTBsEVP/vdoE0cbg0wgxSjT3o5fgw0ufv5k945O1xxECbdW+RhI7AOppeRtgyg6tEHw6lXjGP92CFuOelrh+BkOhGtkcxej7ttVa8gJ/4MrwdtFcl2V0=
Received: from AS9PR05CA0322.eurprd05.prod.outlook.com (2603:10a6:20b:491::21)
 by DBBPR08MB6076.eurprd08.prod.outlook.com (2603:10a6:10:1f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 08:03:34 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:491:cafe::6c) by AS9PR05CA0322.outlook.office365.com
 (2603:10a6:20b:491::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 08:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Fri, 12 Jun 2026 08:03:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flIe6YLt4trKaBCp0c0b8n/rly9RGSDDfF1lv/YsWd+uehGYN7ODtBP8VTLmROWDgsbt1Z29u5JsU+EG5oj++KPrLT5gfRVlRb9ofdrpbjpPh7hL0LTUqqj+CyuhZsw2+eUljXPXGCysKKsmwp3opOAUXI6DSNPtQh3wuJ7BE1wcOBxJ64y1kTYsJKZykNc83micxpZVDP5JYF5tdPw7Eo4PDXzpJL3mBXwY0E3tV5D9jBK6zsRAgArEokMks2BJl4DqnZ1Eui0TG1/gK6AlGJdBwtkCvjvWCNaXkL2Yq9vyyibYr7R24YT/3ZeAnCmkCjTYkKDbFQI/TM8cLyxjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6c7XRwevhJxBOSW6yZiDaQBkQnl4Zn0FC+BjyzWcbw=;
 b=W0rvge8uLMRHYsDjdRv5vkT02dsTiZrOQdI7vCQyStX6Va9iaIQu2fj5/XW9vRXqf1IorIQXk1xVr2fJ/iMUDfd+FcaZGDXHFG+/a6nAOi8t4spkZLnjzV1X5ilCxWPjapln1FTk7FakBfEEhSuNtASBVSF/Z0AxOBj4RABLnpJUUQEPpEGhUbw+0BS6IJ/VR7C1qJJ+pmVlokzT4EkW98Hnm6utVTVX+X975UQ0bYhaHSuBxDhY27WFmVH5V/P5DiBxfMF2kBkT9UZbDKQGo7MHV2OtUJBSnENaOlLJ0m0BTf8XcBgV4/87y6Q18/pngZi99SJ/3O5UBmLst7NkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6c7XRwevhJxBOSW6yZiDaQBkQnl4Zn0FC+BjyzWcbw=;
 b=LjlHuL9CK2Q8B3O7pMqKkd8sQFIRIeOiB/+W0GhUSyYZ1tWRpZGK137TTBsEVP/vdoE0cbg0wgxSjT3o5fgw0ufv5k945O1xxECbdW+RhI7AOppeRtgyg6tEHw6lXjGP92CFuOelrh+BkOhGtkcxej7ttVa8gJ/4MrwdtFcl2V0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22)
 by DB8PR08MB5322.eurprd08.prod.outlook.com (2603:10a6:10:114::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 08:02:27 +0000
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576]) by DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576%3]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 08:02:27 +0000
Message-ID: <d8339a03-a0d3-4b0c-bb10-f706fcc6da49@arm.com>
Date: Fri, 12 Jun 2026 10:02:26 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
Cc: nd@arm.com
From: =?UTF-8?Q?M=C3=A1te_Dimand?= <mate.dimand@arm.com>
Subject: [PATCH] Cygwin: exceptions: Fix AArch64 non-incyg signal handling
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::18) To DB4PR08MB9310.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR08MB9310:EE_|DB8PR08MB5322:EE_|AM3PEPF0000A792:EE_|DBBPR08MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: e28dd7d5-2177-4c4f-b154-08dec8591946
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|3023799007|11063799006|5023799004|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 3SLHyDCnkXqAsH0RtgxXvw7buHMzqmTXnb5ZqE2RFW+AEZDWKSqEZnd/r6IDhYOTTF2qPw4eE5WPTmaZ1MoECKTYM84OMLn1H59Hd9CqpalX5CcF52kylTysrbPp69dyIE7jR03gV/juBOu4i3BCFsq7LSfVkMBNv1z6mVr2+kMS3X0ITe/e3mkNP590OIqNAw4Qg3Ps5fkMceisyp+CEVXZ1gOrtvF11z5dXot4jt76jiROsDNyJh/16rt8Af/Q8QwSFTgt+zmMGHzX3UsaVgARDdP/x/+eWwbObH/Icg1y9mqUi/eUz0v5S3DamcVIMlYErXx3krr1GW5CesofEs2NTFLqt62/txVqEZ2Ab0CS6uGiOdFunfxkwpbsGXHlt87zKk7xJ2Qp5/u25o2tMoTt0yHgAow7yVqjqE6h7r0UbGuYjcnov5fm9xBmbzXslTrth0bQKEWVzXKdMsboM3w54tfExahr7CFEWpQw4RqrAXX0N+UW4CM8tyuHUnwE0f++hiIZIjTnnnEC8g66bC2BHoe0Q7Amq1jPt5egBFoLPai2xPVeA2LyBvoejzF60CA8hZ8coL6wFuseebrC8JbBQ8FJfxm+DGLeppwbgQpzpGS1BhKHZnywaXEcd+U/Fog7pzn92yRpRS/iaVKySb4F387Qvf3SG//9ZPrFj3zZQ0TDUYdl+yvSJstRc87y
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9310.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(3023799007)(11063799006)(5023799004)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 SVdAGbOb+upOZ6QCqnjrcbgPfJLaTJba7JCkr5O+dyo38ca8qGiANnCPUZ5lAVsGyOevFMRt66CLAcJKK4rQfmopAja4w/N8dpLIg+tp/Wj0fAvYITD+krreHD8/NIHWiiKqKHw4W5fTbMmpX85r1ul5UlkPhDft8gDF1XhQf0zToVzz/tspE9ojs+EKLK7ULL9R06G3IJOOYBtM8Mi6JpiHPiMFU5fqt5g36IreEXRTgQ6vuZb6VH2qbpyVRyqNbaOitTFKCGiYLBzPFxQn9W6ajexoMtuzwgXCvrBnA1JVnuaw07d71jGTaUHVWIK9VrRs981mFsGD7XXt1GahNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5322
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0115a7a5-49ae-40d6-1d5d-08dec858f189
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|35042699022|1800799024|14060799003|30052699003|23010399003|6133799003|18002099003|5023799004|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	QWdJoMAkrprpLhpMRicSU9kn4c7zLBrL+Ptt9sxV31s+c9WxA5m63DalcpW932EyNceTAG/1Mv5PAzTbkeGhFnf9caZgTjWayuNIQnd5l+7LjVhKPfg5TQuMUz21ranD72MCbf4OKRZJKKZNMJM2MdqkcHHriLO/b+t0PvRjs7yss9ShlqG+yZsfOv6P8BCuKNW+scSaCKb84FJandktsCOjWPCCdlTOqtE7ltv5Iq7+VKl/zDidyxzlDXHgWHYGYxxv3hJijEymD93as0qMTTMAUaNxRWH5d4pnirclLk17WJRzz/h5RVwf33hxCyqFx1Q9oyCLApQvyYUAQF4iui5iE7DQswTtvpApbv5vSRIl6BLEy7extMRgw2S2JwG+ZRRBKFDdNo7YQ7whUCTXWaTr6m9mq/Nl9B/mqBXIomBuffG5HQeX4gctYI7fbF5xpSsz3SS3EsvPnBwDvgFPjx9bWlqlOaSPbLzgxtiFf8o81BaZA8qvdBlYSU+h8INYYjve5BeiqZ5HzLV4bwtCTicJecxtPFunQLtjZGODbf6XZ9HXG+wjB7M4898pq1Px1syVYTHP/sK8iCN2lx/LYDfNgv4b6/0c+vomWEifXZAfB+zO0c7zwYYRdpyLo23c7palzvuyIEkkSMzST5O+czrAWaGfQMvGx52etW25oKejRmdJbuSvcrKH4ZmY0JqKS22T9v3fksh+KocCh6QWMvbhEMbZ+rYPBbfHCROQoNU=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(35042699022)(1800799024)(14060799003)(30052699003)(23010399003)(6133799003)(18002099003)(5023799004)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P4VqOuMO2OwDAPEFAl81BSBX960zmhhPUoqI6JPekXy1NSGuW7RhsJwScuYRYukKhI3AbUdYl/3om5rft5ImBgBX6oqF+loH8dWv28KDzJTWMOAfwcaAaMcxmrfYnPWjiAW5NuG61OY6v5oP44VKh10gVhopDB8smmr0s1TDmFCb5dB/wg+FsndM4+kOLYp4tlscNC2r0bBHst74c+4BlSmC3OzJOZqflwXK/xBsaLNLTWPBEWYfq0vvr8xk4ofuU/EcPhFV+XBkPT9MO3Dt2D3yzoNURCmdDtzaWizYW6Lh+M1qZLFG2krDRBuVb1yTATuroezIDRS/NajyAZWu3VW8GAAkNvay5rKF6VRN8otlRT5RNjM6NrCIsNKjdjsiZs+o+CexbBJrSaqMhgkcbuP3stWnjjf+gKJK+HKjHUWh3tewmQBvYzQKOia0fiZT
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 08:03:33.4568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28dd7d5-2177-4c4f-b154-08dec8591946
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6076
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch fixes crashes that occur when a signal interrupts sigfe or
any non-cygwin function that does not preserve the LR register in its
prologue/epilogue. This crash was discovered through the "run-heredoc"
testcase in bash's testsuite, which caused bash to call "read"
frequently, leading to a high chance of a signal interrupting sigfe.

The "sigdelayed" function in gendef clobbers the LR register to return
to the instruction where the thread was interrupted. Picking any other
register for branching back would also clobber said register. Leaf
functions are not guaranteed to be compiled with LR being preserved on
the stack. The solution is to use RtlRestoreContext to restore all
registers without needing to sacrifice any.

The patch includes a C++ version of sigdelayed, which calls
RtlRestoreContext at the end. The non-incyg signal handling codepath
will change the thread's IP register to this new function instead of
the original sigdelayed function written in assembly. Cygwin functions
interrupted by signals still use the original function.

Signed-off-by: Máté Dimand <mate.dimand@arm.com>
---
  winsup/cygwin/exceptions.cc           | 87 ++++++++++++++++++++++++++-
  winsup/cygwin/local_includes/cygtls.h | 13 ++++
  2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 1e129b319..d3fdb2a44 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -947,6 +947,56 @@ singlestep_handler (EXCEPTION_POINTERS *ep)
  }
  #endif

+#ifdef __aarch64__
+/* This function is a C version of sigdelayed, with the CPU state
+   restoration code being replaced with RtlRestoreContext to ensure that
+   LR does not get clobbered. Note that this function should not return,
+   and the stack contents created by this function are left un-popped.
+   This should not be a problem, since the context restoration also
+   restores SP. */
+void
+_cygtls::sigdelayed_non_incyg()
+{
+  int backup_errno = saved_errno;
+
+  call_signal_handler();
+
+  lock();
+
+  if(backup_errno)
+  {
+    *errno_addr = backup_errno;
+  }
+
+  /* In the asm version of sigdelayed the stack is popped to restore LR,
+     however we already have it in the stored context, so we don't need the
+     popped value itself. */
+  pop();
+
+  /* In order to stay accurate to the asm version of sigdelayed, we also
+     atomically clear the return address. */
+  InterlockedExchange64 ((LONG64*)stackptr, 0);
+
+  /* We copy the context to ensure nothing overwrites it
+     after unlocking and before restoring. */
+  CONTEXT cx = sigdelayed_context;
+
+  incyg = 0;
+  unlock();
+
+  RtlRestoreContext(&cx, NULL);
+
+  /* If we got here, something was wrong. */
+  api_fatal ("Failed to restore context in sigdelayed_non_incyg");
+}
+
+static void
+call_non_cygwin_sigdelayed(_cygtls* tls)
+{
+  tls->sigdelayed_non_incyg();
+}
+#endif
+
  bool
  _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& si, void *handler,
              struct sigaction& siga)
@@ -998,10 +1048,31 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& 
si, void *handler,
          return false; /* Not interrupted */
      }
  #endif
+
+#ifdef __aarch64__
+      /* Copy unmodified context to be restored by thread
+         after signals are handled. */
+      sigdelayed_context = *cx;
+#endif
+
        DWORD64 &ip = cx->_CX_instPtr;
        push (ip);
+
+#ifdef __aarch64__
+      _interrupt_setup (si, handler, siga);
+
+      /* Instead of setting IP to the asm sigdelayed pushed by 
interrupt_setup,
+         we redirect to an alternative version of it that restores the 
CPU state
+         using RtlRestoreContext. */
+      ip = reinterpret_cast<DWORD64>(&call_non_cygwin_sigdelayed);
+
+      /* X0 overwritten to pass this _cygtls in first argument to 
call_non_cygwin_sigdelayed. */
+      cx->X[0] = (DWORD64)this;
+#else
        interrupt_setup (si, handler, siga);
        ip = pop ();
+#endif
+
        SetThreadContext (*this, cx); /* Restart the thread in a new 
location */
        interrupted = true;
      }
@@ -1009,9 +1080,8 @@ _cygtls::interrupt_now (CONTEXT *cx, siginfo_t& 
si, void *handler,
  }

  void
-_cygtls::interrupt_setup (siginfo_t& si, void *handler, struct 
sigaction& siga)
+_cygtls::_interrupt_setup (siginfo_t& si, void *handler, struct 
sigaction& siga)
  {
-  push ((__tlsstack_t) sigdelayed);
    deltamask = siga.sa_mask & ~SIG_NONMASKABLE;
    sa_flags = siga.sa_flags;
    func = (void (*) (int, siginfo_t *, void *)) handler;
@@ -1037,6 +1107,13 @@ _cygtls::interrupt_setup (siginfo_t& si, void 
*handler, struct sigaction& siga)
            signal_arrived, si.si_signo);
  }

+void
+_cygtls::interrupt_setup (siginfo_t& si, void *handler, struct 
sigaction& siga)
+{
+  push ((__tlsstack_t) sigdelayed);
+  _interrupt_setup(si, handler, siga);
+}
+
  extern "C" void
  set_sig_errno (int e)
  {
@@ -1097,7 +1174,13 @@ sigpacket::setup_handler (void *handler, struct 
sigaction& siga, _cygtls *tls)
            ResumeThread (hth);
            goto out;
          }
+#ifdef __aarch64__
+        /* Since the non-incyg codepath uses a C++ version of 
sigdelayed, we have to preserve
+        the FPU registers within the thread context now. */
+        cx.ContextFlags = CONTEXT_FULL;
+#else
            cx.ContextFlags = CONTEXT_CONTROL | CONTEXT_INTEGER;
+#endif
            if (!GetThreadContext (hth, &cx))
          sigproc_printf ("couldn't get context of thread, %E");
            else
diff --git a/winsup/cygwin/local_includes/cygtls.h 
b/winsup/cygwin/local_includes/cygtls.h
index 0b5255495..1ad98c844 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -39,7 +39,13 @@ details. */
  #include "thread.h"
  #endif

+#ifdef __aarch64__
+/* This allows us to use the CONTEXT struct in _cygtls without
+   violating alignment rules. */
+#pragma pack(push,16)
+#else
  #pragma pack(push,8)
+#endif

  /* Defined here to support auto rebuild of tlsoffsets.h. */
  class tls_pathbuf
@@ -191,6 +197,9 @@ public: /* Do NOT remove this public: line, it's a 
marker for gentls_offsets. */
       aligned. The gentls_offsets script checks for that now and fails
       if the alignment is wrong. */
    ucontext_t context;
+#ifdef __aarch64__
+  CONTEXT sigdelayed_context;
+#endif
    DWORD thread_id;
    siginfo_t infodata;
    struct pthread *tid;
@@ -229,7 +238,11 @@ public: /* Do NOT remove this public: line, it's a 
marker for gentls_offsets. */
      return initialized == CYGTLS_INITIALIZED;
    }
    bool interrupt_now (CONTEXT *, siginfo_t&, void *, struct sigaction&);
+  void _interrupt_setup (siginfo_t&, void *, struct sigaction&);
    void interrupt_setup (siginfo_t&, void *, struct sigaction&);
+#ifdef __aarch64__
+  void sigdelayed_non_incyg();
+#endif

    bool inside_kernel (CONTEXT *, bool inside_cygwin = false);
    void signal_debugger (siginfo_t&);
-- 
2.51.0


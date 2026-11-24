Return-Path: <SRS0=pTEM=JN=arm.com=Mate.Dimand@sourceware.org>
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by sourceware.org (Postfix) with ESMTPS id 76D4840AFC7D
	for <cygwin-patches@cygwin.com>; Tue, 24 Nov 2026 12:12:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 76D4840AFC7D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 76D4840AFC7D
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20f::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1795522336; cv=pass;
	b=U7kbAq6DwGSb62G/5TY2575huZ6v5pwITYnfaOfFJDqcFViJXQnlkU5MDDWrhG/e1rxOPsWNWn9T6Yi/384uM/CULCR0RnN651yF6tUfSF7LcdrX0vG3JbGGDfHjn5htnNfwgt3Jv8HmJqOKpbVWEzkaP8UW1N7F21/3JMMLBsE=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795522336; c=relaxed/simple;
	bh=tnT2ST6KsXd0NYmlgkrr1K2CuG2c9sLA5mTxkeuki2A=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:Subject:To:From:
	 MIME-Version; b=fGDH2MRaVbROSfIufTXXTeMaWoOf7H91h2K5f+2r/fUJymaY3mlCdnIJG0/rBBTeToAVscv9z7js3QSAi5GewcH79cjbU/F20s5Mr+kACRvoZvoXA17wk2/sGQIYonMXEx74jDTdWXqzu5lE4aCAis8k9nIq9Yy5pHkXCHLI52E=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Ske1JEvg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Ske1JEvg
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 76D4840AFC7D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Ske1JEvg;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Ske1JEvg
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fThPuyYAu2hysH42jMLe83hWHpSVu7CyFPN82pCepEh3PyWKaP1xcIEDHtkiLeTYadrGp7Z3Lqd8dWCP5F7SOAhbilA6A0FA5jh1aY2/c29Phlo3TrCVaRerdThsE/eixtGyrGVEj5dmwGDw8U7FbWJSnRBFP/wHMSRQxicPbr5EydwweeE6pQhLhboAueO7O4MqCHEwiqTh7PYUiNK+rct5RthKwNreBnryMWwSEpFaGSTYuikxbGagHbtdcv1h2hTNcvgzvucKzed6HWOvFq5Rg6rUjw02X4KY4NfCXV2wx+2UNOa3bYlmWag85oAoYN4ruTdYtgDvLe+q98Y9qA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KiGJDAwaszeI4P2rNxfXLshhS8PTEoiSbY5pxENaTo=;
 b=CCxSXLrNk9wWZf7BNIjbOavYGpUkugdsnSoA2maxjim1jb4hOezU1VonPPgY7Bt5uD6G5jBxcF0odKz4vmEG4UESQRvzdYBWb2ehOXNi5WnT7XGGIpJQXXZOLqHcQoa9JUNYgGYOGd57nKL6yUQdvisrCtF23/M0OO57kLxPlBMrFpizMwNh0l7U5+CHTxH7ryIkeSN4QDztuogEMyFB7n9/xSvCy4/VBxdEOcpWaqOEASHBFlIM9fARnj197QnNqfuxBjcgI/l0WxQuCF5707ZCmpmXJWhibnWEV7p/TZ/9yx77Xa+vMgCAJ8H/AMWTRikCzGhQLExzDHKYDoH94A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KiGJDAwaszeI4P2rNxfXLshhS8PTEoiSbY5pxENaTo=;
 b=Ske1JEvgioRm+h8fEygBiGjhYI0I8IDmkH/jNPoa5jZNhiIs4vwqMNA4N2M66hnNJe7X7C/aSG0ReZu97QYYqFDGHrdWtL1rTscgBR9fRf+l9m5w05puqJrVd9p3zSpFhOgGkDZgbb9y8gRGO8Xb6+2hk+3ricr+Q3AFOAjVkXY=
Received: from PR3P251CA0012.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::27)
 by GV1PR08MB11075.eurprd08.prod.outlook.com (2603:10a6:150:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 12:12:11 +0000
Received: from MI3PEPF00008551.eurprd05.prod.outlook.com
 (2603:10a6:102:b5:cafe::64) by PR3P251CA0012.outlook.office365.com
 (2603:10a6:102:b5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 12:12:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008551.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 12:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL83DeYAcQmxcEWdQvtDPGgZmYQAw6CltvGqn2x5Uzf/+V0g7syBOyChsaqtKslApGk9E3ALsM/BTKuurJhYYXwxZs5NvsgwDhal2crKb6T9nu7OEdwFrgX7I36Quo0/Ne/MI+lKt77CB/re9f3Ep18StDkXE9VOweELdE2wcD0USkPWVVd34ryQA2zjeRQ7v65mtVFUQmC/1d2+ggK7Cd+/fmonuPDGtBqf6dFAfbBirbLtuDWm6JXk/vP++6wnSglfidiuL+CU78hYUUp/vdxtO2fcNLZaDYApUQ6Sq1f+1FOs0sTzidYinuvKSjHNHkfvLEM7e/m7HsyBJX1EIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KiGJDAwaszeI4P2rNxfXLshhS8PTEoiSbY5pxENaTo=;
 b=SMkkLrkrdN0kKVsI/iQKRgUn4AIUnkQT9Zg5ritX3qeCknNeP7eTm4bRWto/NG65iH4yKNhZB7Ts/aEhpFhTuJJ6deeYBM/pqeX76VBNP5FiJLp+j0eD0fU+6rTsUPTdun/NkNwn2kLNMi2jjSqZ/lGAsCNmAohAdmn3+ECFMNfl0Ig80EmxfIGRkO/T2M2AUGd6UBi+kh23WgYCcAtr9a+/PTm+hufoPE+t8pWaKZlYfD2Gmd9vRjNp+IaJvG+OHhbRnDFEIHWfJ2GwjulO6SiRs6M7tKKqV/Gfym1u+kFwuMPhh539j+SznJU9ItyyOiMVmpKPQ8jWJT3uRTpbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KiGJDAwaszeI4P2rNxfXLshhS8PTEoiSbY5pxENaTo=;
 b=Ske1JEvgioRm+h8fEygBiGjhYI0I8IDmkH/jNPoa5jZNhiIs4vwqMNA4N2M66hnNJe7X7C/aSG0ReZu97QYYqFDGHrdWtL1rTscgBR9fRf+l9m5w05puqJrVd9p3zSpFhOgGkDZgbb9y8gRGO8Xb6+2hk+3ricr+Q3AFOAjVkXY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22)
 by AS2PR08MB8949.eurprd08.prod.outlook.com (2603:10a6:20b:5f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 10:34:37 +0000
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576]) by DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576%4]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 10:34:37 +0000
Message-ID: <c301e89b-ae2a-4296-a538-df27c7a100eb@arm.com>
Date: Tue, 24 Nov 2026 11:34:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gendef: fix SEH directives in AArch64 sigdelayed
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com, Evgeny Karpov <evgeny@kmaps.co>,
 Igor Podgainoi <Igor.Podgainoi@arm.com>, nd@arm.com
References: <9eed0ee5-428c-420a-9788-67d14368f3b1@arm.com>
 <69bf89b9-73dd-40eb-951f-356fbb7ff3d3@arm.com>
 <99c4757d-b886-411b-9887-464999d363a7@dronecode.org.uk>
 <58a2c092-09a0-4c61-944e-b29d5d27b257@dronecode.org.uk>
Content-Language: en-US
From: =?UTF-8?B?TcOhdMOpIERpbWFuZA==?= <mate.dimand@arm.com>
In-Reply-To: <58a2c092-09a0-4c61-944e-b29d5d27b257@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0038.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::10) To DB4PR08MB9310.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR08MB9310:EE_|AS2PR08MB8949:EE_|MI3PEPF00008551:EE_|GV1PR08MB11075:EE_
X-MS-Office365-Filtering-Correlation-Id: ad20b6dc-71b5-468b-45cb-08df4a242aaf
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|261028144727099003|261022105027099003|261021123027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 0sffdmSY2eTI3p7D2/vDEWphlJrie12OcTC0UuRRShuXHZHg5QExYosaQYwSlObwhvdKReiwTib1DVswHoZgRjnfxfFhhjyQmJ8m496PQhZZyN282IlVR9uBvcH0zRGddCG3WvXtRmo7FUW3kJaT0CxCGGoVDHzaaKFCxjEbMChELE1eVPpKUVHIW+FR/F+vUm0G0ghV5qzT9MyrDfIPTDzWft4g046QTaaYx1LqTNIMUFUgQx3qqOjE9ZhO0Ek/QsDcGqQPWpBDpuNuw486sYABtf5DLqxUZF+0+H9sckwHohPaydr+AAb7CEqTnG/sEt+4PY4qGJ/h1ultWmP//MaD9w+JJvsvocKI6TpO5IPw0Ct2yy65t0OtpLvqCeQuH4PKREXLI5wCSKaUvFICQwmiepIGt+C73juZN9EqdsEU19DpCEcxvJ9o8cjC5hhl0n0ESckTXn60HBQ9A0jXk/Vuzxe9jf7uR3D0nMf2tsiV6L4UHnRY3PZpE/TGmlDFdW3qkBJFToKUB+Sb3vGrdlnmwTD/ybx7U5UQbwvfgN1vzVafXPsbc3/WuoNpoF1zhFwj6PzrvIoo1v2vKr3d8+5JYmaknm/bYoQm+L5pzPzM1Z2Isp9gmNIU084j5VHLd9yiPs9Tz7BAbehPmXow+XG+rZJOYdLarqfuE/zHlTQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9310.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261028144727099003)(261022105027099003)(261021123027099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ir9l5w8wPlDu8PJpqwxfk29msMc9uh/BHOeqGC80gUnDUl5enKQL5gJk2PzPxAAz+YIUnvKEaWxX9oImzcmtMH10EYG7qtj9NwglB948M/AXl/MXl/XSY0Z92CAyST7IEn+IaVs5jD2/RXw7DlLn1OOvB7XdaLDVAPc0CDN8tU4k91kpmnNrIYgKbhE/yT1QLbAT5Y4Gi0rciA2x1CCnCnbR9VYLTnSA1MzzAlvjMW363k8SeGXOltZosDgYbktOcH0XgtrbNsHjFXmJq8CAmcDIj/XuuSHAm3mN2WiVZqZGfagSEPs0n3ppSxWBQOCzuaUF0XPbtNJXGUGk234x8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8949
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF00008551.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4fe73f5e-8bda-4b55-6516-08df4a1689ab
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|14060799003|35042699022|23010399003|36860700016|82310400026|10067099003|261021123027099003|4143699003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	towzzg+YGBtzhPq88OkTOIZr9vSvsUez3aYfI+UhvsZH79NIputKHxNdkNQsPzPbINQxRShzbud1BKNtWXYA4AZUW8p8mkIU5xTx6lBsnXyPltKjHZJBirrtJs6Fu9dwXxf4VxT3CqT3qzTkZZXtG0dPmh57ww2K+gdBU67ptp4chV6V7QQ27EzfBvFHo9waoA9+fLpLYDhW3pWryWmNYMwam9Mq1fciGTPMU67KgyMBO64OgY/zZGMSu1aSJjL59akcVAsl0irJXTgMGR/mvqkBBdfIU1KDuwGRpSnj7xSKCBRR8IKspOgwASoZD/oqSz+J82wx/ewV5n1B8o4BKi8pImTvdNCWUlEhPZIi34wAWzPVhAq1RmIHiDgZ3j1yzKbSKKhm8wUxJoMZDkYOBUgVFLVUSYxIihN8LwCRSNSHGTh0hVTZM1CU2bmB+dZtQKIWnv8TJZUyCGA9SFeugyN8/nLvQY9oWfbz1ADpSCAkI9JPa3kstC5M9dIWxgkwqHT3pEMyK1s9f+hymAIQHwHMQcuDW5jDoeSNA63uippGKxzEAymXdhKjowI7OHBhP7FjR8FZK6Jy/pZcVTmgXQKnt32MApDpS2zDiakVM8XIbF/rYooTmYuH/7WES+gLorKeV93rasaZLyck7+z7NZJvI1arF9pIZwCiIexJrYaxGjOci4wm37xEtOmv4qu0uJAdy2lYQA8/QdyMgwtV8w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(14060799003)(35042699022)(23010399003)(36860700016)(82310400026)(10067099003)(261021123027099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XSPRVMTP7jL5KdSSuf+YCcztpGRpFTWXCmGa9dqy+ZeFPuZI1gnbNGqjlhFNXV1+dL9+jN2dnkY2c+QobuovgH6TI8rW+BBlBFJn8Ncvg5R7SI1/hYiQLv/WBAyuRsd+CFCiYDhliLa9aMsTSFyBHrItc8WAEZyTM0Gz3qbtp1QXzHnzO1JgEuCxepybTd6TR8elmp8ZlALDi6Sc1KyGMqOQSVSuv/0Vi1MbpqJP0P/wanMfP2bMDRZznslJeJIA8m03UH7uvYfVREiJLLSGuJr0+CgahrcbWG9U5FS5MpoOQTTwqqolen/tRYVfFGygN3yHQVxD+Zaz8aHPSs0xvsgYLXv8isNXIJcIsbuzRZY1fz8cvuxIBwKyIlRpxVCxQgRlT8NXXfEJhA0YlT6SGw2eVUGjYuEMklH7KRoRv8jT6PSZXsi0+0M/7xSBN3J5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:12:10.3418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad20b6dc-71b5-468b-45cb-08df4a242aaf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008551.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11075
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GB_MSAUTHSOURCE_EUROPE,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

Sorry for the delayed response. I can confirm that all Cygwin patches 
contributed by Arm employees (Máté Dimand, Evgeny Karpov, Igor 
Podgainoi), including past and future ones, follow the 2-clause BSD 
license (BSD-2-Clause).

Best regards,
Máté Dimand


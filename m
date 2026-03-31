Return-Path: <SRS0=hkK3=B7=arm.com=Evgeny.Karpov@sourceware.org>
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by sourceware.org (Postfix) with ESMTPS id DE0774BA2E17;
	Tue, 31 Mar 2026 13:34:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DE0774BA2E17
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DE0774BA2E17
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20f::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1774964054; cv=pass;
	b=lKZYPQj/qa6jADv2sZVuMAiVwxczCc5P5QP7IjpAJ0/4f3ffiijRlnTDwLNt7KrkeVpQdOvFZnw5lIZhpVkH0sND/OU14nwthJPRi0FwbmwlZ6FhIvC/qU5b0ZptobmR1aaBS/GzI/7/4Uso0x9elhJS3qdn7NeiOvbhiVmP2bU=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774964054; c=relaxed/simple;
	bh=XtOCXmhbtwE7MUin+Rw0tAPtYz9ruUOfr3Nn0hhCrhI=;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version; b=pC8i9YsxgB6KY3Up6F+Q564JCXH8Jr02vvGaQnVvy18uXTSweeoUQtsLHfqLdamr2OUbok/mKdxPQViiUU8hL3WSe/6uri7/lU/z5GpILGGBD3hdjFJBFWoJAqdg8V56ZShIVzH9wdMMwDaVh374zDsNPdkutEAfo/zwbPTEUik=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DE0774BA2E17
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=lXIPvR6W;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=lXIPvR6W
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pNKUse2wzziFHcJuM5qEXKm8d1LpBEF2SSB+yYOwc2/l3YuAihQY1Y1yvna+lgBCasUr5SSEYyvavqxLHBo0nOHHmOIGp2PSNMR3EXQt683NNzK5FHPY8D5EEysrVQy0j155MoSCt6jJu600tLFdrzIMZc8fCq8njXeil2QC9ln+9KLy0PQvbLOmf99BBrP4L9SZluakeZnq7B+u5wy6JGV1DyOakpATQ2vqv+lZRGnJc3LaMH6oTXMl2R4BkA2Ly9P1/CnBzV4ho7PvmstdUOU6iPAbstU/YJyH7n3oNAN/LgLvlQ6tG0uyY6cUXa+9Nn9ANhqBFDJAIzaK6nGBPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtOCXmhbtwE7MUin+Rw0tAPtYz9ruUOfr3Nn0hhCrhI=;
 b=viQeRadPRiq6Itsl3e0gQjGyzEVGSjuZ9KMDwzBNOyBzRm1ZOtqryKWqRm3ZwZCO6MNZFShFa9O4xzFUD8lztvuZehHF33wZ3hHRN4Vq8UpMt8lGAD/DfUdDNfg3OEq5/YZAcN8/Bf9VyHi8TYtp0DDxjMi+VoKoxkEtL1rErXbBKZAi+O8RuojfCexhChcTY0+31d+DdeMmPQN9iQ0rHIFNzmeWrT5Q3iCczAOzbRZmZmJsz+okKRCOGc8PekpmJ660fWfdBvejCr70ZZB5fnvlItFDrnwrt1igXGkXYtgFdzvg3zbrXAokJqEMt/plvpMGOrgF+uU0ZQ/cK558qg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtOCXmhbtwE7MUin+Rw0tAPtYz9ruUOfr3Nn0hhCrhI=;
 b=lXIPvR6WmqkfzVpE2daKGqRBHlF8E4D/gO/zCRJoagM7NNHriNHr+kJzILCVzOIjvTU5E5M/cMpaZY7OQRUt+rF580o3iHjgl7fzggCsYfcwoX+nsFBQOzujp/DuXhq0PmYN1FU94d2CGRENiQouEuF3Ae50fgl0CoemslR3mOU=
Received: from AM6P192CA0033.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::46)
 by DU5PR08MB10756.eurprd08.prod.outlook.com (2603:10a6:10:51e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 13:34:08 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:209:83:cafe::88) by AM6P192CA0033.outlook.office365.com
 (2603:10a6:209:83::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 13:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 13:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBlCDJuSEwFWYjs60HsfWD6fKM7Ac8R50MVVbMTD04KQhN+kj3n3UVcGW9epoX+RN0sLh8Ab02txdVHFywGZRJZpJd+7p9Qljw3FYsp1LTWXPr6jssI0LXtsbHk3SrlaBD/7OmAs2xnHHyqptKyAw2j0W4yRgjfzVtiEnG52nWdLKE3EVi6xl7s7BSyYexyo736dAtNLhY2Uf6YjERQ3etxeM0C+TCVQMWu5wQybI0Asxszjr9lCqoXvjgUAEgeISAg6axwBBxdJRMFSIR0dWfClJSj1Fyo6vWPfT1Tk6FpDhCcBo9k1rKuWHriXbAUGeCI3NAjmsdGLy4Z0JAkS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtOCXmhbtwE7MUin+Rw0tAPtYz9ruUOfr3Nn0hhCrhI=;
 b=meOhzXqs5jd7CzFYq2e9OeS9bdC93P5wefeL4mxkFIGpwevBcR/sMT02Ddui84dG4iMfjdjLtCu8oXm49VcXmGjYNmzgYi2HSE41+qifgldyiYxNb21CkweVdx84Yg1eI1QNXTDGHG7ovjDJtg4bDf/xKQZHuHV45ceLlovJvJk5GSdiIbRDM1CI7uLgJHLrpzv0OlH0X9/qdb9eqNMc5z/4f7KWE8DNpS3Aj1/plDO/OCGIFyRYy9Me2LK6+iwHtHUaODMCNHukVbi24EcO/45mz/2uXdpA1pF4cNoMbDlL6FVOJSL21xPLzNbAc9GygcBurhpxs5VvEvBG68lCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtOCXmhbtwE7MUin+Rw0tAPtYz9ruUOfr3Nn0hhCrhI=;
 b=lXIPvR6WmqkfzVpE2daKGqRBHlF8E4D/gO/zCRJoagM7NNHriNHr+kJzILCVzOIjvTU5E5M/cMpaZY7OQRUt+rF580o3iHjgl7fzggCsYfcwoX+nsFBQOzujp/DuXhq0PmYN1FU94d2CGRENiQouEuF3Ae50fgl0CoemslR3mOU=
Received: from DUZPR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::17) by DB9PR08MB11476.eurprd08.prod.outlook.com
 (2603:10a6:10:60b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 13:33:06 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::8f) by DUZPR01CA0158.outlook.office365.com
 (2603:10a6:10:4bd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 13:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 31 Mar 2026 13:33:06 +0000
Received: from AZ-NEU-EX03.Arm.com (10.240.25.137) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 31 Mar
 2026 13:33:04 +0000
Received: from arm.com (10.34.124.54) by mail.arm.com (10.240.25.137) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29 via Frontend
 Transport; Tue, 31 Mar 2026 13:33:04 +0000
Date: Tue, 31 Mar 2026 15:33:03 +0200
From: Evgeny Karpov <evgeny.karpov@arm.com>
To: <corinna-cygwin@cygwin.com>
CC: <Igor.Podgainoi@arm.com>, <cygwin-patches@cygwin.com>
Subject: [PATCH 1/1] Cygwin: Fix SEH and signal handling on AArch64
Message-ID: <acvND9Immt9vB73l@arm.com>
References: <cover.1774613608.git.igor.podgainoi@arm.com>
 <042c0cc99b70b4ec9959d4977b8cfcb224200bbb.1774613608.git.igor.podgainoi@arm.com>
 <aco1lg07YbVH7rVR@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aco1lg07YbVH7rVR@calimero.vinschen.de>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU2PEPF00028D0C:EE_|DB9PR08MB11476:EE_|AM3PEPF0000A79C:EE_|DU5PR08MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d0a5eb-ed42-4365-f0d4-08de8f2a2fbb
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 4V0HalAuDZlzvs99tcJka8OWIAgN3VviYxbpytXItMi1xsgDBXqpi5oI9FLv4KhT2HzHL93N+i/fcCfE25SW9jC6Awpo2c7wWebYXa7HpBCrRDt4DeWDYzJ+MFEGVrSri1fmPEpYZOdOvmhZH6rifWzhZk+dcMSzxmD+300QtQT4+Id8V5Gv/JtAdmIfqWGbpy8rql8C0Ef4XCKJ9DUkHgU9e5r83JwSZAcgKh496l2hPmVN9TxasGdBlDUEkmbBmQ2t0N3F2kPJe9wt7lKPZVrEBJD7Q1IwBqaRkTIqF56hWe2kClzQBMg6JscdCive9ociLiyEtUhf6HyLTXV1CK4RvzfPkigyPLrwv6JZbTj0oU/Y5MQMZzpQUoaLWRctqlN1ItiGGvAhRW2sQPrc0AsaiAbBVGZP8ZvOoO3AX4+nS64+9yslBTdYW/D5XxJX0vpO1xwRGKpyIC9ui8NZnL1qtFNwKqX7gdtdPY3d0sJ+gx7oGC3wMnlMsvGKsAdeIEy6hbUX0D4lQ5XVwdRi4rIfcZK4x0XTjl5un4L7sEsVDlWrtMTFwFV6V9LxEtRUVastkLkM7Yc/ejFdn7OzHH63YEj5wV8kQmRCpABxLnvPrfOatyKIQ0swCp6YKjYjm3q6SvRv7NpHm1MzuUqM3XOgybfJDM/WHFQpXraVYl957NhVhS5NXVZzDsmSpPmr1wEFp7BUZ4DLnoPqtHhdJM6z8vlWoJYjG3TCm9Tth+S4beEK46PPEaw35UOiijVG3w48pGrBGwiY9phKkCdg+w==
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 B0sYRyKts06yxXBAFYZCY7lb/7E1zfuGoEyHFg8aAyLv6tLHvGFS9Js3oRiFBgU7BtRPbBxEuudfCDISoflBKHJva3rKj5Xir8hHzm2XPi78ty41Y39EIwpVoCRq9QHJpYi8d5uBP6VTAHKtv36DlZRGFn7eKP5i1e27CaeUebPH0dSG2qSFCltR7Nhm245oeBUu2f3vXiLWLI3T+9Kg08VjgF91uGoZYE14VobaOztjkoxAyyQzj9vJYHOL3rlFD+fkLay90aQaMtkHAMPcWAP2LDSmpHf5SuyymaKo4twJU68Vi4LeV0HW54Vcca0/tvagSqYGuK/WmaOstlpaOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11476
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dc72e39c-eb71-42c1-c26f-08de8f2a0acd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|14060799003|36860700016|35042699022|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R2NdoI2CmYBYoJiKqFlbqSVTNPI4IO3caagvj4A/GCP6PacBqfwZbhG0rmuREO+qdevHN1olEOv5AmdD1N9Ss/24iufynbeLsTExKBWbMJXKf0ptGOaT3bfskvPIJbK/b4379Jfr+oJdWjiOWXDkWAeX8azdss17pi3KBWe6XBipEqjlL4u9vcH0f7Mg95aReGMVDIS7NJCdJkYd9v4YWOp5cMbm4m0nSfNTJgLWYtVUn80Mo7ISyec4JDH5Oy/Zta8OI1Dc0VKQld9YwHhdO0QmOCz6AtRJw7ucwiH3iAuRiOP82VqGS8LBAOqaPnol6PYlQa4w8YMq724xmj4P9f+GfTFoNU7IAV95c3ElRSfqqAWn4o6zLVojeC4/FeYGe3BRf1usrQVxDaMDppdhm1J0FFizOUd1MK1qGXCAVThmGxeIoJ5ylpM+g9fWqMTt/6XjPgEkjb/gSGoPgoL7HzuctUWWgjsVWlikHHlWMg7cM6mrxtTbwkrpu/VL7RSuqylKnbfbCDDKetfznxAFOl7HsGUiNHkQsFy3VtzE1Zc5LjdilUahdRVKBzZsZC+4a4Q13X9DMKLjBdZ5ez1yo91cQ78VkA7gTq4SvTF4EptCtoVS4UTaW0Br4rsufWzt5RbJHyLhf5vcOeWGd+IwwfixnRR/sBGALkT+ErmMizirjcjwWD8E4ArRBpGBMMPNKmOrFrZK2AWuQPorloK/XLlqzTaGb8L/bBmewAtz++O9bdKte5sg7luFqJxYVc1cktrhi6o3gmVVFbJLgXO3EA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(14060799003)(36860700016)(35042699022)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WVEwA751jb4qr6iBZ3OcNcs8pFdygk40LeLbwfllxon5lMwvoDFlJh6QHI1qS9iZg0cxfaAO6KYRXjCtE/4QRbbYjQUDU9NZVFbqOW5vPqLI8EjBjHsMOXH9pNcWbua0ecVEpjJdrGbvoDVHPKvACbHTLBtrut3kt5PWwJ4b46+jl2jH193pTD8kxT0X5AbhvFKBCkUhPcL7IJFPTE81iTsR2BEhEkuA6aJZUdyEQ68EY9BiyIN20aRIE2xU2NCVRDCn8rFrLjAxRgrjm80nry01MKUU2gARkWm5wvoHAuni47l/5hY9XHfHpzKXo0csm3fh+2OPIF2tFxrQRVWNRC8DLYoCewAyPCY+BJkdtJEv/s1TrXq9H5j71kJkNUQweYkbioWiYq4OEaIEsTK08C/gX4Dv6RDIDTmHP88TiVhahgEq3zZvDBOydOIufEWG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:34:08.5011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d0a5eb-ed42-4365-f0d4-08de8f2a2fbb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10756
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, Mar 30, 2026, Corinna Vinschen wrote:
> On Mar 27 12:43, Igor Podgainoi wrote:
> > This patch adds the SEH_CODE macro (defined in exception.h), allowing
> > a single EXCEPTION_HANDLER_DATA metadata definition to be used on both
> > AArch64 and x86_64 architectures.
> >
> > It also fixes an issue related to stack replacement in _dll_crt0 that
> > impacts SEH and signal handling, where due to an epilogue optimization
> > on AArch64 the epilogue might appear before _main_tls->call. However,
> > after the stack replacement this optimization becomes broken.
>
> Can you explain why this problem only affects aarch64 and not x86_64
> as well?

It looks like the x86_64 epilogue is also optimized and appears before
_main_tls->call.
However, the x86_64 epilogue uses the shadow stack which was allocated afte=
r
the stack replacement. It means if _dll_crt0 is modified, it might bring mo=
re
operations for unwinding, and that might access the stack outside of the sh=
adow
space. It will lead to the same issue as on AArch64. Potentially, the compi=
ler
barrier should be enabled also on x86_64. And the shadow space concept does=
 not
apply to AArch64.

Regards,
Evgeny
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

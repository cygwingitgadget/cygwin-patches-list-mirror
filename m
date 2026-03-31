Return-Path: <SRS0=hkK3=B7=arm.com=Evgeny.Karpov@sourceware.org>
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by sourceware.org (Postfix) with ESMTPS id 3A3C84BAD17F;
	Tue, 31 Mar 2026 16:50:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3A3C84BAD17F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3A3C84BAD17F
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20f::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1774975840; cv=pass;
	b=JzWwSnVjxJHOMMylMHEW2pCCmlHNaAfhQ1CYVHoCHDMr/9g/5A03nAnr13xrg2zhOIWUN7SRnbkzYnh8Q4AnpcmSXkRZhzOxP2oF5oF3D69nC0WMpM42elcjr33/WqobJQnbCQ2OazDNhR1VzxMoAcw3cavcSNK3rNbwblDGxOE=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774975840; c=relaxed/simple;
	bh=tSTGMgzdN6LCCsBr7x9k/j1sIfbBIpl9Bzzlrt5dHQI=;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version; b=WJGh1PhNm4ht6C6CIsovDVIGe+xXCHlO4Sq2UgHA4dq5+nO5km06Yhdpi6mlQtBz0k6NofVO8yr2h8BSGNQe2ZjJ86qnO/asA6dCHm3c+mxqkFrxCSUUpSkCgFl1EcOA2yAZZ97fXJbm6RJ+93Ax7wfT7jeKcE/5HuCDg2Jo7Fs=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3A3C84BAD17F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Lv8iY3YH;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Lv8iY3YH
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lnZi9SOOm1fPIKkc2AqE+XEtuBnU63lNd7nrjeCkSLX7p6PGAtaTHPrsQbp/WAreW+e1DZTg9pxmcYj4/0Xn5rjrrQ0K6Z49j1uf8Ra99XTU2UxIdFmMTu8WekyhjOW/dyYKFoVvUT7TtnFO7MINgUJkxsR4VuRBAOPDKSBIkHtYt/oj2Na6OviRbmFK3YA8RMQ4ue8ONFqdfgh+2IarU+6E7bvkKh/4+b6tsTH1BVuCJ6IIiiQE4YPJoG+k42QXY3ad0zGaVR+VOj7U5UGY6g8WlF2+UdTrphwNz4z53ihuLKy7XQD8EqeiP93/66+2TzkUPNoTrlvzYziTdD0zBw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSTGMgzdN6LCCsBr7x9k/j1sIfbBIpl9Bzzlrt5dHQI=;
 b=OIe5GVHCTnZJvISaWCAE8VRbbpBumJaaZqEmShK5DMfIppEvL7LAH9DUzu/Td9Xhhlikhws1Kpu2no6aHCRNiD4wdQT9/FwE2fcaOHtVl9N3JHHHvVdQcw6czXuW+t4fMHVtzhMIo54zK5iqwrxYfavilSWKQDNDAFkn/8Uw7pUgu/SsFiH/Auj0Fom72vaM6Gk9QcwlBRinle1MLcoHPWexr2Au0AWvLJf1HWGSgglgljM3FgwJO3axOXM0y5LtubeS39XYtdR5UydmbwvuUgfOGpjjc9QnQTTPDXsoqbcmquftbGdvbSG56zEaTdarBC/+qLysZGtjx8L+pC7LKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSTGMgzdN6LCCsBr7x9k/j1sIfbBIpl9Bzzlrt5dHQI=;
 b=Lv8iY3YH956XmDs2cr+OX5vPZ3bKv7YK1wCs0JxBd1/+sGEjiCB5iLJmANT5bcUv7sgsl7OcuKjsHheRcG1Qrx9psiRpEcQm17LiEJc2aN154dPprhhPil5rZPcDqGRWFU222Snvcw1GS781bGtl0PJnXiE0t6zDa9J/CLO5xJE=
Received: from DU6P191CA0068.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::20)
 by AS8PR08MB9980.eurprd08.prod.outlook.com (2603:10a6:20b:634::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 16:50:36 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::23) by DU6P191CA0068.outlook.office365.com
 (2603:10a6:10:53e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 16:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Tue, 31 Mar 2026 16:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFLKjRVsrXDITJaCRzlweHuKGWxBq8I3Hs53ycCreH3AVc61TzVkycn3rRdvYNn44MUUUznEcEi5dm8NqbVaFPa8jF2QY/DZp20eSQtx+CgxRtKdwU97fglsuo1Lxv5Nx54EPIa8O8+BLTiQIA8fIH8kchhL2xfu9kUKwmbZpKMAErz0UAVXBJn7OapWNn7E0fGzVDeqBfH4NOu/9j1mAY9O0tN2Yq82szSBjHLpQQZeyTgV3LuoexFjJFfAi3n968F6xqOnTlM2Zk/aheZBOVfEQ2vxGTL851UYhvB9siRiBxD7Oy3Pg6sZJJoBrxMRzmxXSmrSe4lpEhMdal0UcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSTGMgzdN6LCCsBr7x9k/j1sIfbBIpl9Bzzlrt5dHQI=;
 b=QfFnu0v4wX8eAxgAEC+xMCNbz86nx/S0skiQ1s5iP3w9709G53zsFzniQhe50ZLgm6R18E3BYZTJZMALv6vEYkQM4Lyvh2q5UaQ7o4il6L09N6pUTWFIs7C13/s0TEmgB4iDSIenC3BI/Pe/5g9o9EE5wIM/9RGFboTSe7RYjRzqLBybfoPC7BcuVX41w5Hs10DmDYX3tME+x687XJkU/lW/HDJCas60B5Hhqmlls4mQKLawZmyHXRE29tlS9O/G4k67Upz04rV76Y/WBSBZeYyg3mWKzurGmEjFKTmi8ez7m/5jK1Kt91etpaBuBCcUP6DkIwahl3GohAtfxPEW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSTGMgzdN6LCCsBr7x9k/j1sIfbBIpl9Bzzlrt5dHQI=;
 b=Lv8iY3YH956XmDs2cr+OX5vPZ3bKv7YK1wCs0JxBd1/+sGEjiCB5iLJmANT5bcUv7sgsl7OcuKjsHheRcG1Qrx9psiRpEcQm17LiEJc2aN154dPprhhPil5rZPcDqGRWFU222Snvcw1GS781bGtl0PJnXiE0t6zDa9J/CLO5xJE=
Received: from DUZPR01CA0143.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::8) by VI1PR08MB10051.eurprd08.prod.outlook.com
 (2603:10a6:800:1c8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 16:49:32 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::7b) by DUZPR01CA0143.outlook.office365.com
 (2603:10a6:10:4bd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 16:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 16:49:32 +0000
Received: from AZ-NEU-EX03.Arm.com (10.240.25.137) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 31 Mar
 2026 16:49:29 +0000
Received: from arm.com (10.34.124.54) by mail.arm.com (10.240.25.137) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29 via Frontend
 Transport; Tue, 31 Mar 2026 16:49:29 +0000
Date: Tue, 31 Mar 2026 18:49:27 +0200
From: Evgeny Karpov <evgeny.karpov@arm.com>
To: <corinna-cygwin@cygwin.com>
CC: <Igor.Podgainoi@arm.com>, <cygwin-patches@cygwin.com>, <nd@arm.com>
Subject: [PATCH 1/1] Cygwin: Fix SEH and signal handling on AArch64
Message-ID: <acv7F8ccSij6IVsi@arm.com>
References: <cover.1774613608.git.igor.podgainoi@arm.com>
 <042c0cc99b70b4ec9959d4977b8cfcb224200bbb.1774613608.git.igor.podgainoi@arm.com>
 <aco1lg07YbVH7rVR@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aco1lg07YbVH7rVR@calimero.vinschen.de>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DU6PEPF0000A7E2:EE_|VI1PR08MB10051:EE_|DB1PEPF000509F0:EE_|AS8PR08MB9980:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c82b761-d148-4383-d39e-08de8f45a207
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 RU88eS/1EwvbwuB5hbDypcq6amQT3oE/YDVF7AhtYpZdMtbHA9dHkTuZWxl+R8YtMcgs5vsVvtWA4J6j2/Kep50Wqraf4SgYxUw41/B+p7B4WPS8+UMvNWoTfAl/K9ZKl0xFrE7warIOF0YPoYBB+h6I9GZJ41ZKk69ubJKB4ixWkHQ9YCXbGO4gbEaRe+nxa2vWw16lzafnMu1N5lfPq/USWNO24DiTDxe95a92diZmKKsSO4hneCi+KZkZIqpsLx6o5laFSw8NMOo35Pclh3cNf4fL3hmf84C7NJQG181gMUmfuQK0gbQY394R4PxdixcWfslLkgzbwugzWzNeBmJJEOdSCVkVsex+EovsTAxaZZ2uiBSE9rfoh2NFhMi64ZS1OHsDYC9e1XOrgnmIKcdL3mDA0C372s806sZz0Mc14Gb4IRzahr9tW1kDoXCgDEYREQvEJYFKlOGYqkeBdm1IrKCnNmQQR04pL/bvByxsA9gKIMnj+EMC0JJZebsgm1IhoiFyI1+hf+ZBPXnae1Bu2vTsL9BALt7mzF8EY8js7xpvGs9jOp+iY3P0XDHgrc608jO6x2YOVI45Gzoul7QuMoOTodc1V51By8jJUnkxECAkMcCMwNq2KkA4EaqQ5TKuXAAm0cJ9KdWD5cI8iYik/CSkaiqNMxNSG8yQoqUHhbFvc2R0/Iq1gwmRgjhGj8TUAuE3l3d5MsdCb2IliL2CEg3ae8Y/K300rluzBIQWE9tVYUl4gmSnrMK0IMEFvneKb8jkz0F1XaZAOjhXhQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pLI0WtB92W52DGAnsQLLlhs8FTh3YLl1yH8eYnuztXQYU47lwXtgv0EmgzSCBwI3X2JnkNJuxrBbDiwZj0wkv0440akWOSFtLfbJkrvgn4jhntAoDBNOxqrdDSO9jom9H8Dgiq0gwcZwueWk7YjjiHi+f4E623Rxcvo1KslpXeqtUMg060cluJn+Exkdvf01QNwPcTKYvPjzR7kwSWZqYlHx3ExobQIv1zf5aUhAt1cOZVP0DzROd3KWYULG+tloVPYqSoRbUo+FOR8bVsVhooO3N2bIMS2+zvC/YxCoSM+MMJU7ezOjGHSF2MEEra3miaaP7hbUbZ+LAbKo0tJTmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10051
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4152221b-cd04-4b87-f494-08de8f457b77
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|376014|35042699022|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sI8wlc8sqQ0j1nUWhC8cAdCiFGCyRgutECbGLgiQsF1zb9j0nWMo1xZ3IgUWA+4gVnHRL9Uxk8e93c0AjTTHIm0AlY8CO6znuFiyMS3rOUdmhp0PQZq7h21cjBXHsfaITw/m0aDuE81RZJtv1ybs6WC4hsN84d9wPhegHl+TkcVaq9LwyloIpuZOAUvqz156tthFr7978bkQoJUrkiXeyr890EioNtWhSjbhWF2l1bM93TZCoqnel5MwEHzYhd9ZNgYp3NulvZkJEk7FT+UDEDOmTxpyvYCznOSmKfcoOnlKqJQwMNj+c6pP3yEI1M/VEiz4SXpzr9E4owoxLVp4y5bhOCB4PzpMkkWQ9b7Z2z2Nvr6JeJVCy23a1qNAgqgDX8NqHTX9Mws0ifza8QgFxSKMELiKcoaRel5o4vs/h/UwtasuIx7rmqgDqe/YU7OkzHyxTbIIY+TZItF7GfN6XlhMsZ+cyzrLX3GRoFZyqcmGHMbmVFElg+mK/qBbwivB+JGuLc9C7BUbg92LqlUrzz1DEOR6WrZ7UJEiyX3FWAhg0zSl/TAtiVOt5CqhXvMQHOsMl+fCiiG2rByVojT17n7AkN6IR3QdV1qLnLOhIH4/+QIngz96YsyV6MMJQnQyRTX9gzK4C3OnwDzykje5YzKaE2soBYDwvGrpDv30shPPzrUgztBCT4/4+pJ88lLgcX9B36q/oONy0ClBG7jXa00jnBp4dfB+KbxUCYMN5DQ4pMrD2T+UPcf1ZgGxCuLFBfIBCrwdrvHJyM68n5S8mA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(376014)(35042699022)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BjY/T5336zCJNO3kRkVW0zmi3uPgV+ZDkz3MoafZixRkdgHy0ABVAdy5W/BWL05xQL3Ue/kHHEZmoX5la2ks5qJ3eNAUgsQxEleK9kDhBXnB+vkQ4/FJrLExIaijN72gxPRRFkOv6Qk9XtYrwgI2juozzFYZXEA62QJ+Pp/x2TWus/8EZPhu+az47iqeW1406oqhCzILXPRoPRTlTwneWqa1yIMJhcTZBQhYgBpRUQl1cGwuhpFsIec6h8k7tEYltcueZ5Xea6++E4rkHF1Nxdoy7uLCNhYQNkUk0Jba2eSPIEfOpcqaunYCAcFEHza9VxUbw9/GD9hBVKx8Vvz5aBCKyZCIKXI3ewyS9fuvU6TcyUT4pHXYgBaoRRQTuPuSzFOrEyPbQ0aSv29NDf+2HO8r7q9o2SaAql5UQsTccG8oKJqe6pkS1xC6f8Qufx0S
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 16:50:36.6674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c82b761-d148-4383-d39e-08de8f45a207
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9980
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

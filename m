Return-Path: <SRS0=7rx0=B3=arm.com=Igor.Podgainoi@sourceware.org>
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by sourceware.org (Postfix) with ESMTPS id 002F04BA543C
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 12:44:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 002F04BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 002F04BA543C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1774615462; cv=pass;
	b=cwFy8KIyKXfjuIOiowxUmeVtXCEk9m6wcuyzbjhY9TdgJwdcHRLHep1VohgA+TtYr4JfldGxbC9pGCHAdpBN4wdgim+LdQcnhaNN9Qjd+fEGNKnB6OybBOu5SCaMiRD5mzFuNTJCPIjgnwAuryprD/Gpl2ckhyGQ++0Tl2bfeTA=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774615462; c=relaxed/simple;
	bh=D/6NEtGwRcJZKqGt1WG85sqb2rWfdy8z+OXcaD7UYNk=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=lDJ1QpL3aQU4+7IqTOQC8r9hu9oDf22cZlZqAComSk+TWvgf4yvjUlxlipDnswmg1IsJ3b0vkycEbHwcG0oSPnEg6HO8kMV94HgNwDXf7VAu+alq0twkL7Ho5RotjaL/I62lqGCwHH716WAsCMJJdP8zNMWAUj2R8msxfu3kPcM=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 002F04BA543C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qwG1STqZ;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qwG1STqZ
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xtAlO26XGQUdEASg263ZJNakcuqUrHQ6J6SPRHtIpqgudxs6Vtf9hAqbhXAKHGDnkEH8cr+6b23eaSyLSL0IzW+Sk8n3jO8GVEG72D1Ejs8EfeZAoCDModRptUjXgZYuKTxWf+w9qqiDobqVzkCIpcE+GWQoHJZ9BOWKlHr3ZgwJnIZ115OnmiEQqHGUQ1svx7I975Pih3vPjE3+JV25uMk02FvDhVQ1ZfK2Y1ebEnRuspLJV7gAWtwzu6/6zxKbLeuKnL3/KpezaVC5qxksz08Be0CrOr0k2xqZN/Xnv+UtczVuWEnj7DoNemKcdQvpHcUz9VegAUgWyfXCPbFCqg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/6NEtGwRcJZKqGt1WG85sqb2rWfdy8z+OXcaD7UYNk=;
 b=oJEpHhKQw2TneBQ7vAz4Y1kp9pnKWdGG4spocC93ksg/oiC6FVnCfgQXNYu8zEpIJpRzTjExsivTh7HOT4FNBqnDfU33SOhBKi2Tvb3GZXC2sZmIP6XXuWuXvkFgivas/EoBeXbBVfFnuA0Y4wgY7Xe0rs2s319hHK2PT/P0dcVIPBY+nu040QID16jT4gqQ1XJkqIIejIic4o9oD9vefmz/RhpI2nfl84W1ekrafIp/tI2yzepzIi+5zxOOuNRTPcIju5m1w+jovukSW3GJOA9qTG4jnCg6vuPg4WhyuiWHwy/jtK2DDHTSvFE4Eu6sq0qOVDm1UPAlQS2huF/iqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/6NEtGwRcJZKqGt1WG85sqb2rWfdy8z+OXcaD7UYNk=;
 b=qwG1STqZ26IpwG2D/OUBYt6/sJVbYEF4zk5DT9acRS3qcSJwh/TgAhN8zKRwmvvRHBLV30V3sz/wDBEpCCc/16Un1zoHX1vs8gREAxRAtmpOAYDu1y3SanSGORb3NqQnS4MlS8VGld0XN531nGGaDbKBt2lVRaGqh2ZKbLjcYlI=
Received: from DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) by VI0PR08MB11018.eurprd08.prod.outlook.com
 (2603:10a6:800:253::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Fri, 27 Mar
 2026 12:44:15 +0000
Received: from DB1PEPF000509E5.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::e5) by DUZPR01CA0016.outlook.office365.com
 (2603:10a6:10:46b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E5.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Fri, 27 Mar 2026 12:44:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3eSv+JyTkaZzrOqqCfiV44ynZsnHtM7/jUMSL0FzeO72X4/SYrWsjFdSBzCo7CvAjn8cKdqDfg6N8BM+8wW+DMKIz4pqwtsWb9vFl5AGw5qIGDo+d4zCi4ik7mJyph3l4yQ7UfJ/GO7bjgoUb/jJqNioisasIKIbfdsKvMM5GKW26BRK3w+zCuaAP1JzKDoUwRb4QnocdsDWSyuL/Es9e5PV73hYCseZ0wR+dI9elbsXda5NGu+sJRWBjnM7kQtp0C4waiTC895WexFBfaDzH4m32zA3rktRWM59m9C3LBVUOU1GmVIhFHIy1j3elYT+A3W0IW0fkobJiVL54gVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/6NEtGwRcJZKqGt1WG85sqb2rWfdy8z+OXcaD7UYNk=;
 b=noSX1RVliPIFd8B7bHkR8BWjgnWEC8EGnMRk+rU+c581BGnJurSpKS6Ov8j4ImY2rkxOfjGwu4i1N3ec1fTj6YGOcKrrIAZuXiKAQIvd0wbMBULja/dUOTia0j5TaPUKR+QxHrJ0aKw+HhsljFn5g+jrtpDEf8BTBEDCBVB0FQndM2htuo92NA8esnrSgVk0r8XUT5YTTgTOxOTGaIYDUHeTEpuSsm2k32tPkH5gl4UPPJty6anLT8vRnV2kANTqWDYuQlUhH7JYjczB0q4hgtXuIrIcGnAGi6r86gMzs8k3lVNWxRsbCIljKLCksZ7es5pV9hOiWKA0AbSeIJ6vnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/6NEtGwRcJZKqGt1WG85sqb2rWfdy8z+OXcaD7UYNk=;
 b=qwG1STqZ26IpwG2D/OUBYt6/sJVbYEF4zk5DT9acRS3qcSJwh/TgAhN8zKRwmvvRHBLV30V3sz/wDBEpCCc/16Un1zoHX1vs8gREAxRAtmpOAYDu1y3SanSGORb3NqQnS4MlS8VGld0XN531nGGaDbKBt2lVRaGqh2ZKbLjcYlI=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by AMDPR08MB11505.eurprd08.prod.outlook.com (2603:10a6:20b:718::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 12:43:13 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 12:43:13 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH 1/1] Cygwin: Fix SEH and signal handling on AArch64
Thread-Topic: [PATCH 1/1] Cygwin: Fix SEH and signal handling on AArch64
Thread-Index: AQHcvedGx/7faVlQ20q1O7QNuQSMFw==
Date: Fri, 27 Mar 2026 12:43:12 +0000
Message-ID:
 <042c0cc99b70b4ec9959d4977b8cfcb224200bbb.1774613608.git.igor.podgainoi@arm.com>
References: <cover.1774613608.git.igor.podgainoi@arm.com>
In-Reply-To: <cover.1774613608.git.igor.podgainoi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|AMDPR08MB11505:EE_|DB1PEPF000509E5:EE_|VI0PR08MB11018:EE_
X-MS-Office365-Filtering-Correlation-Id: 32988cc8-75fb-4b09-36a0-08de8bfe8dfc
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|38070700021|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 FkvaxluvpJR17D13McFmL/xQkBr2y+HbZQWv/WO5P9Ak9+a4+So9vcp7nIuwn3XGTGz2Ynz/OtkF8JacQxYnLVjLrW5uJfxjIZEGagxpNq5bl8JEk2+tusKTVJIYD8yerRtELTQZguePVISAEhPfyaN5M08PxU+s4PP6o1bsemduE8FxtfWg4ZeIcjmFAkfx9DioH6GWqyd7DoZKxprdge35lMU2NYpxyFCViF78ywh09bQbikJVMlhlqHrTtHggzcVdItFKgc+uGU9RK5pQM4cHY5PXm6BoJTPDKZf9mf5DLAmf9fyvLqFAfeb1mfX6fR1uoQEfxr6ejhB8mk3x/bjXV2POEAagL4Yyr1EqvODIM/YPmOSnBrFlraYjKD02ms4mdTCEhdp+/Vi1D6zmiWfg4picwx6uWUj7IpKs3/zaxNtUUUWLH/nB3tKpiKUgupo1Bl3TIubChPrVYGV3dn79EnZunaJDDtDP06fbtew6blAXTEzkiCb/61d98b06ONsbr1QTE58M5hHfAiqGY1AlXUrhM5QJu3p5J6Rpa11Sm4CDmp1NctkA230swOm18S2EbPkk06//aTa3qN5lxxdc/hxnExrxg/tlfjYcvETYaMx9bFJ+9WqirgirfDqDSUJp2+MjuGbfyodUtb9M3T11AuQToO33nvvlcxB0hlwNwVQQ2VHSKuLgCRfVymeVb5KoBGQLKOGLase6O/XbPfFpXbjtZ3khKLAbs78N71v05uYKsMI7812kEiV1iUOd
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <2234E40C5F9CE648ACB122D987F386E5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 Fuml8/Dcn00WEBCxSs1p26tTo3c2Sdk+GI+rvwB2aVK4x05nVGPHnKOEaEKlIBio0wqM+odA1bTV6DCMTCdiuLXVb8ml/la3QGtZVxEDz5HDyHOHkt1Bb9dCglr6WCKq8F8lpi9B6R1PhTH7BE96fF8ivJyKDoBQBds2d21ahl7Yqc2zZpI4CBLy80IYdRktzTS43sB8Eea2rTaM5HGDCR3UwBgTd1PZ/E6d0M8lKKUGAzCdqiuIR09byuvxdTkBAMODbR94s/dFzCJReS5k7Bm19xDLAtVe5gbev+8/rBOiGN07vTXalWuYc7RRsxVC+gSUUWynYuwafA6ggmf7eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11505
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e21d1638-c0dd-4458-08b2-08de8bfe68d5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|36860700016|14060799003|1800799024|82310400026|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oC0Y8hNc4juvONlYNSPcspsY3Pa2tMua2F+ivUc7O7M795KigkE4wiH3YD/o9lU3DztqxEZUXExRppTOGxZb2g2ecIIfi+5YVNwUlpLFX+QxP3TGEQ2oAoUw8+YTeuVZ9PyAFYM0hHY/o0yVakroZ4OwKXo4ITHcDUOZNbBXb/v2Wefmz//rRrtvEQBGDhUi5++9QqAs3ZnoOm827Om65WyujvOYmpH9+JmRzoveFphA7Yv2o/KFzEX9TWANYgG9FoWgfu8IRWM/O7i45JgtQkl3gOeQz+0uZCOHjsjyEjyQaNvoZB3IJ8F/0mEc0C5faou+wDZKBHf4Pg9E/d4FnAWYixVRqNFU7VX+qpo6rBV6Q/7tZFwhZf/NCDfgCHST0sWlXZxjdfao+/nPUSg39tXsjmwbvmY8bqQDksEn9LP3l/NUVYvXdgTXvGBS6/AwjAT1sXA6439YWjC26/5l8PS6Ou9n3b2yFpbdDmdnBVpUpFGhpPV90JPGVeu+h9CicA1qkkbEUEPgUJ1rVOBrv0ZdrijBPkAc0Cs7zoUJBUq3+GCRifUoZI2dd30g1Xo0SNZeYjAARFwfHYsRm+chXRjQMfpWfthYq0hemsSgQVjEfnkv1sjXXuWydlsNBnGzsh7B6ROytgCjRv+teEyvtJPEKuDfSqxrF6AQI7XB4ezJsz5/Dp9eU26UDRi13N/cuhstJHRLSiYsnvVq5MsGn3lMTZbJUvOSQz73WrK8gio=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(36860700016)(14060799003)(1800799024)(82310400026)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GiLwKcVQeNLZFwUMW8BicQzRmrxWjza49oXLlyB5Tz/hBGz4zI8/iVGRBk2B1p6FRtb8Xn6P+FzUr+VH52Zq+UUGcZgcgNYwg9uZs+wNhOTW9YrprGBiH/NduVLThC0kKlTm1Syit6ufe03I0vomyMZvp2W/CNJUT1OgwwdgeMHYNrggvw1EA4gYs6iKwRNimqJGE1QNSrgm51k686rKrxv4UQs4a9DxgZqyynSa/qChMLBAd78QWCMfLlALA+b424iLzzp8o+KgS7VR+cuW4E8x2D3naaPuEKb7oaWkwXk40Z0GCCTqvIuV6NfRhdcmDtOv67VVQ5jjrAzEYgZvlT1YZmDhadUCgJ0p2bVf6o+JtqOXEzvS683S/8kdSWL0mb++XCO3JlKe73sDSo/DdViWLAJeOKf9hzozKa2lR9iLZpPZoopyxXCy+6QXuKSy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:44:15.2895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32988cc8-75fb-4b09-36a0-08de8bfe8dfc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11018
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

VGhpcyBwYXRjaCBhZGRzIHRoZSBTRUhfQ09ERSBtYWNybyAoZGVmaW5lZCBpbiBleGNlcHRpb24u
aCksIGFsbG93aW5nDQphIHNpbmdsZSBFWENFUFRJT05fSEFORExFUl9EQVRBIG1ldGFkYXRhIGRl
ZmluaXRpb24gdG8gYmUgdXNlZCBvbiBib3RoDQpBQXJjaDY0IGFuZCB4ODZfNjQgYXJjaGl0ZWN0
dXJlcy4NCg0KSXQgYWxzbyBmaXhlcyBhbiBpc3N1ZSByZWxhdGVkIHRvIHN0YWNrIHJlcGxhY2Vt
ZW50IGluIF9kbGxfY3J0MCB0aGF0DQppbXBhY3RzIFNFSCBhbmQgc2lnbmFsIGhhbmRsaW5nLCB3
aGVyZSBkdWUgdG8gYW4gZXBpbG9ndWUgb3B0aW1pemF0aW9uDQpvbiBBQXJjaDY0IHRoZSBlcGls
b2d1ZSBtaWdodCBhcHBlYXIgYmVmb3JlIF9tYWluX3Rscy0+Y2FsbC4gSG93ZXZlciwNCmFmdGVy
IHRoZSBzdGFjayByZXBsYWNlbWVudCB0aGlzIG9wdGltaXphdGlvbiBiZWNvbWVzIGJyb2tlbi4N
Cg0KVGhpcyBwYXRjaCBwcmV2ZW50cyBhbiBlcGlsb2d1ZSBmcm9tIGFwcGVhcmluZyBiZWZvcmUg
X21haW5fdGxzLT5jYWxsDQpvbiBBQXJjaDY0IGJ5IGluc2VydGluZyBhIGNvbXBpbGVyIGJhcnJp
ZXIgYWZ0ZXIgX21haW5fdGxzLT5jYWxsLg0KDQpUZXN0cyBmaXhlZCBvbiBBQXJjaDY0Og0Kd2lu
c3VwLmFwaS9tbWFwdGVzdDAzLmV4ZQ0Kd2luc3VwLmFwaS9zaG10ZXN0LmV4ZSAocGFydGlhbGx5
KQ0Kd2luc3VwLmFwaS9sdHAvbW1hcDA1LmV4ZQ0Kd2luc3VwLmFwaS9sdHAvbXVubWFwMDEuZXhl
DQp3aW5zdXAuYXBpL2x0cC9tdW5tYXAwMi5leGUNCg0KU2lnbmVkLW9mZi1ieTogRXZnZW55IEth
cnBvdiA8ZXZnZW55LmthcnBvdkBhcm0uY29tPg0KU2lnbmVkLW9mZi1ieTogSWdvciBQb2RnYWlu
b2kgPGlnb3IucG9kZ2Fpbm9pQGFybS5jb20+DQotLS0NCiB3aW5zdXAvY3lnd2luL2RjcnQwLmNj
ICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKysrDQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNs
dWRlcy9leGNlcHRpb24uaCB8IDEzICsrKysrKysrLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL2RjcnQwLmNjIGIvd2luc3VwL2N5Z3dpbi9kY3J0MC5jYw0KaW5kZXggZTA4MGFhNDFiLi5l
N2E4Mzc2NzMgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL2RjcnQwLmNjDQorKysgYi93aW5z
dXAvY3lnd2luL2RjcnQwLmNjDQpAQCAtMTA2NSw2ICsxMDY1LDEyIEBAIF9kbGxfY3J0MCAoKQ0K
ICAgZmVzZXRlbnYgKEZFX0RGTF9FTlYpOw0KICAgX21haW5fdGxzID0gJl9teV90bHM7DQogICBf
bWFpbl90bHMtPmNhbGwgKChEV09SRCAoKikgKHZvaWQgKiwgdm9pZCAqKSkgZGxsX2NydDBfMSwg
TlVMTCk7DQorI2lmIGRlZmluZWQoX19hYXJjaDY0X18pDQorICAvKiBBZGQgYSBjb21waWxlciBi
YXJyaWVyIHRvIHByZXZlbnQgdGhlIGVwaWxvZ3VlIGZyb20gYXBwZWFyaW5nIGJlZm9yZQ0KKyAg
ICAgX21haW5fdGxzLT5jYWxsLiBUaGUgZXBpbG9ndWUgb3B0aW1pemF0aW9uIHNob3VsZCBub3Qg
YmUgYXBwbGllZCBhZnRlcg0KKyAgICAgdGhlIHN0YWNrIHJlcGxhY2VtZW50LiAgKi8NCisgIF9f
YXNtX18gKCIiKTsNCisjZW5kaWYNCiB9DQogDQogdm9pZA0KZGlmZiAtLWdpdCBhL3dpbnN1cC9j
eWd3aW4vbG9jYWxfaW5jbHVkZXMvZXhjZXB0aW9uLmggYi93aW5zdXAvY3lnd2luL2xvY2FsX2lu
Y2x1ZGVzL2V4Y2VwdGlvbi5oDQppbmRleCBiMjZmOGJhMTcuLmZkYzRkM2U0MCAxMDA2NDQNCi0t
LSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvZXhjZXB0aW9uLmgNCisrKyBiL3dpbnN1
cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvZXhjZXB0aW9uLmgNCkBAIC0xMCw5ICsxMCwxMyBAQCBk
ZXRhaWxzLiAqLw0KIA0KICNpZiBkZWZpbmVkIChfX2FhcmNoNjRfXykNCiAjZGVmaW5lIEVYQ0VQ
VElPTl9IQU5ETEVfUkVGICJfWk45ZXhjZXB0aW9uNmhhbmRsZUVQMTdfRVhDRVBUSU9OX1JFQ09S
RFB2UDhfQ09OVEVYVFAyNV9ESVNQQVRDSEVSX0NPTlRFWFRfQVJNNjQiDQotI2RlZmluZSBFWENF
UFRJT05fSEFORExFUl9EQVRBDQotI2Vsc2UNCisvKiBBbiBTRUggZGlyZWN0aXZlIHRoYXQgc3dp
dGNoZXMgYmFjayB0byB0aGUgY29kZSBzZWN0aW9uLiAgKi8NCisjZGVmaW5lIFNFSF9DT0RFICIu
dGV4dCINCisjZWxpZiBkZWZpbmVkKF9feDg2XzY0X18pDQogI2RlZmluZSBFWENFUFRJT05fSEFO
RExFX1JFRiAiX1pOOWV4Y2VwdGlvbjZoYW5kbGVFUDE3X0VYQ0VQVElPTl9SRUNPUkRQdlA4X0NP
TlRFWFRQMTlfRElTUEFUQ0hFUl9DT05URVhUIg0KKyNkZWZpbmUgU0VIX0NPREUgIi5zZWhfY29k
ZSINCisjZW5kaWYNCisNCiAjZGVmaW5lIEVYQ0VQVElPTl9IQU5ETEVSX0RBVEEgXA0KICAgYXNt
IHZvbGF0aWxlICgiXG5cDQogICAxOgkJCQkJCQkJCVxuXA0KQEAgLTIxLDkgKzI1LDggQEAgZGV0
YWlscy4gKi8NCiAgICAgICBAZXhjZXB0CQkJCQkJCQlcblwNCiAgICAgLnNlaF9oYW5kbGVyZGF0
YQkJCQkJCQlcblwNCiAgICAgLmxvbmcgMQkJCQkJCQkJXG5cDQotICAgIC5ydmEgMWIsIDJmLCAy
ZiwgMmYJCQkJCQkJXG5cDQotICAgIC5zZWhfY29kZQkJCQkJCQkJXG4iKQ0KLSNlbmRpZg0KKyAg
ICAucnZhIDFiLCAyZiwgMmYsIDJmCQkJCQkJCVxuIlwNCisgICAgU0VIX0NPREUgIgkJCQkJCQkJ
XG4iKQ0KIA0KIGNsYXNzIGV4Y2VwdGlvbg0KIHsNCi0tIA0KMi40My4wDQo=

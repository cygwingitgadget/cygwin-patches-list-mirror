Return-Path: <SRS0=Mlt0=CA=arm.com=Evgeny.Karpov@sourceware.org>
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by sourceware.org (Postfix) with ESMTPS id C50C44BA2E19;
	Wed,  1 Apr 2026 15:42:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C50C44BA2E19
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C50C44BA2E19
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1775058180; cv=pass;
	b=HwngU4wZWEtWPiTad2jVGlt5Q1Gs22edMsbxGbOsnbK6GpN0fbQ3RRVsDHR5aTk68tSp72gBAtCdW/a3b8PtxlLE4F3vTRIuSBnVBicDSFRzZrL+/dPTfRsVXDAWE4DPs5754/XajtdHp9LOFMWRQG5G+/FyMpA1hcWpLkg95bY=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775058180; c=relaxed/simple;
	bh=w49G9L/Ad3F93RqOprPwbF3D2vmZ+0uq42cADplBxM4=;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version; b=bSNNICRnMo8tjAcyqlsoNXVpscJpGnyV/2VV805ew82Oq74xrtCJVdvyXqT1J/U16wsrHx6RT8TkHW9Xe8AsIiZDU/rp5Q1O2cLpGyZ4Z/blphpxlzF+T0LC4T/AmqCP9OvrJVbsc5js/LDWEW3IgVmqxwhoUcD7NRWqu6bC0eg=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C50C44BA2E19
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=TwwxVNzT;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=TwwxVNzT
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=a9N3+1ueGimQtup7XW6jddPZ3HMsjgMq92dqFukUARRHOm9zlak4hF0OtrRNUBW/paoSpFYy7rYpsYw/gRu8J++gi/kfCQFn4/yzH7vji5kqXtisfHfMRBIJmW9ihTCyflncXyupPcJWEmb9I2T6/apDwDjchO+2/gX06O/NrTkuCiromKxC/9wg6in0KUPu6pyD1JIwAOJkIBqwETf1be2V4wl1EZcvQ/4X4ckxIP3HfPLKampgyCWhbeBoS01hswuV85agbpowoEfWi/kEwePaFOmMILTl8WLk8DXPvmUUymNIuvA6LWZZXOagxJIvdxlHckeYFXD6hTvWIx+KsA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yN1PgXMHtjhluO8kg15z+yXcl+Ma1YSnWsgeNzUBX8=;
 b=C63/pk1e+7kxD2XJ7iPV5Z0o1PJb3wDOh6ZlpuC/jXLS57jnyfBcyz8/YqF+0wbICu/AT82SEtpLDQ4q0O1x4l3BhFBDqGuRzoDz/GDwPLUh+ruVitXhU+YPZBC2oUVzpFK5eA/Rw9Mlxwn1r45NxJFt90exynvdSlecOUGEf0KukuHMyXcaDcPRtQ6LjwjtrJzANQ9vGoanZj6FkgZDc5EQ+/5GRDTRWYq/J6Cxuw1lDwAxLSZ8K63qJuisNrnBDSNz5QGkuWm8J7BZPoT05Ku81bAFszBGXDucMyLyyhOiFc0erbO4Q07yPwLrsYhIBnGt5r7Hu0YhmbgLW4pyeA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yN1PgXMHtjhluO8kg15z+yXcl+Ma1YSnWsgeNzUBX8=;
 b=TwwxVNzTcryxsH5GCL579chIAdFCwZudW+qCVTuPyF5iFSE3b3PwLhvG6FNY9mrvhE819QuCZpvQk4aTQUuUSuSsAoLBbDS7tjEYL4WL3kOSacH6j1RWyk3m1rYy9qj7P+U3T7IxN+bIEhd9P36AX7/J+zty+zl8b7F8h7HiJ9A=
Received: from DU7P251CA0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::14)
 by VI1PR08MB10123.eurprd08.prod.outlook.com (2603:10a6:800:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:42:53 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::b2) by DU7P251CA0001.outlook.office365.com
 (2603:10a6:10:551::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 15:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Wed, 1 Apr 2026 15:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y82sdigctKmP7ii2qtQbFJhTBlSA+XFCgbrvVI0a4w5p3g3EL+oq83PXBL0vKbEXOSXN+BUsP1RUzTNAXWzSb/ZR1uUzFKg9+vOP2QmINh+8MIzrH9HF71EF0CNalrr9tCtiFKZFLNd4ETnVhMv9LQuMEN19gRoElIjWmo4g3v2fQlZRchJjWb5T5LPwl/ju+v7mPvBwOeGMd4fq+2MLvpVKIx6bo3jDvBppTMJvVr2so3aqg3qGQc1E1/9Cyj5eTn8p6Yu4/nhDTXGiqkZfGV9KbOhBuOHHmrIrEGI1SR4e1PDzY6KwETU46sPbXkCgWiVBetBBwfyr6n5QaiHn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yN1PgXMHtjhluO8kg15z+yXcl+Ma1YSnWsgeNzUBX8=;
 b=Y0k0cCIpB1QdbKNqWD/U7AdU3FFEi4PvaXlx8Tmbvk6MpBYskHPTKy5G5qtUUhinr6El1pQrxgPZaByuulNJ8vmTI39tpv6SEfpO2eiwFi0ce68hYNzAIcoR0C+7pw5Fjvc51jGDSeal/Dq7U016I5Ftn2pmugIV9/kQr4Hl1OVdnWSWPYbggT/ztsA7YKmMDDdwkf10M3C/erkANCpnStKg9qxknapsTx+2LhldEkIfGcjUpC4x3XT7ugCG+uVjR+HxjuWZliYO+qcmpGfaI7nWIfYT6voTVw7ltMkVoPMm1u4go54fG9A8opFVGVWiGBP3/9i0lENb5N0uLW2XoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yN1PgXMHtjhluO8kg15z+yXcl+Ma1YSnWsgeNzUBX8=;
 b=TwwxVNzTcryxsH5GCL579chIAdFCwZudW+qCVTuPyF5iFSE3b3PwLhvG6FNY9mrvhE819QuCZpvQk4aTQUuUSuSsAoLBbDS7tjEYL4WL3kOSacH6j1RWyk3m1rYy9qj7P+U3T7IxN+bIEhd9P36AX7/J+zty+zl8b7F8h7HiJ9A=
Received: from AS4P189CA0046.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::11)
 by VI0PR08MB11042.eurprd08.prod.outlook.com (2603:10a6:800:257::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 15:41:47 +0000
Received: from AMS0EPF000001AB.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::5) by AS4P189CA0046.outlook.office365.com
 (2603:10a6:20b:659::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 15:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AMS0EPF000001AB.mail.protection.outlook.com (10.167.16.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 15:41:47 +0000
Received: from AZ-NEU-EXJ02.Arm.com (10.240.25.139) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 1 Apr
 2026 15:41:47 +0000
Received: from AZ-NEU-EX03.Arm.com (10.240.25.137) by AZ-NEU-EXJ02.Arm.com
 (10.240.25.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 1 Apr
 2026 15:41:47 +0000
Received: from arm.com (10.34.124.48) by mail.arm.com (10.240.25.137) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29 via Frontend
 Transport; Wed, 1 Apr 2026 15:41:47 +0000
Date: Wed, 1 Apr 2026 17:41:45 +0200
From: Evgeny Karpov <evgeny.karpov@arm.com>
To: <cygwin-patches@cygwin.com>
CC: <corinna-cygwin@cygwin.com>, <nd@arm.com>
Subject: [PATCH 1/1] Cygwin: Fix SEH and signal handling on AArch64
Message-ID: <ac08uYQWXPNTnsi3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aco1lg07YbVH7rVR@calimero.vinschen.de>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS0EPF000001AB:EE_|VI0PR08MB11042:EE_|DB1PEPF000509F5:EE_|VI1PR08MB10123:EE_
X-MS-Office365-Filtering-Correlation-Id: 302e1ab4-121c-47d5-12c8-08de900555d4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 6+AUaPXOcaBZw5RFoZwmfrjozwIsOmwypbK+1X/Qy3+GkxlQgNoMZ5p83vJJ9Y6FydsXKxZx582ty4JX4gWANaZVZDgakZaSYJ8gakmDAYSYko2bUrKxAf72E96lzmL2zVCp03JmhuwozpZzE+rLWo+8WoWIS1kag/bEds7uDxxfbglO4JZ4mNXinWTnDbkte3eq9p1K4mJeJI6L0aYb+ad1/3yLhVSqKsqeGCMN/qBuvrdHWTyIF9WPZVb+P9U7y3RAlZlrCtio6U0H3+JELtaBfIkJKMGfVLZwvcVFuk73pz1M5NRiKIeOyHpZKdL+jgRet390aI2iXeGyp6QgtIlraPuAY9irG0GX0T+LD5jBH8Ocg+r4DNnUIBUmmPrJUmfyKUKDuzzWqoySwa7zOmIuXteAVSVZ5y/GRkWc1qc47VbJGha6SzVhw/A4NvGBfSDohPC2h5aPHY1zFIzfhsZFmF/G0SCw8vqCjJIGwPi0dzty11NP0FcT703Sm9LSpAcl59GgbZKY+1tW0MUTgXpA1a8k2B0t6UqK9cfGngQ50hbG37o/qhZyFa9ClLVZ7q/ALdogkhbN+os8ltvl6dPQPlokKcNwRcoIMmufDO7Cu+7dqwmbbA+wIvUfE8O3lFJ3WTN9D7toCt9vNgoBVqGi804ZSjAlQ57SrPi81QsUgoWISeulwfruwu+1zyJkXxFId0PMtRgZ8oZrhfIlXUQVutMkfvSuOmW1fwmo9KA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Yf9Dl+gwUPEyieLdeleJWm3UQzPFFJ3fUT1LpovOFnBAbsxRtfg/TRI8LdxewoMEY6Bhzls8dMiwo1ZVcKHDBvyvWtdni4jLznscLZOYl9rLM1q4LZw0P/QTm6mU6CPF0G6aau+MIQ5N3Q8q7Ky7L4Mt3PQQkViHdvge1e0y9AfdQKQIjhpVLqPokKsRtgKTzdqFJaQHQ26/ZcwmcPlPBnAONBv12LjQdY5tkg3Wnray7uPDG/y5AYG3C9CeBphgc+3U6OQeqlbM9UlcfkR9UZNW9wGBAa7TNqVykW4Zy3IF4yHW9MeRQN3kxzd6uaIhI8N9LLw8j007lFoGQjoiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11042
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	466d3fd4-ee5d-4891-2a08-08de90052f71
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|376014|35042699022|1800799024|82310400026|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1t1ZWcxz3+x9hbqSS0TLKmQ/7l9xkotJDL2sgkulmFub72Pggv/+YynT9vliGtP6iiSr9LXQ7HTgLCd9QuMtsEjHMXra/45vqe9jWaxu33fDL81LIfig+lng4FVXUaOLJcIgdeHeJTPsmanErLGkAHcGoX1gGdOeIAb5FDU5nk2QgzvvMjy1FQbbypTucE2R3j3EDmTwpKH22Bbm8gkxs5pw2ElCYhJQlasVhbY2IWTuzOnJi0wN3i43Dobrw1EkTU83erpWYm9WBFF2ZDmFJO7blqgFHjSRDY/MLJNaca+Brc57AhkRgeiz+TidkN07/Hh/5C/avSHMriDUIo5V4ZAfj1EEonG96nObB+S5QLytHU6CBSeu+RZfqRCegN3JRBNvmm0MpKa7P9u11MKL48ccJrjYj+HgQ/XYAWU7v+Yxhj9Hl7VUi+3S3Y2Mw8WeQoRo7w4BlJ8dhXF+WLKyyshs0yy81DfTMtIw9u2iJU1d+9zYlNgFEX7FNDjzB880eJYvLoCwOH28L+1d8kr3LhFQqWJ04ctLaCA+Hk+KK3NDp/2abuz+TrDorgEM4BCNz6GVGYNtL122jArvcjRGJDCmjPk9k7WXPFTYJ8NxacC15cEslO8ZG3uENhOLuUSEDhrUyEWNJjEuhGsdbn+BLzPoaqnG/7JkQxZwM8DzwLVCk+EYBM8tDEKWHRAvvMjvx1zBlsbpOOrDQbusoJHGGAg1wFPUJ1wvWPbeu2/k1F4=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(376014)(35042699022)(1800799024)(82310400026)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WUo2c6rSU90oiU6nTxapEVA82SiL+iKnG3SsvSJZCGnXXuARvySru79v6Eih0nyt/XkRTZI3mYVOgxO++cCXP8owRgxFL0do0aouZoHfmJ1x1Bp0al3y6zazgAoLg9Z8aYBNZRnm5wKFlyG5m8ENPfJtuw4J/K4YFpKG3WnBMBE2Eqh8/U/Mxewn2IFjhCvjJlPRYgtdFW27Jl5jOWI7UNvibzOg7VuwLM2WoAUBh3wT8edOKFwcVYDx94/itTpvCVtL6fIfg/Ry07qEtYEKp1qqa7g+X1AwvmGhfoRrUlIhF36DuRTWhmO94I2mmTdhePuZqr6o9i60mQIdJbJvuW26QOAOzR8005xxM4F72yp5J3G8ybTul0+mGmcR6oaXcGCiuiizfQoCPIvlXrHSuiuwdWT4EaZvm2flOyhx9WmEZbcLO7Rj0AP3clm2h50g
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:42:52.1944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302e1ab4-121c-47d5-12c8-08de900555d4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10123
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, Mar 31, 2026, Corinna Vinschen wrote:
> On Mar 31 18:49, Evgeny Karpov wrote:
> > On Mon, Mar 30, 2026, Corinna Vinschen wrote:
> > > On Mar 27 12:43, Igor Podgainoi wrote:
> > > > This patch adds the SEH_CODE macro (defined in exception.h), allowing
> > > > a single EXCEPTION_HANDLER_DATA metadata definition to be used on both
> > > > AArch64 and x86_64 architectures.
> > > >
> > > > It also fixes an issue related to stack replacement in _dll_crt0 that
> > > > impacts SEH and signal handling, where due to an epilogue optimization
> > > > on AArch64 the epilogue might appear before _main_tls->call. However,
> > > > after the stack replacement this optimization becomes broken.
> > >
> > > Can you explain why this problem only affects aarch64 and not x86_64
> > > as well?
> > 
> > It looks like the x86_64 epilogue is also optimized and appears before
> > _main_tls->call.
> > However, the x86_64 epilogue uses the shadow stack which was allocated after
> > the stack replacement. It means if _dll_crt0 is modified, it might bring more
> > operations for unwinding, and that might access the stack outside of the shadow
> > space. It will lead to the same issue as on AArch64. Potentially, the compiler
> > barrier should be enabled also on x86_64. And the shadow space concept does not
> > apply to AArch64.
> 
> Thanks for the explanation, I think I see what you mean.  Right now we
> subtract 16 bytes from the stacklimit as startaddress for the new stack,
> see https://sourceware.org/cgit/newlib-cygwin/tree/winsup/cygwin/create_posix_thread.cc#n270

Hi Corinna,

The stack is also subtracted here
https://sourceware.org/cgit/newlib-cygwin/tree/winsup/cygwin/dcrt0.cc#n1043

> So... since we're setting up an entirely new stack anyway, would it
> make sense to subtract, say, 256 bytes from the stack for both targets
> instead of just the 16 bytes?  That way there should always be enough
> space for the epilogue, isn't it?


It looks like 256 bytes will not solve the issue.
It seems that after the stack replacement, it is not expected to return from _main_tls->call.
Otherwise, with the broken stack after the replacement, it might crash.

The epilogue unwinds the prologue, and the stack might be significantly moved in the prologue.
For instance, by allocating memory on stack.
Event slight shifts on stack can impact the epilogue optimization when it appears before 
_main_tls->call.
This is why it is better to prevent the epilogue optimization in _dll_crt0 by a compiler 
barrier after the stack replacement.

If the statement for no return is correct, another way to describe it is that the epilogue
should never be called in _dll_crt0 after the stack replacement.

Regards,
Evgeny

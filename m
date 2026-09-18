Return-Path: <SRS0=wEYc=HK=arm.com=Evgeny.Karpov@sourceware.org>
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by sourceware.org (Postfix) with ESMTPS id B8BF44B9DB73
	for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2026 12:24:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B8BF44B9DB73
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B8BF44B9DB73
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1789734278; cv=pass;
	b=t+X3IFPoMiO/4syxe8kF0g80dwS5JmkVT8QPSZr0vTISJERHbJEAB1QrWqDdhb+kxjqyDiFzpuDQqf56Vi25UXKuJVJFk76YN6J2Yd/Rb/dH7QDesRwn8rjIoGxI7VIXyRXsdL6RrnzOPFHoO76XHDsvKBSjwP4LZ5tVMx26894=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789734278; c=relaxed/simple;
	bh=OFBm+EbjA4PEAAvrJsiCP69vzjwcMi69x7fYdVQKqnc=;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version; b=nOaLRtB7SQaUprVJzRh4tPjHsGD1angjtBq6pqZEsePTlUKwsU0OSwBBl5hsJwMKl0pdbtQmdPBYwaVWy7bpQ+/C86Bfv4wS0UdjOh9BMAGvEfWomYxvaYCpzvxSdem3flOw3QgPGcKROOA8CcSgTdy8+5DIJbrBWldjKfqI8CU=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Fqj0uCK1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Fqj0uCK1
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B8BF44B9DB73
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Fqj0uCK1;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Fqj0uCK1
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ucKQQH8Ig9DCjxkNarCcXVVGkA25Snzw3btx1dqZQagLwcr7pUu+RE9D7X7Mb8k20WK22aEmKfYw8CoGsBEmqMKISm/3paiY55s3CFbSAY246w3opYi1DilazDaVHcyUYChfaHaBtBvNDNwNsvINKJADwE1O8uETbDMz+MNobLTqiUPzW7Px+EsYRczM4DeSc6ilbCnWIE7Wadc7N/hbkzMzNiGjactjWzIghPGI7Fg6TKF/p+5h7bS8oq87/kVf+Vo4HCnVaGQ2cYmDJV6XBiNEcVZGKUHwtY6Y6puwMrY3d1oT61cjoLlW7oDqpTM85LsYc7xPFpABrU+MrIdcHA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hlQS+D+jiHlGeze2eNhwIItykOLHhNRYLUBHnyFYv0=;
 b=Re7uGJ7X9BuyGXK+Pl/iaIoIx1yDU5x+6LuntNHqFbCUQNeBZTXTZnNvKrG9JT6XEAM/1GxCm46u1nmwZFSH7LCfUj0CAaeA4djBCsi5ZHcVWOXfWermTDnycqbk+LdnIRJM1Xwaikhtj0QheNU6l4hy9eNErpgarTtw3/0xj1J/7J9ff/YBhcccs27SKiNFGaDyA8lyGpDi4yc1i69U8M4AkPxWmNlrUEcWP2JC+O0aXZ3v0E/YJLRgK5fZd4ehTNVlHpsE23sgsc84gSSIt1eGfO6eRvEy0mn5aXaNq+O0bp0010vpxX0FWjcQaAcgxmq25fq3XbBpk/I4C4C6eA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=dronecode.org.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hlQS+D+jiHlGeze2eNhwIItykOLHhNRYLUBHnyFYv0=;
 b=Fqj0uCK1ad9ZOsJ2mLJfgDfvUm057sNqjyqICFcYOOa0g1lB3xfqthPbtpv1fWW6AJWJCLT99tYVLJg0eWrp0eTADQ6oVILEszizhPl+9cnqLBftFyakFTwzYJ2raszpbFObvPitlg7aYuShBf36s+QBQCH6WX6ukCsFxUU72EQ=
Received: from AM0PR02CA0132.eurprd02.prod.outlook.com (2603:10a6:20b:28c::29)
 by GV2PR08MB10353.eurprd08.prod.outlook.com (2603:10a6:150:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 18 Sep
 2026 12:24:29 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c:cafe::45) by AM0PR02CA0132.outlook.office365.com
 (2603:10a6:20b:28c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 12:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 12:24:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNFEsFPVBGjmWQAEXG50xb3+xbQUK51JYGa7FTdysV6/zYKpB4IHSCRRDmRcZ5AYaybWgGBvg2y8sSGWVYJ+/jddZ7zGl11R2Ch9Iquy+6JvU9Z4IBP4Hv4N9S7gGELLccp28xG5yJYG/LAqbMlRkmfnKsOahmLDf+gPjCjnl5YaX/CpMRTNGyNevxfueS/dyEElTb7i7QQPxePGh6YDxb4CYLUO+mbjUtZBfYvpbKI3VTunhy2HiXkFmGjXmlx5Az1VCKMCNWChL+8sKjSbRPVZtUtFp0Jjxq5wmLkCjWij1LpQkfO5tVYbKFqfhjVz6eZtVXdKu5tgzYjO/O+Rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hlQS+D+jiHlGeze2eNhwIItykOLHhNRYLUBHnyFYv0=;
 b=tDHMLy310brSG97d7PJXmvKpT2FHSrES623nIQdYxu/wSwfRt+2s5q34Zl9CzRe2D4DQtY/5oDTl0mSy7UVwteaQxkTgcxBgJfwDkZ2miE2HXH3CRhffyWDh7QYVN1M5+bdGbcnuhR84U0HsG5AtJFMKZKj1nNj1ITOZutytnpsMzVUmCy6PxdFsnzyiWcF3CIgfrpBtPHaNZ6qZgSaczd0vKMEf5jwigQFBLBTxPtIxT4U/q/6x1xSyCdklxoIe5HQgW3IZshGZcDNhN/DVJMe0FMyFopIwyMPqLjt4Jftg6F6qyg1T42Jy0J0VFEZRhyOZkEIAVwvguKhuJ5AIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=dronecode.org.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hlQS+D+jiHlGeze2eNhwIItykOLHhNRYLUBHnyFYv0=;
 b=Fqj0uCK1ad9ZOsJ2mLJfgDfvUm057sNqjyqICFcYOOa0g1lB3xfqthPbtpv1fWW6AJWJCLT99tYVLJg0eWrp0eTADQ6oVILEszizhPl+9cnqLBftFyakFTwzYJ2raszpbFObvPitlg7aYuShBf36s+QBQCH6WX6ukCsFxUU72EQ=
Received: from MM0P280CA0004.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::18) by
 PA4PR08MB5981.eurprd08.prod.outlook.com (2603:10a6:102:e2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.5; Fri, 18 Sep 2026 12:23:55 +0000
Received: from CPH1EPF0000051B.eurprd04.prod.outlook.com
 (2603:10a6:190:a:cafe::3a) by MM0P280CA0004.outlook.office365.com
 (2603:10a6:190:a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 12:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 CPH1EPF0000051B.mail.protection.outlook.com (10.167.241.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 12:23:54 +0000
Received: from AZ-NEU-EX04.Arm.com (10.240.25.138) by AZ-NEU-EX03.Arm.com
 (10.240.25.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 18 Sep
 2026 12:23:53 +0000
Received: from arm.com (10.57.50.87) by mail.arm.com (10.240.25.138) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29 via Frontend
 Transport; Fri, 18 Sep 2026 12:23:53 +0000
Date: Fri, 18 Sep 2026 14:23:52 +0200
From: Evgeny Karpov <evgeny.karpov@arm.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: <cygwin-patches@cygwin.com>, <nd@arm.com>
Subject: Re: [PATCH] Cygwin: autoload: fix ws2_32 chained init on AArch64
Message-ID: <aq0tWAHikk6Uv3cc@arm.com>
References: <PN0P287MB0295C357517BE127B601D99092F02@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <aqpYA_4qPMpjT7b_@arm.com>
 <1ffe50e1-0e56-483c-ace1-c5ef2bbcb98e@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1ffe50e1-0e56-483c-ace1-c5ef2bbcb98e@dronecode.org.uk>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	CPH1EPF0000051B:EE_|PA4PR08MB5981:EE_|DB1PEPF000509F5:EE_|GV2PR08MB10353:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3b8b6f-accc-43d1-3bc1-08df157fc918
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|18002099003|4143699003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 8Tolh0uaKLugcBSoB/LuCrKI4zN3Vs9iQa07N8gzDrmZ8XoXNEl0AcK5qpnby/mMxoGz+JB1xOohC35b7b2weLHKzADQP1p2Q/u/aoVxHTYbHJkYgdc95tL/bcttps4kTZE8zeBwj6dBGWbCziF64Yg+IjoZszjQM3h0lVdyxyvaFOo5wwkF/JZZqUmh0sB53JEvtKZXpMT9+r/t7mL7CHO5lrqzTpq9rNf9vfVzj3qgwOcKdsmV3PohWDX1JegR25d8/Fycw+JX31ugKpCAZ67Uv+86P6LCwyEVsejzgykbrtXDm8Br8SbfWUDpp81gDVeGKhhHZ+hcRaunHzlWPyFMpHrWKT5IyOGIwA7iRkaPL+fLRMydhuskTJ90uu2XW7XVdD0W8Pde2ZNTHYba8W30J/8Gy6KVamZr5DjMh09NQt9TOE8uTyUZFDjH4rW7wjiP6Lw/NYXzjEiRK7FSo5efJfkcz+rhDoSyraR1s+ujBLk3qPZ1xV5L5zFUoGTQhAN8mCwp7Dm/1jG/sTwP31thNbTwCGXK/7tdW1S2qBhFsQqN5QmxEROgS6orTTEyS/P1YZLM9ND9c2d57iXmaFPqhC6qe/YQ81AgR9MKoGx61XC9Rnpp2d5A6z87WwxX6KwvGosNGJIvuw1DSVfiPI36TSvlNcWbQ0C9mX2/CQM/VZlvV2Tk/bLjau2NPxecNu0N4gkPaCerQDlHY+1vTw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(18002099003)(4143699003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 exJv1OgU243xZdXRzBsXuxhjRF6RfEQKo8sCy7AG9qBvMNk5WieMKivo4PAtSDbhDSeQ9pIxFLApsQe8XRWrI1rIgzgzdv83YVw+qalteW5OtxkfdEIQ60UXEcdqQN5bRv3JUDBbFk0BXPhQQgj2EMevc1MQOidpZOWkg+zt0E1udpZ+A4n87HQQ7a52sehl2Ev2HAycT8Bi9gqZ8/bMavA2O7HxacXO++kzV0ykhgg6712KwVB9GZHaocjhND+s52U4jpYP//8ElyMR3pRyTKmuwAnJ7EI4hK4eQLWQQla1K1i7w6PktMDvchUCCBp04K6/1u19I8C4OybD7jSPog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5981
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2d5094cb-7e9c-4100-0046-08df157fb4c8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|14060799003|1800799024|35042699022|23010399003|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	5Zfilk5gfc5/jOMTSUAZXvgfVDIum9hBpW1dj1gt1Qa6igSoIhy+I9oJeB3e2QNOjcFnyvp3PtBL8ToltTTI4rPWGBua0dVOU9k9vYMeS9hPLs/HoQcmURQA+5dW8ivcimBU/aYjJeDqhKUV3AytSASoYcOKWz4+pNn/Q103a3rLKjLKTJQwCVIfLbQ98QjMJGb32Yz248i8w+X634QGe19IJtv+246wPMTHbk4uZmX+RmR5AyboO2Y2ZLVtZWlfATZ9gKT8p+CCLUdIa1C2QldOvsjG3Mo7nceEFSZLvOpMnacyJf0DRszOEJ8b2Km0n0dH8jAR0lTW6YoeDSVNNqgXyQYWbvxlyQNmXicLDy0+zXG0RnWTie4H9K7K/huOZp7KzN5v9muR5Vbiqe1/TEHxzvQkulg3K09GidUAviEkQbjeCB4/k35EEkM+sRoTZQiObdwMLfhZM9Emm3RMFSVyuJL5Ab+pJ2A3yrBhcqlbws2w6T2v1DeHyvDKhLBarVR/7EEA9RDwtrtKJRx05VYCIgFFhPEoeB/QH1BBrQNA98Ny0uvu6MwpL1VTyEtFmwzaG7+d7xlq/Ed2TDXpNGf6es35NvECGsTYlbLqJK2dCTxnqVjiAS//PilbNKVyelS9ZGR3zh58Ya6+v65pB3dv8eFfPmIh3hrW5l7Q6/lW1XrWnN/Jzyoe90eiuRi634XgS+jxK4vhwV2w+WJgAw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(14060799003)(1800799024)(35042699022)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tkxYtuvpvBJd5RbHoq0vubtqj+JNsKPIxwF3pqKYId5wxyMl3drGoQzFMBGNptXSj9+cQD00nLSPfTDR4JL3yUEJz7mECJZdd3Xf9zQIWVY2EqxzorteBQswNJgArSYxxFgfLdkgRUMcV/W3kB36Fowev/strQp2toPPmxeD1AEobiF0U1Hg08MDxIg083Xmc/83t+yOoUTqh3Pvd9DT95DXCdHCa3aEUxWWygjzUajU6e59Y0umJj3mVGeoBjhbBGZXeGK/o6bOH+XuaojAOSD5H/3uznmCoG4dizG+xK+9399/1UpE7MXYpNJFSbMkvcIJZBYJEW/Jrka3qn1vcQ2JdJaxh8qJxdiUa4gSuPUjjbpi4yZQYjOtZDCXjYTAQI3iROODWGZ3v3xsaOhiRvPvEIYC8qP7Z7TJereeaSVZfQRMk95C9pk5xCi0Z+sP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 12:24:28.8264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3b8b6f-accc-43d1-3bc1-08df157fc918
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB10353
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 17 Sep 2026, Jon Turney wrote:
> In theory, yes.
> 
> (autoload.cc dates back into the previous millennium, when hand-rolling your
> own solution to this problem was the only option)
> 
> In practice, I'm not sure what the state of the 'dlltool -y' implementation
> for aarch64 is, and I think there'd be some work involved in mapping all the
> various ways of handling a missing function we have onto
> __delayLoadHelper2().
> 
> Patches to that end are certainly welcome. :)

Thanks for the clarification. It might make sense later in terms of performance.

Regards,
Evgeny


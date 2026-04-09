Return-Path: <SRS0=KgpT=CI=arm.com=Evgeny.Karpov@sourceware.org>
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by sourceware.org (Postfix) with ESMTPS id 39D124BA2E05;
	Thu,  9 Apr 2026 12:03:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 39D124BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 39D124BA2E05
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1775736210; cv=pass;
	b=aJ/hpvrbDBRBehOgxmi8rTVuhc72XKHq4LJkGsI13DaE8kLxPPDXkIokAVujBJ/1Noq0Sa16wf9pRv0OPWMkDoxUYTMwplZnI1PnJ3ZVV2gvwadshC74M4AbLVBP0pmBD7O8+XoRkiz/EFrJHm4dBPziufNssRiHS9Nqv33ITVc=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775736210; c=relaxed/simple;
	bh=f1luawaR1mFWQuaF5oyvGTEIQD0qsX/bav2yoxAubbw=;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version; b=lOe25lq6qvKTIH6uFp8wQ2NUJ5NlrDCFc7Y2uccX3oDVeajM8J9UHXmPMi/u3DL8kyz5Z2OXlQ/CF0neICdGPprfKDTX31l7JmOSIf1eEEdAGoVfVYHjLFpqnN8+e1hmNiKM1014iWls6aiJdnqPXNl4MfdcEVbLrO8RP9+fiwo=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 39D124BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=MXelJr6d;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=MXelJr6d
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=P0Kyuqbl4/NVI6/CYFKuc1w7w1hPy8smNw9nA/bGrDmMzNFnDGcCHdX8lMagNG2h3hMuVNiynq/EgkE/tZ4wDkqU9ljHIBNJiVG6IKtN2EpLyX1urPljHQrUQ/wNBljCYhqiA7lYoDkZtKicwp6qNH8fpRJ9oKWojHZe9zIJihFg9Etc6d8udLbVFWy3PMEo4gh3A3xNs/LycGDH0dQk6VtevAzkhJrmm8LScFTQtbsVzSpkscxDZ2TlXDSdGOajgPvudgCz0cTy9/d1QjRIdWgntFggMwtMpLVri9AaCwU9DlKOezNOqcmKVh0eNWkain9dQbbYqHqgGa/IkeLAsg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N2p6kI5xYchu3yQb5Q2rwEaKNB897vrW+BZmfEbDYs=;
 b=eqmnThnSsmkFtOc4lmG4pLXO1m2wQbo0noowrdL5G1hlmLkMaN71qjgnBxDbQu+RyBZQp8tHowZPRZ3BjMLCZHXa883FdbKYDAGsNk9fegVlc/TNxwyls6dYlPQep2XO/Skq05Fg8ztdTNJBWXomDqcUv4DT9IlfWTvo86TCgVxJxPH+7DD5fax2YFr964k7oobPjG7nBjV+KN3bv6jdKRaXCWHomsE6vSm+Vf3OW2p/EaorpYQCmuobS7vQBxrOUCDq13syi3Y5jR/GH4o0/mjmj9HFRaa2wtTJfnxUAQHrElIUnlLw9TLJv19Rw7DpCrLGhDKWRC57lXeKZgzsPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N2p6kI5xYchu3yQb5Q2rwEaKNB897vrW+BZmfEbDYs=;
 b=MXelJr6de240UR/pqzG0oj03E7/RwrVjYrfsjFbcqelZdDlRoxVd+44/58LtOwvC1ObKl9idgikU1pyCTwUWGlT6ZqL8i+FeVU3ATJHLBgpO2PlEe2yFrUAKHF7MywNrhmUlrb3CjrKH/6HcwdYPBtuGp/ZZmpVRwUJPO9AugRs=
Received: from AS4PR10CA0016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::8)
 by DB9PR08MB9588.eurprd08.prod.outlook.com (2603:10a6:10:45e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 12:03:26 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::88) by AS4PR10CA0016.outlook.office365.com
 (2603:10a6:20b:5d8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 12:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 9 Apr 2026 12:03:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOsrMU5V61yPSLlezRqfLUgwpiFxdNZAPtMeH8sV0/wx/mv8EuF2HcM4FNu67qFVjkxirS1eVyWFDurKDS8Ql2msChNrjL9rEnn53y9OL0HqTCyg3cNDjxMVDI4ceLZZGkxEGLgrpbw8uJ3S/0qVWhhfIX6CRJ+JvbE6fleE3mFbvnSdYTjIhHFJcK8y1KboYmR337AyAIakX+jHg+U1oyyMTVgeyulP5LHJSr/GC/2h9bPXyIzvb8yRom3D+X73nk4LqQ5JTg0jCzyVhUfzOV8nk/fAqyvMRtZw5g+MIWYMe+hIs7R8ORVAuVy5cXD0/RcxDDaX4E5YsrC/gT7NaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N2p6kI5xYchu3yQb5Q2rwEaKNB897vrW+BZmfEbDYs=;
 b=TwgSydiXapZQu69VZezHZiMFIgNXkFSAh81zOD8cDERmfPnDv+ZFIgXFCkjZ1dtVEFrM/lG9XuqaXNKsbLt7aaRdxpCZ8wKJWiHpUV6r6XXjR5Tkwg/PK90I51V9t5rIJtL+JROtr2sTJ6+Q/Zbr+1aSsTyB1sft0xcg8rTqp3gZ8jjq/8xcWFrwgVa6gBNqlM1Y7yTJIMLksBM5CBjZ1LTLbtkNqEHHf9z7w4jVkLNmUrixWpA1dQq9OI0cG3RM3hbO8UQ+QsYUhOoacB22xE3BuclpIWOk2ucQDFOMBw8XxFiWlMWMMP7sWxc/+SPWwYaC+eN30BGGnvEiZ/3idg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N2p6kI5xYchu3yQb5Q2rwEaKNB897vrW+BZmfEbDYs=;
 b=MXelJr6de240UR/pqzG0oj03E7/RwrVjYrfsjFbcqelZdDlRoxVd+44/58LtOwvC1ObKl9idgikU1pyCTwUWGlT6ZqL8i+FeVU3ATJHLBgpO2PlEe2yFrUAKHF7MywNrhmUlrb3CjrKH/6HcwdYPBtuGp/ZZmpVRwUJPO9AugRs=
Received: from DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) by AS4PR08MB7901.eurprd08.prod.outlook.com
 (2603:10a6:20b:51c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.40; Thu, 9 Apr
 2026 12:02:22 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::58) by DUZPR01CA0045.outlook.office365.com
 (2603:10a6:10:468::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Thu,
 9 Apr 2026 12:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 12:02:22 +0000
Received: from AZ-NEU-EX03.Arm.com (10.240.25.137) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 9 Apr
 2026 12:02:18 +0000
Received: from arm.com (10.57.19.2) by mail.arm.com (10.240.25.137) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29 via Frontend
 Transport; Thu, 9 Apr 2026 12:02:18 +0000
Date: Thu, 9 Apr 2026 14:02:16 +0200
From: Evgeny Karpov <evgeny.karpov@arm.com>
To: <cygwin-patches@cygwin.com>
CC: <corinna-cygwin@cygwin.com>, <Igor.Podgainoi@arm.com>, <nd@arm.com>
Subject: [PATCH v3] Cygwin: SEH: Fix crash and handle second unwind phase on
 AArch64
Message-ID: <adeVSHfhTSJYMjpj@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <adU95HxqoWa4xgSQ@arm.com>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB1PEPF000509F6:EE_|AS4PR08MB7901:EE_|AMS0EPF000001A1:EE_|DB9PR08MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 46910437-d9ca-462c-f549-08de96300186
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 1b1395hsH76X/AKzQT7xwwagKNuAcECWV71WKs1Qm4C+uZMB7qg5TFGPymoXPt4onU2D8tFvxxNzCBdVJTPJ1xzwwC6UfqPzQ00edoKZTbsgsVkdt+QziIWI8sBDI2AuGOgpF/iklVHXq/Q0jQG8K6o586afG03Th8aexnbfa1NBsspoVVSJCAuQBuehCPedJ6Hq2NS/Oy1b2CSwUvASAcVvCekZBKrjLc0SVXncVor67Xi8/OvtZsx20eMedqG1Oh4e63XTrAiRyXk04GXby+NPcUWUp62pJ87AOttdnOtJcasXoPaD0E1scYLNjVfiX14VOwtlSbIBzh5kn5tTtnmuJxQTxoeoSfOoiXlI+mtF0qJIrKdmh1Zr/eWmiAi7tdCt3fBiESxxF+iMyXkcvaTzMBYVYUm8F4Ob5o5qh3ZQ3ekBI98N+bTGF04zPXRz6pc9aRD0F+FTchFf9i3+y1lyXZRNapeoDY2+tih36MfiQA/1TcXI9kJ9O/2780SHzWegCFWQ9FO8wtn1WaIKI/tykwH1ez/qliDLGUHRu/bqSiXGExXklQeYepO3tpgM1hV64hKzPm9qBCU9NvKwWVW5qT2R7HrmHYZcqjnVe9VNo9kTPp1K72s29Cd2Ki3ADwO/wzqRGMtK1e/+4YiH4HN0eIkkW78uosHhlFzO9P2ELulcgkN+Rc9o0J5TfTAPn65pUcTWC9yDURVZF4Nu6bTHam2ISC/HKvXQVFQlvcQ=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 vbV/y58+P2ZLa0z2qjlK0MDOs8qUMOUTtBHwH2DL87j1YilCmKlq0vqrr9kRq3DhICud2Jg9yP0tZKA7EExXXCTMy7ZoEuRYLcqQ12a5KyBUEAhioFKN8CKn5FgltrP3z8f5HV7vA36+PabpJW+hm+cOREtLfI/qtqunVOqnNvMKYo9tzjhG9orRNoPRR3l30UKi5NIdlbUzxS2ycs8FZqb6xAEs72sia3pOaHTcLICjA5JIoFgHDmsxVh4XU8fA135EkSonLwE4vWN1KhwXclEKacyCnuoODRjr+/W6TZtOy6QSWcWroarSX2asVJ6S7PtR0zyz7j0QPSTeEmS0Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7901
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5e326a05-173d-4870-b2dd-08de962fdba7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XEzJJVuXYJ4pULW9ICL3XSV7E9gLafWN9UEk9sJNhX06n/1XhGNIcP0AnGifMS/l9Jb8WiPN/1d8FA4dUDtiNhMnDldsnlscbnE75QTo7fV8IZOvkoGmLt6kkuAG51PZn6dI/4qaTP/T/CGgL2j4V0de5R1cPlkJA/EJZwBcLGKgv6QZSoEtktVrqG6nKnt6X5t3lsJw6ptIHtSYaAZ29MAF+PSn7f7R8QtA6htETYl7pK8YW26Dk1wwzYuZ1MratnVxNnO4A5MBQlJ23oU8u5WxvP7au/tMP/ULo2lbB9u9tcyKBaUFwqDL/pgtWbj6gLmEbqoiKplUFuToCjJYzw+WbF5eOeb96ltkJesSEfy4uzv5qVqMLwbNBqKnvTh16TDvMM1yIwfbTzw9paSREtLrHdpDOyFXNQcL4P3pRw0rlkp07gqT1qt62Q/K7fe/Cz6Hdbkqc+RVrsKBl4ifa+mSv2At4w72VlV2QEZtl13FHN8hi97G5HrKGxZrF157XJj0Z8TqM8D7hzrdsxSaa4lELVg3qtIQdgOd7laZr7qzrfFacnAEbQA21lNWGftXRIXfzZbnLaVZVbjejPB88UFywKouUIQCgEeEjg63Sq9XTv573xT8IYRZ5FUmI4u1x3YNOD6NyYQAbzUtNmE65m/2XfkJSZJzIts5kfoaCgRS0fyW5faXHJ4GYFIDa4IQ3xJBa++Wqp/GDNONmYq0960hJQ8axs25iSpshWRM87g=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dmN4JQRzmXFl3w64MhAVjc4YDnfhK9GLINcEKSqJYUkVXJAw+ZdCrKP16c9o045KX7aw7HVXV88thwdLWebIIAmq8dyDrFRLD7oTZ9ZEAEi8A3LB9vL0QLOhg7sZyQI78vMA/zEq599SnyGeznjVjtjDBGtwebxm87hqXw/4D25Kki0sq4BiK7sp1wP6znbxJhbBi9knZEx2b2AXS0iSx5GwsCSjffqawNYUh5e+g/i9uGdzr7FHSUzInlqvEE2g5yHpYrSC04GU4mpG01E5dZxyBTrtcKPNi0NuRLcYeR3VBLReZZjZByXSFehmEG392rNKstI4LdQKFQChKK9KAK+lupGUXqhjkSYRrnT2u6yC53rvHgo2sLdWeRYdJlM8RqJvWhzmV47HgHSHgcojV9auSFRyqwdz8XlH1EEMRrIHi0JVq7u4Q2jm8MV04FZb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:03:26.1003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46910437-d9ca-462c-f549-08de96300186
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9588
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, Apr 07, 2026, Corinna Vinschen wrote:
> Hi Igor,
> 
> On Apr  7 17:24, Igor Podgainoi wrote:
> > Hi Corinna,
> > 
> > On Mar 31 15:51, Corinna Vinschen wrote:
> > > Do we actually *need* the .seh_code on x86_64, or would it be sufficient
> > > to change this to .text for both targets?
> > 
> > No, as the SEH metadata is defined in the .text section just like the
> > preceding code, there should be no functional difference between them
> > on x86_64. As far as I can tell, this is largely a matter of style -
> > for example, LLVM does not appear to reference .seh_code anywhere in
> > its codebase.
> > 
> > The latest proposed AArch64 SEH implementation in binutils does not
> > support the .seh_code directive at this stage.
> > 
> > As for the original reason for the introduction of this directive,
> > the binutils commit 3c6256d29e2c528880a3cf8df43adf32c7780de5 from
> > 2014-03-25 by Nick Clifton <nickc@redhat.com> explicitly states:
> > > This is helpful because the code section may not be .text.
> > 
> > So it seems to have been initially used for convenience.
> 
> Thanks! Shall we just drop the SEH_CODE macro then, or should we 
> keep it as is?  What do you think?

After some thinking on this topic, perhaps it makes sense to
simplify portability by supporting .seh_code on AArch64.

The binutils-seh-v7 patch series
https://sourceware.org/pipermail/binutils/2026-March/148657.html
will be extended and .seh_code will be added to binutils-seh-v8.

Regards,
Evgeny

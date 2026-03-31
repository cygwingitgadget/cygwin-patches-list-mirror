Return-Path: <SRS0=3r/z=B7=arm.com=Igor.Podgainoi@sourceware.org>
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by sourceware.org (Postfix) with ESMTPS id AEB214B9208E
	for <cygwin-patches@cygwin.com>; Tue, 31 Mar 2026 12:13:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AEB214B9208E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AEB214B9208E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1774959195; cv=pass;
	b=A+Qz7bG0CtqXf9JxrxcM7ZBvdYAMKbHzPmyRPLltJNs8z05eHaWj9h5kMYSsr1yS9hnd0vVrXPlWp6HXZbxEweDdi6BX5XhEdfQ/0hc1wJ0RNGFtrnSjltVYZpeU4HuVceSMY8QKxAwK1Gc5zJZ1h5Ioa+XyonC+klUTh9zEu2E=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774959195; c=relaxed/simple;
	bh=CybPzFZdy1cmkwq9jTfstZTH9cAsnAv/3aCMVF/9JJw=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=jwOFYSyqs6DDkVTz63vpCy/TWQNnUoF0NQScsad1Q94k4KXlWIDkzDomRA6CeA1wTWMrS8e2FLOQRdkkQ+rdRroXnBrdQPXacE3s/7lMm2+dubHyqBQtW3cQdsQ9oOur2Raf9UcaygaYCST2qeICjKTcH8NufuDmWcrlq+FuFts=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AEB214B9208E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iHS1R4Bl;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iHS1R4Bl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DdCsGSW7dgbdO3G3cG8yoNIN6/lBkawHaZBhqzciHzAciDpSfx/Xb8soQ2UTGRglYS1K3h4ofueWMkbjfvxMOiGQkL4IjrFhT46KWU5yzfzQobMMjScjxiuZVa4t/AucICG+gwqnr6kig37BA9ZXCfdcjlmBkLCDcUXOsYtLFivP+GViAGUxSQy1OOTu7Rc8ZrkXku1/9USuY08lIvLwzcnt3VfgRrz2qcpnmMCTnhFZ0dNn3rXdJQMeNb9TGM5lBTo1166KuZ6JdaInk+t7xpJh/uzJfWekzDNmizoh3d/9IrxhV8kHmN9CfWxgsZsS+MKUeClSKnDQ9bydtXLdoA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CybPzFZdy1cmkwq9jTfstZTH9cAsnAv/3aCMVF/9JJw=;
 b=PyEsoVHjb3n8h91C0SjaVM+k03EgYAGN7vkq+ZvxyW/pSLNyhHrHpPQkOvFKrPqZdHjhm5cp+GMi/KiLNWkXH8hdY/YP9tt2vr2YlhLbLyKd8AI9gz4aN9nSj4/Uly2XQV3L4R7ffk24vqjk68EJ7hxrV9jzOZ37ItG7yba/Ft3BSJmrFTsFCCJFJqiVrm4773e5jQTqEgYd/OREi1Sr4e09oKBQSjcJJAy5wCvCjyUdreCYseI6sGhrKQN4Bg4U49RdHyJ0kqdJBzpH0kdVhiUQdTRR62qcdvDd/8ptvjGNoJfOZJAkYrYcX6viiEje7pPVg8iIL6hiRYZ1+S84KQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CybPzFZdy1cmkwq9jTfstZTH9cAsnAv/3aCMVF/9JJw=;
 b=iHS1R4BlyFM1r7jjZIGlGBmbj0ySway3sCtWaOhJU9XbuBakZ2UjL7ZZc+fvo+ns/aqykwMJqEmFpHSNpKJiw9KaoPUj3piQ+YTy575kAidIf8TMjLEWUzdB3AP2gEb4Yhlyl+XGV3U363VwEzcdh/zh5YfRA0E91/yP2Mt4rXA=
Received: from AM6P195CA0054.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::31)
 by GV1PR08MB11206.eurprd08.prod.outlook.com (2603:10a6:150:1ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 12:13:06 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com (2603:10a6:209:87::4)
 by AM6P195CA0054.outlook.office365.com (2603:10a6:209:87::31) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28
 via Frontend Transport; Tue, 31 Mar 2026 12:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 12:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQK802LZ9C8Xup0B00HmJR9Zk9QT6Cq45PqD19NkX4q9MvlsFh1w8NJCoSNKNhZgQK0IqmQJbohyv2Y4l25Mc7NWJNkto8D3JQ0AJWj5ahjtuVReeZZByJf2ryYZ2ez68S8UQyUW24P8TZBKnh3ttgocd8WC6V/JUwgT8vzkyV3U6J7kkBDh+4uscpJtT9rJok3SeyUnvbp84ghoUEfyyOowDxLC/XfSoFoC/l+5tSAWdROa68IXHi8wdlXRJQsAf247PfXR5ixTji8EZNJteCy5nO8pNddwKtBQWixQixftXoNHRvV4+j7NUoce8DReZcwh8yfpMCqnnS0MxqnneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CybPzFZdy1cmkwq9jTfstZTH9cAsnAv/3aCMVF/9JJw=;
 b=XTgYktSOuZATKvGwTy6RdOiUBC++fo/5JA4+3dQfM7DgcGKD7BxgHCYzCIohHrI7ngky/4ThqcyQtlsoa9giyhzuBNB+oyO65uWf5ur0iQrEzoyHBXgWHoehaCuq7X1ZP+JwSTNQgOquwYQOfLTi82OI4HeJhr4NP8bENlSDmLrpBZ9bMRXn/6kSFnQ8Uw0l8A1H63ERcWH8JEByWGNEOK36d2TURHE05wbYTPPPYbMCSorngFvSGbFpy161W9g0SJjWVVjYowjkiwlSC7hFk9HtQjI9Vrg3MGeem9K/YTYm8kg0II2NAbXu6WyQy53OcCJp6epV/XCsnWZ1QvS2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CybPzFZdy1cmkwq9jTfstZTH9cAsnAv/3aCMVF/9JJw=;
 b=iHS1R4BlyFM1r7jjZIGlGBmbj0ySway3sCtWaOhJU9XbuBakZ2UjL7ZZc+fvo+ns/aqykwMJqEmFpHSNpKJiw9KaoPUj3piQ+YTy575kAidIf8TMjLEWUzdB3AP2gEb4Yhlyl+XGV3U363VwEzcdh/zh5YfRA0E91/yP2Mt4rXA=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by DU0PR08MB8207.eurprd08.prod.outlook.com (2603:10a6:10:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 12:11:53 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 12:11:53 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH v3] Cygwin: SEH: Fix crash and handle second unwind phase on
 AArch64
Thread-Topic: [PATCH v3] Cygwin: SEH: Fix crash and handle second unwind phase
 on AArch64
Thread-Index: AQHcwQePj1quTQQV+kurdyj3ccRRyg==
Date: Tue, 31 Mar 2026 12:11:52 +0000
Message-ID: <acu6Bt7BbG-_Cyrr@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|DU0PR08MB8207:EE_|AMS0EPF0000019D:EE_|GV1PR08MB11206:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da7dcf2-e808-4656-d9e3-08de8f1edd1a
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 zp49frcmU9huuk8jPFAlEIJlhh4pNTz8Z8Yb5a0aK4/2mDNneT8qhgFbOwA1YId4Y2pXei97/wn6AurhoLu/jl3wJj5Nfj+hV2rCBiPYvIDqOsSp+2nlLlCwekNPUJKTqf2s7W/hDnpN8Ve0zMvvDf2t2fIfrKbXSo7rHuLHNXYO7cDGekzfvXdkNqaeQpXWHs2xr/AoQX5e/kpJpEyULpXb8Ljrow/VgiBydSL09m/eIN49cr7xf57Vf9X3bTz5KXl5tAnfNFOvsLALRmQuxx5TCakMOy8lIV+5aVpp7nPJ5KLNkjSB6yMK8ydJB+y8x8bD6U4AShjnNG5LqHCUncsHWtlqTy46rw3OzzHnhnD5aTP7bXidD2LAX1Z3xzP8cUli/L8LR9rZn+txUqEVX9rt0DcYD8mZXFwc03rREG3ZuGklpwVMzxlDVc3+by+oYGrCIGF8LIkw0Mu0rAJW7U7BjjHzQO8HpSKHe0ibWlbyYrB8yLjpW/G/Am/2R4SeUuCQdUd/g3ClJ9CQ8Ag8RP2Hl2aIob4abEXjw/QH83H7+AuBTgtLQyIEGNtXl6Iuveb6trqag3P3dlmeILYcbT9Mg48nOtT2q89CTlNVZleyh6DhZhnWeT1PLIHtP8EeBss0nKodKxf1XNm5KZZyNAytnfjiui0u49/RZAi6SJXDfQNlxKxignv3blHq4QDKaWMrhBlANgofDNfzPcqIrTskccM8o0AnDiNH4RiXmMaathtqHaBjkj3Dqzso0S2j
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <F36C94DD9B94DB42B20A3483F2A70840@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 XZO6C16Fe1OVdfJOsQoSsD9PSw3YZcFanv1+OtpSLPV+Y4dcUqDjPZ1gxff+gdUKun2kI7De+BHCxoCU1Yy6Gh8Spye8sBORDF+5f8W98sEvGouf6dfPFiVqFZCCJ3W0efwdYfLJhWCsvp3xp7y3P8ZDpqDJIPASk7ppB1WOG+ltgWAEDZ8hXL9SHKYv/yoZAiHvBEc4H7xgFrZFncwjAPw5PT5aysU7GqDZQAIIgUPokDU5l2LLoWmSSbbn/pCSU/BsRiutFnasvxqtHIIDfEgfw3S4PReoJ6pFExWD+pi+2iotJ+shlECS+cE5G2QIwbU0O8e5QEm8JlbHL4W7rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8207
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d99294cb-386b-41e9-1759-08de8f1eb1ec
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|376014|35042699022|82310400026|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LK/hTxuNu3C3dvm1dwJQUm3HTvdkHnTjqy+1L8w12Y3VoNwm2nSxFgAw2JOwL0QvPc8B7cHh2UUlZTvqInIjCNi0cH6xNlg/sdkPSMmoMWKgcK/KToFFhgyj+d6qTQ/PTa5vxNP7ioMWugp6EUZsazMLST0U1956BvA5F+1Ut1vmcE8mXrc22elI0nxlCXM2/Tdi2IDxKsVub/d7rvo2JMxAN0EGeFzCBKQUzk7WWzaMz/NqJSqwo/HJ1vXL+QHrmYe0UOfbXo8/XkTeh3kTgNe+ipES/EVPpRvzqwXy/8anSwMmOywn2WQl7amuozELLIOR/EQRBxPxiJ/AFcIFQWL5JW7dsbf0msp9QBw3jb8P4kZL8yosWj32RCy6drYjys9Xr7ZQGzikgwAR+D1707axiwDbsjBAr+wM4HjluGuXcUhAZcWdXHZp5DVVbMiFw9Dt1RyiCMFw3KHcEEptZw9PkE11ylv/QsRCiG3sZWYGsL71FiSdzeRH7dp7dC79JxUgQ3/24Xo+rhSonAv4wr5cFPkxZpnBLzHc36IypiNkyFFVGbPk4XQa9q43KVgFh6foJ+fuZQB6MW5s61lZXEIlX4r6VwTYafz68gzvci/gTSJd31myneC2j9ml0njD1slcLyDaQfRTjEk1k4BOy3+SyBP/TF4FOqLYpHnvzLBgpKiPVIJu5miZgTCKj9477Wr8a0GedYx5I2sr9+DhmMhJ3DtVgi/Syiyvfi2Lhms=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(376014)(35042699022)(82310400026)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xh4WPWuw2LEIEn0zqDk0s/x3oZpOEGRNoPQxEycl/Y4BQoAqE2HpKp1TGif+B+pul2iux9OE6s46A0xr85sy1DUiIhI5eA0cosZNU8FVy/WSJHMHtj8Dwn+5Ppf61IrH5OnKbPTOzNblgIkdzYi+dgiwOL1GfdFY1Vx31jBRerdkR0JWmbGvBK8nr3g4EL04sRTe5c5VPy2oVMEQzFnQ3ZlyFKZIeAy9pyO9yTsHM/BcKP0CSh82pF4YLPqYtSE1uOZ+O7rVvJNc4eqiLX8XkGDV9Hwq082vAjGogTX2h+gc3R/x3dn+JMzjRKiVEXYtQ6TnNO9hXaWPhhWfWbabb/h5uC/IDPqS7dF1zHNpCbJo7r+Oydro6Nk3yWcHZPapqniCVxWhg+aFM+6EACKc4BHd0Mt6Vv2WOITyYg3w/gyHjy7874Dh3gA8nUfFJttV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:13:05.3907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da7dcf2-e808-4656-d9e3-08de8f1edd1a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11206
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

VGhpcyBwYXRjaCBhZGRzIHRoZSBTRUhfQ09ERSBtYWNybyAoZGVmaW5lZCBpbiBjeWd0bHMuaCkg
YW5kIHJlZmFjdG9ycw0KdGhlIFRSWV9IQU5ETEVSX0RBVEEgbWV0YWRhdGEsIGZpeGluZyBjb2Rl
IHN0eWxpbmcgYW5kIGFsbG93aW5nIGl0IHRvDQpiZSB1c2VkIG9uIGJvdGggQUFyY2g2NCBhbmQg
eDg2XzY0IGFyY2hpdGVjdHVyZXMuDQoNCkl0IGFsc28gbWFrZXMgbW9kaWZpY2F0aW9ucyB0byB0
aGUgZXhjZXB0aW9uIGhhbmRsZXIgcmVzcG9uc2libGUgZm9yIHRoZQ0KX190cnkgYW5kIF9fZXhj
ZXB0IGJsb2Nrcy4NCg0KVGhlIGZpcnN0IGNoYW5nZSB0byB0aGUgaGFuZGxlciBmaXhlcyBhIGJ1
ZyB3aGVyZSB0aGUgZXhpc3RpbmcNCmV4Y2VwdGlvbiBjb250ZXh0IHJlY29yZCBpcyByZXVzZWQg
YXMgYW4gdW53aW5kIGNvbnRleHQgcmVjb3JkLCB3aGljaA0KZmFpbHMgd2l0aCBhIGNyYXNoIG9u
IFdpbmRvd3Mgb24gQXJtIChBQXJjaDY0KS4gVGhlIGZpeCBpcyB0byBjcmVhdGUgYQ0KbmV3IHJl
Y29yZCBpbnN0ZWFkLCB3aGlsZSBsZWF2aW5nIHRoZSBvcmlnaW5hbCBvbmUgaW50YWN0Lg0KDQpU
aGUgc2Vjb25kIGNoYW5nZSBhZGRzIGFuIGFkZGl0aW9uYWwgY29uZGl0aW9uIGZvciBjYXNlcyB3
aGVuIHRoZQ0KaGFuZGxlciBpcyBjYWxsZWQgYWdhaW4gaW4gdGhlIHNlY29uZCBwaGFzZSBvZiB1
bndpbmRpbmcgb24gY2VydGFpbg0KcGxhdGZvcm1zIHN1Y2ggYXMgV2luZG93cyBvbiBBcm0gKEFB
cmNoNjQpLiBJbiB0aGlzIGNhc2UsIHRoZSB2YWx1ZQ0KRXhjZXB0aW9uQ29udGludWVTZWFyY2gg
aXMgc2ltcGx5IHJldHVybmVkIHdpdGhvdXQgbWFraW5nIGFueSBjaGFuZ2VzLg0KDQpUZXN0cyBm
aXhlZCBvbiBBQXJjaDY0Og0Kd2luc3VwLmFwaS9sdHAvYWNjZXNzMDMuZXhlDQp3aW5zdXAuYXBp
L2x0cC9hY2Nlc3MwNS5leGUNCndpbnN1cC5hcGkvbHRwL2NoZGlyMDQuZXhlDQp3aW5zdXAuYXBp
L2x0cC9ta2RpcjAxLmV4ZQ0Kd2luc3VwLmFwaS9sdHAvcmVuYW1lMDguZXhlDQp3aW5zdXAuYXBp
L2x0cC9ybWRpcjA1LmV4ZQ0Kd2luc3VwLmFwaS9sdHAvc3RhdDAzLmV4ZQ0Kd2luc3VwLmFwaS9s
dHAvc3RhdDA2LmV4ZQ0Kd2luc3VwLmFwaS9sdHAvc3ltbGluazAxLmV4ZQ0Kd2luc3VwLmFwaS9s
dHAvc3ltbGluazAzLmV4ZQ0Kd2luc3VwLmFwaS9sdHAvdGltZXMwMi5leGUNCndpbnN1cC5hcGkv
bHRwL3VubGluazA3LmV4ZQ0KDQpTaWduZWQtb2ZmLWJ5OiBJZ29yIFBvZGdhaW5vaSA8aWdvci5w
b2RnYWlub2lAYXJtLmNvbT4NCi0tLQ0KdjM6DQogLSBSZWJhc2VkIG9uIHRvcCBvZiBjdXJyZW50
IG1haW4NCiAtIEltcHJvdmVkIHRoZSBjb2RlIHN0eWxlIChpZiBjb25kaXRpb24gYnJhY2VzIGFu
ZCBUUllfSEFORExFUl9EQVRBKQ0KDQogd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjICAgICAg
ICAgICB8IDEwICsrKysrKystLS0NCiB3aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rs
cy5oIHwgMjcgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3dpbnN1cC9j
eWd3aW4vZXhjZXB0aW9ucy5jYyBiL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYw0KaW5kZXgg
YmFkYjExZGE3Li4yMWFmMjZhYzMgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL2V4Y2VwdGlv
bnMuY2MNCisrKyBiL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYw0KQEAgLTYxOCwxMCArNjE4
LDE0IEBAIEVYQ0VQVElPTl9ESVNQT1NJVElPTg0KIGV4Y2VwdGlvbjo6bXlmYXVsdCAoRVhDRVBU
SU9OX1JFQ09SRCAqZSwgZXhjZXB0aW9uX2xpc3QgKmZyYW1lLCBDT05URVhUICppbiwNCiAJCSAg
ICBQRElTUEFUQ0hFUl9DT05URVhUIGRpc3BhdGNoKQ0KIHsNCisgIGlmIChJU19VTldJTkRJTkco
ZS0+RXhjZXB0aW9uRmxhZ3MpKQ0KKyAgICByZXR1cm4gRXhjZXB0aW9uQ29udGludWVTZWFyY2g7
DQorDQogICBQU0NPUEVfVEFCTEUgdGFibGUgPSAoUFNDT1BFX1RBQkxFKSBkaXNwYXRjaC0+SGFu
ZGxlckRhdGE7DQotICBSdGxVbndpbmRFeCAoZnJhbWUsDQotCSAgICAgICAoY2hhciAqKSBkaXNw
YXRjaC0+SW1hZ2VCYXNlICsgdGFibGUtPlNjb3BlUmVjb3JkWzBdLkp1bXBUYXJnZXQsDQotCSAg
ICAgICBlLCAwLCBpbiwgZGlzcGF0Y2gtPkhpc3RvcnlUYWJsZSk7DQorICB2b2lkICpqdW1wX3Rh
cmdldCA9ICgoY2hhciAqKSBkaXNwYXRjaC0+SW1hZ2VCYXNlKSArIHRhYmxlLT5TY29wZVJlY29y
ZFswXS5KdW1wVGFyZ2V0Ow0KKw0KKyAgQ09OVEVYVCBjOw0KKyAgUnRsVW53aW5kRXggKGZyYW1l
LCBqdW1wX3RhcmdldCwgZSwgMCwgJmMsIGRpc3BhdGNoLT5IaXN0b3J5VGFibGUpOw0KICAgLyog
Tk9UUkVBQ0hFRCwgbWFrZSBnY2MgaGFwcHkuICovDQogICByZXR1cm4gRXhjZXB0aW9uQ29udGlu
dWVTZWFyY2g7DQogfQ0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMv
Y3lndGxzLmggYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oDQppbmRleCAy
ODlmMzk1ZTQuLjBiNTI1NTQ5NSAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5j
bHVkZXMvY3lndGxzLmgNCisrKyBiL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxz
LmgNCkBAIC0zNDQsMjEgKzM0NCwyNiBAQCBwdWJsaWM6DQogICB2b2lkIGxlYXZlICgpIF9fYXR0
cmlidXRlX18gKChyZXR1cm5zX3R3aWNlKSk7DQogfTsNCiANCi0jaWYgZGVmaW5lZCAoX19hYXJj
aDY0X18pDQorI2lmIGRlZmluZWQoX19hYXJjaDY0X18pDQogI2RlZmluZSBFWENFUFRJT05fTVlG
QVVMVF9SRUYgIl9aTjlleGNlcHRpb243bXlmYXVsdEVQMTdfRVhDRVBUSU9OX1JFQ09SRFB2UDhf
Q09OVEVYVFAyNV9ESVNQQVRDSEVSX0NPTlRFWFRfQVJNNjQiDQotI2RlZmluZSBUUllfSEFORExF
Ul9EQVRBICh2b2lkKSAmJl9fbF90cnk7DQotI2Vsc2UNCisvKiBBbiBTRUggZGlyZWN0aXZlIHRo
YXQgc3dpdGNoZXMgYmFjayB0byB0aGUgY29kZSBzZWN0aW9uLiAgKi8NCisjZGVmaW5lIFNFSF9D
T0RFICIudGV4dCINCisjZWxpZiBkZWZpbmVkKF9feDg2XzY0X18pDQogI2RlZmluZSBFWENFUFRJ
T05fTVlGQVVMVF9SRUYgIl9aTjlleGNlcHRpb243bXlmYXVsdEVQMTdfRVhDRVBUSU9OX1JFQ09S
RFB2UDhfQ09OVEVYVFAxOV9ESVNQQVRDSEVSX0NPTlRFWFQiDQotI2RlZmluZSBUUllfSEFORExF
Ul9EQVRBIFwNCi0gIF9fYXNtX18gZ290byAoIlxuIiBcDQotICAiICAuc2VoX2hhbmRsZXIgIiBF
WENFUFRJT05fTVlGQVVMVF9SRUYgIiwgQGV4Y2VwdAkJCVxuIiBcDQotICAiICAuc2VoX2hhbmRs
ZXJkYXRhCQkJCQkJCVxuIiBcDQotICAiICAubG9uZyAxCQkJCQkJCQlcbiIgXA0KLSAgIiAgLnJ2
YSAlbFtfX2xfdHJ5XSwlbFtfX2xfZW5kdHJ5XSwlbFtfX2xfZXhjZXB0XSwlbFtfX2xfZXhjZXB0
XQlcbiIgXA0KLSAgIiAgLnNlaF9jb2RlCQkJCQkJCQlcbiIgXA0KLSAgOiA6IDogOiBfX2xfdHJ5
LCBfX2xfZW5kdHJ5LCBfX2xfZXhjZXB0KQ0KKyNkZWZpbmUgU0VIX0NPREUgIi5zZWhfY29kZSIN
CiAjZW5kaWYNCiANCisjZGVmaW5lIFRSWV9IQU5ETEVSX0RBVEEgXA0KKyAgX19hc21fXyBnb3Rv
ICgiXG5cDQorICAgIC5zZWhfaGFuZGxlciAiCQkJCQkJCSAgXA0KKyAgICAgIEVYQ0VQVElPTl9N
WUZBVUxUX1JFRiAiLAkJCQkJCSAgXA0KKyAgICAgIEBleGNlcHQJCQkJCQkJCVxuXA0KKyAgICAu
c2VoX2hhbmRsZXJkYXRhCQkJCQkJCVxuXA0KKyAgICAubG9uZyAxCQkJCQkJCQlcblwNCisgICAg
LnJ2YSAlbFtfX2xfdHJ5XSwlbFtfX2xfZW5kdHJ5XSwlbFtfX2xfZXhjZXB0XSwlbFtfX2xfZXhj
ZXB0XQlcbiJcDQorICAgIFNFSF9DT0RFICIJCQkJCQkJCVxuIlwNCisgICAgOiA6IDogOiBfX2xf
dHJ5LCBfX2xfZW5kdHJ5LCBfX2xfZXhjZXB0KQ0KKw0KIC8qIEV4Y2VwdGlvbiBoYW5kbGluZyBt
YWNyb3MuIFRoaXMgaXMgYSBoYW5kbWFkZSBTRUggdHJ5L2V4Y2VwdC4gKi8NCiAjZGVmaW5lIF9f
bWVtX2JhcnJpZXIJX19hc21fXyBfX3ZvbGF0aWxlX18gKCIiIDo6OiAibWVtb3J5IikNCiAjZGVm
aW5lIF9fdHJ5IFwNCi0tIA0KMi40My4wDQo=

Return-Path: <SRS0=W+MN=HI=arm.com=Evgeny.Karpov@sourceware.org>
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	by sourceware.org (Postfix) with ESMTPS id B62C54BA2E17
	for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2026 08:50:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B62C54BA2E17
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B62C54BA2E17
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::6
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1789548643; cv=pass;
	b=nxxuAfXHhxrscAOjGFCE/4qBzEU4yPsI2oZOxqm/w4ZhYc3yHjdPgHJsCS0d1+FsYn7/5c9fa1zV2bGPMvmXwY2VNz+APkJt/X5NuqHNzyo7mthUoi7U/232HE6Jn0VgQp1XOMkC2M09S7vutXXrn3qsqyRQG4cOLBN7cI20JXw=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789548643; c=relaxed/simple;
	bh=pwX5N3k1h694C9+arpIeilPD8WRnp+opLcCAKMc71d0=;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version; b=hCciXtc56URmQ6+Iv6NjjpyQYanYjCCmLxANO8TVUf4JZchvnX3N7cPWLz5o2QGVeLZvntl1byWbilDXLuzf6cUEgFtI1OEmICWoq3V9ET2ewF07BFQaR7m04itEjBYa2y+WRrxvZHX4wMTt7E1UdRKpGp69v4gndMrGXuwmMMc=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pZvScGP6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pZvScGP6
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B62C54BA2E17
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pZvScGP6;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pZvScGP6
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gegHNFanuDPABF4pYEjX2EuK7C4WS3bTSTUQfA8SZcau2hFiwdBCWRZ1mYo4MWPFYNpTKPuKysed2Kqvon9Oi327hWLwVW5TQROVgPCuh71NesXwwmM+XX5xLbJlM4YPgvBmIVoW2ts9mjAggyy+cHV3AC/G/58RnjNCBumOWnuk/BPuxnFFfr/wDcHfl38eFPWnBa1vQZxggIdd4WxcHnwbrGB2C+dN5cNaOtEPUbxF470j7O+90gH49UYkvfrEfbTzi3kA/LdfDMI/0xvv38+/zWbJTptxlsZm2P4YxoufqO71SYVVqPXHYx7euhlQ3YVqInLQNlwPrYUEJZzcwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKtcJ8zhGZGTzu8F7ya9WURyYgpoC8ynPK8q41OPu08=;
 b=qOak4EzjK/jBGhp6H8yBeldVfGzcM3+0a1XhxVT+Zc0GSHo321L6VWQTCHREzGateh5al4JididgqlBatG4l7CgDhS440m+otETXUFruEuyI0wGAuAmsNdvyJBtQjT8GSwMSVVFjHXPF6Km2F02I/2k+JlpAbNdQPTdSMNQGUJKpV9o1b1wGIwGLeiaJviXkNnjTGUf+oZkzHMJLG2C41SnSvbGNgLJUaure6L5oW2127ObyJKQQZOeSnwtu15LfvGWw8aKF+DFp5ywKWweabgo4nAGJMtCvaDIRMyM5GqJG/7yL/2dmi/SK9b9fo8ySEWF2KUxMxFG2EooSpGxD6Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKtcJ8zhGZGTzu8F7ya9WURyYgpoC8ynPK8q41OPu08=;
 b=pZvScGP6j8nzQqA7zz1hRSW2VNud5CLpBjglpujeLws3zz5YUJT2KBW7aa8aKLGn5J9mtM5WvmW3xsqPRX0NxMuY6B9lbQy/rxKXpwvw6VnzNvDPXWQqmozQ7wwHPfv3vzzFRqCrcaooMstjx0067DvlXEmSF4XpwLVVnhAHLF4=
Received: from AS9PR06CA0604.eurprd06.prod.outlook.com (2603:10a6:20b:46e::6)
 by DU0PR08MB8662.eurprd08.prod.outlook.com (2603:10a6:10:402::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 08:50:34 +0000
Received: from MI3PEPF00008556.eurprd05.prod.outlook.com
 (2603:10a6:20b:46e:cafe::8f) by AS9PR06CA0604.outlook.office365.com
 (2603:10a6:20b:46e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 08:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008556.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 08:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt5EPuP36dmEi66Z5JtyszKmzOQypqh6s+60OmbzM/8H21KWyZTjeOx0USB4IX/V1kqkFE1ULSjjSsCPyhwiDOsvef5QcL9FT/zt/I3sraXh8UgM31d2SWUznGCy6Ail200SSlW9O6Oc8frF4W8CEHuyk9WsIN2/V5YERNSabLIzxk9Ll9HsQkkJOEx/FFb5Irf0ExGBcKUGg1LSXdxzsf1UWbYpct5HC44Qc56nl7zId8fVPFs1m4Mh8yBVrjagYqTWeC/xOxiVRqT6txn1TU1qQdQg0jhIN72h1vTD1/MxWc+tWhH5bgiZwW/1KwOqmTfxok4tQhu9PDnyanJxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKtcJ8zhGZGTzu8F7ya9WURyYgpoC8ynPK8q41OPu08=;
 b=ASaZEucMrcKBBrVfZDiMJGjGN1DN/F9F/kJEJSNCrCIcKKlgB9OoAaawvKB+cEDjEEX4iZizb5DBTi4i3xpJeUFw3uDdX18a26wirFXOYXgbvLPQPMgZtoLZ+y+Xdi1xAg9triwBioeNnMMFsuLILvsACIWTDe4FBe0P73edaQXLalfB2CmCqq/qQxFxQe/0JyM68Otu9az4kVFeiZc1Vf44wQAV4u1mlKVFQjispglDWCznO0PHHzNq0KO0Zg14sEbe4mBd6HxLYDpWHFoJIVVwJCrAyBleEe6l9a9VOvuXJ6kolESQm74pgv7AkccwXtD0UHQl2FuA3fRxd2uqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=multicorewareinc.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKtcJ8zhGZGTzu8F7ya9WURyYgpoC8ynPK8q41OPu08=;
 b=pZvScGP6j8nzQqA7zz1hRSW2VNud5CLpBjglpujeLws3zz5YUJT2KBW7aa8aKLGn5J9mtM5WvmW3xsqPRX0NxMuY6B9lbQy/rxKXpwvw6VnzNvDPXWQqmozQ7wwHPfv3vzzFRqCrcaooMstjx0067DvlXEmSF4XpwLVVnhAHLF4=
Received: from AS4P189CA0037.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::8)
 by DU2PR08MB10230.eurprd08.prod.outlook.com (2603:10a6:10:46e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Wed, 16 Sep
 2026 08:49:57 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::1d) by AS4P189CA0037.outlook.office365.com
 (2603:10a6:20b:5dd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 08:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 08:49:56 +0000
Received: from AZ-NEU-EXJ02.Arm.com (10.240.25.139) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 16 Sep
 2026 08:49:56 +0000
Received: from AZ-NEU-EX04.Arm.com (10.240.25.138) by AZ-NEU-EXJ02.Arm.com
 (10.240.25.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 16 Sep
 2026 08:49:55 +0000
Received: from arm.com (10.57.51.247) by mail.arm.com (10.240.25.138) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29 via Frontend
 Transport; Wed, 16 Sep 2026 08:49:55 +0000
Date: Wed, 16 Sep 2026 10:49:54 +0200
From: Evgeny Karpov <evgeny.karpov@arm.com>
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, <nd@arm.com>
Subject: Re: [PATCH] Cygwin: autoload: fix ws2_32 chained init on AArch64
Message-ID: <aqpYA_4qPMpjT7b_@arm.com>
References: <PN0P287MB0295C357517BE127B601D99092F02@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PN0P287MB0295C357517BE127B601D99092F02@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB1PEPF000509F9:EE_|DU2PR08MB10230:EE_|MI3PEPF00008556:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aee605e-f5a5-4008-d2c8-08df13cf91a6
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 xQQ36zjr4m4uKlkCtyodkPs4DO7qXReJjQ4Emu/LPyhXsRmRP6VZ34jbxEA4HpLrEPWIfYqozPrJQ76tAGRf2cwTPhAfHzs777h0RK6GRJe5RNFD3dcX5OECROKOrNszVskUDS85U0F4f8QiUXmxNAmhud4CNzjqN+A8pswV0nzxyjFqQpeix5XNLdtJZrMfA9N0KH85M+WPGPn/x0IAQ12FEpOY9FZMgY29Fxb3loyYiIGfHUA622UxduLv0hvrdF2BOiimpCCS3aUb+K9ep/KPWFjr52JkE9XI0aYLUwjujGbabG1UcsOjl4GZiB8V0v8BQBqfx+pDcthsplFzulPFYO7E6RTfrr4QKUjNwmu5qT1jjRT471f4BVwrsU59U8sD334tsa9RDad5BkplZShVJFBlp7Kd/RteI5MwM+oBnNEPh+fYiaK+UKubbXeWlZPjRE3jH+KNUJBpWaaDmkXwgQV6ar7iOCuvWya7NncESdtdGKJMMyrJOmPHJxk4SpyBdsn2LLW3gKa0Cd230dMMr+ZPGlqzmdUJeIA/2NqNOqFVw1gIFyWt95AvL6aDr+rYP1oq3WxktkXVShj3Iy3RY1RdxhoWEleg+D/LEPAN9nPl5DBRW3FtDYl9SAIsURgPrs5dA8ews48uy52Rq4Pge/TaKue35VN3JqtGRnc9DmGDuDwOlhUF7T/6OFieNOiBZYPb5h7zUviVPa5ZYQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 0ePAUoIeGydirqHXo1S/ff4Kv1XL+p2xUBW/au+JkMM0Phi6je2C+erM+tVstD8scQ+mKdE+qYXAa3GqtkLnlMpi2oT9PMYUkpxhonbP88JYIsw0l26GTCbR7ENSDGRVRmIZnh/f+PrHdy84xo57o7bx2A3HiTdQg/jI9fEIpxs2yg+p0QNsyyYA8YRJtkjZ0m5kwb0j/DDpaQLTbrAKZ5lpBtJkxQk0H8QPLcvE94C8Oy9PC8nbKQBK3RfP/NyPXv9UydfqZsxJ31++Exjb1gN9+rg+RFHEtjkeTemfu6y8BmoqaDZ55b5nY4knODYnNMBPen2Rn7II/YFRtCnkcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10230
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7c12cff2-eb3b-40fa-c6a8-08df13cf7bcb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|14060799003|1800799024|35042699022|376014|82310400026|36860700016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kzRvfG88MkPTO+FKkOd4w/PqLCs/qaA1Iugm+zc/yMS5RTbgcL03w1mcyltD334m1tiD33Yuqtssj/K9VMX18w8LgsKIEDo7/fq5vciQhu5JAL5FcxEKjN0FNasLEwUycPkQyJ1zOuIg+Fc1MR3Bxs0HPZ9Xh0Y0+LY2mstK2iMHWG0F7QxfQqXJjjaS/fdxYDc2BZjCMwHQbekkfrD1oaYCKSsSmrkbKuU+ZIZYBKr9J6yMmEQ+Ho8VTFyHyuk6+yxnlLUlCpXYxRrvRiVH5Zy6zN8nBznfddNRxR2p5NoPqbIZobUaMD1nxJmQ95kBiwtxmFZVRp5XJ+W5VsJpCo+xerHGqnnc4v546Hks9GiQbMlATzr7kcjiOPaM+5PbvaxGzz1w4QYnd6owzYKlgoJlD9BX9zQ+ZArmYCEof67uLTRzwCrlpmbfiAkjiqYor63bExQgL17+0+p5PVYRBlYU34l7AQOSexuo8UmF2z9LAK2lWg7unVgSPr6QPAie7DU3BXycdB8PGDvni9xF9BRbAAvJEfbuVWGZHBj+D6TJtTfiIMKyvd1iZoLNSYL6msASyryRLPCkfNixQIS7V2m0chvw1T6dzAnNh6NurOP8OdtEUjbTeAJmn/QEQ86m/5zH02NtfFS7teaWSPPg66OlpjuvQJppUnMpg4f9kZpiKpYz4MnOuA/3b5AXDpCGPjhNk4V2LgN3HASOymMJqA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(14060799003)(1800799024)(35042699022)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BYXoh2jr+iZ5Iu3ZzWtPJD1q3y4aTUaGbPu2HSpnANsAvLf2d9vHL+LH9palasLX2rl4K176nVD2dhVEU5UKRKKhWSD+g+W/H/SHw4tlAvX2odiVYHhLbTP3ArbI9gvzfJFWhQCapbfWzJ7fbH2uRFuuZAvQHT2P6ieRolCCFBax1c623Cus8avGcLHqlqXQCz2YK5EGKfgGPz1O4hTZlwgmVPZJKrv/U11o5Kuf2HHGBwszjvyHPpJeH9waRdjCivqaUwZwFVPiek8HjedsGSGQlwOA/l02Epu49YBqyATyN+Z55iAP7A/kewZ1tCejR5PIejjpxc0Z4k4AYnafYbB+FhOKJ6jD33eZOvB8abO5U9JTp5t373NOblgZ8zvku8y/9f5TSqOFCmU9UPYs+7oRuXgF5wFNd/WOWPyyV58N8EcxEQ4c+le5Rjuudz19
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:50:33.1885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aee605e-f5a5-4008-d2c8-08df13cf91a6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 07 Jul 2026, Chandru Kumaresan wrote:
> On AArch64, the autoload INIT_WRAPPER passes func_info* via x30 ("mov
> x0, x30").  This works for the first init stage (std_dll_init), reached
> by the trampoline's "blr".  It breaks for a chained second init, because
> dll_chain reaches it via "br x1" without updating x30.

A more general question, could the autoload implementation be replaced by delay loaded DLLs?

Regards,
Evgeny


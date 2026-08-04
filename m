Return-Path: <SRS0=14hl=F5=arm.com=Mate.Dimand@sourceware.org>
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	by sourceware.org (Postfix) with ESMTPS id 7A4D14BA799E
	for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2026 12:45:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7A4D14BA799E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7A4D14BA799E
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c207::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1785847528; cv=pass;
	b=cfVHmcPIo4y/ntomOEl1UB98BRDiv7sFVeV3HrL1tayD2w+6HIQyogolukKWauGHDEgHGP1csrmWyIgpoOfDVlEuLKV617FK4iuuuekQfGHj/r+nSxRwhJkGdeUywfOYwa1t9JdCH302164Z/iVmgDk/ixSlzBIoOhguparlIWU=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785847528; c=relaxed/simple;
	bh=AOVwpqhnUPVj1kJ2oKZ+WazktNO7gdmKhHrxfOIjouo=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:Subject:To:From:
	 MIME-Version; b=AAWm00ezGpcZJ3I2air+2B6xs440I6/3qNS9Suw03Hf5Oi+Syw8g8+86LcKVmt9P0GaBewOMMuU7DhAFxxcXtatt7UlAeGzsr0mukJ/CBD24rvN572gvgEd7sqbcCjamNiPsxDvrGmcTobhzDc3T55CV4g7UVDHHY+7g+yQpiI0=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r/tsNtsS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r/tsNtsS
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7A4D14BA799E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r/tsNtsS;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r/tsNtsS
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sELm6GUCPbTOGArWSQZRFwNzWKMj5ECSaixjcz1rx92R0s9r2Kv7TLe5efGzVROppP8waHh8L9TtjYDhpZJjfu9BPnuwG3IvsqsGhHHQh2+b5ERjuMNjd5loo8xn02Zi8VuyQ9ORZFPTgn59OeEGQHoPu16elnP4s6c6HQGKiu5bjRLESYlh0lMYarxIwX4oAcTutDLKGVYJWcEb5wx6s6UIcjfDbb1ye5HKkgNmaMzPsUZQdiFkHR3UlYTrUFln+M2+fLvUK4krswMKRWSS6fBpP0JVjEUgEY/CjyeGZPfe+A+MaJBeLu6MqoEo0LwQMj7rBmTxd7EuaGBXjfQDyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rHek9pEAcdGcATwk7AEYcYXpvfYSH4gfgpLUt9a98U=;
 b=cK2V3n/u/D3XHXHBcMU2CzIU3Uqr+lHKX1UHdk860AZb1v8OC6BxpSSKoB9XS0JM8nBxAZ0FR/AofKEV8Cmj2PnPMGLaFFYc6FODBQ5AtrF6KWi9dkkK4QMTT+I0G1q+OoGIWAtRCVZ2utYKZQEvyJLJDWhzHe3X0MeuE1uc0nzZnTS9PtgaoEwsijIUH4/RQn1wof6NhHTLpHgZIgDeIcDJVHmFViFti26St25ScabbfEmFH+0kyW3lM7j+hWa6x/z0I7rTMVoMHOvO2QszQfYPeb3u1Mis2Wcz/ly85lcSxrzT3kQkhUcCr7S93Np9sPzxo2RZpEykeS3bbXVsVQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=dronecode.org.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rHek9pEAcdGcATwk7AEYcYXpvfYSH4gfgpLUt9a98U=;
 b=r/tsNtsSUBlU4jsWbG++dfBB1euI0oqgzKgKuzxJLqDfIV7CYST6+Nl6TLgcrPr+fMuNTeyrzxVX4yCGPV3gEFOCnlKZvK8JnmTt9v7klUpzZbWBqsa00Ex7j8SIU5jTwmS6utzE/0GTU0zFY8fk9wTfvMdQsZ0XYsqD18/ZK6Q=
Received: from DUZPR01CA0267.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::10) by AS1PR08MB7428.eurprd08.prod.outlook.com
 (2603:10a6:20b:4df::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 12:45:22 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::a9) by DUZPR01CA0267.outlook.office365.com
 (2603:10a6:10:4b9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 12:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Tue, 4 Aug 2026 12:45:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+tQm2vm/TWv1id95THJpjnve6rTSJb+fcXnCmaoquqJ5vLlRiPaYytTRaA6CP5uAPLatBd7hT8BHMZ0n5b5Uqt4YwxXWeN/icnFpt7lpmaMrblxANadAI9SqOTvBkXUiq6nK+ymRbBftYF9BaF7Q9gK6BrqrZQEQO8bhTbvdI5Ce1YybtyUHgAHQJj7mJqdemXge+z40KqSWNdY/lavy3ln0FPhrAzgLkHSnTcFBsgi+l4VDVB6OZtAzvNZGgOBB+LdZ7wYnK4Wp+5wXC9SBMzvInVyWDo40ZhH2dd59zFxXozmAavx0xFxn5y/hr8xzo2vEAT7fscur9ULeemcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rHek9pEAcdGcATwk7AEYcYXpvfYSH4gfgpLUt9a98U=;
 b=P6Ne4fnyu6RRNLEbKytxjbXwE+cpkdqxH6DGVM2Oxu1KGDJ+jpVm8mIFOMKiQHwyzVfI8oG4XMFUJZEiga20vbgZ5Jhk0ai3m4FJeyx/8HCYuIOywZTfnXmrTJwQ9fDZkX3QTWYUti0Z2jQRQWmeuiEqqwAv4TJHoNNmTGc9hPZmQDHfatUDWYp7dCDfRSFDheji8dFYwfWOrF1qM6WxQeqne0srVAfWTyY2y58T2OwYdzk6jXcDaktXsL4Pfa+WqKkHCu94W/b8bDFdrs8Vql+Y4SlQNGkEK8dx2whnZ5midxKsOP9IDcruUEp1/eNB391mpRKE5oO5ie1Dl34Yyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rHek9pEAcdGcATwk7AEYcYXpvfYSH4gfgpLUt9a98U=;
 b=r/tsNtsSUBlU4jsWbG++dfBB1euI0oqgzKgKuzxJLqDfIV7CYST6+Nl6TLgcrPr+fMuNTeyrzxVX4yCGPV3gEFOCnlKZvK8JnmTt9v7klUpzZbWBqsa00Ex7j8SIU5jTwmS6utzE/0GTU0zFY8fk9wTfvMdQsZ0XYsqD18/ZK6Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22)
 by GV2PR08MB9877.eurprd08.prod.outlook.com (2603:10a6:150:dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 12:44:49 +0000
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576]) by DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576%7]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 12:44:48 +0000
Message-ID: <4d5ed900-602f-4faa-a629-e32dee586190@arm.com>
Date: Tue, 4 Aug 2026 14:44:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exceptions: Fix AArch64 non-incyg signal handling
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
References: <3e05e02f-629a-42fa-947b-0e3f4dc2bdfe@arm.com>
 <4602838c-a08d-4a38-bc58-62b3c99ed59c@dronecode.org.uk>
Content-Language: en-US
From: =?UTF-8?B?TcOhdMOpIERpbWFuZA==?= <mate.dimand@arm.com>
In-Reply-To: <4602838c-a08d-4a38-bc58-62b3c99ed59c@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To DB4PR08MB9310.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR08MB9310:EE_|GV2PR08MB9877:EE_|DU2PEPF00028D08:EE_|AS1PR08MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4fde83-4d9b-4d11-d00c-08def2263fa8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|6133799003|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 lCF/DI3tiYrnIyv+XokGmZpG25Pp1GnZkF8GgVthf1mYl77RCHTsgNxixS9B+61+1Np6DRE+I6n7RKO4pBdche5DLKzH5uWMWKY6sFKz4zGHcuEZdiaetN7JS4K/g0Sc0a9sO/qBnruTMIPo9ImJp8pFCZaumksgMUx6N+W0YGMHBHAvXq9GAA5CZ2/93akXuiPuI1JRZMaUJfCYI03o/iElr6WSIxKZ46y+qQCoqNrolnNpbMSq3y3hRI6LSTFxtISo20cSzPjbJACgeAVpR2R6Oz1hyHp/DaYfZr9z5VZa/u8mhswJyZqKcQL3ffxG9tWiPdg5aTYCAwWzreysHnLO8Ev4B4aY3npqN1wN3hpBr6iXWvBUcXE5MBGlCMsed+M62uSZvmz7krVyq4Fy2DiUip3pKtA6XZE38Y2KqNbQi9j8nYzypY0i07lhYGqO/AJj4vJP7OVgZo1chaR1oMB65cYbmZiVHqloQNiffLAL1UHOmgunxfdDDKUxViQRBR8pt+koIZ7aJqHTsnbXUwFb2G1Jx8Z01s9JuEf/fK8GvdCYibEQye3qjNRrtCKfiGdwFU/pAHdOe/Ss522AjH4HWRYHh+xpsR5yfJ8hIFrdce1KLj79P0XGW6DAiqzRMSYWZbyoBfLalu4bokL0HtLsn0a0x6cxIAmvnpxZrPI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9310.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(6133799003)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 KvSPxhfrf+khjtvzxVrAHas/KowOjCd4s4o5WKzfrJAq/aAlm+CZy4FA86/Wgu45oJu22IY5CgVhtiFyiGKNxEOKxV3cRSiO1WLBsNvIg9oTHRHgdOXYow6ag1MnBgTM6w4fk9ImosSvu30PSNSh8mJXhtm1PcYNamqrDI4Fis5vHDL5ydnDGhkIg6V3jqs4aVAnGfAHrH18i/uTTASW0dOSlnL3PQUozSak6i3UZT0Ex4nzTqe2gQ2E/l7PRvnb16cpUXALwVYQ5WRhvTub1x8A6b3OARQVjCGcTXhLbCjqtHSDOdFgRgJm+IeR8DRvhGYfjP6/YHzLbMF7qWYNlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9877
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1554f364-1e17-48f3-a1c9-08def2262b62
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|36860700016|376014|23010399003|1800799024|56012099006|10067099003|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZF8I7LppfhsP8pEQUyomcZSK/wb4aBEjW7ofp7a7ROdfNmc9CQ6ZiNBJhWdT3OJpStVkS0GdEjRI/rb6gcnyzTtMIKIyKAXfnUsQBcbesYJ1UWYeXX2MgRp9MWgKQUu84c8BOeWoEZMBSirhjZtNt0ui+5MceFCwn8uR3vebkMLkLSQjziDlba9LflaSkd2RI5Uoj3QIvVS48BzNPhptbVc91mqX1xhSSTF7og3Lz2bHAqzzy40jGYN2bYKcnvgGJ5mCmV24Clg/zxK6pn6/6kCeXTFzZGeKowL42w/UmvNnX2YOoAn7b/A2HlFfwMugUnpQncg6MGa5ls/84BweqkECTNfrJT85Y5i6/QvxcnsUf9bDXDF1euT2uVtnHXWFvkydrUoFsio8SWGyXu4OA9ejEgkV6bS6cDyNmbYINPswYurYugz7DFM6+izWVerxYubmWCpAfTKtIUTz7VKtevE6K3yVAKo2lMYQYp+SBjnc2yUk/Dk++MrZc2TD6w0ty50rmnTXQ+skcDLX5pvQbmJxwoOpMTw2yr+veaQccMobh7pF9kmKzBMp41/hTVn/StM6YJ0p7SbxtsJaGSC+NxdNhYa4YJMJJ995HKaNR5wHBHGy0KkqD6Y5iqtSdHdN9464n4IkDKca+NSJs9QojUDkLxV1zb+Sg0nIBfXD3fG5RBj0wIj3oUO210K9HgIaXynTjUBPR1s7uDZUE5sfXw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(36860700016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7wHhzApeTAH3W5iEJigAyXG1R5FgRF7k20zpAA8cVctnZYdbp6frEhJQnINITRXkbfBUjKWewtJCrLO5tLNEnABwbIzQ2YxcuZW4dB61+19ay+vphQlAiBtiofANBim0r/zl/FqglUYzfk0PR54AAw7OU0yE34e9fQu3fDkD65kHsVVuqB4I1GFEI4BRhEO9bJkMrKXSe8XTXx583TZ7An1nxZY/ZsRPA2y/qLZijA58FEzjNRahFSgLDDJa9OCLjHTBfSkJ455wjN82uiE7V0QJIhAVEd8MShsMqngMIuytW9wHViAL52t1KeqaXKVNKq9495xMq2JzPDMfGdbKHaN0W8CjrmzS8gWZxBEQ/KmPCHKOqr4xbCtM82RU+DmyYWmnR3iBefHO0LjTDIL4G4rxBzJmujX2bY3e6Kid3EcHK49oSSTkn5oxMYRJslMR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:45:22.3304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4fde83-4d9b-4d11-d00c-08def2263fa8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7428
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi, thanks for applying the patch!

> cygtls::sigdelayed_impl could probably be marked with
> __attribute__((noreturn))?
Thanks for spotting that, I agree, it should be marked with it.
> Elsewhere ([1], in the implementation of setcontext), the claim is
> made that RtlRestoreContext() can fail on synthetic contexts (meaning,
> not directly the result of RtlCaptureContext()).
>
> Do you agree? Is there good reason to believe that the manipulations
> we perform on a context here are "safe"?

I took a peek into RtlRestoreContext, and excluding all code that's
related to the optional ExceptionRecord argument (which in our instance
is NULL), the only validation it seems to do is for the stack pointer by
checking:
     1. Sp is between StackBase and StackLimit (TEB members)
     2. if it isn't, and StackLimit !=3D DeallocationStack, then it checks
if Sp is between StackBase and (StackLimit - 0x1000), presumably for
checking if it is in the guard page

If it fails both checks then it uses __fastfail to exit.

RtlCaptureContext on the other hand, is described to fail (in a comment
in cygtls.h at line 189) if the context is not aligned to 16
bytes. Looking into its code however, I didn't see any specific check
for this, maybe it's only there on x86/x64. Either way, on AArch64
Windows enforces that the stack is always 16-byte aligned through the
use of a hardware feature
(https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?=
view=3Dmsvc-170#stack).


Best regards,
M=C3=A1t=C3=A9 Dimand

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

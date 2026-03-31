Return-Path: <SRS0=3r/z=B7=arm.com=Igor.Podgainoi@sourceware.org>
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by sourceware.org (Postfix) with ESMTPS id B75F74BA2E27;
	Tue, 31 Mar 2026 12:29:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B75F74BA2E27
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B75F74BA2E27
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1774960198; cv=pass;
	b=ZKhioJOnikVLf/U9D08Dq+hxhhzwG80hK9wXyJBuueILxmz8O/OmOYBXYLWHyBEGJQdjuJqnw1opRJ/5k8nNR2uiOAhCEgzNfaNwESXnjRxkRODZgnJn2o6dJHPpEnH25EGsfopXGkkkEwEM5A2CMqBcKn3t4/JJ9B5Tk+/Xi6M=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774960198; c=relaxed/simple;
	bh=Vpyv6c6HTwekZRqD07yKC1vrpfljH/IybPLFBzlhiJc=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=NQF+mpFbc2grzK+edGaBVDbJ8OwZDAJUYs6o+VIE43mVMZmde9JsKzKrxdv/xiatXudNA5VYkgZBK3riQ87ucnh81JcS652vm8n0yAi+PQ7a9l0Hie30fuU5zIgVEqj3iEKU2AZTnGoBgXsRcasAn1T6et1j68hwYOuxAENbBfA=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B75F74BA2E27
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CNaAB6gv;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CNaAB6gv
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hpb4xteBCxxQ91Y86CVx2946ZKFHHfzOY20FValSL8psA7Zvju7QOvXvMP/wo12XfOTENlJYstS4l7B4o/gRVIynOYemNuTGOBafCV9a9UepRljGLSJymuHdHFmJhaxs/h/b+Oyx8r/48exRHgMH8zkbpSP+p47H6VX6cgHIfjlzvU49mTqQKqBJ5wpzxWs0j+EddBwRVnu8cFDthmj9NGXy6DEjkN5XJNagKiXZgwo3RXU7GXHOxEvH9VsclkyZb1BrdRtM0kDKTfLt1DuAjHLXPohpCvFtECeHqbVJ5+eqFNS4saz8gHxkBt+irwQXRjtC3MxzNy/yGDpiYv56kw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vpyv6c6HTwekZRqD07yKC1vrpfljH/IybPLFBzlhiJc=;
 b=ACZe/pdKSRLtahpjbShtDTFtoQmiDYtK5X00/ygJIDIdXa8Z1WNI/Zzfy5I8QI5RYgCOs96pcfYn8C2FxeYFqDb1Nm/NMPjl5F6jQr7KF+qqsVZQobNTo3KuXD0l8IyCZMwLpFw12E3H7QOqv71izsaNOZxnmuR8/psnwylAqIgDlWBs12WuLbCT5DmmOwUrYAolT/VW/dg4WuFDZIEb6OeKexFPYgLlq1feYdtCRKxk4cwEW8s2vFiTg3KxDwLb0uDmy7ARg0CZRUaxDf21EmTe7IEd9ew1cWoPP8BlnsA88N5m2d/5W4OODHgB+zdpIL569w0eiyXdocFy0fydGg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vpyv6c6HTwekZRqD07yKC1vrpfljH/IybPLFBzlhiJc=;
 b=CNaAB6gvTvhkrAjUKs+aDvOC+ZNLwphdxOa5aSLeBegeua3seoaeW+PTlPK8w2V+j6wdLORW9207gxyMBPI+Tahb+9rSuJx0qmRzdnruIDS0SRsmxNpwQ6VyF7TSvSpZjkQS9IKBBASPOu9Bzz4H+WrJrumOpOwVr1QwI4qZ/Zo=
Received: from CWLP123CA0193.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::18)
 by PA4PR08MB5933.eurprd08.prod.outlook.com (2603:10a6:102:f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 12:29:51 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:400:19c:cafe::2f) by CWLP123CA0193.outlook.office365.com
 (2603:10a6:400:19c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 12:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 12:29:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH5a8+FX+KHLkdNi1PO+NC1cyrXCaUfBNNfd+N/HS9Vm3E/Mxb0oHFyjeHClFTNCMnAwWZyQzwURghfBaHMJpW+EsmvBHi1ZXOBrUqpviYNd5Jxt7W/pVKumsIXtB2QOKnr/Sa0z+rvMqmUBAkHAlBlTQpJqfgjFEky4bHyeo37ENcn8U88rkZoRKImu3OMG9oRb5l+M8uQmMcCCPjGYAR4XE+v1jB9I/10tkFQ7nnF1Ad4WRgecWve4W17BB4+pCKKrcBpfMVnfjewIyM5molBzhnWsB9xM6af5ovDAxHyesQl8xoGxJbCxJkKWVHAC7ZZovF48f4OT+W5cWrH6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vpyv6c6HTwekZRqD07yKC1vrpfljH/IybPLFBzlhiJc=;
 b=s7iNFL4qzKQQfGKLNwqn70TVzAVLiWAitJeKqn720pC6cpk5prfKKIpOXJxWr0oj5Q8rb3qYJplzZQcUBSwWyMGxxKFoB9cliE17ScYsN2TVYb1rflFiGo5El5GD6hU4HnKf77XB/ZUraPGym5Azczn4CiW7gC9E5PAqAO8qcSEGkcY423IXkrgQdeokOa76Qj4F5B+X81oj61k2yIva79bLugB3uKcmK5ZbBuCedc1SRy4+cs44myHoU3EZDINiYiq+z6phHRnJhUpt4dY14ROXsnLfBTU+1+EmQ9rDuAK+DDj0LyIoDVzIG3tXafiHza3N2dPVXUv0ThTDbrXzLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vpyv6c6HTwekZRqD07yKC1vrpfljH/IybPLFBzlhiJc=;
 b=CNaAB6gvTvhkrAjUKs+aDvOC+ZNLwphdxOa5aSLeBegeua3seoaeW+PTlPK8w2V+j6wdLORW9207gxyMBPI+Tahb+9rSuJx0qmRzdnruIDS0SRsmxNpwQ6VyF7TSvSpZjkQS9IKBBASPOu9Bzz4H+WrJrumOpOwVr1QwI4qZ/Zo=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by PAWPR08MB11511.eurprd08.prod.outlook.com (2603:10a6:102:50b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 12:28:47 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 12:28:47 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "corinna-cygwin@cygwin.com" <corinna-cygwin@cygwin.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind
 phase on AArch64
Thread-Topic: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind
 phase on AArch64
Thread-Index: AQHcoM7wwt3RmlVTk0GjLgpwgpysR7Wpid8AgA4naQCABE+eAIAM0VIA
Date: Tue, 31 Mar 2026 12:28:47 +0000
Message-ID: <acu9_iNUzvFX9Dxt@arm.com>
References: <cover.1771414249.git.igor.podgainoi@arm.com>
 <c4f8c7507e38602ef2935a8dbafe7409a63377ad.1771414249.git.igor.podgainoi@arm.com>
 <aZWrI3WPFRqj7P_j@arm.com> <abGAGofEMp7sikvK@calimero.vinschen.de>
 <ab1fpH4XEFR8FEEU@arm.com> <acD9bNOqacDnRPSi@calimero.vinschen.de>
In-Reply-To: <acD9bNOqacDnRPSi@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|PAWPR08MB11511:EE_|AMS0EPF000001AF:EE_|PA4PR08MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 5330310e-d7f9-482b-299b-08de8f213484
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 FoeLB3yLVluPrfkMJat7WfopobK0vRHc3rRedTj8u/TeSww7XzAsTTsZo00MRPSyR+7ydlJUEPzDNpWNNA73yBgS84kNzEyh0FDvOqlCGhigAH0zVBROvOrxxH/WzXQkO1GX1e7I9gChTQTCPyuijp5b7F0GzcAl66U+sQMVlx7a75yzSB/9j6gtBoAtclZApLZU+f75U+9uEfoLAFHeTcS/VsNfuS6kEGH0suZJKnXUyqv8E2TuJz53HpXcDwnmIoZbspnPYEHRG9VEBV/Li8QTQB+ydZR3xGgTM/2DlorMBcOKI//AwSBXwnaTRot5MsE+77xP7+GDoa7j++NDxghKxbp2lCsRYCkykHJIYyMPfJHUfYhcchZNXmfMxkAcRnDIIKc9hAEz1NZbg5S0HoRwDLy6hRkfFwo01X6aiXrjhzHaDUnQupUzG7jJbA3a/JP5uO/ZNvH96479NpfnMQ/L0owds2e9N+SGN0puPACMG/sNN5+DKnST+fAU3ZTDHq8MQ7gw/h0AT9AEC+TlkCPx2RS5fEOxwVt9Wa6CqbsNvoC3OqlWZldKakQPDNYx2rXkMt9IBu3mIUfMeUBM3Wnip5o7xRVZWWBm+6RzA3i815jN6fPjMvDDK6oibBWacE8SgY1eyG4Oe8X3jLIw8YbO+EjgAJx4vRG/HPsrf1CFs6xQXerS0VAKFGIR1j7zpbbqIphC4/tLe4KCTgGguOj4DYAArCkaxalxaaOzqBqCVplnyYenxiQekKbTEg/fXmyDeQyyR3g3YimwC7wq9GhMvv3J6VtDNlVzoCmVDLk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <C418CE8A1C87DC46B9B2D2FD9E6ABE87@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 lTIj9WGVqH1AaVlsig/Gp0cMakm+3dCwTDLBxfUJsuEJoCnhnsLjlJT0eLD0tkRTodyghLDHGUvA47dtOhASgx+u90pOs499A79/PrptTJaFexfj/60TbnNVxqT9u9mgDoNeRgKnmCsEPIfU6dvEx3HBQUIT8ujgImGo7HmSF+T5ajw6S/INJqTm7BKfJ/W7delrh7pF4EOsHjbQ5+l5ZE7yu1hVGrCXhzwWKJ53BnaxT30dtpjq6DanRIwxAYNNOqkV1TNDmrH0QSDddLp+Uqudkeye87wpGhGEa86VcqBnqaEh94sZN7uT+bReHKuYtD2D+ULZ9sbes44I3/XUcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11511
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d37c51cc-9954-4120-11b0-08de8f210eb0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|35042699022|14060799003|36860700016|376014|22082099003|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	NOJCcLpboG9GattFypnaQ0f31gpBm84rYXceAxeZlBDh26rNwkkrxES5TSJbBfIKztt3ahbJNBKiC8hAuGWqE2VaBJDQauCLdpefwgplWayAZ1fyyj4GyTgeRziecDRz1tXDE1RFHaZlA6k+5CrOPyI3p/eLN4iSPkiYrxUA1puNV4G9CvyhDZ+YIIMtYAIcbyyVB9luH702U4kCIBdkK+y3Z5K6kKV1xpgeR1kAoxWZyRE3XNm4SW5/7UuSQZouZhDybaXArcaHLO9vvGQ13CV3dtNGkEHWGW3KMnyTpqZSPOq6rIyD1FiJNv5EaiE9RrEq0UCw0cK30p3ZBcuRsYD9kSppC+F2n+Ob0i7nUNIGTCwg5z7y6DWXGN3b5HICToAVXplmIZW+ExK100EXQgsn6EhPZKMEXCuGlkQzM2zyFzLLDYWrDpVS8Ne+OkCaGJUUi20Lk7HDA679kUgRnMUORISEwH8GQhVFx9VD1I//1w+wWQ39+sY4s4ccPtx3cjvtagtpSVKykkqzbuc82+AXrLLX/5LXjNUysmKFT9ZF9exufbu1kBVTlglU80riZ/kfJcFmnsMk0/P9VbraO2MxrQ7mHbdeGTSLthRBkeKar7rOPrgyCVOTSJZ7hqpNQyAOD1WA3lKWZ5ZkOUrm+8HSsefQz/lhlcGCGKVXMeoMS2hAVwtIcpv5NAzTXyxDTaCYYhqI1jOERo/2mk2bGA8GY8WHHJzS3FLhZniWXqJyTDBmQYLOYOkUWHsgW4e52wvPzFuR5lkt93DorO3Ljw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(35042699022)(14060799003)(36860700016)(376014)(22082099003)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NZOFOTVUsU2l6tiVmy8hGKWcfrCkHBj7cdM971YBQo+2jFgqkIF10hZrfWL4B2B7FYjuzSm+x4gXxriKUKZZIwydyrFMIDh1W9bViRMmrks6AiB5PDQMPEyw3pOtXt3z9ymKcuhnyjLRgt9NqCcqnG+S6leQokMhIORJc27oo/yIkcdBHmJZ3wKGFFnhBbyCv2jA3UqJl757B8HqWulDoXSfOeewiNYT/nD795ZcIgEuaGqnXl5pTCIq4GkYQIajkUjYqtP2086uc1M99jSOW9eOBA3VyBG1GdzMkQQFUi+1ufKTWvCgN/Iy/tU5QSc5QFsUU5Ce3a0EJ3XGkqHLAuimDK4x+aVrdkatZKlOF5A66UHR33gMjfrOrkG/lYiE8vE7dyOkh+PuIFr7SgSh4/3NGM1nh8lcfcSP+4+JnvuqkhZzvdDrNHDeEqFk1yY6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:29:51.0505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5330310e-d7f9-482b-299b-08de8f213484
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5933
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGkgQ29yaW5uYSwNCg0KT24gTWFyIDIzIDA4OjQ0LCBDb3Jpbm5hIFZpbnNjaGVuIHdyb3RlOg0K
PiBPbiBNYXIgMjAgMTQ6NTQsIElnb3IgUG9kZ2Fpbm9pIHdyb3RlOg0KPiA+IEluIHRoZSBjb3Zl
ciBsZXR0ZXIgSSBtZW50aW9uZWQgdHdvIGRlcGVuZGVudCBwYXRjaGVzOyBvbmUgb2YgdGhlbQ0K
PiA+IGludHJvZHVjZXMgVFJZX0hBTkRMRVJfREFUQSwgd2hpY2ggdGhpcyBjaGFuZ2UgcmVsaWVz
IG9uLg0KPiANCj4gT2ssIGJ1dCB0aGVzZSBwYXRjaGVzIGhhdmUgYmVlbiBtYXJrZWQgYXMgIndv
cmstaW4tcHJvZ3Jlc3MgYW5kIG5vdCB5ZXQNCj4gcmVhZHkgZm9yIHVwc3RyZWFtIHJldmlldyIu
ICBJZiB5b3UnZCBsaWtlIHRvIGludHJvZHVjZSB0aGlzIHBhdGNoLCB0aGUNCj4gb3JpZ2luYWwg
cGF0Y2hlcyBoYXZlIHRvIHB1dCB1cCBmb3IgcmV2aWV3IGFuZCBtZXJnaW5nIGZpcnN0Lg0KPiAN
Cj4gQWx0ZXJuYXRpdmVseSB5b3UgcHJvdmlkZSBhIHBhdGNoIHdpdGhvdXQgVFJZX0hBTkRMRVJf
REFUQSBhbmQgdHdlYWsNCj4gaXQgaW4gYSBsYXRlciBwYXRjaCB0b2dldGhlciB3aXRoIGludHJv
ZHVjaW5nIFRSWV9IQU5ETEVSX0RBVEEuDQoNCkknbSByZXZpc2l0aW5nIHRoaXMgYWZ0ZXIgdGhl
IHByZXJlcXVpc2l0ZSBjaGFuZ2VzIGhhdmUgYmVlbiBtZXJnZWQNCmFsb25nIHdpdGggRVhDRVBU
SU9OX0hBTkRMRVJfREFUQS4gSSBoYXZlIHBvc3RlZCB2ZXJzaW9uIDMgb2YgdGhpcw0KcGF0Y2gg
d2hpY2ggaW50cm9kdWNlcyBzb21lIGltcHJvdmVtZW50cyBhbmQgbm93IGFwcGxpZXMgY2xlYW5s
eQ0Kb24gdG9wIG9mIG1haW46DQpodHRwczovL2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi1w
YXRjaGVzLzIwMjZxMS8wMTQ5MDAuaHRtbA0KDQpSZWdhcmRzLA0KSWdvciBQb2RnYWlub2kNCkFy
bQ==

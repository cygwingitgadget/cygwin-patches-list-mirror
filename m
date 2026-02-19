Return-Path: <SRS0=YdQT=AX=arm.com=Igor.Podgainoi@sourceware.org>
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by sourceware.org (Postfix) with ESMTPS id 33F7D4BA23DC
	for <cygwin-patches@cygwin.com>; Thu, 19 Feb 2026 09:20:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 33F7D4BA23DC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 33F7D4BA23DC
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20f::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1771492837; cv=pass;
	b=iLmovK7KMemsgLNcC8MMcczmU3J8PshdbevWLoT5EOOlVbwsqAjvwNF7Da21wb1xgJ6/8YER0Ti0DRYUfS9JPLuZm0zUQbG31BmmuXzQAzXRYQAUIe+zf7qEDW7F022LLQ45Hkl4W+bazbGK4P9MZccEIbfPxbR3HiYrWbamunI=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771492837; c=relaxed/simple;
	bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=MdgrITiKUBJUDFD3IHwmOfug6PNVzAGsL+LhjHQ9g2kM82u64PWy3j8mdvPdPq/iuzr7GMxaC1YqWJO+J4ybL5V7SuejKnLQ3u9FWRKWQEAYivsAUjjppAn+ALUmbRDQfYEzFktO62FKTqKXpYTEWm0geRZl74ykdUaUcWrlIgs=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 33F7D4BA23DC
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dCIWj5lX;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dCIWj5lX
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yy2ztG9hVd43WGGXw0I+kDDCGQJsxpL75E146UMmOVTiJ7RwoaPAKDXPB6uQcDIiNWVqpxVtYeUAIhbxSCy673w/5IkMz/c5eiw+0mxcNPsvxEce9qNhuM4Xy90RHLzbOCeU2iKS3qcMgTO/z25rR5LLnjoV6GGaAdt9T+GD7cCoN1ivD/pWCysiubBnukceOHUWBFKY/B31hyQ1LKz/0EHIjYCdBkGRV5jE8kt0ijdQ55gLz7PjiyjcypZ+iv8FjWbRVHx2e7WKP+LIQLike+wD/tHwCX76Z9csTfp47Bc9odRpEfXolaaItW05iqNaucOmaOxe+AZ0tVFC26jiTw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=a5nDznGcamI1PkoJr79aDr6KtjsgTqJvyvJO4cpBSnTe7cBeYooht5DX+zKEywR9CEbJDS9do/G0+RZlQtdX9lEHjuec+UkCN49QkAk1ogr62zcEXnTnX7F7NOeEQBqauMcbyyPNnFRh8xc2ym/vxMYbLFKZjAWvrorTZ8rC8x6LGRu+PT03gea+zNVC6rhkZHLnMITySdBUkExWsOWzXjT03Gl7b5SJUnZmAIce20xxCpmQqYDk4/RcYnC3jmsLgj4ney52DRvg/8Os2xaYIUyhZLijNd4zX4LwKvLjCjFGVFWhjz8sZvhq+8n+AhRHtb9Aw7rmg17K4BZbGsbn5g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=dCIWj5lXf5fQO3E0kC64lHLn9z5o1Y2Jx6cZE32wRlL3xXPL28y3upCbuJAca4ydkrujc3tXI5kTUEysRaJ4w+HzBPNPXjXuQZTDVbqutZ42CSd5KfHOgFBKqCMUvQD1hvvKEUJoEWKDQSB/5Y8BuXNhUvpvrVhB69jgFSSLTtI=
Received: from AS9PR01CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::24) by VI1PR08MB10008.eurprd08.prod.outlook.com
 (2603:10a6:800:1cb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 09:20:31 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:542:cafe::50) by AS9PR01CA0046.outlook.office365.com
 (2603:10a6:20b:542::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Thu,
 19 Feb 2026 09:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 09:20:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZTUIciiTJP1cEGjn5q+buW9+jf0ptDkiFJCHgoX274pLj2owLx09zmnTOPh9hNtFhP2osF58EhIs+la4/Cz90WJnbS/8pl7lpWHa9jCykCNP9vYPClXiyM9JVPqYyAkg+uEM/UknFOoaYOLCIY03S6OY++F4TwW2TmT6dd+xCUb6YRti9qYH2X1K2HL3kqyGRfsdhuveElkJAbJ9PmR4fs06ip2HHOrFeUd+YBICiCnwde05XL+yGJj5E0W/i8uSazkTY9/civebPbfaO0WmG7BadkF1NwapoDm/2kAVyxHGHM98Zr7przJOgHI0lsRiezHsT3OWggAe/x+hLjnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=wEV8T3O4MkItAeT2CwfCu5QyJQa4ep7wIdb2OKIRByhkuztUbZgjLuBGH7HgxG/xN4TFuLP0iGRoggRArW369j9Jtbaokbkc5wkF1ISlIEH7V8aKbIoaoVYu5ZVJg+s/9oBaezkvI3Fg2MBKjq4zaFB/Rq2KVwo5o+J7UTMamneZ7lUzk4gGGSeTPNYeSss/r7osbXUZXRYE8YRytZc9W83RY8W4fkfFpM4IvTEhCSlE1FKRu1//dTvjaJFAvQk8vgVoEAGOLT0FZX7lLq43FdQQ6djKZKlqMVP1zhgfVtJ+orhu1CfZwT4y0kOSWKPEzKRs+YajVNPyZpr3e2vLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=dCIWj5lXf5fQO3E0kC64lHLn9z5o1Y2Jx6cZE32wRlL3xXPL28y3upCbuJAca4ydkrujc3tXI5kTUEysRaJ4w+HzBPNPXjXuQZTDVbqutZ42CSd5KfHOgFBKqCMUvQD1hvvKEUJoEWKDQSB/5Y8BuXNhUvpvrVhB69jgFSSLTtI=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by DBBPR08MB6107.eurprd08.prod.outlook.com (2603:10a6:10:200::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 09:19:27 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 09:19:27 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
CC: Igor Podgainoi <Igor.Podgainoi@arm.com>, "cygwin-patches@cygwin.com"
	<cygwin-patches@cygwin.com>, nd <nd@arm.com>
Subject: Re: [PATCH] Cygwin: gendef: Implement setjmp for AArch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement setjmp for AArch64
Thread-Index: AdyNYfXzykS8eA0ER3OTVNVTeBRp7gUHuEaA
Date: Thu, 19 Feb 2026 09:19:27 +0000
Message-ID: <aZbVnUN2M0QqVXd4@arm.com>
References:
 <PN3P287MB30778F0B844CF83434426EDC9F95A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3P287MB30778F0B844CF83434426EDC9F95A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|DBBPR08MB6107:EE_|AM4PEPF00027A6A:EE_|VI1PR08MB10008:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e008cf-547a-4b50-2659-08de6f9820c3
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MWRYU2EvUHZiQjVhL3JNQStZSE5sUUZudzZjODJQNEpvb2swU21xZFFaaUVl?=
 =?utf-8?B?UWc1RGwyRjNhekx5M1QvdEIwdlhrSVFmeVA1ZGd5SlZWcy9kRDZHWjd5N0o3?=
 =?utf-8?B?aFk1d1UwT3F5NUJtVGpvKzB5eGZGc0RjUnNBRkFPaWZGSG9GK2djanFudnc0?=
 =?utf-8?B?Y1BWVEF4aStoUG96cjRzbk13cTdYeHl4eW5qUzJjS01Nb2MvaytDV1l2bTUz?=
 =?utf-8?B?UGt2ZVQ4dFl1K29UczFQeDNjTWNCT1NLRGNrOHZvSjVITUx5L1RUd0g5aUVG?=
 =?utf-8?B?MW1NVmVRM1BKaEFtK1IveXpRSGJCN0J6T1AyNzFiRGIvNDJQdEVFd2J0Q0FS?=
 =?utf-8?B?ZnJRU3JUUFlXRGNTY0JMbUowRWU0YkFYSllYbzRuNWUzbVF1cXJGZWxxRGwz?=
 =?utf-8?B?bFNvSyt1eDM5NHNNam14VGI1b1pjY09FcjRTMU1OZStCUlp3b3h0Nk1hTTQ3?=
 =?utf-8?B?RGsyTWxsWWFidWxpOUFOTkRNV2t2V0EySVNBY1d4WmtRQzVRcWtESmQ1b0t5?=
 =?utf-8?B?bWRGTzU1d2JsNWFOYW8xbStZN2xNbDlSdXZEcjFCKzdzaDB3YU91ZjlWNjh4?=
 =?utf-8?B?L2wzSWZ1enVONCszYnZRdU8vL1A5RmcvVVN2VnU1a09lK1p6K1hBWVFEVXJB?=
 =?utf-8?B?THlUaHo4U0UzRUtSajJHUUpOM0JCWndmbFZnUDdOZUYxbUdPZFZvZXRQYTZv?=
 =?utf-8?B?ZVFJSFBZYmNYNGV0M1Q0SUYzc2JXdUxrY1diUWtQTk4zNHByQWdET2RIeERi?=
 =?utf-8?B?TGhHbWJqZENmcHo2b1gwajY1RGdCN0hmbUFoMC96aXVmYkpwa2pIdkg4bHZR?=
 =?utf-8?B?NFJ5d1hQOVNUOXozWWIvVk9nWkFVaGRndEs5RTcxNGIyczdoNHhpVy92eStM?=
 =?utf-8?B?UnlWNUNzUktWZjdLS1NPQnIxQzZtNDNYOG1TaUhuMzhoTjVIR3RhNHYyc1Qv?=
 =?utf-8?B?T3BIS3FSeFNkMDlOQ0N6L0lJMnNwajErWFBxQzZKaXd4cU0yNWlYZ21ZRDNn?=
 =?utf-8?B?eS9zMGg4eWxydCt6RFFJbWNFR1FSL0tKYUdrQVpXcURnRWM0N1FQQnZ0eGZa?=
 =?utf-8?B?by9rSGtWM2lHWldFMko2SGRJVUhRY3ovQXgyMmZEY1NuTVRyM3k4NzdKRHVE?=
 =?utf-8?B?RlBaMEtkdjZGUXByYjNGQkxKOXlyMGFGY2hjZHU2cm56RUY3VFlad3ZaanN6?=
 =?utf-8?B?WDFxRnJyME0yNDRPSElXK0J2MXZPNUh4eGtkYzNISHJ5RFlsb01NNk9TSmFm?=
 =?utf-8?B?bDhGdlo3QUd6aTk0b0dIWVBwSUE1VUhCUlYzamFYb0dUREhIRXROWmF6em4z?=
 =?utf-8?B?Q3JwL0xoT1RWbnRORURIOUVWaUJhWWJMNlEwVStmdUxCYkFMdHcwNmYzVlVB?=
 =?utf-8?B?OElUNVBiT0FXcmJ6Qi9Hb2JHY0hUTmJxK0d6WEtmczdkdndObloxVCtNblZ1?=
 =?utf-8?B?cm5naDNWNjNXbUpqdWlVR3hNbXg3T21mZE5EcXhZeHdkU29CYlRlQXA5NzZK?=
 =?utf-8?B?RVRBSnVIM01ab3lBNEUyUndHUnZ4a1BzUTlJUzk5UjBSSDVGYk0wcitobVg2?=
 =?utf-8?B?cVBRU2NpbTIxVFRmUEVOdW5FS3FJa1JVU3krNzd2TUFLcjNrUTV3WFRXRHlD?=
 =?utf-8?B?Q3ZlMEp3c2M1ZkNJdXZ2ZXdCRmhxZXBDSTRGSDI1anUyMDg3c3lHUENFSWpa?=
 =?utf-8?B?cWRhRnBUdnJlR2FKdy8vNWNWWHVTSCtNR3pLVDFTUi8waHNzS0hkQ1JqSnZa?=
 =?utf-8?B?RGl2d1dTaFVoZEJvc2pjR3U4OC9FUGNtckw0Sko3a29STHprUGNhS2F6bjY4?=
 =?utf-8?B?cUhTeFhiNG85dFpTWjZEd1NuVXdweWxJUHcxSEJlUExhd1pYZWw0cEM4UU8z?=
 =?utf-8?B?UkF5elhpMVNRZzNuT2FjUHluUDlLL0w0V3JSL1R5bWVLeUlvMEg1VW1pRzlE?=
 =?utf-8?B?c0VndDd0OWJUa1lEV2hpeWpxdWNXclJueG1qVnFKVVExZHpHK0dNME1MaFQ2?=
 =?utf-8?B?NU9oR1dzTXR6Q3NSVzFpYzJBZHpaNzhpTmpmSWJlZWhTWEJpSitHalZWM29H?=
 =?utf-8?B?YjFhck1lSHpJNFduTWhtVnkybndhTVJ1amo2Ujl5aTd1ZnJRL2pzYzRPRHNl?=
 =?utf-8?B?bkdzUVR6VGxEOERXY21OWkZXOWExa0psVzYwNnhXWGZHRzZyUERtdldmY1hQ?=
 =?utf-8?Q?YYe/oVPhf6z0qia09Lv8dvM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0D2A4F56C21894EB7ABA9969FBD523A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6107
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3cecc35f-e2cb-4ed1-69cb-08de6f97fb29
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700013|14060799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVl1L2lBY2hIZVlXMHFJM0F4K2pQR3BPTFZtRWFvMWxjczg1VGx2RytKTi9F?=
 =?utf-8?B?UE1pRk1Xek83NXpBNFMyZmV6UXJXbXdPZktudlZpa3h1SWlRdXZNQjd6YTZW?=
 =?utf-8?B?Z2cyaVNuOVB4MFJPMlYvWjJqWS9QdStQZUNqVkJTZ3dKeDFackhVcEhDNUM4?=
 =?utf-8?B?QTdhcG5KSkFvcjhLbTJtUkpQWjhHanVGQzJqbUVnTEp1dXczR08xWnNwU1pW?=
 =?utf-8?B?clV1enRaY2ZlejJ0TzY0R3hPaFNqYTB6UFRwZzJaS1lKVCtwTW5Edkg0ZVpp?=
 =?utf-8?B?NGJtd05UODVuempmaDFjQ1pRRG9wekVSS1BvdzFiU1VRU3NLbVRMRmNYSElv?=
 =?utf-8?B?UCthNTFwdWpIUnVxYjdDa09ubEUvSUo1WEtNODY1b3p3WU1SR2pIOEpJcXhD?=
 =?utf-8?B?Z2tveEZqU1RNZmlRaEJDaXlLMDFuNVd3ck9Heks4dVV3RE5DYWN4R3ZjTkIy?=
 =?utf-8?B?OVlEQXlHZ2plK21DQVhjV1FoUFlHOEpwUzJudWQyQTE2U1F5M285U0phMnpy?=
 =?utf-8?B?MSsxVkp1bXd1WXpFKzE2a1lGMFVwaHc2bE5lUGZPZTB1cHZ5RUptRkpvTGVC?=
 =?utf-8?B?MWp3ZzVoZ0NHR0x2WFhTb0JPSzlISFFFRStlN2JiZkxTTGFZNEZjcFR4Y2lX?=
 =?utf-8?B?L1R5bU1uUytNdk1UZkh0Nk0zakhkL3E0c1JRcnFSQVVSK2l5cU0rRzNMeUhQ?=
 =?utf-8?B?TEVUMXFQdmhyY2gzTVNSYnhWTUdPbHZSKy9KT3VQcm5GSnRxK3VLNkxpb2Vq?=
 =?utf-8?B?YUZIR0crKzlBRWo1R0w5UjlVaFVrdnY2SDFsVTBNMEhLRmVJY2hJTThTUENs?=
 =?utf-8?B?UVFSQ21QL05hdi9EVGJYRDFhdGJ0L2JOdmZpM3dWcTFoN2gzdG5YVUI0OEQ5?=
 =?utf-8?B?WmFkQlZRVHB2R0JuSmhSNStGa216a3AwcnNScjhpT3NhZXdRTUZKTmxmQVFF?=
 =?utf-8?B?WCtWUkdGQXZsMTdaUlRSdXEwZnYxeHhnTm00VThjWkJXc2NpWVBFaEtCRFFm?=
 =?utf-8?B?K3ZVS0RZK2lPdXl2ZVdyL2RkV1Vtd2Jpd0hlSEduOXRrRnBHQ0F2anFsVlpU?=
 =?utf-8?B?RDZQRXQwQ3hOTDdGbnBFYTlGVnhIOEVaZm1WYi90YVhJNTdOVU55Q2R2MFhj?=
 =?utf-8?B?d2ZMS0pXWi9lZjZUSEU1NHAvVnhYNU9SZjc3MGdMNm16ZHpSdlRVdjR5VEdH?=
 =?utf-8?B?bjJya1YrdVVzUVd0OHdWUEVZQitMMlVxZ0dKai9WcTF3T0w3STFXQ0pVRGpZ?=
 =?utf-8?B?dWxBMytMNUxQSHdzTnBjNEV0VlNlME9YMVVTMG1OQUw2R1VxLzBLajczdWhM?=
 =?utf-8?B?V0Q3RlBUcEtmWTAvY3ZrUjUvSnVuUDAyU3ExMWdDdHU4MUtkQit6MlJaQ2dn?=
 =?utf-8?B?cENqdlBjUXowQWNuempMandjOXNoblYxa2RBQXE2Q2U5WXg0U3lWQTBEYzNt?=
 =?utf-8?B?UDVJelJDcGNVV3VRd29neTh3emQ0aEpFLzVsSFNPU004WGhJdm10cE1Jc3g5?=
 =?utf-8?B?VWppNFZHelZQSXdjejZ2ZXdrYmdYd3E2aVNGRWFEKzJKUmVnREhhbHBFdFl0?=
 =?utf-8?B?Z1hpMEhpbHgxL0I5eTkrL21ITThCQmRzNnY5NkI5ajB0b1pjbmtnQWZKWmQr?=
 =?utf-8?B?R3RBZlJuWmlwdjRoTE1FSHR6eUROOExPVTRQZUZqS2s4ajhRY0piNU03ZzFT?=
 =?utf-8?B?MHFCMk1Pb3doNnNTR01WUVVwOEZpRW91ZkxZRFpGN3VJMjhKb3ZtTU9hdWpU?=
 =?utf-8?B?M29FN3cxZ0hUekZsaHlqUHZZa2NuL3VyMG1RT21MQ3YxK0tnR2phV25jNDlu?=
 =?utf-8?B?ZnRnMXViZVhDdjdablhoWFBMNEc2YlFnRER3eTZLYUJBazdkSFE1NWlxQTlT?=
 =?utf-8?B?WHJGcjl5ZmRsNW4yYmtiNFBsazdwR0ZMeXhvZUdjSWNRV3BaNzNTZFU2VTBJ?=
 =?utf-8?B?T1V6ZVZ5dEwwOVdMNHdRUTAxNU9IRVBQbmpsZFdKRG9idXV1TWRHZFZYK2Fu?=
 =?utf-8?B?ZkRPSHVXcWRpRkdXZ3BIVnhoMXBPQUZsZURBR25vcEZ0TFFZYkUzaEw2a0Vm?=
 =?utf-8?B?MDNqS1l6MUtDNlJDaVp2ZUhjWGp6eWFWY1pYQWErZEYyVEl4YUQ0M2I1RzN0?=
 =?utf-8?B?cTdZQlFCWUE0RTV2dkdrMVY4aE1tQjYrekFMZ2RnZUIwbEJKZWFaYlY3cG9Z?=
 =?utf-8?B?aTZPS2pSajd1OEdtalRRUVo1aVBvUDM1alU3VXgyWGFwRWpTSEsvMktUcjY2?=
 =?utf-8?B?Y3dhY0t3QUc4cE9oM1VVRW54MDN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700013)(14060799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PMMgsSvsG4LEEzR7JqALyXirkDf6W8kAYlRzyWIU0EvL3Rz94aUAt5XTRn3xOjUw1CnPR/m4dDw+ZQET2IFJXAlzx0EX26Ngk84ismFuJEpKBTXxbn7f4gaU+eWgtG3c1/6967qqBqPDZHtHpzFLsQZ8j0hMhtlEnjrt4Lx7rXWg4rABA1JM1RVfm4vfjlzKD7QSmIOuInEo3p/Bc/mFf9NZtIZrqGHOmxeI4ZyIaO57beB7DGeuECnN/78qOvFrddWzrRL3Ui1Tpm8KMGGpUnz213sOB+SgpzNeYBOpMmzqPVRr4yX/rBA41QQoVqPlj2b19lOoxGqoNx5X7G2U/x0ubpPnp9UFAdD7vgwppJl9WNA0UuHjAURiX+uhXCV1O8UPiTsJcDjXltRUWa9KzqXxag8pwFdKFspL6+Z1Su8VWTIGzeDFP+s7lfTXN8+B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:20:30.8324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e008cf-547a-4b50-2659-08de6f9820c3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10008
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGVsbG8sDQoNClBsZWFzZSBzZWUgdGhlIGZvbGxvd2luZyB0aHJlYWQgd2hpY2ggcHJvdmlkZXMg
dGhlIGZpeGVzIGZvciB0aGlzIHBhdGNoOg0KaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFpbC9j
eWd3aW4tcGF0Y2hlcy8yMDI2cTEvMDE0NjQyLmh0bWwNCg0KQmVzdCByZWdhcmRzLA0KSWdvciBQ
b2RnYWlub2k=

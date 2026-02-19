Return-Path: <SRS0=YdQT=AX=arm.com=Igor.Podgainoi@sourceware.org>
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	by sourceware.org (Postfix) with ESMTPS id C64934BA23DC
	for <cygwin-patches@cygwin.com>; Thu, 19 Feb 2026 09:22:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C64934BA23DC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C64934BA23DC
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::5
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1771492938; cv=pass;
	b=dSDC3bwf2u9SFGzyJSrvELG8OffwHAW5hsFlTDzYQjFHpaUHi22ttutXGKDYZIFGB2AfI09QxceQNwMoELC6OpHAbATjgnEkp6g0fg6C5uiSAoecaZibmux+euzA26rAwbMK/5LwxkfeJmZ/EKd+22UOEUU53z50Op5TNUvggvQ=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771492938; c=relaxed/simple;
	bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=UGBGk4g2HdJ48kPIcJDyx7rffNH0zEtCbEpw/2JAxAkh9ijGPzL5EJjoCN/l2utVWwUcbZhSO13+yLlWiM1jsGKMUo6n9BLLfSZ2Rc6fJSXV7C5bDyTXcNAydd0vUUYbENkIO+fOnXyIdD6MHrxSfQ85B+CMIQ0XgFk+kYTbY2s=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C64934BA23DC
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=e5uzwpwX;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=e5uzwpwX
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lTmyocrwrqqnPFj7JmclZZHUbQWjB3jXPqbRoyQuYrOgErlLUBpbLYY/jBY27vM0T/EFAKY/a7V4L2OQk7tK/p7dhR+a+CTNvyttEhi2ZrAx+tWXTsepHfx+N7qPFoG7av99Zigcg7khuc8YmUtzo03/BboMRpp50c7DIM3G8xG01JCcyA40IqjpXrxk0zg0dslh1x5Au+ej2pORtHYzXNiNYNAliZNIlQWFg1aeVIHDv+JjrF8dL/oJXLOTA0PLQrdv3HqxcqvzwAD5sHMywKLQsJEKPy0doFNpwMkFHUaETxIj9VcablRk4u+EQIJYm2w5dK+Z0YvNtyIfE0+2ng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=N6mw1S2XLxuJdb/VDi1nccIV7U1p2I7rKqjQYOy6RxzbnzkxE9vSY/cRy+S9t5Kw+VSh+hcQfvhJI9v9KZm+Lq/sPfwE8OyEuWa1MuLT4bT2LqdIy9xQ23DB4STqrWL9gsjkzoQK/OD3hYanAJdDa9cF9x+761ibjnbS4IsG5AdF8MRsNOBD6a9ZZ/Uk3OIN66HXLtXmZ9VsLvxeEGzP0FrxNQRFcQu+w88kmJ29CER24DZ76HAXx+tJqv3OzSa32Kt8AukchbOwUKn1yMr84Js2G1Nv0Y0AF8EfTDwaMHPa+pxDlc3iEjFjPzb1pxZd5jGlk/XN0cXzsT5YR3ovwg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=e5uzwpwXHaukINHxdreKGB/7RD9mRuqVp2Qy6+L0oKLX4OmxD1hjKFbdtZyzzunmJfFEe8SobGWe0pCLtnlFoAOrTpvt4U/yT1BDPMd2Bg6f12Amj99mFYXHx0mfiGzn9EiUPJCNMVV+5tOFuq54ARA8stItxO+dDRjgKiamSHk=
Received: from AM5PR0101CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::25) by DU0PR08MB8712.eurprd08.prod.outlook.com
 (2603:10a6:10:400::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 09:22:10 +0000
Received: from AMS1EPF00000090.eurprd05.prod.outlook.com
 (2603:10a6:206:16:cafe::d9) by AM5PR0101CA0012.outlook.office365.com
 (2603:10a6:206:16::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 09:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000090.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 09:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZJDl8oklDjxVN57RfcYWE4hUlgR632wFnebhHUWSggLsjkTh0A3021RSy6ANMTbPJS8c51g9lT84rocAaEiUtLWM3wiTH1W+wRTQkT/Y+xnamYzdKuBmTZi9OOfVDgIk3VFxndsn63wEnoBDZYFi3EN67tb9Y/forrzog7a60Gk2P6/oXQN8m0wfdfSOU9zGusvNt8Z2Qyvu571hSac03nANoGbHL6/HaN2+jlXDczPcWPRGmXX+p4yCb94EDxb4hTOJDcfSxK7PrHkC8Dt9c6qbq6K/sP/VXotPvQsF2uMyPF/bjLFWeaJQJ3QJFZW3c8yPGTmT0u6x4yL8JSadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=sUFdBoC1jjkn/eY7Qu/GD3pF1xFK8skYFANx0mkNjE34xTbFLDPbit5WMtZ1Xk0Zzn/Ylcy+ncX8pr9hxyssExer409Ei0cnbKfPrF85bFn3OsqWjb2BdtxNwHT5MlY/tHTv3OMMeeLyeMB7s3iuwreenMQAPW12FLD3eVfDgh3K3hYnUWlkNdxhr/YM2Jd/rSVlnYkU4e4u/Do9f3CqOcy0iMQdhD3r3fNxmlhOcZXwoP9SpyDhO0+j07FyjCgKU8Lvgz3W96xxy3kSIEdEuKY95mpW71E5hkWcf7yMim4EftH0cnnY2BBwIb0ho6ByagC0QRDKT0yeocqTxBTJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=e5uzwpwXHaukINHxdreKGB/7RD9mRuqVp2Qy6+L0oKLX4OmxD1hjKFbdtZyzzunmJfFEe8SobGWe0pCLtnlFoAOrTpvt4U/yT1BDPMd2Bg6f12Amj99mFYXHx0mfiGzn9EiUPJCNMVV+5tOFuq54ARA8stItxO+dDRjgKiamSHk=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by PA4PR08MB5887.eurprd08.prod.outlook.com (2603:10a6:102:f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 09:21:05 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 09:21:05 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Igor Podgainoi
	<Igor.Podgainoi@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH] Cygwin: gendef: Implement longjmp for AArch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement longjmp for AArch64
Thread-Index: AdyNYneh381oeUocRWOs+/49F/iADQUHpk4A
Date: Thu, 19 Feb 2026 09:21:05 +0000
Message-ID: <aZbV_mRhlUEDqM1o@arm.com>
References:
 <PN3P287MB3077A99C408AEF13C8036E4C9F95A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3P287MB3077A99C408AEF13C8036E4C9F95A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|PA4PR08MB5887:EE_|AMS1EPF00000090:EE_|DU0PR08MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: ace87022-619b-46de-fb05-08de6f985b88
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UEwrTWNwZ1ZDS2dSaTQ1UjBzUTZuLzZzcWdyZUNpZkYrK1Q1NkFITFhmdjRX?=
 =?utf-8?B?bmx2SXZEbFFvWG01SEJtUHVrTFU5a2RVcWptdXV0NzNhTWhSenJSZ01RcXdh?=
 =?utf-8?B?M2owaTNORGtJN0cwUDhndXVIOWNrR2ozdVJnTm5vYVcyYUYzTG1odkRZY1Ay?=
 =?utf-8?B?Q3FPckhpc2x5K2ppaHNJZzMreXdpQkRTVkx5dlpjMVF5OXZGNHNQMHhET1lw?=
 =?utf-8?B?U2RrQWs1L1Q1VExFck5yMGNIMlNFaG1HRTZGVFFuK3VwU3h0cXFiTlNNWmlW?=
 =?utf-8?B?S2ErRVhROXZjTy8yV0FFVkhUVFlWYjA0dzEvVjlQd08yRmN2dGsvaysrQThU?=
 =?utf-8?B?RGZxRFNISHhIQnVjMGVLOXNacjJRbG9mSmc5SEhFaDR4elozK0JDYzBHT1Jn?=
 =?utf-8?B?a01DNTN6NXN6bmE1b1JKWDVJbFZVWHFUd3cxcUpNcGh1ajlIQWFnYmtscFQy?=
 =?utf-8?B?RUlxZ2diZ0Q2STdmMk9iNnpXU0VyVUQvdjdjMHdVSWZxdnlhdHVOWkUrcmht?=
 =?utf-8?B?Sk8yYzhNZWJxNGMrMW5SNnhxVXBzRnpDSmpZMGhud01hSzBxTjJXMFJYYjAr?=
 =?utf-8?B?UWJNSWFkek44bUpTZlBuZytxNUx4Qk42THkxZUx1UjJlUU1kZXFrTTFDRmgw?=
 =?utf-8?B?Q0JwU09CZE9RWTFlcmNwUUg2enJWR2dqZ2lkeVdndkV3K05jQjRPVmVyZFN5?=
 =?utf-8?B?dWRrYmE5RDZLTDlQd25YMGpqOWlPNlZwN3R5RUdnMktTYlYvMkxhTmQzaUdr?=
 =?utf-8?B?TklYUm5hN1ZLaUJwNXBpQzJGMS82YnBjV1EyRGh5ZTdWeXlHSXppM25oTDNS?=
 =?utf-8?B?Umo3aC9KUlB6TzJlcXBmQ1Y3dGVHaXdPWXFXRnlESHd1bXJ1aU4rNmRraCsr?=
 =?utf-8?B?a3c0YVg2ckwycWN3a2ZvRXJ0ZHdLSzNIV3RkZFNLbnpENnNVSzRRWTVERzVi?=
 =?utf-8?B?WTZHRHA5N2lEMkVtYWNGalUxbTNWMjJqNWlYdC92SUs4MWl2WWh2dTNjbEM3?=
 =?utf-8?B?VSsyZUxuVWc5ekp4R1JxVzZnaHFnZmQ5TzVpclFGbDNEUVRZVFdQTmdITDBI?=
 =?utf-8?B?TFhDWGNpb2YzbldtdldYSFBOYnhCZUhuUVNJalFHSzJCNS9XbloyczVmaXEr?=
 =?utf-8?B?UW9IRjQrSkl6ZG1JQjNOUm43R1B3QTNyNHdBZ01HTTFOZ3F4ejY5d1lhekw5?=
 =?utf-8?B?bndEN1Y2eHBSRXpQeUxyWWZVdFF0djlsT2s0Wk95ZnB2UjlkOWNFc1hSYkdZ?=
 =?utf-8?B?RzRSQjRUb1hqU1RVOHlFd3EzL05jTmFldWpSRHEzai91N21HOHZ3ZGoyZzZM?=
 =?utf-8?B?U1lOUjY1Z0tMNWcvc2hLd1RqY2hpUUc5WTNMejFpYkhPN1ltV2t2NUc4bHBj?=
 =?utf-8?B?S0xKOVRGZUtXSDdiNjIxT1B3OG5wSXliSzgzQVJ1bFBSbEJNRVVGN21iOWJI?=
 =?utf-8?B?Vk1YTFJvSW53VkIycWlRSERzNTEzdDB3QXEwNFFPQ2J3UStnUUxHak93R1B6?=
 =?utf-8?B?SHBxL3VnTGUzRTZlcXNaKzdHZFAyTEJIMGpDWEV4aW1PS0NtMnN5RFcvNU1Q?=
 =?utf-8?B?d3pEbHpQZEo0Ymt4L2M4WXk0Yzd6ZE5EdmwrTGdBZDdjTTJmdWdHcUtOTzNp?=
 =?utf-8?B?OGhuTTR4N3grUXpoMU9KRmxQbDhONEN1SkFSV2tQTXVDLys5V1l1NWpiaFRG?=
 =?utf-8?B?RitIMHUvMGV6d1QzU2ZiMGFkYWZZTmMyeXpFK0t6RnQxaUdvMHdwSWFSTk1P?=
 =?utf-8?B?UnpkajcxZmdBSkJZY0U4WnRJRTBaNFBGL2Jxa0s2VUVSeGRleWtBdmd4Vi9D?=
 =?utf-8?B?REVXdld6d1cxVUFYUTF6WGpINWNwdnVnQ2RSR2dyZENPUGJHdW9zajhUNlZH?=
 =?utf-8?B?M2dWSXBWNGZpOVRPZW1uQUYrNjZLVFJ3bTZBYnhvaHRZTnVoTWt4YmFVd3Y4?=
 =?utf-8?B?WVE0Um9IdzJJWlh5SlY3NHhGZFJsWk41WU1zTmN3ZVZIUlJPM1I1T2RZKzdM?=
 =?utf-8?B?d2lXaGJFREdJcXhDREx0VzZRQ01ac3AwNkZCMHlaZ3JmUGxLYlgrNmVJYUdO?=
 =?utf-8?B?VjdISEx2TGs3Z2pEMm9UVXRzKzFVVGNUbVhrYVhzWVlKMHdaMUV4amRsOS9W?=
 =?utf-8?B?bGZRL1pzaDg5ZHVHVXVDc3htdk5Jd2tmanJtZ1o3Mm9MNmZWSGUrVGhZUlow?=
 =?utf-8?Q?VswnDwAhbpoab56UwW2opJY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <F80E3907B0667A4FB8A19F9F3D105D42@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5887
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000090.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	af17a953-9b31-4a76-f47d-08de6f98352e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|35042699022|14060799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RENqT2R1NnlHWTlqRTZsWGpQWkpMR2RKN3JrbytZbHQwcjVEZXdQcGd0WGhl?=
 =?utf-8?B?R3JVVU9HU3c2UDNsZzF2dld1Zy83TlVYY2NiUFRuZ3oxSVNDYUNCMGtlWjFo?=
 =?utf-8?B?MzVXR2U2NGZRNk13bFdkN1Y2WHVNdWZjc0V6a0ZqemtjSUVUYUttZTdoa2JR?=
 =?utf-8?B?Z0svZHR3bFVxMCtiY2xNOUpzNnY3bWhEbDEvRVdKbTcvbi9jcDU0NXd0WWNo?=
 =?utf-8?B?OW02K1cxQU1aNVdmT2xjRFM3b1BqSGFxR051OXoyVlNRZUJrTlZQQTZmNTNt?=
 =?utf-8?B?bWxFOC9ZUU5mR0N0QS9Scmh3Uyt5citmSFltQzhERzVncFNKK1VLZ1gza0lC?=
 =?utf-8?B?cE9tTTdHeTdrTWdZTk5iMUJzN0NNU28rZmRyWDNTYVVIdGtCQnFsSjBQT2p5?=
 =?utf-8?B?cUpaSmJuOU1qVGdwWlAwb2c5MjUzOGx6d3BZckQ3VmpxQVlCYkRHSnlGOVZn?=
 =?utf-8?B?SngzWlQrOFJDYmluSmwyVVVSNDJuR0JxUHkvVkZSTTBIVmF1bE0zOVYzS0Jw?=
 =?utf-8?B?dlQvYU5QamN0Mm5qL0RrcC9Ib2xvYndwQmQwc2NuWHRQckJIRkZGejZBd2Fw?=
 =?utf-8?B?Z2xETi8vbTdCU2FxME5hbUVNQ2c1Y242QlJWMXl4RDVCL1ZNY0oyQjlQNWdO?=
 =?utf-8?B?d1V5YlNXWEhlRFV0Yi82UGJTcStZS1Z3eFp2cUtzb1FROXE5VURRYmNwSkFm?=
 =?utf-8?B?em9ycVVySEtBb0JqTkUxd1hkUUhla0I0OWhQMmc2eURWTDh2M2duQ0RQZ3VF?=
 =?utf-8?B?OHV5dnpmL3hLZjFCZHJyR2hqSVg2MExjb2FIUVVvU0lnOWt1OUM2VE4rbXFP?=
 =?utf-8?B?dVhSK09ZbktGL0t5dmV5ZG52Uk5KcDBHRCttWXFYU004R0tKVlY5RFdUWGZN?=
 =?utf-8?B?UXliQ3NzV1ZPRHVINmxqRjZ0SVZIVFRKZ0MxU2Q1dkFoQkRNQXRzMEFjdysz?=
 =?utf-8?B?Tms5MnY5d1ZmNGNFOUtOVHJ6SUJJVDkydElJcXFYMjZZOXN4UmNPei9jUlhu?=
 =?utf-8?B?OFNneHhZRkhNTlBmMTRVSm5hYTBvejFHYnhWSVJsUk91R0R5TWZOUmtiVjY2?=
 =?utf-8?B?eG1pRWIweUpVRi9QVndRMTMxdE5aeVE5TVRnTldRM2VUczhJL2VlVHo1TEpW?=
 =?utf-8?B?aWtlWHdwSVp0N2VVZkx3VE9JVkMvOHZRVzM5bUZ3bnRLcGVYNFlqQUl2YmVV?=
 =?utf-8?B?aHc3dG9qOGFGY1ZyQzFMZmhTLzVqb2xtelNlMU9WMFNlV2E1anJvK3BtUVY4?=
 =?utf-8?B?Vk4rbVVEQmxpUUpHamZOd2lYVmxTS0YvaEZxODBVZkZCeEcvbnNzaEpJYng2?=
 =?utf-8?B?ZkpXMWw3TGZvRUdNMUhDM2NMWkJIMEhzK2NFM29kMWlPM1VBaDZWU1Y3WlNw?=
 =?utf-8?B?YncyZEdRWXRFZ3lsekl5UDh3L3Y2cTNoR3dnUTlUS2QrTWlmYnBHNzZteUJr?=
 =?utf-8?B?b04rZ0t6N0RmNFB3MVNBM1lhL1ZTTmdMclU4V0lTZTV1SGRpREwySzR6dWgr?=
 =?utf-8?B?SVNEeDJnZ2tSVnFyUHk5SS9hTWJocVltY0RjUzRQN0NRbFhFNU5maW1EWXFW?=
 =?utf-8?B?REtOQVRHb0krc1hscTN6cnYwakZzMFQ5SzRyMm9JTjUwNDg3WXBYd01KeUJz?=
 =?utf-8?B?a3RjcGt3VUw3MmdzUWtQWVNZV2lIRUp3bHFpRzd4TEE0eElnY0JuMkl4cDNM?=
 =?utf-8?B?dmVNWUg3NURCUDQyOFRKTlE0SUt4Q3FoaExIa2FUNTI2RXJ3Wk5uMkNicW1Y?=
 =?utf-8?B?OXB6SmNWUnpUTnVRLzdMVklZWXlmRmdXSFcyS05wS2VLSlZldW1jenBVNW54?=
 =?utf-8?B?TmJLUUk2amI4Nmc4UXVUQnNZYjVkQVFhNUZEaitlWDFOcm5pelZ6OGIzQU84?=
 =?utf-8?B?bDNuTjFqdFlNNW9aQ0c3SjBybFpobEhjcUY2YUhuRDVMR0tXMlJuaXhqTFVW?=
 =?utf-8?B?WEgySVNHeWVPWGQyRldDWXo5ME5uT2tkdXpsamhkWU5KQjlqVXlKL2dLTjNF?=
 =?utf-8?B?RUNtNit0cWUrQlRmdHd4bHloem9tMjFzT0gvdkp0THdob2lza3VRVHJ3WWFE?=
 =?utf-8?B?TVhtMVF1U0xFUno4M1NXNUhBbGpRZDQrN2djSWorQ2h4eWw3a1hsZUl5TDEw?=
 =?utf-8?B?SGo0Vit1M1kzdVljWXEvOHRsYXZFeWxKWUVadDFVNTNLTjVBQ1gwaUdqU0Fx?=
 =?utf-8?B?L3lRMWFjNEZCTXJRYk5SSFF6TVJKN0JFZXg5WXIvTU5SM3Y2T2cvSTZwaGhX?=
 =?utf-8?B?TmovNmJXZ3pYSlJMSDg1Q2l2THlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(35042699022)(14060799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DhnchRQyglmn1hNq/quXUx3DlAdkwk8HhEzL+1VDTZnhI0DcLqP0+MTCwcxCO+qqi/NXSe/Ei+nYtfrL/klwGmxsvalMO0KA/xjQSX//zJqap7xW8ucPHPjY8FskJ0ofez+dksKU9p5wotn1cNgXbcTDyzMaK0hITBd/ZEvpMq0dKnK4fYUhPB+h37NQkdwoesF81M5hlktCFJ+51wVch55fsmNV/xhNUXuer1FXZbkqtCj/j5kl3Bfioiu0zI3kJ+ObDgnpaQ/WuBQbrcCvcUS/M+Zc1660Tgr6S3BK/pWOnnTIE5mHFWH4lX0/zh0kTPs5cybiDXceoRjvtGhSqE1fbpAaIuGPiRsOLXCKvf9NuEJVz5/MLKLw8zL7+RHXjZMd1qj11NlFiqucrLu1poRRR18BwdsNeEcOl8SHlwFaGziBmqGZ0Xo3ETIoyzbi
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:22:09.4293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace87022-619b-46de-fb05-08de6f985b88
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000090.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8712
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGVsbG8sDQoNClBsZWFzZSBzZWUgdGhlIGZvbGxvd2luZyB0aHJlYWQgd2hpY2ggcHJvdmlkZXMg
dGhlIGZpeGVzIGZvciB0aGlzIHBhdGNoOg0KaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFpbC9j
eWd3aW4tcGF0Y2hlcy8yMDI2cTEvMDE0NjQyLmh0bWwNCg0KQmVzdCByZWdhcmRzLA0KSWdvciBQ
b2RnYWlub2k=

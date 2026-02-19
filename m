Return-Path: <SRS0=YdQT=AX=arm.com=Igor.Podgainoi@sourceware.org>
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by sourceware.org (Postfix) with ESMTPS id 9700A4BA23DC
	for <cygwin-patches@cygwin.com>; Thu, 19 Feb 2026 09:18:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9700A4BA23DC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9700A4BA23DC
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1771492687; cv=pass;
	b=bwMcWGfMI/Gzqg3NRXUxxIO3zUUwmklDLw37LmL8fxUfYUoFWXW7Ew4qyKOjeXKhvSw8hOkz04nPOq5sLZbgmW6FZc0mD+5sxvAwEyi5pQT0mTRnRbgzC26iXGjRfJLr+eTueSKI6B1QCOPmC7B06by/OiNP9m56zC8K540umrk=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771492687; c=relaxed/simple;
	bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=td8CA7f1Y3/XLtAK0fQ5pHaafg/MLAAm/5c9q8ZA8xZjhV1x+C0BoGyktPyUefunoSZRhh9Nkbv+o42pL+4wQseIew3OPS8KDWpecdLe3KUf97SDWQhkcv50F2BUVSThm7A6cEmUbAGkctoN0hfdX0gPIgQfIKgsuQkXDqA1ujs=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9700A4BA23DC
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=c6VddQGN;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=c6VddQGN
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=G0Uynx9o/VTIWxTIObxUrye1ngontkjpo/YSyPNhXYZBv9up6DcyHBLgNHCdziDNapNhxZgKkx+fHuBhlIeBUa9qRFCKxKh6Pv8cUg0S2FKrfMB41yIhuUVWqfGjbho/z9Z76c72QQ5OT/q0bHLy3tnlMYko86nlEEwmwx0eLuvrYi1HZL0HUk87g77MmRPgCKcLoLFuHtSFZSTb3ntRz938yrqqcrQHFjyur/n8dN9eiNhYq1zUckIOzLj4cZ1V0trpyR2jgf2z4eAv1v4kCMFRVMLhv8y5n0s5dcmUCb+sGi2qF4WfiU5UN0RL9iQMqx5ttV/aDucgurAHw5aZ+g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=HViy8VEDoV4JVMYnQcX4RfNcdNOSSRAhcodeQvyzg2igKKgmJjR49iA2frY4nw0WlUdqEuG4g0VqBnOnkLXB+c/zFPc1JEsWkWOlfOInxIQ55iSIKdklygF8GC9Jwt58Xn8AdxKI65dVyfZj+CFpatxHjy121D97tGKQuy8slPtJU+59OZG0WKYSoln7Mg3dNfsmx/cwDwWUQUNVVtMvTgEPbuhRPDOJBsXC42kTPuDTFAPw3sdrBM/6FoabJw33nrWzPPUPrNsl63GeZFxkoo43FCZjbc8iLr/O6vogkzV/ELZd0NwIN+0i7VVm0Gi5ASGQTwDoP+QwkPgmIMgLpg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=c6VddQGN7X8EKyqm8jUY9sW45Cm/jSToz0Q3/mRr6TK3ebxUyID9qh8idJuxd94pkQ3UfcNBkRQmTutbAGglVyEjhSGWE1MQgVoWNTn4XF/Q3ysI5YfIxKDTKZflzXgVMv9T52ourmjMHrEkK0Eew1e0RqiQ6eWqrfVPXh2csx4=
Received: from AS4P250CA0030.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::20)
 by AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 09:18:02 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::c9) by AS4P250CA0030.outlook.office365.com
 (2603:10a6:20b:5e3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 09:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 09:18:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unVMPL/y49lnifhB1RKjYqBT7Kf/K9cr+3NdOAkz1oO6mFeohVze+8psu8+dc1yp1zOpm/qSIC6mYTFrR73BkAoTJROzYAgYW9voznaiDeZCgHA9j9+cu2DjL3JHOdP79yDC1fpPLnOTeOX9bMA4f4SO4BsuxmQL7r46PjSJ+Pzs7tK2b+EPbPCYC6qJfDwEw25fFXw9eJZY5cIAFVfi4h+1StqDzv+MD8lP/Jgp9CRiPv4+oJ3Ur08BkcrwtovbixfaQc2b5lUTj0dLLws+3n35KQbnWV7WUc7M8xAqZMszl1MVFEUpSXsyXdQHSkQzvDemd3Q7k5Phed+SW2ydiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=gl3UKU1PpFmInnlZhiEuG4H1pOR6o7rm6U1lK+8G5F068UKorbwkqRMerK33+sUfmQeP/7xsyZPjWzcK1MQR5AMFLh7k8SfP7MEdntw5s+5tf6x2EOaN7YaTQfDU+5Mkao8IhegnlrNYMa27Mpb4JOfmuMkqwXWaSR3OYzlt5W9eHhCLT94DHFrNOYwPQ2l/SPMqImquSSPlR2qH3/cgt6ebKBZRNUXdGYVB1IDoi4cVEiqEgmpKa5OLuh/GUoptASRFJ9aI+GvPR099D41uOqXHuDqmO3LNF5RHP9iaFegU0YJTEUtIYvjrIMsk7NWjWBzNUukpd2CBt4qZUawRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prpo9CYjXuLKoNuEdPKvy7Aex+R0FtKIK/01I1sNk40=;
 b=c6VddQGN7X8EKyqm8jUY9sW45Cm/jSToz0Q3/mRr6TK3ebxUyID9qh8idJuxd94pkQ3UfcNBkRQmTutbAGglVyEjhSGWE1MQgVoWNTn4XF/Q3ysI5YfIxKDTKZflzXgVMv9T52ourmjMHrEkK0Eew1e0RqiQ6eWqrfVPXh2csx4=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by AS8PR08MB6198.eurprd08.prod.outlook.com (2603:10a6:20b:29f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 09:16:57 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 09:16:57 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
CC: Igor Podgainoi <Igor.Podgainoi@arm.com>, "cygwin-patches@cygwin.com"
	<cygwin-patches@cygwin.com>, nd <nd@arm.com>
Subject: Re: [PATCH] Cygwin: gendef: Implement stabilize_sig_stack for aarch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement stabilize_sig_stack for
 aarch64
Thread-Index: AdyNX8A0HheKB0X7Q1WtfnXac/6ehwUILzUA
Date: Thu, 19 Feb 2026 09:16:57 +0000
Message-ID: <aZbVBkzV4powFpAn@arm.com>
References:
 <PN3P287MB3077A9FBEF7358C49A71B1699F95A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3P287MB3077A9FBEF7358C49A71B1699F95A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|AS8PR08MB6198:EE_|AMS0EPF0000019E:EE_|AM9PR08MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f804c7e-9095-46a4-c0a9-08de6f97c786
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?L1NzZ2NzWGRzeFhHSWRkL28yc09sVmRSUysvNzQwbjVyOUYrMGwxRWZya0RH?=
 =?utf-8?B?ZjVJOG95bW1kOWdlVUlFUVdzODd2Szl2enZ4UHlNQWVmR2pVbE42bnBWVEVo?=
 =?utf-8?B?ZU0wakpKYlkzYmxESHZpM3FnTlFDWXRnWU1jVzFqVkJkSDJKMTFYalQrYkRi?=
 =?utf-8?B?bjRtSkQ4L1VMQVVIQ2xVeE5nY3J1WDM5WlZQektjQjYvd3FKWmI1aUJ0Z1Rt?=
 =?utf-8?B?WmQ3WHQzdXVuclJOa2F4bDB1cTdKQmpoTUhLU2NWY2t5aGJKN2R4UjVFNElS?=
 =?utf-8?B?VmZHUXZ4VDJjUXNaQWFuL2Ztck1yN1VvVnI3Q3NCVHZaUHVFRms4VVF2SHdG?=
 =?utf-8?B?TkpMakw1YXk3WGFsaEFzZDZCWGdMYlVZSXNvQkdxbVZFc2UvaFV2V1c4UTRN?=
 =?utf-8?B?QWFGcVV3c0wwaVhFT3hRbWRJcTN4TCtmdmNLUmNwdWFJTlJCS0tvWEc5NmZU?=
 =?utf-8?B?cnZTYy9BcGlsVG1kSEp5NGIxajZmWWlVTzAxTUpiazRNNWpKTnpSSjdlclls?=
 =?utf-8?B?ejA5Z21nc01vckhwZ21vR1lQUVlWMDZqTFRwU0FCMlp1Mm5UZmVFR3ltYTlW?=
 =?utf-8?B?VmRDOFV6ZGVRQ1BZNGZodDE3b0M2WnRlVThzVkpxMmhrRE83VUx0dTBNVjF0?=
 =?utf-8?B?UlZmUlVYb3kxajk5WHhqM091ajFZRjhQTDBpUzhtd0xQaER2VE4rMVdVbjZm?=
 =?utf-8?B?RThacWtHaG0rKzQyWTQ5ZVY5c2ZyenliMDdGSE0zSHZnOXVQRXIwTG9NYU9G?=
 =?utf-8?B?RGNkdmxsL0xIVjFhb2UyY3E3blkvNWpwRElaT3cwQUxGeXZSUnFUd0MrNkFp?=
 =?utf-8?B?dFdVbll5UzVYY09vbGp2QzR1NUg0UVh5akpXcFRKOG5hdlhDdWYvaEdBUm9X?=
 =?utf-8?B?S01JUDdrTTFWY2RkdTB3c3dsTWptNGtlNDNRUVVOem5MU3YzVG1uWDZCSnNQ?=
 =?utf-8?B?SGg1dXpKSElJbEw4eURQMk1MK2hiV0h0blFYdC84V2tETUZ3WVlCRmxXQVJv?=
 =?utf-8?B?VnlEY1NKR2ZLV2ZxU203QWFTSkxlRTh1WFZid1NFVkljd1lvTFdZaEdmRmU4?=
 =?utf-8?B?YzRlc2ZuVU1tNFhBZnpUR2JZb1pKMlphWHN4R3BSU1RIOXduU3NBNzJwSDVK?=
 =?utf-8?B?WUtTWGQ4U2RqaEw3dFRkZmFnam12d0wzSFlTcGVQVWZMQjYxM2tQR0E3VXR3?=
 =?utf-8?B?dE1TTi9DREZ6emtrc05zTkpTWGFQeWFnQ2VHL2ZIVG9xaG1TS1MvaXI2RVlH?=
 =?utf-8?B?QUsyOGd2MUNuNFdRY2Ixelh6TVZrVnF6Z3J2dHhSYzFMUmZlcHhrSXFJZXVJ?=
 =?utf-8?B?S1NkTFdYOHo4T1UzY1dRN003d3B4blpsLy82RHhqL3l2cWZzR054UFQ2dWIr?=
 =?utf-8?B?WEJYWkxFU3NGZlZzUFpLWXM0NWJKdlRmMXU4aFlSVUNrRW90ZUw5cDkrc2pE?=
 =?utf-8?B?dEhvMm0xalgxLzEyQkhETWRxalZpV09EZ21NcmY2VHd6YmJZc0p5RHZRSWZP?=
 =?utf-8?B?ampiY01KbTkxK2M0djZxN0hSYnZzMStpOWRiMnVRbzdWeDFFeTFLaUh5WllU?=
 =?utf-8?B?VHVVUzdHOWt1eDVDMUVLbTZoZmdScVRxZnpmZmRnQjV1SVVTQ1N3RFBEc2lE?=
 =?utf-8?B?YkU5SXZoNjljZkswTThzMHA1a3ZHYUx6RlpjV3JoQmhxVVFZeU85bmxGTHoz?=
 =?utf-8?B?NlJSRVFMc1VocS91cytuUDBIZWZjRHM4NUVBUk5KRXQreXZvd044QUoxM3p6?=
 =?utf-8?B?VG5yaG9ycHlFNEFvK3ZRaTQvV2ZoazRpMkN2aWJuUWpNcUJqQ3p4ckprV0w2?=
 =?utf-8?B?d2ROUHpoV0ppZFFGcVdkbWxLS3NCOUNpWjJSa3NUUVFFNzgweFFMNTNxYUpL?=
 =?utf-8?B?RW45aGlJTXB6Q2wrUEVqajF5Wlo2R0xvdHBRQW1yNTdpNmVHZy9XV3A2QWhE?=
 =?utf-8?B?b0hidWIybXlyM3hLZjZaL0ZXdmdMaVJsdzExQ2EwczROLzJuRXRPSFowSGFX?=
 =?utf-8?B?UlJMbWVSMkRScTBaNkVKKzZjdEdZTUowK29NbWJWZ3pzS05vNlFwdjNmdHYv?=
 =?utf-8?B?V0Q5SDdYcUd1WEF4LzNJZUozTHlKSjQzT2hZbmFRVmFtQzlROTAvQXk1dXRi?=
 =?utf-8?B?dzd4eDFCQjV2Z0hBM3JET3NZNjBoSUFBbnlmWUxnZ2NQYjArOUx4Mml6ZjRE?=
 =?utf-8?Q?rUUOTJy5ykG4EZ1aRD21gYE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <39578134104D3B48B8906FC0F7A4992C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6198
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6b366f81-22fc-495f-ee37-08de6f97a176
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzB3cVpKQ3RnWFQ2YmRvTnIvL0hMdU90dVhJZzY3OFg4UFo4emtFRzRwa1NB?=
 =?utf-8?B?T1VsbHBlZm9KL1d5Q20zZjd1Zi9ZTHJyWHdNOGxTSjV0RVpiN3RyNzFvaWZL?=
 =?utf-8?B?emRzQklsOU81Y0lOZWdJTk5IeE9VUmpMcmRoZFBCUnBXbzRpbUNOQ1l4M2xU?=
 =?utf-8?B?UWM3VXVjSVpydWFSMXJFTHJ6aWo3K21hc01pSlcvMGF6c3MrNVlPMkU2M3NQ?=
 =?utf-8?B?ZXZheWV6dGFMWmU4STZmcy9WZmlma2gyNWM3MlRONkVSV3VxVkdrNFlkQzMy?=
 =?utf-8?B?TVdSSG1hZU9zaUNMZkFKTXRtdit2VmNiTVJxaHZaT0wwWUFETmdEUGgzSXFV?=
 =?utf-8?B?MXNJRE5WMlFBTHVqNWVqdFhEOGd1M2ZWTVNUd3NOUWl3RTJZQkZoSDluTXZ6?=
 =?utf-8?B?UU5BaTY4N1lpb2NZRWY4eUdxZTJUUGh3OTk2cVJLSW84Nmt2K0hpUFVIZlUr?=
 =?utf-8?B?L0FacnVrcm0wZDFLdUV3S25aQXo2RVZ4N1ZQV2VaMTNwdEVVdFdYUmxqb1dM?=
 =?utf-8?B?QlUzQlFHbHZtOERqM3ZmVzl0anB5QUJrcWdVQlM3aHl4c2xxaG5zcStLTWJz?=
 =?utf-8?B?V1NnQWNxd3NNWG83NzlaUzFWSGVMa2xDQnYyVXkrQUp1dm9IUmR6ZHN2b0hP?=
 =?utf-8?B?b1R0MktQVmd2ZkRKMUxVNGhIbnVwZ1JBbVN3VENQdkpvQ3BaVVNyR1ZIZzBI?=
 =?utf-8?B?UFdtbGljVVIwVWc5OXowTzdOeElOeS9IVlg5c203YlEzSUxWYkdUMkZqVDQw?=
 =?utf-8?B?Y1hVTVNkenBqZTRjbkhHV091R2Q4QTRhY2E2MndnWmJxcyt4TVRBRkUrVUFo?=
 =?utf-8?B?OTMrR21MK0htejk5bmJkVy84QVNRMlNjOG9KYTVwZmxPN1hxcDM5Z0JhQWp2?=
 =?utf-8?B?MzNxaUd4ZHBDbUduR1RxZnlydFU2TGUzcXZQSlBuaHh0VVYxTkd2VWZLdU1j?=
 =?utf-8?B?V3g1Vm1haTZiSFRTYllraCsxN2cvRnVXcDZCVVdyWDVWeG9yN1BXQk5sblVz?=
 =?utf-8?B?RGFQWkdqNkZUYjUxMUJSYThLbjdUM2xpazZJdGMyVjZlbDJVUXgwQUJmaXFu?=
 =?utf-8?B?cHp3K2U2WnlLM1BrcE01QlpzTjcrTkErNlRETDZ1WUFaa3pjU0ZFZnFOT25U?=
 =?utf-8?B?TmxoSzJKNEZsNHVEWE9iYnpZVXNXemxVa3d4K1JvSjFNa09FMlVYQ3dPclRt?=
 =?utf-8?B?SGdKYlVKQ1JHWG1XMXVpeWZCL2hxTlRGQ0lWN01tNDM4Y2Y2Mm1oZWFqb3ZB?=
 =?utf-8?B?V254amFrdmVFeEtBTEJmSVdVSkhPb3V3SWpjR1VzS0owNlVsdTF4K1hWd3hX?=
 =?utf-8?B?ZnZsQy9yN1VxUHAwL3FhYWFYaUJBTlVtYS93bWZ6NUxxN1pJd3dWcUJpdjIv?=
 =?utf-8?B?eWFQSWpnbFhCamhFNnJNWE1uT041TWdIMnVrWklRY1E2c2FRb0NRSXNvNXJB?=
 =?utf-8?B?SXpSc1g1ano2dHh0Vmh0eitVSCtoNVdYR0tGOHdNcGZjS0JDK3UxN1lXa0JP?=
 =?utf-8?B?YzduakdkNDlzaHZBYjhOazFGaEowenFyNDNkU1p5dlNPQTEvOVVPMSszYzY0?=
 =?utf-8?B?N1NBWnBhWFZEeGlrVEVENFNDSmVkYlp2b1pZSEYxTVlrUGtaV2hFVjlleXAx?=
 =?utf-8?B?Z1dxOCs4MFp6OFlPN1pRa3ZrRTRXRTR5d1pZNkwyVlhjTUZJUE1WNjQ2M1ZU?=
 =?utf-8?B?RFFwbXpmSFpHQ0RKNytKWHpHdjNzNUpxWkIzSnd5ZjNXd21jNlBpaFVZcUEx?=
 =?utf-8?B?WFEvLytMQ3JZYnNNNm1wNVFVejU0Y0Y3NmJGNVBsb0RxRGFHa0VlQVFZcTQ3?=
 =?utf-8?B?YllHT25ucXRaU3Y4UnlFUFhzcmFtUGdicnVqWE9iWEQ5d293aVNObFRiemVo?=
 =?utf-8?B?YXRsTXFibG5iT0RtTkREdTA4QitCWUlFOHdIWXYrL2l1dmc4dVNHcGsvbTUx?=
 =?utf-8?B?VmJjM08xWEl4d3VGWHNBR3pPOE4vdFo5elpMRGs0VnJOQVo5R0ZtdlhzYWxR?=
 =?utf-8?B?dnlXdWNOZkV2cW1rdk9rZERRT1VvS1JVaGpnYkU3SnhTTEhCMytWVUMvMG05?=
 =?utf-8?B?SUtMVGxITnV5UC9sbXY5bHBKaFk2SCtaS0daaUYzQkhUaVA1QlQ3K2V0WDBR?=
 =?utf-8?B?Q2pRWnNsdWNWOEZQY1ZSSlpCREQwSXdDRktzVEhKSmVxeU5CcTlQSktHWVdk?=
 =?utf-8?B?RkZtcVRJRmpONlJvY2pQU1A5SnAyblpqVDNmSXhFSlk3NXdvYzc0bGt1MXg2?=
 =?utf-8?B?VkdiRDJHMURTd0FWcHIvQzAvTVdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W6u0HSr4w9RY7tIaW1StitRrRp+XZMLXLmtCAhK7WxQq/2vYdXLLHp0F7LFTCTGESgQ27D5o/VIKqS+hugEjRvv+7z/i/GRyUeLF3/Sx+tMIKuRVcwBcv/MQcBWiYoeAPtEdkQswxFREPKLVI8gBfqGAfDtvk/57JCd3a6zk99s8b/byWMwjJz11ETA8uomkG9NgZIgRLoT9pl/EZcxuATHBVT4/UaTcQRJQoaP7xH1DOIQpBPnxUpinpi8pPCjK+biFF3NLudJXd7HpGOYkAr60RmkWTSCDlWtyneWZ9gR7gVqijsbYs/KkVkAP9e+PGTzDzUsV5DJxFQ+dVYBpAlA1Z+Q/sfP36KdoWHvfujWbn8+L9RLQFjTmBuuAfCD0/s4uFTe01Rh7ier94IeymYhJFOWxf5VnJagM7Gv4Yat+w5bYeCOoQcYaTOs4Da4M
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:18:01.1160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f804c7e-9095-46a4-c0a9-08de6f97c786
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5892
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGVsbG8sDQoNClBsZWFzZSBzZWUgdGhlIGZvbGxvd2luZyB0aHJlYWQgd2hpY2ggcHJvdmlkZXMg
dGhlIGZpeGVzIGZvciB0aGlzIHBhdGNoOg0KaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFpbC9j
eWd3aW4tcGF0Y2hlcy8yMDI2cTEvMDE0NjQyLmh0bWwNCg0KQmVzdCByZWdhcmRzLA0KSWdvciBQ
b2RnYWlub2k=

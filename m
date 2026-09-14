Return-Path: <SRS0=GwCJ=HG=arm.com=Mate.Dimand@sourceware.org>
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	by sourceware.org (Postfix) with ESMTPS id D31194BA2E0A
	for <cygwin-patches@cygwin.com>; Mon, 14 Sep 2026 07:03:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D31194BA2E0A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D31194BA2E0A
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c207::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1789369398; cv=pass;
	b=hOZZJpe1frqwRI92ewPTf7Rt1++6j26TmPrQi/xpBIIlAdvn1Zge8V1GsWxxYMkDrdP7A7j9se7U+M1nFVKKOLtWyte0R2/CiKMFApdMNMYvv3q2RO5Iiifr/mSq2OmvTDFDFuTe8U5tQWSc9ydiyNOKMnoLDTatuIGTS4iLWj8=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789369398; c=relaxed/simple;
	bh=YmUAtqNTQ1uUtL4pw4qCUfvOOZKSKKqz2Q1E5qvFcyY=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:Subject:From:To:
	 MIME-Version; b=bAxu5ffOzBxlyMUhTx5xZfJ9pzwUKy6OHaBAqo234l8/xfvfQ+dLLsqiYL1f4mT//vz6xUJT6IvP418L0iilVZEVb6S5arOVxqqu/wbRHcWvvLRMMzfbbiZp4L2s2GnYOfwOA1LIOu24XIY5cZeg/0b0RopteImFcai/LuMZJ6M=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qTQ7cScf; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qTQ7cScf
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D31194BA2E0A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qTQ7cScf;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qTQ7cScf
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PUhhEWb9t0RAvSfgjYHVd9ZU2pYFPlx3tSFqyM18i8U/Vo0Hks4zQDDd5WJt24utwGWF2sgXLla8AimjJ+5DwHShGslVS9tJLRxzBTT5Raea97AFXlkytQm7pKxkzNehiFICTh4tdb5MyAWHXAmH/YWH4rVyC0D2z0MuxoNWUNeeHBKpVj5Dxas7YYo6QVtiTbtv0uJkBKvtPc+sUllS1gEK9St5eJV4Wm0+maQxqp9RcFdmGaIlQmvV71kTjG6i/bmM/GJ59QlilPk14n1DqZK3LUZycXx1WOdtzTFLeVUf+L4cplLXhoztZTlifEY2In7yQU3QQPVM6gJ5wqhgVw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYdzbTfZmq/hPF8c5xutwqVVXUYSh+UZ6Pbx9lYQBlM=;
 b=e+k7sWlE+nLAeNYMvnbVtKbOk+4ByGLAg0rSI5HKa+t2SYVRXmGF0CkEvFYUh66nnJpEY56jhrli/QNp0A+580/7BF5+56FKrmTGRbr2GpT94nMBAtKhH5Ui0+SPSnWyj8feBzpatekh2m3lAzJlliqjLvCmms7I4f8AsbA4/TWX3JqNjYNCGck6908EIu3rNi+y4TGc8zci7+e257DcQy2IRHp95SLZhO8JPdLaS655rU6udsCQNopeukVZgPEkt/Vqj0dQ2T1WkVVI+u5EO1HjEbho9bu0Wga5HBbbtpqjVCgcjRJfw7Hd53LPeYYKTCAShuVFpx2zQ2H1mv2w8A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYdzbTfZmq/hPF8c5xutwqVVXUYSh+UZ6Pbx9lYQBlM=;
 b=qTQ7cScfqBWRHJJubrDGd7ddsTKJko4Hg6N7h7Wm0187q/gIuVDHemgx2E32+M345xiwootx2wRnk8VBVEY71HUFvNQ8YgKogrRLWGKJOEFYo/lO2jNOzdHjWpIlc8SAaQbzYRVjGve0+xz6pbyxi6Oz6BYMt/TFplj4wzTAz0M=
Received: from AS4P251CA0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::19)
 by DB9PR08MB9492.eurprd08.prod.outlook.com (2603:10a6:10:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Mon, 14 Sep
 2026 07:03:13 +0000
Received: from AMS1EPF00000097.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::65) by AS4P251CA0001.outlook.office365.com
 (2603:10a6:20b:5d2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 07:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000097.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Mon, 14 Sep 2026 07:03:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWnhZi4hRBdI4qDQ8zTZ13dxRl0Mu1jSgyzQ5/BBXYmhwX9N4GcSOB1mCXa0nXEK4vYcsWF87/uyW/SVc37KyBrRfuEMEOlISWWZZJWCXTu8hPYcKBHnhYFRS29psXVLnEDb7T8BbojJUkZpO2m+YU9DkkVqZOPBJAvEHti9MbwzgLemr9ebnc6Fj+FSPoHbBT0JKHzl1U2GgahHjByadNtnSoE09aubn6+CaBsh4ABwajbyLB8IMK2hV4GupoentT4vQEMBHHFJ/n9xgROWttVadyT3HcrGTtZphCulpAO5l1p2rMtgLF8PurHxyrmrbDPPKc9NrvLCv2wAC+7Jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYdzbTfZmq/hPF8c5xutwqVVXUYSh+UZ6Pbx9lYQBlM=;
 b=h2j9LeWGqOKKnCyT/Vnf4Y9H3CeqrhWrgAXxTyULr3xPt6tlZ+Ae6DMZhZ8NO55LatZ9CQs4T3QaC9t3IC8dCGotJiXEL9PXprnBDz+D6SUWJEPq+M+5/FfWw4jaldE+YFZsUm/KZ8CPc29XZuIGmOssYSPt9Hq/ChcBNP3/mVtyOUJ4RCEJPy4+7Gmr9QxsY05isg5K4+2bSsSlFiuLy98mP+INPkL0gOqur1VvDmO4HRHJ1RyjByUe0HiYpHA9SDIF2JIkF3FZ04CglPyKjRPC33poz9RmVQr1CpkPZJ9FRAyeeqKyRow9d/wxOnzN1dLG467VtTP6g2XwD3MpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYdzbTfZmq/hPF8c5xutwqVVXUYSh+UZ6Pbx9lYQBlM=;
 b=qTQ7cScfqBWRHJJubrDGd7ddsTKJko4Hg6N7h7Wm0187q/gIuVDHemgx2E32+M345xiwootx2wRnk8VBVEY71HUFvNQ8YgKogrRLWGKJOEFYo/lO2jNOzdHjWpIlc8SAaQbzYRVjGve0+xz6pbyxi6Oz6BYMt/TFplj4wzTAz0M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22)
 by GVXPR08MB10864.eurprd08.prod.outlook.com (2603:10a6:150:154::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Mon, 14 Sep
 2026 07:02:31 +0000
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576]) by DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576%7]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 07:02:31 +0000
Message-ID: <80308c9d-127d-4f12-bf91-aac8e3124cc7@arm.com>
Date: Mon, 14 Sep 2026 09:02:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: gendef: fixed AArch64 setjmp storing incorrect
 frame pointer in jmpbuf
From: =?UTF-8?B?TcOhdMOpIERpbWFuZA==?= <mate.dimand@arm.com>
To: cygwin-patches@cygwin.com
Cc: nd@arm.com
References: <4635aed1-eceb-4540-9071-2a4cd257b27c@arm.com>
Content-Language: en-US
In-Reply-To: <4635aed1-eceb-4540-9071-2a4cd257b27c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0189.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::14) To DB4PR08MB9310.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR08MB9310:EE_|GVXPR08MB10864:EE_|AMS1EPF00000097:EE_|DB9PR08MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d86a21-c9d5-4159-c501-08df122e3e28
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 E6JCciiggH2eZz+bI2srPyTre1EJ61torhQazlpd4FPI3AsxLRRMVhuzcBt+p2rlTbpoV7XtectLYVxfrDf94OVynU9M56uaRK/8Y4jjJ2vwG4YURHQLXBEMKPM6tF/9qtFcaoHNlW2nvZbJcdu+Whx80B7HdhH5e7YQjL9+oJ3KpC/Kn7yjnMMuGX/lmya6TUij3+yedq/wv0xKWM3QXpUMJ+jhGHUK2pVAgljccYeRdPQQ0n9eMxhRtozPsv+8jE8J6pbg9pgxGVp3WNIKSjrlMPkoMcLC7BT66cmiCka18Lev/JCdPLYij9IjS2Q53b0F1zGywjGuug/mCgCHuR7oR+zqmtU7NtyMbThCtSK2w5xLEZX0s2w5KwVA6KwHazNuhP4zyEVLomajjJigyWF8FYphBqD9XrovznIi44kvzb1YsEdXKWG86BRGKiXLm7WDgUZoOH8hfOW3MhbcePDFvefKyo8oQ062YRHU/IHZnyuPjBPdPLn+Dp9lM5npUuJ1voaQWCthfVAONPVyqJaRC+PpD8kkLMnQa+Dde0NIut8acXUR+VLFGyPdbYuj9QQ0sIKSmvTM0j/zSBoDkmyM6ssqpTNnZRi/mdIbJIZJXxXpbG5b0fZi6xCsUw3as4HmycNJwhQW1WInQ9qOZvMOT7WcVk0JvDoZ4vEqn30=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9310.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 EUIR7gpNiWbanep1b66iPE3xE0Iet7OUwNq6BK4n29aPzDKFFQqkyK9y6otdFUT4tw+Tyor33l1hAveteHGexL2YYhnjpyLMVmBzVVi/QroQxegyEKgeiv5Pi1NcAhXrAaqLgLwikSI/sa03er9Is+7b5oj/TaPz7SnRavMztMgEXuG8WoPHIZYp4Z7MuSzCplCkrK+DExlmHccs34qJOoPf/v9PfpDUAtqvZDbzFkQMuLLne3tEgF8H1TlfAGQc3fL+WpHDOCg4/J5DzL+Sio0Xo42WprwVIG5F63fe1i1EtBwyheoCUmCAmbPffU2z1Y4wutqkogEO8M1wDhUEXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10864
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000097.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c423337e-02b3-4d4d-adc2-08df122e2521
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|23010399003|82310400026|36860700016|1800799024|14060799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cVi8kXQvuBK0qarwhKjkRMvsz7CoMmzYE3Dh6wJ9XTTGyUOXuu62aMywBZJ3n+PSGSgtAhXaV7myqaiWDaJuWkRx1vLN3XCcdAgOZwVkS8a+5NvoamZmGpIyBXQ2b+qlvT8AHR2n4jSUGzUsjb5COCJoVHyzKFthQAa/tZyM5OAP98YIaPOH2FFizekddYtiKwvufooyaTYhoqA0EPaxDKJe6S8HWducGAOVo+9ehXSgktfqAeE6tDG10qjD2OjiSyojrrtIA+HuRP0Rg36xsaOWGvZzV3QUpnMNZBFWSq9N+3Ok7bCI1EVHF+eq/L4Ui27laDKvFBhHA8xNI9JFNkjgUkbDs1Hhy8ek1ec8aa4lFqKvIPxxjJifzpMeIv8olFIj/UXJgJqhGMfco36SENa2sIeUtERkDyFRcDgQ8om91584tDuK6vEq75grCTv4PeHUhhYceNjQ0wd6Mc39OFwbXuDCaGAeJBtG69YOwHwAYTl7Kw/ti51/kL9MEHe5CZ0vIyU33qHnJmTLEvkJL1xhJBeWdsErtoFE5eQMMFXV+B1dBEZA3jrKGwmWV2uGd96achRhckAaEoCo3msz0DwrkE7b0hRoGoc7GzAjV2uguUeQizf8o6/otTalumMgR9mxJjusdwgXpQBKx+iIwW69JpCTPkrMNakZz51CEGpzIfhxhMYxbEgTJMXEkuIXAAkPX2LtZQSBIMV4m6hGUA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(14060799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zctZGxobakwezbEReOaruGTzSuOQssyFcXHYJ66nt8rOR8X0tha8XQTPsyCOKEU7zj06aE5TPcPKcd1J2jbWmdd7jIdtXsrYL2qfc7vaVnN1tBxsnWG9dMzwX6gbMo7/Skw1c6jiZzViYWLW88ucNw2Vo+v37q/hdgVpfcukciyydulIt8FFRNjC/78uJryUb++1NGEO9WFO7u73XqiQSWDpU42hcrWV/Lv8T7udYUyFZ2T/HX6vz5Gcrr123oITPIs03Q3ihmoBoUKmNfKSfPH1C0JoF48BKDRHEiT0/bycKynPHWLryJjEKFmLmaIiqa4wMLGof8q300B4GNue7hpSbUE6WFOEB+UXXEdtfLJWPDhbHzCvzwPrzJFRLni3EGPQvyb/3/DFZmQJM0EYPEpF44z7WRpGzTUQ/aO/0tSDbDn2yUkTNmGsYepXMo3O
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 07:03:13.0245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d86a21-c9d5-4159-c501-08df122e3e28
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000097.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9492
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi everyone,

Just a gentle ping on this patch, any thoughts or feedback would be 
appreciated. Thanks!

Best regards,
Máté Dimand


Return-Path: <SRS0=7IrX=E5=arm.com=Mate.Dimand@sourceware.org>
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	by sourceware.org (Postfix) with ESMTPS id EDFC34BA23DB
	for <cygwin-patches@cygwin.com>; Fri,  3 Jul 2026 09:26:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EDFC34BA23DB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EDFC34BA23DB
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::1
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1783070779; cv=pass;
	b=cZHp8DU4SHiwhslMB5xIRf5xihwe4hkwnW+r5Vq+sq85+bQmkc7xDloSXNm3fI7yPVa7J10kIvdG3bDIgPj9E1moVNA13J08+s51UvKzWRh3AcnhG+s/CsM1fX1pzUYtQuWDMVYkJ05a/KygGvx9+3dtS64gR+QZIfcGDrtrrbw=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783070779; c=relaxed/simple;
	bh=MXZt5I6OHtVktYikBTtBLWp4l8jAOHqy0dPvfuDymTs=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:Subject:To:From:
	 MIME-Version; b=amQeoXD9HtyFAo/ErouBLk5rPdQHGOF65ikfVjWRKdV0bYOEuvj7g/fAFdK56jc9BRs5Swl2lqrWpggGC8Z4iuTZryn1r2GMGlWmmFiVV2AwibFY+xdIvLq8EqU7yHXEtracUUlvqFib/A9LZ+Nw+jyXvxVBTiRX8xnVvHnMHQY=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Eh70hwNs; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Eh70hwNs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EDFC34BA23DB
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Eh70hwNs;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Eh70hwNs
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nJrgPRE+4FZycHUMNBy1CFRNIiUQAMjfn3pWMXPplbQ+3Dp8yvant9n+anZeYzjNS67s4yRO8HFBC8KmhKtHKguJdFvriguaDDNQUHFjcYkjFnxVq4ZqrVaj3SJFCN2yfQK1gCjLKzk+yWbprdAU6ar05TglMrF1+giD7IAkX/D8ZcgXuKxTlZcU8aKA/GbNlE+MbGXE0SvC6MCNIXIFddfu20FrsPbTWqF9rZYiz0480XcH6wT62yZ1ofpXg0IwTDHm6h6ZNSME00bTMYXdhlDlc4v2ZNCYWDizBeX6D5kGKoN8K9+YwuubdVfRyArXFVWqTPiMQYEkfHybJ6LzcQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub3S2UtPx14U6Ee8lTdZvUVZMn2N4DDE4JNhJr4fvgc=;
 b=TkGGZ/NHRFBX/dxEhWqp8Lg0Kr85wfvd7VejBnmclAhCHAggvIX9GnMbe1mlRu17NQpNJMKsbLNgMRKGffnXl5xdSy8uI48PraH+QKAUQT4sj9MvBoWwaahDRkxw4FWnXnLUpJaalYQsRrS7TTHsVqwN0TEsJvjonO0fgWv39/eIzYxsKtOMFgEeJVWC7cd6q5h2mMLD73i6NorqQiMVyB69tI8qehNdPfUVMFcxLGm4Lr7mXHTB7aUjxcwTssVTxyosM40lw5aZ+6XhqwS9Cyviywm2QzIkyVVRpRrMlN+1AK9e4htDS1ihRXPCNW0vh3Fl4pOmL6QorZMrp0VaXw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=dronecode.org.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub3S2UtPx14U6Ee8lTdZvUVZMn2N4DDE4JNhJr4fvgc=;
 b=Eh70hwNsAG2p/9i1kzVH3xR6Wm5NRpX8sjy9ncV4nIEh+M4XlGGzDu6AN6qydyO8svHlSfEoXqHNAKc6W4ypBKSQWo2MxGAmFsWLrz2MN8XoLqqNZunuTZOLHKggzuiF4Oc7MdF8G/1H+NkCyhdfZbOmlNanw4JSATxJkfBtWdQ=
Received: from DUZPR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::17) by AMBPR08MB11590.eurprd08.prod.outlook.com
 (2603:10a6:20b:6ef::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 09:26:13 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::60) by DUZPR01CA0048.outlook.office365.com
 (2603:10a6:10:469::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 09:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 3 Jul 2026 09:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tw3bU0/CK/ZiKShZZK8pLR0V1mAAAhNr9Qb2kG8Z6TKVjpQkRS7pCW/1dGIYuQKy7mBYqxXYKeRzijLaMks1IlxXr44+Hg3DGuAh6sU/uVkY02rrkgd+lWWLYwIv5LjC+qUtmcqPwMs9HrpfaYoR9AjqIu5pBplmPNL4vHg7WNrcfcWElRQwX8Vtq99p8mOle3ZJMH6LqZ8t9u499jCynY0H788p5yvlwK1gHLdhvpfAEs+GpjdcWr/pf/JiBxw8G46I0Xmqbwq0w36fyfL588HHCgZSHg3GZxl0I/PWS4jk3cLs4yMVVaoCtXZElS4TX4SEhzZDduuobdn+eajRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub3S2UtPx14U6Ee8lTdZvUVZMn2N4DDE4JNhJr4fvgc=;
 b=HzC3JMEAeHG/27qZA+gQevZHknn+pNGJXsI113iS1voESKgxWO8MRLVZHYagSREkVeJ4a8JV7i9E/Kd5aY/jCaE4GlKe2YG0MiCIQ7wXNpEfu0HuxSY223BWMbNUjiKgcmD2pili1/2dcowvDJaTRD6hwePYNfy/cO0//DDekJyzSpeTLkT3uzuG3w0xa+C4wKnrgBGu1ZCigsh9xl7pDTlWSNzfuhbqea0H+KWybl8fKz/Q8yxPA6lH4YYdB4BMefC7bHHwb2k0amSteYvkp66XB6EYRt+DUh5fJkZWSDexkeHm7Sfl079LQM7aiwzPv81CfSgCJo1kmt0rWkix9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub3S2UtPx14U6Ee8lTdZvUVZMn2N4DDE4JNhJr4fvgc=;
 b=Eh70hwNsAG2p/9i1kzVH3xR6Wm5NRpX8sjy9ncV4nIEh+M4XlGGzDu6AN6qydyO8svHlSfEoXqHNAKc6W4ypBKSQWo2MxGAmFsWLrz2MN8XoLqqNZunuTZOLHKggzuiF4Oc7MdF8G/1H+NkCyhdfZbOmlNanw4JSATxJkfBtWdQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22)
 by DB9PR08MB7746.eurprd08.prod.outlook.com (2603:10a6:10:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:25:09 +0000
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576]) by DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:25:09 +0000
Message-ID: <2aa3bd4e-2a1e-4511-b90d-1263879fdc28@arm.com>
Date: Fri, 3 Jul 2026 11:25:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: exceptions: Fix AArch64 non-incyg signal handling
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com, nd@arm.com
References: <d8339a03-a0d3-4b0c-bb10-f706fcc6da49@arm.com>
 <054a3964-a4db-4add-9531-4b899e356f4b@dronecode.org.uk>
Content-Language: en-US
From: =?UTF-8?Q?M=C3=A1te_Dimand?= <mate.dimand@arm.com>
In-Reply-To: <054a3964-a4db-4add-9531-4b899e356f4b@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0031.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::18) To DB4PR08MB9310.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR08MB9310:EE_|DB9PR08MB7746:EE_|DU2PEPF00028D04:EE_|AMBPR08MB11590:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad0294b-f8a5-4095-73c0-08ded8e51fda
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|5023799004|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 9+ogh7j9G9y+ZVrZ3knyMvOhrPTi6QHLWedvFY68jRaforYJkEGPoJpGBvAoBR8J0ps+1YZGrOl5MkKNi9KZwppOwY7bGF898wO8DN6tP0Md7hrtbZzmyWE+CIB023Geh9vTG9SIQRF2aORwNVPanmtUxR/fr5mAaMmxQPOBeikMihkdtCl2xkUtcvS7JUGOXrp+YnkMxUI34GJMZZxJmyEa9PZQHu3Jaqf/l56hbwkxJz/xwOLb75XLMqjG+HDV3Xm/qkLi+DxqaJxQlgh8EztcnTwAoumrIDS79fP3jQb3BL433KDHIKSzQ/IPAIl8F7ZzTa2jHkbvdsjw4YSHghsnP/u35hWR/A6BRKFC7fAa9OSilh89NY40X4IbTCpmrLHcIverzNC3X1VPGBI1M2qafKCXEB7nxMi4m7qohqZuoLiAR/XNaZc0oA+3ETUu6RcA5NKKbLLOcuKdcGrmXLF6bPKBDqEX5Q2nMvwccABn507JkDfgatmrFeZAk2qqudU4h1TveccO1869oNdpbz94ZoSIuuOTFd08u3RIZU2KVZQR1SsUR6n56zS7TCEmfv/tag4Nq+N3cCNREyQdWF0kd6o9tJt0Hhu9XSTOFuqv9unsCIF8c6+Rje64Ngf8EtmCNdJDicu7lnVaGWsXDGPsY63hbu1ZrZY+FFFWQAM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9310.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 B02+zC8OADi4imsSDSu1FOkMjuYKJsFrmwQKpvpwbYqaBUg+E6zywbhLxo37DNe/FxPsQ+1OjGk+9sfwsrGDLNZKIIrgEgJBOWQrQnV2+RxUM5BG4g57Jr5SFTt048autCOVutRBBR6dT08yPa7VfIk9gmaKFNbx/lvMHoysrh3bxDhw6WXir65Q0+YbpAoiPwmpboyCNy5g6AsvW30o9s8YQFqIY+MDZDCL/RQolNRuVqJ23Gf8QvQGVa7S9qI2c4CHOizmKDfcu3hCZlc31a7OoyAkCsVnM2/Yi/NZ2TSrDLz1UJjrl/OIpqPBFF424/BOQ8kf9CIqLcEeY8Jubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7746
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8a8cc522-a38c-48dc-91f2-08ded8e4f9c2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|14060799003|82310400026|35042699022|1800799024|36860700016|376014|18002099003|22082099003|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	FaFMnHRwwEs9a895EgsN/VTbiFtRM09h+rfYhEXxplXgu9OhIaIoZOduG7zOJIoD4iIrUzm3uhMI9uhXNA81h0iCnoEod6WGd/Fpo/UWXxTfbF6AcoUwllzz8UbAsFZpDL/BOB1HL1Cus263eZ7MB6GTIqAcolYsy9UX+0r9hVGEXBTxueNdo3Yhwc9E9pphU97SM2+rs4kMWGXeaOw73qeBpzISPeH5n/zo26vs4klyK185q0tjk+DJY3eS8SNrYgIj71vY2ozr1ZA3+3RjnzrGP5Sce1c15kj+sucZdQ3D7ABmk18SUiZkS/gNn58blGvibO9g7OYgLCuSFEup7jSdfrtJWPmH7A8vOP4Amx7yepN/+Wz90mhywMSwC6eExHSIBS+PDQO7CUpNgGx6+PviuV2dmZe9pTsnxvx136VrsZOpj3rrtGfT8Sg4AFKq3GU+kfV6Kr9v2WMf0lzjGXhLBiECRdrmc2WdyGHdagIbICPs/THQkyfHI6Cr85w0TQ4UmgMFFFyM3NYvj+S3JWYIqtKVfSdyjS1ab/KjWJM3pI13zp9y08fUZz8BcLm1HbhuaUpkynrbeeEQABAVQNx+MDWnkG/EIhEvlDXR+M1iKlRKRE4tbEXPvPOYxt8t1HsXepP/HA4Y8pVqDRI6/b6ip/ZALD5/gPgPAlCe4Fv8CPMAj4dtuEmFNWGQf341PHV75n8xLCGLs1gfEZXEqQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(14060799003)(82310400026)(35042699022)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u/fi7SxiRUHoPw7LZQikU5OLCRetanJD1Q74ghKwaWrYzSrRlc6B5pix146NEGihBPHjNYLLdyMJRo0OUtZjgajlGxL54PjY0UhF1i3CfmP2lVLPP+JE9OSJZEY4EvNuUgqNTt8apVXSJ27mxWGfM2yHNDH/ZrFaca3m9aD28Ua8VWUc3sig4REvBRFQrcpMOGvMefdW5J5Bo9MzftNWNZxMAJexH6yTJ01qhu5zIRmMM9j32vE1W6orZ2G3kpBFzlxazj260YWyuYpjjgTMd20ffeUGViShUjZJUquzYGIFeTwLVruWuxy0Rr4bsYbLYY18JNPArFAHXYIpXOA1MwJHNn9Gtmqk0tKBgiaW6VcyUsEacMdfWCxtg7hjewiSQYYROT6iFjCfw7457wYLNu3cE8Wzh0T4UH1by48Ily05/u6ukcV6ivxlKCLR1GGS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:26:12.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad0294b-f8a5-4095-73c0-08ded8e51fda
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11590
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon!

> Right. So I think I understand how this problem manifests when 
> interrupting a leaf function, but I wonder if you could go into a bit 
> more detail about how it occurs inside sigfe? 
Sigfe only saves LR on the cygtls stack late into the function, so if a 
signal arrives prior to it (while testing, this usually occurred when 
it's trying to get the stacklock), then sigdelayed will set LR to where 
it was in sigfe, and sigfe stores this instead of the original LR. This 
leads to sigbe jumping back into the middle of sigfe with an already 
popped stack, and the program crashing when it tries to branch to a 
garbage address on the stack (the address of the function sigfe/sigbe 
was supposed to wrap not being read correctly due to the popped stack).
> One concern I have is that this adds a single CONTEXT.
>
> I'm not entirely sure about the situations in which nested signal 
> interrupts can occur. Is that something you considered? Is there 
> reason to believe that can't happen in these circumstances? 

When submitting the patch I remembered considering this, but now that I 
took a second look at it and made a quick test scenario (nested SIGUSR1, 
SIGUSR2 and SIGTERM signals coming from a forked process), it didn't 
seem to work correctly. Thanks for noticing it, I'll try coming up with 
a solution.

> I wonder if there's a possible implementation where we maintain a 
> stack of (lr, pc) tuples, and then exit by rotating those onto the top 
> of the stack frame and popping them both?

I will take your suggestion into consideration, however 
RtlRestoreContext will still need to be used in some form, we can't 
avoid clobbering any other way. We also cannot forget about the other 
registers that still need to be backed up somewhere.

> (It might also be worthwhile looking at the aarch64 implementation of 
> RtlRestoreContext - since it must know how to restore all registers 
> without clobbering any of them - which is exactly what we want to do 
> in sigdelayed?) 

I looked at its internals, and it uses NtContinue to restore them, which 
is a syscall (svc 0x43), so unfortunately it most likely does something 
we can't do in user-mode.

Best regards,
Máté Dimand


Return-Path: <SRS0=KgpT=CI=arm.com=Evgeny.Karpov@sourceware.org>
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	by sourceware.org (Postfix) with ESMTPS id 12BA54BA2E06;
	Thu,  9 Apr 2026 11:45:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 12BA54BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 12BA54BA2E06
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20a::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1775735148; cv=pass;
	b=kRDSDwT2S1x4GsGJ8kMFM2093lykBsK6NDWx8C+PbCZQaxev1rxF4yQSpJnQRzlfUSPmHlwBGhlA8rOyDKVnyUWVwk9YoXBy098m+CfMBNTzbLMPsPWtrcN8B54QcC6K/QQU80F+IMg0eIGuvxILkWBGFX4kBG1NEAMBkLBULv0=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775735148; c=relaxed/simple;
	bh=FCXyUF8CsCpFOeeY24wcA06OUas1W5nA/FrbQrvTuqQ=;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version; b=p2sQbveG6hgB2dbg/Sg+2vg01jlmRHBG3gFXq6aUcjpqqof7nxgOEO8H6dgBgLJzAo2GiemejUiE0qEBjEedCEQY3D7f0QutOZvjS7jwd99x/4lJrOQOTcFqzV4ghxyqgpgOUWMfFzoul6cVI+C4mWbKsl3NVKeRitSyZlV5Aq8=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 12BA54BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LB91gQEH;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LB91gQEH
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PjNPWBoZqkMV6deB3uArPEjNHpy+CHy8jL+A1dHlAMeLVB0j6O7RKB1med2Xvo3WzJdkWFP21jLKh9ebYXRAvzsEeusig292DCoSp1n/KEtqzy8H+FOZ2KOjmi/P1lpMv7Uj7PM+de4f5XrKSahvYmsgy6qHZ7NxLEE22OO2YScqbAWq411Hky/IYpH4BQLnJJzFLrOL0JV4qfVrPT7zgmYnddar4KxhqWv5vhL9iG+86tkyPIoaYXcGdDBDkVIbmRRDCTPIb6gmtVYByeVWzHJn0F0T5O95LpKO0guOMRnmxu30dhiyZlQG2+h9JF97Aov42rBMjPAz8iuhyMbc6w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uf5daiUoPcIP6fZXNEGuZdP3cmptfOMxu9n0HUuH8s=;
 b=wz2QLqsYU6EKKlF5mVOa8pF0aEZQgLVW7VafqHS2Bm1OyIgANPUB1ZSmxjTyA7WCx356D2x/XZgLtlR0RdG4AT3MrRS4WDD0BuX3zhtlDTIDqTchKi68cGwARA24fVS1Yr7E2UJJJJgV9nMKc4f5DBpp5hpHAEN50z88/5BRrSfIVSKSpvyHexAmeWWH/ztAURrcd9Cj54CKMWr2IoCIAF4WtLMO0B+RNp39TNaKZHR7If6K8VqPAhMRTSxnyHTCXOsRr57FFOBHJbiWOm/EX6NvccKDvDr6trIv34Nt39opeW043S0lPhd1f1TW6jpHtVKT4BSU1xzunewo+a63tg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uf5daiUoPcIP6fZXNEGuZdP3cmptfOMxu9n0HUuH8s=;
 b=LB91gQEHks6wcF9EwMUyGRCF7sEiEUvVqOPdgOYiHw2fVCQFT020TjCz7EsSUrlnzHPi5f0fiieAn3Cuw7FeU+6R8dThhDCKUDjBvGyAZQO01UxZol5z9u9sQHkCXl/1sPizLE8qnlEXUjDRT5MmtnLBTFB3o+i2xSUQ9iRxkEM=
Received: from DU2PR04CA0009.eurprd04.prod.outlook.com (2603:10a6:10:3b::14)
 by DU0PR08MB9873.eurprd08.prod.outlook.com (2603:10a6:10:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 11:45:31 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::85) by DU2PR04CA0009.outlook.office365.com
 (2603:10a6:10:3b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 11:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 9 Apr 2026 11:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoPKCTz9amOltUL+ZvUdrYjHH5UiitujXA7MNVaLXB80jFF5yAh3ZDByXbLivjiOZzPpQ0Js/8htGnW9UR1+oDQMAEFHdAvd3upmorzdZO6Kh3oMTXQhh9U5xR0QtHp+bCujpo0mc6XLPQ0VWt8lCswpKtkP9FOW5J2c2ef5hVd2i0v3VgzbxbAypEjyF8sSbH4g2JK0XZu73rhqdl4sw9UQsn8AR0B6yDaIXLMQHEloii2+i7niivAslnfL60CUw3/3ddqFBimg7aUWvEk9Q4fyRFlM1NamsL51U0R0cP/S/sOR1w5mvmj+Vaf3RvRcgjrOZAbcWviMWippE3PAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uf5daiUoPcIP6fZXNEGuZdP3cmptfOMxu9n0HUuH8s=;
 b=CVNy7russ7FnFMGmQpyJ8cUAfFUYpR4VehwITvBrye0+8pYJd7lbRuNPTGBKCsTh32u10B193jyelrBAbt5gtWZYyRSd2VWMV4XzbZSBwQcb+XW75hemsfLW2xyMfJFtpZTxV1adRNTPxpmVXNQsvRyjAd9u8COyinLhB8Ri9kVmltRtWoJDy3lroe1VjWkYRNR3OPkGU384jruRPD2Rcxbyn0Re5bjDoxm5NAnI+EoRuriGm8/7HMNetVmmu0HPWajgbjjjdKMvzuN/8pL3k3ChwJGvuRxheuPhAxxa+Zg79AP0CDvMXFO/bENu1M7J1RjPtxW9YXFpttMjyTxHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uf5daiUoPcIP6fZXNEGuZdP3cmptfOMxu9n0HUuH8s=;
 b=LB91gQEHks6wcF9EwMUyGRCF7sEiEUvVqOPdgOYiHw2fVCQFT020TjCz7EsSUrlnzHPi5f0fiieAn3Cuw7FeU+6R8dThhDCKUDjBvGyAZQO01UxZol5z9u9sQHkCXl/1sPizLE8qnlEXUjDRT5MmtnLBTFB3o+i2xSUQ9iRxkEM=
Received: from CWLP265CA0431.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::7)
 by AM9PR08MB6067.eurprd08.prod.outlook.com (2603:10a6:20b:287::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 11:44:27 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:400:1d7:cafe::7b) by CWLP265CA0431.outlook.office365.com
 (2603:10a6:400:1d7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 11:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 9 Apr 2026 11:44:26 +0000
Received: from AZ-NEU-EX03.Arm.com (10.240.25.137) by AZ-NEU-EX03.Arm.com
 (10.240.25.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 9 Apr
 2026 11:44:24 +0000
Received: from arm.com (10.57.19.2) by mail.arm.com (10.240.25.137) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29 via Frontend
 Transport; Thu, 9 Apr 2026 11:44:24 +0000
Date: Thu, 9 Apr 2026 13:44:23 +0200
From: Evgeny Karpov <evgeny.karpov@arm.com>
To: <cygwin-patches@cygwin.com>
CC: <corinna-cygwin@cygwin.com>
Subject: [PATCH 1/1] Cygwin: Fix SEH and signal handling on AArch64
Message-ID: <adeRF5tmktaFUxA0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac08uYQWXPNTnsi3@arm.com>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM3PEPF0000A79B:EE_|AM9PR08MB6067:EE_|DB5PEPF00014B8E:EE_|DU0PR08MB9873:EE_
X-MS-Office365-Filtering-Correlation-Id: e552bbbb-d581-41fa-c231-08de962d80ca
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 XGCM0Wm2HdjxoYOPdJeIPuyoKNsG5MAWkoGil19HiFeDlQAchiSqlb9zziRxVMJvd35CoCBiayy8WPLmh4fVqAOIANXLVCB/em0FLDGDtVIHi5E3G5zuzHyJTNBRZiYLem/zeY1uKErlXOJ++sAgbz4QC/fdKeeEjGthSSx5ZFXlRCDd98rhju7hsbeq4XlIII5XOuW0eJcdUw1bmQ64Y+2SovHCRhRUksJeeCE28m/OCB4ssvsZ0CtjLhn07mLl5bV5sY5tTMxha6V7gGLLs3U4U30xaNsyYxxjFhvDcmCi11Vq6avcigq3ArPNVni4FVQVBGUgWzA8eaSanvbSYpml6zm3SXmWCqYPALfxYI72ujhD8jn5sv9HaDG5axD4i/OwHbIRxrWXyE8lJZphiNqW3nwQWh2eKXcciHigUnSkoBRnKMF1wuCKxz18Sv+GiszKkrltG3C16t+pVKR5HEu7nNRTqfGhVhZzZUuGK5f/o53QY0phYG79RAqM5hNRyajfqwKp7xz9rAbj/zc5wljIL/0NhkKNNqdUkEeEL4RdXbuiQmGQGic4pu7hogej2e86cPSmjOApLY3qXuRxrwH/ZvQh5AL2sTEShVJLShPlmWGhTEtxJ2nmNYkfsTu3XVkmFs4TTTHM8rXPVw2qx1EfL7xqK0vaspww3zR32erFHNDBcfyv19YreJfHXzSQYd898Kh8WN+cLtI7ZSmfPj3xM1C+bHeAU+BU3+JNUec=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 uOixGxs/loUSzyqV286ToktWznZdV63TYxupd4x5pQoYAwp02cYiIIkJPLu8R9IwjKW9enwy/D/spO7B0FHGZrD/zZ24/q3JlZFqsH8rQCJd5GdWpInW3sPeULrHpMsHCwQG5H46MhOg+gxFi/xZ4WszqC/fFf/GMCZJ6fVlg7hPeH5QpqfxVYC+Qy+E/NaDr+xWL9Jmb5t/I3K0bErvfJa4l3eH2HoQsys+lAww0EPVZULhuWjnZCGTOnMHb0aL+0NpQuhIj2gEjBpRN7Qec5VSPxTQLv6uk4lJeJqcwO9omJTCYTuidG7gRXMzgFKYZvvlFXtmaGjeFUprQVzkfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6067
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e0739ede-fbb9-4649-7fe0-08de962d5a91
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|35042699022|30052699003|376014|82310400026|14060799003|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wFbaZO1kFnwUDrSU/nux1B8dUC6vG3ZrsnYIfHY5Ty1OlovkdXYiS36hoqBDK94aLe52IPwGcQePLbJsk5sKWMquFyqXzbDaw/5tdtZZnL4Ve/T5nH0wfhJ1XmFAd6YLWs4NOvASF8ssLvHPSGnkMwaP26uz5IUhj6/jyZZAHvqtABZPMrUnPGSgZeNNiANVDNEqMjzL7Au28ODbcuwJUU/YmzQHix8wrH3fIWYjIeuU+HcVAziBwxwqa64JhK+XLf6J3XSML7o9L5FPnEKlCp51EQF5db0ejgau8VPwMqe2QLmKOd/uC2m4HJwnTj52BkIJQWIAZT6XUe4Lanc6ff0YMQZkX11NwsJvmVxUiO3/L0fueIwGkB/XTxOA13TDV6R0rF33QeZumatPizm1E6de4d4ji0SBrCVUpt6o7N4akKnYvspC/dO//AGXqNG7jj1BXl+/kqMkUgqSJcAlUOA1f45nbKdOzqnLJSIf/Y8OTvAKjhHkA8hRKCN74xwgi55U1x5zyjpKWI3kdAFR1GXljZFhI8d9m4lOEqwDIOb1pXy8jGjw/YKI6g1kM9HmWS9zZWJbgqfnzt7C/vSd3UkkCPVFl3GpV/Vquz2BvkslfvraOnQpEnkGgYhdWJI92HdMQDygGdwebXbGnjxtNaZBmpeirEcIYrRM6WRAPGD+A7kuM9C3sEqaaUb+JluGSl9iBde4QgcbGNDtks68ZCjFdbrLjDdBuEwzY9ZpfcQ=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(35042699022)(30052699003)(376014)(82310400026)(14060799003)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+rnXD1GY6jn7ABt/QdLTgJULJXRMleF/nzrUQ4XbMaXtvlagV6EaSpqQRVzUfK3TZkr4QsMk5eidtmmgkpu/TuEjRL0UXo9PJd2qkzXUWuI1w+FTaFH5DXQvntQHDkho9wAuzpIaRrvmzdIXlXxVczh64GRlQqSiZedGDI1bUOvIdZHyMgElPhXMaOkokJ6Jwq2i9aPgQdwgteHeDTBoXL6azG2ZkGDlFshr+2wlMJ0sLs1VH1vO4o6sQ6pw2Aw7L9nTxHc6XlXt2Dd1lkmJW7qYHQFWtz/gyjSy+yEo8G9frooAzWuGZ7WSxC14kV9maSb+an2IaplPJeQCBHSt2wX1I+Mg5LWmYSYXpdMRRKXsv9A96c4vb+4AnRWlxp46VbDOCUhXYwrJhzFdW75kXNTkq0cT9aaXRcQEOxpwPgeIQBioZju1oxWEvfkjramW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:45:31.0682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e552bbbb-d581-41fa-c231-08de962d80ca
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9873
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, Apr 01, 2026, Corinna Vinschen wrote:
> On Apr  1 17:41, Evgeny Karpov wrote:
> > On Tue, Mar 31, 2026, Corinna Vinschen wrote:
> > > On Mar 31 18:49, Evgeny Karpov wrote:
> > > > On Mon, Mar 30, 2026, Corinna Vinschen wrote:
> > > > > On Mar 27 12:43, Igor Podgainoi wrote:
> > > > > > This patch adds the SEH_CODE macro (defined in exception.h), al=
lowing
> > > > > > a single EXCEPTION_HANDLER_DATA metadata definition to be used =
on both
> > > > > > AArch64 and x86_64 architectures.
> > > > > >
> > > > > > It also fixes an issue related to stack replacement in _dll_crt=
0 that
> > > > > > impacts SEH and signal handling, where due to an epilogue optim=
ization
> > > > > > on AArch64 the epilogue might appear before _main_tls->call. Ho=
wever,
> > > > > > after the stack replacement this optimization becomes broken.
> > > > >
> > > > > Can you explain why this problem only affects aarch64 and not x86=
_64
> > > > > as well?
> > > >
> > > > It looks like the x86_64 epilogue is also optimized and appears bef=
ore
> > > > _main_tls->call.
> > > > However, the x86_64 epilogue uses the shadow stack which was alloca=
ted after
> > > > the stack replacement. It means if _dll_crt0 is modified, it might =
bring more
> > > > operations for unwinding, and that might access the stack outside o=
f the shadow
> > > > space. It will lead to the same issue as on AArch64. Potentially, t=
he compiler
> > > > barrier should be enabled also on x86_64. And the shadow space conc=
ept does not
> > > > apply to AArch64.
> > >
> > > Thanks for the explanation, I think I see what you mean.  Right now w=
e
> > > subtract 16 bytes from the stacklimit as startaddress for the new sta=
ck,
> > > see https://sourceware.org/cgit/newlib-cygwin/tree/winsup/cygwin/crea=
te_posix_thread.cc#n270
> >
> > Hi Corinna,
> >
> > The stack is also subtracted here
> > https://sourceware.org/cgit/newlib-cygwin/tree/winsup/cygwin/dcrt0.cc#n=
1043
> >
> > > So... since we're setting up an entirely new stack anyway, would it
> > > make sense to subtract, say, 256 bytes from the stack for both target=
s
> > > instead of just the 16 bytes?  That way there should always be enough
> > > space for the epilogue, isn't it?
> >
> >
> > It looks like 256 bytes will not solve the issue.
> > It seems that after the stack replacement, it is not expected to return=
 from _main_tls->call.
> > Otherwise, with the broken stack after the replacement, it might crash.
> >
> > The epilogue unwinds the prologue, and the stack might be significantly=
 moved in the prologue.
> > For instance, by allocating memory on stack.
> > Event slight shifts on stack can impact the epilogue optimization when =
it appears before
> > _main_tls->call.
> > This is why it is better to prevent the epilogue optimization in _dll_c=
rt0 by a compiler
> > barrier after the stack replacement.
> >
> > If the statement for no return is correct, another way to describe it i=
s that the epilogue
> > should never be called in _dll_crt0 after the stack replacement.
>
> We can return to this point if user_data->main is NULL, but that should
> only happen if the cygwin DLL is loaded dynamically.  This in turn
> disables creating the new stack.

Thanks for the clarification.

> So, shall we just drop the #if __aarch64__ and always instantiate the
> barrier?
>
> Do you want to provide a patch for that?

Yes, it looks like it makes sense. The patch will be prepared.

> Oh, btw., we have a __mem_barrier definition in cygtls.h. Shouldn't
> we use that in _dll_crt0 as well?

The __mem_barrier will be reused if it is suitable.

Regards,
Evgeny

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

Return-Path: <SRS0=7rx0=B3=arm.com=Igor.Podgainoi@sourceware.org>
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by sourceware.org (Postfix) with ESMTPS id 498F14BA543C
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 12:42:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 498F14BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 498F14BA543C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c200::3
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1774615361; cv=pass;
	b=I3M8kjwbo7nggoAYWNpsOdQDngieYLNkANExRa35lNSeWFOWT3Hete6rBonHqkhg//zLJEybYtQRFy/9x5wR+8qKITCxzCSYvYGz2eZPiFoD4tjjdkuBB6GsBm4ccpyulIeUmSMO6QRy0YVWhpOezVrg/MZjgUA/irii5ju5w+M=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774615361; c=relaxed/simple;
	bh=IRxvVdtifTe8s3cTxUct9AkyYmAbH8v7vWlT6YoNEbY=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=locliDzZ4eLizgqjuy2X0T6XTMdK5ebNtLbqItWpKCgpW2TQTEU/E1qEjrUAUsf/59EiYVUUshKgNiFiDQHRy/rHjezchYybZyROjHoQx94/42ToAjBNRkytL4HtvEw7rWliax5vpksXis63L1wym3zA9RKmrxWFtV87HV4Gq20=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 498F14BA543C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=MW3ak1EO;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=MW3ak1EO
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=N+DhGtPGmfQmXGjwi8oPy4JAx/YVb3cha8KCX+5A0Mf7+vUNhqePhS/jhP6oSVT6AJoIatkQ4a/B6YEtGF7asGGv9kctkiQDSIwtr5IbmfcflPHymHrbo6nChchw+ssDLtOsMOGGf9rZN/5y7obZGzaZy75WkoO+moTmB6Kaj+e6sfoo2yqNakUSLuWyeT+yQ2KHCNZ/5eG1/2UrFkSAQfYKeGDf4jms/GjKs8f0ZzO5aeNOEoY+p9AR/WyAsRa8krGdzX3oCGxJPEVvA/WZchGrpGQkI2Ey9poXqbalAdcmHIY3YmokpV0NIEplALWESHNUNffkFF0v9UfrFM/SwA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRxvVdtifTe8s3cTxUct9AkyYmAbH8v7vWlT6YoNEbY=;
 b=rMtNWMyfxcPzXvRLyGBhxPgQUn74tpOVfHUdDuzT3ZQhrHfpD0NgM3SgDzSik1y7wy3UQKYbqJuFDVpWLH1b1xNmB8NDAbWAEkBotl+8urdcfvJpDtPivjySdPUu4wkZ23cGEWZW2JsHWI5mvJWAsU7AorvRpTu98lhaqWVg6ToeZHu4RO4aR4DRxjqlltActNAA7wwoIZDXTAQ6I3x+nb5D3s1xDHjfdiKPEM/Xh15lyHJ7pQ9aXZqglyOWx5iERHhx6vIFqPjWU13zJnAmXJmESNOkrui7V0tKd/AIIa8Bem6M0yoD2vDk9s4/uRgg2uDnFcRwuCaCkkyTsGDsxQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRxvVdtifTe8s3cTxUct9AkyYmAbH8v7vWlT6YoNEbY=;
 b=MW3ak1EO4RNIhDywzOnyY4wk5S7TvNh+Plg4b6ckbfxB3pyWBQI0mXQAu9G8ZKl4h+i/x9kCHkU0zpKegOg3TEeC28Ek33AKzYY/umobiViBhcNdH+T0dL9uEzixfjYONQ/m99E9RgRIhP1Sgdsklh8Y4efJo/7NotgAhNmvz2A=
Received: from AS4P250CA0014.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::17)
 by DB9PR08MB6633.eurprd08.prod.outlook.com (2603:10a6:10:23d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 12:42:35 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::35) by AS4P250CA0014.outlook.office365.com
 (2603:10a6:20b:5df::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Fri, 27 Mar 2026 12:42:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyImgHO9GKc1g12KjyWvLgNelP3DjK+Agbj5i4HNoavU3AlgFOaizBYQLtYqdRf4QmyWnh/3Zpj0YsUhzKHz65VUnYuH/3ptZy21dUx0/v/c4wbYWfxNfEE7y+Y4PXps7VQhG04ksMDS069jbN7ZfLWL0JP1YZDkvFd/kDHZiGf9FMC60XwJOz0eJfQBV1ukXB05o3OmJeFSYeE4knEJxWDPd+FNq5bTSJkx8nD/iFCjPYfNojK2kiU+Hboi2bBep33x5L1Hv3UaRlu8cIh+bT9SjKhGksdVff3oavEtz28wFNqeSyatrtRnvV+gKHfuW2lUwBqgWcUavQkGroP2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRxvVdtifTe8s3cTxUct9AkyYmAbH8v7vWlT6YoNEbY=;
 b=AJHfZV0VCaV5PCfMiorwgeKstDx41fHl5oL2Z7BXCNni62Awbm9nQEAFqGaYoE3rSFDpGzaHSOkOYZ1oTLUyQ1YIa1assGeYEr/mxd6f2zp/+6BPwPe0pAidTW/hZX99jFzkuZPEQCC3obq1AaBXr2ZITNQn8PXiNoxHAMzxaGqb3vj2v2/P+xnKW2zwF2ZuLH1l8rFCnCOHghOUqcly89ouRkWHrz74io3QeULioCDpz4Dr87uhEcUnvBEPWgI4w4yOneIVgjIqrDLc1HS3s5fXVy3JgaDe2Vor3tfpN8kdJCuJ+y+BS6fv0FYngwF5wAPyuORAdqy9ZVKRGnPwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRxvVdtifTe8s3cTxUct9AkyYmAbH8v7vWlT6YoNEbY=;
 b=MW3ak1EO4RNIhDywzOnyY4wk5S7TvNh+Plg4b6ckbfxB3pyWBQI0mXQAu9G8ZKl4h+i/x9kCHkU0zpKegOg3TEeC28Ek33AKzYY/umobiViBhcNdH+T0dL9uEzixfjYONQ/m99E9RgRIhP1Sgdsklh8Y4efJo/7NotgAhNmvz2A=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by AMDPR08MB11505.eurprd08.prod.outlook.com (2603:10a6:20b:718::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 12:41:31 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 12:41:31 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: nd <nd@arm.com>
Subject: [PATCH 0/1] Cygwin: Fix SEH and signal handling on AArch64
Thread-Topic: [PATCH 0/1] Cygwin: Fix SEH and signal handling on AArch64
Thread-Index: AQHcvecJZe42ASDn2EuvCHVHHxkNQg==
Date: Fri, 27 Mar 2026 12:41:31 +0000
Message-ID: <cover.1774613608.git.igor.podgainoi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|AMDPR08MB11505:EE_|AM3PEPF00009BA2:EE_|DB9PR08MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: de78aef8-4e8e-40a8-8b4b-08de8bfe51b4
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 VwpRGyf4A0SyM6XG0WQ94gSh7reyaj4Yiovvx9loZ9eGgFoHgzMRH2Okm09PcMHmFza1OLmwmkw7KFy573/OuiFMwuttS/pfyAAzhLmXNZOEnm3ecgxbznLqAnaxF43uGWWppduyhGn1fp0RgjRg3otavbZeLYEWUYcYHmTW5KyVLAMG9N2m/TdjRpEOKWuxLKyz4mhp6jRPNa53MHLXxp92TTpyZ+u3jwHmCnpl90L7WlDMZ25KNQoQXZjuTZDRz+86XGZmCSCdPGh+1GhNDlFrBu+w0efIJBg68sZ8Av2icJg+On8dLmyxfjqA9AT8QVlFDiXodwEvqhR0dFQJNkS7ePYaNBRPtTyXWH6mnulX3GpP1TruABe0epVehn/8EnVkIB2uJMYs5amQrgj7JsCQQ6vDUvg9+zTmDy1E+rG2ZKwm2O1GAAvo2Gb0ZvwkhFk5fCaWMnIwasNGIokXCJC4wsN8/wYPBCtLwNQbI78k5N4d6ED82k8pOxfR338lbMJs9ti9kPlOkLJpTCgT+zJm1cp+7upPqNcsG0naPTJ3Xnv7/i/esHI5JjDrvpRqFmQ1bpieQkpFuWCv8r/t76XSg+Kin0SIo8y67U63UU035O9vL+7zNICxTiHNiQ7LlkYyYEtG4zX5YosLQ1P+RqVDWFakZfDKMMt8wGGZAlwxOlHw9lEQtgt18HWmDwdEXo6Hu/a5arLG+kJT6U7LMCWRByEGAJjpFS3LrwUexJpcadN+k5x5rIwfe1DPuxMh
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <507F8EAD4043254AA5FF6F6BFADD1C78@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 gTyhW1z4NkLODI/qKk7O4qwzFcg0m/z4Qtgm88CFdy4GQ/WkbraI+5l5qDRoOK2e47Jk5CA4tsvVwx+kSNmmGFFO9NN0/qUdIUOOS3h11r98ktT3kueUQ2eE7B+3CSp0A/qDpon/FiHr6oH/qftmgBq+Q2671lCW5fk9zjEkscbjIZTvbrXKvJcKYAgtIMdxajouhbQSPnMxPCk0NOhc4dLDBzCMUre08ORBihTvGVBJPXr99hBtg2gRXYFLTVua+sA2f6+6A8rarwe9RC/9xu037EI+p3ts//0jcL0bnR7K01buubSLyIw/dKNjdmUaC12H2BY20OufCTvluQi+jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11505
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cf73cc61-ee3d-4336-c4e0-08de8bfe2c47
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|82310400026|36860700016|376014|35042699022|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	n06yZSwuUD7kB8tuasn1IrX5VC6+RpWvBbZxdzH6E4BYbbCFDO4uwjTHa4mTUshoQZymuHPkeoF81/J61UAox5O/1CvIbHK/+cQ9ZYgpJxh5H/PbKWaE6W9IF7P443JhhzYHhwuiYqf1lOO3jftZTSSR5udZ/5wI9dmJY/7ip4q4HWRCAUOQ+xsl+bPhZPZ+HpwjFDXNu/0hZiRY1RoiVyPNHLqWIAgyl+jhUSbSSA7x1rssCCnCGP1BMaJL/AwvpBLjYRMm5KelL1NV1/aZ9TFNFWg2S2Ho/ceJLbbM3fJj0a/hPiK1boIsXCJ4LK/tXQSJw3Zn8SqXl/PW8txGuNY9LAeyDmQ4o0UJhBGtJwJ2pnke4ocC3GLcB6CNhUHyT26QJApy828oQMWtPK9c3wowAJJSfhZj39BmzWlaKu9TZ5x6kjuE3vPebnoS5K7RsRlm2VdtmaQFLmCSm5vF1OOVE9fgtoqq0+NSecxM2IFXwWl3oUQHjzYmgJJJlgJFqc+irPL9Sc/u+vHdE2Et5N9wp2kHNacNQc6dL8qGoVU890fG/DTi8yWwDRXgqB5QoQWooqWC+k2KYYfpzjhmkoLXVQXI4VhrlY6p5IRt+4t3bIVgxLXx98eMxho7OJ4g1dBYAWnbrlDRVESBK7pnA2rCjoLqjXjzFZnycTCpWl0FiWYoVhUUz0NCO2LH32eOPMRiB+3lwm55RXPUKZEMm4gYFtGXMwEwF+wja/is/sg=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(82310400026)(36860700016)(376014)(35042699022)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nJVSzkB5R1rV9YhAOTz6qT2GIul5tAMghZL4pKITUoi94JGIgHFULY0JK2MMuCh7nb+cAUBw5Fqx2uegZS2mC4PoWKQ9DtZx1oLGcIJN9/b6hjTzmNQd22YvzFVgJKFx7u1bMfo/868xlmyvRi4Jc8zl9OwTzYbTDoOVy7oiMpJSO21OCTABguaoXKjhvAkGHSRsZVjQABSL9HtKiWYS+5mlApC9Vn2o3NP2mROYcz5mu9ZJZjmhG8cwCUYADzkSOZP+0BVmq9A18q6OEJINb3uasoxjQsCE0MeU6yivDdeF11EqsEWCStRQy5OJvt7JGAi+DuJIJCBHB3QVIZ5Mf1W4oqDYey/J4TVHOYcvhcDcXXJZAOorFQxOrGfxQVIMpNfs3SfUDN0Yye+4JcZrmovYrRZpKBeA5hWnJJHEDZLQskYcglsxYZXy90cK7Kgv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:42:34.1611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de78aef8-4e8e-40a8-8b4b-08de8bfe51b4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6633
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGVsbG8sDQoNClRoZSBmb2xsb3dpbmcgcGF0Y2ggaXMgb25lIG9mIHR3byBhZGRpdGlvbnMgdGhh
dCBleHRlbmRzIHRoZSB0d28NCnBhdGNoZXMgcG9zdGVkIG9uIDIwMjYtMDMtMjQgYnkNClRoaXJ1
bWFsYWkgTmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5uYWdhbGluZ2FtQG11bHRpY29yZXdhcmVpbmMu
Y29tPiwNCndoaWNoIGZpbGxzIGluIHRoZSBtaXNzaW5nIEVYQ0VQVElPTl9IQU5ETEVSX0RBVEEg
ZGVmaW5pdGlvbiBmb3INCkFBcmNoNjQgYXMgd2VsbCBhcyBwZXJmb3JtcyBvdGhlciBtb2RpZmlj
YXRpb25zLiBQbGVhc2UgcmVmZXIgdG8NCnRoZSBjb21taXQgbWVzc2FnZSBmb3IgbW9yZSBpbmZv
cm1hdGlvbiBhYm91dCB3aGF0IHRob3NlIGFyZS4NCg0KVVJMIHRvIGJhc2UgcGF0Y2hlczoNCmh0
dHBzOi8vY3lnd2luLmNvbS9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMvMjAyNnExLzAxNDgyNS5o
dG1sDQoNClRoaXMgcGF0Y2ggc2hvdWxkIGFwcGx5IGNsZWFubHkgb24gdG9wIG9mIHRoZSBiYXNl
IHBhdGNoZXMgYW5kDQpjdXJyZW50IG1haW4gYXMgb2YgMjAyNi0wMy0yNy4NCg0KUmVnYXJkcywN
Cklnb3IgUG9kZ2Fpbm9pDQpBcm0NCg0KSWdvciBQb2RnYWlub2kgKDEpOg0KICBDeWd3aW46IEZp
eCBTRUggYW5kIHNpZ25hbCBoYW5kbGluZyBvbiBBQXJjaDY0DQoNCiB3aW5zdXAvY3lnd2luL2Rj
cnQwLmNjICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKysrDQogd2luc3VwL2N5Z3dpbi9sb2Nh
bF9pbmNsdWRlcy9leGNlcHRpb24uaCB8IDEzICsrKysrKysrLS0tLS0NCiAyIGZpbGVzIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi40My4wDQo=

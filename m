Return-Path: <SRS0=j7nd=ES=icddrb.org=ziaul.haque@sourceware.org>
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazhn150120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:dc05::2])
	by sourceware.org (Postfix) with ESMTPS id 057384BA2E0F;
	Mon, 22 Jun 2026 19:44:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 057384BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=icddrb.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=icddrb.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 057384BA2E0F
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:dc05::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1782157485; cv=pass;
	b=G7kA1C0fSdnL4iAAKROtv56I9Hs/jiGfPoj2ashf0WFNDA3lXpEypRp3jzb82b+CymEFdpvUbIvp6SYxyUf+NXzG9v4zhdmInC1UvkOTfe8bfP9gr6iKn93z8O7M6WpXG/at51f5YMoLBEI3rBcEpyDjYRQN0POaGf4nGTZFLAo=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782157485; c=relaxed/simple;
	bh=h9613B1SwiwWMBO8Ks1tCbGKktvtwJaD98HyyH2gsho=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Ny+WEPnZYUgkK8mrxyLgvHy/EEx5DXa/ZLdTsFMCeJNKDvJDfzz0Q/pQw2Qk/mKH1umw+Qh9wqK4EjMOwslRHoGNV0yxbQ77KrhGWJXGWy3asl6wyC3ERJqqBQ3ZPsxEmtz2fjFBQvoDdM/K2mJA7LDjQKWFAZF9c71Digfvvfo=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=icddrb.org header.i=@icddrb.org header.a=rsa-sha256 header.s=selector1 header.b=cec6VL7H
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 057384BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=icddrb.org header.i=@icddrb.org header.a=rsa-sha256 header.s=selector1 header.b=cec6VL7H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzLBUYCxMQVUl1MTIjJ9AZ2yAn2q4/kMq46BpCQd7jnNyQAt54q28D57/PeUVywGeC3giGcmN/3gj9AsYIS3X3feJASG/aAJm7mO3KoQbVVtFhEMvn5HA9iy8g7zNNE/QIEvEyaIerKRnIA42F3Yj+Kit9waQIYiCfd0zBi7EIVbDSzN0IdMTfcCk6zKd6EPF8gD9dD/tONgIvieDG+GiVOSac6d7qEW1s1ISdyxSozKPP2dWBGuoNo6UB5Wnay1TbKAyZtqqSeqJIDZ2F4mG0I/Y3WYdcpLqWo7crGrdup10OJrSXesG5SglRxhvCRotdMSMHgmlIp0+A7u/NCtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4bTkjaW88YOnusRxh89NqR7DGwwuzkyISLYgzKQPQo=;
 b=ucm7Y2zB5r3OUSlOJPF26U8uIhIoD3BY6N+4/NDOxPi/5QQguIqNyZnii8K85PLPdOQQrkRzA949sVHTZwBJRiuZDTMmeOpDFEezuN9tJebt+VlrHeYfbsNiYuYcN4Tfgi/s6tDkjqd1VyMiMLvM4dTxUlepNHWM8tJbyIH8MNE+Sjy/UliNsifuzbebjNu+OIk6RUTpXoYbYerTsMLFp3hlJsWrSH5Nlv1di8vwroPDLzbN6sADY63fZMnDhQhi6oTe1oWv9wTqnXTh4yC4ni6n4sGPEl56RnrpG3EaMeYaKyRZrR8yVIi23YWlfTU9HslseGIx9xP25n/lFl8wTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.190.254.10) smtp.rcpttodomain=hitachigst.com smtp.mailfrom=icddrb.org;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=icddrb.org; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icddrb.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4bTkjaW88YOnusRxh89NqR7DGwwuzkyISLYgzKQPQo=;
 b=cec6VL7HL1n9vQUHSD+4AYJSfXJePvWIwpnbWHdTJc5cbGuPNUaK1zOl2zNC8Uds1VDtXosPW+CxNk1tT3BgtwcaUpPs/SuSc6H6Ddmj06gRWTLfT/e756jCpkzTrqgs8453DY9SsMXMrR6E4MH48s54tZF07azbnrEKXJY3QKt0eInboWAFyGoUYni84isxV2apE6mOIv8FVfA43hdp7ok2CMkKPg4SZrHyw75jZ9lxPiHPEXqd7jGcP+DLohDk4sT+ZfrwK12krNGBPkVSdW/Wp8Pez9uMC/GhUNTv3nWtOCjHc4nVpm5GPe4TGEWfpX4eJGWRlbVIr82cj6y9Hw==
Received: from SI3PR03CA0010.apcprd03.prod.outlook.com (2603:1096:4:297::7) by
 SEZPR01MB7218.apcprd01.prod.exchangelabs.com (2603:1096:101:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 19:44:21 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:297:cafe::99) by SI3PR03CA0010.outlook.office365.com
 (2603:1096:4:297::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Mon,
 22 Jun 2026 19:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.190.254.10)
 smtp.mailfrom=icddrb.org; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=icddrb.org;
Received-SPF: Pass (protection.outlook.com: domain of icddrb.org designates
 203.190.254.10 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.190.254.10; helo=mail.icddrb.org; pr=C
Received: from mail.icddrb.org (203.190.254.10) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 19:44:19 +0000
From: "MD. Ziaul Haque Shaikh" <ziaul.haque@icddrb.org>
To: "info@mail.cc" <info@mail.cc>
Subject: Are you seeking for a loan? 
Thread-Topic: Are you seeking for a loan? 
Thread-Index: Ad0Cf4LyalmBU6AqDU2YK7ZDJtYlUA==
Date: Mon, 22 Jun 2026 19:44:17 +0000
Message-ID: <f1ec174c0ab64d47b5e9373972faa610@icddrb.org>
Reply-To: "kateryna.muchen@fuibk.com" <kateryna.muchen@fuibk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: multipart/alternative;
	boundary="_000_f1ec174c0ab64d47b5e9373972faa610icddrborg_"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|SEZPR01MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: f4952beb-78dd-4b08-6e18-08ded096a6de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|23010399003|376014|7416014|82310400026|1800799024|8096899003|56012099006|11063799006|280700005|18002099003;
X-Microsoft-Antispam-Message-Info:
	v1kGPQkdPr0VHHkXgxxekpv2dbkggk7oZBHAXyywnV8stgukP1NW5GCAzUQHKhInqKNI7L9a8etfNsplizzH3dwZXyRCAk/daqyKPmVMMzoPpRehD5Id2AdYoWJbpffnJ+7g1muydcXVULXXHtGXPg1lO8T/Zlz2xgSC3itTjca62BcjJzgFWJak8jtovEl5ab/iYTI+zQ9/LgOy7WlL1C+sd+Byb7DX4bdMTRpd7FjMr2YwBDLghWkf4P0sBo+EsPoLTgHHaPwRI6J6GW4Os6F4FvhXC7BR9ccMGnOQenv6hig++Fu+K0RWHgbLyAUkeqgFYD9B94nl6PpiYk937s+VTzynaNy7vIRD9ibCLoqkRGfSsuFfrzKfbbtAuFMziwh5DnhWkkSdyRew4rof+0jf1MwnlP1pm5VPgKsStRnP9M1WJOOQFQEVfY7acVkmCWAk6Ch+py3W3rT/gyKUKPWMXlzzfZ4+LojwP1M1zedsUJfPhYgawvdWUucyIGOXot1pR+rZAcBlt5b8TK1XJWhqm0bpL4ylsXNMIv8PD9tq73MKZRUrXGq1O5qr0lWYZfthNMarDv7WWP8Uu+6wfXi2X0+ztNsKijoJVkTIUJfCjWxpyeNLl2+HB31EuqbK+TSVuaXaFpnAryYYWFGEYT6WkIgj0sp6DBbnrfoKuUW3M49yZWb/3b2BBphFEYlVmfxkKXKh2bh56PoPZGpwHQ==
X-Forefront-Antispam-Report:
	CIP:203.190.254.10;CTRY:BD;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.icddrb.org;PTR:webmail.icddrb.org;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(23010399003)(376014)(7416014)(82310400026)(1800799024)(8096899003)(56012099006)(11063799006)(280700005)(18002099003);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GEZrqkl/Q5HFEPQpA9Coq5BrMx6q68m2wXrMI8VsV9RjyYgjla7XN1OcuOVbt2g2abMXq9pAWa9aA79s7QEkmCx+U8dLIDfzPQvbvIahy9UQ4oiNqhVm7NoFgdjV+gXzGMoww30wJ1zmzL4hdekNjOStoloB0v6KDNabx4Qc6GyzlF2gi5AhGx/k2fqg0qWV+Kqi20kaSdlY9U2cQdrN46BwsvHy8SHkd0pZzlxaDxvV+MGx7WeQsAM55IVBzfON+oxtjT2SzUUiXBsC0iJSfkxb0bl/MWIkg3+Yy31i0aPdL05qNQCPJSLAQABjK+yMl8vt5RbnP/TEVYuECJfZrBsg5gH5qJYDVQnJT7/eIBoQBe7iqEWIIMDJwu8xZk7T1BKIrqa8khL/Wg+meA7vsbDqpv7fCzurzwPof33pFPPhbGfzRJFh3MrErEY3uUCN
X-OriginatorOrg: icddrb.org
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:44:19.5425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4952beb-78dd-4b08-6e18-08ded096a6de
X-MS-Exchange-CrossTenant-Id: ebc3b063-df9a-4de0-b426-41a71f84e296
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ebc3b063-df9a-4de0-b426-41a71f84e296;Ip=[203.190.254.10];Helo=[mail.icddrb.org]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB7218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_f1ec174c0ab64d47b5e9373972faa610icddrborg_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We offer 2% interest rate. Reply if interested


--_000_f1ec174c0ab64d47b5e9373972faa610icddrborg_--

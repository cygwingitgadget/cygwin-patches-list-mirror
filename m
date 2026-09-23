Return-Path: <SRS0=1tMQ=HP=arm.com=Mate.Dimand@sourceware.org>
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by sourceware.org (Postfix) with ESMTPS id 05EE14BAE7C4
	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2026 09:57:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 05EE14BAE7C4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 05EE14BAE7C4
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20f::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1790157442; cv=pass;
	b=rHxpbJ4kNW4HzoteoKgU9Rd3A8HHNrrJpzUbJ9Cy0f6O3ypSkPw+wceMTuPzFh3gwM9ynmNDDg5mwgbFQH9mfLJ2zKnq1zc55tc5nYr37qDdgoEjrjkKqmuNXt+FpAnSCeV6+jCOOSgA06QSiEgSwiUfi8Zc4LGioWDT1wPrd0c=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790157442; c=relaxed/simple;
	bh=NooUXQQf1AyJU2PiIsqIR31nyghokHkUhXl7ZTo2WWI=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:Subject:To:From:
	 MIME-Version; b=gxiCvYGWy3PsTzq3xJd7gf//D9bTdJeSejSsvgo/+mVNp1RQz/obmi8qWfn1F7BZMDx5D/KAZZDnCt9FbK0z/8H7trEsgy73K/nx9eUxZSJpbOXH8Ax7G+C+FooWXyBnLUd3y+uili86dCzWISLBtZIONv90QRV2jSokIXASPow=
ARC-Authentication-Results: i=3; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QFQTnMPO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QFQTnMPO
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 05EE14BAE7C4
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QFQTnMPO;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QFQTnMPO
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Kyw63FRwtJMSp3tRZJ2rj+qFfLKv4kBD5h8/gTM/8mDVYOrO1nXmOvgsPZ4eUoz0VFEdeDAnIm9DK4HdW77+CYmIZzNmf2r92OhxmD6PDIrviLTR50clcx0iqDMqDXlwDd/FEUdBm0Qlq4DNe2AwEruYYYONdbH2xhvO/3+gMxGKoFcEL6p4b4NTSORq6jaxqAKF9TTALrPuwXXQQeZcMSIgpZEbuKSi6dQj6XlwbR5MBaUu+AVuOPPNrsNSmwpRVyzSphHFgPeAUn2w5EbL1Q32EcnCvNpsCH9mcFW3/SSmuaGhbJ9Vj+i131da+BwMLTsPR/2DL2cRLrsLTmrEtA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NooUXQQf1AyJU2PiIsqIR31nyghokHkUhXl7ZTo2WWI=;
 b=X1wXlanw2j/u1fLTDmOdc+IRQ28mIY78fqnztZAGVcfLgQU8no9Rj0PFleXk4E1BlFVCmIpvHBs6ui2rwx3gi2yvneoLDfD+0h007eBVA9gf04q1vAUitUXq2U+ppFLI7Saf73H8qLANNxOQB3447zQs8SYEzTQZwprTBD1r9wSJrySeE3NY1EyQzG9X0ORSP1pC4l9cidVkhDPv6eYQ0sklKaox8PdZHqPWA2B5C6yiKLU0jswJZXmfFiRutThpYux3j2Zc/eoOzrSMG7KKVRba1jshNARYx7bRRpe6FUxQ3mfFizKSn6lozD4JhfLJR6IbMUrLy32zrfnJ+fyRpg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NooUXQQf1AyJU2PiIsqIR31nyghokHkUhXl7ZTo2WWI=;
 b=QFQTnMPOWt9Ik31F4bRalGUKqwW8fp8xr/3xog17yjGGkCA7mf+IKxL2RQ1khMkAJ6I8g1ryY7iXf49P5X1r4cKju88rTQUeFxPPSQcjwZQs0QKGb4JHWyB+YjKJIzvWd/xgnPm4xg779w+UltVFUh0D40fV1FT85XH7gS0a6OA=
Received: from DU2PR04CA0040.eurprd04.prod.outlook.com (2603:10a6:10:234::15)
 by GV4PR08MB11603.eurprd08.prod.outlook.com (2603:10a6:150:2d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.4; Wed, 23 Sep
 2026 09:57:18 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::1e) by DU2PR04CA0040.outlook.office365.com
 (2603:10a6:10:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 09:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 23 Sep 2026 09:57:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvechSe69yyXrK3qVmqx1kfUc8Smy811JqnZiqSPiyo/DgLxm7Qnx15kK/nXM/NQlzrjzjVvVvXRJ+VcWauRKbBM1L7ZnnOBinU26mL/W0qq1mnljWPGB8Z+DMRrHnauvJM+9tStSOYJ0+d/P00ZY6Z46efhFJzeibozoO0t51Kx88kF+stmO09bZIc13bbKBovXWJRXXoa5qn+ZdzSMvLAfJDC8dk4Ow9kD+imOz7LiwEN6QHiaDTNM+8XP2wB0JPedCP30EliF1R/w2BoJyOu8Sosq9kLq03hFDHCoMIjRwY+D51YZM/g/tPxf5VWZr3GfTwjVbckvfKhob9N0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NooUXQQf1AyJU2PiIsqIR31nyghokHkUhXl7ZTo2WWI=;
 b=fAbGERo2M79W+NSMvq1NRkl8cbe25VNT3BAFzz/6nPYZqVl0q9R60fjffS6S7szZ+DkfDARhJWv/9TPSYR3oOriXFVoVNKLcS36oAWgZOsxLOrx8BCob14NigVV9Z2bpwkOpBQkcljVBjd9bUsP9AVeUA2KaHvALXqunMQ9O9l+nhqaGctA+VOXz2Nrl/2Qb6Gmv+4Im2Y01oWN+yybNj9zFe7V474xIKo0vQw5EdfU6jbhEeYFuAiT3FMwyFgG6IxMaPx8hp/Lp3YEWao6WGyhkHvQ53VdqrcPQXX5RmIU6U+ij7+D4lRh1JyGeBYsA/L9eUSqM5RXMZTv5Y7K/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NooUXQQf1AyJU2PiIsqIR31nyghokHkUhXl7ZTo2WWI=;
 b=QFQTnMPOWt9Ik31F4bRalGUKqwW8fp8xr/3xog17yjGGkCA7mf+IKxL2RQ1khMkAJ6I8g1ryY7iXf49P5X1r4cKju88rTQUeFxPPSQcjwZQs0QKGb4JHWyB+YjKJIzvWd/xgnPm4xg779w+UltVFUh0D40fV1FT85XH7gS0a6OA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22)
 by PAWPR08MB9097.eurprd08.prod.outlook.com (2603:10a6:102:330::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 09:56:41 +0000
Received: from DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576]) by DB4PR08MB9310.eurprd08.prod.outlook.com
 ([fe80::73e6:2715:9ac4:e576%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 09:56:38 +0000
Content-Type: multipart/mixed; boundary="------------cnHJXZRn0GbJJQXcTdvhf0QQ"
Message-ID: <69bf89b9-73dd-40eb-951f-356fbb7ff3d3@arm.com>
Date: Wed, 23 Sep 2026 11:56:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gendef: fix SEH directives in AArch64 sigdelayed
To: cygwin-patches@cygwin.com
References: <9eed0ee5-428c-420a-9788-67d14368f3b1@arm.com>
Content-Language: en-US
From: =?UTF-8?B?TcOhdMOpIERpbWFuZA==?= <mate.dimand@arm.com>
In-Reply-To: <9eed0ee5-428c-420a-9788-67d14368f3b1@arm.com>
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To DB4PR08MB9310.eurprd08.prod.outlook.com
 (2603:10a6:10:3f6::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB4PR08MB9310:EE_|PAWPR08MB9097:EE_|DB1PEPF000509E6:EE_|GV4PR08MB11603:EE_
X-MS-Office365-Filtering-Correlation-Id: 83640f0e-cdff-49dc-a9ad-08df19590d7c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6049299003|5023799004|56012099006|11063799006|10067099003|3023799007|4053099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 azGy5xppSABu2jVyNoeZOvhvvt77Z2spKbLy/liWQCcNfqtSCNYIw+hEmu48HehNJXsYpzJjlYu7+fnwNPlhry/uu4jVjiLSX/dV+GESUlMoFpaFcWC5sLTfox3ATRmd++ap04y0LlWgLxUyLyZJEubbpXIlxiuYp/z3R5Ke5s+c1N1pw+0/M0bpaqf347nEhyauG/3ZkjepULu9dZ9zlpt5WjI60alwkjHMPH7klP/pHDGdRMKpehYPhZEBQrcB3UeHjtndQy4gO8r3BxVROsXhE1puGXJrZkgxSWjGmB+BYagDdw5qd05TwXtdLh69Ar8K2f2DZPId6tNVX7c+Qy9Ds2KCDDiQUPmssd7GMHbzkog4FHhODlZH7vOI/poc/BCOynCcOIv10YoiBuC5RpdnXaejWh6U8deOncOctDqIL1QP7CbKQYt4mRMOUhM0sFrdA/4DvSwLZs9lX2jKcHFD666bCHv+Hdmw+eYN739+3DgKS8UBEPQo540JxzTMc1wrbOyhxdg8BlyIOVAVp2GBrYnio8m9CsoHZtcnd4rhvfTiE5oaxmoSmA/thQ7wFx4HMtoSC+iSMLkZvJp4TJWUNNPkM8xULcc9e+ruVbfq8ybaHMfRA6bb1ij2jJSkoKHLOSML5TETa4v4exE6SELt2/JucZrcRNI+VBrmxIY=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9310.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6049299003)(5023799004)(56012099006)(11063799006)(10067099003)(3023799007)(4053099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Ka9xvA9c1gm5DADP3FQIB7ZYh2hjFBQNMuGRfyo6/uhPR/LPr9gBNa1Otgnz2PBc3zep0qlRLN6/Zd2khocK030r2/r+LXGhrZmJfyygyn0VHWzGHSsyE/2OwXDAn0fj84LilwM/v66zrptcQIQ+LnPPqzshS1318FohafzRztJYjZWp0vqtzPt97X2AMQ2LhRGBWGXoD+SdjUjnZ0Lz6iu7W2y8DZRrCW3gmsY9DMQAST61KGYejyKA2am471UKauR35conj3DKMc326zB4vyBuT4dWce7TLybBx+GxrbnclzFxM0D/xUIba55zcRj/tcSsL+x9vV3zVfkPRwN+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9097
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	81630b94-683f-45a9-dd5f-08df1958f5f4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|35042699022|14060799003|6049299003|82310400026|23010399003|36860700016|4053099003|6133799003|3023799007|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u0zfJHmOw4PkuX6LcGIuFchZ3nOPWXKceuHGJL7kRk4RGa2BD/tLLswmcy/zLfBB35N4CyNdQHYUFfc+B8CchrVg6v8A/SkCii3EHWFfrTwXmsNQVyjq6X+DJEJw5+nKZh1nghlhxi820RY4s1e8D8b5XwiUaLA9+bNNLL3n6jA3JKlZ1lQcuSMHbk12cwyDZrLU5radc8O98QMdIce+3wETI2PPYtsyPxNs1MF1yM9tACBm6PLQa0qHigNtrKHBECUWIRam21D7bUHLDF43WV4xlmCqNNRepeCvtDXOJxqjSRCmjLeT1RbixGnZlQKaJ3hfVzfXH7f/Qm0co/o+rbOcTZ59Xdw+EJMZSD0w0R8AysM1x/kz++iPMYcDpI8gBQYcq3cUNET26UG5/3f2oFuJhvsYj2hzi9dQ/VL+zoiAMPGv4ZXhmfOkqiiAh+QAlPHvEzNYxzB7fMytd+1cnFid67MLwncO3AJLJNoirHCNTaD5/HYGetdWgD2dLygABfkJPhfYmwYNAmwSulEA0JDn8sW/+0Nr+WoXR4R6XVq3nKXFVn93MBtNM/5+sdzcVd5uJJpLtL7/8AhZ+W1R//FZ6pY1tDxAr8HOmjJhmxr7hgeFTw+pX2tsklF3RAT7444KVEHHhlMPO0GoxLu80qYyXa2izj9DXhyqA0kZ0rDqjjA/xGWOXf/iRn1NOcE03mV1B55NLGM10+cL/lS6bw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(35042699022)(14060799003)(6049299003)(82310400026)(23010399003)(36860700016)(4053099003)(6133799003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0y2lPetMCi65nob5wBdGmhvPnf0oqfcklgW2l2OthioIIaWVdugpqmx8zPls56I5P5c5mPOyuqqy/tZNXZbmzAJgNddjuIkuAtPlo0+tcY+xFWTkD6AqwZrC456Dwf7lhvek/9qfuz6h5U4Qh6t1qra6dC1tz6klNPSKB/qTeMWqZZb9GMiGipwTkkUxP+auJLKHlu4MKYlLNNdkVjpFEB6Qh4LpyxuUy8bs4hEg8vEhh/Lv8s7iprY5OdbBzJ6UKqYTdIr+AeFOGIiV0zAE4iN1DV+UqZ+1P3OwF+zDe+lqvBl3QKkYUWs5/J7a21FiHhbmOAx1SvQSRDTtdMDHBrW2MXQKQu7JNXUGL1aRUDtwfvFjUsw+ouv4Btal2SHieSHU+mEkRhyrYy9HrRi77guWo9z9/v0yAuddc2YA0MKmu2q5oKeCM0DnQbmyi50u
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:57:17.8603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83640f0e-cdff-49dc-a9ad-08df19590d7c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR08MB11603
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------cnHJXZRn0GbJJQXcTdvhf0QQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

The previously sent version of the patch used the wrong save_fplr
directive, sending the corrected version.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

--------------cnHJXZRn0GbJJQXcTdvhf0QQ
Content-Type: text/plain; charset=UTF-8;
 name="0001-gendef-fix-SEH-directives-in-AArch64-sigdelayed.patch"
Content-Disposition: attachment;
 filename*0="0001-gendef-fix-SEH-directives-in-AArch64-sigdelayed.patch"
Content-Transfer-Encoding: base64

VGhlIGRpcmVjdGl2ZSAuc2VoX3NhdmVfcmVncF94IHNob3VsZCBub3QgYmUgdXNlZCB3aXRoIHgx
NiBvcgp4MTcgcmVnaXN0ZXJzLiBUaGUgbmV3bHkgYWRkZWQgeDI5IGFuZCB4MzAgcHVzaCArIHRo
ZSBzYXZlX2ZwbHIKZGlyZWN0aXZlIGVuYWJsZXMgZnVsbCBzdGFjayB1bndpbmRpbmcuCgpDby1h
dXRob3JlZCBieTogRXZnZW55IEthcnBvdiA8ZXZnZW55LmthcnBvdkBhcm0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBNw6F0w6kgRGltYW5kIDxtYXRlLmRpbWFuZEBhcm0uY29tPgotLS0KIHdpbnN1cC9j
eWd3aW4vZXhjZXB0aW9ucy5jYyAgfCAgNCArKy0tCiB3aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2Vu
ZGVmIHwgMTggKysrKysrKysrKy0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZXhjZXB0
aW9ucy5jYyBiL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYwppbmRleCA0YzNmMjBjMTIuLjI5
M2M0YzQ1YyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjCisrKyBiL3dp
bnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYwpAQCAtOTkwLDcgKzk5MCw3IEBAIHNpZ2RlbGF5ZWRf
aW5pdChQQ09OVEVYVCBjdHgpCiAgIGNvbnN0IERXT1JENjQgc3RhY2tfeDE2ID0gc3BbMF07CiAg
IGNvbnN0IERXT1JENjQgc3RhY2tfeDE3ID0gc3BbMV07CiAgIGNvbnN0IERXT1JENjQgc3RhY2tf
eDAgPSBzcFsyXTsKLSAgY29uc3QgRFdPUkQ2NCBzdGFja19sciA9IHNwWzNdOworICBjb25zdCBE
V09SRDY0IHN0YWNrX2xyID0gc3BbNV07CiAKICAgY3R4LT5YMTYgPSBzdGFja194MTY7IC8vIHgx
NiBjbG9iYmVyZWQgYnkgUnRsQ2FwdHVyZUNvbnRleHQKICAgY3R4LT5YMTcgPSBzdGFja194MTc7
CkBAIC0xMDAyLDcgKzEwMDIsNyBAQCBzaWdkZWxheWVkX2luaXQoUENPTlRFWFQgY3R4KQogICAg
ICBoYXBwZW5lZCB0byBjaGFuZ2UuICovCiAgIHN0YXRpY19hc3NlcnQoc2l6ZW9mKENPTlRFWFQp
ID09IDB4MzkwKTsKIAotICBjdHgtPlNwICs9IHNpemVvZihDT05URVhUKSArIDMyOyAvLyB1bmRv
IHN0YWNrIHB1c2hlcyBmcm9tIHNpZ2RlbGF5ZWQKKyAgY3R4LT5TcCArPSBzaXplb2YoQ09OVEVY
VCkgKyA0ODsgLy8gdW5kbyBzdGFjayBwdXNoZXMgZnJvbSBzaWdkZWxheWVkCiAKICAgX215X3Rs
cy5zaWdkZWxheWVkX2ltcGwoY3R4KTsKIH0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc2Ny
aXB0cy9nZW5kZWYgYi93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCmluZGV4IDIzMzg0N2Ux
YS4uOGRmZTcyOGM0IDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCisr
KyBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKQEAgLTQ2MSwyMyArNDYxLDI1IEBAIF9z
aWdiZToKIAkuZ2xvYmFsCXNpZ2RlbGF5ZWQKIAkuc2VoX3Byb2Mgc2lnZGVsYXllZAogc2lnZGVs
YXllZDoKLQlzdWIJc3AsCXNwLAkweDM5MCAJLy8gc2l6ZW9mKEFSTTY0X05UX0NPTlRFWFQpCi0J
LnNlaF9zdGFja2FsbG9jIDB4MzkwCi0Jc3RwCXgwLAl4MzAsCVtzcCwgIy0xNl0hCisJc3ViCXNw
LAlzcCwJMHgzQzAgCS8vIHNpemVvZihBUk02NF9OVF9DT05URVhUKSArIDQ4CisJLnNlaF9zdGFj
a2FsbG9jIDB4M0MwCisJc3RwCXgyOSwJeDMwLAlbc3AsICMzMl0KKwkuc2VoX3NhdmVfZnBsciAz
MgorCS5zZWhfZW5kcHJvbG9ndWUKKworCXN0cgl4MCwJW3NwLCAjMTZdCiAKIAkvLyB4MTYgZ2V0
cyBjbG9iYmVyZWQgYWZ0ZXIgY2FsbGluZyBSdGxDYXB0dXJlQ29udGV4dC4KIAkvLyBCb3RoIHgx
NiBhbmQgeDE3IGFyZSBjb25zaWRlcmVkIHZvbGF0aWxlIHJlZ2lzdGVycywgc28gd2UgcHJlc2Vy
dmUgYm90aC4KLQlzdHAJeDE2LAl4MTcsCVtzcCwgIy0xNl0hCi0JLnNlaF9zYXZlX3JlZ3BfeCB4
MTYsIDE2Ci0JLnNlaF9lbmRwcm9sb2d1ZQorCXN0cAl4MTYsCXgxNywJW3NwXQogCiAJLy8gUnRs
Q2FwdHVyZUNvbnRleHQgY2FwdHVyZXMgdGhlIGN1cnJlbnQgQ1BVIHN0YXRlCiAJLy8gYXQgdGhl
IHRpbWUgb2YgY2FsbGluZyBpdCwgbGV0dGluZyB1cyByZXN0b3JlIGl0CiAJLy8gbGF0ZXIgd2l0
aCBhZGp1c3RlZCByZWdpc3RlcnMgaW4gc2lnZGVsYXllZF9pbXBsLgotCWFkZAl4MCwJc3AsCTMy
CQkvLyBzZXQgeDAgdG8gdGhlIHN0YWNrIHNwYWNlIGFsbG9jYXRlZCBmb3IgdGhlIGNvbnRleHQK
KwlhZGQJeDAsCXNwLAk0OAkJLy8gc2V0IHgwIHRvIHRoZSBzdGFjayBzcGFjZSBhbGxvY2F0ZWQg
Zm9yIHRoZSBjb250ZXh0CiAJYmwgUnRsQ2FwdHVyZUNvbnRleHQKIAotCWFkZAl4MCwJc3AsCTMy
CQkvLyByZXNldCB4MCBpbiBjYXNlIGl0IGdvdCBjbG9iYmVyZWQKKwlhZGQJeDAsCXNwLAk0OAkJ
Ly8gcmVzZXQgeDAgaW4gY2FzZSBpdCBnb3QgY2xvYmJlcmVkCiAJYmwgc2lnZGVsYXllZF9pbml0
CiAKIAkvLyB1bnJlYWNoYWJsZQotLSAKMi41NC4wIChBcHBsZSBHaXQtMTU3KQoK

--------------cnHJXZRn0GbJJQXcTdvhf0QQ--

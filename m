Return-Path: <SRS0=7rx0=B3=arm.com=Igor.Podgainoi@sourceware.org>
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	by sourceware.org (Postfix) with ESMTPS id A0CDA4BA23C1;
	Fri, 27 Mar 2026 13:02:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A0CDA4BA23C1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A0CDA4BA23C1
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c20f::7
ARC-Seal: i=3; a=rsa-sha256; d=sourceware.org; s=key; t=1774616535; cv=pass;
	b=br+HdLk9Ywo7XK4SmcV79wINi3ZwpF1OJSOv+6PuYtP9UtC23gSvU9ibHkbF//QtZ99eMWSC0Y6LzP2qJLPwd36rdgiGpE061/WX245gapOEj0mGDamJUo39ai0TWp0fwsG/Uxvqabyz9hs6FVxuiNuzRrLhs3CARoSM7Y6sGEQ=
ARC-Message-Signature: i=3; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774616535; c=relaxed/simple;
	bh=a85tMcQg9efn4Ud811AIuBn09qAEN2YVLA5KBMkp8ik=;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version; b=hQKuw8I1SHU1bBO2IExd9TgKyJBjMZM1XexeGqvkdZxNujbjYX6CUXldnOjvKVm4QHLrfiGJ8asCaWzgN9B7vooPloIJU8+CzEveqzPWjHg9Ga+Apj482Y0LnMmr+NFVIYQzSl8uJJFcJIo4p7d+AX8enJElT894recp6RifAY4=
ARC-Authentication-Results: i=3; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A0CDA4BA23C1
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Jbm3rEri;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Jbm3rEri
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kxTri9deeJUZdTchkOWS4yeXjD+3kPM7dO3r77McQfNVi8N632XKwzsz3ydJK3tb9ST1040baogqjsvh8se1yB3vil3yS8qrebf7hZgMtqevU1fFZFYexlByIIV0CKFg+Iz6jjKVVbUStZXxNNWD9cYdis8ywiVLDMgcxwjaqwKO04p9NCDENrSAZf7RULbrMgTHM4zEnUOScH5y42Rv2J4FUwtoCdp2tNa51yT3VhQrx/ZWjJalX4NY/71opZasF3tNhJcpqk4dbIj5xz6AHH2v3y5he+t7Y1jcs8yblvCHZwjdiXQrV0roXN+KRZqkUPQpMZ9m4ccDOXcHd76Lwg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a85tMcQg9efn4Ud811AIuBn09qAEN2YVLA5KBMkp8ik=;
 b=L+W3mlSKDFcs8MUJI9sjr3Yl5lFlU1zA1AsEyO704o6wc8Q5wKYZfz5u72EutapH8jtzA6VRP87ByoMdEX5xbhZ+USSHU4S/7Yx+2sksi1pn33s25iTg2KKceDsh08RkQFwTH+sorUYOJQpk8J3yGnoZEyAdOW5AocWdaeh4RbbeoRY6AoRhkg7Cm0uAdLVhv5TmMM4ApXR+Nk2nU7Lh7N6Il5rNOFndNOptp1xVRoOQXUdmT2nRB/stvbSD3oVDsjOkQxl+JIXJ/Lxr6LPhSqMdEmTx+Fr+NOKvq2xKNKMHAkc4hXGm5F5GxjhxuE9Gj/UaYTFXEPzb1qsVaFfS8A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=cygwin.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a85tMcQg9efn4Ud811AIuBn09qAEN2YVLA5KBMkp8ik=;
 b=Jbm3rEricyTEpC3WhQedxbLkcYAJgDHqQmn1KV29Io3Aw26p8Heul5FrSJ9hK/sSuQhTFF5+rmYWI8ZF7XT2R7diak1243JmbH9pUyjXFV+O6AFTywXz54pxF0g6TQ/Ep5k5+kL7MU9btXehuSjJQ6LiJZHvOobJ2YVQkR/3sNg=
Received: from AS9PR06CA0606.eurprd06.prod.outlook.com (2603:10a6:20b:46e::20)
 by DB9PR08MB8649.eurprd08.prod.outlook.com (2603:10a6:10:3d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 13:02:07 +0000
Received: from AMS1EPF0000008F.eurprd05.prod.outlook.com
 (2603:10a6:20b:46e:cafe::71) by AS9PR06CA0606.outlook.office365.com
 (2603:10a6:20b:46e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Fri,
 27 Mar 2026 13:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000008F.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Fri, 27 Mar 2026 13:02:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTium7AOmkPtwMrW5oULCPZ7cF/nNev1x392U6eyKBEmr/iEOwTZ07Vc9Lj0D+IKWw2WfcaXzu0WvHEg7VdDT14yDhEVT49oJ6F4nDSNDma/KdrATcsGrA1hF2r+b/bOfLKGv7nLkFZ/J2+hrmlWCGAyHb24OeqTw3kX4SjoQwYqiw1owKqAsRfFWPwFqL8MttuvaFIqtCU6YBIYs0/y7gYYrMKZgQG888YJYRy1Dg5nmZDe5Sz1lu2LY+iG9nn8EsMKkfMklRhjfuHhRQ8HIV/xl8RQ6/ZspduIjzdEGPvSGKyIdmaG8b9PrziZz87k56ktLF+l7kTPB/qSsqYMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a85tMcQg9efn4Ud811AIuBn09qAEN2YVLA5KBMkp8ik=;
 b=OkyJxs+nX21AuUa3drrud0GjqkuiYwfWOMJuAUfLhkkM869yTIXw2MNUDdBTDolc/c60yKR67qUNz+f7ASK+oGEE3XJx8lGEmYCEWM++eEVpotP/iyUTt/9hQwMIQxKZ9ayRwpBjiYJq1QVA+UMfWq0dzwsrcvs0z1ItQlMnRzv4OTpLh8ap3Kt1IUcbos9GuwB/1RsF8J20GFBrHHM/sP3LIsg1qIa1M1bDTAn0XZgJuuJ6pYAuRlMk6rVk4ygES16Lu4WIMY9Jo39bDZRiuvG7qJsTD11GwtXve7LKOUYGjFMVTW0Xr5k8sbqKqQuYF4SJ0jbNrZ8KE/fMrS8tNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a85tMcQg9efn4Ud811AIuBn09qAEN2YVLA5KBMkp8ik=;
 b=Jbm3rEricyTEpC3WhQedxbLkcYAJgDHqQmn1KV29Io3Aw26p8Heul5FrSJ9hK/sSuQhTFF5+rmYWI8ZF7XT2R7diak1243JmbH9pUyjXFV+O6AFTywXz54pxF0g6TQ/Ep5k5+kL7MU9btXehuSjJQ6LiJZHvOobJ2YVQkR/3sNg=
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7)
 by AS2PR08MB8671.eurprd08.prod.outlook.com (2603:10a6:20b:55e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 13:01:03 +0000
Received: from PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe]) by PAXPR08MB7247.eurprd08.prod.outlook.com
 ([fe80::e2f7:f38e:3321:44fe%5]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 13:01:03 +0000
From: Igor Podgainoi <Igor.Podgainoi@arm.com>
To: "corinna-cygwin@cygwin.com" <corinna-cygwin@cygwin.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Thirumalai
 Nagalingam <thirumalai.nagalingam@multicorewareinc.com>, nd <nd@arm.com>
Subject: Re: [PATCH] Cygwin: aarch64 SEH fixes and handler refactoring
Thread-Topic: [PATCH] Cygwin: aarch64 SEH fixes and handler refactoring
Thread-Index: Ady7iqf8Kaqk9IbyQum4KYj9YcFaLwA/uLYAAFgMPYA=
Date: Fri, 27 Mar 2026 13:01:03 +0000
Message-ID: <acZ_gUdL77JdZgPd@arm.com>
References:
 <MA0P287MB3082CAC457D335E3325522CD9F48A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <acQwoPFM-FeioOIA@calimero.vinschen.de>
In-Reply-To: <acQwoPFM-FeioOIA@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	PAXPR08MB7247:EE_|AS2PR08MB8671:EE_|AMS1EPF0000008F:EE_|DB9PR08MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 85565a07-ad69-4505-7be6-08de8c010c8e
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 nl7Q20Wnu0i96isxWAJ3MCirgpzm0K9UsxIOnU02pY2gPyZq9/K2wxuhgQ5ntTD7Xu21FB6d4xlrT9TLSeQMnPX9a1+wobUlKKK2aYxNXEkGsRWZw6p77XJO4CI1Bv4GMxCjvw9an0yT3GjBR3K+ngeyxDD6SwhQ4+TV4YBzNtJ8cF6k3Mo5oA2DdBUBKswkOMOWlEGhwHdBsa20h57dKcz4EgFuEPPoveqrClQXyGwYFCDJMOWBEPKr1PN7wT2aPd9IEFBPCUD/OzRHOyhGfNyK5tRBWZ4ypYisUuHaOLoFMXDtGZqSzIkayoRhzOIpL3DAFm3KSEVX5ui8agjU9cP72/a7ajjSfS80QtLjVS6GTF4YuiHxu8XeiTTbGPGo1Qua3F9CyODUk1LUR/Jj2o0cc05AZFIuOY2Wa1svjse7+OCgnOr0wEB34xZly2lm+Ke0/liKrXTmlYiP0LWi9JsUbUz9g6kK4yYG6tjDDkZxB+MzaBdSxtKpgPIWErAdk6GIlB5qKafFq4+JLqpItggnEJ23X3elW9aefT5o9NXkk8Ch6o1aUvB3skgfyEfWwiauADZFAf+2X3/gQmQP3yy50+Log3uT7rl3BdBts9eqiZ4gGzwFqx8OoD3y//EkAreXG9uVEipIyki9K5fgcd06Au1Ghq2dh5K/0Ya7+8WwYawpDj6+fVSiVJTiClVgi16Y/16iL0RCcrSeEmCsus7pX6kQGXTw95Qfz9hLkChxZqX8Urd6RufmGIgub3ti
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <C62EA1CBE9244849924C5897B1AA8BB1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 utLi5bkhwbs01xiZFztlgs/VV+7aHVhZ4CTdDHIx1ZMJsOifeN7mL/d2mOgVe1vO5IkmbbdSpOmZPYYl0b7h+SRHALESwLkZAdAi0tBja9KsLywWzIbv1B6tN4bybw6M0N7DGV45f+deVcbZnnNI86EyRHHquesfyE4utp5kHdXmWnHzgloDelVBLPjP0W40/dCLBYaZprhww5FCaEk6w6lz7Y2+QPd/n9KPcm0bAXoq+HrNmryloHNTCUcmEHvJNrW4fWHlPcNALdIuBrIAKX8TJH2Y//przAj0jpzyYJLgxYxxXy+YfHbW54jDv6j6BpEzb/pXedZqFgR8yiDcWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8671
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000008F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	227d979c-b055-4f00-d96e-08de8c00e6c2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|36860700016|14060799003|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	47EHxLj1tuVKxEOQ0BmoOWs3slvTF0CIS3RZ93N6N6A6plp7WizgbjXdG06WMacQcEum1fYHvpZi2ZKEgmY1nK1AqoVMB2APH+mQljlUOmF+tH9A63/jzim1fQp8DDtgyVdR06qS40XDiyBk4Xx+QtxKe+ysDybSwCHelJkw67RvZ2J3JafYHSkJb8zEvHAciJsi+RH84Im+cKeSu0NnbpqSnYP+C1buKU/pU63+Ci+xhi68q9rMXzbo0HzBccpZ3IB3nAwZBjlJ1yZj2amv8KJpgwkpaaRz2XZ/KKuhR6C4rDSEj3Y54FYsooYygVUbJqhBAN3j+DTYp71LFloZoquY5cw3hDZGvKT5uVNcME0gK3viwBHUFRWpzwxedk37z1NMR5VEHA5x0ItiphHMs60NH1PR3dd3RLicM2Y1kcnAmfyN55DQU9bogRKc1IyVpt8SqTCcNfYiTwbrt20KjzzKHWuvckSxfXfalZQyGGAyENJg2XTTm9JDikoHEclMTlQsGHvrsXPWTPm60JKNf0d0VodpRHeeNWRXYfSSGJqLZgdDfJN9098khZBCGLj8jCjXOpFyY8Ig3omd87t/vjVkT3w7gWi20Ellmor2Tgnco8Af7L5rGGbsryRnAJ+zMBM3GOq494wi7vN5LtDZn/YoyFrAwY0Ei8FGt6ZytuRTLqg8a0DSd2HDVdchs4xnij5fdwjCfwauMOnOEOPPQSX+cfz3rv0fuQ+/s2LO/BM=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(36860700016)(14060799003)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	59HZepUlHAeX/ZAlGbyqhBTfNVSBLz47n/AlEvXtPbgOZtPvGnoav2eJpbotbePKWCXr+mdV8k3dVWbqwZFfjOg8b+OLCrHEN6D47g4JA2Dwu1hoJV1d2ptpcZYLKHopQIsHUdlFRbNY1vDlvWaqGMd6ZZ0DwDDEcXkSICaqyy14WOEkZdXq//wf9wBX71ois7c378wU8iGGeEZORP39d41BN76o5/Y89VvzCXuxN1glGRDucrv86081gHsfe+dVu8zYAUs2YgVskq9qynuZK9q5KPHLCwmOZAjH8peXdWqZ0wqabX8nYoXeieMcSjMI9gMGv5MwmR153PAYaFlMHVbmY4oNeM3wqRRfK87M5x4jZXtpuLpjb1jwy3U6WK6c6YlreklYcbNLna++XlTeEzcKZBMgYdUGLulFUzQJfaj/Bg9OGXuu8UiIcF2V6yDi
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:02:06.6253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85565a07-ad69-4505-7be6-08de8c010c8e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8649
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGkgQ29yaW5uYSwNCg0KT24gTWFyIDI1IDE4OjU5LCBDb3Jpbm5hIFZpbnNjaGVuIHdyb3RlOg0K
PiBPbiBNYXIgMjQgMTI6NDIsIFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSB3cm90ZToNCj4gPiBJbi1s
aW5lZCBwYXRjaDoNCj4gPiBbLi4uXQ0KPiA+IGRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xv
Y2FsX2luY2x1ZGVzL2V4Y2VwdGlvbi5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9l
eGNlcHRpb24uaA0KPiA+IFsuLi5dDQo+IA0KPiBUaGlzLCBJIGRvbid0IHVuZGVyc3RhbmQgYW5k
IGxvb2tzIHdyb25nIHRvIG1lLg0KPiANCj4gRm9yIGFhcmNoNjQsIHlvdSdyZSBkZWZpbmluZyBF
WENFUFRJT05fSEFORExFUl9EQVRBIGFzIGFuIGVtcHR5IG1hY3JvLg0KPiBFWENFUFRJT05fSEFO
RExFX1JFRiBpcyBleGNsdXNpdmVseSByZWZlcmVuY2VkIGZyb20gdGhpcyBtYWNybywgc28gZ2l2
ZW4NCj4gaXQncyBlbXB0eSwgRVhDRVBUSU9OX0hBTkRMRV9SRUYgaXMgZW50aXJlbHkgdW51c2Vk
IG9uIGFhcmNoNjQuDQo+IA0KPiBJc24ndCB0aGVyZSBhIG5vbi1lbXB0eSBkZWZpbml0aW9uIGZv
ciBFWENFUFRJT05fSEFORExFUl9EQVRBIG9uIGFhcmNoNjQNCj4gbWlzc2luZyBmcm9tIHRoaXMg
cGF0Y2g/DQoNCkkgaGF2ZSBub3cgYWRkcmVzc2VkIHRoZSBlbXB0eSBFWENFUFRJT05fSEFORExF
Ul9EQVRBIG1hY3JvIGluIGENCmZvbGxvdy11cCBwYXRjaCBvbiB0b3Agb2YgdGhpcyBzZXJpZXM6
DQpodHRwczovL2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi1wYXRjaGVzLzIwMjZxMS8wMTQ4
NjEuaHRtbA0KDQpBbiB1cGRhdGVkIHZlcnNpb24gb2YgdGhlIFRSWV9IQU5ETEVSX0RBVEEgcGF0
Y2ggd2lsbCBmb2xsb3cgc2hvcnRseS4NCg0KUmVnYXJkcywNCklnb3IgUG9kZ2Fpbm9pDQpBcm0=

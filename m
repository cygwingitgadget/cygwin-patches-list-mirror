Return-Path: <SRS0=CW23=WS=hotmail.com=Strawberry_Str@sourceware.org>
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn190110000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d407::])
	by sourceware.org (Postfix) with ESMTPS id B55623858C53;
	Mon, 31 Mar 2025 09:19:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B55623858C53
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B55623858C53
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d407::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1743412745; cv=pass;
	b=c49BFCubbMWzgY/SRbhJUpwive9y5JifTe5bWOH1uiIQyjtqpmCwWYgRutx1DoKDVqn76L+tsHcRg+Rfw45mJ8pjA8VhhGScHm2KkHyTSEC7PxzSQzO2l8tUswTdWy8lj1jpf9F+geaU69p2drl2iKfg2XlhTAu6sor9pfK1rcs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743412745; c=relaxed/simple;
	bh=+oM94w8IrU8+EqETTylNDZSmdITFLJ1n1dF3hywnSRE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=SF0VGfOqeHexi1jfWLgHKVg+BgqA909Zj7VNvKSouUc5yyUJVRnXX65G/ZTr/PaXqruzl9BMqVzkvB/DKxMknIl2luSQfyQpMGlSgUxpCxFpqlHTXpLuV0nr0rrlSQCD2PNOnzKi+eran36ETs5JiH1xOBVscllc6JXyAiPtyHk=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B55623858C53
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=PNklMB9n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lrsz0ULQM3J3S/PL3INlNbx2hxnXhTD1L9JJP3BGnlmNsmo1wAUsRYKL8Zzt/aO7dSLvPY0iPrnCaN4CVbrXOCTmIXmqkOL+oNcXo5GJ51aaDHoJXNENxJoy/UlqhZ9zir1wMJvzeuMJ329YFYXQuoQ6aB6wptZIrDYCtlLezF19wCtmx/Xj2JExGsQDpAR1ZHhkBQkrnNZxTqwU6g0om9bwO9F4cgf2ASZxyqU+oUTWXc1x66PnAds1yR2Ygd5pbD1QizlqwU7qK1yZ9Qy4Pgq+/IaRNVqqog44ZlFJinp11uINVZdOQhEmssNRnyP/wa+gb7zusdmrotWLdPUHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oM94w8IrU8+EqETTylNDZSmdITFLJ1n1dF3hywnSRE=;
 b=qDEdHZbhZPCnFo9GUq/goORRceHmtD8+UQ40ccOwe3ZjpeWQWdP8ieY3mAtCWULJZdC7VQRaSSayfJf9I4xvWkDWJbr5BTDu7Pjz/2sKUE96muk/qD1O5teKf5Rer9gGkwuTw7W9UqeOJ/98zcAOeT8VaK6UKbNNdfgyfFgwkoHHw7Slun0UklKsE4dQdnKFH/XU8AZM6VR6YgdefvEKFQ8adhJjVo3+V1vprMcL46CLKFdnOq6yD6DC6mWI5SSN5Sj1ceB64RVP9QUb0nzOHlNcfKfm/zYmwgMgMZHHTZXIUlYFWyyRSpm77XWbPcZ08HJr18mrYnYu0CWOBjemlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oM94w8IrU8+EqETTylNDZSmdITFLJ1n1dF3hywnSRE=;
 b=PNklMB9nOCnZHey7dylDo95tJ58LPPOIcaJB3R2I83KySTAc7sHBqK6/Zw4zYweJP4es1k63rJeaCr1ylv6aCKy/sdedS9rDzoEnqNpKu/PixukMmGfC2g7onRCECfN7etodz92LB1qSKftsDPhxF0z+5/bS5u8dPq6Tsf38cr1q4RkOec8eMD194g+uoCj/KrNsMUKbeLYeI2XROOTBCY+1tAmLRbFPUjeIeoPiAN75ACCfrwu7qbuSUKAzHLV5lphjFFS8nuJrLdEJJuP02ohXYPKjHqOYiQVWIL4oUeQvKC7NU/D50brWTtT6O9GeRqOcLCJJZ7YPf6RwW4sXEw==
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com (2603:1096:400:3a3::6)
 by TYCPR01MB10365.jpnprd01.prod.outlook.com (2603:1096:400:241::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 09:19:00 +0000
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209]) by TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209%5]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 09:19:00 +0000
From: Yuyi Wang <Strawberry_Str@hotmail.com>
To: corinna-cygwin@cygwin.com
Cc: Strawberry_Str@hotmail.com,
	cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dlfcn: fix ENOENT in dlclose
Date: Mon, 31 Mar 2025 17:18:48 +0800
Message-ID:
 <TYCPR01MB109268BAA2FA4C2E56092C090F8AD2@TYCPR01MB10926.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <Z-m7GKMd5fXqlq2S@calimero.vinschen.de>
References: <Z-m7GKMd5fXqlq2S@calimero.vinschen.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To TYCPR01MB10926.jpnprd01.prod.outlook.com
 (2603:1096:400:3a3::6)
X-Microsoft-Original-Message-ID:
 <20250331091848.36386-1-Strawberry_Str@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10926:EE_|TYCPR01MB10365:EE_
X-MS-Office365-Filtering-Correlation-Id: 896dd763-d535-41a1-bb9b-08dd7035128d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|15080799006|5072599009|19110799003|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3VIqtzSgp+/tQ12i2PMFpIQE/7HHx5GwjCy70EVmFfpUYN4zpvYQNAawWidI?=
 =?us-ascii?Q?eNdFMwIBcH1b3WBQJOK5C3HmFMMjzLZDEhnMOh/iM9gmpzfT2MTbeXSlY+TW?=
 =?us-ascii?Q?WCnX7AAS5h7YAMMwD1kBXxxXezBZbfF8/Po7pGkUGZbXEjNglsnYdAAKIy/R?=
 =?us-ascii?Q?9OoLpMQSy5NmcArMm+oGnacljmsoJTzsZsF4nPkEEYfFmOZuhTJLIGLFErGG?=
 =?us-ascii?Q?uqwTtiupcJQ30F/c/CKRFZunuaGZguJdEtHt8kaMnLXMYlGCHxaQKk3uBnKa?=
 =?us-ascii?Q?g+GmM6RjHcXabBaSgDEvZOtyRgeDv2hDM7VnEooPtGYzjPw4tH+n1U8TrPsf?=
 =?us-ascii?Q?tSYpY8NbE8CtsE/HDPrAajcknIaSoD3gGdOcgJ2GAWuPVzgNHNPs0paUy8sp?=
 =?us-ascii?Q?E5waXrwWIMKgb4OK1katqTIF5+jqVvCywNE8ArO6Q8Tp+ly2Df0fralPpakz?=
 =?us-ascii?Q?hLwEed3LtIVqp7vVZagyAVz9Bfdxmtsr9rgdiAhvcike1JyjfVMJZ3UqBRfz?=
 =?us-ascii?Q?VS6ixXZyLd/+x7vNU5qJAc0gzrOyl3Wq8uZBHhPOtk/9sohtq+kJ4hzAUb+F?=
 =?us-ascii?Q?6kShHSILif9Lot00Zo1UalOaljMvNccrpVIhWe58eoYoyD8PM1bzjkwytef8?=
 =?us-ascii?Q?fs9R+C+GN64QOG0+FioyWXmGVIF0LrFxca7PrcAJF23YaQJZp3LlzPZ/rXRP?=
 =?us-ascii?Q?OKRrEE21QCaTJtJTaoD9zoT7e6P92XtZnxjbO7mX4MPOW/j8xqIRXf8XOZCF?=
 =?us-ascii?Q?OIx7lEYcK/+Qj/xKt37L9V7tnrEzrRXTuSg5gKvYlsUGeOuO3oFlmqioY3oo?=
 =?us-ascii?Q?cXGBF88jXQnrxYDtb0JVYiFxaa5Kn0hjrxHxgseDN6UcsTrxQSWNzvPhs2DP?=
 =?us-ascii?Q?G8Zsgg2KBb3HyFElycTY36ols7LxhSgu/S3QGyBbqu2ZHU7c59TNOBbJdihl?=
 =?us-ascii?Q?t8TTdYNfF/H5tljUr2uc2Ls30K1gBA0rPAvxHfrwPfEbLxDLmY/0cudDQMDi?=
 =?us-ascii?Q?wHJIPo8P7NItRxXJJ8I2y6rJ4LE+sMBNkdlblatF3Fvn4JrzFrOMgbJxzOQb?=
 =?us-ascii?Q?rhKx2+bXAN2XFh4MS6orOPXtWeh3i5Kn27ulNG3q/IlD13+LXhfz3YCtDS9l?=
 =?us-ascii?Q?me2vJtf66KRjP8mzgpsT+q3uiRE9GzJ6zw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/oaL9IGmiC/HcpRb6plIn2DiPgVjmKlMw5XlHNV+2cR5jUU+3hsf+uFdTU/?=
 =?us-ascii?Q?+vEIN5Nx5cDenHDM8djzhAzeAVcc/KvOzSPXVOuS2QK3dVRwJXS3EZJHES+K?=
 =?us-ascii?Q?yDhj5yaa7lQHufxddmsR9Y6PcLZXrkcssoTCURJpiwyT1Ga7CUrMsgbssjVc?=
 =?us-ascii?Q?5Pdsqu1BnBlPDcN4O/dnkOX9zn/CsWaU/g3O4yHK0oRngrjyT8c7im0BZLNq?=
 =?us-ascii?Q?3HYfv5NN7U1K3plOkiY6iZv6Z0oxev/RLnIaGtBWkjyc3+L6VvCDlYGfDwRH?=
 =?us-ascii?Q?Gx8PrCC8g+tyy7k2Ax5aVz05KTp75W+Zk4glpbbLrzTWjQqrKVeadpKviC4U?=
 =?us-ascii?Q?ZKm+6rtYEFgkNMOV6n1K41oWHC/F7pYJtTf5el7ScCtCW2cMdQqEtDK0FuuO?=
 =?us-ascii?Q?tKXPncW/sTxjfw/EIogxoPkzzrEFzrxN0QD/DjFYAbtx2CXZ7SSyUr7uJ/tl?=
 =?us-ascii?Q?gkUkVomnl33d5i0C96AN11r5Z6KFU0pfsiug6lkftmzuGW079yCr+Zf35h3D?=
 =?us-ascii?Q?hBRYdCBB6z5Y6IH2RJ82xrTFjndHyYXWtbrB3IjQaQxEsdGQ/hvx09ff0xf1?=
 =?us-ascii?Q?4y5J94rlyaUD2j/WjAeBpiT7SUSGcX7Wh60jPndVLhrMhUWkvJo1L15yBCaC?=
 =?us-ascii?Q?RR52vgxQjBmA1fH5h4zJjGKVQKNhHl0AXhtzo958vysoGxPhUhH/cAr9u1e0?=
 =?us-ascii?Q?mkR7gqIT50HXPa5MeLcr2dnZf82BgFe0yqwlOCi4HQwUCgZB5SRC/AO+5+tI?=
 =?us-ascii?Q?E7DdbgUYsnRXuT+JSyATPAg1FNoY7N4pE2T7+Gg3JyCtaVe6wsErBKUx/2OB?=
 =?us-ascii?Q?Feq0U9BwWoXtUB5ZFsiKHfAcpVeZw9VjAxMsoBjh60vTMF5pI3w6L55BV3PP?=
 =?us-ascii?Q?mtRbzfM1RmYsFDI1WqW81bfvShsb6Y7VnIa5jNNmOktvAIkfP+VaPJjWJf1c?=
 =?us-ascii?Q?BWDhZqlyTU8NKDZdrX9CNIPBbZtS0EtTPXZTcf4fp1U+Gt5BOxLSBnszGX7h?=
 =?us-ascii?Q?wLX2bomxqA4jW1dtGdYkvLpFiDqq0r6mMa/ZL9Nc7HB24uPWf7E5Ol2YAhWK?=
 =?us-ascii?Q?miO18j3cL28zhV0tws4e/nOHmqOvpdGyZeoJKKCYIvwtM2mRlfeaehPCkttp?=
 =?us-ascii?Q?pkOT9HNsUEtW7l8Qiwnwa6YEhs5EtHT9Ro5OMJpUMs2oBDRn4LFd0qiDt9D7?=
 =?us-ascii?Q?gUM4GS5BYOhUFT/hTAyQGsw39BhDBfxLphM3eS8hXZlR0AEoJjPstu6aEs8h?=
 =?us-ascii?Q?jB3j93QDz/Ubhtg8vdv3QwH5l1ihSr9CSVrjCW+IKHEpGj3thbrexRKgZhcg?=
 =?us-ascii?Q?/8w=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 896dd763-d535-41a1-bb9b-08dd7035128d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10926.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 09:19:00.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10365
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

> I tested this scenario, and this problem only occurs with
> dlopening cygwin1.dll.

Not only cygwin1.dll, but also native dlls, e.g., kernel32.dll or user32.dll.
I haven't tested the next release, but do you think it's the same reason for
win32 dlls?

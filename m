Return-Path: <SRS0=H8Ah=IJ=outlook.com=luca.bacci@sourceware.org>
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn190130003.outbound.protection.outlook.com [IPv6:2a01:111:f403:d201::3])
	by sourceware.org (Postfix) with ESMTPS id C63814BA2E16
	for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2026 17:32:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C63814BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=outlook.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C63814BA2E16
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d201::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792431139; cv=pass;
	b=xw3Rwf/v61vJlbpoO7mDCPruhjAowd1yN2Qd1XnG9NKesyOMmAY5ATu1uSZInslHhXEHh12d3I/bPSgj5QDNOwVSYZRQuE8w7GrLXbk/q1/TkoMX6NCFfv4U9VQpecy+nC9TNcUPVEtpLqmW9YCKIL/SKzZAwiHQEAQpcONt/Pw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792431139; c=relaxed/simple;
	bh=/gMXTs5bCXUHOf0vw1zqh0q/XCTDLwh0SlxHhLs6DMU=;
	h=DKIM-Signature:To:Subject:Date:Message-ID:From:MIME-Version; b=vgzKs1Yls6XTaEcn6QQrpqusVRudihn5rgyt+T+8klF87yGAqqJQ5mtg3Raged0BSYTqqAlgKrps9BioPIZdFMDFvcg6YVCTGsbady/t2nMcGShkYFO1C/worz6D1niyiqvdwusvM0dY8Tp0HFS1VhBO55hprz2Wyy5IhqlLaEI=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=rXrJzgfu
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C63814BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=rXrJzgfu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+gXyzre5L1eL3ymOATwOP0gar6icknTwXZGqYiGWOqQ2Tb84tPJJbl9JkdsVW05nNIgOxxEDxWC7Gge7XClE6B44AYjzuXAYD09uR0oaGOOcEExOssO8620CLYC7E7eQePqKamqq2OOaVHLEXYfGCY4kGRdx/MXteVhdqdvxsoIEfVxXM243DigQDlA+Vqy8TyIx5Mrpc3wZdxxeh4kehyVR9+WLXm8zZqfQ8L205fMW+540osWd2DncFYsadQyTE1dG+daW4pQBEg0LRflSs/jUm6QclwtzBoOZA1GF65jjA/Cn9aMg92ibjaSlepU4sOzQZN/WMEEMsBtlKEUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ2Er8vVnk+dk3RjHhH1F/6LuDCR86xu+xOrH57ymKI=;
 b=xlnT14kiTWsy/KHjuP8btfAGKe+JRqFwZf53jQkYcsku6mLj+jH8zKabnzDS0cDzLy6hmSVEKRHNjYvV0mbeomLNkyyPcT2XCiO6MN2tqpHLZoAPi5L+hwXio9qs07O7rjJ3AxwJqmwgt9ZnH8aY4HA8HOQh4hwBo+V5KGimkAoULSKTWVic04oZovzyecxkhF/45dMBAd8oLkhvC6TnwSQpVDf23PH9vnsamwNocbbFYoA/n0vITVUxiNSU6E7bFDh94ZHU6hoPI1oaAwq2wHzpEo2miqQhPNBQdsTzqzcyLgzlwOA1/1i8QzVdYZorun7RUH3EppGmnL6JoP9EjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ2Er8vVnk+dk3RjHhH1F/6LuDCR86xu+xOrH57ymKI=;
 b=rXrJzgfucxdMJxUH3KaBjgVdxhCIVLjnXkOtx8v8NhWCZSxr4sCAjHb2vqEQ1xPmXp4+qdgBF9SoSYEDdFisC9hmMNVVcq/bOg/L5potITrCWXe2ARR1BRM+8sNosRrpHiKdJ609v56Tn2rBfNW5fvaFAO1LYkC9acFJ/lk6/dYa1XBdvnpnhXJt04wpZI3kxFHnBiCsBpi0WWrQ0rL6aWZ38Y7J9leH60IIKyUNxxbMAaMauBowL9Z8u/pHvt9sjgYFHeqYsyBwbf6rjyiKKj9UpTM9FDvocv6KczWdx8uhLZEMMwqDPmjSwtIYb5QHZqlb19Pranfs+BKq3ZjOLw==
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com (2603:10a6:20b:4b2::9)
 by AM0PR02MB457523.eurprd02.prod.outlook.com (2603:10a6:20b:807::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 17:32:17 +0000
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8]) by AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 17:32:17 +0000
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] pthread_spinlock: Attempt exchange only when lock_counter is 0
Date: Mon, 19 Oct 2026 19:32:08 +0200
Message-ID:
 <AS4PR02MB7902AB280F79F6D37805514D83982@AS4PR02MB7902.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261019173209.2894-1-luca.bacci@outlook.com>
References: <20261019173209.2894-1-luca.bacci@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
From: <luca.bacci@outlook.com>
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To AS4PR02MB7902.eurprd02.prod.outlook.com
 (2603:10a6:20b:4b2::9)
X-Microsoft-Original-Message-ID:
 <20261019173209.2894-2-luca.bacci@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR02MB7902:EE_|AM0PR02MB457523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b95b97b-3df0-4452-03bc-08df2e06ebe3
X-MS-Exchange-SLBlob-MailProps:
	9qw5+ftluCBM04rZffbgGeDNXPMguI7eVhP9h+DZ/6VfpRTgNID8Hbj0jZpN1ot3wz3fsTjWzKyih6MBPigy1FloQtUEXf0JaZpfuX7z9lVtTgfsR5sAMG7rVcGGDWIVuNm9wJNrj1fj/kkwT9x0GVlB/2W2AtDofBZVIxeEa4hUVjjx5WdBYmlFb9vzQ3LTLXHlE1N7UKs+6wAiIL2YV5cohvoGL4nNEL7Ab8ikCbhD9TbB/wdsBAUURv6H9ameVHo+IHo7JsyHItZCcUl8xlXr0PsYyZUebbQp3jGwfIzIk08ABa5DX8tW5vMcPkHupSkBoEXuC/izLf9YtyMyLzEauTzyT3wW9RvreFNilBrOSvXB7UU4dt4JlUlzKotJ7dsAX3zqfOkrXY1zViRhow2k/nHtPaR5E3LInRldb7XWzQaFhDLDtLkTP0ShBME4gosf2JGvSXewRBcyDvudLdMhUk69/ZX3HJ/36cr3UIwHFnu+sARtH45nq4eIDDxENEzn6cdz8a9LHya54b3soCtqc/yOlSuuq9x/Do1c8XTeSn6PXdu+p6HtYykwpgP8718UW73uoO2M5osVk9iuWOJsSvRHwwUgZ1aepNA5BHa3r/FKwAKK7nHcOFRvCj8VkLqVH/oLE0GdgCKjhThGKmxLZdAmiYaZCT6pV/okaMoavIAPeGpGkzpHurLLyJROhqN6ZaTGzF4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|12121999013|260925184616899003|24021099003|51005399006|25010399006|15080799012|5072599009|23021999003|40105399003|14041999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a0Kjt+Ybp+mrmDg3XnoD84hW8gDOIYG7oy8Mdmf62xnyCRkwNWeYvzelMbU1?=
 =?us-ascii?Q?f3aRq/lrAOVho7yc0T53TZiH7yOFekqu0QTooP6iwIPBFdMUOWIJUjWMmKQD?=
 =?us-ascii?Q?BwWtV6INGmZ8HXyhJl3aUqUJd5Tnh1YsCzTVlcraHmQPSBH4NMGHlEh/8MPa?=
 =?us-ascii?Q?0ZVa2Xhesx1CkoNeOo2njNL6rBuUP+xmcOQGeJbzWgbtFioEXaUrZz+f26FE?=
 =?us-ascii?Q?LKkjnN4+K/+R/XSXMjcjYGyQds5gIC5fkG1ROaASlmL9u7v01+NF2OYrW5v2?=
 =?us-ascii?Q?REbyztBIcjqa3DP+xtgusjxRoZS+H6PGjSHoiiunRTNq5S23AxTVNO1ekw/j?=
 =?us-ascii?Q?ozM23sy7lrNVNdFR1oruSPgp0VgvF8ACITCqbj2p8p9Zrj8OPwMRDKonwsfo?=
 =?us-ascii?Q?lrYYhJ+3iJRnlNkKiZNvv/7zoAlfw9soI2piZPC/cOHRJa19bAb/XfnN3D9R?=
 =?us-ascii?Q?lg/f8mgy0zLCeuFb4YU8uPi53GrQZBegEFiT4+1pVa/lVggag9mhDBQznrJA?=
 =?us-ascii?Q?+VArodPD6+gDCkE42OGQ6TX9LfCljSek6BmrZc9s7tEx3eJ3Vb64CtDEXjd6?=
 =?us-ascii?Q?b8PBjgHi1e7UH/ofzxvbPVzG/dlricqsvpZdLlVCExG2ej7mjc/MtHtPQi3X?=
 =?us-ascii?Q?eigV7CJDR71a3MlTK4vQ8R8iKOmC7kswaVU8ZqX7ddwRq9tVs2Nz2ZpBlPDj?=
 =?us-ascii?Q?WgGVYV6sQDSTCPj+k7cwl2fWrT9eC3ndKNXcRrxnIS8H/2erXPUhPC6yrYDa?=
 =?us-ascii?Q?p9cuOhmdBaUI3ahLKDOMstgv8xFUG25m/Wej1bl4Y52Em92oYMn1OLrUCLcZ?=
 =?us-ascii?Q?uL4ibCMZ4j2coiILVSbscTH+Dmjexq+TFVPczIh4wH+sW+cnIJ1OXU1wC7Eu?=
 =?us-ascii?Q?Z7S61Jm7apADbL0bMb4U73diTDQDlfqiXlWTyNUagoCcoSak7tqALX1E9936?=
 =?us-ascii?Q?DTD9SAguc90kUUhSs43t1BZaiN7i9hLRtes3Vu+h0/ZjGL5YCYeV2u04X88w?=
 =?us-ascii?Q?uXez?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cmEup8U9AgDJYxDaxUyx6+N600gDqF1kuoEe9K8k5Yz2XN1jokpIt7K4Ssjs?=
 =?us-ascii?Q?XoI315ihR+LMcu+Vy21DFQtW/FsGsQJNXojV+MWINO6Z3sGU7HkctxiP7vmR?=
 =?us-ascii?Q?JFHyugE5W8qNPdAcxJZWRL0AyzwplqNC/OwB1RBKpAhLVVqY9wCw/xB9422C?=
 =?us-ascii?Q?YroS+qZJh5E+EsurZO/IuVeBtKs+7jEKpft/XONmqTQP85xInMQTCv/pc38H?=
 =?us-ascii?Q?eGt+8s4Ecq0XFcLeZbunIylkjYhsiWosbLWhy8/mPfSoiRjDSmwBer03ilRd?=
 =?us-ascii?Q?9ZzcRGeJls1iWaNuCPSCxk4vlhPbAYXoOasIrUTmr9lKIbabMAoYpzp4D/s8?=
 =?us-ascii?Q?rEFcvA5JpIrAUzayvuA0yfoWicVUEkc0nuebtTn/PZzP35vbsv05Dg81kOhu?=
 =?us-ascii?Q?sYZIYb1JJdOS7/u/m2YhHFg6t47zOtKMumwpRqt0VEW/o/ujaoF6cqOgtirI?=
 =?us-ascii?Q?qUAKd3EzBBSwleim8lUxbz1jQie/+5UeSpd/BNgrUMOOQ5yi5yppAZRpMbNO?=
 =?us-ascii?Q?U8Qt8mOJ/dgIZL5AWMVbQB/8FTzrncGyC3XiYhhi+raCUgmRv3fSkPJ9cliZ?=
 =?us-ascii?Q?kE3e+2CTwosBFj1lffd0qD1UKnzR5AexAGdmFLCb0BzZvA0iu4exuL0SQBBV?=
 =?us-ascii?Q?qizYBNwtbpIqa/5UR3zFf2kaQv1ewAZ2BzirzuB4h/5MYP+sphvjxkQkknO7?=
 =?us-ascii?Q?IVlz/dGur+56TGk43qVQUakPNv0WC0T4uumlKgKCJGigr+sxYxOk5KRbbMAx?=
 =?us-ascii?Q?cq+a2hZqBN09wqusRwa/tnBcjC8Z11OfhOCryny2RGxWw7kKFKTjZ9F8M27/?=
 =?us-ascii?Q?pN1N7blP7Xc/2RpLEnp56aMLqgNMXSd8tM9ZZS15sq6o8n8uuQPcmn9t6/SH?=
 =?us-ascii?Q?6bc1u8oO3PVIWFwz1UGKjXmcV0ryCliZUx9ai2n4AXURWlKNyNucTIO5R2Un?=
 =?us-ascii?Q?33ir5OITGHeAT7eYfmZuGk1JKeK1L+/YeufFtE4Ehloul3ozle6jn/5MdrUQ?=
 =?us-ascii?Q?f7O/2/grKVzCV2mDlmD4b9J7CumTPMC17p5VXyoDpU71d249s5JVsc9/hqKO?=
 =?us-ascii?Q?//pg63n84zfX0+R49LXxhg3/kofMYnhQy/bHeiyFRBKvjhpdOpyWmMQXtcZT?=
 =?us-ascii?Q?yhK42JgWuQa+5VIwrSSO0qml3HmudzTW+qhP7zA8JbdGLGZY+obnxQBsU8M1?=
 =?us-ascii?Q?i6ZnVZ/WAE3u/2cy0xbV3f6s7RCisR4nCrXf9zSy9jBCMpQuSJ2YHugYL8E8?=
 =?us-ascii?Q?jFjwduRDmXTY7gMTuaPj0Qi9VIhMTsHy8vPOBTapZVsxRH4WY4cq6ir0jV/F?=
 =?us-ascii?Q?tv3DdP4sME0f6mGU8RY0W03l+/gIO4+R5/n3kGGeakGKZQPDKOUbU52wJFqU?=
 =?us-ascii?Q?rlDO4RqcKUGJ3bW7Mmt+FpT2NKyj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b95b97b-3df0-4452-03bc-08df2e06ebe3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB7902.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:32:17.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB457523
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GB_MSAUTHSOURCE_EUROPE,GIT_PATCH_0,KAM_NUMSUBJECT,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Of course the value can change at any time, however the
added check avoids continuous invalidation of cache lines.
---
 winsup/cygwin/thread.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 96a84596b..424fcc468 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -1984,7 +1984,8 @@ pthread_spinlock::lock ()
 
   do
     {
-      if (InterlockedExchange (&lock_counter, 1) == 0)
+      LONG value = __atomic_load_n (&lock_counter, __ATOMIC_RELAXED);
+      if (value == 0 && InterlockedExchange (&lock_counter, 1) == 0)
 	{
 	  set_owner (self);
 	  result = 0;
-- 
2.55.0.windows.5


Return-Path: <SRS0=H8Ah=IJ=outlook.com=luca.bacci@sourceware.org>
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn190130003.outbound.protection.outlook.com [IPv6:2a01:111:f403:d201::3])
	by sourceware.org (Postfix) with ESMTPS id D803F4BA2E04
	for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2026 17:32:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D803F4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=outlook.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D803F4BA2E04
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d201::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792431138; cv=pass;
	b=EGsCIyocgRpXCyNe+gVnyw/1UmnONSkii6do6yEIhMlR1U0T5gk8A1NZL2rR2Az8wa9AYe8H7DPKJ9K3kZXk7DkXUBjpi0+MCLiNo5H5ld8wBycVqCa5A6QeVMlNERKYjHyXexGYWDBSeDR+2A1ycSCC4xr+iit17WFOv1kuujY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792431138; c=relaxed/simple;
	bh=lBfSkMYljiveSW1cq2f3opEFtz15Vbq4tlUSzw305OA=;
	h=DKIM-Signature:To:Subject:Date:Message-ID:From:MIME-Version; b=rn4KUsAAjWQrzkIQ3KJXUNHapjANq+fZpX2xPZ5DqISUKJpV/cUhOM1QDezmn/5c/vGjTXk3rMcP1QNyUVWXrNDeXI3aZHlGnIIi3IR20EnjXWZkayS6r+YPai5r3cTV5j1z0TchEOtwxh7WHdrUfMEoPXafZ9Migxw9d1fnVDo=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=M3F1TjhY
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D803F4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=M3F1TjhY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouEodZQa8qDoF+sywhor+r+dZpgU0WWW63y4q9+03LaiQ7WL/sDFyQtXNRgZmjsU/I+IVqKQxPc2xGaxDxu6wST83+hlj+qeB1bNkaBfHN4Gfhvvu+5o/SSbbiHRyVxbygKdFsHBq4b4Hyn5zpnC5DqKbf1QVi9pmzwnmvo9qnB4jYjFL0ecRsUvH6r0StWkiLSbAeNqASlVGjUC/X9CJ3KTN1S5r+pBGVwFDY3izQJ08qN+AKqwOkY+dM//brXt/WnGpsTKuwdTK1R/wdLzi/lSJeP13wW84llnOyeeVdLgLSfzEzlCzbBUlgQTrLKbwJBYZL4Kder0kRSV8LXqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWPTot95jdYQWFKKLmfFsoUcmIfZFqLuufd75aorxd4=;
 b=PjwDZoonEeCpkuVmLdfRqY/mr61QrW0oGMEWZZbfnV4wBQfSMJ6X2/9TYd4ltVAazdLFotnbVufGVowhqZjuofrRvMmAtXvgXGXxBnLN9MVHyOy09Cx+br7PQY94G0trfeYgWiS3x420x6xWBprvtpVQRoCHGHwl8h0znUb6UDdfpV52dXlJcdgG5XwCEExntV1iEIUZBC9dAJwpIbO5yzCmr9T93Go6rg0ZThtjDr4sxScS27xKZXaORVgBdL0VjMXwS8YurTDdIMAqPN0PiILab1gzczI6BCXzQLXYyWBk778XawqKqeLbg25wsM0QmUzTjTiNQ5VRc3Io+MTRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWPTot95jdYQWFKKLmfFsoUcmIfZFqLuufd75aorxd4=;
 b=M3F1TjhYLI+DU0MTrL/C7lzNlFvyoqvkxXMyZbjHzAnExeiNKsrQlYTIkJ43/WWg2s2snJq5t7ec0YelRWhaLR0mFdWicLJiJdjhVreiFoCYFX3xSIo729nBrcjQ5BtB1AIPGir1/Rf7OMoi2BVxD/eZEw0YOtRRC0MClpsCnl/7JKApHiOp3DVm9y7Jxzp7ozCQNn0Q19eVp2fJ2yzGKlZZ6OaTOHwOnHYCfPXVaVvLYdDAQumzI4Wr+4KO3mGkGe1+CFakeewiHfXCntfqYH5AUXwVWmlDXijA4IpH6h7Vpkn058BXf4hcHXriY4OrTbDKkJoMPr6k1c+fYUu2nw==
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com (2603:10a6:20b:4b2::9)
 by AM0PR02MB457523.eurprd02.prod.outlook.com (2603:10a6:20b:807::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 17:32:15 +0000
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8]) by AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 17:32:15 +0000
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] pthread_once: Use acquire semantics to load state
Date: Mon, 19 Oct 2026 19:32:07 +0200
Message-ID:
 <AS4PR02MB79026AB40766FA0DF695E28D83982@AS4PR02MB7902.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.55.0.windows.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
From: <luca.bacci@outlook.com>
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To AS4PR02MB7902.eurprd02.prod.outlook.com
 (2603:10a6:20b:4b2::9)
X-Microsoft-Original-Message-ID:
 <20261019173209.2894-1-luca.bacci@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR02MB7902:EE_|AM0PR02MB457523:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ff9f17-98b6-4e69-d9d9-08df2e06ea7d
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQkGaLwEdeYxLY7yqos8lGqVf0nA/V2ErYiCyCI3xVglqFgEcZwayvZk/qr9y2tow7f3tLFtlOV30U95D1xOaG+p5TP3s784uzD/hLhc2m6pJ4YUHQ6nJxsELExZea8igky21wMRg3T9+cj3FRuSZRh5CZdgfFMq4m/kkMdteRD0Gfsxj495CX9HXNKN795EiQTj+vfBGOi6MGDjMkK2mBHPfcoKrPIEwqyBfxlk6ObBRJNanglOQGdYj3FSSQAhSbmLZ2mYohxFD5cSglZeGwyCGYxXPF0AofDFxjGtXMpXcySbfRE/XatWQz6ZAXUvjGUF2hZJZ3LZuYKfEWWkXEx0lblleOvbGjYEtEs05anRTyS/aASIuE6v0+D1t2QXelMGt8PER5zFpczldxivwWuqqIW9+gFMhqvNSHOgsr6MR3g0cqpUW3z6AwaIaSUoqrGqFBXC5rlx8zN484M3NTkHnOkWj4SuilUnv9HrBKqle5xCwav7bbM2nIbTohtAd6MDfcQMCyU1gS2fvumpjzbHuX2wyJKkvi7cVD6qiP8McBJTMwIygWyfKU93dNKq/CWAB3HBHpP0mCF1ArCwlT/OJtEvkAkLJZvqa0SYLVZdL2fm82RSZKR2M/IzJLtB09rKGS4mAhvZgn028hh7PxTd7LUvOOOpzZVGl+zAL4AWJKBSpWHCi5Ogv9YjOXaUgGahdFYBWN4xgUXRXgqtJDGL2RCa0+Yx8SM=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|260925184616899003|24021099003|25010399006|39105399006|4140399003|15080799012|5072599009|20031999006|23021999003|41001999006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?45mXVQ8HtnkPiZ90bHffZFY9O8RTdbQDy13Zm2THa9qlXpVK6tK7EIDqYCY0?=
 =?us-ascii?Q?EVihLhBUh9/yfskO3gBmNyCNf9WejSOrctRQ0GDORF3zuEM192jURWeW9ZdD?=
 =?us-ascii?Q?6s+MpZRy4LBL582wke+cvMGSorCuk6gQowrSjGwv2yRHnXnp+caqSkH8tfI4?=
 =?us-ascii?Q?BfGUBbKBTa4lhSXo1u1VhIkpU2xc9KNP4+WHXDcZ1E1NrPahsfBdK/gRQmVh?=
 =?us-ascii?Q?tJj/nrcJUaySmwZJ7TTnXWr+JL89tvuxG56lqYtWGcfc49SpZTAaV9TXiImN?=
 =?us-ascii?Q?kEiz0uDUQZj/Qtr1lqRLPIBa3yA4pZKPJs3bPVlxAJDEiD16qAuIWlpBRcKo?=
 =?us-ascii?Q?wqSPMCECAY9FX+3INH6S7iRO4S2nMEjRgpAxRkfCCHi9uXlZkP9m1SLBXd9y?=
 =?us-ascii?Q?1buqLFmYxC3/39DMF6vUzeSaiytkpt4SMY0ddgKfhJQGsd2DbUi5W3SdqIfD?=
 =?us-ascii?Q?PrAoJt4mwEJJlBaMFbKpEhzR9xSdAGXa7awQ7w1jDTIS/Ite+IKXrIz76nJr?=
 =?us-ascii?Q?YCSUdY6YseCSxwIXBtJtwXybw9NoQ++zmn82nPRmqgphJs7mIubXqKSOKY3z?=
 =?us-ascii?Q?GB+pqsifybWZY8+Av7liui9Arcropv6AYT54z/XCXMwvLXzIggIPD9toKKiI?=
 =?us-ascii?Q?o9ZpVt8PmE2vcblr2E0M5lW26VDnFZq94ypymabF7lchj1WPYpPK13MBYMg8?=
 =?us-ascii?Q?8Rf02Ufz4g4i+vgW+WFFi6nTW6hdJRcw8gnKD2eJbIEbrm0x5MLYTmAp67jv?=
 =?us-ascii?Q?A5y7tidhIdD2Lwh6DJITQe+GFcqEpYeqhTTcyGtNOezP+PxIMpjjJZ644UW+?=
 =?us-ascii?Q?zU4kdnuLcKZmBsK5nSQz670GONloYyJWtMEEOW3E7R3tAFTsV7aic7YnGmWQ?=
 =?us-ascii?Q?LUEqJ1me+jTBL9knZBOIcDpY2X/gR8VxzeJzd1ywyfXYHI+3UbNh1fdYTWHn?=
 =?us-ascii?Q?R88KUvWy6PUJ1tS9PWAHe8RdIicLlVMMtWVzDH7iorr52/tTyw426t0TX4QV?=
 =?us-ascii?Q?Bbgx?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hprtsp6bFiasNenQY3HMYb4fWHWaIYvoDPaZmlR0wO3/dywPh//4LQvGdrJ1?=
 =?us-ascii?Q?gK/nBb6xUhfbuutCTNVZ0x9YGb6J+rWa9DTM5bT6Q4fx/aInaABatFTNwxb2?=
 =?us-ascii?Q?c9Eq8Q3q5cka0gylK1k3KvohlBTJKJ4waoxSPibBL7hughqT+BvmWgj2GqBc?=
 =?us-ascii?Q?lhBL18jyjrdvIZ+LwTzeu7ja1zbk5rrOQnG75ioaOK1Urq2fmZEItd5fpyrK?=
 =?us-ascii?Q?LRSgvaDv6oRvJHPLN+mVcR7+DM2ySv4gDR8VyzFFZKzPN9wfaEmVK8+mqdR0?=
 =?us-ascii?Q?1M0tZKXPGaZZeZHVN9cxdOICthW+Z5+04gvk9pzbTNaP/KegzhFEJgCutaLw?=
 =?us-ascii?Q?xIIgwzvgaqIvHfIVjZPtDNI6J2irSeV4WmJLx78RyQq+CabqIZVgtkaLKozu?=
 =?us-ascii?Q?zBrdG6D4bdfiVSyRLspyeCZRagCSPjFfJMLVHm5xaW+SIHFE4utolBmZptOn?=
 =?us-ascii?Q?HX2crzxetj7CnZKm8SahkJymb3dOekM2AZnJcQKZwxlbphfb3iW9tLcR7bKw?=
 =?us-ascii?Q?ZVGiobx5sce8nwjNU7D8LmFcHq+QLYdVmpsXHrkRppQTlGQ7W67LIcYg0RAF?=
 =?us-ascii?Q?goU4vaxNKfc+al9gLLAcqHi8BMyfgz2JaAVG32mf1qdb6cAgg1t8S1TXUzA3?=
 =?us-ascii?Q?Ohmm+n4LDAicYVLFqgNw9rbkixBJBOYQ2+VU5HdU4QSuATTmQ2k//GJC5G4K?=
 =?us-ascii?Q?DyPQ03o/4gcYfZP+Pi17IMhZq0YkLW3o74FyYbwwqDlEIIvURl7KnwDuq1Vw?=
 =?us-ascii?Q?ZWjGyXOfy5uDhan55sngl1EnIro0MLmYkBva228lh3iknmNMmNy/B6yPe8LD?=
 =?us-ascii?Q?MdrwizNRoZd5j16V0NMv4/OPDb+mqw6D1dBMcFJnl30GXQ+l3fOBZcqsuEjE?=
 =?us-ascii?Q?hs0pj9xbBEaFK9x11exEPL9mDJJcjzj8NvP2GzDMW9oCEE9HR5v2hYTf5dMO?=
 =?us-ascii?Q?z0iM9OcvO2hzsDI+HiaBAi0SSRDiblaEqpF2tbayHa/rN/kWtv8OBNtZxDuz?=
 =?us-ascii?Q?X9//tkfySOQ8vMlEkvB3VmqKCrfdR8BwsvRvWzFz0lz8c3sxSB8l99060ogs?=
 =?us-ascii?Q?BIck/W9XOzdeair5FCXkrGDM+T7n2ITf6s10lFKmNWct8qfW+Ek1NyR9UgPk?=
 =?us-ascii?Q?iiSzLB6vyqCzv4rjY/MCfBwoqrbEHc0zRdPBwsY/bLeAszpXgVAj1cHv30IU?=
 =?us-ascii?Q?Wsrz6yvCwwlvxJnqnR/Ru6IJ5gKId3fYBOc1gNxkjN1IZ09JdaN6gN/kJ68o?=
 =?us-ascii?Q?OyWjtfYuIvXIWU2nhEP98z8YgiS5roSx4znoB4D5kjlfYiw+Ix9wucLnxJ4X?=
 =?us-ascii?Q?a4gO2XpJfUbljUUl0k3O3Y7OHB5ARVTl1ilUAOX0WedDdhVPRSOoQB2wsn3x?=
 =?us-ascii?Q?zmmF3JvqzDYKqyYql+V2Qj+uAY07?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ff9f17-98b6-4e69-d9d9-08df2e06ea7d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB7902.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:32:15.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB457523
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GB_MSAUTHSOURCE_EUROPE,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This ensures proper ordering.
---
 winsup/cygwin/thread.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 4df13221e..96a84596b 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -2104,7 +2104,8 @@ pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
   const int32_t  DESTROYED = 0x40000000;
   static_assert (sizeof (once_control->state) >= sizeof (int32_t));
   static_assert (sizeof (once_control->state) == sizeof (LONG));
-  if (once_control->state & DONE)
+
+  if (__atomic_load_n (&once_control->state, __ATOMIC_ACQUIRE) & DONE)
     return 0;
 
   /* The type of &once_control->state is int *, which is compatible with
-- 
2.55.0.windows.5


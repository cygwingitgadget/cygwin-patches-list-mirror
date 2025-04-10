Return-Path: <SRS0=zxvb=W4=hotmail.com=Strawberry_Str@sourceware.org>
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d405::])
	by sourceware.org (Postfix) with ESMTPS id 04626383941A;
	Thu, 10 Apr 2025 09:11:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 04626383941A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 04626383941A
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d405::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1744276305; cv=pass;
	b=b7RvMVLGsf2ZnoRbOTeBOZGqYA3U2fKxXfJOI6opi9tSQx8sSJeB+JEy3hRSKmO4kzljXKX9TbgVfl38JfrmX+IUF2bAjE2IhdLk1kPKqHhcqUuufvoUFjF1jPTSAHW43hiYtUwF/22JMJd1Aqpo5ZU7RAxym6nCBAf+Sgdi9vw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744276305; c=relaxed/simple;
	bh=w/aAu9hjCJ6QWW4zmqH8ntGlNdslGI82h2qNYR+vyp0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=w28xXsX/iUXN4AMl4x+OoimHOtKHmND3RAlKUb7gqMTgn7Mg/tFclw0RzYbJwBRGmUUQVMk9xaDkWn4AEdc63hJxlFkitC68sdMDGuloo3f1P9rWiFZyEoeTyOaHbVO16QJ/3O2lAzKDoPK8Hhs3IPUk6mk6oOnhgijX929eyro=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 04626383941A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=tPLessgR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAvmzuEx+XQQQG5V/kHq+6WfDCtNJ7Lsq9CnBHx/BCpmyfynZRXskFxFoO7mHF/1si9BmUAFshbFYZks9TRcbHjGa3WLy1BocxDBKCSHVs1ZyAvq5C+k3LjpNwHrXE55I68tCTHwhjVEOjkeT0IHmAQsiaDbZNbHz3dpqnHVj6zWaPXQPdBN1IWfxgsXqfJXtqVnRrTv7WUdh7HVmSesEvNt+1qMvPN6nvdrHb35RjlXqtIwGEQOFbXXNCEQkpd7SZuBdYOC9Klu/Go2KTRYN78ymIbYb6v9wm7GKpYbcqNsiJoid6mm7gud3RKXl37DMO0tbIEaKcxouJMm6gZkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MGH20XseUZR5+8k+Se2jZYiVaOiGWUe9jvY6jhV+Xs=;
 b=tca1uAEacjUumj0p3/xLsThipTqWC8BeS1UDX5Ln+LjTdQFjtdYdYNKWItHxP/q2FHDks+vFKK1b9kEZT8Pzrr/QmuypQwG5FPvh7/FxQL2Qg5X33Fv1qyMSCbtTj1fvtbqKKONg7e/XKnmdjKKlHd/z/2fOATUEZ8LiNr1oj+XGD22XSwZSQSaQIIzEhTQszqL9zDFodhg9T+hL+KQNW0xDEKWP/FtbH1+Ym8R7lLzncFOi8GANIFDz/id3MU+/XuYftVCXC+apLici0z1moEusb6Ucz0WI0dlnmcpRp3bc0QSHbW9QXDfVt1/qmnVmwSBznUKyZSg4m4/cZBXQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MGH20XseUZR5+8k+Se2jZYiVaOiGWUe9jvY6jhV+Xs=;
 b=tPLessgRbGsteSMO0gpQHIyfLopmPCjgsIO9OCSmSY6TYfUVT/Ifkw2Y3ozuAuLoUY0tIpokfNkXijQIwSuOR7slbh/QHJwvEMCuRv0k/yPsC/AFaDKnu5DT4NR7g9F3MjBwGhV+hbmmekNOBZYzi4+yy613yVdWJ/zbr7DSy+tzgkb+QnPO6tDJOP/Z9lW0Lirn/iazv4TvRo1e8hhac8dXxSkvfMJjEv5G5/NhbVP3l4LNUOe/4OOVZzeI6L7+xki2mk713r8KuErAQ8h0snxKydDBagF4VkPafT9D7tPRZ+eF49FsJq7y7HozCFYoJqWB7A7lr94sf1x0POfTNg==
Received: from TYTPR01MB10923.jpnprd01.prod.outlook.com
 (2603:1096:400:3a1::13) by TYVPR01MB10812.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 09:11:37 +0000
Received: from TYTPR01MB10923.jpnprd01.prod.outlook.com
 ([fe80::4c74:a74a:1e7b:956d]) by TYTPR01MB10923.jpnprd01.prod.outlook.com
 ([fe80::4c74:a74a:1e7b:956d%6]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 09:11:36 +0000
From: Yuyi Wang <Strawberry_Str@hotmail.com>
To: corinna-cygwin@cygwin.com
Cc: cygwin-patches@cygwin.com,
	Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: [PATCH v2] Cygwin: fhandler_local: Fix get_inet_addr_local to retrieve correct type
Date: Thu, 10 Apr 2025 17:11:10 +0800
Message-ID:
 <TYTPR01MB10923408B508C363BC8979A6CF8B72@TYTPR01MB10923.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <Z_eDE8Gw7WuGGnuT@calimero.vinschen.de>
References: <Z_eDE8Gw7WuGGnuT@calimero.vinschen.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To TYTPR01MB10923.jpnprd01.prod.outlook.com
 (2603:1096:400:3a1::13)
X-Microsoft-Original-Message-ID:
 <20250410091110.77562-1-Strawberry_Str@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYTPR01MB10923:EE_|TYVPR01MB10812:EE_
X-MS-Office365-Filtering-Correlation-Id: dced53d0-7d07-4bcb-236d-08dd780fb21d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799006|7092599003|461199028|8060799006|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GIqU9lMQzq/L8dG5+Q+NQzgZ+pckz73cAbiqYCAAx96n2TdDEWz46jqrWXv2?=
 =?us-ascii?Q?d85PTHqsa0eNdCR1ZvU8hlTMk69AZRJ4DhhVjrCEz7nGucGGQO2E5Ceq8rGt?=
 =?us-ascii?Q?W+dIYM7B6hHjLxmV01cvohpMkKWmOrNUkapcy3uBrLq3GvxmpH4FC2Tmabh5?=
 =?us-ascii?Q?mr7+/B3lzUZV+Y9e+1V4BcGJf1Yi1IFLS+AH6qxAdY2HR4yORCFBtPWLyBjN?=
 =?us-ascii?Q?EMb/1WP6RMN82QUvfd9ErZq2GPc1M3e9HHK76vL9vbyc160kBsdJZaftQDZc?=
 =?us-ascii?Q?TBdzJsGbCo1lGK0qfITdONITtJBJMUyqlvlcAkuPNzn7yKPGIwbz5OJGd6cp?=
 =?us-ascii?Q?NjhO4M44wwp5zFzRnqAocSaH4IMWuGbA0XQ/fLPFHdRpsynZ30jwhCVmocdB?=
 =?us-ascii?Q?SSBnShIQTnwjWsl/tEqY43HFMmUVRuXfJkueX2vhk4Gu/0bkRAOneJ0568oK?=
 =?us-ascii?Q?EPgmi292vUOwUs+tIJES2jRYq/EgO5+RDOUxNzuSV0BGg633oFYJfvRD26nC?=
 =?us-ascii?Q?Jl6T1kpJpVCEBNYJi8edKQfnC/eLZyNuwC6vpUdvEmnYmE9Lc2tRY4cIklDN?=
 =?us-ascii?Q?7LQshFFViJXL4KdqD3oc6+biWOzA1lclHS5KWbUXqgCYxskc+KJlh1EqxpWm?=
 =?us-ascii?Q?Ks2Gbz64fLKDv8dULYRnfnxPJz10BqO45O/Vo7GZxFkBT0YQoKkrmW9J3bKK?=
 =?us-ascii?Q?q060z0VWoB5sa0RyS7zYLw1xD3REqBIwigIHuK4coyXzN1pSo4JNe6U0nV3M?=
 =?us-ascii?Q?koGC9mkuQUIv178z9KTu8ugEgcpNQjeB/d98O4TTeONsE2we/W5p3T3P+Ew7?=
 =?us-ascii?Q?YHZyrscP+8my44tnkxKUwYyyjSAdQwMJRgmX2sceywFbPK76iT95QKx1Sn0Y?=
 =?us-ascii?Q?v38XtGREqZg98osiW2sUdy/Mr4Gh8PWem6WCq9fRhGSk6TMrdGn78nAv6j3J?=
 =?us-ascii?Q?v5+eZEgtzpcpEAotGlfaOw/9Fl1rcRFxQk2Z5kOWL/xBheuQvC9kbn7V3/Ek?=
 =?us-ascii?Q?3M0k7LrxHX4fiwrAWhElXpKOz+BpfubwNhpCeaMrZIRHp4Lp/mviaiDylgsM?=
 =?us-ascii?Q?yTOmspnd8dg7ceev1r174/bLeuuqJerXZP2MtONitWY7bZSw15Obhvyr8AMb?=
 =?us-ascii?Q?MLP8jq0IwF28deAbPGy1Vw1nFO1jsBg/a2ADgt9JeiYvM5dZp0UKZfw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JYX8GKBIgwBSvBWO4nEtnR+dzPrsa44EJwc53g5R6z4AM5ILuCez8wEqzswE?=
 =?us-ascii?Q?yo1KAyqpjbjk0+ye3f7qNREibnxO9BF3q2OLOu+M4WuTuPtVtbxCrhvwB55L?=
 =?us-ascii?Q?9rupXamMd69al+/vRO3Fyd33mLVlSTRKxsWpOqz3U3L2/cIL7slHoHh40C/t?=
 =?us-ascii?Q?FpAwfQXVvr2rT/qekbQngUq1ciW78m/iI8KCD4T9EQJ0uqzgGyCzbj5KkRzV?=
 =?us-ascii?Q?YHwiaA8t0ggoxJ6eRF2hAuRs6s1SYmkmtbvA6tcjhVmfmjVgzzpkJtt5uh9T?=
 =?us-ascii?Q?5oJ9rTu1qM5dTstr0t7MC4MJSDaiBt+1RYz2fTa+7D7jjw+GgAkL/1UypsCb?=
 =?us-ascii?Q?5U2Jxk8ZZ44d8uvvTrabeNp7Rzgwi0wvsT+smyYXafKYfm4jhRDXeBfdd3Co?=
 =?us-ascii?Q?mTIAlQHuMTFBy6fsPcIzHW7EO25I6b08zVZo4R69Ns2QsdF2mBvcja5k4+gc?=
 =?us-ascii?Q?U0UbotSoj9CPvUOJqldXECCI+TSlJ5p5Rzsu18EYwjJlf5NzvAGR97yPgBnq?=
 =?us-ascii?Q?fd1G1brWOPyK8EvlX1rfD8Gu7aV80ErXVbOfH3wvvVeoLvafwIe9z76Xudfg?=
 =?us-ascii?Q?pMOzPbG63ecgjIkWVcsHXoBcHOtoez53Q6xPFU6x2q3kiZz4491C8qzzAwwz?=
 =?us-ascii?Q?jjaIEnyrz9sUwluPx6JRws6M9XOtTViSCeCowDiuPx5q0xZucVaXsPBCcBPN?=
 =?us-ascii?Q?JBIjw1/WhofAiRyPEeytprpHxlfrD4RsY/kq2turuOz228b1PnxU3gjXt1Q7?=
 =?us-ascii?Q?08EbZkqzvH3+0gLO+J4NeqxTyUrIQ5heUP0lIEVWkVucB1gmrNfKvSmvMa5Y?=
 =?us-ascii?Q?ooT9PTFwiIG62RJ9lSrpYorK6rL4mJPdoyx9RoruXcYsiLarbRito5vOWIKj?=
 =?us-ascii?Q?EDLYT85nSsWQlY7io4TNAeRWjgc1Ia01cx24IJsw++lTali2RmdkKe2gOwBq?=
 =?us-ascii?Q?kHdkdisoYihN9a7to+hRWv+PYbVLUFPppiLy6F2SWirs0l2lNj4z+65kqZ2v?=
 =?us-ascii?Q?FZsLTrPvZ07nWlANSze06mtOLjKn5OhnhYUemj1106sc9J3DDbXm2hpuHjUo?=
 =?us-ascii?Q?8Tl1ZXem1d6C4FC/qGmCUwMVpIjPwNeA6vERaSaAe/LWwK1edzs9Gn7RXqBC?=
 =?us-ascii?Q?oM4hMXoFd1j2L0pUF3xnOn5YgHonCjVPPIa2U+0nkRL5c6az62WdvjdNxbOD?=
 =?us-ascii?Q?M/sdIKbPLjxX1wrHvWwOGRunWYgb1ej+TrbocfR9ruawNVMumDi5sTghLoYN?=
 =?us-ascii?Q?OkLl42k0UEohUT2aPJhusrRgA4i+YDEH+hMOAjaxH/tXKBQ06GUxkAOZ0vxC?=
 =?us-ascii?Q?0eY=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dced53d0-7d07-4bcb-236d-08dd780fb21d
X-MS-Exchange-CrossTenant-AuthSource: TYTPR01MB10923.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:11:36.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10812
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

For a datagram socket received by recvfrom, the type param is not
assigned correctly, making fhandler_socket_local::connect() to return
WSAEPROTOTYPE.
---
 winsup/cygwin/fhandler/socket_local.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler/socket_local.cc b/winsup/cygwin/fhandler/socket_local.cc
index 270a1ef31..ea5ee67cc 100644
--- a/winsup/cygwin/fhandler/socket_local.cc
+++ b/winsup/cygwin/fhandler/socket_local.cc
@@ -87,6 +87,8 @@ get_inet_addr_local (const struct sockaddr *in, int inlen,
       addr.sin_addr.s_addr = htonl (INADDR_LOOPBACK);
       *outlen = sizeof addr;
       memcpy (out, &addr, *outlen);
+      if (type)
+	*type = SOCK_DGRAM;
       return 0;
     }
 
-- 
2.39.2 (Apple Git-143)


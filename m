Return-Path: <SRS0=4Pli=WR=hotmail.com=Strawberry_Str@sourceware.org>
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn190100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d406::])
	by sourceware.org (Postfix) with ESMTPS id 19FFC3857437
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 15:00:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 19FFC3857437
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 19FFC3857437
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d406::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1743346857; cv=pass;
	b=CeDfnlriDRaJsjhM6CqOetO7U+jLwEfA/mZWB21yOMAyIUYUUJqx6U8kkGDjnUmTaL3NDeYUrFEOGkD6HxLM66cOTvpjQEgPYhdLwxueRP57umfdp6mw/m8DyEejAjguB4lZjhPRl4nOwZBHbYvyC9CzdcWTeKXRdvVwun8gX8I=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743346857; c=relaxed/simple;
	bh=78xvklTlCCoM54TT1DWm+gySgKfu8K1kS3PznljXa/Q=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=eeId4A0Ucn7t7XTYCg6DT7qwLDGhFetpDNhPJ/wC2MG2LCngPucsBIcX2f6a0eOr4ElA0+BI5YRHblhvZ0qRmEt3zu3iBYjRjDEwbq0lQXvc6ygijdnHgqsgIsIut7jn4i1QeEbuRBN9yimNnh+OOlIRsJ2w2T3SzOkXE2JJcW0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 19FFC3857437
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=C28KbC4D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jORMQhA3GcQsITfnfsqwhkP2pLif3jD9is0HFxikXRSSzI435AHerZ8yv/ViPCiZhjYXX2TPjAQGrX1dSas69p4nOMQfWTmzjzY/dVLIJsHf1gqe9kL87IpC2TTaixnwGkPmt40RTlVcc1jqjb9TkoJqFppwZWza3+RajJgpSMKGgVHi5j6xN5GhQnaRd9WdL+4hyFc/kMZP1TAjd+7XHUUaD0B2vKqwoTYy3O6DcaFoJKSYqY0TO3U9bzX2usJ+oW8IYrJnhp7jSc34f692nU+CtDl9cytMNOkS2Eo2Y2cbfmR+9apFYs6gQFnsTLD3Nt0ieyyut16a6G1JDvcbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6VqHDE5wKIuKjnGkS5v3Fla5glphyL2Fk5G0PUqXFQ=;
 b=Ud3iExewt96mvbTFUPadFbfPLfwCv0dIws5OIwTAQhiuUcx0nBkRkeK0GCB+y0namKgAQDUnSXLe6rEgdNK0sko0mLx48jcBIWP9FK08/qhzq7550AM695wCzjCB/Ge9euxoC5x15Cga1NXbvZiCSIC3zzVAAr0K/FirMsVe8JHJXMVYLVlMj2PBQd+ddyfYUlE6QJMreAlC2u/ZoyZOsSoXTXj5kcn9YT+PKcRIKEMUYJzXshXtKHZDB4Zoo9swUpE/rKtqXm1OaCd4YDIe8XS4BjzKiyAUltpQ6TDAl2VaPOGhz9O6r16EUN70elzoyu4AUDcZWN37+uq+TOxyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6VqHDE5wKIuKjnGkS5v3Fla5glphyL2Fk5G0PUqXFQ=;
 b=C28KbC4DxKB11bYlTCB1pIV3gKm1chNPKE0pL8WUNo34wCCqWKzDZ3ukHnwkZtrxV6nP1FsbvnF5wUvlStmOQFP37hllcYUKxIKrgKs8b8SHKonfTG0oyOqY9K/qr/C4n5M3RgPQyF8/4JoZCSrpYKxR3QUICNXs1JuRpJV/WFc8Arns1ke8cyrs+4dkwKSzoto+F2bVi6ChYdoyCEyVbifCTpBrMe9wq0NtG/yCc0AmqQ0KQya47qOiRtPbruVTcPwHCtSlK6iaE7HkGhbRPKElUTEXUhg0cxHtV1F5EaITH2wR+nXehGQuGa06Z9WgW/qw6T3Yzea0zQCnIy0oMA==
Received: from TYTPR01MB10923.jpnprd01.prod.outlook.com
 (2603:1096:400:3a1::13) by TYCPR01MB7042.jpnprd01.prod.outlook.com
 (2603:1096:400:bd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Sun, 30 Mar
 2025 15:00:53 +0000
Received: from TYTPR01MB10923.jpnprd01.prod.outlook.com
 ([fe80::4c74:a74a:1e7b:956d]) by TYTPR01MB10923.jpnprd01.prod.outlook.com
 ([fe80::4c74:a74a:1e7b:956d%5]) with mapi id 15.20.8583.033; Sun, 30 Mar 2025
 15:00:53 +0000
From: Yuyi Wang <Strawberry_Str@hotmail.com>
To: cygwin-patches@cygwin.com
Cc: Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: [PATCH] Cygwin: dlfcn: fix ENOENT in dlclose
Date: Sun, 30 Mar 2025 23:00:35 +0800
Message-ID:
 <TYTPR01MB109233E1CD6728FC1CAAFB90EF8A22@TYTPR01MB10923.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To TYTPR01MB10923.jpnprd01.prod.outlook.com
 (2603:1096:400:3a1::13)
X-Microsoft-Original-Message-ID:
 <20250330150035.123683-1-Strawberry_Str@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYTPR01MB10923:EE_|TYCPR01MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: d93784ee-0daf-4d7e-3634-08dd6f9baaae
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|5072599009|461199028|15080799006|8060799006|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1qOHN1fnwbjX3/jMFwgUQh2Ul5DVhnsavZs/5/iLzM8SLZ97q8ZEEIFEBFC?=
 =?us-ascii?Q?UaxL+VL5gMa8SSAqFo16bvZr6JDwzjIrrVOJNDa4C2lJBRCCjV+4ru2Pthag?=
 =?us-ascii?Q?7vOdYD+Q7OB6V2cUvxhmMpcTHaG5N2Elc7JCNeHzncgmDmyr/7FBNd1+wfss?=
 =?us-ascii?Q?mJvh2XhPAgjlBnJ1/SI8P3qmymoz+1YpuhN1GKQepPaMMGTdCoi1MTNZAzxd?=
 =?us-ascii?Q?zjKHcf/bAkUlfQyXRjJChAbD9nAHozo63DCi/VT37xI0s0Nn6x1iSn6HjoVM?=
 =?us-ascii?Q?xeVxe9rzy1MQCvnEU8Gxm8WBepOUGr0zwG5W/i6hRljU6Mor5zs7eJ3dwT+P?=
 =?us-ascii?Q?w58Gg/i7ZEW/KqMPk1bk/kRYgCB/VKg+FhFcm/WFha6yI/411zChLWWVj0MK?=
 =?us-ascii?Q?JzJmOvPjJxv62gcL5KFdEhcJMuIgBhvBfUwYbMGq5FmJdgbNLnSqi8V0ML9b?=
 =?us-ascii?Q?UYW5D1QNjDpuGKFCoPW4xF3XieIuejVWT0en7g0lcF0tPFVVSC1zjnNZZ/ay?=
 =?us-ascii?Q?7hvVJaTq6oATXE8kduYmEYxsckOyh1NgB9plxMmN4z18T0S8mOfeZpqrfa85?=
 =?us-ascii?Q?4W22K+tpUcPDQES8jcuATb0ZjDSLYRsHiOwOhw2GMGEF3OajK8Z0bhkbj5S2?=
 =?us-ascii?Q?nYILCgleRwthv50hg/7+Pw7DB7j2ZhKcJJHsHhDPV+N3v4aD4F1Go8J8SO8B?=
 =?us-ascii?Q?Yr/zRdIyKvKUJ+wzDa+q3hGlts7TllHk486r064psgcSVpM1D6ffcwkzN83e?=
 =?us-ascii?Q?Jt/d4JHMKbxvzLHZz/RPFinOT4GsDydmBe3UtnWWLBsfzxSWdWaS04FqEyMr?=
 =?us-ascii?Q?4Wdk8No9Gi/kPyPzirvSvW1UoqtKLt5bV09Qj5QZHA+1HLQWijBMw8Ermk8w?=
 =?us-ascii?Q?GtwVgvFp2d1iFN4dWGXA/Cgh7aFb52QwIhs8fquHicr8Kdxz3+C3YWQU8Fuf?=
 =?us-ascii?Q?AjG88bHU/bydWeD/Q0NwxZoUK3Z8LGttmoNV7chOaD7D0Ev4hmEMcnDUuhUE?=
 =?us-ascii?Q?98PxKtbZbHlbmPjFKhouDLG5AHUZP0/iB6MVx07y5k0aSd3AIwliwbM9u5xw?=
 =?us-ascii?Q?ADzpovUye0wLwva4byhW0zLF2uncuGvf2ctoAr7pn1MY/L6W3y05QluHvPsx?=
 =?us-ascii?Q?xwVWhtPfkdqOJbuh1hE3BphCPM7HjfiE8g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BRdh4GNI/3QEbAZDCnGiAY9NxOHF4lvmv/s5F3ri0MhdvI6DC+H6Nr/KgfOt?=
 =?us-ascii?Q?lL0egqVUjgVbB/tTQss4qaPCy5cZNkU7Y/3rd+mgATq8wjQw3COLqlDX1xUH?=
 =?us-ascii?Q?Pya220fIJE4HHu1HxV0Et/BQpbZiENxt06p6JKRgwKa6+X1/nedzgs8KiyUv?=
 =?us-ascii?Q?wJ4ofbPLO6P+bRHQOk61nNMy6/LxasTjlQjMZJRF97YeC47nn/3RphTeeoFC?=
 =?us-ascii?Q?oItuoPiRwcBxgGLHYUN8HAdl4yxNaRT8MneinOfw8boiEPzaz+xTXDzlV89A?=
 =?us-ascii?Q?H8Cmtmi001/pTp9r90wJ9BWD7Z3G3N406FfbJdnUjFydaYho+0YTSjfRN9Be?=
 =?us-ascii?Q?FYZKEA5AjoE5ZsnmzVA1LNKoDqp2bibS53TqgeEi9sENX0RNipEwTguQzofJ?=
 =?us-ascii?Q?+LiXyR6UEJSmnQXRhFIiIRBJZrlU0mw00ejFekKqHERE9JmFriXyWew1wNNQ?=
 =?us-ascii?Q?x1YJZUSuPLDFb5/iTjaAgZXwSELKVFIaYOGj3P7wIBVlFVSYqLH3KdWhVH4d?=
 =?us-ascii?Q?thpoQS6re65mLpczSrVjmgvaRWp/jXEKrlB9FyPmWSaarXO3fYxLUY1lEWHQ?=
 =?us-ascii?Q?oASgUJDZ5TCHJhh45orj0F88Fc68CNgCmQPiXNynS1WPvQAIDTqC5PJDVUyv?=
 =?us-ascii?Q?6WqNNnYkNKV8DOZVxS1B+qQgTQ8YoSFWFP38jGGEq1VqQMt8bKhB5PeB90NR?=
 =?us-ascii?Q?o30fMbuFVuz4/xcPvREkW5XnSfhIJueDyLagX3AxGCCCdpF/LkVzTRMYJC8b?=
 =?us-ascii?Q?fVzntUihayPdX9c0w+cbTcqSSQDYbPgCQEPPEHCIxH5kV2SFtyFSN84v3C/s?=
 =?us-ascii?Q?C9VGZsIwTvYzYkTBNSZs8K6UwK28xeDpE/NJQs+xCzwrArlhetQpJa5OJTMn?=
 =?us-ascii?Q?bgIzizCTC56g74zOtk7qP/55J9eKxB5hbtGCP72lY6PeH66+gZq8AZCoONkR?=
 =?us-ascii?Q?z+DPDOusZZcc/xvfURN8PuxdQZldQ9RWenon4J/itouZAZiP3PZMUHlnAaJl?=
 =?us-ascii?Q?akO36YBRAEONVlivOOncDur6TNNfpydXJTJVBmOZpJy4uV4+JUrMfhwk4kdk?=
 =?us-ascii?Q?aSafNOiyNBwjW2Vs0eGIBPK3Y4tA8ML5ixHabaHymS2A9VF8a6qO+PHLzNwF?=
 =?us-ascii?Q?ZYtzSieL0H1yzkF+e4fyaE1vWkVCVwfAA1sy9uVMg4nRHWf1nnDnUaJLe5vL?=
 =?us-ascii?Q?PgcpL9xxany58Fy/mHVzZYfGV0QpVC5JYoQ7mfzoLWwEXCp9VlM4crOtWapi?=
 =?us-ascii?Q?9Wdnxr5d6w5RltE5KUyobENR4N4WAhqPpr3ZbZjHOA=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d93784ee-0daf-4d7e-3634-08dd6f9baaae
X-MS-Exchange-CrossTenant-AuthSource: TYTPR01MB10923.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2025 15:00:53.2167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7042
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

dlclose tries to decrease the ref count of the dll* entry, but a new dll
opened by dlopen doesn't create a new dll* entry.
---
 winsup/cygwin/dlfcn.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index fb7052473..3093ec1be 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -350,14 +350,15 @@ dlclose (void *handle)
     {
       /* reference counting */
       dll *d = dlls.find (handle);
-      if (!d || d->count <= 0)
+      if (d && d->count <= 0)
 	{
 	  errno = ENOENT;
 	  ret = -1;
 	}
       else
 	{
-	  --d->count;
+	  if (d)
+	    --d->count;
 	  if (!FreeLibrary ((HMODULE) handle))
 	    {
 	      __seterrno ();
-- 
2.48.1.windows.1-2


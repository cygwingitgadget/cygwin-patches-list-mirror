Return-Path: <SRS0=JsoB=W3=hotmail.com=Strawberry_Str@sourceware.org>
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn190110001.outbound.protection.outlook.com [IPv6:2a01:111:f403:d405::1])
	by sourceware.org (Postfix) with ESMTPS id 41E5A384978A
	for <cygwin-patches@cygwin.com>; Wed,  9 Apr 2025 15:58:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 41E5A384978A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 41E5A384978A
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d405::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1744214329; cv=pass;
	b=t/7/svvOZ3FE5otX65mn0AF16DasueK6ZCl0wzMuYLVudivkDu5YPz/syqvD30CI7NGTDqbKX/xho4fyhA7lhHmrdRy14OB7pY1rzlKYEdr1AvW3SHRJR8wsiJKiNMwHevdXOIPvphzDJz+/Tjfr3pYQ2tiTGX9PxMJhPwD8dQU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744214329; c=relaxed/simple;
	bh=FMWEHYs7Yy8NJoRAtJ6I5ELBtP/Vx2JbVrB7P+okMA4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=RhSkjPcQpV2+XSPI5D6rqf0XgTJRRocs3Re5Pc2s0KnWUeB+SD5eTCsIrKffIResiUPd/ydePoJhlM14OrwAqmwN4UuaG+q5r0fLWa0uoc47ZEQl3Nssws9GnDNLCdD5wPULNzjsC/ds57HOPHa+6qSwAC+8jLaoXosah3wvfuI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 41E5A384978A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=DYnlivKL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ije9Cckle1EtCuf/U5FmxM/qfSfQm/TrKoUYSAGNvK40ZPj/5OEHoE7lb40oOohJpJFLSRJMkMz/fUgCtS186zFKkxLU+NvUNLAE9h6ICuMhjGR5lhYjsCneCpxvZDdE4dQcM/SNRCyCuZ1xB3i7ANB4XU/nYopDB6INk2xPi5zYVcjVW5m+RkgXXjbQCaW0Q59lu3G+eZClXh96tL5pv9GPpR6srNE1CsSm+KuwMbb4hnmkM40H61nxc8uIusEuzRyUhp4VOGBz9R+aqcDeyXc0tNTDud13TjmBwtveEwdahA2tbh2Y+b6FKUQQlj3lyBprTLNzF93Jj/MgjmDXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfoKRpc35NjIE6P4rtZbeqHOnCqHgc2aH/iPz2FyBH4=;
 b=dpjwZPcQgQc6dXFC5LkDaGyTdMVH07HGtnJQuNUQj9WGvUFghvGbj3kYNDyBGpJU2Chbd3bWdRpQAS14Dg/fXJmnIHiCjXudr2Qu/jduppN6mf5YLn4CHocvSHz76fxNTN4CS9kSYvvcUDEVY/xRszUgjF7V1iKXLsuzOJkk0FDZzWRpbGfrYimrc4w8DjRz482jkog4qAVqLxmXYpKIljgnybp/v9900p6QpSsGdyXYb9N5dK8NjJ2zG1lLhCJKzF7PqjHUJWwQS+4xHbgk9NvkccdCPl1QILDmemd7gwSCgf+hcpZWWrjF+XsDhWgjVzwn6cmq91nVUGmL4f5Epg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfoKRpc35NjIE6P4rtZbeqHOnCqHgc2aH/iPz2FyBH4=;
 b=DYnlivKLCYxtlTQA8L7y0r3i4LliYvB95BZBbhmhQs9uI2WaBt/8w3/iRev7GDcD80ufgJnCVQRgsE/hvZjJK/A5+NeGZJJPwCYSsIhMlKUMUb3Hcu3uejiY2P9+nJ8qs1FlK/6K4CQRHhKxDjCQOyZsgVoXQHOInXvTxTBx16B66v0GomeGqAncPovjoK8cfCDc1qbFLcCsVj0QxG7xg76NsnSdhMRRUi9iIwrYNTWzz7RSN4N+l1ELy8fucKBRGBudjqT8gkO6RcLmqWGg8MQGQlce2WL0fkrAM+vA7nw4blWMjkYXKp6oAqa+1ZE3F+XNx2o0ua+9oLZtjOO+/w==
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com (2603:1096:400:3a3::6)
 by OS3PR01MB10325.jpnprd01.prod.outlook.com (2603:1096:604:1f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Wed, 9 Apr
 2025 15:58:41 +0000
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209]) by TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209%5]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 15:58:41 +0000
From: Yuyi Wang <Strawberry_Str@hotmail.com>
To: cygwin-patches@cygwin.com
Cc: Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: [PATCH] Cygwin: fhandler_local: Fix get_inet_addr_local to retrieve correct type
Date: Wed,  9 Apr 2025 23:58:23 +0800
Message-ID:
 <TYCPR01MB10926E79742DCF95AA5CD2928F8B42@TYCPR01MB10926.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To TYCPR01MB10926.jpnprd01.prod.outlook.com
 (2603:1096:400:3a3::6)
X-Microsoft-Original-Message-ID:
 <20250409155823.7845-1-Strawberry_Str@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10926:EE_|OS3PR01MB10325:EE_
X-MS-Office365-Filtering-Correlation-Id: 8116bc90-a6df-4625-3e02-08dd777f65d0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|15080799006|8060799006|19110799003|461199028|5072599009|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4z8QBPgFKt01zDQ6W1IHg/Dh47varBGCWpFYuwnLchLvkXMiB/ZeQARiRXW9?=
 =?us-ascii?Q?IZhTUK1JqjiovbRrRxu+fXXmRi859K1Q+a+tP0BU9oPN2kHMP3ery8iNjFX1?=
 =?us-ascii?Q?zQkB2kw0erwSgm5bmufYVBcvarVYwLbBq60JnTW0ceWuikJ87tKU5alPf2Ka?=
 =?us-ascii?Q?gIzKz6Ack5M/emDD3oLbJVHTMnl3JmBPNKDcXX7Cte0hzc048XObwBS9eTrw?=
 =?us-ascii?Q?1Cr3HPrB5f2zaSxQ4YkOXx1xP0oBkV+QlwJJSx3KIV3h01P3hhiIlwoDX2jz?=
 =?us-ascii?Q?tYOu3qt3wJgljVsLTlA10D8rfnIJsfSaJsOtm6laU0lDa864eWz5LDPPJ0ji?=
 =?us-ascii?Q?EuDlicpMSt0pKKFmhGzbT3gL043OPbO6My+2jDYF5hc9opufqtBhsezDCp1X?=
 =?us-ascii?Q?u2o7T+WshefINb2a4OSjWqHCyvUDi5t50JYEtAWxxhZaVLYnDHlcWpsw2bKa?=
 =?us-ascii?Q?3lm13k7Xrr8z6l1Hg2YwlgUuh1pbYEn3cq+P3OXjVK7BCTnCPjYPb/eEIWSu?=
 =?us-ascii?Q?SrAip0Eu1EXBFJ3oVVgFpKaFOqSy4L6uzZxDr+YcOOnEScUEySgKTD+7bU7w?=
 =?us-ascii?Q?KVo7JD0Wy5zljskKXZY+3F+Mq/UFTy/tdWQW52QjcGprY1LQhkLJ47ROD+oM?=
 =?us-ascii?Q?9LUd0DiPAKlaZgPZ326nTFms/cD7pLOi/Aahre3f3GC8+IPUNLprAfcURqfj?=
 =?us-ascii?Q?Z63wZNj2iiPWNmixVBpFI45hFKi3p3CxNAstVPi/4tgz64GxFKhwi6wEg1FG?=
 =?us-ascii?Q?PK0JS+0qAC/dN5CiWTuoydIWhBK2Kahv6vfXH8CsHhvZ3Z0eJlIEJYgZnrRM?=
 =?us-ascii?Q?R+9vgVB4tJSbKszVQpofichwmnyTIDPEb/FpaduJB+hY/VrA1AWmaYgZFkeL?=
 =?us-ascii?Q?1lE+p0emcBMP8Fs0IaPwedmSk3QOcQYzGvyV2J0rblXkTm5uhXPWAuyiTQdC?=
 =?us-ascii?Q?Re4K8muT4UIEsDSnVLwIVA+7K9hkb//kNXNawyADqKVzfMAJclV6IUaYMlMY?=
 =?us-ascii?Q?i8NAoc3YnTJNcKdFVOa9efY22AfnY60IymJXVkis1Zt5oN2+sdQui5TBGqfn?=
 =?us-ascii?Q?kY9ei+G812qILvKO6TzNrtlWsDrn8VQqubm5SBw6V8p4kfaCoOsp2bywz2he?=
 =?us-ascii?Q?yNSHcsjM8VJrIByPEAg7nG7D/MYFNDEm1sHIQmHUtJa9Ayw417WzDqs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ePdtycTiH40AXkjs5BuYMfzW56OozERD+H4abnCMocRf3fRzfZXlzfYFwS/r?=
 =?us-ascii?Q?LdAw3WY/n0+vDwQAnB+V8eCUY/Wxwt4yn9q7dAGdA58IufKU1BgCExqDqGR6?=
 =?us-ascii?Q?hAywQLF5sOMJAGYO7VBw8IHMK2zStmz+t0ARHfZW+LWLT7QgQhR3Fs5M9zdL?=
 =?us-ascii?Q?hk/PUZ6uE8QvPsEMIg061wASJdZyMHCOZ6fps05+p/4OZlwTCkbui75GOVyA?=
 =?us-ascii?Q?SLBWWryBSrlfBYnMM6j/mWphxaW+WZqrhhEbkfShY4loDuuqw50U2TYBmSzv?=
 =?us-ascii?Q?dJYI8nJH6NjGmC+nMgcsIi0cY8E6BANL0Kzh8mv/sDNroeEZMT+V5FTz7Vb8?=
 =?us-ascii?Q?lrd6qUTY3mwD5/dleGW6NUEJ8p9TP6yOhqzpflEJAyBiMm7R5X6p60UjO13f?=
 =?us-ascii?Q?ASkKAVU5CjTOjZHjQB3t0qjqWGTPbzMdoB242eVXsuA81VOUfhPaM5EhPSH7?=
 =?us-ascii?Q?4m5yyuktWyHJp8iI00s48N5fGdxq0oGXSoD0NnWAgLD9RTWaNkuTnjT+lpH5?=
 =?us-ascii?Q?wiSCgLwRYmEteM/Lxxej+XrRd6JdoPIP9gxvn/8mT2/yVIckJhFz8IsTExY2?=
 =?us-ascii?Q?sXk0lMVhBmb2zg6iz2+13VQm9lJGsApLnOq3jKmQ8wMR+osVCk8b5MRo1tgt?=
 =?us-ascii?Q?Dtep1XbYhACGQEOdHPvKcGb8LpRUgwhsr84t8nUDIOPxys5AAgFXq7Etjlzi?=
 =?us-ascii?Q?lvxn1gJ+is1ntvXFfHLTMpanip4izI+AR83F8sm+lNzsFjTxxL/wKTwvNZ0m?=
 =?us-ascii?Q?SPFoUoRuj4bY++qc6+sskw8tJtLijBekq+p5/bDRZr3aQd7b+bbfqkhzSCkD?=
 =?us-ascii?Q?891ElwXLQuDDH8pAjyQcMojt2WF8wRNEfslrdRK4xaWMnKJ+F40SnKwAHCim?=
 =?us-ascii?Q?UZCqYFVOHQB/vY8mgKlG0/WGhUcvQ+u82W6QcD3CwxoiYR8If/OFlQ4rSl6b?=
 =?us-ascii?Q?0cioFR/saBV0fBHcTRPcGdLj9Yfu1Kg6Fd+XgGqlI5g6Au1POZfCbByA7y0J?=
 =?us-ascii?Q?E0z7W2eJ1aHBFw+FAC+tjOZZQ96HzArt5PYnS6GrO9gYLLGkBTMmbQbJSiKP?=
 =?us-ascii?Q?I6dySsyDKPOTpCKabT7PMT4X6sHX4TcU9Uc8ZVJEFsN4aGsC3PGJy3Tzn48R?=
 =?us-ascii?Q?5a3gEU1bYUy1mGcvUu8fc0i3KR7YWqI8jlPjzKN9Bi2HYaz9FJUsk5wo/Dk0?=
 =?us-ascii?Q?N5DWEW63PkmTDdzc1f6rQcaYjY2mLIUFBAfTtXWjZqZ3sBKsL1qCaEQ32cd4?=
 =?us-ascii?Q?EI+Thtylyapdis9A7h8aEzBkp3c51O8pBgECfPcaHA=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8116bc90-a6df-4625-3e02-08dd777f65d0
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10926.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:58:41.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10325
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

For a datagram socket received by recvfrom, the type param is not
assigned correctly, making fhandler_socket_local::connect() to return
WSAEPROTOTYPE.
---
 winsup/cygwin/fhandler/socket_local.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler/socket_local.cc b/winsup/cygwin/fhandler/socket_local.cc
index 270a1ef31..340a2b33c 100644
--- a/winsup/cygwin/fhandler/socket_local.cc
+++ b/winsup/cygwin/fhandler/socket_local.cc
@@ -87,6 +87,7 @@ get_inet_addr_local (const struct sockaddr *in, int inlen,
       addr.sin_addr.s_addr = htonl (INADDR_LOOPBACK);
       *outlen = sizeof addr;
       memcpy (out, &addr, *outlen);
+      *type = SOCK_DGRAM;
       return 0;
     }
 
-- 
2.49.0.windows.1-3


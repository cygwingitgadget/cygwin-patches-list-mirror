Return-Path: <SRS0=zxvb=W4=hotmail.com=Strawberry_Str@sourceware.org>
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn190110000.outbound.protection.outlook.com [IPv6:2a01:111:f403:d407::])
	by sourceware.org (Postfix) with ESMTPS id 2DEFE3839043;
	Thu, 10 Apr 2025 12:27:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2DEFE3839043
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2DEFE3839043
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d407::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1744288061; cv=pass;
	b=JFGWCRb2ZC2r8YOp9hx1uot6CMeaxPsIIevt6IPzPFndO74rkjSNXAeTcDSV6kVOSg16OzKC2ebXgBs6O7IlxSZJilfQYR5mdD4R8HNWoGTuKUiWNbg2pTY3LBhUfIEyQIDxMPsQgzYEsMFVOzGn59Lr3S5kZAW6wdCawr4ws/E=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744288061; c=relaxed/simple;
	bh=UzpF1Y0yIYP051+/bFh589xNKLjsNJS/oGNXabs1tNU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=on1ofbe2NgR4UIhxh8fIY64ukStGREP8dxgf65frbUihvrkn7ubRSKOrMJmjvks4WZ8Gm1O65k5lHLngimVyFm5lQMqydoD7k/qo/8dlgGOdS9HkSGaKuf5lnZeAZoBShOWtHUCVbDSyChwrXEJe78oYPt90egnSnzQRAjaRjxI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2DEFE3839043
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Ru9pMOO8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNIaEOlpIvCP/vjagZf0ifWOQC7JNXfMVT219OWDrV+s1fC7AWlbmBENaah0SHa9Mnnnvxqju/TVeWTmbJ4CCl/KarxcbPWk/8VcfXHR3r3p/E0QGKsev3r3ymxfW60LAbrwrTiXomqTcU7QXNF9xOQ0BrP8annuhUg+/0o284nAJ7OPfdtl4XrKnZ7VObElq1qM3GMP3AIKSttzA56O2yn/jCV0bVdh6EoVgD6f6P1KFjL4yIYBhAIcxOYNHwMfNbNLQNPIY2S7fbDxxwxi16Co2Sqr+kWXIBvYKXGVk8jY5JhpFY74bChKcKpketjc9tCsORPWqrnkWicHJdszQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRaxYeSu6zW8Ce3Pf4DwGlWMaojLVh+Qh1ukD3DDxLc=;
 b=tEISVgpP7qJlac6aEq8nal/GcATTBUxvZFbFjlZNf9aeZmzUliMBKkPfuZugw0dH+HtnEaAJOzO4IRo/7fenHKFD8xJCABBb4IXqL4ibNCNrHbk/GO+z2oX5XiP9vgYYCVqr1MuwebG9yAIAjymRSboIKXmkJQjwS8/bI1izqFWm5bXdjvwOeMC7Tq8lrmkPyOpUd1YSeVmDPGZ5ASsG5QvDa1CEAnOEuKK/O8ZBAQpGHAzVS0tBzUVG7eMr2isAxrwEyRJQbrFzKfJI+0h59+SBQ3Y0ZMrFM/8DqU799F/3uX2AvWFJIHRaGrtlQhUbbiDFpO6Q1ycH7oq+uFmMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRaxYeSu6zW8Ce3Pf4DwGlWMaojLVh+Qh1ukD3DDxLc=;
 b=Ru9pMOO8g+f4mL8qMg3yfLFbMvELP1GTi4VafMFWLVIsyQn+qh7eHR/nq4aQCfjgz5VOV5/RYXpq9uJR1o7habOUCibv5COYj9yGNukJIhuJnVb8lxRZv6QOv5VsEJASAmAAjvg/MRFFPk+JmLGfWjdG0oQaPHR7+idqPp3Xs8FRknnPL3q4FkkLmxbvnTd1aRQfeU08x73uOkW+sV+jcLD1Orpfxl64rqcfUadtJW2BzhihO5YGKXhAZG4LLuI6eYyXSZ9/EgP6o/hotSJj2k3e4h289EUIBrcCzgbHIbFWHSoyAUMXaMexEGfNTSZ+TTmQ5+ZwOLCaAyXy8Xjsew==
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com (2603:1096:400:3a3::6)
 by OS7PR01MB13703.jpnprd01.prod.outlook.com (2603:1096:604:35c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 12:27:33 +0000
Received: from TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209]) by TYCPR01MB10926.jpnprd01.prod.outlook.com
 ([fe80::45e0:7606:a365:9209%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 12:27:32 +0000
From: Yuyi Wang <Strawberry_Str@hotmail.com>
To: corinna-cygwin@cygwin.com
Cc: cygwin-patches@cygwin.com,
	Yuyi Wang <Strawberry_Str@hotmail.com>
Subject: [PATCH v3] Cygwin: fhandler_local: Fix get_inet_addr_local to retrieve correct type
Date: Thu, 10 Apr 2025 20:27:22 +0800
Message-ID:
 <TYCPR01MB109261F895332F0C2ABBCC304F8B72@TYCPR01MB10926.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <Z_eg0w3LZD1y9KJb@calimero.vinschen.de>
References: <Z_eg0w3LZD1y9KJb@calimero.vinschen.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To TYCPR01MB10926.jpnprd01.prod.outlook.com
 (2603:1096:400:3a3::6)
X-Microsoft-Original-Message-ID:
 <20250410122722.94358-1-Strawberry_Str@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10926:EE_|OS7PR01MB13703:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7cedfc-8159-4d64-3e47-08dd782b1157
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|8060799006|7092599003|461199028|5072599009|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NuOqZV0zc7YHkDDS0r2v7AvC2mnAOxUnd/35yCNl8Ew60Cfl886hd6JXjw8H?=
 =?us-ascii?Q?alA3SNy6trIAYjtZRUFzZ56z99X/lIaX9KMrvhThNFV6I/Vl5d88sxddoZL6?=
 =?us-ascii?Q?38IUSVrL6JW+UboAZsW9h6XXxOqW1Q2noKnbLQ2V/3N4jYN3vkzLpt6110Qv?=
 =?us-ascii?Q?+UxoeujLbjF51+3tFrxt96P4iEvO1YwHZM7rGG7APBXqvFL+o/Do9Rc/62Es?=
 =?us-ascii?Q?lgFeP2xfMjr6P03A+pUSM/ZSPK1N0lHRMskklYqJeacdrRLw5pAbj4vHGsDb?=
 =?us-ascii?Q?vAiJ0h8I0dhs5AL7Def1s2611ZVTlhGjqEzkjdS+nGbmTkryJz0+aVFd2BIw?=
 =?us-ascii?Q?ZvOSi2DlVzEsmzUqRf9z2iNbj5nJFtSdL0WGLScA6oU17r9Ow+LzuZ5YhpQu?=
 =?us-ascii?Q?mzEDFM07Vk+yA2GCdfo9zHIacF4Huad6pfWRojuk54NH8XRzKfEqHhRhhqrl?=
 =?us-ascii?Q?xZE56MyOzyNMGdc63rvLDhqpyZn5byvEes3H8hhkmwD0FJky5Arei5KCZQr9?=
 =?us-ascii?Q?XWQ4LdWZ41b6f+zshOAx/zH7xyvFWGR3ea8keKlT8r8AFbpY1S5T/UeAxlGQ?=
 =?us-ascii?Q?GAVVhdnSwLVTzWL53Nu2MgOSZ9LfgealqlhtEp+o6+vqIryQfBsDBaypXvjp?=
 =?us-ascii?Q?5woFrUHcN7tJbNeJF4kxvxvjL0ZNvaQMzvjN7zvMODH8XGzdZOGWexLFeLPv?=
 =?us-ascii?Q?t0R/KtNfzsUy+8WU3DaU2PyVBg+n+dUAjuhrdGaUxSZSvG1whXetbsvYCP4q?=
 =?us-ascii?Q?B+k8JuKqENcIBVPwLdV4uXfItEz6ekvZnH0iMcOAjN5EUGrohJ2r/rSqdPm0?=
 =?us-ascii?Q?L3lceFT+Wgy46EN+srzwpRIwiQY65r/5XyuNEMFYsx+ksdm0s3GNRtVMCdQn?=
 =?us-ascii?Q?JVzFF9urEdxMyu68GPnJRPIGs+YP27QwDreii5PZWV3q3d9fJ762vwsqVlIv?=
 =?us-ascii?Q?8mOhhHWK8HzWsW/LCTD5f5nhAIX+ijgy47nKmjeeeSXBxZPSVPnQr4fmV7C6?=
 =?us-ascii?Q?YYB2ihZDOR5YdVLBZBFYcnFtcjh22rfGA1+uRBQmxBXPJ6YZ4lyzJdR4rcXV?=
 =?us-ascii?Q?cW9cW1boHKCZaYcSaTrNrXLX2xQBJS84uV0HiA+xxtBzS9ec7lOXcgTsE6Vu?=
 =?us-ascii?Q?Z/uF8y/YpGRIT5sMkzzv0UaSIsUBrjRdCbV1Eb8h6zQ/zhR9x4MiNDQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXEfjZgiZsd75xvEVi+8FxA75hYwiIo5F3Bf2Or5t97GeyHiZnGzeW8JeCU/?=
 =?us-ascii?Q?hQUco0lhnbAal7hNB/78pF40eMo+1cKN71Fdpqxf8aSmQ3OxYJw847JkCjK5?=
 =?us-ascii?Q?/uNMPl8mCxlxitoQcwQxGHcwvWWw3sjReHo00EMe6IqCYT8MBV7koh9tekRe?=
 =?us-ascii?Q?lftHZ3SWCKGoBtpVT5f7ThuqlUB+G6+TP9rrPE1Y/61dLQyzy4vSRxDOz2w9?=
 =?us-ascii?Q?wexJGp3bcSd3dLhHVVwairfpG2KD4i5E5FTmWIWz45Z5LJ4Pbe1nzdpm01xd?=
 =?us-ascii?Q?u7oFkV/IYxLstWGJgrr1MEtxP13jLRH6BadI4+QJbrBjZyrRvFQJrzZE/RbW?=
 =?us-ascii?Q?6PS6r/GG0Wr8cRoqkZzj3taPzw8qWEe5C8+Hsw77S8cXO7uJobujqOjncW6Y?=
 =?us-ascii?Q?RuFi/wUKm8vikDsk/WsvoLE5PYTdpGHewkb4DJ1eYxeWnlZtMmZcu/lubEm0?=
 =?us-ascii?Q?kMva0cWqbyR6qN6RDwsEblvgmaZyPfNfd9AjEigvV/5Kea0QqKcn3x7myr/h?=
 =?us-ascii?Q?2TmDbUzAuC433Ajh6elh7K/lQoS5NgJL52wybMroUYyB33hc76RRPOju+k9y?=
 =?us-ascii?Q?fKy++36D1jTWoiHctzL7d4aQ9fk6wFJU6UWsY8/CvJ+KAzf0VDyFS7r//Hzl?=
 =?us-ascii?Q?TmL0FQONPxCYqNajIcZyN3DIXWltjxb5Hr1C2heLeCJMDlDr76CYnOdFcS8a?=
 =?us-ascii?Q?WpnNK3UjlWx7cIDhV8p2RoNw4PFEgOKrme9o2Oip9yYiNjxbHkqYrnN4kcsC?=
 =?us-ascii?Q?m2uBuHc2imlmCZsai8Cv14/ZzgbtUGYmoBkLmg1bWzgAXGhiIReQRD5TlqxD?=
 =?us-ascii?Q?3tcxK7MuEH6e4MVY4Act+XoIfT8HAb8lLrN5LHVd1t2ldByTxWD0IeGsr2hq?=
 =?us-ascii?Q?EJNGfcsCa7/WCG1TXdbSaWc8faDtq9WGfuXkGY36yKBO4TFedqvZ/cscBMaE?=
 =?us-ascii?Q?aYhjeiN2kpLdiOGkjiwGWXh6p7xhLTZ/MqTq/gC3AnsBb9mIbUTQm8mKozr4?=
 =?us-ascii?Q?a/ryfgkjYTS7dUkNNiZw2jqbjfbvxC98QABLWlaqe2rH8nONT4XxsKpuWCHL?=
 =?us-ascii?Q?qMG6yLK7T4n5uxId0iCi0HAwJ/x/yuM5G3rRaAavMxL7N9JiYF4WBtJN/hmF?=
 =?us-ascii?Q?ax2YlqdLu7IxrjSCIYW7gMMGdGhk8J+G8N5rPW8nhLcpBa88iFGgnbWM+AyV?=
 =?us-ascii?Q?Z1ixfyPky2oTb/B+e3i2DhAM6wTWRhGH6X6CXBrK3shiY80ek8c+zFHCZ5OK?=
 =?us-ascii?Q?eT2YME8LhvTcF/TLMX+zfqxhN9Bzht6oHndg4nRQkA=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7cedfc-8159-4d64-3e47-08dd782b1157
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10926.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 12:27:32.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13703
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

For a datagram socket received by recvfrom, the type param is not
assigned correctly, making fhandler_socket_local::connect() to return
WSAEPROTOTYPE.

Fixes: 2617a91597ca ("* fhandler_socket.cc (get_inet_addr): Handle abstract AF_LOCAL socket.")
Signed-Off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
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
2.49.0.windows.1-3


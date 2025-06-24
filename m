Return-Path: <SRS0=J7gK=ZH=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20722.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::722])
	by sourceware.org (Postfix) with ESMTPS id D091A385B830
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 11:02:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D091A385B830
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D091A385B830
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::722
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750762970; cv=pass;
	b=BYSrEdCtTBxV9yr6mSyIgjx2NlV/qioB1r/DCCf1gBm6r7oAnkgNS7M50ro2PFiFSahlsyVK99Imd7MpVcMKKpzafQbgmdzTFuE/oO0whX9GJyA31WDwgvA0XcbJEfcAPTfy/UpbpHQ4LsnAWYhz7CIiLr3bdbHHGjRbtmwjgy8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750762970; c=relaxed/simple;
	bh=S9GMintZLeIhKey9+UTaty5ySXr5YLX9dkybKj1f/ec=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=JJEQf6IvqS9WQHGy79qafE2yrTJnsaWnKSra3DR2voYCPTZ6dcm53r0P1ZareBdquegPn0ooBDdoecL4dE9gWlZ7cuKNkVv2ivTTwLdu0KfrROWDBi1xg7tKGIy6o911vl9p4f5voT1bPV7xzb0rJetTYg9Ko+TCWQsD3uf1KqM=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D091A385B830
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=MSQID6VI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCD47HQ4O1XOvReVF1hzhhsULZISqA0BPqqaSfdauNz2n5IpisYbpgIWawvAvk+8XGZ0jNuCuGsxmWHslo2ZYr5UcWCWgZVw4OHIOJJ3TjL9PLsw5LAgEBmmNHD4F/5BWA3rdIubhmOVCGDlX1M3PcBDfEIwGs9ynJLu6s862IPbHul0Ss3vYD6KsvVY0sFVGLdmQgUewRhRBW/qQONfMdaNinFZwA7AoT+yqNn2sntMhBelJR8f2LTF4KwcpaQaPVhaSZDdkP1bvEvGdsoXTBgPJ6l2BqBHzD9yF79uBZoRQVoNsAdb8YnIxMuYGSFYG06SoE0r5odrAhztl76RLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8cOQP8MMDMeVLlBD29wzziTBrHNXQdsfW5PKYXFpXU=;
 b=n+TaDQLDAB6YTosJlWVe+TBSlAn8gqedebWuWGO/DqiunImEdoQI+H1nSM/+8xljN4MLjLmVf1AoD+sAt7AYYV9f1jRZoeCm3sWdRt2Vy4E7O2OW1UGalwtP3UqFyxwbiGZ092gdf+NkBgynrXvS3tmMpfFI/+5nVUnoqlyCrhn8Vj7j3Ua+PWQVV4nFPqIdvM0tV+7ylFEJHTbABEuAgd1qfUZQL0FrBDxi3WzMBQ5FIUjid+OwbKGK4eRrlBKeJlDqoTsDUDij6DJ5QSfIbywWmpoPio5KqeLhUjbDOMQQMCWp402yQN1durjA4lKIrXe8XPgmmOsuwD5H9/gwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8cOQP8MMDMeVLlBD29wzziTBrHNXQdsfW5PKYXFpXU=;
 b=MSQID6VIEMxKDfgTa4mQ8rNEDEDrVqUNHfW3b11F/Ga1ORRBTizV8UT2mLT06Wxpy2/udG/8GSuxA061bVe4Mt00UGyOkg+12/Q6+TvI/hK43neOl4Z48+NDFfyFq/0wJBCN73unXqCwFWXwYUYecbXuwL3rfq+IUSTno8KjtpI=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU0PR83MB0530.EURPRD83.prod.outlook.com (2603:10a6:10:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.4; Tue, 24 Jun
 2025 11:02:45 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.012; Tue, 24 Jun 2025
 11:02:45 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: fix syntax error in cpu_relax.h for AArch64
Thread-Topic: [PATCH] Cygwin: fix syntax error in cpu_relax.h for AArch64
Thread-Index: AQHb5PcsGyuVaNTO7k2Z8IKUqwQY5g==
Date: Tue, 24 Jun 2025 11:02:45 +0000
Message-ID:
 <DB9PR83MB092353FBE863EBE1067ED0BD9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-24T11:02:44.382Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU0PR83MB0530:EE_
x-ms-office365-filtering-correlation-id: 6c4bd7bb-305d-483b-0540-08ddb30ea5fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?wxj3OMzWqd4k4KVxccCNTAZf7p9yjFTxyyoseFNVAwx+ZzHxNohhVcBGwe?=
 =?iso-8859-2?Q?ZZHIkcRkI4SpWkJG5i/tQgX7LV7IQLOz6ITXZXJM4JZa/pSB6JxlkP/EkQ?=
 =?iso-8859-2?Q?5kNSq3KVmv9PMQWTZ+Pa5BWcP49MMKkX8kU+ih+V1AuW/QsHlASIu8KF8g?=
 =?iso-8859-2?Q?EG/D8E+ZyonxwHigBo/wXMbBkOCCjoQW9cxdBHZnHofpDfkbKOsicEdFNp?=
 =?iso-8859-2?Q?0HWAtOZftOnWaWXoiGK1XcdViqSFlLVsrh+syxXnH0y1gqn5DoYtgx1U9W?=
 =?iso-8859-2?Q?iSLNEItXCyx4U9JUOEREzFEXRYvA40wcUfOcA8MFj9FVXOrp1Guscmgzvf?=
 =?iso-8859-2?Q?W+jsGNdukd1oHKcwbQ6aiBGOmp/I5qviLV23eYuRW4n5h2SEBipeafrJWT?=
 =?iso-8859-2?Q?2XboMIoneeQcB23scQ1MXmrolvu/P+fEfNCw2zwgAn14rjxk1voRPxN9xn?=
 =?iso-8859-2?Q?loZ60GkNBWZIWjpcdYNEZT9gQJdL7sprCe+eFWujfu0eYWWxujhrUkA/ZA?=
 =?iso-8859-2?Q?WyGIqoq9aNvtkRalDFWxEdvw1d8YQ6JC5Btpn0DWu5WKHNeE8LiDnYLuIS?=
 =?iso-8859-2?Q?aUgjD6zMBAxoQOZ6wPht3ELaY9xHPEjC7IOhsNzNlYWfEgkCd5MrqONl9R?=
 =?iso-8859-2?Q?/+wmklZMqtAePG+YaXDYxt32Npgl/JqzNnZGQiKBbqq+V+ogIPnlud2DJC?=
 =?iso-8859-2?Q?swONt8WoDAEFBQQAJykxJp6sZvdJ0IQyxuBGaZNKG5pWDlPAUeSAfyL1hQ?=
 =?iso-8859-2?Q?kATbWOh9t4tBiXHWwZwxNapcJA6zEyavVTwwScvtFmF3AYCYTNFrTwG2TO?=
 =?iso-8859-2?Q?feIaiZbelhKe2yO3OCJEdVYhuqUByuVzOTT5ADXngcyTLBrVV2wIewI0wD?=
 =?iso-8859-2?Q?6b2Ks0VFRyi0nwhP+9qrdlAGMaS+jACk8k5csDNGl/DNBbsKc/et+j645c?=
 =?iso-8859-2?Q?Zc+klZSZYa6XyN4gR9GTdzV71GpMpGY8JhPXqr2Dy63laJRxsjAZ8PQU0+?=
 =?iso-8859-2?Q?BWE+uXSMH08WXtKcpM4rZ0hQHC8W0e4H2QmrxeQPDT96XlyRCX7ed7hyP2?=
 =?iso-8859-2?Q?kYVT7ah0fuWbqg4iw/iyDL068KIA8UIbv3R4dgzF2VHK8rA7uTfm4tzp36?=
 =?iso-8859-2?Q?vGtIaEFlO/ITAgskyyZlweFqcP5A/iysCg5sub9eHojKW0gefUBMdBCuHT?=
 =?iso-8859-2?Q?8PjJ6MccdMVVbIEyu86JFog7NZ4Iq8CcTsVoMkG+pCc9XDpm7j1sGEKoBv?=
 =?iso-8859-2?Q?OT3O6+MmGTctQriLG9RLRuAlDKTfSZwWrjUTmuWOQ1y3/NIhEe9EuoJCyQ?=
 =?iso-8859-2?Q?CAe7x5fB1qDxVljMVaSbf45/HuCtuq2HE/Yc3d3vgafNjxrN6qVHujRIou?=
 =?iso-8859-2?Q?Crohr0sYN66qHdS6d7nA2A1w/+cjjYvRQUV+jke7GlsVZ3pC0u0AQpXkTI?=
 =?iso-8859-2?Q?l8iDeT3Ue2ZQa/WlBjwS9T8FypLAHc7Hzm41DuNR1gtEE6FQT49Bc3XEhf?=
 =?iso-8859-2?Q?Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?s8gMAwrPge7kWWZ0UZCIRu4Luak/ke9mVrFohNKpaCD+NyxKL4MWCcdn96?=
 =?iso-8859-2?Q?UkHOmceye8Tz+3BCYohTQwAR01rI/DU1aAuT3LgN25hTsoq6g0MDHh6thO?=
 =?iso-8859-2?Q?8qozc8yCSJ7SHOYv4+VLmwYqn683mgbJIESH4Mo4eUAg7kGRrx3PA4jJl8?=
 =?iso-8859-2?Q?pvuNWrGPU3AaC96yyDH89gAPM3leG7UXvar+WPkZPVs6kNe8nIHNfOD5SM?=
 =?iso-8859-2?Q?KNLQaTRfkBJGBmNgEK5iZHJ1hRCCvTTxiTOC1BAePT8UjdVo0hXEoobkoY?=
 =?iso-8859-2?Q?kOpFXovS4Ssb+/HmGx1m1FQLG31gZbRIXGjcQtEUCI4ar2up39ueUa5YRp?=
 =?iso-8859-2?Q?N5B/xcp05RoJfJEXAB6yzhsiq3AUVk6nrNgyvt6RymPBYkUAlLXyQmgQA1?=
 =?iso-8859-2?Q?HqSqaxsyV4lfZpYef8kIFhaMq8kZttbR4zW1ALkd4ISPyVTb61heUstIcW?=
 =?iso-8859-2?Q?LhDGNZoocK83M8V4KurA56lK6mmr0rn1VUadUUHnMCsrGzU2hqX+bHrT2T?=
 =?iso-8859-2?Q?F5uYc9SnFGHNxrqIuaAcnrCxdV53QH9mweGqh+rIvRcODwr1fRYDy5Ux8h?=
 =?iso-8859-2?Q?MFtaqZveZs2hmgX0pocRhHm+iFlCgdQGW9IzH6+MBT3UtLN2SP+WbzYPEi?=
 =?iso-8859-2?Q?KR6da25FpOPm/ttxJyw5ACxAxXbNdLVaHUVuSeSDBWwPqmy9vEOrbYnP3D?=
 =?iso-8859-2?Q?kjIEvjCBO/AWyUns++6zHdc+7oh87GdH3sX+A+TzlWyvLHXdvyrPRLfq76?=
 =?iso-8859-2?Q?/KXUia3YiP9CQ37lE1IHIhOR2WNpEAQPK9k2wsIUZWV/6agv9kUCVYdwrQ?=
 =?iso-8859-2?Q?YuWsykq31TBUorcsThxrKkGSHWrafvN+cSwnvKYsxSqnTnOPhyw0gT6lCj?=
 =?iso-8859-2?Q?7Z9FDICB+RAipVqRLN3zgVOrTS7la116tGEIRJxfLlnXciYd4dc1zCBhyK?=
 =?iso-8859-2?Q?WZFtxcLnf9w3I6cMjCuRAm6edAghSIArvhWYxnhk+xcSCH3OrB2rNQ3esm?=
 =?iso-8859-2?Q?M9W0+7qIIN0yNlDCsYu4REBpYvac4b3bizovddsvY6EhAFxoM5xO1/KHzZ?=
 =?iso-8859-2?Q?HM7b62j3eh+eA7uLbABUhmFd3HGsXO64NQIxOHEE6daTDxWjmYjfuHtwoF?=
 =?iso-8859-2?Q?vtH/xFOwNOAP89EWy3CACfVoSRvWzw983RBPRpm/TNEyYQdwB80Misj2E7?=
 =?iso-8859-2?Q?aIhet3r88CUrFnD0j27BmNX+osUfcDH6YFEH5Ja5GUGzBtXNqy3MxK8/Zt?=
 =?iso-8859-2?Q?yOCIczB4u2YImEg5Ex2CM3Gevj4Z6wdxy6U4WEmeuGcgy0YlrSq9rlEySt?=
 =?iso-8859-2?Q?ue7Mt1H7sV4URjFUq0ip0eXH2NNxgAT7CKSOwfsJ4vlTQbRfXdul6Ta3wj?=
 =?iso-8859-2?Q?j9T1lI09xHi2SM9AFk/OrM+Kxdn7rvXFDGcNicuBps9XXkel3kmpdBm3/w?=
 =?iso-8859-2?Q?p2DxOPip51WgJspaBAVxHKRfSIK4k6s8gKCAJKoCqAD9QrZfsaO7Shdenr?=
 =?iso-8859-2?Q?F9YAeUSvzgDBZ1p44Av5W3LmLW6zxw3nJ500ALWvEqK29ac+sRRA/GBLwg?=
 =?iso-8859-2?Q?dK2ID7LENUu9yacTEhbJZi5r8vud?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB092353FBE863EBE1067ED0BD9278ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4bd7bb-305d-483b-0540-08ddb30ea5fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 11:02:45.1883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZQeuh0qoEzLQR9g7Ey9vkFPJcmGb2XrId7Av3QmU7xODh4iVRsUTigE06VQzORNkWOgwcpd9g1lBEgQrGO4DqUUUxbUem+sZ/jUDD/zRnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR83MB0530
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB092353FBE863EBE1067ED0BD9278ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Please, take my apology that I failed to properly validate https://sourcewa=
re.org/pipermail/cygwin-patches/2025q2/013826.html=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 565b1ee84e2882f7229cadaf11e4884349617040 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 21 Jun 2025 22:47:58 +0200=0A=
Subject: [PATCH] Cygwin: fix syntax error in cpu_relax.h for AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/testsuite/winsup.api/pthread/cpu_relax.h | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/winsup/testsuite/winsup.api/pthread/cpu_relax.h b/winsup/tests=
uite/winsup.api/pthread/cpu_relax.h=0A=
index 71cec0b2b..c31ef8c05 100644=0A=
--- a/winsup/testsuite/winsup.api/pthread/cpu_relax.h=0A=
+++ b/winsup/testsuite/winsup.api/pthread/cpu_relax.h=0A=
@@ -4,8 +4,8 @@=0A=
 #if defined(__x86_64__) || defined(__i386__)  // Check for x86 architectur=
es=0A=
    #define CPU_RELAX() __asm__ volatile ("pause" :::)=0A=
 #elif defined(__aarch64__) || defined(__arm__)  // Check for ARM architect=
ures=0A=
-   #define CPU_RELAX() __asm__ volatile ("dmb ishst \=0A=
-                                          yield" :::)=0A=
+   #define CPU_RELAX() __asm__ volatile ("dmb ishst\n" \=0A=
+                                         "yield" :::)=0A=
 #else=0A=
    #error unimplemented for this target=0A=
 #endif=0A=
-- =0A=
2.49.0.vfs.0.4=0A=

--_002_DB9PR83MB092353FBE863EBE1067ED0BD9278ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-fix-syntax-error-in-cpu_relax.h-for-AArch64.patch"
Content-Description:
 0001-Cygwin-fix-syntax-error-in-cpu_relax.h-for-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-fix-syntax-error-in-cpu_relax.h-for-AArch64.patch";
	size=1287; creation-date="Tue, 24 Jun 2025 11:02:18 GMT";
	modification-date="Tue, 24 Jun 2025 11:02:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1NjViMWVlODRlMjg4MmY3MjI5Y2FkYWYxMWU0ODg0MzQ5NjE3MDQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAyMSBKdW4gMjAyNSAyMjo0Nzo1OCAr
MDIwMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogZml4IHN5bnRheCBlcnJvciBpbiBjcHVfcmVs
YXguaCBmb3IgQUFyY2g2NApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxh
aW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKU2lnbmVk
LW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+Ci0tLQog
d2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3B0aHJlYWQvY3B1X3JlbGF4LmggfCA0ICsrLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvd2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3B0aHJlYWQvY3B1X3JlbGF4LmggYi93
aW5zdXAvdGVzdHN1aXRlL3dpbnN1cC5hcGkvcHRocmVhZC9jcHVfcmVsYXguaAppbmRleCA3MWNl
YzBiMmIuLmMzMWVmOGMwNSAxMDA2NDQKLS0tIGEvd2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBp
L3B0aHJlYWQvY3B1X3JlbGF4LmgKKysrIGIvd2luc3VwL3Rlc3RzdWl0ZS93aW5zdXAuYXBpL3B0
aHJlYWQvY3B1X3JlbGF4LmgKQEAgLTQsOCArNCw4IEBACiAjaWYgZGVmaW5lZChfX3g4Nl82NF9f
KSB8fCBkZWZpbmVkKF9faTM4Nl9fKSAgLy8gQ2hlY2sgZm9yIHg4NiBhcmNoaXRlY3R1cmVzCiAg
ICAjZGVmaW5lIENQVV9SRUxBWCgpIF9fYXNtX18gdm9sYXRpbGUgKCJwYXVzZSIgOjo6KQogI2Vs
aWYgZGVmaW5lZChfX2FhcmNoNjRfXykgfHwgZGVmaW5lZChfX2FybV9fKSAgLy8gQ2hlY2sgZm9y
IEFSTSBhcmNoaXRlY3R1cmVzCi0gICAjZGVmaW5lIENQVV9SRUxBWCgpIF9fYXNtX18gdm9sYXRp
bGUgKCJkbWIgaXNoc3QgXAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgeWllbGQiIDo6OikKKyAgICNkZWZpbmUgQ1BVX1JFTEFYKCkgX19hc21fXyB2b2xhdGlsZSAo
ImRtYiBpc2hzdFxuIiBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJ5aWVsZCIgOjo6KQogI2Vsc2UKICAgICNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRh
cmdldAogI2VuZGlmCi0tIAoyLjQ5LjAudmZzLjAuNAoK

--_002_DB9PR83MB092353FBE863EBE1067ED0BD9278ADB9PR83MB0923EURP_--

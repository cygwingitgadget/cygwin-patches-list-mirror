Return-Path: <SRS0=muCJ=ZX=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20705.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::705])
	by sourceware.org (Postfix) with ESMTPS id D352A3858CD9
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 10:24:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D352A3858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D352A3858CD9
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::705
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752143068; cv=pass;
	b=qYxHlevE1fnHFTXrsNdhPQnE2nLxzcWkE6NWD76BaG3w2sMA+SAyZlT4o4NEKtZg7QzrVBwhTYfPS4b2uasBdmTABNxa8yM3Q48ikkyFndNm/ZSkaqtb0sFZNV00ynUe9azZbtBElkyUNZm4jTKX4pxpS5zj0XOvC5Ix30DOSPU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752143068; c=relaxed/simple;
	bh=996+ykYQbYqJ9ju1deXQQp8o27M2eNYeNl/mmJ97Fdw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=d8WkFlA1fE78RJLygZJUz0dGUPveTNytkHuvaXX7KiNU2Lfc8Iq/yWKo3YoywcMnLs2o9Pr/k+Z/QcCfVTwi30ajMqIbXON29AYHJR+x/fnm94OmfNQpcdzFW1zRYWw08JohqTDtNJypxldrvYnS6XIwITi1wMLIDEOvGgHnEI8=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D352A3858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=jcEuCydw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePFJbfxJjZiAk9xCYOYYgpD67arcANU0RZ2v2kOpOJrQLUFD3FTGuqotUM6DZxDbaPFEIq16MRC8QquByVflDlAqHtn1Wc96dvxLQBo9z2doTHDUvZyQ5YFD1j5QfWjRoMjdEM0dIYL+pC1sQOjhyAT/uY6fzUP5ff2rmdy/Tlz4dw0RDctl6iAylW6XwfwoFHZL6kK3CqffybWh5hf2NrAkAZrDQFQudja6bV/5jWklWEUrm67MTmb5EbfeWTEV/1yqE3RgwREd3Giqnxb4xFCbzrwteRRsbUa75sPyL6F/Z8zBwPgxoWAfRtqEGHT7lbS3p48XASmkAI/BhuDsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6s4v2av8mc8MA+HjK3jGEsL3WYF8SNZkYQmC1pq+YA=;
 b=d5wTPNfH3JaMER1lWxdEv/HP6YF/eZFt2BMtbk81VL+RfJYsRargJypDuroo22iX2HWfCZ6xDar3yYCzgWWfwlqNxxMlt94ZsENUscju2GI2bXOZ5jCNAMWSubYEyLpN/XogbKUh7KswLA03djQcXYyQkifjRlH+0KELj2z64ptFVIYQddFXvlNnqFVzHppk0ra8jZBma7NOFZ+VqlYGH0dl9YknKDItprhNuguMm44N4USWy3to1GpqT09qAzg0z8ZzzC6mHvUOHTKEdvVSWpXWW6qB0RP5KrxyetOgBzQyUOeMjnm1ZuYXsoSvsmiqEl5G+z2hbfPMtpWyN+Vtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6s4v2av8mc8MA+HjK3jGEsL3WYF8SNZkYQmC1pq+YA=;
 b=jcEuCydwRbkghVhMpo2mLLzGpUVjj4czBBfeWDdozY0QYi/BA6NSkQYN5d5Yka1QRYtFplixo8aO6uULr9JtEY/9AMSvb5xhcodFxXytfyHluc3NwQe8CmNUzrM9akHubUy3nce72DoB8mTVcNxxKPe6HgfPeMN8nfvPPHXz3Mo=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0702.EURPRD83.prod.outlook.com (2603:10a6:10:566::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Thu, 10 Jul
 2025 10:24:25 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 10:24:25 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Radek Barton
	<radek.barton@microsoft.com>
Subject: [PATCH v2] Cygwin: profiler: port to AArch64
Thread-Topic: [PATCH v2] Cygwin: profiler: port to AArch64
Thread-Index: AQHb8YTPbHqd8V9su0+43z6OPcK8cg==
Date: Thu, 10 Jul 2025 10:24:25 +0000
Message-ID:
 <DB9PR83MB0923FC4AD2C1668B124A71B69248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB09231ED3693E994CA770C8609242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB09231ED3693E994CA770C8609242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-10T10:24:22.778Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0702:EE_
x-ms-office365-filtering-correlation-id: acf907c3-5b04-4662-5551-08ddbf9bf197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?u9lNaHTFp766RZRE0v/dO6Jz4gMpFLJUbD9sdBoJZHRYjlyZwBTI62ZRhl?=
 =?iso-8859-2?Q?DF8flVWJYi/YvflxxMKngPLAbO0PdlDdgVK1vykevd66FKUoFZbbqskmw1?=
 =?iso-8859-2?Q?549HZIWVZkO/5YrNJWNUv7TRemMxJqe73KhUYGuOtSRV9vnS+VJKScbXds?=
 =?iso-8859-2?Q?bswSIxNEMgMQ++BJXWJ0pvUP3jSUrNkpKbUoMqTF1poD0j+idWjMoAzITa?=
 =?iso-8859-2?Q?+FCLoHuNK13XnJ1ECMuo6Lz/sDGGkbBrMmaSzhbA+WXEEUNWLtmgT0erRm?=
 =?iso-8859-2?Q?Ol5ediiRJo3u/2zRmQ1h2FsiO3+G3vZD2tu71ipSC2m0gtvS+4ME2HlA6S?=
 =?iso-8859-2?Q?HB27uP6oAED4vWYhwpIfg9R4pk/l1NjmPcaH6RfawFXzMErmgJO2xl0Snc?=
 =?iso-8859-2?Q?VOy4chtd5l0C18Ha4Jh71OA6p+AofQnHnUOKqfLdb2HNZdKUQu1yJ4s19Q?=
 =?iso-8859-2?Q?foU3nN0xs91yndZTcIx37Q6qoxWZLjWEuBbLceaMWkp6Bqw2BU1YgqO6rZ?=
 =?iso-8859-2?Q?BUG0LRRnyqRpegVxkQu4aglB62MYJJ0zTrgvQ5bth31riAWanuVotiMwkU?=
 =?iso-8859-2?Q?RtsjamkhO5RWsgLlG6RgcUKGh52r4J89zI/BMf7sn6KRCiylEHOew6Gbu0?=
 =?iso-8859-2?Q?2NROdn4ZW79S9VxH12qSNKNUcK36bXUkbsjBCX4e4/XBgvFJ75v+fnWlaI?=
 =?iso-8859-2?Q?zfKG8JkEStFlzk6T+L2eGeEKrZ2fLvUvpl1yv4IAsaVii7u5fq0LbydPmX?=
 =?iso-8859-2?Q?COVudWTMOUq5/A6WuCw10vQvfePHwLTYrpiU3LVaI1cuTEoJ5Pwywxar7e?=
 =?iso-8859-2?Q?cyuO+lw9c9e1m6EAb2BpoXlJbxnjQ17cRdS6k5dUukRdR5e9LQhOXWT8pF?=
 =?iso-8859-2?Q?R9PDeLFspxcl2yUOHecD4mmjNc0LadwYU2HDsvmC13A84Ir/gg3vjx6/Wm?=
 =?iso-8859-2?Q?n57CeEJVqSEBEoAsH3lp9tJf30Of/CPx4rVbIdApRy3zNY4kxlgmIcmLej?=
 =?iso-8859-2?Q?8Y0wyYs+gYH8DdQWXPf5qgO61gttxH0GJ0JHReJ8TkOq9DrIPMuk0vdqFZ?=
 =?iso-8859-2?Q?yGFLuaLZ7TI4cueKuthCQQPPKc4CAoi8jSnLklCxlosFkj29fw065bh3Sr?=
 =?iso-8859-2?Q?HIViEjR/EBp1ll0RZPUzWKYWNKuUhTTwgE1gHDRBEtNjP+7hGTVBENkNPm?=
 =?iso-8859-2?Q?rjQoIAap9SEYXmB8OzTBBU/XS/IDX9no5FnGnSqvocoGSew+Y3cCUfXOFs?=
 =?iso-8859-2?Q?MaKDo5sguD46Gfb2Cy2TW87emfRHgIAi5u+t2F5zzKCc1KHhMBuTlOfM4m?=
 =?iso-8859-2?Q?AnpFmoD6fUHArmiWQp04DNqMwKQobb5FugAeQYvGRlxZrUnP2Qs53ZL88b?=
 =?iso-8859-2?Q?MIFaW01c409vAidFuu1wYKANHL0jmYe64LxFH5BHdL+ay3M2sA3Nerlna5?=
 =?iso-8859-2?Q?Pw8yAiFmTjdZxSmzbEdCx0ddiIWQDfLVv7Jost6I4CedUuvD8g6rkt+yaK?=
 =?iso-8859-2?Q?bsNZCB1HA3ZEm8GIkbEgpKg1IPh8ocb58rP5du6KphC6qVte4B+1NHwdo3?=
 =?iso-8859-2?Q?OCJ+Igc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?ygy05Cg2jzPRfDpXf8E6sxxnnZ/OPkDIaPB1+8QYKNznSYvylBXZC6Ie5z?=
 =?iso-8859-2?Q?RbfzS+90NdDU7BvmcnimNjHrIuI8jp7Eg6+Ld1zm2rxuUNyAFGa4QIl2mm?=
 =?iso-8859-2?Q?nBOdauaG2avSIy16LGSA/DNX8PfJ7lJAcXaf+npb71nmSOr59SiWxkd6ip?=
 =?iso-8859-2?Q?JR9GRTGyQY9XUqDA3bz10mhOZgHlpY4XAjchjRVgAEnw3/vBlyCJu9SHWU?=
 =?iso-8859-2?Q?hBbui8FQHPt0gRMynrzRN3HmKAty60KfbBNlk4Fu7yXDhkqrD6eUSo8sSc?=
 =?iso-8859-2?Q?ERk+UcNJiWr0qTbuKmvmu6JVPxuIRQu/DCqexbEBMcJZgHZFRGJ4T4+NEA?=
 =?iso-8859-2?Q?D/2fGO46xzx3UnfvSZi1n8aeGCs5hR8CScVTr4PcSHcJ0S2YosA8hJpj1w?=
 =?iso-8859-2?Q?O94dwqFlAXc9on+i/OukFpSMPsgziCLsGg/hCK2/6JW+PKCLyZtGzbCNjr?=
 =?iso-8859-2?Q?zvxbpt+j10k1wvw44eh9Bu3W3JBMBoGWiQBM8jC31PmtXnAzQEI79WMAo1?=
 =?iso-8859-2?Q?zV8RquEfzO22SFzP13xzcBuEZtr+DNtQwduck4tJdyxD0AKXdXsOyjMRLH?=
 =?iso-8859-2?Q?uwtHg0LQWufl+Ize/MixOVm+NSOA6MMxcRBR1TNsPoRTxrMZVMcZJkMnm0?=
 =?iso-8859-2?Q?Gd37bsvbhblWCZKch0ZSwqC1S6V35LzEoKyXz69zvy2VFc7+DNYopedYOG?=
 =?iso-8859-2?Q?K/jnC4/orgpDnxY6LnDnCxehpytvNbfvRmTsBkABA9fzjM9gURlUv4i7IY?=
 =?iso-8859-2?Q?ZyCyvcdupjwWv9YMEdljwWWGDlFCP03gfv8at/635PRy2obi3WpysrKq9X?=
 =?iso-8859-2?Q?bV9Fxs7raP/RncvoDvuZQggTTTUq7j/rHSMbjVZ3kAkH7VHDRtribse6r5?=
 =?iso-8859-2?Q?F72blWjoDzpwyMk9wJsnYyF1lRCfONLoT4jQ9/JF2X5TN77creLgvQuUOa?=
 =?iso-8859-2?Q?wyn+rAWX6UZQ4G04DAszLAfro+pCi6x/QSbidbHBO7SXSFR+j7A9Fsu1eS?=
 =?iso-8859-2?Q?Pr34gSAoFAVMy+ZUAzIoHUt1WhWe2vf8zM/iA3Qsan5KqaoJsdaoQq4Iqa?=
 =?iso-8859-2?Q?ctta5w35XrbhFPVpsJWATACBnyDQjDxQrmv2BAlbrNHeCoyOs2SG4RgCCz?=
 =?iso-8859-2?Q?o4VgAbhxqk5NS5GRrcnu7HONFi8QhiSKM3audBrpbZxv15GodUQDvH0JF5?=
 =?iso-8859-2?Q?Olv9zUmW5H+/xQ8czz8Dxm3UCBPF/sXnc8sTxBODYKbMRSwiLBCrlGJXRD?=
 =?iso-8859-2?Q?zn9zHoh5OzacyUVumK8JPMoNRe18WWkhkodfysZze0K2t0Kjn2E2v77s7p?=
 =?iso-8859-2?Q?09rPp6j1CzpgH9AfhePBVbueVwuVCTzeDRmSXAPBoZDw9BmG/eHLy+o1jw?=
 =?iso-8859-2?Q?ClA0Ttf7PnCNVQrKXV/QLuSOHA1df5suvyAEUWM6yjCndnIoGbsVepLi5L?=
 =?iso-8859-2?Q?QA+3Ol9ZR6dcxy5txmhvINkmQxFSP/s5knkT8MZaTSe6tnbTd6SF92zA9z?=
 =?iso-8859-2?Q?GcpccvsibmIbnhYQHBMtAXtueBl4dFys9V+FFw4UyP9M6MPw37+5xpTRQF?=
 =?iso-8859-2?Q?Cdf6QlBKzTAHT+P6gOD5BWBbKP+l?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923FC4AD2C1668B124A71B69248ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf907c3-5b04-4662-5551-08ddbf9bf197
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 10:24:25.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRMshHgAOPzEag8sQISZtKIy++3VqPKq3ZRYNRADf7AFW++DREUaMRCQzFhjQM+wB72f8rl85uiAm4aOe8YnCfJc/YaqUGOANzlBxZzyOVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0702
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923FC4AD2C1668B124A71B69248ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending the same patch with more detailed commit message added.=0A=
=0A=
Radek=0A=
---=0A=
From bfa5d3c1afe40431b28dd2496c38ba84f91ec0e5 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Tue, 10 Jun 2025 17:11:20 +0200=0A=
Subject: [PATCH v2] Cygwin: profiler: port to AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch allows to build winsup/utils/profiler.cc for AArch64 by handling=
=0A=
target architecture condition in find_text_section function implementation.=
=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/utils/profiler.cc | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/utils/profiler.cc b/winsup/utils/profiler.cc=0A=
index b5ce16cf2..4fe900b7f 100644=0A=
--- a/winsup/utils/profiler.cc=0A=
+++ b/winsup/utils/profiler.cc=0A=
@@ -503,8 +503,10 @@ find_text_section (LPVOID base, HANDLE h)=0A=
 =0A=
   read_child ((void *) &machine, sizeof (machine),=0A=
               &inth->FileHeader.Machine, h);=0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
   if (machine !=3D IMAGE_FILE_MACHINE_AMD64)=0A=
+#elif defined(__aarch64__)=0A=
+  if (machine !=3D IMAGE_FILE_MACHINE_ARM64)=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB0923FC4AD2C1668B124A71B69248ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-profiler-port-to-AArch64.patch"
Content-Description: v2-0001-Cygwin-profiler-port-to-AArch64.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-profiler-port-to-AArch64.patch"; size=1177;
	creation-date="Thu, 10 Jul 2025 10:24:09 GMT";
	modification-date="Thu, 10 Jul 2025 10:24:09 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiZmE1ZDNjMWFmZTQwNDMxYjI4ZGQyNDk2YzM4YmE4NGY5MWVjMGU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVHVlLCAxMCBKdW4gMjAyNSAxNzoxMToyMCAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIEN5Z3dpbjogcHJvZmlsZXI6IHBvcnQgdG8gQUFyY2g2
NApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRG
LTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKVGhpcyBwYXRjaCBhbGxvd3MgdG8g
YnVpbGQgd2luc3VwL3V0aWxzL3Byb2ZpbGVyLmNjIGZvciBBQXJjaDY0IGJ5IGhhbmRsaW5nCnRh
cmdldCBhcmNoaXRlY3R1cmUgY29uZGl0aW9uIGluIGZpbmRfdGV4dF9zZWN0aW9uIGZ1bmN0aW9u
IGltcGxlbWVudGF0aW9uLgoKU2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFy
dG9uQG1pY3Jvc29mdC5jb20+Ci0tLQogd2luc3VwL3V0aWxzL3Byb2ZpbGVyLmNjIHwgNCArKyst
CiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvd2luc3VwL3V0aWxzL3Byb2ZpbGVyLmNjIGIvd2luc3VwL3V0aWxzL3Byb2ZpbGVyLmNj
CmluZGV4IGI1Y2UxNmNmMi4uNGZlOTAwYjdmIDEwMDY0NAotLS0gYS93aW5zdXAvdXRpbHMvcHJv
ZmlsZXIuY2MKKysrIGIvd2luc3VwL3V0aWxzL3Byb2ZpbGVyLmNjCkBAIC01MDMsOCArNTAzLDEw
IEBAIGZpbmRfdGV4dF9zZWN0aW9uIChMUFZPSUQgYmFzZSwgSEFORExFIGgpCiAKICAgcmVhZF9j
aGlsZCAoKHZvaWQgKikgJm1hY2hpbmUsIHNpemVvZiAobWFjaGluZSksCiAgICAgICAgICAgICAg
ICZpbnRoLT5GaWxlSGVhZGVyLk1hY2hpbmUsIGgpOwotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBk
ZWZpbmVkKF9feDg2XzY0X18pCiAgIGlmIChtYWNoaW5lICE9IElNQUdFX0ZJTEVfTUFDSElORV9B
TUQ2NCkKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisgIGlmIChtYWNoaW5lICE9IElNQUdF
X0ZJTEVfTUFDSElORV9BUk02NCkKICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhp
cyB0YXJnZXQKICNlbmRpZgotLSAKMi41MC4xLnZmcy4wLjAKCg==

--_002_DB9PR83MB0923FC4AD2C1668B124A71B69248ADB9PR83MB0923EURP_--

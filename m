Return-Path: <SRS0=vNvE=7K=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021133.outbound.protection.outlook.com [40.107.51.133])
	by sourceware.org (Postfix) with ESMTPS id B076C4BA2E04
	for <cygwin-patches@cygwin.com>; Mon,  5 Jan 2026 12:49:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B076C4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B076C4BA2E04
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=40.107.51.133
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1767617400; cv=pass;
	b=KK0KgCgSSKRgKVDCZk/R4q7NB+GqAIRfxipw7GoSrOl32pU1PsKCbL0v+kkqWMkleqTszd8kiu6d2a62KoslZtchctJpUVttlIXwJ8ScW8ddcZoYipfErUj4KqqrVxvwqy7AqWOURR24zv1ejKfzZqZxBwIpZABr/mUAnjIIGtQ=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767617400; c=relaxed/simple;
	bh=b8s3JWu6GjNzaGzMMmBZHzsSE96umXhANjE1wipPLZ8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=f8KBi0mYijJ2iJchItTBgHULTv/LDjNlGufavmgehpBEn95Bhjxxj7kA/aMaFK/gk1i+zXiqjypLxPj42nyEhdrIG+srp7gEY/aABHkRzG/mUHsAuBZvyOm7GWZWx3EhKQ0tX4P966ZqbmrDn+0oIiIYccpSGrR9YEaH75cAIg0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B076C4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=BwKV3Raa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPBY6mMB2qqqgqRzGnGYmEF6Sy6G67nDoXj/5F00borfPGyNTvPZOnIHNFeTlCggkIIW8oPRfeDJGsY+UvTIdL9I4m6HfsPoHj9zq5yMwN/8EkN3gI1+q15qbtGx6v28p/5iMNjTv8X1MNogZphTxWrElk3PUzpgv1UA56qE4aOOAB4pV8N8u4WXPH92tt97+kUo8Mn/v++7E8Y3wKZB0EHQvT/PzIgst6iU0ZLRfoJjcF/OFV2nv2u758rxNpHeK6GGWIonuWk6ZVWP0n3cW859xMWUPZjMjLi3aQoLRM3qoJ+V2vNQcvhMPZxqK1PdYEJu3yFi2CPHnrgNAoPExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS3rUNLFqdCl+7/jG5RGt0+bvngk3z5BS9OLoPIRk4Q=;
 b=gCab5/mDAJfFmF+4SvJ5FwpGw3noaFDeRAkAV5Hw0DnD4+VlU7oNPVZOU1IJVjPEZm9ZgxeXzZ5327KnQRaH9uxn2ncAHb9MiO1PPqbMrSyw526lScQ8rTuYmx9jnHDZXR5KKvL8Xa2gkUFlpqaEIjwBwPpGyn3O5jFxgBeFZHFaMOje/86Q1hK88UCXONZ6glXlPR/LXZ24k0EORp2qnbgCeJYemV30TXxJeoZCFrxxoQJm9LsBsF4yLH0ndkoSM0cBUoN67q0agzIJNvyDlCELpniyh2+dnRGEHkehySJfy4sgF1PiU5a0+wbvBhGEaSRIk0JuIXfCAIHj9ssC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS3rUNLFqdCl+7/jG5RGt0+bvngk3z5BS9OLoPIRk4Q=;
 b=BwKV3RaaT5ci/J23nxbn/5Ds17pMbcTjxnkSb1Qlpj/RMVQ4etYiYR2Ub9MqjVSazQMkeXx5kLbJxMhbXjR9XNoTQLiBiWw+16BamMG2m0cBR+skvbs7AHki5wHJmjaa1K1Th3j/zOkon23ZBUzEAQr2ApyPhAHsTVXf1zauCp8qt/vGHcSTPP8YOsBGhsdInt5EegdrTn6cSNvCm/84qcMH6n7LEvrCfufKOGusg/0jhSbk3CpIgUtbxgUIY41cE/6xNABAnEgcDw3OTjes9d+0UarIEgd6vuNjMf1Qs32G9y7HGjIoNh4u+mIS/hXVuFZKmnsMN5DQLtWwEKQVFg==
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:226::14)
 by MA0P287MB0124.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 12:49:53 +0000
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3]) by PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3%6]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 12:49:53 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: Add AArch64 support in config.guess, dfp.m4, and
 configure.ac
Thread-Topic: [PATCH] Cygwin: Add AArch64 support in config.guess, dfp.m4, and
 configure.ac
Thread-Index: Adx+Qas1XGhoDQWdTriFVH/x3ZK5bQ==
Date: Mon, 5 Jan 2026 12:49:53 +0000
Message-ID:
 <PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB3077:EE_|MA0P287MB0124:EE_
x-ms-office365-filtering-correlation-id: e24a7fb3-b310-4c45-6183-08de4c58ebda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ll4zuLVUwbwSX89BT92lxOlbnQ5gwWNfTHl4Lfcu1MnFFq/ftoU6Zz0aUbIQ?=
 =?us-ascii?Q?irCKEJrLODoMFTwSQbjlklBNj/pt9TuhM0xLzLmlsJ8U3Ldr/T0YQxzcAVmU?=
 =?us-ascii?Q?EnR4APlGAgsaxU7kPckpvGYTECR+6gsBv0l4I8xgwcSazYq1BechvqKiXCEY?=
 =?us-ascii?Q?Xw7WTnY30P9bUilwtBZztxm5pJjvekuFEMRI5h37gD99ew/H/DAggL5c3oCF?=
 =?us-ascii?Q?M0fSr4PxvbuzeaDG7RnytYPmu0Carjpw8WUD7WaddiMFYu4mqAnMo9qxh+A7?=
 =?us-ascii?Q?+vM0Csm4KiyDgPxloD9XL1BaQ2jOFIyXkc15ZEqbJX37Fupeqacr7NOLv9t4?=
 =?us-ascii?Q?Id9X3llGdB1secaOKnqYNaIaBwJX46s1NTWxavrShjDN67USwd9djcorT7qO?=
 =?us-ascii?Q?eNZeXqxbbh8p3OcXXx9BDQtM0Xd7PtFrP2pyG7kMPQ47fSuTjcXKj/FYWs14?=
 =?us-ascii?Q?YJCgnUlMknGypOyr+1bhKJihiiQj7dL3HAXvxJ0O6IebTbIx9Bk4JzIL8bmi?=
 =?us-ascii?Q?Tpbb/Fldn2eGQVRG2YAlvrM1sSwjDFbJJbhrTtYrJfHQgraX7Kt2m1ct83I4?=
 =?us-ascii?Q?JRVBlNIn6l0GDYAjHHkjVnXjalfDj62DVITrALScDHOHgJ+gS0VnPe9qUnJa?=
 =?us-ascii?Q?6psSudeeSIjHsS9GukU/41nMQcefJ3tZok2CBOI/m1XRLOgaoWC6+jzH5ed5?=
 =?us-ascii?Q?OBdu3tsHYeZckPmRH5bRSS9ZnUAOAlM9UAOmSm7Njd4hSZCBu7nJ9PylWiLC?=
 =?us-ascii?Q?rA5fwG0Xq9f7UXvRNBstk+PGhIadKmenKcrzakuu4LOI+u7Htox9KB7WrRMH?=
 =?us-ascii?Q?FVL/Hnz6JC8KDgrGFhQWgR7r8rP5jqMhaWIwyWAwInMzDKyOpb1klL/fzZIG?=
 =?us-ascii?Q?egUG57c4I2Be8deq8IrLY4J9jJavPlpwj+6VfY44s+uPWKb9l/C2y4hruQ7g?=
 =?us-ascii?Q?ezpcetoc9xUil62pxZw+LpFL9TmPtXqd5+b7tyuQM6tqiwuwXBvxn1XyE91R?=
 =?us-ascii?Q?AmnWLjqdgEcfW16Zqj9cZf0p8THfSAJGVanPpwr4ME9YCcZQ6s9KgT9cazXC?=
 =?us-ascii?Q?yLz1pZvy1R4k4eS1loDJLur9w/tK9y3slEjzdvYX+e1+GHCzPnaLK4+se2n3?=
 =?us-ascii?Q?cng14BJFY6/YvMixqjB4Qwzm0FtXpEw5iFnHD/WxFVc2pVaeZ3JMXg0DKXFJ?=
 =?us-ascii?Q?7ivC9/NbMCZ7lTkIfiupUNRvw6/HX0dgQAAdBos3gxG18BBueM6EGpkwbZe8?=
 =?us-ascii?Q?R2ulAg6rvWoh8ClZ2UGyX1gzeJmx/655Vl0vS1H/Bxleo7zIqGe7iLCnrc+2?=
 =?us-ascii?Q?JXrZouL9wzRkSuzrD+IqEU5LyZaY0xbSDowKzhY13isVDZNwys/rxU32DFro?=
 =?us-ascii?Q?13T8lvNl+A1/u96p0i2388V33b1qTSkPnccSYQaaKa0cwXkfzf5UNzSaDrA4?=
 =?us-ascii?Q?JIxhi6aWfas71O/RAacsEH0QmNUc+ChGpmXBVdcmiZK9lubHNMkRc6Aesk24?=
 =?us-ascii?Q?J/biR2YDXftWLU+kHhPtekhT0zdya/uNu2kx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB3077.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gesbmVVe0yrRNAxKu3Xu2YNsg+2BBw9Fklay5cnD4AYhXeH7/giW7656cy/P?=
 =?us-ascii?Q?NpbSqlogVgx/oearTm1TDYoCikOJumXqXALfgAYi5JToUVB+uEMH/VgGElRj?=
 =?us-ascii?Q?lfjYq7j5Y5G4wqLze21UplND5AOJWzxgiMg551Uh2t5xwya0yDra/rhaSjVZ?=
 =?us-ascii?Q?x1bnjPE10k040Coz8hhXkTA5LTrww4mJxfv4o4G9dSk8NFMD7nj/e3hcO3Xm?=
 =?us-ascii?Q?gpmKp3j4Dltz/l6Tm5uGY1WIobo/1Ig+qvqhBpVIfP4Jgv9VE5Xyb70xrg7J?=
 =?us-ascii?Q?Ov2aJQvCj9o48kMfX1Uvhk4qC0gCpRlwwXBCalZ23q9URvUgAmqTZLanh4mC?=
 =?us-ascii?Q?FTBdDmhQYbC/RyK5qm8VQ3vrANdhzIgl81nicgJYkcSzYNhu+jynV48FeNOg?=
 =?us-ascii?Q?7x8vEA9YSh+x8uwCZWd+jD8rwtunqKBYDAAjzb/PbElNjCBXoPbBqZcsr2Le?=
 =?us-ascii?Q?H7K+mFAmH4NzikO0OysL7qCKuTsY/YcsQ4O1z/pjCH9RYhrq5CzQjIsa7sNG?=
 =?us-ascii?Q?OCvfsg/Y535US1xhyi2QMZGbx88pc+rWHAxzTfZiiXwWoqvd0w45E06kIZXo?=
 =?us-ascii?Q?E/pauk8Z3gYKX/Y3QdPIK9FKStxjumKUS1fSSBjXP8DlDIESjdmUsG7Qu2V7?=
 =?us-ascii?Q?25Qyf1hUihWqsWqlM3Q7tqP924sZzXNvZ+/GwwnPCokLw25EpU3Rl4Q1g9Xe?=
 =?us-ascii?Q?fbS2yd28krg0nfSYwJ59StFUYcYN9F3BaUqYzmyGToiTDxh1cHXnIO5WMo1H?=
 =?us-ascii?Q?49ekxiAGYsZr6T+2vCabmbX7mqIPi2zDInXtPRGQGVXhqW7CugRsMM1TN1vK?=
 =?us-ascii?Q?jHHjLd+sS3rTTkm00PNkNbfzPydh6nDHwuMetqlW1KZ0vJs6FepQ8Mv4EP6F?=
 =?us-ascii?Q?S21HYuQZStkcgOlaqmSP/JHVPEzJPalLoiHTajxbxpUeTXAYSpg6QnyBwFZo?=
 =?us-ascii?Q?mZc3FIGSAXvJIXWOUWikzp0Wkd3K29UwMaUVif3zZmOR7hz6Wfi9HkSaNpVq?=
 =?us-ascii?Q?HbtYOygZpAyX5BLOrl0sv6LvHYhiuesKq/6O62PvYahe7YDymTXjruo66Egc?=
 =?us-ascii?Q?ZVK9i16K8comYuc9StAk4SourUu0ESCuDqisgmEtyHUFUw8tunUE6F5boebd?=
 =?us-ascii?Q?JqmKxjSPllfJRHIXpILdUH0T0Yh5Cq4z/oBAWTLcBgKAQYp2ye8gOqc0bUCW?=
 =?us-ascii?Q?1KPrI52qu6MFn7At2FrJx6KeUX32BUZfcohusP9TKwFn4lJOZIx3mWWlnBqp?=
 =?us-ascii?Q?KoXKYu6vItIu3tjyMBtGR/s/c9kPvIrvVzTeZr6EYOhS0D1q6mOdWp664uda?=
 =?us-ascii?Q?aCHq/Y543XXTB+zRyoIduAhbwqb47SsY8LGHSAOZYsgH6TYDtlzxna+gGBfC?=
 =?us-ascii?Q?zyMRTDBbJ42StDa8XYiaWMaEfJBQ/XAxvtH1+hPraZD3l8h8DbJXBkAL0ozf?=
 =?us-ascii?Q?DeLr1lYdF3g3FryQ6GxZElboKbJuuPfiBd1m4CIR2dUS5Ddp/I0RV/7ntQfu?=
 =?us-ascii?Q?7bwtidGhlyW7f4lVJE1PnSzRGZj7Ya6Xp+HZ42jjmOhHJrLvXWA/8a11SR8E?=
 =?us-ascii?Q?60J+38dimmiOskI1akvxjxPdSg4G5/cG8qi1yTS0z4p13I+evsuFwBrtKCOe?=
 =?us-ascii?Q?eqH3yv6w87litDZogqC4RqftI53pDev4qbNd1oTlbWTpbR/bxc2+6i5w5Gh5?=
 =?us-ascii?Q?HKN1CKl552UYrY/4mx5u5bN89pO+hH7xszVsYSjB04P1iAmsI3z4fehz8x++?=
 =?us-ascii?Q?v3rOOZ5IffmjJQiJIhqVIdQ/dHdjetukVhOTTXYJ1oZYfnH5Rpc6mLTK9lr4?=
x-ms-exchange-antispam-messagedata-1:
 z3bKDO+/dVRPOyhqvTxtpKoKW+lNeDYMWF5GC4gkQdAhUVTKQe3OExpk
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86APN3P287MB3077INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e24a7fb3-b310-4c45-6183-08de4c58ebda
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 12:49:53.0351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnmJvLOJN303J9ecWC+rQjoy5BIlhOx5XxOkKT1H4iFjf9PyEu4+vvB/XW3LE2YvRnG9RvXXDNvZpHkWKmto/GUkN5dO5Djle45N2Vu+sWLSY4vmL6koNFqetpM+D3FGXP8kFRTC2ON9JNex5N/L4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0124
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86APN3P287MB3077INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86APN3P287MB3077INDP_"

--_000_PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86APN3P287MB3077INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

This patch adds support for AArch64 targets across the build
configuration files.

The changes include:
- Recognizing aarch64-pc-cygwin targets in config.guess
- Enabling dfp support for aarch64, consistent with existing x86 targets
- Disabling libgcj for aarch64 MinGW targets, matching x86_64 behaviour
- Ensuring appropriate target flags are applied for aarch64 MinGW builds

These updates prepare the build system for aarch64-based Windows
environments.

  *   No functional changes are introduced in this patch.


Please let me know if there are any concerns or if this should be split
into separate patches.

Thanks & regards
Thirumalai Nagalingam
<thirumalai.nagalingam@multicorewareinc.com<mailto:thirumalai.nagalingam@mu=
lticorewareinc.com>>

In-lined patch:

config.guess  | 3 +++
 config/dfp.m4 | 4 ++--
 configure.ac  | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/config.guess b/config.guess
index 1972fda8e..f7c9844b8 100755
--- a/config.guess
+++ b/config.guess
@@ -911,6 +911,9 @@ EOF
     i*:UWIN*:*)
        echo "$UNAME_MACHINE"-pc-uwin
        exit ;;
+    aarch64:CYGWIN*:*:*)
+       echo aarch64-pc-cygwin
+       exit ;;
     amd64:CYGWIN*:*:* | x86_64:CYGWIN*:*:*)
        echo x86_64-pc-cygwin
        exit ;;
diff --git a/config/dfp.m4 b/config/dfp.m4
index 5b29089ce..714bee6b2 100644
--- a/config/dfp.m4
+++ b/config/dfp.m4
@@ -22,8 +22,8 @@ Valid choices are 'yes', 'bid', 'dpd', and 'no'.]) ;;
   case $1 in
     powerpc*-*-linux* | i?86*-*-linux* | x86_64*-*-linux* | s390*-*-linux*=
 | \
     i?86*-*-elfiamcu | i?86*-*-gnu* | \
-    i?86*-*-mingw* | x86_64*-*-mingw* | \
-    i?86*-*-cygwin* | x86_64*-*-cygwin*)
+    aarch64-*-mingw* | i?86*-*-mingw* | x86_64*-*-mingw* | \
+    aarch64-*-cygwin* | i?86*-*-cygwin* | x86_64*-*-cygwin*)
       enable_decimal_float=3Dyes
       ;;
     *)
diff --git a/configure.ac b/configure.ac
index 05ddf6987..7e8a6b1c6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -869,7 +869,7 @@ case "${target}" in
   i[[3456789]]86-*-mingw*)
     noconfigdirs=3D"$noconfigdirs ${libgcj}"
     ;;
-  x86_64-*-mingw*)
+  aarch64-*-mingw* | x86_64-*-mingw*)
     noconfigdirs=3D"$noconfigdirs ${libgcj}"
     ;;
   mmix-*-*)
@@ -3225,7 +3225,7 @@ case " $target_configdirs " in
 esac

 case "$target" in
-  x86_64-*mingw* | *-w64-mingw*)
+  aarch64-*mingw* | x86_64-*mingw* | *-w64-mingw*)
   # MinGW-w64 does not use newlib, nor does it use winsup. It may,
   # however, use a symlink named 'mingw' in ${prefix} .



--_000_PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86APN3P287MB3077INDP_--

--_004_PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86APN3P287MB3077INDP_
Content-Type: application/octet-stream;
	name="Cygwin-Add-AArch64-support-in-config.guess-dfp.m4-an.patch"
Content-Description:
 Cygwin-Add-AArch64-support-in-config.guess-dfp.m4-an.patch
Content-Disposition: attachment;
	filename="Cygwin-Add-AArch64-support-in-config.guess-dfp.m4-an.patch";
	size=2622; creation-date="Mon, 05 Jan 2026 12:43:26 GMT";
	modification-date="Mon, 05 Jan 2026 12:49:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5ZmRlNGYzY2Q0Njc3YzNkMzFkZDc3NDA4MzljZjE1ODg3ZDA5NTEy
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogTW9uLCA1IEphbiAyMDI2IDE3OjUxOjEzICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBBZGQgQUFyY2g2NCBzdXBwb3J0
IGluIGNvbmZpZy5ndWVzcywgZGZwLm00LCBhbmQKIGNvbmZpZ3VyZS5hYwoK
VGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIEFBcmNoNjQgdGFyZ2V0cyBh
Y3Jvc3MgdGhlIGJ1aWxkCmNvbmZpZ3VyYXRpb24gZmlsZXMuCgotIFRlYWNo
IGNvbmZpZy5ndWVzcyB0byBpZGVudGlmeSBhYXJjaDY0LXBjLWN5Z3dpbiB0
YXJnZXRzCi0gRW5hYmxlIERGUCBzdXBwb3J0IGZvciBBQXJjaDY0LCBtYXRj
aGluZyBleGlzdGluZyB4ODYgdGFyZ2V0cwotIERpc2FibGUgbGliZ2NqIGZv
ciBBQXJjaDY0IHRhcmdldHMsIG1hdGNoaW5nIHg4Nl82NCBiZWhhdmlvcgot
IEVuc3VyZSBhcHByb3ByaWF0ZSB0YXJnZXQgZmxhZ3MgYXJlIGFkZGVkIGZv
ciBBQXJjaDY0IE1pbkdXIGJ1aWxkcwoKU2lnbmVkLW9mZi1ieTogUmFkZWsg
QmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+ClNpZ25lZC1v
ZmYtYnk6IFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5uYWdh
bGluZ2FtQG11bHRpY29yZXdhcmVpbmMuY29tPgotLS0KIGNvbmZpZy5ndWVz
cyAgfCAzICsrKwogY29uZmlnL2RmcC5tNCB8IDQgKystLQogY29uZmlndXJl
LmFjICB8IDQgKystLQogMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvY29uZmlnLmd1ZXNz
IGIvY29uZmlnLmd1ZXNzCmluZGV4IDE5NzJmZGE4ZS4uZjdjOTg0NGI4IDEw
MDc1NQotLS0gYS9jb25maWcuZ3Vlc3MKKysrIGIvY29uZmlnLmd1ZXNzCkBA
IC05MTEsNiArOTExLDkgQEAgRU9GCiAgICAgaSo6VVdJTio6KikKIAllY2hv
ICIkVU5BTUVfTUFDSElORSItcGMtdXdpbgogCWV4aXQgOzsKKyAgICBhYXJj
aDY0OkNZR1dJTio6KjoqKQorCWVjaG8gYWFyY2g2NC1wYy1jeWd3aW4KKwll
eGl0IDs7CiAgICAgYW1kNjQ6Q1lHV0lOKjoqOiogfCB4ODZfNjQ6Q1lHV0lO
KjoqOiopCiAJZWNobyB4ODZfNjQtcGMtY3lnd2luCiAJZXhpdCA7OwpkaWZm
IC0tZ2l0IGEvY29uZmlnL2RmcC5tNCBiL2NvbmZpZy9kZnAubTQKaW5kZXgg
NWIyOTA4OWNlLi43MTRiZWU2YjIgMTAwNjQ0Ci0tLSBhL2NvbmZpZy9kZnAu
bTQKKysrIGIvY29uZmlnL2RmcC5tNApAQCAtMjIsOCArMjIsOCBAQCBWYWxp
ZCBjaG9pY2VzIGFyZSAneWVzJywgJ2JpZCcsICdkcGQnLCBhbmQgJ25vJy5d
KSA7OwogICBjYXNlICQxIGluCiAgICAgcG93ZXJwYyotKi1saW51eCogfCBp
Pzg2Ki0qLWxpbnV4KiB8IHg4Nl82NCotKi1saW51eCogfCBzMzkwKi0qLWxp
bnV4KiB8IFwKICAgICBpPzg2Ki0qLWVsZmlhbWN1IHwgaT84NiotKi1nbnUq
IHwgXAotICAgIGk/ODYqLSotbWluZ3cqIHwgeDg2XzY0Ki0qLW1pbmd3KiB8
IFwKLSAgICBpPzg2Ki0qLWN5Z3dpbiogfCB4ODZfNjQqLSotY3lnd2luKikK
KyAgICBhYXJjaDY0LSotbWluZ3cqIHwgaT84NiotKi1taW5ndyogfCB4ODZf
NjQqLSotbWluZ3cqIHwgXAorICAgIGFhcmNoNjQtKi1jeWd3aW4qIHwgaT84
NiotKi1jeWd3aW4qIHwgeDg2XzY0Ki0qLWN5Z3dpbiopCiAgICAgICBlbmFi
bGVfZGVjaW1hbF9mbG9hdD15ZXMKICAgICAgIDs7CiAgICAgKikKZGlmZiAt
LWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5hYwppbmRleCAwNWRk
ZjY5ODcuLjdlOGE2YjFjNiAxMDA2NDQKLS0tIGEvY29uZmlndXJlLmFjCisr
KyBiL2NvbmZpZ3VyZS5hYwpAQCAtODY5LDcgKzg2OSw3IEBAIGNhc2UgIiR7
dGFyZ2V0fSIgaW4KICAgaVtbMzQ1Njc4OV1dODYtKi1taW5ndyopCiAgICAg
bm9jb25maWdkaXJzPSIkbm9jb25maWdkaXJzICR7bGliZ2NqfSIKICAgICA7
OwotICB4ODZfNjQtKi1taW5ndyopCisgIGFhcmNoNjQtKi1taW5ndyogfCB4
ODZfNjQtKi1taW5ndyopCiAgICAgbm9jb25maWdkaXJzPSIkbm9jb25maWdk
aXJzICR7bGliZ2NqfSIKICAgICA7OwogICBtbWl4LSotKikKQEAgLTMyMjUs
NyArMzIyNSw3IEBAIGNhc2UgIiAkdGFyZ2V0X2NvbmZpZ2RpcnMgIiBpbgog
ZXNhYwoKIGNhc2UgIiR0YXJnZXQiIGluCi0gIHg4Nl82NC0qbWluZ3cqIHwg
Ki13NjQtbWluZ3cqKQorICBhYXJjaDY0LSptaW5ndyogfCB4ODZfNjQtKm1p
bmd3KiB8ICotdzY0LW1pbmd3KikKICAgIyBNaW5HVy13NjQgZG9lcyBub3Qg
dXNlIG5ld2xpYiwgbm9yIGRvZXMgaXQgdXNlIHdpbnN1cC4gSXQgbWF5LAog
ICAjIGhvd2V2ZXIsIHVzZSBhIHN5bWxpbmsgbmFtZWQgJ21pbmd3JyBpbiAk
e3ByZWZpeH0gLgogICAgIEZMQUdTX0ZPUl9UQVJHRVQ9JEZMQUdTX0ZPUl9U
QVJHRVQnIC1MJHtwcmVmaXh9LyR7dGFyZ2V0fS9saWIgLUwke3ByZWZpeH0v
bWluZ3cvbGliIC1pc3lzdGVtICR7cHJlZml4fS8ke3RhcmdldH0vaW5jbHVk
ZSAtaXN5c3RlbSAke3ByZWZpeH0vbWluZ3cvaW5jbHVkZScKLS0KMi41Mi4w
LndpbmRvd3MuMQoK

--_004_PN3P287MB3077B9E8B2A9B9A8C6B0005C9F86APN3P287MB3077INDP_--

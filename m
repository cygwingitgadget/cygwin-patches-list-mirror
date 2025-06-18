Return-Path: <SRS0=pByE=ZB=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on20707.outbound.protection.outlook.com [IPv6:2a01:111:f403:260c::707])
	by sourceware.org (Postfix) with ESMTPS id 75BE33892BD6
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 12:05:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 75BE33892BD6
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 75BE33892BD6
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260c::707
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750248353; cv=pass;
	b=jA2AmYUa0QQ1HAhQQUqjmYq7Wc/+oXHZ+ID1hDgY/y8m1nd/AW4t6U2MaQOQ0pKiLrM5p7ylKrC5FMa+fW6ecrdt12PF4DeCu8chLYQoK7tI56ClkwhDwDZIsaXMqdf+3BBghlkihCo1+d3HwujLA4olIvU3H9Qb0kUdiOpRlco=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750248353; c=relaxed/simple;
	bh=NW/6K7YQurXkVxpnvfeZ88hFxyj7F5ZYmH719lPTFFc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=g3qQVDohOzCX3R3CFMfsZQxxLmX13hrvFJ3Y4HWqbHrLKpr3i8oNfnC5Dkazbj9p0uhtsmrsyO4wXxjWE62VGMJigQjwdmm90lXb5AvohBoMxdJwqLucbEcM4rTqBzrkrZDlHuabltOdmM09Owb4wpfUQrmQw4elBOCjweOmFvw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 75BE33892BD6
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=UMI5ssym
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/7xkDm7K45TIGAHQwPG78cz72BPheCwsnsN/bu/J+owJ+oTQIFtndQejboCM1pLUAwNwoMDBFvhWC4eGtg6J7pexAJ9y2ayEEVJRFGkVsPvf0uq/xZxDopaiKKGDQutBvzsDFur82OoEy+le8wBxejr4R4bXfKYb9IfjiVWSKtCfbriiHgzHGSIkpyx7V1xKJ46GCQhyN8sgEXpbHHJMi23I4sCSdd5tcePqQ3FBnd7dmYDTWIGY5A+tdDz8YVxXgPR6AtoYS6GzNXV8I0Xyte1Z44YqPzUC51COmihVLZDq92KCXP0pAOtJxmZ7Rk8AcO4ZOVPpRqHGDKA8u9l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9A29jryu7le6bpzfqiekNsqtWANyQQ1aOhRBPbQ/R4=;
 b=r69bwLREhpwbOOzvmEzQVaqvcWrtwm6cL+NK5fLENpT2SE9oSez574jtjs/lpjU0FJftd1IITXdTTyAdaYyhz/eYBOgUoAQBe2WGRIqlmITw+GFWckX8HYhL85m8ImTNAzBU/vP0QqhJvac9eTVmNlEwbjRdZgLKcJqNYsiBYNmTyR9jF7xgiCduSz8P0211IQ09RqjML3DboDylidpKsoU+jKcpMgs9UvTfPHgkcLAZSR1iEVIiQ3O6gfgn4nBHzlihISMWQ87Jj1kkLXZdSAt7KATFPRLfGMRllNKN7bMzBHh4UMQelZQjC4oUATlpNpZeOsVHvzVZav8KU8LQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9A29jryu7le6bpzfqiekNsqtWANyQQ1aOhRBPbQ/R4=;
 b=UMI5ssymuKDKiyAeobg9APoowVhGwKcveKEHdsJmrSLBXIH+t/vlwnw+8lUg6HBrurD/+3KuuE2Z7o6PqddMQ8v0K8rPN8jzYTyP7QVgSbn5HyvtgmHmAKg4Hb5DKloH02ynitywMppwFnytpitBMSI6AfeHmYEDkh8p5/xNB3A=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0650.EURPRD83.prod.outlook.com (2603:10a6:150:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.16; Wed, 18 Jun
 2025 12:05:48 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.006; Wed, 18 Jun 2025
 12:05:48 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Radek Barton
	<radek.barton@microsoft.com>
Subject: [PATCH v2] Cygwin: fix compatibility with GCC 15
Thread-Topic: [PATCH v2] Cygwin: fix compatibility with GCC 15
Thread-Index: AQHb4ElUg8RZU+kBl06Iq9i1DsT5Cw==
Date: Wed, 18 Jun 2025 12:05:48 +0000
Message-ID:
 <DB9PR83MB0923C311FFF85FC2D2D2428F9272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB09231D8148C836A3AECDB3E19270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB09231D8148C836A3AECDB3E19270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-18T12:05:47.538Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0650:EE_
x-ms-office365-filtering-correlation-id: 2964d5ab-7aab-43cf-4e60-08ddae60767e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?5DUSptoR+JdrLluOGmzcBX3bZ1B+aAw6tfm8bQkQAZNu4zWktobCW+uvWv?=
 =?iso-8859-2?Q?r57QWds1agZ5NM0KBwsRLxhdUaZS98HxEsz20QzddEplWfxfM5vnPncUYG?=
 =?iso-8859-2?Q?ELaE+Amo+JI4qtN3gioYh3Dg7+SFCJLJit6f5q40mwtkPj0C7CkSgYC7Bl?=
 =?iso-8859-2?Q?uMRA3ZZBd0VssK9k8QyXijC69f/AGaKVdZhTNIM09DKxkTu6uA38ql8Cmb?=
 =?iso-8859-2?Q?eViXOOkhxVmKBBd+fJh39/7HbVWsZ5DhLXbDdnjp+lTnbWXyzTtQHZwiKt?=
 =?iso-8859-2?Q?VcpsASqsTXvSedm7QAtUX24dxQjqCIR4l1ZOLMVX6JlBRydFTFxzUtnJy0?=
 =?iso-8859-2?Q?XWwy8dOfX2ky5njWenuJBC+OaK1iAhHnrzud1Q0owFkPnFoTR9h1Vy9mBW?=
 =?iso-8859-2?Q?/YY6bOFWxiIMpVbVPR/Pm/JDXFY4gRmSTP5wX1wMln/+lUwzgzhcR8L90p?=
 =?iso-8859-2?Q?qyESc7sVYrAUSxfKBkeuOpEyw5g9Z8uS+r0qpxK23lFwEiplxBYNOjC+Jz?=
 =?iso-8859-2?Q?o6HBIvmfrbmS/Bhlsq6E+3q2DblD/+WI13pw0DS1x/oem22VLvSqrarh5j?=
 =?iso-8859-2?Q?WzECNJ9CMwvpNV/DN+tbJgSXHIb1MhGhT9bkRAdA+kpbft086drQ0ASs5S?=
 =?iso-8859-2?Q?M0xDTpOncklLf6yZoA8BLoUqJKcdYxJZcOj6kQje/F2e3mF2CcOlvMBAwX?=
 =?iso-8859-2?Q?vzDFW6taY3JUbFj9tAR8q+ZIedRh2zp6OpZeD+KcVHvyl0kZcPBgxDAxPe?=
 =?iso-8859-2?Q?WHAKPNXx8WxQ1/wXTh4QeGYZvr1qsu17FgzkHycDcI7c23ynrxoYJujCSX?=
 =?iso-8859-2?Q?8LnK1YR5OVN0yNDVpPem9XWHUL4tKuXqyfnPe7ap8odJZaGty0j5SWAhlv?=
 =?iso-8859-2?Q?ULt3Ka7NnohH0SjXT2DSKfVzhL+AwS+8rN7KcXo/QJHWxOzbuhZvlpgsSN?=
 =?iso-8859-2?Q?RjqyOCZ2zqug7/FHoAlMMkuSEFMJPaDuxT5yEq8RTnFwT7qFCXNN6slx2m?=
 =?iso-8859-2?Q?qQhBXhLVyFV4/P839GqIf/NMlnfQn3xG3fsqRc5speGcgsTb+jcFaLAmuZ?=
 =?iso-8859-2?Q?tlrfgcZDpRHkFdNM5OfzgpVRiJY0XzbMu/cdHkCoDeAvyY7TtaBnMxPDP5?=
 =?iso-8859-2?Q?M3h8rFICZKHx47KZDlZ39GQ46ddIriSV9IXWAw/Stns5FFsEVYzcLqv8S6?=
 =?iso-8859-2?Q?MBw4231EhK3mW8khowfuRQz1ytNNz8/WKzi6T/tMUMi+FiI06oDLrrteuD?=
 =?iso-8859-2?Q?QViFWHLUC+vFVsuFrGNqX92rqMjVneT9nRVbr3ThnNKneJkwnNwTJW+TeT?=
 =?iso-8859-2?Q?oXox4Inf9sIlrHliHbAuRTQqCICZuODDlHg9uJAarjHY/+cYuDkmVdH/9t?=
 =?iso-8859-2?Q?dqNDQHyj8VmtWFJTMVIErM6t2Ojb6WMu/nsJr6OUoGmxBvFXL7xdG2XspL?=
 =?iso-8859-2?Q?fx8wtQ4r92+mSfc7ZXrbw8MQNUNzAv66WDf9/W1yBbTt+XwtP4Yyx0k7gT?=
 =?iso-8859-2?Q?p7SLo5PwfDvU2YLiPT0gYnCzmCXFaiZaQnHPktC7QCvSp+fzgnTaiHOrYX?=
 =?iso-8859-2?Q?9chlP7Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?IVMD9OM8JDU0S8/C6kBEl2HgwwyCUjm+l2TQT30IOUYdTUNkCZtgS/2n5z?=
 =?iso-8859-2?Q?mK58dGnHW7D3zwgW+3N3ZH/+4mtnRRY8xoHlP7cMRS664LdpYgXLgdNirg?=
 =?iso-8859-2?Q?q2NljmKuDbpO2LQ+YX7pocydrM4Di1tZbpPj+oJrpzrc3rOiHpAF3LgKeD?=
 =?iso-8859-2?Q?sP3b5X5kxJTrnu05hcso/mIW5v+RD6cooqVqU44vEFAZh5FAwrb7cfb8Ml?=
 =?iso-8859-2?Q?yON/9NS0cFm1djAAfbb5HrwL0LDBYgoilKhUWyEqNyep9DhITWlmhxNSnG?=
 =?iso-8859-2?Q?lhImqo1F3IcbwVKmMvLboeMwus+rXXF+fq8XE9p/IbhLsvhxxe3rghBc2V?=
 =?iso-8859-2?Q?gCk0fnjQ/LXv3KxgR4ki+ItTEuQ7OOeV0/aA+ucJhElHSCRlOXBv6/zoaI?=
 =?iso-8859-2?Q?efTBLsajDTfqnJc9jx8oJ54hXLcqlJMbViHULhOiZ4HkkG8NGomh1exwy1?=
 =?iso-8859-2?Q?ReiKAFwEYzCOLlUvy/sAPA0na/GQmmGTZA4bDsgtMc1aeHRAvoL1Zy/B1W?=
 =?iso-8859-2?Q?Jth4YA1biaKibwDn9okSl3IlY2OtMTsOcqV824wEYs2QDQvnImj8ZNXKXG?=
 =?iso-8859-2?Q?Wa2OeGH8VgtoOeY9C8w9dpAQQbfv0S5F8c/YJKkiqxwvGqKKUNRpbqTzHx?=
 =?iso-8859-2?Q?M7V7pIrkvWc8BmBhAWoMnWEzoGHE6BehlQ2DyOuQH16nsQK5vTi1GW/bAq?=
 =?iso-8859-2?Q?ixp7je/zeef71RV4n6vDGA19NPBvy1eDsCBnoKfOeE7KahnLGZnxxHG0u2?=
 =?iso-8859-2?Q?qI+UZiC9/VfDC4Bhasur5sBPq9yphSQdzUCKk7JTX//IywAZ54+r/rmnAS?=
 =?iso-8859-2?Q?Grtgsn5Jpk7tnIqFgTURGd/bxIVya79L3WQCwUQ0DnF2rIHfO1VyQiuJXw?=
 =?iso-8859-2?Q?IPeTN5zNic192yDPZGl7K5/Pegm3a9RrnEGU0n7O1fe5Mhj3v4NgSRLjzZ?=
 =?iso-8859-2?Q?7eAERmJTronu9gOyy3ayFzjJTmeag+uBoEEng86a+UqkaTynkKEWTDXlDd?=
 =?iso-8859-2?Q?bMhmlNdOGCxJvloyO8iEE5NLRn6x5pIDwwKDY+57l0VN4l9wv8h8t+FxgY?=
 =?iso-8859-2?Q?8mvhxCCMwHPRGbdQBxJQnR5DGrgf+gFBbgAOZM3orrtBaY22MrHWVlnXAt?=
 =?iso-8859-2?Q?gI8Tf1Sgp9mAwUFNzRxX+8tyod4o7od5jM3fQGrIcJVnqnQmsorHVRHV43?=
 =?iso-8859-2?Q?MMCKAo88vi7HLGGdGqxgflH8KpkgDjijKeSbcQC8G19h1+v3QyRg0BVFQz?=
 =?iso-8859-2?Q?2uTS9Ke43odUTC8lxU8c93iVUSWDnAdvYdqjpLg/hWmrnAN7RK5QTuEaxy?=
 =?iso-8859-2?Q?4vt0VS//7NxtpHkvDYlV1lxarkpAQf6Z48YAkOa8ryx9ohhgEdNkatkGqr?=
 =?iso-8859-2?Q?qoeYDw3rEO4+2ZXl3kAeOQ2Aczu8ebAIrR2fA0I6P+/y3PkJuSBW2M12WQ?=
 =?iso-8859-2?Q?6Wn44xlJ9ALXtqkrmeL/X7X8/Z+Zjen+BCCwEjaVHw4QDG98rCSyFcn6/I?=
 =?iso-8859-2?Q?nK9vWhDzgfcy/kDph28VKRfZog5GOoeaFn/SeB7HHOdN8UhCf0ORfezY7Y?=
 =?iso-8859-2?Q?7mCZtMdIv1Ow44CC/PiJGuC2AAZI?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923C311FFF85FC2D2D2428F9272ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2964d5ab-7aab-43cf-4e60-08ddae60767e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:05:48.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTXYO6dJgrOMh85mZ/5net0xy2SUGsVhr5hhjMkMmhDVFVIo8ueuxMHtrnwvFOfYVgRv1+mwYVSQYdu7Y7xnnZ2E7+/HctLUEqtLjBw3t0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0650
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923C311FFF85FC2D2D2428F9272ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello=0A=
=0A=
Sending second version with Signed-off-by header.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 715fe9b84a9e290efda46c0a8c649fe145c981cf Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 12:42:05 +0200=0A=
Subject: [PATCH v2] Cygwin: fix compatibility with GCC 15=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/create_posix_thread.cc    | 2 +-=0A=
 winsup/cygwin/local_includes/fhandler.h | 6 +++---=0A=
 winsup/cygwin/local_includes/thread.h   | 6 +++---=0A=
 3 files changed, 7 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_po=
six_thread.cc=0A=
index 8e06099e4..3fcd61707 100644=0A=
--- a/winsup/cygwin/create_posix_thread.cc=0A=
+++ b/winsup/cygwin/create_posix_thread.cc=0A=
@@ -206,7 +206,7 @@ class thread_allocator=0A=
 public:=0A=
   thread_allocator () : current (THREAD_STORAGE_HIGH)=0A=
   {=0A=
-    alloc_func =3D wincap.has_extended_mem_api () ? &_alloc : &_alloc_old;=
=0A=
+    alloc_func =3D wincap.has_extended_mem_api () ? &thread_allocator::_al=
loc : &thread_allocator::_alloc_old;=0A=
   }=0A=
   PVOID alloc (SIZE_T size)=0A=
   {=0A=
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_=
includes/fhandler.h=0A=
index 03f20c8fd..3d9bc9fa5 100644=0A=
--- a/winsup/cygwin/local_includes/fhandler.h=0A=
+++ b/winsup/cygwin/local_includes/fhandler.h=0A=
@@ -1699,9 +1699,9 @@ class fhandler_disk_file: public fhandler_base=0A=
   uint64_t fs_ioc_getflags ();=0A=
   int fs_ioc_setflags (uint64_t);=0A=
 =0A=
-  falloc_allocate (int, off_t, off_t);=0A=
-  falloc_punch_hole (off_t, off_t);=0A=
-  falloc_zero_range (int, off_t, off_t);=0A=
+  int falloc_allocate (int, off_t, off_t);=0A=
+  int falloc_punch_hole (off_t, off_t);=0A=
+  int falloc_zero_range (int, off_t, off_t);=0A=
 =0A=
  public:=0A=
   fhandler_disk_file ();=0A=
diff --git a/winsup/cygwin/local_includes/thread.h b/winsup/cygwin/local_in=
cludes/thread.h=0A=
index 3955609e2..cbbbc3f1e 100644=0A=
--- a/winsup/cygwin/local_includes/thread.h=0A=
+++ b/winsup/cygwin/local_includes/thread.h=0A=
@@ -221,12 +221,12 @@ public:=0A=
   ~pthread_key ();=0A=
   static void fixup_before_fork ()=0A=
   {=0A=
-    for_each (_fixup_before_fork);=0A=
+    for_each (&pthread_key::_fixup_before_fork);=0A=
   }=0A=
 =0A=
   static void fixup_after_fork ()=0A=
   {=0A=
-    for_each (_fixup_after_fork);=0A=
+    for_each (&pthread_key::_fixup_after_fork);=0A=
   }=0A=
 =0A=
   static void run_all_destructors ()=0A=
@@ -245,7 +245,7 @@ public:=0A=
     for (int i =3D 0; i < PTHREAD_DESTRUCTOR_ITERATIONS; ++i)=0A=
       {=0A=
 	iterate_dtors_once_more =3D false;=0A=
-	for_each (run_destructor);=0A=
+	for_each (&pthread_key::run_destructor);=0A=
 	if (!iterate_dtors_once_more)=0A=
 	  break;=0A=
       }=0A=
-- =0A=
2.49.0.vfs.0.4=0A=
=0A=

--_002_DB9PR83MB0923C311FFF85FC2D2D2428F9272ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-fix-compatibility-with-GCC-15.patch"
Content-Description: v2-0001-Cygwin-fix-compatibility-with-GCC-15.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-fix-compatibility-with-GCC-15.patch"; size=2623;
	creation-date="Wed, 18 Jun 2025 12:05:22 GMT";
	modification-date="Wed, 18 Jun 2025 12:05:22 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3MTVmZTliODRhOWUyOTBlZmRhNDZjMGE4YzY0OWZlMTQ1Yzk4MWNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEyOjQyOjA1ICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQ3lnd2luOiBmaXggY29tcGF0aWJpbGl0eSB3aXRoIEdD
QyAxNQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9
VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKU2lnbmVkLW9mZi1ieTogUmFk
ZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+Ci0tLQogd2luc3VwL2N5Z3dp
bi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjICAgIHwgMiArLQogd2luc3VwL2N5Z3dpbi9sb2NhbF9p
bmNsdWRlcy9maGFuZGxlci5oIHwgNiArKystLS0KIHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVk
ZXMvdGhyZWFkLmggICB8IDYgKysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3Np
eF90aHJlYWQuY2MgYi93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQuY2MKaW5kZXgg
OGUwNjA5OWU0Li4zZmNkNjE3MDcgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vY3JlYXRlX3Bv
c2l4X3RocmVhZC5jYworKysgYi93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQuY2MK
QEAgLTIwNiw3ICsyMDYsNyBAQCBjbGFzcyB0aHJlYWRfYWxsb2NhdG9yCiBwdWJsaWM6CiAgIHRo
cmVhZF9hbGxvY2F0b3IgKCkgOiBjdXJyZW50IChUSFJFQURfU1RPUkFHRV9ISUdIKQogICB7Ci0g
ICAgYWxsb2NfZnVuYyA9IHdpbmNhcC5oYXNfZXh0ZW5kZWRfbWVtX2FwaSAoKSA/ICZfYWxsb2Mg
OiAmX2FsbG9jX29sZDsKKyAgICBhbGxvY19mdW5jID0gd2luY2FwLmhhc19leHRlbmRlZF9tZW1f
YXBpICgpID8gJnRocmVhZF9hbGxvY2F0b3I6Ol9hbGxvYyA6ICZ0aHJlYWRfYWxsb2NhdG9yOjpf
YWxsb2Nfb2xkOwogICB9CiAgIFBWT0lEIGFsbG9jIChTSVpFX1Qgc2l6ZSkKICAgewpkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5oIGIvd2luc3VwL2N5
Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5oCmluZGV4IDAzZjIwYzhmZC4uM2Q5YmM5ZmE1
IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2ZoYW5kbGVyLmgKKysr
IGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5oCkBAIC0xNjk5LDkgKzE2
OTksOSBAQCBjbGFzcyBmaGFuZGxlcl9kaXNrX2ZpbGU6IHB1YmxpYyBmaGFuZGxlcl9iYXNlCiAg
IHVpbnQ2NF90IGZzX2lvY19nZXRmbGFncyAoKTsKICAgaW50IGZzX2lvY19zZXRmbGFncyAodWlu
dDY0X3QpOwogCi0gIGZhbGxvY19hbGxvY2F0ZSAoaW50LCBvZmZfdCwgb2ZmX3QpOwotICBmYWxs
b2NfcHVuY2hfaG9sZSAob2ZmX3QsIG9mZl90KTsKLSAgZmFsbG9jX3plcm9fcmFuZ2UgKGludCwg
b2ZmX3QsIG9mZl90KTsKKyAgaW50IGZhbGxvY19hbGxvY2F0ZSAoaW50LCBvZmZfdCwgb2ZmX3Qp
OworICBpbnQgZmFsbG9jX3B1bmNoX2hvbGUgKG9mZl90LCBvZmZfdCk7CisgIGludCBmYWxsb2Nf
emVyb19yYW5nZSAoaW50LCBvZmZfdCwgb2ZmX3QpOwogCiAgcHVibGljOgogICBmaGFuZGxlcl9k
aXNrX2ZpbGUgKCk7CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL3Ro
cmVhZC5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy90aHJlYWQuaAppbmRleCAzOTU1
NjA5ZTIuLmNiYmJjM2YxZSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRl
cy90aHJlYWQuaAorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL3RocmVhZC5oCkBA
IC0yMjEsMTIgKzIyMSwxMiBAQCBwdWJsaWM6CiAgIH5wdGhyZWFkX2tleSAoKTsKICAgc3RhdGlj
IHZvaWQgZml4dXBfYmVmb3JlX2ZvcmsgKCkKICAgewotICAgIGZvcl9lYWNoIChfZml4dXBfYmVm
b3JlX2ZvcmspOworICAgIGZvcl9lYWNoICgmcHRocmVhZF9rZXk6Ol9maXh1cF9iZWZvcmVfZm9y
ayk7CiAgIH0KIAogICBzdGF0aWMgdm9pZCBmaXh1cF9hZnRlcl9mb3JrICgpCiAgIHsKLSAgICBm
b3JfZWFjaCAoX2ZpeHVwX2FmdGVyX2ZvcmspOworICAgIGZvcl9lYWNoICgmcHRocmVhZF9rZXk6
Ol9maXh1cF9hZnRlcl9mb3JrKTsKICAgfQogCiAgIHN0YXRpYyB2b2lkIHJ1bl9hbGxfZGVzdHJ1
Y3RvcnMgKCkKQEAgLTI0NSw3ICsyNDUsNyBAQCBwdWJsaWM6CiAgICAgZm9yIChpbnQgaSA9IDA7
IGkgPCBQVEhSRUFEX0RFU1RSVUNUT1JfSVRFUkFUSU9OUzsgKytpKQogICAgICAgewogCWl0ZXJh
dGVfZHRvcnNfb25jZV9tb3JlID0gZmFsc2U7Ci0JZm9yX2VhY2ggKHJ1bl9kZXN0cnVjdG9yKTsK
Kwlmb3JfZWFjaCAoJnB0aHJlYWRfa2V5OjpydW5fZGVzdHJ1Y3Rvcik7CiAJaWYgKCFpdGVyYXRl
X2R0b3JzX29uY2VfbW9yZSkKIAkgIGJyZWFrOwogICAgICAgfQotLSAKMi40OS4wLnZmcy4wLjQK
Cg==

--_002_DB9PR83MB0923C311FFF85FC2D2D2428F9272ADB9PR83MB0923EURP_--

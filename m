Return-Path: <SRS0=s6lY=ZR=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20721.outbound.protection.outlook.com [IPv6:2a01:111:f403:260d::721])
	by sourceware.org (Postfix) with ESMTPS id 152A53852FDE
	for <cygwin-patches@cygwin.com>; Fri,  4 Jul 2025 14:18:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 152A53852FDE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 152A53852FDE
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260d::721
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751638713; cv=pass;
	b=A0nEGqvY0+9IAlxDk5rt4bPdZ/9RJl/XD321bcvPQ3DnTWjjkZnKyOwSAhAEwBc3VjPyzDZHShPii4LzFZy6Viqoe2A/jSaCg+J8GOo1eU0kjp8Ux02cJdu6NaFHYnig6LgUh47eNAD2Jc1+HcP+T6HdEpglXsOMP8hBTi0qY94=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751638713; c=relaxed/simple;
	bh=ELbgRJLYFzgmIPwu6UG3VukxIWQ4JxUo3r9Y09PTJYw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=I92mNuShVo8x07fBxb/lqXj8aacTumcKvrestaGUCaCwqoEGwWSNZGrthIGCH1Fv+pKdOUqa3tZfDOaxnv2Q8qbW1o0oxM2YVdsjyu9gi4gJMTr6xC2d4lQlAsOQVTYBwgCCXJ18LlG1YgSjXMGBIC4dmGYXiOC04/sEaCocgaE=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 152A53852FDE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=KI7xZ1GA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeRQpQEmRmZf65ZYPoQkgOgfL7IrBvS6hA/0BvQZhgzeEjrAM0L9DQ5YPrA84iIfKOfxPKw4gVCDNQTBlBrZca+v27wZ3u+7Ubl5Lu0E+bHggrM8zP1CONG89t92CsZE/2kllWDQJ7sGb09UICC8Jz4EdrugQIZ+ZQWvOFRea2jz7c60qhTyHeSO3kkmNzuDNUXoeAgNVORVLi8OGH3GpDaUspoJmTUIUWZ8UnDvT316c1Dco35+7M4owyV62KQMHmAWOqUTbyOYbwUP/5RmwjPHKAbE9CFuAOPDcoryqk0R99l2FiQ+bM01ujMtpcbJZQy03xw8eCLbDioZp7H5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nnuE/q1f9LLQjfTw1diWFqrQ3MdLB0CSxjU3icJtks=;
 b=O9ta3Cqmh19pL7XtLhsn5fgu7vdZWIx2IGaggYpmzoVnjVtGj0P+Rb2Il8ehP1QEmD+v78IdGLVCZXHMSsnAVk6pHhD6odgI3qO0XR/44RDfwMU4w2jdBewO/B27IEAWzllAZxTkhFxXSI6Np++quFmX9JPWpWSE+ycM0e65qSDGXZFo8U9qabbmvSU4ycWGpzVDOuiYdg5c7a4ACOeQJTeRt8W8gyY4rP/Tnwb96w1fWBOqkoTFNGsJS1wwkPfIFojvQsbA2JnObvwzsvdhK/nppzbYPyDeWvTUILD1gqXUT4jh6H/9LRYrx0jygzzWckyBoK3Dn7Pbk/PEslc8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nnuE/q1f9LLQjfTw1diWFqrQ3MdLB0CSxjU3icJtks=;
 b=KI7xZ1GALwqyohLPKYGRmhOFaJqEir6Ee3hLszGl/5JMeoLLGdjKBabL+MLOOo2aLcyQq9lYs+KfA0ThdBx+y92tIZxWOk8Zj36wo++fYlg+DZzPG8SFwmOefPfCKaqKMjF7RfTKfVpTTZMdY2zgBZq0VFy5iXtWAGAjw3biUHc=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU5PR83MB0639.EURPRD83.prod.outlook.com (2603:10a6:10:522::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.10; Fri, 4 Jul
 2025 14:18:29 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Fri, 4 Jul 2025
 14:18:29 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v4] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Thread-Topic: [PATCH v4] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for
 AArch64
Thread-Index: AQHb7O6DHnZn57FsoUG6qTY3/RCFKQ==
Date: Fri, 4 Jul 2025 14:18:29 +0000
Message-ID:
 <DB9PR83MB09231472E10A14139FF803A89242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
 <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
 <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
 <81096ca9-9542-4818-b363-f3856915050f@dronecode.org.uk>
 <aFwaB47HM8UDH9CK@calimero.vinschen.de>
 <DB9PR83MB09239C78F66E20045E2F4A269243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923B144F86ADC301E17B3399242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aGe1pC9zNUhWzARd@calimero.vinschen.de>
In-Reply-To: <aGe1pC9zNUhWzARd@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-04T14:18:28.701Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU5PR83MB0639:EE_
x-ms-office365-filtering-correlation-id: 8b0d97e1-d9be-43a7-b8c7-08ddbb05a66c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?izFt3dXky6VeqNJs/LVL4BwFxVHruFaEhxNNFasKG7tPQbtA1WsdF45oUf?=
 =?iso-8859-2?Q?FMcoqIUo7dTyyr9Rr1F9Adnhwpr/dvNoTc+jfDWF2Ne8dyGhWU/n77K8Db?=
 =?iso-8859-2?Q?lP111f5j7ouaX4KJRXKXR+k7fsBokk+9NrUUvqcUTQOShBgtIZP466LSgv?=
 =?iso-8859-2?Q?7xTEBevEyqkOcQ6W/zFPv2J0l7kbfmJyLfNjVbhGr859h6e0hXXSwBZ7d1?=
 =?iso-8859-2?Q?4Jtb/DUOkqmm7VZWO/0pSw2QTCIc0e2jvm6VWslhOfiECx6PZ9+5WtixhK?=
 =?iso-8859-2?Q?ye5aIBjwpf17xgP4tUxY/ur/zBQUQMXUS8HP1vWiSUSpixqJ+5h/Ewd81T?=
 =?iso-8859-2?Q?2mAaMY4ErvefBMMus3LS3VHrWCeUD4sVp6W63O1TkZcKVzxfTzXBSKPUZR?=
 =?iso-8859-2?Q?57cHd+gle0SZMA3LhoNx4FEvOtTn9+8E+mqWZuX0fpfg09V3OAuD6v9++h?=
 =?iso-8859-2?Q?jxT/phd3zGeubDWuW7y/X2LpFaooHLijvb0dlnCZWAGpTA0QJknbN5/pw7?=
 =?iso-8859-2?Q?+/f/I77/G5B7HrGfwKEeZ2hRKBmJXhxuGwsdFv3zIV6+2zQ9Su8eRR9YMk?=
 =?iso-8859-2?Q?YKnj8Up3avlKqSxWUEyCQqnaVSvF8pKuUL72dm86Jtw9a6+RdiDeD/1BOI?=
 =?iso-8859-2?Q?ovt9groXBc8gZww6RBJPBXE3Pa+jCxiSManzCt9wg906LumVfIhJGM9bUy?=
 =?iso-8859-2?Q?whQn26WR8UgUSd7m66Qqh/53XvrgKkpViP2yyGwn/+PiEDl3RLmKfHLG+5?=
 =?iso-8859-2?Q?r+MwIW8aWUrAXuTYwWHniFgfzobHSsDY0Sq32DkZcLifLvSDvTd8buAw3Q?=
 =?iso-8859-2?Q?8sIfhWP3lO8prgHpVp8buXZK0k+wOUVsuEllO3asg+qKgJEKeCiChJJcTw?=
 =?iso-8859-2?Q?mjUd43OYwVeeOSLR7pVcwWH0Cx98lxa5Tqkai4fIrv/ajLmXsBeNgA4IwK?=
 =?iso-8859-2?Q?ghlzdcoek9pofHYw6Bm139nTF8GQ923VF5nVE8aJHIuiktHDRhOhnIarc4?=
 =?iso-8859-2?Q?MZPhlrH/u4TcclK1Zp+YeCB9GzRct5tYvHjSz1+UGGia0/J+qw0yoAQp+M?=
 =?iso-8859-2?Q?+WpZviwEO5fU7z+0LQ4gmudA473ZWF3Lk9O2epMBut8WrCEGo2C2+cb1ZN?=
 =?iso-8859-2?Q?or7uRWSSllpytLk4B8ERhvgaC+pnBSEsjDKcknrlnZCeberDyPXoYtAmOg?=
 =?iso-8859-2?Q?MRKFLIp7qectQk7cPS2Xk/o11dnNt61vtv4EB+xkBY0E+G78sJh9ClOQL/?=
 =?iso-8859-2?Q?Zo+flAUiQQtipsnFjOdLNygWLDRsWajVdawV/XOLBnC8si50wImbCnucgo?=
 =?iso-8859-2?Q?BT7WrSC2DuHJ0gz6W7ABp7Wa8z4HRWGggTgjnHInuQLcWB825GXP9TqFX6?=
 =?iso-8859-2?Q?50P/4ee7PdjTelhEC53e1tD72YLr7U3lPeZeQE+o1NtcgrLUhvngZtULOn?=
 =?iso-8859-2?Q?7RQE3srSVF0D6jw6jSl6xqHlxrCKaTCv5yKV4x7WrmwUMgTIXp/Nu4bD5x?=
 =?iso-8859-2?Q?Ilxb74sXEbRKeWpmMw3RbXP+v0iQXSfQ5uuigNBvhQ7hLuRWcNzO9ceaM4?=
 =?iso-8859-2?Q?P+NBlTg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?NGMJZAHRnS6j/pnI5178crcxX+YKR6X+yJzTmBSSUO6yg+wIzqU8+cMArC?=
 =?iso-8859-2?Q?hdYpy0QfMDcIANbmd+p2+lrWP3rw+DXU6h6GtR45djS9dEHB/llnsJngnm?=
 =?iso-8859-2?Q?0ulw+mrB96xxixx3inWEVkoYvn3YX9rvw7A48Ma8lB2RQfdBXIfXF9zi0/?=
 =?iso-8859-2?Q?iwowxSdpxOgURp3fu+vzRAniGL2AwFCdSt/mHAP9rROyd/Y0ktwBX4JzZj?=
 =?iso-8859-2?Q?1OiJQ3fm30iv+u0bZDoGp0RsUdM1OXAwuGw6cnQOXwPU9Wq1sTNAxA98Xr?=
 =?iso-8859-2?Q?fytYJ+OKOjcQVHnKls1HvxQp6DV67Ps0LfcU9594zBvKsyhIFQ5lo2qDve?=
 =?iso-8859-2?Q?ySrBqDwHq7vMK9wYFF9sz6M/s4MXeW+gf9zEI7gaWDB0JpUEYoeea6ZCt0?=
 =?iso-8859-2?Q?kl0X461D3lFBLjMjQHRLc/QjjMWrJdiNj2ltTSjJocu4lGQpAxuk8LTJ2H?=
 =?iso-8859-2?Q?6w+ylZqe21IF7FC6MHYsIBCKL1i37drFnBeBSoEBFtQO80N+EbRnAo6a3S?=
 =?iso-8859-2?Q?lJIKpWavuDxurmqF3bTUGUK37r/i1Nv/4xObPzNnH9TKR8KcsjxlmUesUn?=
 =?iso-8859-2?Q?40degNKLCkmTPezMP3BkUI3N2Iu9rgkEGekybql4DqoG9LZ+5cJHnOWVwD?=
 =?iso-8859-2?Q?PBJqnCufdJJNrOSJfGXrheFIVf2J3LEHCYtQULkBj6O15QWeh7XipFoWaj?=
 =?iso-8859-2?Q?0g8tczaKVPzfOlAdmfc2/EZNiFqaI2YadPTG0rt2rryYV9cixO7YndicNZ?=
 =?iso-8859-2?Q?6kYaI3ndZdErJ13jsZ4hfE/BZf4knE2IiEN5jkrcQYEgDlwzLB0AXJlr77?=
 =?iso-8859-2?Q?xMz72WwQkyA0xfa4y+dgBbMOH5wBnnu1dZEGqpqN/9ybgEKeTFTGoWHqr+?=
 =?iso-8859-2?Q?c8QMRWB2b1Fr/wGexPK0lqMrX41EkCEMPL1ixNG8eHsJy+mwbkbxRhMFX7?=
 =?iso-8859-2?Q?2r/GnRbBuR8BjMXD40om6kYa0fXUoB17Q36SlmJD3BrRonU3DDFJRbz7H0?=
 =?iso-8859-2?Q?5Q87iXNuDsGaWIrnYXYG6cIQKrOBDNzpA3P6F2hSJTw7BgVEdyhus+uDaY?=
 =?iso-8859-2?Q?sbEBEWFUBgb4/v2pPOVABvVQgjSzbD+RRs/B6js8ju7lHZqsbQnHmvb8BR?=
 =?iso-8859-2?Q?k3gZgja5g14u9czkpPUA+NlVJb1iiYg0UUABxael0VEvWkqdW2ypvIxSlX?=
 =?iso-8859-2?Q?/rF+t6iYMRxMyzwWzir06BA2HHzWOS56qPr135MUU+9T+SgximzQ9p+KHJ?=
 =?iso-8859-2?Q?7t4wc5u3i6+p+y79zfx+bLZ0PXr+uvf+0XNzi8U/Ne3R8j8wiSNDu7S60+?=
 =?iso-8859-2?Q?EoQpV9sWM2td8IkyLzQ+Blj18IhCOK088itWJDfwcAMIMyZ/ggy6j0nS+R?=
 =?iso-8859-2?Q?XUGFt8hir61c8+E6I8PUPk7rAUMm+8Y/ExF/8XX9Gt4eIQWJfXtPsGW6OO?=
 =?iso-8859-2?Q?/XdkUeprqyA3tjWy0nvyvbCy9vuY1muDMDFsSHdU2Y3R7XxxHqNMWMwxIa?=
 =?iso-8859-2?Q?nUqyyjI/TJTN+Wv6XHTIrIztBwDRkX8iOIdvK9RZBXBfavo8XOC/dVSrtk?=
 =?iso-8859-2?Q?rik71N0DE23NnX1BRhiNRdpV3b8b?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09231472E10A14139FF803A89242ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0d97e1-d9be-43a7-b8c7-08ddbb05a66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 14:18:29.7679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGPejZrecky9BN2oKx4BME2i2l1XBtbkbiV5v1KmDQ0/pq7YEMVTHwZ6LWkcH7YjsqP+i1TXZHqmIagZwAQSL3vPoDQAiTrDnk1FlI8qXRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR83MB0639
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09231472E10A14139FF803A89242ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending the version with `SEARCH_DIR("=3D/usr/lib/w32api")` only, with deta=
iled commit message added. I've also removed semicolon for `SEARCH_DIR` as =
it's not needed and other directives do not use it.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 44f33bdb2e564c9dd6207b951f3074a2b98b9bb3 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Fri, 6 Jun 2025 14:13:16 +0200=0A=
Subject: [PATCH v4] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64=
=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch defines binutils output binary format for AArch64 which is pei-a=
arch64-little.=0A=
=0A=
Since =3D/usr/lib/w32api resolves to $SYSROOT/usr/lib/w32api and Fedora cro=
ss-build takes libraries from=0A=
/usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api, the SEARCH_DIR("/usr/x86_64=
-pc-cygwin/lib/w32api"); is=0A=
redundant and can be removed.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/cygwin.sc.in | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in=0A=
index 5007a3694..25739a198 100644=0A=
--- a/winsup/cygwin/cygwin.sc.in=0A=
+++ b/winsup/cygwin/cygwin.sc.in=0A=
@@ -1,9 +1,11 @@=0A=
 #ifdef __x86_64__=0A=
 OUTPUT_FORMAT(pei-x86-64)=0A=
-SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=3D/usr/lib/w3=
2api");=0A=
+#elif __aarch64__=0A=
+OUTPUT_FORMAT(pei-aarch64-little)=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
+SEARCH_DIR("=3D/usr/lib/w32api")=0A=
 #define __CONCAT1(a,b)	a##b=0A=
 #define __CONCAT(a,b) __CONCAT1(a,b)=0A=
 #define _SYM(x)	__CONCAT(__USER_LABEL_PREFIX__, x)=0A=
-- =0A=
2.49.0.vfs.0.4=0A=
=0A=

--_002_DB9PR83MB09231472E10A14139FF803A89242ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v4-0001-Cygwin-define-OUTPUT_FORMAT-and-SEARCH_DIR-for-AArch64.patch"
Content-Description:
 v4-0001-Cygwin-define-OUTPUT_FORMAT-and-SEARCH_DIR-for-AArch64.patch
Content-Disposition: attachment;
	filename="v4-0001-Cygwin-define-OUTPUT_FORMAT-and-SEARCH_DIR-for-AArch64.patch";
	size=1409; creation-date="Fri, 04 Jul 2025 14:18:21 GMT";
	modification-date="Fri, 04 Jul 2025 14:18:21 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0NGYzM2JkYjJlNTY0YzlkZDYyMDdiOTUxZjMwNzRhMmI5OGI5YmIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogRnJpLCA2IEp1biAyMDI1IDE0OjEzOjE2ICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2NF0gQ3lnd2luOiBkZWZpbmUgT1VUUFVUX0ZPUk1BVCBhbmQg
U0VBUkNIX0RJUiBmb3IgQUFyY2g2NApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRl
eHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoK
VGhpcyBwYXRjaCBkZWZpbmVzIGJpbnV0aWxzIG91dHB1dCBiaW5hcnkgZm9ybWF0IGZvciBBQXJj
aDY0IHdoaWNoIGlzIHBlaS1hYXJjaDY0LWxpdHRsZS4KClNpbmNlID0vdXNyL2xpYi93MzJhcGkg
cmVzb2x2ZXMgdG8gJFNZU1JPT1QvdXNyL2xpYi93MzJhcGkgYW5kIEZlZG9yYSBjcm9zcy1idWls
ZCB0YWtlcyBsaWJyYXJpZXMgZnJvbQovdXNyL2FhcmNoNjQtcGMtY3lnd2luL3N5cy1yb290L3Vz
ci9saWIvdzMyYXBpLCB0aGUgU0VBUkNIX0RJUigiL3Vzci94ODZfNjQtcGMtY3lnd2luL2xpYi93
MzJhcGkiKTsgaXMKcmVkdW5kYW50IGFuZCBjYW4gYmUgcmVtb3ZlZC4KClNpZ25lZC1vZmYtYnk6
IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIHdpbnN1cC9j
eWd3aW4vY3lnd2luLnNjLmluIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9jeWd3aW4uc2Mu
aW4gYi93aW5zdXAvY3lnd2luL2N5Z3dpbi5zYy5pbgppbmRleCA1MDA3YTM2OTQuLjI1NzM5YTE5
OCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9jeWd3aW4uc2MuaW4KKysrIGIvd2luc3VwL2N5
Z3dpbi9jeWd3aW4uc2MuaW4KQEAgLTEsOSArMSwxMSBAQAogI2lmZGVmIF9feDg2XzY0X18KIE9V
VFBVVF9GT1JNQVQocGVpLXg4Ni02NCkKLVNFQVJDSF9ESVIoIi91c3IveDg2XzY0LXBjLWN5Z3dp
bi9saWIvdzMyYXBpIik7IFNFQVJDSF9ESVIoIj0vdXNyL2xpYi93MzJhcGkiKTsKKyNlbGlmIF9f
YWFyY2g2NF9fCitPVVRQVVRfRk9STUFUKHBlaS1hYXJjaDY0LWxpdHRsZSkKICNlbHNlCiAjZXJy
b3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgorU0VBUkNIX0RJUigiPS91
c3IvbGliL3czMmFwaSIpCiAjZGVmaW5lIF9fQ09OQ0FUMShhLGIpCWEjI2IKICNkZWZpbmUgX19D
T05DQVQoYSxiKSBfX0NPTkNBVDEoYSxiKQogI2RlZmluZSBfU1lNKHgpCV9fQ09OQ0FUKF9fVVNF
Ul9MQUJFTF9QUkVGSVhfXywgeCkKLS0gCjIuNDkuMC52ZnMuMC40Cgo=

--_002_DB9PR83MB09231472E10A14139FF803A89242ADB9PR83MB0923EURP_--

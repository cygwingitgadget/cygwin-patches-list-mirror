Return-Path: <SRS0=kNIP=2F=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20709.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::709])
	by sourceware.org (Postfix) with ESMTPS id 561793858C62
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 10:30:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 561793858C62
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 561793858C62
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::709
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753353057; cv=pass;
	b=gHPxcoAO+R0kbyNEUukBt+NecrdWfpVKEdDgub/Pz+C92mTotcyATVQbmpNg1M4tN0b9ljzBM+iggAlk+jKOZkLace+w2fOWwXbHwmxlASHwsxiR0e/qSatU0FsrWKlyaggLVMz0LpKkWiC0+bADtrxiDvBp008T8D/MBkCm+b0=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753353057; c=relaxed/simple;
	bh=/Qr+Vtz0lYL0cx15BF3W+qY9aJSJK0EnhYvr1VRgmLk=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=CrsYyrsUUv2piVRZZ89xuVoiRusd2ZxoUIpX1cfiN0xW1JKe1igJMVKbESTZfrQK6q0JErUEzy+CSznLoEuS8xKi0Mbno9DFgGKSUEa8vcpwxHKCe+WSntYGPIdv35jDSysnh09HZX0+876NbiL4ycKaOm57Q1/hNqlOv7L0um8=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 561793858C62
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=fxYR7xj+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNhCFo4mMp9rCiACEcFBk+gIxG4IqzurjBWtYtuRV9xxUkROTHE94MiHlcKzdugo8xGd9fXmO7xOiV4LkkaamX3CFaD2UVYCL7fIkeU9IKCLSGYDHhcE/0X/n6RmJrVRgCLTi0Vtuos5KWyni66bAoHO0AgyxDVNVs/i+Glyc0uFCft0diWc+93O9fywfumFnATxfCkjtO63pu/rgv/9K51Cqn/9IEO2KwMWat1C1jR5Uk6q0t8IiYWkSkPCo+m6vDxtiyGrLABhCgKOUuW1TUQlgNZ6GHArkq7Ic3L9dNPoaWnoS5Ty73gwLNT4wLdpU84gRqFtOBhe1Neuf0ppPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/I9iduTNW79F6/wcXUhb/FdjpwmHFL4x20pX4ocb4P4=;
 b=Rf/2cJdAtz6jLYDOhGqjSOJUNHBR1Bm6AJ/QAJvLoRYgD24Xijb+56+UtFgrn4Z81DueN90BGbphprtjTWqqp7jm/+ipwRCMmvnOI9Gapuy4SIiIP5U8ptAGtlRJ+LhXmWhIAzFZYFTmfashxpFYyKRWrtpEvB4MXb2N7fppe9NDJNZrExzFUZbOov1hK7LwiTj1KsltAt3HkDFbRNYq19DTBnla//tjEouxgylEW/Gf+0s/6DaBz+rNAjcTM4K+b+clXy9bkdxNFFxYEdto9gYQ75OMVM+z6Evvh1OQiLN0Xts2t9wqTeFI7cBhxamdO7l02GYIUv0+P0vcGB5xog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I9iduTNW79F6/wcXUhb/FdjpwmHFL4x20pX4ocb4P4=;
 b=fxYR7xj+hl0WpmfUDV7aqcvhZ3tSf1c5hOTPw9l1nGwIILK8nOwt4FylE9pQNrjm4Ce2YYkJy24ZdXou1LVV7ZiAVBvww53n9GIFbl+uQYf3ZTxqck3OuW4S7xIfBlwC4abG5EXTEoNDtnxE9gyc58W1i4SLoHK9GU1qy9byyms=
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com (2603:10a6:150:27e::22)
 by VI0PR83MB0644.EURPRD83.prod.outlook.com (2603:10a6:800:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.8; Thu, 24 Jul
 2025 10:30:52 +0000
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a]) by GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a%3]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 10:30:51 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Topic: [PATCH v2] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
Thread-Index: AQHb/IYHI2rAcQDCDEekTWjFtgA0sg==
Date: Thu, 24 Jul 2025 10:30:51 +0000
Message-ID:
 <GV4PR83MB0941AA5AD0E67B89787B1FE0925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
 <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9jZCS92AGUaP-o@calimero.vinschen.de>
 <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com>
 <aICZuCg3tKXOj_mR@calimero.vinschen.de>
In-Reply-To: <aICZuCg3tKXOj_mR@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-24T10:30:50.800Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV4PR83MB0941:EE_|VI0PR83MB0644:EE_
x-ms-office365-filtering-correlation-id: 98af77c0-4aa4-45b3-64cd-08ddca9d29c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?p/i5t9TsdE4todoyJyjusAIrtMLUrUH0W5CGG8oDjZ/Ul7hkmgcV4EROgk?=
 =?iso-8859-2?Q?pqAgGXqZ2aNmU/GNXPOP25PUOIXo544OfzaY+JJryUIux/2JBIbA/EKghC?=
 =?iso-8859-2?Q?JKtNW+lhkOhI/hwa73ZaQwDZ7zAlKNhHVV5MWDAzaDx/2EqGPJbLVpqTCY?=
 =?iso-8859-2?Q?O4u1i61psSuSD12E+YespU4ZwWzIeaAJmLgNMhVvaP1cf9btqR1goG9vzb?=
 =?iso-8859-2?Q?L38pBro1vLMJ73dahcKolD+UAHatyPqf35c0ulAbmcgDWH+MB7cHt4p/ze?=
 =?iso-8859-2?Q?bfWq3LCJAha5dIeLFK7pOMD8OjDvmZ0bvI8h7j2g0brAQf+IADlUvEjGMq?=
 =?iso-8859-2?Q?DZXwoDoqRHKFzDA4mlOFwBv3c5FpMziyIk5TBOmzQHqOFMyUOa9K1QYjFi?=
 =?iso-8859-2?Q?GfocjLgQCCSjJPbegN2hWPGK2Uf4gddN4Dr11wHRip5J6gyoVagvb/osna?=
 =?iso-8859-2?Q?Uu56zvklOYaooC+rMOrQXc9M/cJ/YBSm5XppHjWpyQ1OsZlvP1+56RlpCr?=
 =?iso-8859-2?Q?pkn2JCfu8pYzl4O8Ym+9IgD8GBf1dZh44Q1+MpLLanYBzWh6/JRQEgjt4M?=
 =?iso-8859-2?Q?5jhu7i0iVAuIoBiJ1e23Wp8mQinvmKGtrA8eOsvxqrAdwljsJ6+Xqe5flV?=
 =?iso-8859-2?Q?haYwClvwAeXeRy3WXvDCMlmt5ILcLjirOrQF0A6e6PHsAC23vxzNnIA5YP?=
 =?iso-8859-2?Q?H3nnNuCnTqxczG9sbFIY+jmS8LbDD6RrmVok5n+XHhaKP+TOg7PwQM9g6M?=
 =?iso-8859-2?Q?xf7f6arp3mKKITPbsg4pXG5vlq6AEEDseeIPZc4TJgLix/uOSJ8lb5RZcH?=
 =?iso-8859-2?Q?pr5AFm2i7yfNvM4LMEaKJpJHIXPcHWtE/OWoXYrGPweEqJHZhv74uNs5C7?=
 =?iso-8859-2?Q?+veyvdgJmBUjjQdmlNtF4xpyYzkbzeRLhmQia+reOVtJHbfSxQRawCMaZo?=
 =?iso-8859-2?Q?r0oeDTm5WCOKD+iTRIJBkZ4osj/27jk1D58SFAjae4p+ztlRyiSlfrtO6v?=
 =?iso-8859-2?Q?J265CngnKLm4NhwkZzwcQ032BZ05PfO89sI/74ikuMnqAGQb6oGUPAVdyP?=
 =?iso-8859-2?Q?Syu3uElTmxeYpdg1xdH91wyrK/9sQiCCWEKv0j0nxzgU3ZF11/pJOkeYCN?=
 =?iso-8859-2?Q?Vi/mk6A6Lxaj9T0JeNpAdb4T6rgKJzn6jadDyvxlg0LDtEK9Xa4Y8mJFQn?=
 =?iso-8859-2?Q?7LXLVdYmLUDzCUJwjZ0mXQwsUGGjMybbEZZJsF4foFNK4UmISXoZ93jgZY?=
 =?iso-8859-2?Q?gHTKVS7F3PdQ0DeDMCXN2ezgK/xXdOhLmYnnKIUMu+8RPqCUyAptOYDAuY?=
 =?iso-8859-2?Q?pJJ9UCbGQM+ZF4QW+w+/i7NkrMIAMkV7vAmv6NUQwVTVU+amwbkUlOideN?=
 =?iso-8859-2?Q?8ZmBg10NWq8/iF/8h2BPQb86KAcCbF9KeKgMtkr0y9WKDVX5jhgIcdO3QG?=
 =?iso-8859-2?Q?f2XbZ2R0dt9jrHixWl2xCAZ1hOzyUUvGbYf0Cx+MKwSxuc2ZgvKZ5j/J4l?=
 =?iso-8859-2?Q?Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV4PR83MB0941.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?yeE8/LPzIJwseW3O6dLQWVbj1Hj4j4HrpZ7GhCi3SrX0ee5am2bdkp8dVd?=
 =?iso-8859-2?Q?wXc48RpSvmKr2mc6A94uITca60z5bTVx5x4n/8vgBcBsw4InA3xBWl/DqS?=
 =?iso-8859-2?Q?db2iomDGcg5avkkCCpRJ31yLu5htwiP90rwBVZoOuE3v4Ax0PsC6MpcBvn?=
 =?iso-8859-2?Q?FaxDaIX/lcfZM9vg5O46zcVnmYXHZmXyPSdGTTt7f7W4aq0cZunVY7gbP2?=
 =?iso-8859-2?Q?4V10Oo8Y/2fAi5aLfmwdZTvnPZ/NydQgsrrVhXPBftdxX7Ltw4f8p/ZVDS?=
 =?iso-8859-2?Q?iAWkZWhVZysXsI3bmlYyKjYvZD1xNswsbe9xKNFh3mX67bQUqrQN27dQfb?=
 =?iso-8859-2?Q?1lBmrK4Aj638/E6/NjhOYjqKJorS0B98DNBfRIGZ6LRcfuUBNG3arLw40S?=
 =?iso-8859-2?Q?OkAH9XNpbY9IKQwr5hqXvuXyjasAI1QvdSvFGuqO3cFi1AUk51mdw6I5yi?=
 =?iso-8859-2?Q?0h2gtaki64IPahmRWIKaQgR/knZG8D8DA4zNNo1Eumv5aYrsD+YDA/fjdP?=
 =?iso-8859-2?Q?ibKH4QDyndUyK6idrgwTZOPCtnRjrzIMgRiVtIyEzgiUCJ1ZlRtyVOms5n?=
 =?iso-8859-2?Q?e4wkp0UpMLxSCz0N+QDP2BC4GAwgHPG2UEBvtSRGXCcRuzvimRxbe3QTdR?=
 =?iso-8859-2?Q?JIQbwhLhDA+oCpi1w9KCo/teHfsrDn9e9TBWlN3VGol0N2C7QU5rUNcrw6?=
 =?iso-8859-2?Q?aGU5tBXxm0rZARsUTCeFS0OqlJGC4Dcip4rhYBJOJyR8jaDbbbtwl+RzDF?=
 =?iso-8859-2?Q?omkwrZxLsiPDmP8kFMVY8d2n+ZpDmKdYeJuF68KYq0wnNfwOdTIfSzftuD?=
 =?iso-8859-2?Q?y4LcAIZNKkyF5mvAlmnTM0Ipecst8/Axifi87q9iwuTd/AYqTjs/7VIueq?=
 =?iso-8859-2?Q?DK90+mVkdHVT9hlr5VDZibDvSebYWnxNTMA+s01P2dzxXaFYAPqfAvbetH?=
 =?iso-8859-2?Q?Mu4ajTLoxYXIKEBx+CHOQNOtFus3hLS+xhpDwG2Aolh3g7r3p7VVBdM1Oa?=
 =?iso-8859-2?Q?xNN/+4i4PYXJ6ZeJv7WzQj6ga1jjTikswmVUx/9NIGLzZbL1qO1Wcwm47s?=
 =?iso-8859-2?Q?ZOZoE5WO9WpXIjWKIbehD/GIoEdyrpBcrd1dztwIuaSWJhIhGmCHsDpBc8?=
 =?iso-8859-2?Q?DpQaIZ9gUPMDoKEYHXYJwxZFVafEA5nJawrFqhrMdsAf67fkYe7QviiHd7?=
 =?iso-8859-2?Q?oHyZ+njpRINF638hmZkU5v1WKfLHXP1Oic9MPoajtBstKzTTv6y4puVq/W?=
 =?iso-8859-2?Q?qShVtLSBAAWPNd/3MTUeWQ0+Bz94UlGSep0MvIhJJoDV/W39SdwfKU8jWy?=
 =?iso-8859-2?Q?uyXS91MrGr3sBtZv1s9k38shAfGgTCfNPHNAU5RoigVfJj/0ladkckckhj?=
 =?iso-8859-2?Q?zZhLp8oHTpjrxoCHaZrFqreb9f4I+JQnd3H0Fa9hSwd8XFdAxBYuyToq2R?=
 =?iso-8859-2?Q?HGYJ3zQXSUFnNrGjG1Xu8vwR+EZesicOEAQuFqlMQG4IwoirMOPxHZfZpr?=
 =?iso-8859-2?Q?StuDZkNTj4rc8LuFU1IegMsr5/qkTEHRlSR7MfxObu88aBEx9M85+a0vSR?=
 =?iso-8859-2?Q?uOEztSCsENR1Y/tkGBzUJaK9+YWe?=
Content-Type: multipart/mixed;
	boundary="_002_GV4PR83MB0941AA5AD0E67B89787B1FE0925EAGV4PR83MB0941EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV4PR83MB0941.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98af77c0-4aa4-45b3-64cd-08ddca9d29c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 10:30:51.5673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IerODupDcvHTJYr76ZWZq7PsJs9fyXuAf/cgBi8GZbRb3FpinLDrvQxsqoChx8j1ZzOUZ5ry1ZA+EZAYdQc9OBbum9d2kG/WL9YpOmeNXKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0644
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_GV4PR83MB0941AA5AD0E67B89787B1FE0925EAGV4PR83MB0941EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending another version of the patch with the comments added.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From b9d04d2359a258f4a08f7f50fe5a11c03859f2b5 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 19 Jul 2025 19:17:12 +0200=0A=
Subject: [PATCH v2] Cygwin: mkimport: implement AArch64 +/-4GB relocations=
=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Based on https://sourceware.org/pipermail/cygwin-patches/2025q3/014154.html=
=0A=
suggestion, this patch implements +/-4GB relocations for AArch64 in the mki=
mport=0A=
script by using adrp and ldr instructions. This change required update=0A=
in winsup\cygwin\mm\malloc_wrapper.cc where those instructions are=0A=
decoded to get target import address.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/mm/malloc_wrapper.cc | 26 +++++++++++++++++---------=0A=
 winsup/cygwin/scripts/mkimport     |  7 +++++--=0A=
 2 files changed, 22 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/malloc_w=
rapper.cc=0A=
index 863d3089c..991bd57be 100644=0A=
--- a/winsup/cygwin/mm/malloc_wrapper.cc=0A=
+++ b/winsup/cygwin/mm/malloc_wrapper.cc=0A=
@@ -51,16 +51,24 @@ import_address (void *imp)=0A=
   __try=0A=
     {=0A=
 #if defined(__aarch64__)=0A=
-      // If opcode is an adr instruction.=0A=
-      uint32_t opcode =3D *(uint32_t *) imp;=0A=
-      if ((opcode & 0x9f000000) =3D=3D 0x10000000)=0A=
+      // If opcode1 is an adrp and opcode2 is ldr instruction:=0A=
+      //   - https://www.scs.stanford.edu/~zyedidia/arm64/adrp.html=0A=
+      //   - https://www.scs.stanford.edu/~zyedidia/arm64/ldr_imm_gen.html=
=0A=
+      // NOTE: This implementation assumes that the relocation table is ma=
de of=0A=
+      // those specific AArch64 instructions as generated by the=0A=
+      // winsup\cygwin\scripts\mkimport script. Please, keep it in sync.=
=0A=
+      uint32_t opcode1 =3D *((uint32_t *) imp);=0A=
+      uint32_t opcode2 =3D *(((uint32_t *) imp) + 1);=0A=
+      if (((opcode1 & 0x9f000000) =3D=3D 0x90000000) && ((opcode2 & 0xbfc0=
0000) =3D=3D 0xb9400000))=0A=
 	{=0A=
-	  uint32_t immhi =3D (opcode >> 5) & 0x7ffff;=0A=
-	  uint32_t immlo =3D (opcode >> 29) & 0x3;=0A=
-	  int64_t sign_extend =3D (0l - (immhi >> 18)) << 21;=0A=
-	  int64_t imm =3D sign_extend | (immhi << 2) | immlo;=0A=
-	  uintptr_t jmpto =3D *(uintptr_t *) ((uint8_t *) imp + imm);=0A=
-	  return (void *) jmpto;=0A=
+	  uint32_t immhi =3D (opcode1 >> 5) & 0x7ffff;=0A=
+	  uint32_t immlo =3D (opcode1 >> 29) & 0x3;=0A=
+	  uint32_t imm12 =3D ((opcode2 >> 10) & 0xfff) * 8; // 64 bit scale=0A=
+	  int64_t sign_extend =3D (0l - ((int64_t) immhi >> 32)) << 33; // sign e=
xtend from 33 to 64 bits=0A=
+	  int64_t imm =3D sign_extend | (((immhi << 2) | immlo) << 12);=0A=
+	  int64_t base =3D (int64_t) imp & ~0xfff;=0A=
+	  uintptr_t* jmpto =3D (uintptr_t *) (base + imm + imm12);=0A=
+	  return (void *) *jmpto;=0A=
 	}=0A=
 #else=0A=
       if (*((uint16_t *) imp) =3D=3D 0x25ff)=0A=
diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimpor=
t=0A=
index 0c1bcafbf..33d8b08fb 100755=0A=
--- a/winsup/cygwin/scripts/mkimport=0A=
+++ b/winsup/cygwin/scripts/mkimport=0A=
@@ -73,8 +73,11 @@ EOF=0A=
 	.extern	$imp_sym=0A=
 	.global	$glob_sym=0A=
 $glob_sym:=0A=
-	adr x16, $imp_sym=0A=
-	ldr x16, [x16]=0A=
+	# NOTE: Using instructions that are used by MSVC and LLVM. Binutils are=
=0A=
+	# using adrp/add/ldr-0-offset though. Please, keep it in sync with=0A=
+  # import_address implementation in winsup/cygwin/mm/malloc_wrapper.cc.=
=0A=
+	adrp x16, $imp_sym=0A=
+	ldr x16, [x16, #:lo12:$imp_sym]=0A=
 	br x16=0A=
 EOF=0A=
 	} else {=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_GV4PR83MB0941AA5AD0E67B89787B1FE0925EAGV4PR83MB0941EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch"
Content-Description:
 v2-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch";
	size=3363; creation-date="Thu, 24 Jul 2025 10:30:19 GMT";
	modification-date="Thu, 24 Jul 2025 10:30:19 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiOWQwNGQyMzU5YTI1OGY0YTA4ZjdmNTBmZTVhMTFjMDM4NTlmMmI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAxOSBKdWwgMjAyNSAxOToxNzoxMiAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIEN5Z3dpbjogbWtpbXBvcnQ6IGltcGxlbWVudCBBQXJj
aDY0ICsvLTRHQiByZWxvY2F0aW9ucwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRl
eHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoK
QmFzZWQgb24gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMv
MjAyNXEzLzAxNDE1NC5odG1sCnN1Z2dlc3Rpb24sIHRoaXMgcGF0Y2ggaW1wbGVtZW50cyArLy00
R0IgcmVsb2NhdGlvbnMgZm9yIEFBcmNoNjQgaW4gdGhlIG1raW1wb3J0CnNjcmlwdCBieSB1c2lu
ZyBhZHJwIGFuZCBsZHIgaW5zdHJ1Y3Rpb25zLiBUaGlzIGNoYW5nZSByZXF1aXJlZCB1cGRhdGUK
aW4gd2luc3VwXGN5Z3dpblxtbVxtYWxsb2Nfd3JhcHBlci5jYyB3aGVyZSB0aG9zZSBpbnN0cnVj
dGlvbnMgYXJlCmRlY29kZWQgdG8gZ2V0IHRhcmdldCBpbXBvcnQgYWRkcmVzcy4KClNpZ25lZC1v
ZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIHdp
bnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MgfCAyNiArKysrKysrKysrKysrKysrKy0t
LS0tLS0tLQogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0ICAgICB8ICA3ICsrKysrLS0K
IDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyBiL3dpbnN1cC9jeWd3
aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKaW5kZXggODYzZDMwODljLi45OTFiZDU3YmUgMTAwNjQ0
Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKKysrIGIvd2luc3VwL2N5
Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYwpAQCAtNTEsMTYgKzUxLDI0IEBAIGltcG9ydF9hZGRy
ZXNzICh2b2lkICppbXApCiAgIF9fdHJ5CiAgICAgewogI2lmIGRlZmluZWQoX19hYXJjaDY0X18p
Ci0gICAgICAvLyBJZiBvcGNvZGUgaXMgYW4gYWRyIGluc3RydWN0aW9uLgotICAgICAgdWludDMy
X3Qgb3Bjb2RlID0gKih1aW50MzJfdCAqKSBpbXA7Ci0gICAgICBpZiAoKG9wY29kZSAmIDB4OWYw
MDAwMDApID09IDB4MTAwMDAwMDApCisgICAgICAvLyBJZiBvcGNvZGUxIGlzIGFuIGFkcnAgYW5k
IG9wY29kZTIgaXMgbGRyIGluc3RydWN0aW9uOgorICAgICAgLy8gICAtIGh0dHBzOi8vd3d3LnNj
cy5zdGFuZm9yZC5lZHUvfnp5ZWRpZGlhL2FybTY0L2FkcnAuaHRtbAorICAgICAgLy8gICAtIGh0
dHBzOi8vd3d3LnNjcy5zdGFuZm9yZC5lZHUvfnp5ZWRpZGlhL2FybTY0L2xkcl9pbW1fZ2VuLmh0
bWwKKyAgICAgIC8vIE5PVEU6IFRoaXMgaW1wbGVtZW50YXRpb24gYXNzdW1lcyB0aGF0IHRoZSBy
ZWxvY2F0aW9uIHRhYmxlIGlzIG1hZGUgb2YKKyAgICAgIC8vIHRob3NlIHNwZWNpZmljIEFBcmNo
NjQgaW5zdHJ1Y3Rpb25zIGFzIGdlbmVyYXRlZCBieSB0aGUKKyAgICAgIC8vIHdpbnN1cFxjeWd3
aW5cc2NyaXB0c1xta2ltcG9ydCBzY3JpcHQuIFBsZWFzZSwga2VlcCBpdCBpbiBzeW5jLgorICAg
ICAgdWludDMyX3Qgb3Bjb2RlMSA9ICooKHVpbnQzMl90ICopIGltcCk7CisgICAgICB1aW50MzJf
dCBvcGNvZGUyID0gKigoKHVpbnQzMl90ICopIGltcCkgKyAxKTsKKyAgICAgIGlmICgoKG9wY29k
ZTEgJiAweDlmMDAwMDAwKSA9PSAweDkwMDAwMDAwKSAmJiAoKG9wY29kZTIgJiAweGJmYzAwMDAw
KSA9PSAweGI5NDAwMDAwKSkKIAl7Ci0JICB1aW50MzJfdCBpbW1oaSA9IChvcGNvZGUgPj4gNSkg
JiAweDdmZmZmOwotCSAgdWludDMyX3QgaW1tbG8gPSAob3Bjb2RlID4+IDI5KSAmIDB4MzsKLQkg
IGludDY0X3Qgc2lnbl9leHRlbmQgPSAoMGwgLSAoaW1taGkgPj4gMTgpKSA8PCAyMTsKLQkgIGlu
dDY0X3QgaW1tID0gc2lnbl9leHRlbmQgfCAoaW1taGkgPDwgMikgfCBpbW1sbzsKLQkgIHVpbnRw
dHJfdCBqbXB0byA9ICoodWludHB0cl90ICopICgodWludDhfdCAqKSBpbXAgKyBpbW0pOwotCSAg
cmV0dXJuICh2b2lkICopIGptcHRvOworCSAgdWludDMyX3QgaW1taGkgPSAob3Bjb2RlMSA+PiA1
KSAmIDB4N2ZmZmY7CisJICB1aW50MzJfdCBpbW1sbyA9IChvcGNvZGUxID4+IDI5KSAmIDB4MzsK
KwkgIHVpbnQzMl90IGltbTEyID0gKChvcGNvZGUyID4+IDEwKSAmIDB4ZmZmKSAqIDg7IC8vIDY0
IGJpdCBzY2FsZQorCSAgaW50NjRfdCBzaWduX2V4dGVuZCA9ICgwbCAtICgoaW50NjRfdCkgaW1t
aGkgPj4gMzIpKSA8PCAzMzsgLy8gc2lnbiBleHRlbmQgZnJvbSAzMyB0byA2NCBiaXRzCisJICBp
bnQ2NF90IGltbSA9IHNpZ25fZXh0ZW5kIHwgKCgoaW1taGkgPDwgMikgfCBpbW1sbykgPDwgMTIp
OworCSAgaW50NjRfdCBiYXNlID0gKGludDY0X3QpIGltcCAmIH4weGZmZjsKKwkgIHVpbnRwdHJf
dCogam1wdG8gPSAodWludHB0cl90ICopIChiYXNlICsgaW1tICsgaW1tMTIpOworCSAgcmV0dXJu
ICh2b2lkICopICpqbXB0bzsKIAl9CiAjZWxzZQogICAgICAgaWYgKCooKHVpbnQxNl90ICopIGlt
cCkgPT0gMHgyNWZmKQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0
IGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CmluZGV4IDBjMWJjYWZiZi4uMzNkOGIw
OGZiIDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvbWtpbXBvcnQKKysrIGIvd2lu
c3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CkBAIC03Myw4ICs3MywxMSBAQCBFT0YKIAkuZXh0
ZXJuCSRpbXBfc3ltCiAJLmdsb2JhbAkkZ2xvYl9zeW0KICRnbG9iX3N5bToKLQlhZHIgeDE2LCAk
aW1wX3N5bQotCWxkciB4MTYsIFt4MTZdCisJIyBOT1RFOiBVc2luZyBpbnN0cnVjdGlvbnMgdGhh
dCBhcmUgdXNlZCBieSBNU1ZDIGFuZCBMTFZNLiBCaW51dGlscyBhcmUKKwkjIHVzaW5nIGFkcnAv
YWRkL2xkci0wLW9mZnNldCB0aG91Z2guIFBsZWFzZSwga2VlcCBpdCBpbiBzeW5jIHdpdGgKKyAg
IyBpbXBvcnRfYWRkcmVzcyBpbXBsZW1lbnRhdGlvbiBpbiB3aW5zdXAvY3lnd2luL21tL21hbGxv
Y193cmFwcGVyLmNjLgorCWFkcnAgeDE2LCAkaW1wX3N5bQorCWxkciB4MTYsIFt4MTYsICM6bG8x
MjokaW1wX3N5bV0KIAliciB4MTYKIEVPRgogCX0gZWxzZSB7Ci0tIAoyLjUwLjEudmZzLjAuMAoK

--_002_GV4PR83MB0941AA5AD0E67B89787B1FE0925EAGV4PR83MB0941EURP_--

Return-Path: <SRS0=H7AL=7N=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021133.outbound.protection.outlook.com [40.107.57.133])
	by sourceware.org (Postfix) with ESMTPS id C28214BA2E05
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 08:30:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C28214BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C28214BA2E05
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=40.107.57.133
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1767861018; cv=pass;
	b=kMtSOaoLiPAIurTAnXoSJoILOvlEidZrvGWPnyjRr9IVagYYTLsHOPXVQ9qNpNyx5qwixHAx7kL4seZK53L1sNt3a8UZpKnmWPCYh28WpiyuGkiD7hk2olFACyApP13dywUbZg7cFYiCdjsEhWW0EPAe2M1VSbtz/C3O5jRA40I=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767861018; c=relaxed/simple;
	bh=NgTa2BoFzOdc0+Dxm9wueO+uaUVyXPGU7DPmIw7DWhU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=LTcG77tq9uQtfUCqOtXnL3wXE3Aqu9yldSIZ1cfjqx7mznLlnnHxbp3C2F/NnXTR1cZohVkvYikDrWpS2y/n+fE0XD3nwgrLS96qDr88KKWuGai8KQURo/hCCDg/ERM7jlW5y3eJ+KfYwcZM3omBSPfmG+KcFpDC0Z1VAnDtVpY=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C28214BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=oOvSpW3u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmGBkKcGaHgaZl5zN6TRilK0n7NUUc7BTFHJg7sYO1zlSwWKqYnVdoY80HZNz3hmpW0IJYAIHD+dxmJWgvCzqmJar6SAfNtNohJX6VpkMeZkTqMEHMzi2K3VgagD53/pYfAWWskvfxIQ5QaMQOrRckjudGnNN3cXbNWU9ti3ZXaOsEe7WWRNrPTp8IVlUWXzoVA+kHTTZli/+sal/JNh48psvt8PbJN3K6IMktdd8BG9AJ1EGDaN01Rl50282L8RGTvtxlUc6yn8eXoGme3XXvyB/7B+cytTk2Ld6gyITdUnvpCT50T0BnkloquFqTZ97Y3b7zB4+9VaA1fNbE+DmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmA3vVNmJ71Eh08rA2baTPdJ05fwayX8eKmFqD+VYp4=;
 b=rZKlRPKcrMU2ZXuUShcArMh9VOn+rzbbaaZhmi6FNRxbdsd0Wkk12EobIjp5FgepnOzj2/45j92TDNQQp5eQLNYw0LqodRFgjYSXKyoBcTMDkURum7KJ5HRfdcHNclgT+PyH3buX2q5Lrji0ypfHuXP4KDFCfWmNdbyA6oIT0Y/aDBYksIltgfZz9Tzs4uTOPWLk7OPwDqaZ1uRJ2NeVjc0ghdiFwoGDbpU6QmTvc06c53fOlWWZJ8G9/8ry/0GpbdRdh35J4+SmcTo8KD/mTpT93vbzzVfKRPxCjJIVHQflHs4jcseI4CU5QOz6R2gzq10q/aZD6Pv0xbWWQbE2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmA3vVNmJ71Eh08rA2baTPdJ05fwayX8eKmFqD+VYp4=;
 b=oOvSpW3ueegN2D69rLBQE9K77w0zoUR1gSdjBLyHdMjCte2RNjj+bQ5rq4POhjRFaZNKTHXeC3YL+rfRTT4Rz5n6xe2F1q7N7VA73zI5VO8bpIHOODzTC1+PzR3gQZs9yEaeA7tSrNInLxeqgdEk6HSQW+5EMR/Byg9sGBwCxe4YurIoo2Qwx7p55ESiEjdR2ycaQ6RWvJ9EI+YtoaMcS5KnoNacJud1WyanmTZLu2F29tuAqyFh1zmOhLMWJZ1jqPPdNQXxBgp1+AXmffRvh7N3pDNO4yy+rLkqU0WAD3M0TzaU0Zs/XyT5msL5Ellbyx2opZLNrp1grUZ/MpdOVw==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN6P287MB5182.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:300::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 08:30:11 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9478.005; Thu, 8 Jan 2026
 08:30:10 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Update _endian.h to handle unsupported arch
Thread-Topic: [PATCH] Cygwin: Update _endian.h to handle unsupported arch
Thread-Index: AdyAdUAhAFTFQbi0RF2UWFDFgJkSGg==
Date: Thu, 8 Jan 2026 08:30:10 +0000
Message-ID:
 <MA0P287MB308241F2F6A8AB26A6249FB49F85A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN6P287MB5182:EE_
x-ms-office365-filtering-correlation-id: 0f610ba3-1065-4291-fbda-08de4e902360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jNMnTzk+IMeDEgdQp/rZ9cMVn68yzpmXi71zbx7UpIXcYYKXGN/dLN8X2HEK?=
 =?us-ascii?Q?uGj8HvOdFY/ToWDaj8IYVPgQ1wQH6s9h7gHq5IrkPEWWkFT9/Mw3fgHH+uxY?=
 =?us-ascii?Q?6lsgINpTJPK4GYROWtxKAhbXYY/VTMKYYTb2+05etWRCs1VjCFm0mWJ0gvnv?=
 =?us-ascii?Q?DZVqVYoev/zX55ikNNDopk4B1OLVUjDV1DN4xygPCWHElPXMey801HkDziWu?=
 =?us-ascii?Q?e8FIHn7cQ06Oh1LlpnlefzZyGQQPyi5NMUUXQKy+af4pfG+/dJM4vlESktaH?=
 =?us-ascii?Q?wx8SV5SRLH4NO0ukBc0KWuRrMv7TiWhX/3q6a+1G0PdScpiBlwePg7xsBdSR?=
 =?us-ascii?Q?aaWsvEJQG1rnSmZaf0MeDc46qYtTRnmHcmhnDszeoT+Hm2qp2lO2VRb3A7sH?=
 =?us-ascii?Q?s86jm/hB3giOlMXd2rjHzBFy7Ypnk6Bt48bgS2+8sNhCmY28R8IvMxyCQU3G?=
 =?us-ascii?Q?J41qe1tp308GyBLFJ8mMAv8pp7bb0aM3xRFlrrJYxOhIxH0dRCsrztCmhD91?=
 =?us-ascii?Q?7ojqnW/MRiRFPL06s2zDtXwTANrFlVyXJ0Fdnt6QpO7RUhY7ff3xy5Hy8w82?=
 =?us-ascii?Q?N5EcisFvxwGML8B+mvJ51zItlfgEIxzTO6fGB7yJQJ4vR/6Cq309YcPkvyFA?=
 =?us-ascii?Q?MvXosORek+9/5NxZoYLf2/PK7rngY8xmFJVC/j2qMLxLTpnYTw1zkny6orzm?=
 =?us-ascii?Q?DWpKkYNBXmJ3YSrOHmEUxuiAJjOenoNKDog5gdFqbaEDxdr5PBzeqag1H+q8?=
 =?us-ascii?Q?BN9Wcaus4f6Hu7G+YN1HYLiMqEX/2CXf7QDN1WFcXBvPQtuK/X0cdlHJzuza?=
 =?us-ascii?Q?V6gS8mmPUGgVJmCvye4juXpm0+cUes6wOICXDlYY8HNsWK3Et35JvUJg1NOc?=
 =?us-ascii?Q?Y9rm7ljHMfpeIC4KGKpb9+QnEY0rxDlfCANAmMExyg/0Cxd4Mlc88y1VOe/G?=
 =?us-ascii?Q?g7BJhmRm0SfimIE/PPvF517s+gR8XES0v/cF1D2rSPNz2uC/AlYUGI3iTdEs?=
 =?us-ascii?Q?3Fpv+SBCbSHhMi6uYBbZrxQsIbB7FuG+uEcn3JlO6n29AU/2JlHGzvA8pXQG?=
 =?us-ascii?Q?zdCggaSX1zxwczOynsfoupIr92jDgaj+mxoDqYUut6G9kVXxmd9lWKF7ADrW?=
 =?us-ascii?Q?IPRi0tC3VNglIZWtbPubwSgZyx/nRQphB+tHcAq/So05ReKcuIilEOtzqdeZ?=
 =?us-ascii?Q?MjAJuf2Wbk7mHJUwGsP6QtTUBhSc1kLwFj61vL1PSu1G3c8SjxR963ddjBAJ?=
 =?us-ascii?Q?6FFjx96u6bUHW96+JuKCwu036HZXKiY0LkhJjMfv6FZjPzF0llogJ2ELR5vs?=
 =?us-ascii?Q?CRoGObLJ2L3MaKPACL2mYnPqbmXHiu2wzwRxnD0cX6B1kcQBbeChuhlviDnR?=
 =?us-ascii?Q?8NvxFZ1eboLaN0VTCbGgoEonDMcD+0jEXUb0JAyr5taZG5/KPrjTom+lA074?=
 =?us-ascii?Q?KX34vT3mldTRkekxgz5WjRDyHLFhWHlm/OiMuaM+9DRrSkAepUCXenRV2++Q?=
 =?us-ascii?Q?5L+kYOMXoGYWMHP5uh0tac/KW7Wvq+KkNo8o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hi84uK5fdU1ilBbDOmUTZfNrda9uK1izHrUp69vkXXQuBiY4c22ln650wWWX?=
 =?us-ascii?Q?DlzoHKXxoe74Ui0kqNBLBUl6nas83xyKmKUzTo2ZCGftg0XtwKdBeG8nwyYl?=
 =?us-ascii?Q?QGqQd2iVvbGx4L0Q7z1aW7zA/vNzWdfVQdccMN7HQ5j1nbH1Rq8YLUKx9/8s?=
 =?us-ascii?Q?wRv2LCsyEV0Ere+j8p4rL76WFjfAv7MwYkaM4L3cZSTZQUk2ZSmZBoM6x05x?=
 =?us-ascii?Q?KxUHZVD8Pyg+FzXvMNSSHmRVuJq/ZYAENxGKm91rt0dBtxuJeHoob2d1AOS7?=
 =?us-ascii?Q?19pnqOA3HirmOVMVgu4xD7uiOjFKPRMGCHbM7rkQtEnklRYLK2+fovYO1ZUf?=
 =?us-ascii?Q?2OcVp5VlDfA/uyNkuWffjBkz9MKAcfEILnBG99ohN2wcwUZPybk+DB9+167K?=
 =?us-ascii?Q?1b/hPm2eMIOiirF1KeuJoSz+V7uWUTCBFkLKqgFg1bDtACwM5qdgFYUeAj9A?=
 =?us-ascii?Q?i3XNEzZ3CeeJmnoef8A+ipk3F6faglKkDwTMCOLJXaEuxIRwDiDh1HrLKrXZ?=
 =?us-ascii?Q?1cEkftKF3TqBjC/Vxs+Vq+3aUGKMqlEMj4m2Pb5rCytqcSieYKVTOV/tumBz?=
 =?us-ascii?Q?wjjfC4x3Pz7frHD58RrxmUPszy1Pz1Dbq3pyWnMcWnXC56VASK2lG+19VE4p?=
 =?us-ascii?Q?8Kgd2s0EmKKuAGynuGResrzHN7LhCy+HXDvvwzXcTSLNjSClK+IjP/GNvs4W?=
 =?us-ascii?Q?z4aeyVMH6ViklS7zAZf+ZZtBnMhoKR7rFGUUPqHGd11OlroWT8d8skboM5Rb?=
 =?us-ascii?Q?yqrxOYj1KIiKs14HDGRiOTC06FRtEVOCjjMCWvimhMGyMBrX+xO9Cx3Y7QAK?=
 =?us-ascii?Q?iY34h2UYqP+L+TaRrcYggFG6Kzpr7SkzOEKTKAqO/fYSxolMWBB7bO2tkjTQ?=
 =?us-ascii?Q?ADQtl3l5GXVXFnBGVXFSEtDpDu+mkjvKTRSXK2jgC1hWeJvShfJZXo5EjIwM?=
 =?us-ascii?Q?hyOujte0hV7K6LXQpKDeSBn7CP2yb7BN3UhezeCxMNeki/hFBuBg0tgRXdiC?=
 =?us-ascii?Q?OrOQYhOMpPMDaL2yvirZufHQiWp2JDpb6y5O7YRW3AqCXOout0vFwU7avGsY?=
 =?us-ascii?Q?Iqm0IKzRWAgbH2LNHo+QHq7XfV5q2kft1hMEXQ69gpEWm9xXIYtvvHzZ5/8p?=
 =?us-ascii?Q?tdBgau0xLcZtdSv/g0SG8p9hOzbkEJpqCOumSzGjEWBinEi0/21lvw32fD/o?=
 =?us-ascii?Q?rFOh0v6Scg93RKKwcp52h5w1p/fBbzVnDtbBCVEmxejZh4IcghHzI/14oJYz?=
 =?us-ascii?Q?DXqD8hv3uKTV1Ge1qYhYRPzR6vnpCBK40T7Mn4nFmcH2dRDw9htoBmu4iow7?=
 =?us-ascii?Q?Ak7pDKKhjZS3WS5ntUWPcAv3vMi4GUD/qNZwGxvaem0l5ivjfU7SUbwCXMsT?=
 =?us-ascii?Q?mnOfw4u1m7abPr7koRJTCsR/tbdZFXH085Msc64IZMv9mOwPsw/0IFKPoU/0?=
 =?us-ascii?Q?L2gBNZm36Ap5wdLQs9b+64ixGL+EPSzmEdAtBevvermwoYDEAfsvBVHq7Gdv?=
 =?us-ascii?Q?kKVusdU13GPNg2f6Qk+Vg3PlzjI07zePal7jQuJHlGNr6iyI1rrqgmu7kJXK?=
 =?us-ascii?Q?gDps+jTsXwWEx+vze/puPLb+/tgw3+s058dFR87Y4kHU3GWjzH3qMyS844Z0?=
 =?us-ascii?Q?1qIv/gLZqavXpurX4tixk84mup5q9DQblYmR+DqZtP0P683SlqcowR0QmUuf?=
 =?us-ascii?Q?4y4P+dv8Enq39MBnkEOHq5e7x1ZK5M3icqhRcGz917xMnBDNtDzDCtf32EFj?=
 =?us-ascii?Q?BIXIPPCiU1LzyTqeDA3xs+M6GfjNsP5uUyd50qUodJJq+FR2Zs9P?=
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB308241F2F6A8AB26A6249FB49F85AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f610ba3-1065-4291-fbda-08de4e902360
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 08:30:10.8488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tD3eXt8eyjnMh2c/i5ZPGVUmrTKuQ9gdarjRvuFxB6BZAHE/pn6BBwS9ki+dWhH4Twl4qmnYi1BGjUG4AD5buh1/ntfj1dYGDnRJIPRMiGuCNW+YivOe3vpJzxHk6x5CFmQC3Swf1oJDLBr48D889w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN6P287MB5182
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB308241F2F6A8AB26A6249FB49F85AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB308241F2F6A8AB26A6249FB49F85AMA0P287MB3082INDP_"

--_000_MA0P287MB308241F2F6A8AB26A6249FB49F85AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch Update _endian.h so that it explicitly throws an error when enco=
untering
an unsupported architecture instead of returning the unmodified x.
Also tighten the arch detection logic by adding an explicit LE check.

Thanks & regards
Thirumalai Nagalingam

In-lined patch:

diff --git a/winsup/cygwin/include/machine/_endian.h b/winsup/cygwin/includ=
e/machine/_endian.h
index 681ae4abe..e591f375d 100644
--- a/winsup/cygwin/include/machine/_endian.h
+++ b/winsup/cygwin/include/machine/_endian.h
@@ -28,8 +28,10 @@ __ntohl(__uint32_t _x)
 {
 #if defined(__x86_64__)
        __asm__("bswap %0" : "=3Dr" (_x) : "0" (_x));
-#elif defined(__aarch64__)
+#elif defined(__aarch64__) && __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
     __asm__("rev %w0, %w0" : "=3Dr" (_x) : "0" (_x));
+#else
+#error "unsupported architecture"
 #endif
        return _x;
 }
@@ -41,10 +43,12 @@ __ntohs(__uint16_t _x)
        __asm__("xchgb %b0,%h0"         /* swap bytes           */
                : "=3DQ" (_x)
                :  "0" (_x));
-#elif defined(__aarch64__)
+#elif defined(__aarch64__) && __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
     __asm__("\n\
                        rev16 %0, %0 \n\
                " : "=3Dr" (_x) : "0" (_x));
+#else
+#error "unsupported architecture"
 #endif
        return _x;
 }

--_000_MA0P287MB308241F2F6A8AB26A6249FB49F85AMA0P287MB3082INDP_--

--_004_MA0P287MB308241F2F6A8AB26A6249FB49F85AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-Update-_endian.h-to-handle-unsupported-arch.patch"
Content-Description:
 0001-Cygwin-Update-_endian.h-to-handle-unsupported-arch.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-Update-_endian.h-to-handle-unsupported-arch.patch";
	size=1503; creation-date="Thu, 08 Jan 2026 08:29:40 GMT";
	modification-date="Thu, 08 Jan 2026 08:30:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlNTI2NDIyMzM2NDhiZTQxMTg4MzVkMzg4YmMwZjAxY2ZjMzZkNTNh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogVGh1LCA4IEphbiAyMDI2IDEyOjMyOjIyICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBVcGRhdGUgX2VuZGlhbi5oIHRv
IGhhbmRsZSB1bnN1cHBvcnRlZCBhcmNoCgpVcGRhdGUgX2VuZGlhbi5oIHNv
IHRoYXQgaXQgZXhwbGljaXRseSB0aHJvdyBhbiBlcnJvciB3aGVuIGVuY291
bnRlcmluZwphbiB1bnN1cHBvcnRlZCBhcmNoaXRlY3R1cmUgaW5zdGVhZCBv
ZiByZXR1cm5pbmcgdGhlIHVubW9kaWZpZWQgeC4KQWxzbyB0aWdodGVuIHRo
ZSBhcmNoIGRldGVjdGlvbiBsb2dpYyBieSBhZGRpbmcgYW4gZXhwbGljaXQg
TEUgY2hlY2suCi0tLQogd2luc3VwL2N5Z3dpbi9pbmNsdWRlL21hY2hpbmUv
X2VuZGlhbi5oIHwgOCArKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL2luY2x1ZGUvbWFjaGluZS9fZW5kaWFuLmggYi93aW5zdXAv
Y3lnd2luL2luY2x1ZGUvbWFjaGluZS9fZW5kaWFuLmgKaW5kZXggNjgxYWU0
YWJlLi5lNTkxZjM3NWQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vaW5j
bHVkZS9tYWNoaW5lL19lbmRpYW4uaAorKysgYi93aW5zdXAvY3lnd2luL2lu
Y2x1ZGUvbWFjaGluZS9fZW5kaWFuLmgKQEAgLTI4LDggKzI4LDEwIEBAIF9f
bnRvaGwoX191aW50MzJfdCBfeCkKIHsKICNpZiBkZWZpbmVkKF9feDg2XzY0
X18pCiAJX19hc21fXygiYnN3YXAgJTAiIDogIj1yIiAoX3gpIDogIjAiIChf
eCkpOwotI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyNlbGlmIGRlZmlu
ZWQoX19hYXJjaDY0X18pICYmIF9fQllURV9PUkRFUl9fID09IF9fT1JERVJf
TElUVExFX0VORElBTl9fCiAgICAgX19hc21fXygicmV2ICV3MCwgJXcwIiA6
ICI9ciIgKF94KSA6ICIwIiAoX3gpKTsKKyNlbHNlCisjZXJyb3IgInVuc3Vw
cG9ydGVkIGFyY2hpdGVjdHVyZSIKICNlbmRpZgogCXJldHVybiBfeDsKIH0K
QEAgLTQxLDEwICs0MywxMiBAQCBfX250b2hzKF9fdWludDE2X3QgX3gpCiAJ
X19hc21fXygieGNoZ2IgJWIwLCVoMCIJCS8qIHN3YXAgYnl0ZXMJCSovCiAJ
CTogIj1RIiAoX3gpCiAJCTogICIwIiAoX3gpKTsKLSNlbGlmIGRlZmluZWQo
X19hYXJjaDY0X18pCisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKSAmJiBf
X0JZVEVfT1JERVJfXyA9PSBfX09SREVSX0xJVFRMRV9FTkRJQU5fXwogICAg
IF9fYXNtX18oIlxuXAogCQkJcmV2MTYgJTAsICUwIFxuXAogCQkiIDogIj1y
IiAoX3gpIDogIjAiIChfeCkpOworI2Vsc2UKKyNlcnJvciAidW5zdXBwb3J0
ZWQgYXJjaGl0ZWN0dXJlIgogI2VuZGlmCiAJcmV0dXJuIF94OwogfQotLSAK
Mi41Mi4wLndpbmRvd3MuMQoK

--_004_MA0P287MB308241F2F6A8AB26A6249FB49F85AMA0P287MB3082INDP_--

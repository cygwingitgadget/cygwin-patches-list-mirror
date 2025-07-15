Return-Path: <SRS0=uJfT=Z4=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::70a])
	by sourceware.org (Postfix) with ESMTPS id 3637D3858C51
	for <cygwin-patches@cygwin.com>; Tue, 15 Jul 2025 19:45:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3637D3858C51
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3637D3858C51
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::70a
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752608758; cv=pass;
	b=VByXLjVX23/NvTt/9e2DgS7XGLWIXmRaSFPCfxAhII5+EEyPFL1XV+6ys/gIwq5kiYYF0PVrmAl2YYGrFvKVWok83SAw06zFhS/QKKmhWfWZlRS5yfVSDkUJTqIsUvxDGlilWgfz6gxRCmlhetVQsIONHSj1ZsKnCgIf/GTHV4Y=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752608758; c=relaxed/simple;
	bh=b1bvqJvHJjK/8qLiKz1Jn+wSz4zPLf8bXg+/f7Jlgds=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=vL6WixyJQJdrNTResLECzqNDTB4DGqWqy3mfLwcBsZ8HJxAbGohhpjxZT8jONYVuvNYVUic2c7jhAYLs5mujb35fK83Rpkggp2p350w9ZcfarU8N5Bw6AlLbDrhbN2+nSLHPkmQfT+G67fxeVBcsTUdLXdE8ZpGh1CzsKlkIktY=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3637D3858C51
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=i+1/ZrkH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOvo37gPgzCQIJlcFvERbFxP2Zp6pBAs8Us2iZdBF3SKqIDLqHjbfszB+tNiNZmRCimmW9nlLsKaV3rUDe1BefZ1eam90vvuI5ktxqnlm8E+C97VhR+xMthY9TSA+Pjy/6ENRG1qHPZ6R///FJSLOaR1CTU+wnyCpILRPCsldmvlfVRff9HJxIsM1/hznTa6xbRT2oZm/dgqW7FC8mEIycX/mHucboWVYWRzDaFO7rd7u4seZpqtASl9Zo/zwF4wo8xCGU6Hp6ZN4PYyhgOc9I3oJRyr8/a8P3Zd7Hv9nfICFpgXkxFmx4aLdRxgawxMZKkFQjZX9l0uVKg5T18Ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJBBQrtxPpzH5Rr2l6V5V5OYt98y23eQfyCLtwqggWQ=;
 b=n6WM/MZpzObpPEJFCT2hIlwBlpIeanaqVbBIFi6UmootauYBacUkLLIBGrLR+dyyzfPy7yeW2fv1jCRSHs0UtSFOrLuvqHU/jSdjdi2KTNOn2iv5DFeMeshGC4fclnv4lTWdFI8/PV8NHb8RgRCKd5LErSd4m0hFr5AcVvGHD0y9i4nh3o0fA248C4COlOsxhPFoFmkQJNfS3YvgAbXru+Sqrk0InAbJNbVdcEhMCpebfghrxP3XZYt/IxI79B53ujorIekVc5O5rMgB39PChD+f0DFYG4g7GLlpmmpPY2DFqUHbrqlRSrcw6VYj3zJENybgTKuIUSrMRRpLtvsANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJBBQrtxPpzH5Rr2l6V5V5OYt98y23eQfyCLtwqggWQ=;
 b=i+1/ZrkHF1VGnMYm4hEChF292YUhcl/IHiDVjHXEVXbIcnBir8+afQqvnDuEREPFbuOdeCxRcFcDPhzhamXKsZtmezxc4mU5y5NBxcruH8KpPbY8uGsKvRyz6jhXvqhX8CVEudA/5MtI0Axg50cGtAEpz+l+K/WNBB5VCF7USBo=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA1PR83MB0800.EURPRD83.prod.outlook.com (2603:10a6:102:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.12; Tue, 15 Jul
 2025 19:45:54 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 19:45:52 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: mkimport: port to support AArch64
Thread-Topic: [PATCH v2] Cygwin: mkimport: port to support AArch64
Thread-Index: AQHb9cES81samF4TDUmvxiPAdTqoig==
Date: Tue, 15 Jul 2025 19:45:51 +0000
Message-ID:
 <DB9PR83MB09233D8339D631A362A7D66F9257A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923C4491893524EF694F6829243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923D524D8A33D763CBDD0369248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <f9a5570b-728a-14a1-92d4-357a0ca2b062@jdrake.com>
In-Reply-To: <f9a5570b-728a-14a1-92d4-357a0ca2b062@jdrake.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-15T19:45:50.063Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA1PR83MB0800:EE_
x-ms-office365-filtering-correlation-id: 0b71f30f-7c84-47e0-835f-08ddc3d834a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?l+sBJPLHofQzd6tzIL+QeS/tpOHi1I+X3aTBFB9h90uLlkuI0WXshR6W3Q?=
 =?iso-8859-2?Q?dz7IKxxiVvVJ1/dsi6/8XWErockPM7I6pyFl+AUGTKq3MiBC+iM1rkOu0V?=
 =?iso-8859-2?Q?F+2Y64oH5fszm/A2wcgyUzYSPpcjud2360PtliRoMppROIvfG0pyJr6yAl?=
 =?iso-8859-2?Q?fO9th1jfeKtWZS8FecBA8q4wtVqZrgTzhfy54+0UUkCjnLewQO9VAyQms+?=
 =?iso-8859-2?Q?SoGmtDVBUqgG+hzgT3omDIVDeE3A3rSzBzOviyllFUNSfuzK1lStpAA0Sm?=
 =?iso-8859-2?Q?44lkFogUmMltT7e8cRCfUjNF10ut/vNV6YwQhnFZE2ofPbBn7lZAbH+0Q3?=
 =?iso-8859-2?Q?WI8dlV+/gLVzT/iVqFDgQ99zUeQOuUDXs7CLNV77FoSDQcstD435x7OIgK?=
 =?iso-8859-2?Q?jINHct4Rz0zo6QYzi9pTwIxNcf9gvtgYtUPnuaWKBBdB4xk0Muaw8svqS5?=
 =?iso-8859-2?Q?7AYVzaIyIlxL3Krp4M3S3VKohiF6R9hs5qLwjUBGfhZD1bYuz+yPKwNxRA?=
 =?iso-8859-2?Q?XqkgE0khGPI+aclhkmu3r3oDNyq+ek8bmJuH7ghzVqE811CNfzFgZAmwtF?=
 =?iso-8859-2?Q?eXSrMczbMlwJnjXqLpLNIiIRwjbJz1Uv2RSycH2kPI+GpGM+IJ49zGXy7f?=
 =?iso-8859-2?Q?OUQEW9OaHsf7b9G9GnrnfbpyrXfmtfOTpPqbjzig7/NRS50VkXW+ihlenV?=
 =?iso-8859-2?Q?utFHLnRP0LbGw9zRwDDOsPJ9HKM6J6qwBLlTRT7qoKRvON03KVmlaSDFKx?=
 =?iso-8859-2?Q?IpulQ/ARPk9cHdpv691mj+5Cq1hXtHmUWKPRySpUUO9vN78UiMyuA8a995?=
 =?iso-8859-2?Q?Skot3y1LrAyT1vkZW3g0DAsmkHUHHtukHEt2S6ylvk5rDq/HVvxILs0942?=
 =?iso-8859-2?Q?Zxcbl5f7mI4jeX4lE2+kmiv5mzIOxA593XtbdIL+xQnYYDB6sTUcFnp9bJ?=
 =?iso-8859-2?Q?8dc0IZKmhnimLCZ47CRJ8xKDg3EVOUNv2iB3zgEPBj9JgWksglb6OmRFhZ?=
 =?iso-8859-2?Q?JkSw0q0hPFOHzZcFX0u0xz3aL48n0JT8aO+qU3SEw3iIWF8V8WD9aVhEZw?=
 =?iso-8859-2?Q?TJUsPAT560ZlrMff7zO0395RQfemL+UpkKyCGDmqdrrYlsAm1GJT82c5YO?=
 =?iso-8859-2?Q?kWo9j0bGwEb2WXVl7WZlyi2XVZk8HHCdEc/yGresACoLwwuRXGU4rqMITi?=
 =?iso-8859-2?Q?RaYlHE+XmXQVp3THs2GFmxAkw63cCIGj1zAhQK3Q12cWY9wxNM46rdsGDs?=
 =?iso-8859-2?Q?Ur0kq/LvGNxCsib8L/Jgh5z4nRc5OsqWTkYkYXULgPLDeTOtFgjfQyAg6H?=
 =?iso-8859-2?Q?reM+HCkgBA41WCmz8sWnc/gSPQICNKwGSxUa/XaTp0aF+wJYqxTmEcC4qw?=
 =?iso-8859-2?Q?twenu2lZkr5pwJ4PJU7WGq4XWZE4TF4J1Zh9QfzjkIn20sdsZE1QW9Oa78?=
 =?iso-8859-2?Q?V4QQyIlXJfb3l4XANGh4Fd24o95TANLQ1Nf5oBHaM0MBvu4TNthnw1V6B4?=
 =?iso-8859-2?Q?F+TlGWpVXD40Kk+V9LxhPoVNletKNHi3MZL8/5BB0VZbuzU5M4TNX/MXxs?=
 =?iso-8859-2?Q?ZPB/wgk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?TCCfpiOOXgBfwdQ0b1vkblE6OQsWHfqjxY6FNQtOwxlme65VuKNsUTIrtw?=
 =?iso-8859-2?Q?1SUSp2fRbKEii9UHmDh/FLOQ5/88QsPqPY8KnlgFC1T6X9Dwgo9NETolfG?=
 =?iso-8859-2?Q?NxPOXn13rWXcz3vuVBFFdPvauxiHyBa6M/1q7A0e7upXVwsfqnJuEhrHb7?=
 =?iso-8859-2?Q?sVIaFWvh4j4eK2Mafx20QmHNPACxXFHtzbGsi2+nZzfVjTvmLssGzLEjBS?=
 =?iso-8859-2?Q?0OxXmKXr0ew0TYCJOkYirL+tPpSC8vFKgASW+2xehuT2j9r54O1RVvIxDz?=
 =?iso-8859-2?Q?kofId8+rrOtZAQNBJsTh3BKtsmESayHc/VVjMaEczH+PnoVz8+lEZ/EuNv?=
 =?iso-8859-2?Q?HV4V+QFQU3eQNlTWZSimhqDbd6OPBRpuwtwtmlCu6oNUhzJVZ3DNtUGXOG?=
 =?iso-8859-2?Q?NbEs0xkuqT1WB+fm4EI912Hvg3rU65EnTbctXcCuN+pHotlcuiNc1FC53E?=
 =?iso-8859-2?Q?5l9VpYKQPCQL6h+QJE/BK8DTW0YMMSnTw1aK4KyKcDVsdklQymT9MYvPV7?=
 =?iso-8859-2?Q?JuFZf6l59k9UF4pNgxk3apifGMAhQqu+0nqNlGSmizjEp+8HK1WlRN+Jig?=
 =?iso-8859-2?Q?C/ksJ/pMQPyBJOqdyoBc8lqRB9gXhobNZfSyBtkiYv2P+F1ra6My6eYnxX?=
 =?iso-8859-2?Q?W8ZUiqj+tynNwverL5iLU7iW1ySngIut51EkkUUjRkJIEOEcxXFfz/Pit1?=
 =?iso-8859-2?Q?HgjdshqWG5JfOVEcHMmY2sVJbqXquNGCtktrUVo5tYfGfnLa2Fz8xdy3ew?=
 =?iso-8859-2?Q?ELYfjd7hPVzoifEBol7dkFdSc/Gxea+pqlTe3x5myeBiQgkgSykmM/pGBQ?=
 =?iso-8859-2?Q?vecbpPtZC92InWTRtyK60UEbgLGtHIjmbxkfTmKu8tFGHkcgexiJ0Onb01?=
 =?iso-8859-2?Q?yDB5Pih3FQKLSSmgxXl6oj2cLSQnAUMhM6QYL+ZbrKUjnXsXItXrI0043d?=
 =?iso-8859-2?Q?YiBAm675Lc6cfqUg9be3e1zvns6VNnYbTVf+UjxjxhxhXE3FxQ6yrWooUO?=
 =?iso-8859-2?Q?6ZW8DMVRAboaP0Ao3hZVdWxCgbipRRB3rvWn8kDmwK1A4kSM49Cr0PnFkB?=
 =?iso-8859-2?Q?DJiGCRefsTBs5GapAmPvCNR5aurN5svmWe4ce7K2e7Uv21swa0Cux52oe5?=
 =?iso-8859-2?Q?esKWGBorwsFcDIoKeJYpdag1MQWO/0Z9MY+v0xinAfmAG4JUBvt9Whak2E?=
 =?iso-8859-2?Q?VCWyLdmKIf6127umP5gwboj7e7fd1/4uRqQ+Z4rl4ZCKx7hjNHZk8mRUiZ?=
 =?iso-8859-2?Q?OUtJPoi8z588PM5o6SF3kVyDaq8vM+JH33ftvCehbFYyghiUh3IT2KY59T?=
 =?iso-8859-2?Q?VrTWhqEWwC75QoLQuHG3aGZNae0ockDxK4+8uPPBwAkVUr5OC5HNNOBXfx?=
 =?iso-8859-2?Q?szmwrtoLIsjAesAwvx5KA7+FiuwJBZW7skximuCLljgIm5yJe9OEufn0FY?=
 =?iso-8859-2?Q?a2dWadJ4+xelHBmGi1vTPGMsFvgg+xc54xZd/PpQOApdl+BJ6dDegw4TV+?=
 =?iso-8859-2?Q?RWF8T/e0X1842++a6zA16ZueF8V2VyR/JQdsclRZHUjZfRYxW6Iey2Pe0E?=
 =?iso-8859-2?Q?HT8cPope1fy/zTbU5gy02VT0wPZ0?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b71f30f-7c84-47e0-835f-08ddc3d834a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 19:45:51.9416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGoGxhd/4aQPmlQmy96ayRhd41emvUW3AJ+JSWYz3KUyhbxcpbfVXVBSKptm9xakjEucq0kzwrponM1U4/vekeIqVUitg0qcw2JilA0tGA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0800
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.

I will. Thank you for your insights.

Radek

________________________________________
From: Cygwin-patches <cygwin-patches-bounces~radekbarton=3Dmicrosoft.com@cy=
gwin.com> on behalf of Jeremy Drake via Cygwin-patches <cygwin-patches@cygw=
in.com>
Sent: Tuesday, July 15, 2025 9:38 PM
To: Radek Barton <radek.barton@microsoft.com>
Cc: cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>
Subject: [EXTERNAL] Re: [PATCH v2] Cygwin: mkimport: port to support AArch6=
4

On Thu, 10 Jul 2025, Radek Barton via Cygwin-patches wrote:

> Hello.
>
> Sending the same patch with more detailed commit message.
>
> Radek
> ---
> From e5060aa9afc7346301b7f394515d7a280b3c703d Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.c=
om>
> Date: Mon, 9 Jun 2025 08:45:27 +0200
> Subject: [PATCH v2] Cygwin: mkimport: port to support AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> This patch ports winsup/cygwin/scripts/mkimport script to AArch64, namely
> implements relocation to the imp_sym.
>
> Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/scripts/mkimport | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimp=
ort
> index 9517c4e9e..0c1bcafbf 100755
> --- a/winsup/cygwin/scripts/mkimport
> +++ b/winsup/cygwin/scripts/mkimport
> @@ -24,6 +24,7 @@ my %import =3D ();
>  my %symfile =3D ();
>
>  my $is_x86_64 =3D ($cpu eq 'x86_64' ? 1 : 0);
> +my $is_aarch64 =3D ($cpu eq 'aarch64' ? 1 : 0);
>  # FIXME? Do other (non-32 bit) arches on Windows still use symbol prefix=
es?
>  my $sym_prefix =3D '';
>
> @@ -65,6 +66,16 @@ for my $f (keys %text) {
>        .global $glob_sym
>  $glob_sym:
>        jmp     *$imp_sym(%rip)
> +EOF
> +     } elsif ($is_aarch64) {
> +         print $as_fd <<EOF;
> +     .text
> +     .extern $imp_sym
> +     .global $glob_sym
> +$glob_sym:
> +     adr x16, $imp_sym
> +     ldr x16, [x16]

I did a little reading
(https://sourceware.org/binutils/docs/as/AArch64_002dRelocations.html),
and I think this should be

        adrp x16, $imp_sym
        ldr x16, [x16, #:lo12:$imp_sym]

Could you test this?

> +     br x16
>  EOF
>        } else {
>            print $as_fd <<EOF;
> --
> 2.50.1.vfs.0.0

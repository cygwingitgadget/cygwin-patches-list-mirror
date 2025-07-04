Return-Path: <SRS0=s6lY=ZR=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20731.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::731])
	by sourceware.org (Postfix) with ESMTPS id A9E4438515D2
	for <cygwin-patches@cygwin.com>; Fri,  4 Jul 2025 10:28:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A9E4438515D2
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A9E4438515D2
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::731
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751624926; cv=pass;
	b=xAno3LES34EVxrqK32YOYnODqw5Yf3VNbMFcpi8w0hx/Eu6vuIpkByoGERhnR9JvO5Ts2ta+kwfgfHU7Q+P99PpWym9M4ERHfu3xp03nLI7RiD6VM4bLo7NJYOlPheoFau2qo9ajASqbkOP3DCCL0ujjC4KKoGWGApGzF+xpclo=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751624926; c=relaxed/simple;
	bh=DlX+vq2wzSxUKEa2ZJTN59w6lGFoJ7+Bp1HlbJz3p/c=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=CHgXBqM+sPRFoSBVtL89hojuZ0lf8QLUOtij+FwYDu16vz5zFpbLw3pvSHa1Gf5Vz7s8i+ppMh/qapJQUtXb/pk5lz2YpVeVvAjHdLgmqcG15OkcpaVGwgWm0z/1b1LimYyxl2lmA361WTf2eYCKUtyOP5SiV0XTJ1ZPGcTe354=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A9E4438515D2
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=PdoovGsZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcCy1FWokfbXygN/pl8L9jer32u6k2D40v2uRe4UdrlX70Z9LwMUyqabStQTjgep9+xMWXYwfuA3GywP7af4xR1SS5pBnvbrrIFbbzaG108WATpEmBe+78aAfeSc6hU98q5q7OvlE+jh+TyQE+PKfk47bpo37ZzaHsdU2pBvd6EAJXPFFZxwb9xSpVlElAM2ZoWqXmmWhfGNPAwf3a08n61+m3bOkRUQIKooRW2n+mLW2W9J+HenCP0s2ZTQgsb+dGbqMTIJ4EL6juJwJL2EF5aOYzg6zUjI4yjJDjEgRC2b1EpAYB2N5xnKmRoUfF5GpGb7tLe2avOBQVpnrmZ16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H6y8gsvIpY2CjvueEFIRny5DcICxyrG+oWrmKpCzes=;
 b=FS+OJs43O/bAb52Qc5ZKaSwEJ+oa7cafWbt0KmSu25rqK9G2YfgNGj/r55NmLJp6PmwXinmNU11BHYhlG66Pl+iFxBjZK1WptWZ8lmIsKTHQf/DHEplOwM14RxGIUkII+kysfYGZYFvdoYeKFce09hxYeCwCTFCIrBGmfKhWC0QTWVWwVbOFhMWQSO4+pI1s3a6a4y8HzzsOWCPWFzefpVzAv/wzn/t6wd8N3KqDF4KyIFYu6DqqoOosmsXetO+b3NSktOWLyXwT76Ik7Ir5BQHVIzqtOYxtLFvkWLrDB35n83T4WzdHJ1xe1IiNzs3dBMXj2aty7K0KKy5hDG3NKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H6y8gsvIpY2CjvueEFIRny5DcICxyrG+oWrmKpCzes=;
 b=PdoovGsZPtvHgN6G7r4kVT0AhoMOAnd0lfRfN7sPcQu1D80pNXDdWDZCKJ3FgzhtUTg2qw4PeLErFyyZBbYwemgSsMKOmcWvSsGY44ZiNltMxZ7XolBHkOuUL/h9UnFAN+OgQGbhUYDQfZQ7ip0qCcb0guFgHVd1ksxE0yZCK2c=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA1PR83MB0664.EURPRD83.prod.outlook.com (2603:10a6:102:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.11; Fri, 4 Jul
 2025 10:28:43 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Fri, 4 Jul 2025
 10:28:43 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Thread-Topic: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Thread-Index: AQHb7Esvy6gBlfOr1kOafzCSaf4su7QhwgYq
Date: Fri, 4 Jul 2025 10:28:43 +0000
Message-ID:
 <DB9PR83MB0923B144F86ADC301E17B3399242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
 <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
 <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
 <81096ca9-9542-4818-b363-f3856915050f@dronecode.org.uk>
 <aFwaB47HM8UDH9CK@calimero.vinschen.de>
 <DB9PR83MB09239C78F66E20045E2F4A269243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB09239C78F66E20045E2F4A269243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-04T10:28:42.430Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA1PR83MB0664:EE_
x-ms-office365-filtering-correlation-id: aad618e9-3e70-4856-8045-08ddbae58d04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?pAGfjRXJ+VszMt42ouLNqdmVdUhG/UoUItCrWh+c+Bb+rR0VvGA/qNH3Re?=
 =?iso-8859-1?Q?2VTyARY7FC/mM891QSBcfFEoDZCoaOeZydKhHuuRpQg+4cOLGq6su4B+CT?=
 =?iso-8859-1?Q?0zh1TtQMbBiAdBYZJ+SuLNV4e91sgmJJoEIUi9bs1SPkZbVrdT6bICWKmT?=
 =?iso-8859-1?Q?gsVYK+QDbgChBE/M1PQiBvRXgEdObYpI1rmjwe/Z1diSg+Z23SaiBDPdZi?=
 =?iso-8859-1?Q?ePD6DEe3tA7F1pkEJT4iy7BIdNl1gWWBqCqIRw0vS2ltgBn2I+Mjzq0xwc?=
 =?iso-8859-1?Q?RLd3HbqA8RVt9ZyoCSw8n/ACnYtchiOZEAIwOvz6t5Qew+rFniBx9zQHrb?=
 =?iso-8859-1?Q?xo5ECIizJHPh0WkKhezjNgG97y4Ijbcr2ly+qBYK1Rj0sS+eOW73ZzZBCY?=
 =?iso-8859-1?Q?MC1i3IeGf5RL5LEsGF1gpEpyMYfna7tZY59CgPemUr0dfCEZZYepHlsucH?=
 =?iso-8859-1?Q?ypCAFwOz6KD8ZSYusK+1XUBrHg5SqOLIS4SUcbRXtwOqMBNPXzozz3YqG+?=
 =?iso-8859-1?Q?X9/D/hUbUwiDev3ClRmxeHBh5GTYYOwfObVMHnqjhAwJuqBzyvvAAW/39P?=
 =?iso-8859-1?Q?251biXjZtiUPEUbDWI3B6LpNcTbWdjBAUtYeS9HWcbVDGgXs9SNXOe8DL9?=
 =?iso-8859-1?Q?7IkHFeA2X424q3uwtY12WH2ap74GVqLEfkkMfnRmb3JAQNnQflY/TUKqB/?=
 =?iso-8859-1?Q?rElQB7Tmldqq9yjAJRg04ypmR/WeN5/YlqgjRhCkBiPzx3vUBMKBJmdZeu?=
 =?iso-8859-1?Q?/7DK4u4HVkvLJm+v09glCkjlL4TJtfI+SXdfZE24AlFEbcG6N4b0i09xz0?=
 =?iso-8859-1?Q?KLIY/i3AAjlRIw3wMX5oKOzwJ1jZ5YR5qOK7i+xGZlVXR/iRe+S9NKz2Dt?=
 =?iso-8859-1?Q?DNkSdBc1MAASXyGMFGI8e10FBondQUGjXe0fpaWk2T+ezCXdcQpoYM8ixR?=
 =?iso-8859-1?Q?/kA6fjcX21dh9d/SAk2NEX3UJJGmSmvojd1GbS07YzfRdNQslXoVvBEF/0?=
 =?iso-8859-1?Q?HISA82ngo8qO8aoDFNB1gRSbGyYyUMyF7Q3HuK/ORNWp5q/kHmrG7Ihs6R?=
 =?iso-8859-1?Q?/0O2/HlWfKbSYolIDxNakfoAnwIm++X5niyBnnKHLLzifMiJDj6/pQCrPP?=
 =?iso-8859-1?Q?YinYja6v3/xmw4rAzgS5M+1umZbV9r09Yr1QZmT9d0YFud+WDeQtPFHJl9?=
 =?iso-8859-1?Q?DZoa7KU2gO0RC+xHX8m5uAVhg7rsfdtGD4c3xKMkIa5pARa6JsXoXjv/W5?=
 =?iso-8859-1?Q?mbLxF8iqOuFxFZ0dtzVaxpO7YuqR9X9D7IXBBH9ujg809oEZiHXM1OqIWG?=
 =?iso-8859-1?Q?2Dl1L+cHMy3WZCXrP/uzhq4DdKGHGFxt1wiJYRE5vVYplq6Db/YfJDS6oI?=
 =?iso-8859-1?Q?QB0LLbpVzUv3qlkc1K+hYBW3TSIkpsqztzxgoA4UIJkNPU2i1wXbKXzONf?=
 =?iso-8859-1?Q?YaQefRArougP8zRUfNJLPEjufG30CZnarqraMJSbXI7+RMu+/jpVpTEJ5X?=
 =?iso-8859-1?Q?R7UFFVYoyqhpL3sa48CS0mg3wTJiBLz8rdfnyv0zx5Uw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IBnDu7OtCtuXk0OfQmEKVgBDsd4g7W+DKGs6Hin6jep3IYyTlqMMQ3niyN?=
 =?iso-8859-1?Q?KO9fune9H+N7VVwxkvC821C4XJasYPAmuuIYuBvPj3IXM/j4u2kV1Mf1Kk?=
 =?iso-8859-1?Q?NvG2acQQ3bq92XBemcPML6sUuT8/y1rE3JMCCLJs8csah1yIH9KPDoGRx0?=
 =?iso-8859-1?Q?SNLRT4NoZnmrgliCoo9zx5dhOudZGy44+7wciQO6hLxIbnkkVqA16N5uZb?=
 =?iso-8859-1?Q?TKnBs5Qx2skGmi37KVhDoOFUJatJLYvOTqsxrcAG6SIyEzT4qxSqsbxjIC?=
 =?iso-8859-1?Q?BBfsvbXTFli3qJ3Y5ToOIRJZXqi1t/q4zI0bh3K0MtN4wstrEGE49510zK?=
 =?iso-8859-1?Q?bzlywe3QmmFSfKLUg8GqdnDgS7BEunuMuluhpDCKENfbORtuPfbpBuWBBi?=
 =?iso-8859-1?Q?C9oM4pj6jodSOzMHabUVuPsCunF6oDWD7+TPnmvfMq+1OAy8CDwj4o7xvJ?=
 =?iso-8859-1?Q?F14lMYIkdtGGiK/nbpWgWgZF3Zt7iH8jFUXsm8UtMe4Hrbhov73WXxDwN+?=
 =?iso-8859-1?Q?WM4b4Q+/j70PKWl1kBRbksq9LwcJHF12aKiAFts9CR9x/EiazOqPEdIbWJ?=
 =?iso-8859-1?Q?Vi8DcHSsapHyXy9UleOXI4IKc+IQQcx52F3USpTJtNrHGGhPfgGsLimMbc?=
 =?iso-8859-1?Q?oElTTr5iiKIjG6YYs74HhJrQCLsW/ojEop9G9WXN2xAsvW0Hl7OwHCqvt2?=
 =?iso-8859-1?Q?QeJz2vBWqeX66V+0UAjF/JiTocqP8lUEmHAPlKcmgUhGfpogcWVkgaNeoa?=
 =?iso-8859-1?Q?Fakf2aqwEwyCYfHhEfzn/PQqWinW4H0L8nTWmS7xHSKxPQZz0Rxu4kkECg?=
 =?iso-8859-1?Q?f2+etqCex2+6aDUGm9/ECgvocSXvHUWcqYx5Ch3l8XMIUgL6LP84u9j1yN?=
 =?iso-8859-1?Q?e2CLnr+HSxo1NmCvTkCRbjb8Bf5K3LWKhpH59d3VcNKEMFMYuIqn6n7+6c?=
 =?iso-8859-1?Q?NwVdBtScz0V6z3Xb5iGPperVbI5sv23hmiM43UXSgZPuzotyEHoqYcw4gf?=
 =?iso-8859-1?Q?Zjs4/5s+6XHGkh7jyNFIiZbuVJ2Y4THcZgINksdRfFOsGgPoQ0j/khNeTi?=
 =?iso-8859-1?Q?FoIP/8lt7/1XB3JuVqYOHcNt9oOgbQFAna7BTWfftF9pZuycaU4Aa8Y2ob?=
 =?iso-8859-1?Q?fCfqQhelnpKUOwAo1ApKfw16bl+qznEFDrgJ65Yd7YwIyWepMFOyxdayLC?=
 =?iso-8859-1?Q?L1hGpIOZWQgQlbvMZLkFc4tZNKVy5jrC0LawGXHPWu5rkvz5hQj/OGT98m?=
 =?iso-8859-1?Q?gXrHhvXUmDoNxD3e/o3caKzvRJTYmf0dADQckYjR7smvvK04sv8s3kK8oC?=
 =?iso-8859-1?Q?G2sEkRkQffddbHIiQ+6nO4jd7t54LrGi6LbegD30nyfqUj5b2qnxFkpQeQ?=
 =?iso-8859-1?Q?8HtNIDcxzCKvp3uJ7zr7m5Q6C/N8//cLr/5Ek5wSCRHavAelT4ZB63MXX9?=
 =?iso-8859-1?Q?bRYtZieOZznvocyyKvM8ek/b4DqCZ9vQbzmaVUblg/3WCo/yelCglH+RJz?=
 =?iso-8859-1?Q?lpSKcuJXFgxUodhcPcHMW2ySGCYPSAwxoOelHc1aLlVNwuK2N4kJLKIQE3?=
 =?iso-8859-1?Q?aHI2yIXCNVp4SaZiDNZ7b6Std6kk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad618e9-3e70-4856-8045-08ddbae58d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 10:28:43.2261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjdDt0J4ilF8qWyEdHfFI+NmcfB+t1yp45PmBGmwLeyuJOnnQwZSzowE0GhDG+xCpqimoo0bO3qlN/HEXA93RcAiY8Gra4qhxW1/S8fMYro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0664
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
> In terms of this patch here I'm a bit puzzled.  It's nice that the=0A=
> "=3D/lib/w32api" is sufficent.  I tested this locally on my fedora ->=0A=
> x86_64-pc-cygwin cross and it builds fine, too.=0A=
=0A=
> But why on earth is adding an unneeded dir to the search path=0A=
> breaking the build, if the correct "=3D/lib/w32api" path is part of the=
=0A=
>search path as well?  Why does this not break the x86_64 build, even=0A=
> if that path neither exists for x86_64?=0A=
=0A=
This is not consistent with my observations (tested on the GitHub CI):=0A=
=0A=
`=3D/lib/w32api` breaks Fedora build=0A=
`=3D/usr/lib/w32api` works =0A=
`/usr/x86_64-pc-cygwin/lib/w32api`, resp. `/usr/aarch64-pc-cygwin/lib/w32ap=
i` does not change anything (builds pass whether it's present or not)=0A=
=0A=
For this reason, I'd suggest to that the original patch https://sourceware.=
org/pipermail/cygwin-patches/2025q2/013892.html would be the safest to merg=
e.=0A=
=0A=
Radek=0A=
=0A=
PS: Thank you for your feedback, I'll be adding more information to the com=
mit messages.=0A=

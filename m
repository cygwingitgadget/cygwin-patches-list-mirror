Return-Path: <SRS0=ioON=Z3=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070c.outbound.protection.outlook.com [IPv6:2a01:111:f403:2608::70c])
	by sourceware.org (Postfix) with ESMTPS id 175963858C42
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 14:26:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 175963858C42
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 175963858C42
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2608::70c
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752503190; cv=pass;
	b=T/Toz6OnJ9jkmQ2ir/hWp5T8lcSimHfop/v41UfW15K7bw8+e7apXRI7zHH+MCu3H+ZhgzRIR0vMcGBisaM+GzXw6CEtPxC/uCMT2wYrlG64FXLJ6paFeWR/kQe9LPgU4TMBcGCAiX/RgvD4XtGCQLJehi03OkhGdn5gBanbF6s=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752503190; c=relaxed/simple;
	bh=yWJVonvFwpYIry8E9XEvK6LpUAivw7XYjmKlMD2SVKY=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=W0/5bzDC6G51WvgWzi5YMO939Ukm/4jQ+pjPyFW63bc8YZJPLPzMPTmupxDmDD5RHf+TWia8Ut2a5L3Ed7GhFjlGV3+Yiad+8EzoyJoCCzXiCUgBoyoQy7lMXEGN8vPht0ndrCFQdWljAzaeai6fXsUouHALuhia6dKztTOKEeU=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 175963858C42
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=S6tZubV0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHZ4E7j3XcNUMNqX2xSrfM0Oy83v7l0SM7tiL3lnHtwHuD5BMNcsP0t9eDD5h/gMRdqRej67QlFpVGUtvMRaMHY8NC62iVAhklR6SY0fPbecvziDEVhWsrOSHXOv3PqukjusvWDZPXkh0ktCoCY9ut+HIpOdoAQe3VcwS2Pbwv63tJQRT0rXHO2yI14JmpGMtqrguz4bLlMhzsDuHpckP8f1wC+VbCZkf811BgXgDNlWVjUfUnJOL3U+NEnGOT9u9xcsNI4ijNUTd/AoY+wkaPBROF5LTYPHn4lip5CZDE4SREbmj2j+3DsqScKoFknx6/OpbJWcFEqxBcG1DIV0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWJVonvFwpYIry8E9XEvK6LpUAivw7XYjmKlMD2SVKY=;
 b=wdU37Kti6LUMsQIBxX3asPT3ni4f0mFmw1n8C4TxBFZLVsyjqJIifD16sE78Ouedi7Sk1iLvUi7PSY8BX7dlPZCtwePxu0TGm/xm3VBrOx4pJXk87rsoEll8cPnK0mXK+EnOzkKT3AiO7yGY/RqcVJBez0T2YyPM1h08Mvr83+Mht+9W56UykYZ79gJNlVKkkZ2EloEO7IYzvkYayjWvzsCGlKMhUOLeboqeNv153djRCpmisdnhs4zINx252AT856hjQNM9yDl52vsk56sMvjNW8z0M44N3oHAwQpTD42Kf/uJ9Z23Iomcv6JdD0L6NvB7pGXEVgRaitWpaFjdAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWJVonvFwpYIry8E9XEvK6LpUAivw7XYjmKlMD2SVKY=;
 b=S6tZubV0E53MIZoIp7d8bIYlMqh3ogBwku8yZYvFT+2c8Qrf0HpcwAczNkP4hL2o2kqw11zR6vzQOhimkH+ZowDOSugVJlLgVN7WopupfThrhwcHs0ek+2M0/ws8oLTqRnErUXUv0oL6kSd5GeDH6PQF0s6WALr0gdcB55gAlSo=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0706.EURPRD83.prod.outlook.com (2603:10a6:150:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.20; Mon, 14 Jul
 2025 14:26:26 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 14:26:25 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: gendef: stub implementations of routines for
 AArch64
Thread-Topic: [PATCH v2] Cygwin: gendef: stub implementations of routines for
 AArch64
Thread-Index: AQHb9MtH9/6iKTCcdE6WLqSapXb3bw==
Date: Mon, 14 Jul 2025 14:26:25 +0000
Message-ID:
 <DB9PR83MB09239FE0F8762D882392064A9254A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923C9E8CCEA2C6CF37A60739242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB09233DE9CBD5304BB8D2D69E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHTwZ-lCwbHtuIKp@calimero.vinschen.de>
In-Reply-To: <aHTwZ-lCwbHtuIKp@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-14T14:26:25.451Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0706:EE_
x-ms-office365-filtering-correlation-id: 699123fe-9650-44a6-3384-08ddc2e26a48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DrQdz2WddGJgO1JyhWpUpFPrTSXD7BhboWmAa7scR8FDn8o6uPsZ8NpNIL?=
 =?iso-8859-1?Q?CJmr/jYKtSpdpG0PnhDOdisgS42CJEogJKUNxXlYTl7vkpVSFEM79AjKGR?=
 =?iso-8859-1?Q?stUKGEXEcqR1vO6YXYTXovIqJeeaCQDMGE0Nnf4mfdUn5biHLhJDqSgEoJ?=
 =?iso-8859-1?Q?kHirTapwyAwhIFON+MIVzgGAXvqLg6rYW+bwcAt9tXjLW/BVOnhNsFXyNd?=
 =?iso-8859-1?Q?fir3dnRvizlH+eOgy4DthFgCyImsu45Cdlb67CIiEZd1glSos/4EE5xKWk?=
 =?iso-8859-1?Q?SvGeYCcZN27jqWRKObJyaVZcpVpAqGa2+AbvrPyFSAvJoLDXdUXdLVGcqz?=
 =?iso-8859-1?Q?BMRegJZaj/9womM07CQf1pm0DEGTbFfHfi51Bah6gwK6rPn1lZUEahozph?=
 =?iso-8859-1?Q?BmcC1McOmBG3chTmv1cJElhATZ6XmRdw4Nw1BIV1LZf9+hr0fSzMawKlaJ?=
 =?iso-8859-1?Q?pJ49dQvnSnvmBI4pJ/B9aRG4b++Evp3MRfxh0GEKI8ppmzZt2VWosmLVU6?=
 =?iso-8859-1?Q?AOxgWLJWPJq6xPxAHio/8iKoitznYIpjtzGfs8Cxs5nOAhH/EkzDdnbqcA?=
 =?iso-8859-1?Q?lICEs7Y/MALjuIzgS/GbMFdUy3WCkhjeG/bpJJP0asSgWeScro+GlCoAQ8?=
 =?iso-8859-1?Q?i8s/joa3V/0RMieC0Kh92AZBiYRLln65cE1yE8ZjOXadIddWKdrFZOyzR4?=
 =?iso-8859-1?Q?BntFSesMLaZptIdm99eVCypOUpV0U+TB2Truh+ZUkZ2iRHtZMMBR5OnWu6?=
 =?iso-8859-1?Q?9ShaawSmIjpawK9wY6xvThgBRjxLAeUE9fdzS4CTAljr6Rt7EvFWx1jzmm?=
 =?iso-8859-1?Q?3KkGYXa2fb52oYermJlKaLlVY15FJ5RQjmykRcUH8vAZ3w8NBBxlMeCaxv?=
 =?iso-8859-1?Q?vEOM02yTAlhLvNEp4EcYSQPKLkR1Oi+RrbWYKrDWvjAGvkf8/AtEmt1FJH?=
 =?iso-8859-1?Q?1JjgLtlEfKZ/3w9XzaoO3W8SA0waN91sGVFESY177dHPwCmZ1otfG8/E6y?=
 =?iso-8859-1?Q?3i2l8o2pc6bct5eESRyus0JnCrrf+DkRIg2J6aIRtJfkrVI8rju68zABAr?=
 =?iso-8859-1?Q?g0zs3jXc4xRlUndG0kNCbyRXaeyGy8fYZbqO9P45iqZOdEnftHYH19NFm+?=
 =?iso-8859-1?Q?dk0AaEzj2KctNPQqV4lwg6IS08UHbbanI+dDfTmYnlUkqCc5hM0sCzprbo?=
 =?iso-8859-1?Q?aaIavEuT8y/Zc09qNZQ6R0jUyb4E1HAgtB0/LiM9UYhiyWKUiDyFz1aWQe?=
 =?iso-8859-1?Q?StpBy7yYYZLYTh0sFsi7r8H3tTfhOWKMGgUZOhiH7afAOVGToQh5lfXPzu?=
 =?iso-8859-1?Q?xvxhurGFe6m0JP58F+6cXsJvLshC4Loxm+x2gHY0R1K9K4D9b24d5kY5Ig?=
 =?iso-8859-1?Q?T5lfHJJw3gLazSjFCfPH0tSfVqJ6S7xczFtE3cFZMgNI6PUgZz1Fgtz29q?=
 =?iso-8859-1?Q?S4wDeoGE0SYekWEQ1FWlzOyoHhy5sAprbEhyG2okVxkip/7QrFym4j8Boj?=
 =?iso-8859-1?Q?00YIm8ekoSB+umUeOSr7uLgBQBVQIQ6BosNYTFJ4EY4D4GQ/vEL33QnMHk?=
 =?iso-8859-1?Q?LCIiWFg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kza7x2SM7Ape9SXx49RLJfUEjGWLqBkHurJcX9J1coI3m2KQ7KLXN8repm?=
 =?iso-8859-1?Q?paWgabKy8xVdwwG1Ohxr+t5c1bvyVhI60xeGNM51nFENuJaVC+RA3dCmKX?=
 =?iso-8859-1?Q?dUPW+66Ab4ezGBBSIXaUyeexG2KMATUtbMO8gJP2mQuzZq6yISsuqKirsd?=
 =?iso-8859-1?Q?XFRBDHUTFJyBTrq7qeA69uPwwuwf2ilZEh0SUcFe4sY+vE0u5Rph66vrVJ?=
 =?iso-8859-1?Q?3IoMp8Vq9QlOqdai+uqAJSYjx3ktvfi252K2/XKGScyqX58rdlDegirSGa?=
 =?iso-8859-1?Q?ti4SxocbL+I5J49L0CcAICBdcXcD7gSEUU9b43yBjJND2xqbUUQ/wCytEi?=
 =?iso-8859-1?Q?0Daz+PN51MyrWJT/vgNhDk1SrJbllRWTDB3+OKsPhXmNf5qLxWRkDLespE?=
 =?iso-8859-1?Q?peAN7GEO0tVwHVFc2YiDK/zqmrme6Zy4IYbMI9wwdHZ9msV37r1Y3/U6q4?=
 =?iso-8859-1?Q?VJ1zq2IpISWiB1BuGLrg67k8SS8Dc/gWXs8EBnByMoTjERzxrtOorntvEE?=
 =?iso-8859-1?Q?kGQa8C/hd4cubfBpdL5iRSjBdVi43fKT5K0OXp6usMkzo6AMjtvYTAT0k3?=
 =?iso-8859-1?Q?3qEG48hfakTrs+8hHV/jHw+q9gH5hVltGIoZbY3Nr2D469/s+9VIXa/1kS?=
 =?iso-8859-1?Q?bOz2otFz1QmLQT749b0itzk319ELjHpHa2b5AVgqzZYzrQbIzK/VuohmXg?=
 =?iso-8859-1?Q?vlNjFBpA2FVyNOAHeuMn9QfTtVAejyRwNouDfElCvenvUfZW+Y+yiuOQBw?=
 =?iso-8859-1?Q?1TKD1Xryu4loO3cRlXCHRtzLdMjd/FGPJF3GsP1ifNvrSu79vvo7E3ehyp?=
 =?iso-8859-1?Q?Szicc6h0706dWktunhM2rB456zZtdDboHhTYMTwmrltn4H2RWd4yQsTUmm?=
 =?iso-8859-1?Q?+F8EiM+fI/RgJoWRlzf9Ne5dysBN188ZBsbVQZFZgkLHk3JvUfV3ODAGHG?=
 =?iso-8859-1?Q?UBhK46N+pu4uuPPNxlqQhDwQDpL5veSsYNRMlUL0pUCMLuS+E0I63EGHKb?=
 =?iso-8859-1?Q?hPXoc+e2fB45DM9RHeiyqEdNsKJXxciTWFYsyxeOiEDCBXPisV71qwVBsm?=
 =?iso-8859-1?Q?8T2DvMsYELbMs0NZAf2vFm19+fP0SbzfTBbRDXIYdWeaNBHqvqwEVwVh2u?=
 =?iso-8859-1?Q?bZedFm1sYeSJRYIRKjtdlXo6oN0K9dWKl7uZ+Vi4kESuTpnwSzTdjazoxy?=
 =?iso-8859-1?Q?QiS/d8PG4D4V9GV+ZXf43Nid3tzXUnxo8rgy0StFghM6uEF7lLju3r4lDv?=
 =?iso-8859-1?Q?RzL2hgk+d017tJksLLtjJh+3LLAEAXHsvZxzghyIqS/gXBblB7xTH7uVwU?=
 =?iso-8859-1?Q?4Xg6KZ3PjT1g8ICZ2XSNrxXgR6Q7eZWLltzCCsdgLAqgibD48hxspmjEQh?=
 =?iso-8859-1?Q?QkZP3gKrtwS26fsSnMkGzKe0U7Cqan+YzbREJDgDXgVLe+MzrQ8x9ddqoF?=
 =?iso-8859-1?Q?xOk01h0AjggFHX+VZXlfg3fsSsMAXMcMtEMUCoP9SV6MmxXneEC+PfcQq5?=
 =?iso-8859-1?Q?biOdWgajBN5+InlaGsKjafDBy7j+RF/8bUnOuzA5KUey5Rze8rDILkTxxV?=
 =?iso-8859-1?Q?HlzGuRbdrR47uVXR9/wgTJ8LnAub?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699123fe-9650-44a6-3384-08ddc2e26a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 14:26:25.7621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddMS5x6lbPuQxuMnS1Smpjn4ak/GxjfFrwZxDOZ953cr4Ou5qyh0znz3jkxD9DXUZEq0b8BIA5Mh8p7xG+z2NO4JMyfdnOMVQV69yJxO2n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0706
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
> Can you please explain how you're planning to go forward from here, so=0A=
we can all understand if and why this patch makes sense during bootstrap?=
=0A=
=0A=
My intention is to upstream a minimum set of changes that would allow to bu=
ild `cygwin1.dll` and `crt0.o`, respectively bootstrap either a Linux-based=
 or Windows x64 Cygwin `aarch64-pc-cygwin` cross-compilation GNU=A0toolchai=
n. With the toolchain available and Cygwin build passing and tests running,=
 the community can further contribute to the project while having CI checks=
 to compare with.=0A=
=0A=
One can check out what does this actually include in https://github.com/Win=
dows-on-ARM-Experiments/newlib-cygwin/compare/woarm64...aarch64-patch-serie=
s1-v1 branch where the commit messages have `SENT` prefix if the change has=
 been already submitted to the mailing list, `TODO` prefix if some rework i=
s needed and `SKIP` prefix if that change is there only to allow validation=
 on our CI https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/blob=
/woarm64/.github/workflows/cygwin.yml.=0A=
=0A=
As you can see here https://github.com/Windows-on-ARM-Experiments/newlib-cy=
gwin/actions/runs/16268410995/job/45929514517, with changes from that branc=
h, the tests pass rate is already 216/287 that could serve as the baseline.=
=0A=
=0A=
Nitpick: Currently, our CI is using an `aarch64-pc-cygwin` Ubuntu and Windo=
ws x64 Cygwin host cross-compilation GNU toolchains, pre-built from our dev=
elopment branch that contains everything we've done so far but once the abo=
ve branch will be upstreamed there will be only minimum changes left on top=
 of that.=0A=
=0A=
In context of this patch, the only changes left to add to `gendef` to achie=
ve such baseline results are in https://github.com/Windows-on-ARM-Experimen=
ts/newlib-cygwin/commit/c7e082d457e0b2a356d1fce169c2224b46e3a0af commit. Th=
ey are surely incorrect in a sense of the full signals handling implementat=
ions as they are just relocating to the target symbol. I was going to submi=
t them as a separate patches to open discussion whether such temporary impl=
ementations could be accepted. Nevertheless, IMO it's better to keep them a=
s separate commits in the history. The full-features signals implementation=
 is in progress but it will take some time to finish and it's actually not =
needed to bootstrap the cross-compilers and get some baseline test results.=
=0A=
=0A=
Please, let me know if something deserves more explanation.=0A=
=0A=
Radek=

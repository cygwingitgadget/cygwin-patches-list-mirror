Return-Path: <SRS0=H4g6=6Z=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020103.outbound.protection.outlook.com [52.101.227.103])
	by sourceware.org (Postfix) with ESMTPS id 391CE4BA2E1C
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 17:18:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 391CE4BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 391CE4BA2E1C
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=52.101.227.103
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1766164682; cv=pass;
	b=OK1Gj+Vg2+dof0C1VD9tOk2N2xCWOlpl/DA+XJdd0cut9bvWMpM2/GxaNb7506HzubQLaPtSYA5Us38vDBJWVVvJPMu0bc0Pr52v6g/EiDB/j+u2H2NwClRV76sz7+Prl/wbIWxJ/v/e3EMi0d95pQ84ptJfjVxaqU4MEnXaE+c=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766164682; c=relaxed/simple;
	bh=KHqJmY0k2n1pHhK51Ew2UvxperKBzpzl907sgfm6AeQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=bfVXpD5FJzMSahG6gcFJN6tfvPjn4DuVFX/awoU+VyjPpifYuxCjxkNV88gY62maLyyD6C2953qraP+wALRb32hVP0wgH7rNOtmv6qkffA3V/qst48lCUCCvwXTrPTmDbhmN7NYxk73lR1bzD8ZROcoKD4hj6MWiY/yvTea5g20=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 391CE4BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=fjTLxQZJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyQ7pW8tIqe+/eqUk0v+Lte91ox1BwKEITE1y16yCXYvQVGce3YW3Y3KH21vGRMkKI/mN4QODhYSNojC5CsbMoezXj0qC0tKUpeo1mK7phPuxirlxoiIvsP8TaiFca9CEp3qboOc2H+00f5KoP4sjDxb2YXZEc82ztqnplK5jnGEZclJXkJ9uWnu7v1H+YqWdSI1ahPXCIHxcwlfVsAo2PN/D7uErDTM+QeQj+yMrqIBup95zS8jD07TDkqSQsgcvWpY0FD2dESTG1kqgU+CqTYDrVkkLAVKSpL1BMusK9/Bi7O43BUG+uh+2n7xJz0u0MLbuZWe8Bw1c3rXQS5B3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyhV2CsQnYvl3tBHHl8fMkjE0+sjn5MAUfz0/nSjMhw=;
 b=bhyQYJZ2DCyZ5l3kN++VGv9mOgCH3pjYH3Cu/29GqYo7D8jcvErEvzRauTVc5TIFhf5Clj6Ltay8oRTaBDHE06uV7/W6iB3853gE6oZDZEQ20w/1xkAH2Ku5iqzvF4z9hiOTi2efZmWNlCkWw4afwa/QwP8AQidyF4+MesUj54JOATQBv4S7WmlQytFIb2ebcYlrNX4KrtJbNJowEoRCnD30tYbey1TMTs2bIqjCD+cvjvXbejsXHh+si6bXBByuPqWqbtqqr9S5+DLXpUOg/OxfDmp9CL1yx1TjlRYyWrSqozNNLLcVzHxSYmBJydS4fgUs5GjfLnC7oAL6Gfr0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyhV2CsQnYvl3tBHHl8fMkjE0+sjn5MAUfz0/nSjMhw=;
 b=fjTLxQZJELdlLhvYhBvOJHnf61RTdTmYCN8v+debFV0tKLmI6ZwgiXrKsSzs8VB0w4Zm900vYU3TTR+tfBu7ZSeisSy5HPyobzkC9SQEE9G58n5Kgj1bmseMQjsMN6u55XPZE5udpZgvWE/Bj2pdnzyvKDK8J6zwrOkN+NYxrOO0iEU5goRLsgaCQoU2WZ0sPsgeI2VzQ7lMsclDksbThc+I/hZqbomAIKbM79QRnl1uxIzHUabs6o6MNW0wBbLtwvu62iyo8a8WsDW/A7j+nyOBfr5E85QnKALDRpoLK+TKKCpwbszEu1t8PIWEFTq7/1UmLln8I2A8sitpRInFew==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MAZP287MB0073.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 17:17:58 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 17:17:58 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: gendef: add ARM64 stub for $fe in gendef
Thread-Topic: [PATCH] Cygwin: gendef: add ARM64 stub for $fe in gendef
Thread-Index: AdxxC0u9SV6vwdOBQPqAsVyps1crBQ==
Date: Fri, 19 Dec 2025 17:17:58 +0000
Message-ID:
 <MA0P287MB3082D3D7B7FBAE7E1009D6989FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MAZP287MB0073:EE_
x-ms-office365-filtering-correlation-id: c7679d0d-c0c0-465d-5d68-08de3f228e5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|4053099003|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4ASH+9OB1R6AcKjU/gGeosO8dzmZMpg0DaYFYq3RU7dX8Yk+nBQ7xAjySSU3?=
 =?us-ascii?Q?d9luCoLbUtx2sQTyq1IsS1/fn+FSmJSxwwOXVul9OGRcIqJFwRIIWWkoxRy2?=
 =?us-ascii?Q?dN1A+y58XdXPICJyLmiSIOnQPWwENeukw6rSnMoYio/BUs6virbjsB/7A16D?=
 =?us-ascii?Q?wX2BsH1B6wwYEdE7zIqUgB3AB/NrTSEETweoMfr+5oD/XeX6J2xFC30Qjvkf?=
 =?us-ascii?Q?sry8SC7uwwMGOxggIJw37wf1PxMRbKHSTCzkYxnEiUwrdsirOCAobDvgXzP7?=
 =?us-ascii?Q?z8jv7YwKMtR5Ps4k0pkuA30AdwKRn1o+PtiElPmgA1I3YJenLqDP392e/HC/?=
 =?us-ascii?Q?PRUeSBAoaUQIIraEdDCp+F9vyxkfUSTjAfl4tpQdwaekUHmu7/cfPFZK7nsi?=
 =?us-ascii?Q?Z1fstdNKn6qJVqcnmd/DuTKVoiZXSO782HTJN7SEuwvTsZvK2Fy2nl5SRg5+?=
 =?us-ascii?Q?lalFOREV7n2vENMpxkdgLoKQjAym/d7DICtaOxCRRA6Um5R3sTyStwR2i0Ks?=
 =?us-ascii?Q?xkZm+E0Z4W08ffM42YMmmKhYOvHhmOroaJm6Izh8Id/Kj7R4ppJ6MzuM5yYQ?=
 =?us-ascii?Q?6dWSr4jWTwn/bkPvzO6q9cIAqvBYaInRnhkQisM2A5cmqp0ADtDXdLWrWlpI?=
 =?us-ascii?Q?Der/m3C8Q+vbpiRMLuR8fv73WRjSuy56Uy5hRgq7ZYyWHwAl+tC7EqqxTkHb?=
 =?us-ascii?Q?uJQ00qUBaco8t7VTSfs42F8+O99i3FuStOFMgNMuabnN5lq8573g/fXyqciy?=
 =?us-ascii?Q?pNkwsQzivKzNzv7kMuow69TABaMOReQ2nkT0qkU06xdDQ1XVSyVlQuTTwq8S?=
 =?us-ascii?Q?kAXX7P7pfQOhjhTIBNqoVpDtKO5UDUBfdVfc0FP0RcI3xTvDp7eNz9Vct8M+?=
 =?us-ascii?Q?8OyBOi2hjt0y+sCgE+3SG6vn4kSndpjbF5YFn2wNY5/UVkMW+IBVX53ZfmnW?=
 =?us-ascii?Q?z/PtouqEbDBabAH5tX1c2GhGFRu+LbpbUuEgx9YDOubjRUtu6HZT3YmtnW0W?=
 =?us-ascii?Q?Ll/76Rq5ZMfJdlMz+zg3R0BYag8OC1DIvzAMNCGdIt8Q0L3GFOkgfZUm1BgK?=
 =?us-ascii?Q?J+0SBGQIMl2HqqFJOe8Z5yfxKetYgiILCm2PtYyMzyXk0eJmwG1WviSQ/m/t?=
 =?us-ascii?Q?+vaiJ6xKh35iZZb6W1W3LiowJ25N1cVvRiUHxxLhv9vofRLm4HiJHJqxHxvD?=
 =?us-ascii?Q?fRr6YtTU8KH2NWU5rSDmRg/6pKBYFi8HYataHNxMf7wcAsLjhYHIDjWsnD/8?=
 =?us-ascii?Q?TqRK/olcEB3ErIcPBR4c5n/vCxL87ggVJ5fZlG9kl24yjStjNV68w4Z63zO1?=
 =?us-ascii?Q?iYHByErcB4LJbTFa4ZAFB5t2vowhvKTcs7trhNrH3dfeCDm8fD0KpNl1Hu1R?=
 =?us-ascii?Q?B5BrH9oYCnTJcfM/YOLfTxJuEJkcqnN1ngOvVQW7auB+hLtM4NcDcio2Gn9p?=
 =?us-ascii?Q?Tpz4T2gHihwwmdxGy51upFpL2dna+QVDk4VrHDe206fW8CKTHcILm0zBWfnQ?=
 =?us-ascii?Q?Zp1KIUHrMG/E802TRwu6WWoI450/sybIR+JH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(4053099003)(38070700021)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?goQOUVfV0yqHuRSFpfpcArpcsn4uTEF9YdUsPW+Oe8fJ9AnpS+MwNpONXzMx?=
 =?us-ascii?Q?WNIpWYiyHnrKrQCNfZ5UtUswrJ1DvKjFQcMHh1lt3HxHTalmTPBFPyF/DCk3?=
 =?us-ascii?Q?sVHlEzH7dUWWa0jJYw93OiqHZ4+sM/zdVyahi6WXtpjidIHnGn7tD01QjDI0?=
 =?us-ascii?Q?PTIKhZizhojq38Sn1QVVp/BrKoAmEDA7pKCOr4DVcx/C4Koo0DL/jyPwgbnI?=
 =?us-ascii?Q?FdTF9UOZD36Q+UFwWCkwMcEn0fk6uHqiD7LL57VtB+6AZxp8KYISyUMtZ4Yl?=
 =?us-ascii?Q?9VvMYawhjvRDwmB3mROmHZItnJyxQ/HX2VgQHZOK2QV59E1hYZjfp5HRGtRc?=
 =?us-ascii?Q?fdITZpq5mlfU2XzXxBP4CtYHRU5YePxyMhXnfod5YDgkz1PfrCFuCm6cnwaw?=
 =?us-ascii?Q?9YQAKlyh02iM5ppIfk0o37AGLOvDu5QJRZnrh71uQvEcAAj62YT1cfFPZy46?=
 =?us-ascii?Q?VQ0vu7S7zf17ejDL7grgw4jPFHCwzkYmfbd2ljBU205WMLsd16YRXpW+cgAN?=
 =?us-ascii?Q?Kl88O/LKKVCRCqphfOX9iKI+HgRGsNNky8v03QgR+0ezvL8mJw+pS+lwE4Ou?=
 =?us-ascii?Q?McerWlnnraFNRx7aXFSeT6OaPjvrpnwiCil3jVGiWCdvNbzXvGmsCUIWAbii?=
 =?us-ascii?Q?Bx0/2E6fi+LiYsiGIAmRdxrR+bJznRZ46rtR6+xX6mmtS9kh/7Qv+YxRl78G?=
 =?us-ascii?Q?Kd9gWKoAuHNR9OWldWs6otjK9lFkDyzALIJJao6BEoVn/7dRWt3G+dB+eg41?=
 =?us-ascii?Q?giTB/2j7Ths2ncjaRM1y130z8R+PSHfJRycDW4CqVwLPpj5M9YbQ4ShDJVh9?=
 =?us-ascii?Q?16+MeX9OnElhxTYfulprc+zjxhYRqrZCW00gHGmJcgr0qVMN7lEOC+Y0qKKC?=
 =?us-ascii?Q?60H8wsjQU3G00HbZphNov5iz8hWRJqziuM26vta1ISAIQETJKOucltsWGjTr?=
 =?us-ascii?Q?vvCKRkXZGLxJTtU96zo1p8SpbmyOzYr2ovKT+X3eg2GGRYkUReqkVLy2k/Gx?=
 =?us-ascii?Q?RNx0Gat5fzyiYaHsHoDwdfz7Fd9PrpEJsRtUvvMKtFbBmq7g96R3n8mJ23Op?=
 =?us-ascii?Q?WvUT61f6CCJpz2M6e6nEED04CdWBL7ycCGsSi8TiYyPX3rpdVCdk6DdRYEuS?=
 =?us-ascii?Q?TO2+QlYlM5eVgum4L5HuGMtIx0KfSTS6jB7y5SWyQjo4LMD2123i0BA6sH9J?=
 =?us-ascii?Q?Ux9Bl+YeXc69lwPN15ijuMd8MWSQrbUP1Moz094atRvcnE6Hf63F8N0DkLrQ?=
 =?us-ascii?Q?0CbC98/vg6MM08V7KTLQtZFISqp+2m1uyBLj+TMMiY9r4uoQTIfZgUBmd3u5?=
 =?us-ascii?Q?H0NnmBoRwCDYYdLLz+1UvxQ3wQhsagry52KRoD2unYnTIRThTwJlaemcGOFt?=
 =?us-ascii?Q?WZNcvcWt1a2oRBDYY2dMmKxdWazGEcn/1Z8RI6QkY0NqG9lGvn9WvB2lq5aN?=
 =?us-ascii?Q?CPJixcOO7wAhTPGUMDm+9HKr42wO99RnHu8gzNQ0Iys4U0RWXcCZ8PqkuoNW?=
 =?us-ascii?Q?LLu8wMSieSF0upklvpTAs57yeqPejN5sYzFBLb25rNuOxGhdP+rhMXHffpNM?=
 =?us-ascii?Q?6bKXcWsOqVRxQyt2zSdR+dgyHbAvWVkiOdUrxpl7Hxh5hj0j5F/IwiqVw1U3?=
 =?us-ascii?Q?zTgFQSeixCZU2p8CBeF18AwFhbeefwj2GoDLa/5F3Cif4h/UJBV2YxisKKmQ?=
 =?us-ascii?Q?x/UVUA0evFg54O+8mGr8yxw+AZ+xJaWj6ovjsqfiK1KdEW4Wt4dVDs9+hlY8?=
 =?us-ascii?Q?y9UtGbFrDCqR5kdA1EDj2R38IEemTxSZfYeaJAxklptUmLt36tJsbd/LVc1/?=
x-ms-exchange-antispam-messagedata-1:
 K0Iaq18wRAgnuY3jexagIs+YcaYLJeqikg9nwwNgf+F0Bu7Da4c15IkC
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082D3D7B7FBAE7E1009D6989FA9AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7679d0d-c0c0-465d-5d68-08de3f228e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 17:17:58.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbg4Zk/IWg+W0H/Y2LVblnf2CErsDS4mwFZTMwOTHwyHp6wsks3hUaDjjB7HUNuNUnWBs0FgbOabxBp9NdTqdKTROA96SBiqws2h6ocCDAL2Ami1Pb3HQdvl6BnvpCMVRFSyfSuMR2p82Y6HlQEwYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0073
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082D3D7B7FBAE7E1009D6989FA9AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082D3D7B7FBAE7E1009D6989FA9AMA0P287MB3082INDP_"

--_000_MA0P287MB3082D3D7B7FBAE7E1009D6989FA9AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Please find the attached patch which adds an ARM64 stub for the $fe routine=
 in
the gendef script.

Any feedback or nits are very welcome. The changes are documented with inli=
ne
comments and is intended to be self-explanatory. please let me know if any =
part
of this patch should be adjusted.

Thanks for your time and review.

Thanks & regards
Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>

In-lined patch:

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index a4226be62..1419704b8 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -115,7 +115,18 @@ EOF
        $res =3D <<EOF;
        .extern $func
        .global $fe
+       .seh_proc $fe
 $fe:
+       sub sp, sp, 16                  // allocate stack, 16-byte alligned
+       .seh_stackalloc 16              // SEH: describe stack allocation
+       .seh_endprologue                // end of prologue for unwinder
+       adrp x9, $func                  // load page address of func
+       add x9, x9, :lo12:$func         // compute full address of func
+       str x9, [sp, 0]                 // store func pointer on stack
+       adrp x9, $sigfe_func            // load page address of sigfe_func
+       add x9, x9, :lo12:$sigfe_func   // compute final address of sigfe_f=
unc
+       br x9                           // branch to x9
+       .seh_endproc
 EOF
     }



--_000_MA0P287MB3082D3D7B7FBAE7E1009D6989FA9AMA0P287MB3082INDP_--

--_004_MA0P287MB3082D3D7B7FBAE7E1009D6989FA9AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-gendef-add-ARM64-stub-for-fe-in-gendef.patch"
Content-Description: 0001-Cygwin-gendef-add-ARM64-stub-for-fe-in-gendef.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-gendef-add-ARM64-stub-for-fe-in-gendef.patch";
	size=1376; creation-date="Fri, 19 Dec 2025 17:16:23 GMT";
	modification-date="Fri, 19 Dec 2025 17:17:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkMzQwMzhhZmY2MTNkOGFiZjNjMThiZTEwMTMzMGI3ZTkwM2E5NjI2
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogRnJpLCAxOSBEZWMgMjAyNSAxODoxNTozNCArMDUz
MApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogZ2VuZGVmOiBhZGQgQVJNNjQg
c3R1YiBmb3IgJGZlIGluIGdlbmRlZgoKVGhpcyBwYXRjaCBhZGRzIEFSTTY0
IHN0dWIgd2l0aCBzdGFjayBhbGxvY2F0aW9uIGFuZCBTRUggdW53aW5kCmRp
cmVjdGl2ZXMgaW4gZ2VuZGVmIGZvciAkZmUgcm91dGluZS4KClNpZ25lZC1v
ZmYtYnk6IEV2Z2VueSBLYXJwb3YgPEV2Z2VueS5LYXJwb3ZAbWljcm9zb2Z0
LmNvbT4KU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0
aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0t
LQogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiB8IDExICsrKysrKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYgYi93aW5zdXAv
Y3lnd2luL3NjcmlwdHMvZ2VuZGVmCmluZGV4IGE0MjI2YmU2Mi4uMTQxOTcw
NGI4IDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVm
CisrKyBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKQEAgLTExNSw3
ICsxMTUsMTggQEAgRU9GCiAJJHJlcyA9IDw8RU9GOwogCS5leHRlcm4gJGZ1
bmMKIAkuZ2xvYmFsICRmZQorCS5zZWhfcHJvYyAkZmUKICRmZToKKwlzdWIg
c3AsIHNwLCAxNgkJCS8vIGFsbG9jYXRlIHN0YWNrLCAxNi1ieXRlIGFsbGln
bmVkCisJLnNlaF9zdGFja2FsbG9jIDE2CQkvLyBTRUg6IGRlc2NyaWJlIHN0
YWNrIGFsbG9jYXRpb24KKwkuc2VoX2VuZHByb2xvZ3VlCQkvLyBlbmQgb2Yg
cHJvbG9ndWUgZm9yIHVud2luZGVyCisJYWRycCB4OSwgJGZ1bmMJCQkvLyBs
b2FkIHBhZ2UgYWRkcmVzcyBvZiBmdW5jCisJYWRkIHg5LCB4OSwgOmxvMTI6
JGZ1bmMJCS8vIGNvbXB1dGUgZnVsbCBhZGRyZXNzIG9mIGZ1bmMKKwlzdHIg
eDksIFtzcCwgMF0JCQkvLyBzdG9yZSBmdW5jIHBvaW50ZXIgb24gc3RhY2sK
KwlhZHJwIHg5LCAkc2lnZmVfZnVuYwkJLy8gbG9hZCBwYWdlIGFkZHJlc3Mg
b2Ygc2lnZmVfZnVuYworCWFkZCB4OSwgeDksIDpsbzEyOiRzaWdmZV9mdW5j
CS8vIGNvbXB1dGUgZmluYWwgYWRkcmVzcyBvZiBzaWdmZV9mdW5jCisJYnIg
eDkJCQkJLy8gYnJhbmNoIHRvIHg5CisJLnNlaF9lbmRwcm9jCiBFT0YKICAg
ICB9CgotLQoyLjUyLjAud2luZG93cy4xCgo=

--_004_MA0P287MB3082D3D7B7FBAE7E1009D6989FA9AMA0P287MB3082INDP_--

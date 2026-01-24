Return-Path: <SRS0=acxd=75=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id B18694BA23D2
	for <cygwin-patches@cygwin.com>; Sat, 24 Jan 2026 18:51:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B18694BA23D2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B18694BA23D2
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1769280673; cv=pass;
	b=AyRymPZ36VV59qbvIhDNewZowScHmFNuvnNUz/04su23LOH81pi/RuLHHZzuC0dVxV2n8gHrvDMTANiApDnWhLRdBEzMyNHhLZOfKJ+H5BtNnHYJgxYBvNWGQJtH8yFaRthwsF82yLlVj1i4JAvKoWWsAdaZXba2NDP8o49lzAE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1769280673; c=relaxed/simple;
	bh=j4PtotFpwvvyyyEoL6vQPThRR5152yWMAyZGauiUJe0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=RIZDtRgl//N9o4qZ3ob/d+NJUSrudj+LbYAz1MdHCpNTVjV/08VJOgWO/k8w8A/pX8ZmpaByp6FOqvK2G+Bgc0O9mDK5kYh3hY5AyhpNNhayHaPtpnTTlg1iWoIduuFLZ8Qldi/oF1q2ZPdULmXxjhTwZLWDvW6z/Xwq8FdDOps=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B18694BA23D2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=kEjj2P2u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwYg2LAmUam1PY8+TyZW+POGKJ2/I35HUk5OI+rA7j0OPdj0hpWJt/ao4jzGHJjoehyGLYL61r67qWeDlNqzzOxzeVI2lZKsB++OvHyiUmSYVtoaAX+Nh+eucOcMH0bmmeYBTR7gtAL5gdU7vXCoOewZeAqoTg4djwNX60noPSNq7hcVSpzUUSOxSFuqc8cbl4yc1kdjmiKC4ROQYaiiVkl7CadRzkgIVvH5LeRy4eELXxXqcOcjeXVzjqzUk6HI0rN6OMigeU2q5MKV4Tm+PQUZl0bhWLXoe2rbsYc4UqQ+06o2bjqQjRXEC8+NcKibay/tyjVBddlg3LLhLNb27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHxKzfKYhlojQkGOwREa9B0eMwNslBypmnX+gOISRF0=;
 b=TpbqdlbNdPMgOd0fqtPbfX+00iRDRbrq/GHg9JBFiIYHxIYkDmhGbrF42xEZGBTG0aaQOYDzhZUcbkmHhwHd/aA6VCjqn4fj6+ivG/kJ4Le3hUnlodoP6Lkdk6fMv1YSfIgyElBYwNNCP/4htPDf2hIVGGwkOPztB50UZfQzwaQsWu+1NuN42DQ+iyp0JyY62Xtt8QJt50QnLiOeD6RAwu3oehq1m51u106GF8HpoJKU79AyV+n6Z0gEVnGphRjPYdMGXWJP+d1XVxRbYDiosu98SxlvAK4YgtjCbWQN2Osmz1eGnAWghwAi71iI7QdFT/2Zp/PJ12MvZA6hqsPcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHxKzfKYhlojQkGOwREa9B0eMwNslBypmnX+gOISRF0=;
 b=kEjj2P2uRI+VC2sHRuA2WYGgtdCbOx/FhHQE210RFyM3dp55Vgt3KDijUtthtoJO8qGyCG9UCk7/IdUHAS6J9vhqSPrD5gLcw/jowef9eiHqT4XTjv/oW7XhkPvOkT5ncxoFgsjSUOYK79Zl8D7SZKmDFXI3iw0b6X8YeadkhzsgYXG87LQCmF8Ptf8Sa/OuXC9unqTiDG0oBJgNoaA8m02SZGIf70DCFqDMojriByxDWeCtjyyl8vZjXYyveTgVnvTICzArHXYYgSk2sYTxOAIKXFJDUB8qLLmvigo2JsRMRbhBcyfBuIFwQo/vV2VP5W1PoKm2pktolwgQNLbF4w==
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:226::14)
 by PN2P287MB1454.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.5; Sat, 24 Jan
 2026 18:51:09 +0000
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3]) by PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3%6]) with mapi id 15.20.9564.001; Sat, 24 Jan 2026
 18:51:09 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "Igor.Podgainoi@arm.com" <Igor.Podgainoi@arm.com>
Subject: [PATCH] Cygwin: gendef: Implement setjmp for AArch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement setjmp for AArch64
Thread-Index: AdyNYfXzykS8eA0ER3OTVNVTeBRp7g==
Date: Sat, 24 Jan 2026 18:51:09 +0000
Message-ID:
 <PN3P287MB30778F0B844CF83434426EDC9F95A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB3077:EE_|PN2P287MB1454:EE_
x-ms-office365-filtering-correlation-id: 7f039b9b-b47c-4567-8dfb-08de5b7989d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|8096899003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?Hn1TgBVbnbCETgjuPBxsf8Z/0vYYt4wlnoopCJc3a4YXXweXqAd/BRoMti?=
 =?iso-8859-2?Q?FZhWvTUgyWd+tpaEEJpn11lZoa9ZWn9eyXSBlTQ0LXKeh7vIdEXbSTrMA9?=
 =?iso-8859-2?Q?udazx6qYJkJKFQaz/tKhzofH8E4LL9HXEGw/LqhUQbK26lY+pBbhh4PUFU?=
 =?iso-8859-2?Q?/S2P4T2WBRSRagktqKO6lZvXpzp0vDY59XZ+PQfRu/+2hZXiVvmo7I6+4m?=
 =?iso-8859-2?Q?tH+l3NfDou9Q7+hENApWpnaaIbvcsyy68uhwUgKb5feCKQ4ZRS7q//SXPr?=
 =?iso-8859-2?Q?VfiC/f8FYnY7p1CHWTXMqcLbvIVr2xQF1oLJu9PGjv+6+plOwk44T88xvZ?=
 =?iso-8859-2?Q?d4tpvlyyL676YCIuz+JJJXIsWfxcuu6/tpdRGNHpRscQuQvT1r7zsd5aW/?=
 =?iso-8859-2?Q?Ei6iGWCjfwM/6SLTCdI3hfLjkqlnv8wx++ptQRx4Bj3d+2VjIIRDM5RuUp?=
 =?iso-8859-2?Q?LgdqHo35XT0gcCExUbXQPOMB+pJUyuYEcMA+vjWBuTieqqpm1Yrud52Frc?=
 =?iso-8859-2?Q?cVR9LxarDo7l/dTyX8UBpuFp1ixy738ZYsLwPJspYMihkIaVZ4qJdS63NV?=
 =?iso-8859-2?Q?9kDXukNjP490IrwCZlS9o3cdeZhFviih6yp6qeH/YR4fYTjI+KnuGEX2Ac?=
 =?iso-8859-2?Q?ziVeVNSe/40SB22NtUyqyFxBr8IF5m77CBIHdYwxa/OBTfhZhny7uzdlPm?=
 =?iso-8859-2?Q?jEdSTr1TEz1haCA84dmE1SZZETnUXB8SdrnrVvz+phSiPxT875bu1A1jCv?=
 =?iso-8859-2?Q?0bm6yrioSduCqDYldku/D/TgYTKpo9tRoxYXO7JKDTbR22C0cPXtYCeW3A?=
 =?iso-8859-2?Q?/5t9KMvdg/E6V0JnxIcimbNawT+XrwZ2XymSxNeJ96SVy0noyyqNuaKM7N?=
 =?iso-8859-2?Q?+vBp1RZu2HCfiOpi5PHoBUD3Y17gobTE7kBATC9BUpzqQTmiPEfnGyCxlC?=
 =?iso-8859-2?Q?l1qCQy3VZyHOfcTD6qzYgoujuwmEvSc9x4G66BbEp60DAH4c6sSTel7RmY?=
 =?iso-8859-2?Q?zCQg0AjW2zKkptpPSKb5LHu/qcBrS+vofQOWx7ocVvPHv8Y74Pmdy0YTzR?=
 =?iso-8859-2?Q?XB3FGdnPbyBpXGRsFsXX+LYHXRiw04FRpQZzmaVfdMVWoYmAbqE60ZMljH?=
 =?iso-8859-2?Q?ZMmMVUtp047Se4gkSoUzRIVKiB0Gf4QglQNxr4VwvVBMw5UUsFyaSYn/AV?=
 =?iso-8859-2?Q?if25MC1vYoVJUJq+A9suOUxl+xeXr4hg43R1TQ9+5zycdhYHn6MDWIJnUQ?=
 =?iso-8859-2?Q?JJBT72Mn5FfyxVylgGWVfbAukkPyZz8O8eCKT6opWEddT5DaGijTqz+JgP?=
 =?iso-8859-2?Q?XtD8M+ozUFnYLgyrHobUfF4hdorOofzKWqB4mZUX6QeFv8BPnyWdP4soTk?=
 =?iso-8859-2?Q?Lg41ari4auA1EMP2QzxO2RRnne2wa7FtrogQJAEUNZfSuDFFXpJEw851XK?=
 =?iso-8859-2?Q?t8PO0uTp8sjVD+djz6hOvE5KWQ7aa5AylpvvG/aeY608nFw7jLTQRmZ/AY?=
 =?iso-8859-2?Q?p4+5W5I3jNoC16fq47F8eF2Eg0or69QZWvux5E6fWE4MIvUgqkXHvF4kqV?=
 =?iso-8859-2?Q?7ZKjW4KJC0DB2nUHAwl+/DJyDhCCoi2reN1z+oaUBkcbETRD9Z1/3ToGGE?=
 =?iso-8859-2?Q?TAH9PJdXCzc8udla2QEK/yb775aTgdqhT4laIJTy3L4n2IvzsuYu8aEf47?=
 =?iso-8859-2?Q?VcOHifRXNDgmpdQtVqs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB3077.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(8096899003)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?vSAu6HF4gTvzg7CcspLS2ruxq7+QsR+9IJE7qiKg7rzK46gHyQCFa2GsFs?=
 =?iso-8859-2?Q?8hqlWf+2dEIZcTTjZgbZsk0FFY+RWzYQkSpnxSx9m2mL1vkiPFQp7XLVoq?=
 =?iso-8859-2?Q?uLzK3woRZj0L2m7QlEmyvqde6O4LMSW8FVeny+pBlr7S6Htn3BWmfWuesp?=
 =?iso-8859-2?Q?+O5O4hNAt52MdCSN1ozPBu58jQQ0QGyAvT0Q4Y+rRVG8qjV6Ys2q/Y8u0u?=
 =?iso-8859-2?Q?r4E+IYcI5j7Lf0OxeyxP/c05CSalabHKPFoXbvXiVJ2GYMmEM+bj38ahMC?=
 =?iso-8859-2?Q?YlXVManB+3Caeupoon1C/6fQorVJES7uFuaMwAVjSl1LcVThx1Dy81lgC6?=
 =?iso-8859-2?Q?mmaE+Pii0MRQdmp3eIsManbX7koGlzqFn5vtSrkcFXmG+YgskpRxbiidi5?=
 =?iso-8859-2?Q?dj4eJrofz2Hh9JA0si0ApQTKZ897P4DBXlnhJX951xYCp/NWLKCpIOxI7M?=
 =?iso-8859-2?Q?OL07uw1LLOspTfUgj0t/O5PRAz5hhC+fD9xCiEcez7CVQYfBsQntqUdmNa?=
 =?iso-8859-2?Q?VBOh6Q6QpWW9ikfsmrlEcAdPqiKzVb2hv2a1LXkeLNwbJr7VDiUYL0xzBe?=
 =?iso-8859-2?Q?oMWwTd632rplbVtlhf2IyZCZI/KeEqt/eWCqHqOMNquzpKtEe1GHDu+dpN?=
 =?iso-8859-2?Q?Hza2qhYDdrJdMmLNSSYzZ0gZSfVCyPlrOFCU4nSBGKUm/s8jqEdYydlrL9?=
 =?iso-8859-2?Q?Lx7bZLNzaE7lJrVHlRxBmehlPbozRqYOtAotH6vLmZOPQ1HMdrpWXIerfC?=
 =?iso-8859-2?Q?/2TxMGUNaAcx+HNxRuigbRdP3CxpSz7ijd965IGUmRXBVCy6PrKsdSTy3Z?=
 =?iso-8859-2?Q?FgzNLcyoH5BNMF8OOAvOqJA+xyFcz67fEF8NhDv1VGp09Y6wMGtuMlKoqO?=
 =?iso-8859-2?Q?/ywvek/WKv/VwwHTAf5p+Of6MtuvAH9suHh6bCzensUuQYFtou0SeZtZEn?=
 =?iso-8859-2?Q?NQtr2KpqKR+gfGZhmuPqT4uGVKOrKJEl4EwYf9T328KVYxVaAXsvwZwUTM?=
 =?iso-8859-2?Q?mxtT7pV4XCGdlHrZi3DEd4SC6H+BMI9qTzdrf+t44kI6UodSljroBtw3pF?=
 =?iso-8859-2?Q?SGmo4M6thjhjyQOfQhgoPghItCFd7i8CgC80RcXQxLzhr3QXCpBS9ll3W4?=
 =?iso-8859-2?Q?SbsnFvOj1DXLi9us5PbHqz9Kiue2+Tz6tebQTyPI8GEx+Ctpd+Wvsu/Tcr?=
 =?iso-8859-2?Q?oCYucHV4mAWbIEtL1GnuE7tT9oTpZOHMoSzXb40uuuLG1c1dz49x8zx0OR?=
 =?iso-8859-2?Q?/kDezTELPru4ifb9BoJVipK80Z42mQ5GGRR80llvvTmVf1DiAwN56HlfnU?=
 =?iso-8859-2?Q?VMYvsEaewcuvkYWVE9Y9hD/fDJSVXOM97+Zc5S3z57fsPMtdD5ypm2VdHa?=
 =?iso-8859-2?Q?+1v5VQj7BBg0Hs/OIg74zZDzdTAsWsdCC+QAoOineI74tlv9RecVKI6DyR?=
 =?iso-8859-2?Q?Di7lo+dgjvEWHbtYAg6lniyjgXDEfI0xwXRLPnVda26OTvX+h6jQFCJn7Y?=
 =?iso-8859-2?Q?XNgQudFfWGBP+5ewSGTZ8GQW2OXfHf/tl67Fx5Tom9rn9yPTqK588Cmsbo?=
 =?iso-8859-2?Q?gPVzxJfQ1T8rwuiUybNSFIxgjztiIlr7Pxfrx61AV75GW79l88VEV6tkEE?=
 =?iso-8859-2?Q?4SlkOu3W5tbAiJwMlYV/mN0G+14paydEZFezSWIPJXYbmenAmodKUmmtTG?=
 =?iso-8859-2?Q?D/yhz+iLTxY+FE70vFTQLiTxpco3Kr1AQyU39vGvYAxuK09bmxmwWYnofe?=
 =?iso-8859-2?Q?LYvPlA5YmSTPOlv/BMfjG5l4oKeUaSL+XzSQ+lxUS7W2ALi+QnjQmoQRqj?=
 =?iso-8859-2?Q?pGMj48WJQHnrbjq4BO4APp5Wn63cjuQr0XrHO/S03sN3Cc+pkI7cGqobXY?=
 =?iso-8859-2?Q?eu?=
x-ms-exchange-antispam-messagedata-1:
 i/IIqiQFmFX/TPPnrwHr/uDsyKatDh7tCeuGyPia7hyRR+fgZjLJXdx1
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB30778F0B844CF83434426EDC9F95APN3P287MB3077INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f039b9b-b47c-4567-8dfb-08de5b7989d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2026 18:51:09.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42EAlJVcLppBruVoSYj2GZ9Z7Xfxua9+qKBdEGiWGtc1rjagORMHj2KrXWxiO/VrS0Z4bQj9C4hMJhG1gnVQyXnO2nn30rGzs/D8WcscqHx/HPjfd8KVB6CPkoKSFcvQzHUTymPIR/bkE8wYXZsLiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1454
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,POISEN_SPAM_PILL,POISEN_SPAM_PILL_2,POISEN_SPAM_PILL_4,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB30778F0B844CF83434426EDC9F95APN3P287MB3077INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB30778F0B844CF83434426EDC9F95APN3P287MB3077INDP_"

--_000_PN3P287MB30778F0B844CF83434426EDC9F95APN3P287MB3077INDP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch is not for review and a V2 is upcoming.

The current version contains a few known issues that have already been
fixed by Igor Podgainoi <Igor.Podgainoi@arm.com<mailto:Igor.Podgainoi@arm.c=
om>>.  Those fixes will be
contributed directly by Igor by a V2 patch, which will be posted to this sa=
me thread.

Notes:
Attached is a patch that adds an ARM64 stub for the `setjmp` routine
in the gendef script. The changes are documented with inline comments and
should be self-explanatory.
I would also like to thank Radek Barto=F2 <radek.barton@microsoft.com<mailt=
o:radek.barton@microsoft.com>> for his
initial contributions to this effort.

Thanks & regards
Thirumalai Nagalingam
<thirumalai.nagalingam@multicorewareinc.com<mailto:thirumalai.nagalingam@mu=
lticorewareinc.com>>

In-lined patch:

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 0b2d3db9b..5ad7fd947 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -706,7 +706,62 @@ sigsetjmp:
        .seh_endproc

        .globl  setjmp
+       .seh_proc setjmp
 setjmp:
+       // prologue
+       stp     fp, lr, [sp, #-0x10]!           // push frame pointer (x29)=
 and link register (x30)
+       mov     fp, sp                          // set frame pointer
+       .seh_endprologue
+
+       // save callee-saved registers from jump buffer
+       stp     x19, x20, [x0, #0x08]           // save x19, x20
+       stp     x21, x22, [x0, #0x18]           // save x21, x22
+       stp     x23, x24, [x0, #0x28]           // save x23, x24
+       stp     x25, x26, [x0, #0x38]           // save x25, x26
+       stp     x27, x28, [x0, #0x48]           // save x27, x28
+       stp     x29, x30, [x0, #0x58]           // save frame ptr (x29) and=
 return addr (x30)
+
+       mov     x1, sp                          // get the current stack po=
inter
+       str     x1, [x0, #0x68]                 // save SP
+
+       mrs     x1, fpcr                        // get fp control register
+       str     x1, [x0, #0x70]                 // save FPCR
+       mrs     x1, fpsr                        // get fp status register
+       str     x1, [x0, #0x78]                 // save FPSR
+
+       // save fp registers (d8-d15)
+       stp     d8,  d9,  [x0, #0x80]           // save d8, d9
+       stp     d10, d11, [x0, #0x90]           // save d10, d11
+       stp     d12, d13, [x0, #0xA0]           // save d12, d13
+       stp     d14, d15, [x0, #0xB0]           // save d14, d15
+
+       mov x9, x0                              // save jmp_buf pointer in =
x9
+       # // save TLS stack pointer
+       # ldr   x1, [sp]
+       # str   x1, [x0, #0xB8]
+
+       bl      stabilize_sig_stack             // call stabilize_sig_stack=
 (returns TLS in x0)
+
+       // store the stack pointer to jump_buf
+       ldr     x2, =3D_cygtls.stackptr           // load the symbol addres=
s/offset
+       add     x2, x0, x2                      // Final address of stackptr
+       ldr     x3, [x2]                        // load current value of st=
ackptr
+       str x3, [x0, #0xB8]                     // store stackptr into jmp_=
buf
+
+       // decrement the stack lock
+       ldr     x2, =3D_cygtls.stacklock          // load the symbol addres=
s/offset
+       add     x2, x0, x2                      // Final address of stacklo=
ck
+       ldr     w3, [x2]                        // load current stacklock v=
alue
+       sub     w3, w3, #1                      // decrement
+       str     w3, [x2]                        //store back
+
+       mov     w0, #0                          // return 0
+
+       // epilogue
+       ldp     fp, lr, [sp], #0x10             // restore saved FP and LR =
registers
+       ret
+       .seh_endproc
+
        .globl  siglongjmp
        .seh_proc siglongjmp
 siglongjmp:


--_000_PN3P287MB30778F0B844CF83434426EDC9F95APN3P287MB3077INDP_--

--_004_PN3P287MB30778F0B844CF83434426EDC9F95APN3P287MB3077INDP_
Content-Type: application/octet-stream;
	name="Cygwin-gendef-Implement-setjmp-for-AArch64.patch"
Content-Description: Cygwin-gendef-Implement-setjmp-for-AArch64.patch
Content-Disposition: attachment;
	filename="Cygwin-gendef-Implement-setjmp-for-AArch64.patch"; size=2926;
	creation-date="Sat, 24 Jan 2026 18:49:56 GMT";
	modification-date="Sat, 24 Jan 2026 18:51:09 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkMmI1NjE2ZGVmZTcwZmNhZGIzZDllNGI4MWQ0NDFjNGZiYjEwNWQw
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE4OjEzOjI4ICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW5kZWY6IEltcGxlbWVudCBz
ZXRqbXAgZm9yIEFBcmNoNjQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1U
eXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDhiaXQKCkF1dGhvcjogUmFkZWsgQmFydG/FiCA8cmFk
ZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+CkNvLWF1dGhvcmVkLWJ5OiBUaGly
dW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0
aWNvcmV3YXJlaW5jLmNvbT4KClNpZ25lZC1vZmYtYnk6IFRoaXJ1bWFsYWkg
TmFnYWxpbmdhbSA8dGhpcnVtYWxhaS5uYWdhbGluZ2FtQG11bHRpY29yZXdh
cmVpbmMuY29tPgotLS0KIHdpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYg
fCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiBiL3dpbnN1cC9jeWd3aW4v
c2NyaXB0cy9nZW5kZWYKaW5kZXggMGIyZDNkYjliLi41YWQ3ZmQ5NDcgMTAw
NzU1Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKKysrIGIv
d2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZgpAQCAtNzA2LDcgKzcwNiw2
MiBAQCBzaWdzZXRqbXA6CiAJLnNlaF9lbmRwcm9jCgogCS5nbG9ibCAgc2V0
am1wCisJLnNlaF9wcm9jIHNldGptcAogc2V0am1wOgorCS8vIHByb2xvZ3Vl
CisJc3RwCWZwLCBsciwgW3NwLCAjLTB4MTBdISAgICAgIAkvLyBwdXNoIGZy
YW1lIHBvaW50ZXIgKHgyOSkgYW5kIGxpbmsgcmVnaXN0ZXIgKHgzMCkKKwlt
b3YJZnAsIHNwICAgICAgICAgICAgICAgICAgICAgIAkvLyBzZXQgZnJhbWUg
cG9pbnRlcgorCS5zZWhfZW5kcHJvbG9ndWUKKworCS8vIHNhdmUgY2FsbGVl
LXNhdmVkIHJlZ2lzdGVycyBmcm9tIGp1bXAgYnVmZmVyCisJc3RwCXgxOSwg
eDIwLCBbeDAsICMweDA4XSAgICAgICAJLy8gc2F2ZSB4MTksIHgyMAorCXN0
cAl4MjEsIHgyMiwgW3gwLCAjMHgxOF0gICAgICAgCS8vIHNhdmUgeDIxLCB4
MjIKKwlzdHAJeDIzLCB4MjQsIFt4MCwgIzB4MjhdICAgICAgIAkvLyBzYXZl
IHgyMywgeDI0CisJc3RwCXgyNSwgeDI2LCBbeDAsICMweDM4XSAgICAgICAJ
Ly8gc2F2ZSB4MjUsIHgyNgorCXN0cAl4MjcsIHgyOCwgW3gwLCAjMHg0OF0g
ICAgICAgCS8vIHNhdmUgeDI3LCB4MjgKKwlzdHAJeDI5LCB4MzAsIFt4MCwg
IzB4NThdICAgICAgIAkvLyBzYXZlIGZyYW1lIHB0ciAoeDI5KSBhbmQgcmV0
dXJuIGFkZHIgKHgzMCkKKworCW1vdgl4MSwgc3AJCQkJLy8gZ2V0IHRoZSBj
dXJyZW50IHN0YWNrIHBvaW50ZXIKKwlzdHIJeDEsIFt4MCwgIzB4NjhdCQkJ
Ly8gc2F2ZSBTUAorCisJbXJzCXgxLCBmcGNyCQkJLy8gZ2V0IGZwIGNvbnRy
b2wgcmVnaXN0ZXIKKwlzdHIJeDEsIFt4MCwgIzB4NzBdCQkJLy8gc2F2ZSBG
UENSCisJbXJzCXgxLCBmcHNyCQkJLy8gZ2V0IGZwIHN0YXR1cyByZWdpc3Rl
cgorCXN0cgl4MSwgW3gwLCAjMHg3OF0JCQkvLyBzYXZlIEZQU1IKKworCS8v
IHNhdmUgZnAgcmVnaXN0ZXJzIChkOC1kMTUpCisJc3RwCWQ4LCAgZDksICBb
eDAsICMweDgwXSAgICAgICAgCS8vIHNhdmUgZDgsIGQ5CisJc3RwCWQxMCwg
ZDExLCBbeDAsICMweDkwXSAgICAgICAgCS8vIHNhdmUgZDEwLCBkMTEKKwlz
dHAJZDEyLCBkMTMsIFt4MCwgIzB4QTBdICAgICAgICAJLy8gc2F2ZSBkMTIs
IGQxMworCXN0cAlkMTQsIGQxNSwgW3gwLCAjMHhCMF0gICAgICAgIAkvLyBz
YXZlIGQxNCwgZDE1CisKKwltb3YgeDksIHgwIAkJCQkvLyBzYXZlIGptcF9i
dWYgcG9pbnRlciBpbiB4OQorCSMgLy8gc2F2ZSBUTFMgc3RhY2sgcG9pbnRl
cgorCSMgbGRyCXgxLCBbc3BdCisJIyBzdHIJeDEsIFt4MCwgIzB4QjhdCisK
KwlibAlzdGFiaWxpemVfc2lnX3N0YWNrCQkvLyBjYWxsIHN0YWJpbGl6ZV9z
aWdfc3RhY2sgKHJldHVybnMgVExTIGluIHgwKQorCisJLy8gc3RvcmUgdGhl
IHN0YWNrIHBvaW50ZXIgdG8ganVtcF9idWYKKwlsZHIJeDIsID1fY3lndGxz
LnN0YWNrcHRyCQkvLyBsb2FkIHRoZSBzeW1ib2wgYWRkcmVzcy9vZmZzZXQK
KwlhZGQJeDIsIHgwLCB4MgkJCS8vIEZpbmFsIGFkZHJlc3Mgb2Ygc3RhY2tw
dHIKKwlsZHIJeDMsIFt4Ml0JCQkvLyBsb2FkIGN1cnJlbnQgdmFsdWUgb2Yg
c3RhY2twdHIKKwlzdHIgeDMsIFt4MCwgIzB4QjhdICAgICAgICAgICAJCS8v
IHN0b3JlIHN0YWNrcHRyIGludG8gam1wX2J1ZgorCisJLy8gZGVjcmVtZW50
IHRoZSBzdGFjayBsb2NrCisJbGRyCXgyLCA9X2N5Z3Rscy5zdGFja2xvY2sg
CQkvLyBsb2FkIHRoZSBzeW1ib2wgYWRkcmVzcy9vZmZzZXQKKwlhZGQJeDIs
IHgwLCB4MgkJCS8vIEZpbmFsIGFkZHJlc3Mgb2Ygc3RhY2tsb2NrCisJbGRy
CXczLCBbeDJdCQkJLy8gbG9hZCBjdXJyZW50IHN0YWNrbG9jayB2YWx1ZQor
CXN1Ygl3MywgdzMsICMxCQkJLy8gZGVjcmVtZW50CisJc3RyCXczLCBbeDJd
CQkJLy9zdG9yZSBiYWNrCisKKwltb3YJdzAsICMwCQkJCS8vIHJldHVybiAw
CisKKwkvLyBlcGlsb2d1ZQorCWxkcAlmcCwgbHIsIFtzcF0sICMweDEwCQkv
LyByZXN0b3JlIHNhdmVkIEZQIGFuZCBMUiByZWdpc3RlcnMKKwlyZXQKKwku
c2VoX2VuZHByb2MKKwogCS5nbG9ibAlzaWdsb25nam1wCiAJLnNlaF9wcm9j
IHNpZ2xvbmdqbXAKIHNpZ2xvbmdqbXA6Ci0tCjIuNTIuMC53aW5kb3dzLjEK
Cg==

--_004_PN3P287MB30778F0B844CF83434426EDC9F95APN3P287MB3077INDP_--

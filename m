Return-Path: <SRS0=I/99=A4=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 4FAC54BA23E6
	for <cygwin-patches@cygwin.com>; Tue, 24 Feb 2026 08:38:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4FAC54BA23E6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4FAC54BA23E6
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1771922295; cv=pass;
	b=QbrNcy6w6GZdKpXOMjTdR6oX5S0DHpLn1Bkt37Z8ikK+0lJwQY9ls+X0tkIYWB3h9xfE1cNGN1w4PwuC0dBJEwxsP+d1J6GP+qHMhFPZ1lT7xJhhNq85IMeU5at2PUKE7n5iDWTrsaMAHnOTZZMrgc9tSyPZiCIa0pPdxCPo13Y=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771922295; c=relaxed/simple;
	bh=6vr4mODun/iRKysU/s13GFuqBg1Ccz7kweUVWCJz0/o=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=v/rbGsWAmamOymx7gG4g0fAVi087vgicF/4MX6lCQfGd7zwONGMMkMhP/Xl9QIRmySUxEEMwI7FEDO0QvXmoPaATAkVeQfpv9JRYkp5pqmomVx8y45WUu7nezRehmLBz3zzqNryaiA9/KNAbu1Dhgq7dgglzkzRDiU9SKmexYuE=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4FAC54BA23E6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=j3jAQ6qc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CA9K6KuISdmtTwleSeJVcVJizY9oIoTr2P6JHCekdPiCbVWmC1aa/dsT5pw9k01sPQ+KksK6/GirU9x+IxpJDLIqr6+9YAwIj7MfJNNejyqj/nqm6aDRdN+29Gbp4ZbK+QirC1hEDFZ3Guhv9cgzuN9vQATjaD5/4OhQsEO9i0fNW7vbh/HLCN8pnJmSbk7wGaiqQfXU9qz1o41rTSa8i+l/OAn07TTn12qw22Qm7XnOBMbG/mQNBpy0KD9LAS8v8y9krNf6iEVdAZPfFepo3kmvgx3/rO9ZVw0A74q97sltszx3EpEfJ+VyVrhb6TyZV8SqORBwhcKfNlkmHTe+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p557LTb9B3Tp0N3SQw48ZcCxMum/lSu4pmn+vqdjGo0=;
 b=iFARlmOJ+lBzBxBuPb/9g+NfDiyloVMiNmVx53D4opTyIMRuPDpMS4i16W5R8z5A/ZeykpdmKmyfMgZ9GIIgUqHo2KApLZ8tG/o8JFkEEDYMUF54ufFRnM8QhypThMTMU9yZ2s7+7R5N7AmQX/3vHNX53hnv93ft2fpOIJmJx47rBZeVzlHQ3qE52iNMqIRn+sY2jYRVt80mN9i8ShRLeI193BPDbO58JyfZDcjZBNid6V26+GOXsQt90OPZDTuzvKa9WxW6ys0i/ntvNqIvwCYIDhOHNfn7tEolGYQC14eI3uUPYOmOLV7DrliMqhQaipE8ZMY/xcAtvk2U237qEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p557LTb9B3Tp0N3SQw48ZcCxMum/lSu4pmn+vqdjGo0=;
 b=j3jAQ6qch9HpkT8h53RTL3rkdIXfNuTy7shcrsZObnhxRr857MGuL9MXzPclvchCkfo9A/VdcYN66mM0jqURzbMuTNuBtCN/fyJwgxwrWSda4A/z93ixTC8AlkXbpgv9pKx5qr6jS1b5F2xKgyec/kJbZY87o6k36zwUA46e5jiSaqK6t78Xx9NfwaA0eG2jUMBO3M81x/ggk235tzXBpoTLdKL5KI2PSucjYvTV2sPec3gDxpQxtEpetxJx83eE8xbPbybc/vTNk0Mhfwr5qLJQwqFEQE04tEEdIfipYb0za0bv6zRaLdz9YeJ33HTUHbwBUWN+2hyekn+vmfktZg==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN4P287MB4753.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Tue, 24 Feb
 2026 08:38:08 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9654.007; Tue, 24 Feb 2026
 08:38:08 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: Adapt math functions to use 64bit long double on
  aarch64
Thread-Topic: [PATCH] Cygwin: Adapt math functions to use 64bit long double on
  aarch64
Thread-Index: AQHcpWDAaRvsMEkU9Ey46l8CyPjtmw==
Date: Tue, 24 Feb 2026 08:38:00 +0000
Message-ID:
 <MA0P287MB3082742D4D0C170079EF9B7A9F74A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
undefined: 4355888
drawingcanvaselements: []
composetype: newMail
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN4P287MB4753:EE_
x-ms-office365-filtering-correlation-id: 16168639-56e4-4765-eb4d-08de7380096b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|6049299003|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZGnY/iT5GmYEneFg0lOVBw0ZeNQ9Roqwy/fn+xKClYc1+99CQEWXcWQYO1?=
 =?iso-8859-1?Q?+xbKKZggorGo4uBurPnLtPY+wjkPt5iX1zCs2xohEj7zO9yXjEmV1GXHZF?=
 =?iso-8859-1?Q?CQmPvkKfop4G6SCBUjY0RDleYj+bkBKVXGR2W2V3i4X0YiuGyBniWffrSd?=
 =?iso-8859-1?Q?pAI66POrZzSmjj2hT9quH3DAZuSC4F+Uf8c+2qd2CcXgPGycPqmn0Q0LPw?=
 =?iso-8859-1?Q?EUyZH+bO5Rpeh5vVTbmRLU15WyfCc+84slqYP/NQcGJbHwXAE9GZWYRqoC?=
 =?iso-8859-1?Q?268JfEcm179Hrm9iqEGp94fghV/91gdn4jg/UDbXEocKzATVuCts1yvdBF?=
 =?iso-8859-1?Q?rogUS8pVyFODIRqfx2TCjV6C5ue1e66LUYEXL7CICu7ZbY/9BXbbXutZMj?=
 =?iso-8859-1?Q?0XGxLKBVVUtUBv88NbL2x30HZACK1bEnlwa417lgOOALm2TuOz3xE3b/6G?=
 =?iso-8859-1?Q?DPFd3guD94qQGgWUthAbOxn5/6OnsoGUrs65CmnEfKebpiSJKhJxJAxfmU?=
 =?iso-8859-1?Q?d56FIN5r4usUHbHW8ytUvfQ+EGHZ5iQmErw2iucXXFFus8tV2IhyY7sDFV?=
 =?iso-8859-1?Q?ISpflWymmqj73gxuM56fMjX2GwaTQQcoOIVqP+z+opGeq+AMjT5OsE3NnE?=
 =?iso-8859-1?Q?tApq+3A0hlSwy33ldHkhjksMyVWKfIyb12UepCCxDXe6ipXnRJPTKap2G+?=
 =?iso-8859-1?Q?qjd4uU7AO7mV284malZxyJOWam6V0zqSl/+qwN9PoCm7BJAB9TsahLiSDN?=
 =?iso-8859-1?Q?RV0BjFYdgVqu/37dimHyP+W0f7+QdENEVWKaGkJ4QKyG5G0+9SJkH+kl35?=
 =?iso-8859-1?Q?jDnUGHSK/5Hl1OxEpq7R+k9qH2m4XX10C8Mony20X8Nn5ne1kDEjNmm5ud?=
 =?iso-8859-1?Q?u6Ml9IYq+qAWYXkjWOy/DQjujqa9pcUgtwYyPVrtd5BRbEJFQsviFEzjVJ?=
 =?iso-8859-1?Q?UroWKAujeD9ICQ+Y+rQx0ALsTCE0M56SgNfD2V6LGmyTwVWZ4IRL2WvJU2?=
 =?iso-8859-1?Q?JxhC8tysX5ycTT44tIBLHBndnIswLo/svwLMhAK0vkbcJmNdTFFUgdvuxY?=
 =?iso-8859-1?Q?ed5V41vQ9WCCniZfX8qgqnfhVxvz1X5vRxuK1piAnjBhmr3fzfzwcpU7+7?=
 =?iso-8859-1?Q?cjsYouZZxJbNeAHeh14Mng8tl4FqYTq8iLl1LAl2+/dzW8BweEB0MqPa81?=
 =?iso-8859-1?Q?8wnnBIWX2CW8rTFognyyQbCk/hs+zd1KjTv8rFxNEBD7YCtWt8x7UTJtBU?=
 =?iso-8859-1?Q?wy2fJFfkoNCeRnAtt1udqfTt0i/Zwg6O5vPPi4yb8LoO2TSFw5beqVUybn?=
 =?iso-8859-1?Q?A/1CVvtCKb+9g+JESmYvBtp2kpSq1HzZom4qnnpyz57EUZvW4A4upHpB2u?=
 =?iso-8859-1?Q?bTphIqd9xkGjirbklN2Fi7xLbqXPqVKBpwg8vXSqLkKiksu1uRIgqwBCUy?=
 =?iso-8859-1?Q?vWHHvMPmbCjdBbQ0eceuYsH/+a6Pf5BckSx6IhhY0Jbw0FfvMsK227sxPq?=
 =?iso-8859-1?Q?5aCFSw77VL1c2QS6Bn1QdEr7w1invyMmdFsLWEmfR/t6PC8d/Jhb3+rdBO?=
 =?iso-8859-1?Q?Ud6av6Mz5OuXP2Dl+163B3oJV3ocWgHyA7K/Dbj9g/dyrm3Wz1Iubnd8ie?=
 =?iso-8859-1?Q?1pD1vMR3KFxMgzJFzX/sv80k7gjsyGGBFQCqhQEKne7QasYgr4YighrSG/?=
 =?iso-8859-1?Q?1EANG0jEdqaS4rYrFwk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(6049299003)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lboS+TYcBlTyKP0GG8e6FHjPxwIvVTFSeIFDC4FFp0t/97Gunt6f+Sp62J?=
 =?iso-8859-1?Q?zAUJ/A/HeSNX66rDzH9NCBrobiBmdKS6JtupuGLAUUx+DtdEGtTV5qOHfC?=
 =?iso-8859-1?Q?ZdEEYz4Hhq6QLeafvZPTJ07aUAvOkprkDapGR9kPuamr+s4ZSYebc+1zkJ?=
 =?iso-8859-1?Q?srd3TdNNtMSxmQcPduMLXMofV0tuEajC4a58sLJBszWTTyKiwe3KRU/8mq?=
 =?iso-8859-1?Q?9fEIn38+U3mDmLfC4+wrvR4FdmGK6HZO4GWp81ZXFk4lECqJZGf5FkAXMC?=
 =?iso-8859-1?Q?jEd3mkE2t9tbyEkDqkT3Q1XeVz5flsjuwUC/zFFuRfYeXfBsJlz8x+q0fz?=
 =?iso-8859-1?Q?vWhO9sD8WHdnyPn7Sx3+zIqkP91DloYoAvxVfIGaT+uPbxOAUyf7+mFeRX?=
 =?iso-8859-1?Q?fzWmBWxXUO1rgw0qV4BTyE6PD+MgID4NoKtk7R9u0GGSEoNqKTzxxaWmix?=
 =?iso-8859-1?Q?LzdORY03+Z5n91jIv3UY3cDDzLXcvXedi7pfo9fHP52li1WeIQ78j8QywM?=
 =?iso-8859-1?Q?V4AlTrVHYZXlqp7//4bdIVqANuTlYYVGCzME0Oxm9WWc8Iw/YYN6MAK3v0?=
 =?iso-8859-1?Q?EodBSQaWthZFakbI8525oMS5+tjg42tYN2yq3U4ql0ksOYzOxnYsh0MWMc?=
 =?iso-8859-1?Q?dl+UkIAGwoFzVmdZNP44jTp7/7KsFxPhI7wKNcxduX6ZrY6KNYvFOgl7Hp?=
 =?iso-8859-1?Q?EtrRb6DlcALwHfP3s9WmfzaEYOwRnHk9uqGWvmhTBnOntk2a0K3uvmhIJr?=
 =?iso-8859-1?Q?nECnZrW7+9gk8pOem1dX4ohbGiM41uiGONx07yWA7K41XGDxGw+muUzm46?=
 =?iso-8859-1?Q?QWWs9MqA+WAsj6g0ethkhD7y+zRSBkVCD4KbxoAgAr55TYEEoOdN+ESjxV?=
 =?iso-8859-1?Q?JeR7wUxTugqvg8PFqGL2tPziWScvHJ+P/Rbx6Zy3K9pwXqO39/MQWMzw3x?=
 =?iso-8859-1?Q?2P1BQ7MaqV58K0OCC6DulX8slgzvUdP1/Jk1e7FOtQDp9g8ws7X99QoGoR?=
 =?iso-8859-1?Q?30zf7YMwlxDoIcIB5O9NJVlEn6TukS4lmsP+JliWT2pp+1YF52c7l9oskx?=
 =?iso-8859-1?Q?GA9muRbiZp7rwIfiCexeIBBMNq7OJknJcHBYKJPzoNY6s0fkM6KqNZKPEG?=
 =?iso-8859-1?Q?mglwMcqVhabU0dAOIGsMwMUz6HGIITpH0rySqTmNizskqr9j7Nw5iJH6j4?=
 =?iso-8859-1?Q?tieKQbqx6ibSq365DStYqYS6rR+fOZGe7b9t5FzM1ZO9EZ2L2Pd9IyQ4hh?=
 =?iso-8859-1?Q?7KSkyM2ZrUN/jZdo4+oI69nQPnafC8XwfvI4ycrLrz1jbm6kR5dsGp9Uj/?=
 =?iso-8859-1?Q?vwN9porf17KhrZnhLDZ+55j5xX4BtGREyfWeDusZxHKRCNjLj8Hkh5kIZi?=
 =?iso-8859-1?Q?K2pUBynBAaDdIw32/OKqjK7dBJOwhdx3UvGd4yCteyyaO+IArwUgyRlODU?=
 =?iso-8859-1?Q?AULpOgmLCT3Lj2vooGVPGT6HgbGLJv165g5J3/a1S4Zhl0YgP85syFY30x?=
 =?iso-8859-1?Q?wgJsIR3C4krLlgbsucmiU1kt5SFOweY5DoV0lgk6rt5hYIt5loszCwIZWQ?=
 =?iso-8859-1?Q?dE+2xLnct9InQY+TdOMwRROWtH2MgGNnu5cSSb5vzFpglgavHPlo3aIM3b?=
 =?iso-8859-1?Q?xba6y9VRO+mAvLP3pja+lKCR8/+f5HwZUvhRoBp7UbpfjgIBy11WJeTWes?=
 =?iso-8859-1?Q?wSjkd77glnYjIUH6xwTw7emNabpqNmli88weXJQUQS2OMa7p5zlgFApwoY?=
 =?iso-8859-1?Q?SIZ/bKEj0uAFdKCqmhOc8g3N/mSQENTi2bbt7KmORsJleBZZ1bo3EYgvRo?=
 =?iso-8859-1?Q?nQvbKh7daaeDTsVXIOrq4Uh5/+jnA/anTcT/AytAKVNf7JOc6FNRmSftgD?=
 =?iso-8859-1?Q?zu?=
x-ms-exchange-antispam-messagedata-1:
 VOZOkuN6hj0Of++NBt93XSTueNGaIjpfZVPkSqYDcsGEXUUZNDU/xMVj
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082742D4D0C170079EF9B7A9F74AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 16168639-56e4-4765-eb4d-08de7380096b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 08:38:08.3677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nndkAhVLF6My2SpoDDeFU25LypCcO3b+sXoBi4vzdVBuTBR67QgF/42+fVmmwnV00yZgW3HVAxurLgLZQ7791kXo0EIVXDrVkcKpKMudX2w37C8eRqkir3fqWkB3tKpXpbvUyicrZwCc5tAbz+GOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4P287MB4753
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,KAM_LOTSOFHASH,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082742D4D0C170079EF9B7A9F74AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082742D4D0C170079EF9B7A9F74AMA0P287MB3082INDP_"

--_000_MA0P287MB3082742D4D0C170079EF9B7A9F74AMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

On Cygwin AArch64, long double has the same representation and precision
as double (64-bit), unlike x86 extended precision.

This patch updates math functions to correctly handle this case by avoiding
assumptions about extended precision in nextafterl and related functions.
It also updates rintl to use the generic implementation on AArch64 and
adjusts constants in cephes_mconf.h and lgammal.c accordingly.

Thanks & regards
Thiru

In-lined patch:
---
 winsup/cygwin/math/cephes_mconf.h | 4 ++--
 winsup/cygwin/math/lgammal.c      | 4 ++--
 winsup/cygwin/math/nextafterl.c   | 4 ++++
 winsup/cygwin/math/rintl.c        | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/math/cephes_mconf.h b/winsup/cygwin/math/cephes_=
mconf.h
index 832fae0df..654de88bf 100644
--- a/winsup/cygwin/math/cephes_mconf.h
+++ b/winsup/cygwin/math/cephes_mconf.h
@@ -66,7 +66,7 @@ extern double __QNAN;
 #endif

 /*long double*/
-#if defined(__arm__) || defined(_ARM_)
+#if defined(__arm__) || defined(_ARM_) || defined(__aarch64__)
 #define MAXNUML        1.7976931348623158E308
 #define MAXLOGL        7.09782712893383996843E2
 #define MINLOGL        -7.08396418532264106224E2
@@ -84,7 +84,7 @@ extern double __QNAN;
 #define PIL    3.1415926535897932384626L
 #define PIO2L  1.5707963267948966192313L
 #define PIO4L  7.8539816339744830961566E-1L
-#endif /* defined(__arm__) || defined(_ARM_) */
+#endif /* defined(__arm__) || defined(_ARM_)  || defined(__aarch64__) */

 #define isfinitel isfinite
 #define isinfl isinf
diff --git a/winsup/cygwin/math/lgammal.c b/winsup/cygwin/math/lgammal.c
index 022a16acf..961eec280 100644
--- a/winsup/cygwin/math/lgammal.c
+++ b/winsup/cygwin/math/lgammal.c
@@ -198,11 +198,11 @@ static uLD C[] =3D {

 /* log( sqrt( 2*pi ) ) */
 static const long double LS2PI  =3D  0.91893853320467274178L;
-#if defined(__arm__) || defined(_ARM_)
+#if defined(__arm__) || defined(_ARM_) || defined(__aarch64__)
 #define MAXLGM 2.035093e36
 #else
 #define MAXLGM 1.04848146839019521116e+4928L
-#endif /* defined(__arm__) || defined(_ARM_) */
+#endif /* defined(__arm__) || defined(_ARM_) || defined(__aarch64__) */

 /* Logarithm of gamma function */
 /* Reentrant version */
diff --git a/winsup/cygwin/math/nextafterl.c b/winsup/cygwin/math/nextafter=
l.c
index b1e479a95..80c9c3c4d 100644
--- a/winsup/cygwin/math/nextafterl.c
+++ b/winsup/cygwin/math/nextafterl.c
@@ -16,6 +16,9 @@
 long double
 nextafterl (long double x, long double y)
 {
+#if defined(__aarch64__) && (LDBL_MANT_DIG =3D=3D DBL_MANT_DIG)
+  return (long double) nexttoward (x, y);
+# else
   union {
       long double ld;
       struct {
@@ -63,6 +66,7 @@ nextafterl (long double x, long double y)
     u.parts.mantissa |=3D  normal_bit;

   return u.ld;
+# endif /* defined(__aarch64__) */
 }

 /* nexttowardl is the same function with a different name.  */
diff --git a/winsup/cygwin/math/rintl.c b/winsup/cygwin/math/rintl.c
index 9ec159d17..1e30de069 100644
--- a/winsup/cygwin/math/rintl.c
+++ b/winsup/cygwin/math/rintl.c
@@ -9,7 +9,7 @@ long double rintl (long double x) {
   long double retval =3D 0.0L;
 #if defined(_AMD64_) || defined(__x86_64__) || defined(_X86_) || defined(_=
_i386__)
   __asm__ __volatile__ ("frndint;": "=3Dt" (retval) : "0" (x));
-#elif defined(__arm__) || defined(_ARM_)
+#elif defined(__arm__) || defined(_ARM_)|| defined(__aarch64__)
     retval =3D rint(x);
 #endif
   return retval;
--


--_000_MA0P287MB3082742D4D0C170079EF9B7A9F74AMA0P287MB3082INDP_--

--_004_MA0P287MB3082742D4D0C170079EF9B7A9F74AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="Cygwin-Adapt-math-functions-to-use-64bit-long-double.patch"
Content-Description:
 Cygwin-Adapt-math-functions-to-use-64bit-long-double.patch
Content-Disposition: attachment;
	filename="Cygwin-Adapt-math-functions-to-use-64bit-long-double.patch";
	size=3601; creation-date="Tue, 24 Feb 2026 07:55:53 GMT";
	modification-date="Tue, 24 Feb 2026 07:56:13 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmZGY3MWFmMGVkYTdmYTU5ZGNmZTU1ZjQ2ZWUwMWViMmNlNDNmZDg2
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogVHVlLCAyNCBGZWIgMjAyNiAxMjozNjoyMCArMDUz
MApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogQWRhcHQgbWF0aCBmdW5jdGlv
bnMgdG8gdXNlIDY0Yml0IGxvbmcgZG91YmxlIG9uCiBhYXJjaDY0CgpTaW5j
ZSBhYXJjaDY0IFdpbmRvd3MgcGxhdGZvcm1zIHVzZSA2NGJpdCBsb25nIGRv
dWJsZXMgaW5zdGVhZCBvZgo4MGJpdCBvciAxMjhiaXQsIGFkYXB0IEN5Z3dp
biBtYXRoIGxpYnJhcnkgZnVuY3Rpb25zIHRvIGhhbmRsZQp0aGlzLgpUaGVz
ZSBjaGFuZ2VzIGVuc3VyZSBtYXRoIGZ1bmN0aW9ucyB3b3JrIGNvcnJlY3Rs
eSB3aXRoIGFhcmNoNjQncwo2NGJpdCBsb25nIGRvdWJsZSByZXByZXNlbnRh
dGlvbi4KClNpZ25lZC1vZmYtYnk6IE1hcnRpbiBWZWpib3JhIDxtYXJ0aW4u
dmVqYm9yYUBtaWNyb3NvZnQuY29tPgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1h
bGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNv
cmV3YXJlaW5jLmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL21hdGgvY2VwaGVz
X21jb25mLmggfCA0ICsrLS0KIHdpbnN1cC9jeWd3aW4vbWF0aC9sZ2FtbWFs
LmMgICAgICB8IDQgKystLQogd2luc3VwL2N5Z3dpbi9tYXRoL25leHRhZnRl
cmwuYyAgIHwgNCArKysrCiB3aW5zdXAvY3lnd2luL21hdGgvcmludGwuYyAg
ICAgICAgfCAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2lu
L21hdGgvY2VwaGVzX21jb25mLmggYi93aW5zdXAvY3lnd2luL21hdGgvY2Vw
aGVzX21jb25mLmgKaW5kZXggODMyZmFlMGRmLi42NTRkZTg4YmYgMTAwNjQ0
Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbWF0aC9jZXBoZXNfbWNvbmYuaAorKysg
Yi93aW5zdXAvY3lnd2luL21hdGgvY2VwaGVzX21jb25mLmgKQEAgLTY2LDcg
KzY2LDcgQEAgZXh0ZXJuIGRvdWJsZSBfX1FOQU47CiAjZW5kaWYKCiAvKmxv
bmcgZG91YmxlKi8KLSNpZiBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQo
X0FSTV8pCisjaWYgZGVmaW5lZChfX2FybV9fKSB8fCBkZWZpbmVkKF9BUk1f
KSB8fCBkZWZpbmVkKF9fYWFyY2g2NF9fKQogI2RlZmluZSBNQVhOVU1MCTEu
Nzk3NjkzMTM0ODYyMzE1OEUzMDgKICNkZWZpbmUgTUFYTE9HTAk3LjA5Nzgy
NzEyODkzMzgzOTk2ODQzRTIKICNkZWZpbmUgTUlOTE9HTAktNy4wODM5NjQx
ODUzMjI2NDEwNjIyNEUyCkBAIC04NCw3ICs4NCw3IEBAIGV4dGVybiBkb3Vi
bGUgX19RTkFOOwogI2RlZmluZSBQSUwJMy4xNDE1OTI2NTM1ODk3OTMyMzg0
NjI2TAogI2RlZmluZSBQSU8yTAkxLjU3MDc5NjMyNjc5NDg5NjYxOTIzMTNM
CiAjZGVmaW5lIFBJTzRMCTcuODUzOTgxNjMzOTc0NDgzMDk2MTU2NkUtMUwK
LSNlbmRpZiAvKiBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX0FSTV8p
ICovCisjZW5kaWYgLyogZGVmaW5lZChfX2FybV9fKSB8fCBkZWZpbmVkKF9B
Uk1fKSAgfHwgZGVmaW5lZChfX2FhcmNoNjRfXykgKi8KCiAjZGVmaW5lIGlz
ZmluaXRlbCBpc2Zpbml0ZQogI2RlZmluZSBpc2luZmwgaXNpbmYKZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9sZ2FtbWFsLmMgYi93aW5zdXAv
Y3lnd2luL21hdGgvbGdhbW1hbC5jCmluZGV4IDAyMmExNmFjZi4uOTYxZWVj
MjgwIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21hdGgvbGdhbW1hbC5j
CisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9sZ2FtbWFsLmMKQEAgLTE5OCwx
MSArMTk4LDExIEBAIHN0YXRpYyB1TEQgQ1tdID0gewoKIC8qIGxvZyggc3Fy
dCggMipwaSApICkgKi8KIHN0YXRpYyBjb25zdCBsb25nIGRvdWJsZSBMUzJQ
SSAgPSAgMC45MTg5Mzg1MzMyMDQ2NzI3NDE3OEw7Ci0jaWYgZGVmaW5lZChf
X2FybV9fKSB8fCBkZWZpbmVkKF9BUk1fKQorI2lmIGRlZmluZWQoX19hcm1f
XykgfHwgZGVmaW5lZChfQVJNXykgfHwgZGVmaW5lZChfX2FhcmNoNjRfXykK
ICNkZWZpbmUgTUFYTEdNIDIuMDM1MDkzZTM2CiAjZWxzZQogI2RlZmluZSBN
QVhMR00gMS4wNDg0ODE0NjgzOTAxOTUyMTExNmUrNDkyOEwKLSNlbmRpZiAv
KiBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX0FSTV8pICovCisjZW5k
aWYgLyogZGVmaW5lZChfX2FybV9fKSB8fCBkZWZpbmVkKF9BUk1fKSB8fCBk
ZWZpbmVkKF9fYWFyY2g2NF9fKSAqLwoKIC8qIExvZ2FyaXRobSBvZiBnYW1t
YSBmdW5jdGlvbiAqLwogLyogUmVlbnRyYW50IHZlcnNpb24gKi8KZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vbWF0aC9uZXh0YWZ0ZXJsLmMgYi93aW5z
dXAvY3lnd2luL21hdGgvbmV4dGFmdGVybC5jCmluZGV4IGIxZTQ3OWE5NS4u
ODBjOWMzYzRkIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21hdGgvbmV4
dGFmdGVybC5jCisrKyBiL3dpbnN1cC9jeWd3aW4vbWF0aC9uZXh0YWZ0ZXJs
LmMKQEAgLTE2LDYgKzE2LDkgQEAKIGxvbmcgZG91YmxlCiBuZXh0YWZ0ZXJs
IChsb25nIGRvdWJsZSB4LCBsb25nIGRvdWJsZSB5KQogeworI2lmIGRlZmlu
ZWQoX19hYXJjaDY0X18pICYmIChMREJMX01BTlRfRElHID09IERCTF9NQU5U
X0RJRykKKyAgcmV0dXJuIChsb25nIGRvdWJsZSkgbmV4dHRvd2FyZCAoeCwg
eSk7CisjIGVsc2UKICAgdW5pb24gewogICAgICAgbG9uZyBkb3VibGUgbGQ7
CiAgICAgICBzdHJ1Y3QgewpAQCAtNjMsNiArNjYsNyBAQCBuZXh0YWZ0ZXJs
IChsb25nIGRvdWJsZSB4LCBsb25nIGRvdWJsZSB5KQogICAgIHUucGFydHMu
bWFudGlzc2EgfD0gIG5vcm1hbF9iaXQ7CgogICByZXR1cm4gdS5sZDsKKyMg
ZW5kaWYgLyogZGVmaW5lZChfX2FhcmNoNjRfXykgKi8KIH0KCiAvKiBuZXh0
dG93YXJkbCBpcyB0aGUgc2FtZSBmdW5jdGlvbiB3aXRoIGEgZGlmZmVyZW50
IG5hbWUuICAqLwpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tYXRoL3Jp
bnRsLmMgYi93aW5zdXAvY3lnd2luL21hdGgvcmludGwuYwppbmRleCA5ZWMx
NTlkMTcuLjFlMzBkZTA2OSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9t
YXRoL3JpbnRsLmMKKysrIGIvd2luc3VwL2N5Z3dpbi9tYXRoL3JpbnRsLmMK
QEAgLTksNyArOSw3IEBAIGxvbmcgZG91YmxlIHJpbnRsIChsb25nIGRvdWJs
ZSB4KSB7CiAgIGxvbmcgZG91YmxlIHJldHZhbCA9IDAuMEw7CiAjaWYgZGVm
aW5lZChfQU1ENjRfKSB8fCBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmlu
ZWQoX1g4Nl8pIHx8IGRlZmluZWQoX19pMzg2X18pCiAgIF9fYXNtX18gX192
b2xhdGlsZV9fICgiZnJuZGludDsiOiAiPXQiIChyZXR2YWwpIDogIjAiICh4
KSk7Ci0jZWxpZiBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX0FSTV8p
CisjZWxpZiBkZWZpbmVkKF9fYXJtX18pIHx8IGRlZmluZWQoX0FSTV8pfHwg
ZGVmaW5lZChfX2FhcmNoNjRfXykKICAgICByZXR2YWwgPSByaW50KHgpOwog
I2VuZGlmCiAgIHJldHVybiByZXR2YWw7Ci0tCjIuNTMuMC53aW5kb3dzLjEK
Cg==

--_004_MA0P287MB3082742D4D0C170079EF9B7A9F74AMA0P287MB3082INDP_--

Return-Path: <SRS0=lO2D=EH=k12targetiq.com=wren.m@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id A42004BA23D3;
	Thu, 11 Jun 2026 22:20:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A42004BA23D3
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=k12targetiq.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=k12targetiq.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A42004BA23D3
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1781216435; cv=pass;
	b=LsXwPWF/iOkR02CtbWzHvsllVQ782lJwWPGEO9rNKSVrbHKq7y3eHDkeZqaXbcK9AZSdKBes1VYPLF6qJXeZyYiB7ZTNhVBTelicKTejJoPZKM15fILjmnHIvJ3VNbUXuU7BstEs5bJr09qAQx61ZYIqsfsex4yeL884pA+t+/8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781216435; c=relaxed/simple;
	bh=8uNo4nafRUTywEWFkJXaWonN7xUApRTs55avb/Gb4SE=;
	h=From:Subject:Date:Message-ID:MIME-Version; b=Kdqm+yC5SXIjxKu1Vg9ZkoQclK+i9AErBozAmuUL5rCcy5DUbOQa3tCo2IbyYeee5HE+NvQCz4N/yNgaQuGXkDNZ+cSg0whdr6tIQbdxb1JZmRCwpQowJvCcPbI1CPJvzxhTpYq8tjbQ9ob8hGxHGHaiNMMbdJdWk0GDHhNgIoI=
ARC-Authentication-Results: i=2; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A42004BA23D3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF1bzIeiGpmOPCQtG7YwvgGBM4+trGl8OJgXSNbwk4hB+LHi3ZhKKk0RS35VZ/EXbBJByCplCkmRYkZE0u/6LdOrLJxlcemftufx9VVKlyxOL+PXZeDwgFOFlGtJHLY4+eP27crUAFaEUT4UB7qGWQgVt8YO87+DvoZqdUSZhRQY9aSZtHTEsyZmNdSffy8ZeBW3dHhMqp2jumAhQNuQPV2QypnSHxBL4sB7NaqVt9vqeKYCStTqjACaHyV49VzaUJxS/WtFA1E50zao6tdwFe5um58y4esFB9i6YQrvfdUUm+AmZWqcEiFClJJyWZcqAiKnJDjwVrJVgNTqzGDsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uNo4nafRUTywEWFkJXaWonN7xUApRTs55avb/Gb4SE=;
 b=mouuZvy64uvOHt71zOqbw63bGG06YVBJ82+1mgm9BX99nKO3a0k8FslqcoNYHSzczMVeCuxepjYADnkk/57uD/46yUF7jh/1mXQUtFdbdIwWwyTj7gG/QCn3o/Y+IqzmOICf9BqDQd0xZ7/Q9OLC9L17XEbE+sGN8F3yNCm/iWHpBlO0u0Y7skwfTH4fLw77U6a89JVkptzYyH4jYB1YcTz0D8GKx4bV3nhaVjKbnPCLj7BWMgPq9wzVSoEv5OYKSXVzrro/EAnb+bRygc1f11pQ4DXs3+Mr9sfPP2kyHUoI4ALTNhNZCBD3D18AYY/P7bbIn5w1zF1RA0UP6XeZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=k12targetiq.com; dmarc=pass action=none
 header.from=k12targetiq.com; dkim=pass header.d=k12targetiq.com; arc=none
Received: from PN2P287MB0537.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:114::11)
 by PN6P287MB4916.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:302::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 22:20:28 +0000
Received: from PN2P287MB0537.INDP287.PROD.OUTLOOK.COM
 ([fe80::3191:8b7d:adc6:af07]) by PN2P287MB0537.INDP287.PROD.OUTLOOK.COM
 ([fe80::3191:8b7d:adc6:af07%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 22:20:28 +0000
From: Wren M <wren.m@k12targetiq.com>
Subject: Verified district contacts
Thread-Topic: Verified district contacts
Thread-Index: Adz58H7lKX3OWhzCRp2K4Zxq9ZPiLg==
Date: Thu, 11 Jun 2026 22:20:28 +0000
Message-ID:
 <PN2P287MB0537A1B5A59B76CCFDDCF527991B2@PN2P287MB0537.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=k12targetiq.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2P287MB0537:EE_|PN6P287MB4916:EE_
x-ms-office365-filtering-correlation-id: 4e169ab0-ee14-4ade-12ee-08dec807a4b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|34096008|376014|23010399003|42112799006|1800799024|56012099006|8096899003|18002099003|38070700021|7055299006;
x-microsoft-antispam-message-info:
 AJRi5kRKFI7ZjrlHK+tngkTmHF+Q5f9SVVCTpOm/4UN6vbwRIrSfFw8UV5lKEfPzVkv+OHZHGNAcIL40Zo++urXzgLnguB4DbZSjDwiDiYKm0dIzbjxgJ4K3LKt3nLFwJRR4d/R5iIJzVvaugDu2jEAotU/3h6kLOH9H1AOnHoYqHFwXtfTXFpYUQhsevah0OzfEbOUZXMKArHQ6wu3SSAYU3mkEwGrCZBgY5hUJEccUsCi1fREYS87umGaRfxuIYk3xzjoEg0dVjdDU2oFL6JJUyZGaH69z+5Vn/6cKBvMq7V/AICOc1wN9MssGB3efh0E+sLhl/xqSPCzUIGL2cPXQZ2PBdoMNCyAlLWOgQ+zUOHK6i6OCLZ6HucnkByzCTOtV7YPEFwXJc3vkaNh6OMq91rvb9qL+qHgGdV/aufJZtPzcQ9EEX4aAeyr2pUyasEZEHnEUnMmamfEKEiHfevw68qp6k8ixoLQct2R6BPJrw4K0uPp+ZJYxopTsLdEHPQBWOW7s7yAT/fKj3HYhBYmbZYZYwHYFz+MDAxmkZWGrZkWTgl9CTzlFUwYLj/SaIp+3zFowGNmQw7KozuTX6gxfbUKxP8Ci0gSqAhHP8B+XPeIRGcmB3E6keCu55YmGbNHA7Q+mUZFuV/Is/T8hvZQIYz8qRpUt7qdNdg7qWb9ePQPKKGfjYjB3CmYeSk1t0KRZDA+ewV1ggCJkt+jSO6eCQ4a8skITong1xS9FBWTL6Ci8qzhKWIiStbuUWJq7DgSKehFzCP9P8ykKrdiKPQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB0537.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(34096008)(376014)(23010399003)(42112799006)(1800799024)(56012099006)(8096899003)(18002099003)(38070700021)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fKnntm7TfJ2gNzrChToTBtnTE+OVXt7scvESKK7YaF5cSVVKdd7rXWdRP/++?=
 =?us-ascii?Q?MGPSKzxxsefsKrH6Nm3zu4/pVoNnewA09/Zo4kEUNkYAZdO3wNAadKQztzrv?=
 =?us-ascii?Q?63Gw+RKysbRs7LUrxtOmFpBD8IrFM2qGJY4k2BYpIRWbu3Khc5nFypLjQ2Tu?=
 =?us-ascii?Q?YGfU38nUXZlR6DX2OgHmzrcj8mhLrfzjhTrYWLm7ibw2CEsN99t+AmsBmZyq?=
 =?us-ascii?Q?oEQuvE4WhHzF/TnRbVXCvnwUGy8Kx6xiQCDlmKK6mcK+TZC95Xz62FM5vOHu?=
 =?us-ascii?Q?GR4UOce5r5oIEamJ2etiZWnTJ90VHrIMBddwu5DuhNjrgnL/V2jcJ7uJAzd1?=
 =?us-ascii?Q?MM1btX/+KZmo/wnPp7R2RpT+CARh/S/Fj6+XgK+yPrVVodLo+Gi6Rh33jS/F?=
 =?us-ascii?Q?Vo/xSyLsQ4FN551S4vwDFF6gko/zh9lIxqXfBdah1zFS1Fcu8wTg6YjPTyrP?=
 =?us-ascii?Q?uzRg9a8VFcQqJApbY3McmWnmBaM8IDG/+/U0zkR/Uz4Lr19A/1uvFyoF8AEd?=
 =?us-ascii?Q?kneHlWk3b74TxEDKUVIbnv+eg956RuURFHm2p5e0C8q33bSkzUO0p83PER7t?=
 =?us-ascii?Q?6wADnKq5ZKSzvdje7iduDh2K7HlRrY9XQQYKRo8r5MeuF7v/TByg/hwdV43i?=
 =?us-ascii?Q?nWXODY3H1O/X2Ih/jRP9El0/kTOB/6UEpprfmuYZAcbPMm4YRjXdv0Zv+L09?=
 =?us-ascii?Q?qLpQ6iAK8yBHwztUNACm2ULxQWs7BztzaFeaXmYDsHr3eHUEKoi4+DEmYH5q?=
 =?us-ascii?Q?aRctn8bgN1M8Hj3RriOZyrnqUq/958SlkNPvBIwtjYqInP8fDGCO1MAThF4V?=
 =?us-ascii?Q?V+/7ImBEs/3I8A7Lnx7b2JaRrl3wV+RyCoKjx/SbXdwHHtmlE+6EbmY3abSv?=
 =?us-ascii?Q?Ndn7oj6Hc/eRKDQOPBi3D1RHSuQwM/bCS6GvPeBFgdtWrwhhq1ubHWIE3ZPm?=
 =?us-ascii?Q?Ioj0aXDbXL8jWWtyWNSMNicNExO9P8zcS/gEVmkSrVzQVzD9UU2cy6KZDWvC?=
 =?us-ascii?Q?XAsouRo3e8K/EoR4aKhDxStcVh6/SAhd6LOpw1z8/lz86fv4B6dQB/4rLlgE?=
 =?us-ascii?Q?TnAZfOWh4Tfj9sF88tp5OjK1JHjsNhPuaKWT1l4iIjU4tQIrMaH5FN+c6e3q?=
 =?us-ascii?Q?N5ZqB9IEX9bWeVHIXcBs7HyOzROcY/2/TFnqeCaRb+O6OtXraGion2pvblHO?=
 =?us-ascii?Q?h1Ismg2Wr5HQJsfhxewDiEbuv9yh5j+B4k/sCKq2TdnBJ1NDU7ZgUqQat7f4?=
 =?us-ascii?Q?KJ6LnJDK+MJZQZHVW5nGfKRGHe1Mzk6GmcAN2Vka3gZIlCNxzGc9nYiq/3/r?=
 =?us-ascii?Q?r+Aj6O6lFeFdZCGX00HfOAMxarW1lizEGD+9e+CwWvSXkPIaLKMhu4bBF3d5?=
 =?us-ascii?Q?BAbzLvmJKYfRPD+grVXeglLV2kXS/Mm7TBA50knnsvAphB3xNfBTQ3cFlh3U?=
 =?us-ascii?Q?PR/0Qfn/Ai6WjohYMl4Pc4C+fJqdKWoycQ/xdwM7/n8rV6jZxGSh0hzPn7T/?=
 =?us-ascii?Q?x4a3JaNYNVf0HyJgLZNa+Jl4sFtpqpo4IHGbLIjbJAfX6JmFtICa4fUfartI?=
 =?us-ascii?Q?1nCKaU0iH6VcHzvjHDc3zm67csn9Wi6HVW+PkW8Cu3W2gYNqEVMPd9sX8f6g?=
 =?us-ascii?Q?NNkqgRT34/1KQQ6asohcKzL71o9C9JY2nxuhXlQW7N6NB2Cu0HxW3vc+lTaQ?=
 =?us-ascii?Q?O1QxYOBR8/DKfwahepFWoRm7R4UesJc8CbwVjdEZScOipg6O8n46szps53na?=
 =?us-ascii?Q?C9kHniXv84pedcdR/rL9bHOuxVYxkAU=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PN2P287MB0537A1B5A59B76CCFDDCF527991B2PN2P287MB0537INDP_"
MIME-Version: 1.0
X-OriginatorOrg: k12targetiq.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB0537.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e169ab0-ee14-4ade-12ee-08dec807a4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 22:20:28.6804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60e1d8e4-9c0d-438a-a39e-cbaaf1d7a2bd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtDlLUc4gmVvtZS16ELoYevXph7AHsA99X597sehdbzecgIqZA+XAX5BtsZRk0HXtrXES7xsiLEvswxL4O80il0UhI3eRUTDIrlmCFHwCqUK+21QKU0s9zCgrESfnlpT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN6P287MB4916
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,HTML_MESSAGE,KAM_DMARC_STATUS,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN2P287MB0537A1B5A59B76CCFDDCF527991B2PN2P287MB0537INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings,

Would you be interested in reaching principals, deans, and superintendents =
directly?

Covers Principals, Admissions Directors, Superintendents, Provosts, and Pro=
gram Directors.

97% email deliverability - every record is verified and accurate.

Every contact includes direct email, phone, and complete institution detail=
s.

Can I forward a sample with pricing?

Best regards
Wren M

To remove from this mailing, reply with the subject line "LEAVE US"

--_000_PN2P287MB0537A1B5A59B76CCFDDCF527991B2PN2P287MB0537INDP_--

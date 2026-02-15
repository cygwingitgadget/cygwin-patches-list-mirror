Return-Path: <SRS0=SSD+=AT=schooldatapulse.com=allison.price@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id 5EF7C4BA23FC;
	Sun, 15 Feb 2026 15:30:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5EF7C4BA23FC
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=schooldatapulse.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=schooldatapulse.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5EF7C4BA23FC
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1771169443; cv=pass;
	b=AyRPo8lbCiCdQBAxtIXFOOJg+4M28K4PhloJFj8KmuNG+eGDJEY+vSe7sebrR5dVS0b3yf713Lk29XD/Ttx6+Y/2nH86WGKRSnLeKxFjiYEYSHivQfca7aNo89ElgsvIj/LqXiYCGeUrOv/9k56+JzowOB06661UfVM+AogsgiI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771169443; c=relaxed/simple;
	bh=ycVaCVE/uLKeP1T7F3XILz1LXqhLDTrZdgXewlQ0mII=;
	h=From:Subject:Date:Message-ID:MIME-Version; b=eWrKPrT0KC3FkuNSMYbGXNRjg0lUGfHseFb55E+yGDMWSVGjHe0GLJO2tigAS99hm+N8aife+3FII7LP50e3iAWmdFI8RH42ym7IsSutty4Tcq3WGjB9u8oeDCMU8iX53kkffKyguY+dnyH3K00kQpPvIcKXSuZHosuY50222ww=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5EF7C4BA23FC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPiu/3Ag1oPpEZk5hp+LaAQYih23rntDW60fVYiKgM6vkWO2Dyb0EgzmKQxtkf+LBVa1yzkJSxYIa14GiaPm8+Cg830HtDMJmgwfcXQRYkzd3RIMfIBBwnRBkBYFnuwiwUjefBpVQ0yK/25cjxZPlD4BkLnJpPUvUVZT0eiFWIJmNu2CqXtqXxch/aSnZsndwxjYpRw/gzlQZwkIz/ScrMB958f4ISntOj42Ld8BpbFphpiWOLHk11DYbu5Ux3wfRNnQksPRUsIkAtY4an+33phAdTC1sezqDlf56fezWqXcOTbm8rgNtjDw59csA3x12VFXQ6oyKdeciQt/4y0rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycVaCVE/uLKeP1T7F3XILz1LXqhLDTrZdgXewlQ0mII=;
 b=rqo0TZM5HuKAy1Z0dwoVAmM1Tl722gjjPuAVmz6iyIGJVsm5YnZY6mulbP9L3nKyEsifPSsH8dVK1iIAMwo9M9uLVkIOBChGUpD4G99BT4zPYgFlQIXQJxIBkQSvCjPkWB8bRnR2LIvOlTEqRDWBvFvgKfJFg5FKL6mUgoyPgfpipCPL1rpH5+L+yvEa2z+OxiTX/3gBf9ZYLmsoJyG93qglNi2KAkAWF5tohfwGkXdikbowYgdK/kbuQUZLbl+jjEdz9kNo7D3fsepeTv2foq7rz3pjbrFJhOz8eC68cSQ/71SzDLTfX7IbFzhv88yy6Z7i4d5340QePMukO/MQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schooldatapulse.com; dmarc=pass action=none
 header.from=schooldatapulse.com; dkim=pass header.d=schooldatapulse.com;
 arc=none
Received: from PN3PPF68D57569F.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::ad)
 by MAZP287MB0612.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:10c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Sun, 15 Feb
 2026 15:30:37 +0000
Received: from PN3PPF68D57569F.INDP287.PROD.OUTLOOK.COM
 ([fe80::33f5:2c8:687:3309]) by PN3PPF68D57569F.INDP287.PROD.OUTLOOK.COM
 ([fe80::33f5:2c8:687:3309%3]) with mapi id 15.20.9632.010; Sun, 15 Feb 2026
 15:30:37 +0000
From: Allison Price <allison.price@schooldatapulse.com>
Subject: Leadership Emails
Thread-Topic: Leadership Emails
Thread-Index: Adyej7YnZAx0jmsWR2KOKN1j7vk+fg==
Date: Sun, 15 Feb 2026 15:30:37 +0000
Message-ID:
 <PN3PPF68D57569F5F0A69C6006954B28A69F76FA@PN3PPF68D57569F.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schooldatapulse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PPF68D57569F:EE_|MAZP287MB0612:EE_
x-ms-office365-filtering-correlation-id: 14e91bcf-63aa-46e2-4b5c-08de6ca72b44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|34096008|366016|38070700021|8096899003|7055299006;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qRo9UNuXt69qGS0aHhr9TTYlMM2cmHCQ/vaLZKI8JvFjJpXBh6KDeOzWRao3?=
 =?us-ascii?Q?VxnLjLtWWDUJaXSN0xH0CylYYBrV6yOlNrF0/H0gEkt21lUkwbq7jyWkHWLk?=
 =?us-ascii?Q?B0K0YtbqUJzdoQ1CAbZv3RJ9u38KvSFI7Ak58id0XfIacv8Rc8lgB6W4zywR?=
 =?us-ascii?Q?WfDSQFmZ2YqKrBdlCyx9Fn3wphMai85wR/X/za/S8BmxRTIAoobyl+n+N6jc?=
 =?us-ascii?Q?ryOCmGrfgAlTqHqVSb6RwlOxz8OLR4KdUEN5ZpvazQsOvXz0a2h6+d3f1j5e?=
 =?us-ascii?Q?/9zE2kwh5a45TeJUeOjhvTJ9LQegxSRir42jZoLduNnHGc+snuhbC94Uoo70?=
 =?us-ascii?Q?EXIL5kE7KmqbQYnpnTBepnJhZhZ7cXE4z1G9X3VaNS1FX5ylLlz0jXYBBbYd?=
 =?us-ascii?Q?TRM+GnNmp3j0xEyw5ILQLlC4Az2Nnu1tRdE4lQX8sU/IFjtn7Fz/Gh1PYxoj?=
 =?us-ascii?Q?2MzW9DMasYR7zkDbXekeYlXEIgLoxIyw/zp25UHWXZVg19GFvx4gwdZq/fD/?=
 =?us-ascii?Q?FbBBhYMpyFOnMa6ap399vD7DgE4xpSGMoKnsSpGNgV08fEHPdXYjWJ3QAC85?=
 =?us-ascii?Q?CBGWEKd4DrBcFBksymh9a6jlOGbvybw0wrHwTXUvy3RZ8x3ZC0VwB0oHOwAg?=
 =?us-ascii?Q?BXmFcsrKIYYMVX54mpP24Tcm/03yCkqL0BjC2raQWRmKGnr0ql6Fz3Bivskm?=
 =?us-ascii?Q?kXRtBM6KclM1dnTu+hrvqeFOpl9WPufL9l2tk4gNlmtfTQN0Di0ywjn0WrRY?=
 =?us-ascii?Q?9XQgiPU3OMzyFmxCYqLyt0Jiz1zZ9whPRvIrUDH5HFAvoDavMgv0GKTh75aZ?=
 =?us-ascii?Q?n8Dy/hl9fsqThJyfor3AxrXm2RtHY+HUD4TmWh4QYWg1uzMPIRN1ja46gw4G?=
 =?us-ascii?Q?c1c2yLiSZmX5zSyPBzo+sPWOWgxh5/HxigHp73na3EB9zg5tC6rhs+dAdGd5?=
 =?us-ascii?Q?xLsXuiUr4wppxHID6XyUre8zRnIMQq3ChA1QQOOU2al4JL8B2WwahpEM9VNu?=
 =?us-ascii?Q?bua+fYYEiBtaBTP/S768rfebYau9NpGGZkxw/0lEs91qFDKL7m3rm3vurQ9n?=
 =?us-ascii?Q?MsDzA9lO6iXBCeRVP4gVgPVGv00yty84wMgxob29qKwxIS1+XjrDXrL35Da6?=
 =?us-ascii?Q?jEQHUhFr5JLInJyGUh0xnvCiqJLbb+PJmTbSHn721X9aPJSFlq3JeTRriHXK?=
 =?us-ascii?Q?uhh50NKVfXfi2W/O2XOa/0ZvcRUzSJr4/tYQeu8bdsuAXPyuMVj7wDEePV+W?=
 =?us-ascii?Q?pjv8CKl/TbveupTnJv8r08Ju5Ugi8Y8S9gB+/BImRKWJ/tbMMMI4OUmkEm72?=
 =?us-ascii?Q?7H9BhOxDsxhZ5sbFflS7GzTrcSBfObQRMNE2UmkPtHC3/LGzJsTrOEIuS17e?=
 =?us-ascii?Q?1ATXj+jqM84BjX6lbzKpmZSB+neYosadDwI9rzCQASOQ+K3ChVXXP8iJZToD?=
 =?us-ascii?Q?3Z0wdJHUuL5OmYGtaG4d8RPnbf1IjSMan650wHjjo5sBU1cmSvWiZ2jDN1V9?=
 =?us-ascii?Q?O8U1QHVkA2u1kf0wGX3fn/ZQyKfW6binPJmr0JNe93mURmqUiRQ8rlXPcuBQ?=
 =?us-ascii?Q?9HcFaPjY1ycJJN0eyTW52MmALo6Jq7E3/6chKfikwuURMCr9B/YXI4V0Cx/U?=
 =?us-ascii?Q?zzZb7fNxQ7q6zM19SlCPFP9Qx441zSkpJ1EwYgeZEjtd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PPF68D57569F.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(34096008)(366016)(38070700021)(8096899003)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/NOMjO4roXKbIwdKjh5IHIImTAGwRMfEXpqp+3D3zJAHwqAcigDswlYJviW6?=
 =?us-ascii?Q?OHqeKQiBmVrqF6cZAH+v4V4JxGCt+5Bf6geSIGxXWLpm40ODxWlmfqLc++Fq?=
 =?us-ascii?Q?bAFd0FugG5O1BWS+ccbMLUEJ+u10WLME5M3xA0w7HG2f/ZKeCbLPztZgn22l?=
 =?us-ascii?Q?bHtCEsOTMbg5eS9ZL8Zz3E6Q4vmqeI6zPs8RRRULL6h3CXzyEpHBn7xWdlgb?=
 =?us-ascii?Q?a7VBXIscGcr+icJwk+PZsGeY8FiXUhqlmFNj6ax2JVtnLs9ESgPv/NYtU0/g?=
 =?us-ascii?Q?lUdoXPyhmquEmefZzfe0k+IVF0FB+l9t6cbTKeHjox/F66W8RUWbk83hE310?=
 =?us-ascii?Q?iW5DVFMiRAm6KFG8K4ATMTEF8SeAqmXIPJ5ZFXAR5bVjKgqArEWL0mJun+tY?=
 =?us-ascii?Q?dyxUtrOu8YRpJAEB1Spo3B0BD8k+6NX9YduCVKzOlHPYUAMpWQv12kxQrsmU?=
 =?us-ascii?Q?paMBXFQp7/KxERIrTtvZd/Ww1va/x6jO6q75L/8nJ9l+ujpt8pY4yckviLjC?=
 =?us-ascii?Q?0BIXROLs74d29c8bRQgXO4ls3QdxohlryYIongJO8c3XwWi5RtTxGiiA2Gah?=
 =?us-ascii?Q?rffNOQii8GGPm0G3G7h5z28NVrA9/SJnzVSO17ngrD0EM0UwNovm/CpBNepy?=
 =?us-ascii?Q?UNoTe44fPaqqMIm0ePuNNJ2LX56h62aAFsak1THd6iZeeoR1sNaRdfKt9S2E?=
 =?us-ascii?Q?jhKWhas8IlcmnpZ780SrEHYfaSt9SxSsauAQ+WPA7gec9Ze4SwpBJiBkHU8i?=
 =?us-ascii?Q?UxgOnVG2GyKbJ3CNe1AKuJGy7bMqFbqGbBd6VbMFM66JyVcZJzrWLwDWJtvW?=
 =?us-ascii?Q?1vYDcNamAaUE2YY8tfUzrck/rxkKG3QA/NAtGNjvCqYVNhadR7PldoZYinAE?=
 =?us-ascii?Q?c5ytlnDe1JpI69ZHU+omL8hJlAzaQvzPtIi+q8yzGVGVAsfPUjPoBACBKMsL?=
 =?us-ascii?Q?IhDMcAsduE0OMc5uUCYuQ8q8NFA76QmJeqOlwSIV0lzGe7BVk4rLgBWj8dt1?=
 =?us-ascii?Q?lNrDqQoEpNd6IIpm0/YuD5v0SUTd5ppD7rDrhPgp2JEMCv1a/dT24a6A+87H?=
 =?us-ascii?Q?CxR4n0lbCxnDSjWjswEvKOj0ueU3HCskHNBdtQRb9HtEnymqa9+VROV68qxK?=
 =?us-ascii?Q?Hbx7onbrJ4sJFSCH38wqBkSEYFonZhNYBhfBowXhIDR1sx9nGXB7VaohEzPf?=
 =?us-ascii?Q?0l7WpKDfEwGk06kznKIXKBEeRru+l/1CD4o3G85F189NgvmtdSlqE+btbfkS?=
 =?us-ascii?Q?ObWp/nzTBKb06IncU1rSaKZotkleVOXgXYftNIT0nXxoAGFzvcgA9UaAEmhb?=
 =?us-ascii?Q?Ct33lFQpYg2LwBgZTJlJ22xGFVzGkenkB3uC7GiLtMadZQ0Mss63qD+4h4Iq?=
 =?us-ascii?Q?9DeOKqXv2vwHdF80G8qJFdvRZmE4E+rUmzyUgDbPXBfPEgKcAiPjZJmGtHhs?=
 =?us-ascii?Q?jgVcdzZZvp/2WurCHOkbYpg9qynfMNVe9jukIlbHbebfhVq+WrOP/iY0+XP5?=
 =?us-ascii?Q?fVYlu2x9/XlpAP/TSEJDFFmy+K6uZSJ2WV6fHH4Eq27v99oJPQmQ0RSWrEGg?=
 =?us-ascii?Q?mUs8V1QC/ewaZoljnJzg9ugsW+bn+qVj5ntwV048pEmoyBtbMC4r7P42Yb6P?=
 =?us-ascii?Q?pom+b/JjPwfcRJDfBggbYuGHejGGSzs9FKNYD9Ej3rb4kCiC1j4Yacuqlp+i?=
 =?us-ascii?Q?HJhbgrXIaHp1bSHAQPFJII78rDSVqCnSY5V4OnN4WCMNezFktMwy7XWciL17?=
 =?us-ascii?Q?mEZiNHGXj4Y88WPp5VqSKLqiVe1/uQ4=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PN3PPF68D57569F5F0A69C6006954B28A69F76FAPN3PPF68D57569F_"
MIME-Version: 1.0
X-OriginatorOrg: schooldatapulse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PPF68D57569F.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e91bcf-63aa-46e2-4b5c-08de6ca72b44
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2026 15:30:37.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e66803c-05a0-4019-8fee-bc386425d76f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fK337lKWQ3jB8qWRdVkMGkqDbd/5NoX76OBDNfhuX2qDETxO6ZJA4YR440LLrmFXAUUKuanYVk7ZZHzKYhk9+3/Ct4gV5WQe2oAB8XJKby3/7kSlZAFrItUdCzynFaey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0612
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,HTML_MESSAGE,KAM_DMARC_STATUS,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN3PPF68D57569F5F0A69C6006954B28A69F76FAPN3PPF68D57569F_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Would you be interested in a 2026 verified education outreach database?

Public, private, and vocational institutions are included.

Roles covered: Principal, Dean, Registrar, Student Services Head, IT Manage=
r, and more as per requirement.

Contacts are structured for targeted outreach.

Pricing depends on selection.

A sample is available.

Best regards
Allison Price

To remove from this mailing, reply with the subject line "LEAVE US"

--_000_PN3PPF68D57569F5F0A69C6006954B28A69F76FAPN3PPF68D57569F_--

Return-Path: <SRS0=vNvE=7K=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021072.outbound.protection.outlook.com [40.107.51.72])
	by sourceware.org (Postfix) with ESMTPS id A87524BA2E04
	for <cygwin-patches@cygwin.com>; Mon,  5 Jan 2026 12:40:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A87524BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A87524BA2E04
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=40.107.51.72
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1767616819; cv=pass;
	b=XgA0jTw4fMXKs+aA2XC8zNE6lh+luAjtMJ85M9gDrj15al5WWfNAhhLeffdTUAMyAMsHpiB0cKJU1Rq7oD4zxTLDlEL+YRzNuEo9clk/bkYZmIEDLSENWYw10qCYjIq5cgpSo3uT8Olgx/husMDp7KtU/BnCjnOSXtdM0NcRjxQ=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767616819; c=relaxed/simple;
	bh=q4LYKomdHGHitcIupwrCv6UfLzq/ZKGoqtI+AGnoINM=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=p8PVrMTfuZh3qxfsQ3rerJiRN17jFOQn6AaCNuWVYioLsGsW71vpn+/YVg5ndYi5RONSdzjdHasFsgVJDr10Gf98soXYd4RUX1hy29MKHo2uF+lv+bAhbtZMzuD8isMy9vNbFLdRYRMGXVOGuX6jrhCR1wQsjAaj9jUguISTbiE=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A87524BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=YcoJu/Ym
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7KquN1OwcEoK90e3JlwEva0cUztASCd9cL20Jle/7u/UFLkwfcCMBqrPbzm8lpPiwF8Zgyj6waAzN0TLWWjIlN1g7UTbqqVzH9vvnKkzslfT4rLSE1XKUk7xSqPT4pDd0xPEqmXfjkaSRL4EupE0P0E4mHPtffNYCHqggCw4StgC52NEh/ZlzSYlB5K4IijQfe3fqom23ikeq4UUoyhQA1j4I4GIYQiJDYYpUJNIFA3cF+KYjP+LgiiiDRLkwzgVXTbLju8jdMgLXujktbaN4DbwLwzHOlwNSDDNwz4gFhrQUxtsaP1sdxfR9RgDMaGwodWnDR6K1Jt8avRwzFWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynq88u5vazZDi8WcX6yDQjlCQT7woE8wZzev1i/Bgs4=;
 b=SqOhzZtrup6EMi8kKGGJDGtFbOX03Il5tMcLOGHclyGBW/Sgo9Luyxvv04dAUCK7Y52bxNfUemrEev5P1OeGo7/RRgcso3IrbYY3bwZXjSOMa0N+TcsJLlq82uwWID6uIjliwYf114VQeTNj1Jj0R2Ug5zFe134OdSrfyA34r7HgYPiNQT9qTFEB45XtT49xQ+P3KOWmA4l+yeDlYSZQrvx3vw4dQ6aNvYcKNiOfhvyEyYLSdev3WJINCwa2PH3yM+tJIl7kzqJrr6F4ZB422V2J6DZh9YcdBq5JTMpEAkUW1PNlbn7uUq7sHudco9WpqfjncMf9JSxyHfklxlORPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynq88u5vazZDi8WcX6yDQjlCQT7woE8wZzev1i/Bgs4=;
 b=YcoJu/YmkutcKCkLkMbr+3pJZi8L79Hp6R4DVAEw3nTmHSdaXazr+UWNsox/NHFwxyq/RYpgTjaS6r/dmRAWacMwC+iiYX0B8hjWtmo9G59aa3qVr1xv2r7rOyr0GPip2d21KRH6o0CTIWnoFUYzrX48rzRQYc7vQ48PBI9pHpJMzpLHj7WBZ4l83bKBVXnG9Y14gp9L+LpwQOC84zSxcx184fUTWQBtfL2BcsaGAc+b6u3wIV245I0Noc717KyLbS5Y385d7BiXqmwBq0HAmu1kZHn5kgx//SvuWWSIrtqsxhBnPL08ultGbedS4IkLC8d8LEnzjl4TuLLmmYGj/Q==
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:226::14)
 by MA5P287MB5186.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 12:40:12 +0000
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3]) by PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3%6]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 12:40:12 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH] Cygwin: _endian.h: Add AArch64 implementations for `ntohl`
 and `ntohs`
Thread-Topic: [PATCH] Cygwin: _endian.h: Add AArch64 implementations for
 `ntohl` and `ntohs`
Thread-Index: Adx+QEk0XZ3dXM1KRUqKRVZ6HRTO8Q==
Date: Mon, 5 Jan 2026 12:40:11 +0000
Message-ID:
 <PN3P287MB30775977BEB79B12B2F3BCEE9F86A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB3077:EE_|MA5P287MB5186:EE_
x-ms-office365-filtering-correlation-id: e1719200-c693-4cdc-5682-08de4c579183
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|4053099003|8096899003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dJqfl1FdYm99PEWZPnzgJwIwDWMI7VUHRKSeVlUlLdE/z19JKqic2NKtZJla?=
 =?us-ascii?Q?ZEaAS4vemP9JVT0//g9rifybiN1f3CWh1tr8qp1fUg9QjHu6D5EAkNTtpkav?=
 =?us-ascii?Q?r53degHaoVnVK1xcDHYxWssrOvIybLiMBoOgDBlvvdbPZBfuyb6oKc967+iq?=
 =?us-ascii?Q?GsRE2mkLqai0eI9Fj8nKHIZhvElXKOGEr25n4WKhM2GDN5xG0vvbBqynstj0?=
 =?us-ascii?Q?hfDj/awnIAvouroqZJxAZr0tZRmrJ3c0xI6ci7MRIKn2xbu4TsZC49KLFL/b?=
 =?us-ascii?Q?M60GDoV4jZFRMCTqK1eApbGL8csD1JIggU8kP1XIOvae53XpDuru1nvARpEx?=
 =?us-ascii?Q?Ug4w0G8psRpWvRBpf2F8DRzmpinSGiO/d+RxweuOoEOIibHS9Wz4g7nq7RfG?=
 =?us-ascii?Q?b9hS6Z7TiBjAHvxaByGQyAaEWzVHQrnZvAgVbuYWMys7BloZRgsaXIyJ5OzT?=
 =?us-ascii?Q?/ogSnJBzzph1am62c+949YPq7NAaNI2I4XioCIaq2AYjIhnzK7UsLhtIJHQS?=
 =?us-ascii?Q?y0O4eibucRp8xCWRV4RrcLTkZL+Lw0K3U43C0JZ+R18ig1RIMqe5K5Es/TPf?=
 =?us-ascii?Q?xihRrAYORgZm4zvsmv8zN0aXIs1cY+SW/vb+1Q3eJx736WhhjUCfAMknCstK?=
 =?us-ascii?Q?yzKYmWydhvc9ogKXVlwvDsoq9YMHbu/uiT6Yi+cKiliwKX8TkBMKVMoGHXrH?=
 =?us-ascii?Q?Y0I4l9hvAIytDVcwijTBWLB/z6acdgBc6Un07u3rChi61uITbzlrF5YRf6Wj?=
 =?us-ascii?Q?oIAMpVY9lO9GM6iXSQ1Qj3mF5M+SLzHYfHvD9M96Y6288xZi9m8TbGVSIZkf?=
 =?us-ascii?Q?KuJt9PBQt8ARj6IQL4JJM1Zz02oiIiaxQUJgLBupFl88EPH1FdgeeSJ+/+vu?=
 =?us-ascii?Q?DUpLgfYq97HhxwKQkhRPzHE5mO5VbsUHMjrT5ieH+I9MsF1bS+d4ZtwUWY2q?=
 =?us-ascii?Q?/rl78AIibEMfo/06VNFqrbMoZA3GqtcBmsrbNWXx+uMZ0TAexXwiX2J+nOjX?=
 =?us-ascii?Q?OfRglqUMh3pezQp7liJX6rxkVyk1r4tQBzLEkzIfxGO6Z1EAJQ8nH1WBFP2J?=
 =?us-ascii?Q?aGXdoMkSD7rtyKFEeGO66VTH4zStXwkXLUezEP8t8vmDGCRd2b4lat1Tn7nX?=
 =?us-ascii?Q?fkCj952tC7oLzPt2Uffr9CLftl9ZkOv9mD+Owcyp7b6ETY3JvrLS2F7mhYil?=
 =?us-ascii?Q?9pQmj/MS/Op6uKGYRU1T8pk6FCd+R+pIvJfmVrlRLblkEn1iIikU6e5Aoblc?=
 =?us-ascii?Q?q0u47/VizQcQBScgvP7R3Ni545yw7uNsZIXIsfaNm6pQ/ZLf4Fp2I0izFCM3?=
 =?us-ascii?Q?dTCrt0TzCDpsLnJuwh0Uz7GQRyZV0SBtz+OKGT2pvrfjgyS1y2z3rWJNA74K?=
 =?us-ascii?Q?DsS3UeUr0xcQ2AqqsyzVblMiqZoPJTl/2OE6SqyURABuPD72VVoSJBWyugrL?=
 =?us-ascii?Q?8EWY8Ip1xbS6agYUmynJx5pY0XIxiMnbDsu9guhibmdjP26fdg9wI+GnwSfI?=
 =?us-ascii?Q?rUe/LjfdHSNDGnihlkpBjYXdrnwhv5/Ym/1g?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB3077.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(4053099003)(8096899003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WfH86ZNh2LYjxsjCQoL6n6RLljhSxnGxDHdWPwQDmtMfKnZXOUZxhHgcCO1m?=
 =?us-ascii?Q?s8zV0r27UTBbUpfPcu+5Y2aNKCDrvr6B0hBQdyGQ5uBZc5Hh6+lOMJi6Twnl?=
 =?us-ascii?Q?sZ8MZxio411sfyd5FhbW0WnTuGRwt8CoG0WLhsirnXpqjDQqxpIiMW6e7Gq1?=
 =?us-ascii?Q?+r3uyEpqg5P3MZ5LPbjJDB5tKXzE6Wnwfh9WhiZLufaEotui4DqP8BpaVa7m?=
 =?us-ascii?Q?Oph7j0FJqCLF2ifiHxrJ0daNcqcPZ45qLKV9O2Lix1BnvJ0ZGWSOdtyyMB1i?=
 =?us-ascii?Q?kAS1WP79v+pNmXBC55vLCHEk6x8rnHjP19h4QanyFh5ZBAeMPrQkzzNHbMFW?=
 =?us-ascii?Q?j4l61gAAoF8U8D+niNwE7PDQmKNPEBHsCvaUmj5Os2rLO0qIhQTFvfOXIoVa?=
 =?us-ascii?Q?edbU76bHFqXy/zgmiB8g+g6C9wO7QVDqbLEEQ8/hC23uG5s22raBIFhLkjdv?=
 =?us-ascii?Q?OtI7/J8niQcfxePhavYcc+JIMyCDgMYR14nHT4chg2+WvrbYGnpCQKgotvBz?=
 =?us-ascii?Q?b/gV0YFt00cxwaMAWvQJE6eOZVU6AVdADCl7CvEsNBHFGW+/AXaBFA3ynOxP?=
 =?us-ascii?Q?+LLckXk143PJihyDid3DQTbpoHzCfLR5vhYRCLStlWKKuN+N6E6fiIxaYgeX?=
 =?us-ascii?Q?N1w9I4e8JtCvaQ04G5GXZdAFdOgLjFlV/KBPEmbmqKRYVD3vCiFsHYzHD0Rf?=
 =?us-ascii?Q?Fe6JtZxUDAOeSBgwiDB/fcolQxftLrAmCQaiE8TUHOrcQ+DTaHsNIvxBmtbo?=
 =?us-ascii?Q?+BKQ+yq4qZg+LKQF0622jJXaINYSH50SubEnRyUHEjykwIxfKVGl38MFquMZ?=
 =?us-ascii?Q?yrCWI0NvdCeAVeJPz7+1NwwAE10OpyFs2UGEXcxMsa1pEIzpZbbDlxQLxt9Y?=
 =?us-ascii?Q?wPwJA5p0GK35mlEHBNDnleWKomH70b8kjb/KYSQnWlCL/6N7JsJ20Hpjsllu?=
 =?us-ascii?Q?0auEllP7YKIdwmiimzcfRr0cOOhaSAHRgbjqKp6U2KqanqbxNzvyqIweZNw7?=
 =?us-ascii?Q?AGOlNkx88GC0L8rHBLHVAdZQczoIaC6oDYaZTi2jVWr/08xEFj3U/pLAkWSz?=
 =?us-ascii?Q?uRikwXXIIJCPYBjymJP2mOn3Xpu0xJ8Lk85TjynA2Dkq4+BwgklO3t0Sr8U/?=
 =?us-ascii?Q?2z0XXYUXzx3Ml1OMLe2Qk/URXl84n66JoKw7aZCNE0DxOegxmc7EtCdL61ud?=
 =?us-ascii?Q?/Nf5GtGtBxodfWQTqznWwzVvYKuLQg+dmKZfarUQNycg/fYcaXBX7uoZbUzb?=
 =?us-ascii?Q?a0b3lZwGeROnLCjiceJR+YtihxxqjvONqD/iReB6YXA/o1G40dl7bdPJCbNo?=
 =?us-ascii?Q?BIUesWkRU8MepiCVtqZGl9+KTd2Nqnio5K0hB2BG9uG1zqKOrWUn59GGFL6y?=
 =?us-ascii?Q?plLkAk1WERsTZnn+aWoUx5vOhAigKzmmgsyD7x+jf4ANJGYjQ6neijGy3lyz?=
 =?us-ascii?Q?C+dXKVh0piRrFcXYplAJSQ+Rp+MZgNWHsrfkcX656K9J6vB9Z0xBfa5kbtWL?=
 =?us-ascii?Q?04dCtocV2VvLUnPdr8ZjZ3HbsFMgn/VSA+aC8bXjW0lyx/ugRuLkLi1YBqtU?=
 =?us-ascii?Q?WFmTSgvuY/qdSYRhYG59H+THzgkCPv3k29T7Z5MxPGYCCebXLPoMXj2b2INo?=
 =?us-ascii?Q?TuD+meDwTyju+lAY+7K4FcwSwkUtV+pkBgav9iX+VQBYMzXA1t7AvztHr9p2?=
 =?us-ascii?Q?uwq8o4VyN72HWgmKQX4ChR6sc9x0+aouHgNtGRR5ifBkcvwi+lyEmjI+azYU?=
 =?us-ascii?Q?zOuHJwQ3fZqrYgkwQYXcsqxdFnVSfEYeapiWT10td1iwhpg/ZfvR6GQBDTbn?=
x-ms-exchange-antispam-messagedata-1:
 Ve86KLPBUN7+H6QRMhmM3eAytlzNW9S59m73lqPfAfyzx5ygvcN1Rhnl
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB30775977BEB79B12B2F3BCEE9F86APN3P287MB3077INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e1719200-c693-4cdc-5682-08de4c579183
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 12:40:12.0210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07ZUYmZs8qF880/aM7ClJ9nx8sFWcCWICFt5mou8a7VK3qLGU37uveBoGmxwrn8O0ikAxnq/XmTl3rS0Bp2dUyqNAoyOqPk5lAstD3ymiqGqYDWTStVPSDe2vFEgbWd0HwVZosdxfUjYTAVkmJ01Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB5186
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB30775977BEB79B12B2F3BCEE9F86APN3P287MB3077INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB30775977BEB79B12B2F3BCEE9F86APN3P287MB3077INDP_"

--_000_PN3P287MB30775977BEB79B12B2F3BCEE9F86APN3P287MB3077INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Everyone,

This patch adds AArch64-specific inline asm implementations of __ntohl()
and __ntohs() in `winsup/cygwin/include/machine/_endian.h`.

For AArch64 targets, the patch uses the REV and REV16 instructions
to perform byte swapping, with explicit zero-extension for 16-bit
values to ensure correct register semantics.

Comments and reviews are welcome.

Thanks & regards
Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com<mailto:th=
irumalai.nagalingam@multicorewareinc.com>>

In-lined patch:

diff --git a/winsup/cygwin/include/machine/_endian.h b/winsup/cygwin/includ=
e/machine/_endian.h
index dbd4429b8..129cba66b 100644
--- a/winsup/cygwin/include/machine/_endian.h
+++ b/winsup/cygwin/include/machine/_endian.h
@@ -26,16 +26,26 @@ _ELIDABLE_INLINE __uint16_t __ntohs(__uint16_t);
 _ELIDABLE_INLINE __uint32_t
 __ntohl(__uint32_t _x)
 {
+#if defined(__x86_64__)
        __asm__("bswap %0" : "=3Dr" (_x) : "0" (_x));
+#elif defined(__aarch64__)
+       __asm__("rev %w0, %w0" : "=3Dr" (_x) : "0" (_x));
+#endif
        return _x;
 }

 _ELIDABLE_INLINE __uint16_t
 __ntohs(__uint16_t _x)
 {
+#if defined(__x86_64__)
        __asm__("xchgb %b0,%h0"         /* swap bytes           */
                : "=3DQ" (_x)
                :  "0" (_x));
+#elif defined(__aarch64__)
+       __asm__("uxth %w0, %w0\n\t"
+               "rev16 %w0, %w0"
+               : "+r" (_x));
+#endif
        return _x;
 }


--_000_PN3P287MB30775977BEB79B12B2F3BCEE9F86APN3P287MB3077INDP_--

--_004_PN3P287MB30775977BEB79B12B2F3BCEE9F86APN3P287MB3077INDP_
Content-Type: application/octet-stream;
	name="Cygwin-_endian.h-Add-AArch64-implementations-for-nto.patch"
Content-Description:
 Cygwin-_endian.h-Add-AArch64-implementations-for-nto.patch
Content-Disposition: attachment;
	filename="Cygwin-_endian.h-Add-AArch64-implementations-for-nto.patch";
	size=1554; creation-date="Mon, 05 Jan 2026 12:37:57 GMT";
	modification-date="Mon, 05 Jan 2026 12:40:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4MmQ4ZDcxNTRjYzY3NGMzZjU1N2RmYzU1OGJmMWVhNmUzMTA4NzAx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE4OjMxOjQ0ICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBfZW5kaWFuLmg6IEFkZCBBQXJj
aDY0IGltcGxlbWVudGF0aW9ucyBmb3IKIGBudG9obGAgYW5kIGBudG9oc2AK
CkFkZCBBQXJjaDY0LXNwZWNpZmljIGltcGxlbWVudGF0aW9ucyBvZiBfX250
b2hsKCkgYW5kIF9fbnRvaHMoKSBpbgpgd2luc3VwL2N5Z3dpbi9pbmNsdWRl
L21hY2hpbmUvX2VuZGlhbi5oYC4KRm9yIEFBcmNoNjQgdGFyZ2V0cywgdXNl
IHRoZSBgUkVWYCBhbmQgYFJFVjE2YCBpbnN0cnVjdGlvbnMgdG8gcGVyZm9y
bQpieXRlIHN3YXBwaW5nLCB3aXRoIGV4cGxpY2l0IHplcm8tZXh0ZW5zaW9u
IGZvciAxNi1iaXQgdmFsdWVzIHRvIGVuc3VyZQpjb3JyZWN0IHJlZ2lzdGVy
IHNlbWFudGljcy4KClNpZ25lZC1vZmYtYnk6IFRoaXJ1bWFsYWkgTmFnYWxp
bmdhbSA8dGhpcnVtYWxhaS5uYWdhbGluZ2FtQG11bHRpY29yZXdhcmVpbmMu
Y29tPgotLS0KIHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9tYWNoaW5lL19lbmRp
YW4uaCB8IDEwICsrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRl
L21hY2hpbmUvX2VuZGlhbi5oIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL21h
Y2hpbmUvX2VuZGlhbi5oCmluZGV4IGRiZDQ0MjliOC4uMTI5Y2JhNjZiIDEw
MDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2luY2x1ZGUvbWFjaGluZS9fZW5k
aWFuLmgKKysrIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL21hY2hpbmUvX2Vu
ZGlhbi5oCkBAIC0yNiwxNiArMjYsMjYgQEAgX0VMSURBQkxFX0lOTElORSBf
X3VpbnQxNl90IF9fbnRvaHMoX191aW50MTZfdCk7CiBfRUxJREFCTEVfSU5M
SU5FIF9fdWludDMyX3QKIF9fbnRvaGwoX191aW50MzJfdCBfeCkKIHsKKyNp
ZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJX19hc21fXygiYnN3YXAgJTAiIDog
Ij1yIiAoX3gpIDogIjAiIChfeCkpOworI2VsaWYgZGVmaW5lZChfX2FhcmNo
NjRfXykKKyAgICAJX19hc21fXygicmV2ICV3MCwgJXcwIiA6ICI9ciIgKF94
KSA6ICIwIiAoX3gpKTsKKyNlbmRpZgogCXJldHVybiBfeDsKIH0KCiBfRUxJ
REFCTEVfSU5MSU5FIF9fdWludDE2X3QKIF9fbnRvaHMoX191aW50MTZfdCBf
eCkKIHsKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJX19hc21fXygieGNo
Z2IgJWIwLCVoMCIJCS8qIHN3YXAgYnl0ZXMJCSovCiAJCTogIj1RIiAoX3gp
CiAJCTogICIwIiAoX3gpKTsKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18p
CisJX19hc21fXygidXh0aCAldzAsICV3MFxuXHQiCisJCSJyZXYxNiAldzAs
ICV3MCIKKwkJOiAiK3IiIChfeCkpOworI2VuZGlmCiAJcmV0dXJuIF94Owog
fQoKLS0KMi41Mi4wLndpbmRvd3MuMQoK

--_004_PN3P287MB30775977BEB79B12B2F3BCEE9F86APN3P287MB3077INDP_--

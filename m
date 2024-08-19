Return-Path: <SRS0=bRA/=PS=ufpr.br=amanda.santoscastro@sourceware.org>
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02hn2238.outbound.protection.outlook.com [52.100.160.238])
	by sourceware.org (Postfix) with ESMTPS id D56B5384A84B
	for <cygwin-patches@cygwin.com>; Mon, 19 Aug 2024 15:56:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D56B5384A84B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=ufpr.br
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ufpr.br
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D56B5384A84B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=52.100.160.238
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1724083002; cv=pass;
	b=YCcQWV0GFURAjgVNcVTPbtUA7Jb051GSNFimDjE2XoO9yQg4ofjaW+k4N/ewr92oI9aT6hebIjqjHpzcb3ajVMUutyXWYjU9M5CaPMqchnsPSXFb7Up8MIFGgnZDS2OR5mvKIq533glA+poEqFxe8dNvkCoV1iJAIgFjsroGrso=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1724083002; c=relaxed/simple;
	bh=PLrwMwXCAyNTW9VVDr3SHSYETAp0Tdi4EDpFbVNI0SU=;
	h=DKIM-Signature:From:Subject:Date:Message-ID:MIME-Version; b=KvwBvZFO8vITFRPoBASU2hQqPDsUMvrU0F53EbdcwWsnPW2xQcvQ8zh6SW0iR0tP2lXY8si3CFlYbL4zWW1KJtCKx1O8mb0Q7DEMCyf9LwsroS+dOuidU6cFkb5uYWGp0iozg1ioyOQcetZ8w8/6o9tjSZqNyXXOClOvpjFAXWE=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9InVS/QejwwPTFRL0Eegi3h2p7X2fbMABPjwSLVhexVViieMKHIZc4E/Hsn+vUsr/Sjb2wQrYgnKTjUuVSAMGJOfdfGqD+ooiRAM7TC0EfwEk8PLlqkjV/Hcjz+jyfS7+jdxCNzuG802NRipbhyXvd58SyvT9ZqQ5MCprdEbdhYjH26akjW9kWoUoKqmDI9NHl8Fmd97oHRnKFL1c1GR3ZhiADx2ZUkGJD7oalHPbQATToU0Syz9M2/sU1tdIp2kiL2NMHvVAg2A1WrLGrtkqwlVUmnEPDsobwmhB34Yk7v15xdalAskWUWX1XQvSuYDpmygbsys8yZM9+fS3XAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC6KFrhTM8Mf9Q+lRV6b7pKIk/YHlszxK6rjWFa7NTI=;
 b=Q1t0+4ohauJ+QVeZg42mDeSB2vagZzv5vIZHoYQxwNhZZIkxHKbjEjYoQj6xeCcLQMKMLumzGhB0hcP/7V2HyGFGtVA83LWCcF1mexEkn5DXdMfOIgpi8HWKu9vH0wJrJidJAh2Ngo18BlTUpKWbDD2ex9qKkzSAu1tzuj8yNzRwfI97X5cZf7YMZomR5bQ4wxxuFuIh5TYe614LYYeFQNOl0gX9wSca0zuu0aZVG7syHdJNJpUWSRrZAx5WrGrrMCcJYMUJ6GsBYH2aR1OhJJbV2PfBKCczFRfmZCF3x6g5oet2eLB+K9ZOYMkzwY97obEBgcNEQz8ZugG0ZxS3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ufpr.br; dmarc=pass action=none header.from=ufpr.br; dkim=pass
 header.d=ufpr.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ufpr.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC6KFrhTM8Mf9Q+lRV6b7pKIk/YHlszxK6rjWFa7NTI=;
 b=iVg/GWiJ1z8gCHMkGkz95EKnRva/02u6wmn+24pXCp8J39I7zMJuYp4EzZ7hqQ/Qq06GAgCis1nGr54w0gZfKii/Iko0QNZMVXU8pEbPHzh8tNcjKDNdkMrxSX/q66Vk5xFtzv/8Q7EAZyHfFI7PK1amearY5hp4yq+GmUVDfUzqS567dCFZEY7o0UOMrhWhaKHrpHtgYFmi79gYqu0qPIjIgY0hRQad2tOYAL9Ka+B6cmrbdzJz6t1+8ZtWPFnC7a8vDXr2xtdvtZpWPU/vHD2JcNKlfFep/gjMw9qjBhuYH0f581YW0WZohFYI3HcZhbOOvX6hPTvaMFTPqSWQ/A==
Received: from SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM (2603:10d6:300:2a::11)
 by CPVP152MB4607.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:15a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Mon, 19 Aug
 2024 15:54:23 +0000
Received: from SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM
 ([fe80::e349:6c84:3083:760]) by SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM
 ([fe80::e349:6c84:3083:760%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 15:54:22 +0000
From: Amanda dos Santos Castro Benedito <amanda.santoscastro@ufpr.br>
Subject: Let me know
Thread-Topic: Let me know
Thread-Index: AQHa8k+n45x2HlAIeUe0oK9HmdcihQ==
Date: Mon, 19 Aug 2024 15:54:22 +0000
Message-ID:
 <SCZP152MB5471BB3FD411B4234F6498B4F18C2@SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ufpr.br;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SCZP152MB5471:EE_|CPVP152MB4607:EE_
x-ms-office365-filtering-correlation-id: 59d3a46e-0ca4-442b-270b-08dcc06731c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|376014|7416014|41110700001|38070700018|41080700001|41090700025;
x-microsoft-antispam-message-info:
 =?iso-8859-7?Q?R9gl7FJVWiphfIY3jT+lV97kN8I4MZV0no8LEoH9ZCua+2T3wuow0S2r+Q?=
 =?iso-8859-7?Q?IPJDUxBT2wTJz/xKAjXEf4oMeJDykuovTcGv3jRYpgaS9UUPCVkCfMTeg+?=
 =?iso-8859-7?Q?2DFkwy0KEyzZ4sAe8LOi66Y6M7CsPLSz6eLVsveON6bd4bHiiTripVGzeO?=
 =?iso-8859-7?Q?AqIX7mcwyNvIZZdBLfRW74PalYovL9TGLrJq7Jb+Z7E00FWf3Y5FJPMh1p?=
 =?iso-8859-7?Q?UMkuijeAAzF7KbWajT4mpxXM6z90JDz5EItP8CFtSSKdWqi5HCpY4dFxoS?=
 =?iso-8859-7?Q?3S1HDGYKZsK+cqvRd/YHyxeg5cDStJgom0ya56XCdMYxvLZJdwK9zFb3bv?=
 =?iso-8859-7?Q?slHE4OvoGFkh72ObuYNoF9KTLxIJUyyjx7W1l3EAjX+rTcaaoFwthrhGkE?=
 =?iso-8859-7?Q?lIVvVXHEhyarkhT2b2GJzfI50TAvErRLMvsT/1xoLy6XW2s44uz2l1D1JU?=
 =?iso-8859-7?Q?HQ8CAX61beV9TxoL/i+9Lp+yctJ/B77zB2yK/ST75M/feKo5949QtlSyIV?=
 =?iso-8859-7?Q?PYlOoV//ymqKxnyMkuwxRxKZudqboBPh7GM1eXGSHAoObRcV4I5GkwaYq5?=
 =?iso-8859-7?Q?HnvCqhBiNCdUIyTNT1TTzNPa6wa+Wz0aJZGS1n0ge5bBgzgt11CBOjDyuP?=
 =?iso-8859-7?Q?+YB4Bdmi++EYv1T5/MD5nRT1Wx3y0jBooWXjECp7qaT3zXyI0xxZt0y8MU?=
 =?iso-8859-7?Q?dYW3zY/Bs7yX1huO5R3aKV6/EP/gZgM/WmUxwXnLrpmLHZr9fpJX7zQb+/?=
 =?iso-8859-7?Q?MP1clhpd/5XM5EvnrAoe4VRz5VoZyC2GYDO8rAROTrexkCq6+T04F8bft6?=
 =?iso-8859-7?Q?tFpF9Un2a/TZ03djEYgJW1FMsoOqWjpHoJIyjGhR/S4ydHaWqvZxyxGQ0L?=
 =?iso-8859-7?Q?+4ZExGk9AgfeWWZG99+95i1XbS6fDFo6TfAWziQbbEp5qnkSlqn6eswYHj?=
 =?iso-8859-7?Q?U7fxTLrWzm0WG5lM7QEh4NUC/2HkQguziAviN+V5InyBhdq5z7p46Uzzc9?=
 =?iso-8859-7?Q?af2yW6+lPJK4HYCzgYAWsXtEnCl8IscFGwfF2nXt+/CKYt8mndZrgaa/fH?=
 =?iso-8859-7?Q?gUosX/UvBwU3fTVsNVH2UCRUhnGdoyPxxutgEZtdcdF5/Bf5wXYFY15qbK?=
 =?iso-8859-7?Q?egf09JUJJKcl2Nes43RDo+ZVn5T/ZcufBkjZoK60AULgvrxeWOFOR9HNUx?=
 =?iso-8859-7?Q?voEbGTto0X1m/HnDV61nyi0I+c7XCEvOQpjIteR1bY2f4heth5czyTDR3g?=
 =?iso-8859-7?Q?OQiiHnHKMrMQAy45HVN8IJIRq0xr2GnSGUUFfD841+3nynHwj3GIL+6lo+?=
 =?iso-8859-7?Q?bFg/SfMpe/ghm/7aSQ1fGxMQKwHP8l7/QdAE+bAsvUmtQx/ks8m2FAZPkh?=
 =?iso-8859-7?Q?6fYKSKMFI0GQwEJ283BqjZnLHkx/POC4zEaPQ+adjJyI+/6GMsppJ3VR0O?=
 =?iso-8859-7?Q?V1ovJ8amTvu09dMGri0hasI/hij6PDwqZx0JmHr2wOoIFKMfa/jRQWdN/d?=
 =?iso-8859-7?Q?a/mnGTXye2LgvVZNCrUTYpHiE34EypGytDVYcqrq+TxA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(376014)(7416014)(41110700001)(38070700018)(41080700001)(41090700025);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-7?Q?7O4EhQK1VWPBy6+gyWJlKeYvgVXhwAVgycB3vDnUzOyZO/I2rAZriwRu7C?=
 =?iso-8859-7?Q?BxMZE16QwhghkDD6T+xA0TwF+IM2ARaLw92tpuvRlxyh8jOaP6nV6i9tVv?=
 =?iso-8859-7?Q?eNIaEA/v+QdlSkwl2zfAmXrnIRHN/3EKMJ7EedHCxaDh7/8P5lxKhbMCGn?=
 =?iso-8859-7?Q?7SsRvJZjDEs3WA2dbRBb1jqQO/iEQwzNwOeiaCFXw57THPlLhAJ3lI36uz?=
 =?iso-8859-7?Q?WIPwWhEBkhRjsl0gjyOlSA2OXwmKNC4iRMWTey7QlAPh6EquCKQCtgWe/b?=
 =?iso-8859-7?Q?izVETGLZ5DeVd4T+/MOwV9ju4NEi8r41a8tfrqoHyAeTpfPYXds6q/+jL7?=
 =?iso-8859-7?Q?uhwlz58FtiVP26PBgYqp0ro5jhRs81F4YzXVdy6QWvxKb/gj5DcwtwRz2Q?=
 =?iso-8859-7?Q?9MDEta6wznTYaHy0PuvZEkFWfNqVknbiuNijlOux1h1US7XkbQGQj6mQeS?=
 =?iso-8859-7?Q?AHtasmSHyS+9CYVSXGgr/6jkyhs/bcqHvi9N40Q6MGCRZUVO1jEOpWaJn3?=
 =?iso-8859-7?Q?S7gSHRdZBYsY1lpcFqF0yTQu+XER6zA/3ksttdqwBDe8e/hWlDTifYE8tP?=
 =?iso-8859-7?Q?iX4L1sE3e0lxMj1Euf2vKhzGVuKn+kx1LGaiJVeyq5n8vkRu3dIvUKiGhz?=
 =?iso-8859-7?Q?2tOb9aRuY4QITe1zjrRTqfpDYVQLCHoDii0ic35eyFzdqT7CHWBigBos8y?=
 =?iso-8859-7?Q?+O8jSMCecfl3OvWaBYxeS5p7TAEwBXe0rzkAnzG526GKOkiYYwQ8pHmwdx?=
 =?iso-8859-7?Q?Fd32mPSJXHI3OkRBjGQegCKZzczik/YG/L5VqHC6avzqHEFROpkBvIfWMD?=
 =?iso-8859-7?Q?vkLxoAjsXs9EJlNKrSEtY85z/M6vUFhtuGdvEzQ8b3+hsycR6/iqbxaEhb?=
 =?iso-8859-7?Q?jrZvIIAwx9yqFjjzzI1fOfDrop58VWp/Htx35/x7a4aJ9PzysSeneYLfjI?=
 =?iso-8859-7?Q?XYvtHJ4X/h3Q0qxECao+trb/q5vOQsp9QgyiY7gdrzZmpZEARtdVQ8wypK?=
 =?iso-8859-7?Q?hOPQ18lWwbbD/PH2iY5j96qQ9iy9JgfRRLc3fQoc7nCCmGS9kPB25jeXMM?=
 =?iso-8859-7?Q?1ViG13jUkF4AJub6CKKZOmrXaqq//ybddEbGL/1+5lK3PadYwGRJlmkGGh?=
 =?iso-8859-7?Q?yYtQ3iO2M3pjdNjk2lSIQ4/VA05baG4JadKamNPTKwFyIESivex2jDum7G?=
 =?iso-8859-7?Q?0RZm57TrA5RxWZH823h8XYVJi6Ns4nGufnyaSSBXV/SzY5lcw5XxJzJaOR?=
 =?iso-8859-7?Q?+vkeu+CtRP8FwV0u9Wp3Elnh/v86YcGazGHvVlW8lXxaaqw+xU8zW/StHi?=
 =?iso-8859-7?Q?sF9zU2ncyYcZldvAZuapgAC4ZWwuOG7jqSw4REPb/7j+GxI8WXapNEmajv?=
 =?iso-8859-7?Q?WFM1Gs8nqVz0Qkn9cwYjkFW4rYeKcnDYliUD0oDd/frVzyPkufl25/uwch?=
 =?iso-8859-7?Q?1zyHzFyQrcrrA9dpuO7DQNIgolRQSxDiPTCtZbJdpHJZnMr3PscwBB73eC?=
 =?iso-8859-7?Q?kFr129wZ45sMxrUma+1L4G457y7EQwfMHxAd0Wz1y5cBDCVKSnIX4WeMMV?=
 =?iso-8859-7?Q?meseeZ2m+qO7dPE9W/TC2Qzjq7+ENkPKdCGXuWmK5DKzwy5xBQfshRXeU3?=
 =?iso-8859-7?Q?Fo+/84ukSELZPOimHLaCe/kGz/q7bM346G?=
Content-Type: multipart/alternative;
	boundary="_000_SCZP152MB5471BB3FD411B4234F6498B4F18C2SCZP152MB5471LAMP_"
MIME-Version: 1.0
X-OriginatorOrg: ufpr.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d3a46e-0ca4-442b-270b-08dcc06731c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 15:54:22.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c37b37a3-e9e2-42f9-bc67-4b9b738e1df0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ow7te2UViPMvMN3a2fOrFrZAZ5QJW2u+gM9KYyO4osFhGYzPaP4HxTfsJYoe4Dxze37qEwv5tMPVVnN/BDQTncLc1lqxrGtT33slIKh7uyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPVP152MB4607
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_SCZP152MB5471BB3FD411B4234F6498B4F18C2SCZP152MB5471LAMP_
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

Hello,
I'd  like  t=F3  kn=F3w  whether  y=F3u're  still  reachable  at  this  ema=
il  address. My  b=F3ss [abr=F3ad]  has  a  business  pr=F3p=F3sal  =F3f  m=
utual  benfits  he'd  like  t=F3  share  with  y=F3u.

Amanda

--_000_SCZP152MB5471BB3FD411B4234F6498B4F18C2SCZP152MB5471LAMP_--

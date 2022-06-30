Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxwayst06.hub.nih.gov (nihcesxwayst06.hub.nih.gov
 [165.112.13.54])
 by sourceware.org (Postfix) with ESMTPS id BC786385042A
 for <cygwin-patches@cygwin.com>; Thu, 30 Jun 2022 18:35:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BC786385042A
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.92,235,1650945600"; d="scan'208";a="250634907"
Received: from unknown (HELO mail.nih.gov) ([156.40.79.162])
 by nihcesxwayst06.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 30 Jun 2022 14:35:06 -0400
Received: from nihexb2.nih.gov (156.40.79.162) by nihexb2.nih.gov
 (156.40.79.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Thu, 30 Jun
 2022 14:35:06 -0400
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (156.40.79.133)
 by nihexb2.nih.gov (156.40.79.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9
 via Frontend Transport; Thu, 30 Jun 2022 14:35:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isX/yTdzfTQI2F6kVQ69ehsu4/cIKdoEBi2O27AGZeJ1w/0M66Xbo3dFVrxx7KsCIuHPjDd2hwsiC8v4XhflC70Q80a6gvjtIEv6Y/EUunvfFD6MNkiDnUPUgLdYOIbEslyA0ybbVKg/P/Qjy5wHbSKz+fP3HkHKo1cED98C7ZBBiy1wUywpsvBtLce2pbQnbHnZWNInzySsEbMtatvN5aRjYewr1XSDmA05aDJ3ql3KUcxDCZPedysMXjAiJmwCj2fvQUn9OwnUbPLQ7FAv/8jyzdBJoHiJrDPDJuoMx24D13VR7KwiSAVm123gRYQHHceu4WfBz7xguQpeXNX7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5NJCkNa4YnJU713B7Gl1F0uuOcHWz2f0oX9GiQ2yQY=;
 b=UIRalMruiYMGEINr1m0+RhIMupCTFvaGjr/EMZcxh0605ssC/Lk45b5fcPpq2TRP1xacheW/dnsOzWnOgRGsvTQQLq+yy1LUtjCXZsnWfv2nGf9pcipj+dbdEHI0hHH9wAO4llZ0NoMjgn/9yuJPqPaKfHLOJJeYpTc0jy7tnUkC+NNo+Q3GERTuqAV1rtf8TUYzcTeHsVfvnE7Lk0MqpWL51MaMUm2XfSd7RVWi5kQ9bBcuQ5FJvZSwl2cDQepX53wLBQatT2QIe4xp8M1VqpLYS2vwz3hE/NePr/EwNiAx1sHjdMiLeXq9DYlVZ81aCefMwiEQCgR50MC9ARbrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by SJ0PR09MB7342.namprd09.prod.outlook.com (2603:10b6:a03:267::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 18:35:04 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::282a:38f8:c3b5:8f5b]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::282a:38f8:c3b5:8f5b%7]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 18:35:04 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: Ken Brown <kbrown@cornell.edu>, "cygwin-patches@cygwin.com"
 <cygwin-patches@cygwin.com>
Subject: RE: [EXTERNAL] Re: [PATCH] Cygwin: spawn: Treat empty path as the
 current directory.
Thread-Topic: [EXTERNAL] Re: [PATCH] Cygwin: spawn: Treat empty path as the
 current directory.
Thread-Index: AQHYjJiLtjjVkMJcoUSGbHwt63TYgK1oRrWg
Date: Thu, 30 Jun 2022 18:35:04 +0000
Message-ID: <DM8PR09MB7095DDCF46700AB235A53717A5BA9@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
 <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
In-Reply-To: <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a89212ee-ef30-4788-001b-08da5ac73fdb
x-ms-traffictypediagnostic: SJ0PR09MB7342:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gCWk0zNw9oyUvkuQxb7g1fq0yIq56gtM9ktnFz4c3Rlk1YFUuaa27dIKBjFtRAss1CKk6C+W+KQ7Sc9h5ywvK/krtnSPGSa0EwjrjuFBaEVcir8UKgeCXqx/vqXKMQLivRzCo28dNFiB4rM9BLd1OymtJCrUySjAagoClK6jVAg+o4mW+huqJiXJqNwT//U/hhmW7Q0PrfN/jiAdQiAQbix069iuLCpKNmm29elNHoVFtr5IJJcQf7e24A56kvU11kNHpdWxK5hSIeCP+M1h+q0402KDmsNH0OeIRREgZVEX99BBjFpLG4uol3GQT4csmqL6KJJsjCPKt4vt8mr3NptXlK/MsX0mF1tSTcKkaakSda/deWzb3TyT6hBtCscgJp5tq+yeE/s1rQmfvRrQ8+x7cqOf3gjeQHseaGNPcAPnWMOCoom7UaUsAWy0fDSuqbRKXdyIl6XFtG2tbEZhe5+55qGpyhujxRDOLFxszG94CY75y7YYmx2BFLAGD0NyBazbZYbxLILupM8VmB0KLakmP4ZG6kdfeKxkDRa4ZLPripqgHR1+u3+n8tzTwRaLQhEXY+lipxIclzQnXxTnNr9dvJMzZB+aLmdeCbFLETHGS2Q5pC3ANQPGuLJi0qKL0gQW7WiK0S0aXKyNJTKcOvec5H/a/FBewC/ygx7nrgPnRxaUg73qXkr+b++SuYH0K1qVKXbaNaMyRCAKchdOU3QW7xqOIYgLPspqy0xERNMZ/PR3RW1mT83q0Ofj3/458rCzV2yIaQ2pgzyNzYBm8D3DTU3fT2aTGRhOMKhqXkAELOqHCs0jkf7HZgahkU/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(66446008)(38070700005)(66476007)(558084003)(8676002)(66556008)(498600001)(64756008)(76116006)(66946007)(2906002)(8936002)(5660300002)(33656002)(52536014)(71200400001)(296002)(7696005)(110136005)(122000001)(55016003)(6506007)(38100700002)(86362001)(186003)(9686003)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nivDLM5TWsMg8IE1uW6hiPojXh1/eHRfuKHRSe7glyb9dtgwRFRQPQsIzbHO?=
 =?us-ascii?Q?aatqVjwNbaGK7RJQ7pZGAsWgz4ERlXxVdW8X4B+QB8R4e9Q58IXS2DjNchjL?=
 =?us-ascii?Q?S9HkQl7FgKjZ6n1qJ39pb9OSqAKkpG8d1/WcgVf9DdSo5TY8dIMom8xsaxcv?=
 =?us-ascii?Q?ytI/H+rc3rhQN1Pq2HiTZ40aFr6EIoayly0mD/9rPPlZ0tgB2j2M1NOfBFIi?=
 =?us-ascii?Q?ahPtWIOEkJPkUTTdxE8gGP04yRqBljSk2fl2PUPzrBOmTbqdnrGwjMDgp/rt?=
 =?us-ascii?Q?ZO/+fOfj6CVif0XjqWVl8fFomwqnTLpNVrN75QgbQoga6GL7tYYPbFzdBRq4?=
 =?us-ascii?Q?QOwX3aR1wT3sS0851ME1QWgTZd75jFOeu698Y6/CyszblX43q/9AS4/fj+Le?=
 =?us-ascii?Q?uVKro4u0Vpvc0hG45PDuXsacbTXGVrN7BcKWZuOPCIhIyCpsFqdXSGiCqSnF?=
 =?us-ascii?Q?L9C33hkBH/s99b9VGh/6kbYhkLFYJJmwavl2dm6N7Ww/ufNER0o4ZhxwhOng?=
 =?us-ascii?Q?4UkQJEsBoaV8EbEkeWLYaNoPbgQa8KiAwuy5+eOP8Bdg/4o+OBZb+kGYm/Nu?=
 =?us-ascii?Q?AXvUwDl2yzIFV25MCmarB3rq2USjCbPr7yfW5kZhUJgMb+xc+PxUa+zTdENP?=
 =?us-ascii?Q?fJu5If4MkoZghqIrgU+pLC74/eoMYGlOTfyKjZhyBH8AKWi24LhsZuOekIwh?=
 =?us-ascii?Q?3g/AmzpUmgZjUGLwekGSEWOxCcRyXa9yzPM0ZEjBiJFmQtjUqnLYyM8DA4Q3?=
 =?us-ascii?Q?n1Supton2Y44B/oUWH96wbsDzLs/hGvGFVx2SOtp51E8fsNhxKFceoDCIMG6?=
 =?us-ascii?Q?i3H+mg/90g3rA/1eSnTgq2/uY9skFLgPbOUJjP1kyZQGmo5e+LxcZhCbYnQD?=
 =?us-ascii?Q?EPplc2mJju75ElgEw3QiZC7byQLrL0RU5RzY56udjKF9w8ipy+Bc+MTmkWLS?=
 =?us-ascii?Q?DwS+9FOn0Bvr/hPtkakLEoXF6B09Mz+nLcWtbaAmAPcMpapxtSpndN7vCR8w?=
 =?us-ascii?Q?R5poun0GuIMHVK75FnsetODURlMXX+sPwh33U/2DaCoyfUugD2upJFZ/ZvNm?=
 =?us-ascii?Q?dDfqubaSWwieQAAN2uU5r87aFVlmOtmuLwkp/dMhUc0YEr0u4F8v9YiufR/U?=
 =?us-ascii?Q?ev9jdJDGVJoIQ57BOQ8gxIGtFBKzZERIBsDbpzI3tO2iFgN6lJAXdHHzqNQq?=
 =?us-ascii?Q?VExRDY99bC9ofT7P1Sa3NTR3FCbgJSVAuDsw0oseD90PC0S7RjGcbFC5/9KK?=
 =?us-ascii?Q?O1p/NAuYXe3bvHxXk/tzGO4eldSeopr9p4Hm1gIt8pzgtCy7DBBV5cF33MPk?=
 =?us-ascii?Q?HsJ35vOobAyvazDRa3MtIBm8Icaish336mu6EjB4ZaemH5DXryeQ8eBrgt0v?=
 =?us-ascii?Q?DAgPmoB3Vz6WzJSCpgIpTn5USgitoaEKFHF8IR87J2MWprwoOpnDFdZQ3LbR?=
 =?us-ascii?Q?5DnCtNAlP6S2ng5IvWwnP0KjEiosW8iE3dRIUCsybLbZTYblIB5vW8N1rhYO?=
 =?us-ascii?Q?tfzdvxk2iPCZs9LqcDY6dHeGeJ3DNhTkIVSI8aFFEunVpF2JBOTBfApIU2Yt?=
 =?us-ascii?Q?rgeiyv3InUw1Wo7z0SE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89212ee-ef30-4788-001b-08da5ac73fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 18:35:04.2342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR09MB7342
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_EF, SPF_PASS, TXREP, T_SCC_BODY_TEXT_LINE,
 T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 30 Jun 2022 18:35:26 -0000

>                However, use of this feature is deprecated, and POSIX
>                notes that a conforming application shall use an explicit
>                pathname (e.g., .)  to specify the current working
>                directory.

Since "SHALL" does not mean "MUST", I think this patch is correct.

Anton Lavrentiev
Contractor NIH/NLM/NCBI


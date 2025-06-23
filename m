Return-Path: <SRS0=cFOF=ZG=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072e.outbound.protection.outlook.com [IPv6:2a01:111:f403:2606::72e])
	by sourceware.org (Postfix) with ESMTPS id D8C6C3860C34
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 06:29:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D8C6C3860C34
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D8C6C3860C34
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2606::72e
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750660170; cv=pass;
	b=W8Y9M/ijUyglkwj+WPp1SCtAfs2qqaXaP1EN1iXwt5kgtp/qzIgwqsqVMOAZGHtBQpBdfiVTa4ta752PIH1hvQyX5HGFpH08BP8A4ZuEsGFcHQbFZGaLVe8G6F1eBFu5cM2G0t9y5uI9+giEFw1KmowTyi22jh7/JSOSbJuFbCA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750660170; c=relaxed/simple;
	bh=YcduMbNhtQ/OXgzO1XgE8PmBqpoGVajfpkTX0JA7fQ4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=lbYoGDRkPKIm9GvqjLqX3re0DroEECJhbMlPQRJs2K78CzZV7FpfVXV3qE2ioawg+xvnurapgjqwDoG3R49epFaUmJFdwUMgTfH0KPU8vuWagDC0ndrWp7hTXItQoSxTHmiVd9ScNhp9Mz3m/LkPXby7cfPfcDZLt53juv0LyCg=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D8C6C3860C34
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=ZazYE1qW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5174qMQXdWxTZaNoMAowZirrGMqznR+4/DaIhKJVFOgrswBH+thlaLurt1ZFnnZbfgPyliB3i8JpokNZthmE1BAKrVZ9vV4HDwQpR8JLLNYzjNAmgKCOeEjxMIDEmA6hU8ZB++WKP8q40502Y/l0qQ9HhqDr0G3pxjXW8MJG+N0JpOoMqPIcyirW9S84aAphv2CMie45ex105qN9R5cYzdOtb5fqOJ1ImpesUsKRGjZpa1nL7oZsH0AuAxEEyB0wJOkNQ4rCkRRCA46x8wMdRe83+G6UEuWDp0s0I1IrqVuUUUXix1brgL4wJUo/ts/4riLHwDubcwPdFrJank2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcduMbNhtQ/OXgzO1XgE8PmBqpoGVajfpkTX0JA7fQ4=;
 b=xUSbxM4T5s+iaaTOvIabqowepknOReR1zQnP8GmgRXfhhuNJhGcHBzomEgpliFZRw5TZy6+fM5Qc5Uj/4ZOCAuh4XEWxK+ZXfuSbbgzcuO7F8gDitCleQGJ4YNPRabvB5lb2zS15RaqP/c4yXSqFV7qfDNhf6w3/cIo5ymg/ZG+gbFEGYkd3p2Dq5RnHvv43ynQ0PPXG3JqMK5VYa2DBI8dX097Z5+s/jwO0toynkgN3xU1aYACrg5vyqB9w4oztMAzq81KMVxIPOdGbvVxLKYuudcGDRsrvST64VQuV1bkUEKW8u+NUMIGlMf9dx7rUnkvgfebypGERzv3ZgJuMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcduMbNhtQ/OXgzO1XgE8PmBqpoGVajfpkTX0JA7fQ4=;
 b=ZazYE1qWy+tFfBuQLlxHiPx7V168rCvCUWB79VAT/wgq6JFglg34VRE/s6NppVEyICuDVAlOvATpk+o4HP3RELo8muJm8gGIuNduZLkJHDJ29dkmem/v7OIODi2aU40jCXw0ZJftyPYKrbYjjnANelNO4O3Tsog970hOM1xd8Xo=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DB9PR83MB0537.EURPRD83.prod.outlook.com (2603:10a6:10:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.13; Mon, 23 Jun
 2025 06:29:17 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.012; Mon, 23 Jun 2025
 06:29:16 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: stack base initialization for
 AArch64
Thread-Topic: [EXTERNAL] Re: [PATCH] Cygwin: stack base initialization for
 AArch64
Thread-Index: AQHb4GohaV9RByzWEkuse0eJGFCLS7QJLdGAgATLOgCAAlVHvg==
Date: Mon, 23 Jun 2025 06:29:16 +0000
Message-ID:
 <DB9PR83MB0923E495EA001D0887EC80469279A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com>
 <5a0ee0d2-6fac-1886-45c0-c75dba8d0bd7@jdrake.com>
In-Reply-To: <5a0ee0d2-6fac-1886-45c0-c75dba8d0bd7@jdrake.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-23T06:29:15.853Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DB9PR83MB0537:EE_
x-ms-office365-filtering-correlation-id: 40ff44f2-06aa-4d07-902d-08ddb21f473b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?iRIqc2krOfKaQ2i/8zITYbZL0FIuRCr02+UFaEK9Xxx0u8duHZhst0o0jN?=
 =?iso-8859-1?Q?FFSmyuSS4AP4Fk2EnQoT8kppyKdVUvz+SXtIsrRbOqTbXf+x6niVOq93eH?=
 =?iso-8859-1?Q?opDmVI1dTQZk6FkXBM0AEVyUvieDSToHGhkLhfGH5Tscb03ecIeRodz6XY?=
 =?iso-8859-1?Q?2GfYdh5Xezl4j4fAb89JFXJdr5yS9jaVxRyy8Hm++7jFzoUjcSKiPYySaZ?=
 =?iso-8859-1?Q?cumfSnljsDlS8UOZD810jm5HM+t5coeprg8hnZoQb4sEDW5+QeRWJSX5gB?=
 =?iso-8859-1?Q?8PYSL3Vvg9P4YYgRXK7zNFPBWENCZs8aJ6DssyLBm6Seczra4J/4SrPXqE?=
 =?iso-8859-1?Q?UtWEEpOptS6db6ASr6+Q43k3zB2WJF4y73mb7L2WscVBWxes1qOC/UPrs/?=
 =?iso-8859-1?Q?h8xMqbzD+kdc77Wo1hbv8QQDAJ8KGsWO5juZTJckM7DSuuBh2ramdBk86Q?=
 =?iso-8859-1?Q?fAPlde/eEEmTfJG9Yj5X65gPK9hedmlx+fQ2pdsn76vu4xkePzqO/AqQSF?=
 =?iso-8859-1?Q?LW1eGJD/YQgEmrCgXJib6or4KlbBWH6jHvAz1CdimK2CKOnd4u9dX7Ai+h?=
 =?iso-8859-1?Q?MJhuOnA5LiFKdgaHyPVn0/qMfiMqnTSl6VgdrRZ6WSJTWJtEApr8qCuUY6?=
 =?iso-8859-1?Q?tQnoVLnGq4kfBwxbbapSPcR2Iez7ytmLauP1m7aSZxyVsohldjf50/amXW?=
 =?iso-8859-1?Q?50dGrgQf+JWmEqr6yY8NaCIChG9CeLbuLdjGIV0sClmD+8Vvz2bAOuyo8z?=
 =?iso-8859-1?Q?o0ikD2eoXjP0+wM/A8rZCSmOczXeSUai4W56oLLyzVgEEda6hSuBHjr7GR?=
 =?iso-8859-1?Q?PZrC2ciLDYy+jfLd8C3+RS2fS593+2yg/j2GmDIh4t4jWyeAYtZOL3i30d?=
 =?iso-8859-1?Q?mPabcd0OzIp1qxBhnbqzBhmU9slxhimpmrIKH4NrKBOMk7d4dI1nK++6Vw?=
 =?iso-8859-1?Q?7dbV73TF20AqcTTI2ZCDCfqcBlR71KJToHfKgJHfu7Horzxd9VT6VIW2ug?=
 =?iso-8859-1?Q?lNS5/Jz3/rd2hj2bV4zt2GNxfJU9ewhDOohFtZU/4tjgIFP1bL6LeR4R51?=
 =?iso-8859-1?Q?tahXdw3ZIAWVaZ9MDlfCHdiqZlvmPyOHzJrYTleHGMnrUkORKbropssE1r?=
 =?iso-8859-1?Q?zTsFPsPo7MH6M74SDIAgffT3JAuYt2Fx0rpFwJXVdDnNnf5436DCeJKh5P?=
 =?iso-8859-1?Q?dquxOKOXGfgZNYZASntqsHWY9vANe1DH/q9vY21RYre9KWmhHLNVHO2ppJ?=
 =?iso-8859-1?Q?mi894Yv+K6eFrO7pV/0IRyXvSSCXGvpbCQ3bBGzV72ms+kbXfdl+RMkh7O?=
 =?iso-8859-1?Q?Dh8DmWzo0PUl61wvNTo5yWe8MlByl/1eeWS4V6M9Q6daLJZ/lyWz0Ab0/Y?=
 =?iso-8859-1?Q?ckuOkHCcsV0MLSv4oVlIHZKWleTNIWrnZ3CA3KpI3bm5FmIzCs2YoFyfQM?=
 =?iso-8859-1?Q?mpUN3Sq98RURiczLEvd97pVI3DOloe5OTfgRkC3A3Hi68J4DQMxn2ISB0U?=
 =?iso-8859-1?Q?pfPdsjKlqx3vJkDxPhNfIBxforpZ/RCIRpmMdo4pVR6g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qlJnu1LnreX6SQFNMKLdBUBWtA4d+LJL/xyCVfVRsTi4BUJYNTxHFIA0iT?=
 =?iso-8859-1?Q?v3vOwc2crkK0xOs9ygie0KpHdXoIWMVLe6wRdoM5+XF7taXxEScnwDAkLm?=
 =?iso-8859-1?Q?pkaB6R+Y+RfbeMo397rwHxG4ZjsQclEaI0uoB8OfSonzoj6IdSHxfqQ7aD?=
 =?iso-8859-1?Q?7rW8r2un0JOT+6AZFdqoZsQtsx105C1WNTHlynzQ5Is3HUGY/28WJiNNYU?=
 =?iso-8859-1?Q?ITr42dgNA4zo+x6G+oDWCnEjB8Q1iZ+bgIsMZL0eGBK1RRr3+/SNGYWy1t?=
 =?iso-8859-1?Q?2foVm6p3NSxDEDM13gk94B+2/aNrpiMJsje9ZT2aw7qN/1FRqhQKi4p9S+?=
 =?iso-8859-1?Q?E13gx7q50ISzz+/yawP4s50+MQhiKxgg1AlH607cVK9kXLcFiCdmierUSX?=
 =?iso-8859-1?Q?9tvZKrOO1q6GtP0o+oCkz1U1DHa/dOub5i1fUmfnHNqG04vkjlrFnEZoMW?=
 =?iso-8859-1?Q?Jt2+JMRK7bbMG7SCeDfqNoe0AyKKYrQjFo5aU11yMLKIJgfIxcN9Gz6zyh?=
 =?iso-8859-1?Q?tBdumV5lnGSVfeZUUJ9UQcvyHVvX/LqymQw0sWoeEEUDQA6rnUR6nRscfG?=
 =?iso-8859-1?Q?HfJuezDiaPd0NMpN7KSX10SubssXS24YB6NDEh7AC67R5ZXUH/qRxXdWJi?=
 =?iso-8859-1?Q?jLp1Lb57dvd2eycStRwifZ0i9+lqjx1C0nIisVyA1gnIWAptOFZtA5Qkro?=
 =?iso-8859-1?Q?KQmcZMnfKoiASEf8yDiGhqHzpt5m4Biu2E2EJe4IyrAo2vpLFnMLK0L62V?=
 =?iso-8859-1?Q?IZfUiSDsoD3qJdqFihY+7QW0pWq6Z7Ad0ShPxiUrkaCwkna9dTJX1glx1H?=
 =?iso-8859-1?Q?yrnY3Sc4ebnkXUEkI3F2/tHxuAIAiDojYiDZp0et1iWkZWdMutiSeWzJqo?=
 =?iso-8859-1?Q?oKxyDzs7w/WXqbWMcNBP1q7rsJlgc0DwEmwlaj0QSiDsk5DWOgW9AGfbe8?=
 =?iso-8859-1?Q?cpNl15EBjQT7fV/46WcupWckjaI+dA/XNCY+B0FP0xJ3iMJ40YTfKxQOlt?=
 =?iso-8859-1?Q?n7aRLEuiingy8IVw+gBR5nMvF/6fguWNS04CWpNGW5oWZGt6at1xb/RQ/c?=
 =?iso-8859-1?Q?9TzP2RRn2LLfNWmcpmrJOAAfoD+T425trpooviTUtYHZvpEr21VuWdbICX?=
 =?iso-8859-1?Q?DeHT8LKP1aZZM3wN/53N+oncY7kmueXmSI4TcpCtsiQg91uKD7FRDU0PF2?=
 =?iso-8859-1?Q?UC00uAlv/iUettHBcRFSgs/tofjBohbq8WrB+880lFI8zT4hByA9IxEV4W?=
 =?iso-8859-1?Q?l0IEJSDSGlwcYnkOTMYmy6OeODTovjFV37gpf1uyJaxjcHSScQIK5cslZg?=
 =?iso-8859-1?Q?3arh4gepG7TU0lm19vIpVkx0vMIeg7/NvK5Z8fCAd5qQrtZmRvGk5hdGNP?=
 =?iso-8859-1?Q?Db+eMQyDp/BhUilfVO12Un4qH2xLtaQR6tO3EB4gYWX/pFXnaiTZ7UBurI?=
 =?iso-8859-1?Q?ZjeNqkub7vimYpN/nExPUNGtu54ElxVawWPvlwE0NLJbRqGd11niHw4EQD?=
 =?iso-8859-1?Q?Wf1zlMOb32zJB8n5PInceb5NJeTfslYRyOcR/Q+7ORoXzVph7rifMDRwPu?=
 =?iso-8859-1?Q?IBhKzebY63KF3xlsTbP8sCD/FbE9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ff44f2-06aa-4d07-902d-08ddb21f473b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 06:29:16.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GA4P2Z/c8PXydmuazhrqU53LzpWbR+hbHtB3GOlIcIdCWFl75T+daOV32B8epHmSU5Ci+9GcqQYVo2qzUzBxlKuNErF+eBAT57cZ8znOEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR83MB0537
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,BODY_8BITS,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
Thank you for pointing this out. I didn't know this was related to ABI call=
ing conventions in this particular case. Simple removal of the `sub`=A0inst=
ruction is causing tests regressions in our development branch together wit=
h other regressions introduced by rebase the to current upstream master bra=
nch (induced by recent changes to pthread). It will take some time to inves=
tigate and validate this change.=0A=
=0A=
Thank you for your patience,=0A=
=0A=
Radek=0A=
=0A=
________________________________________=0A=
From:=A0Jeremy Drake <cygwin@jdrake.com>=0A=
Sent:=A0Saturday, June 21, 2025 8:47 PM=0A=
To:=A0Radek Barton <radek.barton@microsoft.com>=0A=
Cc:=A0cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>=0A=
Subject:=A0[EXTERNAL] Re: [PATCH] Cygwin: stack base initialization for AAr=
ch64=0A=
=A0=0A=
On Wed, 18 Jun 2025, Jeremy Drake via Cygwin-patches wrote:=0A=
=0A=
> On Wed, 18 Jun 2025, Radek Barton via Cygwin-patches wrote:=0A=
>=0A=
> > -#ifdef __x86_64__=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Set stack pointer to new address.=
=A0 Set frame pointer to=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stack pointer and subtract 32=
 bytes for shadow space. */=0A=
> > +#if defined(__x86_64__)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __asm__ ("\n\=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 movq %[ADDR=
], %%rsp \n\=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 movq=A0 %%r=
sp, %%rbp=A0 \n\=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 subq=A0 $32=
,%%rsp=A0=A0=A0=A0 \n"=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : : [ADDR] =
"r" (stackaddr));=0A=
> > +#elif defined(__aarch64__)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0 __asm__ ("\n\=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mov fp, %[ADDR] \n=
\=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sub sp, fp, #32 \n=
"=0A=
>=0A=
> Is the 32-byte shadow space part of the aarch64 calling convention spec,=
=0A=
> or is this just copying what x86_64 was doing?=A0 My impression is that t=
his=0A=
> space was part of the x86_64 calling convention.=0A=
=0A=
The patch for pthread stack initialization dropped the 32-byte shadow=0A=
space, and I believe this patch should as well.=

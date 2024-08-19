Return-Path: <SRS0=r+vf=PS=kneu.ua=yeliena.prokhorova@sourceware.org>
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::])
	by sourceware.org (Postfix) with ESMTPS id 5C6823858408;
	Mon, 19 Aug 2024 12:32:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5C6823858408
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kneu.ua
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=kneu.ua
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5C6823858408
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1724070756; cv=pass;
	b=rDIALLXdvjHP+LsbQqfmIGgHr1xSgUUUyTkBMouJ5cH1jQi6pNmJ5jVKH5Wy2hgG+j9CAGP0QeD59LJG9iQXzGf1z7fnBkjb+sup2jwMVc1UQN1tKV4P9REuD+pdmzzPsJZjkiLXQFxpm67lwh6YpJwMkxqrw/9ZFyPhwp+PIRA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1724070756; c=relaxed/simple;
	bh=fPGyoNtwtBSJMws3SU02nBp4BDURHDoYqD7TT6kzabA=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=d+nZNGpcvZtd714C0NDHmIUnY/UD8Lso6sWPJQu6guBKle267H7e6kkbhicJ+RUQJgKsZVhQYZAy08cFL9Aay/YZmH9Y08Ob+FW82SZ3toY1rwxfgb/aYaZsOwm8Y8LFjOTiUkYPavpZs5UOoZYq2vgOLLdNZhDiqIRVcQDcOc8=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+wvElTqxjkAM4HnizC4DdQ5L3YrvDbOtZV8JsqnbqZd93JmldzT2C4BL4RA5cK+nRVmJJVyQ+OO1dHv69nga+iEsDSiPDQDFmFXaQRnSKmgSjlx/cYDeOt7t4pJyjI2jdh/mMdv8z+B+uTh3OJexBZ3m2RuGk8CGUJKg4PKIOOaoEAv0mA4Uo6kaIPDTk4Twk7ixaAF1gAiVPY42VpKbexgUif9hj3pFxAxgMkzYytpIM9reycTfB06+hy2VII7+L4ntUPOg8TLpClH4G/IUcp1vyF/Yya3aV+wxTGuKIWZBacLRmIoE8UmBE7FgDpAWJXJKMB0Poy/8qI2rhkWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhmBtm6TQW4PCPzwX3VrOo5REDokpTmi1KorLVyxpjA=;
 b=oCUKyzKdVdP395fPcFhatrd27GE4umyhlTUZ5uHGcoHipiNbB4RxUB0G0UBsxyWBSmxmAF69VQTElewF8xNhULsZynMpPIOHUtteA/zK9WEYrGd/HxBbn4P0niDjC8jTJ5ErEG2pGZqfWo64KQWTLTTaCbO/6RxxZxJoRWLa7CIMhBHT96Vym9pvFouZW1N9Vdds3M8WY15+0tL1c9sh12dpLQUJV7z842HEBz0qxsYQ1d1F6DKWBvlMPL3PFSUhlM/DChLzTx3fP0pJ0XYjjjEXZek5FPGLTDWyy251BfnDcqNYj4MDwB+7KjPVk88cNkhbAxe10Ylxmwiw4bh3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kneu.ua; dmarc=pass action=none header.from=kneu.ua; dkim=pass
 header.d=kneu.ua; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itkneu.onmicrosoft.com; s=selector2-itkneu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhmBtm6TQW4PCPzwX3VrOo5REDokpTmi1KorLVyxpjA=;
 b=Vh5PlpHk9RXt2/mrEPwGWU/IkCt7qlE7CXm5F/t0NEDYtv/bxRSlxeyuqOI9ph0xY8fjBZxtMQrv17CgHgmqVny+XMiyk41wj5W45HSADANmJL7/kfKC8aR05N8pSI71IoYKAllvBoOWTgYWxtLlJreId7IEvTCMLQ42PnaA/Ec=
Received: from DBBPR04MB7691.eurprd04.prod.outlook.com (2603:10a6:10:201::7)
 by AS5PR04MB10058.eurprd04.prod.outlook.com (2603:10a6:20b:683::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:32:31 +0000
Received: from DBBPR04MB7691.eurprd04.prod.outlook.com
 ([fe80::a3f7:a9e5:b331:3edc]) by DBBPR04MB7691.eurprd04.prod.outlook.com
 ([fe80::a3f7:a9e5:b331:3edc%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:32:31 +0000
From: =?koi8-u?B?8NLPyM/Sz9fBILTMpM7BIPemy9TP0qbXzsE=?=
	<yeliena.prokhorova@kneu.ua>
To: Corporate Finance and Controlling <corporatefinanceandcontrolling@kneu.ua>
Subject: Read Your eFax  
Thread-Topic: Read Your eFax  
Thread-Index: AQHa8jHC602NJDP7iUiWcq+erDoUZw==
Importance: high
X-Priority: 1
Date: Mon, 19 Aug 2024 12:32:31 +0000
Message-ID:
 <DBBPR04MB7691320BCBC35C817A9E58B0838C2@DBBPR04MB7691.eurprd04.prod.outlook.com>
Accept-Language: uk-UA, ru-RU, en-US
Content-Language: uk-UA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kneu.ua;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7691:EE_|AS5PR04MB10058:EE_
x-ms-office365-filtering-correlation-id: c1573816-d370-4a85-8fb7-08dcc04afeb7
x-ld-processed: 726204ed-52fe-41de-b46b-6041c7cb52ef,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?koi8-u?Q?ToKF6XgQH/2CJf8NB+uS0VH6eSp6LC7iz+9xlDSDaMRqh4+fVVLhjTPf8sm2qx?=
 =?koi8-u?Q?X7+E/Y29kih97S1BBU09TgEaWlxchVt/x9UwDuNiT9KHQyyB8jFMTp6ZprM3cP?=
 =?koi8-u?Q?a9HWP8s061OOhAN1GbZRwM3VsSq0s7uJXugzdOsKOEhsGZB6Io3si/Lhnge7CM?=
 =?koi8-u?Q?4y8x+4oDRJOqz0hzNogMvTJkIYBxYeEO60czpyKYuNmkUKgSduLj1HBg+tzDMG?=
 =?koi8-u?Q?nHlz+hwAr0WMlE8CruRMtaRp/te3MROrBFzDnm3pbEmL1eaa858qWU48xRglXn?=
 =?koi8-u?Q?FSHUaACmuASjlNA7sbnoGr+cOLKEpdVrWB9ctXTCpTblKD0bUu7r7r56jh6oqZ?=
 =?koi8-u?Q?2KEv3TBKVvGax9W3Z2gaEvFecGrbhMrJrsiHwklIMCcfMjqbzdLxJL+HQuSuCx?=
 =?koi8-u?Q?YYN2PW1fKy7EYx9+ClfldsIjxQy23j4nXrQQr+0c/3mU2qPonBvDxxctjJeXM9?=
 =?koi8-u?Q?eat78EWPt6xucOT1YjHx0ECiyfF7pdu7VAkpeT4ojtZ3TDNO5TmNBaj+CPPsPv?=
 =?koi8-u?Q?PRkVEQJgYQwUygQUt26d2rWy8PhcqlK5wr/gwkY5cCPytqHzycz1WJP1uDCIrI?=
 =?koi8-u?Q?FZ9J3CPE9eBFnQetGuNh9bdjDW2gGuHqh3kQUwfJKiCYb5S1cdhOeOVdF9Mt3j?=
 =?koi8-u?Q?Fez8uGE7Hb5hsasuits4yoQiIOLh1PR0ncxLRWQPOxFBfMXv8Ud/dTpvoiZQfw?=
 =?koi8-u?Q?KCBtFMTg0cGQk87a/BekQgipUVBaL8lS7o1z0ZR3Fk6sfVYKVz+GH0XMmROW5W?=
 =?koi8-u?Q?8AH3D3FI8uMuaT8o05E6kUIiIT7IE35jVip4WXraW0sxPnAG3JXytONVf3bZ0V?=
 =?koi8-u?Q?x5bag0ptm2FAbzxaLz+Q1WOTJGLlD1MO/z3crxQ8YksyY/p9pMdmxBiCtTzk5C?=
 =?koi8-u?Q?tpunvN704jG5wMollQVme1W1Abr5o+31KNBJ1frK8u9vRPXlVTUc8x//BV3Gn/?=
 =?koi8-u?Q?IVaxc48Sj026gneRr3pO/QM7cVQPzQ+LHPizlYaw83B6zNgbliTKG5QIEyzuTJ?=
 =?koi8-u?Q?00iLNQ3LlSITWfAbjTW6Ed0FeECqs06Bbyx5C6BYF1RiJUs6CylePNdifGVnEe?=
 =?koi8-u?Q?Cxh/yNewFM6FDR3EvSBgx3IwAqj6kRyn2hyE2AMLZFBxrhP5dXt5G97kC8qw+G?=
 =?koi8-u?Q?MMd0dtSQ11/xnO+iMtQyVnsHxDQ5Yf7PLNDX6wE0ad6Th7+W2dq0rOcWLD1V06?=
 =?koi8-u?Q?JEvN/G0uRZi1Xd0asYV1YGP938AMDfOoGAoSQuWV8m8l6/Kg9xFrQn5ThkmM0l?=
 =?koi8-u?Q?f7owYdJ849OyZ6OOYlOAUd8HM+p0m5Rbe8jHIaq8acajU8N/FjyrVFqg8Lyjqq?=
 =?koi8-u?Q?oA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7691.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-u?Q?gSkltgVx4pWzy/tMPhRhKFwfpNY3ouz8ubck5ms810394QQjy5N08NO6+bMfgR?=
 =?koi8-u?Q?sZH39nsYBhU+PngLbgSG7BT/ghZos9bNNTs/wR6H7Qsy1Pvy0IGcoT6LcQSBjP?=
 =?koi8-u?Q?jaWDPTzqxoF87z4iqf210Ad88a0zL2bTffLnY8qO5phcIpW1MXJ8RTXci9TzN+?=
 =?koi8-u?Q?vNhvnj98YYrOg9dRhqRa2hF9AMDsQ8Yc5DRIg4UuliE2VwODcAfMjskNpGGjfy?=
 =?koi8-u?Q?vDZ9EELRhJsg8ShswvwmqJK8LNpbMS+f3KsiRvFUlGi/a0U06WcC30tJ7fOjTY?=
 =?koi8-u?Q?Zp2aTvrVCdyknO7k97ZoOlIxgz6FlKT1qZoCvtLGV1jZ2/SWnjxfhft+/7j4Yy?=
 =?koi8-u?Q?Son7Dc7SIta4TAUM6CwqaOg+rzLy8WNn9GRJel0mJ4Z6i6YyfxQTOAGR449h4X?=
 =?koi8-u?Q?fxZCxNI7kMEIlDwV6QxyfGuk+kXbv9av2UpdH0qr6S0YxF7khn5CnByc/DKEmt?=
 =?koi8-u?Q?uvWDdaQKLOEw5Dw3c0UZYd7nivFSir/Kdcr++MssC3OB/b90w5IFUoYmIJKaTj?=
 =?koi8-u?Q?8OYcxnfeZFs1GJOX+KjM0+o4TfW7fq8mTwcgUQhkrg6Nl7sZDVaa3kfX/C9uxD?=
 =?koi8-u?Q?3o9lxkaFo94zjJA7rBaxaeHeD9kFCPI6KVk1gjFC4SGxmOhUABqpsoEr37L4Gc?=
 =?koi8-u?Q?+rV/ZBbfVI8Bd2mMDa8t30CCZ8VGoiPkNVZARX2gwPUbQfzyOZNIQKTNr9pDJO?=
 =?koi8-u?Q?lv0RYZ0U4/nAAWL7dc8LkY0NPEM+ws7Q/N3il+tybRwCyo5gIHJWJ0xyW2YlSb?=
 =?koi8-u?Q?VFykSYDIU3fLoNwSHIWiwQzDTSzYkfiswUt72H2L9j+d0OwSL4zGD/yoiXJE+5?=
 =?koi8-u?Q?6Sq2LNXOG519oW5iYr28uQUFaQLFwBFZ03v9HEiYcHvqtkwjIcXR5mFrpHMGIz?=
 =?koi8-u?Q?on0LLjketjTJE1OW+aNLJI/ojh141O1YEKr8dT1JRLtysphf7JRnP/zp8ni9bw?=
 =?koi8-u?Q?s8BkI3VJfoe+3eKVT6+RA1sI3BxEmJZe6lXeDTP4sDC66tt24MqEKVCmoZP07w?=
 =?koi8-u?Q?heanaaD3Y045gmCZo3bD1+1FdR95cAqvTHH+qxQWL4uBmaWWuhK7KuNwqwylba?=
 =?koi8-u?Q?TUV6RSlTP2hBO0XolstztgQFzH9Wsqxr8WZg24z1AG80vTeL9Qnws6hzHjj7RC?=
 =?koi8-u?Q?C2sXkK9A40rPyuc8TZs9Xnfx8n1u26NDJEzoqAvkrSHZ96yl6pKx/F02/ES3l/?=
 =?koi8-u?Q?fjpblCqOCLDJi4Zl3XbOTFGQJwPEDBqyC1M8mgi4uoYJe1na04AXREGRhg2bCm?=
 =?koi8-u?Q?W9W27obigQb/wJm/BP6i/pxQeFlc9UnSI2dq53ZBJNXXBa4PSwNZRNR10Sb/uN?=
 =?koi8-u?Q?I9Zc6oJic45pQ9JEkNdtRQ74rh2OSW5qgtHA2NHtK5My7YtoOEczPO7z6Wn2dc?=
 =?koi8-u?Q?lUAGskaP8YRtP3bTYyI7IrEglKPCzqWSY2QhQ9M2A/yyEGNfDHArIX9XG8cAE3?=
 =?koi8-u?Q?Nrn+6w72gR7GNxfvDvckJ8OvDa+MG8tvtVALA3EgPamT+ogrJHJekYWAk4WEne?=
 =?koi8-u?Q?g4jOuFjgg/c1DaR3iz7nyOy/qKUgZVVFH68GMfia4Tl1TldPlW?=
Content-Type: multipart/alternative;
	boundary="_000_DBBPR04MB7691320BCBC35C817A9E58B0838C2DBBPR04MB7691eurp_"
MIME-Version: 1.0
X-OriginatorOrg: kneu.ua
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7691.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1573816-d370-4a85-8fb7-08dcc04afeb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 12:32:31.2769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 726204ed-52fe-41de-b46b-6041c7cb52ef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9N+NpIhd6e+2lf3tWc8z7Xr9QnVjhMOOTVBFq2OCjcvYSXbGV0p+kX6vMeNR/AonSs1o1EeifuBYnPDFhQ5EsRo1P9IOBJ80QMsGkW4VcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10058
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_DBBPR04MB7691320BCBC35C817A9E58B0838C2DBBPR04MB7691eurp_
Content-Type: text/plain; charset="koi8-u"
Content-Transfer-Encoding: quoted-printable


yeliena.prokhorova@kneu.ua    sent you an eFax


Status:
Received
Page Available:
10
size:
3.5Mb
Priority:
Very Important

Read Your eFax<https://www.canva.com/design/DAGOS9Q6enk/1nX7YMmmQGIHyv_w64d=
rFA/view?utm_content=3DDAGOS9Q6enk&utm_campaign=3Ddesignshare&utm_medium=3D=
link&utm_source=3Deditor>

 The requested email is legitimate, and it has been secure to your email ad=
dress only. Kindly proceed to review it Here Now<https://www.canva.com/desi=
gn/DAGOS9Q6enk/1nX7YMmmQGIHyv_w64drFA/view?utm_content=3DDAGOS9Q6enk&utm_ca=
mpaign=3Ddesignshare&utm_medium=3Dlink&utm_source=3Deditor>


Sincerely,
Yeliena Prokhorova

--_000_DBBPR04MB7691320BCBC35C817A9E58B0838C2DBBPR04MB7691eurp_--

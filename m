Return-Path: <SRS0=r+vf=PS=kneu.ua=yeliena.prokhorova@sourceware.org>
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::])
	by sourceware.org (Postfix) with ESMTPS id B765F385841D;
	Mon, 19 Aug 2024 12:32:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B765F385841D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kneu.ua
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=kneu.ua
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B765F385841D
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c201::
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1724070758; cv=pass;
	b=tT5iOCpyskutQlNjtOtMZMG/TCYe8Yrj6D4NOGiKYsKg3hQRUq+drvBTmcRT4bNTcqzgD3RUpPlr9GWtth80179B91fldQORBVWVA4XEfDjmFS6m64/xG8OZbEjxKeN2dLMivHYSI3tZG16ZAx1UqNzZvVmNJSqW02amPHVj3Y4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1724070758; c=relaxed/simple;
	bh=SG6LtLWMQHeSCK/9rWdtezx+4NIkfXFy1tnrS2QUPaA=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=mUbQ2QIkt99JoFcr4t2no7ORqA73TtKRQ7K+vwTza3fUub3IWExPCRt75Nvq++TMbyP+TCe174yqQP4rSfo2jXHXuWJSymz0oaEZRwW+axrAvTEg73T+ydR8llbreombiKqgfj1kw9s3bZvDPN1o2xcreNKsvjTifTmnfRO99lA=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKtUZvaDm5m0WTL9n5Gk+GliUgsz5UAaTZqQhpjUow3Fjh7Rb8lEHfH1U4/kLFjtsjmJyDhDNrYJKca6P/y6WgwZHsl9I786AIrOJuzUHtjeYns/x1n1ja4D6LRS3iYS5wvC+nNIbvTX6g4DLW/wvD005KQ/1RAZKY6LDompPpVHXQT8T5Fln7ID56czIHd1DnCcA6TJ/rQ9aX0ytCry+FiPsvQglTNUl5n9dKptIch8prp7wmWa3Yqt8JyVDuxmjf9YyvqRTRt0Xqg9oWj6I355E0zBJz9ARZdg+ZKPpdhgj4mIEO5+IBCHykKCNIsoM/96vuqlxCV1qrcp8fbzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNEEqpYAQ+eJoJBP41fnNN16m+Rz4DqInsnozrFXNIw=;
 b=JAQrD+aFGuxI3x/xKMd3epy1+yqfy6qcEqM6w0A3FxXMvZbSbqD+JL7mvNXUTTd5P8GHcm2TjqvxhTm7toXD9OiiriMTIcjhwMzGFSQYCR/m5pUDqkDfeyctpFvP4xrNkSwafC/WklDJ7t+kAMpGhSopFrseBauE8VTxsZ8kMgITkCgeA2Zwg+rz2YAwh8Gg8Ke8vakjFlF6WxiFTU9KyEEvJwBHqs9T8fOWQMfS6orYIAgJRUc+RGDAiR+WYJ0eZZylfiile34g/HDVPUv8OlKBZ+Vu41vo6mSNgSnK+tNtkFS2rIW1m/JkEPAfEurFDpa3oZdH/NYZkhomW53Hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kneu.ua; dmarc=pass action=none header.from=kneu.ua; dkim=pass
 header.d=kneu.ua; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itkneu.onmicrosoft.com; s=selector2-itkneu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNEEqpYAQ+eJoJBP41fnNN16m+Rz4DqInsnozrFXNIw=;
 b=JU9gMYrzEftGLpuYz8GgBaU/Bz7zOg5o6v9ntFLpb124jR+3gyXnwxEWqTNJTlIdX5BpG7cCatDgSRagpaczKD608KFho0KCOGWZwg/G1ALKbzrKfGzAacAVRu15gk9BC4G22JTcHset/uGb6kPX5lLTgOUW7Lvze6POCJ2+OUU=
Received: from DBBPR04MB7691.eurprd04.prod.outlook.com (2603:10a6:10:201::7)
 by AS5PR04MB10058.eurprd04.prod.outlook.com (2603:10a6:20b:683::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:32:33 +0000
Received: from DBBPR04MB7691.eurprd04.prod.outlook.com
 ([fe80::a3f7:a9e5:b331:3edc]) by DBBPR04MB7691.eurprd04.prod.outlook.com
 ([fe80::a3f7:a9e5:b331:3edc%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:32:33 +0000
From: =?koi8-u?B?8NLPyM/Sz9fBILTMpM7BIPemy9TP0qbXzsE=?=
	<yeliena.prokhorova@kneu.ua>
To: Corporate Finance and Controlling <corporatefinanceandcontrolling@kneu.ua>
Subject: Read Your eFax  
Thread-Topic: Read Your eFax  
Thread-Index: AQHa8jPda7U0oj0A+U2ZuWFPhYOV2g==
Importance: high
X-Priority: 1
Date: Mon, 19 Aug 2024 12:32:33 +0000
Message-ID:
 <DBBPR04MB7691015022F7C8B099F70582838C2@DBBPR04MB7691.eurprd04.prod.outlook.com>
Accept-Language: uk-UA, ru-RU, en-US
Content-Language: uk-UA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kneu.ua;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7691:EE_|AS5PR04MB10058:EE_
x-ms-office365-filtering-correlation-id: 6fc96241-40d0-4945-9318-08dcc04b0025
x-ld-processed: 726204ed-52fe-41de-b46b-6041c7cb52ef,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?koi8-u?Q?Z2lhI8BGkskni0TJRs9qCZm9yA8RAqJ9mVd90P/XNjK4AORgaC09omu+fImD5J?=
 =?koi8-u?Q?9bE0Vm/iDG/0zFfHhxiP/PUHwKl5IhzT4fBeVFEsWbShIhuF5+Bsgq+FpYpaxa?=
 =?koi8-u?Q?61rFJOi8walNXFBR9B0M4gSFgo/i8evSRApP/UFfhzSYqYD0teMVjOsSww4WGN?=
 =?koi8-u?Q?PaDN26EL0iiGXXU1YvaYOjVpzEqqRO//9gqmFyZvlzOKtCxkRnb5tatPe9Hx2q?=
 =?koi8-u?Q?PUm3AMoyWSCL1ePqNQHxkaeCYZOe7Zbh8FYxVdR51lg/c8AHnwISDFclRXYdHT?=
 =?koi8-u?Q?P64OeN056ywy0npW4ofb73V+dEmxJyLOsN/QCzcuGokb1RsJm9arEA2K0p1N4q?=
 =?koi8-u?Q?dk55fnRGNYf3clH57rThkKdtgvvUhjlPNw7WTAZTdDWa2GLsRp1YHInXdwbnCX?=
 =?koi8-u?Q?V4bXy7txPT5pAJK2S9F5Tz9larl1Xjv2ieTVrY/4IEHf7VNBqGnQKvsy8bbze/?=
 =?koi8-u?Q?EsbhFlna5T+xxmChyv9XPME4ZwJo0QyoJid8Lp0gIQ8qEmRABkG5J/3B+NVFqJ?=
 =?koi8-u?Q?KKD+Xpj04hyjHNHLFyMYZi5e7Ck/V7A6A+17Glsij1dghrr3MwDbRG/f2BfW3b?=
 =?koi8-u?Q?16sQNpi4TSUT7wf4Gw8+YmUR+3maSJi2p7QpoNqHSCI953meA+q+O7dcb0Q4Xr?=
 =?koi8-u?Q?qrH7pWdfyNo3g2Em7lvzbd6kVYupnIp1z8+VmUPB97LhSJMpcEiENsRzKjdlkA?=
 =?koi8-u?Q?MlUqgaADhFC5hCVS90AEiT3RjzMDT7+pPpdTxuW4M+OAle13T9C6xxIVVTaVze?=
 =?koi8-u?Q?a28H3iCZRJWWNBpyH29WkaQ3poOZhsCBqPBqX0fld2XW9TSgPWGW1oG75XmiKu?=
 =?koi8-u?Q?4xW2QxdbcATe7PQ4EhTIFrSdvABeLTRmS7NbpcWjEjZAaD7BeDDYJeyfOO5e/K?=
 =?koi8-u?Q?SgB+aIV6socu8jEimc8Qi+nqwgAfNrcSC235RTO0u7OJVHMt6UlvBd3yOHR+0S?=
 =?koi8-u?Q?jJr+o/Ul4tTZVKf+SVol6DwNxFHYwocRxxMhA1ttMJRprzyzskU6BlvO55fAdP?=
 =?koi8-u?Q?DanF1CWm/VdYqCbHdC3hPYfQjMZ+qRwu0tZ2d6NkAHf3Wz1slnrwmila4gxjpT?=
 =?koi8-u?Q?T6+bYSAO5CV4ol5iwmCy0TdZv6trmYmY4imz6OddC+tl3YA8nNBVvNB2gFMDnR?=
 =?koi8-u?Q?VtFmht1X8Z3rSLqc9rBgADiKi1VBeYK7hR11Xs3mn9G9gUDucyOoitDHgJvtGs?=
 =?koi8-u?Q?d4MR57F+pMtlMiapeubv6qvo3ftaI88/pC186A3mIlXtNghFHf6yRKJxXpksOX?=
 =?koi8-u?Q?NuGZdgkQ4xnYPsUXZlEw5ZoNRz0gSW9Tqn+Tg6e7w/NuzE//T+zM5CE1zKOsf3?=
 =?koi8-u?Q?ZA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7691.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-u?Q?EDo3NxUWR5DHsDqQtjAeifIG8PUC1cwu8UB/DkprQ4S8w5N5wPexMRIrcDjKXL?=
 =?koi8-u?Q?aWmRa4Vu8Es4kuBDbhKFQs6DGYAdAJcSiVE9Q5Nt5JkzHxup4rd3HTSPgEhwfR?=
 =?koi8-u?Q?GD7DhuvCQASiMa6O0S6ZtYi660gjSrhya46YDKjP3VZ22zHJi9ZCh4FYT2aEo5?=
 =?koi8-u?Q?rMDPaCys434UJjj0UMhNaVGzNDGF1WItm1lfVhoO4wst8uZzdt+i5o/+nVC6pv?=
 =?koi8-u?Q?WJiTnoZQIlIPN68AOIlsPbnivE5W79MHmvryfbw9Ok02r8bEQZ3jMLsT+6G8Wv?=
 =?koi8-u?Q?qcz5lJ8+ocnHzeX/fiAQFUavBafTSampX9dx64mTy0haceoh32gWQeW0FwbVpM?=
 =?koi8-u?Q?PGvDGnrU6GpO8gaLiPNVyHkDFyV9+LbO+Awi99piI8c6CWNPVH96Gauwa/5kVZ?=
 =?koi8-u?Q?aZpJU9c1jTHd658KMSFm7C9iVAj99rcfiRIl5vlTt0h0fwl73k/4lRnf16itJH?=
 =?koi8-u?Q?WOaeFDc8kETixQg4c8veqLDAH4Nn40oNNkmjLlVIgnhzveztOyDLqqQEsa0CFI?=
 =?koi8-u?Q?T6/PhQRm5zZJR5fKNHaTPNq+Jk9GB76P0pohiWVCnhc7JcYrUKoxiSCj9mM0vM?=
 =?koi8-u?Q?29eIKvjGY5FbECzDTLB/JZ0eKmPw/kC40Urwf0JBStf8HisvG2OY/+FWwgSO0L?=
 =?koi8-u?Q?JlzOi4LYvqIu3XL7KqAveoVIzLP0DeEyyGem9kJW/1XepCNLcmww4oDCcjpw/V?=
 =?koi8-u?Q?m/pr0szcW7nNG0IYwFLhlgNKvIExVwZD+lmR9kI6qtIphnmD7a2Nusu3t5H0ye?=
 =?koi8-u?Q?s4X1RTw6Tb/tCsKbtxH6wsLto/87DRInrJhllI5SdV3tZY3PKQdCvLDVRDz3ZT?=
 =?koi8-u?Q?6ckXY8euhXIRzUQHSJDN+ZCUycPZRyvLva/bqHU9zYva0h9iEUm5uyU7BCdsYK?=
 =?koi8-u?Q?mt0VqH5G7/cWDfMl3H1P3/IQZHYFPk+Cpm388c60I029sjjb1ribRke5VQsgQK?=
 =?koi8-u?Q?RR9UFNHX/Cir7ADDUgFVCU+hGNAnfDil+/57ZYuBIzxclf7Tp4ZFQSn+bK9EDM?=
 =?koi8-u?Q?X7rWE+myKZfGfkOd9GBIpvJHEHzoi3H72noztLbin2ftyR3iscimCqkhlRo+WP?=
 =?koi8-u?Q?E0HJF64dNvztij1wrobchkP1ftEu0iyiV9nLJZGv54MXOB3aQ/nYIbR31W8esN?=
 =?koi8-u?Q?GWxjKEVLQ6QZhxqebh3fWt1Kl1VOrw797yQSzo4NmpfMSXqbqvat+cFN2CT7XX?=
 =?koi8-u?Q?hHYZybHwuU36eOlWm0xUnbVCO75Q420Vc8hMJDW86TkCtbn9I36nam3R+zR5sB?=
 =?koi8-u?Q?D5Ah/vclh7aX6X1i2O4sLzzPuwgtVa/W6sCetvqWqigjVnpxFkeebSyLuZVpol?=
 =?koi8-u?Q?svrOTpQtKVledJ6+5wAgowdj4LiqPXv9t8th4SoQhwzO2Exy5JsNzTyxhDqBK6?=
 =?koi8-u?Q?4QcKvjYG2jH2eZ0uYboHqkJlHgqekKl9sdPNr0FRIqsy25TXXuueE5AgsqhcUg?=
 =?koi8-u?Q?JoPvdlR9hxEU8CwO5rCjqfYz4AGB+XUM3WR6XgJ8kDpehbLVefcoUnY4PLY9wJ?=
 =?koi8-u?Q?LniIYJsbvTsPhUJYuQkSs3TWg5F+AmhaK69b91yU8Y3ZDnyjRx?=
Content-Type: multipart/alternative;
	boundary="_000_DBBPR04MB7691015022F7C8B099F70582838C2DBBPR04MB7691eurp_"
MIME-Version: 1.0
X-OriginatorOrg: kneu.ua
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7691.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc96241-40d0-4945-9318-08dcc04b0025
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 12:32:33.6692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 726204ed-52fe-41de-b46b-6041c7cb52ef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPeZf0vjjyWsZ06Gne2QNfBk8V3imWrumPbQmPHlEd1YN7Df2e8TJf4jIQmlwM0v8xQkaMs/MYyzIJjcaibEEHBqEKhbVdGYBD4DQ1vE/Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10058
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_DBBPR04MB7691015022F7C8B099F70582838C2DBBPR04MB7691eurp_
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

--_000_DBBPR04MB7691015022F7C8B099F70582838C2DBBPR04MB7691eurp_--

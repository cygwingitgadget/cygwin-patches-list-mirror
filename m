Return-Path: <SRS0=7K4E=2D=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on20716.outbound.protection.outlook.com [IPv6:2a01:111:f403:260c::716])
	by sourceware.org (Postfix) with ESMTPS id 5E9F5385C6E0
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 09:12:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5E9F5385C6E0
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5E9F5385C6E0
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260c::716
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753175543; cv=pass;
	b=HHY4yph7d5wU/uaWnHcaS0av/3IEqODbisL3D/XYaJw4n8cuQlS0PQlZbRsbvtjNevTNhU5p1TObdwKoSUaZ6tra/GMAF3NaPF1UdH9tFPKtCQqdIPr1sZ2J+2cxZTuJFVnzX2o2lI+lAztjazPjPt12AO8eKq0Ab/e4sSNdsTE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753175543; c=relaxed/simple;
	bh=MFQlZtL6RtoFUJvEB63IvaeT9yllQHp4+OBZPJcor90=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=W/OXuqNeM56CrV/WShfvAmmUPmWGdfKTmQIFRFD8Qes/Vci6SSr3ZAfdh8X3OF+cGxLymvLNTZf/YBKt9sJRVys40RH0//tcZkk/nITHPY+ChwuoO2hlyl9U1mSdE5lMFOBNPoru2qWo1J3VcnB1C0HKCv5efEk8AVfAI8MaVKc=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5E9F5385C6E0
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=dncZFWK0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwinFBjsIjwJnDM3ndHUdnDqKePAND8Y7YYZtDsp1dguzcl6+WwPUBMnXsTR5nW1aBgeIgzWGV9KG81PiKtIv+D+wFIBjliLBIM/Z5AEvDC8Ga97L0iJmsfynRzCDjtDwBI6WJmNoO0u4CylUDay6IqS7Oyeo8eUoQBqc4C49WYpUqk+Lj8IPy4fhTYyISxygcDROrZZTHNR5rqmEFARYNXvVdPPwX/PJbBdizJxYLKM0IExVrlE6n12B8w1y8W/UBuFKn5vvu5QSp0q6Y9jWKZvP4B5cs0+QvaRnbwvy6sZUmYksFdJ9Cw1/BR7E63RI+onktD2AqJNsHtsAa4QkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFQlZtL6RtoFUJvEB63IvaeT9yllQHp4+OBZPJcor90=;
 b=k81YjCJlzZCwa2B1q+1BBbodFWp8bk0S1D9cCb+Ch4Ej+qXuHXDcj0NaqqH8YeRVjIZH3o8I+OVqekRbyQ3CWOxVV6nWaMKQunCDYR56/equMehcz1WKaA00ImBpDGd6aU/FgYB5DTw1Yv1sEQtH66QVTimLxxVVPioQiBNR38spoKRifaa529OkR+G6qZe/fNG4+Za3yPm1dYr0bDldpz2SLOIrFPEKXeGh4a8ElUaK/g3asKIEPuXaWedZeWdwxmmp4mYqhSTplUWZUrCj70T5VqEPekRvLeqbLddap7ruvy2UEHZjyITv9aO0BtA7BjamXeVuykMNgTXXdAkg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFQlZtL6RtoFUJvEB63IvaeT9yllQHp4+OBZPJcor90=;
 b=dncZFWK0I9wGSBRb98HGP6LnJlkOh6ShmxHO4ZajxnwLjWhB8BLMS63sQ4Rxnu6BWUBHy+T5Kz6xS17MOe2iByW/SHtWZ/Ere4Chgsz6Yr6+tPY6xRTQriU3BJOoqnlhaMHHUsoUZTSQVDbw9J4C1a8KwsKMMsPv+Ci0vxUnaSg=
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com (2603:10a6:150:27e::22)
 by VI0PR83MB0715.EURPRD83.prod.outlook.com (2603:10a6:800:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.15; Tue, 22 Jul
 2025 09:12:20 +0000
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a]) by GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a%3]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 09:12:20 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jeremy Drake <cygwin@jdrake.com>
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
Thread-Topic: [EXTERNAL] Re: [PATCH] Cygwin: mkimport: implement AArch64
 +/-4GB relocations
Thread-Index: AQHb+txxbc5KthQQjUOqbt8Hxemkv7Q91BeAgAAG+Us=
Date: Tue, 22 Jul 2025 09:12:20 +0000
Message-ID:
 <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
In-Reply-To: <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV4PR83MB0941:EE_|VI0PR83MB0715:EE_
x-ms-office365-filtering-correlation-id: 35c0f552-60c6-4dd8-70b3-08ddc8ffdcb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ynTCdpJhive8Apwz3Wf/N5pAyKoNgryfxLIqSr+jOubWDMdgjuGbY4yN1t?=
 =?iso-8859-1?Q?8P+2FSwl1h755PdWe32orqIPo5KGheuNGCd6Z8aGrsYLX/rzqT0IcJ5teJ?=
 =?iso-8859-1?Q?e4Rj6xVjLVHZzS1mTfEox/HtDeeFMrNPU7XrSQlHkPsh/nl4SI3V3dcoHf?=
 =?iso-8859-1?Q?ImRNeRrFRMyLlaWlTZ+VT50+7Qg+s+bXISWygykVGrEJyMBAU7IXa9LhmU?=
 =?iso-8859-1?Q?y3xFgAli+ly6di95UdofhwvPJzF2yHHAi7DDR6G7MThjHHB1I/1KJ+SXBA?=
 =?iso-8859-1?Q?GN4HVPSHYLsQwjzTgHu90rZymJzZB4fazT1H5fIgUoXfNKF+jeDF2KPPoW?=
 =?iso-8859-1?Q?/vgJpbwaIE5CmkjVuEYpHduMtcEGYY3+arFxRnupNPxRdbaBMrXl9XlgTZ?=
 =?iso-8859-1?Q?DzhafSmzjuTepHHUlnF/JxxUhsiobV71cBByZuqJU/cUPiD1hEdG6yxrBR?=
 =?iso-8859-1?Q?ezT2vFc69dAVaek5zDMJdFwluOyQOaGr39jj11XnjJiz/xJc5yNjG0gqqn?=
 =?iso-8859-1?Q?tmjhW8CIbcJEB2FE8oqzsC1KdrOOg2egYHkUKeFyUkcqtrQCA5QV7sxcpH?=
 =?iso-8859-1?Q?1VOxF5pd/dn0om92F3tPkqJ3S0MHO592WD2LelCVGAY6zH3nj4QbD7m+Qb?=
 =?iso-8859-1?Q?ZtXKJ5FZ2kBTyfKzQp/3UHWjP+kH3nqFe8glpZ/YrR3KamxvlyX/BAgghv?=
 =?iso-8859-1?Q?ke0c5DAbA9T68/uWyW2Zr/NAyiKGfIGu3GcJXJCBC+0+RJw/8EiqLtzqsq?=
 =?iso-8859-1?Q?NmdiEd2XOHiZts87dzL3aKLU9EZRPV8c29CrA5HkG7QViEMbJuIWcUtLSC?=
 =?iso-8859-1?Q?tInY5v8NxNipMpNWdukN6himaeFLAdoyABxOV/XGTL7CwbzNDuYR0mNUVI?=
 =?iso-8859-1?Q?yF0Y/6G1qCKl5pcCpoOmC3ZSpzgz9REvN2L/DnOKKrVbyYUjZ+exrznO+V?=
 =?iso-8859-1?Q?LMehKDOl/WvsBzk+9Zi1c8FQTLQZGbhcBBEqihCi8oxz9ZNVXBooW2zH4f?=
 =?iso-8859-1?Q?7Ei7XEx1EoDTqEdIULRQrPrW9lYx6sn0bh49pmcpME24umqiQ2r0Kvwm2s?=
 =?iso-8859-1?Q?eGEcXrk9xUCznRLqeYwjhfhs+81fUfu9FozvorppxYK2BMFByiE3PHQpKw?=
 =?iso-8859-1?Q?4ev6FibHqZ7t2zxwyU6VX0C4X+Hb1WRkFhITBxlIc8hg4hvMkSeGD7O4nw?=
 =?iso-8859-1?Q?5YNFDdTCoiyHMqe5k9YtEBg2SYqui3M9a8gKUz1QXJk7do6vsS7RJa43sZ?=
 =?iso-8859-1?Q?Khg+qBmg6zEdWR23o7D6W9qAWl0nVMuTXUmIWqNmsEkNL6qd+jAtDx8t9k?=
 =?iso-8859-1?Q?J36/rLMl0VDEBFDd2RPnFk6EYk2TcIDdAKitvTN8Llg4dZZyaG/w+ykZzi?=
 =?iso-8859-1?Q?KcXqnKSOvOfVXNd6qS476DrM9qFt7i6IxEUAVSXu+hDcEW+EXWcA1CiUuz?=
 =?iso-8859-1?Q?w4RqDvV3vvB7f59LfjGWZrn2+sUiAF6qfiVVxiw7OuA1BzmNwgUzql+Wy1?=
 =?iso-8859-1?Q?ne4SW8xtw8vT+5GFcZODApIAnITXUBDiev2yHkIHsBTg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV4PR83MB0941.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sDarov51rh1xRZ24cm3X5zMbeXVYPwps0dQ+5zWzVwP+7gPVjIN9EX9feQ?=
 =?iso-8859-1?Q?dDr7ql2r/91cklWf8p9jEzqiVL66exffxWXBv6+5aXkljFkCzf90ot5l1f?=
 =?iso-8859-1?Q?yUaIsKnJkHKT1EgLz1ba9UcfRKh1Ya//IjqkeQwt0b77uCiMmu7wtwoPCe?=
 =?iso-8859-1?Q?wqQQtFaUlBzsyZwFlCDgJ6daBxoCWqLrlNrHsVMJLNNpseT154tK9VfhWp?=
 =?iso-8859-1?Q?Mpjbm+6KPWYAR6DSW41T9uWAsbmf6fYiMHR6GuX8RprnD4+WJMeo1ZHEOc?=
 =?iso-8859-1?Q?i6+7xIY9S+XbIPoyfZUmOnhL8dnJfE7Yw5qRIAkBAmbeQTbBGqqNUm7TrI?=
 =?iso-8859-1?Q?gJDgJ6i0jZ/IOB+3wJzauYF1O282R3a1uUgj7BvYIthh4gUBFN9rOhFzfI?=
 =?iso-8859-1?Q?u/sUFJQ5pSl7xbXcZKsn22/na5tAX3r86uLy6UF5zDPcB3yerzV0xwVHL/?=
 =?iso-8859-1?Q?SlFaAcESRuYKOOzLRmm+e3lcB9YjBoLIfMlEf0oM8f++s13vyqeZ3aIsaq?=
 =?iso-8859-1?Q?GkWhVIgu59/B6BT3gCNRbgpbdZn4ZqPLScEmxf9l5SQLNel1btOvuNgugU?=
 =?iso-8859-1?Q?x+FiFYiiZj4b1LYX+guhulXdd/KlsUUabum+DycwQVCHPW3Ms1wEtAdYzg?=
 =?iso-8859-1?Q?nTTYWdOLwYn4/APklQBBDuhHSwUamnmBmfymneiJtIUz9CY3wJoteXcAEd?=
 =?iso-8859-1?Q?LQKuJ8fLUHKxF/Ck1JT9anEdQCAQ1IM7EzYRP9fXEYRHMJDOvFVaz0y1TN?=
 =?iso-8859-1?Q?ONKRPuA703kgybSvpVajRgcEZdsYkZArMKX671DwiGxdm2gaQ4+mVRWWlv?=
 =?iso-8859-1?Q?NAttc/KJmJQYDh0JUs9IJ5ZfuvKZX8mZT4doW9nsB08NBbERnJiFT5NnC8?=
 =?iso-8859-1?Q?QwzpEaJTAIOaLtjBssOhKAGPCx7JWlKIP1Z4/N5sntHUhout7T+N6/cDoP?=
 =?iso-8859-1?Q?fk2kCpNVg84hnxLPhpyQBoYZwaWcv+YC6LhF1hdHHggHA+lOXsQ+eq+KkZ?=
 =?iso-8859-1?Q?/YOmm0Do4N5jzmo3l8avl1YtQTDzqHycCzWPZZpfBnHdlO0WgzCqRIGNA9?=
 =?iso-8859-1?Q?ubbvfrxQ6gIBr+rbfNMcKKtCmA9vYEZjy7j0cmIFJGl7OuR1DGGHW8CwiF?=
 =?iso-8859-1?Q?uHqV5TxVAA+pBP2r9dFwXkCVTP91iKThhnYmmagcK8qZ0yzfAmw5wAX2KX?=
 =?iso-8859-1?Q?BCYpbGn04/NJu4xuKM3rO3DW/4FnPMJuIuoWLz45/3lN6mEoAeuVWKEZFn?=
 =?iso-8859-1?Q?HTcz7uxflp9Rhy9uLcVmp+7ZX7JYghLdNM+ZGVSjJ+1EoCtypzHH7sGrtN?=
 =?iso-8859-1?Q?rQiQiMy3TZtZte/iEUHaPxbuQZKAohcHJs9PPUk2uqa9wx6wZLO9ETsrGQ?=
 =?iso-8859-1?Q?q1NHhTWkAz3JWA11PP0Yet+qWU8pGW8nQOLfLWevtzyF35vMGIspah7w7W?=
 =?iso-8859-1?Q?DvXdl5GXlCw8sHuO/SNotFwAZ8dYsW9jHMh9VQdwvlLepUBj8c2FA3qVpn?=
 =?iso-8859-1?Q?5RsYnllyvHRu6vxX2F/+XwXpzvELOOCIo9yVbfnOavGizNKYhWyZifjCDH?=
 =?iso-8859-1?Q?AnXX+yQjbANwE4jefuB1vNohLoRQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV4PR83MB0941.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c0f552-60c6-4dd8-70b3-08ddc8ffdcb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 09:12:20.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNDnBR8dPTcXFR1AvjPiXRoKFBaDf4WkGf2BJXMPF40UyLP6Uze3sTaVZdmeEnuPP9KGUZTKxhGFmdAS2yfC96ij6mrlCS8neFRWTbNJtRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0715
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
Thank you for this insight. So, if I build tcsh using AArch64 Cygwin GNU to=
olchain, I should see if this behaves correctly with debugger?=0A=
=0A=
Radek=

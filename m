Return-Path: <SRS0=wKTa=PI=al.insper.edu.br=betinaoa@sourceware.org>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2214.outbound.protection.outlook.com [52.100.156.214])
	by sourceware.org (Postfix) with ESMTPS id 36A1D3858420
	for <cygwin-patches@cygwin.com>; Fri,  9 Aug 2024 14:38:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 36A1D3858420
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=al.insper.edu.br
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=al.insper.edu.br
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 36A1D3858420
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=52.100.156.214
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1723214319; cv=pass;
	b=lAYk2maWK0jeh0G484MMv+2E8aTUF2IG9AGz8Gb/GNWh+7lY4YRTdJDisJQN1WjJuCU9qxA+F+vdZdWtJi1CGnJKkZobN9KiUZNJFtq3QaJTbVG+vnZCVJZNV/Nq70OLeotFKVlgKWjSOE4ieCKYFlNQ/6kuETuJHUYdIS3tuXA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1723214319; c=relaxed/simple;
	bh=/q7mXecl2JCHnP+cva76YOvaXOZg2v10yNKq3Rd7Ah0=;
	h=DKIM-Signature:From:Subject:Date:Message-ID:MIME-Version; b=gkFHJll2bb9zV/49wwLUPrYr3FQ/O0LcaG0HIL205wVQoKx181zUhB1rsU7wlhuC/aSsPioNPhZkOCVlOx3Kxhyt39Nxg7SXoaZIg7sHw7QNRT3dIqNK9JGreuYomGhGnKUhCtQabvQm9BHqkmiHHmmgzq6Fvka6aPdCuI0M4i8=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRiJ/R+0u8sUicTLiq4yEuWMHZL5VKYaFB38ucFM7/RaQuKsqkR7ixEUhRPZBjqP3hhdt7smoDce7pFE9hVVfKkrTxclvPUdzKQsY2796bQchX49HfBVRVoB0rzzKSUoXEvHsmRmmazwRsMHahuGd5socqwxCKcEOxKp1lQf4cMzXllxjgdNZcNbZLUE/+wTeYt/N92vT/GxUPnkdVsKbIHdP217T3e6tlnXhv/FaFyv+7HUkQWBYq9QQVdag+nrY7SxLNN1ZE4ODL5co6fVN9u9No2YmtB/ApyvAwNvEagFNm9ODsqrllrbv+unOjDLMmAdrw9CEKbjDuhBcgHpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lzb8CB4TErusBRmel1zEJ+OEqKZh/5IsePjA3U3XgM8=;
 b=tYeSdqynhOvjZMDbCkt08A3c3bKzfhN3HR8ltQFiqw2A21Qd4b3P1JE3aLU5ywf3O7gGT3mFvPIrTTSgFWSq/PTSGuW/9tOTNlWjPHxzIx9X0OibWb+HmWKg//8wMQ68IDoDtSN/uo/fNfTtlJm8xwkcOqQfz8YCkzvvCBuEThOrTaH2FF399k5UglvhP0BlSoYvqOf5/oO+wESsA6gCEbOW90Av2g56ZSRMo4EeZZxfU4A1tgb6mVkPoaJ/g1dIdbKCXbArSC5ce95EDwNOh4a2rqapoLw5cZo/ED4OlOqleR/SsmOqBSJY0qLmYEKZq1Z2sY22Mp647ytp2MRaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=al.insper.edu.br; dmarc=pass action=none
 header.from=al.insper.edu.br; dkim=pass header.d=al.insper.edu.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=al.insper.edu.br;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzb8CB4TErusBRmel1zEJ+OEqKZh/5IsePjA3U3XgM8=;
 b=KImzVr19tfr/0ztkRvSmrEAsgjasBugyTKMgrzzR3FLSqEc357d3ALCa5rCbJ/1XYZE87ho2zUVRKYBJmy814rcljX5+tRU6mrAjwIfdL/dIL8y80SD47VPdD20q+Fj8Hx4lXFAcpmKRCLbF9u+pf8OmPb+8aSpGQASy/4fSXJc=
Received: from CO6P220MB0649.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:354::15) by
 PH7P220MB1398.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:312::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.23; Fri, 9 Aug 2024 14:38:32 +0000
Received: from CO6P220MB0649.NAMP220.PROD.OUTLOOK.COM
 ([fe80::acf8:f680:90d7:257a]) by CO6P220MB0649.NAMP220.PROD.OUTLOOK.COM
 ([fe80::acf8:f680:90d7:257a%6]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 14:38:32 +0000
From: Betina Olbertz Amaral <betinaoa@al.insper.edu.br>
Subject: TEST
Thread-Topic: TEST
Thread-Index: AQHa6mmymLQCdOlN7kW2K7U6WchrlA==
Date: Fri, 9 Aug 2024 14:38:32 +0000
Message-ID:
 <CO6P220MB06491625D2AF4FDA3936C66DB5BA2@CO6P220MB0649.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=al.insper.edu.br;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6P220MB0649:EE_|PH7P220MB1398:EE_
x-ms-office365-filtering-correlation-id: 393a9ab3-a73d-481c-2d58-08dcb880f13a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018|41110700001|41080700001|41090700025;
x-microsoft-antispam-message-info:
 =?iso-8859-7?Q?bKxmU0BW88yfXZiZ99Vfuw6KH61A/PdtuLQdZ5DdQ+j2M5xFAleAxQEFXO?=
 =?iso-8859-7?Q?QVRPy0+6o40SL+qZFTg5hgvplQfQtIXWBJ62kxMtMz+WvwKtsla7NZBSw1?=
 =?iso-8859-7?Q?SU0YqgCd93dU7zAJP211tmVPUY84X+daoW2mvzrdjqhFDN1keTwL4PKfHT?=
 =?iso-8859-7?Q?oN9WGLc8UEU4qHMcEyeEJs+HSVazrBtFPNQjLCmauiVAQxpqYM4f20DFCg?=
 =?iso-8859-7?Q?nJeCrVdrFimmMkcKvg8oXh4c/nNiTngSZxcNn/FswV+VW1uR4OjOR4WmoI?=
 =?iso-8859-7?Q?ekqRY57j9LeuAjxUdDkOwmsIkXGeoB5vJpP5IcrfG8I9oEFi7zr3zrqsul?=
 =?iso-8859-7?Q?L+Ir1lIG6c9qXmiCo8Nj/CuDEMnORiO5lWvvLtNOCrhXHxQyK2DULvGSlY?=
 =?iso-8859-7?Q?QgF5TkOONlF9IX3AH4OD+GPE3S4K0/stXySPE8/K4ERJhlGOf6wZ32FmZc?=
 =?iso-8859-7?Q?9byhc9wS3jfj6VRbCTJe82mjDNC4gL5KF/3q9toEBaalCACaIYEYeO6gfj?=
 =?iso-8859-7?Q?eH3RyAe8fBXNl7I0NSkvM8z682vpR9a5vWkWzc30qKmdHaQ+3Dv/Bo2rVa?=
 =?iso-8859-7?Q?dRyRhv8wVaOLXlWFINB1VHaCipaxojOk3RTDcXgf8dlfGArX63/UFLwKVu?=
 =?iso-8859-7?Q?RU7n4d1ZpBbjMqJn9u2MCjt2Al1i5SNLYsVlD1q1j7SnbntS7LkNJkX0u8?=
 =?iso-8859-7?Q?ZkqLUq77F0RII1tAPF4S+tk15CZ0Zp/hIa2RJFhTGRkKhJ8YW2KI7wYDDc?=
 =?iso-8859-7?Q?aFwgDU0vejVvJbqIo+bbMTxReqR/37EX+Er2T5k1MJ8bz5INc3G0P8rtir?=
 =?iso-8859-7?Q?iIkH+FmLewWtBY7pl5e+cOLgWqGYVXCj+DAGulZG2TrwWPnbUlRUTNCkc0?=
 =?iso-8859-7?Q?Lhd8xeFkjKFUYmciTYccm0Y2tC0dCh7r4i/9jjMxT+BcINGS6krLzBovqA?=
 =?iso-8859-7?Q?JEsRqjHKQgeQ+hlEOmIGoV/SbM+qHt52VfKCXiXqU2hb++dCxiD+V9DFCc?=
 =?iso-8859-7?Q?QjeQLFNJgPID3ZU60Ifj3wVdmPwQXkU8Kfraj3bv+qYsWQafDVXHvFQV1s?=
 =?iso-8859-7?Q?Jio2za6BKYo/E1ORagqFixKL2xBd2WkappW0hIw2Pq/t4KdzxeRbVYrofN?=
 =?iso-8859-7?Q?7EDmVrPsLUaVnbQzlykTR9RoWHp83OwS0sc3vFe6ttRktI/Xdtgcc3eZvb?=
 =?iso-8859-7?Q?q5Spgc9HPOuAqe9fuIh9+47TcPyfHKFwSeSNs+51DaAfBeGq/PCO5Oniw1?=
 =?iso-8859-7?Q?kByxy2yeb/wLHklJrZS2b9tzZqAqvA/xptnAAAv2aQWLxdprNwhy7uIEls?=
 =?iso-8859-7?Q?1if/NQE/RTQ7n7kbk7h/VVM1ZhD7BuS+Xzymsm0hN+b/PQ0svuaZp18sMZ?=
 =?iso-8859-7?Q?b/RLqIociqery6+qzSvgc/ArkX2Z/tHDLp8Me0l88fpNRyLdGGnER9gwFW?=
 =?iso-8859-7?Q?2uB/T7WWXu+sjW0gP8PpSTDuvjAVj9kruDSIfbwtd6psToZatQxaewG+FW?=
 =?iso-8859-7?Q?prYgtCK8zIAJODRZFFHbeOeY1+Ln5CqOQBjgnQd/sm4A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6P220MB0649.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018)(41110700001)(41080700001)(41090700025);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-7?Q?QU9LHcIuqQp/hcvNQyyX4Hb8S5ZXh6NMnhmhuJHFd9QhAInOFQAj48HVpz?=
 =?iso-8859-7?Q?S87zy6UgoT7+jnVKMaHC2g5biGG57XVrmxdg38VAfp6+hEzDVAfHsHLq36?=
 =?iso-8859-7?Q?5/LDZyyNFc0TvuIjo0fdfY5oC38dUIBByc9bYEfVRQkpqCV5JK9pn392sk?=
 =?iso-8859-7?Q?moLDNLKog8UmIPpWPnd9zFyoSjBmHBylEN2zQUp15Pml9P4IpVpqgLtAqW?=
 =?iso-8859-7?Q?GBqwMjmSZogkf4xlDqY2zvFiP1XXY/MwMVTrav/niVSgUQpN8hcTnK8ZbB?=
 =?iso-8859-7?Q?tcAUFlTRkHEShGhqxPJrydcISWMIUJyBdeIxL5/96mj7LSFZrudH7v2yHc?=
 =?iso-8859-7?Q?guO97FGc/CKCIcTueAu8dj8OTaKHMKOB7qy8r5bTZO32cJPCpB9OGsaXI2?=
 =?iso-8859-7?Q?o3vt4tNc6uNMHxiUO2T9xc65HVLwVlfGJUI4u4hgxMZnEuxmXYqce9Z37U?=
 =?iso-8859-7?Q?B1t7nFGs9mzq2GnpMKNbSLnbudbvpF4AB/mEDZAk7hGejJao0oGdjeI6r6?=
 =?iso-8859-7?Q?kGA8mOt+xw7kdXk209Z+fJ8maZuuZ5cI4/1Cref1Bf5kwP1Asehq7SBFMw?=
 =?iso-8859-7?Q?+iIkdAviqEJNEDPLoXW4v5xn+PHUWfwgS2KE2YnaOjYin7jKRu0ilU/S+s?=
 =?iso-8859-7?Q?HxPgrnQcszwzg8PQRJtlRHxGqJc/pbGmNa9N3Rb55ShQBtXaMXkg2/JA4M?=
 =?iso-8859-7?Q?ESiJq/UwVbDYMlc/nBO7Brw2EUH4WaKGGeHdqzg5o6/Go2BX9XqCxTLWq7?=
 =?iso-8859-7?Q?jD2YUwaYLtqXu4wtOz7+PT+VPL1E73socV+eBo2TINgT/sfPc4p49H7yWp?=
 =?iso-8859-7?Q?bqtVigNpaRQLDhpXSApUvpQ9jlnpaLkvcgB96CfS9CgZ2Cusknfpcfc0J+?=
 =?iso-8859-7?Q?VyOyULUbfW2IgLno7Cv3W4JuJ2hSHV9Xk4bYatYq7GWtH2tX0Usy6iBgni?=
 =?iso-8859-7?Q?HbxJTDFKblVY6o1PtBmaZYAIJcaDoAT+Pif39yJZgEeZzTTmP2YAbIADNN?=
 =?iso-8859-7?Q?cEQczY5IRFK03qFaUXKO+9d4kjhFe3J8BhYY+2TZYl0y5hzig3wN4u0weU?=
 =?iso-8859-7?Q?rD1do6HdJrgoOsdYncxm618oMJApIem48dhynWgcShV2diWOx5WDEMk3dH?=
 =?iso-8859-7?Q?+Zn/Nl+IP3ATb5/pVCLNZyrtQukM9o0P/+3pM/qTAE++7h07RlCDoz2Rky?=
 =?iso-8859-7?Q?OAM+7DwomuDKbFgjNUNpPg7t9VjSXe0zij0NDWqtbAvTDshu2UZDhsYQRq?=
 =?iso-8859-7?Q?opj1CPSz7lQ52ThSJ2cQ4ODeA9L0Xt0NHtl/FS+x6IcGX/jOPjpdzb7wj4?=
 =?iso-8859-7?Q?xaE2Miz+eHGYh1fcFlHvQBnQYIPGD8Xgn5xyjoUgmE+eum9lmYqASPKD7s?=
 =?iso-8859-7?Q?apjv98bzoj3FgZMziuPr7rvIJWlOxvIHcX65obUZ5eBOc615+YUxQLQhr/?=
 =?iso-8859-7?Q?tWPF7bYF5ZWTzK5I5AIMRg8HTz7yH98p+SCZjvVkjLGD+StoP/ifE5LRNh?=
 =?iso-8859-7?Q?3WBVMh5ohTCgQbu8hTaTUxBkXhJGHd4/aDxELRZ4w1iG34tnJvC7uKwyPV?=
 =?iso-8859-7?Q?Dvfy0bwfvXNfPnHm6zO+ShOFFC/gAJcHZcJy6HGbNiT5TInmUNCEf+RRHE?=
 =?iso-8859-7?Q?q+W8IA2S5t4KbE0a4wcLMl7hJeblt3gq6G?=
Content-Type: multipart/alternative;
	boundary="_000_CO6P220MB06491625D2AF4FDA3936C66DB5BA2CO6P220MB0649NAMP_"
MIME-Version: 1.0
X-OriginatorOrg: al.insper.edu.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6P220MB0649.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 393a9ab3-a73d-481c-2d58-08dcb880f13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 14:38:32.1829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6370a6c0-7b90-4709-bd6e-59c28ede833b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xG3/ssCL8WUkwQor4NWwqEzzM9FY43XuoLyj1KpPPtWURWBPFBU2CzAC89MpjvQYoZ7aTvfdPL+vIyjDomS+P4w7Mb9Hk/mmHPgLJPcxGEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P220MB1398
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_CO6P220MB06491625D2AF4FDA3936C66DB5BA2CO6P220MB0649NAMP_
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

Hi there,
I  assume  this  email  is  still  up  and  running.
If  yes,  do  reply  so  that  my  b=F3ss  can  discuss  an  int'l  busines=
s  =F1ro=F1osaI  with  you.

Betina

--_000_CO6P220MB06491625D2AF4FDA3936C66DB5BA2CO6P220MB0649NAMP_--

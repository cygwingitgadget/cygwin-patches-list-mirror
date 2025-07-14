Return-Path: <SRS0=ioON=Z3=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070a.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::70a])
	by sourceware.org (Postfix) with ESMTPS id 823813858C48
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 13:59:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 823813858C48
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 823813858C48
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::70a
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752501585; cv=pass;
	b=P7YcYIBRRL4gpnoSZW8XTHqbv5nh/+kGfJZ6oEPgtgBiEAnqy15lQdw+R9cyvVKbKaGzMdrvRAcaBXvIzwHyhID3YZSAlY4Nn/x+gaRrnRyahkrdJRG2rUhputEnTnxK4DIle1utpRBiVFEf1de7lB0MXOE1uwEIsz6MdmCV564=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752501585; c=relaxed/simple;
	bh=XqdjkCDxe29q2SL5dKrhDBY5KkGNbhFvpnM66zVxgT8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=VEp/5LC4elimCs4DrsBSdG6pIVom2HAxYJOzdELn4YwokaJjhCjWE7v3+ahqKJOB0hf0GvTwjE4pR4sTpmLmf62rkto05/g9JuhArCGkYiLFsYTPtR3bDQCoKHB+0hmE2jSdLcqD0hVXWGiauCNcWM130ZwXonkc78duwdOxIjw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 823813858C48
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=NDDielH4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3EuavgOXTZo/pcFo3kEjFBzG4y1e1KUzLsM9Yk71xV+4cAk7FGpNuhtBTFfiziEPXRE6sDHbZ5JlTBPEuYgv1rCM5sjO22d0bXIRnZzOh9/7dL5ZTdYSai8OybCq050y006aA8bKqCapcXF7E7Cs4AgeAhhpsEdozhlpwfyOyhSbrHgd2dvqlBGn3v6GQOv9W4tnsGIXEm6JphDdeHyVPyCVmOgHmhAlmnx6Cg2mpSaBso/ez6sZvnjI8nT0di/ekhtcFIOdJn+le9p5eJf0nUd1GU4t8hzzJtdhuGcIoYSp/98P254b14hb3CBNMUMXI21JY5i+eD9mvunhEf/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqdjkCDxe29q2SL5dKrhDBY5KkGNbhFvpnM66zVxgT8=;
 b=vi8gULreF26LeF/T6u0EifiarR29hAxsKaWRIVGCD/dIJdgKu6nJexPziBdDcSjUtWBfISXpUrasol2a68bfMSwLGc2N9Bhtc0/D1omfOGiTA3VpTXp0Q1vQhDTMYqsayY6IVBkc+KWJhhrKpERIBhIGZTNUktescnns6SGfPP3zW+6KsX4/8x8fQylfGfoldNBTm3UG28sRnqCuPuRgs+30+0Mr+PLmeLt1gqJsfw+GcPlTssa+TdzoR6G9mPwyEVGGZ9NIPp93v84Ita54/tvgH8y1HEiPicfL2XETLzVKnC8KEw5GuG9VwMPRoKenEe9OZCZZ1RsTyMkHmQjsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqdjkCDxe29q2SL5dKrhDBY5KkGNbhFvpnM66zVxgT8=;
 b=NDDielH4wxNPoC/Cv968HiujVFgq5ysInni85ZsOpew0NmPjkksPPAA9gO8QLkcp9Jd8WgyRsWdNtJ04x8fZclOSrih8WjBvToNNxOsB3yEbSnHZ4TlKszPj1xIqORtHqaGbNaF8kWlGWWy9pyUyP2VFa0EeSl7CVlfvP6tIXbk=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA6PR83MB0626.EURPRD83.prod.outlook.com (2603:10a6:102:3d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.14; Mon, 14 Jul
 2025 13:59:43 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 13:59:43 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Evgeny Karpov <Evgeny.Karpov@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Thread-Topic: [EXTERNAL] Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Thread-Index: AQHb8c98UO3l6Yj5Mk+U7ImBGJ/smbQxoP4AgAABhwCAAAfw8Q==
Date: Mon, 14 Jul 2025 13:59:42 +0000
Message-ID:
 <DB9PR83MB09231FD87FE92056367C0D829254A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
In-Reply-To: <aHUFzEEGq448gvZ0@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-14T13:59:42.125Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA6PR83MB0626:EE_
x-ms-office365-filtering-correlation-id: 61580901-b748-4a5e-c81a-08ddc2deaea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?h6wJ0JAeex11oYc41kwGtoUafzb/8l7wON/mowIJ/lpKmJGM1uErZ8ETLo?=
 =?iso-8859-1?Q?SdZVUzaP3+AYBS5ZXCZD1uhjpEOnAxlmBHTfCKc1yYxZVUFAfo2RXHoMWh?=
 =?iso-8859-1?Q?wk5IgEjIK83AjjbRK0q7InWVdbNT4JgP8XXCWuofCiVYi9kk8KIkDYTv/p?=
 =?iso-8859-1?Q?I61j3EK1A0emwBqSpGWJxNAdGft7Ue6iMR5589VygoIweI5BLFNOHKQXM4?=
 =?iso-8859-1?Q?BGeImcprHwlXAx7m/Gcq3QMoVn+5tOjLLRCzKFyUeYlscurv8EzEjQobWO?=
 =?iso-8859-1?Q?unJsRegl6IskwOcQHuaPUjxLRHVFTz+jdboS05qCKpcgeaNV4uhWGeySTN?=
 =?iso-8859-1?Q?hcDOXD0XMnIyCgLM62vhXXYGLeR1uhYW75GDoAmZk6FZkN31jACvLTUemG?=
 =?iso-8859-1?Q?F/fqvCFeT/V03kMpnmRSqRKA+zb16CSsSCBL4A5aF4WhUO4g3gKDV6I9Rk?=
 =?iso-8859-1?Q?oMaA5JTh8rFKUwG9ZSodTnm34w+FuVhbaM94LAPQMOFUscAtLdzxOGOvEs?=
 =?iso-8859-1?Q?0B/p1iWiBzuGctDbGv7KCars1rzS2ZuN2RjzZfvpycCJsRMVW/xyTxcOSU?=
 =?iso-8859-1?Q?r872e0UXQhelnwM1+fDM23V+RlLnV+YOZ6lBYO6Tn+ygWGoCeu9hQ7iStv?=
 =?iso-8859-1?Q?PMtpi29Z3e0QHl1B9ewtZZtYnr71fSNNSyk/p7/8AhLph5mj4yI9yvL3oR?=
 =?iso-8859-1?Q?L9CYoRPJZJ6tFnGAyobAdL1ydPIJLsKLd8rSSFfS8m6W2NxRJfAFJlXNIV?=
 =?iso-8859-1?Q?Pz6tnlSFkxxjRLJnlF4fzO7aHnN5ibdVo0vIdY4WjPY5FLgPAQ0LnPPmAO?=
 =?iso-8859-1?Q?6Jiwg634POpUFMHKQjFSnWUH5ZsJ4ojLlPpSNmEDYFZpjdID4JWfLGvKOv?=
 =?iso-8859-1?Q?qOETdi47YR9yyZKcspZW3y4grC2UmFpacQ5H/VLT64QaCETOKD1wK/6kaO?=
 =?iso-8859-1?Q?XK2KZQd5fctoWYUiwqm+OmwUgwN1LIR73UzrUU+2xSgi6/824KiCmCpQIE?=
 =?iso-8859-1?Q?sMZGhV0BNNFAyTW9+715P6BANBYAQh35ygSEf25fqD+zmvxGuJ9ax8Snfn?=
 =?iso-8859-1?Q?t9PXPpd7494Ms/JtQoe5ulzQKYNMrSJ1BEuXmstwNf/9V7jKvH0XsymjpC?=
 =?iso-8859-1?Q?crLhV3iCisx6aTcW1Yz8syPWtddlDfKuWdK4rVddqKptI02ndzPi3G+3d5?=
 =?iso-8859-1?Q?a3f/RAs/fAGwvPgEIC2yaSWko6e/7oimjfaiKfUvjEenrRDCdsaT+EGkEj?=
 =?iso-8859-1?Q?askXhqk0jMp7547P5aXySH6YBgOP0LHUl7+gQ5ULSfBL0F606X9GNTFOtx?=
 =?iso-8859-1?Q?bsp39i6+/HaLE8crcJjoYHwyg0mgyY+WQM8QEvh4mGLr+lsrc+oViuyqxG?=
 =?iso-8859-1?Q?9O72SGqs2bWcQriCpXzKYfdLPHOuY4hA6TprTNnvnma4jElBvMPYlJLB41?=
 =?iso-8859-1?Q?pVqw8UBHLR2vnI2R7nTvmdTXnCliJg3cbYxx4P2Ut1ZFHCbEDfL7zM6DcW?=
 =?iso-8859-1?Q?NJzZFGGGEW8sUcI8QThVDtEtQI8ni65MjJDGZ+N0YICQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GEAFEU6BTYrxYQ8fIjs/WR/ZLitbwbFS7qLjhnWM9+tITHzKR/wCXd8+Hm?=
 =?iso-8859-1?Q?vcSfbXpyoOVYheCI8kW/Oc+PNsa84RezX9DDZ82AiUNgAMHzGNexLcKVsw?=
 =?iso-8859-1?Q?FaMojYDUBTcDapMd0uUP5enOjULx4npQhj3r5cWg7LYAvWYwseUfIpcM1t?=
 =?iso-8859-1?Q?KV8OrVPmutS/p1QQ+E6MgFmz2IHz0VMvbEjG9NwP64Zz5ej0g86t/TM/nL?=
 =?iso-8859-1?Q?m0xt47d9cTJ+MxOR9AYnc3TDXer9eM+rZfxTqFqdCGVm6+3V6GGuvOahpi?=
 =?iso-8859-1?Q?ZhoOZCyMz+EmML92Pn4vBcZpri+gAguBQ6j06z6tSaBj05qaQVV85/rEds?=
 =?iso-8859-1?Q?w3FZq4h7wgUUlntknWH8utB2UvqL6D5Yej/0ghRg9XegJxtzUTVnJj/t9+?=
 =?iso-8859-1?Q?Ru5ei/mrrPzcl0Xb1DUID8LIARqy14ymR1iS+q7co+koxZif4QJ2KBFJf9?=
 =?iso-8859-1?Q?0j8kjkj4hoSZhvyyFiAw7c3yIHM8jWXeykSAxSNyQoU3rnsWhLYBgU1y7j?=
 =?iso-8859-1?Q?G6SKFjFPSq8VzOFfd8N0G4aEjOYekYiNH8bGLv6fkxqHLT2+b/HZbipM13?=
 =?iso-8859-1?Q?fmaN9uEh4RufPLi8w0JV5mYjKKpj19hvo7DsGdZtvf+6cRHo095d5lalZc?=
 =?iso-8859-1?Q?0IKvfqjuKAFYaq8Rqrhbzc9pZABBzXvQaTAXgqUvLms/NNSWFxmLMB37qK?=
 =?iso-8859-1?Q?J8rIveqEjg56HMyeGAa4+j9yDTFwmtsuhz9RM/6/cQQ138R9mDA+cu/y5t?=
 =?iso-8859-1?Q?JkmzTH7fONwQVCSPgynAfPGafmw9ihGDNxk6R7vAzS4vuXNMdvZWqzGymx?=
 =?iso-8859-1?Q?Y3ixp1gDLze1AxSAMEDvNQVDepP6bjhq31gDamjwkun5lnCAzw4apAhjS9?=
 =?iso-8859-1?Q?uHgwKvhYs2c0XtTARcWjXaFvQjSgpx0r/jv6vsnS155Mt2Qzn9R5yGtM3a?=
 =?iso-8859-1?Q?TYqL8RFNRYre8+m7jHVIUPWat2mNz0L6uJB7Fe24bl7cDzfW8+X8YZf35h?=
 =?iso-8859-1?Q?hh9nY+Hsn1I/ZPUYFl/4DV2T8ID6Dm7CCOpjM1IVzf8KVaQV/nTWtQpQkp?=
 =?iso-8859-1?Q?WeZtF+4qGElijd03zQTM9HwgZaA1Fpp89BCokZj1yVhFybp0asZWVpJLne?=
 =?iso-8859-1?Q?fAFvxCVfzvVCwYyWttnNIiaabjXp1WUOrF9TPR5axLYl4H3+QqQACCLJ45?=
 =?iso-8859-1?Q?53HpHXmOPnNhFPCyJauGoeT7x1j0ee7biZ11gtu87AtdqMZpY9NnqG6jxK?=
 =?iso-8859-1?Q?ONoJMmq05at0PB4Y3uAxiIUJmNA3JvQfmbWKv4pLEAo8TK6tqkOKWA31Pp?=
 =?iso-8859-1?Q?TCElUocEYXgRxKIqInDBND1Qq6Y2bJP/Eo+9ecvf3smC4HjaCsmsk/t0tN?=
 =?iso-8859-1?Q?OxJfU/MKtssKflCxU33bbXaqheDggDTkwPfrz+iNfiSR1qjanpj18onTa4?=
 =?iso-8859-1?Q?kOUrAFNlgC7Tv+qhWry11Lb7QBZUg7uE86hj29jxD46tVOjx+VE8ek60Ie?=
 =?iso-8859-1?Q?nVk3kOOUfGXS7krH/akZZGEg7LsxMBcD0v0ARq7JnO+02vqhlWmno6d5gw?=
 =?iso-8859-1?Q?uG+s/bsaf9K+4vtuGmwLPayVbvQp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61580901-b748-4a5e-c81a-08ddc2deaea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 13:59:42.5128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGlYLcI6hhMIw5WbRtf2ibf6vqO5KTgkqp1mDqUm1LHdwNToUN7KYAPAQ3/cEFZHGG/9ReyZ+7R4g+DDecPgVdB7SFTFz5eWElaqDJhMBVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR83MB0626
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
Uh, my bad. As I need to manually edit the `Signed-off` headed in the `git =
format-patch` output file, I have done the edit, copy&pasted the text to th=
e message body but forgot to save the file before adding the file as an att=
achment.=0A=
=0A=
Sorry for that, especially to Evgeny.=0A=
=0A=
Radek=0A=
=0A=
> Sigh.=A0 Actually I shouldn't have done that.=A0 While Evgeny is the patc=
h=0A=
> author, the *attached* patch has you, Radek, in the Signed-off-by, and=0A=
> that's what I now pushed.=0A=

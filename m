Return-Path: <SRS0=0muy=ZI=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20719.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::719])
	by sourceware.org (Postfix) with ESMTPS id EFEDD3857400
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 19:50:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EFEDD3857400
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EFEDD3857400
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::719
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750881016; cv=pass;
	b=stqyaYGbn43RvPP9chuaD5bRz0I4UdGDf4k5foPaegsNmsAj4wGYqkEBtb9TfPHsCMbc093YBHtFz7X6w84gRTqfpgAxLTUPDbhwzch1eXVslE/rCXPnGhz8qD4XNhFEKWx/9Xw/aWDs5sg57m7RsgzKZ4q65P+hTl83l6nPlUs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750881016; c=relaxed/simple;
	bh=f7VZ5LKw8S6+JhqVJoGxI9UlcjTxhvvz3+QNm50YlXw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=HrUovQ9HHSfclIWQntq35srQQ77pIr6J2tKOY6zCHYvYmUtxXFzGfFMbwmtJxArms+hK44fDo0ixiccc+yiDqI2MpH3UT6Hh2pjN7QwkIhaoJiXy7Zgh0QcpTZge/HlT3I4lrALwL3El+W5wvj3eCoju2v3wzOIAdHKp/DecQ2Q=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EFEDD3857400
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=NCKG8ggH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1nMV0QmOlVzgxlP427QcpitHeBqKD0syjrAysTkHhi5dsGurt8uzH+Rv5FAfsLlrSgiQUYQb9pQSe5NCiRPCseyfyX9bL992mnyx+toh+InI/6Gv7/1RMRstmmrhil9/gWOWhMSgE4hgaGFsEIFB4WYfSTiRa+i64lCIPOWh4Qtuf0tTgjXxJG8d5b550BiF6f2/+JOCJvv6SnD0utHVvC9NBnV3ooRGmO1WOnwQHCTL9J+r7XEwWEiW9qebyhsvG99bsFCooaXVjGrCxts6lmDMmQJuwkp4kVZCrUqaLEYWvBaTf9rkA/wlKaWYwx+fETkLoDLXCd2fZmhyIgpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7VZ5LKw8S6+JhqVJoGxI9UlcjTxhvvz3+QNm50YlXw=;
 b=Rv3wqogR+eQoE5Hu160W+sGq1OjsVfgMtfKVLDFMXen4ffz+EDCqQzm22GD5RCQZwUcCUhChrfEvJ7XjmtO2JqdcjQ855rVUiJJh6zvnOmT4KLKxrUbWaWJ2AMV0oAZA+01m9NpiYhCkHqT+rMws8fuiUcPZ2ZVD8+AI6ID+X2e8FzM8F9suj6m2vgtu3DK3TYX/RzqRJ7u5ajIdJsulQHB/1Iv7eJz/ffqgl9ROugLBtMLDKgjpNkajX1EfMaC8aAIYgnMBStUQERUjaIKZSrgfrt8BAktZeV/zIvUZmwYjO/fBzXyhQo0EsbxJ/jY8WY1mobm81J8bafEhrayBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7VZ5LKw8S6+JhqVJoGxI9UlcjTxhvvz3+QNm50YlXw=;
 b=NCKG8ggHLcuageSQD5t9dOn+4AyFvKrExev/yyDRSoVy03Jxuu4kYcyJpvbU+fAYvasLpomrpaJ9LMJ5xa7dlow6F4oYviuDwGbxr0hxYsoMzdl1Q+h34rfRSXYFZ/5QxUUNIEByrAEDJ2cRpzGyNY1x6+kOAM42vtg+vAPZRgs=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GVXPR83MB0783.EURPRD83.prod.outlook.com (2603:10a6:150:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.7; Wed, 25 Jun
 2025 19:50:05 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.012; Wed, 25 Jun 2025
 19:50:05 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>, Jeremy
 Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [EXTERNAL] Re: [PATCH] Aarch64: Fix register load order in `ldp`
 in commit f4ba145
Thread-Topic: [EXTERNAL] Re: [PATCH] Aarch64: Fix register load order in `ldp`
 in commit f4ba145
Thread-Index: Advl/GwKeLwEPPBoQJa3fUrayNfVSQAA8veAAAIrpvc=
Date: Wed, 25 Jun 2025 19:50:05 +0000
Message-ID:
 <DB9PR83MB0923158964E875DDAC33C118927BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <MA0P287MB3082CD4D85400059F59A3A449F7BA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <2d238391-3495-515a-2075-2d327508d793@jdrake.com>
In-Reply-To: <2d238391-3495-515a-2075-2d327508d793@jdrake.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-25T19:50:02.575Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GVXPR83MB0783:EE_
x-ms-office365-filtering-correlation-id: f0f9d3dc-e833-45c1-27dd-08ddb4217bb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mNcbMbSh+wDze8iW/Z2S470jxpqEbOwxuVELn622DdqI0f1qStXikEOqIg?=
 =?iso-8859-1?Q?0WOimzb4zMy09443jUlcGVQXUiv2WyPGRGocFaSlgqeWl+c/HQQweriteI?=
 =?iso-8859-1?Q?TWGv6pyxGJBZiy6obg0WD/ln+TcwvSb46/5xjG0kid9IoC4EiDBIrRLHpy?=
 =?iso-8859-1?Q?SvKo5daf+QW35T8ULYI3XNZeCUChjtbkdmi8yYQcNTF5LmDDRFurii60dS?=
 =?iso-8859-1?Q?fymHBWKdS6ozg2zMMtchj5VX4d5GUxw0jfmdkHxgF8M8mp/BxKE4+NHIdO?=
 =?iso-8859-1?Q?4VOBCHo79cOnItd/hUHBw5Pl2DexqIMXaHUKD1XlADj48d2ATgS1mZAcG/?=
 =?iso-8859-1?Q?+Qt3sZj9hvQqTRSMdCG0+TsSLforMDtTB/RJVPzdsvAWOs2Eg1XqxDJ7UU?=
 =?iso-8859-1?Q?/GP2fFQjNIxX4Gc8l6FR+XS41UGeyp8iy2fKTDGAS1c9eDwdZWTDMjkZCc?=
 =?iso-8859-1?Q?c0agSTE7tJQFVbkWGjYtjt8qarGTFYQETFuS35Iyc/b/ZZm28KUrqupJBt?=
 =?iso-8859-1?Q?DuF83MN89HJP+s4zP7u1F0+duZmlrU6x9fOEYN7cWlhGHfGu/6ExdCQsG2?=
 =?iso-8859-1?Q?U0cdcqe7R1nuJ8PIWNtlWNhXe0Gw1L9ME/wwnokdJ3YC2NSj3Otn0yG7tS?=
 =?iso-8859-1?Q?vwCVGEw8MbLQqDmTXbJ5WQZu4kolv4YFCnEIgZ/W8nXpll8Mi2uBxvd94B?=
 =?iso-8859-1?Q?MaNMRseD5SJYXr3r9lCm/DpuiHGj8bM8zajrfNO8sbyZPqvoyiTsutah/p?=
 =?iso-8859-1?Q?sf+J43B57fEXRvwSiAn8NWrjAJvdhZZnLgMuIRCl+jdvqSjeiqP5MbsjJJ?=
 =?iso-8859-1?Q?odMKQCkaI7Z4A9BYnnNZi8V/qlaEhY89b1O1rE0NUggqRYKns9JBHEpuYy?=
 =?iso-8859-1?Q?AY5v5Pb33/dO0W5JYskcLd4OwZoT2RqNPm4O7gxiW3wWc4GwIEhi6BcALt?=
 =?iso-8859-1?Q?uY4GtTngDgKVjrIhuop/svz5BUuVk7ZGSbh0YtPV6VTFhaKrbCVngYAcI+?=
 =?iso-8859-1?Q?iXJljY/DTfpctmg9fZT2UZxX88jkIoirjhWSv0RGsxtNcmlnwCw7BXRewK?=
 =?iso-8859-1?Q?KpVn9o4IanhYmz9c0yKJSfTFwNLPFIOm7/8GdycLm508oWoDnLuAWyqxqE?=
 =?iso-8859-1?Q?FGSbSkVsY1TNhgmWLfLMdknOxUnjjGn9UJung3BdZDuiqYe+cFWKFvjXT/?=
 =?iso-8859-1?Q?Ynr226T5ei/hOVWFfz5esRLvAy5A5FiQYVqFdDzQEP8+ImJhFFBXciLwtc?=
 =?iso-8859-1?Q?qGcBaJ73khoMBiYjThdMh2B80ANdiWyhc5dyDOUWAcB7+C9GuEUMyhPiVY?=
 =?iso-8859-1?Q?1V9GZ1Y6/6hnt9JUiWyibb4M35QuOv/VCqcudzEWZD4J+ydgIzrZp5miTf?=
 =?iso-8859-1?Q?eH1px3zIoJEBDS9Nibm5prBHOGt2js7DjgiZwppfoiwhHytJqyTjZhP0oX?=
 =?iso-8859-1?Q?ULvh6xIA0bNZyWLrQdsO8DjaTklRSGEE6DrAveWvfSyhnKyo9tWthkNIdl?=
 =?iso-8859-1?Q?386hl5dp7wmBIdi9jSrvMp7wWvyKZm6ZcPpn49FIwaTA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NTjgC3GnC7qqbhUAFGgqKYJBTeLoI66uvd3FJzE5FpbNFJmOAI44UF1ayb?=
 =?iso-8859-1?Q?AyhkjLyp97CPxNlzxae2Nx+K2sbM5kL2RxfLX4DUSdPGitwU4EpGTu4agC?=
 =?iso-8859-1?Q?Ac+sGGKrxkUjd9uSNjp2LvEHshiOGyYmi5gXnnEntYe1ucwgw9DXYejkNf?=
 =?iso-8859-1?Q?BxNvlZCZVUpay8qRs9I2JmnRaf+CebDfxGXqcnby9BaZADxmsac7QO1FRk?=
 =?iso-8859-1?Q?relqSc8YPPKFLKiivJNQAZUuLdqa3L/3BzI48UaUNAoakxgvwxBrzE+fyA?=
 =?iso-8859-1?Q?XWU+oibsSbtW8mHLKm8qxAX1GM5/R+ra0H+28TE65U+8uHhNKiNfQUelWq?=
 =?iso-8859-1?Q?bDNgYZD9s6qScn+hS7tbqbIbk0u5W69X6PJgc/Fjr1V40LGFQeVdkwRT2u?=
 =?iso-8859-1?Q?AlREOpGTVc5ubKhAUhUKnM+Opc/G/d6ZDXPMVBBcSyMTxCq646GpAphXR/?=
 =?iso-8859-1?Q?X/6YGjIhRJaU8F1BX+bRkBiVKjD6dnnjn7xwbtZjpbZavA/7D7J4qaM91G?=
 =?iso-8859-1?Q?HiqrYJspewumN5PFvnU2ICx+Sh3nEvDZ2wqaquqfY3/xqbzBGAVbPt1Ota?=
 =?iso-8859-1?Q?bdobcTpzZVXM23h1aWbDDLeI+ha3l3Qb+R34u60Qlpktk8bowHN8s2vagQ?=
 =?iso-8859-1?Q?JvCrYkPsrplovEBzwl11+qOSR2UBWa7pmYGVAjPCrKdvY4cu95uzjvBPgF?=
 =?iso-8859-1?Q?bniBY2YRLi/ZV563Ysj+G7CN04+qy3lG5RBUReHueIv4pgZ1/04UWIB+xW?=
 =?iso-8859-1?Q?kS0LhVsIzXwd9n9oDHeV1r3V4XgBVSjE3dM+2h15l4wiNgZ1PjbfKYCDz/?=
 =?iso-8859-1?Q?mRKGInbS0IxpOmaelltT3dg3J1ABN7ulBJ8PZdnv2LFs03AnBhcUM6qqfP?=
 =?iso-8859-1?Q?QNJkLdCCtJDqFSqBbh4FPUUd6pxISm71IqL/GW4Mq7NU2YGJDcRvX8f9Hp?=
 =?iso-8859-1?Q?yakQ9HV58rTgLMoyNyBWXL3DkqiwqyCbrVZw730FVlav8n85EefLwBEQ8G?=
 =?iso-8859-1?Q?jdE3T93XjTKiX9ACX0ps2T9mH11sJAX0/bNaXayXxhuz7yO3KjNCcudrBT?=
 =?iso-8859-1?Q?uhASJPcnHNWh5+Lbn1t6X9RRTqw/A3j8tOD+dRuUTgbOriXb+6tSo1X4mg?=
 =?iso-8859-1?Q?kRYIfTD5okCndgizttQ3INXY4WkdSTtuLw7Vg5pZ46KZcX8p1jZe1yucFJ?=
 =?iso-8859-1?Q?5YriEc+J8cpItZIrooPF8BeD9gVZo9FtezY4bXhjJoML0u2hXkogwqWhN/?=
 =?iso-8859-1?Q?tT9Mt2gqURoqMdltMW5nCBSM/Q8lUA/QDiXycjJ0rMne9FyIBbMwtz/D32?=
 =?iso-8859-1?Q?+gpQDRo+5WC7c3id2lkCX7aFvYwFsl1fZx1vqBoGutTA2CFDTV/M1qzSuy?=
 =?iso-8859-1?Q?dBAj1p/2PrF9iFXP2yhny63Zn3cunF2B6D5cqCtEcBISutYDylJ8Tp/qnb?=
 =?iso-8859-1?Q?Ped4b+31HhZGdkuK/OUfCDJh1+9dnRXKgzu9Daor6p9vkwpqMQrgDZKNjw?=
 =?iso-8859-1?Q?RjVenXkPaaTh1m9/9Jyq2co0UDi53xrwG5JMm8PiinkEGAJoQQAolhLw/G?=
 =?iso-8859-1?Q?0YT9jnvhNNYU3vR62Zwm2rpqx3Cs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f9d3dc-e833-45c1-27dd-08ddb4217bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 19:50:05.8409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyS8Oihavgk6uJXb3pVTGuVA6Isy82BcKe1UYkuAgXP4EupVkWANX4hPYjvwvx4Mhcl5qPRz+YPrVcEgOBCB/J/oHqKvLUaruI16g2gtDkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0783
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,BODY_8BITS,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
Sorry, the confusion is on my end. I misinterpreted how the `ldp` instructi=
on work. I thought that `ldp A, B, [C, #X]` loads `[C+#X]` into `B` and `[C=
+#X-0x04]` into `A` as it is used to pop stack and stack grows backwards. I=
t was just coincidence that it fixed the regressions.=0A=
=0A=
The real cause of the regression seems to be that `NtCurrentTeb()->Dealloca=
tionStack` gives invalid value but we don't have neither explanation nor fi=
x yet.=0A=
=0A=
Radek=0A=
=0A=
________________________________________=0A=
From:=A0Cygwin-patches <cygwin-patches-bounces~radekbarton=3Dmicrosoft.com@=
cygwin.com> on behalf of Jeremy Drake via Cygwin-patches <cygwin-patches@cy=
gwin.com>=0A=
Sent:=A0Wednesday, June 25, 2025 8:37 PM=0A=
To:=A0Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>=0A=
Cc:=A0cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>=0A=
Subject:=A0[EXTERNAL] Re: [PATCH] Aarch64: Fix register load order in `ldp`=
 in commit f4ba145=0A=
=A0=0A=
On Wed, 25 Jun 2025, Thirumalai Nagalingam wrote:=0A=
=0A=
> -=A0=A0=A0=A0=A0 ldp=A0=A0=A0=A0 x0, x10, [x19, #16]=A0 // x0 =3D stackad=
dr, x10 =3D stackbase \n\=0A=
> +=A0=A0=A0=A0=A0 ldp=A0=A0=A0=A0 x10, x0, [x19, #24]=A0 // x0 =3D stackad=
dr, x10 =3D stackbase \n\=0A=
=0A=
I am very confused about this.=0A=
=0A=
The struct layout:=0A=
struct pthread_wrapper_arg=0A=
{=0A=
=A0 LPTHREAD_START_ROUTINE func; // +0=0A=
=A0 PVOID arg;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // +8=
=0A=
=A0 PBYTE stackaddr;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // +16=0A=
=A0 PBYTE stackbase;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // +24=0A=
=A0 PBYTE stacklimit;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // +32=0A=
=A0 ULONG guardsize;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // +40=0A=
};=0A=
=0A=
below, you have=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ldp=A0=A0=A0=A0 x19, x0, [x19]=A0=A0=A0=A0=
=A0=A0 // x19 =3D func, x0 =3D arg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \n\=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blr=A0=A0=A0=A0 x19=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 // call thread function=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 \n"=0A=
=0A=
If this works (and it'd be really very obvious if it didn't), ldp loads=0A=
64-bits at the address given and puts it in the first register, and loads=
=0A=
64-bits at address+8 and puts it in the second register.=A0 So wouldn't thi=
s=0A=
really be=0A=
=0A=
+=A0=A0=A0=A0=A0 ldp=A0=A0=A0=A0 x10, x0, [x19, #24]=A0 // x10 =3D stackbas=
e, x0 =3D stacklimit \n\=0A=
=0A=
?=0A=
=0A=
so now you're freeing stacklimit instead of stackbase?=A0 I don't think=0A=
that's right.=

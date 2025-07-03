Return-Path: <SRS0=JPMj=ZQ=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::70b])
	by sourceware.org (Postfix) with ESMTPS id ADDE3385E825
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 19:16:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ADDE3385E825
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ADDE3385E825
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::70b
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751570183; cv=pass;
	b=X/dq0UNfR5+4wtluGiXH/3zrQo7Jr0xZpAXbxNAsPQpbKUxHeM6s80T6WDtMrdiIam0cuOAQJt3k1xx40M05d+3ln2nTAygGopst1M1QwwNkGWcXZ8g1nkPwD4lG5FZC8fk3OMDps3nywZtHGbgZa0sS6ur62uPiM8d6zsV7zHA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751570183; c=relaxed/simple;
	bh=VYIHhNBXr0Sc7SocXPV4CCCMqXoK5lSegzfL2CaTLU4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=PE809YhiR7z5raRRb3JXCRqVUTIALY5sPxEo9/HCQAi07hSbJkwlexcK5FZBvpz9bFqrBCDPFufVYplvA/+r/OEnQ5xRHoa8/qQWrj29RqENwT9Zth8/aa6ty6oUGm1mLj1wVpFeVrNAyEDJzmBvEX3qDDYRRctAahKuZ03vMns=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ADDE3385E825
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=J0IKuT0e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AN8dzltL7DMn++BLpjcs43KVCzFAmWeRxB5GxtlM0OOsR3hkVCAbT1BAFpkikx2/nFV+8xDoypSyGonujC88uuJQsBguGV0usFZkRQAn/t1wBhkeRLjyIlbdmY1FGF4FR3qzsqZ28hSNpgLjifOR4A/DW9J9BM7U9uW7o1iR9vjIGsKgHum29KI+odo0iOWxe/xD9Z9IWHrpkJFogDpUTeEk41V7i9H22q6lpwUjjTnmlUO1bOK3Gw9j0Jha7b23lKueHyujnCPUBTTOtmP74gC6oUaqlwst9mXyRD7b/PO5yzFeO98ubhdr1xKiZ+xy+1+iAD/ELhOdrVf0YsUM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juHN1hU2woVWq1zsZU6wIbD/+YHa8/s27IGHFYr3IV4=;
 b=bW3QSW7rKep19J7lJ6C5O4t55yalzW0FtlVOSkgA7rFqHY/uvfoomqNfBwL6M3+l5iEVBBfomFIcVCp5Q6cgwnTKz3DOReNGjvl62/OyQEb4wvSELhxgUxWtaBVTjGjjknm9Y0/DZmoy72blh8XCJD8GtwirsILbpw+HbBigJTywwipcs73ZUzHUp71JSKl0+REMWsTmA0OMAoUDdAjhTU9jh0kj1S0bvzUBeoLMBraQ6joFA3Z3RrOUY5iROSKWnhSzh3ktg/I/gs26Cv3VKCBzipWBVjhL5D11+SlIQwTMtTP3k9mLSos1bEDhyf9JvDZN4KgAW0/op+/uaSFiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juHN1hU2woVWq1zsZU6wIbD/+YHa8/s27IGHFYr3IV4=;
 b=J0IKuT0em9zoIMH6RVPakrpnCucP+IAGm3LejbqI+wGVBI1KqDrPfUqN/p8xVfgGGckO2GXVGanWo27/SU35+ugxMSDRIqzNMAvg5PC9/CqphsIGdEQAg1hx5DNvXSuu87JfmcXQgdhkO0dvddeu+fAxMMik1JDBNTzuVbroNLM=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU6PR83MB0826.EURPRD83.prod.outlook.com (2603:10a6:10:5c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.15; Thu, 3 Jul
 2025 19:16:18 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Thu, 3 Jul 2025
 19:16:18 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: mkimport: port to support AArch64
Thread-Topic: [PATCH] Cygwin: mkimport: port to support AArch64
Thread-Index: AQHb7E2MMWwx0yNv80evfpYUgCjHMQ==
Date: Thu, 3 Jul 2025 19:16:17 +0000
Message-ID:
 <DB9PR83MB0923C4491893524EF694F6829243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-03T19:16:16.688Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU6PR83MB0826:EE_
x-ms-office365-filtering-correlation-id: 6c3bbae7-bf9a-4b0f-020c-08ddba661645
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?wqyzwZGM51q5oQnhGNcIDSro5kGNAupdqILbiujVFV0JaGG/L/3fIqh44C?=
 =?iso-8859-2?Q?hJC3VYhi4ZiKU1K4SIOwKvMcEb8jj7QlX1tzBi0UcQBYfO/cclsukLC8XJ?=
 =?iso-8859-2?Q?Wqzs44mihsPlasP8iGDHjQrUNanSo2rnchjnhTTTMmhXyC0V+nkPAGheAC?=
 =?iso-8859-2?Q?QPXr1SzEHvLRmBAC4t+fOReq93pEvZ0alcUFPIj8dQU2DCTOOwnKykAUbr?=
 =?iso-8859-2?Q?FOKvPN2s7btkXqxZMuFlcNwbU2gvM65pLRvfV0Niz4vTRyNOuDvBUhdhUt?=
 =?iso-8859-2?Q?X0UcYdf5ri/L7clgYrZWYgvgGjliSumwDwE1ILmioKrpOeQLJjfiFaREby?=
 =?iso-8859-2?Q?4BtEMpZkcXbGStF0mJzfMxbcX5XwX6VoW7QbSXj+GC7EtcEuIY/LLHPKEj?=
 =?iso-8859-2?Q?TRA/ccPddBCfq4pM/xd2fOKwkV9Hga3l8pGERPwu0j2GhWaQ9xeT3cBWlk?=
 =?iso-8859-2?Q?OeCA5DmndBlfzI9a5bKO2iSx3xJGWdWyD2U1J3BoLPASRJtdhoHAlPvg2h?=
 =?iso-8859-2?Q?1HdOwdcBPY3xmnU8Xfa7WOY+gU1gcF0MT8H7pN6lv3B5HuDVJiIZ8+zI/Q?=
 =?iso-8859-2?Q?lVXvlv72EN/cZEElC6eJFM1xiLBe04amMsZYSWyhiyUrMsLZNCesqH9BEX?=
 =?iso-8859-2?Q?K+PXTR40URrec90E3CUgpfUId6TYzNIjUn5X5vJ37eTYLxozG+lVj9eidT?=
 =?iso-8859-2?Q?fgKtftVMPGC9nUMJm80fThkaw+UwGjqtWGCXALmfNVOOUDPw2o0MvcCHFa?=
 =?iso-8859-2?Q?hBHix+DtXAQ2j+ni2SHK+NTAOB61YHzAFnaqFpPyi0ZrAerZe3qJ3CLsNS?=
 =?iso-8859-2?Q?offmgQEmE5ieS44jLTwzg5s5oIGtK2lyJ+aj/qB5zGKQhUdDhMK5dqJh8q?=
 =?iso-8859-2?Q?PRxDGKuyJYo40dxc9uaA4QSAempugcRC1hupfEueGsh4MznDYqqXgQgA0n?=
 =?iso-8859-2?Q?JCymY02OlJdEJJNt4iHZx9LRHQp9TQ+/mOhYvDb/iWL3ei9ISB8oZ4hpQk?=
 =?iso-8859-2?Q?ZwpWvAr6eK5deQ2zC80m1KATbd1zWw3zMlSfOJQ7WjNsAgSpPWY7mLvR7u?=
 =?iso-8859-2?Q?IllWLwWbh0fpJOCmKmjFwqBs1/dEAI5goDV7mKKab7I6bQuArD6nrNnwJA?=
 =?iso-8859-2?Q?0g1u2hyr8BDO4GDOU6CPTM+0r7mXl8oQ+auzxqRoF0xswOzQh0beLXwptn?=
 =?iso-8859-2?Q?OXjxcb9xJJpqyuMOhLfAA+w0OqqpLn+OGKrdm0HHKGeoz8F0rG7+xbZpD1?=
 =?iso-8859-2?Q?xPTTd2sHxwL0Hv+Nc3nDVXzp/5A3BCGzO/7WjtVpu/oyeIdgzsr5hhTm4I?=
 =?iso-8859-2?Q?KnCs/w4hJbLEh7450W/cT4oxbOeqspoyHB8xasgw6YzejchqQIdfJvoxQ4?=
 =?iso-8859-2?Q?qNbVifZJQsPwyg61FYNb+t29uBUgKhGj0uJYWD9iZjgQ7KTUFV5sjlQI8y?=
 =?iso-8859-2?Q?3cg2gZe67Qice1RbO+9JWhjnJ1On4j/2N2ctyH0AGFYWPhWP1kablajegA?=
 =?iso-8859-2?Q?3LWzibxDMne29KBNvrYICyI4VIVtroQRLEfleJZvGCrx6f6ZxZE/cQS/mt?=
 =?iso-8859-2?Q?8F4LpZ8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?mW0OIWnhSFVXbBzuhpryHrYjzuMJ7KvxRAd57vtBFIoQOVNGpNElVMs+sf?=
 =?iso-8859-2?Q?NFmSM6bblRa7eOlCXm+8bZWiA9Gfn1pl0xFgKQqjMOMK0TYFTBLFa8eLUa?=
 =?iso-8859-2?Q?gGXrPsdU6CVahIrZwyzuFqIPR1HNZzMQXjghLlhOLaFsHJoCXunz8+Abwy?=
 =?iso-8859-2?Q?p5AhfXeXrlCPxyt/uMNL0e4klJrknREK1altR9MSVCfpVo9wGhzrH6ey3q?=
 =?iso-8859-2?Q?G2jToOYTGY5BMxjOGf78CH3JkzLQyvYgz39AWb3DEP4h0JYUCifagfzYgE?=
 =?iso-8859-2?Q?NiIZS8rs8WBlIGhJdQK0y+6CVrxIktlw5kz7oMhNZAf+U2vM1ic/yckC76?=
 =?iso-8859-2?Q?EA0fnFC/T9+imV/EndGUUi24LBWOMvSGL0sVLBeYaku1p6tWx7EkdmlE8x?=
 =?iso-8859-2?Q?QiDWFUIF2+1IFObn25oKbaDYTGEgpuIG7RaTdshjZO9xGLmcVtK/oSGboJ?=
 =?iso-8859-2?Q?IK7M3RYJF5ixFQCmlwrj3jdOwFu84A7GjQ995ZypoGGsfCp+XiheejEl4p?=
 =?iso-8859-2?Q?Uuqy0gAqVVlBBF1HN0oa0BzHvOA20oTZCoVV/jJBmUEXzrsajc/vUYVLGV?=
 =?iso-8859-2?Q?5mzQBBuaYWPNrDe5GsI7spAWI0GqetGuWQHfYvpaSPs2vFIeAo9yVJqfm3?=
 =?iso-8859-2?Q?33rW0mmYzjVIg7kr5QedemcV3QLV7t1zzofD4Ju3/jAZ7Gw8KDspDyzN/k?=
 =?iso-8859-2?Q?LdgsFupfCsZGfATsNf5HiFRpRkIKzV+ObivleCV9YSCGKjhSIpRKZjiZ5S?=
 =?iso-8859-2?Q?j6mmempleJ0vgHjV6qKeC7sSFq5+rwqKtNtkIG/zO7jXwXu6qEmEy+wWty?=
 =?iso-8859-2?Q?kY8xEsehN3t2pSCMLyUs2O6rWSi9VJK4O5MxxinEuzddNt8DEYGf4lfr6H?=
 =?iso-8859-2?Q?FlKROBbIpNscr7KFfVO2sgAlN9VW0i6dKc71R3qpWu5gOlCfDP0XFB8DRo?=
 =?iso-8859-2?Q?EoiQvWfkNg6jJJ9loUgoUNNACTFK9ZPMpIuF8VbDGFgiwtbklvAfEChoVf?=
 =?iso-8859-2?Q?6SYPZX/ZEfPuHpl6i75AZUffN3CaaimXbjlDahzggYkjYVpbBYMUPDk95N?=
 =?iso-8859-2?Q?bn+jBeUx6GB2gBh5NpxrEFCdHgqg1Sz23UkuAQrWpfMsWA65o9kL5e01Wh?=
 =?iso-8859-2?Q?p9l1kfoIVrVvA/smOEWyoVHjv8zyqfL3RVHvVMNEmOESNbSRf5aYkJEfSd?=
 =?iso-8859-2?Q?sWOSAQB6fF7WUbhexkVGGlHZ5sCZeSkxOahAbITre4K4fr9Q+VpjlKLSNB?=
 =?iso-8859-2?Q?/eCUYCWBUK76qgpD3W9Hs5v5a8ElCjQE5J/PPOqN2T6tCtuWovljuthvua?=
 =?iso-8859-2?Q?F3XQlC+tg2PSC8l1xKzlKJUrTgF2dZBp8iac0QpJ2jJor/HWMccZnBzZ7s?=
 =?iso-8859-2?Q?XQjM3bCwzABYXzn1t7iRfQ3QyH8f2n6lc6uB1HPzacI/cuEZBKZcP94ybw?=
 =?iso-8859-2?Q?hUC+IYRYOAtChE4WUN9C2b3ruVnm1+l8ibNb214N05K5/CZxRykaKVtO1E?=
 =?iso-8859-2?Q?AlR0j1UEYPuaR1ae1sKr2mk4huYx2faWue58UZbZI/e1H34VIpreBoYhU9?=
 =?iso-8859-2?Q?tOUzsLcWfUCLfuwnwUnzzr1LT5fz?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923C4491893524EF694F6829243ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3bbae7-bf9a-4b0f-020c-08ddba661645
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 19:16:17.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmMZrm88D9cf8x4S/S0dbK3GXsgWSncsWeJmaxRVgt2xygLcNwfcjGANsybnr4J/KcKsPteH3gtML30LVFwk4xpd3ddXEEi1Q4oPZcGh1ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR83MB0826
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923C4491893524EF694F6829243ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch ports `winsup/cygwin/scripts/mkimport` script to AArch64, namely=
 implements relocation to the `imp_sym`.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 155396dbbd715642dc0fa4f7922e5df4d963b8c3 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Mon, 9 Jun 2025 08:45:27 +0200=0A=
Subject: [PATCH] Cygwin: mkimport: port to support AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/scripts/mkimport | 11 +++++++++++=0A=
 1 file changed, 11 insertions(+)=0A=
=0A=
diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimpor=
t=0A=
index 9517c4e9e..0c1bcafbf 100755=0A=
--- a/winsup/cygwin/scripts/mkimport=0A=
+++ b/winsup/cygwin/scripts/mkimport=0A=
@@ -24,6 +24,7 @@ my %import =3D ();=0A=
 my %symfile =3D ();=0A=
 =0A=
 my $is_x86_64 =3D ($cpu eq 'x86_64' ? 1 : 0);=0A=
+my $is_aarch64 =3D ($cpu eq 'aarch64' ? 1 : 0);=0A=
 # FIXME? Do other (non-32 bit) arches on Windows still use symbol prefixes=
?=0A=
 my $sym_prefix =3D '';=0A=
 =0A=
@@ -65,6 +66,16 @@ for my $f (keys %text) {=0A=
 	.global	$glob_sym=0A=
 $glob_sym:=0A=
 	jmp	*$imp_sym(%rip)=0A=
+EOF=0A=
+	} elsif ($is_aarch64) {=0A=
+	    print $as_fd <<EOF;=0A=
+	.text=0A=
+	.extern	$imp_sym=0A=
+	.global	$glob_sym=0A=
+$glob_sym:=0A=
+	adr x16, $imp_sym=0A=
+	ldr x16, [x16]=0A=
+	br x16=0A=
 EOF=0A=
 	} else {=0A=
 	    print $as_fd <<EOF;=0A=
-- =0A=
2.49.0.vfs.0.4=

--_002_DB9PR83MB0923C4491893524EF694F6829243ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-mkimport-port-to-support-AArch64.patch"
Content-Description: 0001-Cygwin-mkimport-port-to-support-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-mkimport-port-to-support-AArch64.patch"; size=1227;
	creation-date="Thu, 03 Jul 2025 19:12:34 GMT";
	modification-date="Thu, 03 Jul 2025 19:12:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNTUzOTZkYmJkNzE1NjQyZGMwZmE0Zjc5MjJlNWRmNGQ5NjNiOGMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCA5IEp1biAyMDI1IDA4OjQ1OjI3ICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBta2ltcG9ydDogcG9ydCB0byBzdXBwb3J0IEFB
cmNoNjQKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0
PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClNpZ25lZC1vZmYtYnk6IFJh
ZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIHdpbnN1cC9jeWd3
aW4vc2NyaXB0cy9ta2ltcG9ydCB8IDExICsrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9ta2ltcG9y
dCBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9ta2ltcG9ydAppbmRleCA5NTE3YzRlOWUuLjBjMWJj
YWZiZiAxMDA3NTUKLS0tIGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CisrKyBiL3dp
bnN1cC9jeWd3aW4vc2NyaXB0cy9ta2ltcG9ydApAQCAtMjQsNiArMjQsNyBAQCBteSAlaW1wb3J0
ID0gKCk7CiBteSAlc3ltZmlsZSA9ICgpOwogCiBteSAkaXNfeDg2XzY0ID0gKCRjcHUgZXEgJ3g4
Nl82NCcgPyAxIDogMCk7CitteSAkaXNfYWFyY2g2NCA9ICgkY3B1IGVxICdhYXJjaDY0JyA/IDEg
OiAwKTsKICMgRklYTUU/IERvIG90aGVyIChub24tMzIgYml0KSBhcmNoZXMgb24gV2luZG93cyBz
dGlsbCB1c2Ugc3ltYm9sIHByZWZpeGVzPwogbXkgJHN5bV9wcmVmaXggPSAnJzsKIApAQCAtNjUs
NiArNjYsMTYgQEAgZm9yIG15ICRmIChrZXlzICV0ZXh0KSB7CiAJLmdsb2JhbAkkZ2xvYl9zeW0K
ICRnbG9iX3N5bToKIAlqbXAJKiRpbXBfc3ltKCVyaXApCitFT0YKKwl9IGVsc2lmICgkaXNfYWFy
Y2g2NCkgeworCSAgICBwcmludCAkYXNfZmQgPDxFT0Y7CisJLnRleHQKKwkuZXh0ZXJuCSRpbXBf
c3ltCisJLmdsb2JhbAkkZ2xvYl9zeW0KKyRnbG9iX3N5bToKKwlhZHIgeDE2LCAkaW1wX3N5bQor
CWxkciB4MTYsIFt4MTZdCisJYnIgeDE2CiBFT0YKIAl9IGVsc2UgewogCSAgICBwcmludCAkYXNf
ZmQgPDxFT0Y7Ci0tIAoyLjQ5LjAudmZzLjAuNAoK

--_002_DB9PR83MB0923C4491893524EF694F6829243ADB9PR83MB0923EURP_--

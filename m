Return-Path: <SRS0=JPMj=ZQ=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on20704.outbound.protection.outlook.com [IPv6:2a01:111:f403:2606::704])
	by sourceware.org (Postfix) with ESMTPS id 4FB31385E825
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 18:49:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4FB31385E825
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4FB31385E825
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2606::704
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751568565; cv=pass;
	b=gHJr+wZncoeTwYx5AJbKijGEBWLw6ml/x3MjQ6G4zwax5cFj4bmVh8EhGaCLg+/bcAgtBnEmg3fhS1fGFfZV8/kA6WCWahxoZ1KvR0ml3Yrmpn9Ar4U/sBenJJgUWmSC9cZavFYQVtjBUxel/HjqWVsav8qkQW0gpM4bJSHbQ/E=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751568565; c=relaxed/simple;
	bh=RqpGPMybOtE587CPt3Eq3QKehnMjxIXHYWT21eHbzvc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=gi6Pt/VeYLGtXbTV0V/re/kZx1yTYOQhzlqTrPF1b1DIWoNOYh2Uls8bGWg9tDovVetcgjn+obj6F4jJegQvJgwtPa8V725rVlunpwzLQ6oEbpR58NnIJukcNYyuCb0WXn5whBZGGrl7I7zO7S7sMV4ZF++mnJuW8ab+uwz0cyk=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4FB31385E825
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=VFVHkQa1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkMQib2ht+KqCeIbgKEBvfWgGuLR6i+PGezVIX6kdwm9nC/XCRaZmGFluGsWaJT2DkntZFQxz4nsPtSvQ9pZoGiMIT7w59HzyvOb3+1qrNwirlFlQNnCTTSJ8gTbaAhq3SBKJ+0In2jI0VLb2BfLourKXot+dS+kTqvUceMM3pFukwKpgfzyzqYJqTVTbgXDcUANRVJTwZ1cz08oeGlnvW0z4JgDcnDSBj5Nyl7BmQ2TZNqILvUGC7OoyeQmVB0vrH6/0Zx2Nh0nvmnmLssp9okhryrpvRPsluC/J4h8J7Cgc26DSlBrI9iQzIMa2RhzNva0cTO0DAszt4CAobHrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp+bwBd5M+2pUnRzQPULsAhackMvielq6h5dunyxBdA=;
 b=f1FsO2je7e6NFceyj9sfVEULYZrkQ9JLjDJM7wlwdg3o7QJNndPbM5X4Bu7sWRVpnbnb2tCelDVibGiu02J/5Nc7uxgimzUYVNEByHx/aceTVPVSQ737eHRBkSBVXjkHdTpDVK0l4HkrPtGftDHkIcyX/C9UkMCGeyRfIA71+6rzlbIf0EtWkbtTmEAyW3magRS+Bbeil3uduU0E8ka3bcBz4+VjGqMhTjdOPAEz0ZLZRBzfBVfxZegLfqMtNuaPtmruqWd//cImtBJgSFj08i7ZbsplNSYb6cUDloGJZ/89837soW7mMWFz5LIe8GfcjJsTPAn/0N1ufFWuIUSzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp+bwBd5M+2pUnRzQPULsAhackMvielq6h5dunyxBdA=;
 b=VFVHkQa1T0idl0YHeCb9lVx8kIejLN6A4fEA6BBw+R4Vm0UFPsO/Pg5YnIYiBQDQ/leu7BdpCzIxdn9XDiwtHc8VEBJDGwab+kWZ9tf66VSnYWfg8jp+5y2mTyWjlVwnGIpgfha9u4rz1AW2p5RbpgXRTO113ihPKaAPzv9zPkk=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by AS4PR83MB0522.EURPRD83.prod.outlook.com (2603:10a6:20b:4f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 18:49:21 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8901.009; Thu, 3 Jul 2025
 18:49:21 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Thread-Topic: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Thread-Index: AQHb7Esvy6gBlfOr1kOafzCSaf4suw==
Date: Thu, 3 Jul 2025 18:49:20 +0000
Message-ID:
 <DB9PR83MB09239C78F66E20045E2F4A269243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
 <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
 <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
 <81096ca9-9542-4818-b363-f3856915050f@dronecode.org.uk>
 <aFwaB47HM8UDH9CK@calimero.vinschen.de>
In-Reply-To: <aFwaB47HM8UDH9CK@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-03T13:35:14.658Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
undefined: 3414042
drawingcanvaselements: []
composetype: reply
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|AS4PR83MB0522:EE_
x-ms-office365-filtering-correlation-id: 7c44b0ca-c9d7-4e83-c9e4-08ddba62525e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qmZ0LCEtnHeGqmqGQI+7J57PL/hBJ/WxmFCLsxX1XX3IJ7au/ulWgIfYxk?=
 =?iso-8859-1?Q?pEFSIOSM/S+o0CQLa23HwQiG7NngNMlJddhX45XgRBcQbhYwILAWleaSxc?=
 =?iso-8859-1?Q?XNkMwyhyjAk4hRg9LTWYIPR6J3ufNAPhOuFvQsVemckz3GRgvTCEhyDEzM?=
 =?iso-8859-1?Q?GjE/OeMc/BR2PdATWZZQR8XnfJeU0AXWiRG2vSOejQyNP4/9udHMGkE+BS?=
 =?iso-8859-1?Q?z78jD/1dPCbH1vhFS4P76Q7hfBesxlPqUoIhJgZbVA4k6NMMAud/l8F/Rz?=
 =?iso-8859-1?Q?r/jgvLfpbC9U5dQ9ly2ze/aaeR17zauRMWg/o7qtBDm7h6gWl197O8BNT+?=
 =?iso-8859-1?Q?YgE7nHW8VoRGQ6WXz6xLhkytNJRwsowkDrNXu7puU511i4QL8vIKXcuJOc?=
 =?iso-8859-1?Q?S29DpZr0DAALJDlQwbTtsxupxkeIC5Fws/4CoXvKVI6N8sBDON2sXy9Lfo?=
 =?iso-8859-1?Q?ldRPKHeJ+uJWDdP99M4HZ2JkZ5EQWSCpNGqEhoblEc4uKYuu8FJm0bgn6j?=
 =?iso-8859-1?Q?O22VEbZKl5PdJkkWL89r1PhR+R6cY6FDpx9jd31z8qnKZ2QaDBUyHcucyD?=
 =?iso-8859-1?Q?VQGcRcz+SjpkNzJClVDofkTUoDqxMaGa7VrRIjpHvb3ECD7/2xbFudVrK8?=
 =?iso-8859-1?Q?CdoyFm+h/8XDHi/MCsyOH5ZA+o1DpvRIxJx1tILbMDcVDted8ENBjmIOs8?=
 =?iso-8859-1?Q?jywXB81WE3bdBE+6eq7s9qZofpxw/3mNiVTddw0bIvuW4GV2Fs8wNze17m?=
 =?iso-8859-1?Q?TdPEXALhok0E/bAAZEn0hFIrNoT+KN8mI6GCtP0HG7jj2h0KgxWeYDS7GO?=
 =?iso-8859-1?Q?tr990qgv9/E3TaL2WHRvA4vzwxYuT4f7LVQQJVYOecVFJQnzEB3im78k1V?=
 =?iso-8859-1?Q?RXRizF8GiDkgBwfSpeJ0Ge+cZNnpjVT4D5iJPEOWOxmQo8wp8adUqSIGAG?=
 =?iso-8859-1?Q?gsrc2KDQeMKUL/EOyct3WcxAkodeohRI6WpBYJ7vgG1mGUuqQLxgPdJ/Qi?=
 =?iso-8859-1?Q?vpDptgP0Y3/r6jb1LEsa1sVqtFuzbuNdvLAc3cmorUhdk7xVV1GM98LhmU?=
 =?iso-8859-1?Q?2D2vvoggqU+SHvCMU037t6gKD4YHOuN0KICmM3u5+ICs2ifg9oQY/YpMe5?=
 =?iso-8859-1?Q?Xup7R4lW7RTENeKgCyb8I5zkIvvDkUH3s/ABU4yo14Rg35SCtJtsqh5oa0?=
 =?iso-8859-1?Q?yXLCwTW3tfWydMkzjIR1B5b6xPLCx+fDgGxBEVkTwGygK9K0ScYa+Kt2Sq?=
 =?iso-8859-1?Q?FTQxMQdYuInDlcB6BZdR6AFPFYeesG0YPW577NMfRKtNA1Sj3/wYHw3MBm?=
 =?iso-8859-1?Q?46YY0nhGagLCVKZHLqNmxCkvgGMzLzGEHpAVrABJYxDyoewWXNc/qtdbCC?=
 =?iso-8859-1?Q?5xy/Daari884KUh3AhAmbJTcUyajZua9jbHYRH18BmUFHpgIoQxkr/iMNB?=
 =?iso-8859-1?Q?VCWiwV5CP4C6ykoHn1QxjW9A0ayijd84xJ5H5aAVZfMR3zlqfRxywYrcoq?=
 =?iso-8859-1?Q?Qe8Zh8EMKP+XjF0bNOydNfKtZX5Log2AoJYsmENyzLRC72wOAEY72gxrHh?=
 =?iso-8859-1?Q?P8XIiuE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?R/+9DVQPFAfdVGQdWia6pRYDO8rzcMsmXf2xSE9U3BWzcgoGD8dF8QkgrD?=
 =?iso-8859-1?Q?/5MhkFv9kbBFAv50ydTXfJE4MoO5EXwi+EOe9pgz4UL8SuqVoa/leGOD4g?=
 =?iso-8859-1?Q?oDvTZGf5kjSMBUph8IFdICXKYmUDDalgpOWt8pxQzkWvB+1cQT1Izq27se?=
 =?iso-8859-1?Q?DwKZlh5ELFBRu4gDDJYY5mvTF54WgCTEhScxxAVcKpwyqBdogqdfin9PO0?=
 =?iso-8859-1?Q?uXCqVV0vKZqZvk1qIPIJ+/TYCdpxb4egoE2OpobNnCnkA1r9oSl4oZ5NdC?=
 =?iso-8859-1?Q?awRJzm4lxJafDd3dhwyqlIg7GXaf+kTMDxQFTDNiJVCF1m/uA3lA+Q9ibd?=
 =?iso-8859-1?Q?HvRDdANvpXZHEfey3qqOP8mylhBBo5teG4oKaq6qSFkcn2YrNDFhcncY/G?=
 =?iso-8859-1?Q?CYXkP+WpQj8sLgRXXRU9J06OIe2CSZg2B7lG0mEZlqPav+Xw53+P73PzGr?=
 =?iso-8859-1?Q?mjBCVf2IECK0vj9SR7arUIr0F3hABK/OK6iMJMSaJV15iihOPxVIhDseCd?=
 =?iso-8859-1?Q?gr1Kc6WmIp22w0NjJVpn5CwkJoPi3j+LV6TxCS/JUzMCOkBpoq21fraoJj?=
 =?iso-8859-1?Q?xItQl0s0P1h9ncYfhAncaO8Vug1ylIHkPCwSD066tKzQqsYqOZZMzpVo0J?=
 =?iso-8859-1?Q?7a2RsPNUPoYl5SQPAnygOBAKrW5i5CJsbUaYD+kMkXxtJsY/yDyFVt9Kiq?=
 =?iso-8859-1?Q?8SOuqdsKZUEpnWcJNXnjGAEjw54bxKcplfXPI8Sn0Cevvqm+LTq5/8BRsr?=
 =?iso-8859-1?Q?3PSE98fh4UOtl3P0NnFaOA1/zzS+dveGWPgWk7TJiOROOKHqcbGT5euQ80?=
 =?iso-8859-1?Q?7sKNb5wOeHK4FQtyf9tcWrpDXyitm+IeoJ0Q+xWb79dnjVtRoMNaOeCrfY?=
 =?iso-8859-1?Q?tLUHG4sHkRefItfX5iHzAdAV6LNwVmHU4H8ITRkqJz7BSqPUj7ervdViA6?=
 =?iso-8859-1?Q?nzZG5FHqcrExBz0zMeMBUCX5pxQJX0ua4OMFrSLZVZzbfIH7VW1TFrbnZO?=
 =?iso-8859-1?Q?6WVkEhj1j40VubGdFGersR7aA/L9J4WnOrCGlr1fH9USZWXkDil6slzfaR?=
 =?iso-8859-1?Q?ojIZfmQVeX+8PSOHAQxv0lyaevK75l/Sf5jniuAiooMuhSndErEw9HxvGd?=
 =?iso-8859-1?Q?9s9WOs6CuudqWPhGZYbReCzEFsDGYx6eNGL6WEL+3rlwfiXU7lrAkrU4/k?=
 =?iso-8859-1?Q?/P/czVNwNZSLpF9WX4hUPfvAlx2pd+J57msdayghDOB2Cml85g+AIDRwLV?=
 =?iso-8859-1?Q?a6lo7EM6mW1uJYz6gzpMbxf6x8EduZHiTEjKEvpDdrefni6N3FiHaWdxRV?=
 =?iso-8859-1?Q?PtHVe3m7+0zF8onXZfO08EOglh0MoDSNFMrzcVETKbrl9JqmepHpxSFi6e?=
 =?iso-8859-1?Q?yCDjBwka4rkl0mNB/+U7JK5lhx3vIUjN3IU9byhImQfigQV3NRk2upOE3y?=
 =?iso-8859-1?Q?NBouVLvNJgU4rVKmTN3Kdd58+q8ZcRLyxKMfKMTCi45aXD4tqP+nFTnGuu?=
 =?iso-8859-1?Q?us8h2f7PcV12B6Bo+JvbTMzZ3GGQG5NBnY14jAkcX3NKlgiQHa+jpq4kr3?=
 =?iso-8859-1?Q?tzi1n0TVVr0+YhTdLudj9u7fdUR2?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09239C78F66E20045E2F4A269243ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c44b0ca-c9d7-4e83-c9e4-08ddba62525e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 18:49:20.7808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eS2tze2rJBWyor0qzi4qO7T1qmo2L48ab9xyBbP9T6dwqgNxQvtJJXQW1ZhWxh6HarplweWYpeibk/5HU5dBWP2Y5XPXQHmUv1tf+PjpDmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR83MB0522
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09239C78F66E20045E2F4A269243ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
The following:=0A=
=0A=
diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in=0A=
index 5007a3694..e71e0189c 100644=0A=
--- a/winsup/cygwin/cygwin.sc.in=0A=
+++ b/winsup/cygwin/cygwin.sc.in=0A=
@@ -1,6 +1,8 @@=0A=
+SEARCH_DIR("=3D/lib/w32api");=0A=
 #ifdef __x86_64__=0A=
 OUTPUT_FORMAT(pei-x86-64)=0A=
-SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=3D/usr/lib/w3=
2api");=0A=
+#elif __aarch64__=0A=
+OUTPUT_FORMAT(pei-aarch64-little)=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif =0A=
=0A=
breaks Fedora build (https://github.com/Windows-on-ARM-Experiments/newlib-c=
ygwin/actions/runs/16051682177).=0A=
=0A=
Also this:=0A=
=0A=
diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in=0A=
index 5007a3694..dda28692e 100644=0A=
--- a/winsup/cygwin/cygwin.sc.in=0A=
+++ b/winsup/cygwin/cygwin.sc.in=0A=
@@ -1,9 +1,13 @@=0A=
 #ifdef __x86_64__=0A=
 OUTPUT_FORMAT(pei-x86-64)=0A=
-SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=3D/usr/lib/w3=
2api");=0A=
+SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api");=0A=
+#elif __aarch64__=0A=
+OUTPUT_FORMAT(pei-aarch64-little)=0A=
+SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api");=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
+SEARCH_DIR("=3D/lib/w32api");=0A=
 #define __CONCAT1(a,b)	a##b=0A=
 #define __CONCAT(a,b) __CONCAT1(a,b)=0A=
 #define _SYM(x)	__CONCAT(__USER_LABEL_PREFIX__, x)     =0A=
=0A=
breaks the Fedora build (https://github.com/Windows-on-ARM-Experiments/newl=
ib-cygwin/actions/runs/16051815462).=0A=
=0A=
While this:=0A=
=0A=
diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in=0A=
index 5007a3694..2a734a5b1 100644=0A=
--- a/winsup/cygwin/cygwin.sc.in=0A=
+++ b/winsup/cygwin/cygwin.sc.in=0A=
@@ -1,9 +1,11 @@=0A=
 #ifdef __x86_64__=0A=
 OUTPUT_FORMAT(pei-x86-64)=0A=
-SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=3D/usr/lib/w3=
2api");=0A=
+#elif __aarch64__=0A=
+OUTPUT_FORMAT(pei-aarch64-little)=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
+SEARCH_DIR("=3D/usr/lib/w32api");=0A=
 #define __CONCAT1(a,b)	a##b=0A=
 #define __CONCAT(a,b) __CONCAT1(a,b)=0A=
 #define _SYM(x)	__CONCAT(__USER_LABEL_PREFIX__, x)=0A=
=0A=
seems to work (https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/=
actions/runs/16057401863).=

--_002_DB9PR83MB09239C78F66E20045E2F4A269243ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v3-0001-Cygwin-define-OUTPUT_FORMAT-and-SEARCH_DIR-for-AArch64.patch"
Content-Description:
 v3-0001-Cygwin-define-OUTPUT_FORMAT-and-SEARCH_DIR-for-AArch64.patch
Content-Disposition: attachment;
	filename="v3-0001-Cygwin-define-OUTPUT_FORMAT-and-SEARCH_DIR-for-AArch64.patch";
	size=1082; creation-date="Thu, 03 Jul 2025 18:49:09 GMT";
	modification-date="Thu, 03 Jul 2025 18:49:09 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2YTY2N2FlN2M2ZDBlMzc3NDc3Zjc0MTIxMzAwNmI0OTJiM2VlZDEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogRnJpLCA2IEp1biAyMDI1IDE0OjEzOjE2ICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2M10gQ3lnd2luOiBkZWZpbmUgT1VUUFVUX0ZPUk1BVCBhbmQg
U0VBUkNIX0RJUiBmb3IgQUFyY2g2NApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRl
eHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoK
U2lnbmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+
Ci0tLQogd2luc3VwL2N5Z3dpbi9jeWd3aW4uc2MuaW4gfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL2N5Z3dpbi5zYy5pbiBiL3dpbnN1cC9jeWd3aW4vY3lnd2luLnNjLmluCmluZGV4IDUwMDdh
MzY5NC4uMmE3MzRhNWIxIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2N5Z3dpbi5zYy5pbgor
KysgYi93aW5zdXAvY3lnd2luL2N5Z3dpbi5zYy5pbgpAQCAtMSw5ICsxLDExIEBACiAjaWZkZWYg
X194ODZfNjRfXwogT1VUUFVUX0ZPUk1BVChwZWkteDg2LTY0KQotU0VBUkNIX0RJUigiL3Vzci94
ODZfNjQtcGMtY3lnd2luL2xpYi93MzJhcGkiKTsgU0VBUkNIX0RJUigiPS91c3IvbGliL3czMmFw
aSIpOworI2VsaWYgX19hYXJjaDY0X18KK09VVFBVVF9GT1JNQVQocGVpLWFhcmNoNjQtbGl0dGxl
KQogI2Vsc2UKICNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCitT
RUFSQ0hfRElSKCI9L3Vzci9saWIvdzMyYXBpIik7CiAjZGVmaW5lIF9fQ09OQ0FUMShhLGIpCWEj
I2IKICNkZWZpbmUgX19DT05DQVQoYSxiKSBfX0NPTkNBVDEoYSxiKQogI2RlZmluZSBfU1lNKHgp
CV9fQ09OQ0FUKF9fVVNFUl9MQUJFTF9QUkVGSVhfXywgeCkKLS0gCjIuNDkuMC52ZnMuMC40Cgo=

--_002_DB9PR83MB09239C78F66E20045E2F4A269243ADB9PR83MB0923EURP_--

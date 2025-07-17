Return-Path: <SRS0=ysPO=Z6=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071e.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::71e])
	by sourceware.org (Postfix) with ESMTPS id 25B6E385B805
	for <cygwin-patches@cygwin.com>; Thu, 17 Jul 2025 08:55:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 25B6E385B805
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 25B6E385B805
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::71e
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1752742553; cv=pass;
	b=IadCrNu0wpaApvASipEV2YARvtyHR/TrZa3VQGg7642Ew24hCFC104HlfomC+XO1J+OkeXUVBjVr/zJydlAcCz1GvzTjaVl1kh6nr2CESRT362NLnshOZf59wRDGoNdINtrQcCZ8sjcs5mHArWMLZKXxZKL6I2Y2ieFqmR8df1s=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752742553; c=relaxed/simple;
	bh=CO2UytagJXtMbOJuI6cCuQK+lTTD1qOzBz3UCdGsmtQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=gcSkeZeRCKeJLQGisPDHXRuEGoRH7+/hOigc6fm7vW08I/Fn0v56rKffnUtFPzylSZIpBsjf8+rD6Xw7W2/FYmHgX9YLfsbPsTZqSLCGyGl4PJmksu5D23d0ZSoWTcSw1njjsyt9+CKK1YEX5RAVz44N5k3kWF9I5g80hke2oF0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 25B6E385B805
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=MZisGYw1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j37eGnSpvSWTF4EWEqgh+LDGuXvkGBHpM1rfU++xeajM0cKXqOod3TeSbsWztGs1aPTvkP496L4lljrECCfh3QXzJZTfzkYiuXBm8wbCvsadEK7I4aqjzZPqmTKKMcE53K1pb+u82tf3qI+WXUoKnjNhnzHKOaA39ym+V6tvlearrJyvhjth+ML9XbStfA/ILIctsNUViIIaGK2036dJKqytc3iUSMmEGfKVRwwaYo44SZYQjqMZUkV5UwxTAAJ63JAlgR7m3e4gpG+FhdVOdWz9UvNE+yMDaF49I7CeWw9W7tXW2fOBktwst2XG2tAtJpDlGlnn6isJlyzKjcKBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sn3U577+zvzvEQt89US6DhFqVvOLMpp+U4y8hy+BiI=;
 b=NHx4YsZfDubrtUfKZINox9qTFSm17MAfG5c6D0juetJ5MTQq6YdFMoSszj9MLNIVvxh3fLdfURzkDXyxhvSZznlB/xNFtqvnumhfeGrdv1EOojdEWkZQ1oReenccaPTV8oKN/v2Czf3kRD44q0dEuPxssfUO9gDdjtJUD3Y2VbrxW/hlWC3ow24rla0pOPTOUqfQF6rozi28dotzULr5kbFD3gDqCBnhrQjCU1fdgK02rAlA4r4cOM7L/JWNn9Z1m42J9geiqdakSvOycS9cdXPuZIHBol0t0Nel3lhep9XD+gJkDCvp6gwzJkpRiB9ENSypjjHcoCiEowyuDBw36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sn3U577+zvzvEQt89US6DhFqVvOLMpp+U4y8hy+BiI=;
 b=MZisGYw1W5rkrzwd0oe0YsZyiPvVZoJqvc/Z7t71Kv/ZdxmPJ4hlmebxwmInNJUYhxyrGq6LYPIt+N0wbuJa2XCBLMACuBu4V3HO9dID0V6Pq6Mx4WtTaHJJ4kForCL/wvbl0nAhNbtkqu9VenGsS0sbenSP10gdo6Elc00MWmI=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0795.EURPRD83.prod.outlook.com (2603:10a6:10:58e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.16; Thu, 17 Jul
 2025 08:55:49 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8964.010; Thu, 17 Jul 2025
 08:55:49 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3] Cygwin: cygcheck: port to AArch64
Thread-Topic: [PATCH v3] Cygwin: cygcheck: port to AArch64
Thread-Index: AQHb9viXln1GSQ4oNUq8Sys/lyCLCA==
Date: Thu, 17 Jul 2025 08:55:49 +0000
Message-ID:
 <DB9PR83MB09230DE13A8F922630FC2CF69251A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB09236B2289D6307E787D64FC9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB09232BEB586BCF0576FD69CD9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHTs_sKuNZ1OkBvc@calimero.vinschen.de>
In-Reply-To: <aHTs_sKuNZ1OkBvc@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-17T08:55:48.659Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0795:EE_
x-ms-office365-filtering-correlation-id: f425814c-55e4-486d-aa91-08ddc50fba3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?Nn9T6dT6z3Fas0lk2Le6AOcIZDwH33Pd+HIaFIwnQCZ758BoIfAd7JF2v2?=
 =?iso-8859-2?Q?yXjec+RyjDfl8gOGzosImtWY46WSpuBZSsKN6uFE+BMNEViF0FwwA2pd76?=
 =?iso-8859-2?Q?/TA5nzxjkEdKK9VvYdQVxv1g+fRqaln0Hc70L2l1KPcu4mMiYJhtjU8m8y?=
 =?iso-8859-2?Q?sDoB7nrshwdDqIfbLZwD8+ELhJk3YMNp0ub5owP2inlM9BLDtwhZSJvCpi?=
 =?iso-8859-2?Q?B6xDp0xhTSc0TpzjV+axRj/fPG0uAyED62IlqitJb5vVWWlVYXUnFFEVcM?=
 =?iso-8859-2?Q?JQnQvItUmg6SbdG+BTw1j1l2k4TKFZWtdo8xitRuYkl1GAqax4Dfs0Nz3u?=
 =?iso-8859-2?Q?RH7YKz71LOVhwyfN5eTeqgqPBDHxE/2yZn4SUNNLltd3DUIrfGIBZyzs42?=
 =?iso-8859-2?Q?6XBWFY/N4OXdnGKLCQF8nfK6ANK+UeZ4BBrng0iMPD2qmKrN4w//XZpCDq?=
 =?iso-8859-2?Q?Gxxa144W1qnNwlBg4nh9iLP2YFijQpfzfi9x7BCr7Yj0APM6LO6dI8EjHM?=
 =?iso-8859-2?Q?hTCSvh0DwRpzZt5umRsjcZXMfpq4Od15uPhf2YheCbB9iByYOgq3nCRUqF?=
 =?iso-8859-2?Q?vxSKzTUfO9dVtotzB3aEWE9g/7fC6VuJ+U5poGbLgExUWXYKkOSuggJDoQ?=
 =?iso-8859-2?Q?i3qgkykHPcrvQIK80c7bdGuXJx3i5jyL9PcIyn099y84+BdU8bbxDEqVPe?=
 =?iso-8859-2?Q?yPHvXKuWBz5V0cUHU+TkXEQPGYCOH5E0hA1A1nFvMUWxYKn7Ug8CRewpdD?=
 =?iso-8859-2?Q?6xEMb9TDUEd/cpeiMm5P35FEKjvn8exfq+cdd1ovEGxvB2AP66w+ZGVYUb?=
 =?iso-8859-2?Q?SoooA1dJXQCIQBB2otSMY1ATuUpqRoKbjjyeeZB+at7R+fkYqQK6xoQM9X?=
 =?iso-8859-2?Q?MrWh71hkMwbmOlrEs9PmeBen2r6yf1NVO3cx8VAsN02dl0hiPcTIQez0LR?=
 =?iso-8859-2?Q?mn8ZlV81Kq9Xk7TBVE6KZ54+cpVlJ7nOwkTvRZCJLPhuAYLF55Y0WPvZdG?=
 =?iso-8859-2?Q?407Ii9a3THT7D5A03/mHxqrvE5Xfm72Hz4IlqIExm98XSKuG4GaQBVaIWu?=
 =?iso-8859-2?Q?IjbRLidXGsyztIH1RphuriwxUi+hp0V04DJTt947NuOZdJQDGomhBaVV0W?=
 =?iso-8859-2?Q?xnOPX33tNeBUfkH+ERwTq0J1NwclJkWth/5TQOxd+GV7wrbnzIQWIXWcZA?=
 =?iso-8859-2?Q?ieNB5zjkdmFUnSh33BYxQf0Vc/OSIcXuhVQLIQa/AteidWDZME8z7SywEQ?=
 =?iso-8859-2?Q?KYUJatX1uMKCoUzXWk1442VsFaDplHodLXOeHgfp9QKfkZWlllKE62FtCF?=
 =?iso-8859-2?Q?PXixmIDNahFCB8ENhKgOZzgMXXMN7nikEH46BV10OJb75GH/lsBg4Q0usI?=
 =?iso-8859-2?Q?BYDOWYxr1u3X59Q1s1i2/OyPATfEW5nli65e1qEKgWmHqXp9kYX5b6hNkV?=
 =?iso-8859-2?Q?DBciROAj1wCJ3fWqa9wQLs+xuaWLERm18ZmjLYSwwchXQFdnDnwQkKO39b?=
 =?iso-8859-2?Q?b4VWjvPv3EslnBZ6fEtcdc+kKBH03twWJ1lxkA1RUjG3Dlugm9d1hwUSMN?=
 =?iso-8859-2?Q?LSEUZZ4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?uNP29sO27qO9jJbGBW5LIIY+MeHWWkF/UeYZG3xu3/Aeo9vSupOAPrP/xp?=
 =?iso-8859-2?Q?b7XAgsbYpadGxuHkoLWCgXy4vEghC2W4umfo6VIg2Cin9hehOocYxaPGZq?=
 =?iso-8859-2?Q?dJ/KOa24kj/PDn2b1xhy6RrMCCyhuazEty9dnt+vBkdowkR0mGO8kiUAWf?=
 =?iso-8859-2?Q?7/QGno2lAFyIOs88nFOMdVpFBLciQ2RXlEECF3u07rTBYv0uzuqZrEgpnC?=
 =?iso-8859-2?Q?lCDIRvhfPDHkWlKAm3xcacejS8OW3pkl4dx9Ht6iomHyy9yTzdP2qhUUHE?=
 =?iso-8859-2?Q?O1MjGRztdBo7SYCfbmZcAF2PZhZc0OISuqrsi0mpcaaLbF3DsfRcwYRIEl?=
 =?iso-8859-2?Q?OeAAW6BVmQccAfsunLXN/7xWPtBPJyRmH6khu5TUKt5nKxqAN8oxlJnj3a?=
 =?iso-8859-2?Q?l6fTqUFJEDc92NmdVXMCu/F6XvOs08FqS6On+HqupssbJCBWQTcFOAPz/S?=
 =?iso-8859-2?Q?Mhe5u5/1HYx+dCCTHgVugL4mEksee710kBWuZ76rAciHTml+LZZSL8gYSA?=
 =?iso-8859-2?Q?vwE3L9/vw2ZcqIvxA4rMGi/JHhL38wo10vtfG97wKZEwOCUjl9d7gMLrwr?=
 =?iso-8859-2?Q?6mjnSssIYk/x7WecrVvaG673UkiwCeQytx+CXBq9cC1YdPITEgSZ8jKKPS?=
 =?iso-8859-2?Q?91IoU3r0BFsqf3ZNlZTm/o+TG0r3BSFhFLHmTljRK4EJ6RkFlOnj1bL4+i?=
 =?iso-8859-2?Q?XUGm6elRaZCViGmsj204CJQ0e63oYbaYIEfBjP4FhBTWFsTKrAZ5KnVY3U?=
 =?iso-8859-2?Q?j0pZKCYNF83jd5ZdsWa5vrKYag+qEwo70FzDwToITMY0ARM5inkmP904Sy?=
 =?iso-8859-2?Q?DJm4FjgKnChkmwPPQX1m8v7U10qLMCPStQlHl36x2l2toxSLT6kDgMEZ3Y?=
 =?iso-8859-2?Q?vh+iJXfhaOsL6vXJh+qYAUQrW03l+vSZy6OKF/V3wdztoECU9RWmo8Dj8G?=
 =?iso-8859-2?Q?mXwVrKUZqgU9x3GiJdAnjmv6r7YALLVxGwR7U3t15FO2OsbI+fi02sotRv?=
 =?iso-8859-2?Q?u0LJGB819Bbi5t82d79jEOaLUQ90usPMrcnkDYER46fv7g4817oTx6sx7a?=
 =?iso-8859-2?Q?kGhHx6MGETQwr6M/6yNoWvkH4r9CLqzxBaZ0PeR1aNPD8Ymv/IVNpGGQHZ?=
 =?iso-8859-2?Q?115rWMkwje2tMvQfCEvqMENMhFbwEls02CBWnWraNuzO1m3Olk2sbUygUb?=
 =?iso-8859-2?Q?kRuoo5tsYT4c1ZfIDIetKmfGvR6T+o1oMvO0sWUicLhXwMfgfIfRKIG4In?=
 =?iso-8859-2?Q?ovXuvDDoZre+0PuZdSe0Ur7PgZ/5K9Q8Skx6mGySTe9BuaMWdwfSKtriGW?=
 =?iso-8859-2?Q?eU5HnuJkFn3loPnQ1zwGle+5Hetyhr8tFWPjE0QObxETqFsLu0R2Cwn6nh?=
 =?iso-8859-2?Q?GtMAMz7Wc6wGcmMnXkLseVV7GTG2xdfAezwb92fsgNjpTut8oVhVyPylvj?=
 =?iso-8859-2?Q?ECvY9yfxxcq9hfcDos54d6+ED0lEQISEOhFyXo+gLC/6G/aaZkGT854ScT?=
 =?iso-8859-2?Q?ZdgF2NlKXFJwzweSqwzrFeyHKX34vdvbMcHGNXACG93+1vEI7sJQ2EkE8a?=
 =?iso-8859-2?Q?5yqBRHFi+U+brm86Fd1N3whRX4Ek?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09230DE13A8F922630FC2CF69251ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f425814c-55e4-486d-aa91-08ddc50fba3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 08:55:49.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGuY/2mWXzg2/Ir4LLDHUrrcH3/DmWVGUDASCNzsycHGsFxIIAj55xAOaUoI6VRysD5NwlU2H6VbJqs+MlVr18B1ZtdhIIXl526nTCwnVfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0795
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09230DE13A8F922630FC2CF69251ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Hmm. It's quite a while since I've been writing this and honestly I no long=
er remember why I though the offset should be different for AArch64. Now, l=
ooking into the documentation and the surrounding source code, I'd say 108 =
is a correct value. Furthermore, I've tried `cygcheck -s -v` with both and =
112 was crashing while 108 seemed to work.=0A=
=0A=
Thank you for noticing this.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From a27cdd462d1067e8bffe7dade7c3d2088ed7866f Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Mon, 9 Jun 2025 13:08:35 +0200=0A=
Subject: [PATCH v3] Cygwin: cygcheck: port to AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch ports `winsup/utils/mingw/cygcheck.cc` to AArch64:=0A=
 - Adds arch=3Daarch64 to packages API URL.=0A=
 - Ports dll_info function.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/utils/mingw/cygcheck.cc | 14 +++++++++++---=0A=
 1 file changed, 11 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.c=
c=0A=
index 89a08e560..d17909bfc 100644=0A=
--- a/winsup/utils/mingw/cygcheck.cc=0A=
+++ b/winsup/utils/mingw/cygcheck.cc=0A=
@@ -654,16 +654,22 @@ dll_info (const char *path, HANDLE fh, int lvl, int r=
ecurse)=0A=
   WORD arch =3D get_word (fh, pe_header_offset + 4);=0A=
   if (GetLastError () !=3D NO_ERROR)=0A=
     display_error ("get_word");=0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
   if (arch !=3D IMAGE_FILE_MACHINE_AMD64)=0A=
     {=0A=
       puts (verbose ? " (not x86_64 dll)" : "\n");=0A=
       return;=0A=
     }=0A=
-  int base_off =3D 108;=0A=
+#elif defined (__aarch64__)=0A=
+  if (arch !=3D IMAGE_FILE_MACHINE_ARM64)=0A=
+    {=0A=
+      puts (verbose ? " (not aarch64 dll)" : "\n");=0A=
+      return;=0A=
+    }=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
+  int base_off =3D 108;=0A=
   int opthdr_ofs =3D pe_header_offset + 4 + 20;=0A=
   unsigned short v[6];=0A=
 =0A=
@@ -2108,8 +2114,10 @@ static const char safe_chars[] =3D "$-_.!*'(),";=0A=
 static const char grep_base_url[] =3D=0A=
 	"http://cygwin.com/cgi-bin2/package-grep.cgi?text=3D1&grep=3D";=0A=
 =0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
 #define ARCH_STR  "&arch=3Dx86_64"=0A=
+#elif defined(__aarch64__)=0A=
+#define ARCH_STR  "&arch=3Daarch64"=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB09230DE13A8F922630FC2CF69251ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v3-0001-Cygwin-cygcheck-port-to-AArch64.patch"
Content-Description: v3-0001-Cygwin-cygcheck-port-to-AArch64.patch
Content-Disposition: attachment;
	filename="v3-0001-Cygwin-cygcheck-port-to-AArch64.patch"; size=1882;
	creation-date="Thu, 17 Jul 2025 08:54:59 GMT";
	modification-date="Thu, 17 Jul 2025 08:54:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMjdjZGQ0NjJkMTA2N2U4YmZmZTdkYWRlN2MzZDIwODhlZDc4NjZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogTW9uLCA5IEp1biAyMDI1IDEzOjA4OjM1ICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2M10gQ3lnd2luOiBjeWdjaGVjazogcG9ydCB0byBBQXJjaDY0
Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYt
OApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpUaGlzIHBhdGNoIHBvcnRzIGB3aW5z
dXAvdXRpbHMvbWluZ3cvY3lnY2hlY2suY2NgIHRvIEFBcmNoNjQ6CiAtIEFkZHMgYXJjaD1hYXJj
aDY0IHRvIHBhY2thZ2VzIEFQSSBVUkwuCiAtIFBvcnRzIGRsbF9pbmZvIGZ1bmN0aW9uLgoKU2ln
bmVkLW9mZi1ieTogUmFkZWsgQmFydG/FiCA8cmFkZWsuYmFydG9uQG1pY3Jvc29mdC5jb20+Ci0t
LQogd2luc3VwL3V0aWxzL21pbmd3L2N5Z2NoZWNrLmNjIHwgMTQgKysrKysrKysrKystLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3dpbnN1cC91dGlscy9taW5ndy9jeWdjaGVjay5jYyBiL3dpbnN1cC91dGlscy9taW5ndy9j
eWdjaGVjay5jYwppbmRleCA4OWEwOGU1NjAuLmQxNzkwOWJmYyAxMDA2NDQKLS0tIGEvd2luc3Vw
L3V0aWxzL21pbmd3L2N5Z2NoZWNrLmNjCisrKyBiL3dpbnN1cC91dGlscy9taW5ndy9jeWdjaGVj
ay5jYwpAQCAtNjU0LDE2ICs2NTQsMjIgQEAgZGxsX2luZm8gKGNvbnN0IGNoYXIgKnBhdGgsIEhB
TkRMRSBmaCwgaW50IGx2bCwgaW50IHJlY3Vyc2UpCiAgIFdPUkQgYXJjaCA9IGdldF93b3JkIChm
aCwgcGVfaGVhZGVyX29mZnNldCArIDQpOwogICBpZiAoR2V0TGFzdEVycm9yICgpICE9IE5PX0VS
Uk9SKQogICAgIGRpc3BsYXlfZXJyb3IgKCJnZXRfd29yZCIpOwotI2lmZGVmIF9feDg2XzY0X18K
KyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCiAgIGlmIChhcmNoICE9IElNQUdFX0ZJTEVfTUFDSElO
RV9BTUQ2NCkKICAgICB7CiAgICAgICBwdXRzICh2ZXJib3NlID8gIiAobm90IHg4Nl82NCBkbGwp
IiA6ICJcbiIpOwogICAgICAgcmV0dXJuOwogICAgIH0KLSAgaW50IGJhc2Vfb2ZmID0gMTA4Owor
I2VsaWYgZGVmaW5lZCAoX19hYXJjaDY0X18pCisgIGlmIChhcmNoICE9IElNQUdFX0ZJTEVfTUFD
SElORV9BUk02NCkKKyAgICB7CisgICAgICBwdXRzICh2ZXJib3NlID8gIiAobm90IGFhcmNoNjQg
ZGxsKSIgOiAiXG4iKTsKKyAgICAgIHJldHVybjsKKyAgICB9CiAjZWxzZQogI2Vycm9yIHVuaW1w
bGVtZW50ZWQgZm9yIHRoaXMgdGFyZ2V0CiAjZW5kaWYKKyAgaW50IGJhc2Vfb2ZmID0gMTA4Owog
ICBpbnQgb3B0aGRyX29mcyA9IHBlX2hlYWRlcl9vZmZzZXQgKyA0ICsgMjA7CiAgIHVuc2lnbmVk
IHNob3J0IHZbNl07CiAKQEAgLTIxMDgsOCArMjExNCwxMCBAQCBzdGF0aWMgY29uc3QgY2hhciBz
YWZlX2NoYXJzW10gPSAiJC1fLiEqJygpLCI7CiBzdGF0aWMgY29uc3QgY2hhciBncmVwX2Jhc2Vf
dXJsW10gPQogCSJodHRwOi8vY3lnd2luLmNvbS9jZ2ktYmluMi9wYWNrYWdlLWdyZXAuY2dpP3Rl
eHQ9MSZncmVwPSI7CiAKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9f
KQogI2RlZmluZSBBUkNIX1NUUiAgIiZhcmNoPXg4Nl82NCIKKyNlbGlmIGRlZmluZWQoX19hYXJj
aDY0X18pCisjZGVmaW5lIEFSQ0hfU1RSICAiJmFyY2g9YWFyY2g2NCIKICNlbHNlCiAjZXJyb3Ig
dW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgotLSAKMi41MC4xLnZmcy4wLjAK
Cg==

--_002_DB9PR83MB09230DE13A8F922630FC2CF69251ADB9PR83MB0923EURP_--

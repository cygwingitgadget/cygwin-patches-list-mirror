Return-Path: <SRS0=RHLI=2C=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072e.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::72e])
	by sourceware.org (Postfix) with ESMTPS id 1DAEA3858D1E
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 15:53:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1DAEA3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1DAEA3858D1E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::72e
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753113192; cv=pass;
	b=fo6Hs877NBqjSvsIT72i2mYPCvsmroQuOSOMF48R7u/owUl7A2i3Cuov5m/srfoJkGh+sw1Rh0Prbnm++ya+DIk/TaYst1RIZslvrQ4c2DDQQ7oSqZVPFbYE7KhYm9O37+Fl2mQUo5YsBTso81A97nrWa+0XkcaemtmIrleuZEo=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753113192; c=relaxed/simple;
	bh=5BiKjJ8g+saK6ny/cqMPMxHisIWlEOnL/yYa0t0Un0o=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=rWGP9kWox9C0uH4VfQaLFeMuDI40UGb+LZtLLuaR1WwVk0l0bxrOIFlAhAxCLdtBrs0TBcop2cDV5WmBK0Gw+rkoADLph35biOCyq+TzILp4Kzb+KeimsmUPxkZStfEJ7eZZAshTWy3PTjWmqpoLX0lEEG8WRiw7FoFvZZ8Mve4=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/3Yhq0ygh/qlVJUsS0uuYfq/8zGbAtnbEAT8fLkszk12sAYFSWHhv7WkcvWeK4StX+kAOg34V77KAr7WPEpNouqArJbw0U9lTir/pLeLBawoX9Yga6WBWXGiqoCg/V39beqrheH5fYhEEW75Z89IGbQaxICFQf4RFortTy4SH4xEsTQRz4VUn4lDG7uEKvg5ra1n/HtKWvia6cposLbXohrZnHUsiF+xeCdE1kWPpaUl+SI508uF3NQv8fEvyoojnLhbxjZmOz5N+HZ5bcWjfcK4lt3Zgq71sBGBvuYZIAslSuCFh1W7IRdWUKWCrxjtfzpp0T5akSOD7j9NWEAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BiKjJ8g+saK6ny/cqMPMxHisIWlEOnL/yYa0t0Un0o=;
 b=D/6joZuAm6SQyGryp5pf320A72GGR5pvg6Un9I1fAuppD0XYSjnRSPiO44peRE/3BRvAtbBwrZ2gN/bEW2CQAZzSeAk9Ib52a+B5WdTcniu2ezeHPXoSa+8RRY4c92hrFzXQ900TizKiSy24Rtoi/hX8xm10KOnymGdop7p8yrNQGwA2XFFf+BNpBHjJoQ6trh3VNwYjm0CXlufXrDsEj8Dj8CMZ6lGMei4DuMh7hX32MySqMtftKG5Yy78vyfrZvb5SstPdB+SpMomh4ikQ2oCUAT9TwjYsI0kCzkN6NtyDbdNJjbLtPfBlq3ewcZTXrASg4eNLU5huwEaRfJ9pTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BiKjJ8g+saK6ny/cqMPMxHisIWlEOnL/yYa0t0Un0o=;
 b=VN3+32E3InFYVLDKZQuPFH2z++FIVy0OpsnC1bz9J1yTj1vztoNoksBf1O32rj0aTwWCHJ1Y1YgnGOSgog8YnW4QpuDCXHFYb+xzxgTnDbphA/Ren5FBUwB/GDvH6kG3KGtznF2JJ0CLMxYmWSEGqgvajLBOSBWsbqh1WWnOmL8=
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com (2603:10a6:150:27e::22)
 by GVXPR83MB0784.EURPRD83.prod.outlook.com (2603:10a6:150:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 15:53:01 +0000
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a]) by GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a%3]) with mapi id 15.20.8964.019; Mon, 21 Jul 2025
 15:53:01 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Thread-Topic: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Thread-Index: AQHb+leJWYkHtPC/6kWAlAvdD8Kvlg==
Date: Mon, 21 Jul 2025 15:53:01 +0000
Message-ID:
 <GV4PR83MB09410EFD509ABD23BDA49B18925DA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
 <bd64e817-ffa8-4299-a3bc-6d1ff691ca9b@dronecode.org.uk>
 <aH5CvWENvjsmKbjJ@calimero.vinschen.de>
 <aH5EsVT1Hhe_7yHV@calimero.vinschen.de>
In-Reply-To: <aH5EsVT1Hhe_7yHV@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-21T15:52:59.965Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV4PR83MB0941:EE_|GVXPR83MB0784:EE_
x-ms-office365-filtering-correlation-id: eb184d5b-9700-4473-ba9c-08ddc86eac19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?s4vlv8a0AV3c2IMwtk16sDe/Fomi5fVN4Z5ULvvfWu/fpAb+LvOfPmmF7b?=
 =?iso-8859-1?Q?wnRAogrlAzj5QA3J1q4tjOy3s9F++hWp2q9ZJLvC6YoSPqsQkJc9hX9nTg?=
 =?iso-8859-1?Q?T2tmIJFhG/gEzAC7I1FmKRH+u3T9Euwe/2RYuYzfNbRlXpKacWn5RLKVfW?=
 =?iso-8859-1?Q?ukPOnFcTVECh8G4rpD2FQsTzTkP7hxEGHfdQEGBxP7L5Ci82gXHxpMrouZ?=
 =?iso-8859-1?Q?YkEhcswafA46PIBrmKBwvCfNg7TpSQyTjR5xoiTLCCwmOIUK3euS46ptt5?=
 =?iso-8859-1?Q?HznqHvwnPt+W3Z3H59qHVFxg0v1N6LEdSgJapi7qrmGW+kHR18CRc4MpIA?=
 =?iso-8859-1?Q?1k6pjAi55T1GWJtpXQ5OaHuYvD/sE+hvYDbvVYoxmc2aHPVuVxYN4xcutp?=
 =?iso-8859-1?Q?DGvinOYnMA7/hgUTSW8Pe0hIdXlbkYT/gixj0ia+E3+oazLY9agRzPpeU5?=
 =?iso-8859-1?Q?1VmS5LDij5KVqHaEUvufKN8KPEhGbrtCV4VM801h+K/q21SCvqksp7rVkk?=
 =?iso-8859-1?Q?bx/31fT9IDYu7I1xFwf3nIRzH7kFT+lKX7Z4+L0TMcQkWGdfsYO4d5i8RU?=
 =?iso-8859-1?Q?Q6HwAG/I8zm7XGUWCq4Vg8yvsYLeTvSDwOfxrWhpc4feVX1jCdShFfNOAX?=
 =?iso-8859-1?Q?jIkhgV7+knUGFU3IUnuhO8+TGGAchLdO33Sr1YGtTC2K88obKQXgn7oU7i?=
 =?iso-8859-1?Q?/FsPZGxuE8r6VpfZe4PCdNWMu+I/RawyT4aaLtidPoskZFIVJfbGSG3XEm?=
 =?iso-8859-1?Q?+6GAmUaXXCkuIbNclemcdiTrXh2e2lx11duTh5tutV0NFlJ99w4zM2gCoT?=
 =?iso-8859-1?Q?uRlw/3nDaXPaNdnGXEVLpPKrSwOlQ69x5uLVdgi4ONd5rMvrW2r0MubPqp?=
 =?iso-8859-1?Q?BAFdzTk8vy0RKZxiVq6XnZ815ShtTgB77j0uTTRjdW9QbHGRoKQN7xXlbK?=
 =?iso-8859-1?Q?RFxQC5nEUGV733625A4xY5xT0wYhNRmjbj5UF0r7nhQ8gb+q5Vhsa6Q402?=
 =?iso-8859-1?Q?DeSXaVBhVKE5ATG32uMadc4iukpsM5o9hPTIYX1BUpVpSDd9XKd31poUy/?=
 =?iso-8859-1?Q?pNcgtLpLKZ9t4XieLxjQk+5wseTX71rutVFDSA7Sd1i3IA8fN1Z160xMyv?=
 =?iso-8859-1?Q?xuaULyNjVaw2YCC+2pSBnpvScwaryeo3M3fs9SJf47tmHdLPj9AaO0tRiM?=
 =?iso-8859-1?Q?LrCRKy3nUvMXuAKjayvE9wQA6+I7ne+IuynmLxB5sxMvsQa0LIQ1i4Zqr+?=
 =?iso-8859-1?Q?I6O7xSJnyd3IzE+ktj447VHvevzvCLDGQ62n8gVNvcu2G0hQhzw0xGn+fH?=
 =?iso-8859-1?Q?Y7KZfozW0SSM9ZRimIJocA6vIhFPI/jqVTwyLyZKPzD5/3W0twsTZPpDpm?=
 =?iso-8859-1?Q?tr7GSHoQj9HkHlZy54NQWFj0PdZPWkHxKptIfXTrw53+FEkJFJn8w47T4o?=
 =?iso-8859-1?Q?CNZ5Lqcxh0qhWCDDke9vvyegzjwaVTjuDjEMU7atuMcxg/nr4n6ZElkCa0?=
 =?iso-8859-1?Q?jpjQOpcgCAzzFzOxEXnDZ01ROcUhedPWVhaAWNi3Ka1w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV4PR83MB0941.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qEN/2JIBgqbNujS3zQT4BmQNf4t8hZ0c9pyhXE/9XcCH5ob79xd/KZwGdz?=
 =?iso-8859-1?Q?XdX9e1bFMWsGHzgUyiDofOA22w72uKXCiloWMuZztuhPSYpccpo/EIwgjP?=
 =?iso-8859-1?Q?2dnEE8qvY2YI1lOTqEAgphm/QnBwSmifhLhPHOpL9aN3O4iG4ZpJvKvqI/?=
 =?iso-8859-1?Q?Us6PWeBSUkgfnHzfUnV4eT8CUC3TLd1yLac8ikqS4fKTf2Emzf/2EU6xO0?=
 =?iso-8859-1?Q?YMm+B7n5S33P4sbIQF9PmV8JL7LRwSvH+upP6DetMZtdQjAdcwicCwk6/C?=
 =?iso-8859-1?Q?NYmJAZ1kZNHq6BJvGsuMB7TCni7eeRVwUOTPpjZ5aeyJXKTcbND1le5XLj?=
 =?iso-8859-1?Q?FEndWhbYbj4pdVBG33RjpFPHqfocxlI0tNwUYZKIlVRjLAkCgr57ZWSZ8n?=
 =?iso-8859-1?Q?PSNi9PL/GbVZ+FyEeaY+dWkQ1pDG/CX+N76EVSTIo/JJsreJ9EdowjNeYo?=
 =?iso-8859-1?Q?pt5gOVC+e25vl7L6N7S/BNKX7HQiQOt3P9YJGcTSSJTbn1B05rx99FkAEt?=
 =?iso-8859-1?Q?p1Xn8q5TVtLf51zXhahK22VvQTug/h150vAPSMDDHkxMUh5Vfj8/ojtbCm?=
 =?iso-8859-1?Q?P/BIP03eamajA/fSV62sezomeOY+huTKvB0gYHx9wYQgzlP+5uK+GeYrky?=
 =?iso-8859-1?Q?eato2pFzGkdp04P0iDcxDb5A92ELJpIr5kqMTYjBougNZwpJeyHh9Er0VX?=
 =?iso-8859-1?Q?JnXSPPnn2n1yV7D0oyTadcH9vG+GLEF/LinviJNHmoW9a6tJEmOOEsW7Fr?=
 =?iso-8859-1?Q?NwZ4z+Rg8vur7k6eDLziQPzd/MgbJaEVs60s8bxxHY4EEQRDj05JA+31A7?=
 =?iso-8859-1?Q?5s1GsEHmFCfimJWyjkxeVuJbFwnYmdGgu77oY5ZMd0RaPx2sh8lq5hPxfH?=
 =?iso-8859-1?Q?+sgkVaIQbl0FomB3Xrr5RYDwnbmNAidUC7BVX71SrABupNI8DrbXp2v2Z4?=
 =?iso-8859-1?Q?YokTq1yG2xH1rhYGIk85Flj5hQ6KfDBC5VhyoJrvnhB/6ZmltDghstfkVx?=
 =?iso-8859-1?Q?7QNd+PswEgNGeLnAz79bJTJQSSmoQ6KyTHFBRPrE1g7cMfYiQsqu+y2FqS?=
 =?iso-8859-1?Q?FGRCnKUTB6nY+C3gTf0uodO2pZXegF73wtXcD2gtl4M4OFZpVm0v3XfrjP?=
 =?iso-8859-1?Q?+/8Jv8OP9ZkE+NvwP/rasdP1XssJ6WR4YbpQTvgaARUWlNk04pQCRNSlIs?=
 =?iso-8859-1?Q?m1relsut929vK1xcVpGOHfTn44yOtgyQ1Av7/IqGl2oLMqxFgEoVWzYVzP?=
 =?iso-8859-1?Q?14UgAoo0e8Lxky1F2aT+OyhJ8qeN1Mh5+Zhxldp6CgsmZBCrvLYkjTZnlR?=
 =?iso-8859-1?Q?jPnbmiUH8UdoR0E66LNVvNdo3OQxshI8yBrX2KTM8698iv7sv/uZNV+dlq?=
 =?iso-8859-1?Q?MSBzptvQ+iyRvXzKdAEVLzY3rxXmwEg9QR9ly5KF3qnrnjfsfy9WN0zQj7?=
 =?iso-8859-1?Q?sjhQkc9aK8f6+DO4EEsepsSMezn7nrl+GXgEHlMlxDYi6q4imc5wEFSo7O?=
 =?iso-8859-1?Q?GGcZYMM73dQLwHGkMAbv2kb2ERjtBpF3seCH/Tta13KYT0vz8dJuXn+l9i?=
 =?iso-8859-1?Q?ZuGJMrleIHWiZHKa5nhFPcfVDDJC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV4PR83MB0941.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb184d5b-9700-4473-ba9c-08ddc86eac19
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 15:53:01.5755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dz+trK5uu+izs38E6AGukAphSb8ZmER9I7OFxI7e3rVDLReZbfJ098yE4X5osfpZVpQlh4yH7gA+M+nWEX6HmUSxmua7RvtQ3Y704NKF+bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0784
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello.=0A=
=0A=
JFYI, my original thought was that the Signed-off-by header is serving for =
some sort of automation that will let maintainers create commit with that p=
erson as a committer. Other than that, I am not aware of the cases where it=
 could be handy to have different person being a committer and different pe=
rson being the one who is granting the authorship rights.=0A=
=0A=
Radek=

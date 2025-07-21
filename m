Return-Path: <SRS0=RHLI=2C=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071e.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::71e])
	by sourceware.org (Postfix) with ESMTPS id AAAFB3858CDA
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 07:40:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AAAFB3858CDA
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AAAFB3858CDA
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2612::71e
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753083640; cv=pass;
	b=BqCIcDFUwuJNafbhv4ALtoFE+ENXEP76YV7ejMc2/Q3UddK2B9kVekPfZ7/f4+DimSzcEmqH1cXEPYM0LFxfFbwmJ4Mw5tGJ27byxWPurT98xBZtJ0Gc7+8stt+EEcUvWGWd3n/mVQMhUMOt7BT8xqXw2dcS2+CdD88zxiYAl/w=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753083640; c=relaxed/simple;
	bh=qmB19ybYnhNqX9wRM5B8C9BzjMJ2HFwfJEn4kMbgIS0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=xyuwCl0SMNiF7I4Jw2sf8NdXRcKfuvQBt7GxHaxXCX90YsI53KRrvFnpw2o4f6dVeBI+Sv9NUg00mqsIMnbQHBD/j+gNVtyUtkbSexwUFQWp78/D0vFJtiA+DoX7oelq3Lw/uRYS4A0CWgZKUzKpiInBzGQgPwTz8U/ZN+wKuMI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AAAFB3858CDA
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=WR8yfe+D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpasyioegMXbrLb/ISXBp32svw6aGdSNbpzk9YLrtPs0YCfJ0nWtWzg84+9lWvn4QLMgKonbD4tCqg97KCnu1vZUqu1DzIufRnVV6NkfNXhtUq144LVqyaCACW5+vlBtBqeJqpPyFrVVriqmsJCOJef1bteMYe67yoSZTJrsmoZkouLdG4IZXFpGGNjNYewuoVIjhX9nh0kPG2a1hzIQCcB2lsuSabXE+NI6jzPheFJJAAaAp/Q4wFEhJRK45iQeUpujOCmn/P+9/UfMGshUtmxrlu/qrexQ2/JZJJ2z45/W+w7Z7IkYD4wITIBIcyRlgkw4ncBXl9X699Uw4eUDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3BAvckWhFHRTzdwE08dge12B0EZmg2DDX8Ir8satbE=;
 b=oMVXu/sKvyMeaMd4gy8l3XsweMFVpOfEg8iTS1ud/vKsXDhEjPca4jfKH40fNla7T6fHXhZQtnY2yuodLS2NdYkaPU3NtjVnojkt9WEYMLUfg8qpL9A6WOYh7DBYn7qILxD2i4FoNvheo//60jw+rD9MSG+1qG28rp4ptCt3yzNP5zmjdqhj/JDdv4WHaPJamDKzHxVHBaFYu7vqJfUvBcLbz3nJIt1hJPeNuFOlJdCfcZvWtUEpS6hENlyLA/9QIo5AMMVN8G79W4dvv+uhuqPjh5KmkyGEUKuLDftDZLOmCiGh29hh7VtElFheqNKrtkadmMO0FZeWQMldI/Dnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3BAvckWhFHRTzdwE08dge12B0EZmg2DDX8Ir8satbE=;
 b=WR8yfe+D/3NKcqldARejj68RltxOYhpCpkCxkkgmxuqDK3lVQC2bePKWbxspKDkB0x9wcJZ+vTlqIXVG9LXVnK+NIoKOZ1l3AOjpsMvwEf+jB9HilMjhJe2yNVYn8W99QrPqMghDmfXzg3XXWLEQbBwk+eJ1eY0y3Q8Qseo8umE=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by VI2PR83MB0719.EURPRD83.prod.outlook.com (2603:10a6:800:27d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.16; Mon, 21 Jul
 2025 07:40:37 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8964.019; Mon, 21 Jul 2025
 07:40:37 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v4] Cygwin: configure: add possibility to skip build of
 cygserver and utils
Thread-Topic: [PATCH v4] Cygwin: configure: add possibility to skip build of
 cygserver and utils
Thread-Index: AQHb+hLA8IDZ9THIV0ijBrbEpw3cJw==
Date: Mon, 21 Jul 2025 07:40:37 +0000
Message-ID:
 <DB9PR83MB0923F0FF53C98FB27E03C376925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB09232A0A1E4EC3D43BBAFA089242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923C35FB2253C8C2A21927C9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <52fd7877-6abc-4e01-8f3c-405cf075b1ff@dronecode.org.uk>
 <DB9PR83MB09237AD6BA4BFE16B03AEBD99256A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB09237AD6BA4BFE16B03AEBD99256A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-21T07:40:36.558Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|VI2PR83MB0719:EE_
x-ms-office365-filtering-correlation-id: eec2564a-ef4d-4f6a-905a-08ddc829e28a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?gaAgHACAKuhjOKNfLRf2Ylu24elUpdGSX478D8bhikVYMr+WL8KYeCN/7C?=
 =?iso-8859-2?Q?0xkcQgO32ylfXHIYw79kpB9dgQiDRzZpDcZU/JZgo5YmyTpJN4bRGo4NGX?=
 =?iso-8859-2?Q?RbWbqVrYh5R/iDkN6VY04jUpPeZMM9rFmhdFmBJ2YbuvagVSsrxnGMukOU?=
 =?iso-8859-2?Q?7+52lc7ZYuW0mVJJ6lIQPb4jybgEsOMQcPZv4HiNt828bRZjdgO8QkIhVn?=
 =?iso-8859-2?Q?0s8dldmAZhrdhBcAj9kjqKz548kRZNwSxqcB6HsCvxZRTocVpzYjAYvTc6?=
 =?iso-8859-2?Q?0Lq3jt+0qxbXNcgIiqFgea5DvfOwmPUYIy/1i7voR0yXQBxIH2/C9E0LCh?=
 =?iso-8859-2?Q?YxlxqTN+O1jk7hmow5pyZk0H0/F/9DIhSfprwvG/JBkWd9Q1NMR27n3fuy?=
 =?iso-8859-2?Q?brtXUFzXVcxKPmdmRzo63b0GliGx3zED1CjtZL5fxPABu1P8O8vXQrX8BA?=
 =?iso-8859-2?Q?KYOMtO8fDZt3ndo96wZLsLg0hz1o3U+n3/4K5Ie9As3Bfk4wUGw0Ql4AM3?=
 =?iso-8859-2?Q?TD1Mywy1Nu/P0Z90bJL5Q+JqSQBC93atF291Bh4auR3z7wvuEyVjRQbrH/?=
 =?iso-8859-2?Q?Z5S8zp3ScWHIetmzHdORmH27TZYbW4Wgok+HNeA8Hf1fmcMXZMYn7uyoAY?=
 =?iso-8859-2?Q?nZR1QlseIT9czWrWgSjdS1l3AFnk4ozgwYUP2p5Dh4Fuvjjd89S6v2G9xz?=
 =?iso-8859-2?Q?XDqiUDIlyXfnntlyVlj7R4vSEF2q+aDoS1qyIwfdSOmWNue/MWmAi19zyn?=
 =?iso-8859-2?Q?HyOsLvlDg7TCBjxajLgGSlm9w1twhMYguk30FDcHqriN2jOO2chBGxjMAW?=
 =?iso-8859-2?Q?Y9v/HVjOvBXFM9XRsNnj1kb47s+2mRE4Ia16ajYWkillvtlCigtvwQoZ8B?=
 =?iso-8859-2?Q?hN44q7B03t42qgmVt/b4Ke2RimkeY/3mr4Mi8sYWz/OFaDBPZTMbRkYdUF?=
 =?iso-8859-2?Q?lAb+KYul8QsPM+8KnshsednQcbJ/yHDgUcl3JfzucrWoiWrxdvpYcHHU7c?=
 =?iso-8859-2?Q?V/V4K/M5N5Y9BeC3eEtA70gJb6hoPD22EEtGFkiBRlh9iDvj9tCnRoGjzl?=
 =?iso-8859-2?Q?FIgfOcDBfS/vcoI5gzICoP1waKw4Lae9ZDSsNMRSYrdkcNtxXUWToPxSCK?=
 =?iso-8859-2?Q?F/rhhqioT/eqnxyHfmn0Xvjm3MalrvxD652ilen4a+6ZanMqVSBWb0brmT?=
 =?iso-8859-2?Q?GafP5pqWf6SDaaFHdOlAyzvvd08mrC5IGspXpzhqDSx3AxmZW3PYKZ+GUN?=
 =?iso-8859-2?Q?h/Av0biq3F0Flpu1PSKUYu7CBt4kJQDQcAE7p9fj1wf1nMIPUBUDIUKp7K?=
 =?iso-8859-2?Q?wXsfJSQghvPCLX0QHzIHUp+SFkvjAa0zP5X5RqLfiwNpWYKU0ZeYUJxs45?=
 =?iso-8859-2?Q?VwLq9MbJpPbh1Hvs3JCeUQCyi4KYHmoxQWD67AOqfVLm81u5qDhmPXI6EG?=
 =?iso-8859-2?Q?VoaoaBT60sV6Jq0R+YjEKAS50DRhvgEGMSW1sQ595flgMj3R9Z9W5z+PP4?=
 =?iso-8859-2?Q?vKdQo96N2CvE1IQub6wjCt8qjADukjlqPsHyhl3l9dmzN4iLC7hPKdMvJL?=
 =?iso-8859-2?Q?1V4Zyzs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?CE2YkhSfTwLHWQopFTsGG0HRbetdewjvlSo3GRw+RmKJzfnvNbSdtMI6BL?=
 =?iso-8859-2?Q?CNtZKtAYGvlmdTxA09BsQrVuzd14go09dc+Tb7xRUOtmWN7GfmMhAp5ccI?=
 =?iso-8859-2?Q?gmLIJGW8+M6HaSqyT6rkiI7uiS9JE6cR464pD8jtC9VbMEV9hc+yGZr5wN?=
 =?iso-8859-2?Q?hEbqKLPpTCLwJ8pwKTU22uETfqlu0msSE9xjpb3xFncBFuzkL74T9IiEeC?=
 =?iso-8859-2?Q?nZkx6RML8kTzDjvpoD2K8y7gDQ99W2GAksOApwbavYVEuV5I9ktfZ77BrW?=
 =?iso-8859-2?Q?dNeY80r+gPZb9YCyNALKXlakHy+e/FWmG559qFFC1tAz4BON6rnnZoBaEw?=
 =?iso-8859-2?Q?RdjG61bygWe/UwM/nATV1hNsskJIk+8wiW49GcYhvYQMdEGWq00JoUYiIH?=
 =?iso-8859-2?Q?n8KXk0eJ/YDoIlRef+eFzJWokWQE5q3vdra3VHnqFE24RpnD+BSL6WymtR?=
 =?iso-8859-2?Q?nBW5JIZ3D+HHC0WMEXTm6FWCD+cahbnV5mOuZiyqB3gPyCUydDwnl/6FnC?=
 =?iso-8859-2?Q?4QTKBxSWtyU+ZJnmWTAlw0b7wMs0+0emU0vd5/33xRgYI9+a/CLkhkA1NW?=
 =?iso-8859-2?Q?QZutGnN65yaP558KWiWfs7iFscWxVST+8Nbg2gKrTnm/Mktz3ifAawvMbQ?=
 =?iso-8859-2?Q?0Ej5Pb6rKIAYu+725Si1m/V5Na5Gq+sqAxjvuX8+xeiQnI/OgO+Bn/NMEj?=
 =?iso-8859-2?Q?bYZUugs/jAsCKYOhoOlDid+pL+rrs+kR5xJGa8x4/B2nemy3Mo2gmSdkgi?=
 =?iso-8859-2?Q?nkzEoF3JgXqYUqplmNHRt15ioRxS60aCEuCHaKMq7hO/rzrEarYl7ElNLY?=
 =?iso-8859-2?Q?sgBq6Z/ssMtwEYTGVpvStiR8EaXfAwKo7+g9MvdQCsJ/f/bmG1//NBkP35?=
 =?iso-8859-2?Q?tvaw/j+LyO+p2hBzTyNIn/R8CdmOUTIzIzD2EOx4IxxSLJ5kvRoMhPiZHZ?=
 =?iso-8859-2?Q?5k8jTAzy9dm3Vj09OaFILdFA9ssJ0+z0VhahaY8ByJ8HVuZ+IknloyYFxk?=
 =?iso-8859-2?Q?IsDo/IOJSomJapU+kaXCA+XtAI3xWwF7H2aVY7se7J/ZoNakI7tlsl1xSS?=
 =?iso-8859-2?Q?F7FxsVoAUArsEWmSrG9eoFPM205SWNdJi2osKd2wlatxYIpTN9Cmfw+1r0?=
 =?iso-8859-2?Q?ob53/RxXdRMT1XqgtZEVrMV8f5heFm96gzwMGA8dzsPE69KCPOfR8pOusa?=
 =?iso-8859-2?Q?HZF1UqUySF+vuflo6mvhMVm0J2JY02optRDK5pqs5pTP8KMWQe5soj/Ptr?=
 =?iso-8859-2?Q?PkX8cDuTugjQeERd5hFcP6nnjjN5jMKCch6sFfNHf9jPUHvSJ/w7PMO3mM?=
 =?iso-8859-2?Q?fDl8MY8wy8kr7DN7yH9HjoXlZba1mjP8J1+1+4a5g8GSn0AQdftneSETzg?=
 =?iso-8859-2?Q?cgrTITcIqMHOLj5bcDRbh0fvv/DDovsmAggDDv4qR5QNOxpNC9QBAg51I7?=
 =?iso-8859-2?Q?5DQLtMhg11g8IhQ7Fu9fyanbi+/YCK+IXIy4qh0PlLC/ZIWTCfnlIMcddK?=
 =?iso-8859-2?Q?9tVOj2043K/WA3cJJXHvb7oBzLZ9TIEDNklnmdzGqY+jXc4XeQJp0A6zIZ?=
 =?iso-8859-2?Q?j9emXPK8o5Dq0TKSNMPzrqJyCs6I?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923F0FF53C98FB27E03C376925DADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec2564a-ef4d-4f6a-905a-08ddc829e28a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 07:40:37.5889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SlfCsEtxhkjMqSp4PTbz2iZwRLjimcDfyCUtvi/asGKixUqguWD3e+QNso4KIGYAS6RGn2o1BbWqYiHJT8v12S0UP2UEZBfujW7jEfPPDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR83MB0719
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923F0FF53C98FB27E03C376925DADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending a patch with your suggestion applied. I'll address the `--with-cros=
s-bootstrap` option handling in a separate patch submission as it requires =
more complex solution to fully allow zero-bootstrap of x64/AArch64 Linux ->=
 AArch64 Cygwin or x64 Cygwin -> AArch64 Cygwin cross-compiler.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 7770246d173d869f79f5d87e1bce1621c0fe1308 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 21 Jun 2025 22:56:58 +0200=0A=
Subject: [PATCH v4] Cygwin: configure: add possibility to skip build of=0A=
 cygserver and utils=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch adds configure options allowing to disable build of cygserver=0A=
and Cygwin utilities. This is useful when one needs to build only=0A=
cygwin1.dll and crt0.o with stage1 compiler that is not yet capable of=0A=
linking executables as it is missing cygwin1.dll and crt0.o.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/Makefile.am             | 20 ++++++++++++++++++--=0A=
 winsup/configure.ac            | 12 ++++++++++++=0A=
 winsup/cygserver/Makefile.am   |  2 ++=0A=
 winsup/doc/faq-programming.xml | 17 ++++++++++++++++-=0A=
 4 files changed, 48 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/winsup/Makefile.am b/winsup/Makefile.am=0A=
index 9efdd4cb1..877c4e6b9 100644=0A=
--- a/winsup/Makefile.am=0A=
+++ b/winsup/Makefile.am=0A=
@@ -14,10 +14,26 @@ cygdoc_DATA =3D \=0A=
 	CYGWIN_LICENSE \=0A=
 	COPYING=0A=
 =0A=
-SUBDIRS =3D cygwin cygserver utils testsuite=0A=
+SUBDIRS =3D cygwin testsuite=0A=
+=0A=
+if BUILD_CYGSERVER=0A=
+SUBDIRS +=3D cygserver=0A=
+endif=0A=
+=0A=
+if BUILD_UTILS=0A=
+SUBDIRS +=3D utils=0A=
+endif=0A=
 =0A=
 if BUILD_DOC=0A=
 SUBDIRS +=3D doc=0A=
 endif=0A=
 =0A=
-cygserver utils testsuite: cygwin=0A=
+testsuite: cygwin=0A=
+=0A=
+if BUILD_CYGSERVER=0A=
+cygserver: cygwin=0A=
+endif=0A=
+=0A=
+if BUILD_UTILS=0A=
+utils: cygwin=0A=
+endif=0A=
diff --git a/winsup/configure.ac b/winsup/configure.ac=0A=
index 18adf3d97..e7ac814b1 100644=0A=
--- a/winsup/configure.ac=0A=
+++ b/winsup/configure.ac=0A=
@@ -83,6 +83,18 @@ AC_ARG_ENABLE(doc,=0A=
 	      enable_doc=3Dyes)=0A=
 AM_CONDITIONAL(BUILD_DOC, [test $enable_doc !=3D "no"])=0A=
 =0A=
+# Disabling build of cygserver and utils is needed for zero-bootstrap buil=
d of=0A=
+# stage 1 Cygwin toolchain where the linker is not able to produce executa=
bles=0A=
+# yet.=0A=
+AC_ARG_ENABLE(cygserver,=0A=
+	      [AS_HELP_STRING([--disable-cygserver], [do not build cygserver])],,=
=0A=
+	      enable_cygserver=3Dyes)=0A=
+AM_CONDITIONAL(BUILD_CYGSERVER, [test $enable_cygserver !=3D "no"])=0A=
+AC_ARG_ENABLE(utils,=0A=
+	      [AS_HELP_STRING([--disable-utils], [do not build utils])],,=0A=
+	      enable_utils=3Dyes)=0A=
+AM_CONDITIONAL(BUILD_UTILS, [test $enable_utils !=3D "no"])=0A=
+=0A=
 AC_CHECK_PROGS([DOCBOOK2XTEXI], [docbook2x-texi db2x_docbook2texi])=0A=
 if test -z "$DOCBOOK2XTEXI" ; then=0A=
     if test "x$enable_doc" !=3D "xno"; then=0A=
diff --git a/winsup/cygserver/Makefile.am b/winsup/cygserver/Makefile.am=0A=
index ec7a62240..efb578e53 100644=0A=
--- a/winsup/cygserver/Makefile.am=0A=
+++ b/winsup/cygserver/Makefile.am=0A=
@@ -12,7 +12,9 @@ cygserver_flags=3D$(cxxflags_common) -Wimplicit-fallthrou=
gh=3D5 -Werror -DSYSCONFDIR=0A=
 AM_CXXFLAGS =3D $(CFLAGS)=0A=
 =0A=
 noinst_LIBRARIES =3D libcygserver.a=0A=
+if BUILD_CYGSERVER=0A=
 sbin_PROGRAMS =3D cygserver=0A=
+endif=0A=
 bin_SCRIPTS =3D cygserver-config=0A=
 =0A=
 cygserver_SOURCES =3D \=0A=
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0A=
index 39610b916..ae9bdb8dc 100644=0A=
--- a/winsup/doc/faq-programming.xml=0A=
+++ b/winsup/doc/faq-programming.xml=0A=
@@ -698,8 +698,23 @@ Building these programs can be disabled with the <lite=
ral>--without-cross-bootst=0A=
 option to <literal>configure</literal>.=0A=
 </para>=0A=
 =0A=
+<para>=0A=
+Build of <literal>cygserver</literal> can be skipped with=0A=
+<literal>--disable-cygserver</literal> and build of other Cygwin utilities=
 with=0A=
+<literal>--disable-utils</literal>.=0A=
+</para>=0A=
+=0A=
+<para>=0A=
+In combination, <literal>--disable-cygserver</literal>,=0A=
+<literal>--disable-dumper</literal>, <literal>--disable-utils</literal>=0A=
+and  <literal>--without-cross-bootstrap</literal> allow building of just=
=0A=
+<literal>cygwin1.dll</literal> and <literal>crt0.o</literal> for a stage2=
=0A=
+compiler, when being built with stage1 compiler which does not support lin=
king=0A=
+executables yet (because those files are missing).=0A=
+</para>=0A=
+=0A=
 <!-- If you want to run the tests <literal>busybox</literal> and=0A=
-     <literal>cygutils-extra<literal> are also required. -->=0A=
+     <literal>cygutils-extra</literal> are also required. -->=0A=
 =0A=
 <para>=0A=
 Building the documentation also requires the <literal>dblatex</literal>,=
=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB0923F0FF53C98FB27E03C376925DADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v4-0001-Cygwin-configure-add-possibility-to-skip-build-of-cygserver-and-utils.patch"
Content-Description:
 v4-0001-Cygwin-configure-add-possibility-to-skip-build-of-cygserver-and-utils.patch
Content-Disposition: attachment;
	filename="v4-0001-Cygwin-configure-add-possibility-to-skip-build-of-cygserver-and-utils.patch";
	size=4163; creation-date="Mon, 21 Jul 2025 07:40:15 GMT";
	modification-date="Mon, 21 Jul 2025 07:40:15 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3NzcwMjQ2ZDE3M2Q4NjlmNzlmNWQ4N2UxYmNlMTYyMWMwZmUxMzA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAyMSBKdW4gMjAyNSAyMjo1Njo1OCAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjRdIEN5Z3dpbjogY29uZmlndXJlOiBhZGQgcG9zc2liaWxp
dHkgdG8gc2tpcCBidWlsZCBvZgogY3lnc2VydmVyIGFuZCB1dGlscwpNSU1FLVZlcnNpb246IDEu
MApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zl
ci1FbmNvZGluZzogOGJpdAoKVGhpcyBwYXRjaCBhZGRzIGNvbmZpZ3VyZSBvcHRpb25zIGFsbG93
aW5nIHRvIGRpc2FibGUgYnVpbGQgb2YgY3lnc2VydmVyCmFuZCBDeWd3aW4gdXRpbGl0aWVzLiBU
aGlzIGlzIHVzZWZ1bCB3aGVuIG9uZSBuZWVkcyB0byBidWlsZCBvbmx5CmN5Z3dpbjEuZGxsIGFu
ZCBjcnQwLm8gd2l0aCBzdGFnZTEgY29tcGlsZXIgdGhhdCBpcyBub3QgeWV0IGNhcGFibGUgb2YK
bGlua2luZyBleGVjdXRhYmxlcyBhcyBpdCBpcyBtaXNzaW5nIGN5Z3dpbjEuZGxsIGFuZCBjcnQw
Lm8uCgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0
LmNvbT4KLS0tCiB3aW5zdXAvTWFrZWZpbGUuYW0gICAgICAgICAgICAgfCAyMCArKysrKysrKysr
KysrKysrKystLQogd2luc3VwL2NvbmZpZ3VyZS5hYyAgICAgICAgICAgIHwgMTIgKysrKysrKysr
KysrCiB3aW5zdXAvY3lnc2VydmVyL01ha2VmaWxlLmFtICAgfCAgMiArKwogd2luc3VwL2RvYy9m
YXEtcHJvZ3JhbW1pbmcueG1sIHwgMTcgKysrKysrKysrKysrKysrKy0KIDQgZmlsZXMgY2hhbmdl
ZCwgNDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAv
TWFrZWZpbGUuYW0gYi93aW5zdXAvTWFrZWZpbGUuYW0KaW5kZXggOWVmZGQ0Y2IxLi44NzdjNGU2
YjkgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9NYWtlZmlsZS5hbQorKysgYi93aW5zdXAvTWFrZWZpbGUu
YW0KQEAgLTE0LDEwICsxNCwyNiBAQCBjeWdkb2NfREFUQSA9IFwKIAlDWUdXSU5fTElDRU5TRSBc
CiAJQ09QWUlORwogCi1TVUJESVJTID0gY3lnd2luIGN5Z3NlcnZlciB1dGlscyB0ZXN0c3VpdGUK
K1NVQkRJUlMgPSBjeWd3aW4gdGVzdHN1aXRlCisKK2lmIEJVSUxEX0NZR1NFUlZFUgorU1VCRElS
UyArPSBjeWdzZXJ2ZXIKK2VuZGlmCisKK2lmIEJVSUxEX1VUSUxTCitTVUJESVJTICs9IHV0aWxz
CitlbmRpZgogCiBpZiBCVUlMRF9ET0MKIFNVQkRJUlMgKz0gZG9jCiBlbmRpZgogCi1jeWdzZXJ2
ZXIgdXRpbHMgdGVzdHN1aXRlOiBjeWd3aW4KK3Rlc3RzdWl0ZTogY3lnd2luCisKK2lmIEJVSUxE
X0NZR1NFUlZFUgorY3lnc2VydmVyOiBjeWd3aW4KK2VuZGlmCisKK2lmIEJVSUxEX1VUSUxTCit1
dGlsczogY3lnd2luCitlbmRpZgpkaWZmIC0tZ2l0IGEvd2luc3VwL2NvbmZpZ3VyZS5hYyBiL3dp
bnN1cC9jb25maWd1cmUuYWMKaW5kZXggMThhZGYzZDk3Li5lN2FjODE0YjEgMTAwNjQ0Ci0tLSBh
L3dpbnN1cC9jb25maWd1cmUuYWMKKysrIGIvd2luc3VwL2NvbmZpZ3VyZS5hYwpAQCAtODMsNiAr
ODMsMTggQEAgQUNfQVJHX0VOQUJMRShkb2MsCiAJICAgICAgZW5hYmxlX2RvYz15ZXMpCiBBTV9D
T05ESVRJT05BTChCVUlMRF9ET0MsIFt0ZXN0ICRlbmFibGVfZG9jICE9ICJubyJdKQogCisjIERp
c2FibGluZyBidWlsZCBvZiBjeWdzZXJ2ZXIgYW5kIHV0aWxzIGlzIG5lZWRlZCBmb3IgemVyby1i
b290c3RyYXAgYnVpbGQgb2YKKyMgc3RhZ2UgMSBDeWd3aW4gdG9vbGNoYWluIHdoZXJlIHRoZSBs
aW5rZXIgaXMgbm90IGFibGUgdG8gcHJvZHVjZSBleGVjdXRhYmxlcworIyB5ZXQuCitBQ19BUkdf
RU5BQkxFKGN5Z3NlcnZlciwKKwkgICAgICBbQVNfSEVMUF9TVFJJTkcoWy0tZGlzYWJsZS1jeWdz
ZXJ2ZXJdLCBbZG8gbm90IGJ1aWxkIGN5Z3NlcnZlcl0pXSwsCisJICAgICAgZW5hYmxlX2N5Z3Nl
cnZlcj15ZXMpCitBTV9DT05ESVRJT05BTChCVUlMRF9DWUdTRVJWRVIsIFt0ZXN0ICRlbmFibGVf
Y3lnc2VydmVyICE9ICJubyJdKQorQUNfQVJHX0VOQUJMRSh1dGlscywKKwkgICAgICBbQVNfSEVM
UF9TVFJJTkcoWy0tZGlzYWJsZS11dGlsc10sIFtkbyBub3QgYnVpbGQgdXRpbHNdKV0sLAorCSAg
ICAgIGVuYWJsZV91dGlscz15ZXMpCitBTV9DT05ESVRJT05BTChCVUlMRF9VVElMUywgW3Rlc3Qg
JGVuYWJsZV91dGlscyAhPSAibm8iXSkKKwogQUNfQ0hFQ0tfUFJPR1MoW0RPQ0JPT0syWFRFWEld
LCBbZG9jYm9vazJ4LXRleGkgZGIyeF9kb2Nib29rMnRleGldKQogaWYgdGVzdCAteiAiJERPQ0JP
T0syWFRFWEkiIDsgdGhlbgogICAgIGlmIHRlc3QgIngkZW5hYmxlX2RvYyIgIT0gInhubyI7IHRo
ZW4KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWdzZXJ2ZXIvTWFrZWZpbGUuYW0gYi93aW5zdXAvY3ln
c2VydmVyL01ha2VmaWxlLmFtCmluZGV4IGVjN2E2MjI0MC4uZWZiNTc4ZTUzIDEwMDY0NAotLS0g
YS93aW5zdXAvY3lnc2VydmVyL01ha2VmaWxlLmFtCisrKyBiL3dpbnN1cC9jeWdzZXJ2ZXIvTWFr
ZWZpbGUuYW0KQEAgLTEyLDcgKzEyLDkgQEAgY3lnc2VydmVyX2ZsYWdzPSQoY3h4ZmxhZ3NfY29t
bW9uKSAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTUgLVdlcnJvciAtRFNZU0NPTkZESVIKIEFNX0NY
WEZMQUdTID0gJChDRkxBR1MpCiAKIG5vaW5zdF9MSUJSQVJJRVMgPSBsaWJjeWdzZXJ2ZXIuYQor
aWYgQlVJTERfQ1lHU0VSVkVSCiBzYmluX1BST0dSQU1TID0gY3lnc2VydmVyCitlbmRpZgogYmlu
X1NDUklQVFMgPSBjeWdzZXJ2ZXItY29uZmlnCiAKIGN5Z3NlcnZlcl9TT1VSQ0VTID0gXApkaWZm
IC0tZ2l0IGEvd2luc3VwL2RvYy9mYXEtcHJvZ3JhbW1pbmcueG1sIGIvd2luc3VwL2RvYy9mYXEt
cHJvZ3JhbW1pbmcueG1sCmluZGV4IDM5NjEwYjkxNi4uYWU5YmRiOGRjIDEwMDY0NAotLS0gYS93
aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWwKKysrIGIvd2luc3VwL2RvYy9mYXEtcHJvZ3Jh
bW1pbmcueG1sCkBAIC02OTgsOCArNjk4LDIzIEBAIEJ1aWxkaW5nIHRoZXNlIHByb2dyYW1zIGNh
biBiZSBkaXNhYmxlZCB3aXRoIHRoZSA8bGl0ZXJhbD4tLXdpdGhvdXQtY3Jvc3MtYm9vdHN0CiBv
cHRpb24gdG8gPGxpdGVyYWw+Y29uZmlndXJlPC9saXRlcmFsPi4KIDwvcGFyYT4KIAorPHBhcmE+
CitCdWlsZCBvZiA8bGl0ZXJhbD5jeWdzZXJ2ZXI8L2xpdGVyYWw+IGNhbiBiZSBza2lwcGVkIHdp
dGgKKzxsaXRlcmFsPi0tZGlzYWJsZS1jeWdzZXJ2ZXI8L2xpdGVyYWw+IGFuZCBidWlsZCBvZiBv
dGhlciBDeWd3aW4gdXRpbGl0aWVzIHdpdGgKKzxsaXRlcmFsPi0tZGlzYWJsZS11dGlsczwvbGl0
ZXJhbD4uCis8L3BhcmE+CisKKzxwYXJhPgorSW4gY29tYmluYXRpb24sIDxsaXRlcmFsPi0tZGlz
YWJsZS1jeWdzZXJ2ZXI8L2xpdGVyYWw+LAorPGxpdGVyYWw+LS1kaXNhYmxlLWR1bXBlcjwvbGl0
ZXJhbD4sIDxsaXRlcmFsPi0tZGlzYWJsZS11dGlsczwvbGl0ZXJhbD4KK2FuZCAgPGxpdGVyYWw+
LS13aXRob3V0LWNyb3NzLWJvb3RzdHJhcDwvbGl0ZXJhbD4gYWxsb3cgYnVpbGRpbmcgb2YganVz
dAorPGxpdGVyYWw+Y3lnd2luMS5kbGw8L2xpdGVyYWw+IGFuZCA8bGl0ZXJhbD5jcnQwLm88L2xp
dGVyYWw+IGZvciBhIHN0YWdlMgorY29tcGlsZXIsIHdoZW4gYmVpbmcgYnVpbHQgd2l0aCBzdGFn
ZTEgY29tcGlsZXIgd2hpY2ggZG9lcyBub3Qgc3VwcG9ydCBsaW5raW5nCitleGVjdXRhYmxlcyB5
ZXQgKGJlY2F1c2UgdGhvc2UgZmlsZXMgYXJlIG1pc3NpbmcpLgorPC9wYXJhPgorCiA8IS0tIElm
IHlvdSB3YW50IHRvIHJ1biB0aGUgdGVzdHMgPGxpdGVyYWw+YnVzeWJveDwvbGl0ZXJhbD4gYW5k
Ci0gICAgIDxsaXRlcmFsPmN5Z3V0aWxzLWV4dHJhPGxpdGVyYWw+IGFyZSBhbHNvIHJlcXVpcmVk
LiAtLT4KKyAgICAgPGxpdGVyYWw+Y3lndXRpbHMtZXh0cmE8L2xpdGVyYWw+IGFyZSBhbHNvIHJl
cXVpcmVkLiAtLT4KIAogPHBhcmE+CiBCdWlsZGluZyB0aGUgZG9jdW1lbnRhdGlvbiBhbHNvIHJl
cXVpcmVzIHRoZSA8bGl0ZXJhbD5kYmxhdGV4PC9saXRlcmFsPiwKLS0gCjIuNTAuMS52ZnMuMC4w
Cgo=

--_002_DB9PR83MB0923F0FF53C98FB27E03C376925DADB9PR83MB0923EURP_--

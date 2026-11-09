Return-Path: <SRS0=DBxI=I6=hotmail.com=safmswork@sourceware.org>
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn190130003.outbound.protection.outlook.com [IPv6:2a01:111:f403:d111::3])
	by sourceware.org (Postfix) with ESMTPS id F1BF94B920D3
	for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2026 22:14:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F1BF94B920D3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F1BF94B920D3
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:d111::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1794262475; cv=pass;
	b=fbXEQ9U9Y0PPvwgLhAOz7d9k74Zvp6gwug6eO20duQlKlC7SKthlZHCmTgAYuhsD9xXY0rVrjrD5/xT79L5u5TEzYgUTYkNGU9g0F8QTTRFo6nLPsb8GI15eZ0abRfceU8j6hUE8AeiftU6sGcikEfQSUO6Q993UOmIWmod937k=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794262475; c=relaxed/simple;
	bh=aA2l6IHtJ8Nw5Spi9bvFCKS0pwGXtur4WuKqHTR819g=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=kgPyeMLdzfF1O1XJRKlSnfsTl/ptvDlSe8Vnr0S/Gmp/1+9/6srvuDLczd/ipKQSei7R0XWIl17lNUV2y0wDVThRN2jHl1cB2sYEv3kIsHIB9/v5JQcN6msPWaj5glHXVH7843FJaTsJeiwkTDFQwQ5yXzaJfXzxfhKitp+5Gxo=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=chqg98Vh
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F1BF94B920D3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=chqg98Vh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTItY5aI5Lkzr6kXlYFkJk3TlLsGVzT+qXZGg4LYjeuyedkwgaoRcvb+SBie8a1KWGQpSJkUOwWUKGgretu1I1D6K7e2LfU/x8SxoNxf0GrFCLoc/MVZkIg04rOq1b/1tIlnbOVKO8OqsrdrBTH68jAnsICrmmaabmr473G98GfXeM/7gFxxVt0URS+c03G22JEKfrFsAfZZ6W2GXdpBK6yhEHTkCwr84H4kPdbYKM5W9D+v54RFe7r23YUz/rdlUqNkdpUjfS+jHwwtuFsR+1dD4FRA879pFWlKoDMLlRq6CCOyGuq1h5j3hl3CCS+grvRQFFaTs/Z1XC1COVjGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OhalXEtg5EiLi5VIEfioQYGZ/9ooG6OSpPmHbSMWEg=;
 b=J5P0DaOrg87838Vog4nUU9/w9OZChrYoUNOImujDOgcl0MXUR4/DJQ3Y4YWazf4uTLCvWY894PRA+NQGm3TesERFK4IGWWR9gDvIL7CC+52lwOyg9kdkyjMScLRjFHMK8zsN8Yt/puV9Llo/D3Sox7932Ktjp6bVtNg9uWZbZ8EGBTHhiIVm8D172gCJA/0NP5ifsuD8FE1AQSyPXpGKkVDFvfXDee8/zF/w0EerpIRwt7w3xPtXFQaGeZphT/7TjAQnBqWLSLcZapE3TKeydE1TKPVC8eNALd85ImOE/qR40BxjCCiOy4rRCr0YPLrvd49KUiYS1E7yGtlHbWB3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OhalXEtg5EiLi5VIEfioQYGZ/9ooG6OSpPmHbSMWEg=;
 b=chqg98VhAPRdXcaKu9jzUjwxhDMKdGMCKt+ZwTcTvqDLS2+G332NR69w1IZIjPs44PP4vkN/oi2iP44CvGSI6WZtDV1Psg8zuFXR1nCKaPPKwSEu4sWGxQ//lYxZKqerJZq+u/z5r055HNqXMv20m/v7G/io5aGejRkQqvQI+ngB0cYzfzOuXpDexS6X9XuEJZI5lLJKH3aTXZRH3vunBWxChdw6TXpjA8fP4SqMzM8X/bwkzCj72QBCkhnvScHE3MZSh6h9/Ul+ZEy/v2JWgbZ8O/zT/J/W6Vnqe+onQOHRB7ye7i3N7XyKjRL94zbFv2gMgZ21rLKEHM5H+5UN4A==
Received: from BN8PR19MB2434.namprd19.prod.outlook.com (2603:10b6:408:9c::17)
 by DS2PR19MB9243.namprd19.prod.outlook.com (2603:10b6:8:2d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 22:14:32 +0000
Received: from BN8PR19MB2434.namprd19.prod.outlook.com
 ([fe80::f64b:eb79:a6fe:e2d]) by BN8PR19MB2434.namprd19.prod.outlook.com
 ([fe80::f64b:eb79:a6fe:e2d%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 22:14:32 +0000
From: Safet Hrbinic <safmswork@hotmail.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Subject: Fixing cygwin DLL initialization in AppContainer Process
Thread-Topic: Fixing cygwin DLL initialization in AppContainer Process
Thread-Index: AQHdcJTcokbc8ToT3E2NW4qFo6euIw==
Date: Mon, 9 Nov 2026 22:14:32 +0000
Message-ID:
 <BN8PR19MB24340B09A742AE4567DD45AAA4732@BN8PR19MB2434.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB2434:EE_|DS2PR19MB9243:EE_
x-ms-office365-filtering-correlation-id: f60f90f8-65ad-4371-cb0a-08df3eaed4a1
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|31061999003|25010399006|24021099003|8062599012|41001999006|51005399006|8060799015|15080799012|19110799012|15030799006|10035399007|40105399003|1602099012|102099032|440099028|3412199025|4302099013;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QWvFv7RbKxn3sPOShFlYpKmjrrAks9lgE95wLPZORRbpMKBWSuCso8c+xR?=
 =?iso-8859-1?Q?WNW6bNilD02lPcyUtUjaOMOSYMmF0mL3buP+z24MJZ16YaDE+JG4LEtG+W?=
 =?iso-8859-1?Q?82qAMsPVPD3b4Nru0rOmjq1qONAlx9Sm4foLQ6//gILuxCWRZ8n6cFcSzH?=
 =?iso-8859-1?Q?lypAwe6iHvVP/VtHAqKj+IqWt/gqe8r6YyiZ3u9Xy44KNf7/K1svVR6NBm?=
 =?iso-8859-1?Q?0hGL6K3CYowrv0/uAcqciEPBR56hI9cQgJC0S5cGK1QDb4od9EI+dZ45C2?=
 =?iso-8859-1?Q?QzpG5QfuOpw/AJnkO9IKMZtGqlaFpMXMsBSjiBUhVJFiloRc3eEY5KcKq0?=
 =?iso-8859-1?Q?zR5VJbNlPLgrYmy4vm5eKBN56z9iD6Ii8Pfh+4WETwnP4sVVsl4P2FkE0j?=
 =?iso-8859-1?Q?treVRH3I/nCU1GWXTIK+qsrgOIByFrlBjdWZPx/ZYmu4krK1Ub9Yg6O9ZR?=
 =?iso-8859-1?Q?pLqR5dhwA+/5X5p4MKPM5FUaJMU0VZHkcGIER+VODp3S39DPHL5RVvsngO?=
 =?iso-8859-1?Q?cMN0vQEhNRhc8Il290q+iVOB/Gklu7vUcAqMEdx2L++gotbfI/IJTNxJsf?=
 =?iso-8859-1?Q?7nDpIRswo2dr9MG98XbbyDnqrrbSP7ALuDVH8Cve/FcNy4+gX5tiKl9BSv?=
 =?iso-8859-1?Q?omcwgsI2vMzICDoilFRkJ0I7ZsxEnKblKiYAom2fi0xeDOAryjfkiQSopi?=
 =?iso-8859-1?Q?TBAehdGb7/6T47HbaLuR8grGKFzHZ/JTRVE0qYof/RFQMyM7KVvBOtuVbL?=
 =?iso-8859-1?Q?u5SvXm8T7PHjZh6+LNVIOeZbjTV4RLICzi3z8ir7ScxVUnWMPSWXHTE+ka?=
 =?iso-8859-1?Q?8JbjOccz99enw8nExbkg596ze/q5Hp9VI3nQ9eRYclU1+P5Y+24PA0cVsw?=
 =?iso-8859-1?Q?UDJoZNvOmbwtoVeaF4N1MzCQZp4EsLg7w0Qtl8i1U0YMrRiQXv3jGujK1Q?=
 =?iso-8859-1?Q?HNPlQra5HrDc0gjPXo090cLpLiPzYtHXghJNz2iJeus/4jul39Pr0kHOvh?=
 =?iso-8859-1?Q?KLAB35Dsc/N1EIsUhwswkkZ33qJbTqLNEQEXCnWHvogU0EHOWRrpkbrymM?=
 =?iso-8859-1?Q?9CRLxkQtdIA0ybSpMoALEViRMVbmgfaXFba9x0BEgsWD?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dLir0gsQu6AZYpqR5jDb2/gQgdzo7wpcHRpdGXWFi6DFNnKj+fi8+xuY+q?=
 =?iso-8859-1?Q?UaG+5f1sOF/q8iZvnUydB+sAouXeIbRrVoUoWnz1iQBWClR1SqAVQtk9le?=
 =?iso-8859-1?Q?EuiLP55Gv0wPEqbB6fFjkaF/Qvc13Ij3T0Xo+CV0yJJwcEJPoqlObKA3pB?=
 =?iso-8859-1?Q?CI4r6Pq6RtYI/Hdg5JnyhLQxGI5s/NnH+EiOnMnKUCCDbkPGyQ7stSQEM1?=
 =?iso-8859-1?Q?4L0BPbvKwClc++kYf9TOpIIXQeWD8eZUCUOGUa01qBcpzs2s84E8g22xAK?=
 =?iso-8859-1?Q?CYz+uwtMjLot5521Db4ZPzFN6BWaJVtPrc2tub14siU6SpvmWKeKCbbj2B?=
 =?iso-8859-1?Q?VJGLjxzzYEcN+gEqcUjfCcnCDk1IAwh5aGr8nCAItrJnet4qGe/6tSW21Q?=
 =?iso-8859-1?Q?/WQK8TbAYhDCaqMiAhuVhLvzkKcxsm9TRLMxNpJuG93hcymbMwO44G60Ye?=
 =?iso-8859-1?Q?DBgVT7hzqLe5JjkCq10vmgga3kpql2oSnzMA4BGx1vdPPtXvG4lujEE0Ru?=
 =?iso-8859-1?Q?vP8YI9FbihadYAVY6W4Rp9ys1aYA7Jn/LKOcyBOP08cv26lllVmhWVLvtx?=
 =?iso-8859-1?Q?odkxR81IqiPEhEZ6effZYJIoju0i4AkGcj968ljt14IG0b0MUzBGhNrExq?=
 =?iso-8859-1?Q?SVrzJXUWums/KZeaWYmgnIPcBxNigc1xXcsKpxdT3hxJkBmPwosFjeoZ1Z?=
 =?iso-8859-1?Q?FSfIgM9vkKOtSR9b+XzerxJalfXeh0yHy2rYebWiTVKvdR+fqsbHsQeBtp?=
 =?iso-8859-1?Q?v+wHEAjVEYj9u8F0oASFLCtxZEGZyKjPigfOLr37nQw+YKWZ2A3HPiWfrP?=
 =?iso-8859-1?Q?N1w+k4QEpF5GJIbkO11G5BfjrKSCRCWMmj2kaYpMhpJbeYVdgSUTHf8Lti?=
 =?iso-8859-1?Q?qy7saPzZjaNDy2ver/HYD2i0T3PsjYOM4tZ0BREajchQUyHvzhim1OeOJZ?=
 =?iso-8859-1?Q?cmigxV3qFaipS1GrevU63a8W3J1D0+AkUvHaXDBlDFLx+wx43hw38OS9ys?=
 =?iso-8859-1?Q?eAsTCuBMjvaBfmwUo3qsXnPdeeN9yymjQJR4QmLrDKxpwoG6hd1zs+zCGj?=
 =?iso-8859-1?Q?a5lDbXNoteM7OwEycxtXVT9i9OdwLtodiNTEM1CrVsnTX2w/TOqG6nWq5v?=
 =?iso-8859-1?Q?qVbOuYhnSVTkTcbJBzFKQhQi/ZRlajJoXLq9hbIDCKrQzI+Wnd7ORWBRKf?=
 =?iso-8859-1?Q?l/XQ7rxX+S1XhMW4yCiPO2+FCN/U3Qi4AdX1FhbpBGR7J3ewGiKOEWtrn7?=
 =?iso-8859-1?Q?cZJbK8un/bo4mIyeRdC8+lHKs5n5j+RF78R+jTgMyAYMYDaEwtx8w4oSff?=
 =?iso-8859-1?Q?vK/ulgqNc+e2P/01AgePG1lq+rqmIQmnQbfQDOARGtAolSlJKWg5sqV1MN?=
 =?iso-8859-1?Q?DeZCuMex4/pxENIgQLjDFo14bBlQxlQcID7v+PeNDQV4pFy7/J698=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB2434.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f60f90f8-65ad-4371-cb0a-08df3eaed4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 22:14:32.2491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9243
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GB_MSAUTHSOURCE_NORTHAM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Greetings! There is an existing issue in the cygwin.dll where initializatio=
n of the DLL fails if it is running in an AppContainer process. The failure=
 happens in winsup\cygwin\mm\shared.cc , where the code calls NtCreateDirec=
toryObject using the global \\BaseNamedObjects namespace. AppContainer proc=
esses are not allowed to create directory objects in the global namespaces,=
 and so this fails.=0A=
=0A=
The fix at a high level is simple. AppContainer processes are given their o=
wn private namespace to create directory objects within. So the change is s=
imply:=0A=
if(AppContainerProcess())=0A=
{=0A=
  appContainerNamespace =3D GetAppContainerNamespace=0A=
  NtCreateDirectoryObject(appContainerNamespace)=0A=
} else=0A=
{=0A=
 // do as before change=0A=
 NtCreateDirectoryObject(\\BaseNamedObjects\...)=0A=
}=0A=
=0A=
Also added automated coverage using a native launcher and a Cygwin-linked c=
hild which verifies its AppContainer token and build-tree runtime, then tes=
ts startup and flock locking. Include the socket event-sharing regression t=
est from the branch.=0A=
=0A=
Note: I've never contributed to open source before so please let me know if=
 there is anything else I need to add/remove from this email :)=0A=
=0A=
Thanks=0A=
-Safet Hrbinic=0A=
=0A=
I provide my changes to the Cygwin sources in this patch under the 2-clause=
 BSD license.=0A=
Signed-off-by: Safet Hrbinic <sahrbini@microsoft.com>=0A=
---=0A=
 winsup/cygwin/autoload.cc                     |   1 +=0A=
 winsup/cygwin/environ.cc                      |   1 +=0A=
 winsup/cygwin/fhandler/pipe.cc                |  27 +-=0A=
 winsup/cygwin/fhandler/socket_inet.cc         |  45 +-=0A=
 winsup/cygwin/kernel32.cc                     |  44 +-=0A=
 winsup/cygwin/local_includes/fhandler.h       |   1 +=0A=
 winsup/cygwin/local_includes/security.h       |   8 +-=0A=
 winsup/cygwin/local_includes/shared_info.h    |   2 +=0A=
 winsup/cygwin/mm/shared.cc                    | 145 +++++=0A=
 winsup/cygwin/sec/helper.cc                   | 118 +++-=0A=
 winsup/cygwin/syscalls.cc                     |   2 +-=0A=
 winsup/cygwin/wincap.cc                       |   2 +-=0A=
 winsup/testsuite/Makefile.am                  |  12 +=0A=
 winsup/testsuite/mingw/Makefile.am            |   8 +-=0A=
 .../testsuite/mingw/appcontainer-launcher.cc  | 579 ++++++++++++++++++=0A=
 .../testsuite/winsup.api/appcontainer-child.c | 141 +++++=0A=
 .../winsup.api/socket-event-sharing.c         | 142 +++++=0A=
 17 files changed, 1253 insertions(+), 25 deletions(-)=0A=
 create mode 100644 winsup/testsuite/mingw/appcontainer-launcher.cc=0A=
 create mode 100644 winsup/testsuite/winsup.api/appcontainer-child.c=0A=
 create mode 100644 winsup/testsuite/winsup.api/socket-event-sharing.c=0A=
=0A=
diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc=0A=
index 7054511b6..58714ef5b 100644=0A=
--- a/winsup/cygwin/autoload.cc=0A=
+++ b/winsup/cygwin/autoload.cc=0A=
@@ -597,6 +597,7 @@ LoadDLLfuncEx (ResizePseudoConsole, kernel32, 1)=0A=
 LoadDLLfunc (QueryInterruptTime, KernelBase)=0A=
 LoadDLLfunc (QueryInterruptTimePrecise, KernelBase)=0A=
 LoadDLLfunc (QueryUnbiasedInterruptTimePrecise, KernelBase)=0A=
+LoadDLLfunc (GetAppContainerNamedObjectPath, KernelBase)=0A=
 LoadDLLfuncEx (SetThreadDescription, KernelBase, 1)=0A=
 LoadDLLfunc (VirtualAlloc2, KernelBase)=0A=
 =0A=
diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc=0A=
index 956a04a0c..94963ecbb 100644=0A=
--- a/winsup/cygwin/environ.cc=0A=
+++ b/winsup/cygwin/environ.cc=0A=
@@ -956,6 +956,7 @@ static NO_COPY spenv spenvs[] =3D=0A=
 #ifdef DEBUGGING=0A=
   {NL ("CYGWIN_DEBUG=3D"), false, true, NULL},=0A=
 #endif=0A=
+  {NL ("CYGWIN_TESTING=3D"), false, true, NULL},=0A=
   {NL ("HOMEDRIVE=3D"), false, false, &cygheap_user::env_homedrive},=0A=
   {NL ("HOMEPATH=3D"), false, false, &cygheap_user::env_homepath},=0A=
   {NL ("LOGONSERVER=3D"), false, false, &cygheap_user::env_logsrv},=0A=
diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.c=
c=0A=
index 2312688e1..cefaabe30 100644=0A=
--- a/winsup/cygwin/fhandler/pipe.cc=0A=
+++ b/winsup/cygwin/fhandler/pipe.cc=0A=
@@ -817,8 +817,16 @@ fhandler_pipe::create (LPSECURITY_ATTRIBUTES sa_ptr, P=
HANDLE r, PHANDLE w,=0A=
     psize =3D DEFAULT_PIPEBUFSIZE;=0A=
 =0A=
   char pipename[MAX_PATH];=0A=
-  size_t len =3D __small_sprintf (pipename, PIPE_INTRO "%S-",=0A=
-				      &cygheap->installation_key);=0A=
+  size_t len;=0A=
+  if (appcontainer_sid ())=0A=
+    {=0A=
+      /* AppContainer named pipes must be scoped to the LOCAL namespace. *=
/=0A=
+      len =3D __small_sprintf (pipename, "\\\\.\\pipe\\LOCAL\\cygwin-%S-",=
=0A=
+			     &cygheap->installation_key);=0A=
+    }=0A=
+  else=0A=
+    len =3D __small_sprintf (pipename, PIPE_INTRO "%S-",=0A=
+			   &cygheap->installation_key);=0A=
   DWORD pipe_mode =3D PIPE_READMODE_BYTE | PIPE_REJECT_REMOTE_CLIENTS;=0A=
   if (!name)=0A=
     pipe_mode |=3D pipe_byte ? PIPE_TYPE_BYTE : PIPE_TYPE_MESSAGE;=0A=
@@ -1054,9 +1062,18 @@ nt_create (LPSECURITY_ATTRIBUTES sa_ptr, HANDLE &r, =
HANDLE &w, DWORD psize,=0A=
 =0A=
   UNICODE_STRING pipename;=0A=
   WCHAR pipename_buf[MAX_PATH];=0A=
-  size_t len =3D __small_swprintf (pipename_buf, L"%S-%u-",=0A=
-				 &cygheap->installation_key,=0A=
-				 GetCurrentProcessId ());=0A=
+  size_t len;=0A=
+  if (appcontainer_sid ())=0A=
+    {=0A=
+      /* Match the Win32 CreateNamedPipe path above. */=0A=
+      len =3D __small_swprintf (pipename_buf, L"LOCAL\\%S-%u-",=0A=
+			      &cygheap->installation_key,=0A=
+			      GetCurrentProcessId ());=0A=
+    }=0A=
+  else=0A=
+    len =3D __small_swprintf (pipename_buf, L"%S-%u-",=0A=
+			    &cygheap->installation_key,=0A=
+			    GetCurrentProcessId ());=0A=
 =0A=
   access =3D GENERIC_READ | FILE_WRITE_ATTRIBUTES | SYNCHRONIZE;=0A=
 =0A=
diff --git a/winsup/cygwin/fhandler/socket_inet.cc b/winsup/cygwin/fhandler=
/socket_inet.cc=0A=
index 5ed0cb0ec..aadf09111 100644=0A=
--- a/winsup/cygwin/fhandler/socket_inet.cc=0A=
+++ b/winsup/cygwin/fhandler/socket_inet.cc=0A=
@@ -70,12 +70,44 @@=0A=
       ReleaseMutex (wsock_mtx); \=0A=
     }=0A=
 =0A=
-static wsa_event wsa_events[NUM_SOCKS] __attribute__((section (".cygwin_dl=
l_common"), shared));=0A=
+struct wsa_shared_data=0A=
+{=0A=
+  LONG socket_serial_number;=0A=
+  wsa_event events[NUM_SOCKS];=0A=
+};=0A=
 =0A=
-static LONG socket_serial_number __attribute__((section (".cygwin_dll_comm=
on"), shared));=0A=
+static wsa_shared_data NO_COPY *wsa_shared;=0A=
+static HANDLE NO_COPY wsa_shared_h;=0A=
 =0A=
 static HANDLE wsa_slot_mtx;=0A=
 =0A=
+void=0A=
+wsock_init ()=0A=
+{=0A=
+  UNICODE_STRING uname;=0A=
+  OBJECT_ATTRIBUTES attr;=0A=
+  LARGE_INTEGER size =3D { .QuadPart =3D sizeof (wsa_shared_data) };=0A=
+=0A=
+  /* The table and its liveness mutexes must use the same namespace. */=0A=
+  RtlInitUnicodeString (&uname, L"socket-events.1");=0A=
+  InitializeObjectAttributes (&attr, &uname, OBJ_OPENIF,=0A=
+			      get_session_parent_dir (),=0A=
+			      everyone_sd (SECTION_ALL_ACCESS));=0A=
+  NTSTATUS status =3D NtCreateSection (&wsa_shared_h, SECTION_ALL_ACCESS, =
&attr,=0A=
+				    &size, PAGE_READWRITE, SEC_COMMIT, NULL);=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("Couldn't create/open shared socket table: %y", status);=0A=
+  wsa_shared =3D (wsa_shared_data *)=0A=
+    open_shared (NULL, 0, wsa_shared_h, sizeof (wsa_shared_data), SH_JUSTC=
REATE);=0A=
+}=0A=
+=0A=
+void=0A=
+wsock_destroy ()=0A=
+{=0A=
+  UnmapViewOfFile (wsa_shared);=0A=
+  ForceCloseHandle (wsa_shared_h);=0A=
+}=0A=
+=0A=
 static PWCHAR=0A=
 sock_shared_name (PWCHAR buf, LONG num)=0A=
 {=0A=
@@ -86,6 +118,7 @@ sock_shared_name (PWCHAR buf, LONG num)=0A=
 static wsa_event *=0A=
 search_wsa_event_slot (LONG new_serial_number)=0A=
 {=0A=
+  wsa_event *wsa_events =3D wsa_shared->events;=0A=
   WCHAR name[32], searchname[32];=0A=
   UNICODE_STRING uname;=0A=
   OBJECT_ATTRIBUTES attr;=0A=
@@ -185,6 +218,7 @@ get_ext_funcptr (SOCKET sock, void *funcptr)=0A=
 fhandler_socket_wsock::fhandler_socket_wsock () :=0A=
   fhandler_socket (),=0A=
   wsock_events (NULL),=0A=
+  wsock_slot (0),=0A=
   wsock_mtx (NULL),=0A=
   wsock_evt (NULL),=0A=
   status (),=0A=
@@ -211,9 +245,9 @@ fhandler_socket_wsock::init_events ()=0A=
   do=0A=
     {=0A=
       new_serial_number =3D=0A=
-	InterlockedIncrement (&socket_serial_number);=0A=
+	InterlockedIncrement (&wsa_shared->socket_serial_number);=0A=
       if (!new_serial_number)	/* 0 is reserved for global mutex */=0A=
-	InterlockedIncrement (&socket_serial_number);=0A=
+	InterlockedIncrement (&wsa_shared->socket_serial_number);=0A=
       set_ino (new_serial_number);=0A=
       RtlInitUnicodeString (&uname, sock_shared_name (name, new_serial_num=
ber));=0A=
       InitializeObjectAttributes (&attr, &uname, OBJ_INHERIT | OBJ_OPENIF,=
=0A=
@@ -253,6 +287,7 @@ fhandler_socket_wsock::init_events ()=0A=
       NtClose (wsock_mtx);=0A=
       return false;=0A=
     }=0A=
+  wsock_slot =3D wsock_events - wsa_shared->events;=0A=
   if (get_socket_type () =3D=3D SOCK_DGRAM)=0A=
     wsock_events->events =3D FD_WRITE;=0A=
   return true;=0A=
@@ -503,6 +538,7 @@ fhandler_socket_wsock::fixup_before_fork_exec (DWORD wi=
n_pid)=0A=
 void=0A=
 fhandler_socket_wsock::fixup_after_fork (HANDLE parent)=0A=
 {=0A=
+  wsock_events =3D wsa_shared->events + wsock_slot;=0A=
   fork_fixup (parent, wsock_mtx, "wsock_mtx");=0A=
   fork_fixup (parent, wsock_evt, "wsock_evt");=0A=
 =0A=
@@ -533,6 +569,7 @@ fhandler_socket_wsock::fixup_after_fork (HANDLE parent)=
=0A=
 void=0A=
 fhandler_socket_wsock::fixup_after_exec ()=0A=
 {=0A=
+  wsock_events =3D wsa_shared->events + wsock_slot;=0A=
   if (need_fixup_before () && !close_on_exec ())=0A=
     fixup_after_fork (NULL);	/* No parent handle required. */=0A=
 }=0A=
diff --git a/winsup/cygwin/kernel32.cc b/winsup/cygwin/kernel32.cc=0A=
index f07f80d59..25d50f559 100644=0A=
--- a/winsup/cygwin/kernel32.cc=0A=
+++ b/winsup/cygwin/kernel32.cc=0A=
@@ -19,6 +19,19 @@ details. */=0A=
 #include "winf.h"=0A=
 #include "sys/cygwin.h"=0A=
 =0A=
+static bool=0A=
+has_non_null_dacl (PSECURITY_DESCRIPTOR psd)=0A=
+{=0A=
+  BOOLEAN present;=0A=
+  BOOLEAN defaulted;=0A=
+  PACL dacl;=0A=
+=0A=
+  return psd=0A=
+	 && NT_SUCCESS (RtlGetDaclSecurityDescriptor (psd, &present, &dacl,=0A=
+						      &defaulted))=0A=
+	 && present && dacl;=0A=
+}=0A=
+=0A=
 /* Implement CreateEvent/OpenEvent so that named objects are always create=
d in=0A=
    Cygwin shared object namespace. */=0A=
 =0A=
@@ -39,10 +52,13 @@ CreateEventW (LPSECURITY_ATTRIBUTES lpEventAttributes, =
BOOL bManualReset,=0A=
       RtlInitUnicodeString (&uname, lpName);=0A=
       flags |=3D OBJ_OPENIF | OBJ_CASE_INSENSITIVE;=0A=
     }=0A=
+  PSECURITY_DESCRIPTOR psd=0A=
+    =3D lpEventAttributes ? lpEventAttributes->lpSecurityDescriptor : NULL=
;=0A=
+  if (lpName && appcontainer_sid () && !has_non_null_dacl (psd))=0A=
+    psd =3D appcontainer_sd (EVENT_ALL_ACCESS);=0A=
   InitializeObjectAttributes (&attr, lpName ? &uname : NULL, flags,=0A=
 			      lpName ? get_shared_parent_dir () : NULL,=0A=
-			      lpEventAttributes=0A=
-			      ? lpEventAttributes->lpSecurityDescriptor : NULL);=0A=
+			      psd);=0A=
   status =3D NtCreateEvent (&evt, EVENT_ALL_ACCESS, &attr,=0A=
 			  bManualReset ? NotificationEvent=0A=
 				       : SynchronizationEvent,=0A=
@@ -133,10 +149,13 @@ CreateMutexW (LPSECURITY_ATTRIBUTES lpMutexAttributes=
, BOOL bInitialOwner,=0A=
       RtlInitUnicodeString (&uname, lpName);=0A=
       flags |=3D OBJ_OPENIF | OBJ_CASE_INSENSITIVE;=0A=
     }=0A=
+  PSECURITY_DESCRIPTOR psd=0A=
+    =3D lpMutexAttributes ? lpMutexAttributes->lpSecurityDescriptor : NULL=
;=0A=
+  if (lpName && appcontainer_sid () && !has_non_null_dacl (psd))=0A=
+    psd =3D appcontainer_sd (MUTEX_ALL_ACCESS);=0A=
   InitializeObjectAttributes (&attr, lpName ? &uname : NULL, flags,=0A=
 			      lpName ? get_shared_parent_dir () : NULL,=0A=
-			      lpMutexAttributes=0A=
-			      ? lpMutexAttributes->lpSecurityDescriptor : NULL);=0A=
+			      psd);=0A=
   status =3D NtCreateMutant (&mtx, MUTEX_ALL_ACCESS, &attr, bInitialOwner)=
;=0A=
   if (!NT_SUCCESS (status))=0A=
     {=0A=
@@ -223,11 +242,14 @@ CreateSemaphoreW (LPSECURITY_ATTRIBUTES lpSemaphoreAt=
tributes,=0A=
       RtlInitUnicodeString (&uname, lpName);=0A=
       flags |=3D OBJ_OPENIF | OBJ_CASE_INSENSITIVE;=0A=
     }=0A=
+  PSECURITY_DESCRIPTOR psd=0A=
+    =3D lpSemaphoreAttributes=0A=
+      ? lpSemaphoreAttributes->lpSecurityDescriptor : NULL;=0A=
+  if (lpName && appcontainer_sid () && !has_non_null_dacl (psd))=0A=
+    psd =3D appcontainer_sd (SEMAPHORE_ALL_ACCESS);=0A=
   InitializeObjectAttributes (&attr, lpName ? &uname : NULL, flags,=0A=
 			      lpName ? get_shared_parent_dir () : NULL,=0A=
-			      lpSemaphoreAttributes=0A=
-			      ? lpSemaphoreAttributes->lpSecurityDescriptor=0A=
-			      : NULL);=0A=
+			      psd);=0A=
   status =3D NtCreateSemaphore (&sem, SEMAPHORE_ALL_ACCESS, &attr,=0A=
 			      lInitialCount, lMaximumCount);=0A=
   if (!NT_SUCCESS (status))=0A=
@@ -334,11 +356,13 @@ CreateFileMappingW (HANDLE hFile, LPSECURITY_ATTRIBUT=
ES lpAttributes,=0A=
       RtlInitUnicodeString (&uname, lpName);=0A=
       flags |=3D OBJ_OPENIF | OBJ_CASE_INSENSITIVE;=0A=
     }=0A=
+  PSECURITY_DESCRIPTOR psd=0A=
+    =3D lpAttributes ? lpAttributes->lpSecurityDescriptor : NULL;=0A=
+  if (lpName && appcontainer_sid () && !has_non_null_dacl (psd))=0A=
+    psd =3D appcontainer_sd (SECTION_ALL_ACCESS);=0A=
   InitializeObjectAttributes (&attr, lpName ? &uname : NULL, flags,=0A=
 			      lpName ? get_shared_parent_dir () : NULL,=0A=
-			      lpAttributes=0A=
-			      ? lpAttributes->lpSecurityDescriptor=0A=
-			      : NULL);=0A=
+			      psd);=0A=
   if (!(attribs & (SEC_RESERVE | SEC_COMMIT)))=0A=
     attribs |=3D SEC_COMMIT;=0A=
   if (hFile =3D=3D INVALID_HANDLE_VALUE)=0A=
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_=
includes/fhandler.h=0A=
index d37c604f2..fa3ad24d2 100644=0A=
--- a/winsup/cygwin/local_includes/fhandler.h=0A=
+++ b/winsup/cygwin/local_includes/fhandler.h=0A=
@@ -659,6 +659,7 @@ class fhandler_socket_wsock: public fhandler_socket=0A=
 =0A=
  protected:=0A=
   wsa_event *wsock_events;=0A=
+  unsigned int wsock_slot;=0A=
   HANDLE wsock_mtx;=0A=
   HANDLE wsock_evt;=0A=
   bool init_events ();=0A=
diff --git a/winsup/cygwin/local_includes/security.h b/winsup/cygwin/local_=
includes/security.h=0A=
index b31edfe26..9f5106b59 100644=0A=
--- a/winsup/cygwin/local_includes/security.h=0A=
+++ b/winsup/cygwin/local_includes/security.h=0A=
@@ -48,7 +48,7 @@ bool check_token_membership (PSID);=0A=
 #define MAX_DACL_LEN(n) (sizeof (ACL) \=0A=
 		   + (n) * (sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD) \=0A=
 			    + SECURITY_MAX_SID_SIZE))=0A=
-#define SD_MIN_SIZE (sizeof (SECURITY_DESCRIPTOR) + MAX_DACL_LEN (1))=0A=
+#define SD_MIN_SIZE (sizeof (SECURITY_DESCRIPTOR) + MAX_DACL_LEN (2))=0A=
 #define ACL_MAXIMUM_SIZE 65532	/* Yeah, right.  64K - sizeof (DWORD). */=
=0A=
 #define SD_MAXIMUM_SIZE 65536=0A=
 #define NO_SID ((PSID)NULL)=0A=
@@ -522,6 +522,12 @@ extern PSECURITY_DESCRIPTOR _recycler_sd (void *buf, b=
ool users, bool dir);=0A=
 extern PSECURITY_DESCRIPTOR _everyone_sd (void *buf, ACCESS_MASK access);=
=0A=
 #define everyone_sd(access)	(_everyone_sd (alloca (SD_MIN_SIZE), (access))=
)=0A=
 =0A=
+extern PSID appcontainer_sid ();=0A=
+extern PSECURITY_DESCRIPTOR _appcontainer_sd (void *buf, ACCESS_MASK acces=
s);=0A=
+#define appcontainer_sd(access) \=0A=
+  (_appcontainer_sd (alloca (sizeof (SECURITY_DESCRIPTOR) \=0A=
+			     + MAX_DACL_LEN (3)), (access)))=0A=
+=0A=
 #define sec_none_cloexec(f) (((f) & O_CLOEXEC ? &sec_none_nih : &sec_none)=
)=0A=
 =0A=
 extern bool sec_acl (PACL acl, bool original, bool admins, PSID sid1 =3D N=
O_SID,=0A=
diff --git a/winsup/cygwin/local_includes/shared_info.h b/winsup/cygwin/loc=
al_includes/shared_info.h=0A=
index 4316717a9..f826a3b95 100644=0A=
--- a/winsup/cygwin/local_includes/shared_info.h=0A=
+++ b/winsup/cygwin/local_includes/shared_info.h=0A=
@@ -79,6 +79,8 @@ enum shared_locations=0A=
 =0A=
 void memory_init ();=0A=
 void shared_destroy ();=0A=
+void wsock_init ();=0A=
+void wsock_destroy ();=0A=
 =0A=
 #define shared_align_past(p) \=0A=
   ((char *) (system_info.dwAllocationGranularity * \=0A=
diff --git a/winsup/cygwin/mm/shared.cc b/winsup/cygwin/mm/shared.cc=0A=
index 7977df382..2544b74d4 100644=0A=
--- a/winsup/cygwin/mm/shared.cc=0A=
+++ b/winsup/cygwin/mm/shared.cc=0A=
@@ -21,6 +21,8 @@ details. */=0A=
 #include "cygwin_version.h"=0A=
 #include "memory_layout.h"=0A=
 #include "spinlock.h"=0A=
+#include "tls_pbuf.h"=0A=
+#include <securityappcontainer.h>=0A=
 #include <alloca.h>=0A=
 #include <wchar.h>=0A=
 =0A=
@@ -33,6 +35,123 @@ HANDLE NO_COPY cygwin_user_h;=0A=
    NT namespace used to implement global objects including shared memory. =
*/=0A=
 =0A=
 static HANDLE NO_COPY shared_parent_dir;=0A=
+static HANDLE NO_COPY appcontainer_parent_dir;=0A=
+=0A=
+static bool=0A=
+is_appcontainer_process ()=0A=
+{=0A=
+  return appcontainer_sid () !=3D NULL;=0A=
+}=0A=
+=0A=
+static HANDLE=0A=
+get_appcontainer_parent_dir ()=0A=
+{=0A=
+  if (!appcontainer_parent_dir)=0A=
+    {=0A=
+      tmp_pathbuf tp;=0A=
+      PWCHAR path =3D tp.w_get ();=0A=
+      if (__in_forkee =3D=3D FORKING)=0A=
+	{=0A=
+	  WCHAR sidbuf[UNLEN + 1];=0A=
+	  UNICODE_STRING sid;=0A=
+	  RtlInitEmptyUnicodeString (&sid, sidbuf, sizeof sidbuf);=0A=
+	  NTSTATUS status=0A=
+	    =3D RtlConvertSidToUnicodeString (&sid, appcontainer_sid (), FALSE);=
=0A=
+	  if (!NT_SUCCESS (status))=0A=
+	    api_fatal ("RtlConvertSidToUnicodeString(AppContainer): %y",=0A=
+		       status);=0A=
+=0A=
+	  PROCESS_SESSION_INFORMATION psi;=0A=
+	  status =3D NtQueryInformationProcess (NtCurrentProcess (),=0A=
+					      ProcessSessionInformation,=0A=
+					      &psi, sizeof psi, NULL);=0A=
+	  if (!NT_SUCCESS (status))=0A=
+	    api_fatal ("NtQueryInformationProcess"=0A=
+		       "(ProcessSessionInformation): %y", status);=0A=
+=0A=
+	  __small_swprintf (path,=0A=
+			    L"\\Sessions\\%u\\AppContainerNamedObjects\\%S",=0A=
+			    psi.SessionId, &sid);=0A=
+	}=0A=
+      else=0A=
+	{=0A=
+	  ULONG required =3D 0;=0A=
+	  GetAppContainerNamedObjectPath (hProcToken, NULL, 0, NULL,=0A=
+					  &required);=0A=
+	  if (!required || required > NT_MAX_PATH)=0A=
+	    api_fatal ("GetAppContainerNamedObjectPath(size %u), %E",=0A=
+		       required);=0A=
+=0A=
+	  ULONG returned =3D 0;=0A=
+	  if (!GetAppContainerNamedObjectPath (hProcToken, NULL, required,=0A=
+					       path, &returned))=0A=
+	    api_fatal ("GetAppContainerNamedObjectPath, %E");=0A=
+	  if (!returned || returned > required=0A=
+	      || wcsnlen (path, required) >=3D required)=0A=
+	    api_fatal ("GetAppContainerNamedObjectPath returned invalid length "=
=0A=
+		       "%u (buffer length %u)", returned, required);=0A=
+=0A=
+	  if (path[0] !=3D L'\\')=0A=
+	    {=0A=
+	      PROCESS_SESSION_INFORMATION psi;=0A=
+	      NTSTATUS status=0A=
+		=3D NtQueryInformationProcess (NtCurrentProcess (),=0A=
+					     ProcessSessionInformation,=0A=
+					     &psi, sizeof psi, NULL);=0A=
+	      if (!NT_SUCCESS (status))=0A=
+		api_fatal ("NtQueryInformationProcess"=0A=
+			   "(ProcessSessionInformation): %y", status);=0A=
+=0A=
+	      size_t path_len =3D wcslen (path);=0A=
+	      if (path_len + 32 >=3D NT_MAX_PATH)=0A=
+		api_fatal ("AppContainer named object path is too long");=0A=
+	      PWCHAR absolute_path =3D tp.w_get ();=0A=
+	      __small_swprintf (absolute_path, L"\\Sessions\\%u\\%W",=0A=
+				psi.SessionId, path);=0A=
+	      path =3D absolute_path;=0A=
+	    }=0A=
+	}=0A=
+=0A=
+      UNICODE_STRING uname;=0A=
+      OBJECT_ATTRIBUTES attr;=0A=
+      RtlInitUnicodeString (&uname, path);=0A=
+      InitializeObjectAttributes (&attr, &uname, OBJ_CASE_INSENSITIVE, NUL=
L,=0A=
+				  NULL);=0A=
+      NTSTATUS status=0A=
+	=3D NtOpenDirectoryObject (&appcontainer_parent_dir,=0A=
+				 CYG_SHARED_DIR_ACCESS, &attr);=0A=
+      if (!NT_SUCCESS (status))=0A=
+	api_fatal ("NtOpenDirectoryObject(%S): %y", &uname, status);=0A=
+    }=0A=
+  return appcontainer_parent_dir;=0A=
+}=0A=
+=0A=
+static HANDLE=0A=
+create_appcontainer_dir (HANDLE root, PCWSTR name)=0A=
+{=0A=
+  HANDLE dir;=0A=
+  UNICODE_STRING uname;=0A=
+  OBJECT_ATTRIBUTES attr;=0A=
+  RtlInitUnicodeString (&uname, name);=0A=
+  NTSTATUS status;=0A=
+  if (__in_forkee =3D=3D FORKING)=0A=
+    {=0A=
+      InitializeObjectAttributes (&attr, &uname, OBJ_CASE_INSENSITIVE, roo=
t,=0A=
+				  NULL);=0A=
+      status =3D NtOpenDirectoryObject (&dir, CYG_SHARED_DIR_ACCESS, &attr=
);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      InitializeObjectAttributes (&attr, &uname, OBJ_OPENIF, root,=0A=
+				  appcontainer_sd (CYG_SHARED_DIR_ACCESS));=0A=
+      status =3D NtCreateDirectoryObject (&dir, CYG_SHARED_DIR_ACCESS, &at=
tr);=0A=
+    }=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("%sDirectoryObject(%S): %y",=0A=
+	       __in_forkee =3D=3D FORKING ? "NtOpen" : "NtCreate",=0A=
+	       &uname, status);=0A=
+  return dir;=0A=
+}=0A=
 =0A=
 HANDLE=0A=
 get_shared_parent_dir ()=0A=
@@ -43,6 +162,18 @@ get_shared_parent_dir ()=0A=
 =0A=
   if (!shared_parent_dir)=0A=
     {=0A=
+      if (is_appcontainer_process ())=0A=
+	{=0A=
+	  WCHAR bnoname[MAX_PATH];=0A=
+	  __small_swprintf (bnoname, L"%s%s-%S",=0A=
+			    cygwin_version.shared_id,=0A=
+			    _cygwin_testing ? cygwin_version.dll_build_date : "",=0A=
+			    &cygheap->installation_key);=0A=
+	  shared_parent_dir=0A=
+	    =3D create_appcontainer_dir (get_appcontainer_parent_dir (), bnoname)=
;=0A=
+	  return shared_parent_dir;=0A=
+	}=0A=
+=0A=
       WCHAR bnoname[MAX_PATH];=0A=
       __small_swprintf (bnoname, L"\\BaseNamedObjects\\%s%s-%S",=0A=
 			cygwin_version.shared_id,=0A=
@@ -70,6 +201,18 @@ get_session_parent_dir ()=0A=
 =0A=
   if (!session_parent_dir)=0A=
     {=0A=
+      if (is_appcontainer_process ())=0A=
+	{=0A=
+	  WCHAR bnoname[MAX_PATH];=0A=
+	  __small_swprintf (bnoname, L"Session-%s%s-%S",=0A=
+			    cygwin_version.shared_id,=0A=
+			    _cygwin_testing ? cygwin_version.dll_build_date : "",=0A=
+			    &cygheap->installation_key);=0A=
+	  session_parent_dir=0A=
+	    =3D create_appcontainer_dir (get_appcontainer_parent_dir (), bnoname)=
;=0A=
+	  return session_parent_dir;=0A=
+	}=0A=
+=0A=
       PROCESS_SESSION_INFORMATION psi;=0A=
       status =3D NtQueryInformationProcess (NtCurrentProcess (),=0A=
 					  ProcessSessionInformation,=0A=
@@ -248,6 +391,7 @@ user_info::create (bool reinit)=0A=
 void=0A=
 shared_destroy ()=0A=
 {=0A=
+  wsock_destroy ();=0A=
   ForceCloseHandle (cygwin_shared_h);=0A=
   UnmapViewOfFile (cygwin_shared);=0A=
   ForceCloseHandle (cygwin_user_h);=0A=
@@ -325,6 +469,7 @@ memory_init ()=0A=
   shared_info::create ();	/* Initialize global shared memory */=0A=
   cygheap->user_heap.init ();	/* Initialize user heap */=0A=
   user_info::create (false);	/* Initialize per-user shared memory */=0A=
+  wsock_init ();=0A=
   /* Initialize tty list session stuff.  Doesn't really belong here but=0A=
      this needs to be initialized before any tty or console manipulation=
=0A=
      happens and it is a common location.  */=0A=
diff --git a/winsup/cygwin/sec/helper.cc b/winsup/cygwin/sec/helper.cc=0A=
index 89090fc92..6150c17ff 100644=0A=
--- a/winsup/cygwin/sec/helper.cc=0A=
+++ b/winsup/cygwin/sec/helper.cc=0A=
@@ -24,6 +24,7 @@ details. */=0A=
 #include "cygheap.h"=0A=
 #include "ntdll.h"=0A=
 #include "ldap.h"=0A=
+#include "tls_pbuf.h"=0A=
 =0A=
 /* General purpose security attribute objects for global use. */=0A=
 static NO_COPY_RO SECURITY_DESCRIPTOR null_sdp =3D=0A=
@@ -94,6 +95,99 @@ MKSID (mandatory_system_integrity_sid, "S-1-16-16384",=
=0A=
 MKSID (well_known_samba_unix_user_fake_sid, "S-1-22-1-0",=0A=
        SECURITY_SAMBA_UNIX_AUTHORITY, 2, 1, 0);=0A=
 =0A=
+static bool NO_COPY appcontainer_sid_checked;=0A=
+static bool NO_COPY appcontainer_sid_valid;=0A=
+static ULONG NO_COPY=0A=
+  appcontainer_sid_buffer[(SECURITY_MAX_SID_SIZE + sizeof (ULONG) - 1)=0A=
+			  / sizeof (ULONG)];=0A=
+=0A=
+PSID=0A=
+appcontainer_sid ()=0A=
+{=0A=
+  if (!appcontainer_sid_checked)=0A=
+    {=0A=
+      ULONG is_appcontainer =3D 0;=0A=
+      ULONG size;=0A=
+      NTSTATUS status=0A=
+	=3D NtQueryInformationToken (hProcToken, TokenIsAppContainer,=0A=
+				   &is_appcontainer, sizeof is_appcontainer,=0A=
+				   &size);=0A=
+      if (!NT_SUCCESS (status))=0A=
+	api_fatal ("NtQueryInformationToken(TokenIsAppContainer): %y", status);=
=0A=
+      if (is_appcontainer)=0A=
+	{=0A=
+	  tmp_pathbuf tp;=0A=
+	  PTOKEN_APPCONTAINER_INFORMATION info=0A=
+	    =3D (PTOKEN_APPCONTAINER_INFORMATION) tp.w_get ();=0A=
+	  status =3D NtQueryInformationToken (hProcToken, TokenAppContainerSid,=
=0A=
+					    info, NT_MAX_PATH * sizeof (WCHAR),=0A=
+					    &size);=0A=
+	  if (!NT_SUCCESS (status))=0A=
+	    api_fatal ("NtQueryInformationToken(TokenAppContainerSid): %y",=0A=
+		       status);=0A=
+	  if (!info->TokenAppContainer)=0A=
+	    api_fatal ("Missing AppContainer SID");=0A=
+	  ULONG sid_len =3D RtlLengthSid (info->TokenAppContainer);=0A=
+	  if (sid_len > sizeof appcontainer_sid_buffer)=0A=
+	    api_fatal ("AppContainer SID is too long");=0A=
+	  status =3D RtlCopySid (sizeof appcontainer_sid_buffer,=0A=
+			       appcontainer_sid_buffer,=0A=
+			       info->TokenAppContainer);=0A=
+	  if (!NT_SUCCESS (status))=0A=
+	    api_fatal ("RtlCopySid(AppContainer): %y", status);=0A=
+	  appcontainer_sid_valid =3D true;=0A=
+	}=0A=
+      appcontainer_sid_checked =3D true;=0A=
+    }=0A=
+  return appcontainer_sid_valid ? (PSID) appcontainer_sid_buffer : NULL;=
=0A=
+}=0A=
+=0A=
+PSECURITY_DESCRIPTOR=0A=
+_appcontainer_sd (void *buf, ACCESS_MASK access)=0A=
+{=0A=
+  PSID app_sid =3D appcontainer_sid ();=0A=
+  if (!app_sid)=0A=
+    return NULL;=0A=
+=0A=
+  tmp_pathbuf tp;=0A=
+  PTOKEN_USER user =3D (PTOKEN_USER) tp.w_get ();=0A=
+  ULONG size;=0A=
+  NTSTATUS status=0A=
+    =3D NtQueryInformationToken (hProcToken, TokenUser, user,=0A=
+			       NT_MAX_PATH * sizeof (WCHAR), &size);=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("NtQueryInformationToken(TokenUser): %y", status);=0A=
+=0A=
+  PISECURITY_DESCRIPTOR psd =3D (PISECURITY_DESCRIPTOR) buf;=0A=
+  status =3D RtlCreateSecurityDescriptor (psd, SECURITY_DESCRIPTOR_REVISIO=
N);=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("RtlCreateSecurityDescriptor: %y", status);=0A=
+  PACL dacl =3D (PACL) (psd + 1);=0A=
+  status =3D RtlCreateAcl (dacl, MAX_DACL_LEN (3), ACL_REVISION);=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("RtlCreateAcl: %y", status);=0A=
+  status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, access,=0A=
+				   user->User.Sid);=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("RtlAddAccessAllowedAce(user): %y", status);=0A=
+  status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, access, app_sid);=
=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("RtlAddAccessAllowedAce(AppContainer): %y", status);=0A=
+  status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, GENERIC_ALL,=0A=
+				   well_known_system_sid);=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("RtlAddAccessAllowedAce(system): %y", status);=0A=
+  LPVOID ace;=0A=
+  status =3D RtlFirstFreeAce (dacl, &ace);=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("RtlFirstFreeAce: %y", status);=0A=
+  dacl->AclSize =3D (char *) ace - (char *) dacl;=0A=
+  status =3D RtlSetDaclSecurityDescriptor (psd, TRUE, dacl, FALSE);=0A=
+  if (!NT_SUCCESS (status))=0A=
+    api_fatal ("RtlSetDaclSecurityDescriptor: %y", status);=0A=
+  return psd;=0A=
+}=0A=
+=0A=
 void=0A=
 cygpsid::debug_print (const char *prefix) const=0A=
 {=0A=
@@ -547,7 +641,7 @@ bool=0A=
 sec_acl (PACL acl, bool original, bool admins, PSID sid1, PSID sid2, DWORD=
 access2)=0A=
 {=0A=
   NTSTATUS status;=0A=
-  size_t acl_len =3D MAX_DACL_LEN (5);=0A=
+  size_t acl_len =3D MAX_DACL_LEN (6);=0A=
   LPVOID pAce;=0A=
   cygpsid psid;=0A=
 =0A=
@@ -591,6 +685,14 @@ sec_acl (PACL acl, bool original, bool admins, PSID si=
d1, PSID sid2, DWORD acces=0A=
 				   well_known_system_sid);=0A=
   if (!NT_SUCCESS (status))=0A=
     debug_printf ("RtlAddAccessAllowedAce(system) %y", status);=0A=
+  PSID app_sid =3D appcontainer_sid ();=0A=
+  if (app_sid)=0A=
+    {=0A=
+      status =3D RtlAddAccessAllowedAce (acl, ACL_REVISION, GENERIC_ALL,=
=0A=
+				       app_sid);=0A=
+      if (!NT_SUCCESS (status))=0A=
+	debug_printf ("RtlAddAccessAllowedAce(AppContainer) %y", status);=0A=
+    }=0A=
   status =3D RtlFirstFreeAce (acl, &pAce);=0A=
   if (NT_SUCCESS (status) && pAce)=0A=
     acl->AclSize =3D (char *) pAce - (char *) acl;=0A=
@@ -693,7 +795,7 @@ _everyone_sd (void *buf, ACCESS_MASK access)=0A=
     {=0A=
       RtlCreateSecurityDescriptor (psd, SECURITY_DESCRIPTOR_REVISION);=0A=
       PACL dacl =3D (PACL) (psd + 1);=0A=
-      RtlCreateAcl (dacl, MAX_DACL_LEN (1), ACL_REVISION);=0A=
+      RtlCreateAcl (dacl, MAX_DACL_LEN (2), ACL_REVISION);=0A=
       status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, access,=0A=
 				       well_known_world_sid);=0A=
       if (!NT_SUCCESS (status))=0A=
@@ -701,6 +803,18 @@ _everyone_sd (void *buf, ACCESS_MASK access)=0A=
 	  debug_printf ("RtlAddAccessAllowedAce: %y", status);=0A=
 	  return NULL;=0A=
 	}=0A=
+      PSID app_sid =3D appcontainer_sid ();=0A=
+      if (app_sid)=0A=
+	{=0A=
+	  status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, access,=0A=
+					   app_sid);=0A=
+	  if (!NT_SUCCESS (status))=0A=
+	    {=0A=
+	      debug_printf ("RtlAddAccessAllowedAce(AppContainer): %y",=0A=
+			    status);=0A=
+	      return NULL;=0A=
+	    }=0A=
+	}=0A=
       LPVOID ace;=0A=
       status =3D RtlFirstFreeAce (dacl, &ace);=0A=
       if (!NT_SUCCESS (status))=0A=
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc=0A=
index 5ca02c0a1..e955923d9 100644=0A=
--- a/winsup/cygwin/syscalls.cc=0A=
+++ b/winsup/cygwin/syscalls.cc=0A=
@@ -3661,7 +3661,7 @@ seteuid (uid_t uid)=0A=
 	debug_printf ("NtSetInformationToken (user.token, TokenPrimaryGroup),"=0A=
 		      "%y", status);=0A=
       /* Try setting default DACL */=0A=
-      PACL dacl_buf =3D (PACL) alloca (MAX_DACL_LEN (5));=0A=
+      PACL dacl_buf =3D (PACL) alloca (MAX_DACL_LEN (6));=0A=
       if (sec_acl (dacl_buf, true, true, usersid))=0A=
 	{=0A=
 	  TOKEN_DEFAULT_DACL tdacl =3D { dacl_buf };=0A=
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc=0A=
index f94b9f60b..d80b9208c 100644=0A=
--- a/winsup/cygwin/wincap.cc=0A=
+++ b/winsup/cygwin/wincap.cc=0A=
@@ -277,7 +277,7 @@ static const wincaps wincap_11_24h2 =3D {=0A=
   },=0A=
 };=0A=
 =0A=
-wincapc wincap __attribute__((section (".cygwin_dll_common"), shared));=0A=
+wincapc NO_COPY wincap;=0A=
 =0A=
 extern IMAGE_DOS_HEADER=0A=
 __image_base__;=0A=
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am=0A=
index b84e3b0d4..23d36b074 100644=0A=
--- a/winsup/testsuite/Makefile.am=0A=
+++ b/winsup/testsuite/Makefile.am=0A=
@@ -49,6 +49,7 @@ check_PROGRAMS =3D \=0A=
 	winsup.api/shmtest \=0A=
 	winsup.api/sigchld \=0A=
 	winsup.api/signal-into-win32-api \=0A=
+	winsup.api/socket-event-sharing \=0A=
 	winsup.api/systemcall \=0A=
 	winsup.api/user_malloc \=0A=
 	winsup.api/waitpid \=0A=
@@ -387,8 +388,13 @@ clean-local:=0A=
 if MINGW_PROGS=0A=
 SUBDIRS =3D mingw=0A=
 check_PROGRAMS +=3D testinst/bin/pty-background-native=0A=
+check_PROGRAMS +=3D testinst/bin/appcontainer-child=0A=
+TESTS +=3D mingw/appcontainer-launcher=0A=
 testinst_bin_pty_background_native_SOURCES =3D \=0A=
 	winsup.api/pty-background-native.c=0A=
+testinst_bin_appcontainer_child_SOURCES =3D \=0A=
+	winsup.api/appcontainer-child.c=0A=
+testinst_bin_appcontainer_child_LDADD =3D -ladvapi32 $(LDADD)=0A=
 =0A=
 testinst_bin_pty_background_native_DEPENDENCIES =3D \=0A=
 	$(filter-out -%,$(LDADD)) \=0A=
@@ -396,6 +402,9 @@ testinst_bin_pty_background_native_DEPENDENCIES =3D \=
=0A=
 	testinst/bin/cygwin-console-helper$(EXEEXT) \=0A=
 	testinst/usr/share/terminfo/78/xterm=0A=
 =0A=
+testinst_bin_appcontainer_child_DEPENDENCIES =3D \=0A=
+	$(filter-out -%,$(LDADD))=0A=
+=0A=
 testinst/usr/share/terminfo/78/xterm: /usr/share/terminfo/78/xterm=0A=
 	$(MKDIR_P) $(dir $@)=0A=
 	$(INSTALL_DATA) $< $@=0A=
@@ -410,6 +419,9 @@ testinst/bin/cygwin-console-helper$(EXEEXT): \=0A=
 mingw/pty-native-input$(EXEEXT): $(srcdir)/mingw/pty-native-input.c=0A=
 	$(MAKE) -C mingw pty-native-input$(EXEEXT)=0A=
 =0A=
+mingw/appcontainer-launcher$(EXEEXT): $(srcdir)/mingw/appcontainer-launche=
r.cc=0A=
+	$(MAKE) -C mingw appcontainer-launcher$(EXEEXT)=0A=
+=0A=
 ../utils/mingw/cygwin-console-helper$(EXEEXT): \=0A=
 	$(top_srcdir)/utils/mingw/cygwin-console-helper.cc=0A=
 	$(MAKE) -C ../utils/mingw cygwin-console-helper$(EXEEXT)=0A=
diff --git a/winsup/testsuite/mingw/Makefile.am b/winsup/testsuite/mingw/Ma=
kefile.am=0A=
index 1f14a0240..03aff9b04 100644=0A=
--- a/winsup/testsuite/mingw/Makefile.am=0A=
+++ b/winsup/testsuite/mingw/Makefile.am=0A=
@@ -16,7 +16,8 @@ override CC =3D @MINGW_CC@=0A=
 override CXX =3D @MINGW_CXX@=0A=
 AM_CPPFLAGS =3D=0A=
 =0A=
-noinst_PROGRAMS =3D cygrun cygload winchild pty-native-input=0A=
+noinst_PROGRAMS =3D cygrun cygload winchild pty-native-input \=0A=
+	appcontainer-launcher=0A=
 =0A=
 cygrun_SOURCES =3D \=0A=
 	../cygrun.c=0A=
@@ -32,3 +33,8 @@ winchild_LDADD=3D-lntdll=0A=
 =0A=
 pty_native_input_SOURCES =3D \=0A=
 	pty-native-input.c=0A=
+=0A=
+appcontainer_launcher_SOURCES =3D \=0A=
+	appcontainer-launcher.cc=0A=
+appcontainer_launcher_LDFLAGS =3D -static -municode=0A=
+appcontainer_launcher_LDADD =3D -ladvapi32 -luserenv=0A=
diff --git a/winsup/testsuite/mingw/appcontainer-launcher.cc b/winsup/tests=
uite/mingw/appcontainer-launcher.cc=0A=
new file mode 100644=0A=
index 000000000..e55853990=0A=
--- /dev/null=0A=
+++ b/winsup/testsuite/mingw/appcontainer-launcher.cc=0A=
@@ -0,0 +1,579 @@=0A=
+/* appcontainer-launcher.cc: Run a Cygwin testsuite child in an AppContain=
er.=0A=
+=0A=
+   This file is part of Cygwin.=0A=
+=0A=
+   This software is a copyrighted work licensed under the terms of the=0A=
+   Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
+   details. */=0A=
+=0A=
+#ifndef _WIN32_WINNT=0A=
+#define _WIN32_WINNT 0x0602=0A=
+#endif=0A=
+=0A=
+#include <windows.h>=0A=
+#include <aclapi.h>=0A=
+#include <securityappcontainer.h>=0A=
+#include <userenv.h>=0A=
+=0A=
+#include <stdio.h>=0A=
+#include <string>=0A=
+#include <vector>=0A=
+#include <wchar.h>=0A=
+=0A=
+struct acl_backup=0A=
+{=0A=
+  std::wstring path;=0A=
+  PSECURITY_DESCRIPTOR descriptor;=0A=
+  PACL dacl;=0A=
+};=0A=
+=0A=
+class temporary_acl=0A=
+{=0A=
+  std::vector<acl_backup> backups;=0A=
+=0A=
+public:=0A=
+  DWORD=0A=
+  grant (const std::wstring& path, PSID sid, DWORD access)=0A=
+  {=0A=
+    PSECURITY_DESCRIPTOR descriptor =3D NULL;=0A=
+    PACL old_dacl =3D NULL;=0A=
+    DWORD error =3D GetNamedSecurityInfoW ((LPWSTR) path.c_str (), SE_FILE=
_OBJECT,=0A=
+					 DACL_SECURITY_INFORMATION, NULL, NULL,=0A=
+					 &old_dacl, NULL, &descriptor);=0A=
+    if (error !=3D ERROR_SUCCESS)=0A=
+      return error;=0A=
+=0A=
+    EXPLICIT_ACCESSW entry =3D {};=0A=
+    entry.grfAccessPermissions =3D access;=0A=
+    entry.grfAccessMode =3D GRANT_ACCESS;=0A=
+    entry.grfInheritance =3D NO_INHERITANCE;=0A=
+    entry.Trustee.TrusteeForm =3D TRUSTEE_IS_SID;=0A=
+    entry.Trustee.TrusteeType =3D TRUSTEE_IS_GROUP;=0A=
+    entry.Trustee.ptstrName =3D (LPWSTR) sid;=0A=
+=0A=
+    PACL new_dacl =3D NULL;=0A=
+    error =3D SetEntriesInAclW (1, &entry, old_dacl, &new_dacl);=0A=
+    if (error !=3D ERROR_SUCCESS)=0A=
+      {=0A=
+	LocalFree (descriptor);=0A=
+	return error;=0A=
+      }=0A=
+=0A=
+    backups.push_back ({ path, descriptor, old_dacl });=0A=
+    error =3D SetNamedSecurityInfoW ((LPWSTR) path.c_str (), SE_FILE_OBJEC=
T,=0A=
+				   DACL_SECURITY_INFORMATION, NULL, NULL,=0A=
+				   new_dacl, NULL);=0A=
+    if (new_dacl)=0A=
+      LocalFree (new_dacl);=0A=
+    if (error !=3D ERROR_SUCCESS)=0A=
+      {=0A=
+	backups.pop_back ();=0A=
+	LocalFree (descriptor);=0A=
+	return error;=0A=
+      }=0A=
+    return ERROR_SUCCESS;=0A=
+  }=0A=
+=0A=
+  DWORD=0A=
+  restore ()=0A=
+  {=0A=
+    DWORD first_error =3D ERROR_SUCCESS;=0A=
+    for (size_t i =3D backups.size (); i > 0; --i)=0A=
+      {=0A=
+	acl_backup& backup =3D backups[i - 1];=0A=
+	if (!backup.descriptor)=0A=
+	  continue;=0A=
+	DWORD error=0A=
+	  =3D SetNamedSecurityInfoW ((LPWSTR) backup.path.c_str (), SE_FILE_OBJEC=
T,=0A=
+				   DACL_SECURITY_INFORMATION, NULL, NULL,=0A=
+				   backup.dacl, NULL);=0A=
+	if (first_error =3D=3D ERROR_SUCCESS && error !=3D ERROR_SUCCESS)=0A=
+	  first_error =3D error;=0A=
+	if (error =3D=3D ERROR_SUCCESS)=0A=
+	  {=0A=
+	    LocalFree (backup.descriptor);=0A=
+	    backup.descriptor =3D NULL;=0A=
+	  }=0A=
+      }=0A=
+    if (first_error =3D=3D ERROR_SUCCESS)=0A=
+      backups.clear ();=0A=
+    return first_error;=0A=
+  }=0A=
+=0A=
+  ~temporary_acl ()=0A=
+  {=0A=
+    restore ();=0A=
+  }=0A=
+};=0A=
+=0A=
+static std::wstring=0A=
+full_path (const std::wstring& path)=0A=
+{=0A=
+  DWORD needed =3D GetFullPathNameW (path.c_str (), 0, NULL, NULL);=0A=
+  if (!needed)=0A=
+    return std::wstring ();=0A=
+  std::vector<WCHAR> buffer (needed + 1);=0A=
+  DWORD length=0A=
+    =3D GetFullPathNameW (path.c_str (), buffer.size (), buffer.data (), N=
ULL);=0A=
+  if (!length || length >=3D buffer.size ())=0A=
+    return std::wstring ();=0A=
+  return std::wstring (buffer.data (), length);=0A=
+}=0A=
+=0A=
+static std::wstring=0A=
+parent_path (const std::wstring& path)=0A=
+{=0A=
+  size_t slash =3D path.find_last_of (L"\\/");=0A=
+  if (slash =3D=3D std::wstring::npos)=0A=
+    return std::wstring ();=0A=
+  if (slash =3D=3D 2 && path.size () >=3D 3 && path[1] =3D=3D L':')=0A=
+    return path.substr (0, 3);=0A=
+  return path.substr (0, slash);=0A=
+}=0A=
+=0A=
+static bool=0A=
+grant_ancestor_traverse (const std::wstring& root, PSID sid,=0A=
+			 temporary_acl& acl, DWORD& error)=0A=
+{=0A=
+  std::vector<std::wstring> ancestors;=0A=
+  std::wstring path =3D parent_path (root);=0A=
+  while (path.size () > 3)=0A=
+    {=0A=
+      ancestors.push_back (path);=0A=
+      path =3D parent_path (path);=0A=
+    }=0A=
+  for (auto it =3D ancestors.rbegin (); it !=3D ancestors.rend (); ++it)=
=0A=
+    {=0A=
+      error =3D acl.grant (*it, sid, FILE_TRAVERSE | FILE_READ_ATTRIBUTES)=
;=0A=
+      if (error !=3D ERROR_SUCCESS)=0A=
+	return false;=0A=
+    }=0A=
+  return true;=0A=
+}=0A=
+=0A=
+static bool=0A=
+grant_test_files (const std::wstring& root, const std::wstring& child,=0A=
+		  const std::wstring& dll, PSID sid, temporary_acl& acl,=0A=
+		  DWORD& error)=0A=
+{=0A=
+  error =3D acl.grant (root, sid, FILE_TRAVERSE | FILE_READ_ATTRIBUTES);=
=0A=
+  if (error !=3D ERROR_SUCCESS)=0A=
+    return false;=0A=
+  error =3D acl.grant (parent_path (child), sid,=0A=
+		     FILE_TRAVERSE | FILE_READ_ATTRIBUTES);=0A=
+  if (error !=3D ERROR_SUCCESS)=0A=
+    return false;=0A=
+  error =3D acl.grant (child, sid, FILE_GENERIC_READ | FILE_EXECUTE);=0A=
+  if (error !=3D ERROR_SUCCESS)=0A=
+    return false;=0A=
+  error =3D acl.grant (dll, sid, FILE_GENERIC_READ | FILE_EXECUTE);=0A=
+  return error =3D=3D ERROR_SUCCESS;=0A=
+}=0A=
+=0A=
+static std::wstring=0A=
+quote_argument (const std::wstring& arg)=0A=
+{=0A=
+  std::wstring quoted =3D L"\"";=0A=
+  size_t slashes =3D 0;=0A=
+  for (WCHAR c : arg)=0A=
+    {=0A=
+      if (c =3D=3D L'\\')=0A=
+	{=0A=
+	  ++slashes;=0A=
+	  continue;=0A=
+	}=0A=
+      if (c =3D=3D L'"')=0A=
+	quoted.append (slashes * 2 + 1, L'\\');=0A=
+      else=0A=
+	quoted.append (slashes, L'\\');=0A=
+      quoted.push_back (c);=0A=
+      slashes =3D 0;=0A=
+    }=0A=
+  quoted.append (slashes * 2, L'\\');=0A=
+  quoted.push_back (L'"');=0A=
+  return quoted;=0A=
+}=0A=
+=0A=
+static bool=0A=
+is_appcontainer (HANDLE process)=0A=
+{=0A=
+  HANDLE token =3D NULL;=0A=
+  DWORD value =3D 0;=0A=
+  DWORD size =3D 0;=0A=
+  if (!OpenProcessToken (process, TOKEN_QUERY, &token))=0A=
+    return false;=0A=
+  BOOL ok =3D GetTokenInformation (token, TokenIsAppContainer, &value,=0A=
+				 sizeof value, &size);=0A=
+  CloseHandle (token);=0A=
+  return ok && value !=3D 0;=0A=
+}=0A=
+=0A=
+static bool=0A=
+skip_error (DWORD error)=0A=
+{=0A=
+  return error =3D=3D ERROR_ACCESS_DENIED || error =3D=3D ERROR_NOT_SUPPOR=
TED=0A=
+	 || error =3D=3D ERROR_CALL_NOT_IMPLEMENTED=0A=
+	 || error =3D=3D ERROR_PRIVILEGE_NOT_HELD=0A=
+	 || error =3D=3D ERROR_ACCESS_DISABLED_BY_POLICY;=0A=
+}=0A=
+=0A=
+static bool=0A=
+skip_hresult (HRESULT hr)=0A=
+{=0A=
+  return skip_error (HRESULT_CODE (hr));=0A=
+}=0A=
+=0A=
+static void=0A=
+print_child_output (const std::string& output)=0A=
+{=0A=
+  if (!output.empty ())=0A=
+    {=0A=
+      fwrite (output.data (), 1, output.size (), stdout);=0A=
+      fflush (stdout);=0A=
+    }=0A=
+}=0A=
+=0A=
+static bool=0A=
+read_available (HANDLE pipe, std::string& output, DWORD& error)=0A=
+{=0A=
+  error =3D ERROR_SUCCESS;=0A=
+  for (;;)=0A=
+    {=0A=
+      DWORD available =3D 0;=0A=
+      if (!PeekNamedPipe (pipe, NULL, 0, NULL, &available, NULL))=0A=
+	{=0A=
+	  error =3D GetLastError ();=0A=
+	  return error =3D=3D ERROR_BROKEN_PIPE;=0A=
+	}=0A=
+      if (!available)=0A=
+	return true;=0A=
+      char buffer[4096];=0A=
+      DWORD read_count =3D 0;=0A=
+      if (!ReadFile (pipe, buffer,=0A=
+		     available < sizeof buffer ? available : sizeof buffer,=0A=
+		     &read_count, NULL))=0A=
+	{=0A=
+	  error =3D GetLastError ();=0A=
+	  return error =3D=3D ERROR_BROKEN_PIPE;=0A=
+	}=0A=
+      if (!read_count)=0A=
+	return true;=0A=
+      output.append (buffer, read_count);=0A=
+    }=0A=
+}=0A=
+=0A=
+int=0A=
+wmain ()=0A=
+{=0A=
+  std::wstring child =3D full_path (L"testinst\\bin\\appcontainer-child.ex=
e");=0A=
+  if (child.empty ())=0A=
+    {=0A=
+      fwprintf (stderr, L"Could not resolve the AppContainer child path: %=
lu\n",=0A=
+		GetLastError ());=0A=
+      return 1;=0A=
+    }=0A=
+  std::wstring test_root =3D parent_path (parent_path (child));=0A=
+  std::wstring dll =3D parent_path (child) + L"\\cygwin1.dll";=0A=
+  if (GetFileAttributesW (child.c_str ()) =3D=3D INVALID_FILE_ATTRIBUTES=
=0A=
+      || GetFileAttributesW (dll.c_str ()) =3D=3D INVALID_FILE_ATTRIBUTES)=
=0A=
+    {=0A=
+      fwprintf (stderr, L"Missing test child or build-tree cygwin1.dll:\n"=
=0A=
+		L"  child: %ls\n  dll: %ls\n", child.c_str (), dll.c_str ());=0A=
+      return 1;=0A=
+    }=0A=
+=0A=
+  WCHAR profile_name[96];=0A=
+  int name_length=0A=
+    =3D swprintf (profile_name, 96, L"CygwinTest-%lu-%llu",=0A=
+		GetCurrentProcessId (), GetTickCount64 ());=0A=
+  if (name_length < 0 || name_length >=3D 96)=0A=
+    {=0A=
+      fwprintf (stderr, L"Could not generate AppContainer profile name.\n"=
);=0A=
+      return 1;=0A=
+    }=0A=
+  PSID appcontainer_sid =3D NULL;=0A=
+  HRESULT hr =3D CreateAppContainerProfile (profile_name, profile_name,=0A=
+					  L"Cygwin testsuite AppContainer",=0A=
+					  NULL, 0, &appcontainer_sid);=0A=
+  if (FAILED (hr))=0A=
+    {=0A=
+      if (skip_hresult (hr))=0A=
+	{=0A=
+	  fwprintf (stdout, L"SKIP=3DCannot create AppContainer profile "=0A=
+		    L"(HRESULT 0x%08lx).\n", (ULONG) hr);=0A=
+	  return 77;=0A=
+	}=0A=
+      fwprintf (stderr, L"CreateAppContainerProfile failed: 0x%08lx\n",=0A=
+		(ULONG) hr);=0A=
+      return 1;=0A=
+    }=0A=
+=0A=
+  int result =3D 1;=0A=
+  temporary_acl acl;=0A=
+  DWORD error =3D ERROR_SUCCESS;=0A=
+  if (!grant_ancestor_traverse (test_root, appcontainer_sid, acl, error)=
=0A=
+      || !grant_test_files (test_root, child, dll, appcontainer_sid, acl,=
=0A=
+			    error))=0A=
+    {=0A=
+      DWORD restore_error =3D acl.restore ();=0A=
+      if (restore_error !=3D ERROR_SUCCESS)=0A=
+	{=0A=
+	  fwprintf (stderr, L"Could not restore test-tree ACL after setup "=0A=
+		    L"failure (error %lu).\n", restore_error);=0A=
+	  goto cleanup_profile;=0A=
+	}=0A=
+      if (skip_error (error))=0A=
+	{=0A=
+	  fwprintf (stdout, L"SKIP=3DCannot grant AppContainer access to test "=
=0A=
+		    L"runtime (error %lu).\n", error);=0A=
+	  result =3D 77;=0A=
+	}=0A=
+      else=0A=
+	fwprintf (stderr, L"Could not grant AppContainer access to test "=0A=
+		  L"runtime (error %lu).\n", error);=0A=
+      goto cleanup_profile;=0A=
+    }=0A=
+=0A=
+  {=0A=
+    SECURITY_ATTRIBUTES pipe_security =3D { sizeof pipe_security, NULL, TR=
UE };=0A=
+    HANDLE output_read =3D NULL;=0A=
+    HANDLE output_write =3D NULL;=0A=
+    HANDLE input =3D NULL;=0A=
+    if (!CreatePipe (&output_read, &output_write, &pipe_security, 0))=0A=
+      {=0A=
+	fwprintf (stderr, L"CreatePipe failed: %lu\n", GetLastError ());=0A=
+	goto cleanup_acl;=0A=
+      }=0A=
+    input =3D CreateFileW (L"NUL", GENERIC_READ,=0A=
+			 FILE_SHARE_READ | FILE_SHARE_WRITE, &pipe_security,=0A=
+			 OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);=0A=
+    if (input =3D=3D INVALID_HANDLE_VALUE)=0A=
+      {=0A=
+	fwprintf (stderr, L"Could not open NUL for child stdin: %lu\n",=0A=
+		  GetLastError ());=0A=
+	CloseHandle (output_read);=0A=
+	CloseHandle (output_write);=0A=
+	goto cleanup_acl;=0A=
+      }=0A=
+    if (!SetHandleInformation (output_read, HANDLE_FLAG_INHERIT, 0))=0A=
+      {=0A=
+	fwprintf (stderr, L"SetHandleInformation failed: %lu\n",=0A=
+		  GetLastError ());=0A=
+	CloseHandle (input);=0A=
+	CloseHandle (output_read);=0A=
+	CloseHandle (output_write);=0A=
+	goto cleanup_acl;=0A=
+      }=0A=
+=0A=
+    STARTUPINFOEXW startup =3D {};=0A=
+    startup.StartupInfo.cb =3D sizeof startup;=0A=
+    startup.StartupInfo.dwFlags =3D STARTF_USESTDHANDLES;=0A=
+    startup.StartupInfo.hStdInput =3D input;=0A=
+    startup.StartupInfo.hStdOutput =3D output_write;=0A=
+    startup.StartupInfo.hStdError =3D output_write;=0A=
+=0A=
+    SIZE_T attr_size =3D 0;=0A=
+    InitializeProcThreadAttributeList (NULL, 2, 0, &attr_size);=0A=
+    if (!attr_size)=0A=
+      {=0A=
+	DWORD init_error =3D GetLastError ();=0A=
+	if (skip_error (init_error))=0A=
+	  {=0A=
+	    fwprintf (stdout, L"SKIP=3DAppContainer process attributes are not "=
=0A=
+		      L"available (error %lu).\n", init_error);=0A=
+	    result =3D 77;=0A=
+	  }=0A=
+	else=0A=
+	  fwprintf (stderr, L"AppContainer process attributes are unavailable: "=
=0A=
+		    L"%lu\n", init_error);=0A=
+	CloseHandle (input);=0A=
+	CloseHandle (output_read);=0A=
+	CloseHandle (output_write);=0A=
+	goto cleanup_acl;=0A=
+      }=0A=
+    std::vector<BYTE> attr_storage (attr_size);=0A=
+    startup.lpAttributeList=0A=
+      =3D (LPPROC_THREAD_ATTRIBUTE_LIST) attr_storage.data ();=0A=
+    if (!InitializeProcThreadAttributeList (startup.lpAttributeList, 2, 0,=
=0A=
+					    &attr_size))=0A=
+      {=0A=
+	DWORD init_error =3D GetLastError ();=0A=
+	if (skip_error (init_error))=0A=
+	  {=0A=
+	    fwprintf (stdout, L"SKIP=3DAppContainer process attributes are not "=
=0A=
+		      L"available (error %lu).\n", init_error);=0A=
+	    result =3D 77;=0A=
+	  }=0A=
+	else=0A=
+	  fwprintf (stderr, L"InitializeProcThreadAttributeList failed: %lu\n",=
=0A=
+		    init_error);=0A=
+	CloseHandle (input);=0A=
+	CloseHandle (output_read);=0A=
+	CloseHandle (output_write);=0A=
+	goto cleanup_acl;=0A=
+      }=0A=
+=0A=
+    SECURITY_CAPABILITIES capabilities =3D {};=0A=
+    capabilities.AppContainerSid =3D appcontainer_sid;=0A=
+    HANDLE inherited[] =3D { output_write, input };=0A=
+    bool attrs_ok=0A=
+      =3D UpdateProcThreadAttribute (startup.lpAttributeList, 0,=0A=
+				   PROC_THREAD_ATTRIBUTE_SECURITY_CAPABILITIES,=0A=
+				   &capabilities, sizeof capabilities,=0A=
+				   NULL, NULL)=0A=
+	&& UpdateProcThreadAttribute (startup.lpAttributeList, 0,=0A=
+				      PROC_THREAD_ATTRIBUTE_HANDLE_LIST,=0A=
+				      inherited, sizeof inherited, NULL, NULL);=0A=
+    if (!attrs_ok)=0A=
+      {=0A=
+	DWORD update_error =3D GetLastError ();=0A=
+	DeleteProcThreadAttributeList (startup.lpAttributeList);=0A=
+	CloseHandle (input);=0A=
+	CloseHandle (output_read);=0A=
+	CloseHandle (output_write);=0A=
+	if (skip_error (update_error))=0A=
+	  {=0A=
+	    fwprintf (stdout, L"SKIP=3DAppContainer process attributes are not "=
=0A=
+		      L"supported (error %lu).\n", update_error);=0A=
+	    result =3D 77;=0A=
+	  }=0A=
+	else=0A=
+	  fwprintf (stderr, L"Could not configure AppContainer process "=0A=
+		    L"attributes (error %lu).\n", update_error);=0A=
+	goto cleanup_acl;=0A=
+      }=0A=
+=0A=
+    std::wstring command =3D quote_argument (child);=0A=
+    std::vector<WCHAR> command_line (command.begin (), command.end ());=0A=
+    command_line.push_back (L'\0');=0A=
+    if (!SetEnvironmentVariableW (L"CYGWIN_TESTING", L"1"))=0A=
+      {=0A=
+	fwprintf (stderr, L"SetEnvironmentVariable(CYGWIN_TESTING) failed: "=0A=
+		  L"%lu\n", GetLastError ());=0A=
+	DeleteProcThreadAttributeList (startup.lpAttributeList);=0A=
+	CloseHandle (input);=0A=
+	CloseHandle (output_read);=0A=
+	CloseHandle (output_write);=0A=
+	goto cleanup_acl;=0A=
+      }=0A=
+=0A=
+    PROCESS_INFORMATION process =3D {};=0A=
+    BOOL created=0A=
+      =3D CreateProcessW (child.c_str (), command_line.data (), NULL, NULL=
, TRUE,=0A=
+			EXTENDED_STARTUPINFO_PRESENT, NULL,=0A=
+			parent_path (child).c_str (), &startup.StartupInfo,=0A=
+			&process);=0A=
+    DWORD create_error =3D GetLastError ();=0A=
+    DeleteProcThreadAttributeList (startup.lpAttributeList);=0A=
+    CloseHandle (input);=0A=
+    CloseHandle (output_write);=0A=
+    if (!created)=0A=
+      {=0A=
+	CloseHandle (output_read);=0A=
+	if (skip_error (create_error))=0A=
+	  {=0A=
+	    fwprintf (stdout, L"SKIP=3DHost denied AppContainer child launch "=0A=
+		      L"(error %lu).\n", create_error);=0A=
+	    result =3D 77;=0A=
+	  }=0A=
+	else=0A=
+	  fwprintf (stderr, L"CreateProcess(AppContainer child) failed: %lu\n",=
=0A=
+		    create_error);=0A=
+	goto cleanup_acl;=0A=
+      }=0A=
+=0A=
+    std::string output;=0A=
+    ULONGLONG deadline =3D GetTickCount64 () + 30000;=0A=
+    bool timed_out =3D false;=0A=
+    bool output_failed =3D false;=0A=
+    DWORD output_error =3D ERROR_SUCCESS;=0A=
+    for (;;)=0A=
+      {=0A=
+	if (!read_available (output_read, output, output_error))=0A=
+	  {=0A=
+	    fwprintf (stderr, L"Could not read AppContainer child output: %lu\n",=
=0A=
+		      output_error);=0A=
+	    output_failed =3D true;=0A=
+	    TerminateProcess (process.hProcess, 1);=0A=
+	    WaitForSingleObject (process.hProcess, INFINITE);=0A=
+	    break;=0A=
+	  }=0A=
+	DWORD wait =3D WaitForSingleObject (process.hProcess, 50);=0A=
+	if (wait =3D=3D WAIT_OBJECT_0)=0A=
+	  {=0A=
+	    if (!read_available (output_read, output, output_error))=0A=
+	      {=0A=
+		fwprintf (stderr,=0A=
+			  L"Could not read AppContainer child output: %lu\n",=0A=
+			  output_error);=0A=
+		output_failed =3D true;=0A=
+	      }=0A=
+	    break;=0A=
+	  }=0A=
+	if (wait =3D=3D WAIT_FAILED)=0A=
+	  {=0A=
+	    fwprintf (stderr, L"WaitForSingleObject failed: %lu\n",=0A=
+		      GetLastError ());=0A=
+	    TerminateProcess (process.hProcess, 1);=0A=
+	    WaitForSingleObject (process.hProcess, INFINITE);=0A=
+	    break;=0A=
+	  }=0A=
+	if (GetTickCount64 () >=3D deadline)=0A=
+	  {=0A=
+	    timed_out =3D true;=0A=
+	    TerminateProcess (process.hProcess, 1);=0A=
+	    WaitForSingleObject (process.hProcess, INFINITE);=0A=
+	    if (!read_available (output_read, output, output_error))=0A=
+	      {=0A=
+		fwprintf (stderr,=0A=
+			  L"Could not read AppContainer child output: %lu\n",=0A=
+			  output_error);=0A=
+		output_failed =3D true;=0A=
+	      }=0A=
+	    break;=0A=
+	  }=0A=
+      }=0A=
+      {=0A=
+	DWORD exit_code =3D 1;=0A=
+	GetExitCodeProcess (process.hProcess, &exit_code);=0A=
+	print_child_output (output);=0A=
+	if (timed_out)=0A=
+	  fwprintf (stderr, L"AppContainer child timed out.\n");=0A=
+	else if (output_failed)=0A=
+	  result =3D 1;=0A=
+	else if (!is_appcontainer (process.hProcess))=0A=
+	  fwprintf (stderr, L"Child process token is not an AppContainer.\n");=0A=
+	else if (exit_code !=3D 0)=0A=
+	  fwprintf (stderr, L"AppContainer child exited with status %lu.\n",=0A=
+		    exit_code);=0A=
+	else=0A=
+	  result =3D 0;=0A=
+      }=0A=
+    CloseHandle (process.hThread);=0A=
+    CloseHandle (process.hProcess);=0A=
+    CloseHandle (output_read);=0A=
+  }=0A=
+=0A=
+cleanup_acl:=0A=
+  {=0A=
+    DWORD restore_error =3D acl.restore ();=0A=
+    if (restore_error !=3D ERROR_SUCCESS)=0A=
+      {=0A=
+	fwprintf (stderr, L"Could not restore test-tree ACL (error %lu).\n",=0A=
+		  restore_error);=0A=
+	result =3D 1;=0A=
+      }=0A=
+  }=0A=
+cleanup_profile:=0A=
+  {=0A=
+    HRESULT cleanup_hr =3D DeleteAppContainerProfile (profile_name);=0A=
+    if (FAILED (cleanup_hr))=0A=
+      {=0A=
+	fwprintf (stderr, L"DeleteAppContainerProfile failed: 0x%08lx\n",=0A=
+		  (ULONG) cleanup_hr);=0A=
+	result =3D 1;=0A=
+      }=0A=
+    FreeSid (appcontainer_sid);=0A=
+  }=0A=
+  return result;=0A=
+}=0A=
diff --git a/winsup/testsuite/winsup.api/appcontainer-child.c b/winsup/test=
suite/winsup.api/appcontainer-child.c=0A=
new file mode 100644=0A=
index 000000000..48508a5ac=0A=
--- /dev/null=0A=
+++ b/winsup/testsuite/winsup.api/appcontainer-child.c=0A=
@@ -0,0 +1,141 @@=0A=
+/* Exercise runtime initialization and named-object locking in AppContaine=
r. */=0A=
+=0A=
+#include <windows.h>=0A=
+=0A=
+#include <errno.h>=0A=
+#include <fcntl.h>=0A=
+#include <stdio.h>=0A=
+#include <string.h>=0A=
+#include <wchar.h>=0A=
+#include <sys/file.h>=0A=
+#include <unistd.h>=0A=
+=0A=
+static int=0A=
+is_appcontainer (void)=0A=
+{=0A=
+  HANDLE token;=0A=
+  DWORD value =3D 0;=0A=
+  DWORD size =3D 0;=0A=
+=0A=
+  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_QUERY, &token))=0A=
+    {=0A=
+      fprintf (stderr, "OpenProcessToken failed: %lu\n",=0A=
+	       (unsigned long) GetLastError ());=0A=
+      return -1;=0A=
+    }=0A=
+  BOOL ok =3D GetTokenInformation (token, TokenIsAppContainer, &value,=0A=
+				 sizeof value, &size);=0A=
+  DWORD error =3D ok ? ERROR_SUCCESS : GetLastError ();=0A=
+  CloseHandle (token);=0A=
+  if (!ok)=0A=
+    {=0A=
+      fprintf (stderr, "GetTokenInformation(TokenIsAppContainer) failed: "=
=0A=
+	       "%lu\n", (unsigned long) error);=0A=
+      return -1;=0A=
+    }=0A=
+  return value !=3D 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+check_runtime_dll (void)=0A=
+{=0A=
+  WCHAR actual[MAX_PATH];=0A=
+  WCHAR executable[MAX_PATH];=0A=
+  HMODULE module =3D GetModuleHandleW (L"cygwin1.dll");=0A=
+  if (!module=0A=
+      || !GetModuleFileNameW (module, actual, sizeof actual / sizeof actua=
l[0]))=0A=
+    {=0A=
+      fprintf (stderr, "Could not locate loaded cygwin1.dll: %lu\n",=0A=
+	       (unsigned long) GetLastError ());=0A=
+      return -1;=0A=
+    }=0A=
+  if (!GetModuleFileNameW (NULL, executable,=0A=
+			   sizeof executable / sizeof executable[0]))=0A=
+    {=0A=
+      fprintf (stderr, "Could not locate test executable: %lu\n",=0A=
+	       (unsigned long) GetLastError ());=0A=
+      return -1;=0A=
+    }=0A=
+=0A=
+  WCHAR actual_full[MAX_PATH];=0A=
+  WCHAR executable_full[MAX_PATH];=0A=
+  DWORD actual_len =3D GetFullPathNameW (actual, MAX_PATH, actual_full, NU=
LL);=0A=
+  DWORD executable_len=0A=
+    =3D GetFullPathNameW (executable, MAX_PATH, executable_full, NULL);=0A=
+  if (!actual_len || actual_len >=3D MAX_PATH=0A=
+      || !executable_len || executable_len >=3D MAX_PATH)=0A=
+    {=0A=
+      fprintf (stderr, "Could not normalize runtime paths.\n");=0A=
+      return -1;=0A=
+    }=0A=
+=0A=
+  WCHAR *actual_slash =3D wcsrchr (actual_full, L'\\');=0A=
+  WCHAR *executable_slash =3D wcsrchr (executable_full, L'\\');=0A=
+  if (!actual_slash || !executable_slash=0A=
+      || CompareStringOrdinal (actual_slash + 1, -1, L"cygwin1.dll", -1,=
=0A=
+			       TRUE) !=3D CSTR_EQUAL)=0A=
+    {=0A=
+      fwprintf (stderr, L"Unexpected runtime DLL path: %ls\n", actual_full=
);=0A=
+      return -1;=0A=
+    }=0A=
+  *actual_slash =3D L'\0';=0A=
+  *executable_slash =3D L'\0';=0A=
+  if (CompareStringOrdinal (actual_full, -1, executable_full, -1, TRUE)=0A=
+      !=3D CSTR_EQUAL)=0A=
+    {=0A=
+      fwprintf (stderr, L"Loaded cygwin1.dll is not beside the test "=0A=
+	       L"executable.\n  loaded: %ls\n  executable: %ls\n",=0A=
+	       actual_full, executable_full);=0A=
+      return -1;=0A=
+    }=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+main (int argc, char **argv)=0A=
+{=0A=
+  (void) argv;=0A=
+  if (argc !=3D 1)=0A=
+    {=0A=
+      fprintf (stderr, "usage: appcontainer-child\n");=0A=
+      return 2;=0A=
+    }=0A=
+=0A=
+  int appcontainer =3D is_appcontainer ();=0A=
+  if (appcontainer < 0)=0A=
+    return 1;=0A=
+  if (!appcontainer)=0A=
+    {=0A=
+      fprintf (stderr, "Child is not running in an AppContainer.\n");=0A=
+      return 1;=0A=
+    }=0A=
+  if (check_runtime_dll ())=0A=
+    return 1;=0A=
+=0A=
+  int fd =3D open ("appcontainer-child.exe", O_RDONLY);=0A=
+  if (fd < 0)=0A=
+    {=0A=
+      fprintf (stderr, "open test executable failed: %s\n", strerror (errn=
o));=0A=
+      return 1;=0A=
+    }=0A=
+  if (flock (fd, LOCK_SH | LOCK_NB) < 0)=0A=
+    {=0A=
+      fprintf (stderr, "flock shared lock failed: %s\n", strerror (errno))=
;=0A=
+      close (fd);=0A=
+      return 1;=0A=
+    }=0A=
+  if (flock (fd, LOCK_UN) < 0)=0A=
+    {=0A=
+      fprintf (stderr, "flock unlock failed: %s\n", strerror (errno));=0A=
+      close (fd);=0A=
+      return 1;=0A=
+    }=0A=
+  if (close (fd) < 0)=0A=
+    {=0A=
+      fprintf (stderr, "close test executable failed: %s\n", strerror (err=
no));=0A=
+      return 1;=0A=
+    }=0A=
+=0A=
+  puts ("Cygwin AppContainer startup and named-object locking passed.");=
=0A=
+  return 0;=0A=
+}=0A=
diff --git a/winsup/testsuite/winsup.api/socket-event-sharing.c b/winsup/te=
stsuite/winsup.api/socket-event-sharing.c=0A=
new file mode 100644=0A=
index 000000000..d4182c0cd=0A=
--- /dev/null=0A=
+++ b/winsup/testsuite/winsup.api/socket-event-sharing.c=0A=
@@ -0,0 +1,142 @@=0A=
+/* Share socket state across dup/fork/exec, but not object namespaces. */=
=0A=
+=0A=
+#include <windows.h>=0A=
+#include <sys/socket.h>=0A=
+#include <sys/wait.h>=0A=
+#include <fcntl.h>=0A=
+#include <stdio.h>=0A=
+#include <stdlib.h>=0A=
+#include <string.h>=0A=
+#include <unistd.h>=0A=
+=0A=
+static void=0A=
+fail (const char *message)=0A=
+{=0A=
+  perror (message);=0A=
+  exit (1);=0A=
+}=0A=
+=0A=
+static int=0A=
+check_namespace (int fd)=0A=
+{=0A=
+  char executable[MAX_PATH];=0A=
+  char command[MAX_PATH + 32];=0A=
+  DWORD length =3D GetModuleFileNameA (NULL, executable, sizeof executable=
);=0A=
+  if (!length || length >=3D sizeof executable)=0A=
+    return 1;=0A=
+  snprintf (command, sizeof command, "\"%s\" --other-namespace", executabl=
e);=0A=
+=0A=
+  /* A native launch avoids inheriting Cygwin's process information. */=0A=
+  const char *testing =3D getenv ("CYGWIN_TESTING");=0A=
+  if (!SetEnvironmentVariableA ("CYGWIN_TESTING",=0A=
+			       testing && *testing ? NULL : "1"))=0A=
+    return 1;=0A=
+  STARTUPINFOA startup =3D { .cb =3D sizeof startup };=0A=
+  PROCESS_INFORMATION process;=0A=
+  BOOL created =3D CreateProcessA (executable, command, NULL, NULL, FALSE,=
 0,=0A=
+				 NULL, NULL, &startup, &process);=0A=
+  BOOL restored =3D SetEnvironmentVariableA ("CYGWIN_TESTING", testing);=
=0A=
+  if (!created)=0A=
+    {=0A=
+      fputs ("Could not launch the other socket namespace\n", stderr);=0A=
+      return 1;=0A=
+    }=0A=
+  CloseHandle (process.hThread);=0A=
+  DWORD wait =3D WaitForSingleObject (process.hProcess, 20000);=0A=
+  DWORD status =3D 1;=0A=
+  if (wait =3D=3D WAIT_OBJECT_0)=0A=
+    GetExitCodeProcess (process.hProcess, &status);=0A=
+  else=0A=
+    {=0A=
+      TerminateProcess (process.hProcess, 1);=0A=
+      WaitForSingleObject (process.hProcess, INFINITE);=0A=
+    }=0A=
+  CloseHandle (process.hProcess);=0A=
+  if (!restored || wait !=3D WAIT_OBJECT_0 || status)=0A=
+    {=0A=
+      fputs ("Other socket namespace failed\n", stderr);=0A=
+      return 1;=0A=
+    }=0A=
+  if (fcntl (fd, F_GETOWN) !=3D getpid ())=0A=
+    {=0A=
+      fputs ("Other namespace overwrote a live socket's event state\n",=0A=
+	     stderr);=0A=
+      return 1;=0A=
+    }=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+main (int argc, char **argv)=0A=
+{=0A=
+  alarm (30);=0A=
+  if (argc =3D=3D 2 && !strcmp (argv[1], "--other-namespace"))=0A=
+    {=0A=
+      for (int i =3D 0; i < 4096; ++i)=0A=
+	{=0A=
+	  int fd =3D socket (AF_INET, SOCK_DGRAM, 0);=0A=
+	  if (fd =3D=3D -1)=0A=
+	    fail ("socket in other namespace");=0A=
+	  close (fd);=0A=
+	}=0A=
+      return 0;=0A=
+    }=0A=
+  if (argc =3D=3D 3 && !strcmp (argv[1], "--exec"))=0A=
+    {=0A=
+      int fd =3D atoi (argv[2]);=0A=
+      if (fcntl (fd, F_GETOWN) !=3D getpid ())=0A=
+	{=0A=
+	  fputs ("Socket owner was not preserved across exec\n", stderr);=0A=
+	  return 1;=0A=
+	}=0A=
+      if (fcntl (fd, F_SETOWN, getppid ()) =3D=3D -1)=0A=
+	fail ("F_SETOWN after exec");=0A=
+      return 0;=0A=
+    }=0A=
+=0A=
+  int fd =3D socket (AF_INET, SOCK_DGRAM, 0);=0A=
+  if (fd =3D=3D -1)=0A=
+    fail ("socket");=0A=
+  if (fcntl (fd, F_SETOWN, 0) =3D=3D -1)=0A=
+    fail ("F_SETOWN");=0A=
+=0A=
+  pid_t child =3D fork ();=0A=
+  if (child =3D=3D -1)=0A=
+    fail ("fork");=0A=
+  if (!child)=0A=
+    {=0A=
+      if (fcntl (fd, F_SETOWN, getpid ()) =3D=3D -1)=0A=
+	fail ("F_SETOWN after fork");=0A=
+      int duplicate =3D dup (fd);=0A=
+      if (duplicate =3D=3D -1)=0A=
+	fail ("dup");=0A=
+      if (fcntl (duplicate, F_GETOWN) !=3D getpid ())=0A=
+	{=0A=
+	  fputs ("Duplicated socket does not share its owner\n", stderr);=0A=
+	  return 1;=0A=
+	}=0A=
+      close (duplicate);=0A=
+      char fdstr[32];=0A=
+      snprintf (fdstr, sizeof fdstr, "%d", fd);=0A=
+      execl (argv[0], argv[0], "--exec", fdstr, (char *) NULL);=0A=
+      fail ("exec");=0A=
+    }=0A=
+=0A=
+  int status;=0A=
+  if (waitpid (child, &status, 0) !=3D child)=0A=
+    fail ("waitpid");=0A=
+  if (!WIFEXITED (status) || WEXITSTATUS (status))=0A=
+    {=0A=
+      fputs ("Socket child failed\n", stderr);=0A=
+      return 1;=0A=
+    }=0A=
+  if (fcntl (fd, F_GETOWN) !=3D getpid ())=0A=
+    {=0A=
+      fputs ("Parent did not observe the child's socket owner update\n",=
=0A=
+	     stderr);=0A=
+      return 1;=0A=
+    }=0A=
+  int result =3D check_namespace (fd);=0A=
+  close (fd);=0A=
+  return result;=0A=
+}=0A=

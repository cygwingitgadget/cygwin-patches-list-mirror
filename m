Return-Path: <SRS0=DBxI=I6=hotmail.com=safmswork@sourceware.org>
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010033.outbound.protection.outlook.com [52.103.10.33])
	by sourceware.org (Postfix) with ESMTPS id D23254B99F71
	for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2026 22:41:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D23254B99F71
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D23254B99F71
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=52.103.10.33
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1794264074; cv=pass;
	b=lRsYsmlr18EkCmBd84JfAY4151ZDqkd+DsqBIlEa+ddEX4Z9pxLESqJtjAXxkRVj5ud0dSauQmC8yLVj8mclsOW7IATFrqQYWN0lRzVVDnG4/pnj/hdWvajgq3cVyu+1EI2rTRPaYWGm5xToepkj1LtUnJ4IgSBaP2QG6jyGWtU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794264074; c=relaxed/simple;
	bh=O1XfMMgfHa31fdH0FaYuTSV3B2QSQE0yw35TaKlOCuk=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=cNas0dnfHfwcqLO94Mct4jlc++GzsvKz0d179+ZCBt1IztmJyHkt10z0KZ8gk0aySWqGtPnfDycpoydyPyNSXJS9edtnyEMO3bK0rLbbtbM+sjTK99AyAkRN/rfc9dJp/KTepw2GECrd9cMn9JIme3Qk3R0w3h7VawpYoTpoYjw=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=AzblFY2f
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D23254B99F71
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=AzblFY2f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tvjs0QufCtfCY4lwX8+DW5G2M2SnTaEfign5az/CzYI2EvhV2Z8FchOI/UAQgw2rli/q0d1JXqQl6aRfPUdufcLTjgyVDljYb8HNeKl5VLV8kttFahKfKLqjtPWuu0Rx48d8wHSifXL7xVncT6iZ+BnWRMS/k5tImF+lI365E7m6LoI7kTiewkkZJ4cEa6BA2Ob6m31766Wenqbmrxkpuy4/6HMppXqW0Gn40UhV5E2qgq7EoHm9D+YzEkKai2Azy90dbYEgrdUgE6TAAAsdWF1OU9uJLwNLysR4Pw4HcuerLzO9PRymltXZkvsNHtNdR/K//wfSJcsx0TsfyzNf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/BQDpEfURXRWxmaVPCOWPpNodfdSMh6HQyGNHd6yyQ=;
 b=voEJO8wnp1ux0U4q6epD8u27dgkeW9SMitI+jvH1HLTwCYIbrOnfi4dfzBfVXg/+6/73QFnYuXvWBclGvrzAXMPF/CZchQ/CdjFcfzInVfUeZWttr2tYA4VaAJ1kAS1G45gTOFDxsx5HQYC/E9Dhk+dHqJ5Yp9agpMWAk7ULmJVwdHFwQ98kGXC0VCNrOWOOJzvh58SAEFynIK5E79rXeTefTZsQLWaZZlE31/Mc+JSukBxQfvFSjio7vWYpLb+yGalPdqJP1NQJOH6Vy2UCgcbkVZVzV8am0xXNZSfXNCCpjuuRcSI5eXdayS+jw413HPOxGtrDlt1uK07gE65HCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/BQDpEfURXRWxmaVPCOWPpNodfdSMh6HQyGNHd6yyQ=;
 b=AzblFY2fv+ftuXLXsfrWiRrhC7xRPce+A4qmw04z/HTdbWm4xwFhNJlipMRruv88j82dsKvv/arIJseqiND3FStRYKyCrvb9TZvhr4EQby6evijmMiWTryql32MNfOiE7XskTjFGs0PMaBugacxRFx4KwHMMIJeI8ZNv1dpxiRkxl2dNho+z87clVZvkN7qis9ekm1EGFBk824CyQRyn+IyNSFLINtu1xNu/75AnjpYtACIGDps+Cfs9DVJD6FTkVTjGFRpMHiKHttRHzYHmz52poQzGsIVfeK3/3jrCKZ0VyrdULiGAXfAlZD8Py0jLji6PPLkQ5ppQj/cwIwpMKA==
Received: from BN8PR19MB2434.namprd19.prod.outlook.com (2603:10b6:408:9c::17)
 by DM4PR19MB5761.namprd19.prod.outlook.com (2603:10b6:8:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 22:41:07 +0000
Received: from BN8PR19MB2434.namprd19.prod.outlook.com
 ([fe80::f64b:eb79:a6fe:e2d]) by BN8PR19MB2434.namprd19.prod.outlook.com
 ([fe80::f64b:eb79:a6fe:e2d%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 22:41:04 +0000
From: Safet Hrbinic <safmswork@hotmail.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
	"anisk@microsoft.com" <anisk@microsoft.com>
Subject: Re: Fixing cygwin DLL initialization in AppContainer Process
Thread-Topic: Fixing cygwin DLL initialization in AppContainer Process
Thread-Index: AQHdcJTcokbc8ToT3E2NW4qFo6euI7cmVXkq
Date: Mon, 9 Nov 2026 22:41:04 +0000
Message-ID:
 <BN8PR19MB2434EF5E0D72955EF6BEC1A8A4732@BN8PR19MB2434.namprd19.prod.outlook.com>
References:
 <BN8PR19MB24340B09A742AE4567DD45AAA4732@BN8PR19MB2434.namprd19.prod.outlook.com>
In-Reply-To:
 <BN8PR19MB24340B09A742AE4567DD45AAA4732@BN8PR19MB2434.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB2434:EE_|DM4PR19MB5761:EE_
x-ms-office365-filtering-correlation-id: c1117027-0841-4cba-dbc2-08df3eb289ad
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|12121999013|4140399003|25010399006|19110799012|8062599012|15080799012|24021099003|31061999003|15030799006|41001999006|1602099012|10035399007|52005399003|40105399003|102099032|4302099013|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JPsAaGVfrXn6uOQAPIA6DPTtFnfqiSMR9q/iCqDd4VgQAj3gIPVLZNYzhjzB?=
 =?us-ascii?Q?ZsL7sdKNRTAroxBPL15GYfzOYdts5OqDtpdy3wRvbp0hEWlTNuRM97eTQ/Hn?=
 =?us-ascii?Q?IXiHKvD3tJX00pPGD62apKj9RtK9V3dUx6a6JNrdSgW3uWZkBDMlgQeWLRnS?=
 =?us-ascii?Q?VEkiJ31i1mn3U0dqggyc66afe+QGAbyc+W8Bg4GSicpZ9+z8/UTzOerCnEnA?=
 =?us-ascii?Q?BcjRx1HGwELNZFR+Z0K08B/8XS4uyHoR16k29/5n6MaMdWf6744w+x1sgDjn?=
 =?us-ascii?Q?/dEEJsMv30YM9XMLWtMHSuWnF1zkriWa3NpAjPcG91gdfpXLPZQhrgYYo3J6?=
 =?us-ascii?Q?o4mB9rdM+AWxkhegR8raMAWlHxJLctCkKDcoLcfRFkL2wDibGXrwXuO5h370?=
 =?us-ascii?Q?uFLKw8FutYPCYhj9ChljWrotWdrOy3TjJckJDBJ/qJ6UuSR2SFiqbs97X44+?=
 =?us-ascii?Q?gOfnhSqy/urY7wi3jP0ZBVHH7RMUwXU7hpkNFiylJsCFTSLCU1mqDm/TaARV?=
 =?us-ascii?Q?d/eS4fX2c2qnZcFQVnqslixQmXkTtaqnEVjDLlCvWLBpgJikULShkpeSLgNx?=
 =?us-ascii?Q?YjD8HDqgbgD8ViZJe1dGbfsXRFDWl3GIg3zsbUtTYwkn/jS4R3S5BPL9YZZ8?=
 =?us-ascii?Q?sW4XITOb/Qum9/mNkbk+e0FO8jZAA4RnVXDgTkua54pK/mqwUFoZI3/TCQLM?=
 =?us-ascii?Q?ZWhQsrii1BJUV3aEbJxjDaOW1JUqjjcRDzw0O6Jx4l1zJaYhqjsj/G0qHVmf?=
 =?us-ascii?Q?Q8GRyFMDVgRACNU4WzxQ+5xifxRQWQfFrH38LibQTxM8muEtqWxkPSFpCobU?=
 =?us-ascii?Q?dLrxKCnVLqXaj/aM5iAfC7wK6cRDO+sl/0yzEZap7k6NR8+GSbsIYeSdLEI9?=
 =?us-ascii?Q?Um8jaVayav28lIqFcRWU1e4GlgFELgylfEQySUp4tRTNIeRhqxGXFuqJfEKy?=
 =?us-ascii?Q?PpeDRjipLa1mdTtMRToS9DoRc5Onb7hEb2Z6uvQDxXBPe0OjfeKMjyg2pq0N?=
 =?us-ascii?Q?hoBjlcE8LgHEdo704Z5d91HuhL0NTzoaV9u/qOj6a0Kyfj32rOBbXe/u/5nk?=
 =?us-ascii?Q?PUKoPqsS?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZjkV8/VBI1zwVqCHjzKIi29L4yHn64JQq+lmG2mRV4bjTSlAt6f5TOT4bUJA?=
 =?us-ascii?Q?cel0DAJOx+Dk6XRpJUAvVwS3Q5SBvOIeaen/0otXmvp52ubCKmOJEJnlWc3Z?=
 =?us-ascii?Q?o5pENw0IqJnqUmEHtlpt7TA9U4s8bBFtIf25kgN8s5VrFKGqvdSghB0S2MKr?=
 =?us-ascii?Q?DqZ7eBqLyn1tyW5O+WcSM6xTYLHERYhoIfi3hzS/56lfyXgI0VvZ9Iifrwfl?=
 =?us-ascii?Q?09AGFx14q8eTlzIBdwLViBy7MSmg6HpbJ7imq3BT2sesHjy/YFESRYN6xwZx?=
 =?us-ascii?Q?dejOklP2BA7IwGQneT2rb03Guf08ek5w7IeyokxtWO5ZH0HxJ2p3JV1fTVKv?=
 =?us-ascii?Q?N3sIe4HB0CCpFVLX6ek7YLpf0AJbnJZtoteinZn71tniJkNVIaIGncCPOEqh?=
 =?us-ascii?Q?fyTrd1NEpBIMxTMP/JhAyfwjMjkCCuGpbW9bqnUnoFCmtCqyFxWBan/nl2CC?=
 =?us-ascii?Q?d6dmSlBPKDb4WybKEiE4TB1n+Msu/Aa44JZ9vK5BAa+vAZt7lLzBNbOXSB8v?=
 =?us-ascii?Q?WtrwbSOL5PvL1yr1rMoQcdpzbSV4cD45s+Ue+jReYY0k6oqOdRnzyZqg/p0I?=
 =?us-ascii?Q?uALKN1MhdOOpkZwmhQClPrl/9yDnAf3/U17oR3FQVQFYMOyXpAw+AuKzkmwL?=
 =?us-ascii?Q?Uak9wINvY16htLl+UFZmAx1+tG6SBn5v8rgrILyJA3aBuotIFkIRQqfY63sc?=
 =?us-ascii?Q?fD2KjDzVyEPAksjehKW0ikHnzgHPQgFXlG6Jwl3AfiuqjGeMzxZ5uCBVmL90?=
 =?us-ascii?Q?hiY24wOTIHF47kru0N2W43QCiH0QY5WlnOz65bYlp61I3jMrqQrMLNTvACzz?=
 =?us-ascii?Q?J8v3rX6kYolhfz1ojiNfrxYGNCIUKM3GLwROyNXl4rneukUkJ/kD+gIBZjfd?=
 =?us-ascii?Q?jVFmHPaaEzquTDFN1XlLzHC0DEEHDSPhjww0eFT84CwMbTJ27/vC8+n8v/Gj?=
 =?us-ascii?Q?w0wTaHBfqxhV95J0ScZZC1P9KURR5URS2vXuxixuhXr2pkA5MfEUpVic94dU?=
 =?us-ascii?Q?M9pe3HnzQ1kdMjn5pjirUAAWtVy16cegrqQ7YaM7mPloSesP5VySGvz/k6J6?=
 =?us-ascii?Q?gRcncUc1cdRMhGQQTgSAACO/l19H+B9mLX8QlCndkOzS3CSgaP8XsYOpYztv?=
 =?us-ascii?Q?vzOkdHIMRJnPE9MSUQg4VD0zG4IA1U7d44ujaU+IqSjsKyDwx2U3qvLfMae2?=
 =?us-ascii?Q?C1TDT+OJL8hweXQUhae1e0L4aVj2KzmCS89JvE1mA7itCmuvIb0yErfqs3Aq?=
 =?us-ascii?Q?eTwjQ9zJ3iBteFlqIpHKtA5+qeVoALGAvGL1USFuxjHqhqAVX7oV55aTwfOf?=
 =?us-ascii?Q?oLDRI5YR++W9YgrezICZvA4mNuzAD5TfMmP6eO+viDjc99BWTrA5soyMd5Na?=
 =?us-ascii?Q?eoQU3aE=3D?=
Content-Type: multipart/alternative;
	boundary="_000_BN8PR19MB2434EF5E0D72955EF6BEC1A8A4732BN8PR19MB2434namp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB2434.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c1117027-0841-4cba-dbc2-08df3eb289ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 22:41:04.4357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5761
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GB_MSAUTHSOURCE_NORTHAM,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_BN8PR19MB2434EF5E0D72955EF6BEC1A8A4732BN8PR19MB2434namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

+another interested party
________________________________
From: Safet Hrbinic
Sent: Monday, November 9, 2026 2:14 PM
To: cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>
Cc: johannes.schindelin@gmx.de <johannes.schindelin@gmx.de>
Subject: Fixing cygwin DLL initialization in AppContainer Process

Greetings! There is an existing issue in the cygwin.dll where initializatio=
n of the DLL fails if it is running in an AppContainer process. The failure=
 happens in winsup\cygwin\mm\shared.cc , where the code calls NtCreateDirec=
toryObject using the global \\BaseNamedObjects<file://\\BaseNamedObjects> n=
amespace. AppContainer processes are not allowed to create directory object=
s in the global namespaces, and so this fails.

The fix at a high level is simple. AppContainer processes are given their o=
wn private namespace to create directory objects within. So the change is s=
imply:
if(AppContainerProcess())
{
  appContainerNamespace =3D GetAppContainerNamespace
  NtCreateDirectoryObject(appContainerNamespace)
} else
{
 // do as before change
 NtCreateDirectoryObject(\\BaseNamedObjects\...)
}

Also added automated coverage using a native launcher and a Cygwin-linked c=
hild which verifies its AppContainer token and build-tree runtime, then tes=
ts startup and flock locking. Include the socket event-sharing regression t=
est from the branch.

Note: I've never contributed to open source before so please let me know if=
 there is anything else I need to add/remove from this email :)

Thanks
-Safet Hrbinic

I provide my changes to the Cygwin sources in this patch under the 2-clause=
 BSD license.
Signed-off-by: Safet Hrbinic <sahrbini@microsoft.com>
---
 winsup/cygwin/autoload.cc                     |   1 +
 winsup/cygwin/environ.cc                      |   1 +
 winsup/cygwin/fhandler/pipe.cc                |  27 +-
 winsup/cygwin/fhandler/socket_inet.cc         |  45 +-
 winsup/cygwin/kernel32.cc                     |  44 +-
 winsup/cygwin/local_includes/fhandler.h       |   1 +
 winsup/cygwin/local_includes/security.h       |   8 +-
 winsup/cygwin/local_includes/shared_info.h    |   2 +
 winsup/cygwin/mm/shared.cc                    | 145 +++++
 winsup/cygwin/sec/helper.cc                   | 118 +++-
 winsup/cygwin/syscalls.cc                     |   2 +-
 winsup/cygwin/wincap.cc                       |   2 +-
 winsup/testsuite/Makefile.am                  |  12 +
 winsup/testsuite/mingw/Makefile.am            |   8 +-
 .../testsuite/mingw/appcontainer-launcher.cc  | 579 ++++++++++++++++++
 .../testsuite/winsup.api/appcontainer-child.c | 141 +++++
 .../winsup.api/socket-event-sharing.c         | 142 +++++
 17 files changed, 1253 insertions(+), 25 deletions(-)
 create mode 100644 winsup/testsuite/mingw/appcontainer-launcher.cc
 create mode 100644 winsup/testsuite/winsup.api/appcontainer-child.c
 create mode 100644 winsup/testsuite/winsup.api/socket-event-sharing.c

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index 7054511b6..58714ef5b 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -597,6 +597,7 @@ LoadDLLfuncEx (ResizePseudoConsole, kernel32, 1)
 LoadDLLfunc (QueryInterruptTime, KernelBase)
 LoadDLLfunc (QueryInterruptTimePrecise, KernelBase)
 LoadDLLfunc (QueryUnbiasedInterruptTimePrecise, KernelBase)
+LoadDLLfunc (GetAppContainerNamedObjectPath, KernelBase)
 LoadDLLfuncEx (SetThreadDescription, KernelBase, 1)
 LoadDLLfunc (VirtualAlloc2, KernelBase)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 956a04a0c..94963ecbb 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -956,6 +956,7 @@ static NO_COPY spenv spenvs[] =3D
 #ifdef DEBUGGING
   {NL ("CYGWIN_DEBUG=3D"), false, true, NULL},
 #endif
+  {NL ("CYGWIN_TESTING=3D"), false, true, NULL},
   {NL ("HOMEDRIVE=3D"), false, false, &cygheap_user::env_homedrive},
   {NL ("HOMEPATH=3D"), false, false, &cygheap_user::env_homepath},
   {NL ("LOGONSERVER=3D"), false, false, &cygheap_user::env_logsrv},
diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 2312688e1..cefaabe30 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -817,8 +817,16 @@ fhandler_pipe::create (LPSECURITY_ATTRIBUTES sa_ptr, P=
HANDLE r, PHANDLE w,
     psize =3D DEFAULT_PIPEBUFSIZE;

   char pipename[MAX_PATH];
-  size_t len =3D __small_sprintf (pipename, PIPE_INTRO "%S-",
-                                     &cygheap->installation_key);
+  size_t len;
+  if (appcontainer_sid ())
+    {
+      /* AppContainer named pipes must be scoped to the LOCAL namespace. */
+      len =3D __small_sprintf (pipename, "\\\\.\\pipe\\LOCAL\\cygwin-%S-",
+                            &cygheap->installation_key);
+    }
+  else
+    len =3D __small_sprintf (pipename, PIPE_INTRO "%S-",
+                          &cygheap->installation_key);
   DWORD pipe_mode =3D PIPE_READMODE_BYTE | PIPE_REJECT_REMOTE_CLIENTS;
   if (!name)
     pipe_mode |=3D pipe_byte ? PIPE_TYPE_BYTE : PIPE_TYPE_MESSAGE;
@@ -1054,9 +1062,18 @@ nt_create (LPSECURITY_ATTRIBUTES sa_ptr, HANDLE &r, =
HANDLE &w, DWORD psize,

   UNICODE_STRING pipename;
   WCHAR pipename_buf[MAX_PATH];
-  size_t len =3D __small_swprintf (pipename_buf, L"%S-%u-",
-                                &cygheap->installation_key,
-                                GetCurrentProcessId ());
+  size_t len;
+  if (appcontainer_sid ())
+    {
+      /* Match the Win32 CreateNamedPipe path above. */
+      len =3D __small_swprintf (pipename_buf, L"LOCAL\\%S-%u-",
+                             &cygheap->installation_key,
+                             GetCurrentProcessId ());
+    }
+  else
+    len =3D __small_swprintf (pipename_buf, L"%S-%u-",
+                           &cygheap->installation_key,
+                           GetCurrentProcessId ());

   access =3D GENERIC_READ | FILE_WRITE_ATTRIBUTES | SYNCHRONIZE;

diff --git a/winsup/cygwin/fhandler/socket_inet.cc b/winsup/cygwin/fhandler=
/socket_inet.cc
index 5ed0cb0ec..aadf09111 100644
--- a/winsup/cygwin/fhandler/socket_inet.cc
+++ b/winsup/cygwin/fhandler/socket_inet.cc
@@ -70,12 +70,44 @@
       ReleaseMutex (wsock_mtx); \
     }

-static wsa_event wsa_events[NUM_SOCKS] __attribute__((section (".cygwin_dl=
l_common"), shared));
+struct wsa_shared_data
+{
+  LONG socket_serial_number;
+  wsa_event events[NUM_SOCKS];
+};

-static LONG socket_serial_number __attribute__((section (".cygwin_dll_comm=
on"), shared));
+static wsa_shared_data NO_COPY *wsa_shared;
+static HANDLE NO_COPY wsa_shared_h;

 static HANDLE wsa_slot_mtx;

+void
+wsock_init ()
+{
+  UNICODE_STRING uname;
+  OBJECT_ATTRIBUTES attr;
+  LARGE_INTEGER size =3D { .QuadPart =3D sizeof (wsa_shared_data) };
+
+  /* The table and its liveness mutexes must use the same namespace. */
+  RtlInitUnicodeString (&uname, L"socket-events.1");
+  InitializeObjectAttributes (&attr, &uname, OBJ_OPENIF,
+                             get_session_parent_dir (),
+                             everyone_sd (SECTION_ALL_ACCESS));
+  NTSTATUS status =3D NtCreateSection (&wsa_shared_h, SECTION_ALL_ACCESS, =
&attr,
+                                   &size, PAGE_READWRITE, SEC_COMMIT, NULL=
);
+  if (!NT_SUCCESS (status))
+    api_fatal ("Couldn't create/open shared socket table: %y", status);
+  wsa_shared =3D (wsa_shared_data *)
+    open_shared (NULL, 0, wsa_shared_h, sizeof (wsa_shared_data), SH_JUSTC=
REATE);
+}
+
+void
+wsock_destroy ()
+{
+  UnmapViewOfFile (wsa_shared);
+  ForceCloseHandle (wsa_shared_h);
+}
+
 static PWCHAR
 sock_shared_name (PWCHAR buf, LONG num)
 {
@@ -86,6 +118,7 @@ sock_shared_name (PWCHAR buf, LONG num)
 static wsa_event *
 search_wsa_event_slot (LONG new_serial_number)
 {
+  wsa_event *wsa_events =3D wsa_shared->events;
   WCHAR name[32], searchname[32];
   UNICODE_STRING uname;
   OBJECT_ATTRIBUTES attr;
@@ -185,6 +218,7 @@ get_ext_funcptr (SOCKET sock, void *funcptr)
 fhandler_socket_wsock::fhandler_socket_wsock () :
   fhandler_socket (),
   wsock_events (NULL),
+  wsock_slot (0),
   wsock_mtx (NULL),
   wsock_evt (NULL),
   status (),
@@ -211,9 +245,9 @@ fhandler_socket_wsock::init_events ()
   do
     {
       new_serial_number =3D
-       InterlockedIncrement (&socket_serial_number);
+       InterlockedIncrement (&wsa_shared->socket_serial_number);
       if (!new_serial_number)  /* 0 is reserved for global mutex */
-       InterlockedIncrement (&socket_serial_number);
+       InterlockedIncrement (&wsa_shared->socket_serial_number);
       set_ino (new_serial_number);
       RtlInitUnicodeString (&uname, sock_shared_name (name, new_serial_num=
ber));
       InitializeObjectAttributes (&attr, &uname, OBJ_INHERIT | OBJ_OPENIF,
@@ -253,6 +287,7 @@ fhandler_socket_wsock::init_events ()
       NtClose (wsock_mtx);
       return false;
     }
+  wsock_slot =3D wsock_events - wsa_shared->events;
   if (get_socket_type () =3D=3D SOCK_DGRAM)
     wsock_events->events =3D FD_WRITE;
   return true;
@@ -503,6 +538,7 @@ fhandler_socket_wsock::fixup_before_fork_exec (DWORD wi=
n_pid)
 void
 fhandler_socket_wsock::fixup_after_fork (HANDLE parent)
 {
+  wsock_events =3D wsa_shared->events + wsock_slot;
   fork_fixup (parent, wsock_mtx, "wsock_mtx");
   fork_fixup (parent, wsock_evt, "wsock_evt");

@@ -533,6 +569,7 @@ fhandler_socket_wsock::fixup_after_fork (HANDLE parent)
 void
 fhandler_socket_wsock::fixup_after_exec ()
 {
+  wsock_events =3D wsa_shared->events + wsock_slot;
   if (need_fixup_before () && !close_on_exec ())
     fixup_after_fork (NULL);   /* No parent handle required. */
 }
diff --git a/winsup/cygwin/kernel32.cc b/winsup/cygwin/kernel32.cc
index f07f80d59..25d50f559 100644
--- a/winsup/cygwin/kernel32.cc
+++ b/winsup/cygwin/kernel32.cc
@@ -19,6 +19,19 @@ details. */
 #include "winf.h"
 #include "sys/cygwin.h"

+static bool
+has_non_null_dacl (PSECURITY_DESCRIPTOR psd)
+{
+  BOOLEAN present;
+  BOOLEAN defaulted;
+  PACL dacl;
+
+  return psd
+        && NT_SUCCESS (RtlGetDaclSecurityDescriptor (psd, &present, &dacl,
+                                                     &defaulted))
+        && present && dacl;
+}
+
 /* Implement CreateEvent/OpenEvent so that named objects are always create=
d in
    Cygwin shared object namespace. */

@@ -39,10 +52,13 @@ CreateEventW (LPSECURITY_ATTRIBUTES lpEventAttributes, =
BOOL bManualReset,
       RtlInitUnicodeString (&uname, lpName);
       flags |=3D OBJ_OPENIF | OBJ_CASE_INSENSITIVE;
     }
+  PSECURITY_DESCRIPTOR psd
+    =3D lpEventAttributes ? lpEventAttributes->lpSecurityDescriptor : NULL;
+  if (lpName && appcontainer_sid () && !has_non_null_dacl (psd))
+    psd =3D appcontainer_sd (EVENT_ALL_ACCESS);
   InitializeObjectAttributes (&attr, lpName ? &uname : NULL, flags,
                               lpName ? get_shared_parent_dir () : NULL,
-                             lpEventAttributes
-                             ? lpEventAttributes->lpSecurityDescriptor : N=
ULL);
+                             psd);
   status =3D NtCreateEvent (&evt, EVENT_ALL_ACCESS, &attr,
                           bManualReset ? NotificationEvent
                                        : SynchronizationEvent,
@@ -133,10 +149,13 @@ CreateMutexW (LPSECURITY_ATTRIBUTES lpMutexAttributes=
, BOOL bInitialOwner,
       RtlInitUnicodeString (&uname, lpName);
       flags |=3D OBJ_OPENIF | OBJ_CASE_INSENSITIVE;
     }
+  PSECURITY_DESCRIPTOR psd
+    =3D lpMutexAttributes ? lpMutexAttributes->lpSecurityDescriptor : NULL;
+  if (lpName && appcontainer_sid () && !has_non_null_dacl (psd))
+    psd =3D appcontainer_sd (MUTEX_ALL_ACCESS);
   InitializeObjectAttributes (&attr, lpName ? &uname : NULL, flags,
                               lpName ? get_shared_parent_dir () : NULL,
-                             lpMutexAttributes
-                             ? lpMutexAttributes->lpSecurityDescriptor : N=
ULL);
+                             psd);
   status =3D NtCreateMutant (&mtx, MUTEX_ALL_ACCESS, &attr, bInitialOwner);
   if (!NT_SUCCESS (status))
     {
@@ -223,11 +242,14 @@ CreateSemaphoreW (LPSECURITY_ATTRIBUTES lpSemaphoreAt=
tributes,
       RtlInitUnicodeString (&uname, lpName);
       flags |=3D OBJ_OPENIF | OBJ_CASE_INSENSITIVE;
     }
+  PSECURITY_DESCRIPTOR psd
+    =3D lpSemaphoreAttributes
+      ? lpSemaphoreAttributes->lpSecurityDescriptor : NULL;
+  if (lpName && appcontainer_sid () && !has_non_null_dacl (psd))
+    psd =3D appcontainer_sd (SEMAPHORE_ALL_ACCESS);
   InitializeObjectAttributes (&attr, lpName ? &uname : NULL, flags,
                               lpName ? get_shared_parent_dir () : NULL,
-                             lpSemaphoreAttributes
-                             ? lpSemaphoreAttributes->lpSecurityDescriptor
-                             : NULL);
+                             psd);
   status =3D NtCreateSemaphore (&sem, SEMAPHORE_ALL_ACCESS, &attr,
                               lInitialCount, lMaximumCount);
   if (!NT_SUCCESS (status))
@@ -334,11 +356,13 @@ CreateFileMappingW (HANDLE hFile, LPSECURITY_ATTRIBUT=
ES lpAttributes,
       RtlInitUnicodeString (&uname, lpName);
       flags |=3D OBJ_OPENIF | OBJ_CASE_INSENSITIVE;
     }
+  PSECURITY_DESCRIPTOR psd
+    =3D lpAttributes ? lpAttributes->lpSecurityDescriptor : NULL;
+  if (lpName && appcontainer_sid () && !has_non_null_dacl (psd))
+    psd =3D appcontainer_sd (SECTION_ALL_ACCESS);
   InitializeObjectAttributes (&attr, lpName ? &uname : NULL, flags,
                               lpName ? get_shared_parent_dir () : NULL,
-                             lpAttributes
-                             ? lpAttributes->lpSecurityDescriptor
-                             : NULL);
+                             psd);
   if (!(attribs & (SEC_RESERVE | SEC_COMMIT)))
     attribs |=3D SEC_COMMIT;
   if (hFile =3D=3D INVALID_HANDLE_VALUE)
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_=
includes/fhandler.h
index d37c604f2..fa3ad24d2 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -659,6 +659,7 @@ class fhandler_socket_wsock: public fhandler_socket

  protected:
   wsa_event *wsock_events;
+  unsigned int wsock_slot;
   HANDLE wsock_mtx;
   HANDLE wsock_evt;
   bool init_events ();
diff --git a/winsup/cygwin/local_includes/security.h b/winsup/cygwin/local_=
includes/security.h
index b31edfe26..9f5106b59 100644
--- a/winsup/cygwin/local_includes/security.h
+++ b/winsup/cygwin/local_includes/security.h
@@ -48,7 +48,7 @@ bool check_token_membership (PSID);
 #define MAX_DACL_LEN(n) (sizeof (ACL) \
                    + (n) * (sizeof (ACCESS_ALLOWED_ACE) - sizeof (DWORD) \
                             + SECURITY_MAX_SID_SIZE))
-#define SD_MIN_SIZE (sizeof (SECURITY_DESCRIPTOR) + MAX_DACL_LEN (1))
+#define SD_MIN_SIZE (sizeof (SECURITY_DESCRIPTOR) + MAX_DACL_LEN (2))
 #define ACL_MAXIMUM_SIZE 65532  /* Yeah, right.  64K - sizeof (DWORD). */
 #define SD_MAXIMUM_SIZE 65536
 #define NO_SID ((PSID)NULL)
@@ -522,6 +522,12 @@ extern PSECURITY_DESCRIPTOR _recycler_sd (void *buf, b=
ool users, bool dir);
 extern PSECURITY_DESCRIPTOR _everyone_sd (void *buf, ACCESS_MASK access);
 #define everyone_sd(access)     (_everyone_sd (alloca (SD_MIN_SIZE), (acce=
ss)))

+extern PSID appcontainer_sid ();
+extern PSECURITY_DESCRIPTOR _appcontainer_sd (void *buf, ACCESS_MASK acces=
s);
+#define appcontainer_sd(access) \
+  (_appcontainer_sd (alloca (sizeof (SECURITY_DESCRIPTOR) \
+                            + MAX_DACL_LEN (3)), (access)))
+
 #define sec_none_cloexec(f) (((f) & O_CLOEXEC ? &sec_none_nih : &sec_none))

 extern bool sec_acl (PACL acl, bool original, bool admins, PSID sid1 =3D N=
O_SID,
diff --git a/winsup/cygwin/local_includes/shared_info.h b/winsup/cygwin/loc=
al_includes/shared_info.h
index 4316717a9..f826a3b95 100644
--- a/winsup/cygwin/local_includes/shared_info.h
+++ b/winsup/cygwin/local_includes/shared_info.h
@@ -79,6 +79,8 @@ enum shared_locations

 void memory_init ();
 void shared_destroy ();
+void wsock_init ();
+void wsock_destroy ();

 #define shared_align_past(p) \
   ((char *) (system_info.dwAllocationGranularity * \
diff --git a/winsup/cygwin/mm/shared.cc b/winsup/cygwin/mm/shared.cc
index 7977df382..2544b74d4 100644
--- a/winsup/cygwin/mm/shared.cc
+++ b/winsup/cygwin/mm/shared.cc
@@ -21,6 +21,8 @@ details. */
 #include "cygwin_version.h"
 #include "memory_layout.h"
 #include "spinlock.h"
+#include "tls_pbuf.h"
+#include <securityappcontainer.h>
 #include <alloca.h>
 #include <wchar.h>

@@ -33,6 +35,123 @@ HANDLE NO_COPY cygwin_user_h;
    NT namespace used to implement global objects including shared memory. =
*/

 static HANDLE NO_COPY shared_parent_dir;
+static HANDLE NO_COPY appcontainer_parent_dir;
+
+static bool
+is_appcontainer_process ()
+{
+  return appcontainer_sid () !=3D NULL;
+}
+
+static HANDLE
+get_appcontainer_parent_dir ()
+{
+  if (!appcontainer_parent_dir)
+    {
+      tmp_pathbuf tp;
+      PWCHAR path =3D tp.w_get ();
+      if (__in_forkee =3D=3D FORKING)
+       {
+         WCHAR sidbuf[UNLEN + 1];
+         UNICODE_STRING sid;
+         RtlInitEmptyUnicodeString (&sid, sidbuf, sizeof sidbuf);
+         NTSTATUS status
+           =3D RtlConvertSidToUnicodeString (&sid, appcontainer_sid (), FA=
LSE);
+         if (!NT_SUCCESS (status))
+           api_fatal ("RtlConvertSidToUnicodeString(AppContainer): %y",
+                      status);
+
+         PROCESS_SESSION_INFORMATION psi;
+         status =3D NtQueryInformationProcess (NtCurrentProcess (),
+                                             ProcessSessionInformation,
+                                             &psi, sizeof psi, NULL);
+         if (!NT_SUCCESS (status))
+           api_fatal ("NtQueryInformationProcess"
+                      "(ProcessSessionInformation): %y", status);
+
+         __small_swprintf (path,
+                           L"\\Sessions\\%u\\AppContainerNamedObjects\\%S<=
file://\\Sessions\\%u\\AppContainerNamedObjects\\%S>",
+                           psi.SessionId, &sid);
+       }
+      else
+       {
+         ULONG required =3D 0;
+         GetAppContainerNamedObjectPath (hProcToken, NULL, 0, NULL,
+                                         &required);
+         if (!required || required > NT_MAX_PATH)
+           api_fatal ("GetAppContainerNamedObjectPath(size %u), %E",
+                      required);
+
+         ULONG returned =3D 0;
+         if (!GetAppContainerNamedObjectPath (hProcToken, NULL, required,
+                                              path, &returned))
+           api_fatal ("GetAppContainerNamedObjectPath, %E");
+         if (!returned || returned > required
+             || wcsnlen (path, required) >=3D required)
+           api_fatal ("GetAppContainerNamedObjectPath returned invalid len=
gth "
+                      "%u (buffer length %u)", returned, required);
+
+         if (path[0] !=3D L'\\')
+           {
+             PROCESS_SESSION_INFORMATION psi;
+             NTSTATUS status
+               =3D NtQueryInformationProcess (NtCurrentProcess (),
+                                            ProcessSessionInformation,
+                                            &psi, sizeof psi, NULL);
+             if (!NT_SUCCESS (status))
+               api_fatal ("NtQueryInformationProcess"
+                          "(ProcessSessionInformation): %y", status);
+
+             size_t path_len =3D wcslen (path);
+             if (path_len + 32 >=3D NT_MAX_PATH)
+               api_fatal ("AppContainer named object path is too long");
+             PWCHAR absolute_path =3D tp.w_get ();
+             __small_swprintf (absolute_path, L"\\Sessions\\%u\\%W<file://=
\\Sessions\\%u\\%W>",
+                               psi.SessionId, path);
+             path =3D absolute_path;
+           }
+       }
+
+      UNICODE_STRING uname;
+      OBJECT_ATTRIBUTES attr;
+      RtlInitUnicodeString (&uname, path);
+      InitializeObjectAttributes (&attr, &uname, OBJ_CASE_INSENSITIVE, NUL=
L,
+                                 NULL);
+      NTSTATUS status
+       =3D NtOpenDirectoryObject (&appcontainer_parent_dir,
+                                CYG_SHARED_DIR_ACCESS, &attr);
+      if (!NT_SUCCESS (status))
+       api_fatal ("NtOpenDirectoryObject(%S): %y", &uname, status);
+    }
+  return appcontainer_parent_dir;
+}
+
+static HANDLE
+create_appcontainer_dir (HANDLE root, PCWSTR name)
+{
+  HANDLE dir;
+  UNICODE_STRING uname;
+  OBJECT_ATTRIBUTES attr;
+  RtlInitUnicodeString (&uname, name);
+  NTSTATUS status;
+  if (__in_forkee =3D=3D FORKING)
+    {
+      InitializeObjectAttributes (&attr, &uname, OBJ_CASE_INSENSITIVE, roo=
t,
+                                 NULL);
+      status =3D NtOpenDirectoryObject (&dir, CYG_SHARED_DIR_ACCESS, &attr=
);
+    }
+  else
+    {
+      InitializeObjectAttributes (&attr, &uname, OBJ_OPENIF, root,
+                                 appcontainer_sd (CYG_SHARED_DIR_ACCESS));
+      status =3D NtCreateDirectoryObject (&dir, CYG_SHARED_DIR_ACCESS, &at=
tr);
+    }
+  if (!NT_SUCCESS (status))
+    api_fatal ("%sDirectoryObject(%S): %y",
+              __in_forkee =3D=3D FORKING ? "NtOpen" : "NtCreate",
+              &uname, status);
+  return dir;
+}

 HANDLE
 get_shared_parent_dir ()
@@ -43,6 +162,18 @@ get_shared_parent_dir ()

   if (!shared_parent_dir)
     {
+      if (is_appcontainer_process ())
+       {
+         WCHAR bnoname[MAX_PATH];
+         __small_swprintf (bnoname, L"%s%s-%S",
+                           cygwin_version.shared_id,
+                           _cygwin_testing ? cygwin_version.dll_build_date=
 : "",
+                           &cygheap->installation_key);
+         shared_parent_dir
+           =3D create_appcontainer_dir (get_appcontainer_parent_dir (), bn=
oname);
+         return shared_parent_dir;
+       }
+
       WCHAR bnoname[MAX_PATH];
       __small_swprintf (bnoname, L"\\BaseNamedObjects\\%s%s-%S<file://\\Ba=
seNamedObjects\\%s%s-%S>",
                         cygwin_version.shared_id,
@@ -70,6 +201,18 @@ get_session_parent_dir ()

   if (!session_parent_dir)
     {
+      if (is_appcontainer_process ())
+       {
+         WCHAR bnoname[MAX_PATH];
+         __small_swprintf (bnoname, L"Session-%s%s-%S",
+                           cygwin_version.shared_id,
+                           _cygwin_testing ? cygwin_version.dll_build_date=
 : "",
+                           &cygheap->installation_key);
+         session_parent_dir
+           =3D create_appcontainer_dir (get_appcontainer_parent_dir (), bn=
oname);
+         return session_parent_dir;
+       }
+
       PROCESS_SESSION_INFORMATION psi;
       status =3D NtQueryInformationProcess (NtCurrentProcess (),
                                           ProcessSessionInformation,
@@ -248,6 +391,7 @@ user_info::create (bool reinit)
 void
 shared_destroy ()
 {
+  wsock_destroy ();
   ForceCloseHandle (cygwin_shared_h);
   UnmapViewOfFile (cygwin_shared);
   ForceCloseHandle (cygwin_user_h);
@@ -325,6 +469,7 @@ memory_init ()
   shared_info::create ();      /* Initialize global shared memory */
   cygheap->user_heap.init ();  /* Initialize user heap */
   user_info::create (false);   /* Initialize per-user shared memory */
+  wsock_init ();
   /* Initialize tty list session stuff.  Doesn't really belong here but
      this needs to be initialized before any tty or console manipulation
      happens and it is a common location.  */
diff --git a/winsup/cygwin/sec/helper.cc b/winsup/cygwin/sec/helper.cc
index 89090fc92..6150c17ff 100644
--- a/winsup/cygwin/sec/helper.cc
+++ b/winsup/cygwin/sec/helper.cc
@@ -24,6 +24,7 @@ details. */
 #include "cygheap.h"
 #include "ntdll.h"
 #include "ldap.h"
+#include "tls_pbuf.h"

 /* General purpose security attribute objects for global use. */
 static NO_COPY_RO SECURITY_DESCRIPTOR null_sdp =3D
@@ -94,6 +95,99 @@ MKSID (mandatory_system_integrity_sid, "S-1-16-16384",
 MKSID (well_known_samba_unix_user_fake_sid, "S-1-22-1-0",
        SECURITY_SAMBA_UNIX_AUTHORITY, 2, 1, 0);

+static bool NO_COPY appcontainer_sid_checked;
+static bool NO_COPY appcontainer_sid_valid;
+static ULONG NO_COPY
+  appcontainer_sid_buffer[(SECURITY_MAX_SID_SIZE + sizeof (ULONG) - 1)
+                         / sizeof (ULONG)];
+
+PSID
+appcontainer_sid ()
+{
+  if (!appcontainer_sid_checked)
+    {
+      ULONG is_appcontainer =3D 0;
+      ULONG size;
+      NTSTATUS status
+       =3D NtQueryInformationToken (hProcToken, TokenIsAppContainer,
+                                  &is_appcontainer, sizeof is_appcontainer,
+                                  &size);
+      if (!NT_SUCCESS (status))
+       api_fatal ("NtQueryInformationToken(TokenIsAppContainer): %y", stat=
us);
+      if (is_appcontainer)
+       {
+         tmp_pathbuf tp;
+         PTOKEN_APPCONTAINER_INFORMATION info
+           =3D (PTOKEN_APPCONTAINER_INFORMATION) tp.w_get ();
+         status =3D NtQueryInformationToken (hProcToken, TokenAppContainer=
Sid,
+                                           info, NT_MAX_PATH * sizeof (WCH=
AR),
+                                           &size);
+         if (!NT_SUCCESS (status))
+           api_fatal ("NtQueryInformationToken(TokenAppContainerSid): %y",
+                      status);
+         if (!info->TokenAppContainer)
+           api_fatal ("Missing AppContainer SID");
+         ULONG sid_len =3D RtlLengthSid (info->TokenAppContainer);
+         if (sid_len > sizeof appcontainer_sid_buffer)
+           api_fatal ("AppContainer SID is too long");
+         status =3D RtlCopySid (sizeof appcontainer_sid_buffer,
+                              appcontainer_sid_buffer,
+                              info->TokenAppContainer);
+         if (!NT_SUCCESS (status))
+           api_fatal ("RtlCopySid(AppContainer): %y", status);
+         appcontainer_sid_valid =3D true;
+       }
+      appcontainer_sid_checked =3D true;
+    }
+  return appcontainer_sid_valid ? (PSID) appcontainer_sid_buffer : NULL;
+}
+
+PSECURITY_DESCRIPTOR
+_appcontainer_sd (void *buf, ACCESS_MASK access)
+{
+  PSID app_sid =3D appcontainer_sid ();
+  if (!app_sid)
+    return NULL;
+
+  tmp_pathbuf tp;
+  PTOKEN_USER user =3D (PTOKEN_USER) tp.w_get ();
+  ULONG size;
+  NTSTATUS status
+    =3D NtQueryInformationToken (hProcToken, TokenUser, user,
+                              NT_MAX_PATH * sizeof (WCHAR), &size);
+  if (!NT_SUCCESS (status))
+    api_fatal ("NtQueryInformationToken(TokenUser): %y", status);
+
+  PISECURITY_DESCRIPTOR psd =3D (PISECURITY_DESCRIPTOR) buf;
+  status =3D RtlCreateSecurityDescriptor (psd, SECURITY_DESCRIPTOR_REVISIO=
N);
+  if (!NT_SUCCESS (status))
+    api_fatal ("RtlCreateSecurityDescriptor: %y", status);
+  PACL dacl =3D (PACL) (psd + 1);
+  status =3D RtlCreateAcl (dacl, MAX_DACL_LEN (3), ACL_REVISION);
+  if (!NT_SUCCESS (status))
+    api_fatal ("RtlCreateAcl: %y", status);
+  status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, access,
+                                  user->User.Sid);
+  if (!NT_SUCCESS (status))
+    api_fatal ("RtlAddAccessAllowedAce(user): %y", status);
+  status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, access, app_sid);
+  if (!NT_SUCCESS (status))
+    api_fatal ("RtlAddAccessAllowedAce(AppContainer): %y", status);
+  status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, GENERIC_ALL,
+                                  well_known_system_sid);
+  if (!NT_SUCCESS (status))
+    api_fatal ("RtlAddAccessAllowedAce(system): %y", status);
+  LPVOID ace;
+  status =3D RtlFirstFreeAce (dacl, &ace);
+  if (!NT_SUCCESS (status))
+    api_fatal ("RtlFirstFreeAce: %y", status);
+  dacl->AclSize =3D (char *) ace - (char *) dacl;
+  status =3D RtlSetDaclSecurityDescriptor (psd, TRUE, dacl, FALSE);
+  if (!NT_SUCCESS (status))
+    api_fatal ("RtlSetDaclSecurityDescriptor: %y", status);
+  return psd;
+}
+
 void
 cygpsid::debug_print (const char *prefix) const
 {
@@ -547,7 +641,7 @@ bool
 sec_acl (PACL acl, bool original, bool admins, PSID sid1, PSID sid2, DWORD=
 access2)
 {
   NTSTATUS status;
-  size_t acl_len =3D MAX_DACL_LEN (5);
+  size_t acl_len =3D MAX_DACL_LEN (6);
   LPVOID pAce;
   cygpsid psid;

@@ -591,6 +685,14 @@ sec_acl (PACL acl, bool original, bool admins, PSID si=
d1, PSID sid2, DWORD acces
                                    well_known_system_sid);
   if (!NT_SUCCESS (status))
     debug_printf ("RtlAddAccessAllowedAce(system) %y", status);
+  PSID app_sid =3D appcontainer_sid ();
+  if (app_sid)
+    {
+      status =3D RtlAddAccessAllowedAce (acl, ACL_REVISION, GENERIC_ALL,
+                                      app_sid);
+      if (!NT_SUCCESS (status))
+       debug_printf ("RtlAddAccessAllowedAce(AppContainer) %y", status);
+    }
   status =3D RtlFirstFreeAce (acl, &pAce);
   if (NT_SUCCESS (status) && pAce)
     acl->AclSize =3D (char *) pAce - (char *) acl;
@@ -693,7 +795,7 @@ _everyone_sd (void *buf, ACCESS_MASK access)
     {
       RtlCreateSecurityDescriptor (psd, SECURITY_DESCRIPTOR_REVISION);
       PACL dacl =3D (PACL) (psd + 1);
-      RtlCreateAcl (dacl, MAX_DACL_LEN (1), ACL_REVISION);
+      RtlCreateAcl (dacl, MAX_DACL_LEN (2), ACL_REVISION);
       status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, access,
                                        well_known_world_sid);
       if (!NT_SUCCESS (status))
@@ -701,6 +803,18 @@ _everyone_sd (void *buf, ACCESS_MASK access)
           debug_printf ("RtlAddAccessAllowedAce: %y", status);
           return NULL;
         }
+      PSID app_sid =3D appcontainer_sid ();
+      if (app_sid)
+       {
+         status =3D RtlAddAccessAllowedAce (dacl, ACL_REVISION, access,
+                                          app_sid);
+         if (!NT_SUCCESS (status))
+           {
+             debug_printf ("RtlAddAccessAllowedAce(AppContainer): %y",
+                           status);
+             return NULL;
+           }
+       }
       LPVOID ace;
       status =3D RtlFirstFreeAce (dacl, &ace);
       if (!NT_SUCCESS (status))
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 5ca02c0a1..e955923d9 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -3661,7 +3661,7 @@ seteuid (uid_t uid)
         debug_printf ("NtSetInformationToken (user.token, TokenPrimaryGrou=
p),"
                       "%y", status);
       /* Try setting default DACL */
-      PACL dacl_buf =3D (PACL) alloca (MAX_DACL_LEN (5));
+      PACL dacl_buf =3D (PACL) alloca (MAX_DACL_LEN (6));
       if (sec_acl (dacl_buf, true, true, usersid))
         {
           TOKEN_DEFAULT_DACL tdacl =3D { dacl_buf };
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index f94b9f60b..d80b9208c 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -277,7 +277,7 @@ static const wincaps wincap_11_24h2 =3D {
   },
 };

-wincapc wincap __attribute__((section (".cygwin_dll_common"), shared));
+wincapc NO_COPY wincap;

 extern IMAGE_DOS_HEADER
 __image_base__;
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index b84e3b0d4..23d36b074 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -49,6 +49,7 @@ check_PROGRAMS =3D \
         winsup.api/shmtest \
         winsup.api/sigchld \
         winsup.api/signal-into-win32-api \
+       winsup.api/socket-event-sharing \
         winsup.api/systemcall \
         winsup.api/user_malloc \
         winsup.api/waitpid \
@@ -387,8 +388,13 @@ clean-local:
 if MINGW_PROGS
 SUBDIRS =3D mingw
 check_PROGRAMS +=3D testinst/bin/pty-background-native
+check_PROGRAMS +=3D testinst/bin/appcontainer-child
+TESTS +=3D mingw/appcontainer-launcher
 testinst_bin_pty_background_native_SOURCES =3D \
         winsup.api/pty-background-native.c
+testinst_bin_appcontainer_child_SOURCES =3D \
+       winsup.api/appcontainer-child.c
+testinst_bin_appcontainer_child_LDADD =3D -ladvapi32 $(LDADD)

 testinst_bin_pty_background_native_DEPENDENCIES =3D \
         $(filter-out -%,$(LDADD)) \
@@ -396,6 +402,9 @@ testinst_bin_pty_background_native_DEPENDENCIES =3D \
         testinst/bin/cygwin-console-helper$(EXEEXT) \
         testinst/usr/share/terminfo/78/xterm

+testinst_bin_appcontainer_child_DEPENDENCIES =3D \
+       $(filter-out -%,$(LDADD))
+
 testinst/usr/share/terminfo/78/xterm: /usr/share/terminfo/78/xterm
         $(MKDIR_P) $(dir $@)
         $(INSTALL_DATA) $< $@
@@ -410,6 +419,9 @@ testinst/bin/cygwin-console-helper$(EXEEXT): \
 mingw/pty-native-input$(EXEEXT): $(srcdir)/mingw/pty-native-input.c
         $(MAKE) -C mingw pty-native-input$(EXEEXT)

+mingw/appcontainer-launcher$(EXEEXT): $(srcdir)/mingw/appcontainer-launche=
r.cc
+       $(MAKE) -C mingw appcontainer-launcher$(EXEEXT)
+
 ../utils/mingw/cygwin-console-helper$(EXEEXT): \
         $(top_srcdir)/utils/mingw/cygwin-console-helper.cc
         $(MAKE) -C ../utils/mingw cygwin-console-helper$(EXEEXT)
diff --git a/winsup/testsuite/mingw/Makefile.am b/winsup/testsuite/mingw/Ma=
kefile.am
index 1f14a0240..03aff9b04 100644
--- a/winsup/testsuite/mingw/Makefile.am
+++ b/winsup/testsuite/mingw/Makefile.am
@@ -16,7 +16,8 @@ override CC =3D @MINGW_CC@
 override CXX =3D @MINGW_CXX@
 AM_CPPFLAGS =3D

-noinst_PROGRAMS =3D cygrun cygload winchild pty-native-input
+noinst_PROGRAMS =3D cygrun cygload winchild pty-native-input \
+       appcontainer-launcher

 cygrun_SOURCES =3D \
         ../cygrun.c
@@ -32,3 +33,8 @@ winchild_LDADD=3D-lntdll

 pty_native_input_SOURCES =3D \
         pty-native-input.c
+
+appcontainer_launcher_SOURCES =3D \
+       appcontainer-launcher.cc
+appcontainer_launcher_LDFLAGS =3D -static -municode
+appcontainer_launcher_LDADD =3D -ladvapi32 -luserenv
diff --git a/winsup/testsuite/mingw/appcontainer-launcher.cc b/winsup/tests=
uite/mingw/appcontainer-launcher.cc
new file mode 100644
index 000000000..e55853990
--- /dev/null
+++ b/winsup/testsuite/mingw/appcontainer-launcher.cc
@@ -0,0 +1,579 @@
+/* appcontainer-launcher.cc: Run a Cygwin testsuite child in an AppContain=
er.
+
+   This file is part of Cygwin.
+
+   This software is a copyrighted work licensed under the terms of the
+   Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+   details. */
+
+#ifndef _WIN32_WINNT
+#define _WIN32_WINNT 0x0602
+#endif
+
+#include <windows.h>
+#include <aclapi.h>
+#include <securityappcontainer.h>
+#include <userenv.h>
+
+#include <stdio.h>
+#include <string>
+#include <vector>
+#include <wchar.h>
+
+struct acl_backup
+{
+  std::wstring path;
+  PSECURITY_DESCRIPTOR descriptor;
+  PACL dacl;
+};
+
+class temporary_acl
+{
+  std::vector<acl_backup> backups;
+
+public:
+  DWORD
+  grant (const std::wstring& path, PSID sid, DWORD access)
+  {
+    PSECURITY_DESCRIPTOR descriptor =3D NULL;
+    PACL old_dacl =3D NULL;
+    DWORD error =3D GetNamedSecurityInfoW ((LPWSTR) path.c_str (), SE_FILE=
_OBJECT,
+                                        DACL_SECURITY_INFORMATION, NULL, N=
ULL,
+                                        &old_dacl, NULL, &descriptor);
+    if (error !=3D ERROR_SUCCESS)
+      return error;
+
+    EXPLICIT_ACCESSW entry =3D {};
+    entry.grfAccessPermissions =3D access;
+    entry.grfAccessMode =3D GRANT_ACCESS;
+    entry.grfInheritance =3D NO_INHERITANCE;
+    entry.Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
+    entry.Trustee.TrusteeType =3D TRUSTEE_IS_GROUP;
+    entry.Trustee.ptstrName =3D (LPWSTR) sid;
+
+    PACL new_dacl =3D NULL;
+    error =3D SetEntriesInAclW (1, &entry, old_dacl, &new_dacl);
+    if (error !=3D ERROR_SUCCESS)
+      {
+       LocalFree (descriptor);
+       return error;
+      }
+
+    backups.push_back ({ path, descriptor, old_dacl });
+    error =3D SetNamedSecurityInfoW ((LPWSTR) path.c_str (), SE_FILE_OBJEC=
T,
+                                  DACL_SECURITY_INFORMATION, NULL, NULL,
+                                  new_dacl, NULL);
+    if (new_dacl)
+      LocalFree (new_dacl);
+    if (error !=3D ERROR_SUCCESS)
+      {
+       backups.pop_back ();
+       LocalFree (descriptor);
+       return error;
+      }
+    return ERROR_SUCCESS;
+  }
+
+  DWORD
+  restore ()
+  {
+    DWORD first_error =3D ERROR_SUCCESS;
+    for (size_t i =3D backups.size (); i > 0; --i)
+      {
+       acl_backup& backup =3D backups[i - 1];
+       if (!backup.descriptor)
+         continue;
+       DWORD error
+         =3D SetNamedSecurityInfoW ((LPWSTR) backup.path.c_str (), SE_FILE=
_OBJECT,
+                                  DACL_SECURITY_INFORMATION, NULL, NULL,
+                                  backup.dacl, NULL);
+       if (first_error =3D=3D ERROR_SUCCESS && error !=3D ERROR_SUCCESS)
+         first_error =3D error;
+       if (error =3D=3D ERROR_SUCCESS)
+         {
+           LocalFree (backup.descriptor);
+           backup.descriptor =3D NULL;
+         }
+      }
+    if (first_error =3D=3D ERROR_SUCCESS)
+      backups.clear ();
+    return first_error;
+  }
+
+  ~temporary_acl ()
+  {
+    restore ();
+  }
+};
+
+static std::wstring
+full_path (const std::wstring& path)
+{
+  DWORD needed =3D GetFullPathNameW (path.c_str (), 0, NULL, NULL);
+  if (!needed)
+    return std::wstring ();
+  std::vector<WCHAR> buffer (needed + 1);
+  DWORD length
+    =3D GetFullPathNameW (path.c_str (), buffer.size (), buffer.data (), N=
ULL);
+  if (!length || length >=3D buffer.size ())
+    return std::wstring ();
+  return std::wstring (buffer.data (), length);
+}
+
+static std::wstring
+parent_path (const std::wstring& path)
+{
+  size_t slash =3D path.find_last_of (L"\\/");
+  if (slash =3D=3D std::wstring::npos)
+    return std::wstring ();
+  if (slash =3D=3D 2 && path.size () >=3D 3 && path[1] =3D=3D L':')
+    return path.substr (0, 3);
+  return path.substr (0, slash);
+}
+
+static bool
+grant_ancestor_traverse (const std::wstring& root, PSID sid,
+                        temporary_acl& acl, DWORD& error)
+{
+  std::vector<std::wstring> ancestors;
+  std::wstring path =3D parent_path (root);
+  while (path.size () > 3)
+    {
+      ancestors.push_back (path);
+      path =3D parent_path (path);
+    }
+  for (auto it =3D ancestors.rbegin (); it !=3D ancestors.rend (); ++it)
+    {
+      error =3D acl.grant (*it, sid, FILE_TRAVERSE | FILE_READ_ATTRIBUTES);
+      if (error !=3D ERROR_SUCCESS)
+       return false;
+    }
+  return true;
+}
+
+static bool
+grant_test_files (const std::wstring& root, const std::wstring& child,
+                 const std::wstring& dll, PSID sid, temporary_acl& acl,
+                 DWORD& error)
+{
+  error =3D acl.grant (root, sid, FILE_TRAVERSE | FILE_READ_ATTRIBUTES);
+  if (error !=3D ERROR_SUCCESS)
+    return false;
+  error =3D acl.grant (parent_path (child), sid,
+                    FILE_TRAVERSE | FILE_READ_ATTRIBUTES);
+  if (error !=3D ERROR_SUCCESS)
+    return false;
+  error =3D acl.grant (child, sid, FILE_GENERIC_READ | FILE_EXECUTE);
+  if (error !=3D ERROR_SUCCESS)
+    return false;
+  error =3D acl.grant (dll, sid, FILE_GENERIC_READ | FILE_EXECUTE);
+  return error =3D=3D ERROR_SUCCESS;
+}
+
+static std::wstring
+quote_argument (const std::wstring& arg)
+{
+  std::wstring quoted =3D L"\"";
+  size_t slashes =3D 0;
+  for (WCHAR c : arg)
+    {
+      if (c =3D=3D L'\\')
+       {
+         ++slashes;
+         continue;
+       }
+      if (c =3D=3D L'"')
+       quoted.append (slashes * 2 + 1, L'\\');
+      else
+       quoted.append (slashes, L'\\');
+      quoted.push_back (c);
+      slashes =3D 0;
+    }
+  quoted.append (slashes * 2, L'\\');
+  quoted.push_back (L'"');
+  return quoted;
+}
+
+static bool
+is_appcontainer (HANDLE process)
+{
+  HANDLE token =3D NULL;
+  DWORD value =3D 0;
+  DWORD size =3D 0;
+  if (!OpenProcessToken (process, TOKEN_QUERY, &token))
+    return false;
+  BOOL ok =3D GetTokenInformation (token, TokenIsAppContainer, &value,
+                                sizeof value, &size);
+  CloseHandle (token);
+  return ok && value !=3D 0;
+}
+
+static bool
+skip_error (DWORD error)
+{
+  return error =3D=3D ERROR_ACCESS_DENIED || error =3D=3D ERROR_NOT_SUPPOR=
TED
+        || error =3D=3D ERROR_CALL_NOT_IMPLEMENTED
+        || error =3D=3D ERROR_PRIVILEGE_NOT_HELD
+        || error =3D=3D ERROR_ACCESS_DISABLED_BY_POLICY;
+}
+
+static bool
+skip_hresult (HRESULT hr)
+{
+  return skip_error (HRESULT_CODE (hr));
+}
+
+static void
+print_child_output (const std::string& output)
+{
+  if (!output.empty ())
+    {
+      fwrite (output.data (), 1, output.size (), stdout);
+      fflush (stdout);
+    }
+}
+
+static bool
+read_available (HANDLE pipe, std::string& output, DWORD& error)
+{
+  error =3D ERROR_SUCCESS;
+  for (;;)
+    {
+      DWORD available =3D 0;
+      if (!PeekNamedPipe (pipe, NULL, 0, NULL, &available, NULL))
+       {
+         error =3D GetLastError ();
+         return error =3D=3D ERROR_BROKEN_PIPE;
+       }
+      if (!available)
+       return true;
+      char buffer[4096];
+      DWORD read_count =3D 0;
+      if (!ReadFile (pipe, buffer,
+                    available < sizeof buffer ? available : sizeof buffer,
+                    &read_count, NULL))
+       {
+         error =3D GetLastError ();
+         return error =3D=3D ERROR_BROKEN_PIPE;
+       }
+      if (!read_count)
+       return true;
+      output.append (buffer, read_count);
+    }
+}
+
+int
+wmain ()
+{
+  std::wstring child =3D full_path (L"testinst\\bin\\appcontainer-child.ex=
e");
+  if (child.empty ())
+    {
+      fwprintf (stderr, L"Could not resolve the AppContainer child path: %=
lu\n",
+               GetLastError ());
+      return 1;
+    }
+  std::wstring test_root =3D parent_path (parent_path (child));
+  std::wstring dll =3D parent_path (child) + L"\\cygwin1.dll<file://\\cygw=
in1.dll>";
+  if (GetFileAttributesW (child.c_str ()) =3D=3D INVALID_FILE_ATTRIBUTES
+      || GetFileAttributesW (dll.c_str ()) =3D=3D INVALID_FILE_ATTRIBUTES)
+    {
+      fwprintf (stderr, L"Missing test child or build-tree cygwin1.dll:\n"
+               L"  child: %ls\n  dll: %ls\n", child.c_str (), dll.c_str ()=
);
+      return 1;
+    }
+
+  WCHAR profile_name[96];
+  int name_length
+    =3D swprintf (profile_name, 96, L"CygwinTest-%lu-%llu",
+               GetCurrentProcessId (), GetTickCount64 ());
+  if (name_length < 0 || name_length >=3D 96)
+    {
+      fwprintf (stderr, L"Could not generate AppContainer profile name.\n"=
);
+      return 1;
+    }
+  PSID appcontainer_sid =3D NULL;
+  HRESULT hr =3D CreateAppContainerProfile (profile_name, profile_name,
+                                         L"Cygwin testsuite AppContainer",
+                                         NULL, 0, &appcontainer_sid);
+  if (FAILED (hr))
+    {
+      if (skip_hresult (hr))
+       {
+         fwprintf (stdout, L"SKIP=3DCannot create AppContainer profile "
+                   L"(HRESULT 0x%08lx).\n", (ULONG) hr);
+         return 77;
+       }
+      fwprintf (stderr, L"CreateAppContainerProfile failed: 0x%08lx\n",
+               (ULONG) hr);
+      return 1;
+    }
+
+  int result =3D 1;
+  temporary_acl acl;
+  DWORD error =3D ERROR_SUCCESS;
+  if (!grant_ancestor_traverse (test_root, appcontainer_sid, acl, error)
+      || !grant_test_files (test_root, child, dll, appcontainer_sid, acl,
+                           error))
+    {
+      DWORD restore_error =3D acl.restore ();
+      if (restore_error !=3D ERROR_SUCCESS)
+       {
+         fwprintf (stderr, L"Could not restore test-tree ACL after setup "
+                   L"failure (error %lu).\n", restore_error);
+         goto cleanup_profile;
+       }
+      if (skip_error (error))
+       {
+         fwprintf (stdout, L"SKIP=3DCannot grant AppContainer access to te=
st "
+                   L"runtime (error %lu).\n", error);
+         result =3D 77;
+       }
+      else
+       fwprintf (stderr, L"Could not grant AppContainer access to test "
+                 L"runtime (error %lu).\n", error);
+      goto cleanup_profile;
+    }
+
+  {
+    SECURITY_ATTRIBUTES pipe_security =3D { sizeof pipe_security, NULL, TR=
UE };
+    HANDLE output_read =3D NULL;
+    HANDLE output_write =3D NULL;
+    HANDLE input =3D NULL;
+    if (!CreatePipe (&output_read, &output_write, &pipe_security, 0))
+      {
+       fwprintf (stderr, L"CreatePipe failed: %lu\n", GetLastError ());
+       goto cleanup_acl;
+      }
+    input =3D CreateFileW (L"NUL", GENERIC_READ,
+                        FILE_SHARE_READ | FILE_SHARE_WRITE, &pipe_security,
+                        OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+    if (input =3D=3D INVALID_HANDLE_VALUE)
+      {
+       fwprintf (stderr, L"Could not open NUL for child stdin: %lu\n",
+                 GetLastError ());
+       CloseHandle (output_read);
+       CloseHandle (output_write);
+       goto cleanup_acl;
+      }
+    if (!SetHandleInformation (output_read, HANDLE_FLAG_INHERIT, 0))
+      {
+       fwprintf (stderr, L"SetHandleInformation failed: %lu\n",
+                 GetLastError ());
+       CloseHandle (input);
+       CloseHandle (output_read);
+       CloseHandle (output_write);
+       goto cleanup_acl;
+      }
+
+    STARTUPINFOEXW startup =3D {};
+    startup.StartupInfo.cb =3D sizeof startup;
+    startup.StartupInfo.dwFlags =3D STARTF_USESTDHANDLES;
+    startup.StartupInfo.hStdInput =3D input;
+    startup.StartupInfo.hStdOutput =3D output_write;
+    startup.StartupInfo.hStdError =3D output_write;
+
+    SIZE_T attr_size =3D 0;
+    InitializeProcThreadAttributeList (NULL, 2, 0, &attr_size);
+    if (!attr_size)
+      {
+       DWORD init_error =3D GetLastError ();
+       if (skip_error (init_error))
+         {
+           fwprintf (stdout, L"SKIP=3DAppContainer process attributes are =
not "
+                     L"available (error %lu).\n", init_error);
+           result =3D 77;
+         }
+       else
+         fwprintf (stderr, L"AppContainer process attributes are unavailab=
le: "
+                   L"%lu\n", init_error);
+       CloseHandle (input);
+       CloseHandle (output_read);
+       CloseHandle (output_write);
+       goto cleanup_acl;
+      }
+    std::vector<BYTE> attr_storage (attr_size);
+    startup.lpAttributeList
+      =3D (LPPROC_THREAD_ATTRIBUTE_LIST) attr_storage.data ();
+    if (!InitializeProcThreadAttributeList (startup.lpAttributeList, 2, 0,
+                                           &attr_size))
+      {
+       DWORD init_error =3D GetLastError ();
+       if (skip_error (init_error))
+         {
+           fwprintf (stdout, L"SKIP=3DAppContainer process attributes are =
not "
+                     L"available (error %lu).\n", init_error);
+           result =3D 77;
+         }
+       else
+         fwprintf (stderr, L"InitializeProcThreadAttributeList failed: %lu=
\n",
+                   init_error);
+       CloseHandle (input);
+       CloseHandle (output_read);
+       CloseHandle (output_write);
+       goto cleanup_acl;
+      }
+
+    SECURITY_CAPABILITIES capabilities =3D {};
+    capabilities.AppContainerSid =3D appcontainer_sid;
+    HANDLE inherited[] =3D { output_write, input };
+    bool attrs_ok
+      =3D UpdateProcThreadAttribute (startup.lpAttributeList, 0,
+                                  PROC_THREAD_ATTRIBUTE_SECURITY_CAPABILIT=
IES,
+                                  &capabilities, sizeof capabilities,
+                                  NULL, NULL)
+       && UpdateProcThreadAttribute (startup.lpAttributeList, 0,
+                                     PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
+                                     inherited, sizeof inherited, NULL, NU=
LL);
+    if (!attrs_ok)
+      {
+       DWORD update_error =3D GetLastError ();
+       DeleteProcThreadAttributeList (startup.lpAttributeList);
+       CloseHandle (input);
+       CloseHandle (output_read);
+       CloseHandle (output_write);
+       if (skip_error (update_error))
+         {
+           fwprintf (stdout, L"SKIP=3DAppContainer process attributes are =
not "
+                     L"supported (error %lu).\n", update_error);
+           result =3D 77;
+         }
+       else
+         fwprintf (stderr, L"Could not configure AppContainer process "
+                   L"attributes (error %lu).\n", update_error);
+       goto cleanup_acl;
+      }
+
+    std::wstring command =3D quote_argument (child);
+    std::vector<WCHAR> command_line (command.begin (), command.end ());
+    command_line.push_back (L'\0');
+    if (!SetEnvironmentVariableW (L"CYGWIN_TESTING", L"1"))
+      {
+       fwprintf (stderr, L"SetEnvironmentVariable(CYGWIN_TESTING) failed: "
+                 L"%lu\n", GetLastError ());
+       DeleteProcThreadAttributeList (startup.lpAttributeList);
+       CloseHandle (input);
+       CloseHandle (output_read);
+       CloseHandle (output_write);
+       goto cleanup_acl;
+      }
+
+    PROCESS_INFORMATION process =3D {};
+    BOOL created
+      =3D CreateProcessW (child.c_str (), command_line.data (), NULL, NULL=
, TRUE,
+                       EXTENDED_STARTUPINFO_PRESENT, NULL,
+                       parent_path (child).c_str (), &startup.StartupInfo,
+                       &process);
+    DWORD create_error =3D GetLastError ();
+    DeleteProcThreadAttributeList (startup.lpAttributeList);
+    CloseHandle (input);
+    CloseHandle (output_write);
+    if (!created)
+      {
+       CloseHandle (output_read);
+       if (skip_error (create_error))
+         {
+           fwprintf (stdout, L"SKIP=3DHost denied AppContainer child launc=
h "
+                     L"(error %lu).\n", create_error);
+           result =3D 77;
+         }
+       else
+         fwprintf (stderr, L"CreateProcess(AppContainer child) failed: %lu=
\n",
+                   create_error);
+       goto cleanup_acl;
+      }
+
+    std::string output;
+    ULONGLONG deadline =3D GetTickCount64 () + 30000;
+    bool timed_out =3D false;
+    bool output_failed =3D false;
+    DWORD output_error =3D ERROR_SUCCESS;
+    for (;;)
+      {
+       if (!read_available (output_read, output, output_error))
+         {
+           fwprintf (stderr, L"Could not read AppContainer child output: %=
lu\n",
+                     output_error);
+           output_failed =3D true;
+           TerminateProcess (process.hProcess, 1);
+           WaitForSingleObject (process.hProcess, INFINITE);
+           break;
+         }
+       DWORD wait =3D WaitForSingleObject (process.hProcess, 50);
+       if (wait =3D=3D WAIT_OBJECT_0)
+         {
+           if (!read_available (output_read, output, output_error))
+             {
+               fwprintf (stderr,
+                         L"Could not read AppContainer child output: %lu\n=
",
+                         output_error);
+               output_failed =3D true;
+             }
+           break;
+         }
+       if (wait =3D=3D WAIT_FAILED)
+         {
+           fwprintf (stderr, L"WaitForSingleObject failed: %lu\n",
+                     GetLastError ());
+           TerminateProcess (process.hProcess, 1);
+           WaitForSingleObject (process.hProcess, INFINITE);
+           break;
+         }
+       if (GetTickCount64 () >=3D deadline)
+         {
+           timed_out =3D true;
+           TerminateProcess (process.hProcess, 1);
+           WaitForSingleObject (process.hProcess, INFINITE);
+           if (!read_available (output_read, output, output_error))
+             {
+               fwprintf (stderr,
+                         L"Could not read AppContainer child output: %lu\n=
",
+                         output_error);
+               output_failed =3D true;
+             }
+           break;
+         }
+      }
+      {
+       DWORD exit_code =3D 1;
+       GetExitCodeProcess (process.hProcess, &exit_code);
+       print_child_output (output);
+       if (timed_out)
+         fwprintf (stderr, L"AppContainer child timed out.\n");
+       else if (output_failed)
+         result =3D 1;
+       else if (!is_appcontainer (process.hProcess))
+         fwprintf (stderr, L"Child process token is not an AppContainer.\n=
");
+       else if (exit_code !=3D 0)
+         fwprintf (stderr, L"AppContainer child exited with status %lu.\n",
+                   exit_code);
+       else
+         result =3D 0;
+      }
+    CloseHandle (process.hThread);
+    CloseHandle (process.hProcess);
+    CloseHandle (output_read);
+  }
+
+cleanup_acl:
+  {
+    DWORD restore_error =3D acl.restore ();
+    if (restore_error !=3D ERROR_SUCCESS)
+      {
+       fwprintf (stderr, L"Could not restore test-tree ACL (error %lu).\n",
+                 restore_error);
+       result =3D 1;
+      }
+  }
+cleanup_profile:
+  {
+    HRESULT cleanup_hr =3D DeleteAppContainerProfile (profile_name);
+    if (FAILED (cleanup_hr))
+      {
+       fwprintf (stderr, L"DeleteAppContainerProfile failed: 0x%08lx\n",
+                 (ULONG) cleanup_hr);
+       result =3D 1;
+      }
+    FreeSid (appcontainer_sid);
+  }
+  return result;
+}
diff --git a/winsup/testsuite/winsup.api/appcontainer-child.c b/winsup/test=
suite/winsup.api/appcontainer-child.c
new file mode 100644
index 000000000..48508a5ac
--- /dev/null
+++ b/winsup/testsuite/winsup.api/appcontainer-child.c
@@ -0,0 +1,141 @@
+/* Exercise runtime initialization and named-object locking in AppContaine=
r. */
+
+#include <windows.h>
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <wchar.h>
+#include <sys/file.h>
+#include <unistd.h>
+
+static int
+is_appcontainer (void)
+{
+  HANDLE token;
+  DWORD value =3D 0;
+  DWORD size =3D 0;
+
+  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_QUERY, &token))
+    {
+      fprintf (stderr, "OpenProcessToken failed: %lu\n",
+              (unsigned long) GetLastError ());
+      return -1;
+    }
+  BOOL ok =3D GetTokenInformation (token, TokenIsAppContainer, &value,
+                                sizeof value, &size);
+  DWORD error =3D ok ? ERROR_SUCCESS : GetLastError ();
+  CloseHandle (token);
+  if (!ok)
+    {
+      fprintf (stderr, "GetTokenInformation(TokenIsAppContainer) failed: "
+              "%lu\n", (unsigned long) error);
+      return -1;
+    }
+  return value !=3D 0;
+}
+
+static int
+check_runtime_dll (void)
+{
+  WCHAR actual[MAX_PATH];
+  WCHAR executable[MAX_PATH];
+  HMODULE module =3D GetModuleHandleW (L"cygwin1.dll");
+  if (!module
+      || !GetModuleFileNameW (module, actual, sizeof actual / sizeof actua=
l[0]))
+    {
+      fprintf (stderr, "Could not locate loaded cygwin1.dll: %lu\n",
+              (unsigned long) GetLastError ());
+      return -1;
+    }
+  if (!GetModuleFileNameW (NULL, executable,
+                          sizeof executable / sizeof executable[0]))
+    {
+      fprintf (stderr, "Could not locate test executable: %lu\n",
+              (unsigned long) GetLastError ());
+      return -1;
+    }
+
+  WCHAR actual_full[MAX_PATH];
+  WCHAR executable_full[MAX_PATH];
+  DWORD actual_len =3D GetFullPathNameW (actual, MAX_PATH, actual_full, NU=
LL);
+  DWORD executable_len
+    =3D GetFullPathNameW (executable, MAX_PATH, executable_full, NULL);
+  if (!actual_len || actual_len >=3D MAX_PATH
+      || !executable_len || executable_len >=3D MAX_PATH)
+    {
+      fprintf (stderr, "Could not normalize runtime paths.\n");
+      return -1;
+    }
+
+  WCHAR *actual_slash =3D wcsrchr (actual_full, L'\\');
+  WCHAR *executable_slash =3D wcsrchr (executable_full, L'\\');
+  if (!actual_slash || !executable_slash
+      || CompareStringOrdinal (actual_slash + 1, -1, L"cygwin1.dll", -1,
+                              TRUE) !=3D CSTR_EQUAL)
+    {
+      fwprintf (stderr, L"Unexpected runtime DLL path: %ls\n", actual_full=
);
+      return -1;
+    }
+  *actual_slash =3D L'\0';
+  *executable_slash =3D L'\0';
+  if (CompareStringOrdinal (actual_full, -1, executable_full, -1, TRUE)
+      !=3D CSTR_EQUAL)
+    {
+      fwprintf (stderr, L"Loaded cygwin1.dll is not beside the test "
+              L"executable.\n  loaded: %ls\n  executable: %ls\n",
+              actual_full, executable_full);
+      return -1;
+    }
+  return 0;
+}
+
+int
+main (int argc, char **argv)
+{
+  (void) argv;
+  if (argc !=3D 1)
+    {
+      fprintf (stderr, "usage: appcontainer-child\n");
+      return 2;
+    }
+
+  int appcontainer =3D is_appcontainer ();
+  if (appcontainer < 0)
+    return 1;
+  if (!appcontainer)
+    {
+      fprintf (stderr, "Child is not running in an AppContainer.\n");
+      return 1;
+    }
+  if (check_runtime_dll ())
+    return 1;
+
+  int fd =3D open ("appcontainer-child.exe", O_RDONLY);
+  if (fd < 0)
+    {
+      fprintf (stderr, "open test executable failed: %s\n", strerror (errn=
o));
+      return 1;
+    }
+  if (flock (fd, LOCK_SH | LOCK_NB) < 0)
+    {
+      fprintf (stderr, "flock shared lock failed: %s\n", strerror (errno));
+      close (fd);
+      return 1;
+    }
+  if (flock (fd, LOCK_UN) < 0)
+    {
+      fprintf (stderr, "flock unlock failed: %s\n", strerror (errno));
+      close (fd);
+      return 1;
+    }
+  if (close (fd) < 0)
+    {
+      fprintf (stderr, "close test executable failed: %s\n", strerror (err=
no));
+      return 1;
+    }
+
+  puts ("Cygwin AppContainer startup and named-object locking passed.");
+  return 0;
+}
diff --git a/winsup/testsuite/winsup.api/socket-event-sharing.c b/winsup/te=
stsuite/winsup.api/socket-event-sharing.c
new file mode 100644
index 000000000..d4182c0cd
--- /dev/null
+++ b/winsup/testsuite/winsup.api/socket-event-sharing.c
@@ -0,0 +1,142 @@
+/* Share socket state across dup/fork/exec, but not object namespaces. */
+
+#include <windows.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void
+fail (const char *message)
+{
+  perror (message);
+  exit (1);
+}
+
+static int
+check_namespace (int fd)
+{
+  char executable[MAX_PATH];
+  char command[MAX_PATH + 32];
+  DWORD length =3D GetModuleFileNameA (NULL, executable, sizeof executable=
);
+  if (!length || length >=3D sizeof executable)
+    return 1;
+  snprintf (command, sizeof command, "\"%s\" --other-namespace", executabl=
e);
+
+  /* A native launch avoids inheriting Cygwin's process information. */
+  const char *testing =3D getenv ("CYGWIN_TESTING");
+  if (!SetEnvironmentVariableA ("CYGWIN_TESTING",
+                              testing && *testing ? NULL : "1"))
+    return 1;
+  STARTUPINFOA startup =3D { .cb =3D sizeof startup };
+  PROCESS_INFORMATION process;
+  BOOL created =3D CreateProcessA (executable, command, NULL, NULL, FALSE,=
 0,
+                                NULL, NULL, &startup, &process);
+  BOOL restored =3D SetEnvironmentVariableA ("CYGWIN_TESTING", testing);
+  if (!created)
+    {
+      fputs ("Could not launch the other socket namespace\n", stderr);
+      return 1;
+    }
+  CloseHandle (process.hThread);
+  DWORD wait =3D WaitForSingleObject (process.hProcess, 20000);
+  DWORD status =3D 1;
+  if (wait =3D=3D WAIT_OBJECT_0)
+    GetExitCodeProcess (process.hProcess, &status);
+  else
+    {
+      TerminateProcess (process.hProcess, 1);
+      WaitForSingleObject (process.hProcess, INFINITE);
+    }
+  CloseHandle (process.hProcess);
+  if (!restored || wait !=3D WAIT_OBJECT_0 || status)
+    {
+      fputs ("Other socket namespace failed\n", stderr);
+      return 1;
+    }
+  if (fcntl (fd, F_GETOWN) !=3D getpid ())
+    {
+      fputs ("Other namespace overwrote a live socket's event state\n",
+            stderr);
+      return 1;
+    }
+  return 0;
+}
+
+int
+main (int argc, char **argv)
+{
+  alarm (30);
+  if (argc =3D=3D 2 && !strcmp (argv[1], "--other-namespace"))
+    {
+      for (int i =3D 0; i < 4096; ++i)
+       {
+         int fd =3D socket (AF_INET, SOCK_DGRAM, 0);
+         if (fd =3D=3D -1)
+           fail ("socket in other namespace");
+         close (fd);
+       }
+      return 0;
+    }
+  if (argc =3D=3D 3 && !strcmp (argv[1], "--exec"))
+    {
+      int fd =3D atoi (argv[2]);
+      if (fcntl (fd, F_GETOWN) !=3D getpid ())
+       {
+         fputs ("Socket owner was not preserved across exec\n", stderr);
+         return 1;
+       }
+      if (fcntl (fd, F_SETOWN, getppid ()) =3D=3D -1)
+       fail ("F_SETOWN after exec");
+      return 0;
+    }
+
+  int fd =3D socket (AF_INET, SOCK_DGRAM, 0);
+  if (fd =3D=3D -1)
+    fail ("socket");
+  if (fcntl (fd, F_SETOWN, 0) =3D=3D -1)
+    fail ("F_SETOWN");
+
+  pid_t child =3D fork ();
+  if (child =3D=3D -1)
+    fail ("fork");
+  if (!child)
+    {
+      if (fcntl (fd, F_SETOWN, getpid ()) =3D=3D -1)
+       fail ("F_SETOWN after fork");
+      int duplicate =3D dup (fd);
+      if (duplicate =3D=3D -1)
+       fail ("dup");
+      if (fcntl (duplicate, F_GETOWN) !=3D getpid ())
+       {
+         fputs ("Duplicated socket does not share its owner\n", stderr);
+         return 1;
+       }
+      close (duplicate);
+      char fdstr[32];
+      snprintf (fdstr, sizeof fdstr, "%d", fd);
+      execl (argv[0], argv[0], "--exec", fdstr, (char *) NULL);
+      fail ("exec");
+    }
+
+  int status;
+  if (waitpid (child, &status, 0) !=3D child)
+    fail ("waitpid");
+  if (!WIFEXITED (status) || WEXITSTATUS (status))
+    {
+      fputs ("Socket child failed\n", stderr);
+      return 1;
+    }
+  if (fcntl (fd, F_GETOWN) !=3D getpid ())
+    {
+      fputs ("Parent did not observe the child's socket owner update\n",
+            stderr);
+      return 1;
+    }
+  int result =3D check_namespace (fd);
+  close (fd);
+  return result;
+}

--_000_BN8PR19MB2434EF5E0D72955EF6BEC1A8A4732BN8PR19MB2434namp_--

Return-Path: <SRS0=dsF1=EV=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id BA6D84BA2E29
	for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2026 14:33:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BA6D84BA2E29
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BA6D84BA2E29
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1782398000; cv=pass;
	b=rB51IUfenm+bq7d+G0ZzEd9GVQ/il/rQFpbA6LSq63XzNHUaUlSX8WVHloeyE3rb5GfNLl7xq3tDDEg0uXB6j9ZO+M6O30/G5kvyaySFi07t8Xzglgvq8B1s/C260Wi479tPVH7fX0K+WlGecDuCxtOipm0Dd56R0zayLnqgnZw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782398000; c=relaxed/simple;
	bh=Yq8p+I1ui2XHd5aQqFqsaML+zyYdpClKmKONLJ4DosI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=if9AMrHKaApC3r4+OF2mrzrhjKFeh+MfrZaDvFQ8Ey1j1QR/M8PHBoOWLi9PW4noCTNkOGSiDTIEmD5gJxzt/7hDi6G6CcoXA56A/gd4/sXhW0YoBAXoe7D6tE7odkC3eFBqga9y5xgsGqnK5LNW1SMDjs8QfOtETz0jR/vAklM=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=pctbSvQj
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA6D84BA2E29
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=pctbSvQj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGGKg2bhrg736vT3grjnQtk7VHGCcHEsF+XKiGbzAjvEe3P8ihVfifw4MdB+2GDR3KG58PDEHAHng1+t/+xHcELIF0JkgJN6GfiU6uz/R4ujPpV1fraePEL3TbW9c2koMjvbNKoNCqLoQcV+vqaSb80GE77IJ5MiDk5dZrRiZfcUFNCCjDQtwdt6H4fkYe9MY1TeHKG1Tw0KP2OqjcV1eLNvxMO+lP5yz7sDOLlosMvvK5MGQ8TgON/qCwh1ovJyPDWPZuOvabNyGgAJ0qRPCp9ET0idy9KbVrZ+QirhOQmEfmlyJbE+SgQmEn+OzNV7pYeYiHucXCx0gGJiyEqqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kByZHO9P+ajTvx4r+lYImhF25TpI467l+HWqagplYg=;
 b=L8rIkbwApdS2D8ex2zn2g43fLvRoKdcOZF4z1vx634Fx1CG2Sm7j5S+kVQJGaHlo4/nW1sMG3KaKlb/LMlPfMPkW57s9GgAhDpXPV3P/AVn5k1bxMwdED6jnlVnlB54rkUu1iWvj32srjyTajQ3F6V3TRRND3VYS5n4NVaQ7yCoG9i2ZiceHrxKNX1veiQG08yCpm6OMqZzRv2bsfl0MyIaUlh+7iVZOg12BIhZWdP9Ggu91m6VoOv6MLOI7kTeufZzywnHjwYTc/Cbgw/xhkuW/Z5Gq3jPh71dJ7iBFxoGeielTcaXGvI8ZZ3LHEs2VysbCYHPkZySdoUwW+APH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kByZHO9P+ajTvx4r+lYImhF25TpI467l+HWqagplYg=;
 b=pctbSvQjPflYqsx+HLv6byQ+sfyzxPTFAYjMSFHor1T1qYTX6In8ZpCbvSzD08n6rwz/gALvAhB//bBy6m5gApivdPdUOrR3saKS6RBdOeE54uqDpXoX2mKZxRJmy783D7I1VBjFMaq6/N42EECc/lPIXviYXDV7UPP4P0vavBb9i45th+tQ8l8sDmvSpg/T5mEi5jkR6OA4WEFpl3cu1tGsl7UmrargsuDmZF3770GK2hh4sOyoHBa075Nib789AxkTCFh6VtqOXSWCu2fQraA26Cso6ScECEsi0JBlV++kDzCwa34Bnz5WGKV2e00abP20lHsRrBoii6lzg6X+tQ==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by PN2PPF797C3267A.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::128) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 14:33:08 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 14:33:07 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: Jon Turney <jon.turney@dronecode.org.uk>, "cygwin-patches@cygwin.com"
	<cygwin-patches@cygwin.com>
Subject: [PATCH v3] Cygwin: ssp: Move command-line copy into run_program
Thread-Topic: [PATCH v3] Cygwin: ssp: Move command-line copy into run_program
Thread-Index: AQHdBK+K89vI5xMM10ibOVRbxAN0nQ==
Date: Thu, 25 Jun 2026 14:33:07 +0000
Message-ID:
 <PN0P287MB02952A907048F49E206674D492EC2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
References:
 <PN0P287MB02952FCE57C59FF18096B96D920E2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <34b42100-1722-4bdc-abf9-e9d159456ee0@dronecode.org.uk>
 <PN0P287MB0295E9D540A342B741B82CC592122@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB0295F1D93B25FA3B90293E35921C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <d775f31b-f552-409c-b21b-f280180e8089@dronecode.org.uk>
In-Reply-To: <d775f31b-f552-409c-b21b-f280180e8089@dronecode.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|PN2PPF797C3267A:EE_
x-ms-office365-filtering-correlation-id: f1798f36-9cf0-49a2-4a92-08ded2c6ac9f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|39142699007|6049299003|31052699007|376014|366016|1800799024|10070799003|38070700021|4053099003|56012099006|4143699003|5023799004|55112099003|18002099003|22082099003|8096899003;
x-microsoft-antispam-message-info:
 NuhhvJDTe1xQ+TSMpyCeAo0/LtUWpyBDcGL1o2RtIng/ON+TIEO77pyOlKa64ql2fhrSJzSbfxu3a5Rp7MOnJUvBaOQ8IwSF+ZxRgf1htkqM8B7dQxJxd5Nnv/obbyFVioQ5bvQWD1aTkMD+Fs3tnXVoHr5milLJ7hCFBV5CA0p8IjEmpfYlWVD27bClHkN8XKT0NVX8HzfgBohgcLeNiHnxal138RNtp3tNsOycaUBWkV1rtJKAG5hLmEKpND3tgThTDeKycMSXfmAJK1oI56ZZ59yxWFkkwZe5MSQBZWObkqvYkZcrxfPVT2ClvDPDeynCeLUk1E/4tPDc5cIDVblz01nHWOL1zYxi9RrV7QQSG7bMKT7oXxtJVuhkuUtxjQ0wf9G9OLFPEsnzQkWPpiDBPzW3POe5p+J19x531eUtfAM/zY51J0ss/VWobINPlmlXK72g+rUlkUwjbswy9QiG4+YFOOI5TPzvsT77m2syItxIKFiIdE2gCZmM5TPrlVdxeWfZMdPLM0niQfIbIzIKg6lH/NjXRmUrCppOWsJdOL9U9FG62SR71Sf6b5pKctX042KOvp4uwmon+BBZfmKPZleFyjrMRGG90GhlrBddODIaUA6wpZH3zLr7qv3LBQWw9hJ4iBlX8HQIsJBhAlz620bOKlsPAp4mKz0wIkuMOakK1Z51inIRpgmgY0BJpS0eA16902Es+bYeotP4YvajFXBl6PJAaZkxjtX5Bwo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(39142699007)(6049299003)(31052699007)(376014)(366016)(1800799024)(10070799003)(38070700021)(4053099003)(56012099006)(4143699003)(5023799004)(55112099003)(18002099003)(22082099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?RP/0MMA7gkzh8bNSu3Gtr9Eu9EdsHnwR2NUzJifq2sbaid/3ECnbHM6Y?=
 =?Windows-1252?Q?hUXGEBtrrsFYUAGXApwZTLp56K/RbBIXsyMH/CB1Nt8MybaRJ1NDCa0Y?=
 =?Windows-1252?Q?FUi4C0EL7pT+yQUc3O0ivPqkPhNUYM/U/H/otNIWPv2CcNk25YHVWrTV?=
 =?Windows-1252?Q?Olqkk0E8cCJJjJaUq5H2t+Hsnnjgo8ICiYqPure/7qwihqEIOBY3zSCJ?=
 =?Windows-1252?Q?E+cxd8BbpKFYhbuyMdzmsTW+zo2mvD7i+OKdhy0CWr205Q8PqMoVp1XF?=
 =?Windows-1252?Q?HLQxCSeZvxqXhNpWC/T+xfOjDxhs2thEzhJ6hTNyFT88ztjzglH8K5JL?=
 =?Windows-1252?Q?VJJ1hzSTPPRlRYYTMTUl4U3KeqBmci6tjuox9eBZ9H16BVEOKNQ+n9PB?=
 =?Windows-1252?Q?/qzm6mVPYNukacP79VaarSRpfqJdWsaivIUiEbMY/yDksWdTQP9/12H7?=
 =?Windows-1252?Q?gz1BJxQbG9fhxWqEJlWZ82G1VbA+kjystMWhWkNBLGKfyFCSPGgufxcz?=
 =?Windows-1252?Q?NYcxzwlHg3CBmAK20QCPoPPE5tRygbtsA56ivNYvGoOqP8EURTV8AU1v?=
 =?Windows-1252?Q?+GSn2TElziCiW6W9a0unWLHeLrj6xX11wCfUyx26h6T2ArCLsMcBXg8q?=
 =?Windows-1252?Q?aiDjsRhLFlS1MDWyXLffPNvrTY8nVtgFY8JHpebEe/HCGS015KtRTSE9?=
 =?Windows-1252?Q?jsZnlAlqAo+K8qDr+dHmqeauaBb3QWYlSnbjZhvzqT30ptjhRf/bU1+U?=
 =?Windows-1252?Q?fVKRR423gfUNseaLrFchMa4qs259NaqEsU1AK23/zWRwSCQLKqoc6VKS?=
 =?Windows-1252?Q?lvkjCqlY0455FUnUs4BQ6RWTPr9OIaGDYQyRuDwPdTWGo153/fjylI92?=
 =?Windows-1252?Q?2TqIH0kx9IuECFfQUDm50lnUGlb3U7k/FmGmWcYFTwBysD/slGeOu/k2?=
 =?Windows-1252?Q?muteKJXw2oCoWneH4Knhm6wfrM+Vq8ddYEoeCgYzjP2BSJHha+m+C32+?=
 =?Windows-1252?Q?92HbIgTVb2f8oIUFBnoGa7wc1izQN2MLrKi10reJe0rn0wvCa4Kc/Sf/?=
 =?Windows-1252?Q?SmagZsp06qG/t1km0gj0v8AZzbwgzg2lPMJCP7Edg9WIAkIzMtfwpT6q?=
 =?Windows-1252?Q?XbXSV+qUE/zWWdZWvWDFkLPhRryi418mXzrIx/Zrmx6eV5d+YkK5tqZn?=
 =?Windows-1252?Q?5aF4XAAtAibkbAqn/ZayiEVo3P4w25XCXwOQE7nHgSBshW3Wd/4yCp5D?=
 =?Windows-1252?Q?SuXn9Q2jZKjTnpyAiWPvjus8/o05BhUqaGvIKGokUlzSOwf+sdRrxhJ/?=
 =?Windows-1252?Q?iZ1RsXl/pZDIHPnc2aecSZ+lvRMWWHN0x29IkaMVVT606WNF4jrpVYxt?=
 =?Windows-1252?Q?Khx1uQqwwPQpYrJcRrnR662SxC86lfaOWfiOcHLhmeRp11mD/w44yPq/?=
 =?Windows-1252?Q?12+z5JCIqCSxtKRnYJlkYvyexD6P3im76ciI5Tb1tPUdFzitAxlckdfc?=
 =?Windows-1252?Q?rAIALm5M9ekJblB/qEzep+yiyyTV1larc4miaBL8SEuxYviES8DabC24?=
 =?Windows-1252?Q?3Yw6d4yiW9whyx6DfTPciyDfKEu8Sh1daOvRB5UD8fTjTtz9xiG9dQ4R?=
 =?Windows-1252?Q?BVEm4Igv5QhUiFmH2glms0det4FwCypnKTvyvbyXR92CfWT1a/G0Xr+D?=
 =?Windows-1252?Q?Vze3yKKPQYn3B/piFlJ1MIK+U7+/QQdky2pWKCK+W8jzvgOd7wNBVwDf?=
 =?Windows-1252?Q?QHAxAQoRzKcRLhhC1TspeedVhiYaCjPqHQwuStKjIJCgzFUZdSvkN/N6?=
 =?Windows-1252?Q?9I2mqrrmKDC14aDQ+4bBoitQ+t73fXt3G2H3b9GMyNknO/SjvB5pXnfZ?=
 =?Windows-1252?Q?DEhc23DHIpSPYkcIdgiJUVeNTZNc4A3llgDzKT7RYXBOO1wImrFPKel2?=
 =?Windows-1252?Q?nsU/mAkK?=
x-ms-exchange-antispam-messagedata-1:
 ljJ6Fg/LgsGJyFyV/GEkI/Wn00wHByrfkf3AnA694+N858W50+QJ6nKF
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB02952A907048F49E206674D492EC2PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1798f36-9cf0-49a2-4a92-08ded2c6ac9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 14:33:07.3426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7A+OWhQyV98QgPEpFQHORo3x4map19CZ4/97/6FuWl1CuYlPD2SFwexKng7DnT14hsV9DgUq8w0jsaTEfm43IEN+oS6iL1afPxgxKECiEnKoW5iIyxonGcGfmhGNl845
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF797C3267A
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB02952A907048F49E206674D492EC2PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB02952A907048F49E206674D492EC2PN0P287MB0295INDP_"

--_000_PN0P287MB02952A907048F49E206674D492EC2PN0P287MB0295INDP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

> Hmmm... from the explanation above, it seems like this is in the wrong
> place and should be inside run_program, around the call to CreateProcess?
> Otherwise, the same pointer which is passed to CreateProcess and
> potentially has its contents mutated by that is also assigned to
> dll_info[0].name, leading to a potentially corrupted string appearing in
> the DLL-profile table.
> If that supposition is correct, I'd appreciate it if you could come up
> with a follow-up patch to change that.

You are correct =97 moving the strdup into run_program, just before the
CreateProcess call, is the right fix. Please find the follow-up patch below.

Thanks and regards
K Chandru
Inline Patch

---
 winsup/utils/ssp.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/winsup/utils/ssp.c b/winsup/utils/ssp.c
index 84de523be..deae839d6 100644
--- a/winsup/utils/ssp.c
+++ b/winsup/utils/ssp.c
@@ -379,11 +379,27 @@ run_program (char *cmdline)
   int tix, i;
   HANDLE hThread;
   char *string;
+  char *cmdline_copy;

   memset (&startup, 0, sizeof (startup));
   startup.cb =3D sizeof (startup);

-  if (!CreateProcess (0, cmdline, 0, 0, 0,
+  /* CreateProcess (called with lpApplicationName =3D=3D NULL) is document=
ed to
+     modify the lpCommandLine buffer in place.  dll_info[0].name below poi=
nts
+     at the caller's original string, which is read later when printing the
+     DLL-profile table, so hand CreateProcess a private writable copy to
+     scribble on instead; otherwise the program name comes back mangled
+     (observed on aarch64-cygwin as 'test_hello.exe' -> 'st_hello.exxee').
+     The copy is only needed for the CreateProcess call and is intentional=
ly
+     leaked rather than freed, as ssp is short-lived.  */
+  cmdline_copy =3D strdup (cmdline);
+  if (!cmdline_copy)
+    {
+      fprintf (stderr, "Out of memory duplicating cmdline\n");
+      exit (1);
+    }
+
+  if (!CreateProcess (0, cmdline_copy, 0, 0, 0,
           CREATE_NEW_PROCESS_GROUP
           | CREATE_SUSPENDED
           | DEBUG_PROCESS
@@ -1029,23 +1045,7 @@ main (int argc, char **argv)

   fprintf (stderr, "prun: [" CONTEXT_REG_FMT "," CONTEXT_REG_FMT "] Runnin=
g '%s'\n",
     low_pc, high_pc, argv[optind]);
-  {
-    /* CreateProcess (called below with lpApplicationName =3D=3D NULL) is
-       documented to modify the lpCommandLine buffer in place.  argv[optin=
d]
-       points into our own argv, so passing it directly lets CreateProcess
-       scribble on it; this was observed on aarch64-cygwin as the command
-       line coming back mangled (e.g. 'test_hello.exe' -> 'st_hello.exxee')
-       on later use.  Pass a private writable copy instead.  It is not fre=
ed
-       because run_program() stores it in dll_info[0].name, which is read
-       later when printing the DLL-profile table.  */
-    char *cmdline_copy =3D strdup (argv[optind]);
-    if (!cmdline_copy)
-      {
-  fprintf (stderr, "Out of memory duplicating cmdline\n");
-  exit (1);
-      }
-    run_program (cmdline_copy);
-  }
+  run_program (argv[optind]);

   hdr.lpc =3D low_pc;
   hdr.hpc =3D high_pc;
--
2.49.0.windows.1

--_000_PN0P287MB02952A907048F49E206674D492EC2PN0P287MB0295INDP_--

--_004_PN0P287MB02952A907048F49E206674D492EC2PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-ssp-Move-command-line-copy-into-run_program.patch"
Content-Description: Cygwin-ssp-Move-command-line-copy-into-run_program.patch
Content-Disposition: attachment;
	filename="Cygwin-ssp-Move-command-line-copy-into-run_program.patch";
	size=3940; creation-date="Thu, 25 Jun 2026 14:32:59 GMT";
	modification-date="Thu, 25 Jun 2026 14:33:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3OThkNjI5NTE4ODJiN2MxOGI0MjdlMzhhODA0NDg1YmQzMDNlMzAx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IFRodSwgMjUgSnVuIDIwMjYgMTc6MjY6NDQgKzA1MzAKU3ViamVjdDogW1BB
VENIIHYzXSBDeWd3aW46IHNzcDogTW92ZSBjb21tYW5kLWxpbmUgY29weSBp
bnRvIHJ1bl9wcm9ncmFtCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlw
ZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVy
LUVuY29kaW5nOiA4Yml0CgpUaGUgcHJldmlvdXMgcGF0Y2ggZHVwbGljYXRl
ZCBhcmd2W29wdGluZF0gaW4gbWFpbigpIGJlZm9yZSBwYXNzaW5nIGl0IHRv
CnJ1bl9wcm9ncmFtKCksIGJ1dCBydW5fcHJvZ3JhbSgpIGltbWVkaWF0ZWx5
IGFzc2lnbnMgdGhlIHJlY2VpdmVkIHBvaW50ZXIKdG8gZGxsX2luZm9bMF0u
bmFtZSBhbmQgdGhlbiBwYXNzZXMgdGhlIHNhbWUgcG9pbnRlciB0byBDcmVh
dGVQcm9jZXNzLgpTaW5jZSBDcmVhdGVQcm9jZXNzICh3aXRoIGxwQXBwbGlj
YXRpb25OYW1lID09IE5VTEwpIG1heSBtb2RpZnkgaXRzCmxwQ29tbWFuZExp
bmUgYnVmZmVyIGluIHBsYWNlLCBkbGxfaW5mb1swXS5uYW1lIGNvdWxkIGVu
ZCB1cCBwb2ludGluZyBhdApjb3JydXB0ZWQgZGF0YSwgcHJvZHVjaW5nIGEg
bWFuZ2xlZCBuYW1lIGluIHRoZSBETEwtcHJvZmlsZSB0YWJsZS4KCkZpeCB0
aGlzIGJ5IHBlcmZvcm1pbmcgdGhlIHN0cmR1cCBpbnNpZGUgcnVuX3Byb2dy
YW0oKSwgaW1tZWRpYXRlbHkgYmVmb3JlCnRoZSBDcmVhdGVQcm9jZXNzIGNh
bGwuICBUaGUgb3JpZ2luYWwgY21kbGluZSBwb2ludGVyIGlzIHN0b3JlZCBp
bgpkbGxfaW5mb1swXS5uYW1lIGFzIGJlZm9yZSwgcHJlc2VydmluZyB0aGUg
aW50YWN0IG5hbWUgZm9yIGxhdGVyCnJlcG9ydGluZywgd2hpbGUgQ3JlYXRl
UHJvY2VzcyByZWNlaXZlcyB0aGUgcHJpdmF0ZSBjb3B5IHRvIG11dGF0ZSBm
cmVlbHkuClRoZSBjb3B5IGlzIGludGVudGlvbmFsbHkgbGVha2VkOyBzc3Ag
aXMgc2hvcnQtbGl2ZWQgYW5kIGZyZWVpbmcgaXQgd291bGQKcmVxdWlyZSB0
aHJlYWRpbmcgdGhlIHBvaW50ZXIgYWNyb3NzIHRoZSBlbnRpcmUgZGVidWcg
bG9vcC4KClJldmVydCB0aGUgbWFpbigpIGNoYW5nZSBmcm9tIHRoZSBwcmV2
aW91cyBwYXRjaCBzbyB0aGUgY2FsbGVyIHBhc3Nlcwphcmd2W29wdGluZF0g
ZGlyZWN0bHkgYWdhaW4uCgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0b8WI
IDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KU2lnbmVkLW9mZi1ieTog
VGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1A
bXVsdGljb3Jld2FyZWluYy5jb20+ClNpZ25lZC1vZmYtYnk6IENoYW5kcnUg
S3VtYXJlc2FuIDxjaGFuZHJ1Lmt1bWFyZXNhbkBtdWx0aWNvcmV3YXJlaW5j
LmNvbT4KLS0tCiB3aW5zdXAvdXRpbHMvc3NwLmMgfCAzNiArKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
OCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS93aW5zdXAvdXRpbHMvc3NwLmMgYi93aW5zdXAvdXRpbHMvc3NwLmMKaW5k
ZXggODRkZTUyM2JlLi5kZWFlODM5ZDYgMTAwNjQ0Ci0tLSBhL3dpbnN1cC91
dGlscy9zc3AuYworKysgYi93aW5zdXAvdXRpbHMvc3NwLmMKQEAgLTM3OSwx
MSArMzc5LDI3IEBAIHJ1bl9wcm9ncmFtIChjaGFyICpjbWRsaW5lKQogICBp
bnQgdGl4LCBpOwogICBIQU5ETEUgaFRocmVhZDsKICAgY2hhciAqc3RyaW5n
OworICBjaGFyICpjbWRsaW5lX2NvcHk7CiAKICAgbWVtc2V0ICgmc3RhcnR1
cCwgMCwgc2l6ZW9mIChzdGFydHVwKSk7CiAgIHN0YXJ0dXAuY2IgPSBzaXpl
b2YgKHN0YXJ0dXApOwogCi0gIGlmICghQ3JlYXRlUHJvY2VzcyAoMCwgY21k
bGluZSwgMCwgMCwgMCwKKyAgLyogQ3JlYXRlUHJvY2VzcyAoY2FsbGVkIHdp
dGggbHBBcHBsaWNhdGlvbk5hbWUgPT0gTlVMTCkgaXMgZG9jdW1lbnRlZCB0
bworICAgICBtb2RpZnkgdGhlIGxwQ29tbWFuZExpbmUgYnVmZmVyIGluIHBs
YWNlLiAgZGxsX2luZm9bMF0ubmFtZSBiZWxvdyBwb2ludHMKKyAgICAgYXQg
dGhlIGNhbGxlcidzIG9yaWdpbmFsIHN0cmluZywgd2hpY2ggaXMgcmVhZCBs
YXRlciB3aGVuIHByaW50aW5nIHRoZQorICAgICBETEwtcHJvZmlsZSB0YWJs
ZSwgc28gaGFuZCBDcmVhdGVQcm9jZXNzIGEgcHJpdmF0ZSB3cml0YWJsZSBj
b3B5IHRvCisgICAgIHNjcmliYmxlIG9uIGluc3RlYWQ7IG90aGVyd2lzZSB0
aGUgcHJvZ3JhbSBuYW1lIGNvbWVzIGJhY2sgbWFuZ2xlZAorICAgICAob2Jz
ZXJ2ZWQgb24gYWFyY2g2NC1jeWd3aW4gYXMgJ3Rlc3RfaGVsbG8uZXhlJyAt
PiAnc3RfaGVsbG8uZXh4ZWUnKS4KKyAgICAgVGhlIGNvcHkgaXMgb25seSBu
ZWVkZWQgZm9yIHRoZSBDcmVhdGVQcm9jZXNzIGNhbGwgYW5kIGlzIGludGVu
dGlvbmFsbHkKKyAgICAgbGVha2VkIHJhdGhlciB0aGFuIGZyZWVkLCBhcyBz
c3AgaXMgc2hvcnQtbGl2ZWQuICAqLworICBjbWRsaW5lX2NvcHkgPSBzdHJk
dXAgKGNtZGxpbmUpOworICBpZiAoIWNtZGxpbmVfY29weSkKKyAgICB7Cisg
ICAgICBmcHJpbnRmIChzdGRlcnIsICJPdXQgb2YgbWVtb3J5IGR1cGxpY2F0
aW5nIGNtZGxpbmVcbiIpOworICAgICAgZXhpdCAoMSk7CisgICAgfQorCisg
IGlmICghQ3JlYXRlUHJvY2VzcyAoMCwgY21kbGluZV9jb3B5LCAwLCAwLCAw
LAogCQkgICAgIENSRUFURV9ORVdfUFJPQ0VTU19HUk9VUAogCQkgICAgIHwg
Q1JFQVRFX1NVU1BFTkRFRAogCQkgICAgIHwgREVCVUdfUFJPQ0VTUwpAQCAt
MTAyOSwyMyArMTA0NSw3IEBAIG1haW4gKGludCBhcmdjLCBjaGFyICoqYXJn
dikKIAogICBmcHJpbnRmIChzdGRlcnIsICJwcnVuOiBbIiBDT05URVhUX1JF
R19GTVQgIiwiIENPTlRFWFRfUkVHX0ZNVCAiXSBSdW5uaW5nICclcydcbiIs
CiAJICBsb3dfcGMsIGhpZ2hfcGMsIGFyZ3Zbb3B0aW5kXSk7Ci0gIHsKLSAg
ICAvKiBDcmVhdGVQcm9jZXNzIChjYWxsZWQgYmVsb3cgd2l0aCBscEFwcGxp
Y2F0aW9uTmFtZSA9PSBOVUxMKSBpcwotICAgICAgIGRvY3VtZW50ZWQgdG8g
bW9kaWZ5IHRoZSBscENvbW1hbmRMaW5lIGJ1ZmZlciBpbiBwbGFjZS4gIGFy
Z3Zbb3B0aW5kXQotICAgICAgIHBvaW50cyBpbnRvIG91ciBvd24gYXJndiwg
c28gcGFzc2luZyBpdCBkaXJlY3RseSBsZXRzIENyZWF0ZVByb2Nlc3MKLSAg
ICAgICBzY3JpYmJsZSBvbiBpdDsgdGhpcyB3YXMgb2JzZXJ2ZWQgb24gYWFy
Y2g2NC1jeWd3aW4gYXMgdGhlIGNvbW1hbmQKLSAgICAgICBsaW5lIGNvbWlu
ZyBiYWNrIG1hbmdsZWQgKGUuZy4gJ3Rlc3RfaGVsbG8uZXhlJyAtPiAnc3Rf
aGVsbG8uZXh4ZWUnKQotICAgICAgIG9uIGxhdGVyIHVzZS4gIFBhc3MgYSBw
cml2YXRlIHdyaXRhYmxlIGNvcHkgaW5zdGVhZC4gIEl0IGlzIG5vdCBmcmVl
ZAotICAgICAgIGJlY2F1c2UgcnVuX3Byb2dyYW0oKSBzdG9yZXMgaXQgaW4g
ZGxsX2luZm9bMF0ubmFtZSwgd2hpY2ggaXMgcmVhZAotICAgICAgIGxhdGVy
IHdoZW4gcHJpbnRpbmcgdGhlIERMTC1wcm9maWxlIHRhYmxlLiAgKi8KLSAg
ICBjaGFyICpjbWRsaW5lX2NvcHkgPSBzdHJkdXAgKGFyZ3Zbb3B0aW5kXSk7
Ci0gICAgaWYgKCFjbWRsaW5lX2NvcHkpCi0gICAgICB7Ci0JZnByaW50ZiAo
c3RkZXJyLCAiT3V0IG9mIG1lbW9yeSBkdXBsaWNhdGluZyBjbWRsaW5lXG4i
KTsKLQlleGl0ICgxKTsKLSAgICAgIH0KLSAgICBydW5fcHJvZ3JhbSAoY21k
bGluZV9jb3B5KTsKLSAgfQorICBydW5fcHJvZ3JhbSAoYXJndltvcHRpbmRd
KTsKIAogICBoZHIubHBjID0gbG93X3BjOwogICBoZHIuaHBjID0gaGlnaF9w
YzsKLS0gCjIuNDkuMC53aW5kb3dzLjEKCg==

--_004_PN0P287MB02952A907048F49E206674D492EC2PN0P287MB0295INDP_--

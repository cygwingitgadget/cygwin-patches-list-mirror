Return-Path: <SRS0=dsF1=EV=multicorewareinc.com=chandru.kumaresan@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 706AF4BA2E1B
	for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2026 12:22:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 706AF4BA2E1B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 706AF4BA2E1B
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1782390122; cv=pass;
	b=v5VOMr5fhgdiMUTlDtG7JFs0D8guVXaMgUZZThaqQAItDS9njG6X+7RTKqr1/jM4yu4UpTavn3RxY8RWKC7ZMWOKZitsFAAR78gahDgszt2cCFGXJMp+eZq9+oj0nkkp8ZsQ3NcsY3ayQ0Xf4W/Fj28j7jSHvcBidLsl+efHIUM=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782390122; c=relaxed/simple;
	bh=to7C5IesiBv0YS8qyikyKszJ9s4uMvnT9oHHgDizRiM=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=f02Pr4A3NoStc595HnDj4uaNrjnJqoNHVyfn+Ae7iZEgeGoGKymMYHG23ZmlXop3+ysx+51tb2gS/pjO8e+ihj5ZhK2mVby2Vcz5BBJQYXUMp57H/H90+dQ1UYcg0sA+T6a6WNTIzPjnfSs5N1BqvmY9AvqOAzB8Jd5uAseLzW4=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=NsLqRaSq
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 706AF4BA2E1B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=NsLqRaSq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqTNhDLpRYtCARXYxx2LGCduqRTqjwgUdakg5CFuE4wdw6S3GqCAQpyS5dVJyaBVYaNmWypQSwnUbUAEqCG0tXjNyuTSdPFdB4PbiSGClgOzrb+swDD2kqtCOg//BJyoEJ1gJuwptlvW1Iy9FkQBQyYwbrZznxMdsqy9mU2MurjAwuM8R/8PX9c+sRFjivI/Ps/5zkdq57D/mWRmJEUIe4VoijP6p0uwRUS/3FoOxDNo+LGr33FN7mRB3jwxc6e9Z2XX1rDf70zIFIhNo7G1gQCfbfLQEl18hG5JxYA4nnEJhSnmfw8pnAqc4RxLO82ijwKYSM6o/MMiuz/9a3+WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGHnULJ2wTRpTBm57T2CGa8NrjqRBnIH1K/OOY2xKMM=;
 b=BhupDq5QLCrCyvm2EYJK/yO+1AywQF0JfsjlANELNuWRN+pA3HSy1FPIHKbGY2btdfnzGIZqfpn0z1exxrcG5VgPiW+mxbkySF2rGlCj0U6oTw5IShDPtrXldAsV6lmGdZX1jUHB1hvuBl8orgpSJNYQnwCMOZwg2slXmH6EnTgl2iH6kZqa90u7HQCkMV4ti+LJHMT59J0vlUUfkSSqGyLPZ3gycW3pelLkIbT1Sq8pXOvqCFATY7x9sgSWIbvWw5zlqEDPYGBpinMcT7YoAti8upIK62edQF/2ix1etl6bHAP4tvfjaqra0SzXc54U/MVkqpERxBSFxGzZqo/i3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGHnULJ2wTRpTBm57T2CGa8NrjqRBnIH1K/OOY2xKMM=;
 b=NsLqRaSqNX/sJl5ZHKzfOzGhdDXcG6xAEKEblvnAqMpAoGdVhhv66XJISAR2HlDsPeSWBkiodke+OajevVOYCLjsKwABdpLmB7zKu/mmlLDhW8pJ1Qa8J5J2/ucFtiQayVTTk3n6V55GNMHYYL9LwXA96mrpQhVShmfmGHr1YxHZK/0gplpqI+oNJWF5lQ13D5NdvFEd5kZRF/Fc+yg9qVw7fKHSgLge5525u5/vUTdmA4Szgxt51vxXbERyZ1Ix0/M1FZzsk2rk5nrztKgzTKg3wZy2v4lIZn4aUSVG5LkmFVS8bC9LSin2jBFOA7At7YNeo4z5l+04rFM2GwPl9Q==
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::10)
 by PN0P287MB1308.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:17e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 12:21:55 +0000
Received: from PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070]) by PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
 ([fe80::cb75:9295:2928:9070%7]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 12:21:55 +0000
From: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3] Cygwin: ssp: Move command-line copy into run_program
Thread-Topic: [PATCH v3] Cygwin: ssp: Move command-line copy into run_program
Thread-Index: AQHdBJ018STdl1ExNEC4xe8ygr0guw==
Date: Thu, 25 Jun 2026 12:21:54 +0000
Message-ID:
 <PN0P287MB0295A49DE62713D1E8BB8A1392EC2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
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
x-ms-traffictypediagnostic: PN0P287MB0295:EE_|PN0P287MB1308:EE_
x-ms-office365-filtering-correlation-id: 46d5fd3d-dae4-4c2f-a576-08ded2b45842
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|23010399003|31052699007|39142699007|376014|366016|1800799024|38070700021|4053099003|5023799004|56012099006|4143699003|55112099003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info:
 0biiQsicGaobk3r/a0depNIjH1iOujY5PiOpC/YODxaMsFs8K4iJWFhaYtRfM902DftgpaRJxjQ7vn0qItyPyIPmBxiN/0LDuwMG1GBVK0/jGgNKlS9VuYRhFNabjoztYMXa7h3jUTUODP5J+yfprynVHon7RzEJqgJE7smX8XFLhcTupyeLtyTFpxagbiUbcPG7HiHEtoBMgu8/67HWD4ged8lBaq+tO9kPU57vECOzMYKHvpit285gCrsQWqoTukwN2dglN7v+2tB8terVOXvfSZuu8Le52AlJn9dPVibx9Hk3jSZZ6kiVqXZQdMtOkegk1QhhXMwDBQ1UKrPDHKok63fcTiq2AXiF33nMAM5jD8urrPETWLuStZE9UNxc/bAkpcQwjlXAut8Qgg/ZY10wcQ0b5ZyrJLwKZQ9VVEGNdcAR/t3p6DKlVB/nDwtx48+HFVW+fEMq6g5X7PBwwbaThFsLiVlh2BowooY9Fz4HJMcDob6f1Rp/IX5g83DX6l8xycmqqlKlTG8/BQjeZ62KuhbiLaazi16vMIxmj/jyGV4GjA/iIFgcuW41NjibK6yAQ0jreApRa7w2V3ExeL0CJBD1tEV4A/5eiiTfpAVKSxHnPz6z3w4B7I55foEnuIGEFRLXE/RYHHFfrOf5J/W23bABHBrLXfyGQ7wUKKBANp1uwuxAjp6E05hg1c+P6Ov2jqVGfZDjOqYNcd6UUtMHIHpcsL3LCTrpmkpA6VI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0295.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(23010399003)(31052699007)(39142699007)(376014)(366016)(1800799024)(38070700021)(4053099003)(5023799004)(56012099006)(4143699003)(55112099003)(22082099003)(18002099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?D5HuVy5MX2lj0oCfX/KKIcLNYYhLOz3q8l74BM2lUN7pz5hAC6US3ny8?=
 =?Windows-1252?Q?1HWYbNLUTMgcsLcvvOYSdEOvOPEDO5IbDYoqt5MLmZdP44BJMN3ln70E?=
 =?Windows-1252?Q?r/Jo2QGyVR2tFAXkGNDsQkEEgdOfuKauRVTG4VZMyu8VCP6N4f9lff5u?=
 =?Windows-1252?Q?Y1NSzq/F2GC2rwTzsvEc3HYgIyQcknJoaBH6bz7AOg9veuDUdA87EleU?=
 =?Windows-1252?Q?w/RTZwbHTwq0kzj4sSrlp9LC1qUifDJ2xrlO9+RspAqQn/dtNyyYv3R0?=
 =?Windows-1252?Q?sgwcFlcywN7MKeNM8Ho84PLVQJwIV3LxTcyGCUNejx+P9xsIhgwn8omc?=
 =?Windows-1252?Q?6YDva3Lwd1yqb40wjo+hprrqjLzW0qBRc1ncScaXgBMhH63FosvxG+/t?=
 =?Windows-1252?Q?xm9aH3aYeX9GvKhTYtF0Cblfa5vLhGIDkMT3t6WvO3S+fntHgRRKj8vL?=
 =?Windows-1252?Q?5x2224xUA2tHi/1yoVnkJ+AEi/WmNncTNj662FzBRc7hu0YaSa0J32Om?=
 =?Windows-1252?Q?T0BUsiqv/L8oDjXWl1cOt1EJ/9qweT7DHpyAnnQQChZ8Ezx7sfy8zpwi?=
 =?Windows-1252?Q?2h+PDBXGyaB/Ahxz0JCf6m7IayC1FUjU+G1WN9wg7TqfpSKjoMzsZP7K?=
 =?Windows-1252?Q?ur5TI/L0nCIUg4W3ubJiKBP+pn6TIEuxbc85UjNr9pjSKqXAUUb3hW5I?=
 =?Windows-1252?Q?tcVOynQXzyCaLP3s7ATcou1PV+N5vuiY32iotzxyBnvFtTcE4gd6vDGh?=
 =?Windows-1252?Q?nO4wxRYUPY5bQJL3dQ175xEU2QVLDwDntQfilvC/g212BmrDsM5N5Q7T?=
 =?Windows-1252?Q?FHR/hxlzD8OMiLZYuWppwmCWbGTfGLJuYtIpJExM3ZezKNe6E8Ypegmi?=
 =?Windows-1252?Q?eqV3efZxguasm8ZNgowluG2UUKd+UxA4ZkTcLoQfrfPpKcATopa6EiSZ?=
 =?Windows-1252?Q?hYprD2rAM0AK+ucJBFSKhncLQWZV41Y0Lg9GEQUHGW90taW2yrZyOwyl?=
 =?Windows-1252?Q?mjfCrUznV439N9wBNyeINtrVoO8URk1amVN7ezZYOybW63ktWrP4xVec?=
 =?Windows-1252?Q?fWTQKt7imnRiJ1ZBTHbOy1om6j7wvMAtePhYqFBbe9kWIH5iRdzOJsf9?=
 =?Windows-1252?Q?MfVIyhcHrVn1LHr3XRNZl1ucE7BNn5kpBaTuD7nborvHOr0esNvkwOn+?=
 =?Windows-1252?Q?61YtabDbDFtIGAd97x07OUNRyj/bST/2ujySheq9Km2KiVMP0c5PdT+G?=
 =?Windows-1252?Q?dEjvlq2bdx6AVd2up6uSqrsAk37qDgOHnWHpWX///p6gZBdC4sHYssQ5?=
 =?Windows-1252?Q?2Trad93lSvOUkJHr3ID2J2Eo2BC5kIcNSiUeM2TsMkEkGFAsVs8fIeqN?=
 =?Windows-1252?Q?WUF+cSM+xzpIkIk2ohZk9qPgvTjqVSpOWAWtqDosCELq6twx4mXRexoX?=
 =?Windows-1252?Q?h0PHFdqQfEipsH7OLZoajOWXqdY2CZ38w4TjoMExhq9WMzep2TOX0uFN?=
 =?Windows-1252?Q?t/vqELp222dm+jlcCaSzPUn21LFhjDW27Jvt7oPMsV6tve4b3vF7Bxh1?=
 =?Windows-1252?Q?3YVbHe44v0PceYZC/KbF9b/Dq+EOmiSa/KUrzYjAtHvSb90msDOMVvwN?=
 =?Windows-1252?Q?ZZ0/MIKfHAX7RNUzdvzRTrCvC4at3X8n9pUJ/WSK7rL1kv2ygryHlO1U?=
 =?Windows-1252?Q?tCKv6nHTPwOK4V83vlCOjjowkLlmYrimogvCLJWhUohbXSqKxhYvIEbl?=
 =?Windows-1252?Q?jjvBDQEyt2Gq81d6ELxbnTMEIPihTOQn1mi+uwe3JBjaQi7xKaM16Fcs?=
 =?Windows-1252?Q?dHymQP0GqvegLQkEvnjxMWXOr1rw7eQTyGGK43efIBLHw80898KXxCcM?=
 =?Windows-1252?Q?Cz9DgevikC5kBkUY+aBFVpt7MAkqPxY+iRU=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN0P287MB0295A49DE62713D1E8BB8A1392EC2PN0P287MB0295INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0295.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d5fd3d-dae4-4c2f-a576-08ded2b45842
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 12:21:54.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Btw603zvrNl1ltutFgSGSw1QXgZszaHlw9QwyTdsehJqwZGPVLfLnRye5naiaSCNfJPdVUOVa/bRLcNzFsqZ44q7nxGTHR2Fp8OND5d4eg1l6ovXrXBRQRvydd5gc9lD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1308
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN0P287MB0295A49DE62713D1E8BB8A1392EC2PN0P287MB0295INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB0295A49DE62713D1E8BB8A1392EC2PN0P287MB0295INDP_"

--_000_PN0P287MB0295A49DE62713D1E8BB8A1392EC2PN0P287MB0295INDP_
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







--_000_PN0P287MB0295A49DE62713D1E8BB8A1392EC2PN0P287MB0295INDP_--

--_004_PN0P287MB0295A49DE62713D1E8BB8A1392EC2PN0P287MB0295INDP_
Content-Type: application/octet-stream;
	name="Cygwin-ssp-Move-command-line-copy-into-run_program.patch"
Content-Description: Cygwin-ssp-Move-command-line-copy-into-run_program.patch
Content-Disposition: attachment;
	filename="Cygwin-ssp-Move-command-line-copy-into-run_program.patch";
	size=3940; creation-date="Thu, 25 Jun 2026 12:21:24 GMT";
	modification-date="Thu, 25 Jun 2026 12:21:54 GMT"
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

--_004_PN0P287MB0295A49DE62713D1E8BB8A1392EC2PN0P287MB0295INDP_--

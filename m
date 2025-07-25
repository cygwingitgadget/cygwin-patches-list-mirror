Return-Path: <SRS0=+QaW=2G=microsoft.com=radek.barton@sourceware.org>
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20717.outbound.protection.outlook.com [IPv6:2a01:111:f403:260e::717])
	by sourceware.org (Postfix) with ESMTPS id 247163851AB4
	for <cygwin-patches@cygwin.com>; Fri, 25 Jul 2025 11:07:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 247163851AB4
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 247163851AB4
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:260e::717
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753441649; cv=pass;
	b=hqZFYPyF3gBJpHEEVIMtrW6CU0US2AOfnyuF/znyu8EmrQ6sbX97pmnZg7wdAEyfflHNJB6uYUxfhgyIuRob5l+SZPaEW8LFCexVLpTXehFw5rEyjJGj44Dy0AaqgoZYuVrsMD7E4sF5YHYG9fjc+3Nnh+5y3z5s8PrcJm26xSU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753441649; c=relaxed/simple;
	bh=YxVn761q1evPsFL+0XOEdTyQQP9Jb0tT1yH1if+zchI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=L6ukQ/4hEwICf/EEYFXEN7WgRzMQEypO7iAE9Ts6D4ynS7aiKS4ZBmrpg8UR3t4P0VCnrddHhx5u3f7N92q+1X8Cj9YIHIDPe0e6qiF6bohe0NqbbdAAQf691RvT53sqJTb8y3MipHCMY6DKuWul3CS0Zf9LuEnnXxEQ+Iwyvqo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 247163851AB4
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=VIgn0n64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+3BJk1Dm2kpFlytujqc173/buXjDgS4MkeKOTecLof+ea989+D3QHV8anxfWx3zATxTpkMneJXPLwpk/FwWeJsFaGOayGednKw69TKNKKk7MlacK/dIjfY7RGZ6HBnP1WsmRKCRnWswdqRUpybdK9HOaMyvpwbOwESw7ojcw3wd357LLwBNAy1x7vsLG2Oq3IvNBrLJ+7XlfCcRfxOa9A9l2p4F6+0VHPJ5yfkX7kx7Jajg4EgY1p0LsVF5X8j90uJawVbRjZBNMZkq2XyGRp6Zv4gXLqzVuhSnf/E9LwHvCKfjFPd8aXu+8XfJC9jikGj61Vs4TyFVApgg6JQeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rySm7tnDGSBnp26yJ9UWdO1VQWJqr0vvSNHeA34AYQ0=;
 b=yqKs4s6TL8ntC7ip/CnfbAUxeIwne9slypN/m0/O0mf03nZI5DKbo3FbCnafhoV5LxeMoStv2izUTD05vA7wDrgqzzbBI1hPiJIycGoxpsBNSoMFCbF9hb0g8sArxeSdeHNfsNhevNDtpMw9LqfjM9Y/lXpGPwDv2yphC1nWNa0jtcIuClMVT9aAAKuaozTMsnRndMKxUBGXUeQRMJedR5zkMg59Rk2yX7P83MVbYpbzPmM8rLe0BX9QMWKldCwyJ0xRhBbTXBj7CLc5yZss1MPJwlRf+KGVCm9yd4hhtNuZ0utAkevJx/MEUOnzxnw6dSmBn2E2ik/Hg4mauR9ZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rySm7tnDGSBnp26yJ9UWdO1VQWJqr0vvSNHeA34AYQ0=;
 b=VIgn0n64gbPj9a7xCEMiNAaDnqwknp3NI7LoqGWeTtFHR9RM7b/cX6NZlOLjODjtdI7BDgq8k8VaO8uPlEgqKoiUPnVK6aZzlaebz1iVbh6JT+GvqB2Z3qND9s44Y5m8m//w1SKf1+hXhwvU60vs9cUNjKUIXVdbaSo3vnP1rek=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PAXPR83MB0560.EURPRD83.prod.outlook.com (2603:10a6:102:247::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.12; Fri, 25 Jul
 2025 11:07:26 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::eb7:83b3:42aa:9e7e%4]) with mapi id 15.20.8989.006; Fri, 25 Jul 2025
 11:07:26 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v4] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Topic: [PATCH v4] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
Thread-Index: AQHb/VRN+TT5V2Cd9Ui/nP1Cvzvndw==
Date: Fri, 25 Jul 2025 11:07:25 +0000
Message-ID:
 <DB9PR83MB092391AD95379EB112A8EC339259A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
 <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9jZCS92AGUaP-o@calimero.vinschen.de>
 <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com>
 <aICZuCg3tKXOj_mR@calimero.vinschen.de>
 <GV4PR83MB0941AA5AD0E67B89787B1FE0925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aIIM-ZOEUZDsq-og@calimero.vinschen.de>
  <GV4PR83MB0941BC79A50B76470922FE38925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <039ff598-6a8d-3a16-c544-be7dae5b2a78@jdrake.com>
In-Reply-To: <039ff598-6a8d-3a16-c544-be7dae5b2a78@jdrake.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-25T11:07:25.094Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PAXPR83MB0560:EE_
x-ms-office365-filtering-correlation-id: 749538ba-a65a-48b2-b44d-08ddcb6b7025
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?hqkf/R1rRDST7QGCvDfh9uESHaglKk/3TqGPn0LpdySOg2GbKcXPqdywUb?=
 =?iso-8859-2?Q?MT9pdg4aBlP6JRgRpOWEqsB2N3EQypyIS2Ez21ZXs9vYHHzcNlJxFsRK3B?=
 =?iso-8859-2?Q?hpgrIfGjahnunnOpBKSo/ewfCjkFXsKwqxyO14TzUkbaajNQU32K8D/Caj?=
 =?iso-8859-2?Q?r3+zxnluuo1IMNq0YX5kZ9PqwgkLVKYEN91xYy1CeB09cB6zBrtOIHovGN?=
 =?iso-8859-2?Q?Um4lxvVHNUxewxsvds75482xmIWMO822bLLG8hnv4wDXMTbS+9M5SJV7GM?=
 =?iso-8859-2?Q?PovoeB+Li7a0ngNkM6UcevT1XG3cKs4sjAYxp5cySi2mm9lwjl1T5kgV8f?=
 =?iso-8859-2?Q?SEXhKmRb2lHNI+GLhmJpnxWEHxbC4jqqORMHxwLIL6fVE1fg1hbHvpvCVd?=
 =?iso-8859-2?Q?gT96ifwppytzZyqvwfHF1puwiad/PKMvq04XSmikkPcArrqtRIS9eo82Mv?=
 =?iso-8859-2?Q?3hD7i5hkt6n1oUdvr+b6MZLfCn5f7sJz4ktbkJvkn3WnqVQGOvGMaeXFDA?=
 =?iso-8859-2?Q?yDV/Bv/uMY9wiLIh8wD8NRC0IlvhZhQRvY6k2qpo5XFic5UxhRRY/6KFv1?=
 =?iso-8859-2?Q?DDpaBbkNF8Rp/h/1np7vrPA39CPY+SGszxy445HQstZIV5V9dzgO3iEGBo?=
 =?iso-8859-2?Q?n1TW85elojiAWmJdbaEYxv/egqZcxrwOJiRjQWtOHoFRFhTJr33LgU7euU?=
 =?iso-8859-2?Q?Yq4l878tTaLdQhusS6V7cAz8PtN5+vJobzLV1nr9dFTCLfnNiUOZYDImiB?=
 =?iso-8859-2?Q?B8ovFwAqrECOIyGczLqYvrvuUpTIxVIfpZhRu7AmOSLoFE5UJbR81VeKsr?=
 =?iso-8859-2?Q?J0MiwqCdH3lwSEHelcVLd0TjCl4ZEGj7V2hcNzea/RsKwiwAkV/ZllSvkQ?=
 =?iso-8859-2?Q?6DjIyFmIVoQZ0hjFUZpuRgA626G3W8ep/8tjdr+nHvsRLByEj6CbRwd/Hh?=
 =?iso-8859-2?Q?M21QCh2KWVP6ZK0bB1eOLWu5du5M+EKF+FVfBBaHvWrcX9mQ6nZE/Yac3J?=
 =?iso-8859-2?Q?5oU4I3c4V/axYochD4ZIwkfUDtqN0nWiWgH1zbNLHEQYH8ZzK8WZc7PbR2?=
 =?iso-8859-2?Q?CoZ4LlnMQ+/G0xeNWEE+ntTQK+n34FVbd96aLEtP4XTuNRYHxny9TL528k?=
 =?iso-8859-2?Q?w+5BTJvvFCDzXVdPihaJsrwH6xL6mnOGIBVvECs+X8XF/OlskL4cpHQlSX?=
 =?iso-8859-2?Q?QxkjcjgxqjkkkM+JS92pF2SWtZ82SBzG7G7w3QAtL6kP+8YnlqclTR3HVc?=
 =?iso-8859-2?Q?MoXdbxjt1iRaXQdSz+dB58NSybugWrXo+bPt2BGnVO1v+X2TiKfpdJIO5Y?=
 =?iso-8859-2?Q?t+Jupc33GQuKsgrzwRdWlNStnBGJYIqMTshuWYpQYjcnHyQ2l+ckqlcFAx?=
 =?iso-8859-2?Q?UaMFz838SohvcOUWGvAyFqr/8JFkQHXo4nPzhxC6Td8iNtQGbdlK3LDQfB?=
 =?iso-8859-2?Q?+9VKxcZP5+zWE9gwj85lytuHuDWyC9foDpbRYx80+DgWw/stlDSAi3peNR?=
 =?iso-8859-2?Q?Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?RWKDzD/0U0n9jvtobsbUs3FqsqB4i5doNgYBbfgeuRoGNH1/VdD0PW6lh8?=
 =?iso-8859-2?Q?vG56lkpUb0BvtqYBdYFvFbPLlpHeUZe3VPf05CREtzpJinLO3zP17cMUIl?=
 =?iso-8859-2?Q?r7SOdingIefZMBe0vdb6It+UaA6XCRA0immcPBKwrSpEidZMtbqR+1iDTD?=
 =?iso-8859-2?Q?ghGzA7BS9FpNesJJLtTBSa/zM6qQKoRLzSEFqrxJHqjN3B3ZngkwFZW3Oi?=
 =?iso-8859-2?Q?yKKQ7Ki/ob8Mhx4BTxYLw+LPxzNfg8VjrSnbMJ+LKuVB8Cv744VeIyhKen?=
 =?iso-8859-2?Q?x3RqXB+g8MLdREqGIkOnh52O0q25KahifzCMLPK24WkYMgHHJOKpLbhw75?=
 =?iso-8859-2?Q?0s60UuHaVUBlgRNLOBXbTU4PgapcXag4WDJhgZt1bX5h+QDgZWGaB4x6cc?=
 =?iso-8859-2?Q?QRRD7SyojyNPNv6ReAc3HdEsn6pBvLjB5Jymo9AMzdsnI+Xvocd8u/5pz9?=
 =?iso-8859-2?Q?kW1E0O7a/UBFYvMQ4Hrc4Y09TZhZ85KyTa8ZyI9RWlqtY9x3Kp28iarUMJ?=
 =?iso-8859-2?Q?7xy66NkjATHB0T4NiwnBB3CB+802aDg2b2/GMBdVKQUqkVRFq9MTKbYZ9j?=
 =?iso-8859-2?Q?0dFjP/BzG6JPs26221VXVgpK8psMqtWeqj82I1qO+4VZoXPtFVbQ+aEpg3?=
 =?iso-8859-2?Q?uHBeFG1y433pDOF+LuobvGisepEGTjjwXe2sgA7nGwgayzT0AXZiM9loL3?=
 =?iso-8859-2?Q?1A5UhN+BVXxrlsY+v18it2md/LW7hPiIkRFsejhGVEX/6t5BvnU4k3kvOZ?=
 =?iso-8859-2?Q?fRGvvswDUOtnnRnOO+tff/pSbFH6UAdwj2QVSyLByIzcy3cUIBq4roJbZn?=
 =?iso-8859-2?Q?ssEjxZ/Lug7qeozweUGa+AEiddHzxZZ07BhCXP4WpOeSvHXZ7ie3utp0lz?=
 =?iso-8859-2?Q?pIYLEKDjWiM4JAFJ5srHFgUI1pzByXAhrUP2gmKtcgyJl+m05VPKhbIN6M?=
 =?iso-8859-2?Q?S6fIcCjDg81UVze2nYRflEE5v84+TXl/odBsnxijkbNsPXalnL5YnFNEp1?=
 =?iso-8859-2?Q?CE9+aWJYCx5wZDfFhG2gFGBTJuZjnyCLSVxyxBfpy1tug9c++FloDzymVL?=
 =?iso-8859-2?Q?X3Swmo7yqCJpEKLddq8Ib1LxUMHRYWSo3mCifZzRwpWt1ZimDgQpSsTQbp?=
 =?iso-8859-2?Q?R1ER1HnXbEjPBiEtY4T2GU3ayq8/xi2yw+ii9CGU6bv49N8gY9yWL4/BHV?=
 =?iso-8859-2?Q?+cCNtWPFiQJd9fUZRuzveoe8bF5RTRVWUWq59696pdoiByZpBZtVVsT2o8?=
 =?iso-8859-2?Q?33Px1WxP9RZahE+pKBtPNmc2FDc9UwYZLY98ML5TCJSNr3/LgO+9n7Lwpg?=
 =?iso-8859-2?Q?4ziD4MYBZXJ0EuSl90H9TKamjnG/q/xHfNGBESS50GRhJErOIUI2Q1JsjB?=
 =?iso-8859-2?Q?SNF4p8spLITyaDFW8o6VJqHrdp2/q0YaWP0OUkXgx1f8cmsv+w322Jfd4d?=
 =?iso-8859-2?Q?8k2RjKAsq3X1/Oyt090LToBUl0lOoKcevxAmhYyN8CoeIK2bTRNLD8sqMx?=
 =?iso-8859-2?Q?oD3NydZLMs3mZXVchtffguznxwiOkpfHbrXI6LYfo8jZOMDer+wQHXDvxD?=
 =?iso-8859-2?Q?Ta00ChgD6ov/x/irUXYgfeH+QGoU?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB092391AD95379EB112A8EC339259ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749538ba-a65a-48b2-b44d-08ddcb6b7025
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 11:07:25.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bm+nbaA3pdEvBwtyij36DRxWFcW+o7JQYhlOoj/k5UMnm/MrLif1db5Vf3kiSXpQH0M1L4apWsTz76q6wCBuWjBSsnz/64iQPnGaILczg2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR83MB0560
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB092391AD95379EB112A8EC339259ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending another version with suggestion to use more strict conditions for i=
nstructions detection applied.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From fed90421a5c9c8539a7aad92588730f0a84fd306 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 19 Jul 2025 19:17:12 +0200=0A=
Subject: [PATCH v4] Cygwin: mkimport: implement AArch64 +/-4GB relocations=
=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Based on https://sourceware.org/pipermail/cygwin-patches/2025q3/014154.html=
=0A=
suggestion, this patch implements +/-4GB relocations for AArch64 in the mki=
mport=0A=
script by using adrp and ldr instructions. This change required update=0A=
in winsup/cygwin/mm/malloc_wrapper.cc where those instructions are=0A=
decoded to get target import address.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/mm/malloc_wrapper.cc | 29 ++++++++++++++++++++---------=0A=
 winsup/cygwin/scripts/mkimport     |  7 +++++--=0A=
 2 files changed, 25 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/malloc_w=
rapper.cc=0A=
index 863d3089c..db6ffb5a0 100644=0A=
--- a/winsup/cygwin/mm/malloc_wrapper.cc=0A=
+++ b/winsup/cygwin/mm/malloc_wrapper.cc=0A=
@@ -51,16 +51,27 @@ import_address (void *imp)=0A=
   __try=0A=
     {=0A=
 #if defined(__aarch64__)=0A=
-      // If opcode is an adr instruction.=0A=
-      uint32_t opcode =3D *(uint32_t *) imp;=0A=
-      if ((opcode & 0x9f000000) =3D=3D 0x10000000)=0A=
+      /* If opcode1 is an adrp and opcode2 is ldr instruction:=0A=
+           - https://www.scs.stanford.edu/~zyedidia/arm64/adrp.html=0A=
+           - https://www.scs.stanford.edu/~zyedidia/arm64/ldr_imm_gen.html=
=0A=
+         NOTE: This implementation assumes that the relocation table is ma=
de of=0A=
+         those specific AArch64 instructions as generated by the=0A=
+         winsup/cygwin/scripts/mkimport script. Please, keep it in sync. *=
/=0A=
+      uint32_t opcode1 =3D *((uint32_t *) imp);=0A=
+      uint32_t opcode2 =3D *(((uint32_t *) imp) + 1);=0A=
+      uint32_t opcode3 =3D *(((uint32_t *) imp) + 2);=0A=
+      if (((opcode1 & 0x9f00001f) =3D=3D 0x90000010) &&=0A=
+	  ((opcode2 & 0xffc003ff) =3D=3D 0xf9400210) &&=0A=
+	  (opcode3 =3D=3D 0xd61f0200))=0A=
 	{=0A=
-	  uint32_t immhi =3D (opcode >> 5) & 0x7ffff;=0A=
-	  uint32_t immlo =3D (opcode >> 29) & 0x3;=0A=
-	  int64_t sign_extend =3D (0l - (immhi >> 18)) << 21;=0A=
-	  int64_t imm =3D sign_extend | (immhi << 2) | immlo;=0A=
-	  uintptr_t jmpto =3D *(uintptr_t *) ((uint8_t *) imp + imm);=0A=
-	  return (void *) jmpto;=0A=
+	  uint32_t immhi =3D (opcode1 >> 5) & 0x7ffff;=0A=
+	  uint32_t immlo =3D (opcode1 >> 29) & 0x3;=0A=
+	  uint32_t imm12 =3D ((opcode2 >> 10) & 0xfff) * 8; // 64 bit scale=0A=
+	  int64_t sign_extend =3D (0l - ((int64_t) immhi >> 32)) << 33; // sign e=
xtend from 33 to 64 bits=0A=
+	  int64_t imm =3D sign_extend | (((immhi << 2) | immlo) << 12);=0A=
+	  int64_t base =3D (int64_t) imp & ~0xfff;=0A=
+	  uintptr_t* jmpto =3D (uintptr_t *) (base + imm + imm12);=0A=
+	  return (void *) *jmpto;=0A=
 	}=0A=
 #else=0A=
       if (*((uint16_t *) imp) =3D=3D 0x25ff)=0A=
diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimpor=
t=0A=
index 0c1bcafbf..33d8b08fb 100755=0A=
--- a/winsup/cygwin/scripts/mkimport=0A=
+++ b/winsup/cygwin/scripts/mkimport=0A=
@@ -73,8 +73,11 @@ EOF=0A=
 	.extern	$imp_sym=0A=
 	.global	$glob_sym=0A=
 $glob_sym:=0A=
-	adr x16, $imp_sym=0A=
-	ldr x16, [x16]=0A=
+	# NOTE: Using instructions that are used by MSVC and LLVM. Binutils are=
=0A=
+	# using adrp/add/ldr-0-offset though. Please, keep it in sync with=0A=
+  # import_address implementation in winsup/cygwin/mm/malloc_wrapper.cc.=
=0A=
+	adrp x16, $imp_sym=0A=
+	ldr x16, [x16, #:lo12:$imp_sym]=0A=
 	br x16=0A=
 EOF=0A=
 	} else {=0A=
-- =0A=
2.50.1.vfs.0.0=0A=

--_002_DB9PR83MB092391AD95379EB112A8EC339259ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v4-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch"
Content-Description:
 v4-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch
Content-Disposition: attachment;
	filename="v4-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch";
	size=3457; creation-date="Fri, 25 Jul 2025 11:06:43 GMT";
	modification-date="Fri, 25 Jul 2025 11:06:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmZWQ5MDQyMWE1YzljODUzOWE3YWFkOTI1ODg3MzBmMGE4NGZkMzA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAxOSBKdWwgMjAyNSAxOToxNzoxMiAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjRdIEN5Z3dpbjogbWtpbXBvcnQ6IGltcGxlbWVudCBBQXJj
aDY0ICsvLTRHQiByZWxvY2F0aW9ucwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRl
eHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoK
QmFzZWQgb24gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMv
MjAyNXEzLzAxNDE1NC5odG1sCnN1Z2dlc3Rpb24sIHRoaXMgcGF0Y2ggaW1wbGVtZW50cyArLy00
R0IgcmVsb2NhdGlvbnMgZm9yIEFBcmNoNjQgaW4gdGhlIG1raW1wb3J0CnNjcmlwdCBieSB1c2lu
ZyBhZHJwIGFuZCBsZHIgaW5zdHJ1Y3Rpb25zLiBUaGlzIGNoYW5nZSByZXF1aXJlZCB1cGRhdGUK
aW4gd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyB3aGVyZSB0aG9zZSBpbnN0cnVj
dGlvbnMgYXJlCmRlY29kZWQgdG8gZ2V0IHRhcmdldCBpbXBvcnQgYWRkcmVzcy4KClNpZ25lZC1v
ZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIHdp
bnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MgfCAyOSArKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLQogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0ICAgICB8ICA3ICsrKysr
LS0KIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyBiL3dpbnN1cC9j
eWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKaW5kZXggODYzZDMwODljLi5kYjZmZmI1YTAgMTAw
NjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKKysrIGIvd2luc3Vw
L2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYwpAQCAtNTEsMTYgKzUxLDI3IEBAIGltcG9ydF9h
ZGRyZXNzICh2b2lkICppbXApCiAgIF9fdHJ5CiAgICAgewogI2lmIGRlZmluZWQoX19hYXJjaDY0
X18pCi0gICAgICAvLyBJZiBvcGNvZGUgaXMgYW4gYWRyIGluc3RydWN0aW9uLgotICAgICAgdWlu
dDMyX3Qgb3Bjb2RlID0gKih1aW50MzJfdCAqKSBpbXA7Ci0gICAgICBpZiAoKG9wY29kZSAmIDB4
OWYwMDAwMDApID09IDB4MTAwMDAwMDApCisgICAgICAvKiBJZiBvcGNvZGUxIGlzIGFuIGFkcnAg
YW5kIG9wY29kZTIgaXMgbGRyIGluc3RydWN0aW9uOgorICAgICAgICAgICAtIGh0dHBzOi8vd3d3
LnNjcy5zdGFuZm9yZC5lZHUvfnp5ZWRpZGlhL2FybTY0L2FkcnAuaHRtbAorICAgICAgICAgICAt
IGh0dHBzOi8vd3d3LnNjcy5zdGFuZm9yZC5lZHUvfnp5ZWRpZGlhL2FybTY0L2xkcl9pbW1fZ2Vu
Lmh0bWwKKyAgICAgICAgIE5PVEU6IFRoaXMgaW1wbGVtZW50YXRpb24gYXNzdW1lcyB0aGF0IHRo
ZSByZWxvY2F0aW9uIHRhYmxlIGlzIG1hZGUgb2YKKyAgICAgICAgIHRob3NlIHNwZWNpZmljIEFB
cmNoNjQgaW5zdHJ1Y3Rpb25zIGFzIGdlbmVyYXRlZCBieSB0aGUKKyAgICAgICAgIHdpbnN1cC9j
eWd3aW4vc2NyaXB0cy9ta2ltcG9ydCBzY3JpcHQuIFBsZWFzZSwga2VlcCBpdCBpbiBzeW5jLiAq
LworICAgICAgdWludDMyX3Qgb3Bjb2RlMSA9ICooKHVpbnQzMl90ICopIGltcCk7CisgICAgICB1
aW50MzJfdCBvcGNvZGUyID0gKigoKHVpbnQzMl90ICopIGltcCkgKyAxKTsKKyAgICAgIHVpbnQz
Ml90IG9wY29kZTMgPSAqKCgodWludDMyX3QgKikgaW1wKSArIDIpOworICAgICAgaWYgKCgob3Bj
b2RlMSAmIDB4OWYwMDAwMWYpID09IDB4OTAwMDAwMTApICYmCisJICAoKG9wY29kZTIgJiAweGZm
YzAwM2ZmKSA9PSAweGY5NDAwMjEwKSAmJgorCSAgKG9wY29kZTMgPT0gMHhkNjFmMDIwMCkpCiAJ
ewotCSAgdWludDMyX3QgaW1taGkgPSAob3Bjb2RlID4+IDUpICYgMHg3ZmZmZjsKLQkgIHVpbnQz
Ml90IGltbWxvID0gKG9wY29kZSA+PiAyOSkgJiAweDM7Ci0JICBpbnQ2NF90IHNpZ25fZXh0ZW5k
ID0gKDBsIC0gKGltbWhpID4+IDE4KSkgPDwgMjE7Ci0JICBpbnQ2NF90IGltbSA9IHNpZ25fZXh0
ZW5kIHwgKGltbWhpIDw8IDIpIHwgaW1tbG87Ci0JICB1aW50cHRyX3Qgam1wdG8gPSAqKHVpbnRw
dHJfdCAqKSAoKHVpbnQ4X3QgKikgaW1wICsgaW1tKTsKLQkgIHJldHVybiAodm9pZCAqKSBqbXB0
bzsKKwkgIHVpbnQzMl90IGltbWhpID0gKG9wY29kZTEgPj4gNSkgJiAweDdmZmZmOworCSAgdWlu
dDMyX3QgaW1tbG8gPSAob3Bjb2RlMSA+PiAyOSkgJiAweDM7CisJICB1aW50MzJfdCBpbW0xMiA9
ICgob3Bjb2RlMiA+PiAxMCkgJiAweGZmZikgKiA4OyAvLyA2NCBiaXQgc2NhbGUKKwkgIGludDY0
X3Qgc2lnbl9leHRlbmQgPSAoMGwgLSAoKGludDY0X3QpIGltbWhpID4+IDMyKSkgPDwgMzM7IC8v
IHNpZ24gZXh0ZW5kIGZyb20gMzMgdG8gNjQgYml0cworCSAgaW50NjRfdCBpbW0gPSBzaWduX2V4
dGVuZCB8ICgoKGltbWhpIDw8IDIpIHwgaW1tbG8pIDw8IDEyKTsKKwkgIGludDY0X3QgYmFzZSA9
IChpbnQ2NF90KSBpbXAgJiB+MHhmZmY7CisJICB1aW50cHRyX3QqIGptcHRvID0gKHVpbnRwdHJf
dCAqKSAoYmFzZSArIGltbSArIGltbTEyKTsKKwkgIHJldHVybiAodm9pZCAqKSAqam1wdG87CiAJ
fQogI2Vsc2UKICAgICAgIGlmICgqKCh1aW50MTZfdCAqKSBpbXApID09IDB4MjVmZikKZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9ta2ltcG9ydCBiL3dpbnN1cC9jeWd3aW4vc2Ny
aXB0cy9ta2ltcG9ydAppbmRleCAwYzFiY2FmYmYuLjMzZDhiMDhmYiAxMDA3NTUKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CisrKyBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9t
a2ltcG9ydApAQCAtNzMsOCArNzMsMTEgQEAgRU9GCiAJLmV4dGVybgkkaW1wX3N5bQogCS5nbG9i
YWwJJGdsb2Jfc3ltCiAkZ2xvYl9zeW06Ci0JYWRyIHgxNiwgJGltcF9zeW0KLQlsZHIgeDE2LCBb
eDE2XQorCSMgTk9URTogVXNpbmcgaW5zdHJ1Y3Rpb25zIHRoYXQgYXJlIHVzZWQgYnkgTVNWQyBh
bmQgTExWTS4gQmludXRpbHMgYXJlCisJIyB1c2luZyBhZHJwL2FkZC9sZHItMC1vZmZzZXQgdGhv
dWdoLiBQbGVhc2UsIGtlZXAgaXQgaW4gc3luYyB3aXRoCisgICMgaW1wb3J0X2FkZHJlc3MgaW1w
bGVtZW50YXRpb24gaW4gd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYy4KKwlhZHJw
IHgxNiwgJGltcF9zeW0KKwlsZHIgeDE2LCBbeDE2LCAjOmxvMTI6JGltcF9zeW1dCiAJYnIgeDE2
CiBFT0YKIAl9IGVsc2UgewotLSAKMi41MC4xLnZmcy4wLjAKCg==

--_002_DB9PR83MB092391AD95379EB112A8EC339259ADB9PR83MB0923EURP_--

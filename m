Return-Path: <SRS0=RHLI=2C=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20724.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::724])
	by sourceware.org (Postfix) with ESMTPS id 5D9C53858D29
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 07:56:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5D9C53858D29
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5D9C53858D29
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::724
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753084566; cv=pass;
	b=koxc1vx8WcOtC6+hyTLZ/y58sve9Enwqolxf4jGgkO4MKrEw7p9dgF2Gyj0aY7GqZg9jZOGaLd+sywqo3sRrfA8s680GTeDpTLAKZY78+zda2yDNTdUr0hSaqI5DEdXN7QMlXJV7vOOU7eJ6SXIZM7b6Yu5htQPaBE0miraujJc=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753084566; c=relaxed/simple;
	bh=1rS0oHY11yDs22O384TkOaGuUrKILMH+azwZpkdGzZ0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=HJgkhEy/5yT3D2iinVIPVCUKEuKIiuFYzOuGTPhrwn5xBGlB0Ub77e1Qap/w125D974OAjeWCz2v6ENEqM3Q0iRHWV2E8aSrICeVzcr8iJltsAzu3W7Bo5hVZNjjaZFFjoQDqIBuHDBwYSG9C/FAfwV9a1rymwODyd6dNiMrEpE=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5D9C53858D29
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=UXHRWvDe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxRIe8x0vvObiVQGlMRCIFNYMganjsS3U5B/xCI+yQ8silOCp6ZPJ/po9vxC/Yqqxl8Qz/d1OTjQ6gnKJ9QW4vAIcMDQ8XGnwsysEFwRgXWt0+xPwgel74gW9SKxuXsZd5pZvLehaYkfAf0P0cHtNrTEXoH66dhtvKw+1y5C3rnSZxQweZoXH2GMKKtYYiNJflpXiyMi68OFBcbs5zgnmq+4Q/NMq8wvt6OZZRcr9uqMHLKGubR7nQEcdexZilel68d4VxZPBSRFYLVOIqjVKTEeXBwcD836ugT/Ya4bY3bnQfiVDeMCmnY0ZpgdRRmI+3PNEbl5J4zujJ4kigdYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx2k7jXNY9ZC8mPcd/58be+n4sBGET6FEe0XKiem2w8=;
 b=lAH1S5EWCAUtJVxBVf6MQm9GCcz6nk8AlwUBoYjkKeN3K8Xs0NVrI6M8qiiT007pZPf0TmKZNhmCYx16AlqfMdripEKz5wV3/8b0xZk1Bar0v5pX+sbcm9Q+yVWIMzX+MjNqPhNkACK7W4vE3Ajj1+mj/doSMoU2iLrUoEVhtJTjPRQivvo1tLPd4beuZL4/tMX11anxATvKgJ3Xs1ErmmpZHbgUSNhTMHjsP5XjZpNQf/mLgQ42lLCC+TtucZ5zN1qo6dNGtevkkXgqQ7eS4Tk97uorc+l7j5dQD0zgLIV4CrrJQFCODhQLzMGZBfmNBkLLJOhAwfMZJX7W/v3Y1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx2k7jXNY9ZC8mPcd/58be+n4sBGET6FEe0XKiem2w8=;
 b=UXHRWvDeCQ/lYps5AWQMei6WpIEqCy/WhnGfsFpRhwPjl5skWEU0Teoe4LLmfFRuUU5SALUa/ihDzSOiXMmTWC/V8nb8Am4+ej6bkksG9UWGIX+M6iQJw+uTRPwC3NgfCzsF1+1SFwNt0dKEypVyjEOrQ+VhZs2nZbJhT6jIAfI=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU4PR83MB0771.EURPRD83.prod.outlook.com (2603:10a6:10:592::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.17; Mon, 21 Jul
 2025 07:56:02 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%3]) with mapi id 15.20.8964.019; Mon, 21 Jul 2025
 07:56:02 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Topic: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Index: AQHb+hSK6v+bOS7EmUuldlpBv2x9Fg==
Date: Mon, 21 Jul 2025 07:56:02 +0000
Message-ID:
 <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-21T07:56:01.043Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU4PR83MB0771:EE_
x-ms-office365-filtering-correlation-id: a73a5e87-d475-419f-b927-08ddc82c09ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?Rf00k7qy8uxcUiRPYVX/4wxZBpyTR6dB7tRYPRrUms4flciHHXXa/7q6Vn?=
 =?iso-8859-2?Q?uOT5TEklD8WKpo2ALtL3d+i5DXHvcNdZ9FlQgjYh6Swz9JE6VP1ThKCIly?=
 =?iso-8859-2?Q?dVpAx+qMxK+3AoR1Alc+9Xt6siddLbQVI3GJnw74l/4QjBeAZ1CuTZEsBc?=
 =?iso-8859-2?Q?SVbcVfDFQpF6daz5GXXJb/PTr1Ciw6VDk56yg2FEv+LarO94KV0kZ9gcdn?=
 =?iso-8859-2?Q?4a62sHhDYsY6AhenWIJvO/DZhVaErVkwLHTdEbvfejQ5qRLBCVsLH68vvQ?=
 =?iso-8859-2?Q?ucEOxgPFVmpZ/FDUKGyLFe7p6oju7XToY8LLzGUZ8IrgUs9vqFH+PVIS+S?=
 =?iso-8859-2?Q?uFWs207uNrwqYMf56rBeVPNO5TSfNix4EdYh01ViFdcqXpbbUaVhW6a1PJ?=
 =?iso-8859-2?Q?n9OBapAJvY+83OpX/4EcdsRa5erUC7FpTBSnplOtNQJkNDKwA2y51l/Vwk?=
 =?iso-8859-2?Q?KPWnndBJrrYH0d6eZiBqqnTxFS8pAetmBe5ybUJ6kZrCjVIy0ITJcChGlm?=
 =?iso-8859-2?Q?sME8TK/cxHLNPBm4CsdLb4aZ3W/KBFJ1NYfgLPE/o+Ea7dyILb+T/2kPU+?=
 =?iso-8859-2?Q?CBYhC7AN3z/vzz57ejd/FuEm2MogJv4sZVdZa6lc3D9QfOkPS3rg67IdmY?=
 =?iso-8859-2?Q?UZ0LyqdUhFy5Xwgo50HnNR+lXx8l2AJc2sm2BK7XX0PIuJfOOZveAoggXD?=
 =?iso-8859-2?Q?sONAEviZJ57LP338zCkXmGCu/tfoC+F3RBh2rozYoYBB0kXgxcH5Ua/LG6?=
 =?iso-8859-2?Q?+0LNs1C/NHHZtxVo/KWjDxvQdxWk+mqAnP4ZRBg79nSf/4alJGg44ti+aq?=
 =?iso-8859-2?Q?+TPuXswREsn3yGViiWtuRwcvJ9xllpBMSUVElI26BzFPFLkjmCpxszsbMf?=
 =?iso-8859-2?Q?bsupEoKMGNg5dSBXJbMI0Y2ALrxJVbPju9gcSb7DMFvCMVc4DpJgn9UNnZ?=
 =?iso-8859-2?Q?sbbvnVe4pcXEjmlHoRSjXJCKhdNYIvk84LYJXVg7ZCQJPtZxt1lbgyokdh?=
 =?iso-8859-2?Q?C6W0Ky+e2JmgVBLTW/A5HlwjG/yRpsrFupw6C4NbHnPJo9H5zR+bZYEleL?=
 =?iso-8859-2?Q?d98kk9Dveg7AVwk35g4bef+woJNUZAowdlpTGs9AvZb/G2L8ZfvHNN6dUa?=
 =?iso-8859-2?Q?xx3bxisg1ig6hfWLNgJqWTtGxVQBz1tYPdTkdywcg9v+UmpU8sEh7p1MWz?=
 =?iso-8859-2?Q?PAp9MXsn0GSl7BXnTQsYDo3MgYrLcRMF9JiAatzBJWMCG0N2EpTlLObAzE?=
 =?iso-8859-2?Q?PI3HdvW/m6ilcV2/C7TklSh4B9m6pTqn/tONtmmdERUx25QHpBN2kLQ4yM?=
 =?iso-8859-2?Q?sqb4KvlRDnItyGYqWnAZoBCfY8mmi2kFCifb+5hfJTL+ZAvfEVuVdMz7L3?=
 =?iso-8859-2?Q?EWf3F1qf3az7R3F9KxkHBtxxzDAM3Wfuh2YtdgNK+kTrBwXRGagRKX5f6Z?=
 =?iso-8859-2?Q?olNUdhWyc/RlezkYGR3PrtR6geErWPUG8NKZ1zzG+njg84hWgGEhelI3ui?=
 =?iso-8859-2?Q?yH97Wec3OEsCK5AbdzJ91fczd8Hu+3TyNe2IgJHf1ewNUNUtxC9UeGmTpP?=
 =?iso-8859-2?Q?QT3W5h0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?mrTw2eZUl1YC48HDz1AtBDu17jQ0/VTE0nNvQK2VFQ0WM4gLGmxTjc6/hA?=
 =?iso-8859-2?Q?xw18OMuBK6KDn6hOZHI0X1G9+wQ+oZE/K/izfgLs05AzNZcZUbG/L2Icwb?=
 =?iso-8859-2?Q?Rri/NWCt4HZqGXNP93h3V253BK9FbATP/RUcvHlbIez/humsIKh//ra3hv?=
 =?iso-8859-2?Q?JCjj/D2ypZB4ysi0EJRCpjCg54Lj755oA+4zg+Gc/zwx/igzIbCdVtxhXG?=
 =?iso-8859-2?Q?xM6tfYTXYoMM1WRO39W0FxjwWZcaYImahT74tJm2z0iQOoRCIXlv8PFSbD?=
 =?iso-8859-2?Q?AVuej7sVBAB+uVVnpopeiwW2adRHJ4YEmDQpbyoStC7Ny+Z3FgDpjUhY1Y?=
 =?iso-8859-2?Q?KZSytGR1Jq6bAPCDBNGPQXYc1TDI6dcOJNq3qwhLFgHvYalI4Q6Htfj6Qx?=
 =?iso-8859-2?Q?zkG8ntK92f7C2dvTZlGongvBYvt4kRG/GrXywqQuvuQmUZX9WEuYrR+SXI?=
 =?iso-8859-2?Q?8HRpApwcRZJLNJQEDkRyWLM9TmIWk+iBeZvs/jxO5bU3fkZnab8jRYvumR?=
 =?iso-8859-2?Q?KmfWQ92HB5D9uwfvHMOd70kMvNDk0f6g1YhmxU9yxf6cudvZpubnDEoHy6?=
 =?iso-8859-2?Q?Yjg2LwlWDGOEvDiT2xcIFIRnJzoz3qmoskXP8H01lp+m26XgYFDm7H+CWN?=
 =?iso-8859-2?Q?uIOz4jol8o1mlyBuePTt7Z8R34EzXHNJOs4oC3emlOCMoV43gDMXR0whUS?=
 =?iso-8859-2?Q?qbrxiAH9OFJXE40A8Qw7jrGn69pZiioDXtuOePYgI7xjoZvNO3fGcTOkDg?=
 =?iso-8859-2?Q?0rHNrBXXVDx/F0VxNq2ZKy0Fn7IuHTiw3N9HZFZgaZ7a4zc5zvSt0z/NRM?=
 =?iso-8859-2?Q?oAhGOF4kXTBwR4E4OCR9WyMf4EPBCqCM61Hj+8T/x6hPfPPOtPqxvZNyrh?=
 =?iso-8859-2?Q?rKu9yLWTgdDr0Q2sUCKS4q/fJSIXcPdV+PC2rx/c+oAnoC+q1H7ZDQsmR+?=
 =?iso-8859-2?Q?741Bzi8e/FTGfaJ+q0B0frMkBMu1nomDJoa/SDha/JVu9I7LDmXr6Ozqqq?=
 =?iso-8859-2?Q?ajAs7+1suSdL5+vKbx293XzAGViMDd1wV65iXiXQ/b26MxR9lm9rcVMy/T?=
 =?iso-8859-2?Q?kIxJKOuw/VK5AMUonXnXzkpTdpnq2W9hB8iQjdIwdMI5oG/4U1HShitdiH?=
 =?iso-8859-2?Q?VsuNfdClV0xg1Qzysxh8cVs8Eg0CCZvcZrntIe1lNgNQdU1A8tjY02Dy5v?=
 =?iso-8859-2?Q?mXPHU2+m0sPDNBmOe8r4yBDNX94wQEG9I9ZyqVKowcm52AW9YzwaRce1ZW?=
 =?iso-8859-2?Q?oFtjv4vIAorUZynBzgWB6/fYS9b+pUb58GsWKk8hK3HKVuWWFeVBXU3/bi?=
 =?iso-8859-2?Q?R54q7TJ1u6Zov/SFSbI7kMQz5yuDDCn5Ycsq5YNr/iEbL4PXlhPuTEmEVr?=
 =?iso-8859-2?Q?mWLTzF47jmzuwlYrNee02jzJnroptxcXuwDmTaYauFHTuh0r9Qjm3FU0QB?=
 =?iso-8859-2?Q?nb1LG/sGD42s2UDF67Gav3sE/aoIR0I319N8Np7Cayhw9sE2VSkE/Q7GWU?=
 =?iso-8859-2?Q?pVlE5UGuW24GLWBtu+uwt8MPRfp51RLTjWuNxtfh1y+WipysVf40BbwtLA?=
 =?iso-8859-2?Q?9V2vwgBugF83uDVDwd61PlsiiDfX?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923E3D187978CF43940B188925DADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73a5e87-d475-419f-b927-08ddc82c09ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 07:56:02.4705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWXgCQTgkrax35avrwYy9/IbIhU6t+OST+rqkSSbvKzW+HzsoO9aVrO2v9tpR+mEW1ZXnze7ocUM7AGtz8+pbouDfJCnz9yKP15v/GwFOgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0771
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,PROLO_LEO1,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923E3D187978CF43940B188925DADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Sending a patch with AArch64 +/-4GB relocations in mkimport as promised at=
=A0https://sourceware.org/pipermail/cygwin-patches/2025q3/014155.html=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 3ec4e2136942ade5856310ee1f4d9d89359c3c79 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 19 Jul 2025 19:17:12 +0200=0A=
Subject: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB relocations=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Based on https://sourceware.org/pipermail/cygwin-patches/2025q3/014154.html=
=0A=
suggestion, this patch implements +/-4GB relocations for AArch64 in the mki=
mport=0A=
script by using adrp and ldr instructions. This change required update=0A=
in winsup\cygwin\mm\malloc_wrapper.cc where those instructions are=0A=
decoded to get target import address.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/mm/malloc_wrapper.cc | 23 ++++++++++++++---------=0A=
 winsup/cygwin/scripts/mkimport     |  4 ++--=0A=
 2 files changed, 16 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/malloc_w=
rapper.cc=0A=
index 863d3089c..5ca4da587 100644=0A=
--- a/winsup/cygwin/mm/malloc_wrapper.cc=0A=
+++ b/winsup/cygwin/mm/malloc_wrapper.cc=0A=
@@ -51,16 +51,21 @@ import_address (void *imp)=0A=
   __try=0A=
     {=0A=
 #if defined(__aarch64__)=0A=
-      // If opcode is an adr instruction.=0A=
-      uint32_t opcode =3D *(uint32_t *) imp;=0A=
-      if ((opcode & 0x9f000000) =3D=3D 0x10000000)=0A=
+      // If opcode1 is an adrp and opcode2 is ldr instruction:=0A=
+      //   - https://www.scs.stanford.edu/~zyedidia/arm64/adrp.html=0A=
+      //   - https://www.scs.stanford.edu/~zyedidia/arm64/ldr_imm_gen.html=
=0A=
+      uint32_t opcode1 =3D *((uint32_t *) imp);=0A=
+      uint32_t opcode2 =3D *(((uint32_t *) imp) + 1);=0A=
+      if (((opcode1 & 0x9f000000) =3D=3D 0x90000000) && ((opcode2 & 0xbfc0=
0000) =3D=3D 0xb9400000))=0A=
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
index 0c1bcafbf..80594296a 100755=0A=
--- a/winsup/cygwin/scripts/mkimport=0A=
+++ b/winsup/cygwin/scripts/mkimport=0A=
@@ -73,8 +73,8 @@ EOF=0A=
 	.extern	$imp_sym=0A=
 	.global	$glob_sym=0A=
 $glob_sym:=0A=
-	adr x16, $imp_sym=0A=
-	ldr x16, [x16]=0A=
+	adrp x16, $imp_sym=0A=
+	ldr x16, [x16, #:lo12:$imp_sym]=0A=
 	br x16=0A=
 EOF=0A=
 	} else {=0A=
-- =0A=
2.50.1.vfs.0.0=0A=
=0A=

--_002_DB9PR83MB0923E3D187978CF43940B188925DADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch"
Content-Description:
 0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch";
	size=2915; creation-date="Mon, 21 Jul 2025 07:54:22 GMT";
	modification-date="Mon, 21 Jul 2025 07:54:26 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzZWM0ZTIxMzY5NDJhZGU1ODU2MzEwZWUxZjRkOWQ4OTM1OWMzYzc5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAxOSBKdWwgMjAyNSAxOToxNzoxMiAr
MDIwMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjogbWtpbXBvcnQ6IGltcGxlbWVudCBBQXJjaDY0
ICsvLTRHQiByZWxvY2F0aW9ucwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQv
cGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKQmFz
ZWQgb24gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMvMjAy
NXEzLzAxNDE1NC5odG1sCnN1Z2dlc3Rpb24sIHRoaXMgcGF0Y2ggaW1wbGVtZW50cyArLy00R0Ig
cmVsb2NhdGlvbnMgZm9yIEFBcmNoNjQgaW4gdGhlIG1raW1wb3J0CnNjcmlwdCBieSB1c2luZyBh
ZHJwIGFuZCBsZHIgaW5zdHJ1Y3Rpb25zLiBUaGlzIGNoYW5nZSByZXF1aXJlZCB1cGRhdGUKaW4g
d2luc3VwXGN5Z3dpblxtbVxtYWxsb2Nfd3JhcHBlci5jYyB3aGVyZSB0aG9zZSBpbnN0cnVjdGlv
bnMgYXJlCmRlY29kZWQgdG8gZ2V0IHRhcmdldCBpbXBvcnQgYWRkcmVzcy4KClNpZ25lZC1vZmYt
Ynk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIHdpbnN1
cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MgfCAyMyArKysrKysrKysrKysrKy0tLS0tLS0t
LQogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0ICAgICB8ICA0ICsrLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyBiL3dpbnN1cC9jeWd3aW4vbW0vbWFs
bG9jX3dyYXBwZXIuY2MKaW5kZXggODYzZDMwODljLi41Y2E0ZGE1ODcgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9tbS9t
YWxsb2Nfd3JhcHBlci5jYwpAQCAtNTEsMTYgKzUxLDIxIEBAIGltcG9ydF9hZGRyZXNzICh2b2lk
ICppbXApCiAgIF9fdHJ5CiAgICAgewogI2lmIGRlZmluZWQoX19hYXJjaDY0X18pCi0gICAgICAv
LyBJZiBvcGNvZGUgaXMgYW4gYWRyIGluc3RydWN0aW9uLgotICAgICAgdWludDMyX3Qgb3Bjb2Rl
ID0gKih1aW50MzJfdCAqKSBpbXA7Ci0gICAgICBpZiAoKG9wY29kZSAmIDB4OWYwMDAwMDApID09
IDB4MTAwMDAwMDApCisgICAgICAvLyBJZiBvcGNvZGUxIGlzIGFuIGFkcnAgYW5kIG9wY29kZTIg
aXMgbGRyIGluc3RydWN0aW9uOgorICAgICAgLy8gICAtIGh0dHBzOi8vd3d3LnNjcy5zdGFuZm9y
ZC5lZHUvfnp5ZWRpZGlhL2FybTY0L2FkcnAuaHRtbAorICAgICAgLy8gICAtIGh0dHBzOi8vd3d3
LnNjcy5zdGFuZm9yZC5lZHUvfnp5ZWRpZGlhL2FybTY0L2xkcl9pbW1fZ2VuLmh0bWwKKyAgICAg
IHVpbnQzMl90IG9wY29kZTEgPSAqKCh1aW50MzJfdCAqKSBpbXApOworICAgICAgdWludDMyX3Qg
b3Bjb2RlMiA9ICooKCh1aW50MzJfdCAqKSBpbXApICsgMSk7CisgICAgICBpZiAoKChvcGNvZGUx
ICYgMHg5ZjAwMDAwMCkgPT0gMHg5MDAwMDAwMCkgJiYgKChvcGNvZGUyICYgMHhiZmMwMDAwMCkg
PT0gMHhiOTQwMDAwMCkpCiAJewotCSAgdWludDMyX3QgaW1taGkgPSAob3Bjb2RlID4+IDUpICYg
MHg3ZmZmZjsKLQkgIHVpbnQzMl90IGltbWxvID0gKG9wY29kZSA+PiAyOSkgJiAweDM7Ci0JICBp
bnQ2NF90IHNpZ25fZXh0ZW5kID0gKDBsIC0gKGltbWhpID4+IDE4KSkgPDwgMjE7Ci0JICBpbnQ2
NF90IGltbSA9IHNpZ25fZXh0ZW5kIHwgKGltbWhpIDw8IDIpIHwgaW1tbG87Ci0JICB1aW50cHRy
X3Qgam1wdG8gPSAqKHVpbnRwdHJfdCAqKSAoKHVpbnQ4X3QgKikgaW1wICsgaW1tKTsKLQkgIHJl
dHVybiAodm9pZCAqKSBqbXB0bzsKKwkgIHVpbnQzMl90IGltbWhpID0gKG9wY29kZTEgPj4gNSkg
JiAweDdmZmZmOworCSAgdWludDMyX3QgaW1tbG8gPSAob3Bjb2RlMSA+PiAyOSkgJiAweDM7CisJ
ICB1aW50MzJfdCBpbW0xMiA9ICgob3Bjb2RlMiA+PiAxMCkgJiAweGZmZikgKiA4OyAvLyA2NCBi
aXQgc2NhbGUKKwkgIGludDY0X3Qgc2lnbl9leHRlbmQgPSAoMGwgLSAoKGludDY0X3QpIGltbWhp
ID4+IDMyKSkgPDwgMzM7IC8vIHNpZ24gZXh0ZW5kIGZyb20gMzMgdG8gNjQgYml0cworCSAgaW50
NjRfdCBpbW0gPSBzaWduX2V4dGVuZCB8ICgoKGltbWhpIDw8IDIpIHwgaW1tbG8pIDw8IDEyKTsK
KwkgIGludDY0X3QgYmFzZSA9IChpbnQ2NF90KSBpbXAgJiB+MHhmZmY7CisJICB1aW50cHRyX3Qq
IGptcHRvID0gKHVpbnRwdHJfdCAqKSAoYmFzZSArIGltbSArIGltbTEyKTsKKwkgIHJldHVybiAo
dm9pZCAqKSAqam1wdG87CiAJfQogI2Vsc2UKICAgICAgIGlmICgqKCh1aW50MTZfdCAqKSBpbXAp
ID09IDB4MjVmZikKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9ta2ltcG9ydCBi
L3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9ta2ltcG9ydAppbmRleCAwYzFiY2FmYmYuLjgwNTk0Mjk2
YSAxMDA3NTUKLS0tIGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CisrKyBiL3dpbnN1
cC9jeWd3aW4vc2NyaXB0cy9ta2ltcG9ydApAQCAtNzMsOCArNzMsOCBAQCBFT0YKIAkuZXh0ZXJu
CSRpbXBfc3ltCiAJLmdsb2JhbAkkZ2xvYl9zeW0KICRnbG9iX3N5bToKLQlhZHIgeDE2LCAkaW1w
X3N5bQotCWxkciB4MTYsIFt4MTZdCisJYWRycCB4MTYsICRpbXBfc3ltCisJbGRyIHgxNiwgW3gx
NiwgIzpsbzEyOiRpbXBfc3ltXQogCWJyIHgxNgogRU9GCiAJfSBlbHNlIHsKLS0gCjIuNTAuMS52
ZnMuMC4wCgo=

--_002_DB9PR83MB0923E3D187978CF43940B188925DADB9PR83MB0923EURP_--

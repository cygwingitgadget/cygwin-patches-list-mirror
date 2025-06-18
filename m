Return-Path: <SRS0=pByE=ZB=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20729.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::729])
	by sourceware.org (Postfix) with ESMTPS id C5FBA38697C5
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 16:08:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C5FBA38697C5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C5FBA38697C5
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::729
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750262884; cv=pass;
	b=dmvOUtUp0isfhNcrQTaJfJRHlqWMDxw5zeFoS+hhnqnIkmQHI/CsBSePp0QSpy1vA4fiVbJ1mXQhKCGPzi/ltcIg+fnT5YNVAGpnpjYcKbTMVYUlwOZ/Fx73w5yB9rrog/IbI1NKKLGTPYFvpfxFMmZ7Vc0/Qialrep98eNfiLE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750262884; c=relaxed/simple;
	bh=Aj5vsLIYgzb1AgWJFOkIDc7AD+91UiFVTG386hxUU30=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=RPbJSpppSvLEfSmWIlw0fcZtW4Wq469VjWKR/hwYiXj42A8WZQ69vULHWeoJI3gpckK4GwF91Zw1aU58hRYlr6FlwsCy/7Wq3egWB3n23mQ/ylz3n6XYzWEKJKIF+Ywmk/M22d139E0zIqMcn09vbwoo2zFa1YLln8aT7soJp04=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C5FBA38697C5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=IyBblcRF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFrhFtQR55npYu47DR56+bsS2LVsVo9MA+tsSLTsQKBIWZRUVl0tqrOzTQCWbh6jV+PdQBzbm1RQflgofqciVjeLH7scJ704PSB7qgaKl+aFj8uAOkIjSP+bkvRUJ5hHZjukOcpUaVWr40mLLRw2B1XGeidAhui0bF6SzVAFiXDorR7Ag5zl1Jh1qZzO3tsrDyd6/m5ZjQ/3frHHXkBkBs50/+XCvaUUL1iVRTUbZb9ufII5hDXOmDkY6E5z8VVjpFX50qVwExSnV6yhM/oRaiJxKDoPrXfwSMZ4SBnAcLD0J7PYvX5dhhgwIdhwuWdJfnlL7hfr/8G2K6W50XNj/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKuvFnjiDLG96nuFX2iPGQk1PkvbatN8+qP8S3fmhFw=;
 b=JvAciVya4nXmFogWDdlNhF2hlAamFIxVLeqE5+r6Bs+XXp9BHfNL+4qpFgj+uFeIpY+h1H+oUpVJfLLzO7MaNfpJusH2BRjces40z7hmcootxKgR0juLYeF/+8Ri/vWvx9FqeAmTHMBzDNz9nqnpvbV/IwZ3wSz5KfhkS7RmQ3vCLG0tFD+mXufkqO61IR8BU538KuMK3wqOTQXMLrksMWiQpCFI1W1X+UrUgUVvUQstVocImq8C8j3oPoUT1gmZIajx+1xUDS4ZKTFo4ppnfpMrZTub1V7g81fRBM6Y5v1ZdcjDmZN0uZlf5zda9/Dsd12C46V1fJpsI4d9KKq+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKuvFnjiDLG96nuFX2iPGQk1PkvbatN8+qP8S3fmhFw=;
 b=IyBblcRF4/TYdykQxtgbAkUiKXfhMAvUzPo4NSItVBJEFJM3p/djnmzBbZbCwGzScklwZy9cdqAJjO9wepWnAWjPsNYry+nkEAEMB6O4UuGmY+FFp8Lf+a9L4tjJWSk6pnDlNYbI4p6sAfp9OqdzPyGrgvB473Pxvvt0CvavtG0=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU5PR83MB0595.EURPRD83.prod.outlook.com (2603:10a6:10:522::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.7; Wed, 18 Jun
 2025 16:07:57 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.006; Wed, 18 Jun 2025
 16:07:57 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: obtain stack pointer on AArch64
Thread-Topic: [PATCH] Cygwin: obtain stack pointer on AArch64
Thread-Index: AQHb4Gr8qHa23Pq8SESLqMgVaf3NOg==
Date: Wed, 18 Jun 2025 16:07:57 +0000
Message-ID:
 <DB9PR83MB09238701426EDE79BDAAFA2F9272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-18T16:07:56.329Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU5PR83MB0595:EE_
x-ms-office365-filtering-correlation-id: e31ec607-b6de-4371-57cd-08ddae824a60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?soZEQNXWwGcEiI0oSLn4lIlMhJHTwhkruhoyYyn3UK8ToMSn6fAszpPNHL?=
 =?iso-8859-2?Q?uQ1XllXmrvd01b1DUxRB+zcTP8/SAd1RvROf3ObPffV7eIQKdbNd91TuZC?=
 =?iso-8859-2?Q?oQI+voGCmiTsFv1ExYmcOCTNacB/O2y62Is4F/LSXpGUxQK1O6DTZ3JOOF?=
 =?iso-8859-2?Q?MECJNAVBFOrZzJQyChtCFMAdxCoFzI66Qz2adYZ2bZSM4hKdKqOCRkG57F?=
 =?iso-8859-2?Q?YuHssARk8F8ONH6AThZ9bVtOgPlycVRcls6QUybd8lGGIZtzJEsVSCX5Bm?=
 =?iso-8859-2?Q?+ZUJg+P0YOyLbtMvta1+3qDpONYTq+MSGOk7qT4DCoSdxAvQRyiGDLr0uX?=
 =?iso-8859-2?Q?ht8Yir6pr0f/ZqZJQT0/ut6rjNKEjteaAgRJqqOY6dEO5l+W/Ecu+Cpke1?=
 =?iso-8859-2?Q?KtO00bK5amWn1jljuzFREw/29PpQeaR75ys3A2VJcH3u30gp/imvHaqbkV?=
 =?iso-8859-2?Q?2HzfjXJJ/zcjwIYcClN0dF/Ih/O+RRhWaWPocmaz8HUO80IdLMVh96eTw8?=
 =?iso-8859-2?Q?LYR1lMN6l07RJVoLmNM7FR1Enpc8iKKMOynvmBsmdC35y0lNqJItt23sXf?=
 =?iso-8859-2?Q?LL52EQ3LFspCKnVsBzvbM2VcZ/SDRUTRd6zVP4J0fsWe9GCXBav0l7oymu?=
 =?iso-8859-2?Q?2g7h2T0hQorfxAK/1W6ItGs/AMkpreCodtCT2zUSLasa1bE8jI8+WrkWFj?=
 =?iso-8859-2?Q?st+dUnzgUbySE0xS+5WsjfqRHLyMyfqip8PcsaABle1RF58ePFRJzLFFEH?=
 =?iso-8859-2?Q?po2hleHD36rpKEcj6G8Ep+Ix8Tz7Vdsdate4/bZ9vuSEB3dRZ4XJ3U7qN4?=
 =?iso-8859-2?Q?ZbYoIxlgqS35arNv/ZdGzrTJpZwQKs9yzaUx5i75okH5B71JTHjQh3qGbt?=
 =?iso-8859-2?Q?fe2rRpzeArHAd7W8btb7jOjNsBBPDCtEfoXCsouDQt5DwHrkw2nMnCzedw?=
 =?iso-8859-2?Q?btdj+hmRBdLM9vtigpKYBxVYOa7/a3FT5qVrms9Mht2Y4B4/rBK163cOaE?=
 =?iso-8859-2?Q?2w60f8wyMj8TWRY3potRl0MtRBVtOhxpY7tmwaNaXW4PzSD4DC12Bt0ftF?=
 =?iso-8859-2?Q?PF2wTusjcfVCxohi/Olp6iQEpZrJKkCyP0Av+LY6nhCbldJX6Nz9J6pYNM?=
 =?iso-8859-2?Q?H68LkMZfeqD52DQFypWtl8dCFC58DJ3cxm2SXheA9c/LBnD+jBhkDRpC9k?=
 =?iso-8859-2?Q?dX95obdbddTGeUjxRvGo2KWlq09It1Z3mYtGHQdnmnKXu86E9EekdO1n9E?=
 =?iso-8859-2?Q?sGg11PoCk6Vfbin0QgaJ9j52wxf9pdr+gB/uZ0ENjPn/JO7ulaoa/3uaa6?=
 =?iso-8859-2?Q?uEgBhhTXpdZ00kUqB/7+4NkdtmzrB2CykGOkk7/0Py7bOOljUMylj1Q5ct?=
 =?iso-8859-2?Q?Z7mxTnRuPFnZw0TyJFbyAvznRN9oCx2Vjvd6OwbKHLNKN8nNcnjmwMZ8Un?=
 =?iso-8859-2?Q?H14NX90VSebnnfvl+DMHItKZkEnkVeH/A0B+UlkpWusdJ8XixYOXa1KeaX?=
 =?iso-8859-2?Q?AopdsvNzmHgcddkjap1tQ347vuCyEjqnUTniSy9YxOnKTB8reqbbQqi+hq?=
 =?iso-8859-2?Q?pR73xh8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?3nWhft1R1sUhw7ENVZaRm+VzmvxkHri49Myon75mnZcYZf+kLMdGkfqtNp?=
 =?iso-8859-2?Q?CVKz8SddrYSwtJkuwO6UzXa8AwT6ONTGxCAZWLaX96jVNNOQAa08YcEM57?=
 =?iso-8859-2?Q?sISCnSKiv5X4KuHDbzR7+HTWPL6D651S7RejuCRQNDFfCbEjoHWr6OLU3N?=
 =?iso-8859-2?Q?6VM5kpjJeAAQB1y1qTWKE10ZjZapoU09tvn+0zaHXPPfuDO+QskccQqrdR?=
 =?iso-8859-2?Q?GpjSdhRMqXFKEgtgEV7B8KfQccWJKBSPo8ac9L4crculubPflrk+2L7hno?=
 =?iso-8859-2?Q?3yTZvOirJ1bjdQ2rUt7VnewYjlrKmwJ24qtsYKgcw5Zjc+S1Y5nyh9tZ/X?=
 =?iso-8859-2?Q?S1TVHDJ056J1UwgzV5mNzOduBbqycNNhbq9lUmRvlZrZ9/bbV6acUr51/v?=
 =?iso-8859-2?Q?CLyCuCCH+2l/rYEqwZNNMdMg/47a2vq+V6OeRzGHaU3kwqCOS+mLLpoP65?=
 =?iso-8859-2?Q?PCKRxB668DXZBCpU1KTBg+h6puZ3O9JbZvkHHqvlWjQWdapGYlD9BtTAdY?=
 =?iso-8859-2?Q?Hd9z7rEj1kasLIKfB/M/1E4F0psvS64Dh9gMGE6YNNMzFN9DWky05SZB3O?=
 =?iso-8859-2?Q?FDE/ooqI9zxv49lgjgdXvZq+uoMHWG7L9WxteTe0vsU0ax3LZjXxX77mJO?=
 =?iso-8859-2?Q?xMB0Abt6iZa/30x7IcmBE0U1m6zTOYhsvvxPHoCTMUdhBr/dzyLcQ0eirI?=
 =?iso-8859-2?Q?lN9m7eegZDkaevswD3+gRHF64swvomB1dnGnsa+xWpgCk4058L+YEI7LCR?=
 =?iso-8859-2?Q?aGd5QNUkL1mi0slDlnLoCu1wbdB9l6xLvhYBjhI22DhY9MZn9fsExwXlGq?=
 =?iso-8859-2?Q?AXc/j+6Nkpc6BHyzkMZZ9rNAjLwtQ0xtdSOZf2Jgfa208MyGWVbXtao4U0?=
 =?iso-8859-2?Q?0LzIn6fLivRQcCi5txfimdoerOGr34hq4miUi+J+L5An/UBKTygBe6OD/o?=
 =?iso-8859-2?Q?Ul46OqZl0tEZfFhGBvttFlMyTljcPGCQ/UJugT/2XzUhiu++395kwRjgL2?=
 =?iso-8859-2?Q?ifR2Fq4jqApYH91T1t3yNzFN91L/leB+0VYuK2ATP3Kqdu5IgPfWB0MUn7?=
 =?iso-8859-2?Q?t12OIX+TjBNg11v4Suxl1AcFeZO+yrc+SgkxVAZWOlqapogvQ8/PFqYBrw?=
 =?iso-8859-2?Q?wlsPcDIfpHaNUd2J+ern+nAMKbGs72VgkSJt0Cd144gIGPPlA5HnDzyQhG?=
 =?iso-8859-2?Q?b3/BnA9Tn4toNHMKSWjbSOxjJKGD4vReuvfXf/Tznj8+eX8owzhWbgbAB1?=
 =?iso-8859-2?Q?cR7fLI7Y4GbxNGFlSrIYt064oWTa32/O8LYaMk+Z+NqsmlZhiCqPo3+I8U?=
 =?iso-8859-2?Q?PnY+ge8TljotEgoDWmAJUam4ZHZuwCC43u9MkLOekrVxcS9uTyxmgMROi8?=
 =?iso-8859-2?Q?InQ6xE5B/+zJjbwpDDfqkicS8erOFwv7k2xrYoJEPkEuBxO5jYOFPaD8B5?=
 =?iso-8859-2?Q?RtGUWpFy75BgS0a8ffk/IX1K5PoaB64bqh11cJ4dsr+jYnU+ZzILC5AGiL?=
 =?iso-8859-2?Q?NrsNl2pvRlDiCX/MvYw281cnP2gUsKQaNy2WrM1MKYQHKLHVwoarD+skOr?=
 =?iso-8859-2?Q?aNPQ38L8k95XclE3DF0nlGUnqHO4?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09238701426EDE79BDAAFA2F9272ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31ec607-b6de-4371-57cd-08ddae824a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:07:57.3254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6hdkRb/oeNBhqBYI62OwC7Pw7kWwWilkSUdBgRE6TVRdaOQLM6uQGQdK3ucWyLj1XWspcQloPV0TlFtazAJz1V5cCLgst3qaOrDuCYIWTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR83MB0595
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09238701426EDE79BDAAFA2F9272ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This patch ports stack pointer reading to AArch64 at fork.cc and cygtls.h.=
=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From cc920233d50fe38f22610cb51f219e3c9b566109 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Fri, 6 Jun 2025 10:21:10 +0200=0A=
Subject: [PATCH] Cygwin: obtain stack pointer on AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/fork.cc                 | 4 +++-=0A=
 winsup/cygwin/local_includes/cygtls.h | 6 ++++++=0A=
 2 files changed, 9 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc=0A=
index f88acdbbf..4abc52598 100644=0A=
--- a/winsup/cygwin/fork.cc=0A=
+++ b/winsup/cygwin/fork.cc=0A=
@@ -660,8 +660,10 @@ dofork (void **proc, bool *with_forkables)=0A=
     ischild =3D !!setjmp (grouped.ch.jmp);=0A=
 =0A=
     volatile char * volatile stackp;=0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
     __asm__ volatile ("movq %%rsp,%0": "=3Dr" (stackp));=0A=
+#elif defined(__aarch64__)=0A=
+    __asm__ volatile ("mov %0, sp" : "=3Dr" (stackp));=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_in=
cludes/cygtls.h=0A=
index 31cadd51a..44bd44e72 100644=0A=
--- a/winsup/cygwin/local_includes/cygtls.h=0A=
+++ b/winsup/cygwin/local_includes/cygtls.h=0A=
@@ -325,7 +325,13 @@ public:=0A=
        address of the _except block to restore the context correctly.=0A=
        See comment preceeding myfault_altstack_handler in exception.cc. */=
=0A=
     ret =3D (DWORD64) _ret;=0A=
+#if defined(__x86_64__)=0A=
     __asm__ volatile ("movq %%rsp,%0": "=3Do" (frame));=0A=
+#elif defined(__aarch64__)=0A=
+    __asm__ volatile ("mov %0, sp" : "=3Dr" (frame));=0A=
+#else=0A=
+#error unimplemented for this target=0A=
+#endif=0A=
   }=0A=
   ~san () __attribute__ ((always_inline))=0A=
   {=0A=
-- =0A=
2.49.0.vfs.0.4=0A=
=0A=

--_002_DB9PR83MB09238701426EDE79BDAAFA2F9272ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-obtain-stack-pointer-on-AArch64.patch"
Content-Description: 0001-Cygwin-obtain-stack-pointer-on-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-obtain-stack-pointer-on-AArch64.patch"; size=1766;
	creation-date="Wed, 18 Jun 2025 16:07:54 GMT";
	modification-date="Wed, 18 Jun 2025 16:07:54 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjYzkyMDIzM2Q1MGZlMzhmMjI2MTBjYjUxZjIxOWUzYzliNTY2MTA5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogRnJpLCA2IEp1biAyMDI1IDEwOjIxOjEwICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBvYnRhaW4gc3RhY2sgcG9pbnRlciBvbiBBQXJj
aDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1V
VEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpTaWduZWQtb2ZmLWJ5OiBSYWRl
ayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5zdXAvY3lnd2lu
L2ZvcmsuY2MgICAgICAgICAgICAgICAgIHwgNCArKystCiB3aW5zdXAvY3lnd2luL2xvY2FsX2lu
Y2x1ZGVzL2N5Z3Rscy5oIHwgNiArKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9mb3JrLmNjIGIv
d2luc3VwL2N5Z3dpbi9mb3JrLmNjCmluZGV4IGY4OGFjZGJiZi4uNGFiYzUyNTk4IDEwMDY0NAot
LS0gYS93aW5zdXAvY3lnd2luL2ZvcmsuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9mb3JrLmNjCkBA
IC02NjAsOCArNjYwLDEwIEBAIGRvZm9yayAodm9pZCAqKnByb2MsIGJvb2wgKndpdGhfZm9ya2Fi
bGVzKQogICAgIGlzY2hpbGQgPSAhIXNldGptcCAoZ3JvdXBlZC5jaC5qbXApOwogCiAgICAgdm9s
YXRpbGUgY2hhciAqIHZvbGF0aWxlIHN0YWNrcDsKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVm
aW5lZChfX3g4Nl82NF9fKQogICAgIF9fYXNtX18gdm9sYXRpbGUgKCJtb3ZxICUlcnNwLCUwIjog
Ij1yIiAoc3RhY2twKSk7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorICAgIF9fYXNtX18g
dm9sYXRpbGUgKCJtb3YgJTAsIHNwIiA6ICI9ciIgKHN0YWNrcCkpOwogI2Vsc2UKICNlcnJvciB1
bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNs
dWRlcy9jeWd0bHMuaAppbmRleCAzMWNhZGQ1MWEuLjQ0YmQ0NGU3MiAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaAorKysgYi93aW5zdXAvY3lnd2luL2xv
Y2FsX2luY2x1ZGVzL2N5Z3Rscy5oCkBAIC0zMjUsNyArMzI1LDEzIEBAIHB1YmxpYzoKICAgICAg
ICBhZGRyZXNzIG9mIHRoZSBfZXhjZXB0IGJsb2NrIHRvIHJlc3RvcmUgdGhlIGNvbnRleHQgY29y
cmVjdGx5LgogICAgICAgIFNlZSBjb21tZW50IHByZWNlZWRpbmcgbXlmYXVsdF9hbHRzdGFja19o
YW5kbGVyIGluIGV4Y2VwdGlvbi5jYy4gKi8KICAgICByZXQgPSAoRFdPUkQ2NCkgX3JldDsKKyNp
ZiBkZWZpbmVkKF9feDg2XzY0X18pCiAgICAgX19hc21fXyB2b2xhdGlsZSAoIm1vdnEgJSVyc3As
JTAiOiAiPW8iIChmcmFtZSkpOworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyAgICBfX2Fz
bV9fIHZvbGF0aWxlICgibW92ICUwLCBzcCIgOiAiPXIiIChmcmFtZSkpOworI2Vsc2UKKyNlcnJv
ciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAorI2VuZGlmCiAgIH0KICAgfnNhbiAoKSBf
X2F0dHJpYnV0ZV9fICgoYWx3YXlzX2lubGluZSkpCiAgIHsKLS0gCjIuNDkuMC52ZnMuMC40Cgo=

--_002_DB9PR83MB09238701426EDE79BDAAFA2F9272ADB9PR83MB0923EURP_--

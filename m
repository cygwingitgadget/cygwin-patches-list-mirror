Return-Path: <SRS0=OfBw=Y7=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20710.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::710])
	by sourceware.org (Postfix) with ESMTPS id E8D4C39848CE
	for <cygwin-patches@cygwin.com>; Mon, 16 Jun 2025 08:37:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E8D4C39848CE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E8D4C39848CE
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2614::710
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750063029; cv=pass;
	b=Guw1qgeuRY8LABlrS4eozbdKscdwJT+9C1Qyd6btrBdmcQbBeLjAyzXgjnIlm5xWAim0KDJ2sgn48b3wvKyewNA8acxssC8LOnVNy9m3nQQw0mEPchDiRNkDXJaSY71EB4P5t0L9LvcmVa8aGGRpMi8ePhMBTDMH7cOgDT33+fI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750063029; c=relaxed/simple;
	bh=Uo2oxwKWgherGDSKcitE2RekBsB+d6K9wFPO7tfZDgI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ryQWgamroVDY1OP59T8UzAHyxQWk/JBOma1yZ4ALz4CeLzF8MDu2ukelu7l3BuuSyikNCNyUBgncB3ukJKuLNdKlsZhgkRivOfBz9zfd5zjPDnhqRcl63T1E7X9ajigOW36MkOuyAHrsBOHWyaNs0x1Iwlb1/66GNoIzjc/YqYw=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E8D4C39848CE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=F/W24Hwp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F470q8tHnCliuwCDU/BtQG5OG2+Yji3o6Gb2/FnfPi8uEhqQz8IXFuy9SulVdo9WQiIzqZk7EGc+N5A78FYN72clhZSlSkB4wCCmZhGyQO8Bx13zWya+gjT42VwOqIJItvTTtKzaRpT7w/YrcnXH85aE8SvCDohtlT4FqLyjl0Nw8/TCLD3TN8enGjWUFG7Y+l5TqNcQJrX+HqNu5ABzyUNjU4l6f/DMQj84giRtcE/1hPPPjnRekbbMHL3wVei/lluJdfwjJUIoQNo0ejm34H5Y4IDiphBT/B8dYRJLSoe72hkGWs2GFsNEzpb9uZb9idKt6vFDldpz0lWGRi6mFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4HYEyNWjaDFSzzlOBDpjiEKzZWk1nfHcrD2I4jJ8Qc=;
 b=YZSxUyvQ6hnWdXVpkH1elSnnHToFrG1CIC7/IrOO2X1rmQSW0HlakByLefsx1qPBG+ajSriyrSvc0TUGLe5bg0Ka2xp4yHH0NzdFfQjleGRhZzCqd/2tGwzx2gKH2DsEePxTXdBU9FvIuFX/P2Fy/MOtrtePQW1fkzMU97VYOglUZgNZtWxl1sHm8Te1GHDI5JJn9P9E3EsRF5VGnc6j38NiI9/1JtNXWAGezkv7H52h7PC+4km3iAOwYVlMFlDzkuNQl6DxNxNNUOOTzzN0vAI17rR5xlOTTDS/+1+ilAq5YGVUXqTQakoCsebpizgQy/324vGLVx0jkTyma6WVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4HYEyNWjaDFSzzlOBDpjiEKzZWk1nfHcrD2I4jJ8Qc=;
 b=F/W24HwpdqvF1ODzls1sL+c7qI2lFF5258MH5mrEqT5dIuQuet18fGubgESIQk29IA1JFfsFzqebUF8Th4fYaMY3LyRdVav9K6ly/LnqmdWRCfn9Zewdy1k6Vn5Zg3Yterl1ARO/Yae66jDncAKVP1yAI8iFQM34X9rtLyEiD4U=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by DU5PR83MB0637.EURPRD83.prod.outlook.com (2603:10a6:10:522::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.16; Mon, 16 Jun
 2025 08:37:05 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.004; Mon, 16 Jun 2025
 08:37:04 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2] Cygwin: implement spinlock pause for AArch64
Thread-Topic: [PATCH v2] Cygwin: implement spinlock pause for AArch64
Thread-Index: AQHb3pnW4nkiaeWoGUaib/pQgn086A==
Date: Mon, 16 Jun 2025 08:37:04 +0000
Message-ID:
 <DB9PR83MB092313132E1B9E5C8A8F91B79270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB09237758F38BC0ACB9AAB51B9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <c03e5943-d622-4381-8ce1-c85f1ffa3c69@SystematicSW.ab.ca>
 <e768114d-c2e5-7033-c30d-9991c5982f3b@jdrake.com>
 <7329e318-02fc-40d0-8f06-7c5ef8642182@SystematicSW.ab.ca>
In-Reply-To: <7329e318-02fc-40d0-8f06-7c5ef8642182@SystematicSW.ab.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-16T08:37:03.750Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|DU5PR83MB0637:EE_
x-ms-office365-filtering-correlation-id: 4ff15c1b-83f6-4c9a-9b6f-08ddacb0f8ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?eaFgvqYkwf51sGJqZHsZMy1t0eLD77i6tYyPnQtOND//rqjFSvUcdwFmB1?=
 =?iso-8859-1?Q?li2b5gFBrtjag+ljDilEiDNtIwuG+XiiF2NoxfDf1fwweed7WPvxpovek/?=
 =?iso-8859-1?Q?0YFoibTmt37b/ohEMW3IsMfIe+7IudHL0SN+CpRkfc96h8Qb5GNvqWT1kN?=
 =?iso-8859-1?Q?f2ju+PBYtlfHfjkqkISvTj8zEsYQZPM0OnXjRbBlElNwRdKdX6Ph3Jo2TM?=
 =?iso-8859-1?Q?PS3oVMs22l17ezbYZkDgIXCXm+Iv8HKKKhh9XSuBiH8TOEV97b2qB3DEmO?=
 =?iso-8859-1?Q?iyPwKqp58enxQILynci2TTPBjI6dWsWa/ekOe0/Y8aqRgHfj0mJFrakhF0?=
 =?iso-8859-1?Q?JMC7liVJgHC47t/pvEIFOuvgPmpa5HLSllzmbrY4FM4YRUywXWZJ0hXvt/?=
 =?iso-8859-1?Q?GXLfLJ7u2DaiWPGmwosCFXWFoxiWeh4lBlIlcDcMhUqa6m8CECGum2uo9Q?=
 =?iso-8859-1?Q?dQDOK8DjbVtqdva8Dj168ez41nmIVPKmEE5K+owmE+Bs3EKXmLruhX3i6h?=
 =?iso-8859-1?Q?ef2Y+bb0IciN/BR8bFLX8f7uz/6LLb/3/H74sGq2Z2fAsBJewY/HWXEdqx?=
 =?iso-8859-1?Q?QdP6KUQ30JUO4yy64jg4x9p9TZTXxcGgF6e22UUCZNdnjjodIaDrSUs4i1?=
 =?iso-8859-1?Q?J2ASj7PFJ6bSsmAIVjNLDdZii8Va3cRkZM5q6miNhZzXWIDPYjuh+I4gxy?=
 =?iso-8859-1?Q?/tTzRc05XQ5Xc/WKpvmYoxCNLVRM6M8JzzksUrkuRKkqNsTwSkIzf5Y+K5?=
 =?iso-8859-1?Q?14uBUgWJE325zBRwUCAPAI0Yl3xoZn4k+39Zp36LLz/0hBqLAjQkb6Sheg?=
 =?iso-8859-1?Q?+udOgQVfsjeeDsi60eHEaFFA+5JcfhVU7n2jQMPNTaoB6NnWxpdjGCviur?=
 =?iso-8859-1?Q?IU//BEubJ7Ui6Zbx5fkz64sOcaZOaVk/hp1HHrp0isiBPmHtN7lOdhjrgy?=
 =?iso-8859-1?Q?CgNmRjTqGdA5236Tpehm/opLIWCYypaiOadXntgEuiEG7KewrT4C/Vt1NR?=
 =?iso-8859-1?Q?8kPiKgN+wPjxNRq5Nq5RmncWx0DUfMyVMF1h96oblWYcf0RE7zWQs+eU+v?=
 =?iso-8859-1?Q?gWYfJfkxDI98OuHQ5Aq3SmWvZ1ZxupO/ZJvG54nVzDX5u0vmSaFjqUbR/k?=
 =?iso-8859-1?Q?td07oAsWlr5Uxh1v74n71yu+KPZVp9KKMfglHNfQnA36F1SltFFGKO3OZ/?=
 =?iso-8859-1?Q?FF0/jHM5qPT2s2X36wenxJ7gmdzk1meE+QMZtarLfSUrvg17w7HHKza0BV?=
 =?iso-8859-1?Q?28QOvC3so53qvsNKgH9butbje+64hbPyv1m7MfKnhfxdeb6Ub80g3snmXi?=
 =?iso-8859-1?Q?JdO5djoCZ+UQ7rMF068Oj7IQOOqEMQtvyXviTikL8reCjppqYVvztDrkCu?=
 =?iso-8859-1?Q?QpnCEm3JXhcmaj9zfel/EEEznDc73nY8Tmsx7iCiVkU9tbpdmcp1paAmGf?=
 =?iso-8859-1?Q?BLc7mQZgLtFcMIvWVdA1Q+sHEWlEPweHWbJ+yjzPT1hgA6EApIXj/idLFv?=
 =?iso-8859-1?Q?sfYRxWuopvcaavMDXseCyHqLIZh5Gwq8SLmKN3hTkHIDY/HKFcvpLymJ13?=
 =?iso-8859-1?Q?nUnkzHg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?txfyOLgx7Tun4foaZgtIQAaCjx54cSGMCerAFYHTmX3q8ztxvTG73UsO1v?=
 =?iso-8859-1?Q?/TeVu/zv8Ij7zutRX/V6iqMEhGGqZpe8BQbn/D6JEoexkUxcZwReOOs+eY?=
 =?iso-8859-1?Q?Z5R8ATNJ9CDubO26besCXU9UzKW6hvHz8UZpH9opsrxjeP8myEmeE2RKQm?=
 =?iso-8859-1?Q?9y+79tN9ryA90Amm7dOmTbx4QeEZ87Vwqv7LZ1NDytSavG3OTw7XfdoGZR?=
 =?iso-8859-1?Q?NMK+cRLlT48IK5k9mGSLY41GogaovCMoR6EqIH5lqIO5ZkypfqyzcptmdP?=
 =?iso-8859-1?Q?paNxKUM7kTTIbizxalitLF5Y0O07lZe/OA/5Q2wY9TExyN+k8Pr2If75mT?=
 =?iso-8859-1?Q?Onb/OGhpU2IQjWfbFYa4s8QL3uB2DE6kzTCF3ntuSVzN66r3irK4KkbOb7?=
 =?iso-8859-1?Q?Sk1khIjHjYGXHSkNmDvpBXPpZBmiPM52CNEp8UDOSTeTA5FcgZIrXkAJ0E?=
 =?iso-8859-1?Q?iASF3XL1RNBuU3Rw3fVuaM2tnoZl3oNiVoTh0OhXfd8iSFpP9HUiqPEKPN?=
 =?iso-8859-1?Q?J3KCey6xj5Oc570WsbVEivoT5Y1hCMIkNOWSn1EmhYenbfFB+MSDWvZo3j?=
 =?iso-8859-1?Q?a2j442dgDYo17aDLStVicYG3uhezHNq4+sZljAKbAtNGJALJxYMcC+oBtQ?=
 =?iso-8859-1?Q?Su/42y0IZcrjLg8slsUo3+l8aq7uKIdTqJgc5CMsA5gmNP+CPsYX5IofaC?=
 =?iso-8859-1?Q?7ttAvdzJqod2tTQ/6ucS9yDDZukHFip0VRQSpwdv2fWB3abLGYoJ7G9Bx6?=
 =?iso-8859-1?Q?wMuyPg0O/eIlIJJeMKyGvxB0dsQD1MsnPFFl/WBvGcHuQ/xFVZfpKk2Wbi?=
 =?iso-8859-1?Q?eFYPvq+frd096BcGz+l9O++oVmyr8o2UDFYYaAk6GAqeOM8AkmPYypVoFw?=
 =?iso-8859-1?Q?/HXL8849FRdEXY2/xrMvQ5zpMiZxCOTG088IDawnc8Lc/7o+D7ChIkv0ma?=
 =?iso-8859-1?Q?KOiGSN6FgArbTmrMF92RQ24gXP9ENhMlUnovRDiViGEv/B0SRMzIHzk8DS?=
 =?iso-8859-1?Q?87Q2Im9Z/4OPbImQ+nrHPTECKea5RCd7O4JRPbxtK5GjtgFgWdICbRwJ2p?=
 =?iso-8859-1?Q?1Drw8FjWw+gN7DuYw/rscc8YYPIYJBHkYhuDqAZic00ZHEWQLyYdJRzvu8?=
 =?iso-8859-1?Q?sAiqckRAnTZOh/KC3cHVYQiCJrj4PqnFbbwwBp1rO2Yd+vHB8BRtHwnw3k?=
 =?iso-8859-1?Q?HoFioO1OXl8eVKZGqaEGLKudY7z/TmfClYUbxhOFXn+ecTBQ7640GX0jFJ?=
 =?iso-8859-1?Q?wFUGmRE170PZAyeWnUngEgBkuzkuBxh8XhIALGPmr1Td9SarCqNcy5MoTQ?=
 =?iso-8859-1?Q?JbDelZJwLdqhlJtLcRMhfEEtUfVS0ltgtLAg6waeJ5VuqrMSHzp+nK0/OJ?=
 =?iso-8859-1?Q?KN4lszd+o/DOJIzVgHv71jQ31SHTjA64J9PeTxSMPVld7AL2jTXoB1NJJ3?=
 =?iso-8859-1?Q?FLyh5Uu111esLm73GU7Yj6cmgPESwnhwXHBWqSLkuQTffmli0y/wB0RrtF?=
 =?iso-8859-1?Q?zd/DypiXIw1MIK8Q8kvXROINbnR4L5Sf7IHB5dXGShFNwp8ozoRPLEap8A?=
 =?iso-8859-1?Q?ncXy2QpDa80CbzunjUpe3czmHp+I?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB092313132E1B9E5C8A8F91B79270ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff15c1b-83f6-4c9a-9b6f-08ddacb0f8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 08:37:04.4471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p42ChqadxAFBBvGDXH1rLemy1ZfZv11eQ//ovvKTTZ++1UGV7qcKqpI7HpRqwuRQmQtfW/3UepvgOccPXNT5eKi1cWLJ9071vkCU6x3kyb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR83MB0637
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB092313132E1B9E5C8A8F91B79270ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.

Thank you for your insights. The patch has ben changed according to your su=
ggestions.

Radek

---
From b055fb898c8f09ee1ae598c4c7d85ab2673d7a4c Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>
Date: Thu, 5 Jun 2025 12:41:37 +0200
Subject: [PATCH v2] Cygwin: implement spinlock pause for AArch64

---
 winsup/cygwin/local_includes/cygtls.h           | 5 ++++-
 winsup/cygwin/thread.cc                         | 5 +++++
 winsup/testsuite/winsup.api/pthread/cpu_relax.h | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_in=
cludes/cygtls.h
index 4698352ae..0b8439475 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -242,8 +242,11 @@ public: /* Do NOT remove this public: line, it's a mar=
ker for gentls_offsets. */
   {
     while (InterlockedExchange (&stacklock, 1))
       {
-#ifdef __x86_64__
+#if defined(__x86_64__)
        __asm__ ("pause");
+#elif defined(__aarch64__)
+       __asm__ ("dmb ishst\n"
+                 "yield");
 #else
 #error unimplemented for this target
 #endif
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index fea6079b8..510e2be93 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -1968,7 +1968,12 @@ pthread_spinlock::lock ()
       else if (spins < FAST_SPINS_LIMIT)
         {
           ++spins;
+#if defined(__x86_64__)
           __asm__ volatile ("pause":::);
+#elif defined(__aarch64__)
+          __asm__ volatile ("dmb ishst\n"
+                            "yield":::);
+#endif
         }
       else
        {
diff --git a/winsup/testsuite/winsup.api/pthread/cpu_relax.h b/winsup/tests=
uite/winsup.api/pthread/cpu_relax.h
index 1936dc5f4..71cec0b2b 100644
--- a/winsup/testsuite/winsup.api/pthread/cpu_relax.h
+++ b/winsup/testsuite/winsup.api/pthread/cpu_relax.h
@@ -4,7 +4,8 @@
 #if defined(__x86_64__) || defined(__i386__)  // Check for x86 architectur=
es
    #define CPU_RELAX() __asm__ volatile ("pause" :::)
 #elif defined(__aarch64__) || defined(__arm__)  // Check for ARM architect=
ures
-   #define CPU_RELAX() __asm__ volatile ("yield" :::)
+   #define CPU_RELAX() __asm__ volatile ("dmb ishst \
+                                          yield" :::)
 #else
    #error unimplemented for this target
 #endif
--
2.49.0.vfs.0.3

________________________________________
From: Cygwin-patches <cygwin-patches-bounces~radek.barton=3Dmicrosoft.com@c=
ygwin.com> on behalf of Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Sent: Thursday, June 12, 2025 11:54 PM
To: cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>
Subject: [EXTERNAL] Re: [PATCH] Cygwin: implement spinlock pause for AArch6=
4

On 2025-06-12 14:47, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 12 Jun 2025, Brian Inglis wrote:
>> Rust apparently uses yield on arm32, and isb (instruction sync barrier) =
on
>> aarch64, as yield is effectively a NOP (although it could be implemented=
 to
>> free up pipeline slots, SMT switch, or signal), while isb (with optional=
 sy
>> operand) is more like pause on x86_64:
>
> I looked up what mingw-w64 does, and for both arm32 and aarch64 they use
> "dmb ishst" followed by "yield" for YieldProcessor().  I think this makes
> sense, since you'd want any pending stores to be available before
> re-checking the spin condition.

That may be better depending on load and store acquire/release options desc=
ribed
in relation to barriers:

        https://github.com/eclipse-openj9/openj9/issues/6332

        https://devblogs.microsoft.com/oldnewthing/20220812-00/?p=3D106968

--
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien =E0 ajouter  not when there is no more to=
 add
mais lorsqu'il n'y a plus rien =E0 retrancher  but when there is no more to=
 cut
                                 -- Antoine de Saint-Exup=E9ry

--_002_DB9PR83MB092313132E1B9E5C8A8F91B79270ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v2-0001-Cygwin-implement-spinlock-pause-for-AArch64.patch"
Content-Description: v2-0001-Cygwin-implement-spinlock-pause-for-AArch64.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-implement-spinlock-pause-for-AArch64.patch";
	size=2266; creation-date="Mon, 16 Jun 2025 08:36:01 GMT";
	modification-date="Mon, 16 Jun 2025 08:36:01 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMDU1ZmI4OThjOGYwOWVlMWFlNTk4YzRjN2Q4NWFiMjY3M2Q3YTRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEyOjQxOjM3ICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQ3lnd2luOiBpbXBsZW1lbnQgc3BpbmxvY2sgcGF1c2Ug
Zm9yIEFBcmNoNjQKCi0tLQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaCAg
ICAgICAgICAgfCA1ICsrKystCiB3aW5zdXAvY3lnd2luL3RocmVhZC5jYyAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDUgKysrKysKIHdpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wdGhyZWFk
L2NwdV9yZWxheC5oIHwgMyArKy0KIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVz
L2N5Z3Rscy5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaAppbmRleCA0
Njk4MzUyYWUuLjBiODQzOTQ3NSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNs
dWRlcy9jeWd0bHMuaAorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5o
CkBAIC0yNDIsOCArMjQyLDExIEBAIHB1YmxpYzogLyogRG8gTk9UIHJlbW92ZSB0aGlzIHB1Ymxp
YzogbGluZSwgaXQncyBhIG1hcmtlciBmb3IgZ2VudGxzX29mZnNldHMuICovCiAgIHsKICAgICB3
aGlsZSAoSW50ZXJsb2NrZWRFeGNoYW5nZSAoJnN0YWNrbG9jaywgMSkpCiAgICAgICB7Ci0jaWZk
ZWYgX194ODZfNjRfXworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAlfX2FzbV9fICgicGF1c2Ui
KTsKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisJX19hc21fXyAoImRtYiBpc2hzdFxuIgor
ICAgICAgICAgICAgICAgICAieWllbGQiKTsKICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBm
b3IgdGhpcyB0YXJnZXQKICNlbmRpZgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi90aHJlYWQu
Y2MgYi93aW5zdXAvY3lnd2luL3RocmVhZC5jYwppbmRleCBmZWE2MDc5YjguLjUxMGUyYmU5MyAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi90
aHJlYWQuY2MKQEAgLTE5NjgsNyArMTk2OCwxMiBAQCBwdGhyZWFkX3NwaW5sb2NrOjpsb2NrICgp
CiAgICAgICBlbHNlIGlmIChzcGlucyA8IEZBU1RfU1BJTlNfTElNSVQpCiAgICAgICAgIHsKICAg
ICAgICAgICArK3NwaW5zOworI2lmIGRlZmluZWQoX194ODZfNjRfXykKICAgICAgICAgICBfX2Fz
bV9fIHZvbGF0aWxlICgicGF1c2UiOjo6KTsKKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisg
ICAgICAgICAgX19hc21fXyB2b2xhdGlsZSAoImRtYiBpc2hzdFxuIgorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJ5aWVsZCI6OjopOworI2VuZGlmCiAgICAgICAgIH0KICAgICAgIGVsc2UK
IAl7CmRpZmYgLS1naXQgYS93aW5zdXAvdGVzdHN1aXRlL3dpbnN1cC5hcGkvcHRocmVhZC9jcHVf
cmVsYXguaCBiL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wdGhyZWFkL2NwdV9yZWxheC5o
CmluZGV4IDE5MzZkYzVmNC4uNzFjZWMwYjJiIDEwMDY0NAotLS0gYS93aW5zdXAvdGVzdHN1aXRl
L3dpbnN1cC5hcGkvcHRocmVhZC9jcHVfcmVsYXguaAorKysgYi93aW5zdXAvdGVzdHN1aXRlL3dp
bnN1cC5hcGkvcHRocmVhZC9jcHVfcmVsYXguaApAQCAtNCw3ICs0LDggQEAKICNpZiBkZWZpbmVk
KF9feDg2XzY0X18pIHx8IGRlZmluZWQoX19pMzg2X18pICAvLyBDaGVjayBmb3IgeDg2IGFyY2hp
dGVjdHVyZXMKICAgICNkZWZpbmUgQ1BVX1JFTEFYKCkgX19hc21fXyB2b2xhdGlsZSAoInBhdXNl
IiA6OjopCiAjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKSB8fCBkZWZpbmVkKF9fYXJtX18pICAv
LyBDaGVjayBmb3IgQVJNIGFyY2hpdGVjdHVyZXMKLSAgICNkZWZpbmUgQ1BVX1JFTEFYKCkgX19h
c21fXyB2b2xhdGlsZSAoInlpZWxkIiA6OjopCisgICAjZGVmaW5lIENQVV9SRUxBWCgpIF9fYXNt
X18gdm9sYXRpbGUgKCJkbWIgaXNoc3QgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgeWllbGQiIDo6OikKICNlbHNlCiAgICAjZXJyb3IgdW5pbXBsZW1lbnRlZCBm
b3IgdGhpcyB0YXJnZXQKICNlbmRpZgotLSAKMi40OS4wLnZmcy4wLjMKCg==

--_002_DB9PR83MB092313132E1B9E5C8A8F91B79270ADB9PR83MB0923EURP_--

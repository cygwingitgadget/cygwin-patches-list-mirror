Return-Path: <SRS0=6c8O=Y3=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20712.outbound.protection.outlook.com [IPv6:2a01:111:f403:2613::712])
	by sourceware.org (Postfix) with ESMTPS id 602683843B57
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 12:34:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 602683843B57
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 602683843B57
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2613::712
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1749731677; cv=pass;
	b=bpF27q4EHUGgxyoRCF2A7oKFWqUZZpTSS9qtsnyHHMxp3evY/cWf0wNlS6o0imQim1tkTJBhLrzGzJavXHuwl4lDJ/y8Uz3WkyV/vd97j3JabxXMvj8LuHXnAJTcQpIxNbR5FEzX/No7fFQAdkb0OM5xdJH22/vkRxrhQQl70R4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749731677; c=relaxed/simple;
	bh=RSiwh5RZtTByTRPzF4rS83FnM6P2PWFhLFOIVRmFhLs=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=lEQiuHEaOhej+WbX8YLwy7q+cwqFfW5/6rv1tR/tCe9l79QsBtlll8X9X+l86DuQf7Odc6NxvpILEqUP71j5pi/AS/TJOSta4/RJN2qk/2VnlaaR2u7+t1dasK82K7HAxNsg1gFjlWZ0Ndf4kpdz4CH5WPFdo7PCbYCVTNKDBhk=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 602683843B57
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=XIRff5VG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBRam485xbmwD2WUHUuQvynaiQKfL52xRNLKpf9B11HmFkCPkdROo+JfSn5/LTI4mjTlxMJTrBWSxxW6a79kj5+6mdQo5OBz60PCYQtpDEJ1dQjGsS1mxDtNyuONWENggHTYhTbpBuxP/VBv+52f4AqWBYMD9dhiCfnzV5/i0zZAR7iQNdjh3qXUMJTEkLuslV8mRqcy02KPE9s/4wZE/+JmGFS9wVeSTsCU0M6LqTVq7cIOLA5+iT9jwbeeK3lQVGHsfQZ20tsC0H1UeEbIr3wfGOyiAKP/wLW5m8BEJTaQds7iIO1vUFKkA5u8fLUFHFKyOI+KaGCi79jyqoHgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gdi2Xy3eLEMS+byEuSKfTTjlyVmKLxCxzu+R6YJCaI=;
 b=Ulo/E2vdy0gcY2+OufTJvXLeSOzpO1nI6EUuBr1b0TP4nBZzGqoHM3yxhi07YLRoTXKvBjrAUH9k0ViXXJx4VQpR/MAv1BkD0c+yaneGKTiaBrtXOnntd10ZCPgWD4FBX2ncuXpwdVSYiYRWIGsUqfRM2v/6ZP0Rs4qLNcUfh0ZhsMh69+S9bCez407WQJfguJKP6XN1wySbV2capH/hxRw/VLtklZ5lW6TiMVzFrySt1MTr9p7YbD+zow2u6my0i6Jf+XOk+76VppyudZ1qfuKKf7v8Vh4LWovyig3d1mUdC7Bh0/uonbUQlobfTsiBJmTcwJM9EuPn5p5xF3xl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gdi2Xy3eLEMS+byEuSKfTTjlyVmKLxCxzu+R6YJCaI=;
 b=XIRff5VGI/hEzDy1kNl5RpgClygktplNIYyV+NU+1MotbJMdkMgW9Y7T8KDilXONIlimAogazDH/jzmC0iDU5rd+lhLlR2RqPYeQ8SLxPLdJjwMGBtsgEPPG+HqjT4cD/t6tJ6Sr++rSWaINKOVdJMAAfQ/wEmt+wj63lCwvRI8=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by PA1PR83MB0726.EURPRD83.prod.outlook.com (2603:10a6:102:484::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.10; Thu, 12 Jun
 2025 12:34:33 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 12:34:33 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: configure: allow configuring winsup for AArch64 
Thread-Topic: [PATCH] Cygwin: configure: allow configuring winsup for AArch64 
Thread-Index: AQHb25ThCk+L1aBZXkuyGF5yJxkmaw==
Date: Thu, 12 Jun 2025 12:34:32 +0000
Message-ID:
 <DB9PR83MB0923C4B40A6602F4A39784CC9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-12T12:34:31.527Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|PA1PR83MB0726:EE_
x-ms-office365-filtering-correlation-id: 1c6dfaae-b6b2-41b0-c656-08dda9ad7bb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?p8kRQoNGKWOMmypyB2CVlaQ62a5ySjaUJO5iAHKUFzqvXj13a/LvyARndX?=
 =?iso-8859-1?Q?Z2Kl6uWPnKwLF6D4iXGUU5rgRVohtLnvkUckGLMmEKGxXF7rOZO9WbhjTX?=
 =?iso-8859-1?Q?LqqQmMZPBXTid5/8DBbijgwkEEsLxnpaTPlfArqs2SY2jx6AlF5iS8FAxN?=
 =?iso-8859-1?Q?GkV+JxSg+8jK2g1r6pm860ntwNWPpWhH6ot9AjCANh80TiAiW+yDcjEXtQ?=
 =?iso-8859-1?Q?2vGi9lBzRyClSUXEAjlq4Ws4vMwZAxCRMSi+Iy8uD4kbbLllFzKCFKz6HW?=
 =?iso-8859-1?Q?rNxL7btAHtvJ22RcrO50h++PIXN+1rQE/32bHE9njs2YRqXEaoDpEoLy0m?=
 =?iso-8859-1?Q?TGbucdkMg4H10WY7ATYNOIofcmHdWANvfkSQg1GlYrWgM5tKdMaaAaX+o6?=
 =?iso-8859-1?Q?Oo2qGUGpGqZRqJn8lUCbnzPYjGZ8jIpUfzqZxapGJwhbZ5DBRK/Tc1IF5v?=
 =?iso-8859-1?Q?sx/Js0MFgQYRvbHLVIvCXzOgiqgrsM6uWitwGxOrwAFb7wE9poaNRWVcmj?=
 =?iso-8859-1?Q?M0oVIPx9KSaEAlqUIqGlXXZIqq3zzDwXIgEVg00nIDrT6TWp/pDd3+MaSb?=
 =?iso-8859-1?Q?0b4NWFo/QtlnWesft4G1l+GmpN9pYau5b4f7XGNCny9IkartsXyR1uyXqk?=
 =?iso-8859-1?Q?4hjdBa8txVT06LmnKFZl7XMYUh046SzeD2UsdgqIdJhRRkxCcWEmMFl2G8?=
 =?iso-8859-1?Q?dx6n75SeQwk3Ydt4fn9yZpEBhIYATWv1zQDaQvzq11jyeCwagBqhQToE29?=
 =?iso-8859-1?Q?MrmRWWhczuh6AI0H6/pInxzue8277Gt/k/0jKuBWFdxU+YhM5LjiYiRl/7?=
 =?iso-8859-1?Q?iWK5WrIshkIX9lOyw+NKQHbWczWxetg3+j52KVSnhD+Fz5pqeXlNwfN0CE?=
 =?iso-8859-1?Q?L5qt9jYSt37KlUT1WySSUIO76Ee/0ljLqwSFPbNc5fBIWVHKc4n9AWKx9R?=
 =?iso-8859-1?Q?YruFvJ8YKqysF2SQZRnTCxULk708JKy4FqD8OPNMOB2t2pBvsjHaVhMiNM?=
 =?iso-8859-1?Q?xsb2XC+nLXUwx82sbTCdZJk7oTFEq5et0btkqnClfPXR1GXwoHCFXr+4UP?=
 =?iso-8859-1?Q?s01OURCzNwetScvy3AWwbMb+A1pmN3HgxmUN7fYtYL0Crt9FiJC2czUiS3?=
 =?iso-8859-1?Q?0fkpg8OYpBQlRp0CZYwFJ11RHbIRGGMsgDRlAAQgRk951doHNwPhq+wxaf?=
 =?iso-8859-1?Q?Wb/vL1+DC/gPUL4Ytu606qnd/NnCtNy+MOt41wuyr+CxgPP7wUaohaikLi?=
 =?iso-8859-1?Q?dsrppPsh3Hmue/v3D1tJwhB8NLR9kZI6oha819qZ4kMXy4bNoOUOImSC/l?=
 =?iso-8859-1?Q?8GzpL1Yw3xQxXrJKpgic44IHEwn/ydT8Z/JTXDSCacnb+gBYKNJ6qe3MUM?=
 =?iso-8859-1?Q?iQ5vKfDA4hIQBFYu3c+CtwtDt1PZ5WRpSrLvubpqM6qXHk5806XO1kxIsN?=
 =?iso-8859-1?Q?AxDw82auIIeLCyVWRff77560/7/2neAHw13kdl5z/665B9uFxf3Qr6OBiP?=
 =?iso-8859-1?Q?2N6M1fnUQ/IyvJObk6CFCdrgHQ5fYvv+wKFGx+Yumw0vBeS2cfXC8ADr6B?=
 =?iso-8859-1?Q?8vrW5N8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fwNZ9OmZJa5IUOVaRDovT6R4VXyJzRyUBucwyKOG3VdoUoCx7g6q2I05ii?=
 =?iso-8859-1?Q?FQs6kQ99aknSdVB84xvEd/HgBgE/5D4N290keu5HtKwlOPFuSebL5bZv32?=
 =?iso-8859-1?Q?GIHqTfmVIg1O9JyhfunKWYaVRZmttl8twtpmbEYkTyZdTdJi1MlqSwNotM?=
 =?iso-8859-1?Q?ofsxImV/f3SJlMDW406+zEBqM+GJuoyf4a6bd8EFWzcdjQ6JMmVJ9iecB2?=
 =?iso-8859-1?Q?o66IqaVShc61ReQkzOHVsBGPNYaYRP96gmyPRRmAKPh1GV70d6d1VrrUNX?=
 =?iso-8859-1?Q?6Q6OCXcASVTs9US5IH5E4zAvKkDCQP31aCZ5kL+6+QsLIUdfQv0yGKxtkd?=
 =?iso-8859-1?Q?63vNBYRSw2fosNkh8BSDOw6htdFY8/ChyiIZRP/2TpdNAYOVp3+yR6MMl8?=
 =?iso-8859-1?Q?Wc4bWpur7LU4WUeQHJvZok8gpPDXdE1bOxg5UF4N5y0scYYTptJgGb/mw7?=
 =?iso-8859-1?Q?T7fvEeaEmGidUChWOg8BPsO8oRuDFxkO0ORuvQ+L/Mmo9QIImpmuNBoki7?=
 =?iso-8859-1?Q?N9bk7tm6IESxKDRMjMAPmzVQZ9g3gEyRnu578MYnIrfqMNelv/5ulnvx/6?=
 =?iso-8859-1?Q?Jz9qki4PE3bPNl1cz4kTuYJ3c2nTpeIoWJxFKxEBtb7mHnoi6YBAHLNRra?=
 =?iso-8859-1?Q?oJv/iP+fQrx6heRp/45FwI75e3jqv8mjDiA8WHhInJUOCsSl+seZ2Z2obJ?=
 =?iso-8859-1?Q?9CCxlHlr/zT+csGQmtyfbdtDgOJn+whQwLqVapxkKPOLGuvCOC77OATo63?=
 =?iso-8859-1?Q?Kd8MY4Ro/MiUUJ9xjO0ttLNM1zIiuYMIZPKv7foWxrOG22sda8fEGAmuXf?=
 =?iso-8859-1?Q?TVEzZRnRRI+kZsdF9qrxVCUf8ewUj4PknJopNK36SKPKzZWXxVzxnsQgh+?=
 =?iso-8859-1?Q?JlPleAua/qQu0OccyjaKQqPXla5dDgvhHrVRuSQaGHPDSofeTsoV/UVG8A?=
 =?iso-8859-1?Q?vWIry9z+Iyb4pYoCTzndOFU5HLlPmnC1VsD4rNOzzQMx//E9SOKFTG39eY?=
 =?iso-8859-1?Q?B0Ve5sz86bJU7W/K3WrdKbVVczWv+zzoK2lVUknPMnOk+T+awN/FQ+GAx6?=
 =?iso-8859-1?Q?nozhXtiO1VF3CaW0jYq5U0rXDJgHcin7yMon531q13GVyTm4ZMlB279sxS?=
 =?iso-8859-1?Q?+I4iPPpRx2g2TMBRVxJCjc89ctqR9CeKifWnObKYm7gmnPkWSlnbITjF/1?=
 =?iso-8859-1?Q?meIfZKCfr0M6jzUkvsZrflQN/tnaSt7vnWjvmBVVIGAPON35dzO7rT6S1n?=
 =?iso-8859-1?Q?DiGxUI46kUe4L/cSz4l1Q3VoFcbReGQ3A9EPeC/RsGys6USGiXM74I7jda?=
 =?iso-8859-1?Q?X5iK3oIc5cAXwbbJdxInYtDuuBzXSDz9+mGGBuTdDlGO+lmzXmrAs7I8J/?=
 =?iso-8859-1?Q?v8YckmPgLNa9lDdGjYou7lLhpsrGfuxn149poAhRP1UYFiAbzSob99V52s?=
 =?iso-8859-1?Q?roILET7osRwS2xOHwhQTI2LF1GiE+bi4zeW1nJPqo2MIdRsVIKLm+0V/if?=
 =?iso-8859-1?Q?Wl+PBCgeINShQ6uDpIyOhPImbdAhgc8l6bR7Y3F5cc4SNg5QU+j2D/LkNt?=
 =?iso-8859-1?Q?Lm0pL4MOvn+MyMjXn6msXPhW8zCk?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923C4B40A6602F4A39784CC9274ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6dfaae-b6b2-41b0-c656-08dda9ad7bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 12:34:32.5653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TCNASAwvrFA4IRguCD9RlSyT0rGq/PybUEYDbzDe+qfbd1+Ili9gcmJR2kenKihZGQIZe3n4Ada82hb0EDsSwBM6PpqkZA9p70XCI0jAiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0726
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923C4B40A6602F4A39784CC9274ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
This is a first patch from series that=A0aspire to allow building and linki=
ng Cygwin for Windows on Arm64 assuming there is already a `aarch64-pc-cygw=
in` toolchain available.=0A=
For validating it, the AArch64 Ubuntu cross-toolchain from https://github.c=
om/Windows-on-ARM-Experiments/mingw-woarm64-build/releases and the https://=
github.com/Windows-on-ARM-Experiments/newlib-cygwin/pull/31 job added to `c=
ygwin.yml` GHA workflow can be used.=0A=
=0A=
This patch only adds the necessary changes to `configure.ac` to pass the co=
nfiguration step of the build.=0A=
=0A=
Thank you for your feedback.=0A=
=0A=
Radek=0A=
=0A=
From f5b653121eda766db76c058f54c6039868a3366d Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 11:44:23 +0200=0A=
Subject: [PATCH] Cygwin: configure: allow configuring winsup for AArch64=0A=
=0A=
---=0A=
 winsup/configure.ac | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/winsup/configure.ac b/winsup/configure.ac=0A=
index 9b9b59dbc..18adf3d97 100644=0A=
--- a/winsup/configure.ac=0A=
+++ b/winsup/configure.ac=0A=
@@ -69,12 +69,14 @@ DLL_ENTRY=3D"dll_entry"=0A=
 =0A=
 case "$target_cpu" in=0A=
    x86_64)	;;=0A=
+   aarch64)	;;=0A=
    *)		AC_MSG_ERROR([Invalid target processor "$target_cpu"]) ;;=0A=
 esac=0A=
 =0A=
 AC_SUBST(DLL_ENTRY)=0A=
 =0A=
 AM_CONDITIONAL(TARGET_X86_64, [test $target_cpu =3D "x86_64"])=0A=
+AM_CONDITIONAL(TARGET_AARCH64, [test $target_cpu =3D "aarch64"])=0A=
 =0A=
 AC_ARG_ENABLE(doc,=0A=
 	      [AS_HELP_STRING([--disable-doc], [do not build documentation])],,=
=0A=
-- =0A=
2.49.0.vfs.0.3=

--_002_DB9PR83MB0923C4B40A6602F4A39784CC9274ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-configure-allow-configuring-winsup-for-AArch6.patch"
Content-Description:
 0001-Cygwin-configure-allow-configuring-winsup-for-AArch6.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-configure-allow-configuring-winsup-for-AArch6.patch";
	size=893; creation-date="Thu, 12 Jun 2025 12:25:07 GMT";
	modification-date="Thu, 12 Jun 2025 12:25:07 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmNWI2NTMxMjFlZGE3NjZkYjc2YzA1OGY1NGM2MDM5ODY4YTMzNjZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDExOjQ0OjIzICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBjb25maWd1cmU6IGFsbG93IGNvbmZpZ3VyaW5n
IHdpbnN1cCBmb3IgQUFyY2g2NAoKLS0tCiB3aW5zdXAvY29uZmlndXJlLmFjIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jb25maWd1
cmUuYWMgYi93aW5zdXAvY29uZmlndXJlLmFjCmluZGV4IDliOWI1OWRiYy4uMThhZGYzZDk3IDEw
MDY0NAotLS0gYS93aW5zdXAvY29uZmlndXJlLmFjCisrKyBiL3dpbnN1cC9jb25maWd1cmUuYWMK
QEAgLTY5LDEyICs2OSwxNCBAQCBETExfRU5UUlk9ImRsbF9lbnRyeSIKIAogY2FzZSAiJHRhcmdl
dF9jcHUiIGluCiAgICB4ODZfNjQpCTs7CisgICBhYXJjaDY0KQk7OwogICAgKikJCUFDX01TR19F
UlJPUihbSW52YWxpZCB0YXJnZXQgcHJvY2Vzc29yICIkdGFyZ2V0X2NwdSJdKSA7OwogZXNhYwog
CiBBQ19TVUJTVChETExfRU5UUlkpCiAKIEFNX0NPTkRJVElPTkFMKFRBUkdFVF9YODZfNjQsIFt0
ZXN0ICR0YXJnZXRfY3B1ID0gIng4Nl82NCJdKQorQU1fQ09ORElUSU9OQUwoVEFSR0VUX0FBUkNI
NjQsIFt0ZXN0ICR0YXJnZXRfY3B1ID0gImFhcmNoNjQiXSkKIAogQUNfQVJHX0VOQUJMRShkb2Ms
CiAJICAgICAgW0FTX0hFTFBfU1RSSU5HKFstLWRpc2FibGUtZG9jXSwgW2RvIG5vdCBidWlsZCBk
b2N1bWVudGF0aW9uXSldLCwKLS0gCjIuNDkuMC52ZnMuMC4zCgo=

--_002_DB9PR83MB0923C4B40A6602F4A39784CC9274ADB9PR83MB0923EURP_--

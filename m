Return-Path: <SRS0=bDv3=FD=multicorewareinc.com=aswin.kalies@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 800304BA2E10
	for <cygwin-patches@cygwin.com>; Thu,  9 Jul 2026 10:13:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 800304BA2E10
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 800304BA2E10
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1783592025; cv=pass;
	b=w4JZPkpBpCTDTvbMdr7+01ykUn77vwTdsO2/uKMOpwpQtA8JerHKUQssYozAINOE85Nmv9sMR8nl3d/xDCD8D2SOmluxfAV8BM4EoiAhH85pKeuNrcD8nR69hb6nGEDM7lvbSYLc4GS01eQoeafFqldSfhpoFgrI2JoWgllrO/A=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783592025; c=relaxed/simple;
	bh=wU3iE3r5Sk1uVgeQMSL5biuxatqaQOztS+lvjbtX4kw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=JjHngSgGyrtXc1TSXEXtvXa9LUIfQVxsFTcTuPNDZwf3XZrBwS2EENK0d2mquWDZotOhnoKRbdZF+dSzIt9Ow+Dx3wBjQws87+YdpTUXba1c42BQyqCE0KxQAROKAVkELytUSFiPe6fCRZUeiyctvJw8RkGlbBSaIyVbixlTQuM=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=jML7pKB1
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 800304BA2E10
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=jML7pKB1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jopwUIlno+aUTtSW0zeBwyWM89G5KgvUL+fJxgfNL4e/5cjkAMzJHjxhHRF1/WlaXbM/Y0GOvRyIkANj+Nina8/qW/AXrbXAM1LvNUMGCNBLWrGjzgCSdUmV6qPC2NyQuxiq8B6ec/XbWmXkMxOHck11uq99nckBiIBFb5goWQk7uIYbNXg13J8SNG9g4uTHtqhnZuldoX9n66ouaFPB1GUWTTcgZmwMGA9Hy5JIqFAE4wfksiDB37NhgaChqF3eTFjeJlKblzyTvI9837FQfxeLd0G73ohezi6GfWifjMtOOZGEeIVScPSqOEun6g/x/nUnJNwvKTA5A4jNV53J5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru6Jo9iCXKnoWqJRbRIR1IvRFzcBNwTpzxU2mcwZuAQ=;
 b=cWpXoT2VAX2NkpbwfYB5EZ2hO4th6Yz/mBfMCwN3D6RnV7vmvwasel51w7yV+yBDePCmWWSQ9wZXzlXbsmy8+9+aexDwFzh0QkmpGLqvI5PesG6sd3LUnjCMtdb4xWo8yiPuC37NJ3Zz0EJUpqvsllWANSQnATVc0Encdi+zym20fNTNdyFnzpvcPlM1t/bxLQf5Nhsl+hg16rraNyqX9CnO2JD53jIeHL4t483584HjnxE2znd0n1/C1MF174w3oL0P9sE8pbtR9lX/bnrMSf87H64DZdESITjqSAFeKcd6fDuU4mK7qcjG7orihOKiif+gE+tXcjCvTLk6wcHstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru6Jo9iCXKnoWqJRbRIR1IvRFzcBNwTpzxU2mcwZuAQ=;
 b=jML7pKB1Z3YMHwyKU33Nb5PqdJRYDfKWzVKU0aT2P73HVGWq2orMhZwdqiMG4rI0dkuuhegdVOGkTYPXuZXjRElljXSoBWdo1A8HixE4IO7ZdvQyIotEosXf17EOB+0bhZXsiT7tRAVm7op7co6g/znNdLQiYxs5mtpffnYwmEOPNliaLqEe/EAcPRfkWDhT7veGAJ7FjGDQWOqHoTfBO8N4otMwxTYGEvs7EgN/O000OZXD+jQY8yFZBa4kGUJr6PkphNqG+70Gw8YSGEUCSCoKlC7oIWcACefyysGJfJjTg1XNqnneyFGvr3cJfp0eoSzuXXc29x7KVNfuN1AQRA==
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:193::14)
 by MAUP287MB4894.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 10:13:38 +0000
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b]) by PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 10:13:37 +0000
From: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: dumper: add Aarch64 support
Thread-Topic: [PATCH] Cygwin: dumper: add Aarch64 support
Thread-Index: AQHdD4q/JjAk16H2EUKiaXz5elLDsQ==
Date: Thu, 9 Jul 2026 10:13:37 +0000
Message-ID:
 <PN3P287MB13206A5CED8DE6D538D83E40F7FE2@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1320:EE_|MAUP287MB4894:EE_
x-ms-office365-filtering-correlation-id: 54b06210-484a-475f-45ac-08dedda2be38
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|31052699007|366016|1800799024|39142699007|376014|23010399003|6049299003|4053099003|18002099003|55112099003|38070700021|6133799003|56012099006|8096899003;
x-microsoft-antispam-message-info:
 ccngsgzYM1plOce92EhUQe2Em81JKj+Va2GGxiNsaXH3hzNEEIJjv20s0/tALtDuSmOjPpj3tJMTD9AUOoLjgHx1OKha4Fk6eh1HUC3MzQ3M0V2/5eQ4N+MTxRXiwDsjC3Kf/es/l+iAX7bxU3U/uNuLzgFHMz0xx5KzU/eXNaOojHLIMbmUGxsV0glo9dcAyPz9nNu6f+0UtPFAXBosAbWkHI1kNu9YX4hd+lhUej9mTpJ5rXIXKFqg4qmPe+HUCI2l2ZLlNunHMlZ+oVyEAVRjkqQW7iC/BsRUuBRT5qCsqES+A2haLq/w23wzNkS4YUvT0F35IhBFyH8O9lmfzcV3dmz+e6RqmWJj8M4PTfFf6tNQov3nH6Afy2ea1oExIWvkMBE2RSlAHIAacATvHlRePnNpkrpYoHSH3+jd8I8M9aKMAP1TxBmpZcQNxOMNMpnbT4RbEK6Djt6K1ppM2pr9mp+IkB9yYs9HJwvSz+TAeydr7/vU+eyCwftAuVGPcDAz1Upga1y4H3xXXUY/MNDhzRu7JDNFjityPGEDOV67mEp4L5DCur369UX92r15OYsKspxFMIR9RFZEhulLVjxI9sxaagmUsV9d8jbfI1HhvvCi3bXaHCHbRoZ0TY+D/xRG/3TqBThxHKouANa1LbrpQ6QyilDfLhjpLgxlvCfypkhG8Cbem6lCoXnJUcCVkZBOuu65S3845MIKYITBmm8Lx2uCJoU+JhRnRSHqM+8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1320.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(31052699007)(366016)(1800799024)(39142699007)(376014)(23010399003)(6049299003)(4053099003)(18002099003)(55112099003)(38070700021)(6133799003)(56012099006)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mQY2kME9aeRJAdkURcapCYWKt+sLW4EGyIRanfDmH/CSAEOgSYuskYrwdb?=
 =?iso-8859-1?Q?twhJm48DMb9NeP+svA+HLvjwufkY1A+0a7XJzN8BlBHTcXS/amwE3B+ixu?=
 =?iso-8859-1?Q?2v9ldJvkGpeoxsay8UH/vEfW0Cvjx9b+0KnURAH9bFYzSy0WAaaIiDtN0C?=
 =?iso-8859-1?Q?T0KhoNipnkVzrmZBAAJypnwzTcm7ZChmwEf22X3ksmaszlWmxFJx0/F3ZQ?=
 =?iso-8859-1?Q?ANJl9XgCwtpRtu6yN8cCH1kAJMuzvEnQISut4Wo1zb5Bv/UwRGSAlItfja?=
 =?iso-8859-1?Q?Z6jz8SUW958Vd32YQJVduIoJ3I0RBDPlg7pUdJTJz7oeNm/6nkeo0ff2vX?=
 =?iso-8859-1?Q?qnWJSCsFs01PGtPRjcfre/UQHWZYlFHuc+JyPRxopiJ7/6MSyQPLRZStSd?=
 =?iso-8859-1?Q?VIDjy7XBDuwKgC9jbcqOba6j+XzQBh+q6tFElcmzuWLWHC0bet9C4Nc0oY?=
 =?iso-8859-1?Q?MUH8pdcsvSLANNh+7TPeSs/Rjk0O5PL59NVOFQ3SqZQ7wGZH3SuRL4/tJ1?=
 =?iso-8859-1?Q?h1cxfnWYffF0QCPQU00AAv1kWh0+cIT+GGQYI6QdG/aIsXIV/F6JvVMtMh?=
 =?iso-8859-1?Q?c2NpGtjAjsdMYmkkpt2CPzYfbJgx/vn5SJNJI5v6mLzX/4VE4O7nczKvBu?=
 =?iso-8859-1?Q?VP30Staq1JtH2m/CYkkSPjxGIyqQz3tRdXijtBrvVByGFwYqc9vn5T9fDQ?=
 =?iso-8859-1?Q?EnuEXCbZcsjzp9IqSLKXFtBIrmA0bkuChNCghsG7hP3oYbf7xT94A3mwPO?=
 =?iso-8859-1?Q?hyYCGkaS+3UWXTaQ2sVErxdZu9ioVcBYTVM3B0RLTnwzDkO/CS9iiWXsx3?=
 =?iso-8859-1?Q?e9jGHx9/fCLP8WBSlTNSRixbjVj38TgBGlczovyrpR/f9poRkXT2s/clGx?=
 =?iso-8859-1?Q?4tkRo4o0+4czRAq40bpJzwjjrm/euYIjY9x+BBZS7ROCbCtqGu3QHZoFf6?=
 =?iso-8859-1?Q?dS55r3qiyh9/T23Rs38ptQRf9PawKhcMow8fu7sjzO1Q7m6Ll5w/zPeniC?=
 =?iso-8859-1?Q?JX0nV473Yl2NS7VROnYatFx1a/CbO2g+bz2GV81jA8/EQRHknygjvSvEUd?=
 =?iso-8859-1?Q?r4jVO8jeHLoCeRwVUf84rFDDxNromuMybNnJREecaWeZd2YxUdJfwH8Nho?=
 =?iso-8859-1?Q?mvcauRetgJfvnth2dIuDa3a98as3/B0JeDqRiTJE90JtVYGqRXvGI0Mu/I?=
 =?iso-8859-1?Q?DqFGoCpFgO8HRyJB1zfZ1SjCwOQeorbh9tiCqILdGoTu7QDbbQjxxxnHnl?=
 =?iso-8859-1?Q?PfPERPuLjJOmS/Rck4v+Z0kK9q39QJPmOdFtaGT+kcf7zBPSQFkMz7QK7v?=
 =?iso-8859-1?Q?95IBJRGLgPW6+/PJqmtcdlC4rA1lOjWgcRRmuXmPAhffXXJbFeB3mpE5Nz?=
 =?iso-8859-1?Q?5TQjfEvhlVC9iNnjEN3IQfbBVVW6thiSfQ6zGT3ZdMa6LPOxgSbJOdtZg7?=
 =?iso-8859-1?Q?shlkA37Zv5jB2SF61nwVVChcFUq4Mv3Y2Cf35SPGXmwpIJL0WlMlzmqo+c?=
 =?iso-8859-1?Q?WOst9M7ac1FAEzdCOCeZESHEg0CV7cboXT61azPEXaJt0Iq+apVkx/t52O?=
 =?iso-8859-1?Q?sQBfyk3VMyBlgLXLBYp0/r0MJxlW0+PgkwYaA/KAR92TYsANmmcnUoITAo?=
 =?iso-8859-1?Q?EaawfH8mZoyQ5cbDr/4Enx2jolQNfSQuUj69iYRWqTq+5oJzf2so9JuoJU?=
 =?iso-8859-1?Q?08LyYj3mdlF2WW1NVwlEKoDnVUa27KvQHCRIzfCAF+/K+J0j6StcN30X66?=
 =?iso-8859-1?Q?be3rGOVurEJGs1mHyGFZRK/jKDI1aHQ6VsNngc1I3sClZECi1yr4G1OLgw?=
 =?iso-8859-1?Q?Wt5EA1AMblZxCygTpZUb8CEdm/K7QLA=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB13206A5CED8DE6D538D83E40F7FE2PN3P287MB1320INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b06210-484a-475f-45ac-08dedda2be38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 10:13:37.7726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPJYk3c5AzQK9zgtye3gbt8xFncVRg+HRT5vBZVyNHlmHlj6jqDx2HVyHGp8B7Dg24mMOf2E3uC+xcr5NwqlxIpJkiKcWLrlJsyulIXg4Ha4UU824J5Gilpmse4d53La
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUP287MB4894
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB13206A5CED8DE6D538D83E40F7FE2PN3P287MB1320INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB13206A5CED8DE6D538D83E40F7FE2PN3P287MB1320INDP_"

--_000_PN3P287MB13206A5CED8DE6D538D83E40F7FE2PN3P287MB1320INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,
This patch adds Aarch64 support to the core dumper utility. Previously, dum=
per.cc used "elf64-aarch64" as the BFD target name, which is not a valid BF=
D target vector which caused bfd_openw() to fail with "invalid bfd target" =
on Aarch64. This has been corrected to "elf64-littleaarch64", matching the =
aarch64_elf64_le_vec vector registered by BFD.
 Additionally, bfd_set_arch_mach() was unconditionally called with bfd_arch=
_i386, which is only correct for the x86_64 build. This is now conditionali=
zed so Aarch64 builds use bfd_arch_aarch64 / bfd_mach_aarch64 instead.
Thanks and Regards,
Aswin Kalies
Inline Patch
---
 winsup/utils/Makefile.am |  2 +-
 winsup/utils/dumper.cc   | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/winsup/utils/Makefile.am b/winsup/utils/Makefile.am
index e44079a41..a4521f2ab 100644
--- a/winsup/utils/Makefile.am
+++ b/winsup/utils/Makefile.am
@@ -79,7 +79,7 @@ LDADD =3D -lnetapi32
 cygpath_CXXFLAGS =3D -fno-threadsafe-statics $(AM_CXXFLAGS)
 cygpath_LDADD =3D $(LDADD) -luserenv -lntdll
 dumper_CXXFLAGS =3D -I$(top_srcdir)/../include $(AM_CXXFLAGS)
-dumper_LDADD =3D $(LDADD) -lpsapi -lntdll -lbfd @BFD_LIBS@
+dumper_LDADD =3D $(LDADD) -lpsapi -lntdll -lbfd -lsframe @BFD_LIBS@
 dumper_LDFLAGS =3D -Wl,--disable-high-entropy-va
 ldd_LDADD =3D $(LDADD) -lpsapi -lntdll
 mount_CXXFLAGS =3D -DFSTAB_ONLY $(AM_CXXFLAGS)
diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index b3151e66d..830cf9ce1 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -703,7 +703,7 @@ dumper::init_core_dump ()
 #if defined(__x86_64__)
   const char *target =3D "elf64-x86-64";
 #elif defined(__aarch64__)
-  const char *target =3D "elf64-aarch64";
+  const char *target =3D "elf64-littleaarch64";
 #else
 #error unimplemented for this target
 #endif
@@ -721,11 +721,19 @@ dumper::init_core_dump ()
       goto failed;
     }

-  if (!bfd_set_arch_mach (core_bfd, bfd_arch_i386, 0 /* =3D default */))
-    {
-      bfd_perror ("setting bfd architecture");
-      goto failed;
-    }
+#if defined(__x86_64__)
+  if (!bfd_set_arch_mach(core_bfd, bfd_arch_i386, 0 /* =3D default */))
+  {
+   bfd_perror("setting bfd architecture");
+   goto failed;
+  }
+#elif defined(__aarch64__)
+  if (!bfd_set_arch_mach(core_bfd, bfd_arch_aarch64, bfd_mach_aarch64))
+  {
+   bfd_perror("setting bfd architecture");
+   goto failed;
+  }
+#endif

   return 1;

--
2.49.0.windows.1





--_000_PN3P287MB13206A5CED8DE6D538D83E40F7FE2PN3P287MB1320INDP_--

--_004_PN3P287MB13206A5CED8DE6D538D83E40F7FE2PN3P287MB1320INDP_
Content-Type: application/octet-stream;
	name="Cygwin-dumper-add-Aarch64-support.patch"
Content-Description: Cygwin-dumper-add-Aarch64-support.patch
Content-Disposition: attachment;
	filename="Cygwin-dumper-add-Aarch64-support.patch"; size=2634;
	creation-date="Thu, 09 Jul 2026 10:13:10 GMT";
	modification-date="Thu, 09 Jul 2026 10:13:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1YWE2MTA4M2FlOGI5NDk5MjM5MjczYzM4MThiMjdkMjFjM2JjOTQ1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBjaGFuZHJ1LW1jdyA8
Y2hhbmRydS5rdW1hcmVzYW5AbXVsdGljb3Jld2FyZWluYy5jb20+CkRhdGU6
IE1vbiwgNiBKdWwgMjAyNiAxNzozMToxNSArMDUzMApTdWJqZWN0OiBbUEFU
Q0hdIEN5Z3dpbjogZHVtcGVyOiBhZGQgQWFyY2g2NCBzdXBwb3J0CgpVc2Ug
dGhlIGNvcnJlY3QgQkZEIHRhcmdldCB2ZWN0b3IgbmFtZSBmb3IgQUFyY2g2
NCwKImVsZjY0LWxpdHRsZWFhcmNoNjQiLCBtYXRjaGluZyB0aGUgYWFyY2g2
NF9lbGY2NF9sZV92ZWMKdmVjdG9yIHJlZ2lzdGVyZWQgYnkgQkZELCBpbnN0
ZWFkIG9mIHRoZSBwcmV2aW91c2x5CnVzZWQiZWxmNjQtYWFyY2g2NCIsIHdo
aWNoIGlzIG5vdCBhIHZhbGlkIEJGRCB0YXJnZXQKbmFtZSBhbmQgY2F1c2Vk
IGJmZF9vcGVudygpIHRvIGZhaWwgd2l0aCAiaW52YWxpZCBiZmQgdGFyZ2V0
Ii4KClNldCB0aGUgQkZEIGFyY2hpdGVjdHVyZS9tYWNoaW5lIGFwcHJvcHJp
YXRlbHkgZm9yCkFBcmNoNjQgKGJmZF9hcmNoX2FhcmNoNjQgLyBiZmRfbWFj
aF9hYXJjaDY0KSByYXRoZXIKdGhhbiB1bmNvbmRpdGlvbmFsbHkgdXNpbmcg
YmZkX2FyY2hfaTM4Niwgd2hpY2ggb25seQphcHBsaWVzIHRvIHRoZSB4ODZf
NjQgYnVpbGQuClNpZ25lZC1vZmYtYnk6IENoYW5kcnUgS3VtYXJlc2FuIDxj
aGFuZHJ1Lmt1bWFyZXNhbkBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KU2lnbmVk
LW9mZi1ieTogQXN3aW4gS2FsaWVzIDxhc3dpbi5rYWxpZXNAbXVsdGljb3Jl
d2FyZWluYy5jb20+Ci0tLQogd2luc3VwL3V0aWxzL01ha2VmaWxlLmFtIHwg
IDIgKy0KIHdpbnN1cC91dGlscy9kdW1wZXIuY2MgICB8IDIwICsrKysrKysr
KysrKysrLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL3V0aWxz
L01ha2VmaWxlLmFtIGIvd2luc3VwL3V0aWxzL01ha2VmaWxlLmFtCmluZGV4
IGU0NDA3OWE0MS4uYTQ1MjFmMmFiIDEwMDY0NAotLS0gYS93aW5zdXAvdXRp
bHMvTWFrZWZpbGUuYW0KKysrIGIvd2luc3VwL3V0aWxzL01ha2VmaWxlLmFt
CkBAIC03OSw3ICs3OSw3IEBAIExEQUREID0gLWxuZXRhcGkzMgogY3lncGF0
aF9DWFhGTEFHUyA9IC1mbm8tdGhyZWFkc2FmZS1zdGF0aWNzICQoQU1fQ1hY
RkxBR1MpCiBjeWdwYXRoX0xEQUREID0gJChMREFERCkgLWx1c2VyZW52IC1s
bnRkbGwKIGR1bXBlcl9DWFhGTEFHUyA9IC1JJCh0b3Bfc3JjZGlyKS8uLi9p
bmNsdWRlICQoQU1fQ1hYRkxBR1MpCi1kdW1wZXJfTERBREQgPSAkKExEQURE
KSAtbHBzYXBpIC1sbnRkbGwgLWxiZmQgQEJGRF9MSUJTQAorZHVtcGVyX0xE
QUREID0gJChMREFERCkgLWxwc2FwaSAtbG50ZGxsIC1sYmZkIC1sc2ZyYW1l
IEBCRkRfTElCU0AKIGR1bXBlcl9MREZMQUdTID0gLVdsLC0tZGlzYWJsZS1o
aWdoLWVudHJvcHktdmEKIGxkZF9MREFERCA9ICQoTERBREQpIC1scHNhcGkg
LWxudGRsbAogbW91bnRfQ1hYRkxBR1MgPSAtREZTVEFCX09OTFkgJChBTV9D
WFhGTEFHUykKZGlmZiAtLWdpdCBhL3dpbnN1cC91dGlscy9kdW1wZXIuY2Mg
Yi93aW5zdXAvdXRpbHMvZHVtcGVyLmNjCmluZGV4IGIzMTUxZTY2ZC4uODMw
Y2Y5Y2UxIDEwMDY0NAotLS0gYS93aW5zdXAvdXRpbHMvZHVtcGVyLmNjCisr
KyBiL3dpbnN1cC91dGlscy9kdW1wZXIuY2MKQEAgLTcwMyw3ICs3MDMsNyBA
QCBkdW1wZXI6OmluaXRfY29yZV9kdW1wICgpCiAjaWYgZGVmaW5lZChfX3g4
Nl82NF9fKQogICBjb25zdCBjaGFyICp0YXJnZXQgPSAiZWxmNjQteDg2LTY0
IjsKICNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCi0gIGNvbnN0IGNoYXIg
KnRhcmdldCA9ICJlbGY2NC1hYXJjaDY0IjsKKyAgY29uc3QgY2hhciAqdGFy
Z2V0ID0gImVsZjY0LWxpdHRsZWFhcmNoNjQiOwogI2Vsc2UKICNlcnJvciB1
bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCkBAIC03MjEs
MTEgKzcyMSwxOSBAQCBkdW1wZXI6OmluaXRfY29yZV9kdW1wICgpCiAgICAg
ICBnb3RvIGZhaWxlZDsKICAgICB9CiAKLSAgaWYgKCFiZmRfc2V0X2FyY2hf
bWFjaCAoY29yZV9iZmQsIGJmZF9hcmNoX2kzODYsIDAgLyogPSBkZWZhdWx0
ICovKSkKLSAgICB7Ci0gICAgICBiZmRfcGVycm9yICgic2V0dGluZyBiZmQg
YXJjaGl0ZWN0dXJlIik7Ci0gICAgICBnb3RvIGZhaWxlZDsKLSAgICB9Cisj
aWYgZGVmaW5lZChfX3g4Nl82NF9fKQorICBpZiAoIWJmZF9zZXRfYXJjaF9t
YWNoKGNvcmVfYmZkLCBiZmRfYXJjaF9pMzg2LCAwIC8qID0gZGVmYXVsdCAq
LykpCisgIHsKKwkgIGJmZF9wZXJyb3IoInNldHRpbmcgYmZkIGFyY2hpdGVj
dHVyZSIpOworCSAgZ290byBmYWlsZWQ7CisgIH0KKyNlbGlmIGRlZmluZWQo
X19hYXJjaDY0X18pCisgIGlmICghYmZkX3NldF9hcmNoX21hY2goY29yZV9i
ZmQsIGJmZF9hcmNoX2FhcmNoNjQsIGJmZF9tYWNoX2FhcmNoNjQpKQorICB7
CisJICBiZmRfcGVycm9yKCJzZXR0aW5nIGJmZCBhcmNoaXRlY3R1cmUiKTsK
KwkgIGdvdG8gZmFpbGVkOworICB9CisjZW5kaWYKIAogICByZXR1cm4gMTsK
IAotLSAKMi40OS4wLndpbmRvd3MuMQoK

--_004_PN3P287MB13206A5CED8DE6D538D83E40F7FE2PN3P287MB1320INDP_--

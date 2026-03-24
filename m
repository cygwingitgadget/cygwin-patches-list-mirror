Return-Path: <SRS0=VhY4=BY=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id 03E274BB3BDA
	for <cygwin-patches@cygwin.com>; Tue, 24 Mar 2026 12:42:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 03E274BB3BDA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 03E274BB3BDA
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1774356179; cv=pass;
	b=N06yi5oF6xwEyTzuHaTQ9im+oLOplCZzeDawrR9T4r6zkMgt/8O/bKM5A9h4AzAXe0aIKR9/P7VUOg7uM27CxEVwhIFNY1m9/od5MVMOrzrh2NViva35UKAP6B3A2sCoTHuDt7x9oIkyzb9Giskd/ZLa0plsheA6BFEqLNw2qHc=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774356179; c=relaxed/simple;
	bh=sxq46CCo2N3MHUbn+x2fEkG8dzwwbmB7DrKNxFWwIeU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=a586kEhjKjMGPZameK0v5de/3awgIK+C++41gLQaztaKzBROH8FGi1K5LyZsySR6YP0eMxMTjPnf0XSs6ffcY8LqWl9dKcZyCtYUS7ECupVGVdhTrIQQWcBLrEijHSe/cboZaTStkYS9OU0TvVekyN8OaIROQfSZF3NozGq+ODU=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03E274BB3BDA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=WNtGW4iV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+eaU+r+Ph0xKoA+EUsIvoLj0jloU8mhguF1t640QMf5vwRmlkzld6ZyXgoftSy5Jv/fJAMEjrtG9EjkrR1yfZ89v7fMymztVqrd+hK9nK2G/Ij/o0b05ajiz9sS09EJ/TpL3K93IXnXm2bQJtVdadWl1oxPjJ0aUbCHIsc/uTDdzQjOdqV3YlCopZRvXnRPsFTMiypEi0O72mNLiclbCC4mLBR7GkYje8uwj3+GeV2RpB6N+pO/oWRS9BtDrb3HpCTIy37yIi4Ut7gP+DZ4hQqMpNIbOdaJeRRl2ZRg2A7UZDKV5dCVEyqB5DEX391Z6kXdCAerxjhvX2/5vHVWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qic+6tC21ULa/LhIe5DtHKudojKJ2NoMWZ3DSg0J+9M=;
 b=Rci9sYQIvVPRvhNi2n91PvXFRqv26d17ouvGFd+pYg2ffknVvnxEYr//C4rmplNqfWJqrDO82KeOEzOxsVKnlGIzFVdEyVhpEMOKtcwWm/OnM7r5Fr7CIRxqI1xxdznIddn3hC9OZvicoz0UmvqV3iZVtkjYBlhoeweqq1jbw4X8t7XZfQNWC+1g/wL3QYCblsnYqHfNtOsEVjYG30K8IW/6uacCPY6RDuyEgu3gH/MhAVccQt4M97Y4NhbW6VFTf4NwVNfvdm7jZ+GTFvpLVDP4T8neYMbinuKuneooojkKp8F++MgTVN7+KQkKCGFQwwIRwVpWTfXJlFJEfSxqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qic+6tC21ULa/LhIe5DtHKudojKJ2NoMWZ3DSg0J+9M=;
 b=WNtGW4iVp5Oltjav/wR3FnBo3itBfQ3S+UDjUhvsmLLR07nj9u3fhwkO277VXwdwGeLB9BVU1gLyx/R3fYkOxeKkoEpYhs098Jb8zS6C/0BP21/oFHfZb/PMMewVtjWrtm+4ocECGlvKfaebr3EhR1DY1aKV6H953KRjI+h8NzgBlfJFKAocdt3dGV0+/7oggONrQnHJBSUge96pAVyDfCvdoKpX3NmWERQJaYlWv7HnsdEb3IUd/lihbJDRDU+RwJiftq/Z7tD4OxI4Jmf8yOG8xGl0S8O4KK3Ad6ZsHX2kVus01g/5K+3la3aQ2eRWgUxRdNSTN4wDzkN10ayZ/g==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PNXP287MB4380.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:42:49 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9723.022; Tue, 24 Mar 2026
 12:42:48 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: aarch64 SEH fixes and handler refactoring
Thread-Topic: [PATCH] Cygwin: aarch64 SEH fixes and handler refactoring
Thread-Index: Ady7iqf8Kaqk9IbyQum4KYj9YcFaLw==
Date: Tue, 24 Mar 2026 12:42:48 +0000
Message-ID:
 <MA0P287MB3082CAC457D335E3325522CD9F48A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PNXP287MB4380:EE_
x-ms-office365-filtering-correlation-id: 721b6081-f196-4639-6d9a-08de89a2dadd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|6049299003|10070799003|8096899003|13003099007|4053099003|38070700021|55112099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 t1OIcQFpTO40/xjO6epnj5sIovq4A1OE/reuCCkZv3ivVBlRidiRM/UZvFuIeRge8YTSWM1fKvMS3myO1TfzDucYQHcTEhP0+Iz5vxucwV6cX+T6dTSWCgJT9qRMhxKCnHJYtRZmLgZ5nLer0HyE19x92DPBOoqyxpWI2Q7BHFFqCwLIVnHUYrKlEjkNs1Cl+yRQu6uU+KYK+5NWPkfcwEFnBuob6BrHjxZ0P8McyuTP1H2kEmQaSqByrNGuiq7gSyFqLo5ztqDyU3FuRJldaoKVt35cpcKzNpt52k8abBJY1bhaGSnwW0PtiNsLb2fyJSIus+UFI/Qz+SOJATuaoIzcDZh8sXdfLZKM4PR6zek3Wz96Tc/oBaszmDgyMyILNsiC+NJolPP1pkORc4s5Y0NgsVqPMeMhuFn2ZY417CTNIC4g9YoIQX2LLXlIIyJBM6l5kDo/klijlTKyAuNCZHuH5onpHk05O0eqKkQDGWDmpVJhe+vqtnH8HwSpoP8ZjTBlb4E6but7gsDioZDFwHq4E4QPC1t5ItwJybGgeelX0/P7OeAA8T9yaHRSWYaOtP2xFBsgIJ9hndgOaJXkeK4jNRzlMbJQYMsTs+8sGy67DHjyrmP644svqht2dFkhzLUq4fpBtf07MYoaYpQ5piDdKfOVYWq56ZJ0Z3iyzEDMgTwd8WZK66EBymxaQfGFM5iVgsa98bMMsN7yrLEmhkQTE0o1Hng80q4lFoAI0yuTMyoCmw5IV4c/5glVirrY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6049299003)(10070799003)(8096899003)(13003099007)(4053099003)(38070700021)(55112099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NGycarLuXW5vKDMb4/rdW4fznKapjuHgwYXfOY2pYW398ksvWBwSDAJAPSaN?=
 =?us-ascii?Q?rivUkpBmJaNvLl29zmaE3tb/IMeUQ7cU2g3iPSDicnA2tsCVvJVzJZHj6VP2?=
 =?us-ascii?Q?FWdVPfHxWQ9rRgcUMWTA2hKUJ5lt8weqpnwsCp9d1G+AQUgJVLXXFI8DgrKI?=
 =?us-ascii?Q?1qeMIv4KjjpjOZI7zmMRUU2IrdmjYxs5dBXbYv1SxSFHYdFll0oBQsxHxWGK?=
 =?us-ascii?Q?Jp2mhjhNyDNHymIWbFTb9lJWP/jIYaVnQZIEPzrCx8e63k4BfcoZ/x5Ov8Z9?=
 =?us-ascii?Q?60gqpHupW0nM0YCaQ2m4MBWr3pq3Bj5XVI2v5oiVbJAUQPQHO/RTw5mQgGJS?=
 =?us-ascii?Q?4O5zN2NTinw7SOlvYoeiYlm+Hqio8mxHviV0LbDbEgHAws7eNWL/Ti3nxN1T?=
 =?us-ascii?Q?H3MzUOJu2MD4ZPl6gjf/wJmFBgnGELAUmyGz8OgOtG0Sqw6IlAEe0NutJJ8c?=
 =?us-ascii?Q?HNc1/glIyu74NnmQFBEfN3rCwGd5KIEcNz6WewODwTWOEwgs3ir4rHsB63m6?=
 =?us-ascii?Q?L6j33SWDIiUVgr8pAkqBn610dkFj/gurNluBbrV48u00VJKLYiaq31u+palF?=
 =?us-ascii?Q?Gb9mBC625JZa/EfT4Ty++7mai9xM9NluF47NObrlzY+g3nuiZqZQ2jFxXkng?=
 =?us-ascii?Q?YPsr65vrdTf1uET91rliR5EOSQc6Ocvb30xnZq03AVQ3N+bWAbqIPCWDp4cI?=
 =?us-ascii?Q?NoUoDsG4KmLe76OkdGgC+0TpgNvMhkXrYUFp4eC7QQCb8imcWI+NGar0gly+?=
 =?us-ascii?Q?/V8u8d3msxymA1ZBq0jXoxzCrz5Lr4epyZxLgpe0Lj60I9+ITxJHslmPp84O?=
 =?us-ascii?Q?Ht51BXJNdQiX94kgrNe2U2nDr0ThOSjIb33NxsPHfSYVEq8eF80x56DPfAHu?=
 =?us-ascii?Q?dMDv1Bufz5fBEibHMXMr5NhoDyZ1Ry9zzd/lVUReuY8rxnJbH+XU+q9y7NUt?=
 =?us-ascii?Q?o5F9xgFWqkaiDPElGN/Y9TYkFgxhIWZbQaP+aJvEZCmH0WwdF0ZFecxRpL6d?=
 =?us-ascii?Q?jQWOcXqWK+AUCkiiKQso/WxbLDy+kf7Qn42mDCNslRH57GNRj/xJcpVz6UEP?=
 =?us-ascii?Q?FQs/07j7jXzA5e8VHbQc/80sGlRvaMgJYwMBylSlUuQSDugTuW5xBUZuaQmP?=
 =?us-ascii?Q?e2RBv4P9xI0D/z4qNdkrHcw5Mwe5XTyyehKTsfS4UnTg21CgbCAmiJ1ukete?=
 =?us-ascii?Q?zZQmvZVvViRDC+KH7bi6rhi9uqcafJUIqFQ/+3RtDjhT98hNEVuaS313ZlpQ?=
 =?us-ascii?Q?hsnOV7N5s0Oq/nVuTAGAhQRcCVv69WzJmxbzVUqbsfmgJfqrk+Hj0n+xZtg8?=
 =?us-ascii?Q?pRO6bo9+C+XfSk+oh5bYUApoh4kxA20Fl1cWoOJxaOurrOdww8rZTPi+JiR6?=
 =?us-ascii?Q?Eicu6YQ85JC3iKobxvZr0sQGz8DPmLhMAyLbBYYk8j+a/iewcCOnORSN6fW4?=
 =?us-ascii?Q?RklknGtv7yTVKfv6cvWSAJwygPARlLhgOmMU+rRP01dJ//9o7rBEO3m/pfum?=
 =?us-ascii?Q?N2b9iSQPfX/5uOZ5nLe7e9uaqJ5pOoUylJdtNLmYnEF+/jxv+BpQ9t0ykSa5?=
 =?us-ascii?Q?soYDRM4HVfSjlEVz23v+JD6LdmQDMml9o8GXCfe0Cwbq/bZ/kFj5cSe1rw99?=
 =?us-ascii?Q?25q5PYxwvbUxfKr2ZD79ijQaUez0DWhIF/9OVzY9EEu5qkYvuLnjEOvmZNcH?=
 =?us-ascii?Q?TteWU0X7z5zmxEEX1nXARwEosVNzaevDu14No3dIyU67i1cmbeMBhnKeCNyG?=
 =?us-ascii?Q?xEo5tFWbXtZZJ+IbMRiOXWzE7aQVzRBiRFwbJhkgAMvTFjKXNG+CCk/24URb?=
x-ms-exchange-antispam-messagedata-1:
 nyB5avD0kx5kFfwd7opfBWqb9LwNcYZvvphTQrDeosCuwJHJfNmkzQ8S
Content-Type: multipart/mixed;
	boundary="_005_MA0P287MB3082CAC457D335E3325522CD9F48AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 721b6081-f196-4639-6d9a-08de89a2dadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 12:42:48.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiQgETqYzDXSWfPLcak/EAi4aYCUVSyWAmq/37J/71g27DfFbhUMAyqoOhA1ruiz/QPkibBX3NPH0gmGkJBuqKhQ99rLnNlXnQlD0g+ssmA0mfVb78iUQ5Z8MfrD70SKBFLeMn4mCvGdWz7o6TR7Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXP287MB4380
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_005_MA0P287MB3082CAC457D335E3325522CD9F48AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082CAC457D335E3325522CD9F48AMA0P287MB3082INDP_"

--_000_MA0P287MB3082CAC457D335E3325522CD9F48AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

The previously posted patches for aarch64 SEH support and handler refactori=
ng were marked as work-in-progress. Now they should be ready for upstream r=
eview.
This series [2 patches] includes changes related to:


  *   Proper symbol references for exception handlers on aarch64
  *   Refactoring of SEH handler data setup via macros
  *   Guarding altstack_wrapper in exceptions.cc for supported architectures

These patches will unblock merging of patch from Igor Podgainoi [SEH: Fix c=
rash and handle second unwind phase on aarch64]( https://cygwin.com/piperma=
il/cygwin-patches/2026q1/014741.html)

Thanks & regards
Thirumalai Nagalingam

In-lined patch:

[PATCH 1/2] Cygwin: Add ARM64 support for SEH handler symbol references

 winsup/cygwin/local_includes/cygtls.h    |  8 +++++++-
 winsup/cygwin/local_includes/exception.h | 11 ++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_in=
cludes/cygtls.h
index 9f83c134c..336c72a06 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -344,6 +344,12 @@ public:
   void leave () __attribute__ ((returns_twice));
 };

+#if defined (__aarch64__)
+#define EXCEPTION_MYFAULT_REF "_ZN9exception7myfaultEP17_EXCEPTION_RECORDP=
vP8_CONTEXTP25_DISPATCHER_CONTEXT_ARM64"
+#else
+#define EXCEPTION_MYFAULT_REF "_ZN9exception7myfaultEP17_EXCEPTION_RECORDP=
vP8_CONTEXTP19_DISPATCHER_CONTEXT"
+#endif
+
 /* Exception handling macros. This is a handmade SEH try/except. */
 #define __mem_barrier  __asm__ __volatile__ ("" ::: "memory")
 #define __try \
@@ -352,7 +358,7 @@ public:
     __mem_barrier; \
     san __sebastian (&&__l_except); \
     __asm__ goto ("\n" \
-      "  .seh_handler _ZN9exception7myfaultEP17_EXCEPTION_RECORDPvP8_CONTE=
XTP19_DISPATCHER_CONTEXT, @except                                          =
  \n" \
+      "  .seh_handler " EXCEPTION_MYFAULT_REF ", @except                  =
                             \n" \
       "  .seh_handlerdata                                              \n"=
 \
       "  .long 1                                                       \n"=
 \
       "  .rva %l[__l_try],%l[__l_endtry],%l[__l_except],%l[__l_except] \n"=
 \
diff --git a/winsup/cygwin/local_includes/exception.h b/winsup/cygwin/local=
_includes/exception.h
index 13159d17b..19bb109de 100644
--- a/winsup/cygwin/local_includes/exception.h
+++ b/winsup/cygwin/local_includes/exception.h
@@ -7,7 +7,12 @@ details. */
 #pragma once

 #define exception_list void
-typedef struct _DISPATCHER_CONTEXT *PDISPATCHER_CONTEXT;
+
+#if defined (__aarch64__)
+#define EXCEPTION_HANDLE_REF "_ZN9exception6handleEP17_EXCEPTION_RECORDPvP=
8_CONTEXTP25_DISPATCHER_CONTEXT_ARM64"
+ #else
+#define EXCEPTION_HANDLE_REF "_ZN9exception6handleEP17_EXCEPTION_RECORDPvP=
8_CONTEXTP19_DISPATCHER_CONTEXT"
+#endif

 class exception
 {
@@ -21,8 +26,8 @@ public:
     /* Install SEH handler. */
     asm volatile ("\n\
     1:                                                                 \n\
-      .seh_handler                                                       \
-       _ZN9exception6handleEP17_EXCEPTION_RECORDPvP8_CONTEXTP19_DISPATCHER=
_CONTEXT,      \
+      .seh_handler "                                                     \
+       EXCEPTION_HANDLE_REF ",   \
        @except                                                         \n\
       .seh_handlerdata                                                 \n\
       .long 1                                                          \n\
--
2.53.0.windows.2

[PATCH 2/2] Cygwin: Add SEH workaround for aarch64 compilation

 winsup/cygwin/exceptions.cc              |  2 ++
 winsup/cygwin/local_includes/cygtls.h    | 17 ++++++++++-------
 winsup/cygwin/local_includes/exception.h | 23 +++++++++++++----------
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 158d8675b..badb11da7 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1696,6 +1696,7 @@ done:

 }

+#if defined(__x86_64__) || defined(__aarch64__)
 static void
 altstack_wrapper (int sig, siginfo_t *siginfo, ucontext_t *sigctx,
                  void (*handler) (int, siginfo_t *, void *))
@@ -1746,6 +1747,7 @@ altstack_wrapper (int sig, siginfo_t *siginfo, uconte=
xt_t *sigctx,
        teb->Tib.StackLimit =3D old_limit;
     }
 }
+#endif

 int
 _cygtls::call_signal_handler ()
diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_in=
cludes/cygtls.h
index 336c72a06..a07e143c7 100644
--- a/winsup/cygwin/local_includes/cygtls.h
+++ b/winsup/cygwin/local_includes/cygtls.h
@@ -346,8 +346,17 @@ public:

 #if defined (__aarch64__)
 #define EXCEPTION_MYFAULT_REF "_ZN9exception7myfaultEP17_EXCEPTION_RECORDP=
vP8_CONTEXTP25_DISPATCHER_CONTEXT_ARM64"
+#define TRY_HANDLER_DATA (void) &&__l_try;
 #else
 #define EXCEPTION_MYFAULT_REF "_ZN9exception7myfaultEP17_EXCEPTION_RECORDP=
vP8_CONTEXTP19_DISPATCHER_CONTEXT"
+#define TRY_HANDLER_DATA \
+  __asm__ goto ("\n" \
+  "  .seh_handler " EXCEPTION_MYFAULT_REF ", @except                   \n"=
 \
+  "  .seh_handlerdata                                                  \n"=
 \
+  "  .long 1                                                           \n"=
 \
+  "  .rva %l[__l_try],%l[__l_endtry],%l[__l_except],%l[__l_except]     \n"=
 \
+  "  .seh_code                                                         \n"=
 \
+  : : : : __l_try, __l_endtry, __l_except)
 #endif

 /* Exception handling macros. This is a handmade SEH try/except. */
@@ -357,13 +366,7 @@ public:
     __label__ __l_try, __l_except, __l_endtry; \
     __mem_barrier; \
     san __sebastian (&&__l_except); \
-    __asm__ goto ("\n" \
-      "  .seh_handler " EXCEPTION_MYFAULT_REF ", @except                  =
                             \n" \
-      "  .seh_handlerdata                                              \n"=
 \
-      "  .long 1                                                       \n"=
 \
-      "  .rva %l[__l_try],%l[__l_endtry],%l[__l_except],%l[__l_except] \n"=
 \
-      "  .seh_code                                                     \n"=
 \
-      : : : : __l_try, __l_endtry, __l_except); \
+    TRY_HANDLER_DATA; \
     { \
       __l_try: \
        __mem_barrier;
diff --git a/winsup/cygwin/local_includes/exception.h b/winsup/cygwin/local=
_includes/exception.h
index 19bb109de..b26f8ba17 100644
--- a/winsup/cygwin/local_includes/exception.h
+++ b/winsup/cygwin/local_includes/exception.h
@@ -10,8 +10,19 @@ details. */

 #if defined (__aarch64__)
 #define EXCEPTION_HANDLE_REF "_ZN9exception6handleEP17_EXCEPTION_RECORDPvP=
8_CONTEXTP25_DISPATCHER_CONTEXT_ARM64"
- #else
+#define EXCEPTION_HANDLER_DATA
+#else
 #define EXCEPTION_HANDLE_REF "_ZN9exception6handleEP17_EXCEPTION_RECORDPvP=
8_CONTEXTP19_DISPATCHER_CONTEXT"
+#define EXCEPTION_HANDLER_DATA \
+  asm volatile ("\n\
+  1:                                                                   \n\
+    .seh_handler "                                                       \
+      EXCEPTION_HANDLE_REF ",                                            \
+      @except                                                          \n\
+    .seh_handlerdata                                                   \n\
+    .long 1                                                            \n\
+    .rva 1b, 2f, 2f, 2f                                                   =
     \n\
+    .seh_code                                                          \n")
 #endif

 class exception
@@ -24,15 +35,7 @@ public:
   exception () __attribute__ ((always_inline))
   {
     /* Install SEH handler. */
-    asm volatile ("\n\
-    1:                                                                 \n\
-      .seh_handler "                                                     \
-       EXCEPTION_HANDLE_REF ",   \
-       @except                                                         \n\
-      .seh_handlerdata                                                 \n\
-      .long 1                                                          \n\
-      .rva 1b, 2f, 2f, 2f                                              \n\
-      .seh_code                                                           =
     \n");
+    EXCEPTION_HANDLER_DATA;
   };
   ~exception () __attribute__ ((always_inline))
   {




--_000_MA0P287MB3082CAC457D335E3325522CD9F48AMA0P287MB3082INDP_--

--_005_MA0P287MB3082CAC457D335E3325522CD9F48AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-Add-ARM64-support-for-SEH-handler-symbol-refe.patch"
Content-Description:
 0001-Cygwin-Add-ARM64-support-for-SEH-handler-symbol-refe.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-Add-ARM64-support-for-SEH-handler-symbol-refe.patch";
	size=2952; creation-date="Tue, 24 Mar 2026 12:31:08 GMT";
	modification-date="Tue, 24 Mar 2026 12:42:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzOWU5MWVkZTk5MmRhYzkyMjM0YjFiZTA3Njc5NzQ4YzQ3ODI1MmQ4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogVHVlLCAyNCBNYXIgMjAyNiAxNzo1MDowMSArMDUz
MApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBDeWd3aW46IEFkZCBBUk02NCBzdXBw
b3J0IGZvciBTRUggaGFuZGxlciBzeW1ib2wKIHJlZmVyZW5jZXMKCkludHJv
ZHVjZXMgY29uZGl0aW9uYWwgc3ltYm9sIHJlZmVyZW5jZXMgZm9yIHN0cnVj
dHVyZWQgZXhjZXB0aW9uIGhhbmRsaW5nCnRvIHN1cHBvcnQgQVJNNjQgYXJj
aGl0ZWN0dXJlLiBFbnN1cmVzIGNvcnJlY3QgaGFuZGxlciBzeW1ib2wgbmFt
ZXMgYXJlCnVzZWQgYmFzZWQgb24gdGhlIHRhcmdldCBwbGF0Zm9ybS4KClNp
Z25lZC1vZmYtYnk6IEV2Z2VueSBLYXJwb3YgPEV2Z2VueS5LYXJwb3ZAbWlj
cm9zb2Z0LmNvbT4KU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGlu
Z2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5j
b20+Ci0tLQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMu
aCAgICB8ICA4ICsrKysrKystCiB3aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1
ZGVzL2V4Y2VwdGlvbi5oIHwgMTEgKysrKysrKystLS0KIDIgZmlsZXMgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5o
IGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaAppbmRl
eCA5ZjgzYzEzNGMuLjMzNmM3MmEwNiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5
Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaAorKysgYi93aW5zdXAvY3ln
d2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oCkBAIC0zNDQsNiArMzQ0LDEy
IEBAIHB1YmxpYzoKICAgdm9pZCBsZWF2ZSAoKSBfX2F0dHJpYnV0ZV9fICgo
cmV0dXJuc190d2ljZSkpOwogfTsKIAorI2lmIGRlZmluZWQgKF9fYWFyY2g2
NF9fKQorI2RlZmluZSBFWENFUFRJT05fTVlGQVVMVF9SRUYgIl9aTjlleGNl
cHRpb243bXlmYXVsdEVQMTdfRVhDRVBUSU9OX1JFQ09SRFB2UDhfQ09OVEVY
VFAyNV9ESVNQQVRDSEVSX0NPTlRFWFRfQVJNNjQiCisjZWxzZQorI2RlZmlu
ZSBFWENFUFRJT05fTVlGQVVMVF9SRUYgIl9aTjlleGNlcHRpb243bXlmYXVs
dEVQMTdfRVhDRVBUSU9OX1JFQ09SRFB2UDhfQ09OVEVYVFAxOV9ESVNQQVRD
SEVSX0NPTlRFWFQiCisjZW5kaWYKKwogLyogRXhjZXB0aW9uIGhhbmRsaW5n
IG1hY3Jvcy4gVGhpcyBpcyBhIGhhbmRtYWRlIFNFSCB0cnkvZXhjZXB0LiAq
LwogI2RlZmluZSBfX21lbV9iYXJyaWVyCV9fYXNtX18gX192b2xhdGlsZV9f
ICgiIiA6OjogIm1lbW9yeSIpCiAjZGVmaW5lIF9fdHJ5IFwKQEAgLTM1Miw3
ICszNTgsNyBAQCBwdWJsaWM6CiAgICAgX19tZW1fYmFycmllcjsgXAogICAg
IHNhbiBfX3NlYmFzdGlhbiAoJiZfX2xfZXhjZXB0KTsgXAogICAgIF9fYXNt
X18gZ290byAoIlxuIiBcCi0gICAgICAiICAuc2VoX2hhbmRsZXIgX1pOOWV4
Y2VwdGlvbjdteWZhdWx0RVAxN19FWENFUFRJT05fUkVDT1JEUHZQOF9DT05U
RVhUUDE5X0RJU1BBVENIRVJfQ09OVEVYVCwgQGV4Y2VwdAkJCQkJCVxuIiBc
CisgICAgICAiICAuc2VoX2hhbmRsZXIgIiBFWENFUFRJT05fTVlGQVVMVF9S
RUYgIiwgQGV4Y2VwdAkJCQkJCVxuIiBcCiAgICAgICAiICAuc2VoX2hhbmRs
ZXJkYXRhCQkJCQkJXG4iIFwKICAgICAgICIgIC5sb25nIDEJCQkJCQkJXG4i
IFwKICAgICAgICIgIC5ydmEgJWxbX19sX3RyeV0sJWxbX19sX2VuZHRyeV0s
JWxbX19sX2V4Y2VwdF0sJWxbX19sX2V4Y2VwdF0JXG4iIFwKZGlmZiAtLWdp
dCBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvZXhjZXB0aW9uLmgg
Yi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2V4Y2VwdGlvbi5oCmlu
ZGV4IDEzMTU5ZDE3Yi4uMTliYjEwOWRlIDEwMDY0NAotLS0gYS93aW5zdXAv
Y3lnd2luL2xvY2FsX2luY2x1ZGVzL2V4Y2VwdGlvbi5oCisrKyBiL3dpbnN1
cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvZXhjZXB0aW9uLmgKQEAgLTcsNyAr
NywxMiBAQCBkZXRhaWxzLiAqLwogI3ByYWdtYSBvbmNlCiAKICNkZWZpbmUg
ZXhjZXB0aW9uX2xpc3Qgdm9pZAotdHlwZWRlZiBzdHJ1Y3QgX0RJU1BBVENI
RVJfQ09OVEVYVCAqUERJU1BBVENIRVJfQ09OVEVYVDsKKworI2lmIGRlZmlu
ZWQgKF9fYWFyY2g2NF9fKQorI2RlZmluZSBFWENFUFRJT05fSEFORExFX1JF
RiAiX1pOOWV4Y2VwdGlvbjZoYW5kbGVFUDE3X0VYQ0VQVElPTl9SRUNPUkRQ
dlA4X0NPTlRFWFRQMjVfRElTUEFUQ0hFUl9DT05URVhUX0FSTTY0IgorICNl
bHNlCisjZGVmaW5lIEVYQ0VQVElPTl9IQU5ETEVfUkVGICJfWk45ZXhjZXB0
aW9uNmhhbmRsZUVQMTdfRVhDRVBUSU9OX1JFQ09SRFB2UDhfQ09OVEVYVFAx
OV9ESVNQQVRDSEVSX0NPTlRFWFQiCisjZW5kaWYKIAogY2xhc3MgZXhjZXB0
aW9uCiB7CkBAIC0yMSw4ICsyNiw4IEBAIHB1YmxpYzoKICAgICAvKiBJbnN0
YWxsIFNFSCBoYW5kbGVyLiAqLwogICAgIGFzbSB2b2xhdGlsZSAoIlxuXAog
ICAgIDE6CQkJCQkJCQkJXG5cCi0gICAgICAuc2VoX2hhbmRsZXIJCQkJCQkJ
ICBcCi0JX1pOOWV4Y2VwdGlvbjZoYW5kbGVFUDE3X0VYQ0VQVElPTl9SRUNP
UkRQdlA4X0NPTlRFWFRQMTlfRElTUEFUQ0hFUl9DT05URVhULAkgIFwKKyAg
ICAgIC5zZWhfaGFuZGxlciAiCQkJCQkJCSAgXAorCUVYQ0VQVElPTl9IQU5E
TEVfUkVGICIsCSAgXAogCUBleGNlcHQJCQkJCQkJCVxuXAogICAgICAgLnNl
aF9oYW5kbGVyZGF0YQkJCQkJCQlcblwKICAgICAgIC5sb25nIDEJCQkJCQkJ
CVxuXAotLSAKMi41My4wLndpbmRvd3MuMgoK

--_005_MA0P287MB3082CAC457D335E3325522CD9F48AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0002-Cygwin-Add-SEH-workaround-for-aarch64-compilation.patch"
Content-Description:
 0002-Cygwin-Add-SEH-workaround-for-aarch64-compilation.patch
Content-Disposition: attachment;
	filename="0002-Cygwin-Add-SEH-workaround-for-aarch64-compilation.patch";
	size=4028; creation-date="Tue, 24 Mar 2026 12:34:32 GMT";
	modification-date="Tue, 24 Mar 2026 12:42:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3NmUwYzMzOGVkY2I4NGYyMWI0N2VmMDI4YjBjOWJhZWNmOWE4NjE5
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogVHVlLCAyNCBNYXIgMjAyNiAxNzo1MTo1NSArMDUz
MApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBDeWd3aW46IEFkZCBTRUggd29ya2Fy
b3VuZCBmb3IgYWFyY2g2NCBjb21waWxhdGlvbgoKU2lnbmVkLW9mZi1ieTog
RXZnZW55IEthcnBvdiA8RXZnZW55LkthcnBvdkBtaWNyb3NvZnQuY29tPgpT
aWduZWQtb2ZmLWJ5OiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFs
YWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KLS0tCiB3aW5z
dXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MgICAgICAgICAgICAgIHwgIDIgKysK
IHdpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmggICAgfCAx
NyArKysrKysrKysrLS0tLS0tLQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNs
dWRlcy9leGNlcHRpb24uaCB8IDIzICsrKysrKysrKysrKystLS0tLS0tLS0t
CiAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE3IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9u
cy5jYyBiL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYwppbmRleCAxNThk
ODY3NWIuLmJhZGIxMWRhNyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9l
eGNlcHRpb25zLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5j
YwpAQCAtMTY5Niw2ICsxNjk2LDcgQEAgZG9uZToKCiB9CgorI2lmIGRlZmlu
ZWQoX194ODZfNjRfXykgfHwgZGVmaW5lZChfX2FhcmNoNjRfXykKIHN0YXRp
YyB2b2lkCiBhbHRzdGFja193cmFwcGVyIChpbnQgc2lnLCBzaWdpbmZvX3Qg
KnNpZ2luZm8sIHVjb250ZXh0X3QgKnNpZ2N0eCwKIAkJICB2b2lkICgqaGFu
ZGxlcikgKGludCwgc2lnaW5mb190ICosIHZvaWQgKikpCkBAIC0xNzQ2LDYg
KzE3NDcsNyBAQCBhbHRzdGFja193cmFwcGVyIChpbnQgc2lnLCBzaWdpbmZv
X3QgKnNpZ2luZm8sIHVjb250ZXh0X3QgKnNpZ2N0eCwKIAl0ZWItPlRpYi5T
dGFja0xpbWl0ID0gb2xkX2xpbWl0OwogICAgIH0KIH0KKyNlbmRpZgoKIGlu
dAogX2N5Z3Rsczo6Y2FsbF9zaWduYWxfaGFuZGxlciAoKQpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaCBiL3dp
bnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvY3lndGxzLmgKaW5kZXggMzM2
YzcyYTA2Li5hMDdlMTQzYzcgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4v
bG9jYWxfaW5jbHVkZXMvY3lndGxzLmgKKysrIGIvd2luc3VwL2N5Z3dpbi9s
b2NhbF9pbmNsdWRlcy9jeWd0bHMuaApAQCAtMzQ2LDggKzM0NiwxNyBAQCBw
dWJsaWM6CgogI2lmIGRlZmluZWQgKF9fYWFyY2g2NF9fKQogI2RlZmluZSBF
WENFUFRJT05fTVlGQVVMVF9SRUYgIl9aTjlleGNlcHRpb243bXlmYXVsdEVQ
MTdfRVhDRVBUSU9OX1JFQ09SRFB2UDhfQ09OVEVYVFAyNV9ESVNQQVRDSEVS
X0NPTlRFWFRfQVJNNjQiCisjZGVmaW5lIFRSWV9IQU5ETEVSX0RBVEEgKHZv
aWQpICYmX19sX3RyeTsKICNlbHNlCiAjZGVmaW5lIEVYQ0VQVElPTl9NWUZB
VUxUX1JFRiAiX1pOOWV4Y2VwdGlvbjdteWZhdWx0RVAxN19FWENFUFRJT05f
UkVDT1JEUHZQOF9DT05URVhUUDE5X0RJU1BBVENIRVJfQ09OVEVYVCIKKyNk
ZWZpbmUgVFJZX0hBTkRMRVJfREFUQSBcCisgIF9fYXNtX18gZ290byAoIlxu
IiBcCisgICIgIC5zZWhfaGFuZGxlciAiIEVYQ0VQVElPTl9NWUZBVUxUX1JF
RiAiLCBAZXhjZXB0CQkJXG4iIFwKKyAgIiAgLnNlaF9oYW5kbGVyZGF0YQkJ
CQkJCQlcbiIgXAorICAiICAubG9uZyAxCQkJCQkJCQlcbiIgXAorICAiICAu
cnZhICVsW19fbF90cnldLCVsW19fbF9lbmR0cnldLCVsW19fbF9leGNlcHRd
LCVsW19fbF9leGNlcHRdCVxuIiBcCisgICIgIC5zZWhfY29kZQkJCQkJCQkJ
XG4iIFwKKyAgOiA6IDogOiBfX2xfdHJ5LCBfX2xfZW5kdHJ5LCBfX2xfZXhj
ZXB0KQogI2VuZGlmCgogLyogRXhjZXB0aW9uIGhhbmRsaW5nIG1hY3Jvcy4g
VGhpcyBpcyBhIGhhbmRtYWRlIFNFSCB0cnkvZXhjZXB0LiAqLwpAQCAtMzU3
LDEzICszNjYsNyBAQCBwdWJsaWM6CiAgICAgX19sYWJlbF9fIF9fbF90cnks
IF9fbF9leGNlcHQsIF9fbF9lbmR0cnk7IFwKICAgICBfX21lbV9iYXJyaWVy
OyBcCiAgICAgc2FuIF9fc2ViYXN0aWFuICgmJl9fbF9leGNlcHQpOyBcCi0g
ICAgX19hc21fXyBnb3RvICgiXG4iIFwKLSAgICAgICIgIC5zZWhfaGFuZGxl
ciAiIEVYQ0VQVElPTl9NWUZBVUxUX1JFRiAiLCBAZXhjZXB0CQkJCQkJXG4i
IFwKLSAgICAgICIgIC5zZWhfaGFuZGxlcmRhdGEJCQkJCQlcbiIgXAotICAg
ICAgIiAgLmxvbmcgMQkJCQkJCQlcbiIgXAotICAgICAgIiAgLnJ2YSAlbFtf
X2xfdHJ5XSwlbFtfX2xfZW5kdHJ5XSwlbFtfX2xfZXhjZXB0XSwlbFtfX2xf
ZXhjZXB0XQlcbiIgXAotICAgICAgIiAgLnNlaF9jb2RlCQkJCQkJCVxuIiBc
Ci0gICAgICA6IDogOiA6IF9fbF90cnksIF9fbF9lbmR0cnksIF9fbF9leGNl
cHQpOyBcCisgICAgVFJZX0hBTkRMRVJfREFUQTsgXAogICAgIHsgXAogICAg
ICAgX19sX3RyeTogXAogCV9fbWVtX2JhcnJpZXI7CmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2V4Y2VwdGlvbi5oIGIvd2lu
c3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9leGNlcHRpb24uaAppbmRleCAx
OWJiMTA5ZGUuLmIyNmY4YmExNyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dp
bi9sb2NhbF9pbmNsdWRlcy9leGNlcHRpb24uaAorKysgYi93aW5zdXAvY3ln
d2luL2xvY2FsX2luY2x1ZGVzL2V4Y2VwdGlvbi5oCkBAIC0xMCw4ICsxMCwx
OSBAQCBkZXRhaWxzLiAqLwoKICNpZiBkZWZpbmVkIChfX2FhcmNoNjRfXykK
ICNkZWZpbmUgRVhDRVBUSU9OX0hBTkRMRV9SRUYgIl9aTjlleGNlcHRpb242
aGFuZGxlRVAxN19FWENFUFRJT05fUkVDT1JEUHZQOF9DT05URVhUUDI1X0RJ
U1BBVENIRVJfQ09OVEVYVF9BUk02NCIKLSAjZWxzZQorI2RlZmluZSBFWENF
UFRJT05fSEFORExFUl9EQVRBCisjZWxzZQogI2RlZmluZSBFWENFUFRJT05f
SEFORExFX1JFRiAiX1pOOWV4Y2VwdGlvbjZoYW5kbGVFUDE3X0VYQ0VQVElP
Tl9SRUNPUkRQdlA4X0NPTlRFWFRQMTlfRElTUEFUQ0hFUl9DT05URVhUIgor
I2RlZmluZSBFWENFUFRJT05fSEFORExFUl9EQVRBIFwKKyAgYXNtIHZvbGF0
aWxlICgiXG5cCisgIDE6CQkJCQkJCQkJXG5cCisgICAgLnNlaF9oYW5kbGVy
ICIJCQkJCQkJICBcCisgICAgICBFWENFUFRJT05fSEFORExFX1JFRiAiLAkJ
CQkJCSAgXAorICAgICAgQGV4Y2VwdAkJCQkJCQkJXG5cCisgICAgLnNlaF9o
YW5kbGVyZGF0YQkJCQkJCQlcblwKKyAgICAubG9uZyAxCQkJCQkJCQlcblwK
KyAgICAucnZhIDFiLCAyZiwgMmYsIDJmCQkJCQkJCVxuXAorICAgIC5zZWhf
Y29kZQkJCQkJCQkJXG4iKQogI2VuZGlmCgogY2xhc3MgZXhjZXB0aW9uCkBA
IC0yNCwxNSArMzUsNyBAQCBwdWJsaWM6CiAgIGV4Y2VwdGlvbiAoKSBfX2F0
dHJpYnV0ZV9fICgoYWx3YXlzX2lubGluZSkpCiAgIHsKICAgICAvKiBJbnN0
YWxsIFNFSCBoYW5kbGVyLiAqLwotICAgIGFzbSB2b2xhdGlsZSAoIlxuXAot
ICAgIDE6CQkJCQkJCQkJXG5cCi0gICAgICAuc2VoX2hhbmRsZXIgIgkJCQkJ
CQkgIFwKLQlFWENFUFRJT05fSEFORExFX1JFRiAiLAkgIFwKLQlAZXhjZXB0
CQkJCQkJCQlcblwKLSAgICAgIC5zZWhfaGFuZGxlcmRhdGEJCQkJCQkJXG5c
Ci0gICAgICAubG9uZyAxCQkJCQkJCQlcblwKLSAgICAgIC5ydmEgMWIsIDJm
LCAyZiwgMmYJCQkJCQlcblwKLSAgICAgIC5zZWhfY29kZQkJCQkJCQkJXG4i
KTsKKyAgICBFWENFUFRJT05fSEFORExFUl9EQVRBOwogICB9OwogICB+ZXhj
ZXB0aW9uICgpIF9fYXR0cmlidXRlX18gKChhbHdheXNfaW5saW5lKSkKICAg
ewotLQoyLjUzLjAud2luZG93cy4yCgo=

--_005_MA0P287MB3082CAC457D335E3325522CD9F48AMA0P287MB3082INDP_--

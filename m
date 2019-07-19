Return-Path: <cygwin-patches-return-9493-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12002 invoked by alias); 19 Jul 2019 18:27:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11993 invoked by uid 89); 19 Jul 2019 18:27:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1902
X-HELO: NAM05-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr710118.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) (40.107.71.118) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jul 2019 18:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=mQ5+dPsmLLadSKJnaOVEbRZGhTTyjIIArz0Mzcu/lAJvHN2R+0lJEOOW+Nj5AGt7Qp+S4SEuz50y59Q9mNk4Oknpmai3rn0hW+f++ebuCE2zcKy0dG7e/Egp6pBvz4nwkg3taLolmHn0P/Ox9KmbvTbu5TMY6FQKlLU6DPjhs8Ipd/WXwqfNMHaAX5S4UUgqV/sGAcsALs4i/XKg4w/lT2J1M57IJgT3V0TPLkxvdIKCn1lUZHXMVQrWilEogoZ+5XhM7DKxjqlh+JMxF7G6GeUAxoWso6BaDaxcXm6DSVBDUhyHdgNsTmJRleZwl2tKlEL+NSCIXPyul0T80FHnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=gW0AfCRsSeCLZ1M4nYhdheXsHqoEAUG0O54qJmO0+G0=; b=DZDs2KQWFihSUsdjbv9fOJFaLeXDmiODriq7fkdMrs2DapWmztc2ep5zP/3SkcCYxDlM2PTdkHyDjgYaqV+b6S0NGiEIbBAWnERZ5xTet94jD0Qafvm+ZIR0Z7+s/HQi9c1jhE82Byi4MIjycAsYAKcvseRZzWkT6Q2uqA7Ol5C60zRDE1xNMplau7wba60NDHoW7CNJCzdbqyTSlSXvjsAjeGSQamZ2y8wRSLLDBePds6WzShF00eN4KrTZDhzCooAN7Q1Oadn6TKoRnkBoVMvtJVisxyUfH4X+IUIpTHETe2yYLewVirbDVR7RTPSoktyTnj2EnNUi3xW+xCAPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=gW0AfCRsSeCLZ1M4nYhdheXsHqoEAUG0O54qJmO0+G0=; b=TqIuRleVBcjX3uSNm15CxfVgx3m2MUz4svt9oV6zflz7e8cEK7LgLJE/aYXjoobDAD10oTNLqd38zC31tp42JXTjgRw94YFVclVmg86Mc6+3XinueDtYbx5W9Fg0IOQB7I7GZiwLj3gb5TXYNaa52o/pgwdP6LnPtB/4XGicIm8=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1SPR00MB264.namprd04.prod.outlook.com (10.167.9.148) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14; Fri, 19 Jul 2019 18:27:27 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.011; Fri, 19 Jul 2019 18:27:27 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: unbreak the build with GCC 7
Date: Fri, 19 Jul 2019 18:27:00 -0000
Message-ID: <20190719182710.34746-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6108;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00013.txt.bz2

The recent port to GCC 8 used the 'nonstring' attribute, which is
unknown to GCC 7.  Define and use an 'ATTRIBUTE_NONSTRING' macro
instead.
---
 winsup/cygwin/include/sys/utmp.h | 11 ++++++++---
 winsup/cygwin/uname.cc           |  8 +++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/include/sys/utmp.h b/winsup/cygwin/include/sys/u=
tmp.h
index acf804ad0..443c44252 100644
--- a/winsup/cygwin/include/sys/utmp.h
+++ b/winsup/cygwin/include/sys/utmp.h
@@ -19,16 +19,21 @@ extern "C" {
 #define ut_name		ut_user
 #endif
=20
+#if __GNUC__ >=3D 8
+#define ATTRIBUTE_NONSTRING __attribute__ ((nonstring))
+#else
+#define ATTRIBUTE_NONSTRING
+#endif
=20
 struct utmp
 {
  short	ut_type;
  pid_t	ut_pid;
- char	ut_line[UT_LINESIZE] __attribute__ ((nonstring));
+ char	ut_line[UT_LINESIZE] ATTRIBUTE_NONSTRING;
  char  ut_id[UT_IDLEN];
  time_t ut_time;
- char	ut_user[UT_NAMESIZE] __attribute__ ((nonstring));
- char	ut_host[UT_HOSTSIZE] __attribute__ ((nonstring));
+ char	ut_user[UT_NAMESIZE] ATTRIBUTE_NONSTRING;
+ char	ut_host[UT_HOSTSIZE] ATTRIBUTE_NONSTRING;
  long	ut_addr;
 };
=20
diff --git a/winsup/cygwin/uname.cc b/winsup/cygwin/uname.cc
index e323335b4..350216681 100644
--- a/winsup/cygwin/uname.cc
+++ b/winsup/cygwin/uname.cc
@@ -17,6 +17,12 @@ details. */
 extern "C" int cygwin_gethostname (char *__name, size_t __len);
 extern "C" int getdomainname (char *__name, size_t __len);
=20
+#if __GNUC__ >=3D 8
+#define ATTRIBUTE_NONSTRING __attribute__ ((nonstring))
+#else
+#define ATTRIBUTE_NONSTRING
+#endif
+
 /* uname: POSIX 4.4.1.1 */
=20
 /* New entrypoint for applications since API 335 */
@@ -25,7 +31,7 @@ uname_x (struct utsname *name)
 {
   __try
     {
-      char buf[NI_MAXHOST + 1] __attribute__ ((nonstring));
+      char buf[NI_MAXHOST + 1] ATTRIBUTE_NONSTRING;
       char *snp =3D strstr (cygwin_version.dll_build_date, "SNP");
=20
       memset (name, 0, sizeof (*name));
--=20
2.21.0

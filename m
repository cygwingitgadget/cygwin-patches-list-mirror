Return-Path: <cygwin-patches-return-9484-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104635 invoked by alias); 16 Jul 2019 17:34:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104577 invoked by uid 89); 16 Jul 2019 17:34:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820093.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jul 2019 17:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=PqVWOgeOQpXzVDcyPRnlHZu7oDvRp5yo0hurHDSn5L6+PQ+aQQwoEiFUo4PI65Z6fH4DKuNCJgixvLPVjjnuBj8HZPxOaUKuCXmlrqs4ZU9d0CDHTdijOwYCHBLQAH3RX+PmmIfG5pHFdJyPGCmesbV8Q8F/60+Ub2oPBxMvAeqV70Sxp+JfgMD29CdIf3bWMu8vzgecCuWZ4pEerFTmoi0vjtlRMaPct+ZgBrLCSe6S5LX7tiN/Y/okMQ6J5iZgonzbJWmU+x/dfVypWpeM9EbcZQLRAM6B/J3yZLiLHsdpPIgS3b6V0uJ1fopixxZLQ1SScjnf0yIV1chHiVKpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=i0zX8aHsmW5yXYyFuvpTfhLMD5LuFUUdCVOl3Gfi2pg=; b=mUWThgAkQtaB1FxOuSaZhtE8XsKVFI6a1ssM2qLci7YcI0KcvOTwWj9wKpY60oOYMk8l36/j1YwWq2Qa9AitYYGmI6XEmjUp97DxJKVOW0k/SQaAPbaSdnqq0s6WK/ONcGTckmp5/6Urxy4/Z8ysayVkl+Hg8xNkE3rsTbSSjAm9ZqFC3w6IG+PdoR+FxZbEyQ0VpYT4NKBrFN4hBUn31LT0n4qYR4PVU5ehSPVMd5coc4XU7R82jt2vUd/QlbGxYSu0VS09OfS79b76m0UjsrtF2/5dWRywTimas4LTiF2GF/kMYzj80lYUNNebP+wrDpLU2lcDLuniWAXB5hN2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=i0zX8aHsmW5yXYyFuvpTfhLMD5LuFUUdCVOl3Gfi2pg=; b=UqAEmmu/0A2yiPjQZ1IJy60VdOPQR6rgdq++7GNV+b8VIR8cMwDb0nGhy2VjA9Eq0mv6iosNi+6HyYtEYV3gqX8jnEo5xOr+57EVTHx+hmS7I4j5v5ozHa7Zsoyqjdcx8P/OS+iZFjxruaCOku85QZ5s+stGeIrrAne1fxkwfq0=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2234.namprd04.prod.outlook.com (10.167.16.18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Tue, 16 Jul 2019 17:34:25 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019 17:34:25 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 2/5] Cygwin: avoid GCC 8.3 errors with -Werror=stringop-truncation
Date: Tue, 16 Jul 2019 17:34:00 -0000
Message-ID: <20190716173407.17040-3-kbrown@cornell.edu>
References: <20190716173407.17040-1-kbrown@cornell.edu>
In-Reply-To: <20190716173407.17040-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:1051;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00004.txt.bz2

---
 winsup/cygwin/environ.cc         | 2 +-
 winsup/cygwin/include/sys/utmp.h | 6 +++---
 winsup/cygwin/uname.cc           | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index a47ed72e7..124842734 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -644,7 +644,7 @@ _addenv (const char *name, const char *value, int overw=
rite)
 	return -1;		/* Oops.  No more memory. */
=20
       /* Put name '=3D' value into current slot. */
-      strncpy (envhere, name, namelen);
+      memcpy (envhere, name, namelen);
       envhere[namelen] =3D '=3D';
       strcpy (envhere + namelen + 1, value);
     }
diff --git a/winsup/cygwin/include/sys/utmp.h b/winsup/cygwin/include/sys/u=
tmp.h
index d90517cdd..acf804ad0 100644
--- a/winsup/cygwin/include/sys/utmp.h
+++ b/winsup/cygwin/include/sys/utmp.h
@@ -24,11 +24,11 @@ struct utmp
 {
  short	ut_type;
  pid_t	ut_pid;
- char	ut_line[UT_LINESIZE];
+ char	ut_line[UT_LINESIZE] __attribute__ ((nonstring));
  char  ut_id[UT_IDLEN];
  time_t ut_time;
- char	ut_user[UT_NAMESIZE];
- char	ut_host[UT_HOSTSIZE];
+ char	ut_user[UT_NAMESIZE] __attribute__ ((nonstring));
+ char	ut_host[UT_HOSTSIZE] __attribute__ ((nonstring));
  long	ut_addr;
 };
=20
diff --git a/winsup/cygwin/uname.cc b/winsup/cygwin/uname.cc
index 306cdee4a..e323335b4 100644
--- a/winsup/cygwin/uname.cc
+++ b/winsup/cygwin/uname.cc
@@ -25,7 +25,7 @@ uname_x (struct utsname *name)
 {
   __try
     {
-      char buf[NI_MAXHOST + 1];
+      char buf[NI_MAXHOST + 1] __attribute__ ((nonstring));
       char *snp =3D strstr (cygwin_version.dll_build_date, "SNP");
=20
       memset (name, 0, sizeof (*name));
--=20
2.21.0

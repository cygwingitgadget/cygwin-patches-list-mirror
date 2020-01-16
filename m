Return-Path: <cygwin-patches-return-9939-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39009 invoked by alias); 16 Jan 2020 18:34:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39000 invoked by uid 89); 16 Jan 2020 18:34:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*r:408, HX-Languages-Length:4228, editions
X-HELO: NAM11-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam11on2130.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) (40.107.236.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Jan 2020 18:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=ZkeEI3XOFncGjsTJ5T5Q2FOZ3L3u4A7YIZjShaSAl0dqD9SSzjj1cY04BILiUWJs37rEF9nnOZSAnkS997bJgU39KAscPhPhHyUsD+mPn+qOD/7gvZaTtTfDd/gslifaoX2lvOF3wg8jfmDquB1/KlyQKli2ltsAnXWxUW2jqpi6RdmCkyAHLdKmtKey3VU9t+qEFUvnCJOSKt/82vpmoQkHtZIeIz1pPvmD2IwZKYgVdb4W9QBs1DY2zOVHQinZmr7Hgq5hlGq+BlSrfZLluyNX/cHCUX0B/e4yKfwZibKoDI5sqdTkDBxtCS14jHo8zHwJXKdAtHcVcU21SMZm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=5w+1iAKgf8ViM2rweIEmyYB2uLEnTTfXt2KObjiaAzM=; b=nd+WIFA7HuHRxSQQOKB4PMvBG4rKn/0QDYb0flIZj8BIZyvM6hT47G1pB0o4YNMryL+PXjy2SnUqdPvMJVdkC34SdWyzt4Lp778TpS3yMQMWh9aysRqgFu53aKeQHuYtQvxJjJ0X/BdIpVaWY9YLMgN69ZCjzmi/OlEn1GbMid5brz0sNxkNbTaVOWGe3vKfJ/nO/xAjjU7jT14vEc4tLaAaijEmdHQs7MTXzPiNdzuJvrQ2lPkAVDG0CGAUyGWKeQQersLlSMSNOE0ybvW/PFCdaI86shBmDo5oD2rbWTxNwxvBbkkRC8+4Qaags/AbqHIRYxBSerx8Qu/vc7ohVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=5w+1iAKgf8ViM2rweIEmyYB2uLEnTTfXt2KObjiaAzM=; b=YKsTy0bufGRBBZmw6vSvxlVmujGD4VBG3nXER6sihYD3ACqIk7LKGqmBoyKPnNymNIpnuur47Df7haM1wJLwLjXwThPvUNIrlGo2Q+H6XXoZlrCpLjFtvF0uRULK0eWVWSIB1WQBdNr0lLYWY/nZT2CkNuvezvCBn7EwCi4iKE4=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4889.namprd04.prod.outlook.com (20.176.113.93) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 16 Jan 2020 18:34:18 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020 18:34:18 +0000
Received: from localhost.localdomain (65.112.130.194) by BN8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:408:ac::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 18:34:17 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: allow opening an AF_LOCAL/AF_UNIX socket with O_PATH
Date: Thu, 16 Jan 2020 18:34:00 -0000
Message-ID: <20200116183355.1177-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:5797;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpSomFJ4xx6soWYmm1gBbbnDokhlWV+saZZMCj2rypk1RhORBk+utcz85SWt0i7PmZhsuiDjIvRX+4zmiowj8Q==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00045.txt

If that flag is not set, or if an attempt is made to open a different
type of socket, the errno is now EOPNOTSUPP instead of ENXIO.  This is
consistent with POSIX, starting with the 2016 edition.  Earlier
editions were silent on this issue.
---
 winsup/cygwin/fhandler.h               |  2 ++
 winsup/cygwin/fhandler_socket.cc       |  2 +-
 winsup/cygwin/fhandler_socket_local.cc | 16 ++++++++++++++++
 winsup/cygwin/fhandler_socket_unix.cc  | 16 ++++++++++++++++
 winsup/cygwin/release/3.1.3            |  7 +++++++
 winsup/doc/new-features.xml            |  6 ++++++
 6 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c0d56b4da..71b549d38 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -822,6 +822,7 @@ class fhandler_socket_local: public fhandler_socket_wso=
ck
   int getsockopt (int level, int optname, const void *optval,
 		  __socklen_t *optlen);
=20
+  int open (int flags, mode_t mode =3D 0);
   int __reg2 fstat (struct stat *buf);
   int __reg2 fstatvfs (struct statvfs *buf);
   int __reg1 fchmod (mode_t newmode);
@@ -1103,6 +1104,7 @@ class fhandler_socket_unix : public fhandler_socket
   virtual int ioctl (unsigned int cmd, void *);
   virtual int fcntl (int cmd, intptr_t);
=20
+  int open (int flags, mode_t mode =3D 0);
   int __reg2 fstat (struct stat *buf);
   int __reg2 fstatvfs (struct statvfs *buf);
   int __reg1 fchmod (mode_t newmode);
diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_sock=
et.cc
index 9f33d8087..227004b43 100644
--- a/winsup/cygwin/fhandler_socket.cc
+++ b/winsup/cygwin/fhandler_socket.cc
@@ -269,7 +269,7 @@ fhandler_socket::fcntl (int cmd, intptr_t arg)
 int
 fhandler_socket::open (int flags, mode_t mode)
 {
-  set_errno (ENXIO);
+  set_errno (EOPNOTSUPP);
   return 0;
 }
=20
diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandle=
r_socket_local.cc
index f88ced22d..dbca74702 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -634,6 +634,22 @@ fhandler_socket_local::dup (fhandler_base *child, int =
flags)
   return fhandler_socket_wsock::dup (child, flags);
 }
=20
+int
+fhandler_socket_local::open (int flags, mode_t mode)
+{
+  /* We don't support opening sockets unless O_PATH is specified. */
+  if (!(flags & O_PATH))
+    {
+      set_errno (EOPNOTSUPP);
+      return 0;
+    }
+
+  query_open (query_read_attributes);
+  nohandle (true);
+  set_flags (flags);
+  return 1;
+}
+
 int __reg2
 fhandler_socket_local::fstat (struct stat *buf)
 {
diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler=
_socket_unix.cc
index eea7e76b3..b3d4da49a 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -2296,6 +2296,22 @@ fhandler_socket_unix::fcntl (int cmd, intptr_t arg)
   return ret;
 }
=20
+int
+fhandler_socket_unix::open (int flags, mode_t mode)
+{
+  /* We don't support opening sockets unless O_PATH is specified. */
+  if (!(flags & O_PATH))
+    {
+      set_errno (EOPNOTSUPP);
+      return 0;
+    }
+
+  query_open (query_read_attributes);
+  nohandle (true);
+  set_flags (flags);
+  return 1;
+}
+
 int __reg2
 fhandler_socket_unix::fstat (struct stat *buf)
 {
diff --git a/winsup/cygwin/release/3.1.3 b/winsup/cygwin/release/3.1.3
index 489741136..af9e0f38e 100644
--- a/winsup/cygwin/release/3.1.3
+++ b/winsup/cygwin/release/3.1.3
@@ -1,3 +1,10 @@
+What's new:
+-----------
+
+- AF_LOCAL/AF_UNIX sockets can now be opened with the O_PATH flag.  If
+  that flag is not set, or if an attempt is made to open a different
+  type of socket, the errno is now EOPNOTSUPP instead of ENXIO.
+
 Bug Fixes
 ---------
=20
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 65bdc17ab..bf481bd04 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -54,6 +54,12 @@ Allow times(2) to have a NULL argument, as on Linux.
 Improve /proc/cpuinfo output and align more closely with Linux.
 </para></listitem>
=20
+<listitem><para>
+AF_LOCAL/AF_UNIX sockets can now be opened with the O_PATH flag.  If
+that flag is not set, or if an attempt is made to open a different
+type of socket, the errno is now EOPNOTSUPP instead of ENXIO.
+</para></listitem>
+
 </itemizedlist>
=20
 </sect2>
--=20
2.21.0

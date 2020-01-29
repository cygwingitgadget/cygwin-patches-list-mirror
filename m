Return-Path: <cygwin-patches-return-10028-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40084 invoked by alias); 29 Jan 2020 17:22:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39986 invoked by uid 89); 29 Jan 2020 17:22:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=*buf
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770104.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.104) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 17:22:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=M7PgesR8yNS4VMtSi92Suyh9bieC9y7rHBPNiMxkVUgiDxwbd0vMnvYE2+OKnoUNHSXgkZDa3S5oAjdQLF5C2jLu3yPxLvEDWwSBAiJM/Hghif/hQg+yB2sHd6C7qR7V+MSdOc2XTwg9GODm52fOOJJOGn9Zp/7XRZEDSwricxg6iMU/1cozTaQKqf2GpA+lfcVtnpTffcLsao6+WwV3NOhgvfHlFG8vykgW3s40VwRgjYQ8j6ECwos7hKejqppsGONp6kHmDv9BDRj9+B4oeZQsDpx5D47XBMlA7q3E2AnYad+GbdkWGqX7iFPZSiH5n7ESEKJPi1xasmqQjcW+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=0ppKmCcxvJm9jcrX74lbNtgtG4UosoIHVdZZvWHmoX0=; b=SNDLVaWJT380+cOj+AMo7SAoQkb7lgx5VHiV8ePamLEAoxFBZ8A2XaXUisnutSX9JY9iz26+HREaMqS3+I2do/wVeLydzyLuFuj+ikYUgRSTf1jZAfy1kfBy53UxnmZTD1D3trfgl9SVZz2LTXLw0bCi8cbdYH2CkppdnCojGx57F8RZH5erImDeRALZyscSZ+h9wfC1xyngSnSOme1rB8RFb9K53mKgweHZX/Y/xfY2O/tYiOJeaiz+8lbtdrmknYDQ4rt4dPXfthnBl++ZDj3yyVwsTYSqrVs+u3iUrgD1wdztOaL2E2CIlBkGMpMYBSeK41Zz47SgMWnAujl26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=0ppKmCcxvJm9jcrX74lbNtgtG4UosoIHVdZZvWHmoX0=; b=TNMljHaVL9RMHh8E6TcGSFAKTObKHm5hmXNPjPk/z7dNbM5UglUA2KIjirBqexUg/1XZEp0Arlgh7uj6/CbBN1tQKY9iXe8PbhQLoKOz5TBU11Fw8qZcRi6M+EtwyqeehN1/5ukYEojBgqHCVNIJDp/knpyk+VNHYztENpsYyj4=
Received: from BYAPR04MB5735.namprd04.prod.outlook.com (20.179.59.153) by BYAPR04MB5432.namprd04.prod.outlook.com (20.178.51.153) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Wed, 29 Jan 2020 17:22:10 +0000
Received: from BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399]) by BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020 17:22:10 +0000
Received: from localhost.localdomain (65.112.130.194) by BN7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:408:34::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 17:22:10 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 1/5] Cygwin: AF_LOCAL: allow opening with the O_PATH flag
Date: Wed, 29 Jan 2020 17:22:00 -0000
Message-ID: <20200129172147.1566-2-kbrown@cornell.edu>
References: <20200129172147.1566-1-kbrown@cornell.edu>
In-Reply-To: <20200129172147.1566-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:4125;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: ah7mJU9tYtd/Kr4fXyQOVlD8E5GcdkdmNqvHLbJgl/oLoBl6LpJOgIK4DyZ0P4A+F4FK9lq9HZg9swarxXzQ0cpJOmDlad4a9Lzn1wbWBfDZCIHr6SOk+xZ6qrlsBAdZUeguGgXX7PWHqHSWgctxYA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GewYDM/q0yo864y53GGL8RNd4IDbEMoZkjb5bc3pHtx4QKTyirN0vMXqJ4DHlM1uYVzE8hQ+Sz8N6h9AOqUOg==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00136.txt

If that flag is not set, or if an attempt is made to open a different
type of socket, the errno is now EOPNOTSUPP instead of ENXIO.  This is
consistent with POSIX, starting with the 2016 edition.  Earlier
editions were silent on this issue.

Opening is done in a (new) fhandler_socket_local::open method by
calling fhandler_base::open_fs.

Also add a corresponding fhandler_socket_local::close method.
---
 winsup/cygwin/fhandler.h               |  2 ++
 winsup/cygwin/fhandler_socket_local.cc | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 80a78d14c..c54780ef6 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -834,6 +834,8 @@ class fhandler_socket_local: public fhandler_socket_wso=
ck
   int getsockopt (int level, int optname, const void *optval,
 		  __socklen_t *optlen);
=20
+  int open (int flags, mode_t mode =3D 0);
+  int close ();
   int __reg2 fstat (struct stat *buf);
   int __reg2 fstatvfs (struct statvfs *buf);
   int __reg1 fchmod (mode_t newmode);
diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandle=
r_socket_local.cc
index f88ced22d..e7f4fe603 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -634,6 +634,26 @@ fhandler_socket_local::dup (fhandler_base *child, int =
flags)
   return fhandler_socket_wsock::dup (child, flags);
 }
=20
+int
+fhandler_socket_local::open (int flags, mode_t mode)
+{
+  /* We don't support opening sockets unless O_PATH is specified. */
+  if (flags & O_PATH)
+    return open_fs (flags, mode);
+
+  set_errno (EOPNOTSUPP);
+  return 0;
+}
+
+int
+fhandler_socket_local::close ()
+{
+  if (get_flags () & O_PATH)
+    return fhandler_base::close ();
+  else
+    return fhandler_socket_wsock::close ();
+}
+
 int __reg2
 fhandler_socket_local::fstat (struct stat *buf)
 {
--=20
2.21.0

Return-Path: <cygwin-patches-return-9507-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47593 invoked by alias); 22 Jul 2019 18:08:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47575 invoked by uid 89); 22 Jul 2019 18:08:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1590
X-HELO: NAM02-CY1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr760092.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) (40.107.76.92) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jul 2019 18:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=jljz68ze2fG9p9mdu4dUtO9kHgjlFQjjQcAfnmbe3LRMIIe+956XJfNuaIbha+BtKzbwTPbQK7OiJELtxRnczjN+1Cn1DiTFqkSbJpx07J2Rat5XV/XBP4zazt7XM5NHcQBOabaTYyD/DGOKAwdPdA3wVlCPGXbkk9nnYoRkSimstdTAHJn/tBZyna0WOcgLbYtICJnEy5oDoJRhI+LWRYumALdpg6Qrm4D3X5A+piscJLo0B7YWrmj2fGfAYu1j0FANrYK2G4uz3Bp+31c9aEMbfVbEWySGUPZb9HGizL9aRo8iftzLUItYfkn/WNz5ucTL0hh5Axw7pgAxsdkHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=lRIZ2F6KIg+8s/I7+GP+Ipru8KLxUCRk63LN8bVYlXI=; b=Is0SMSyyW+WrgesOUo+c/U6NiOT/tqtDRUhx3IRTOinxBNUGRh9f5KG8V69fRYK5HSNKyK0DXvySYK/TRXiMHrNBZ1GgVAIxRV37Q+hH9lkfzB/cJpfx17oFNIE1Eu8j8DmJ16AYblffYW1OueTEN+UjPDKz7jx489eEQbAh9XlE2ZxXsbHaRkHkOKIg8gTkUSLHRbYOcx32VHV4UhOnsYzfZlfVYeAACMyIprjxIhhhRQQR1uZcgIUkH2bCC/P/WHY3OhRY0RZIBTLim38Jx5slH8/XjrXgKQumoiMpJtMsOTFs9iiaVCa2jOXj7n3a6HRVWwX2ApNZYoClytL/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=lRIZ2F6KIg+8s/I7+GP+Ipru8KLxUCRk63LN8bVYlXI=; b=X/CRmbhtis4xVnRcM6l/gj3mUX40wBdhRFxKTIIfbEputrA3VLEH09yBU3gybrXXsXKw4EcAYKqvM3dVeQ4A0J7qlx99Wjk3NX1tSzJ2URLs03oCVdwtW+M60zQ52u0o79qNrp7LqolcYMrh5ONokWggDLbAppymPjl+wpRmDEg=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2042.namprd04.prod.outlook.com (10.166.191.136) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Mon, 22 Jul 2019 18:08:42 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.017; Mon, 22 Jul 2019 18:08:42 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: fix one more check for positive virtual_ftype_t values
Date: Mon, 22 Jul 2019 18:08:00 -0000
Message-ID: <20190722180825.15840-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:4125;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00027.txt.bz2

Also drop more comments referring to numerical virtual_ftype_t values.
---
 winsup/cygwin/fhandler_process.cc  | 3 ---
 winsup/cygwin/fhandler_registry.cc | 4 +---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_pro=
cess.cc
index 0dafc2f0f..2a0655475 100644
--- a/winsup/cygwin/fhandler_process.cc
+++ b/winsup/cygwin/fhandler_process.cc
@@ -86,9 +86,6 @@ static bool get_mem_values (DWORD dwProcessId, size_t &vm=
size, size_t &vmrss,
 			    size_t &vmtext, size_t &vmdata, size_t &vmlib,
 			    size_t &vmshare);
=20
-/* Returns 0 if path doesn't exist, >0 if path is a directory,
-   -1 if path is a file, -2 if path is a symlink, -3 if path is a pipe,
-   -4 if path is a socket. */
 virtual_ftype_t
 fhandler_process::exists ()
 {
diff --git a/winsup/cygwin/fhandler_registry.cc b/winsup/cygwin/fhandler_re=
gistry.cc
index f7db01b99..5fc03fedd 100644
--- a/winsup/cygwin/fhandler_registry.cc
+++ b/winsup/cygwin/fhandler_registry.cc
@@ -306,8 +306,6 @@ multi_wcstombs (char *dst, size_t len, const wchar_t *s=
rc, size_t nwc)
   return sum;
 }
=20
-/* Returns 0 if path doesn't exist, otherwise a virtual_ftype_t value
-   specifying the exact file type. */
 virtual_ftype_t
 fhandler_registry::exists ()
 {
@@ -562,7 +560,7 @@ fhandler_registry::fstat (struct stat *buf)
 		  buf->st_uid =3D uid;
 		  buf->st_gid =3D gid;
 		  buf->st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
-		  if (file_type > virt_none)
+		  if (virt_ftype_isdir (file_type))
 		    buf->st_mode |=3D S_IFDIR;
 		  else
 		    buf->st_mode &=3D NO_X;
--=20
2.21.0

Return-Path: <cygwin-patches-return-9886-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87253 invoked by alias); 29 Dec 2019 17:57:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87144 invoked by uid 89); 29 Dec 2019 17:57:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM12-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam12on2132.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) (40.107.244.132) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 29 Dec 2019 17:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=dGM1aZSXEkTQ6SjlHFSDPp48pkCp2EGJSsnK9m3J8MKVgq+g7hQLvthQuRZnK1a4bocvKoz8yuVN1B8InNoWO90FhfaDbSaPcr6NlWK34v+GlVzqkadq+PH9GjcuGdhqDSTJmM9cjC2Af1vaaxbWzUSyRQ6mNPvFWCji2cbAXR8GX8fdKuG8E2mNVdH1u8V9lAtSS7+xPQX26PLroEGHltMMEPo71ZCnNFI1+qT1r8tF19/HhUp/IxUMllJQ3KuegefPZtPs6Md506X4qxBP2/5UFV+ed1guWvqiwyyBP7bs0MZwjXoYKb9be0MEPkU+NgzBnVHkGxuL3+Sv43OZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=hrW+iTis3dhRWoNkd6xSIi6yonrQUAXFyfQRA8slrmw=; b=Kxoja8PX+jFsb4Xih2HhmtkI6GG80Nr4Si8lJWCjCkaZT2U3WEXB1+Y2Y9V2icq1w3aCFFMsHxSmreaOxKqxsuYycmXkthVcJidAibmYxT0NgevJbr0n1f99nzbov7Yt5MQCVTZah214FFJRcuRfGA1Uilz2ptLNuASLDrl+HlzP20I6sfz77j0mgLGCI6tAp4g3Oeyraqk94d4N62PVIb1V+GSrU/RkkYKtklMJJJXcogJjOl4dU9ucHGb1krDNwDLhTniTrWucBSu16qPAefISS9BTjpFnUyum1fguPndOMgZRmzqAP4m5xiTc1Qe6tEICnEX+MVyZI8mUTNCFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=hrW+iTis3dhRWoNkd6xSIi6yonrQUAXFyfQRA8slrmw=; b=FF7nBGZjEAm51leqmJw9Pge+XQTL4P+iuTIHfv71WetAJQhfZ5fakgHsH0kV6C3L4eVzB5H4+y51TYOcwqho9lH27K47+ylPfT2KtzjVRToEuu+D8llrmPF7KzvEIKSIf4mPpQ9moKELMHKULPLwGuRuCjzMvU3Eey1+aeAGWdE=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4345.namprd04.prod.outlook.com (20.176.76.21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Sun, 29 Dec 2019 17:56:58 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Sun, 29 Dec 2019 17:56:58 +0000
Received: from localhost.localdomain (68.175.129.7) by CH2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:610:51::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend Transport; Sun, 29 Dec 2019 17:56:57 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 2/3] Cygwin: readlinkat: allow pathname to be empty
Date: Sun, 29 Dec 2019 17:57:00 -0000
Message-ID: <20191229175637.1050-3-kbrown@cornell.edu>
References: <20191229175637.1050-1-kbrown@cornell.edu>
In-Reply-To: <20191229175637.1050-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7219;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcKZ2aa1VwNLJdbCsFo8wekD6jw0e21xrZkQnRSecS4qqtKYnq/d3UAMpcbSg/AQRda+bVnN5CGVJEE2wpBA3g==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00158.txt.bz2

Following Linux, allow the pathname argument to be an empty string,
provided the dirfd argument refers to a symlink opened with O_PATH and
O_NOFOLLOW.  The readlinkat call then operates on that symlink.
---
 winsup/cygwin/syscalls.cc | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 038a316db..2be8693c9 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4979,8 +4979,23 @@ readlinkat (int dirfd, const char *__restrict pathna=
me, char *__restrict buf,
   __try
     {
       char *path =3D tp.c_get ();
-      if (gen_full_path_at (path, dirfd, pathname))
-	__leave;
+      int res =3D gen_full_path_at (path, dirfd, pathname);
+      if (res)
+	{
+	  if (errno !=3D ENOENT)
+	    __leave;
+	  /* pathname is an empty string.  This is OK if dirfd refers
+	     to a symlink that was opened with O_PATH and O_NOFOLLOW.
+	     In this case, readlinkat operates on the symlink. */
+	  cygheap_fdget cfd (dirfd);
+	  if (cfd < 0)
+	    __leave;
+	  if (!(cfd->issymlink ()
+		&& cfd->get_flags () & O_PATH
+		&& cfd->get_flags () & O_NOFOLLOW))
+	    __leave;
+	  strcpy (path, cfd->get_name ());
+	}
       return readlink (path, buf, bufsize);
     }
   __except (EFAULT) {}
--=20
2.21.0

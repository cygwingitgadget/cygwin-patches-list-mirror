Return-Path: <cygwin-patches-return-9950-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47996 invoked by alias); 17 Jan 2020 16:11:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47985 invoked by uid 89); 17 Jan 2020 16:11:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690122.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Jan 2020 16:11:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=UWGC7keBvZ+1w4wMkPiliKzEy7wZTlr/Xw1G1+4h/yJScgQHbue8urPjUJ+xPORCLIYY4I++jFAfOrjedcx0ga8QL+CmhzdM+wPwfxSfB7OlkG4PD8GRebd/VXoQbJH8+up2EdYE14gbN1A1Sy/7PQCIfeU2KG5owv/2pjlP5+0WP5mE+fxMao9dorA1LLJbJbxUdT4SpvNJNzLyLDUsWkrK4FhsK3keojTNVxmD/3FQLDgBGJ8cL1XeTx5AUwA9rmT3TLsEoX0OMMg8sThmxEBTwZcoUgv8SO7z7QwldC6R+Q9saOw2aJ7YFoIu4Yn6yhdHqPBQpvja+NDeUYs/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=c1Ye97P8IHhvgEggFni4Qlmofg83gR+Ua/thOVGY+tU=; b=H6HkAkK3RDOgjVunHVfwdoayM1JWw3iZkkzcwvbKOxESOC90epoO56a/5UJXMvoIaVh2m2dcxMMLnVG/PR5rUSBFT48Er1Avk8KujJjkKjyt8h5RhJD4dLwAv0WjlGpbi1cru2f0Exxk5ODAaSHqHJjuRB4CcyxIYERg9R1ctXbe3/0OsPNm8W3PFnA/H4ugk/3EZxFuC4UtvcDxMNxEYWSOcKQn2YzbipjETyhRyujvBSUMHfZ5/BPeGkxG9mpWmtimlFdvipbJp6kcaQcCkIMzwQFcu36/EcsNavcPBv3mLLw/8fDrdRcg35wq62J2bfR1R+vjdNCmF8KMOnDpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=c1Ye97P8IHhvgEggFni4Qlmofg83gR+Ua/thOVGY+tU=; b=iM4s9LgQ5OUB6RKCjepIMOiBV/5GvT6+rfmAlgb9Cfv5wfasvorpKkoCJ5eijJM78pGyx5Ly2GsFT5Qg4Gidskqtt0AGSD4Ie4JEyyXgbC3UgQ61iLeO7uPpk2JtSlAg4e+LyCWpstH10YBb8Naipq+tTNsAOSa6OIEn/27JbxI=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4761.namprd04.prod.outlook.com (20.176.107.144) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Fri, 17 Jan 2020 16:11:02 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020 16:11:02 +0000
Received: from localhost.localdomain (65.112.130.194) by BN6PR14CA0035.namprd14.prod.outlook.com (2603:10b6:404:13f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Fri, 17 Jan 2020 16:11:00 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v4 2/4] Cygwin: readlinkat: allow pathname to be empty
Date: Fri, 17 Jan 2020 16:11:00 -0000
Message-ID: <20200117161037.1828-3-kbrown@cornell.edu>
References: <20200117161037.1828-1-kbrown@cornell.edu>
In-Reply-To: <20200117161037.1828-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7219;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b43YapmhtWEXA3QSqj24CqHUiKcKMSKZ/aNmJ1t1meICXLnIlaUbaOtieELf1DiojHVMEbh6fU6RCI8wLkJy3w==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00056.txt

Following Linux, allow the pathname argument to be an empty string,
provided the dirfd argument refers to a symlink opened with
O_PATH | O_NOFOLLOW.  The readlinkat call then operates on that
symlink.
---
 winsup/cygwin/syscalls.cc | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 038a316db..282d9e0ee 100644
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
+	     to a symlink that was opened with O_PATH | O_NOFOLLOW.
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

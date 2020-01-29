Return-Path: <cygwin-patches-return-10027-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39975 invoked by alias); 29 Jan 2020 17:22:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39893 invoked by uid 89); 29 Jan 2020 17:22:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2092.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.92) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 17:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=YAy1Jq8S2d0ivwwiKrD+xU3w1VXRgWuMKXFHDl7my6rZ+XpQJuJdGPSWIudd5S3xyTX0nss7/wIuwUZ6WjDvtIaebDlf5trK6Y/6tpejwduBtBG+Ec1jQijUOM1WCjcm3pviBgVH8kGvO0MUcsUUXeHZBBEgmGbKUhA4h4k3UQyq9SkKa6+1SnUT55LBL6nIyY8UXdR5sXIR8StmDoV1Kgg8kz1H5KSog3oTNHS02xAwZrXJ792xqI98U65FbkCLl64PWBTH97U4vrRPzk20iKHmfYWwqA/jRrssEH8KMfMYV08vIZf3glAzJLfTzwDi3a9Y15Fh5sYxNpbbVMA5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=AmuTXdMU65u6Cw5dlqoyR1XN+nIQNtuse7/i2MiT5eo=; b=Ahc5vh8UQpJKYDg+xouSvoxf90ElGu35WlXfWEC1jyCbMFaBYhT7ZINGggdRSa/YCFoE2vjLwxXT9AMkXFXwNIx26H6KQ7xTOTP7uNBcwYESGEHlUQ/dKXqtlSyxQDK3+NmzrAlcjux244dHMh3x/8nahTA0fOS/mh5kcbjT9nIIbuxw2rvd29Sroi8Y4vPmERjNDSHGH3CaUzk66FxJfVtrkijQeqikfIvYY0xlq8ERlSmeJuTaZRvEOI0gDda5ahS5pYu/oe1+5CESsjEP7KWGR3qM1Dmsvwm0JSjb4lSjJgZpIbYzMuk/fT2WOBdjWvw3wPUnbXnfp2FuvQg0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=AmuTXdMU65u6Cw5dlqoyR1XN+nIQNtuse7/i2MiT5eo=; b=crUg1I6Fkf5Ca8Q6dOZ5qKa9Lf3cmww+U8VJKeCHGIkxg38pUJFwvBao7cjkKfJpYPKcaaOr/u7EUy513FKXXVn6NLj1ToFPpHO2MZKV2yLQqA4FVvSQevQFCwG0t5lZSIsGylJONbSYQvhLuJWkeCU0IGjCsA/Z5HZEdb897Sw=
Received: from BYAPR04MB5735.namprd04.prod.outlook.com (20.179.59.153) by BYAPR04MB3896.namprd04.prod.outlook.com (52.135.220.152) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.26; Wed, 29 Jan 2020 17:22:11 +0000
Received: from BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399]) by BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020 17:22:11 +0000
Received: from localhost.localdomain (65.112.130.194) by BN7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:408:34::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 17:22:10 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 2/5] Cygwin: AF_LOCAL: set appropriate errno on system calls
Date: Wed, 29 Jan 2020 17:22:00 -0000
Message-ID: <20200129172147.1566-3-kbrown@cornell.edu>
References: <20200129172147.1566-1-kbrown@cornell.edu>
In-Reply-To: <20200129172147.1566-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: QAbrLUTWDHh2MQlHrAv3Q6pdWxLXycS2nbgUVzVt7Pgb74BgZOQraT18YSJ7xrzzq1k15HVtvq3ee9wliDPMaIOopRU6XnERiHxGQk3q5U31beeJCWgN0jK0v4PbNWA/oOK0+j34IUcJEPwpcDdGxQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yiwujKW62zsBJKu0mBL2xA4TZVHDdpvty2DLkQ7bccX7ok6thx5ctrVyBODywX11F8CDuogVRgpPjsznP+6JxQ==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00133.txt

If an AF_LOCAL socket is opened with O_PATH, all socket system calls
that take a file descriptor argument fail on the resulting descriptor.
Make sure that errno is set as on Linux for those calls that are
implemented on Linux.  In almost all cases it is ENOTSOCK.  There are
two exceptions:

- sockatatmark(3); errno is EBADF.

- bindresvport(3); errno is EAFNOSUPPORT if the second argument sin
  (of type struct sockaddr_in *) is non-NULL and satisfies
  sin->sin_family =3D=3D AF_INET.

Finally, there are two BSD socket system calls implemented on Cygwin
but not Linux: getpeereid(3) and bindresvport_sa(3).  Set errno to
ENOTSOCK for these for consistency with the majority of the other
calls.
---
 winsup/cygwin/net.cc | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index 437712c63..d9f51bf68 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -65,8 +65,11 @@ get (const int fd)
=20
   fhandler_socket *const fh =3D cfd->is_socket ();
=20
-  if (!fh)
-    set_errno (ENOTSOCK);
+  if (!fh || (fh->get_flags () & O_PATH))
+    {
+      set_errno (ENOTSOCK);
+      return NULL;
+    }
=20
   return fh;
 }
@@ -641,9 +644,17 @@ extern "C" int
 sockatmark (int fd)
 {
   int ret;
+  cygheap_fdget cfd (fd);
=20
-  fhandler_socket *fh =3D get (fd);
-  if (fh && fh->ioctl (SIOCATMARK, &ret) !=3D -1)
+  if (cfd < 0)
+    return -1;
+
+  fhandler_socket *const fh =3D cfd->is_socket ();
+  if (!fh)
+    set_errno (ENOTSOCK);
+  else if (fh->get_flags () & O_PATH)
+    set_errno (EBADF);
+  else if (fh->ioctl (SIOCATMARK, &ret) !=3D -1)
     return ret;
   return -1;
 }
--=20
2.21.0

Return-Path: <cygwin-patches-return-9880-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5332 invoked by alias); 28 Dec 2019 19:52:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5151 invoked by uid 89); 28 Dec 2019 19:52:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2091.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 28 Dec 2019 19:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=O7nkMSjHRWm3cgtMarnaIiT6yLLqpYJF2ur7uAF4UZmj3S6EENO/L123AWsCOrEan/bH1FHjNokmQmY74LKU1kKyLN7pKMPKbWpbC+mIwNUd7/V0rKlVB4mlQIkT+U5gBkYn7zbPJGHMmIuIQEk/Et0A3KI2mwJE+R99BkYUopYxI10dJNXJ1uOsFThy3vXd5ixC/NsRsuRB6aauBnowZHnwD96c29yahIrTVUil/tA8A82dM70FfcFC0ZtHkxRCE3eJupMO/kO7/eroAGrDWv8YKeIjlS2KLdE0Pn7o94hFBPwmMOKTX4IRQrR/Xfd5bE+S7nND2X1tXpNLXCpG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8tKjAKpN4egFlaFKchE7uxfSgIWvJYnzenAYPwio00=; b=aOfh4nxXYjdHOlCHR9nq0y0et4ohCxV1bNmMgvsDCRBXG4CLM9uNdYJ1PtBkwPSc46GJf+2FB0Y6M++kNeucx1fVDPiCYxascjTKO9OlGlCksHhXMckR8AJ4NE5SdiTHV7Gl+W7go+g8ruMQVRyVr+lAgj7WHKhVH5zoY+2jDDGPPQYBybcrvH/DyhMuk9FRLchtDLOC9wKtczUzgKRE9yGAe7HVHfY9F0L2+ncPGRu5b61RVbjWlGcsdbsrXoZwAx3jOy7nhqQhl1ZsXXxXgQHmtS37D93EgjO1Saatx/yys6QhqORNAUfRy9usPvphdBJPimqBKcHqu8yA7GF7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8tKjAKpN4egFlaFKchE7uxfSgIWvJYnzenAYPwio00=; b=FaSCEEp20vFRzO7ln7ZImUmy5qJZ6LZP/AkxVkwB9Hd8TOkFEjpqZh5vdhmIQ5ZzjmGrj4JgBVc7b2gJ3I+sOO31NPZ41D2pvwjXnkNgfUunQxHkWeGvWZvr7V08EOkD5z+c5sHtJuToJPnNWlvCEolduIx+V9amgd96D4xoAh0=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5210.namprd04.prod.outlook.com (20.178.24.151) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Sat, 28 Dec 2019 19:52:30 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Sat, 28 Dec 2019 19:52:30 +0000
Received: from localhost.localdomain (68.175.129.7) by CH2PR18CA0048.namprd18.prod.outlook.com (2603:10b6:610:55::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Sat, 28 Dec 2019 19:52:29 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 1/3] Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
Date: Sat, 28 Dec 2019 19:52:00 -0000
Message-ID: <20191228195213.1570-2-kbrown@cornell.edu>
References: <20191228195213.1570-1-kbrown@cornell.edu>
In-Reply-To: <20191228195213.1570-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2582;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3civxIGb0qleKT+I0Pb0zN2MdG5qeii4M3YDR4zN9UNpD7C7I9PHVerdMMQopdJKcg9A9lDq8L11oXZM6LCzw==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00151.txt.bz2

Up to now, opening a symlink with O_NOFOLLOW fails with ELOOP.
Following Linux, allow this to succeed if O_PATH is also specified.
---
 winsup/cygwin/syscalls.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 20126ce10..038a316db 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1470,7 +1470,7 @@ open (const char *unix_path, int flags, ...)
=20
       if (!(fh =3D build_fh_name (unix_path, opt, stat_suffixes)))
 	__leave;		/* errno already set */
-      if ((flags & O_NOFOLLOW) && fh->issymlink ())
+      if ((flags & O_NOFOLLOW) && fh->issymlink () && !(flags & O_PATH))
 	{
 	  set_errno (ELOOP);
 	  __leave;
--=20
2.21.0

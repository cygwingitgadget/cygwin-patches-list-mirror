Return-Path: <cygwin-patches-return-10029-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40177 invoked by alias); 29 Jan 2020 17:22:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40081 invoked by uid 89); 29 Jan 2020 17:22:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1097
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2092.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.92) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 17:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=HcaAkDswSw1K92fegguAgE9IavDZhG9ePyDKZmY6NabyGpnCrQnyhA/BW9KnZJSuJf4P0dVt5DHHQ42S3C2gAdcfOUS5erREuaZ9yGdE/q06+NIOXnywfNQkkGX/zWowjPalpTaojCvfImy70ruQYR7ZvXmdNZur0r6nlwGAGUjyGRbieyIwNwHe78mSR4w4pkIMhh6AnT3k+RTagKb96CB0n/l2OZSS76qJ41hKrYNZXXaIYLoLcTKT4iDKrFGdWkR25rhZNlxdoBqLiJY7KMWXpqndbJR1+YX7i4AqRxAo9JhEDKkrdlWx24KYVjvGXe3YgfUHcfoQl9GSUcotug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=kGjM4usv95dg+ADzv6Sk7I4nZyBD5O4eX/6DmjhgH3k=; b=dA9A2Ji0vJIALyIAxiNk7jy289akMkBP1CYdE0dzfVQtfGUgBdCIrVMOH+U/uKZNw1mNlQht0JxTP0Fm4a4uQLDXSPi2bAKDt0hadq07YmxHNdyKN4JJxz56T1WAkued00dd7f96bG6xGDm0JRUV9jhF+HvmfwyUhA8/zUThvuNMWXPocrUt55WsuB6cvoFgeG20w1nyYHoRHfTh6r/8FUWGlyq4dR+pX0ottI6lVtcgMt6m3lkMrvtJOExZN8UJEm6qRm79J8/zfRLffJt7vZQqL74RhtHouUImwIDHE37YRvFl4NdEADUXzRasBEISEWHXiGkG5FXbUYbXdEOI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=kGjM4usv95dg+ADzv6Sk7I4nZyBD5O4eX/6DmjhgH3k=; b=RpqGd4XmBzL4JF2+AxTZGzKbWKAysPSiSucVWTiq/SRfU1q/r72wyn3xf2IcpGwQBWHW2Z/NNUPQagWxnEwTJnyGi6QbUxI77QGY7kgeBm2H6QsZCGWlc0v4N0JBOry7nPiyybs0HB2LOFmlIcj063lWMRqfcAd2GUVjLIg+zLw=
Received: from BYAPR04MB5735.namprd04.prod.outlook.com (20.179.59.153) by BYAPR04MB3896.namprd04.prod.outlook.com (52.135.220.152) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.26; Wed, 29 Jan 2020 17:22:12 +0000
Received: from BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399]) by BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020 17:22:12 +0000
Received: from localhost.localdomain (65.112.130.194) by BN7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:408:34::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 17:22:11 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 3/5] Cygwin: AF_LOCAL::fstatvfs: use our handle if O_PATH is set
Date: Wed, 29 Jan 2020 17:22:00 -0000
Message-ID: <20200129172147.1566-4-kbrown@cornell.edu>
References: <20200129172147.1566-1-kbrown@cornell.edu>
In-Reply-To: <20200129172147.1566-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: zMDB8aCTYDbONBX23Eh3s8+8o8yo7QLX95IJY8M55uB5ybsYwrd/q32aIgx+1ZKXUSjxEcuRHEuPnL0hotqJqZl4+a86vMjdZm/nDTkyNpuKWJBZPk9KnuDN4PQ/La8ul6p87hvzjdSdH5+8aKaOdw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUzMsjZT+B7j4ZaIW7rgDQdVnNZfN74NHZSYzbVdwQp287A/9r+aCd40qynCJBEOIXVxTl0ND9H/hKHhG9/wAw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00134.txt

If O_PATH is set, then the fhandler_socket_local object has a handle
that can be used for getting the statvfs information.  Use it by
calling fhandler_base::fstatvfs_by_handle.  Without this change,
fhandler_disk_file::fstatfvs would called on a new fhandler_disk
object, which would then have to be opened.
---
 winsup/cygwin/fhandler_socket_local.cc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandle=
r_socket_local.cc
index e7f4fe603..76815a611 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -675,6 +675,13 @@ fhandler_socket_local::fstatvfs (struct statvfs *sfs)
 {
   if (get_sun_path () && get_sun_path ()[0] =3D=3D '\0')
     return fhandler_socket_wsock::fstatvfs (sfs);
+  if (get_flags () & O_PATH)
+    /* We already have a handle. */
+    {
+      HANDLE h =3D get_handle ();
+      if (h)
+	return fstatvfs_by_handle (h, sfs);
+    }
   fhandler_disk_file fh (pc);
   fh.get_device () =3D FH_FS;
   return fh.fstatvfs (sfs);
--=20
2.21.0

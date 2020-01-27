Return-Path: <cygwin-patches-return-10016-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122653 invoked by alias); 27 Jan 2020 13:21:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122567 invoked by uid 89); 27 Jan 2020 13:21:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690139.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Jan 2020 13:21:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=F0YWoaXOhVVaczxWSUkemskJD0KgOV3TJkhsGeGLQXki6dtd4vuA3aeqMDir0QomZGXfRvZ/8MOO/5+pIRLCIbP9nZCQL8J8KNqEIIf5l/ZdnRfz9ci/kZyMtNjDbHRDFijVhtqFN4FkVmsw0HcZE2K47EyxnJ0DPyISvqOTW03r4U9mPc0ChxfwjrNdjMeF8JsCsHgDBQqFGbiZz6AOWW2TsqrAT+L6jQ8hLzgj3D8pQhEVqYA3QAO57IaEs3kTebVmfQRd9DPawDIjjuQ72T8/uJAbce1qZt3vDyLcld1Uoriu1L6SeWf48P7ii1+I5MCdok/k+BYpg0coPhWkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Yi4U2FLyw+7LMtKSiYGlZrEkAjfduIO/SvNUHDxcf9Q=; b=SZIt9Cfnv6UqDx2zwY15eVETkQ0iBWRArmNHmfnAfXWw3FRd1BB+HHaFVycykyvDLCzXYx3d4nL1/v6tx/mg1ctB6hQObW86m+P8W13oSn6l2C0k/3C8kVPwG/vpI6BSxuyHfai/zMeg+5RkaJv2nVHaRdAzbiyD5lHyTSyV58vTehndYp3mZ9plm9LhhDswtZnfphErpqtVeChllWEPiAaj9PI99vpkHKRohy2MTixCmxL6E94d7a0GyAKlyajW0hcW2OgDGEHLOi57g1FusW2k1ud/Y1VRhnY3O11aHMISw6GMvHyLa5SJKCe+JsNcyc5uZzlIdgobF79gJHlqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Yi4U2FLyw+7LMtKSiYGlZrEkAjfduIO/SvNUHDxcf9Q=; b=MKYS+uWJI5/FbzJ6h/KtE9zHqatLsk2PY5/9ldYHuf47QBVW/o7z7KUACJdo2WHpPJxIEYiWX67C02M9MaYBlalSlLt3gvg7CNAVb308TDZwh5LDg2c0c/ivptkVSS+QIADeUThplxwOOXYqGYBvyQ5FRidSEXu2b49uNhORevk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4859.namprd04.prod.outlook.com (20.176.109.28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Mon, 27 Jan 2020 13:21:16 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020 13:21:16 +0000
Received: from localhost.localdomain (65.112.130.194) by BN3PR03CA0107.namprd03.prod.outlook.com (2603:10b6:400:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Mon, 27 Jan 2020 13:21:15 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 3/3] Cygwin: FIFO::fstatvfs: use our handle if O_PATH is set
Date: Mon, 27 Jan 2020 13:21:00 -0000
Message-ID: <20200127132050.4143-4-kbrown@cornell.edu>
References: <20200127132050.4143-1-kbrown@cornell.edu>
In-Reply-To: <20200127132050.4143-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: pMrCRsDjJNBf3Ybr+u1kRhrEdGusaUyTL53vY1JeJ1YOzzjZcd9A0ZH2lvq9k+c7zAcA55aKW7FEy3wOMDvdMyp28muJ9CAmju35EWzoMdswfEZ4ZSgOF1BK7BbEPJR41UHNZqEXwYTpf7CxA4wLzA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Az0usElJ97DIsjSrfjeaGo/kp4fcXLeEd/OV8WBeStTflWugwNdcGtmhZ3M5dTEFglBH5eMOdFiq87ucHqQUig==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00122.txt

If O_PATH is set, then the fhandler_fifo object has a handle that can
be used for getting the statvfs information.  Use it by calling
fhandler_base::fstatvfs_by_handle.  Before this change,
fhandler_disk_file::fstatfvs was called on a new fhandler_disk object,
which would then have to be opened.
---
 winsup/cygwin/fhandler_fifo.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index a338f12cc..ef568f6fe 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -906,6 +906,14 @@ errout:
 int __reg2
 fhandler_fifo::fstatvfs (struct statvfs *sfs)
 {
+  if (get_flags () & O_PATH)
+    /* We already have a handle. */
+    {
+      HANDLE h =3D get_handle ();
+      if (h)
+	return fstatvfs_by_handle (h, sfs);
+    }
+
   fhandler_disk_file fh (pc);
   fh.get_device () =3D FH_FS;
   return fh.fstatvfs (sfs);
--=20
2.21.0

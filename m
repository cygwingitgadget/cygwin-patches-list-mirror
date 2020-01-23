Return-Path: <cygwin-patches-return-9995-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109277 invoked by alias); 23 Jan 2020 16:31:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109219 invoked by uid 89); 23 Jan 2020 16:31:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM12-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam12on2095.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) (40.107.237.95) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 16:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=QjYlYNZGsnX3ezThPfswJBIw/7o+n8hBDrNY5b7/lt1XkjB9IjiDAOBIWWPAik8hkIeENBf3O/CBv8YvNpuOWQPLY6QyVJEG4dOmAhganefnVOpo6BK9p93IXGziD/bYAz4AKsE5mjTTKXe5vFCBSDawcyOSUlRX7xsVBChMvgDKK4hqJ4ohdryW3RLeWe1qcqqRMkw0A9Q/LzF1dn5gmJkta+ZqX07+lVPJVMbXJ6m/c14SEzM8PWccIvTwiAGpLYVq8Q7sBUeyiWDv2w8dnWJ36XLRN2U5FpbfyUWblck9y4EBRa7kmOIekRFu0sMfEDmS65Ee/i+VqFx2aEK3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=LwaTtJOjRnUQ7uD45t6joXRLtXZBA4cFcYZKn8wUosc=; b=IGsbCiv3kpGUWymeZzHpT5V4/6Gd77QHXGvGBsPZi8s952Uz59BPSmOOc3cbt/H4lAMjnTBaWwXxkD0eGoGK4lJv1VCAJw9D5DrTRjqStrMmH3dr28HuqWQ/5sHlFk6iuog90LH949V+M2jAXNMDeQMmPbBiLTuHgjN2juZGn6UkfTxjkU+kYaXEfmjFgm3dbe5q+CjN8v+aBM0W+2oZSKSOXKtIj1WMxUQ9j466L1JB65dbish04+R/H6W03fEVE4a3VbX/NaoyYaLBOeuZR6tkPydavw3xbsh5fi33U75ewxxmtrzEN0iehBsaAKintsJsku55vRVI3bTuv3t41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=LwaTtJOjRnUQ7uD45t6joXRLtXZBA4cFcYZKn8wUosc=; b=XM3eZSlWpvYmNQ+FY0cmhl7Fml9RkDSJrL7wCol1Srt/QIL0JTBdd6DDfrQ+pRHuvjBKKhpsEp9wLw9qjhGU1oernD3/UT+ik/Upy3EQsvQx6eFa1HK6HzhjbA1O0fwLpyHPpWpFLZ/+ZiLaSiXqjmsP4XwWrWEwqr3Wp4e7tOk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6393.namprd04.prod.outlook.com (10.141.162.145) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Thu, 23 Jan 2020 16:31:05 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020 16:31:05 +0000
Received: from localhost.localdomain (23.31.190.121) by CH2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:610:51::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Thu, 23 Jan 2020 16:31:04 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 3/3] Cygwin: FIFO: tweak fcntl and dup when O_PATH is set
Date: Thu, 23 Jan 2020 16:31:00 -0000
Message-ID: <20200123163015.12354-4-kbrown@cornell.edu>
References: <20200123163015.12354-1-kbrown@cornell.edu>
In-Reply-To: <20200123163015.12354-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:1923;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: Mf//9BRZVObUjXoXrefzI32Drn/0g9nDpZkI/ejeetofAkP7ADCgwgFSwYM5dQX6btp8domA4lua0tfZkrXr4kX/ILQ49zSr5GLjiZFTcNHt/SrQcFqGqXsNiOWlxXQNfsDzlLPz6nVOk9dEMRozag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQslDMw2/QFqzmA0K7FTMcQykaDULYoEC5SeF23PARsx5+9FevRCj5RJjpYCN4Iauoy2ip8d2ZwCBrV/KlS3mg==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00101.txt

fhandler_fifo::fcntl and fhandler_fifo::dup now call the corresponding
fhandler_base methods if the FIFO was opened with the O_PATH flag.
---
 winsup/cygwin/fhandler_fifo.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 8cbab353c..a338f12cc 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -997,7 +997,7 @@ fhandler_fifo::close ()
 int
 fhandler_fifo::fcntl (int cmd, intptr_t arg)
 {
-  if (cmd !=3D F_SETFL || nohandle ())
+  if (cmd !=3D F_SETFL || nohandle () || (get_flags () & O_PATH))
     return fhandler_base::fcntl (cmd, arg);
=20
   const bool was_nonblocking =3D is_nonblocking ();
@@ -1014,6 +1014,9 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
   int ret =3D -1;
   fhandler_fifo *fhf =3D NULL;
=20
+  if (get_flags () & O_PATH)
+    return fhandler_base::dup (child, flags);
+
   if (fhandler_base::dup (child, flags))
     goto out;
=20
--=20
2.21.0

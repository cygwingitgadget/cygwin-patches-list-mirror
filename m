Return-Path: <cygwin-patches-return-9249-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85934 invoked by alias); 27 Mar 2019 21:29:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84909 invoked by uid 89); 27 Mar 2019 21:29:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1135
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780135.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 Mar 2019 21:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=c6UfOdhCroFUAE6ZOuSU0eS9DofQ8+Z+I4lo8fTAEds=; b=VcSJU1O+40ViXUbZ7sRtakfcwHkdJ+QiVmLl3kvh/zDgs3ky3GXvh+1EghDCcN7x99uOtEGemVb2KBlYk4HD8bO6/8+KjbaC+YQs5gvOWH8s6e5ahHaHxINaYwN1+IoLvG1qD85USzy7tJQA4rMh11VryVm4JD1fGzBs65GkBjY=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB6089.namprd04.prod.outlook.com (20.178.226.159) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.18; Wed, 27 Mar 2019 21:29:21 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019 21:29:21 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: FIFO: implement clear_readahead
Date: Wed, 27 Mar 2019 21:29:00 -0000
Message-ID: <20190327212910.672-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00059.txt.bz2

Make fhandler_base::clear_readahead virtual, and implement
fhandler_fifo::clear_readahead.  This is called by
dtable::fixup_after_exec; it clears the readahead in each client.
---
 winsup/cygwin/fhandler.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 3398cc625..21fec9e38 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -444,7 +444,7 @@ public:
     return dev ().native ();
   }
   virtual bg_check_types bg_check (int, bool =3D false) {return bg_ok;}
-  void clear_readahead ()
+  virtual void clear_readahead ()
   {
     raixput =3D raixget =3D ralen =3D rabuflen =3D 0;
     rabuf =3D NULL;
@@ -1302,6 +1302,12 @@ public:
   bool arm (HANDLE h);
   void fixup_after_fork (HANDLE);
   int __reg2 fstatvfs (struct statvfs *buf);
+  void clear_readahead ()
+  {
+    fhandler_base::clear_readahead ();
+    for (int i =3D 0; i < nclients; i++)
+      client[i].fh->clear_readahead ();
+  }
   select_record *select_read (select_stuff *);
   select_record *select_write (select_stuff *);
   select_record *select_except (select_stuff *);
--=20
2.17.0

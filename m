Return-Path: <cygwin-patches-return-9210-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113956 invoked by alias); 22 Mar 2019 19:31:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113814 invoked by uid 89); 22 Mar 2019 19:31:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810112.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.112) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Mar 2019 19:30:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=O4O2kkNwEibuu+Q1LjYlecFk0ojH/WPtwh9WbTuffHw=; b=YRVJIvT8gh1clyJFC5/ykEF1EpKd8oIhDhTNUlL5+ztewmAYGwWP+gFKMQqHdN7LUmBVNTEuJvsk9nooNyc+mGu2AzITw5KljzzgX4f77PzYqLv+mI6Co18ZvU3ICMg3CiKDYOcmcsmVhEt9fCwsUjPi0gcGwQc0BOp4XEeAXsA=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5243.namprd04.prod.outlook.com (20.178.25.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Fri, 22 Mar 2019 19:30:40 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019 19:30:40 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 6/8] Cygwin: FIFO: update fixup_after_fork
Date: Fri, 22 Mar 2019 19:31:00 -0000
Message-ID: <20190322193020.565-7-kbrown@cornell.edu>
References: <20190322193020.565-1-kbrown@cornell.edu>
In-Reply-To: <20190322193020.565-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00017.txt.bz2

Fixup each client.  Reset listen_client_thr and lct_termination_evt.
---
 winsup/cygwin/fhandler_fifo.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index c295c2393..7a592aa0d 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -850,6 +850,15 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
   fhandler_base::fixup_after_fork (parent);
   fork_fixup (parent, read_ready, "read_ready");
   fork_fixup (parent, write_ready, "write_ready");
+  for (int i =3D 0; i < nclients; i++)
+    {
+      client[i].fh->fhandler_base::fixup_after_fork (parent);
+      fork_fixup (parent, client[i].connect_evt, "connect_evt");
+      fork_fixup (parent, client[i].dummy_evt, "dummy_evt");
+    }
+  listen_client_thr =3D NULL;
+  lct_termination_evt =3D NULL;
+  fifo_client_unlock ();
 }
=20
 void
--=20
2.17.0

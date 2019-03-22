Return-Path: <cygwin-patches-return-9209-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113713 invoked by alias); 22 Mar 2019 19:31:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113294 invoked by uid 89); 22 Mar 2019 19:30:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810099.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.99) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Mar 2019 19:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=c4YjBIuF90cdofJ0FoxJjmEqbghcxtCtbhi4uTGAdpY=; b=hDtDU9OPYk7nzZ4bkF2vcJjCItfPI0O5g/KAywXjvSuLuE+nGF9P4XYYNGIzwTwyVm8b8vNE8SuN089bUFlxd+MnYs4dGOTZ2dsnS9ceWAYI2trDNIWNC8QmeBxJBs+TbhZO4H1jFIRzn32fs6AqkbkbRVKfUBMa6ICWmbXINRI=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5243.namprd04.prod.outlook.com (20.178.25.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Fri, 22 Mar 2019 19:30:39 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019 19:30:39 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 5/8] Cygwin: FIFO: update clone and dup
Date: Fri, 22 Mar 2019 19:31:00 -0000
Message-ID: <20190322193020.565-6-kbrown@cornell.edu>
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
X-SW-Source: 2019-q1/txt/msg00018.txt.bz2

Deal with all clients.
---
 winsup/cygwin/fhandler.h       |  8 +++++---
 winsup/cygwin/fhandler_fifo.cc | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index af5f500bf..0ebc44e0d 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1309,9 +1309,11 @@ public:
   fhandler_fifo *clone (cygheap_types malloc_type =3D HEAP_FHANDLER)
   {
     void *ptr =3D (void *) ccalloc (malloc_type, 1, sizeof (fhandler_fifo)=
);
-    fhandler_fifo *fh =3D new (ptr) fhandler_fifo (ptr);
-    copyto (fh);
-    return fh;
+    fhandler_fifo *fhf =3D new (ptr) fhandler_fifo (ptr);
+    copyto (fhf);
+    for (int i =3D 0; i < nclients; i++)
+      fhf->client[i].fh =3D client[i].fh->fhandler_base::clone ();
+    return fhf;
   }
 };
=20
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 1dcb3b3df..c295c2393 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -816,6 +816,31 @@ fhandler_fifo::dup (fhandler_base *child, int flags)
       __seterrno ();
       return -1;
     }
+  for (int i =3D 0; i < nclients; i++)
+    {
+      if (!DuplicateHandle (GetCurrentProcess (), client[i].fh->get_handle=
 (),
+			    GetCurrentProcess (),
+			    &fhf->client[i].fh->get_handle (),
+			    0, true, DUPLICATE_SAME_ACCESS)
+	  || !DuplicateHandle (GetCurrentProcess (), client[i].connect_evt,
+			       GetCurrentProcess (),
+			       &fhf->client[i].connect_evt,
+			       0, true, DUPLICATE_SAME_ACCESS)
+	  || !DuplicateHandle (GetCurrentProcess (), client[i].dummy_evt,
+			       GetCurrentProcess (),
+			       &fhf->client[i].dummy_evt,
+			       0, true, DUPLICATE_SAME_ACCESS))
+	{
+	  CloseHandle (fhf->read_ready);
+	  CloseHandle (fhf->write_ready);
+	  fhf->close ();
+	  __seterrno ();
+	  return -1;
+	}
+    }
+  fhf->listen_client_thr =3D NULL;
+  fhf->lct_termination_evt =3D NULL;
+  fhf->fifo_client_unlock ();
   return 0;
 }
=20
--=20
2.17.0

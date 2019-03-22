Return-Path: <cygwin-patches-return-9208-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113607 invoked by alias); 22 Mar 2019 19:31:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113273 invoked by uid 89); 22 Mar 2019 19:30:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810112.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.112) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Mar 2019 19:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=GNFlfWD4ilrQgT4O4a+MY3clc1D7K4z/3y0x2FDiWYU=; b=l04TSAVwaUQnrM3pR9Vh57wc1Ivn/kRmZHwvl8JhQy+YBw4/YTzOnCNRysnhuuzqqt5s/L9zNFf96rg35bRG/01SrgKxnd8AHETVUyRs6ox0J1EYnz1AjAMKA1PoFm6v6VDtYaO35oCcuNoEpxz1L0QXxzMADb3SpL6hoXLXYWQ=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5243.namprd04.prod.outlook.com (20.178.25.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Fri, 22 Mar 2019 19:30:38 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019 19:30:38 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 4/8] Cygwin: FIFO: improve EOF detection
Date: Fri, 22 Mar 2019 19:31:00 -0000
Message-ID: <20190322193020.565-5-kbrown@cornell.edu>
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
X-SW-Source: 2019-q1/txt/msg00016.txt.bz2

Add a hit_eof method that tries to detect whether any clients are
connected.  Before concluding that there are none, it gives the
listen_client thread time to update the client data.
---
 winsup/cygwin/fhandler.h       |  1 +
 winsup/cygwin/fhandler_fifo.cc | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 997dc0b6d..af5f500bf 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1277,6 +1277,7 @@ class fhandler_fifo: public fhandler_base
   bool listen_client ();
 public:
   fhandler_fifo ();
+  bool hit_eof ();
   PUNICODE_STRING get_pipe_name ();
   DWORD listen_client_thread ();
   void fifo_client_lock () { _fifo_client_lock.lock (); }
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index b0016ee90..1dcb3b3df 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -654,6 +654,25 @@ fhandler_fifo::raw_write (const void *ptr, size_t len)
   return ret;
 }
=20
+/* A FIFO open for reading is at EOF if no process has it open for
+   writing.  We test this by checking nconnected.  But we must take
+   account of the possible delay from the time of connection to the
+   time the connection is recorded by the listen_client thread. */
+bool
+fhandler_fifo::hit_eof ()
+{
+  fifo_client_lock ();
+  bool eof =3D (nconnected =3D=3D 0);
+  fifo_client_unlock ();
+  if (eof)
+    {
+      /* Give the listen_client thread time to catch up, then recheck. */
+      Sleep (1);
+      eof =3D (nconnected =3D=3D 0);
+    }
+  return eof;
+}
+
 void __reg3
 fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 {
@@ -665,7 +684,7 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
=20
   while (1)
     {
-      if (nconnected =3D=3D 0)	/* EOF */
+      if (hit_eof ())
 	{
 	  len =3D 0;
 	  return;
--=20
2.17.0

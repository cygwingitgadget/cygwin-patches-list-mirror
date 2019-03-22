Return-Path: <cygwin-patches-return-9206-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113119 invoked by alias); 22 Mar 2019 19:30:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112688 invoked by uid 89); 22 Mar 2019 19:30:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Fall, poll
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810112.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.112) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Mar 2019 19:30:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=hXw6+V4xrobekODOlYTxbhRhlRZXEdP0Zz1Uq4gM7cM=; b=sMrDhISC/R5aT1jIBijTQt22uQe2e0P/G0i6O/ZVLz3PDEpgAfK0jx/G/k+qYwqpdy7YEV27QVstalC1FEykDYh8n4lfrcOF9wMb2X3PX3VzflEXyGVE+1KpVDM8LYw2Yn73TlhW0k5U3vhCsqhHQAMNQvRTJH8m6kZcpIKC8Go=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5243.namprd04.prod.outlook.com (20.178.25.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Fri, 22 Mar 2019 19:30:38 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019 19:30:38 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 3/8] Cygwin: FIFO: add a spinlock
Date: Fri, 22 Mar 2019 19:30:00 -0000
Message-ID: <20190322193020.565-4-kbrown@cornell.edu>
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
X-SW-Source: 2019-q1/txt/msg00015.txt.bz2

Don't let listen_client_thread and raw_read access the client list
simultaneously.
---
 winsup/cygwin/fhandler.h       |  3 +++
 winsup/cygwin/fhandler_fifo.cc | 34 +++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index e7c4af6a1..997dc0b6d 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1267,6 +1267,7 @@ class fhandler_fifo: public fhandler_base
   WCHAR pipe_name_buf[CYGWIN_FIFO_PIPE_NAME_LEN + 1];
   fifo_client_handler client[MAX_CLIENTS];
   int nclients, nconnected;
+  af_unix_spinlock_t _fifo_client_lock;
   bool __reg2 wait (HANDLE);
   NTSTATUS npfs_handle (HANDLE &);
   HANDLE create_pipe_instance (bool);
@@ -1278,6 +1279,8 @@ public:
   fhandler_fifo ();
   PUNICODE_STRING get_pipe_name ();
   DWORD listen_client_thread ();
+  void fifo_client_lock () { _fifo_client_lock.lock (); }
+  void fifo_client_unlock () { _fifo_client_lock.unlock (); }
   int open (int, mode_t);
   off_t lseek (off_t offset, int whence);
   int close ();
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index e91e88050..b0016ee90 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -349,13 +349,17 @@ fhandler_fifo::listen_client_thread ()
       int i;
       DWORD wait_ret;
=20
+      fifo_client_lock ();
       found =3D false;
       for (i =3D 0; i < nclients; i++)
 	switch (client[i].state)
 	  {
 	  case fc_invalid:
 	    if (disconnect_and_reconnect (i) < 0)
-	      goto errout;
+	      {
+		fifo_client_unlock ();
+		goto errout;
+	      }
 	    /* Fall through. */
 	  case fc_connected:
 	    w[i] =3D client[i].dummy_evt;
@@ -369,13 +373,15 @@ fhandler_fifo::listen_client_thread ()
 	    break;
 	  }
       w[nclients] =3D lct_termination_evt;
+      int res =3D 0;
       if (!found)
-	{
-	  if (add_client () < 0)
-	    goto errout;
-	  else
-	    continue;
-	}
+	res =3D add_client ();
+      fifo_client_unlock ();
+      if (res < 0)
+	goto errout;
+      else if (!found)
+	continue;
+
       if (!arm (read_ready))
 	{
 	  __seterrno ();
@@ -391,9 +397,11 @@ fhandler_fifo::listen_client_thread ()
 	return 0;
       else
 	{
+	  fifo_client_lock ();
 	  client[i].state =3D fc_connected;
 	  nconnected++;
 	  set_pipe_non_blocking (client[i].fh->get_handle (), true);
+	  fifo_client_unlock ();
 	  yield ();
 	}
     }
@@ -664,6 +672,7 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	}
=20
       /* Poll the connected clients for input. */
+      fifo_client_lock ();
       for (int i =3D 0; i < nclients; i++)
 	if (client[i].state =3D=3D fc_connected)
 	  {
@@ -671,15 +680,22 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 	    client[i].fh->fhandler_base::raw_read (in_ptr, len);
 	    ssize_t nread =3D (ssize_t) len;
 	    if (nread > 0)
-	      return;
+	      {
+		fifo_client_unlock ();
+		return;
+	      }
 	    else if (nread < 0 && GetLastError () !=3D ERROR_NO_DATA)
-	      goto errout;
+	      {
+		fifo_client_unlock ();
+		goto errout;
+	      }
 	    else if (nread =3D=3D 0) /* Client has disconnected. */
 	      {
 		client[i].state =3D fc_invalid;
 		nconnected--;
 	      }
 	  }
+      fifo_client_unlock ();
       if (is_nonblocking ())
 	{
 	  set_errno (EAGAIN);
--=20
2.17.0

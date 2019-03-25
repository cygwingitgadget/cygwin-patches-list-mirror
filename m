Return-Path: <cygwin-patches-return-9235-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81618 invoked by alias); 25 Mar 2019 23:06:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81529 invoked by uid 89); 25 Mar 2019 23:06:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Never, 12686
X-HELO: NAM05-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr720104.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) (40.107.72.104) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 25 Mar 2019 23:06:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=NiBew8eNn8I0J7Z8R9pUVF8v2kuTaSRH/yvYyW7Tg1E=; b=DDDgVQD5FU4IX+c4wjkYBTT5L1ZLJEacY1sGj7QFWZsH+n3csFX8wm8lUxCtRJdGgvlEG9D98JZWsXb0jeXuIcnTOGDIjiSMmMu+bxvKHiJS259rScjjJM07tw7GFYwOX5VuDK/k9KWOg8qSrEmm8TDaiBYzopoCEdi4VyhFDI4=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4649.namprd04.prod.outlook.com (20.176.105.214) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.19; Mon, 25 Mar 2019 23:06:10 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019 23:06:10 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 2/2] Cygwin: FIFO: add support for the duplex case
Date: Mon, 25 Mar 2019 23:06:00 -0000
Message-ID: <20190325230556.2219-3-kbrown@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu>
In-Reply-To: <20190325230556.2219-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00045.txt.bz2

If a FIFO is opened with O_RDWR access, create the pipe with
read/write access, and make the first client have the handle of that
pipe as its I/O handle.

Adjust fhandler_fifo::raw_read to account for the result of trying to
read from that client if there's no data.
---
 winsup/cygwin/fhandler.h       |  5 +++
 winsup/cygwin/fhandler_fifo.cc | 79 +++++++++++++++++++++++++++++-----
 2 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index ef34f9c40..3398cc625 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1253,6 +1253,10 @@ struct fifo_client_handler
   HANDLE dummy_evt;		/* Never signaled. */
   fifo_client_handler () : fh (NULL), state (fc_unknown), connect_evt (NUL=
L),
 			   dummy_evt (NULL) {}
+  fifo_client_handler (fhandler_base *_fh, fifo_client_connect_state _stat=
e,
+		       HANDLE _connect_evt, HANDLE _dummy_evt)
+    : fh (_fh), state (_state), connect_evt (_connect_evt),
+      dummy_evt (_dummy_evt) {}
   int connect ();
   int close ();
 };
@@ -1268,6 +1272,7 @@ class fhandler_fifo: public fhandler_base
   fifo_client_handler client[MAX_CLIENTS];
   int nclients, nconnected;
   af_unix_spinlock_t _fifo_client_lock;
+  bool _duplexer;
   bool __reg2 wait (HANDLE);
   NTSTATUS npfs_handle (HANDLE &);
   HANDLE create_pipe_instance (bool);
diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 2c20444c6..7847cca82 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -33,7 +33,7 @@ STATUS_PIPE_EMPTY simply means there's no data to be read=
. */
 fhandler_fifo::fhandler_fifo ():
   fhandler_base (), read_ready (NULL), write_ready (NULL),
   listen_client_thr (NULL), lct_termination_evt (NULL), nclients (0),
-  nconnected (0)
+  nconnected (0), _duplexer (false)
 {
   pipe_name_buf[0] =3D L'\0';
   need_fork_fixup (true);
@@ -224,6 +224,8 @@ fhandler_fifo::create_pipe_instance (bool first)
     }
   access =3D GENERIC_READ | FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES
     | SYNCHRONIZE;
+  if (first && _duplexer)
+    access |=3D GENERIC_WRITE;
   sharing =3D FILE_SHARE_READ | FILE_SHARE_WRITE;
   hattr =3D OBJ_INHERIT;
   if (first)
@@ -437,7 +439,7 @@ fhandler_fifo::open (int flags, mode_t)
     case O_RDWR:
       reader =3D true;
       writer =3D false;
-      duplexer =3D true;
+      duplexer =3D _duplexer =3D true;
       break;
     default:
       set_errno (EINVAL);
@@ -447,7 +449,7 @@ fhandler_fifo::open (int flags, mode_t)
=20
   debug_only_printf ("reader %d, writer %d, duplexer %d", reader, writer, =
duplexer);
   set_flags (flags);
-  if (reader)
+  if (reader && !duplexer)
     nohandle (true);
=20
   /* Create control events for this named pipe */
@@ -472,6 +474,48 @@ fhandler_fifo::open (int flags, mode_t)
       goto out;
     }
=20
+  /* If we're a duplexer, create the pipe and the first client. */
+  if (duplexer)
+    {
+      HANDLE ph, connect_evt, dummy_evt;
+      fhandler_base *fh;
+
+      ph =3D create_pipe_instance (true);
+      if (!ph)
+	{
+	  res =3D error_errno_set;
+	  goto out;
+	}
+      set_io_handle (ph);
+      set_pipe_non_blocking (ph, true);
+      if (!(fh =3D build_fh_dev (dev ())))
+	{
+	  set_errno (EMFILE);
+	  res =3D error_errno_set;
+	  goto out;
+	}
+      fh->set_io_handle (ph);
+      fh->set_flags (flags);
+      if (!(connect_evt =3D create_event ()))
+	{
+	  res =3D error_errno_set;
+	  fh->close ();
+	  delete fh;
+	  goto out;
+	}
+      if (!(dummy_evt =3D create_event ()))
+	{
+	  res =3D error_errno_set;
+	  delete fh;
+	  fh->close ();
+	  CloseHandle (connect_evt);
+	  goto out;
+	}
+      client[0] =3D fifo_client_handler (fh, fc_connected, connect_evt,
+				       dummy_evt);
+      nconnected =3D nclients =3D 1;
+    }
+
   /* If we're reading, start the listen_client thread (which should
      signal read_ready), and wait for a writer. */
   if (reader)
@@ -482,8 +526,8 @@ fhandler_fifo::open (int flags, mode_t)
 	  res =3D error_errno_set;
 	  goto out;
 	}
-      /* Wait for the listen_client thread to create the pipe and
-	 signal read_ready.  This should be quick.  */
+      /* Wait for the listen_client thread to signal read_ready.  This
+	 should be quick.  */
       HANDLE w[2] =3D { listen_client_thr, read_ready };
       switch (WaitForMultipleObjects (2, w, FALSE, INFINITE))
 	{
@@ -703,12 +747,25 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 		fifo_client_unlock ();
 		return;
 	      }
-	    else if (nread < 0 && GetLastError () !=3D ERROR_NO_DATA)
-	      {
-		fifo_client_unlock ();
-		goto errout;
-	      }
-	    else if (nread =3D=3D 0) /* Client has disconnected. */
+	    /* In the duplex case with no data, we seem to get nread
+	       =3D=3D -1 with ERROR_PIPE_LISTENING on the first attempt to
+	       read from the duplex pipe (client[0]), and nread =3D=3D 0
+	       on subsequent attempts. */
+	    else if (nread < 0)
+	      switch (GetLastError ())
+		{
+		case ERROR_NO_DATA:
+		  break;
+		case ERROR_PIPE_LISTENING:
+		  if (_duplexer && i =3D=3D 0)
+		    break;
+		  /* Fall through. */
+		default:
+		  fifo_client_unlock ();
+		  goto errout;
+		}
+	    else if (nread =3D=3D 0 && (!_duplexer || i > 0))
+	      /* Client has disconnected. */
 	      {
 		client[i].state =3D fc_invalid;
 		nconnected--;
--=20
2.17.0

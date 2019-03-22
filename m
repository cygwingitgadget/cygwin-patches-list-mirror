Return-Path: <cygwin-patches-return-9212-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114439 invoked by alias); 22 Mar 2019 19:31:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114341 invoked by uid 89); 22 Mar 2019 19:31:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=ss, avail
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810112.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.112) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Mar 2019 19:31:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=3y/mpULU1wj15W5DrDmoCmfEO+nIvsBcwJIlQ5Owieg=; b=iei/mHotUHuIxDiPEMDDEvKbsG50uA+0e/jNUAnYVcTH709YmD+qEBLAzzEY8s096Xx7Ysn34pRIwetMu8wQFsZLxaCpXNlnfNOgXMJvRqH6WxROFCu7Qf4Jd3N5GXahS6G3T2cgtr+xGl42T7hQlQ27ZwQ4G+bobLIMf2XgHJY=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5243.namprd04.prod.outlook.com (20.178.25.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Fri, 22 Mar 2019 19:30:41 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019 19:30:41 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 8/8] Cygwin: FIFO: update select
Date: Fri, 22 Mar 2019 19:31:00 -0000
Message-ID: <20190322193020.565-9-kbrown@cornell.edu>
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
X-SW-Source: 2019-q1/txt/msg00022.txt.bz2

Add static functions peek_fifo, thread_fifo, start_thread_fifo, and
fifo_cleanup to select.cc.  These are based on the corresponding pipe
functions, the main difference being that peek_fifo loops through the
connected clients to see if any of them have data available for
reading.

Add the fhandler_fifo methods select_read, select_write, and
select_except.

Add accessor methods get_nclients, get_handle, and is_connected that
are needed by peek_fifo.
---
 winsup/cygwin/fhandler.h |   4 +
 winsup/cygwin/select.cc  | 161 +++++++++++++++++++++++++++++++++++----
 winsup/cygwin/select.h   |   7 ++
 3 files changed, 157 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 0ebc44e0d..f6982f0ba 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1278,6 +1278,10 @@ class fhandler_fifo: public fhandler_base
 public:
   fhandler_fifo ();
   bool hit_eof ();
+  int get_nclients () const { return nclients; }
+  HANDLE& get_handle () { return fhandler_base::get_handle (); }
+  HANDLE get_handle (int i) const { return client[i].fh->get_handle (); }
+  bool is_connected (int i) const { return client[i].state =3D=3D fc_conne=
cted; }
   PUNICODE_STRING get_pipe_name ();
   DWORD listen_client_thread ();
   void fifo_client_lock () { _fifo_client_lock.lock (); }
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 59325860d..991494aa8 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -822,17 +822,148 @@ fhandler_pipe::select_except (select_stuff *ss)
   return s;
 }
=20
+static int
+peek_fifo (select_record *s, bool from_select)
+{
+  if (cygheap->fdtab.not_open (s->fd))
+    {
+      s->thread_errno =3D EBADF;
+      return -1;
+    }
+
+  int gotone =3D 0;
+  fhandler_fifo *fh =3D (fhandler_fifo *) s->fh;
+
+  if (s->read_selected)
+    {
+      if (s->read_ready)
+	{
+	  select_printf ("%s, already ready for read", fh->get_name ());
+	  gotone =3D 1;
+	  goto out;
+	}
+
+      if (fh->get_readahead_valid ())
+	{
+	  select_printf ("readahead");
+	  gotone =3D s->read_ready =3D true;
+	  goto out;
+	}
+
+      if (fh->hit_eof ())
+	{
+	  select_printf ("read: %s, saw EOF", fh->get_name ());
+	  gotone =3D s->read_ready =3D true;
+	  if (s->except_selected)
+	    gotone +=3D s->except_ready =3D true;
+	  goto out;
+	}
+
+      fh->fifo_client_lock ();
+      for (int i =3D 0; i < fh->get_nclients (); i++)
+	if (fh->is_connected (i))
+	  {
+	    int n =3D pipe_data_available (s->fd, fh, fh->get_handle (i),
+					 false);
+	    if (n > 0)
+	      {
+		select_printf ("read: %s, ready for read: avail %d, client %d",
+			       fh->get_name (), n, i);
+		fh->fifo_client_unlock ();
+		gotone +=3D s->read_ready =3D true;
+		goto out;
+	      }
+	  }
+      fh->fifo_client_unlock ();
+    }
+out:
+  if (s->write_selected)
+    {
+      gotone +=3D s->write_ready
+	=3D pipe_data_available (s->fd, fh, fh->get_handle (), true);
+      select_printf ("write: %s, gotone %d", fh->get_name (), gotone);
+    }
+  return gotone;
+}
+
+static int start_thread_fifo (select_record *me, select_stuff *stuff);
+
+static DWORD WINAPI
+thread_fifo (void *arg)
+{
+  select_fifo_info *pi =3D (select_fifo_info *) arg;
+  DWORD sleep_time =3D 0;
+  bool looping =3D true;
+
+  while (looping)
+    {
+      for (select_record *s =3D pi->start; (s =3D s->next); )
+	if (s->startup =3D=3D start_thread_fifo)
+	  {
+	    if (peek_fifo (s, true))
+	      looping =3D false;
+	    if (pi->stop_thread)
+	      {
+		select_printf ("stopping");
+		looping =3D false;
+		break;
+	      }
+	  }
+      if (!looping)
+	break;
+      Sleep (sleep_time >> 3);
+      if (sleep_time < 80)
+	++sleep_time;
+      if (pi->stop_thread)
+	break;
+    }
+  return 0;
+}
+
+static int
+start_thread_fifo (select_record *me, select_stuff *stuff)
+{
+  select_fifo_info *pi =3D stuff->device_specific_fifo;
+  if (pi->start)
+    me->h =3D *((select_fifo_info *) stuff->device_specific_fifo)->thread;
+  else
+    {
+      pi->start =3D &stuff->start;
+      pi->stop_thread =3D false;
+      pi->thread =3D new cygthread (thread_fifo, pi, "fifosel");
+      me->h =3D *pi->thread;
+      if (!me->h)
+	return 0;
+    }
+  return 1;
+}
+
+static void
+fifo_cleanup (select_record *, select_stuff *stuff)
+{
+  select_fifo_info *pi =3D (select_fifo_info *) stuff->device_specific_fif=
o;
+  if (!pi)
+    return;
+  if (pi->thread)
+    {
+      pi->stop_thread =3D true;
+      pi->thread->detach ();
+    }
+  delete pi;
+  stuff->device_specific_fifo =3D NULL;
+}
+
 select_record *
 fhandler_fifo::select_read (select_stuff *ss)
 {
-  if (!ss->device_specific_pipe
-      && (ss->device_specific_pipe =3D new select_pipe_info) =3D=3D NULL)
+  if (!ss->device_specific_fifo
+      && (ss->device_specific_fifo =3D new select_fifo_info) =3D=3D NULL)
     return NULL;
   select_record *s =3D ss->start.next;
-  s->startup =3D start_thread_pipe;
-  s->peek =3D peek_pipe;
+  s->startup =3D start_thread_fifo;
+  s->peek =3D peek_fifo;
   s->verify =3D verify_ok;
-  s->cleanup =3D pipe_cleanup;
+  s->cleanup =3D fifo_cleanup;
   s->read_selected =3D true;
   s->read_ready =3D false;
   return s;
@@ -841,14 +972,14 @@ fhandler_fifo::select_read (select_stuff *ss)
 select_record *
 fhandler_fifo::select_write (select_stuff *ss)
 {
-  if (!ss->device_specific_pipe
-      && (ss->device_specific_pipe =3D new select_pipe_info) =3D=3D NULL)
+  if (!ss->device_specific_fifo
+      && (ss->device_specific_fifo =3D new select_fifo_info) =3D=3D NULL)
     return NULL;
   select_record *s =3D ss->start.next;
-  s->startup =3D start_thread_pipe;
-  s->peek =3D peek_pipe;
+  s->startup =3D start_thread_fifo;
+  s->peek =3D peek_fifo;
   s->verify =3D verify_ok;
-  s->cleanup =3D pipe_cleanup;
+  s->cleanup =3D fifo_cleanup;
   s->write_selected =3D true;
   s->write_ready =3D false;
   return s;
@@ -857,14 +988,14 @@ fhandler_fifo::select_write (select_stuff *ss)
 select_record *
 fhandler_fifo::select_except (select_stuff *ss)
 {
-  if (!ss->device_specific_pipe
-      && (ss->device_specific_pipe =3D new select_pipe_info) =3D=3D NULL)
+  if (!ss->device_specific_fifo
+      && (ss->device_specific_fifo =3D new select_fifo_info) =3D=3D NULL)
     return NULL;
   select_record *s =3D ss->start.next;
-  s->startup =3D start_thread_pipe;
-  s->peek =3D peek_pipe;
+  s->startup =3D start_thread_fifo;
+  s->peek =3D peek_fifo;
   s->verify =3D verify_ok;
-  s->cleanup =3D pipe_cleanup;
+  s->cleanup =3D fifo_cleanup;
   s->except_selected =3D true;
   s->except_ready =3D false;
   return s;
diff --git a/winsup/cygwin/select.h b/winsup/cygwin/select.h
index 71821f76c..19f9d7dc2 100644
--- a/winsup/cygwin/select.h
+++ b/winsup/cygwin/select.h
@@ -53,6 +53,11 @@ struct select_pipe_info: public select_info
   select_pipe_info (): select_info () {}
 };
=20
+struct select_fifo_info: public select_info
+{
+  select_fifo_info (): select_info () {}
+};
+
 struct select_socket_info: public select_info
 {
   int num_w4;
@@ -89,6 +94,7 @@ public:
   select_record start;
=20
   select_pipe_info *device_specific_pipe;
+  select_fifo_info *device_specific_fifo;
   select_socket_info *device_specific_socket;
   select_serial_info *device_specific_serial;
   select_signalfd_info *device_specific_signalfd;
@@ -102,6 +108,7 @@ public:
   select_stuff (): return_on_signal (false), always_ready (false),
 		   windows_used (false), start (),
 		   device_specific_pipe (NULL),
+		   device_specific_fifo (NULL),
 		   device_specific_socket (NULL),
 		   device_specific_serial (NULL),
 		   device_specific_signalfd (NULL) {}
--=20
2.17.0

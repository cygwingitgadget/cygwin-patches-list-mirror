Return-Path: <cygwin-patches-return-5878-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16031 invoked by alias); 29 May 2006 09:03:37 -0000
Received: (qmail 16019 invoked by uid 22791); 29 May 2006 09:03:36 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 29 May 2006 09:03:32 +0000
Received: from mail.artimi.com ([192.168.1.3]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Mon, 29 May 2006 09:48:51 +0100
Received: from rainbow ([192.168.1.165]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Mon, 29 May 2006 09:48:50 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: Fix leaky pipe
Date: Mon, 29 May 2006 09:03:00 -0000
Message-ID: <022401c682fc$b51c2d50$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----=_NextPart_000_0225_01C68305.16E09550"
X-Mailer: Microsoft Office Outlook 11
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00066.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0225_01C68305.16E09550
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 1374



  As discussed elsewhere, here's a patch that solves the race problem without leaking handles any more by placing the
master-pipe-closing logic where it really belongs, in fhandler_tty_common::close where the send-an-EOF decision is made.  I figured
4 extra bytes in the vtable isn't too bad, it's not like you expect to have millions of terminals open at once.

  This isn't ready to checkin immediately because I haven't had a chance to test it yet.  It builds OK but I have to wait for my gcc
testsuite run to complete before I can actually replace the dll and test it.  Once that's out of the way, I'll test it and run the
before-and-after testsuite; if I have to make changes I will resubmit but I don't expect to.


2006-05-29  Dave Korn  <dave.korn@artimi.com>

winsup/cygwin/

	* fhandler.h (fhandler_tty_common::pre_eof_hook):  New virtual
	member function for use of masters when shutting down.
	(fhandler_pty_master::pre_eof_hook):  Declare override. 
	* fhandler_tty.cc (fhandler_tty_common::close):  Call pre_eof_hook
	before signalling EOF to slaves if master no longer alive.
	(fhandler_tty_common::pre_eof_hook):  Do-nothing stub.
	(fhandler_pty_master::pre_eof_hook):  Close master pipes here to
	avoid race condition.
	(fhandler_pty_master::close):  Remove code now in pre_eof_hook.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_0225_01C68305.16E09550
Content-Type: application/octet-stream;
	name="leaky-pipe-patch.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="leaky-pipe-patch.diff"
Content-length: 3916

Index: winsup/cygwin/fhandler.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v=0A=
retrieving revision 1.290=0A=
diff -p -u -r1.290 fhandler.h=0A=
--- winsup/cygwin/fhandler.h	25 May 2006 05:40:51 -0000	1.290=0A=
+++ winsup/cygwin/fhandler.h	29 May 2006 02:11:49 -0000=0A=
@@ -967,6 +967,7 @@ class fhandler_tty_common: public fhandl=0A=
   select_record *select_write (select_record *s);=0A=
   select_record *select_except (select_record *s);=0A=
   bool is_slow () {return 1;}=0A=
+  virtual void pre_eof_hook (void);=0A=
 };=0A=
=20=0A=
 class fhandler_tty_slave: public fhandler_tty_common=0A=
@@ -1023,6 +1024,7 @@ public:=0A=
   void set_close_on_exec (bool val);=0A=
   bool hit_eof ();=0A=
   int get_unit () const { return slave.minor; }=0A=
+  virtual void pre_eof_hook (void);=0A=
 };=0A=
=20=0A=
 class fhandler_tty_master: public fhandler_pty_master=0A=
Index: winsup/cygwin/fhandler_tty.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v=0A=
retrieving revision 1.166=0A=
diff -p -u -r1.166 fhandler_tty.cc=0A=
--- winsup/cygwin/fhandler_tty.cc	22 May 2006 04:50:54 -0000	1.166=0A=
+++ winsup/cygwin/fhandler_tty.cc	29 May 2006 02:11:49 -0000=0A=
@@ -1207,6 +1207,8 @@ fhandler_tty_common::close ()=0A=
   if (!get_ttyp ()->master_alive ())=0A=
     {=0A=
       termios_printf ("no more masters left. sending EOF");=0A=
+      /* If this is the master, it needs to close the master pipes now.  *=
/=0A=
+      pre_eof_hook ();=0A=
       SetEvent (input_available_event);=0A=
     }=0A=
=20=0A=
@@ -1221,6 +1223,34 @@ fhandler_tty_common::close ()=0A=
   return 0;=0A=
 }=0A=
=20=0A=
+void=0A=
+fhandler_tty_common::pre_eof_hook (void)=0A=
+{=0A=
+  /* Nothing is needed in the slave/default case.  */=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_pty_master::pre_eof_hook (void)=0A=
+{=0A=
+  termios_printf ("freeing tty%d (%d)", get_unit (), get_ttyp ()->ntty);=
=0A=
+#if 0=0A=
+  if (get_ttyp ()->to_slave)=0A=
+    ForceCloseHandle1 (get_ttyp ()->to_slave, to_slave);=0A=
+  if (get_ttyp ()->from_slave)=0A=
+    ForceCloseHandle1 (get_ttyp ()->from_slave, from_slave);=0A=
+#endif=0A=
+  /* We must close the master pipes before the input_available_event is=0A=
+  signalled, or there is a race condition where the slave might see it as=
=0A=
+  a read of zero bytes instead of an EOF meaning SIGHUP.  */=0A=
+  if (get_ttyp ()->from_master)=0A=
+    CloseHandle (get_ttyp ()->from_master);=0A=
+  if (get_ttyp ()->to_master)=0A=
+    CloseHandle (get_ttyp ()->to_master);=0A=
+=0A=
+  if (!hExeced)=0A=
+    get_ttyp ()->init ();=0A=
+}=0A=
+=0A=
 int=0A=
 fhandler_pty_master::close ()=0A=
 {=0A=
@@ -1229,27 +1259,7 @@ fhandler_pty_master::close ()=0A=
     continue;=0A=
 #endif=0A=
=20=0A=
-  if (get_ttyp ()->master_alive ())=0A=
-    fhandler_tty_common::close ();=0A=
-  else=0A=
-    {=0A=
-      termios_printf ("freeing tty%d (%d)", get_unit (), get_ttyp ()->ntty=
);=0A=
-#if 0=0A=
-      if (get_ttyp ()->to_slave)=0A=
-	ForceCloseHandle1 (get_ttyp ()->to_slave, to_slave);=0A=
-      if (get_ttyp ()->from_slave)=0A=
-	ForceCloseHandle1 (get_ttyp ()->from_slave, from_slave);=0A=
-#endif=0A=
-      if (get_ttyp ()->from_master)=0A=
-	CloseHandle (get_ttyp ()->from_master);=0A=
-      if (get_ttyp ()->to_master)=0A=
-	CloseHandle (get_ttyp ()->to_master);=0A=
-=0A=
-      fhandler_tty_common::close ();=0A=
-=0A=
-      if (!hExeced)=0A=
-	get_ttyp ()->init ();=0A=
-    }=0A=
+  fhandler_tty_common::close ();=0A=
=20=0A=
   return 0;=0A=
 }=0A=

------=_NextPart_000_0225_01C68305.16E09550--

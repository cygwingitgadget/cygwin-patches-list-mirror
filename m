Return-Path: <cygwin-patches-return-4234-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26107 invoked by alias); 25 Sep 2003 03:46:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26096 invoked from network); 25 Sep 2003 03:46:32 -0000
Message-Id: <3.0.5.32.20030924233929.0082cd30@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 25 Sep 2003 03:46:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Fixing the delete queue security
In-Reply-To: <20030925004355.GA13801@redhat.com>
References: <3.0.5.32.20030915211808.0081d6d0@incoming.verizon.net>
 <3.0.5.32.20030915211808.0081d6d0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1064475569==_"
X-SW-Source: 2003-q3/txt/msg00250.txt.bz2

--=====================_1064475569==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 396

This is the second part of the patch, class cleanup and Makefile update.

Pierre


2003-09-25  Pierre Humblet <pierre.humblet@ieee.org>

	* shared_info.h: Update CURR_USER_MAGIC, CURR_SHARED_MAGIC and
	SHARED_INFO_CB.
	(mount_info::cb): Delete.
	(mount_info::version): Delete.
	(shared_info::delqueue): Delete.
	* Makefile.in: Do magic for USER_MAGIC, class user_info, instead
	of for mount_info.
--=====================_1064475569==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="delqueue2.diff"
Content-length: 2517

Index: shared_info.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
retrieving revision 1.36
diff -u -p -r1.36 shared_info.h
--- shared_info.h	25 Sep 2003 03:06:36 -0000	1.36
+++ shared_info.h	25 Sep 2003 03:32:49 -0000
@@ -43,8 +43,8 @@ class mount_item
 #define MAX_MOUNTS 30

 #define USER_VERSION	1	// increment when mount table changes and
-#define USER_VERSION_MAGIC CYGWIN_VERSION_MAGIC (MOUNT_MAGIC, USER_VERSION)
-#define CURR_MOUNT_MAGIC 0x6dd73a3fU
+#define USER_VERSION_MAGIC CYGWIN_VERSION_MAGIC (USER_MAGIC, USER_VERSION)
+#define CURR_USER_MAGIC 0x8dc7b1d5U

 class reg_key;
 struct device;
@@ -55,8 +55,6 @@ struct device;
 class mount_info
 {
  public:
-  DWORD version;
- unsigned cb;
   DWORD sys_mount_table_counter;
   int nmounts;
   mount_item mount[MAX_MOUNTS];
@@ -147,9 +145,9 @@ public:
 				  cygwin_version.api_minor)
 #define SHARED_VERSION_MAGIC CYGWIN_VERSION_MAGIC (SHARED_MAGIC, SHARED_VE=
RSION)

-#define SHARED_INFO_CB 47112
+#define SHARED_INFO_CB 21008

-#define CURR_SHARED_MAGIC 0x359218a2U
+#define CURR_SHARED_MAGIC 0x818f75beU

 /* NOTE: Do not make gratuitous changes to the names or organization of the
    below class.  The layout is checksummed to determine compatibility betw=
een
@@ -163,7 +161,6 @@ class shared_info
   DWORD sys_mount_table_counter;

   tty_list tty;
-  delqueue_list delqueue;
   void initialize ();
   unsigned heap_chunk_size ();
 };
Index: Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.138
diff -u -p -r1.138 Makefile.in
--- Makefile.in	25 Sep 2003 00:37:16 -0000	1.138
+++ Makefile.in	25 Sep 2003 03:32:50 -0000
@@ -377,7 +377,7 @@ version.cc winver.o: winver_stamp
 	@ :

 shared_info_magic.h: cygmagic shared_info.h
-	/bin/sh ${word 1,$^} $@ "$(CC) -x c" ${word 2,$^} MOUNT_MAGIC 'class moun=
t_info' SHARED_MAGIC 'class shared_info'
+	/bin/sh ${word 1,$^} $@ "$(CC) -x c" ${word 2,$^} USER_MAGIC 'class user_=
info' SHARED_MAGIC 'class shared_info'

 child_info_magic.h: cygmagic child_info.h
 	/bin/sh ${word 1,$^} $@ "$(CC) -x c" ${word 2,$^} CHILD_INFO_MAGIC 'class=
 child_info'

--=====================_1064475569==_--

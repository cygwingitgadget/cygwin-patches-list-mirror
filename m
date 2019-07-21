Return-Path: <cygwin-patches-return-9499-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18698 invoked by alias); 21 Jul 2019 01:53:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18608 invoked by uid 89); 21 Jul 2019 01:53:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730101.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.101) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 01:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=gOA8khrjceF0QX0vUTHbxuRGvyw6jWn9qK26jb2iN/QGaF5sOjBI0AsBCglZkVjtXAoQlpgTkL7SMYvj348sjKVJtzusB56XsKYM29J7BFt4FIk9oFOE1YUUtetz3agrrxid0QbFahySjATcCvlKEuU1QpCfcCR0KDgzUJ3i0/9kE7Y5uCjxA59HFfakhwI3Ve3KlBbcZ3eTFi1Tc/P1X6PR9UCl7ruDg++2uB+9OFYnOT3N+rxhEFX5ZbRMrVqIka/0V5FIWd2YTesGd7QhOqoGwzFHz0IUcZtYuhImacCZTvtjz6WdDq3Qc7UDnvyOu+KDOjaLgkNgBJea7/1ArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8+2cDh5Ty3iRQyOasHdc+L5RbnzoJdOGGKSxKV7e9YA=; b=muVJJ9w4DMlrIkvVcEAtfJezYDfs6XBwUtpsmesKyknkhX5Q5C0POauEfw6rGupxMgW/vuJAeZDlDcFoQhcTfP3uAtUfHgfDRhwrehyPXjE1JoxTn8muA3XGgTlO5v4r6rjiCNUlJH1fB1d0a47rhEjzg4r6r4fyWCmEvjGVXdCAqpUyokPDu/OZgBHxGzlNBZD1mEsWsM7tH3E14or7ydmtbuYGu7JolUPhXD+8ST4hRC13cn/c8BU0cNBteNCnQA/mo6FjUGSMetFejtkBYw6z1Q+dI1gSnh/kcC/WeQV5MVkRsnWAS+EO3NQWQTV8KMISPP/9+YX9LpKPyFkQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8+2cDh5Ty3iRQyOasHdc+L5RbnzoJdOGGKSxKV7e9YA=; b=B8vek1VmXEWh1h1ZaMJ5+dRqsHXX+7EFsNOBVpvN4QbV2HqlFukYwpA4OLV91pgJ1udi19NSVayFytL9IT/IOyQ1FkKeIpcZnqKhsqbkImVDMsNw7KSzDKYXSu0rQpo4t8FJdDCIt+EAX4LZfzDA4vuFDjKUCRQrxyhVvgc1LGQ=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2313.namprd04.prod.outlook.com (10.166.204.8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14; Sun, 21 Jul 2019 01:53:01 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.013; Sun, 21 Jul 2019 01:53:01 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 1/4] Cygwin: fhandler_*: remove isdevice() and is_auto_device()
Date: Sun, 21 Jul 2019 01:53:00 -0000
Message-ID: <20190721015238.2127-2-kbrown@cornell.edu>
References: <20190721015238.2127-1-kbrown@cornell.edu>
In-Reply-To: <20190721015238.2127-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:5516;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00020.txt.bz2

isdevice() is used only in the definition of is_auto_device().  And
the latter is used only once, in a context where isdevice() always
returns true.
---
 winsup/cygwin/fhandler.h      | 3 ---
 winsup/cygwin/fhandler_raw.cc | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 0da87e985..e0a8d4101 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -414,7 +414,6 @@ public:
   virtual bool is_tty () const { return false; }
   virtual bool ispipe () const { return false; }
   virtual pid_t get_popen_pid () const {return 0;}
-  virtual bool isdevice () const { return true; }
   virtual bool isfifo () const { return false; }
   virtual int ptsname_r (char *, size_t);
   virtual class fhandler_socket *is_socket () { return NULL; }
@@ -459,7 +458,6 @@ public:
   virtual void seekdir (DIR *, long);
   virtual void rewinddir (DIR *);
   virtual int closedir (DIR *);
-  bool is_auto_device () {return isdevice () && !dev ().isfs ();}
   bool is_fs_special () {return pc.is_fs_special ();}
   bool issymlink () {return pc.issymlink ();}
   bool __reg2 device_access_denied (int);
@@ -1455,7 +1453,6 @@ class fhandler_disk_file: public fhandler_base
   int dup (fhandler_base *child, int);
   void fixup_after_fork (HANDLE parent);
   int mand_lock (int, struct flock *);
-  bool isdevice () const { return false; }
   int __reg2 fstat (struct stat *buf);
   int __reg1 fchmod (mode_t mode);
   int __reg2 fchown (uid_t uid, gid_t gid);
diff --git a/winsup/cygwin/fhandler_raw.cc b/winsup/cygwin/fhandler_raw.cc
index bd47b6010..7c341d895 100644
--- a/winsup/cygwin/fhandler_raw.cc
+++ b/winsup/cygwin/fhandler_raw.cc
@@ -38,7 +38,7 @@ fhandler_dev_raw::fstat (struct stat *buf)
   debug_printf ("here");
=20
   fhandler_base::fstat (buf);
-  if (is_auto_device ())
+  if (!dev ().isfs ())
     {
       if (get_major () =3D=3D DEV_TAPE_MAJOR)
 	buf->st_mode =3D S_IFCHR | STD_RBITS | STD_WBITS | S_IWGRP | S_IWOTH;
--=20
2.21.0

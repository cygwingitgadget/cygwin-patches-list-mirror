Return-Path: <cygwin-patches-return-9483-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104352 invoked by alias); 16 Jul 2019 17:34:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104284 invoked by uid 89); 16 Jul 2019 17:34:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=nlen
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820093.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jul 2019 17:34:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=FeftK8aV6iYaDTeNA7zKulVaVI/ayusOXNfb9nbiYMyuR5H8iu43PJ10f1H9pm9KyRJjSOv4VJo69dCKLN1fZh1i/lya3+wUbG7FYKx2+MzMNmotaS6pOigH3WpxbN6eITwcnTQT+OYiT4KH3JvcEXfjefDYaC37OU/iylXzN8ysBs+s7ZkjEbIq7tfBDjod/gBD7CrUlmtQ1wPSWPaXurzg0eWQcRenaruOzx9ZFi5SJxd7iF+Y9IfUcenEA3i6AQuMy7c3lyWd3jXf/xCB/KpDgA9/Tq/RIzpRb4XYCJv1iA7YUEdhprEJ2nquuiivwbgZje2PSkDvdWkjk32Wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=/xSTwEfWxXoFaxpX6XF5VM6B8vzZRhHYjDuUC9KVEIQ=; b=kLnFOZXKxJxHhPebi/EZ8ullPgWMbGrWud05VpW4cx2rS649QZgztLiZyH8oAhncI5C2kP4Eyo9OkmsNqj9sdSzFiFq3haAWJmYBwQknJaVDKxGec0N2SsZGti5MEvZn37wNEP4M8D/8GmRM0t1q9N2Z+S0J4VzyUK1npvEpw4Ew2/s0cSvW6lB0SyVJqeN+1lj5x7gu3XnJBlPKS4ymigaboVO1BR/B9jxTzTRYx4rPyQ7tm6N3kh8aHgP+dxDXe3XVi0E8LywmiIxCdCA8BHdEbGBV5YwrnnzvUUubIv7PZ6+rIbCDO+LuhEi0jYZCzL4M2uqjZUmXx27m16BQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=/xSTwEfWxXoFaxpX6XF5VM6B8vzZRhHYjDuUC9KVEIQ=; b=S8eBd+KvaIN8euWYD8d98ZG7f6LSISAjS64giGa2gP3MIJfzKhvr/p4EFNP9nW+2bGF+EbtScp+w7iPN5t5i/fmSyX8DCBfky5VvECyh8V7ZSGd3jRkqYL7k2NcBOfWPrDLlFVmhWD93OetTaSs5I4S2hqv8cFLRzwG4pWdrG3E=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2234.namprd04.prod.outlook.com (10.167.16.18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Tue, 16 Jul 2019 17:34:24 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019 17:34:24 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 1/5] Cygwin: avoid GCC 8.3 errors with -Werror=class-memaccess
Date: Tue, 16 Jul 2019 17:34:00 -0000
Message-ID: <20190716173407.17040-2-kbrown@cornell.edu>
References: <20190716173407.17040-1-kbrown@cornell.edu>
In-Reply-To: <20190716173407.17040-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00003.txt.bz2

---
 winsup/cygwin/flock.cc | 2 +-
 winsup/cygwin/path.cc  | 4 ++--
 winsup/cygwin/path.h   | 2 +-
 winsup/cygwin/pinfo.cc | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 860791d7b..74374d727 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -1736,7 +1736,7 @@ lf_split (lockf_t *lock1, lockf_t *lock2, lockf_t **s=
plit)
   splitlock =3D *split;
   assert (splitlock !=3D NULL);
   *split =3D splitlock->lf_next;
-  memcpy (splitlock, lock1, sizeof *splitlock);
+  memcpy ((void *) splitlock, lock1, sizeof *splitlock);
   /* We have to unset the obj HANDLE here which has been copied by the
      above memcpy, so that the calling function recognizes the new object.
      See post-lf_split handling in lf_setlock and lf_clearlock. */
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 158f1e5fb..8da858da1 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1299,7 +1299,7 @@ path_conv::serialize (HANDLE h, unsigned int &n) const
       n =3D 0;
       return NULL;
     }
-  memcpy (&pcf->pc, this, sizeof *this);
+  memcpy ((void *) &pcf->pc, this, sizeof *this);
   pcf->hdl =3D h;
   pcf->name_len =3D nlen;
   pcf->posix_len =3D plen;
@@ -1318,7 +1318,7 @@ path_conv::deserialize (void *bufp)
   char *p;
   HANDLE ret;
=20
-  memcpy (this, &pcf->pc, sizeof *this);
+  memcpy ((void *) this, &pcf->pc, sizeof *this);
   wide_path =3D uni_path.Buffer =3D NULL;
   uni_path.MaximumLength =3D uni_path.Length =3D 0;
   path =3D posix_path =3D NULL;
diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index 0c94c6152..69af5a01c 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -313,7 +313,7 @@ class path_conv
   path_conv& eq_worker (const path_conv& pc, const char *in_path)
   {
     free_strings ();
-    memcpy (this, &pc, sizeof pc);
+    memcpy ((void *) this, &pc, sizeof pc);
     /* The device info might contain pointers to allocated strings, in
        contrast to statically allocated strings.  Calling device::dup()
        will duplicate the string if the source was allocated. */
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index d002268ed..cdbd8bd7e 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -1418,12 +1418,12 @@ winpids::add (DWORD& nelem, bool winpid, DWORD pid)
     {
       npidlist +=3D slop_pidlist;
       pidlist =3D (DWORD *) realloc (pidlist, size_pidlist (npidlist + 1));
-      pinfolist =3D (pinfo *) realloc (pinfolist, size_pinfolist (npidlist=
 + 1));
+      pinfolist =3D (pinfo *) realloc ((void *) pinfolist, size_pinfolist =
(npidlist + 1));
     }
=20
   _onreturn onreturn;
   pinfo& p =3D pinfolist[nelem];
-  memset (&p, 0, sizeof (p));
+  memset ((void *) &p, 0, sizeof (p));
=20
   bool perform_copy;
   if (cygpid =3D=3D myself->pid)
--=20
2.21.0

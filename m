Return-Path: <cygwin-patches-return-9756-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51794 invoked by alias); 9 Oct 2019 20:06:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51039 invoked by uid 89); 9 Oct 2019 20:06:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr710105.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) (40.107.71.105) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 09 Oct 2019 20:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=T7Ou+LXAVi40HwAFPAXLJ++bzptFNhn4yWXfFawE9t/ZIFZ3p6MJuL/ciDppoWeYLhAEvEwlnGRVihHwQXCJ8FqnhMBjcXgNWL059DpCaT5gMf3pdAq8qqWobEauKpRrQ0XGVGopB8RHtkA/vhw/SrOIxOI65L7fvJR2Hyb/A4AZNeF8Evcov8g4tX49jjew78GWNiD37Gc0Ek94EGo9JFz62RPxuJ8DwIm+x0sM0hg9Ccm/3HFrG9nGwHofcv3adjSP0MwoSCzkJxpvqoYwMgvkvhNvVJ15aOtzMW5v/Ml+Iz8YIiG0yVlBrshsZqg4NyD2uClaTqJEvi9xWGLf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=bhm/b3h0agjmNx2dzgmkRVIqDqq6hykAFc68SaX6MI0=; b=MiNTTTThPTyadomNMAwerzb1BgdrsK7mzAmS6cZg/xIek8ENkepYUqE0SrBjNIHxx3PiWPfC9Plo8dzcboRns23kW2Ab1cahRAjmTSwKLiYi5to3Gyc1Var3KUVtf60Cn9Vq4rEOSJZ6F2vdsXA5JkHzsrUzuU7af9Fp0X/8c/tL3TBmXp8g2iepVyWwgHPQK/pANcYF+jJS+9kOej0d4Qmo7dUW0Eptzgs4OjiYqy9GYrAkz/kc4sJRg7cfWDApyf3ofFwj71Uh6QHlozCN0GghRHelo9HM4dpHZgdZ1xmHoVbm3p4S15lHGYOX/wsPglh4PhdpNs/7vrG7E/SiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=bhm/b3h0agjmNx2dzgmkRVIqDqq6hykAFc68SaX6MI0=; b=CMF79f1HZS0ymyuGurVDHSSgbZ/G+zqEW8AflhDfNrMM58XXCjItFZ+fAtEdbgGy5j9oTtfKXDnmpfcnywZesF4bk9ZEmD1zNrVTcQ9DjopJyT/T4g1wgcUX7fxqN/I0qqESEDIZg6riEuZBLbhFjrAxVGAvXbCI9ACsAGSR/hk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB3897.namprd04.prod.outlook.com (20.176.86.154) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Wed, 9 Oct 2019 20:06:03 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172%4]) with mapi id 15.20.2327.023; Wed, 9 Oct 2019 20:06:03 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: spawnvp, spawnvpe: fail if executable is not in $PATH
Date: Wed, 09 Oct 2019 20:06:00 -0000
Message-ID: <20191009200545.1641-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 2
x-ms-oob-tlc-oobclassifiers: OLM:6790;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R97J6nUse0LRDtCky8avvGJJuIrR50lXDOoRgcFn+RFGr3DzWvILz12dwmBJ5mDvp9+ieiN7D6jS9EHKrNFJ1g==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00027.txt.bz2

Call find_exec with the FE_NNF flag to enforce a NULL return when the
executable isn't found in $PATH.  Convert NULL to "".  This aligns
spawnvp and spawnvpe with execvp and execvpe.
---
 winsup/cygwin/release/3.1.0 | 3 +++
 winsup/cygwin/spawn.cc      | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/release/3.1.0 b/winsup/cygwin/release/3.1.0
index 3f2f3c86b..fb0e37215 100644
--- a/winsup/cygwin/release/3.1.0
+++ b/winsup/cygwin/release/3.1.0
@@ -91,3 +91,6 @@ Bug Fixes
 - If the argument to mkdir(2) or rmdir(2) is 'x:\', don't strip the
   trailing backslash.
   Addresses: https://cygwin.com/ml/cygwin/2019-08/msg00334.html
+
+- Make spawnvp, spawnvpe fail if the executable is not in $PATH.
+  Addresses: https://cygwin.com/ml/cygwin/2019-10/msg00032.html
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index f8090a6a4..f82860e72 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -1081,8 +1081,9 @@ extern "C" int
 spawnvp (int mode, const char *file, const char * const *argv)
 {
   path_conv buf;
-  return spawnve (mode | _P_PATH_TYPE_EXEC, find_exec (file, buf), argv,
-		  cur_environ ());
+  return spawnve (mode | _P_PATH_TYPE_EXEC,
+		  find_exec (file, buf, "PATH", FE_NNF) ?: "",
+		  argv, cur_environ ());
 }
=20
 extern "C" int
@@ -1090,7 +1091,9 @@ spawnvpe (int mode, const char *file, const char * co=
nst *argv,
 	  const char * const *envp)
 {
   path_conv buf;
-  return spawnve (mode | _P_PATH_TYPE_EXEC, find_exec (file, buf), argv, e=
nvp);
+  return spawnve (mode | _P_PATH_TYPE_EXEC,
+		  find_exec (file, buf, "PATH", FE_NNF) ?: "",
+		  argv, envp);
 }
=20
 int
--=20
2.21.0

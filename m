Return-Path: <cygwin-patches-return-10015-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122309 invoked by alias); 27 Jan 2020 13:21:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122245 invoked by uid 89); 27 Jan 2020 13:21:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690139.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Jan 2020 13:21:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=oP/WjqRyUPULrADw0fnU++M7WllMXO5DG7AMa3oaYs4i1tzXq7Y37VRMcs81sGVKLpihA+FxDHbhIUIVkjoxBKaVD7R4IWfgnO/8jRIWnsCro5STSweUn798itVyPxOTmfQTsYnqYSkXmwEViPtrL5X8HFldeRR3WEq475gJ54kwf5QmDHKwZMBvYmMR4nXI7TA+ZIgOHblw7S+I1emBV+6DPFxN9Pznyy2zOCNfzxxg0Xg3SKWhKcj2B1qhlHaYgisGfhg2qHsVBH6XsBktpbnSzMoATmuAGy0AfGKhExP5sJaauFLappHfK3aYf4288hfuzzoEOUWBgaS55OZbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=tvdyVglXkP3cSlyzXDtxmiVt2Utcx+JdVP1A9jqSRPY=; b=ju9QhpUxUytBvtOh3rSyqow/3smykuJa5IuQDQJgnxUpFOi2w4zNd1SfnrYZvZFKrzoAtSj+QwoupLR/5mKU70dFPbV5Gq01BtXUFvQ3GNt6HO7MA7a9uECvUOu/FgiSrkv8LqNi1LZB4eNaYvPfiwTamVzgYGnS1zq+XUh/mhA+snd/RvSBORidSL1eI6o2Q08KvQN6xYKA8cEFEGD9q7qvRDth+aZbdeYPNlDY74yHCk9bBaupEaYjMdIRs64HfIPBvXms36hETJh6SR27gWQesvimxUolLyvS/QxeDtH3/ba2XauI1yerYaH7DopxVWk7tbgNaPYyAkIxW/COFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=tvdyVglXkP3cSlyzXDtxmiVt2Utcx+JdVP1A9jqSRPY=; b=eOVVEWdSuzq5w+nZEzKGouFYBbThISZMIT6vzRAK06RnR/+J/IJRuYwLf1UlykOTGB/Ju/4AbZ0lhnpnjUwZdfksk+skm7fRdMjjxBkvict+rwu8Z/ikzzipE+Cvj0vgraw2Iqhbuc0E+i11N9xEqkQ9B+YWb4mUy6MSk8Q+Y4k=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4859.namprd04.prod.outlook.com (20.176.109.28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Mon, 27 Jan 2020 13:21:15 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020 13:21:15 +0000
Received: from localhost.localdomain (65.112.130.194) by BN3PR03CA0107.namprd03.prod.outlook.com (2603:10b6:400:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Mon, 27 Jan 2020 13:21:15 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 2/3] Cygwin: fhandler_disk_file::fstatvfs: refactor
Date: Mon, 27 Jan 2020 13:21:00 -0000
Message-ID: <20200127132050.4143-3-kbrown@cornell.edu>
References: <20200127132050.4143-1-kbrown@cornell.edu>
In-Reply-To: <20200127132050.4143-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2276;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: Lxp6ugYf27q1VJLvM7rHj40Os8FpDgXnvRq83la0fMkZbtsT3dgngrAekEEDMlGY1iANJJvZZ7cj69sN+smfCevYc+kbQ5MhsXPyWuPVBSFhHCoBT+tsiJ+aneZIDOfwNJmwGJRT5qkK5E5kN+GA8A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRKhAVbQ8GYbWstb+Sr3nvk195KFZj1/69EwLrlOp5fBEN3X+T2ZL/dfLhp0HJCT60MoSB2vrVUKhWX2VhczXw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00121.txt

Define a new method fhandler_base::fstatvfs_by_handle, extracted from
fhandler_disk_file::fstatvfs, which gets the statvfs information when
a handle is available.

This will be used in future commits for special files that have been
opened with O_PATH.
---
 winsup/cygwin/fhandler.h            |  1 +
 winsup/cygwin/fhandler_disk_file.cc | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c0d56b4da..5fa720a83 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -381,6 +381,7 @@ private:
   int __reg2 fstat_by_name (struct stat *buf);
 public:
   virtual int __reg2 fstatvfs (struct statvfs *buf);
+  int __reg2 fstatvfs_by_handle (HANDLE h, struct statvfs *buf);
   int __reg2 utimens_fs (const struct timespec *);
   virtual int __reg1 fchmod (mode_t mode);
   virtual int __reg2 fchown (uid_t uid, gid_t gid);
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_d=
isk_file.cc
index a1ab2bbdd..89e651029 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -600,9 +600,7 @@ int __reg2
 fhandler_disk_file::fstatvfs (struct statvfs *sfs)
 {
   int ret =3D -1, opened =3D 0;
-  NTSTATUS status;
   IO_STATUS_BLOCK io;
-  FILE_FS_FULL_SIZE_INFORMATION full_fsi;
   /* We must not use the stat handle here, even if it exists.  The handle
      has been opened with FILE_OPEN_REPARSE_POINT, thus, in case of a volu=
me
      mount point, it points to the FS of the mount point, rather than to t=
he
@@ -630,6 +628,22 @@ fhandler_disk_file::fstatvfs (struct statvfs *sfs)
 	}
     }
=20
+  ret =3D fstatvfs_by_handle (fh, sfs);
+out:
+  if (opened)
+    NtClose (fh);
+  syscall_printf ("%d =3D fstatvfs(%s, %p)", ret, get_name (), sfs);
+  return ret;
+}
+
+int __reg2
+fhandler_base::fstatvfs_by_handle (HANDLE fh, struct statvfs *sfs)
+{
+  int ret =3D -1;
+  NTSTATUS status;
+  IO_STATUS_BLOCK io;
+  FILE_FS_FULL_SIZE_INFORMATION full_fsi;
+
   sfs->f_files =3D ULONG_MAX;
   sfs->f_ffree =3D ULONG_MAX;
   sfs->f_favail =3D ULONG_MAX;
@@ -688,10 +702,6 @@ fhandler_disk_file::fstatvfs (struct statvfs *sfs)
     debug_printf ("%y =3D NtQueryVolumeInformationFile"
 		  "(%S, FileFsFullSizeInformation)",=20
 		  status, pc.get_nt_native_path ());
-out:
-  if (opened)
-    NtClose (fh);
-  syscall_printf ("%d =3D fstatvfs(%s, %p)", ret, get_name (), sfs);
   return ret;
 }
=20
--=20
2.21.0

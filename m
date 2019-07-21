Return-Path: <cygwin-patches-return-9497-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18337 invoked by alias); 21 Jul 2019 01:53:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18328 invoked by uid 89); 21 Jul 2019 01:53:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=cygwincom, UD:cygwin.com, cygwin.com, winsup
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730101.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.101) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 01:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=TuB2gAg0p9Dsk5JLkYbpyKhwTp3OemiQXR7gS9fKQMULqaZY91t7W8wozwyb94Hc/fVnt/vW70g4VI3bVGOKxHC6GElm4lkwhZGZGpzCaLG1v2gfBsYeSXNCbVReRCb5Uy09BNHPYUpQ0pjV8AtXwpJv5YQijO+K52/EJgshIGIcgmk87laID/BrkTGYFLF9qIj2JVjTPfido5S0YZb2FS8KXffjfDRWILs6P2fihNWfjmaKyZB36qFapOlrb7wTk4zDHF8iVoc4hQLwI4w1VCLfxxmRpvgSWbniFDhZcBClSxHrXi/qeD2rYkYAtQHIu6Uu9g0K6Z3YCa4ycwrwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8rrb1wdu0cPbQhfj+QVerlLFjnJsYvDIM8e4/NCOo7o=; b=jEmmsxuzM+J+VvT7VzB7JQMFTOAnuSHU4z0tYhB6fBmTpM7tmq7iat/H7RftpLNmQPAPc6Rmti4RaoccyBvxgeNGobDcNGOGRqtpyxAKO1usChAA3zKIHt50jG44duntOYOxwfEysXNh+Er5an4oRKX+q9nBkMudhw3st0DJB1TXnlG+IDcv3/IxM2hPHRE1JHl+tEu5mQyyaxOCK0rsf62G9Pg9EKXAOQiQxC+S8J1Fzu4G945IZtj67pn8fJH7bE3+ILmLE0bf3z2V5D8bygzejWKJDB0w9nbBYJ7hpu/vWyNHkAXaBeXz8Gl11UYtWihUPOZskmgrm6Y+/ksCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=8rrb1wdu0cPbQhfj+QVerlLFjnJsYvDIM8e4/NCOo7o=; b=Srjn7MkOVh5xFqLJcMnrE6zxNEfhtOTBcSsUvC7HfKVSp14WkSB8b65N0PjpFRbtXRcU4C1d2b454YbEaxLLARDHky5YO2RNb6k1XUQU6XmGLl4WiaDU+M5ikDLZ8WaXlo612y105ITYiNk/CAJ7dHHWN3fWOPfzNLPIaHvH65k=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2313.namprd04.prod.outlook.com (10.166.204.8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14; Sun, 21 Jul 2019 01:53:00 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.013; Sun, 21 Jul 2019 01:53:00 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 0/4] Fix rename bug with socket files
Date: Sun, 21 Jul 2019 01:53:00 -0000
Message-ID: <20190721015238.2127-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:5797;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00017.txt.bz2

The last patch of this series fixes the bug reported here:

  https://cygwin.com/ml/cygwin/2019-07/msg00139.html

The first three patches do some cleanup of the is**device() methods.

Ken

Ken Brown (4):
  Cygwin: fhandler_*: remove isdevice() and is_auto_device()
  Cygwin: remove path_conv::is_auto_device()
  Cygwin: remove path_conv::is_fs_device()
  Cygwin: socket files are not lnk special files

 winsup/cygwin/fhandler.h            | 3 ---
 winsup/cygwin/fhandler_disk_file.cc | 4 ++--
 winsup/cygwin/fhandler_raw.cc       | 2 +-
 winsup/cygwin/path.cc               | 2 +-
 winsup/cygwin/path.h                | 7 ++++---
 5 files changed, 8 insertions(+), 10 deletions(-)

--=20
2.21.0

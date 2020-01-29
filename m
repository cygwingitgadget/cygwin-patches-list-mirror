Return-Path: <cygwin-patches-return-10030-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40555 invoked by alias); 29 Jan 2020 17:22:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40464 invoked by uid 89); 29 Jan 2020 17:22:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2092.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.92) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 17:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=VqCqdKE0Dj24bl3XgfJ/gxxWRK9qfTjhBv9OqgnDXcAOZXy//4kBE0u19AdmnhpT9bpBriERbs3OD5gJMuPtSfb+CHhVosvJWSdSJiXTYfpUDbA0Rf+wtJ0w8h44t/dt4Pt2tBAW63X17/C4FMEx5a9r7gCgqlolFolS66WPsHzrGpUSjlMJtUBtLsPgWutL0/2eXIxJUkUeNskaGY11jDs7WlSXMT2lzMo2vCRLSfCHuRvyr3sgAjMmV56lwQUtShi8RalWXZDRCKQOWKtZUW+fn0snkSE8engypVyi73+ln3dLDApbCG5tanui+dKm2pI9wbAgU959EarBzu8vSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ib0L+8UNUgTi+8Tiievz/3DvNJf/IJUKfAag8aNkus0=; b=j1fgonNd8vg5uwrSsRQfAV9fH+hfRevXpvKIbqVr/JQ3jhfg9O64aeo66C1DtDwe+dU+Zc63ORGYZkO562bOhvjaC87TOTfUvaeuL8tMbILSTqPm71Rvg2zCPWxCXDoh0T8RTUllck/PE4sqn1n/lNGj5u5ckklqRNE5Lgm59O+udnJedd5/4XM7wLP5CS/Rv+/wKL4OzVruEthfy3aMy45DdZrps4ukzz+a6PvAScNr6c6jxm5Gk5blkp7Dk9PvVsEVKcx1U7RnwoTgAimGEV6jpKJuv/m+A9VjHoVFHxKG0RD7v1H4ZtHiTQgiGDAbXaAJ0E56gF6Vi2P90ewBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ib0L+8UNUgTi+8Tiievz/3DvNJf/IJUKfAag8aNkus0=; b=XrupFsCCdu2frkQmcuwk+lpoa4U1eejbq7A2EL5owwIxvPAED5q9G69KN8UxM+1oT3JR875h4G9gxZ/EQhQ2k0ATvQr3IaR7cqsdscTqH8M91SLS+Mn3LRxcQQZQW7sOBh4+VfOm7QvVVRIaymbwX7r5O8NA8lLzkhTbxXDEsRM=
Received: from BYAPR04MB5735.namprd04.prod.outlook.com (20.179.59.153) by BYAPR04MB3896.namprd04.prod.outlook.com (52.135.220.152) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.26; Wed, 29 Jan 2020 17:22:13 +0000
Received: from BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399]) by BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020 17:22:13 +0000
Received: from localhost.localdomain (65.112.130.194) by BN7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:408:34::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 17:22:12 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 4/5] Cygwin: AF_LOCAL: fix fcntl and dup if O_PATH is set
Date: Wed, 29 Jan 2020 17:22:00 -0000
Message-ID: <20200129172147.1566-5-kbrown@cornell.edu>
References: <20200129172147.1566-1-kbrown@cornell.edu>
In-Reply-To: <20200129172147.1566-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:513;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: EN2xnvBnI0Z04G0NYSnLEGSzar5RNOSl609NKbci9hCh/QiJE6ZyZ350G3y+Ff0iLN4yOEyEjzU2UjeKFEQhVSLlmftqibkKa1H4Zm6bRUv1nTTlQAvcOD0Ns4svhQos/iEdnKARmlwaNsw/sp0vaQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mAJeoQyq0mvEvwPXppxUvVVA8SfBx3X4fU89gKjYiq+klbcVxwLVDPslaBub+nswpcXpcN0mk9CRsI2CBe4Dw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00135.txt

For fcntl this requires a new method, fhandler_socket_local::fcntl,
which calls fhandler_base::fcntl if O_PATH is set and
fhandler_socket_wsock::fcntl otherwise.
---
 winsup/cygwin/fhandler.h               |  1 +
 winsup/cygwin/fhandler_socket_local.cc | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c54780ef6..1b477f633 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -836,6 +836,7 @@ class fhandler_socket_local: public fhandler_socket_wso=
ck
=20
   int open (int flags, mode_t mode =3D 0);
   int close ();
+  int fcntl (int cmd, intptr_t);
   int __reg2 fstat (struct stat *buf);
   int __reg2 fstatvfs (struct statvfs *buf);
   int __reg1 fchmod (mode_t newmode);
diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandle=
r_socket_local.cc
index 76815a611..531f574b0 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -628,6 +628,9 @@ fhandler_socket_local::af_local_set_secret (char *buf)
 int
 fhandler_socket_local::dup (fhandler_base *child, int flags)
 {
+  if (get_flags () & O_PATH)
+    return fhandler_base::dup (child, flags);
+
   fhandler_socket_local *fhs =3D (fhandler_socket_local *) child;
   fhs->set_sun_path (get_sun_path ());
   fhs->set_peer_sun_path (get_peer_sun_path ());
@@ -654,6 +657,15 @@ fhandler_socket_local::close ()
     return fhandler_socket_wsock::close ();
 }
=20
+int
+fhandler_socket_local::fcntl (int cmd, intptr_t arg)
+{
+  if (get_flags () & O_PATH)
+    return fhandler_base::fcntl (cmd, arg);
+  else
+    return fhandler_socket_wsock::fcntl (cmd, arg);
+}
+
 int __reg2
 fhandler_socket_local::fstat (struct stat *buf)
 {
--=20
2.21.0

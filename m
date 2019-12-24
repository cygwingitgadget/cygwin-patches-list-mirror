Return-Path: <cygwin-patches-return-9876-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47808 invoked by alias); 24 Dec 2019 19:27:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47798 invoked by uid 89); 24 Dec 2019 19:27:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=edition, socket
X-HELO: NAM02-BL2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr750092.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) (40.107.75.92) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 24 Dec 2019 19:27:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=He73wnqYdFvvzAb0ORS8kPSYQbUcFy+32inirFfURydlOPll5nQ4VvwMROkwASo6WCD6ZFOxh6n5qgO+0Kcwd8bvz4cyFAOXa9JyAla5/XwJsVyRgAe1ZhWjyZoS83dJm7RDx9BIBSRl6LVI5FC1i5gP/G+a035OQORKGESOUvQK5F7vf9gMN1WX9bq79uBu8iIlWfeNQkzjdzGPh6O4GrTaW16mLIMYjBij9k9SpQoGQRYh6VGObAHvgk2mQm2D/fZsiUo8alUSzAZUcixft6tFeY16NW7X88LWw3LWv+4BEnq6LICxuudgIs6QT0B1cvDTUVGjJy8ZCIvZVguimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=K9DfFlaHcUGyDMMMAoxsZXWnbWL3LAV38z8+TuZLJto=; b=c4iv+3SFkUhASqLIcBMCCoDL+QPLHn/YpwrzugcknSbCFpvZCH46jFWm8sV/tcvmrFkOFxoAlfe5qp8UgteQtqFzHQbhhCo/D5sUWUnkv7t3XQinB0C+gxPuumewz/0QMJJWnNS49dmu/bnleGt/8OrIUuytBJ0Y8QOhCRzSDh4AvBdex1kakeKgPGvbLne1wLV51QFL5C7Rkr0oGr6KT997PTBvQATk3Wl9Y8HTX1XW5j6LCJ6/fB8g/hGV9GdyZT94tcRfxjj/3YxAwjZHklG4nkW9vF/WFVRXr9lFvFZOiOyUIzqZxR73EKQ7Ul6rZr9SIWM/8PDZJKla8Ngbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=K9DfFlaHcUGyDMMMAoxsZXWnbWL3LAV38z8+TuZLJto=; b=bHDnEMgRDxRYjw5jxekhLIWYx9V/fWn55SzkuNwuaJgRk+K7fNqyHFbuY9OTQcEErGhfNXy/pScWVD9qaY5wsBF9sKMbvziP0LFp/UMxPrty2R0HCGBDohatfiFRV31M9H8WqfePL0QQtm7RJgfzLOCN1PUGl0gRjOXDxlWmU7Y=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6681.namprd04.prod.outlook.com (10.186.143.206) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Tue, 24 Dec 2019 19:27:39 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019 19:27:39 +0000
Received: from localhost.localdomain (68.175.129.7) by BL0PR02CA0101.namprd02.prod.outlook.com (2603:10b6:208:51::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend Transport; Tue, 24 Dec 2019 19:27:38 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: fhandler_socket::open: set errno according to POSIX
Date: Tue, 24 Dec 2019 19:27:00 -0000
Message-ID: <20191224192722.43497-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6430;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dm1WTg+RPER9218mzMKJ4oCkBLx/oSywwL+QEKfBlSLH/KSwZ1ICcRt2byVU5YMMKLTfRzSDAqkMpjLNquFvSg==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00147.txt.bz2

Set errno to EOPNOTSUPP instead of ENXIO when 'open' is called on a
socket.  This is consistent with POSIX, starting with the 2016
edition.  Earlier editions were silent on this issue.
---
 winsup/cygwin/fhandler_socket.cc | 2 +-
 winsup/cygwin/release/3.1.3      | 5 +++++
 winsup/doc/new-features.xml      | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 winsup/cygwin/release/3.1.3

diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_sock=
et.cc
index 9f33d8087..227004b43 100644
--- a/winsup/cygwin/fhandler_socket.cc
+++ b/winsup/cygwin/fhandler_socket.cc
@@ -269,7 +269,7 @@ fhandler_socket::fcntl (int cmd, intptr_t arg)
 int
 fhandler_socket::open (int flags, mode_t mode)
 {
-  set_errno (ENXIO);
+  set_errno (EOPNOTSUPP);
   return 0;
 }
=20
diff --git a/winsup/cygwin/release/3.1.3 b/winsup/cygwin/release/3.1.3
new file mode 100644
index 000000000..654201c6f
--- /dev/null
+++ b/winsup/cygwin/release/3.1.3
@@ -0,0 +1,5 @@
+What changed:
+-------------
+
+- The errno is now EOPNOTSUPP instead of ENXIO when 'open' is called
+  on a socket.
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 65bdc17ab..1d93c7730 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -54,6 +54,10 @@ Allow times(2) to have a NULL argument, as on Linux.
 Improve /proc/cpuinfo output and align more closely with Linux.
 </para></listitem>
=20
+<listitem><para>
+The errno is now EOPNOTSUPP instead of ENXIO when 'open' is called on a so=
cket.
+</para></listitem>
+
 </itemizedlist>
=20
 </sect2>
--=20
2.21.0

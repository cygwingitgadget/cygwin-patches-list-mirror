Return-Path: <cygwin-patches-return-9873-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4793 invoked by alias); 21 Dec 2019 23:01:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4727 invoked by uid 89); 21 Dec 2019 23:01:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=500000, 1848
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2101.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.101) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 21 Dec 2019 23:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=IrUdx9UFz6hyZ++CANwEltKZGHb5ZADto/WFMCSc68JstSNjowsY1SsJtS5ypvDJD3/o+CALMAW7kbv0ySBu/js5l1qUYnwOfNaYvKuKgh9beE1ee6yh8vFm3PiBtSwUHLD/pCNOWnja6IASuOUhE+0EKwAw3Q6rGOLZ+pxzctimnCdmRwq4oLKVCQ5Ounzsq3dFyRJl2ZR4Di6jYdbGiLhyV+v5Q0Wf3spGhs8utOqa3V6D4ps0zD8WCbPvx9ddZCwDVj+8d7brNXyQ7i/jnTeMRnAjtgbzIKfssRQLxjXlfUm+JAU363bJQqmsePwvR2yF0rPoMDpm5E0MWIZAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=/w5Fo+WNX9FYqga8XyBqXFIpMCkITWRI3lf2bhPCBYE=; b=FOTUb9N+lbeNwYaKQV10V/SGKjoh/X0PlMffSytC1UdlnG3/5EHiqL96z2MicSUzWeCGDqMDHIi7RoWnnJwhOOIMdnSRt7UG0w25ZR4Jkt8rZeUNSYcbhTTuMhjOc09EE80yFAL4941bcOfalPqaZCncFoRu7X49IfB9qedbqek//nP7WDetRiytwvi0reJn/bMozkL13fAC5FwABpdUC3ZGlH2/dWR3rGtlEQ7PW3T8RNmNymFVQxhkvBpNcmflqpuP+Vk0/CCttTe3gyms+cQOSybjVt2mksgzIHjQYCwAJjydu4okgjU6Ku5uNizOQKpLXUf5oSj/I3BCc8Rr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=/w5Fo+WNX9FYqga8XyBqXFIpMCkITWRI3lf2bhPCBYE=; b=Qf1jOlLg6N5bOIjWcRRzABLGvhl2gjGQSQVPJfEHJ8xK/h00kkg/P9GshZAbrua/pCAlKCE5ps00igobPu0rvPDmGvvMy9R8bYai01lUcJzcOOpKxL0Mic7aT+3IdeT2H/70flh/h4zCoywZE/jvRao6X1ooVCz/KKXU7fl0/n8=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6201.namprd04.prod.outlook.com (20.178.225.224) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Sat, 21 Dec 2019 23:01:46 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2559.017; Sat, 21 Dec 2019 23:01:46 +0000
Received: from localhost.localdomain (2604:6000:b407:7f00:9072:82e5:a2c0:8e76) by MN2PR17CA0032.namprd17.prod.outlook.com (2603:10b6:208:15e::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15 via Frontend Transport; Sat, 21 Dec 2019 23:01:46 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: FIFO: use FILE_PIPE_REJECT_REMOTE_CLIENTS flag
Date: Sat, 21 Dec 2019 23:01:00 -0000
Message-ID: <20191221230129.2177-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVsxuTAP2NchYST0IHH/4uolhaTGSWSz8bZ5g5a16xJUzEoweNE9moZ0iZlSYxx1kL3UwLrk1D5+2XSnc4hDYQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00144.txt.bz2

Add that flag to the pipe type argument when creating the Windows
named pipe.  And add a definition of that flag to ntdll.h (copied from
/usr/include/w32api/ddk/ntifs.h).
---
 winsup/cygwin/fhandler_fifo.cc | 3 ++-
 winsup/cygwin/ntdll.h          | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 92797ce60..fd8223000 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -184,7 +184,8 @@ fhandler_fifo::create_pipe_instance (bool first)
   timeout.QuadPart =3D -500000;
   status =3D NtCreateNamedPipeFile (&ph, access, &attr, &io, sharing,
 				  first ? FILE_CREATE : FILE_OPEN, 0,
-				  FILE_PIPE_MESSAGE_TYPE,
+				  FILE_PIPE_MESSAGE_TYPE
+				    | FILE_PIPE_REJECT_REMOTE_CLIENTS,
 				  FILE_PIPE_MESSAGE_MODE,
 				  nonblocking, max_instances,
 				  DEFAULT_PIPEBUFSIZE, DEFAULT_PIPEBUFSIZE,
diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
index e19cc8ab5..1c07d0255 100644
--- a/winsup/cygwin/ntdll.h
+++ b/winsup/cygwin/ntdll.h
@@ -557,7 +557,8 @@ enum
 enum
 {
   FILE_PIPE_BYTE_STREAM_TYPE =3D 0,
-  FILE_PIPE_MESSAGE_TYPE =3D 1
+  FILE_PIPE_MESSAGE_TYPE =3D 1,
+  FILE_PIPE_REJECT_REMOTE_CLIENTS =3D 2
 };
=20
 typedef struct _FILE_PIPE_PEEK_BUFFER {
--=20
2.21.0

Return-Path: <cygwin-patches-return-9211-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114176 invoked by alias); 22 Mar 2019 19:31:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113838 invoked by uid 89); 22 Mar 2019 19:31:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:739
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810099.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.99) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Mar 2019 19:31:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=nJS43kOITiHnhNdABF4LbnxiaU7D+UsrD6oYrzTNjYU=; b=iAY32iyfd5rPQiszKlpvvwXtIWyudkiqAK2Qjtej98CIx+GlSDoqvwL2wOJy5yEblsDC4DUQM+aEq4usTTxrcTB3KtbTCcaRBNIyjNMv7DjA0JB3ZUsycBXGXX/lCcoXM+Vv9YwAZG0NUgOM+saOsY3MdWKjHSgaitMzhHWRH6A=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5243.namprd04.prod.outlook.com (20.178.25.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Fri, 22 Mar 2019 19:30:40 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019 19:30:40 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 7/8] Cygwin: FIFO: update set_close_on_exec
Date: Fri, 22 Mar 2019 19:31:00 -0000
Message-ID: <20190322193020.565-8-kbrown@cornell.edu>
References: <20190322193020.565-1-kbrown@cornell.edu>
In-Reply-To: <20190322193020.565-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00019.txt.bz2

Deal with each client.
---
 winsup/cygwin/fhandler_fifo.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 7a592aa0d..2c20444c6 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -867,4 +867,10 @@ fhandler_fifo::set_close_on_exec (bool val)
   fhandler_base::set_close_on_exec (val);
   set_no_inheritance (read_ready, val);
   set_no_inheritance (write_ready, val);
+  for (int i =3D 0; i < nclients; i++)
+    {
+      client[i].fh->fhandler_base::set_close_on_exec (val);
+      set_no_inheritance (client[i].connect_evt, val);
+      set_no_inheritance (client[i].dummy_evt, val);
+    }
 }
--=20
2.17.0

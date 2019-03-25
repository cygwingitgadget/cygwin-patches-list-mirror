Return-Path: <cygwin-patches-return-9234-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81222 invoked by alias); 25 Mar 2019 23:06:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81149 invoked by uid 89); 25 Mar 2019 23:06:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr720104.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) (40.107.72.104) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 25 Mar 2019 23:06:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=DM8URR1Zn7c/y1+bBOKXMWbY9vyh3+phd/HZFciRSbU=; b=TR/ShuLOfhRH1vQCbtAs5Cg1GtDltWG0IHYRSqOXCFgQGNSrJma415fKh0bz9Zbph2Knq044CcEvlZFs1JgP6obTzNqwCwGNVx8QSTiCFYPE0oDXdENAPXVn+aRjPuARYq0mlA59iD0OOOXCLpISsbdbo1WJ/UQh0LA0feLbD94=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4649.namprd04.prod.outlook.com (20.176.105.214) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.19; Mon, 25 Mar 2019 23:06:10 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019 23:06:10 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 1/2] Cygwin: FIFO: avoid crashes when cloning a client
Date: Mon, 25 Mar 2019 23:06:00 -0000
Message-ID: <20190325230556.2219-2-kbrown@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu>
In-Reply-To: <20190325230556.2219-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00044.txt.bz2

fhandler_fifo::clone called fhandler_base::clone on each client
fhandler.  But those fhandlers are actually fhandler_fifo objects, so
when fhandler_base::clone calls copyto, it's actually
fhandler_fifo::copyto that gets called.  This can lead to mysterious
crashes.

Fix this by simply calling clone (which translates to
fhandler_fifo::clone) on each client fhandler.
---
 winsup/cygwin/fhandler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index f6982f0ba..ef34f9c40 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1316,7 +1316,7 @@ public:
     fhandler_fifo *fhf =3D new (ptr) fhandler_fifo (ptr);
     copyto (fhf);
     for (int i =3D 0; i < nclients; i++)
-      fhf->client[i].fh =3D client[i].fh->fhandler_base::clone ();
+      fhf->client[i].fh =3D client[i].fh->clone ();
     return fhf;
   }
 };
--=20
2.17.0

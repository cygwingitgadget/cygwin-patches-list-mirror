Return-Path: <cygwin-patches-return-9190-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63535 invoked by alias); 10 Jan 2019 17:57:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63525 invoked by uid 89); 10 Jan 2019 17:56:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, oder, HTo:U*cygwin-patches
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780137.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 10 Jan 2019 17:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Lycw9u3fW1KnJpgo/GptR40E1vTpZBOZqBUnf5g4W4w=; b=cqjEjIMN24zcVAnzS7pc5QMdy2us55kON2kiNuI/uQgRQ2cB4CtqMG8+kMIxchpKXl8GHvaGBNPkL/8I2/YnsXCyhbDszhKA5YowJLPVEgtw6PMJveNEUT37mE7CTWyqNhdgf9a6XeWorc4tK0hh2VAqHdiNerMap5nfdyRnCGw=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5932.namprd04.prod.outlook.com (20.179.52.153) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.7; Thu, 10 Jan 2019 17:56:55 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::f04c:a357:7c28:14dc]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::f04c:a357:7c28:14dc%5]) with mapi id 15.20.1516.016; Thu, 10 Jan 2019 17:56:55 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: af_unix_spinlock_t: add initializer
Date: Thu, 10 Jan 2019 17:57:00 -0000
Message-ID: <20190110175635.16940-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00000.txt.bz2

Also fix a typo.
---
 winsup/cygwin/fhandler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index d02b9a913..7e460701c 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -832,9 +832,10 @@ class fhandler_socket_local: public fhandler_socket_ws=
ock
 /* Sharable spinlock with low CPU profile.  These locks are NOT recursive!=
 */
 class af_unix_spinlock_t
 {
-  LONG  locked;          /* 0 oder 1 */
+  LONG  locked;          /* 0 or 1 */
=20
 public:
+  af_unix_spinlock_t () : locked (0) {}
   void lock ()
   {
     LONG ret =3D InterlockedExchange (&locked, 1);
--=20
2.17.0

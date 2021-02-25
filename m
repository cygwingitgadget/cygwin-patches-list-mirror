Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
 by sourceware.org (Postfix) with ESMTPS id 9701E3972833
 for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2021 22:48:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9701E3972833
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo5VqO1loOeDDUAOpGJ7FzzQSTGlQKWG3ngrqvFOyPkN6c61GxItmK72dSLV1GQtCd2y9IrITnAW+M9pbb5XHP6fJJHionB9TOK9nx9e+plwa0R98QDmnLAoe6XeW54Bd4hK9TuxDZzpnbOahNIxALuW/wiQHdH0iW3sNcU7k5Vc3mRbVT47qbzu2htKnQObz2Y5Ey63da0N7PVwMazrcpBFsgXS09pcyPxQ/+MyPK46kKQWbFAfIxp1fx0be2BUVspvnzF3LWK/3qkgtJYLLvEWkpySaPIVdq9z2msaNl2kB0ycGGo8XY3Ext+3mXjWjWhLXMGbSrAmwMpc2QPL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeIXaaSD51i6ok9TiW62eBCkQ7KrBIWxCsVghcHSO/I=;
 b=M9hGPKOFUBJtUtucDmC9sQnd3wmlyLEBlUBYenkEgKUQxXkOGyknBtXrLj716o92nRdI16zrmKwEiH6FEaisquB8SlunWt85lsSlwI9uJSCAlBwpMWdU/WoTGwfemhX9MRXE2HeFj9ylfTLG+L8nWSB9na/GDFNT7WvFUCc//2iCnJO5L3mCpu7mZBjcG6Gc4aRHtojnEHL2Gf/DCWExylKp2yQ7aI2henBmE0lqyZe2HaZWVVItAZK88UABWgOTDZ+I/KUXhoCNo/vSHzITBeTL8IRGKveOV8SpqSzmKMFyFZDRIEfFtOUMnF/rHiP7X8ynzhhJQiMeHE1J6JMtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6163.namprd04.prod.outlook.com (2603:10b6:408:5c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 22:48:37 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 22:48:37 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/7] Cygwin: fix fchown on sockets that are not socket files
Date: Thu, 25 Feb 2021 17:48:09 -0500
Message-Id: <20210225224812.61523-5-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225224812.61523-1-kbrown@cornell.edu>
References: <20210225224812.61523-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.194.34.31]
X-ClientProxiedBy: MN2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:208:236::23) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (24.194.34.31) by
 MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend
 Transport; Thu, 25 Feb 2021 22:48:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 123f29e3-ea3a-4fb6-778f-08d8d9df7ce8
X-MS-TrafficTypeDiagnostic: BN8PR04MB6163:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6163C1E9FB0F5BB9FA239430D89E9@BN8PR04MB6163.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiwYrdlH0NlybxQAboBtBYJfHjL//USzY/JS3+NyJd+JY8/XztDgRG2dhuk5EDEEZDSSO3ZHS5N5sIJ0++u1B995SoUAyMpEU6C2unLw/UcJwem9/CdlF3cA+g9xgVHh6adFhjpVbc0jYIkKgiqnB2A1qK39/6qzsU8QWz1ERTLyAcRmUxdyeeGWHh9M4hME4VHB8anFOk8ym4BW4QnI5Q2OKoGP4sOqVZyRifFdkRup7dSpPNJt971gar1Qypk7j1hpzzeY6EG7IpvtHI9SUAleoOIC5mFB2x0y6tDYMhAyUWXnso/1ck7s/vcjR0yKTdPjYolbszBPHVy713v0edqfZWF6Q7AurUL2AGbFkrSaIo1ckYMjkks48JXWmNo24+wD9nKDV8/0nnf3OCBtPTdvrFm5e+6fY/PL6z7t8cTFopOm/P5IPoKxoGYgapxU/lMXNtPLrdPpRt7ZXLXNKlwQWPbaQIzlhdLbR/ZgrDRNTu4VYy0CWgrEMyNuDcJUSTfO9kDB+vCYRdRq+kVR4q9JsjmS9v/6rx0wqI7AP576Eg8UoFTOgkOM9cKwKDvf8qef58osQiy0xrb8iY8nDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(26005)(8936002)(66476007)(66556008)(86362001)(6916009)(16526019)(186003)(8676002)(66946007)(2616005)(316002)(36756003)(6512007)(956004)(75432002)(52116002)(83380400001)(2906002)(6486002)(69590400012)(478600001)(6506007)(786003)(5660300002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?alJ46tHjPKiQ0O5V6Z2n+0a/mV77MPB68LHVS3aB+v8zz01Y7wlG/kuTbU4W?=
 =?us-ascii?Q?xZ26MY59BAQRUY4H42y5RN8cp7WJXVEq12pwhD6l2xGLS2qPxSwnemgeAOip?=
 =?us-ascii?Q?WNHIKxIZrzlRp8YQ5ssPJNW8kirfwisQW+2ZXhO0qQlKmB41UFA88YLV/+FV?=
 =?us-ascii?Q?hM9v5ZDueZj7C2u/Z+zhTVnLK+vXS9oKgkGl0wRT/wS6dtD3T6eN8ksKePUb?=
 =?us-ascii?Q?K+Gz/gd9sA2n4XPiCa3sb932wqTHhhPa/5SYFMnwlH3gFgvQxr8fHW0U2dS0?=
 =?us-ascii?Q?GbUCXQSSSYRLoGRSBAxVDKJkGoutWMt2XEbRx8yDnx1HvuLxKKMepzmCxOqz?=
 =?us-ascii?Q?MSIRJtFG/KjCwKmL0OeWTudIEN86ajgG1Kh5nfN+SlJP3nWGiMWLA1s0tEGb?=
 =?us-ascii?Q?0vIhlZosBzLESHJYLsgHTmdJFh+ZqTImsxXjAeLgWit36tMskoYvaGkg7oOU?=
 =?us-ascii?Q?KGWsLhEXtdSxfG/1N08gdrV1eay9t2dtsuYur0/V5O96MUkNASuef3pDyuoW?=
 =?us-ascii?Q?sS6MQ8IrGyXdH1YuzcnUHv/pSTe3AIkz+GzmU2y+IMQJffKRekKeTCKPdxIK?=
 =?us-ascii?Q?BupeqS+sjxZFquk2Os1p3IlTT/6lgX9XHT4Jj0HjA/DY260VJ168oErkprKK?=
 =?us-ascii?Q?RSJHhbBMCSfe2v6PGVE1W/qWdo3ilB9F5a55d9/Q4FcD2UpaTopCwLbW/BOT?=
 =?us-ascii?Q?e2b/E2iH3ncnSCuE07DDsoE9ryXJegkO2LTsLnOZEOHwRqLwe8YWQZ+SkOvv?=
 =?us-ascii?Q?82DgC75cQXFNA1djCBCGH9xiOzSEszAcZvG5VMlJ5z08Zct8VQGdGBB/DM4H?=
 =?us-ascii?Q?75m7fnoayNwMiGj4THydYEC+/PnfCsjvy/xYGPoxSjqM3J9stMECeSGUhzpQ?=
 =?us-ascii?Q?d3pKfiLaTgX6/yMX4niRNHbUynqHwIVTubqELn/gsej6Zm54wZt5uJCTMb2L?=
 =?us-ascii?Q?2UBZX9Df77D6/kTJOCkgPa4yWC6AdQSQXHhL2jfBha7PvrPCvvYnciZ1o5zh?=
 =?us-ascii?Q?4zq6u2GmOiVmN+wj6d+6mOmAXers4TcGBOr3MMGufrtk23WhlXu/0VhWLQA/?=
 =?us-ascii?Q?zknOvRhzWbPOvtoPOZxY9+6lh2PrIaCFmQS3F5gSt4AhKDKbYowWcvX8r3lM?=
 =?us-ascii?Q?L9+jq7NoPWD2WaD9MvXgIA0W6Frw7BsfqwpryR4EhpEgDLaRtavKVGBP4PPT?=
 =?us-ascii?Q?rTn0UgWThqrxNGDug7PAu/GAjWqhAsKgQUQ6NH3ef3H48JC1y7Vkgzb67csL?=
 =?us-ascii?Q?uwPSN5Yr/OuxUrmE0SSqfKDczXvyZIWuSy/QaHw1Owy6Y9T99F7w0nW2WfxY?=
 =?us-ascii?Q?c4DPU1fT0teNxAKWZZB2Bvo+?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 123f29e3-ea3a-4fb6-778f-08d8d9df7ce8
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 22:48:37.1907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3ScxPIjX9NJ2VPKP045PmJYOd1Pu67zC+S4q5V/oesAtLyAMW2Pg0X2Lsds/5jtZng+ul/U+GixNfKeHXC/gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6163
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 25 Feb 2021 22:48:42 -0000

If fchown(2) is called on an AF_LOCAL or AF_UNIX socket that is not a
socket file, the current code calls fhandler_disk_file::fchown in most
cases.  The latter expects to be operating on a disk file and uses the
socket's io_handle, which is not a file handle.

Fix this by calling fhandler_disk_file::fchown only if the
fhandler_socket object is a file (determined by testing dev().isfs()).
---
 winsup/cygwin/fhandler_socket_local.cc | 6 +++++-
 winsup/cygwin/fhandler_socket_unix.cc  | 8 +++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index d1faa079a..349ade897 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -724,8 +724,12 @@ fhandler_socket_local::fchmod (mode_t newmode)
 int
 fhandler_socket_local::fchown (uid_t uid, gid_t gid)
 {
-  if (get_sun_path () && get_sun_path ()[0] == '\0')
+  if (!dev ().isfs ())
+    /* fchown called on a socket. */
     return fhandler_socket_wsock::fchown (uid, gid);
+
+  /* chown/lchown on a socket file.  [We won't get here if fchown is
+     called on a socket opened w/ O_PATH.] */
   fhandler_disk_file fh (pc);
   return fh.fchown (uid, gid);
 }
diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index e08e9bdd9..573864b9f 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -2395,10 +2395,12 @@ fhandler_socket_unix::fchmod (mode_t newmode)
 int
 fhandler_socket_unix::fchown (uid_t uid, gid_t gid)
 {
-  if (sun_path ()
-      && (sun_path ()->un_len <= (socklen_t) sizeof (sa_family_t)
-	  || sun_path ()->un.sun_path[0] == '\0'))
+  if (!dev ().isfs ())
+    /* fchown called on a socket. */
     return fhandler_socket::fchown (uid, gid);
+
+  /* chown/lchown on a socket file.  [We won't get here if fchown is
+     called on a socket opened w/ O_PATH.] */
   fhandler_disk_file fh (pc);
   return fh.fchown (uid, gid);
 }
-- 
2.30.0


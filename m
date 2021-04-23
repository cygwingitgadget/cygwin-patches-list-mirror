Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2127.outbound.protection.outlook.com [40.107.93.127])
 by sourceware.org (Postfix) with ESMTPS id 18DB33857832
 for <cygwin-patches@cygwin.com>; Fri, 23 Apr 2021 18:52:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 18DB33857832
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=kbrown@cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeX44YXSzDqAzZsKANPtp8iUl8L+i1H6GmRRs2ZLzrLd92bu1WYDSHgjFJ9cuaXD2GowgxC/RX5TkrHc4Mfy7/rCaV9XjSDVvNnHtuKRla7/YO/6sh4um3NTnxHvRzas0CljB18PhH5vN8SXg40DyhUsD0JjfBRFLbtqNNfiUWsSeF/NlxGBAO7U7H1MElvUu04iF/Mtq/DuM3sO2CtebXCzP1QG6skPBxotoHKzG9RldPnX9fsKCK8KFOi7QlmzofeLxXjrKBqEcaY906iw1I2VSh2DOWpU+4SE3wGvhXBvfAbR4bvofR5DoyOtKauQa7h843s/t0jakWoVMp3eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A810iWHn1oBU6GTztry+iwnGgVJgwDWXb/eiBF7+jbc=;
 b=izdymSFBkeo2RLD4jazHWT055WBrnohRCqG2S0tkfTSJ78AqPebzsud01sS2rvHHFif8p5BNtH02uvjz9RdVzq1xEGRmLgto0IZwWEU3XI5AogZPIhNzq5B8lnhhyLNqg/MzHOaXLJBvZOHCRwoWsVR1qrxJaba7Ft+nsP60HQb1JTFzBLos+AeBctj26j6dyMeWLUuYILHwggu8PYzNf+ArjJHEOJfw0CC1UzG5PH48k3qanaRO1xkYC4jFoQNpsIyvY/oQNhqVBXI8KvBwBfrDjdyHw8BBO7C+LhNPM44cRnVBmsTIq+jDWdww8axoJs3zfcWtCxioBH4t0ww/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A810iWHn1oBU6GTztry+iwnGgVJgwDWXb/eiBF7+jbc=;
 b=TlTgavrXUeXCIF5H1oEmnYXuCuPwWcGAWPZlgFC4LH0aSqMqweB18oS1SaSP/l0ihWHo5sOVrbRYOWNocdzGLEYpEAUAv42tbdITKiE5PueHyro2B5w/z1/L/iTwSTZ0vNXGiPdrm+BOY+7RyxrPFH96DzXlcseujLoALwndwdU=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB4385.namprd04.prod.outlook.com (2603:10b6:406:f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 18:52:05 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89%4]) with mapi id 15.20.4065.021; Fri, 23 Apr 2021
 18:52:04 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: connect: set connect state for DGRAM sockets
Date: Fri, 23 Apr 2021 14:51:41 -0400
Message-Id: <20210423185141.7687-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: MN2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:208:e8::22) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 MN2PR20CA0009.namprd20.prod.outlook.com (2603:10b6:208:e8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Fri, 23 Apr 2021 18:52:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53f7edec-679d-45d3-594b-08d90688e31f
X-MS-TrafficTypeDiagnostic: BN7PR04MB4385:
X-Microsoft-Antispam-PRVS: <BN7PR04MB4385D8F627E795BAF0EF9565D8459@BN7PR04MB4385.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJ8JnWUQ+/PSkcUUlH9meUK72nbKZJI1LiUNxUGhC3RfUbBLnaE0cVyMJZAExZX67ybs+4QBlwZ5FfnntoAI2ebjsKln0iV4EH20BRkKhhsJy4rVMpZl/A6saxHmE+fH7tKxAGH+xBVQRqaizQ1LAn5tNRszDLPwFeP8Ar5LBf+pO0Dqth71GwtLNCJLKRZSqNZh7N/d3vwoBiZLgT+tU/Qin6vhhx2FpzMq0hYVu77Pdon8JJ5Rvbd/gC5RqxEa8bze0ejzrFw6CZ7tFH6Fnjj+/65G1/F5jn2IKL+8v2D7MzxPbMFVlZSNwWCYPe87jasxb5VntDhbuZzg5NmcEg8jHpmIzRNNOKgLwiNaNjit7En9rcovRYHpjenMdBuEiJrzs8DCatXwF4vkrw0NV8TzmkBq2KkgwBpnLey6DLHBOIuZ61u1vRR0nUYOD+4y/NDk8dV7+5d3oFYGPlEQe8u2cfomNEl0AMTgN9GFo6SILw0zvOk0CHaOm4Dd6/Vf4pnnVgXG+6ouN1OS1+9FonEYBp4vp+EVM+BXkB67l2x/fLpeeLqaOgG4grpQjc+6pFbYxnV7dF+ZIFQeagQXAnTSAiEzm68YLTGUXDP85T7ier018+G2ahfZhWbUubx4DqT6KkH720EMilRvZFf/iMT4fOkxZu5z1IMXD373PL3P063bDWl7r0VvOsoNoFKU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(5660300002)(2906002)(66946007)(956004)(8676002)(38350700002)(38100700002)(186003)(66476007)(75432002)(2616005)(6486002)(6916009)(26005)(16526019)(66556008)(478600001)(36756003)(8936002)(6666004)(83380400001)(86362001)(52116002)(6512007)(786003)(1076003)(6506007)(316002)(69590400013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vRlGmDe4pNq4G1k9Oe4q4vaPR4bHgr4j7pKYTgEQF28A84pjPOOcC0FGw5sK?=
 =?us-ascii?Q?4rciJP4RFgKJEKO4C4W+kHDQsFN8LsBoYbL4SHqo+SGDFYoi27On8lyvBar3?=
 =?us-ascii?Q?4gaoFsC/IVKEms2iyjwFDjLvtZ9PFk1FNv/qXxFrMJ3UU+4mE8fjWiGvdvHz?=
 =?us-ascii?Q?UA0icyMJ1M8qjXI7H6yyR9N66VlfH8LzoM+d8l5rabOM2O5/z9PUC6ak7xHP?=
 =?us-ascii?Q?VWLJfeBGTckRMFMS7S2xmP5M4lnyiwJFkuevQOXN+6gDc7v6ZZoLYOofhZd/?=
 =?us-ascii?Q?kwHJLMwdNn2/Z8RZtx4F5PGBHabXleGMMtNIgDnVd2MkYzazPRyTFOg6tqMC?=
 =?us-ascii?Q?WJfy4KJ5A4m6XTtG9jy4fnUlLHBHIZ22DzLJscmJ0l/Pn7WOb5CokFSnz68b?=
 =?us-ascii?Q?xU+Nnjoc2Y9mnqtxKH2lhQFbdBMKps5yEBBoPFs0Xw7YPFmVyTh5+yPEYmU8?=
 =?us-ascii?Q?irY7wAbwFjUXYZhapGBmw467J1rMWJbDy81db4Se1byndguknYsE/1nbkKcC?=
 =?us-ascii?Q?XXG84r28QfnghbGgZ2PmFB94tznRiz2yPHq0xkas2qcurs5H0gxG5WwnxyP4?=
 =?us-ascii?Q?hrr01X6V3nXmtrwGtG1QfpaCfIKX6tXRaU1uG9ai5MRR50XGH1HJnLzV8ZyC?=
 =?us-ascii?Q?41hist8q0PfxZg6IRIZccprTFvvPXIH5qObBUVDUiRwPaldYAJfbIx5GsE8P?=
 =?us-ascii?Q?GJTMYElxr/pYM7tuT/h/3ZkEBQ9HARj2qDNOR1YOis2ArQ/V+/IZ0D/9u0BC?=
 =?us-ascii?Q?QY2LlWoUSoXlUXslA7OYto2BhZFrh//brSV/3FuXUvLy/C9nq6OgDyPzV/CA?=
 =?us-ascii?Q?FxHzQutJW0CFJ+KvTpyIQDtd/HvYzEDjtoz14spKtLJ6sLv6DimBr86TDyLX?=
 =?us-ascii?Q?xZq1PajJpp4sOY4gHBpyIaTvyJpa5UDxsKfXHDCJup4N4HAM0YR4NEMhTIOA?=
 =?us-ascii?Q?g3EWCtfMhWqZz7vRjo2tBxcMFcBGMWutIBUQJIUbiO9jBUSBbr8PnqEQF8Uz?=
 =?us-ascii?Q?qRxx1mMEbHXMRh4f5m3nXyOnwOVI4albtiqzxZcJ620gFsZNvie5dUIUDzRg?=
 =?us-ascii?Q?Z79rLnd7cZahGWx+jDTYNc+HFigLt0CPoJLLSde2M573lop7X+VgddJNsZmU?=
 =?us-ascii?Q?oVuBw8cTalPGiCNgj+en/yB7PLNiBZ/EBTwpaEf/aICTsgny9AY8dheysVNi?=
 =?us-ascii?Q?GablXnTzZIL3s1NIzHbMR0JMWPEVDMDtb6daR6cmHDbBkY+XAsK846dfySsT?=
 =?us-ascii?Q?/BNDD1U0771m0OekmOulye2yxeLoi4KyH2Sf0FVwbEHEGx2aVVAmqqHgmlE2?=
 =?us-ascii?Q?3hz39MUAAYPg54e63PMcO053?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f7edec-679d-45d3-594b-08d90688e31f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 18:52:04.7336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6Lhjj/EiNO3POxEu1C93DjGmLn7Dkq1WqlKzg/4X8WKK5xA8LFUBIAuHYdNgkEjEhmffQeo3ogRDikDJY4utA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4385
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 23 Apr 2021 18:52:13 -0000

When connect is called on a DGRAM socket, the call to Winsock's
connect can immediately return successfully rather than failing with
WSAEWOULDBLOCK.  Set the connect state to "connected" in this case.

Previously the connect state remained "connect_pending" after the
successful connection.
---
 winsup/cygwin/fhandler_socket_inet.cc  | 19 +++++++++++--------
 winsup/cygwin/fhandler_socket_local.cc | 19 +++++++++++--------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_inet.cc b/winsup/cygwin/fhandler_socket_inet.cc
index 4ecb31a27..f6bb8c503 100644
--- a/winsup/cygwin/fhandler_socket_inet.cc
+++ b/winsup/cygwin/fhandler_socket_inet.cc
@@ -785,11 +785,13 @@ fhandler_socket_inet::connect (const struct sockaddr *name, int namelen)
   if (get_inet_addr_inet (name, namelen, &sst, &namelen) == SOCKET_ERROR)
     return SOCKET_ERROR;
 
-  /* Initialize connect state to "connect_pending".  State is ultimately set
-     to "connected" or "connect_failed" in wait_for_events when the FD_CONNECT
-     event occurs.  Note that the underlying OS sockets are always non-blocking
-     and a successfully initiated non-blocking Winsock connect always returns
-     WSAEWOULDBLOCK.  Thus it's safe to rely on event handling.
+  /* Initialize connect state to "connect_pending".  In the SOCK_STREAM
+     case, the state is ultimately set to "connected" or "connect_failed" in
+     wait_for_events when the FD_CONNECT event occurs.  Note that the
+     underlying OS sockets are always non-blocking in this case and a
+     successfully initiated non-blocking Winsock connect always returns
+     WSAEWOULDBLOCK.  Thus it's safe to rely on event handling.  For DGRAM
+     sockets, however, connect can return immediately.
 
      Check for either unconnected or connect_failed since in both cases it's
      allowed to retry connecting the socket.  It's also ok (albeit ugly) to
@@ -801,7 +803,9 @@ fhandler_socket_inet::connect (const struct sockaddr *name, int namelen)
     connect_state (connect_pending);
 
   int res = ::connect (get_socket (), (struct sockaddr *) &sst, namelen);
-  if (!is_nonblocking ()
+  if (!res)
+    connect_state (connected);
+  else if (!is_nonblocking ()
       && res == SOCKET_ERROR
       && WSAGetLastError () == WSAEWOULDBLOCK)
     res = wait_for_events (FD_CONNECT | FD_CLOSE, 0);
@@ -824,8 +828,7 @@ fhandler_socket_inet::connect (const struct sockaddr *name, int namelen)
 	 Convert to POSIX/Linux compliant EISCONN. */
       else if (err == WSAEINVAL && connect_state () == listener)
 	WSASetLastError (WSAEISCONN);
-      /* Any other error except WSAEALREADY during connect_pending means the
-         connect failed. */
+      /* Any other error except WSAEALREADY means the connect failed. */
       else if (connect_state () == connect_pending && err != WSAEALREADY)
 	connect_state (connect_failed);
       set_winsock_errno ();
diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index ad7dd0a98..1c8d48b58 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -914,11 +914,13 @@ fhandler_socket_local::connect (const struct sockaddr *name, int namelen)
   if (get_socket_type () == SOCK_STREAM)
     af_local_set_cred ();
 
-  /* Initialize connect state to "connect_pending".  State is ultimately set
-     to "connected" or "connect_failed" in wait_for_events when the FD_CONNECT
-     event occurs.  Note that the underlying OS sockets are always non-blocking
-     and a successfully initiated non-blocking Winsock connect always returns
-     WSAEWOULDBLOCK.  Thus it's safe to rely on event handling.
+  /* Initialize connect state to "connect_pending".  In the SOCK_STREAM
+     case, the state is ultimately set to "connected" or "connect_failed" in
+     wait_for_events when the FD_CONNECT event occurs.  Note that the
+     underlying OS sockets are always non-blocking in this case and a
+     successfully initiated non-blocking Winsock connect always returns
+     WSAEWOULDBLOCK.  Thus it's safe to rely on event handling.  For DGRAM
+     sockets, however, connect can return immediately.
 
      Check for either unconnected or connect_failed since in both cases it's
      allowed to retry connecting the socket.  It's also ok (albeit ugly) to
@@ -930,7 +932,9 @@ fhandler_socket_local::connect (const struct sockaddr *name, int namelen)
     connect_state (connect_pending);
 
   int res = ::connect (get_socket (), (struct sockaddr *) &sst, namelen);
-  if (!is_nonblocking ()
+  if (!res)
+    connect_state (connected);
+  else if (!is_nonblocking ()
       && res == SOCKET_ERROR
       && WSAGetLastError () == WSAEWOULDBLOCK)
     res = wait_for_events (FD_CONNECT | FD_CLOSE, 0);
@@ -953,8 +957,7 @@ fhandler_socket_local::connect (const struct sockaddr *name, int namelen)
 	 Convert to POSIX/Linux compliant EISCONN. */
       else if (err == WSAEINVAL && connect_state () == listener)
 	WSASetLastError (WSAEISCONN);
-      /* Any other error except WSAEALREADY during connect_pending means the
-         connect failed. */
+      /* Any other error except WSAEALREADY means the connect failed. */
       else if (connect_state () == connect_pending && err != WSAEALREADY)
 	connect_state (connect_failed);
       set_winsock_errno ();
-- 
2.31.0


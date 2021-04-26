Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2108.outbound.protection.outlook.com [40.107.243.108])
 by sourceware.org (Postfix) with ESMTPS id 9753F3844051
 for <cygwin-patches@cygwin.com>; Mon, 26 Apr 2021 19:37:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9753F3844051
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=kbrown@cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBeOfJYWGCUviqqDoAlv8sC9j6CUTB8I9YGGRkuRjTs/YPAWUGDPXFFCbB5+7GsVBjs+Nn+1l7WWu/1vg/73LJXkQeq9et6xmdCq1jeRZllXywONWFjyfKJAG/pN80j9iVKsvO169FTh4a6cbAxtuETegGM04Wo9F/cyK92RVZdz7yud7IvjSSLt9/VZJbEhLjeMWMpgrhat8kMTGO1eek8esfCIJFnJOzD+wc4rRnXeQso7IBUuaXevRs/dFZDQ9bsW3RgzUdLJH33w13MRpB9u7tANEwLnNzLl49xjHubW+B3v5cf3JSfgp023LhRvgEnNx70TRl9dPFzABHkoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQGJaLCkb0eqAwageTMVFJ3RIy/FIt4Z8RFGlbxnn/k=;
 b=F9rFgxl15oiqfMHthcGa+PN2roPLpAhUKMa9QCu0JPhfhhrCBbL5kbMXEQ0hof78BcU2BI8YN/0N6ngHrF42ycr+BhQnkXhldFZioRoRMfscBEpSPuuj6ob8+BlCxY9YFheidEJXlXkfBQQjSb0hCJTrljH6lDAWDj9H1ByiFbc/AsnaEC/lm1sDYCkCArfH5Q2GYU4HM1Qz13uh7vBvWRnXbt/6f5HskklkYcPHSYJ8AeA8JwphrEHSvEczP7RCDe1DJ7PR0zwa3vyiF8GhOiow1HxymRUCc04AdYEL5HhCmmVcdNgfjXu4vFEVM473uthIQblgC6iTnBiQ69o6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQGJaLCkb0eqAwageTMVFJ3RIy/FIt4Z8RFGlbxnn/k=;
 b=SqnE2TPAfvx7wXwgj7Fc4yZ75frdVEJ1HBYyt93J9CLhC3EXWMMdvw8RjVExNjhbutkNtniSkSkXXN6IK2f277IX307oaNxrxLc1rdN4Yt1GYybZloERo9nFuithjUE49M5QMXcos69QKBQFX1edzCIs6HJrd29qFNtA2rucYYA=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB3731.namprd04.prod.outlook.com (2603:10b6:404:d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 19:37:22 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 19:37:22 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: connect: implement resetting a connected DGRAM socket
Date: Mon, 26 Apr 2021 15:37:01 -0400
Message-Id: <20210426193701.19895-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: MN2PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:208:19b::21) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 MN2PR19CA0044.namprd19.prod.outlook.com (2603:10b6:208:19b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Mon, 26 Apr 2021 19:37:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbf45ba9-e10e-40b1-5c76-08d908eab64d
X-MS-TrafficTypeDiagnostic: BN6PR04MB3731:
X-Microsoft-Antispam-PRVS: <BN6PR04MB3731EDD251CC11CF2DEDD094D8429@BN6PR04MB3731.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GTXw20SGUBEkIyLDJoAOI5dwiK4Q86as3vbAglnR1xVcKx3hHL0HHYF4zyelfe1+xPDaPYGxKHLfOT2vppzdrG1OEkG3pLnSK8BJfGlVStXuZG7XaZfIIyeCj3A3+VX6d+XkMRsRwA7A//ClK52VwfZLzpLluORlu6uUfh0noM/iYadB6KpYmWlZ6xqQm3gGYIuBCYu3XImzAe2NhVHP+ksxNbMkDCsD2WrlA8i3B10TxCYBN42oi5/BP7pgRA8iLHbTqWnNtsmnN6YzHH1fcS7rg1Bslitq7OU19MQyRwkZoszMzZ0CYfK6JrQhPrwkWB+aJByrJy1jJ2NbX5CFKkB7DDrp0jeWnjbSt0Q1tP80wLcfCwMJZNGRh3PEP1CvTemV9Iz6HLWeKiyy9QbUCLizzxwxTS9gVVCZDmvpMhT/b4s1haE7iYpljb3XUJcbk0pkdukHMn+g/9W7CNN2ar6IzFS980a/bARFUfh7xZ7rATLBtUAB/2if2EF8Cgj+QkLw6j3mQ6kx6dAOn2BXjD+bOZNryB+NENZLnJHLDhDgoWr8hgkoK5c/kATuwrP94rBT1251hiZ/vzm766KVSA5Voi7zusHf9iIu+ZrZADH3nqaBQxbrNwzvvpibYm3cSNni3obyauq7oGjH3TiSQnkdRtnaawmfEFVjx13i7OtfFf5RznMxhSJrj9rihbw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(38100700002)(38350700002)(2906002)(186003)(1076003)(6506007)(5660300002)(16526019)(6512007)(66946007)(478600001)(8936002)(83380400001)(66476007)(75432002)(66556008)(6916009)(2616005)(36756003)(316002)(786003)(8676002)(6486002)(956004)(86362001)(52116002)(26005)(6666004)(69590400013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kFah0t73BUDD1fgFCrnfp07wCwq5Fn/f8g5cTCOe4plL7si/v8ln221ejEnv?=
 =?us-ascii?Q?0do0v2Y1ZVgsQTN9fFCHN1WGj8Drw8yNESCS9IWg74f/L9txhPn+yoBNGFZO?=
 =?us-ascii?Q?Rij7+YefOavGtYFHN8QgeaeHIeqdj2MUDk5A4TbIoPK61iRGKjZKIsEFUaYm?=
 =?us-ascii?Q?/NbYk8PTmGWPyqikYD9zxRPdQvB6eggS+WabkwLmDvhlPOHG7F0K1uR+/XSv?=
 =?us-ascii?Q?YgfcqKX4UrtFloVquS+jSv668ATMp3tMiXyK1EU4GQwr5AqhtCvBcd+2Qmfx?=
 =?us-ascii?Q?1NGQxklkLLX6IsDK4Nj6HYZ1JHVGLwellvONTiFrrtIrMG7bUJqxvgujxGB0?=
 =?us-ascii?Q?jqF3dUlboHnuyDi8J1jhp8wpoo/Qcuy7o/9Tsd4cfqUwkgiS+VNWhD+8vbvy?=
 =?us-ascii?Q?reTyAEBtQTV8nqd3YOpXjO2f5NXGMt9xGApisc6Uh0vUqvgcGb3NP9toEMea?=
 =?us-ascii?Q?1xAkS0RBJLbnAB8OwH1zH6hfgazjGEL0WTiBlKexSrAZ0uXczzK2EtBk6o/P?=
 =?us-ascii?Q?CZ2Nmyn0BIUZXJLbD0f31rkK+kV2bXTKjianXHxVT6WZF39awKlLjARlfvqN?=
 =?us-ascii?Q?NssevZdPuWqocWggVPThTcRPQ/ivHPMpndi8y0Vz6V+HC0ea+qAwFhSSpbqr?=
 =?us-ascii?Q?SKvATq1YKuA+d6eBILs9ELSxPT3EW5Wd6Y8yTDh/xvqy1iPM/xBRfH/YIIjd?=
 =?us-ascii?Q?z8oYc3UXjj01tIznsZO5CPKsz6qKE1/gg/gjbdJgj112y+q+xqywCAWYQFlT?=
 =?us-ascii?Q?VMbpqzCxBt5IDNokLapWZsC+jgxkrZxwukOU13IqjGF6qwNHag8vOAl6wO4B?=
 =?us-ascii?Q?GuLGpRrj6OX5rS3VeeDxO+6c8Li0JV+yB38xMDCeXB+sIU2a4hcVJKTXt+5o?=
 =?us-ascii?Q?4v18VE5tXs6QYxCQEAo0s4eco33GIlvtgkoRlC9ZBEsqQXGODg+gcMcY9hOV?=
 =?us-ascii?Q?XVkEhBpou4yKn/+1w7SJybX/+BwcBdVDJ5majEH1btvmwB7k31kte2osFGob?=
 =?us-ascii?Q?PMlPdLy8hOzlHu9pgfx/Ag9HLg91N0fD80nonQ591Y78aSBjvf2+R26au+0P?=
 =?us-ascii?Q?nNlog3C/ewCtq6c0DYMKQORMFPHvnj+NjL231o6S+pec3GTUGc3cRvgyyLx8?=
 =?us-ascii?Q?PwEV3j2+xKg/+qEHxC+y/Cmk/E5tuaN6h6AebYkqfxQ4LuiZEVE5V/+5vbgS?=
 =?us-ascii?Q?h1wRgo95zXmSSdqmIXqexqix0uTn1HsefcX/r+yzK8fM6h4DBx9rwRVi20YT?=
 =?us-ascii?Q?a+8EByCpvNpE5Jo52mqPvcW84/ARRq8UJeKYMLDRYelxzZpVYWww53hz1oZq?=
 =?us-ascii?Q?fM5I6SofFj2WgkXx5c1c7LPa?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf45ba9-e10e-40b1-5c76-08d908eab64d
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 19:37:22.6336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5rPvRPr7w/RETcnvulIhQkJmqA7tknSWWnBIdl3n2nrFrNE4K52TQhlQRwyNV1vFBkvc/df0FQ0EJy/8ZbDOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB3731
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
X-List-Received-Date: Mon, 26 Apr 2021 19:37:27 -0000

Following POSIX and Linux, allow a connected DGRAM socket's connection
to be reset (so that the socket becomes unconnected).  This is done by
calling connect and specifing an address whose family is AF_UNSPEC.
---
 winsup/cygwin/fhandler_socket_inet.cc  | 21 ++++++++++++++++--
 winsup/cygwin/fhandler_socket_local.cc | 30 +++++++++++++++++++++-----
 winsup/cygwin/fhandler_socket_unix.cc  |  7 ++++++
 winsup/cygwin/release/3.2.1            |  3 +++
 winsup/doc/new-features.xml            |  6 ++++++
 5 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket_inet.cc b/winsup/cygwin/fhandler_socket_inet.cc
index f6bb8c503..30eab4099 100644
--- a/winsup/cygwin/fhandler_socket_inet.cc
+++ b/winsup/cygwin/fhandler_socket_inet.cc
@@ -781,8 +781,20 @@ int
 fhandler_socket_inet::connect (const struct sockaddr *name, int namelen)
 {
   struct sockaddr_storage sst;
+  bool reset = (name->sa_family == AF_UNSPEC
+		&& get_socket_type () == SOCK_DGRAM);
 
-  if (get_inet_addr_inet (name, namelen, &sst, &namelen) == SOCKET_ERROR)
+  if (reset)
+    {
+      if (connect_state () == unconnected)
+	return 0;
+      /* To reset a connected DGRAM socket, call Winsock's connect
+	 function with the address member of the sockaddr structure
+	 filled with zeroes. */
+      memset (&sst, 0, sizeof sst);
+      sst.ss_family = get_addr_family ();
+    }
+  else if (get_inet_addr_inet (name, namelen, &sst, &namelen) == SOCKET_ERROR)
     return SOCKET_ERROR;
 
   /* Initialize connect state to "connect_pending".  In the SOCK_STREAM
@@ -804,7 +816,12 @@ fhandler_socket_inet::connect (const struct sockaddr *name, int namelen)
 
   int res = ::connect (get_socket (), (struct sockaddr *) &sst, namelen);
   if (!res)
-    connect_state (connected);
+    {
+      if (reset)
+	connect_state (unconnected);
+      else
+	connect_state (connected);
+    }
   else if (!is_nonblocking ()
       && res == SOCKET_ERROR
       && WSAGetLastError () == WSAEWOULDBLOCK)
diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
index 1c8d48b58..bd4081622 100644
--- a/winsup/cygwin/fhandler_socket_local.cc
+++ b/winsup/cygwin/fhandler_socket_local.cc
@@ -894,19 +894,34 @@ fhandler_socket_local::connect (const struct sockaddr *name, int namelen)
 {
   struct sockaddr_storage sst;
   int type = 0;
+  bool reset = (name->sa_family == AF_UNSPEC
+		&& get_socket_type () == SOCK_DGRAM);
 
-  if (get_inet_addr_local (name, namelen, &sst, &namelen, &type, connect_secret)
-      == SOCKET_ERROR)
+  if (reset)
+    {
+      if (connect_state () == unconnected)
+	return 0;
+      /* To reset a connected DGRAM socket, call Winsock's connect
+	 function with the address member of the sockaddr structure
+	 filled with zeroes. */
+      memset (&sst, 0, sizeof sst);
+      sst.ss_family = get_addr_family ();
+    }
+  else if (get_inet_addr_local (name, namelen, &sst, &namelen, &type,
+				connect_secret) == SOCKET_ERROR)
     return SOCKET_ERROR;
 
-  if (get_socket_type () != type)
+  if (get_socket_type () != type && !reset)
     {
       WSASetLastError (WSAEPROTOTYPE);
       set_winsock_errno ();
       return SOCKET_ERROR;
     }
 
-  set_peer_sun_path (name->sa_data);
+  if (reset)
+    set_peer_sun_path (NULL);
+  else
+    set_peer_sun_path (name->sa_data);
 
   /* Don't move af_local_set_cred into af_local_connect which may be called
      via select, possibly running under another identity.  Call early here,
@@ -933,7 +948,12 @@ fhandler_socket_local::connect (const struct sockaddr *name, int namelen)
 
   int res = ::connect (get_socket (), (struct sockaddr *) &sst, namelen);
   if (!res)
-    connect_state (connected);
+    {
+      if (reset)
+	connect_state (unconnected);
+      else
+	connect_state (connected);
+    }
   else if (!is_nonblocking ()
       && res == SOCKET_ERROR
       && WSAGetLastError () == WSAEWOULDBLOCK)
diff --git a/winsup/cygwin/fhandler_socket_unix.cc b/winsup/cygwin/fhandler_socket_unix.cc
index 252bcd9a9..a2428e952 100644
--- a/winsup/cygwin/fhandler_socket_unix.cc
+++ b/winsup/cygwin/fhandler_socket_unix.cc
@@ -1696,6 +1696,13 @@ fhandler_socket_unix::connect (const struct sockaddr *name, int namelen)
       conn_unlock ();
       return -1;
     }
+  if (name->sa_family == AF_UNSPEC && get_socket_type () == SOCK_DGRAM)
+    {
+      connect_state (unconnected);
+      peer_sun_path (NULL);
+      conn_unlock ();
+      return 0;
+    }
   connect_state (connect_pending);
   conn_unlock ();
   /* Check validity of name */
diff --git a/winsup/cygwin/release/3.2.1 b/winsup/cygwin/release/3.2.1
index 7662c7114..9edf509bb 100644
--- a/winsup/cygwin/release/3.2.1
+++ b/winsup/cygwin/release/3.2.1
@@ -1,6 +1,9 @@
 What's new:
 -----------
 
+- A connected datagram socket can now have its connection reset.  As
+  specified by POSIX and Linux, this is done by calling connect(2)
+  with an address structure whose family is AF_UNSPEC.
 
 What changed:
 -------------
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 5ec36e409..aa3594ce2 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -76,6 +76,12 @@ facl(2) now fails with EBADF on a file opened with O_PATH.
   as symlinks to the actual executables.
 </para></listitem>
 
+<listitem><para>
+- A connected datagram socket can now have its connection reset.  As
+  specified by POSIX and Linux, this is done by calling connect(2)
+  with an address structure whose family is AF_UNSPEC.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>
-- 
2.31.1


Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
 by sourceware.org (Postfix) with ESMTPS id BBAE83972004
 for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2021 22:48:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BBAE83972004
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdWjEGm5Pli5/6f+e3fVgeDfThNhnj3K1mDtSYjwb/tVx/DzxrjuLyG3p44BIbXY+njXcpLs4BNZZFb9vqa9v+DQE6AreLp6wluQ0pRsBVy8sAqBCwvFd/6SWApi1I21kZ9vAeTUnUn7XBn6fVehM0ZSY/IHRKJIYuxuhnnuJyBo5Xd7Xqx56oP71tj1g6+IwIIaZFvtHSYolEh73uaFFVFu+a8toP9SnUavHUJCJce2Uo0fLKVL8vFxTNuk4EaFVPuRNPtOc7ZMc497DP0FYJdKDpaYbElKZiISx/znSDfRtZwaMII2X6pHZvTRwIA37GVhs7TBHbI/CIEGLbpHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg8OeDQLekQvEFMcK4yxJs7ZSPpvIO9+21latJyEU3Y=;
 b=avI62sOXcqCobIL2JbIfcOhx8A5W4h2zJ3gyr+qZFofb3kiHuy3deUxc2F5p8dXIDwDmOYUBqX/Lg2U+WSehpiIrOdkVU5f0wsry6/0P6pplwY4GOTH9u22+JKf+3Wg4RqnPeDGKfOWKtY918rv0umEO5P4TOBullmHu/JFukmFAVbGu+lkqloIyN5OkBen2n01YAUHTSVUi+BueX9ydkpa5dIzg8+iBMpAx1v0ccf6A8nBAXgxS8iHi+aMLXgRIQhBTGrczTNDjJVnrGnbv7wAL/BJUUqAsGKd3GLShUl66OBF3R7H4fms/RcRpSx38s9l8QPdXdXAAUJ6QJ5smRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6163.namprd04.prod.outlook.com (2603:10b6:408:5c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 22:48:40 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 22:48:40 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 7/7] Cygwin: simplify linkat with AT_EMPTY_PATH
Date: Thu, 25 Feb 2021 17:48:12 -0500
Message-Id: <20210225224812.61523-8-kbrown@cornell.edu>
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
 Transport; Thu, 25 Feb 2021 22:48:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 454303ab-31ef-4da8-577f-08d8d9df7e30
X-MS-TrafficTypeDiagnostic: BN8PR04MB6163:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6163AAACF5EF88AB6F8764A1D89E9@BN8PR04MB6163.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WT1YsZwHph0Ry/+1mPj4nGjSyaHlqAMBdNxB3nkWQAyK60mQSQAeWe6zb25Yk36sNdCssmE6kB50DO8VZDahLFy1U9A4lV08Fpuxhj8Iyvq3RMEk0NgAPPoDqfi18HPJVtx1q8Qhn4hFc4nG5q8KcTNuUnaZfpDnp0xDZKCccfE+huhneAvcxYSm2QPFoKshoTyurmXJhOkKOPxEZwFFMKVrVaDV0OlhFzJOFAsI/VVsnov89tODYR/RDQB1Mw/zz474Y8vji/+rEs6jzyYgldS8hHR2mCLWht0mw0SfX1ii/s6S2FkFdN38ylMICczV00tYe9c5zrXqgGtQ5qnlDaGPOzVDd1vQVOwEXAAKjc4XldVAiexci8TVelCfDwT+kTPk36na5Vf3jwJqHvWFUH/G2XPw8ePJ+iEgZt/EA7MJH9bPSB2zcz25AL2I4dnuviZKDw6ndv7kbZddlv+vvjh7iwJrSrZkqtuosLrAd7ceFYS31et0jnbRCXGkrCDU26Ao/fiHxRXrqRQf82iQ0ghFh0r3m1A/rpq8A9O9Wb2T8bgNRjPdq31Trp9zgVr17rgW8FZrXGH2lNsY9gi/9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(1076003)(26005)(8936002)(66476007)(66556008)(86362001)(6916009)(16526019)(186003)(8676002)(66946007)(2616005)(316002)(36756003)(6512007)(956004)(75432002)(52116002)(83380400001)(2906002)(6486002)(69590400012)(478600001)(6506007)(786003)(5660300002)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1XeXx+ql4RFZZ6TkKBl47lXPg3P+WJIb8zxihMyxr1LhBaa4A2H5BZQRJCNB?=
 =?us-ascii?Q?sSeP5RWp6YAViE5nJ5ErcCA80/c2LL8SVG57JzROmDuzQHEvdC+NONbsGod0?=
 =?us-ascii?Q?OY4lv5CiNj695wMMJGxwX57pLT5nIyvB5GskVH772uXuAMi7pTmRWHjRfNzz?=
 =?us-ascii?Q?gT3uOZ6/PBttihr0q4sIdCJ21UEE8XKLoH6t8VzXd4bS0mVA0M2lwgFsSgpI?=
 =?us-ascii?Q?lRavOB81OYpPeAEaXup5ZpjF39XBX3aPwswdTPlelpR25OPDl0FrxbE5cTxN?=
 =?us-ascii?Q?CTY+wBQtQCEXwNOpZQ2NIvP5k3fouLSkWEJ0HfA0GnmHEith1Y2sPV9v6TQw?=
 =?us-ascii?Q?0+L6+DAmGO13sLTo80o6Rlv3qRmOo1zzmoZPWM7c2Vap/Vg9RgYSakh9l7/m?=
 =?us-ascii?Q?arjj6m8H5w7xS8J4wZGJ2dxK4+ZTR14biwQqfSqDTZwSAAG6ohm7A9+F1Pet?=
 =?us-ascii?Q?gfN2nYFlmsI/Bl6cl+/uGwOELkZxV87ee4UH6+OJPHbW5KEVwWU3VDrnBxSj?=
 =?us-ascii?Q?l60ysaITjNrUSS7Wsmp7oEUqiD4NTmo4hetf/bjq1SGUArUZzbvtY+GvYz8h?=
 =?us-ascii?Q?c0wwLRYS3oOBwvQP88d0Rk734t8+Kn5vVpT3TUsHkA36Ss3mVz5UhER97Sh8?=
 =?us-ascii?Q?23E9q4N6O8pfZ8Kwvq5VnUMAvh9ZX42jRZVumzARtqECb3PaO7rWZUJ/IiND?=
 =?us-ascii?Q?gRqVz1L6mDGb6PjOPRHmCryZ8B5gDdopIV5PMbNrOqwYIy3SnnUrlYOlZ/uC?=
 =?us-ascii?Q?LRIf/lb/0xgnfiFQdM9iQor9w++RY2G2AAUq4WcllWehGIyamqHus2WmYL8D?=
 =?us-ascii?Q?7dNB1bWT2WSyioxsbP6eZL+21NznhSwc6IP8PYEJzUx7wXevjSgh+Ip0V8tI?=
 =?us-ascii?Q?FY2yknlC7CT7awifgcXK9yvEegVjHTYcyf6hCvoWIA+S2FeWbJAOKDvmGp8X?=
 =?us-ascii?Q?fnvCgV8P3PR3NQai4b4ts5hpNyzgBRWMt/Z//lt4+09AFK6Fv/r/zp0fi0iV?=
 =?us-ascii?Q?oX+osekpAJfvp5yhrlALu+pox4G7QRMDpF+xTY4XE/MwEcYWR04wvWs8eSIE?=
 =?us-ascii?Q?2y9xhwu/gt9aBo2ZnBnligzP2IDBq+PZe8nZ7+8baiEJpbj/rsi5XT5paxrf?=
 =?us-ascii?Q?zQq1s0VwimTW1Lg1kEq5yzmMsBhBm4sRZSHjAdsPaeTLVuCHYakBbRae9Lb2?=
 =?us-ascii?Q?Sny5MXs/vRMDWDb1uDC1pAVlHOttghKCHw/ilTENIJfGugz9CbfNGV8LLqRC?=
 =?us-ascii?Q?LS5YIqHlvFTyIIvPxQSuLd6YxbJ+RwyNu8ITm6/vKoA80MzXN3FvlSZJrfyU?=
 =?us-ascii?Q?HAHbtiyQ+CR9pkSr3+pZjjRu?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 454303ab-31ef-4da8-577f-08d8d9df7e30
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 22:48:40.0561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRVLmo+n2DfvBGsU7mfeIyBp1oC6F8mVDZrNiqoRQJu8JnjpyNXVz7GP7XCS+qdA0qNwGm2Mg79/T9fxf3qEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6163
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 25 Feb 2021 22:48:49 -0000

linkat(olddirfd, oldpath, oldname, newdirfd, newname, AT_EMPTY_PATH)
is supposed to create a link to the file referenced by olddirfd if
oldname is the empty string.  Currently this is done via the /proc
filesystem by converting the call to

  linkat(AT_FDCWD, "/proc/self/fd/<olddirfd>", newdirfd, newname,
         AT_SYMLINK_FOLLOW),

which ultimately leads to a call to the appropriate fhandler's link
method.  Simplify this by using cygheap_fdget to obtain the fhandler
directly.
---
 winsup/cygwin/syscalls.cc | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 460fe6801..6ba4f10f7 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4962,6 +4962,8 @@ linkat (int olddirfd, const char *oldpathname,
 	int flags)
 {
   tmp_pathbuf tp;
+  fhandler_base *fh = NULL;
+
   __try
     {
       if (flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH))
@@ -4970,21 +4972,25 @@ linkat (int olddirfd, const char *oldpathname,
 	  __leave;
 	}
       char *oldpath = tp.c_get ();
-      /* AT_EMPTY_PATH with an empty oldpathname is equivalent to
-
-	   linkat(AT_FDCWD, "/proc/self/fd/<olddirfd>", newdirfd,
-		  newname, AT_SYMLINK_FOLLOW);
-
-	 Convert the request accordingly. */
       if ((flags & AT_EMPTY_PATH) && oldpathname && oldpathname[0] == '\0')
 	{
+	  /* Operate directly on olddirfd, which can be anything
+	     except a directory. */
 	  if (olddirfd == AT_FDCWD)
 	    {
 	      set_errno (EPERM);
 	      __leave;
 	    }
-	  __small_sprintf (oldpath, "/proc/%d/fd/%d", myself->pid, olddirfd);
-	  flags = AT_SYMLINK_FOLLOW;
+	  cygheap_fdget cfd (olddirfd);
+	  if (cfd < 0)
+	    __leave;
+	  if (cfd->pc.isdir ())
+	    {
+	      set_errno (EPERM);
+	      __leave;
+	    }
+	  fh = cfd;
+	  flags = 0;		/* In case AT_SYMLINK_FOLLOW was set. */
 	}
       else if (gen_full_path_at (oldpath, olddirfd, oldpathname))
 	__leave;
@@ -5003,6 +5009,8 @@ linkat (int olddirfd, const char *oldpathname,
 	    }
 	  strcpy (oldpath, old_name.get_posix ());
 	}
+      if (fh)
+	return fh->link (newpath);
       return link (oldpath, newpath);
     }
   __except (EFAULT) {}
-- 
2.30.0


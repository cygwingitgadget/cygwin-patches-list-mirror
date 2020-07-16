Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
 by sourceware.org (Postfix) with ESMTPS id A23F538930D6
 for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2020 16:19:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A23F538930D6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYZ0Yb/49cp5yUr4dvNp3ffYJnmDnMs0qTyfv+WQzRTfQoEAN5nj48KkXhv1JN02T54+P3bapoz7kkaug+gUOWqStYYJFKh3jZ+mkcQmHGfOdHL1Gf9vJ++34fwdlLkLhRnvI0JLQ4gcCukdIByeDXHXOkejHbrYMRu3mjg8/koRRL2KNYQZM77JvhVoJS9/inOn27umyWS+h7oqYW0tqRvJ+Py4ZwahmgcGz2LfP8v/QSkoeClloh2muR9LzuVTGpCg7B50eA70VmThZbMpDvzGqTrJiF3E/6F6aowtCy2Yk90jgpqJHmt8A9eERoFc7OcXhkAn8mVwMEmB3IEEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvOnldpIs4DbJpOQo9+/e6QNuF8FJTAjxAEzIWE4mko=;
 b=LyBASDoI8o9KirwF+pPRMXflk4D6zQQ1TtVrrEYuQbYMVeURzbSTLGUmqm1WytdqFEZP0tx2SdrRL4DuK8mJv4YCSd5/p5d4xMvr1V/gSDVWeOBbvjpxgqKcf8Lv2+PBl7aB2nzTlq9kPtJRA26oFHQBM8PROPXNRFAIMrIu5QW1yaDCdh0iHahzyJMpP/iC1LUXSeqOViaBmnnvf7JndoVi2ZWzE+NKswSieI0jcPcOQd2fiZdD+KmVBOgwnpddCZOFc4DOrPTb8l+Jm57WVy4+Jvy3RfL8BPanjoptA07f9hjVrGkXLuUSsnzCXhRWOFh0V2Q/BOtz4uCZ/rJ8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6112.namprd04.prod.outlook.com (2603:10b6:208:e0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 16:19:39 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 16:19:39 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 12/12] Cygwin: FIFO: update commentary
Date: Thu, 16 Jul 2020 12:19:15 -0400
Message-Id: <20200716161915.16994-13-kbrown@cornell.edu>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716161915.16994-1-kbrown@cornell.edu>
References: <20200716161915.16994-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:208:23d::19) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (68.175.129.7) by
 MN2PR06CA0014.namprd06.prod.outlook.com (2603:10b6:208:23d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Thu, 16 Jul 2020 16:19:38 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8db90639-5c08-416a-621b-08d829a409eb
X-MS-TrafficTypeDiagnostic: MN2PR04MB6112:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6112F142983AEEAB01300209D87F0@MN2PR04MB6112.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnv+5Q7Hu1JakJ/auk8qU6bi9gb9IRdIGQ16GHBtRcxIbTkwvS8Y1oKj+GTHnfKufzHvj9YRh/iPDG2+nOi0OKVmHSy52r3eggAmYXhjz5obNO8xii+M/B0+F4B8FCNqYGYOVT+2FFwhFJmkC6FA7jxf2iJ8AWtApt6Ply5ZEbO2JFuGgVoOS3t8dWIhEiiCYKAfUFSJQWtS8Tn436Y46mk/jKJn91JWH/h3HAVXUuYVR8KUnG+bb10eKeMsEL4X0bbGRCLgqnHiAuJ/+un/wtseyNIWRgyez2fOB4q1zioxS15UGesmb2SiOSx9YhNTCz2d7OFEAiXG1KaLKJg5Bhrh65MFzqrwKwo7sO3u44xKtL+8aSAh0TGOXtB3fAXu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(66946007)(2616005)(66556008)(5660300002)(69590400007)(6506007)(8676002)(83380400001)(16526019)(956004)(6486002)(6512007)(52116002)(186003)(26005)(8936002)(66476007)(478600001)(2906002)(86362001)(316002)(786003)(75432002)(1076003)(6666004)(6916009)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /sVyVarB9IynZML8I//MN5nJFUJV7k5eqv+rYmLZqC6hUEjsNe1FaDI3ncfvcy1Vy35bu26SDvnJfPw0rH8guoMEN6wX9I72sgPkz7Jps6D97diWgx9CCOxDBmS8t/qv04Hvf4Llz1scD7UmU8l+q0qpFq9vDTcDNEmfBxhbESB7mUOrbBjkQnqSggNRxAIKxtrO00RkBbkiBfW3xVInrnhTl/GR5IuNEW5KS6AF9lbJ5vl4H/1e/bAmsNVwCouDoKxdOk0xVckfCrUPXGgCbucwIk4XjPI45V0eEqIcQGXG8BHpQybOVVBvpZLe0l4xEVAwbkbux2V1/ux+uKN8GOxVNVKl9Ql/i/2sRmSaG9Fhozxakq1KeX2HumNB7YD6RYZcwt72R4kIOh70lbQyL95HyVW1kNFXY8Gedb7hhAPVGVX2LfxQZEilB3WdYCTHP8OhfqjdgtKvoN7XQaI7MdimHbLv46wM7bX4+aIJXnE=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db90639-5c08-416a-621b-08d829a409eb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 16:19:39.2300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oENzaKh7i11lqGn+zkuKBNlllJ4jJ4WOO4bza35N+ng+waRjdaHuKXIlMc5mm6FkJ5tsQk9bv+ug9Shw4JC67A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6112
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 16 Jul 2020 16:19:48 -0000

---
 winsup/cygwin/fhandler_fifo.cc | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index 30486304f..e9d0187d4 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -52,10 +52,23 @@
      which is mostly idle.  The thread wakes up if that reader might
      need to take ownership.
 
-     There is a block of shared memory, accessible to all readers,
-     that contains information needed for the owner change process.
-     It also contains some locks to prevent races and deadlocks
-     between the various threads.
+     There is a block of named shared memory, accessible to all
+     fhandlers for a given FIFO.  It keeps track of the number of open
+     readers and writers; it contains information needed for the owner
+     change process; and it contains some locks to prevent races and
+     deadlocks between the various threads.
+
+     The shared memory is created by the first reader to open the
+     FIFO.  It is opened by subsequent readers and by all writers.  It
+     is destroyed by Windows when the last handle to it is closed.
+
+     If a handle to it somehow remains open after all processes
+     holding file descriptors to the FIFO have closed, the shared
+     memory can persist and be reused with stale data by the next
+     process that opens the FIFO.  So far I've seen this happen only
+     as a result of a bug in the code, but there are some debug_printf
+     statements in fhandler_fifo::open to help detect this if it
+     happens again.
 
      At this writing, I know of only one application (Midnight
      Commander when running under tcsh) that *explicitly* opens two
-- 
2.27.0


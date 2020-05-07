Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2122.outbound.protection.outlook.com [40.107.243.122])
 by sourceware.org (Postfix) with ESMTPS id 6BA093973016
 for <cygwin-patches@cygwin.com>; Thu,  7 May 2020 20:22:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6BA093973016
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaWez4D/zf0cU/7fhzASJFLwLwsxgsQphZ7H0yLGRdZ9XAUwb3mQ7FTtBJ3nE9Ew0L6hZqmvjacXE7fiwpk5HhjSvp8pDWa32RrxxY/ZUcsAO2Vfk2ctLqqT/+gsaG2mwer5hbhNBWDtXuBbBKaa4yU9PEkP10qRM+lSeoUNdroAwAk3ighznNu1NWEaUEjfnTK0CEZ86eFGVYRi+tsmmOL5Wmwj6kMrmk01vPvFd8r/IyApPcBhrQb7FlaOHUnXkSL+wi4ogvwcfS0EHZfq/1NftVSUGq6/diddIOw2f9DEF6hGpZTQBmd954Lpqn7SvyxB3Xp+CmGEaElJQs/bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFOZNfopiAwqZD49BQh8mZ07v/lBNOqiwPMBKljMksc=;
 b=WhVt+E0yng3cs28WKKuRCWj6afXSvvXbKt8cItr4uwW3M2Yqh5RhSSdRpTCwq+NRQ6FQ8ccaGhCeAB2heodA/ZIySDDYoSjuUesHoRytszZPxqg2NFz6uwMces8AGf3hCo4ZpHzvPjaBJ+9tea3efYQmdVieGBSHqWlam2ma7Sn06dJ+bc37HEd09M95/yVqgcKNUFgGUJxkHsX+k3K/wj0/yo6+3iANdoK66uZHaoLpOf4S4/Ng1JdMcdo7jmlN8YHYwvoovy2AxayFZYXPhfEzrJhaoaermerx+XwhK5VK5+73R0ZuPqWQCVB3/EkvpNKepWAxhS+aHKkcw51UdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB5082.namprd04.prod.outlook.com (2603:10b6:5:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 20:22:00 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 20:22:00 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Cc: sten.kristian.ivarsson@gmail.com
Subject: [PATCH 21/21] Cygwin: FIFO: update commentary
Date: Thu,  7 May 2020 16:21:24 -0400
Message-Id: <20200507202124.1463-22-kbrown@cornell.edu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200507202124.1463-1-kbrown@cornell.edu>
References: <20200507202124.1463-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:e532:58da:20b8:9136)
 by MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 20:21:59 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [2604:6000:b407:7f00:e532:58da:20b8:9136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db03949c-bd28-46b7-98a9-08d7f2c44c0c
X-MS-TrafficTypeDiagnostic: DM6PR04MB5082:
X-Microsoft-Antispam-PRVS: <DM6PR04MB508210D6CE136198B32B8535D8A50@DM6PR04MB5082.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61oEnTNCqvjZy6eVAHCRKfNxPoprck1kQXmvgzCTrLOms4jbBmBsIulxQXV/X/TOGRyUvpBp6+xc9Zvy1V4dnMzTX2+EyCbu55SB2W0/U2EtP5+OH9BONSe27lpL/UYpp/f0k0IZdHCrCYUstbG3ASTQ+J8gr3i2ICp+YNojiTCXQY9tEzLZsiumYXh/iH9d7zDG/lrfOydehjGlLyLo0t0qGld5/3ycbTvqdDJdCeNv6ghSK4UnSR9R85B7/IrBNo1xP35LlyR0OEvC5jq7y5woBo+GETDy/jg3QOCSM7f2eiCWn5YmE4d6+VFQpi9evvOloNT2Xf397aidvX35fhj3klQVsKUuNVjo8E2cVFbABAOsmb5WiW1ia/P+IwjIxMYEFTRF7yFZ6v0y5n+Ogmltvhh7v7jfMH2/aYWXgAEDpxDlCjtRfIsrzRvy1WWYxL3XFBGWg8aSUOY6nWwpRKTr9UPNNxNh/COwxpOmlRJK3gbuYz7q+62wTde5YqdIvbdYonL5YnR1+awJGbYffZxXzqIMmWaYDi9r2PLO4YdivhsM/GmsrEdUsxvnykNs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(33430700001)(66556008)(86362001)(786003)(6666004)(186003)(6512007)(75432002)(52116002)(66476007)(69590400007)(316002)(6506007)(2616005)(4326008)(478600001)(15650500001)(5660300002)(1076003)(36756003)(2906002)(33440700001)(16526019)(6486002)(66946007)(8676002)(6916009)(8936002)(83320400001)(83280400001)(83310400001)(83290400001)(83300400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CqYnqUoRzQ09eEpokdEbbkJC1or/Lm9Ed1iGQDxOJ+MkoSU487UvqLJRGjiC210bVSDcjmPUbrgGxwpr57tWLZsQN3ns9XvmS6RymVxWxiJzj+bYANkTQ7Fo0rP1riMkwmEOEMhl1VMLQbE17xUJgG5whS5m8HVnhQJ0dAUagDQd5hbzjOEn3sTarbTwbEV4si1+hUPP4Cl/yCWf0vBUvPMttKbYV/ApB+d8B1mg6HCbz9bqS/xei96zSjfJowX8OBTooVU2wM4h2urRvrPgW3V3f71GBp0kHpggEUO5bLlVUdAIjxv23Qwg7W/MoD2PX0m481LADbPedZSCqk3meMbKmBWUgmRAhKHCOwYFnPl1fBewdtODCNtZSvMeOINh0WRzORngi5/e/7Cu6iUnk5Pl/Hk3DjAocb+S28GZLL71HrrC4rSAOnuknFF4wk4I2gt2YC6xxBaN68kITUUWGbFnza2XGar9+WvHvr26Z0t4OBNqq32m18Ngs01p7rfv5ppIrOTS3Z8kmypcp1NLMCiGtnLIIToO9VsUxzMRqx7pzs1xkfDk/JiBRK47l0f6DWza6fkOZ50+ArQ8hul7Z1uRlZZCET8ons1Yy8LxPzhAWkxTrC2bFDtDXk1AN76M0oIBpop4HnlzFkMguMAIjSe5zIwCmTGaG9A2OdajZ6G4L1R0OvF1UVKcOuTkbgHLrAYbZCQ38f1Xt15wAHy9TSxZBQpQOqsmxjVVw2CS8CWRBKCfYipZbgbbIvbBa81T8aTNNRMOqzDxGh90Bkcu4tl90VGPKBOWhqOG/YP0FwuoaBDA2PQfhNYnc0/47CKIrwiYmpTOQyK7vJZfQKzP/TaRTkVZPHySniuL0mZFAiCXJkiePVoXq2qDJOg+IKzY
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: db03949c-bd28-46b7-98a9-08d7f2c44c0c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:22:00.1519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAeaKWDrmk7TFxm3U4EU9boxMJQoNYCM8OAaRhYsynVBf2viTK41wK+AsgdtHua9J5fYv4hwFKKlPn4cAKoyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5082
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 07 May 2020 20:22:23 -0000

The beginning of fhandler_fifo.cc contains a long comment giving an
overview of the FIFO implementation.  This is now updated to describe
the support for multiple readers.
---
 winsup/cygwin/fhandler_fifo.cc | 58 ++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
index cc51c449a..7290b4655 100644
--- a/winsup/cygwin/fhandler_fifo.cc
+++ b/winsup/cygwin/fhandler_fifo.cc
@@ -26,29 +26,41 @@
 /*
    Overview:
 
-     Currently a FIFO can be opened once for reading and multiple
-     times for writing.  Any attempt to open the FIFO a second time
-     for reading fails with EACCES (from STATUS_ACCESS_DENIED).
-
-     When a FIFO is opened for reading,
-     fhandler_fifo::create_pipe_instance is called to create the first
-     instance of a Windows named pipe server (Windows terminology).  A
-     "fifo_reader" thread is also started; it waits for pipe clients
-     (Windows terminology again) to connect.  This happens every time
-     a process opens the FIFO for writing.
-
-     The fifo_reader thread creates new instances of the pipe server
-     as needed, so that there is always an instance available for a
-     writer to connect to.
-
-     The reader maintains a list of "fifo_client_handlers", one for
-     each pipe instance.  A fifo_client_handler manages the connection
-     between the pipe instance and a writer connected to that pipe
-     instance.
-
-     TODO: Allow a FIFO to be opened multiple times for reading.
-     Maybe this could be done by using shared memory, so that all
-     readers could have access to the same list of writers.
+     FIFOs are implemented via Windows named pipes.  The server end of
+     the pipe corresponds to an fhandler_fifo open for reading (a.k.a,
+     a "reader"), and the client end corresponds to an fhandler_fifo
+     open for writing (a.k.a, a "writer").
+
+     The server can have multiple instances.  The reader (assuming for
+     the moment that there is only one) creates a pipe instance for
+     each writer that opens.  The reader maintains a list of
+     "fifo_client_handler" structures, one for each writer.  A
+     fifo_client_handler contains the handle for the pipe server
+     instance and information about the state of the connection with
+     the writer.  Each writer holds the pipe instance's client handle.
+
+     The reader runs a "fifo_reader_thread" that creates new pipe
+     instances as needed and listens for client connections.
+
+     If there are multiple readers open, only one of them, called the
+     "owner", maintains the fifo_client_handler list.  The owner is
+     therefore the only reader that can read at any given time.  If a
+     different reader wants to read, it has to take ownership and
+     duplicate the fifo_client_handler list.
+
+     A reader that is not an owner also runs a fifo_reader_thread,
+     which is mostly idle.  The thread wakes up if that reader might
+     need to take ownership.
+
+     There is a block of shared memory, accessible to all readers,
+     that contains information needed for the owner change process.
+     It also contains some locks to prevent races and deadlocks
+     between the various threads.
+
+     At this writing, I know of only one application (Midnight
+     Commander when running under tcsh) that *explicitly* opens two
+     readers of a FIFO.  But many applications will have multiple
+     readers open via dup/fork/exec.
 */
 
 
-- 
2.21.0


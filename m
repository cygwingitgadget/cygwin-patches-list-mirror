Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770132.outbound.protection.outlook.com [40.107.77.132])
 by sourceware.org (Postfix) with ESMTPS id 3FE9C398B824
 for <cygwin-patches@cygwin.com>; Tue,  9 Feb 2021 15:12:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3FE9C398B824
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOOjT8RFPe70TUXpLy68AQkkCLMW48x78NxZwtNG4wRh3zJIWTX0sYxf/r7iXd6ascxrORd/3Goi4w/ABzCm0PPY8auoRvJVMMYAT15AHREG1hUVGq/LVVi+iJrMkfV4a4/DIqpBqk/weGqJeg45L5R9kAu2sicy7pT+5YctNnK1quoXn6y9gY/xd9bsRHgkuXGPYCwiVvk4jsmrMopn2i717Kt5DB2a8Q8DC8yOJgXxx94nn/Zr63hBJ7BapVc8JXXonF7uA+dP4drzEiZL23ref2G9oW9Zj5lGGptU/iQP9lifSo3YKQDF2pNs5cbeGYZWssAgUYG5uZNGHAmRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpevF1FyDig2QSrVzNeiUqLtn+TmNzoe331ofO6LDrU=;
 b=RYlKy94kllC0dnap9BYSlSSLlj9/xIFwQkS5D+alIjS3/cE6UgflVTUJeWStRvNWyVOcr0Fi4qYldloZ5Tc+sDc45yT5wGKvbm/XtuG5rLxHB2pyUgOF+fo2QLuj3uSWuntoExlZkKncqrOwCPDbJDK+4xR5pgtuC4gWyd3HXZWX/EmyU8eM33rHBy543G9sX79J0bBSaneCTIYOndiHC6Xr+fkMrjCJnGzT9fVazJqMcsoyqW4u5JthPKJrqLZ1rDBjHck9d1iVkBsa7SaaXGwqkWLXFNLZ0ZVtdSVe8lJZY2Sd8kl+63W3vcRnWQp/hRNMsAM+pDrtDseAhWwnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB3954.namprd04.prod.outlook.com (2603:10b6:406:be::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 9 Feb
 2021 15:12:20 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 15:12:20 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/1] Revert "Cygwin: fstat_helper: always use handle in call
 to get_file_attribute"
Date: Tue,  9 Feb 2021 10:11:58 -0500
Message-Id: <20210209151158.57831-2-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209151158.57831-1-kbrown@cornell.edu>
References: <20210209151158.57831-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR14CA0032.namprd14.prod.outlook.com
 (2603:10b6:404:13f::18) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN6PR14CA0032.namprd14.prod.outlook.com (2603:10b6:404:13f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Tue, 9 Feb 2021 15:12:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7be9957-9a03-4c3f-f3cf-08d8cd0d1830
X-MS-TrafficTypeDiagnostic: BN7PR04MB3954:
X-Microsoft-Antispam-PRVS: <BN7PR04MB3954F5A96A1219D5708739C3D88E9@BN7PR04MB3954.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRR2Jf8TRvH1TkyL3TzgovNY2O6udOKHJ8zTH/++qBye0h/YpNAUhoI9pDp4oK89vEuFar9nFWOuoOvueLyc6ABg4o3639zFICmkCpFtGU+/jeuYTd74weVSrTFl6zTadJq41mZxCRej9b56m2253IybCrppZUA79pDNtQ/sSS0T0ELoxwbP7qNpJ6KP9oIJGKMYSDJWSoD0l2jdTLWi/zpD1moxsPDtBVpwqqq1W6wC+yGre8ZDzakCW+7XqK4y6+D3uAgGt11rPUsO4LC1qZ50O7VBDDhyCWM+zwoZ+SiiX0I55vJGDVOyUCcTKx0+IAds4bz62eOzpKja7z2hAegPbfvJuCWLGFD270myiYWuYS88fQsgG6eX3lllF9qa7hyHjyqjfaDchoLUhgyzzChT8AuTO0JwguelU+tVdRPDh+9jFqTYH7l+xsZxc/JRN1E0O4Al+FCSMydxCysSJqR6kwVe5lV0WjFpJN3F+y0pkGSS2gu0GP0XAtUIrEL5rL4qDhFprh+JgmU3YQm5zivPmt4qkGNt/bQ6e8m0pNsyjP5af5FUuvf3p3HLNx9ErhiY+EMaFK1gum38jkKyeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(6486002)(186003)(75432002)(36756003)(26005)(86362001)(83380400001)(2616005)(956004)(2906002)(1076003)(316002)(786003)(66556008)(66946007)(66476007)(6512007)(6666004)(5660300002)(6916009)(8676002)(52116002)(69590400011)(8936002)(6506007)(478600001)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2vsKz9RWj3WZ6V8oHR0NLnO8SYnVIOCFVet6L3/TtU64cIxTRPmM8yHyDP/9?=
 =?us-ascii?Q?3JVVhqVOd09JkJxT4CR3DWCGjhIE/d9KW3LwXdu++txmVXW1qE3dvVafdC2e?=
 =?us-ascii?Q?OkIjm7Aze7ps+WTxIwTzP1wA1CABLZ0M3+zImPy21N7WQTmHAucHv6+j1Crj?=
 =?us-ascii?Q?H63MTraAl5NGkqzjq7CEnfnz4+udZ7mwq9kmjnsLekQzexhkldF3Mh63QgES?=
 =?us-ascii?Q?O213NLLBj3oLRDO2M8c8QXH1/zrGJmgOO4A/J9T+UNFPOe6B47Z+Bf7ev0rY?=
 =?us-ascii?Q?r/C5jGhBS4AzX+Hj5RAAkrIDCb1CSW0QVy3N+yqBeS+I967srx0fA1Hvtt0v?=
 =?us-ascii?Q?KPXBGS1zTfDwSf2hKk80mfC4ZdoVUC8fccUeC9SQdZIC6/ugIEwhxjgCmVOU?=
 =?us-ascii?Q?/0I0RZY6HLRphBhjcdllNF+q9xoiIzphKDHZkVLJDcjlM+KgRpQJgj8pm8mi?=
 =?us-ascii?Q?f4fuqr/eeG94GqPVl+ispOJ7Vpx8rICRFZr7pF+u6xli29ewUEtcL9i3os49?=
 =?us-ascii?Q?dMHV1D/SHJaaMq4qE/GKIrilOE/PRL0pTopZAt5QbJcrWi3wnJxB4faxLyDJ?=
 =?us-ascii?Q?OxIc9uXRmu9c7tegjTLKLVFe3/TLMfpitAiJDQ0L/IuJyJx9GOU02YUuAECa?=
 =?us-ascii?Q?5SBvSBBf9GdwaUPEbfyg7MYrGLyl5+0xpwZHxh8EyxqXVsymCNznTrNaspB5?=
 =?us-ascii?Q?urRHLs1klKM/M3bLCa3MXysQk/m7Z5NXRBO7mouOGLB6i+7EPHQ0Mqqlliui?=
 =?us-ascii?Q?2F4RUYIUZZCLM4A6Zw1MaNnXHpizbJOqK4Y0bqaA+BTd2EC3xy5hZRx9q04p?=
 =?us-ascii?Q?eH6GJQMCBGazXnW421gE+LtAPaeZeKkxUvbZJ5YE+SpladPCwmMoCv418HY0?=
 =?us-ascii?Q?+y6SExVNN3pun4zsnfjwGXBl620ajcG/0tbX2VCo8v1HHfX6xyscqdz3va+K?=
 =?us-ascii?Q?jOGhCNWsbs14+CptNBxApAKpXtLEew/MNJQp55dlrEBGQvUvZpEdXamNB7hS?=
 =?us-ascii?Q?oLsQ7grdaVJbhoq3y4bLuJU6eAQGX4j8LNZ1CT48yn3Ks8vZqaMgYh1suRWG?=
 =?us-ascii?Q?9zpS16ct3im1axAHIXdcTlHJKQzD6Vc5I4SpVppnQbrd8In5q3yXmWF23bs8?=
 =?us-ascii?Q?JOhtCnmTrvOaHGrKxAAybtTQYyp6RbGDwoyNGV+NL4dhRMWBlqB7rHT+kh3n?=
 =?us-ascii?Q?yHSesTN5eTAqQklSuebmFKpfNt/swUYA8xGTQfuG3i7Ifm8RlbTnPFa8th91?=
 =?us-ascii?Q?NfcWZqxLHO1jISx/MkRqjSxhCWY83YGZWKHJ30wBVA4o/7HolBtbeppFU7Gc?=
 =?us-ascii?Q?/brUKThXDGsbOYNTQhm3aIoL?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a7be9957-9a03-4c3f-f3cf-08d8cd0d1830
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 15:12:20.0243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhifgNyHxKhrwliHWTqoVQDTaFbuT5sPbjmQ3n5BHkOfGmboc/NtDPcYMOP+O4/WOcbe98LQ7jSgtTKkVeJSdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3954
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
X-List-Received-Date: Tue, 09 Feb 2021 15:12:23 -0000

This reverts commit 76dca77f049271e2529c25de8a396e65dbce615d.  That
commit was based on the incorrect assumption that get_stat_handle,
when called on a FIFO in fstat_helper, would always return a handle
that is safe to use for getting the file information.

That assumption is true in many cases but not all.  For example, if
the call to fstat_helper arises from a call to fstat(2) on a FIFO that
has been opened for writing, then get_stat_handle will return a pipe
handle instead of a file handle.
---
 winsup/cygwin/fhandler_disk_file.cc | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 5e58688b7..ef9171bbf 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -394,13 +394,12 @@ fhandler_base::fstat_fs (struct stat *buf)
   return res;
 }
 
-/* Called by fstat_by_handle and fstat_by_name. */
 int __reg2
 fhandler_base::fstat_helper (struct stat *buf)
 {
   IO_STATUS_BLOCK st;
   FILE_COMPRESSION_INFORMATION fci;
-  HANDLE h = get_stat_handle ();      /* Should always be pc.handle(). */
+  HANDLE h = get_stat_handle ();
   PFILE_ALL_INFORMATION pfai = pc.fai ();
   ULONG attributes = pc.file_attributes ();
 
@@ -476,8 +475,8 @@ fhandler_base::fstat_helper (struct stat *buf)
   else if (pc.issocket ())
     buf->st_mode = S_IFSOCK;
 
-  if (!get_file_attribute (h, pc, &buf->st_mode, &buf->st_uid,
-			   &buf->st_gid))
+  if (!get_file_attribute (is_fs_special () && !pc.issocket () ? NULL : h, pc,
+			   &buf->st_mode, &buf->st_uid, &buf->st_gid))
     {
       /* If read-only attribute is set, modify ntsec return value */
       if (::has_attribute (attributes, FILE_ATTRIBUTE_READONLY)
-- 
2.30.0


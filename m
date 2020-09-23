Return-Path: <kbrown@cornell.edu>
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2105.outbound.protection.outlook.com [40.107.100.105])
 by sourceware.org (Postfix) with ESMTPS id D009B386181A
 for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2020 23:52:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D009B386181A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZeAZGoOFETiGHC2g3616FMAIeb87O/6YCO78PgU8+Yyv1D9dkeaNt2Q9/LUDVXXOMbU+Oq3dsRslMfzKc6RICRLOWPPMW91JYoIf3fGDhTSdCHJj4IAOgV8AdGMkkoVsm3dbaYEYQhVz2TmaVnrMRsTx8by4T49p8TSlf1xjV1CXbTUGmV1aZKkYqxmYo+ZaqOOt57dKvgw+Jp5m6SEY4PU3bPseGam/V/9RoHzrsRAifEjbKPuJ1ZSLFOVu4Eb7Gu0mbNI51ASwECLRbUp2tj0YxHtC+RXFKKdy0WsST/pKzoNzbguX+efdOZL7dSStcYXWnZt/TxrU964i4DKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH8Jr4xRhC2Rye3Oj47uRYhGHxmY/lC+nSor/pDJSvI=;
 b=dl1B4Kg8hjNHwQ5aQi7DWZdvYnD94KIW0a3qduvoASHf82xbhlwubj/LfkdpydDyd/t4XhmMGBPzLJyTylcCkElLi8FQ+0xpiSoRscMkBibiIdz/cTAOXVlTDUua7XsuZlTjr3NLY0yq6oArbH7A6/6fJMzBECJJ/iaA4e3VGOnCjSCWWzFu1cmLQNW6SgW8Ia+z4w/ZM8etze+4jA7/pP6rzTnw5fnjbB+MM05jswmhsyUgyFyj4RsOsakHbu9aEm8W5gID9GB4kKuamPzGRrlRYzPCWCMjBjPpeTP0Y0frFQsrG8UKS/ArSaCqAHxjATOMVQ61MzN0fXCfUcpN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5789.namprd04.prod.outlook.com (2603:10b6:208:3a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 23:52:47 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 23:52:47 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: winlean.h: remove most of extended memory API
Date: Wed, 23 Sep 2020 19:52:25 -0400
Message-Id: <20200923235225.46299-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: MN2PR19CA0037.namprd19.prod.outlook.com
 (2603:10b6:208:19b::14) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (68.175.129.7) by
 MN2PR19CA0037.namprd19.prod.outlook.com (2603:10b6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Wed, 23 Sep 2020 23:52:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fde049ca-a883-4625-00ee-08d8601bc5e0
X-MS-TrafficTypeDiagnostic: MN2PR04MB5789:
X-Microsoft-Antispam-PRVS: <MN2PR04MB57892D2BFBF45AF111BC80B2D8380@MN2PR04MB5789.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wUMKHxlQClMk+kbKfTel/++hutI+4XACwKOpKn6U/bZMlzxDoCnfjPlghyKIC/Egqyjo51byqAvptkNxwns7Zu1M31EtHDx8c58RoxwBd0ZI90bIDdJY43WkY9Fs/aS75F+kyLfuIoZjcDkCMvQFH0kHpDriD2JrhQn7OWars5FtN/P7VPvvDJyngemlQAu1nOP5/DC3FUKmfukeC4CWmqr/1jb6IpR8k7xRtOAEpdC4rGjS+QsIb0iJnrcN2IvHc0HCeQFn3wfayrGkucFVIERlnmruNDmF8wbrYaP7SBqyyhvgVinT4nWPDLzoueTJRznuO5xVXQT/jJPEqOWbTSAbljOkOyXX+NGbAVS9gBHHLBVlEt2Raa3jag8WMSKPQmkUgAiHlZcE7XJDNoVWOR+JeVWEXjh2hghh5GR5qs4I0gfZGlYPfnvGmtxghla
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(66946007)(66556008)(6666004)(26005)(6506007)(8676002)(5660300002)(186003)(8936002)(52116002)(2616005)(956004)(86362001)(1076003)(36756003)(16526019)(478600001)(69590400008)(6916009)(83380400001)(786003)(316002)(75432002)(66476007)(2906002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7oUwvKXmVmf+BiL4yViKyaPddcy3sszF5xVZERftq2UfqTVw3lj28Lbll3WB6v7LDR8OBW//KGi/ThN+NNc79f7dZVAMyASrj5HhP0phxi06HChqY3pbVBELVgK+vmOgk2HTP3nM9orsQ3f9BtyMn5Z78GU0xHb2UT5ov7ABX18Bjs8dOs/bCXHMZ5szoFRTV4EMeOhv3U2K2p7X8skN9OYQ2p/eptPVuhbcydjQSs700cZhU44vm2Xia4ad14URrRzLAyLAXahZTlob5qtoYX1MOV6P/oE6EMZ+vY5eZureImHJKvh54GtEJnjqF8wGpbShE8S3E2A53mTer2Tn5qaDyh3fq1YvF+LGRiDHiAcKKZ3j/i1ligjoPorUxyQgBytsYJRFEaGB4JYi0ZJ5EEL8aLbp1BXc50mqr8y58464VC3C2YzAFo8fh5HoZuRdgTxySbZmeNQ7SUNbhARNMfFFu/L7tt2UaB2Y4NywuncsdaW4iGIYbrvKtU8nDdkmZ4tSGDvu2u4YMEruSdTLW6FGNId2ISDMvVCbqUbHCpZxeEef/L8qiPaVih5XaHkMwbh0D27h3jVnGsTv1GCWvstdH77kjeruer/5EirqrZr/ijWkElvjfzX7uwebOyNxz5iGgnZBZXyR42+rvYMUEw==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fde049ca-a883-4625-00ee-08d8601bc5e0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 23:52:47.5439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zssav10gsIyZLGH8IcJ1Ta5zkojSJ0cxYS++4urZPRz4bKMUFuiQR4/jzBJuqQHjtgOfdcZ3eWgwx9godn+tig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5789
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Wed, 23 Sep 2020 23:52:52 -0000

This was added as a temporary measure in commit e18f7f99 because it
wasn't yet in the mingw-w64 headers.  With one exception, it is now in
the current release of the headers (version 8.0.0), so we don't need
it in winlean.h.  The exception is that VirtualAlloc2 is only declared
conditionally in <w32api/memoryapi.h>, so retain it in winlean.h.  Add
"WINAPI" to its declaration for consistency with the delaration in
memoryapi.h.

Also revert commit 3d136011, which was a related temporary workaround.
---
 winsup/cygwin/winlean.h | 44 +++--------------------------------------
 winsup/utils/cygpath.cc |  1 -
 winsup/utils/ps.cc      |  1 -
 3 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/winsup/cygwin/winlean.h b/winsup/cygwin/winlean.h
index 2ee4aaff4..4a6a46355 100644
--- a/winsup/cygwin/winlean.h
+++ b/winsup/cygwin/winlean.h
@@ -99,47 +99,9 @@ details. */
 extern "C" {
 #endif
 
-/* Define extended memory API here as long as not available from mingw-w64. */
-
-typedef struct _MEM_ADDRESS_REQUIREMENTS
-{
-  PVOID LowestStartingAddress;
-  PVOID HighestEndingAddress;
-  SIZE_T Alignment;
-} MEM_ADDRESS_REQUIREMENTS, *PMEM_ADDRESS_REQUIREMENTS;
-
-typedef enum MEM_EXTENDED_PARAMETER_TYPE
-{
-  MemExtendedParameterInvalidType = 0,
-  MemExtendedParameterAddressRequirements,
-  MemExtendedParameterNumaNode,
-  MemExtendedParameterPartitionHandle,
-  MemExtendedParameterUserPhysicalHandle,
-  MemExtendedParameterAttributeFlags,
-  MemExtendedParameterMax
-} MEM_EXTENDED_PARAMETER_TYPE, *PMEM_EXTENDED_PARAMETER_TYPE;
-
-#define MEM_EXTENDED_PARAMETER_TYPE_BITS 8
-
-typedef struct DECLSPEC_ALIGN(8) MEM_EXTENDED_PARAMETER
-{
-  struct
-  {
-      DWORD64 Type : MEM_EXTENDED_PARAMETER_TYPE_BITS;
-      DWORD64 Reserved : 64 - MEM_EXTENDED_PARAMETER_TYPE_BITS;
-  };
-  union
-  {
-      DWORD64 ULong64;
-      PVOID Pointer;
-      SIZE_T Size;
-      HANDLE Handle;
-      DWORD ULong;
-  };
-} MEM_EXTENDED_PARAMETER, *PMEM_EXTENDED_PARAMETER;
-
-PVOID VirtualAlloc2 (HANDLE, PVOID, SIZE_T, ULONG, ULONG,
-		     PMEM_EXTENDED_PARAMETER, ULONG);
+
+PVOID WINAPI VirtualAlloc2 (HANDLE, PVOID, SIZE_T, ULONG, ULONG,
+			    PMEM_EXTENDED_PARAMETER, ULONG);
 
 #ifdef __cplusplus
 }
diff --git a/winsup/utils/cygpath.cc b/winsup/utils/cygpath.cc
index aa9df3a21..bc5f11dd0 100644
--- a/winsup/utils/cygpath.cc
+++ b/winsup/utils/cygpath.cc
@@ -24,7 +24,6 @@ details. */
 #define _WIN32_WINNT 0x0a00
 #define WINVER 0x0a00
 #define NOCOMATTRIBUTE
-#define PMEM_EXTENDED_PARAMETER PVOID
 #include <windows.h>
 #include <userenv.h>
 #include <shlobj.h>
diff --git a/winsup/utils/ps.cc b/winsup/utils/ps.cc
index f3eb9e847..478ed8efd 100644
--- a/winsup/utils/ps.cc
+++ b/winsup/utils/ps.cc
@@ -6,7 +6,6 @@ This software is a copyrighted work licensed under the terms of the
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
-#define PMEM_EXTENDED_PARAMETER PVOID
 #include <errno.h>
 #include <stdio.h>
 #include <locale.h>
-- 
2.28.0


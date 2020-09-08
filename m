Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2128.outbound.protection.outlook.com [40.107.243.128])
 by sourceware.org (Postfix) with ESMTPS id B4A94385702E
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 16:51:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B4A94385702E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZOm8SFVKbFlQoCfUFEhF0Py9ZdoI0QnvVF+2A0KkOT18zn47kWL7Hs54bRMadyw0ZzMFxJgnr6tDkqREiAZ4h4rga1voTfmtnOqIYdHHLI0crEigOpE2E6yBNMrtMObdaGFQrtKJEkkrU77z/9XkxYexAfoxldVxm2OLQMiHYqyj2CZtBCRuYK4/t/sCcsQT+VivsHNQmE3or0KN+ZuQkynwx0j+o4ksJMTnwOr7ZWwB5nC99szmXTkS6BZmQrC9DGO8NVVv1azgHenduutD69Pztie5SFe4rxVMVsp6LTz11GpMhAQTLU+EFkBtkPeieOFIIW73Vj/dvYqclg6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMC1iTsq+9TJJxy7nGcOPuPTuoBhKEhc0fuzHDUdqj8=;
 b=Vpef5gLCycn4Kv9Ovgnrm+tgfy70AcsUGxLpkz9DZ7S90m5UwVTjiBQyav7AzbJ5ajv8/LyTIJD4yioeWsflRKQg3u13AReZSYx1nDV7I7NEiJCtX1OQ2YDmSGPd6DrZAiavULzHJpnH8ZejXsbgf8uIutoxFrN/nZ4BZuSsaP6fGjbsfZzGhnkXlV88ew8mm73AqjarM+YQbR4nM61NAzel2RnrHy5br2mpWyvafnp7PFDsn7XMqc9KjWGxTnfkbkaoYigTLSYq9aGldGcF11H7gzjDm7Ce51oihCzO436GBRMPzc9mB2qv56BmyTYxOwHhrWxpZV3SVe2l9hx0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5744.namprd04.prod.outlook.com (2603:10b6:208:3a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 16:51:06 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.017; Tue, 8 Sep 2020
 16:51:06 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: path_conv::check: handle error from
 fhandler_process::exists
Date: Tue,  8 Sep 2020 12:50:48 -0400
Message-Id: <20200908165048.47566-3-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908165048.47566-1-kbrown@cornell.edu>
References: <20200908165048.47566-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:207:3d::39) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:fc34:902a:527a:1c90)
 by BL0PR02CA0062.namprd02.prod.outlook.com (2603:10b6:207:3d::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Tue, 8 Sep 2020 16:51:06 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:fc34:902a:527a:1c90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dec4fd8e-50fa-4ffb-741a-08d85417613c
X-MS-TrafficTypeDiagnostic: MN2PR04MB5744:
X-Microsoft-Antispam-PRVS: <MN2PR04MB574461C3233233E9832B718AD8290@MN2PR04MB5744.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mjz/dQjOsT1J1zeQsiJYcRAQMqoGA6sp3FMzfqC55Ev9x+N42UpFi5ET+TOJ90gsyH9P8FguxOE+i3feKxIdHWSrpgSPgpjold9+50FbDcffoNdpN++4sPxFKtB+1+rzcS28nkHBVgq0q2FQ/Q0cb51itg2ZxYPq9mmjDdrYcwz0zIFDS1ysBE5TD4Ennn7a2Fc4nCjex2jLJWIf7OkBf2gaC1fbW139A6WYEbk4nV3FtpD3M0F7qfGHraV0OJo44qZOte447hwPxaOd1HJoHi6Tptc5UtAJykwK+D8ahL45C7/ADB7emLYhE7kw1kXRlJGL4ZLykVzYBJBnbRH9E0LHV8Bkoz6APuczbTYpTyVAJNwXJ5q1briXzwCBHzhq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(66946007)(66476007)(52116002)(6486002)(5660300002)(6666004)(69590400008)(1076003)(316002)(786003)(6506007)(6512007)(83380400001)(8676002)(186003)(2906002)(4744005)(2616005)(66556008)(478600001)(75432002)(86362001)(6916009)(36756003)(8936002)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: B5jQ7vRUOvrIBM93EizSAvcsqVvbJ7yRybMGlCDdwx7YMOQ8Iuc+qOgU8E4rR1WwcwVtwOTkuZB5hH3R3T4KPC9bx9pvetjkNmQl5msyCud7CY7CG+3yl6KsrnPQC3FhQjWrQJ9OW3nmNmjN8tYrt9fMw0j2V9bVxgl5IcXk81S7hqfepRXuvdwhptJhxLlvc5FF7wdtVtX/l+e9UYA0/yB7cCCBxV/AP0jTW7TCxDwZMLQvYIrKAXnrjs8HHovlbeygexXR/7mzu1HU/ABeLgibS+Ix4c4q9BwUrDi8UY5kI1I+/03fxNHK4dcVB234+dQAcHRnVhBXhUlIcFvSCKTmV8R10wQm8Xannjv0YgVgHYSNqls6c9SpalK9pFu0ZZqKulkadbcosGszPAgeKPoP9S+V6HZzmzK15r3I78vVnO9+KKSMy6pQCVk7QSMU4kHR59Xr9eyRwdxc4ClW/ubIxhKHKtj/UfSHQXkQjfOQHFcuimFld3xMqJFN9/vXdt40poc74S61QXeas7W43LYCU5SRtxAKhRi0ntFf4OcZAIKHa/X0ccq2G9I9NcwCPTfxizdgz7EYX/iDLD7jyPS2wSe9O6b8wifyxrsmcIKXjhMDHDGtUjkyj2idL/IXemdR4UGY5tzMQro2oMK9vnWRKBBIjdhOtWRFltgyg5TcgyEjL/QrSepHnVXa7wL8nz6RTKVa1z0iyCflf/vQ7A==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: dec4fd8e-50fa-4ffb-741a-08d85417613c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 16:51:06.7626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOAI/QDGUs5LbjhCHrxA5VCmWNQ8l4znnVxnaWA4FxGWNjMauppb5EXNDHAbVp+rW0JkC08Yzw4+0EuGIj2E1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5744
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 08 Sep 2020 16:51:12 -0000

fhandler_process::exists is called when we are checking a path
starting with "/proc/<pid>/fd".  If it returns virt_none and sets an
errno, there is no need for further checking.  Just set 'error' and
return.
---
 winsup/cygwin/path.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 95faf8ca7..092261939 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -809,6 +809,12 @@ path_conv::check (const char *src, unsigned opt,
 			  delete fh;
 			  goto retry_fs_via_processfd;
 			}
+		      else if (file_type == virt_none && dev == FH_PROCESSFD)
+			{
+			  error = get_errno ();
+			  if (error)
+			    return;
+			}
 		      delete fh;
 		    }
 		  switch (file_type)
-- 
2.28.0


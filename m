Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2095.outbound.protection.outlook.com [40.107.243.95])
 by sourceware.org (Postfix) with ESMTPS id BCE4E3861930
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 19:03:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BCE4E3861930
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqJro41rgXYEH4OD2uhNtnldeUeMyEXsroxIxdctWIOLHU0Kn4OZ6b+1zUoj33E077s2OCwR9L99afunbqux6LPJODr5uTFavclUtqgpyKvP226Om4xDaQEk7/OXNwzOSfimpKeFW3/AuB94X5MN2lfirwZ6ZetygKlv46y/yvjWDGH6by1boKASCXeLjQZHrwSABZgNKfsfZgmRThCifRgGwQNMfxh4aSage0wk3Kh4hIxe7092cS1wF/QV7EAnpnO5VFXxedhcMQfZQmdXXzvGkVi4+Jl7PjoASvtEQA/EZ14m1Cz3wLw43Q7rIb5SwW26uJGgyPw0qP21HjY/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9cRKHFla3NHelcKFJKfZbdVrEV57HDNueH4x4mTDIk=;
 b=XgoDnY4TSyLaAiSt7mdDUu9WfTdbVswV4qRsb6tAsHEi+IPY1ZXFoYtjyLeic3h4XTnvVtpOnZw/gA2j0Vcym7hBsqgtuS8CE4rAcSkDz1X/zbBop+VbWQvtCw+F/Yk1fyYPM/FJODVeBU8wKB2UJZ3jlShBwp5HCafpDYDvphhAj5OT9WCs3Jf12tD/2cqapmfE0rvs43/hJVUkNQNEuIe2nxgOe/gAxKRi+fPGxdYq8JQdEdU7hw01KE0RwVrBfdLgcXGn7gqeTRJoF3v69WbRAKSyU9U3TQvni/K1/+k9WRNrvWrTZ3Z6Iq0zX4zLuw9PHK4gjPW429hGOfEc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 19:03:04 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.017; Tue, 8 Sep 2020
 19:03:04 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/3] Cygwin: path_conv::check: handle error from
 fhandler_process::exists
Date: Tue,  8 Sep 2020 15:02:46 -0400
Message-Id: <20200908190246.48533-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:208:235::10) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:fc34:902a:527a:1c90)
 by MN2PR20CA0041.namprd20.prod.outlook.com (2603:10b6:208:235::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Tue, 8 Sep 2020 19:03:03 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2604:6000:b407:7f00:fc34:902a:527a:1c90]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2818efcf-09dc-4bdc-0650-08d85429d04e
X-MS-TrafficTypeDiagnostic: MN2PR04MB6061:
X-Microsoft-Antispam-PRVS: <MN2PR04MB606154E8879AC932CF1D1DADD8290@MN2PR04MB6061.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w18A+wHdK2dw6tSZwIO0700HFfd4ozYOEMcHehVHyXTSzcSm0fPBmtl71F9b3Db/YBVwF6WIVN6ECtryq0xB92rn5MLnw8XEikRiQo49qMDhSY4rrChlIlKnFpxQH7Hf3J23Z3i7nY+vuctlCeNWvbC0r6pDF5HHsHM5bOJZj/5Wzaw4aC5kg31HwA5qiT4Orj6WhHwye6iKBAB8PyZLMw4+kHF/18BRagxZk4kWs4v92L4iM4nASrKnDgzLJlgrxD7NaXMm82I2ZqYEe1uVkYXvTXzoH239Y2I3/2wp2eModsmJoy5LHDLwrhWSUwQ8OT5skMcCEzbK+X73bXxfS+ECjhQkivGcIHBaeIIh5LxSyCePjZvs5yWdo2cQeI8X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(16526019)(186003)(8676002)(86362001)(2616005)(8936002)(36756003)(5660300002)(1076003)(6916009)(66556008)(316002)(6506007)(786003)(6486002)(6512007)(4744005)(52116002)(478600001)(66946007)(69590400008)(66476007)(2906002)(83380400001)(6666004)(75432002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: JpUaIdwVVAHTz9AQ4RS7XvbwPpQjFT/I1+k7sfLJhgyzwsuA2I1rqKL6idmjXremBLJmHC72sROqUVm2roDQOm8aTLgq9Zm+k3ZqRGUTOca+CH3qAWDa4/AG8ItZTiQvKaO3u2GOFLMA40aZV1dcMEGEcDZWYE2+sIchqnR3OYLrIylrZdwqVhgg+Y5Y5DLQXBdJABWV2MkZfNt/Tgdnb76ExF3Kmc+dP3LpPvvABHI9grd62TQftM9IyikfzINBQjbKhdFz9WuoyJPppqnMFIkA7YG196MX3qLMTMAkn0H8hrrUSo9oBJ/Z17z7MbKFqIl/O1L3jPDab0b6DTXHdi8UeD5KHZlty0YXSAwNAbQqCoX7bUQo7fUaMPdkH+A+nbd8nPZ3XEwfNgkyPl2oGkZSZFlSv+RA//K2ySsXn1wSufeVhvfK10tL2SmDDVSoNId/GJythIUbIcjWtfstVlnQxcP0JggO0Y/bI/a+2x3gEhbKp6ya1E5s4BTKxqzWcJ/QyzlJANS+pdhk/8z0zKmo+VchIHHkgkKR9jj1qqwPcI68RO3vckdOrDDaabRcPz27DdfJJSiOIdgdOMHmilppKvCGiL/+pe3y31DoSe92ACQpJGNNHyLff/hhlIJZe8X+naX2embR77M17cO5jLC3eioZEhHAO9X3mHfyAG33e9KJc6h/+KYzeN/6mce6o1G8WK6iYLOBXWJVw2rLyA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2818efcf-09dc-4bdc-0650-08d85429d04e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 19:03:04.0680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlzFpSBq5YFAKbbc+Ndj9fl31PN7Lye8BJO7CugZK8k5l0QbVZhedxLKMuysz4/QV0w1eAicHKDfVPKtIpKd8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6061
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 08 Sep 2020 19:03:08 -0000

fhandler_process::exists is called when we are checking a path
starting with "/proc/<pid>/fd".  If it returns virt_none and sets an
errno, there is no need for further checking.  Just set 'error' and
return.
---
 winsup/cygwin/path.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 95faf8ca7..1d0c38a20 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -809,6 +809,15 @@ path_conv::check (const char *src, unsigned opt,
 			  delete fh;
 			  goto retry_fs_via_processfd;
 			}
+		      else if (file_type == virt_none && dev == FH_PROCESSFD)
+			{
+			  error = get_errno ();
+			  if (error)
+			    {
+			      delete fh;
+			      return;
+			    }
+			}
 		      delete fh;
 		    }
 		  switch (file_type)
-- 
2.28.0


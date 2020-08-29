Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
 by sourceware.org (Postfix) with ESMTPS id B7A553861001
 for <cygwin-patches@cygwin.com>; Sat, 29 Aug 2020 10:02:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B7A553861001
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a49u5+jgUAvndcwg+wehansKViVSU4FoIWlUYzrPA1cmUJJYci90FqDyUwAmWRQQ8A8LfH7ZM22bfbJwKGFN49Cbix9hQu+aT5XGe8H6OZtpNjeqhJI48dUQQsQV0g+acXz+QdLse3R1QS9+6qmUGCvuMo9lEG9FywvmVHFqfVFrkQSVRIURGhSMMPcwLaYOXFjBVJm/H7eca0LgwkTNnnhqVoI+PmXyUJ1gPkzBnyOCflbHyHAIor1Z/eLK3lCzLwgx4LBIL1DIRSPMMJs6cZiqVhJuZo4x5kb4RkREnNX7w/Vg/RoucTarUor/u+RARtmnKYs6RJjAD17TvE02Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFPGwkU8YRYM233OIiC1HsJNXhV+dzrlDQv3L8v1G6k=;
 b=Q9GH3CYXpPdDGSRt2LtmvAMwZmuHcEJj+NYGhEBHFrple1RRg8vQ/DlT+kp4o1sDxDS9p1VS3oEugJBAgbLFP5IkA7M7qadO316zGXS9EMsc+W8WAsT5os/dkDQMPE/ILrG8/j1FHWOr7gQHCrC966V5NfodpiGe2y693udeKcNiVP9Mo8EFkn5sGNLpm9iVkahr0SwLEVALQZzAGxDaWkVfMKgnt1cyahc2LCo98qAxmplPWWHr6FlLBLUQOBTuKqe9BKpRUID3FaI+znA+e4tanhp9N+SZjjE9Jx9/L08n1shrfZCVUkHhhAecSHE/auKN6mYKtz6eqLFNNX1Vhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5872.namprd04.prod.outlook.com (2603:10b6:208:a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Sat, 29 Aug
 2020 10:02:13 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3305.032; Sat, 29 Aug 2020
 10:02:12 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: sigproc.cc: add comment
Date: Sat, 29 Aug 2020 06:01:57 -0400
Message-Id: <20200829100157.27707-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:208:134::45) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:208:134::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Sat, 29 Aug 2020 10:02:12 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad8995fd-674c-4c92-de6e-08d84c0299ad
X-MS-TrafficTypeDiagnostic: MN2PR04MB5872:
X-Microsoft-Antispam-PRVS: <MN2PR04MB587233E075C0414B363ED6C1D8530@MN2PR04MB5872.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JeIppI8gY6lvTjLileKwQQiwxBp/+GXzB9BCWZH8ySCBMHMT0Xjjolqnh5oujOJC/oq5cgCINC562swoA+Pvq/9leOgsAzJ68PTbbkA+dpP/6VUPWm/Hyy/KvJLz1HoUAPgIV+Ip4RzXnCUF+E59NnxrpaZayRs0Ookln3b0JhlAmpt/ff1HlhJVhWhdLc3HErNbYirgACxNgDS5aApxbm5J6xl5qjLeibCxhoFB3MwUwVFLizx3vgVblKfOH/LJjv4ME3VVDApRgSN4XwZ1ZjppuP4GQwPOGDRdfZCqN1z8ecsmIrq+8x9PDCtfjP0QfOC3LnAb7/muWpotNa6o3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(16576012)(6666004)(6916009)(478600001)(66556008)(75432002)(66946007)(66476007)(36756003)(52116002)(5660300002)(316002)(2906002)(186003)(1076003)(786003)(2616005)(8676002)(86362001)(956004)(8936002)(4744005)(6486002)(26005)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: h8x0XGamNFYjvDoF9t+hwPazjCbCWm7gZbnGRb3fsDo5nY3p/Wlnik2k8yVKDNnm8FuslU09NhOZ/8CbVET5mk0gvZt3n4F3aNC3/b0+zRLU/HeWlNmXOar5jGoEYBWSNglO9U06du2WKOD3rWxWSSX+evdvmJFJwr7GNHtDHI/o5MD98/tEaf+h9VoGeB1aLlHY5ryL5Jx0xrvBiy9AJdlF8P6+S4YH36FF2jw4MDIvfuhmHmVwi7Y7IbDIdK47xTDJuuyeKjuxcRzvRfVTZZB3QHK5uwuMT6htRdlade8EssqDYDBeOx/IGEg18E6zO4zEettggUfrpLklpxUzX1q34MKwAI3+wfo3gX0+YQ+96i3Q42/zttKYGrb2NxTBe44KNb9dIBwOAkbi4XlD9oM11mIOxIglMVvuxkRdV6IvWjhQ4mkHUcWz55B/+guV9iwm2rPuDbdpsInVihGAs8dUEBi5Yeiqio0LXIIVHsqoxwATStjcTYi2DZNTpzr2zJpxyh6qZMSrbalUxM5ggvcKKTnBNUn3lDhariiElsCFnz6AQz9soVYQkhMFaf/CsbCZq7ltThWqpBapI8RfnKyRrEsIdgo0GFgFMyqy7/GWDQt1HC2nqzZBIYl6dAoyh3NzL+0DfoqW1hwmtWtLNg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8995fd-674c-4c92-de6e-08d84c0299ad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2020 10:02:12.6778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJU4EKCtrUvsZiewTI7mQaUofs1KQ42KL+iNjiW2Wi28DBcaLbXsDo6G+Azi7+7Lmje1iimi8D50iZfe2yLugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5872
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 RCVD_ILLEGAL_IP, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
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
X-List-Received-Date: Sat, 29 Aug 2020 10:02:16 -0000

---
 winsup/cygwin/sigproc.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 2a9734f00..47352c213 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -44,7 +44,11 @@ char NO_COPY myself_nowait_dummy[1] = {'0'};
 
 #define Static static NO_COPY
 
-/* All my children info.  Avoid expensive constructor ops at DLL startup */
+/* All my children info.  Avoid expensive constructor ops at DLL
+   startup.
+
+   This class can allocate memory.  But there's no need to free it
+   because only one instance of the class is created per process. */
 class child_procs {
 #ifdef __i386__
     static const int _NPROCS = 256;
-- 
2.28.0


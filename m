Return-Path: <kbrown@cornell.edu>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690132.outbound.protection.outlook.com [40.107.69.132])
 by sourceware.org (Postfix) with ESMTPS id 0EF6D3857C55
 for <cygwin-patches@cygwin.com>; Sun, 23 Aug 2020 22:51:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0EF6D3857C55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJr5zzy67/wvy9VAM7k51o+Ui9MVrIsrvByu8nttStfrJJbofO2ejVqnt6nAom3uyHSikE69PO5j9wetfZoa+/Nxpn3m+AUykMPV1jZE2V64/VGyY0XnLQj5J/dmZ28ObN5Q9tF1N88Axi+u9sIbhY5s278KUKNZB3iYqrYRy0xlIHPBsMXEjki6K/6rEA84P6CyTa206kIeLDFGm7ycwPTb1/fMxJjlnuyFK87h/5wTNW4q5Fb3tfS7daoxmqFJJzZKt5vDGWUoNi+2Hc32T+0gO8aqAJ8sPRvkuJf7SQh91a+m33GOjaJ1f3y9KWJXameZnuYCrq2uqRGP4WTguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTE/AbpCDUup3apc7Fvfmxv3yVogFf2CcXddPxD7In8=;
 b=HqXCKQFLQf7wVrca0wQfXB8GVp2Dn4DQ7qPumkH306DJRNcss4yEjDTXi7j06lUtYOSbdw47we6w3QNcMvr01o/z0TPapUrpDDANZ/VuDtYCZ+n6Kft1b8eQlbSdA/7Xnat7RjTi+cpM+R3C7SLZhKIRQTnyX73jB1DvL/pEu4AvW5scD2WVzozNMl6UfbYVf4EO0bybTmSqB2IecUwN+qcCiZL7eMDvnS9BIFpazREiE5XRIGX1HJFkdpzfd1CpYEPvW83IEDm0gtgEssYxjZIewObJlDNh0PCDWXB40hsrNrVBpyRo9hL6pqkDBiM1AjBAaAMRor4zSahIfjZmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5582.namprd04.prod.outlook.com (2603:10b6:208:e2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Sun, 23 Aug
 2020 22:51:19 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3305.026; Sun, 23 Aug 2020
 22:51:19 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: cwdstuff::get: clean up debug_printf output
Date: Sun, 23 Aug 2020 18:51:03 -0400
Message-Id: <20200823225103.22835-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:91::13) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BL0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:91::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Sun, 23 Aug 2020 22:51:18 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e389f107-215d-4237-159d-08d847b70c76
X-MS-TrafficTypeDiagnostic: MN2PR04MB5582:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5582BFEB9F0D04E7328C3638D8590@MN2PR04MB5582.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6+lv/bnC0CP2ssIlllM45xXPFdh61WeO31uK2elaHsZpwUfc8L5j14kDge/thM8nBlfrkCu1erLHOiaHxjUMgpE2qZpsKR155todn/IP3qAETCiDaeIO/m728/Ig/WHtXdHK0KnywMaYePByVHGVnbJ/JVWc/LeK6/PyLwrd1aAuB0z6nLoNBT1Bz4W/+Bc+QH156Pf//GvRLUDOKGBhFCwRuxAEgssHIA6BeTYJOJghK2SNlqudaI5jyopAU8IBFClVu2+Kb4moMaakLjylLnuT03X02UpP9bObSvZ6yf60ONtVA0rJaEhwTkVGGsQmmJijr1JurJMGa2Az1Wv9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(1076003)(6666004)(86362001)(66476007)(956004)(2616005)(75432002)(8936002)(4744005)(5660300002)(6486002)(52116002)(2906002)(36756003)(26005)(66946007)(66556008)(186003)(786003)(8676002)(6916009)(478600001)(16576012)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /CjRM4X5H2o83tRBszv3Pu67gm3SFkUQOUrBl2/x/VE5Tynla+VCMSOhgdfE0KOSyeQOX5M9HegAeFlba0xa6RvUu5KLVirlx1KyUO+9XAeCfBK93UJaVP0JuORp8Soh1HTfCwUUMHoSKz8kNMga0A7Fy915d90bM5kUrvOh9L6gq50s4zXyf0w7Z7si7+8xDcTZKcEoD+sLRiI9EZL6rvhJ/ec06ukhXgB9NhxbZwAU4GgkhAxhTrEITMBq7HrukJdBS/6v1dZ6+oKZpi7CM4Y40Gkd037V+J7Xtt+YsHs0gjcGUwHkrRrhLR7Gr/voZwL1BioNCi+uO9+fj6cuYXrUeyasXbMGLwu+MUWHAj4FMzyUUuhZfYNlckRIIYIV90RTX2hyh5Tmsj7ZiGi9gScg8SmN4q0jnT873CaGpldsy7w01hu0Wfo2ckYR97Y+tAidekU1RaEx6bKoOjr0R6FGHKjILgaZcYMNtCIR1nRzDaDbzVWUzVDt4bd7YsmfyET+2ZQsfsgEf68JwtisiFE1IURPu/c8Q/AQH9/dRHjk5a5H4vKtq9HDt4B84lPjCBQCg8JOzANEDw5wcs8V6QblgsU+ssqBZLDUyA58o6NS0B62qiwOk8kRnbk/fxi+VomhYXMyG7HTbYZbaO4Z/g==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e389f107-215d-4237-159d-08d847b70c76
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 22:51:18.9406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SOn9ExEx7aTRU9rXhhKAmQxdd0nQSW/L2sV9CHsEZPJE7ojdlMudGL5rQZGdBFdZLGBeUS8A4DCxXFV2PDoVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5582
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 23 Aug 2020 22:51:22 -0000

Set errno = 0 at the beginning so that the debug_printf call at the
end doesn't report a nonzero errno left over from some other function
call.
---
 winsup/cygwin/path.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index f3b9913bd..95faf8ca7 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -5022,6 +5022,8 @@ char *
 cwdstuff::get (char *buf, int need_posix, int with_chroot, unsigned ulen)
 {
   tmp_pathbuf tp;
+
+  errno = 0;
   if (ulen)
     /* nothing */;
   else if (buf == NULL)
-- 
2.28.0


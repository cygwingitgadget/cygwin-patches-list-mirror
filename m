Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2131.outbound.protection.outlook.com [40.107.94.131])
 by sourceware.org (Postfix) with ESMTPS id 78A6D395182E
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 14:10:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 78A6D395182E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfmcsyRPZBr5xteQzwKmgmY1ME7opP0uzoJ0n/jI+RN3U6rTTm8z37jr0SGWKEkNBA7A7F8wqSlqDZ4n+PSxCd91vWyq2bgsFukqkKD1uBTDSbNVR3LGF7qmMvtXtyvebYJX1wTQmGkyu/0ZdYBXSa4K/RLPjY9nuDfjHl74t2GSjQOBAq8/wBR//Fz1m70emAJdVXnAkK5XrhgERNrTqU0JYOKQzogtxw03W+vianZv1GteeZVOH7JduudWzVoKTqJdWDpFTgZX2M+YUHrTFr8JFLgFJave/ekDuin3CdcTb8vTwMNoGuYiboZOMp0lW8veSzqn+Z7MWwO+7XzszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU1slYyOw7h8fAIomI6RavLjglIa3B7D4UtkyJU/XQQ=;
 b=U+Uf98FgCLLAyKIfUFcJa+d0bYT8nMFYbrQvWfJ4rZ0giv0reLWj/7+GQFZMWNXT7uaXL18eNiDqu++qFnpokYpIrMMfQyUB1HqGKOhOxKxH+QIci9r2ndWMezhr21r6d6CDnXmHmpwCPBsUc/Oxfo+z7Kb9trlfnJeb20TBZgrWqQFT1/0K+8KKm7bt+XQMERaFqy37sLE2teb0PkC6FICPqSfsZQxUxpWVo591ETU8luFU4fzBKyULYeMdhvK8B5QW7zsLZ2QvLoFTgixclfFaO0urHrbBBI6XnsfrNzHWTETZWNSuuRH6WLZUNGUCp9fIjl3o3uVTxSs3YOH/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5936.namprd04.prod.outlook.com (2603:10b6:208:3f::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 14:10:55 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 14:10:55 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fix return value of sqrtl on negative infinity
Date: Tue, 27 Oct 2020 10:10:37 -0400
Message-Id: <20201027141037.38881-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: BL0PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:207:3c::33) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (68.175.129.7) by
 BL0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:207:3c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 14:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f4784c6-35e0-47d0-a8ef-08d87a821ec7
X-MS-TrafficTypeDiagnostic: MN2PR04MB5936:
X-Microsoft-Antispam-PRVS: <MN2PR04MB59364509C23A04663475431AD8160@MN2PR04MB5936.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8F5rfivke/1K3fXVpGcAZt/QvCmMQ3Op9wvyGj9Z1HKRWRw4I5qcm8xhGMebCSlLFST8013+bWPZLSjtq95nZ0ggf/9Ayx5iWCd+Sq4DXBAHyuiHUpGGE4ewtXf7Bn/QbXCEM3CWb/Rk1d4PfHjH7jTUFDkuZOYfvKeInDReeUa6ZfVgaCJGHBZ6OIuBrikWkVdZxzy1qWzBPWJYVkuFbx+wwhZf0IvlsPSogErWdUPLvbVjLtaWvpbScg1+Bg219Rx8gx76AkiZJZf5YKddqzeEBzHeK9dmvf6lWbfrs/jJOAHVbxzKStx4mn5pbyAbdIUHw3n+OYOmZ+i45kh5TiPAFjkmdH2iMynKFGEN7tEr7MqYNUuZHPKTVeifHXtu8UicsWCxxloUTToLHol9Z9vA3BzMqL/NoDjRI2qPJDfpSVs9IMZevq+T87uwAuBfQmi7itIGFjkk+JACf5kl7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(5660300002)(1076003)(66556008)(8936002)(4744005)(66946007)(66476007)(6666004)(6512007)(6506007)(6916009)(2616005)(786003)(52116002)(83380400001)(956004)(69590400008)(966005)(36756003)(316002)(478600001)(26005)(186003)(75432002)(2906002)(8676002)(16526019)(6486002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: saNB96Zkv9x0ozKymYyd3HKZVtwLwMEzEUSkE89bqO09cpPK40PQXpjJRbqr8jJPp3dO9MeEGOgB16gQvEIvDRJmlkIBEl9pVCwDptFCIrKu3WLJB5RWr6M+OuHQLYAV10a19ajpW6+uvt8tX7UXhSuPeWHr/NR+7wHYit6UYfrdgLeu5QNNzbxE4Qjutnhu/rrV1j+baJSBiv5i9sfr2vc8faYMRY5lZP+X1t+2TL+eyncGNrngxbh3qCzGNi2Awjj5U/fsuQnO5aaFS6ruAUEGT03r2X9OyJY+7qK7Z3d7DFqLeDOC0GusXT6IE2+Rx1qMDnPmCYM+lKDwR3dwD0H+5c7D5Nyy56dvRCt/1etH4nGTl1+UTAHSCCIlWYZvDrNd6t+YScygXfOJxDsHdz6yrOKA+WlspfpzPuAcSM/7ObjNXaD7xmJUb5Hg52pjFeyBxmlZXaPDJAjJ/TbUURviA2Ldr2gQpVvjAhNfjbP12lBETQtekppYGFnivYmDdXuSP4ouk71iqnkDXlieewI4ZRvcuGb1gyxlsUE0kcAGc/kcAspiPRZuX5qUxEAtJaVSnwuPwqjiWfPDtQ6+uAm55N7ZluP5nJHOyrVhT+Gp/jV27dBcYDrMCIUzwyxPKbsSX9abdibjkhlwolpDeA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4784c6-35e0-47d0-a8ef-08d87a821ec7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 14:10:55.5622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngmRwSXUJ+Su3ANkpl7lKiXWuwchkP3QkJ+OBfQV/qBx3ckTJ+2TMtbNqpomNygDAjzLH2wYst+f0E5IjIcIWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5936
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
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
X-List-Received-Date: Tue, 27 Oct 2020 14:10:58 -0000

The return value is now -NaN.

This fixes a bug in the mingw-w64 code that was imported into Cygwin.
The fix is consistent with Posix and Linux.  It is also consistent
with the current mingw-w64 code, with one exception: The mingw-w64
code sets errno to EDOM if the input is -NaN, but this appears to
differ from Posix and Linux.

Addresses: https://cygwin.com/pipermail/cygwin/2020-October/246606.html
---
 winsup/cygwin/math/sqrt.def.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/math/sqrt.def.h b/winsup/cygwin/math/sqrt.def.h
index cf8b5cbe6..3d1a00908 100644
--- a/winsup/cygwin/math/sqrt.def.h
+++ b/winsup/cygwin/math/sqrt.def.h
@@ -73,8 +73,11 @@ __FLT_ABI (sqrt) (__FLT_TYPE x)
       if (x_class == FP_ZERO)
 	return __FLT_CST (-0.0);
 
+      if (x_class == FP_NAN)
+	return x;
+
       errno = EDOM;
-      return x;
+      return -__FLT_NAN;
     }
   else if (x_class == FP_ZERO)
     return __FLT_CST (0.0);
-- 
2.28.0


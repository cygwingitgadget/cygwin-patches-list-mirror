Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
 by sourceware.org (Postfix) with ESMTPS id 16C5D3857C7F
 for <cygwin-patches@cygwin.com>; Sun,  4 Oct 2020 16:50:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 16C5D3857C7F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8r1ZUpQBB0X9TV9TyuhgC2x/R2by2GryoGOGaG0An2uH1C5n7lQzBcH5Ung2ZYwEdxUubBM5ZJq9fanY78ecFHbJwy01NL4LboHJvW7/W6RTpC/nVrD2m+WXQprST4lWtO2FLoduulkzJcaYztacmYFuR5iscrDhwFfQ088eJRtI+0r8gSbKd1kE4xgyMTWmSHyiiaZGyq0znckg2ccDSJYB+pK5Wmn9eHdZy0SADFqitvngdUAJJSEIuuLd6sgWpRLBQOXPLhm4R0LVmbWy3R8nfNuwnaTlHHuYG+rmth/aJTF9YW43rgSuL0AVY6C3H+y2WL+jNMHsZHJmSQFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If/HRExOv3tfeR6MHgiQIYmEK1lYtec7qIy3whZSQw8=;
 b=nDWm0/+HBPH5mZUBvKE/XM3tBKldvcAnAmGAj8cKJfEANTTf9m07f4qnCzLrIsuamE8NElNya4+bHpWhTrHZlRCNwGrmQfeVI9tspGm8fi0FiiixiEXorQh9AjHXrnN9TSe9aMD1qESSkeK87fBTD1Xl63OLCgM1scgPCfQ2zTQE0QXe5FPM3/cH7s/m20ynFUxCIdbA6z/kUDrcfMF2brDvoFuJT7vPzUrmW8siDBbxQ5FTPfRTLZQxTrVLKP/iCk/EHhF0/A8mVKrj1GpCOQiDzDc8oON3DY/p+0yPwbvswxVqklSA7Du02OlMGOT1T2wYRTKwI9gnRfQt7NntNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 16:50:07 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 16:50:07 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/6] Cygwin: fix handling of known reparse points that are
 not symlinks
Date: Sun,  4 Oct 2020 12:49:44 -0400
Message-Id: <20201004164948.48649-3-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004164948.48649-1-kbrown@cornell.edu>
References: <20201004164948.48649-1-kbrown@cornell.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2604:6000:b407:7f00:48c7:bebb:3651:4c42]
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:48c7:bebb:3651:4c42)
 by MN2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:23a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend
 Transport; Sun, 4 Oct 2020 16:50:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dcb8056-0b71-422f-eb15-08d868858ce5
X-MS-TrafficTypeDiagnostic: MN2PR04MB6176:
X-Microsoft-Antispam-PRVS: <MN2PR04MB617661C78E29F50F0389C1F2D80F0@MN2PR04MB6176.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7aBkqZdXuvEJ5Aq/2ZFVkKaXuu8gKPBhn027LjKz15Wb4j4ppumLNp2pOTQtFc/wWq+Q/IB/C6sLZax2huRPfrQXd5AZU2AdW4166fiL35x76awz/+tChtZvrPALkVvD/aIOyIAcQ89Aex2q7WY72RS1epRaBCxHWzvtp9nNkRuwHZHyXORv6Cqq7X3o65/GfMLoWuivri2hJUfrEUqoUKWp5Lt31G+D3IL4cLjmQ/CaIKPrViqNxbQASvxahVo9Qpcmm8Wh2L5k5ldFZJ2pMxQtRgcxeRkBUrA+44bFuN0w2omgBr6km2MYMs2hYv3TFEZ1sg1LjBCL5BGxycbXM/73ROALEJRWCCIvx35lEesoSwQ0QIZ1gjgpuB/g68V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(2616005)(186003)(16526019)(5660300002)(75432002)(52116002)(66476007)(66556008)(66946007)(316002)(786003)(8676002)(36756003)(6512007)(6506007)(478600001)(8936002)(1076003)(69590400008)(6486002)(83380400001)(6916009)(2906002)(86362001)(6666004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6EniQZjEgDa1UCbQFHgZ9wMhpP3iRBtwDgOGzItDxe0HZcs97fpE/IZOI74Gp56i52p4XAOwFvEXTmAneTo90AxcWZjBKzwDyr65V+OlufsxRK43WyMZ0oX0/MjDL6lfHJxzADuoS2gOOsI7viWuBtH4tPcYLMfjN3TgMsJEZVAGujpNSfwUpUNCuBW2bYkgmLG3trQrKJTTxtB53mHktnxSuTPXK4No5jktCwYoeZDZl4II6HnYl+NjgJI1KZQznDT2Op+P3YM7oQe805Q3CtaMQV0gvJg/UNWODa2GGDAeeXtHEdpSbcnhK5/7lWDDJ0HCeZW6/YgsX9w96I5qbtBq6rUbtVXZrfyOi3Wnl3Ce0Dqd8nLLX/s0MyMYlrv+OkQX8M/v77iNRR57RekJXBJv2OEhzhRGaKdo8SlzOEmsJRKvgZeSbyz5y7pZfmQS6a8qiPxMr9RhwNfXczM7y+z0qSl2CWbsFoc69SFcozHmgvktyvkTNr2thUaymftAMlSH5vAoFqq0h/mK93JNcMacHA0LirWnZAWQ+YhWl8AATgnjicl17hRluhCbmGqUEp4x1Lr89uMdXh0PDheKD0NylDbAbf3meIW1lJs4ZzLe/CnapT8GAOWQ33L9w9/uebAfCuwOJ4IR4Qi4EBSTomgwjGrKXbSL1u2wAMh0wgEYmy96JivGthDBz6aO+9ylfVmvjk+meuaP/RKraYj1yg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcb8056-0b71-422f-eb15-08d868858ce5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 16:50:07.8351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7+26T/x3AeBvoZaEAPEC/BLbU6vgcfv7fV+iGwcvSRJDf5dPgkBG38116JnXRcl9AwQo3DlmcxFXRaS1Sl3HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6176
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 04 Oct 2020 16:50:12 -0000

Commit aa467e6e, "Cygwin: add AF_UNIX reparse points to path
handling", changed check_reparse_point_target so that it could return
a positive value on a known reparse point that is not a symlink.  But
some of the code in check_reparse_point that handles this positive
return value was executed unconditionally, when it should have been
executed only for symlinks.

As a result, posixify could be called on a buffer containing garbage,
and check_reparse_point could erroneously return a positive value on a
non-symlink.  This is now fixed so that posixify is only called if the
reparse point is a symlink, and check_reparse_point returns 0 if the
reparse point is not a symlink.

Also fix symlink_info::check to handle this last case, in which
check_reparse_point returns 0 on a known reparse point.
---
 winsup/cygwin/path.cc | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 638f1adce..2e3208d2d 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2655,11 +2655,15 @@ symlink_info::check_reparse_point (HANDLE h, bool remote)
   /* ret is > 0, so it's a known reparse point, path in symbuf. */
   path_flags |= ret;
   if (ret & PATH_SYMLINK)
-    sys_wcstombs (srcbuf, SYMLINK_MAX + 7, symbuf.Buffer,
-		  symbuf.Length / sizeof (WCHAR));
-  /* A symlink is never a directory. */
-  fileattr &= ~FILE_ATTRIBUTE_DIRECTORY;
-  return posixify (srcbuf);
+    {
+      sys_wcstombs (srcbuf, SYMLINK_MAX + 7, symbuf.Buffer,
+		    symbuf.Length / sizeof (WCHAR));
+      /* A symlink is never a directory. */
+      fileattr &= ~FILE_ATTRIBUTE_DIRECTORY;
+      return posixify (srcbuf);
+    }
+  else
+    return 0;
 }
 
 int
@@ -3274,6 +3278,9 @@ restart:
 		&= ~FILE_ATTRIBUTE_DIRECTORY;
 	      break;
 	    }
+	  else if (res == 0 && (path_flags & PATH_REP))
+	    /* Known reparse point but not a symlink. */
+	    goto file_not_symlink;
 	  else
 	    {
 	      /* Volume moint point or unrecognized reparse point type.
-- 
2.28.0


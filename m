Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2132.outbound.protection.outlook.com [40.107.92.132])
 by sourceware.org (Postfix) with ESMTPS id D30C83949094
 for <cygwin-patches@cygwin.com>; Wed, 26 May 2021 18:56:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D30C83949094
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=kbrown@cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHSF28RAIKgU5lzdB/UF3FSMLay0HX/erzUv7PU8mDvCMdHJM101s31CRel+N8kjrpNnh91ResTZO0nOUjjcGkONcPyJcXRD507VHQLifNnVZqwlA/Cc9+Jkb8vi+q+0XOZBs0YjFa05TilvjAa1hOQcPZaq8/NaglTYRPuo+lu08u1HCa/XknuMEKin260AD/NdrR6bRhdWoBcpojHLBMyRWU9NrawEhpvecKPixmWNNzanrxMq6WSH8udetTx+ub9reu3pjzv9kIqt3QbSblAGFeCB6XaVolozzrmjxC3Fx6GqTroJezfKAFpi6Cntp5JmctLwy9+O+GbetEVF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnOCpZB02Yfgoz0Acy2GlQnOOKroHSVVCeZRUkUuInc=;
 b=jk+WecYmtdEyZ50slV+APgN1qgnaw0c1B527i95Fhfbd8ukugfZeDhbqDy2roEZf4GdIHh4hYcndJB0/Q/xAx+1G623TWXdwNjxRUEmdsdK/1sSJfL2Q8p9BLkk8Mn0LYvsTBi+DjMpFolHFtCW26KLpfZ22ZU6cHjKf/VajDgERW9ipyp9RrmnKoOPQ9FEqPvNddyXtrwLXy7J8S5ReMBWFb3QZWWBGCSyEMjqE5EJV6NqCd2pO52zxmmL4Bh55zHvzueAMtWliV+sL5V6En3zrmqK3gIb3wRD0+TBrJI96e+GQY+4fRz1bvI1rUgwMJ2p/cYYGVpr6B7Wy0xClzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnOCpZB02Yfgoz0Acy2GlQnOOKroHSVVCeZRUkUuInc=;
 b=cJKdV5cJh+ccPnK9+mYzdFOK6fgmlgzvM4s7gdav0VDCLRWGBTRy+b0j9iBwAsJVBY5HGwAEPVSj3GKj6zc1JKWD6LZou8e00cx4VsusRSlJFgYewIDHA9f96BnvfhIYzxxxY+EaoqnK2aiugxDhfuFqqMXgZTACVg7jVhWUNG8=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN3PR04MB2322.namprd04.prod.outlook.com (2a01:111:e400:7bb9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 18:56:06 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d452:659e:43f2:812b]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d452:659e:43f2:812b%7]) with mapi id 15.20.4129.037; Wed, 26 May 2021
 18:56:05 +0000
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: fhandler_mqueue::mq_open: fix typo
Message-ID: <8dadeb18-2033-fcca-23bd-39a0aee99ecb@cornell.edu>
Date: Wed, 26 May 2021 14:56:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
Content-Type: multipart/mixed; boundary="------------053A35C31F8DEE2415014779"
Content-Language: en-US
X-Originating-IP: [2603:7081:7e41:6a00:6c82:3ad:36ef:9439]
X-ClientProxiedBy: CH2PR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:610:5b::37) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2603:7081:7e41:6a00:6c82:3ad:36ef:9439]
 (2603:7081:7e41:6a00:6c82:3ad:36ef:9439) by
 CH2PR07CA0063.namprd07.prod.outlook.com (2603:10b6:610:5b::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 18:56:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4bdb973-8cf2-49d8-6463-08d92077ea65
X-MS-TrafficTypeDiagnostic: BN3PR04MB2322:
X-Microsoft-Antispam-PRVS: <BN3PR04MB232277C58D4368B7D2FF9415D8249@BN3PR04MB2322.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFrPIb5bKseRfvLxdkQYiY/vukx1Uzp/gVug/wzUSrRfYVpXM757WK3z9SXyub73ANq8ld0DxdSWzJtlJ9uc6f/mGvcq1G7n9lc0udnPJkUkT6xoxM/ndl9OAA7DqOdxWsjS8q6PYkq8PVAjkJ25ZiapGZ7BQLpma2KTHIweTs73Ut5URrGqoVJwvc/Gg+/+8sM1gqnMEn+uu5l5xHl8+1Xvw/NhQvkmGtrWgyQjYwO9rkpnPmjgZiKm+IIY/XptViFYcUElWXo4H+7O59PcTgTcXpR1csV+A2pBBFVp0K6KsSvy2J6TS1g7bT0xQXwIqvCIU9Rlrv8yIwZPS8R7ryb6mQY8crXMgUKkZtk1FHpJwqy3FbrtZ+KcGAd3OoBnFmZgwOKAOQRLAFgZDqUNfsVwMOtiIF1i9MXGNV3NEzi278FszSzpTCmUw85kCpau/VUJCeS09yve0HELFq0N46hJZlCb4jV/DonlzpVoqne8TbFHNg3atOdOiHo3pkaipeT6ip3L3q/jd3qcEKbQGwZY0+hiY4OEFZom/5XLk2pT3ZGWAb15XwdqzeXlW5xK5oCudoxR++n3dyAquDVbDW7maLgODfTyBa3ofYtoQoSBlziorc9rjtTjudgbyRJn4vHfX4gVsprsAWYg3XZrAzCfzo0njJHsAJCjPHhdylOv9LNUkZBJgfFSfc7rrha5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(2906002)(8936002)(5660300002)(36756003)(186003)(31696002)(478600001)(2616005)(86362001)(235185007)(786003)(38100700002)(8676002)(16526019)(6486002)(316002)(31686004)(66946007)(33964004)(75432002)(6916009)(66616009)(66476007)(564344004)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?i8dwJJBwimQ9LmZs7ZYt/N19cibduQJCe21pUWR/lvC/D3HLOy4LGCaC?=
 =?Windows-1252?Q?rluJDbu6Y8vvQ578pIXEEF3FJMCDXnADiktmsuPsMGsJu7uKgB4M1XVZ?=
 =?Windows-1252?Q?QW1Jz0+ZQZQ+fnNFhPOUIPNujT0f896hBgwNPeZntFrfY2xh3XSQAm2v?=
 =?Windows-1252?Q?Tr95kz8AyuMX/LubFG747mugCKxtlgW37nBbHCJa7nDXTEJ/+Akt76Ol?=
 =?Windows-1252?Q?V5cyRh8GdAJE3TZNJkqUDUY9ygvWp52PRmCMzsJo9bonFeD+AqXEvf/F?=
 =?Windows-1252?Q?biE+JPDFej+KtdhxVO7CgmYr5YbCThfM/mXLgZDF3XJ6CqeD+fvSNuC3?=
 =?Windows-1252?Q?dUYioP9T1Nn34NPwv9BttFQJtJ9pk3iwHubh754lKxO8sOcJn0vjomIO?=
 =?Windows-1252?Q?jMkt0S5QsIw0p+x8bmT5FmGWrv8QGe+C62zp/dVxTw04E7S9LgYGWHJY?=
 =?Windows-1252?Q?zFvEIRHw6WjeyiIPdQwIugEj79cFS8qJC8h8+edbVRh2CG74SH99/XrJ?=
 =?Windows-1252?Q?8IWisuS+v+ndYmp8Vl7dgI93IAIj1diFKwU2z/v1SiPMfJF00Rs0rqD5?=
 =?Windows-1252?Q?ibsCoXBuu3Te74CR/K/WOYHonM/rsdqO0KuqFqGLMT1f2o4C+Y+2TBLY?=
 =?Windows-1252?Q?Sm91gcGU4VQpCWH/2CR4JsQAk/RO449TDtKmnW9I/3fhuojS91b8Rq2U?=
 =?Windows-1252?Q?8kW/H5PQeOglkDylq8GqG8Agv0HkD0aRtcvbow3iLkNQacUs51fRuGGx?=
 =?Windows-1252?Q?JYO3ASvRvKl1abcFd7QZkXGQ2XYwGRZl5GejmMeeTbejzGCgMAdDD0/e?=
 =?Windows-1252?Q?AMvJZhYUZl8MfylxcDt9AAJ/iVD1OOPjVdqyyKhQP0RiFcYF65q6d/1Q?=
 =?Windows-1252?Q?AiYfcQfdOgyCeGQKxy3b3gbdtQ/GJ3SpWOXPgcfRbwE1TSZuyLNDU2LJ?=
 =?Windows-1252?Q?OTbSFJ5IixflqnBYfuSvAtLOCDZMXVGuQEfcorRe0b1xjuaEypsbWZUW?=
 =?Windows-1252?Q?3rgKu5Z6gWqN4mp9/xIsRT15A0xFzXRCz1Koc9NuwwGuliz6o/YThdhv?=
 =?Windows-1252?Q?Eu9N97p2v/od5eWJzjNF7g3VvWRDSQCw+vziDaysDAnU9l+pcSfXrM2j?=
 =?Windows-1252?Q?E1tqrYI+6Hry1sP17qfW/vnZ4J4OARg1qJE2g2vZSDadKpscfMmPMu3l?=
 =?Windows-1252?Q?Ceb14VWtV3rFn2YgfS0Ztn2GdyAFQjLjuPqvwAwg1XwFbKq7Fgn8D/QZ?=
 =?Windows-1252?Q?OJpYqTRlXzN5SXNHmOvFZQ2h5DbsTBwqnYGFU6GJI0x87Tyx+8Rly4nH?=
 =?Windows-1252?Q?XGwrpFPzFmRiwcdj3piRY1l8vjPi6gbHav05/NrRmLgVnsdvwLl6dxOY?=
 =?Windows-1252?Q?8uVrxguI4tnO54Jblid40Q+Wx3tgdpTcKhugw8TZQjxqZkLTVs9FQMQE?=
 =?Windows-1252?Q?1g3Bmsb00LowOeVG3w6Vp1WYn+34+FNuGsCPs0zExtsHxHM44szzs/9W?=
 =?Windows-1252?Q?qnU2xUJN?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bdb973-8cf2-49d8-6463-08d92077ea65
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 18:56:05.6935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcZBqV+V9E/rhTM5sFP6/t8Ed4QKOlKVj9PHSZ0rzZiEQUU3coB2ya0IgQoHAqqyABMwhKJrj+BO7chkY1AOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2322
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 26 May 2021 18:56:11 -0000

--------------053A35C31F8DEE2415014779
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.

Sorry for using an attachment, but my smtp server just started using 2-factor 
authorization, and I haven't figured out how to make it work with git-send-email.

Ken

--------------053A35C31F8DEE2415014779
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-fhandler_mqueue-mq_open-fix-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Cygwin-fhandler_mqueue-mq_open-fix-typo.patch"

From dfe5988f961ff97d283a9c460e75499db168163a Mon Sep 17 00:00:00 2001
From: Ken Brown <kbrown@cornell.edu>
Date: Wed, 26 May 2021 12:48:58 -0400
Subject: [PATCH] Cygwin: fhandler_mqueue::mq_open: fix typo

---
 winsup/cygwin/fhandler_mqueue.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_mqueue.cc b/winsup/cygwin/fhandler_mqueue.cc
index 745c80643..d81880cba 100644
--- a/winsup/cygwin/fhandler_mqueue.cc
+++ b/winsup/cygwin/fhandler_mqueue.cc
@@ -117,7 +117,7 @@ exists:
       if (status != STATUS_SHARING_VIOLATION)
 	{
 	  __seterrno_from_nt_status (status);
-	  return -1;
+	  return 0;
 	}
       Sleep (100L);
     }
-- 
2.31.1


--------------053A35C31F8DEE2415014779--

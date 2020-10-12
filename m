Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
 by sourceware.org (Postfix) with ESMTPS id 96B51385EC4E
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 18:02:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 96B51385EC4E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VecdGfkGzRaDPezz4QyRP8go2ILRkWoOL6SMbtAWBR9QpeGYDiPPJR8cG8iD5sQQmHUxWhyd25jzhOQPjhl3+VipLPL7EKeqZn6+/6QAjuKhE3SlsW4iuIYJi4Wv9qRODGiqycl8pLYV1fKNH1GD04BOqIrsFnRJZa2Mwx6MJg1bYO/sQxN0YT1QoYV91YvfsNhgS5dNRYyrSH+BpHe9LZLxqIItbxpb8KSEFgcQsobEnNMMw+k9Lsfj/Tl7+Da8PAFfDER3mxiRQ5pat/FJzgwfVFLm/gPWzodIKN57kxpim9byxOnbf5tBdey5dba9pS2iAOr6Lkihn3WOaYRYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIr7kr32eFrFZNqUvJ57JSbJBAp0nne4pjhOusyAvMI=;
 b=feKiYUxvFgmHbPgm0B0dOqvjzRfF7abHZDKqV7fmrtJTw+rvGhqYaF25AsdeCpO6ghvjFe2DA9R+VDNvHELjcWuXZ1B5G7ICmyRmXFXlfEqd5TGWAdyJKGu+fI93ElKkpY85LhIcCKoselVXjvlDp6qX0mszVJcREZqmA3tezrhfg9dUfWrM+VsD6PEBFKNlq0pJB4oyDqh30zD+XZuGby9rAqOgATLL05etzDKHaQeKopEZcHA85agcztZYTGLhh3uPCtvu9t3esMDz+iwMANcZ6YOTn6rYwwbYx300MOUtU1XD72qbgqCSObGXdRgl7Xbj1XINQ1TIlp66ZpzPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6063.namprd04.prod.outlook.com (2603:10b6:208:e3::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Mon, 12 Oct
 2020 18:02:31 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 18:02:31 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/1] Fix MSG_WAITALL support
Date: Mon, 12 Oct 2020 14:02:12 -0400
Message-Id: <20201012180213.21748-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2604:6000:b407:7f00:946b:663a:1a3:dfd2]
X-ClientProxiedBy: CH2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:610:50::34) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2604:6000:b407:7f00:946b:663a:1a3:dfd2)
 by CH2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:610:50::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Mon, 12 Oct 2020 18:02:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d069f0c8-876f-45db-05a0-08d86ed8fceb
X-MS-TrafficTypeDiagnostic: MN2PR04MB6063:
X-Microsoft-Antispam-PRVS: <MN2PR04MB6063CCEEA98D92AD95837269D8070@MN2PR04MB6063.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYKYL8QffhJ67Qspu5wYqjhbEkJXK8r1Vq+sWC0kcecfpQDVcCHxfF+nVb5LuXu4ZyRP/AUXT5ircJSnmrXxHt9tSqMRznKDb97NlKLlEH2csSygRflS1ZodIsDoiF13CqnmphVfByneSH2gjiPg12CrkHRZ0C0rmPu8WZGLWbbcMMq9ORgqNWNNmcqJeYks4KWHIZHReopq0RHf83vyPkv67e4q6BiBCfB+8fvl72kgCVNqnVMSAUpvA/grItXczl2IMPoYY7MaVsSZlfIDzLudhGs+r26Gctfzo0F7bbTxT/+eJVe7KJ2aibZBB+Aj08c0KcGcNhVjP/qLq9cx2/uMdDZ6TLcc474dTxEKiFmUmC9eCUrJWBcpaFv8v2CV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(186003)(316002)(6916009)(786003)(8936002)(75432002)(66476007)(16526019)(66946007)(5660300002)(66556008)(69590400008)(2906002)(478600001)(6486002)(86362001)(8676002)(6666004)(6506007)(52116002)(6512007)(36756003)(2616005)(4744005)(1076003)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XGvRsyTwi2Bpex3KnnvY4Fo39M8rjb7wNeZFNwlRTRs2WnbCww1UCkIPxpMu72PE3uJHgXnU9JABXcdcT/ETJp/86vnQwJmZ/H4pHXIIbYozSuHfD0wiZeSSQy3sEFkAwNhBbPZl1fC5cXscNhzUM9MhkVpNR4IeAaMYz9s5yZJOvCQE1Ad44x5CM+t4b4sZbvM8GSpB8lof93Y6h7a3yhmmpbqY/goDgOWv6FZX4e8p3Gu1iKXVFi+fBDcESbezwQqxNv6yrf+vtUJWErkfOJFWC3VBBmycrJYr8GowA9cM4rwErCr5Z2dJ7av5HfHlwuCWoYfEYigzR1BGCdk1uBukMe/f1vOFQt9nhJ4KoWuWHiSTMgD5otrE/oayDSW4/hq5FNI8fgqJWLhzRI6LS/87FGUemQcoUC8tbsfHdqyFu1PXKHnOTCUX3o9WLGyLdS4dH3GAlZUCcx0ISyMu1Qs6MboBzamMZwzt0bu/r9r1xw/n496XIEaKdUvXIopzj/jsRIOgaS31XK2pT2QDnsbHyJ2GYb5ouQHecQfGvMTJEX6hX2QxbArCrCyFD77JkOqOEuPXGZ8s4IqGg+xXWCb0+4vFAi6FJR/wjghHHUlsaqx/6wXLBpf3IX7DBtQfm1R/nZ3HuE0Cbi6ylwcKNU47IvJ7uz5L+0KNpOA3RAFngcoNROT0IZtnS93G7VaFIcnejQsDhLdFUVRU0CXbOA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d069f0c8-876f-45db-05a0-08d86ed8fceb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 18:02:31.4093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mUnhmHf46kdQkJYC/idrHqMROrMT5LfWlUBU1/1CjbUIUq8XGWmZCPiXFedCq5DCtKEyUW0U6t0g/v8UZOVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6063
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
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
X-List-Received-Date: Mon, 12 Oct 2020 18:02:36 -0000

It looks to me like there's been a bug in the MSG_WAITALL support for
AF_INET and AF_LOCAL sockets ever since that support was first
introduced 13 years ago in commit 023a2fa7.  If I'm right, MSG_WAITALL
has never worked.

This patch fixes it.  I'll push it in a few days if no one sees
anything wrong with it.

In a followup email I'll show how I tested it.

Ken Brown (1):
  Cygwin: AF_INET and AF_LOCAL: recv_internal: fix MSG_WAITALL support

 winsup/cygwin/fhandler_socket_inet.cc  | 2 +-
 winsup/cygwin/fhandler_socket_local.cc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.28.0


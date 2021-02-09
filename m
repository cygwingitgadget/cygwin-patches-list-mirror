Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770132.outbound.protection.outlook.com [40.107.77.132])
 by sourceware.org (Postfix) with ESMTPS id 638DA398B824
 for <cygwin-patches@cygwin.com>; Tue,  9 Feb 2021 15:12:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 638DA398B824
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3x23aMYCFKBfZaLnPn0pW9mSu460WYcZ7LDCXuIDLs7NyJiza2yueIBVcD3fH9sEYb72vSzSexu/fprwytv001GAboUg0Vb4rmtL/JxJ4c4MeNEdzw+6YHqkkcVVfmESMp9g/VgruU1aXzPFnxW8QGk4WNPxKQcZxIyIvDxjsOoIDguoTmd8sWaZkY+BVES9VuEi4jxhBsIKYcLT2MK8UYgF/Zkn3EZXeN4sN6zFZHxqrmQyogFzEtOyVOPIR7jlLs//9rBDjo5nX/LE5mLuRP6kojAQ0TFE9r/uvCTURg1h49YoHIkTJ/JGdjU5hwV8WwV3H1ia2yFuYsqt0P/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctINOwIVUzJyjWQNcBOWH/9WF3fOTgNE8465VPd/2ds=;
 b=AUA/rkm1Q0WHxmlrWEzy9jFvqr8mdB0uoj5g0fV4cZKNv03fiMNaoIDRQ4r/cBt9jf/sI9fwLGy/AqW/3um94jVf5a2CA/VQ09QczUQJ5ZJ8eCZ6Z0Cr/0yF0KZhdN6P8wjghNxBK3T/6KxCpC8+xkGQEqv+z0K3bWrUyYzdFMmeEuKvpCHrej4YgnikG7t1x2jdbEV5NNFEtCzPtvVfnvMokTwkgt/hGl7dG4dvq8pC4JH7Oi89MCf8ZJ1MaKKA1xFj8/LQEAbFHt3AMCGMqb31HFnX2P+CuoRShOt2NpwGuI1gd+6IWiAj47NX0pbZZuNvTNzwE9E49+jrzietag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB3954.namprd04.prod.outlook.com (2603:10b6:406:be::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 9 Feb
 2021 15:12:19 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 15:12:19 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/1] Fix fstat on FIFOs, part 1
Date: Tue,  9 Feb 2021 10:11:57 -0500
Message-Id: <20210209151158.57831-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
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
 Transport; Tue, 9 Feb 2021 15:12:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a758d2-9309-4a03-6350-08d8cd0d17cb
X-MS-TrafficTypeDiagnostic: BN7PR04MB3954:
X-Microsoft-Antispam-PRVS: <BN7PR04MB3954ED53BC1BAA86781C7D43D88E9@BN7PR04MB3954.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVLc4o2I9j11oNy0tEN2KGPPOk2dEEhOzLSmoxbUwafaeb0LSm6bi7ZowfaIOYnqYYeguOtunyAFhatdv1lJb5kXDuZvD94VOBEL+nurqXog2Zg9jnb2p0c0fFUMlYkrXpTcQypb2y9z/YefoTzZTdGXajTxoM4d1DIUy7IzhExoenU70RHGx9jmI/Vb9jXJRJtp7Xs//DmxT0enoLrnr+L7Y6U+mJhX2ibkAgrxqw3ExmGPog+8gbHFEuZ4pNbYL1DoRkfvUmaMYIW4wu15NesZOO0zqgSPoAB2KN7xFc2jwGmZnAa7n1oqBNWnZ8XMddZBjZ4s+7rLg37dY8x73nBKwmor29Ua04Y6AmkHMZYlRE4VFJCW67cb0xqHU/OnwE6246W5bATtFY3ADzfMN9Oi3ww6W9CrZYiw+GqE3icqF3Q8dpWO/A354bX4cpcc2+w/fk0liK7fu466dL0PSR2WRF5zN9nAh+hZfTdPfVI54+jkifRwhNFEE8mYH3+LDRBGHXCpfuKNwJg95n36o2PHeuJ4PctoS0a0JGx/JA+vSK0CEYMypakecb80gRzk+RJzFzj+CfxbLWFEkDqEfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(6486002)(186003)(75432002)(36756003)(26005)(86362001)(83380400001)(2616005)(956004)(2906002)(4744005)(1076003)(316002)(786003)(66556008)(66946007)(66476007)(6512007)(6666004)(5660300002)(6916009)(8676002)(52116002)(69590400011)(8936002)(6506007)(478600001)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mefz/uzGxMnYRTtuDlpf22E6WR0zsqAmrjuNgfyDo+Ml3cJBRPnis1bpLExz?=
 =?us-ascii?Q?bNqtjewVl3/tmMV9/pihfCBzhr0riHZXTlX3XupkZISNT64AWeL72sBtCVE+?=
 =?us-ascii?Q?x3/G2mqL0fYuVQpuRFFT5sTOQXuPMJDJ8pfJkjydqBBV7oQuskUR65Xac9nK?=
 =?us-ascii?Q?G8aZzFWPA2spr2z30J5BXcbOdEVK5xSiMqZ6ysD6UcDVP0esC3uJWoDed/Z7?=
 =?us-ascii?Q?a7LYk+T4QVKIMcRd6bNm/NI3v4Icxt3EzSY9ITDv0ZjNES0AyI3S78p89ryA?=
 =?us-ascii?Q?deu+ZkXC1D30brVuxK7Gw+eR+hNmxqZuNxeFbsYl1r51anFutjPYekH1Vw3W?=
 =?us-ascii?Q?ubplYCPfqCVqNVDVjwCLrf8XzgJ88A/ZAV1XTxNz/7mSEVubGmulQpZuNevG?=
 =?us-ascii?Q?11l3ikxNSjeKJcwakvaHJ7WYggpXA4vMbLvkbC3qJHfXhSmtQm5GCN7Xay2s?=
 =?us-ascii?Q?2ZjpOaW5cOYJpC5h4G0mRlPvmuLL6li0V6ZgQ3vfB8FTKxYG9Hr3Q47BrTkY?=
 =?us-ascii?Q?hPBetGgaJihLN19sHdoGyGgD97Do1OFAjQVgn6+1qJjg1fLZ5HuhnhUeP64b?=
 =?us-ascii?Q?K7SI1xqoP0CphNglmSAQh7NgCu5RAM1DfOJZjvquqLurJuL5NcnyZL++Xe13?=
 =?us-ascii?Q?JTllU5ebnZKGqaEaSuDm9AJH1O25B8sczk/nWSxsSR31VEguyl5S0Bly9Cfr?=
 =?us-ascii?Q?AGLvAsIMFq1CGO8y9zLg23kjz/yjSgWa+a6U+gKYYFdoFFz0bilaF9WC5Nk0?=
 =?us-ascii?Q?Xia7T2xeL3x9/DuZZjFwATMQlpWiToQaU5SAE2XKXJgVqpdqKueyxSjTi3XP?=
 =?us-ascii?Q?R80ajZlmknriQ4GQ6eFNRY7hcHGQcY+sLdBIaMv57w4PCOy+OXNJrIoQrN25?=
 =?us-ascii?Q?YD1/Z6XGGZgTsgx7Grc5lHRx7oNf7KSPBgaMknGAu2Xf0UEhgu8N0YM8mGv6?=
 =?us-ascii?Q?2vZWBxfvlC5J9T5kYt/4zNkx9u5w3qoVUL/KeLMRbpgrysKzZiElXXcPx7uP?=
 =?us-ascii?Q?rtT+ILlya/A6iN91HXALme4u2m6AqqEldLnR8YL8dgw0vO9eNutrJnrkR7qV?=
 =?us-ascii?Q?4eDuvo4/pr+3tfvzovVUyzi6P/8MWSbLJpE5SEL65tRE/+8GJBg5JldAyBml?=
 =?us-ascii?Q?XspLMqGykJxOyrRWa0K0u+ySksseBoT0JvoiGiLYaQ7jXLgV/yz9WuG+T1VF?=
 =?us-ascii?Q?r95VZkUF7+QmiEoHG4uKLOKyesXKSmYwdhCAvlfsPuLyDPd0+f7cjVwM80po?=
 =?us-ascii?Q?PEDC4I/WaZVcV70s3O5Ry5WBNqqLZxE3uAghEFFWuHA+eoRdvhI9yp/2HyS+?=
 =?us-ascii?Q?B/Bk9H9Id2eiLYWAceGU8ZPj?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a758d2-9309-4a03-6350-08d8cd0d17cb
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 15:12:19.2378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARHDCO91V0X1DOPivZBJk3ZT+2D4bI7KbBRoUwvyOa6/Xi8KwO1jwuIBlnP2huNvF5M5+nNf1klSvM3AcFE/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3954
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, KAM_NUMSUBJECT,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 09 Feb 2021 15:12:22 -0000

Commit 76dca77f04 had a careless blunder, so this patch reverts it.

Nevertheless, fstat(2) can be made more efficient on FIFOs, and I'm
working on a separate patchset to do this right.  It's worth doing,
because every call to open(2) on a FIFO leads to a call chain

  device_access_denied --> fhaccess --> fstat,

and this is one of the cases where greater efficiency is possible.

Ken Brown (1):
  Revert "Cygwin: fstat_helper: always use handle in call to
    get_file_attribute"

 winsup/cygwin/fhandler_disk_file.cc | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.30.0


Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
 by sourceware.org (Postfix) with ESMTPS id 095F13857C4D
 for <cygwin-patches@cygwin.com>; Thu, 22 Oct 2020 19:26:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 095F13857C4D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXv61cK3C9fO6yRDxSKaftZ0qSSfPIrYQsv9TwNy9/L7gWedfVxjK8Dx8gzeGzY8jxyMdudleXW9ZMEYr4zXLrWQy5aQRhR6UqzhYIlyUb2PoNesqkHLPTXbTbPEu8haTMxXo1DJMOHO634bqgwHwAuoE90cuyvwbB33ZBIGBlgFkWrQ1XNpNSZBIMwCgm/sGlMECzD/ryJ49YDMQXZAgnhO/87mYjg0dfrO5NzINhG9U46xTXJMtZDgcad4bYxFjT66GbpDXWUHnvbVRDSMofF4EamVedAusBJAz1bfDSMsxPQCJIX/vELXt9yXbLFrIGFBn9XYWywMA/Jg5Ea3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS3CkOKo75WJhctV6ale9Upabfz9pqH/y41zqb4k7dM=;
 b=diNaJOev2RenebvqdwbVJE1umpx6oEVRZPgwjrQi6zqq4BGLbvm2mcEKKh2yYXGa/xCBABxHTfr7HiZl6RK5hhEtrSNwtsjtwqpTqij4lAZS4tGYYSo5hcafV19NZ7RfqUQmhLu+6kKsWctYuxbXb8AnmJqRlNoxu6+LH8AxINp//fRbsj7IarBAQVcv/GdMiYiiTD45O/87ycx9CFQvjlY00FIjzN/r6c0O4kUaUGBbxHeQmf+CZ4nSYRbntSCNy1KFKnSW8jEzIRnHqKuRHl4aAzKg6B3i7E2e3cN/9L6THqD+++Ot2Tj53QlRxRG152QdkQVFP1KqDW+UJActjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5568.namprd04.prod.outlook.com (2603:10b6:208:e5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 19:26:38 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 19:26:38 +0000
Subject: Re: [PATCH 0/1] Fix MSG_WAITALL support
To: cygwin-patches@cygwin.com
References: <20201012180213.21748-1-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <48028fa7-5bcd-2c37-f535-87ad622840ba@cornell.edu>
Date: Thu, 22 Oct 2020 15:26:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201012180213.21748-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: MN2PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:208:19b::46) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 MN2PR19CA0069.namprd19.prod.outlook.com (2603:10b6:208:19b::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 22 Oct 2020 19:26:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7688e88a-42dc-473c-4b5b-08d876c06568
X-MS-TrafficTypeDiagnostic: MN2PR04MB5568:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5568A2C3E5E03FF80CEAA070D81D0@MN2PR04MB5568.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNjERQ7oLSmQ/2SPVatIYLbtL7AEC9VqDgML9h1SFLplhjGVaUXgq/q1ij6tGQ74LbyfNvKYvUDj6ZH4GTKUeDlIdnZPsPSoktlkCOyQ3LmBdmS1DOOCc4Dtj336tSjcOW/+mkQTbK6dYOSBA07zqbInrqDSIzjK3H0yl3MEmh6s0RWksI5w6ku03FT8sRyE4081d3cXJMP+adBvjlnTlTBwPFedZpQWxbZApRU6fKT8qfSrdEA1gumaTq7Y9gME+P+TK4hhpmnO5vhoq/hkqI3eDabWoAmk3A+xr6jnHAG7Jxb3HA1fow2zZrgNh4boLBhXvG5CB7b8kAIOx6NYQ08fpg0IbdrWGOsI2DTnhPCDiyTPF6QIbUcMDa8WxAVN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(6486002)(316002)(66556008)(66946007)(31686004)(4744005)(16576012)(86362001)(75432002)(5660300002)(31696002)(186003)(16526019)(36756003)(8676002)(66476007)(956004)(2616005)(6916009)(786003)(52116002)(478600001)(8936002)(2906002)(53546011)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Gb3TMu5XUbw0kKR+U8eeR10YAZSJll/Os+QmPwKiOo0DyqJyFtMgm5yQTTXGh5GZaTFnBqRYAep8C5R+uL/1u/AclJmfkS+Qd5m0hUFRlwi0ysoMBeAIlRWzeIBfMA6hhV+dBgI5HdriB4G03nM7+OELj5VEMqsXStaLRCfHrcWio93XfPcNX+ovACLPU9hhi77ENjDlB3IY5fvA/aIPxJa25F7AQ7HIEkrHjRpk0mb1HujpYmRU48rR+G33qZ0e0lidnO0syqZ8N6GLH+GfKkHohGHJO8Apg6tOfBu90i0jC2ZipVq5SDpF7rMOY4t/RpY/uubiipR0k5QY4m4zXQY+ohABXQec3LYDsOLXzrVuF7di5m3rLqWm5xFgTnz+kci1e8hywG1vBGsjflWUOT1vH6ZkXwMVS+lka1aXlxKDujNQpTCCi6IMpe6XpUMnIwu+WRHSwRq61qQFJ1CZNA0BsB352bZ3b+EDQPCZRTbfeuaV7Mt+l+YWZo6P4i4jfovDg1oq7ViW0z6R0KiwH2NdvJVuZEuADjpnMsatSvaXZCsyzTNgIbb1v7AtQiIZknhd5PQUEcIO2YOtmbVIC+cLrXjBoXarmK3qNRv53BO9BcHK0AF5e5T6z9gMVco/9dhLISqkCxLCsOUQ1MO3dQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7688e88a-42dc-473c-4b5b-08d876c06568
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 19:26:38.2745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3ABf/dAErClohJnAf+reG6ISrmu5tSA8vQdZt5BgsxQz/6FvvHYmSvo9C2czRYnHW8J/VLsqssv6b18HXDuLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5568
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
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
X-List-Received-Date: Thu, 22 Oct 2020 19:26:41 -0000

On 10/12/2020 2:02 PM, Ken Brown via Cygwin-patches wrote:
> It looks to me like there's been a bug in the MSG_WAITALL support for
> AF_INET and AF_LOCAL sockets ever since that support was first
> introduced 13 years ago in commit 023a2fa7.  If I'm right, MSG_WAITALL
> has never worked.
> 
> This patch fixes it.  I'll push it in a few days if no one sees
> anything wrong with it.
> 
> In a followup email I'll show how I tested it.

Hi Corinna,

I know I said I'd push this in a few days, but that was when I thought you'd be 
gone for a while longer.

Does the patch look OK?

Ken

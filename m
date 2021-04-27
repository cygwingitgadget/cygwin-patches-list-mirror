Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
 by sourceware.org (Postfix) with ESMTPS id 74526388A401
 for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021 16:52:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 74526388A401
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=kbrown@cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EInZ2le7XRKFt5QZ/ywNAkDEDQE9CHy61vKd+0OJ+fFZuEnlvumf1UXkqNVZQGHPFyiAPqe4y2phd0xT7dnO8agpu7yCuviuMVsFxrPMcyK2cCxTplpmbgLLEplYi2TthFg1P0wva2sSNQBP3plNhUzRzCd9AzykB3y6UAZG2Wc/r3neGLY326M4j8jIVx/NRqwgrS0Q1bZs/oWXXFscIoPnF0t142cF3iMso3MhxMd4p1J4V42pXSemxGO7CdS5Ty/zjILKeEhtZTFwa1IEfuhGm4cyC7FSqaDXzOY30gTNspUW58e9FiUAcZzkFcTW5t48v3p+dUC1jLQWKGER4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSlK5khKWdLKVcuajV7A0qOhrLu/RMb/+0sR+m5vv0g=;
 b=UDjhAXwHXSLjISK4cXqO2S8yd7TB4eDyl5ttu5jsMIhOa9GHmM5HxNHAox/O/iHC7MIOgBj0APVR1/XyPzGlQ2pV/6NI/x9jw/rHQ5p83mTpfYah2JTjtc51ZIRr/aLFfl+bmr+YpiL5SuGKg3Rzurq8SSPjvI7An9zCXGGjCxCSl0Xg7AdE756SnIniSy9ZIJyPth0zHd3bxzZsg/7b0JKmgjBiQvxQMvx73Z+WEyrY9O2fnWsc7eKkvWLhbFZg+Y1N6LXUOwY24UscYOlm8qgp2BJfaBfEbUbUsgqgJf8K0D9Fmhn33MYEaz8s08snPQxvB4TdoZlUvtxkN9YxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSlK5khKWdLKVcuajV7A0qOhrLu/RMb/+0sR+m5vv0g=;
 b=b8Ey81A3HNQ+/H//Ei93skUM6sY3hmLCBEQzcJvTNVVKW9HM4paCjvljKtr+uEBBi4+kOWQTZnyN4r9JNBXxLHBIFDRmwFPNsSkdr9ABbjg4TQ+zuOrJX7n2zGHduWhcIsKTCjFpbc2k//jjFKQAgdRTI0nmKhRTGg7I558b0M4=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6369.namprd04.prod.outlook.com (2603:10b6:408:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Tue, 27 Apr
 2021 16:52:14 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89%4]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 16:52:13 +0000
Subject: Re: [PATCH] Use automake (v5)
To: cygwin-patches@cygwin.com
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <74ea8f75-8bbb-8a58-66d3-cf6ae68db2c3@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <dd2be414-edd1-5502-050a-ecaaa5920db5@cornell.edu>
Date: Tue, 27 Apr 2021 12:52:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <74ea8f75-8bbb-8a58-66d3-cf6ae68db2c3@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BL0PR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:207:3d::47) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.8] (65.112.130.200) by
 BL0PR02CA0070.namprd02.prod.outlook.com (2603:10b6:207:3d::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Tue, 27 Apr 2021 16:52:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991017a8-b471-447b-7508-08d9099ccea7
X-MS-TrafficTypeDiagnostic: BN8PR04MB6369:
X-Microsoft-Antispam-PRVS: <BN8PR04MB636905040D7287B16D9CF0E7D8419@BN8PR04MB6369.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAfDGunsVd22tZp/82sBezMUkkERWX9mJ53Xn0/UJH8mjhbmPbStrD+xdw3mF9hClxJv2yTImK5KpqSMcd/JDmhEUi2FN9MJF1WIbE3ykBAj6sJeHyP9X8DEf19OHgtQAeLq1WQ07wyPuvYwBVvvBb5p80xojbeDZ3KoBoR0kd83S7f56eiTmkgnis8ZcWXMQKvBQDRFxEnbceSUk1q4gNpaylTZFppyIHJmsVHaijS1xgQ1jH7aE3N9zZK18bVo5EMvfHNpSgYN2Eq0qz7ybtPSRYlVndd4NTTO1WvlJJSO9tp2epPhVQwhRVu6rJy97841Zc4QTfYhomdhSidyEbIFI073G0iIhbKwQETVk50Z7YcTLFl9XBh/AtN43/2cI3RQUKG261nNqwCZdQqdeUIR3AF8Edf0Bo+FAAj4MlFpc0NO5ZgI4LVTOgQvMibFj4Xl7OqKhRomT+CxrnBOoAEfdsn8go4UW1JPYx7XvSXhSIqof/rI/sDmtvGxFs6IVEGT/mdiwqpuBJXMOp1fUbXvel9qR6Cokvlld+DbE1s4JMuXth3iQs11aHONnkEYs1jhTPJ+7HQMQuOrk+d1Zb7ie4liITA8J/anDSRuRKYZmqUghEQ02uJrt9jO7da/ohhKMCs8mYjHe0ufeq8RkVp7mQAsTG/b3z7juN3fNwsiQACg4tiXzCXNlUjWQgN8zRgl1inj+sEnt5GM5TmhENFeZ40bjxqL9Amdp+oZ1XvB13EwYHdIV3MOlxGELH/3/aZkJi0U6/xam68gLH4ZXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(26005)(86362001)(66556008)(66476007)(38100700002)(36756003)(8936002)(6486002)(6916009)(478600001)(53546011)(4744005)(5660300002)(16526019)(186003)(2616005)(8676002)(31696002)(16576012)(786003)(2906002)(52116002)(66946007)(31686004)(316002)(75432002)(956004)(38350700002)(83380400001)(43740500002)(45980500001)(460985005)(2480315003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?mJgtyJZQcspXrH64APWLRhcrXNwT7yFzvrkr+ttUnwAzDBUmKjqsw3m+?=
 =?Windows-1252?Q?xXUviOYeDNHD7+9KhBXEC5gW8Epfo4tNHvVog6vTl540zZhhobPKPqoD?=
 =?Windows-1252?Q?498QR6sMZme3QgglJLRC/hMgooIvQ+rIKGEPV78cpZkyKP7kdBa2gEjl?=
 =?Windows-1252?Q?znCrsovkzc1JLoiD9Kb1skwyGqiALwBsRQWqLCnxizY61LO1qIAamR3D?=
 =?Windows-1252?Q?AfnpAYO9oSwOAnL9zqeWzTszH7aiMdonD7jq/efu0eP2i1IYMxSeyiBE?=
 =?Windows-1252?Q?hE5kRTEBom57HftK3pGpmbSPVmJrbVagAm+sqaEYZivmi5UOp2Ti2vgE?=
 =?Windows-1252?Q?N6kbJisnaXwnaO4hTDQ6sSo3bi6z0uTVfUHIsECGtViddjbl0om/kZOK?=
 =?Windows-1252?Q?jdwMcnzRz3ehFkz4kV37CpbiGk24sK/UGDrrn8jFOfA0ohueycwlOZWk?=
 =?Windows-1252?Q?32XEYGQtpGStPG8NTr4XRf5opAJ/wSFpqRMFwlYwXX31IHbyJHrE/mnB?=
 =?Windows-1252?Q?8WvXp6xbbBrPAWpSdU+oxXm61GI3yAyzNOV6CvG0KrrRTICX45+gadhg?=
 =?Windows-1252?Q?0N1RrlUmS6IHEFQuKv6NvLSyxNYDLD+60nX/9euiNVMzWwE6HSiZr2cO?=
 =?Windows-1252?Q?c2HBk/tFi80w+eWdLWH/WsFxohTnFEFLITL1GRKBZMJ36uNnbB1g8S0j?=
 =?Windows-1252?Q?2eVR765Y+IPZWMf21pd6JyZV10Fokv0DZmo+Wpgi+va5DRGPYYn34ZkB?=
 =?Windows-1252?Q?7YCS3r1lQRTodL1lkXJVEbEpuHPFonepQCvYPH4hKVWRPZKbUF5tO66l?=
 =?Windows-1252?Q?RMMosAUlH9+NEXyGzhsIVyPH2DWSG6CA/ssi2/11hX8Eh7OAkynVNjo5?=
 =?Windows-1252?Q?CIxqlC+WD7yehVny46hc3wQj7r+p2IMArL7Xjnvxu76U7AFyWYfWetYM?=
 =?Windows-1252?Q?I70E+knbAxkiAj92RBeWOD+TRDn4rwCPIoUw/0tmHCVN/AJTmull5q7L?=
 =?Windows-1252?Q?aUt0Y7RjfsgPkXfT/9jGhnSii0syfBgiXKp4BDy8494ku1ONG2W+Rc38?=
 =?Windows-1252?Q?lxgOXJZlfo6HAegKbU0fRA+i7uxJ7fR2KbM3LY8HJt0hNJgLFs9fnnU8?=
 =?Windows-1252?Q?3I8rX3bqXwZhsbUMhoduD5jBzr0MKzVJxoMgeE9w/GJzLuaTLJQD+xES?=
 =?Windows-1252?Q?rE5FE6j7Q2PRbUQgNUWEw1PrbiFXqUGYCiroC79+qb179aYEPfAkVxRU?=
 =?Windows-1252?Q?3xfGbI61vTXB/EikSyT61ix3nrI4loBpt60z+SknqAvEm15/HJO5eUqC?=
 =?Windows-1252?Q?pqiGl546930xgGnpyVXw5/8qUNr149ohxJYXuEi/eJHm1qW2TTw0peKe?=
 =?Windows-1252?Q?1SRCILliFqIl1nmKq5Q0881KJxT0PoO1qvptBJPw5Q/n1OmbN3bvf3+B?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 991017a8-b471-447b-7508-08d9099ccea7
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 16:52:13.8993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHuPeJdKHIDB0PdkCPzOw9k7QuByjirSc4QjEwOyYPmVu+XpE1IgCqkhrgyvadQn8ZuvtwLX0vrcJAycsbNFLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6369
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 27 Apr 2021 16:52:19 -0000

On 4/27/2021 11:50 AM, Jon Turney wrote:
> On 20/04/2021 21:13, Jon Turney wrote:
>> For ease of reviewing, this patch doesn't contain changes to generated
>> files which would be made by running ./autogen.sh.
>   I pushed this patch.
> 
> If you have an existing build directory, while you might get away with invoking 
> 'make' at the top-level, I would recommend blowing it away and configuring again.

I'm confused about how the generated files are going to get regenerated when 
necessary.  I see calls to autogen (which I guess is /usr/bin/autogen.exe from 
the autogen package) in the Makefiles, but I don't see any calls to autogen.sh. 
  Is the latter no longer needed?

Ken

Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2094.outbound.protection.outlook.com [40.107.94.94])
 by sourceware.org (Postfix) with ESMTPS id B4D0B3857C4D
 for <cygwin-patches@cygwin.com>; Mon, 21 Sep 2020 21:05:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B4D0B3857C4D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtZeI2gBZtFpUdA5Z9RehCSKb2Aowt+9KtPEeaLCQtlcl6HO/lkWr0/aKCQUpzr2SaSSOCPJxQtlYCkFldT/HgQFW4+GBTkZTTisehLbyGTQXGNS6tQVOpQnq/L9/totGJn7sYWZJ13ptmc46nzVV6A50GD6tq6qBn2mjpbosVk4tYXDWpPYXdAoyaKEzMQAkuWOQ6SvImdm18FSR3QP0A/uCjvGMs6zL0lacSnaxOaz6ONSC49MpTPTpnL6eHF+2ZmwLbs8eY0n2Obfo9X5C3aGRWugoC2o40iZ2ThGdQAzMEHiwVOa0SH4QMcnLr5PPsKIIyYfXmBC4rIrfy5kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k023Gw1WU9i62QP2jqJtCFHby7bE3ZT/G3QkP7GNXWM=;
 b=HV8TkSXJU/KcSsuw9ldV0mxV1cTZVNFZ0xGx98W2EmWDc12U77ocQ6satnaxf1bGGzkC3rs06qLBLKAc8627ZICMtl594WWfYyh6xeOG3G98emPq4RNDwxmwrOVpyDxSMVfr4iuHfOLyRi/lfacGzMU2NuI1CKtAxev+AAhbjS+vpUHSofTLxx9BzfGJzDSbi3XPuqwsOqsEwK5gmR6Byde7AClnEa2w7m7rHGhA9TDQq7gGi3K6q4MFpi1tz8iYh2aDN+fC7CfUC/NQCMEBWKJgFe/5s8TYq2YXEK3aNvmNgrXAQxq8hesb9sInBYeV9h5VS5d9SHtl6Da+E/IGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5965.namprd04.prod.outlook.com (2603:10b6:208:d9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 21:05:29 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 21:05:29 +0000
Subject: Re: [PATCH v2] winsup/doc/faq-what.xml: FAQ 1.2 Windows versions
 supported
To: cygwin-patches@cygwin.com
References: <20200918025335.43795-1-Brian.Inglis@SystematicSW.ab.ca>
 <ea6c7db5-5c8c-6e5c-d9be-6ffa50f2d236@cornell.edu>
 <b347ae40-0eaf-8fd6-9698-f3a04f5640ff@SystematicSw.ab.ca>
 <83715369-327e-9159-9bf9-3de5e27b47a8@cornell.edu>
 <9410b3d4-ef85-7a18-2cda-c1a52d54c0f9@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <fe49cf4f-4c9c-a62c-9a9a-3de2eba364ca@cornell.edu>
Date: Mon, 21 Sep 2020 17:05:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <9410b3d4-ef85-7a18-2cda-c1a52d54c0f9@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:610:56::28) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 CH2PR14CA0048.namprd14.prod.outlook.com (2603:10b6:610:56::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 21:05:28 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63efe8d4-9b8b-4083-1066-08d85e721185
X-MS-TrafficTypeDiagnostic: MN2PR04MB5965:
X-Microsoft-Antispam-PRVS: <MN2PR04MB596556B33E31D9DC0D30D25FD83A0@MN2PR04MB5965.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcyGNwMNzn2YYFvvhFf8CfyO+/0IGIDxFVlKd0nSnG3q7NkkRf+/JNBxIhV1OpEySX4LC7/qsC+XcPEuxhHnvvW5eFdbSH/wLvhW1g2U/xgOukXlxUYtz6T8COQ2dqaRy2m8tkEIuaIh7NGqve/EcUi+0OYeKWxhBYXkrhHu4kWkhdD+gxrB1wCfFfQv1AI3zv/E0VTJRR2aYceIhh/RN/PJudlKddS3jaePgX6sNWJ1lNKf3uQnLXwNUKANJ1Jos5nnpnabvDJGNxs852Eg0ojxEgCRuQwUPtDRBWveUSnWnxjB3YjKb7J1ncR/9jD1zGD6/qcFn8/bO5PGHK73hreuv+caFr/0upKnZtK41yjieQNNN2Vt4LbjloFdDWh6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(186003)(26005)(31686004)(6486002)(75432002)(6916009)(2906002)(83380400001)(36756003)(8936002)(52116002)(478600001)(8676002)(53546011)(86362001)(31696002)(16526019)(956004)(2616005)(5660300002)(66946007)(66476007)(66556008)(4744005)(786003)(16576012)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rW9JUMhJD+wU7JAWY+UP2ExnW/DXOb8oBYCm91UPkXjntvhXxTXgvHLx+ZFXxhza4ZZJcKrg5+4Xt8Wg/zw62Z7+tIKdjsl6f6iede1jatkIy7njSvux4AiAaV99ihf+u+bPzC386P95gqEaCbwAb2ZdUeuIoIG2lyAvJXgfPKFsybjVDRNxSMaQvdBu5op+cjhIq2Q0tbi600GwlK/sRjgXRT4IBNtZO/ybcpdTQzOcoPDHmv+c8D9xhZw47Z6nlAinxvRmUaH3tB1+R6xp5IVxel/pvemcpQqJx+sgyMLNs2csvf/AkCAkjpUlVe8lVnZ5DdO8QeT9/zA7xdeXTKCML95ZQ4m87SujFFCwHy+/vR5Y+fnoLDfm6Y/+C5DPAe3olIDFy7H5c4KUJ/GeWsUIB/CT7HNvJdXbS/bT4ZzMT8dR61h7Nmc4lU/s9dsN4yGQVYjl+6FpQGA4w8Lywdk0s/HbafD2yScvvfOlRQCgUi9mrN1SdOJeTB639dESlDDcPUfZtV8rZSPUW/X5iSCHXLDc3eNBVR+ovc7dC8Fot8p8v93Yr7dgp76dBqMD/Ei7SCuiuJlYKmElR0n3KOqmiFfIJfg46Ji0PYLXhI8U0oh+j2+hs39Eqz3rO12P/EKxw3ff/XV2KoiZTtu5+w==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 63efe8d4-9b8b-4083-1066-08d85e721185
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 21:05:29.0058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIXzni5NWpFFWsk7VhgY8d5J5cx8ujpYPbqL4CRbaRErHsCYlgT+qvOfwKVwWRhIF4Oc2xS5bTtK31ZBmYRZGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5965
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Mon, 21 Sep 2020 21:05:32 -0000

On 9/21/2020 3:22 PM, Jon Turney wrote:
> On 18/09/2020 22:17, Ken Brown via Cygwin-patches wrote:
>>> Do you have to run something to regen the docs, FAQ.html, and push to the web
>>> site, or does it run periodically, so I can follow up to the OP and get feed
>>> back from the responder?
>>
>> No, sorry.  I don't know how/when that's done.
> 
> I believe all the built cygwin documentation files are present in the 
> cygwin-htdocs git repo, so updating them in that would deploy to the website.
> 
> This is usually only done when a cygwin release is made.

Thanks, that's good to know.

Ken

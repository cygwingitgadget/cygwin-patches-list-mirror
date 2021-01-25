Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2109.outbound.protection.outlook.com [40.107.220.109])
 by sourceware.org (Postfix) with ESMTPS id 9556C3857C52
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 19:16:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9556C3857C52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs5dm4lVIX+6+T/wnhUXHjZn1gU7SJHNPUFQMcNLf8zalvn1sC2Zp9v9AduhnUpNF737gAa6VOqFW3fJxVmzRT0/VlZxZOA2/DPi21Tt7il8mMUPGrSlBdg/55gs3PqK3RXPnsSf5X3A8++oY6dSB9RWCYe2rNXpRtvADYqZH9aq2KZwvQ6Q1qH/yds89iHg7BW4Golm+ImVRaHnbEM+1cRrm5seQ383sQRqpwimHGbiCn4ZrIVpsPWMz0BEIlwBaw7uq1JmSUJ3nHYly8xNBdZlzve2CnAQ9d7b9T8WzGVe0yFZDdKoeATCyrA6hyhL95U7Yk+BUCvjiRmavM5kIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWaG+NjgaPrZD92W0o/MMK2fXzKzGAzgmSXOgMa1xNU=;
 b=VerfGyG1kHNXE08BmUH80b/zn/0oj7hBhfwItEp7TQXpfREEdVCtDLyEZw6NxAcP168mSU2OFK/48Mp422LyYkPh+1uxeYtBhlWselhPTZbG5cG+YBtQBaV8Y9FV4SI4wIg0G6IOy8zHwB7bAa4A0AKXlzH8rk6sQg/AmNJGzmFi2KBaMvRPow1Sug2BWx/eyVc+kYt7uxX1bo1TuThD/UxnO3WaMEn8prhT3hJFvpm3VKx+eKFvrAd9AdH1vu4zWuy3m6JNpS+Rja6DLe8BX7PQEuC/5e6KPcifD8fRyvMYeMi6RmvMyBawbHEBrCEonpeDnYGJ4dK10c3cE60Ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5714.namprd04.prod.outlook.com (2603:10b6:408:77::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 19:16:44 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 19:16:44 +0000
Subject: Re: [PATCH] Cygwin: chown: make sure ctime gets updated when necessary
To: cygwin-patches@cygwin.com
References: <20210125172455.64675-1-kbrown@cornell.edu>
 <20210125185730.GF4393@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <c40f388a-7afd-a672-06e3-4c92edf4060c@cornell.edu>
Date: Mon, 25 Jan 2021 14:16:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210125185730.GF4393@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN0PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:408:eb::22) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN0PR04CA0167.namprd04.prod.outlook.com (2603:10b6:408:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.14 via Frontend Transport; Mon, 25 Jan 2021 19:16:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0b6275f-5c15-4977-b224-08d8c165c0be
X-MS-TrafficTypeDiagnostic: BN8PR04MB5714:
X-Microsoft-Antispam-PRVS: <BN8PR04MB5714CF3D0ACC1823FB6BB0D1D8BD9@BN8PR04MB5714.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE6dCRNr6Ouq7ky+RkchVQE1JoHUr0eCwMILwLQJxWbfGLPs8rUd1vu9TFfrp+DXD1duacI3u6tHmuPQXnGoh0LOX45jVVcT0dRyAW5P/1IUNY27fIR9X0PrMub+fUA/oA2oWvEjdAM4aclMcPWTb9fPuCW3wAvHEr9EqJh59J09zcEb//dX63Qm8cW0drgvPSCgxRJWgXpIkHyCCqtU8XB16SGkEO0LHBPPZYYk8WvCjUCyB3zAXVVO+ewVg0EyUYR009fp0zk4NvJgK5vmbv7dqCkVGRzfLhtYEBhmYBPNOaviG1h616R806IgplMWgelyXGu1SN0gRrcSoWcOfoluZ3WiccVbjLIRzvylCL42Wh2Op8E9+R91w72YDz2hiHlOCqw5bceBdJp+LqDuUOqD4MCvH36sStJiJIazq5/CRlkscc9uKktXF9OsFJwuJpqWylvHDps31T12nTSUJjSLS1apW+1aUcMJu0hpSQ+Xq3TTgP2fShsZozXU0SxO0PIc9yJ70gqW6GnL+z54XZFTNC901lZi6Ae4AEXl7LgBbg8Z3S42fT1+KKErFk6YjmbDSF03nM5mPqcHzaNiZ5fOh4AIncEaAgw6lLguzvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(8936002)(66946007)(66556008)(66476007)(53546011)(36756003)(75432002)(8676002)(5660300002)(2906002)(15650500001)(83380400001)(6916009)(86362001)(31686004)(6486002)(478600001)(31696002)(786003)(316002)(16576012)(186003)(2616005)(16526019)(956004)(26005)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?IZy/N8Ob15OcYkcFn+qu2wi0MmewPd/Ol4nx4DNGq7dV2KIgOUHHNTzL?=
 =?Windows-1252?Q?kERnKtFCVs4zxYOQ0x2Sr+PPtUlwU5KbQgrwJg/3WaAFz/5Mnr5MAQfS?=
 =?Windows-1252?Q?h97UVqGaQLQz+OSpsHvBMXM5oiKUoa+uDadeMFi6gKPAHSghpXoR//Gb?=
 =?Windows-1252?Q?PSgYZJQ/M5G4iedkoz+uQ5f5L2VAzVH/K5U3t7XfGTHUUnXMg3RVwe5t?=
 =?Windows-1252?Q?THm1XQTEIqwjZQIr8wPcrMSRN4BFa6r56RzYsRJhbuTEP4ulshfCfovO?=
 =?Windows-1252?Q?fp/LS/acrT87nH6w3xsehxSwYMb71g3gTJADbCkI1xZf1SBYJ02plzOQ?=
 =?Windows-1252?Q?hSQ/5HT5AngWXYJtlRUAe7mqlRcbaYU5mTgRmlVzyhe90KzDLdUpAQ2s?=
 =?Windows-1252?Q?NDfs+oBzeR2PoyO3M0dGgW05E2AEuXvV0MFdA8+yvX9yKsg3g9SKeZyL?=
 =?Windows-1252?Q?9ZJnGfgDwVYeC/7w/f0Si0ub0CqJbmsdeq3hZQ9/PirqacxYRQpvzVOK?=
 =?Windows-1252?Q?GitO2rqsN9rpbfnVO/d/tWnQba/BGp3ITb2VOi1hJsuQC0tXDTBG3AO3?=
 =?Windows-1252?Q?cRAW01FCkD5GRxtbUdL7dkdmtgY+HAS/bA7yfzARt+M34xSC033+0KGC?=
 =?Windows-1252?Q?mtFjHCHpNjjuBSkmhfn8YebvFT+Nm1XcuT+3H4NFiHJCE23ZQyVPYBS/?=
 =?Windows-1252?Q?H//EEUGBmgu6BAOkM/vm3mwwuRzKS+cJjEAkDPpP1Ntyu4DG5l6dX08+?=
 =?Windows-1252?Q?ZbUr3hYfMCz5NXz8MbuF3JHWGZBQikOnGw2MF1+1RJTfSQETpceRMvGS?=
 =?Windows-1252?Q?s/dKxru/X8+ZcdICEOQm5S0KYV5KqPaMrZpUo2oev3/FjIG+sMSwIx5q?=
 =?Windows-1252?Q?xYtTQGDt984dHGrR1gwEeF+sK9nOLKY5pl9mg+KAfDrgdEr/xJApJ0ux?=
 =?Windows-1252?Q?++I2YQFfznm9SY04kcu+X8foRnKEKTMGlvXDk7HNl4q66g7XnhLlN8Fk?=
 =?Windows-1252?Q?lAYVcjefbqoO40mvE3BKJjNaqnEZLqd9q7KJkvOWwMLb793L3Pv+AnyY?=
 =?Windows-1252?Q?ZXqe9MGimKStCp/Sgsw493wX16D5Y+EG8iquctP6JVwTFugW6pNEBPVC?=
 =?Windows-1252?Q?vQABYz6Re9LbgCsC4bvB0ZEd?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b6275f-5c15-4977-b224-08d8c165c0be
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 19:16:44.7442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZg9QJL3g+6gXIg8eW9Y0pvb3Zf1Su778PXPcDShPCmWn4e5HiTr6kT+qMlP68lBDs9HmTHczOgXmW4PeVxRAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5714
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Mon, 25 Jan 2021 19:16:48 -0000

On 1/25/2021 1:57 PM, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 25 12:24, Ken Brown via Cygwin-patches wrote:
>> Following POSIX, ensure that ctime is updated if chown succeeds,
>> unless the new owner is specified as (uid_t)-1 and the new group is
>> specified as (gid_t)-1.  Previously, ctime was unchanged whenever the
>> owner and group were both unchanged.
>>
>> Aside from POSIX compliance, this fix makes gnulib report that chown
>> works on Cygwin.  This improves the efficiency of packages like GNU
>> tar that use gnulib's chown module.  Previously such packages would
>> use a gnulib replacement for chown on Cygwin.
>> ---
>>   winsup/cygwin/fhandler_disk_file.cc | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
>> index 07f9c513a..72d259579 100644
>> --- a/winsup/cygwin/fhandler_disk_file.cc
>> +++ b/winsup/cygwin/fhandler_disk_file.cc
>> @@ -863,6 +863,7 @@ fhandler_disk_file::fchown (uid_t uid, gid_t gid)
>>     tmp_pathbuf tp;
>>     aclent_t *aclp;
>>     int nentries;
>> +  bool noop = true;
>>   
>>     if (!pc.has_acls ())
>>       {
>> @@ -887,11 +888,18 @@ fhandler_disk_file::fchown (uid_t uid, gid_t gid)
>>   				    aclp, MAX_ACL_ENTRIES)) < 0)
>>       goto out;
>>   
>> +  /* According to POSIX, chown can be a no-op if uid is (uid_t)-1 and
>> +     gid is (gid_t)-1.  Otherwise, even if uid and gid are unchanged,
>> +     we must ensure that ctime is updated. */
>>     if (uid == ILLEGAL_UID)
>>       uid = old_uid;
>> +  else
>> +    noop = false;
>>     if (gid == ILLEGAL_GID)
>>       gid = old_gid;
>> -  if (uid == old_uid && gid == old_gid)
> 
> Basically ok, but why not just
> 
>       if (uid == ILLEGAL_UID && gid == ILLEGAL_GID)
> 
> instead of the noop var?

I went back and forth on that.  Following your suggestion, the code looks like this:

   if (uid == ILLEGAL_UID && gid == ILLEGAL_GID)
     {
       ret = 0;
       goto out;
     }
   if (uid == ILLEGAL_UID)
     uid = old_uid;
   if (gid == ILLEGAL_GID)
     gid = old_gid;

I was trying to avoid checking uid == ILLEGAL_UID and gid == ILLEGAL_GID twice. 
  But on second thought, it's probably silly to worry about that.  The code is 
cleaner without the noop variable.

Thanks.

Ken

Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2119.outbound.protection.outlook.com [40.107.93.119])
 by sourceware.org (Postfix) with ESMTPS id 170DF3861027
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 20:21:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 170DF3861027
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5jUpYJHIeFz1Sa2+UUjwXx0/HU5yk0IqiNNi1kNwq1hyIhxrmrxmhmjjnTp5yQ3F4Y/ZPopmwkBbos6qNSJoOD9WoNbiEYOPp7uBX11C3AwHt3jPwFbZ5gXhosfS64uzdLB/6E924LXGDp1vjx7HLE3qj2KembEehn1Lx6KDi+2Vh/23X4KIQc0+qQhjBjpNwN/3rGAA5xcdJ5wACS/vSrvcuip7/a3TMQ+ZHP3LB6eaNXn3uVh6cc2316wgbttoKV/AcBMGoi7jr63p2+U+x1Jdde3xqpglOnyzXKcewHtqbjqZvF0BSoA9qk4mW8X4pYVB6gPYWHKiWBOBAZtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7YcKp7I6gC9AhrBKJh1zGx58oOP+4l4SaThYmOrdlY=;
 b=ARQz+AGsOXnFOU5Fqpx//RYQuAS12l0w8KaazrfHDgtJvwgUx5AUMgiWtEJqpQWuEuKpjOIx5nTcTqYcxvbZd1dg6U4ulAA2G23yivKMP8b/n6Z1DOb2MMTpp6INYO9A7pxgdiwXstcPTFpZSX/eQJ0ynw1sYQcsezFJnNAoUPgX1foDw4ZwKQN8bwdEeAsPY7ZlPdCw6UzOC5x//1yPiC19a0/uPpKxB0fBhxgNawyYVQgr4jHMZyH/c0qzrzbtJ5aLH8P3d80c7qy9jKQ9A7HvYhRK0/K6Sdeu5z+im0hvznsgS9pux/oGy5DhMkOB0xorxVw/7cIZVmtTX5aV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5476.namprd04.prod.outlook.com (2603:10b6:408:58::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 20:21:23 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 20:21:23 +0000
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
To: cygwin-patches@cygwin.com
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
 <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
 <38792da7-75f7-231d-0de2-d483b927820a@SystematicSw.ab.ca>
 <YEX5FO0ISV06h9QY@calimero.vinschen.de>
 <b62c52a0-fee4-4cc4-bb57-e16169239d9a@SystematicSw.ab.ca>
 <87pn098s1j.fsf@Rainer.invalid>
 <70c973ec-f8c7-f5cc-1d38-f0306b8521c2@SystematicSw.ab.ca>
 <87lfax8nu3.fsf@Rainer.invalid>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <b81497ce-72d0-f11e-a381-568aa407b98a@cornell.edu>
Date: Mon, 8 Mar 2021 15:20:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <87lfax8nu3.fsf@Rainer.invalid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.194.34.31]
X-ClientProxiedBy: CH2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610::25)
 To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (24.194.34.31) by
 CH2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.16 via Frontend Transport; Mon, 8 Mar 2021 20:21:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4232277c-af25-4c7d-1613-08d8e26fbe60
X-MS-TrafficTypeDiagnostic: BN8PR04MB5476:
X-Microsoft-Antispam-PRVS: <BN8PR04MB5476302779173480AE2755D5D8939@BN8PR04MB5476.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tr10XvMGqmJvkvJ5m5Rb46hB/i7QmAn80j6m2WuzuuXEodxDYerdZsu6dKQaA1sbeSF4RRDsBET9NAAI5HiQxUkZYyWbKeWF7bf3GrvSYfzM6vlZqwDrApYYHYu6GiyExObZXD/fGLZISVv5KmxKPkDYuVmh3UJNR2nGKQbYNIMzQtXyhuzmeJp90ImzM4hL9JPvmnZLCVd48jVBmC2vW95m29uA2pGN4/n1JJvZ8fyzl54sHxxqYZ9MBXS/xdElFWfC8ig54IgzSy6GewWMfNQRNRQIWIQo/nRuv9SJjtE3YrqfAnAZVBGXTAx2gM9TdnxIWKXLNB8gmqOXajj6TFtZt8BNjdmGCH/hO4Km2OlN35bXYhCy/2md7UlkXOaPvmmVeqwAAMffqO+QjUXhe8Cov1EBbHxJ6ilfZi1EHqvVbHw7aCBPksWPMAUAVhL5blugSDmFU99Rmt6E6SAGOqUVHuJilZRaO97NO52DQPOalh+V5JF03UGefC7Ov45NHZVSn23ZNosRTXi+x7KXOLamI8m2tjSSQH3xFfQnIbmS7MHGlUYBf/J3vn0W7pGbY5wuKD+HLLipU44zhKAW6j9Y+udJX/5/y+tvkD1WCzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(478600001)(6916009)(5660300002)(53546011)(31696002)(52116002)(66476007)(66556008)(36756003)(66946007)(16576012)(6666004)(31686004)(26005)(6486002)(75432002)(86362001)(16526019)(186003)(956004)(8936002)(2616005)(8676002)(83380400001)(786003)(2906002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?POj7yvN6YejTjPAi37nWpIvBRS2XCb2CUlgBHMPyqFcVAu4aYA3FTYVg?=
 =?Windows-1252?Q?MZf3IWEVFsHL5su+pHHE39eW9qEwVJfKd2VJJVdut+X9k39ukMNswreq?=
 =?Windows-1252?Q?gEnAUkEozhBOexAgIcjStVI2HZ3ZazukVVnGVCxOLPtpoCgdD8Sbce3F?=
 =?Windows-1252?Q?ZQWZiI/gQxxwwCLIm8rFhr6Qgj743Evn9PZBVDLJTREZ0VISfvrkxGmh?=
 =?Windows-1252?Q?SCpCxoo0fmxyCGgP/Pizs61+Q9baUWcnSqkvBbc70YVzh3dmyH+/z4Qe?=
 =?Windows-1252?Q?CJmy0wGzMtn08LetvEqMHuhIMAIjRN89ewUP5olWFD+CtPkeismLT5rD?=
 =?Windows-1252?Q?aQGdNEZHuNK3WbJYuottsdFc8MCHudTKR6lU3dnZAeSSLkUERX5fnRnS?=
 =?Windows-1252?Q?guMi6PqY0p9c1uHxNwSFqZqXvwnTnlo06kqi4jYhUgqRyUeR9qJE4Mq8?=
 =?Windows-1252?Q?+9CGMJbNiDZmOxmINMoXXR52tP+EsuGUmJuM5ZhFY00+7AdaerZOrKKR?=
 =?Windows-1252?Q?ntrXG3A2G5HR/Gsbpu3ODl+uRUwaEOZ0Pn0C0esLVdrgR0kILEgfj1fm?=
 =?Windows-1252?Q?YnZ2UBNhGP6GGUMf8n9Jk3K4ZkMXJ7t05VLZpuWj5bA660akXm/NsTkm?=
 =?Windows-1252?Q?IZ9LrzXVWmrGoy4VH1HUigYS6fI/gGkMAlJpnSws1T5MXhespVOrLPvj?=
 =?Windows-1252?Q?V9BYtyPewFZCTWqAy/pX/Ikfp7UfBipwPI3wPIZtzm0MBqeT6M1OOurf?=
 =?Windows-1252?Q?p3s2AGxncJZ82pXwyv4vS41P4tQGGUk+4iynYrbCPtx8KS3qDx0axel7?=
 =?Windows-1252?Q?bZNJ2H2EyXGCYOrstSaJwrvY0qzLavkcgWZ4XcHAT+7a8S8fveNJPITH?=
 =?Windows-1252?Q?4hkaW1NJvcDlGujnsgBT3EESTSzKTh2APY53fRMDxn06W36LGaYfv7tT?=
 =?Windows-1252?Q?89jESXqQ7UOYUoCf2Yaeo80tz5v367mxxXgnvP+bfkYAUHey3PceGVpZ?=
 =?Windows-1252?Q?sLcJ4C0ijr8HaQMuiQI14qbs/2xNcTAQieFiW3A2tcLc8SjMh63v0jCB?=
 =?Windows-1252?Q?cdwLPDHaVQZGvGm8vG07/efblbOCuihIuFEtinMVQFX/sQWPiXQ3+fw3?=
 =?Windows-1252?Q?R6U0mLjyBOVFI9YMZWzDKsCXY6X/OvQPvD2EaOLm6kvQ7VoZMtGu2DYt?=
 =?Windows-1252?Q?dONOPjBBQAgZ1kftQf2X1dy1kI67Mn+buz1wDgBu2Uy9SqlOOl4aSSow?=
 =?Windows-1252?Q?WSVrHTSzQNhn91IdM2XNlalzxipYn47Kzj3X2FQEBIA58wAQ+dKSDKZB?=
 =?Windows-1252?Q?zvoh4mb68SvKGFgIXe6gdAryavF7PJBgfRUKSBPNY5scoh8EM90O+mjD?=
 =?Windows-1252?Q?4380EdNUVcCTdmPe21HKdVqTJ5Dv2uTuvesQfxScZ6BJP4WGZ0ZmvWWg?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4232277c-af25-4c7d-1613-08d8e26fbe60
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 20:21:23.7829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHvXT69AUmvwOrtEU0q/vyT1GtKAFqvsJZ54EiWlm9AghDUqGO5j21fFuyFDIYWllKjiBN4NNpmGiIF79sYclQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5476
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 08 Mar 2021 20:21:29 -0000

On 3/8/2021 2:09 PM, Achim Gratz wrote:
> Brian Inglis writes:
>> It's normally a merge conflict which will not be satisfied by regular
>> commands to restore the working files to upstream.
> 
> So you're pulling on an unclean work tree?  That's a no-no, either keep
> your changes on a separate branch (that you can rebase or merge later)
> or stash them away for the pull.
> 
> As Corinna said, if you're prepared to lose any local changes then
> 
> git reset --hard
> 
> will do that.  But you should be sure you really didn't want any of your
> unfinished business around any more.

If the unfinished business consists of local commits that haven't yet been 
applied upstream, then I typically do the following:

git fetch  # Find out if upstream has changed since my last pull.  If so...
git format-patch -n  # save n local commits
git reset --hard origin/master
git am 00*  # reapply my local commits

This assumes I've been too lazy to work on a separate branch, which is often the 
case for small changes.

Ken

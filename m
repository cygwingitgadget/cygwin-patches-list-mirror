Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2136.outbound.protection.outlook.com [40.107.236.136])
 by sourceware.org (Postfix) with ESMTPS id C11B53851C04
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 19:04:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C11B53851C04
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNyvYuggE4LIKKAAF0AMBL6VBFlQnzejwIVWYDqBP94ibvFCPUUOCyWmho5qHSHKd2dsJ88ukQ/BZm+BCIoxKIytWEJTvxJH027TbtrhYyWTMoxydjJHnb+y8iUHHRKC/ytRBwn38bLeiNST56zv7/+auEbm1EqD13tw5shEXsWIFl6OnMNaD9wFSf9jDrEJuO6ZmoInjTpn9Xg9eh9t52EC4Gz1bz7BydybsWBuXx5Cnsrx0ycbV9/nmXylsZR358JoTpLsyc+Mj0d4vavPtJ7rogOyvDuFViRFx1NQ6Ltv7+4gYRlV+uSw34fHoU/aLAZsocl8tk77aQ+yDVLPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m2eTbnamcczjYa0cApGQfveq7+fkFRlRl3A40VOHNc=;
 b=ZrzR+rSI33SFB5/a7K0H/s48xqslF1bIp4gph+VAVYmZOfmIWviZO7D3I2iNT3gMWzcm/bijcbqX2tfFqnenABg8fANcSfniIEoFtQjTfZKgLz975Z77QBGy5aTAdRKFsqxHUOH0LWafSJByrX7rM/dndyA5nHXNl5Pdt73kYnjIIYOanS+Vs/WuH7aJYi5A2u+Udbetcy4S5zaPmWBGaVvw6LEU0vUYKKK1zF0MujFneVJkfeDtBU3uIaaJDKzkaHT8YqnHcmaPXuIqL6N4x55ueWx0YI/IvJvZ2pN4IkqxyUGxbePJchve1gSj08BZQ0/02hEUfBmH3TKoLDXXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB5658.namprd04.prod.outlook.com (2603:10b6:5:168::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 19:04:28 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 19:04:28 +0000
Subject: Re: [PATCH] Cygwin: pty: Make system_printf() work after closing pty
 slave.
To: cygwin-patches@cygwin.com
References: <20200519113600.467-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <c6a10e57-9492-adf1-6773-1d731512ce20@cornell.edu>
Date: Tue, 19 May 2020 15:04:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200519113600.467-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0038.namprd18.prod.outlook.com
 (2603:10b6:610:55::18) To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 CH2PR18CA0038.namprd18.prod.outlook.com (2603:10b6:610:55::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26 via Frontend Transport; Tue, 19 May 2020 19:04:27 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2714ac5f-2ebf-4b1c-aad4-08d7fc277416
X-MS-TrafficTypeDiagnostic: DM6PR04MB5658:
X-Microsoft-Antispam-PRVS: <DM6PR04MB5658223F45F92E0665AF9C4DD8B90@DM6PR04MB5658.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzQa6SGDpiNbhmYBhaxuOKEAUcaMDSu5TXksDCeXvIJjTxiY00lGaqhcHGnjPErfPlaq7hSaXAGyCF8YoB3kfIRSJu0fd6xh2cuymnTAT3zYL8F2LxcVv+cBWDDbovvtA44HHJMEQugz8l85Ge2LAHiprNitOO9yCgpZBl+rLlt25kGJDPlOpdwWh8iCMq/dMUFz9sYpupQEvb9rztHwXyvf47sP95V1M4rHAosdFBnpO0ENwf6awLnkQ5AT9HVpEYVHcZbGESUPuEP3sCVT8OU1n8RSbfpMx+h26upZZCTLBQgUzVcSYjmFLtsC6GKraWUk0V6XqfO9pvazOoqIZAIHtwgO9j517Bu+XIJIT/7rtztEZ8aSCq1U8VoWAZxzS60jysDrNJF8wXNPBihxIwDKaxDPQLzn3A8Vn8lxDD2aZVgxN7EUD7BkDRhc0+9x5vxADzZKxoIo9tlLyGmXSu94efFdATB7iPe3TwPn7DUtqPQY82DR3+4YZmelUbRhBifS4YGHHT4Ucdd4aLNmJIV7+j3dQ7xpjy8kkRyn5Xr7bkWHJgsQ1yn0VG7esQy70fJOTwe8OHOF1+uo+pJk0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(26005)(2616005)(16526019)(5660300002)(8936002)(36756003)(6486002)(786003)(966005)(66946007)(316002)(66476007)(66556008)(86362001)(31696002)(186003)(16576012)(478600001)(53546011)(956004)(6666004)(8676002)(75432002)(31686004)(6916009)(2906002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wmrFzbdFLx3jlk42Is7LOwSN3sskB7aIEoO2C8A8aNO2oIuhOevcofibiT2W1cR6VD8XLtAdanEm0Hz6whrC3dDszMId4N4+xthV3tBgn4GXlKUzba1DIjb/aLOOMSlZImA20MfUcaZZww++RJM2zNugf0yT20AABSZtMQybmw3xhuoCuykN4ezAFgc3uNLPNpNCVnYQpAwWhec6iyAAorftFmvLSQHYRgCjOkVKWBbkCK6/84QaX0zlQBbL+5OnPCUWJkfFUHvodgYILi+krVJfEsqnAqY0ZVRKby2GNHYVUu6jNR7f7qWUF2PUSb4/Rppv1CxCO4YokkVp5T3FgrId2v08Uc3KDvyMZSmUensRDwg33del4TjfOG2SGC0fywEUvL0DW7NdleXqKMOhuSoLaL9IBF8aVv0CU918r7I2DFvGkblgP4jwqMGSIx1y5PJo/PKTPqjZkB1j50ph5wcu7Kp5ybYeppDegm8GlZs=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2714ac5f-2ebf-4b1c-aad4-08d7fc277416
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 19:04:27.9620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uqbn5It8twrp3ymVV1lNiiaAEJn15gTyDREq69S0mBkxMtZQAjK5h0Hc0p/6QDdghb6PJpwb/sDUHKjbZrQGmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5658
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 May 2020 19:04:31 -0000

Hi Takashi,

On 5/19/2020 7:35 AM, Takashi Yano via Cygwin-patches wrote:
> - Current pty cannot show system_printf() output after closing pty
>    slave. This patch fixes the issue.

Sorry to be returning the favor so soon, but this patch causes 'make check' in 
the texinfo source tree to hang.  I don't have time at the moment to try to 
produce a simple test case, so here's a complicated way to reproduce the problem:

1. Clone the texinfo git repo:

   $ git clone https://git.savannah.gnu.org/git/texinfo.git

2. Build texinfo:

   $ cd texinfo
   $ ./autogen.sh && ./configure # Maybe CFLAGS='-g -O0' for debugging
   $ make

3. Test the standalone info reader:

   $ cd info
   $ make check

It hangs while running the test t/malformed-split.sh, leaving a ginfo process 
and a pseudotty process running, with ginfo trying to close a pty slave.

Note that this test uses both ptys and fifos, so there's always a chance that 
this is another fifo bug.  But reverting your patch fixes the problem, so I 
think it's probably a pty bug.

Ken

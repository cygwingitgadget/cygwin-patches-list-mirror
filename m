Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::719])
 by sourceware.org (Postfix) with ESMTPS id C69F13858D35
 for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021 22:22:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C69F13858D35
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTUc0TbSlnLG5bt8yOH2w8mCPLUhUz/pyK1tk9tqhoGy0jMTJaafRbzsi5drdZ+6OCw5CLxfkL8Q2bnplsdAvIqI4jrpRgksSTZHIx14WF3rO6ELKqaQIJuR4/4KnkhoEfU+adOWWYaxYMrXjFFpYQes1lnlcDLub2OoPVI//SCv3p9fkrPrNg1JQhRG1V5TdxHIASjBgeio0otosxvLnWewq70Rq0xgQ4O9ahTDtZZjjKmI/yHgBtZ/LU6XnOk2ANOK+wqEsInVoHXXbJSs8is23ZTUluUliJ6P/TAUinlVWXEyt3OELhHOBjeXg67aFirpNxoIaS/v0Y4YnL7A2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRTwsDRKeLPg/KjUZKo2ucUnfQx3HncEFIh8U+AfjvM=;
 b=PeFOBK27Urbp6p0uxrL0ieXbjLdJZRjCl3nPvpVi2vqir8oW7JW9L01GNnrhKTs+a5eg3VuM0lk07pW5kqOY7aB9gJ8GT0lnyTVdFBVLHfhzm//K0ktVn/jfK4JjxGl8L5G1HBkyyEbx/HFCb6L5flL/qJirZtiK8j3AVCuqPSqWxghvuauiq16aTysoKymVnq92S7VGlt3PhJWL5KneVcsgJ1/YNNXTVUwI5GNgrW+/GGvPfB1mNyj6v0yhP9mZM3kZhnpW48aWUpThAIwZFyKg/O9m1Oq2YT+dcW0hz17fZY1G4eEMx1EsCGZ2D0drLFNsmnB0uaZ1tmiWBsmBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRTwsDRKeLPg/KjUZKo2ucUnfQx3HncEFIh8U+AfjvM=;
 b=SJQjJ/UFADYKDHgWSPFcY3a04NB9MLkYS3RsarKYw/dYrJDGLDQnqp7OwPzzErgLxo7WdODhPEXCDlbLv5i3Hx5SKKyi60goOzP3k81tyzkc/Npzoygf+qZKcjeWMmvq4wBBer38J2Wel+buA1wbEbTnroUbjOt3eOepMOq9Byw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6385.namprd04.prod.outlook.com (2603:10b6:408:d6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Wed, 10 Nov
 2021 22:22:08 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 22:22:08 +0000
Message-ID: <f6a4f67f-1db4-4e53-7907-c7a7dcfbde79@cornell.edu>
Date: Wed, 10 Nov 2021 17:22:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] Fix a bad case of absolute path handling
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0035.prod.exchangelabs.com (2603:10b6:208:10c::48)
 To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
Received: from [IPV6:2603:7081:7e3f:3419:7428:1d03:8434:f8fd]
 (2603:7081:7e3f:3419:7428:1d03:8434:f8fd) by
 MN2PR01CA0035.prod.exchangelabs.com (2603:10b6:208:10c::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16 via Frontend Transport; Wed, 10 Nov 2021 22:22:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54e2904f-ccc9-48a1-ebd1-08d9a4988849
X-MS-TrafficTypeDiagnostic: BN8PR04MB6385:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6385D34060A057AF45454445D8939@BN8PR04MB6385.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1R+VIyd8wyDudPkNYVLDE2haVvJFcooaLBPfmKEmOyAUEWXdWxSUQGSWUS7Z99Im35Py626cT0EpQk0kmKgn3zDLzHOfhfVvg9ahssmX8bZVSUCcWrPpqssAXu1s9gsnOy5aVdJywKFZKKU5zeTEz7Hyv8Ax0L2KMk/UlnctiS5bnQPae+zbIaby40mhcK3d7/Nodq4wkVL+xJNaCFg4sdhSBMSoAq+gmiQBpsH5BS3ThOzBdinLLcBtAYDljfptLpGAcsmGzipgFiw5wzCs1m3wVOkmjxtmyF8fhhWAYop/nkRLifO95Q0uut/l7MlBIkKtX8RS6haIHdnXPuK74WTpVy4o+HKGBGjQFndZ6cJmXCz3wvRa5OTZRxYvmRiCx8zpI4urLtmkt9+LbmNc5+dqVcQjYxNJtEzP1zU+uzArDOxQ7Bg+BubGnHkelaVkWDglcS4VZAf6wSJLLX+1DRtXAEl8KrvngNk43GAjFx9/PQI+5wOn+KgYguP3Dp4309f3zL3coXLO+YzqNOwVwLQoTBoYeAFlHGiEH8pEcyxex/xyAahghUnz1K0EuLUU8ZrerJhnW7QpFJY5Z90S0nJGdThdqjxBFFYeOghW2zlpgkCB3wz250oJhkvfHSim/gWfuw/krjzN8/xB1PMzuqTyfbs8u4MzqwhKcQVYdbMso/EAPLo1p3ueM0aYTzZzJm2K6D4ERIHTniPsDAQUuM5tPbQRk2Vd817YXP2jTjy9h8Z63zb8E+N9Eb718mruQxElSt9f4jvqAGbZVNCEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(75432002)(36756003)(6486002)(2906002)(508600001)(83380400001)(186003)(786003)(316002)(31696002)(86362001)(6916009)(8936002)(5660300002)(66556008)(38100700002)(66476007)(2616005)(53546011)(66946007)(31686004)(966005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzExVSt1TFJ6LzRhVWd6UmFnZHpvVStPTlNWb2dPZ251ZXgrcFNXV3lQY3Zj?=
 =?utf-8?B?MjhJY01pMzRhZ211QnlwZmsyRXRZUmNWZko5WVR4ZlEydDk0bHFvankzdVZ6?=
 =?utf-8?B?M0FhazU5UkVCQkFvZGdjaE0yeXRWSUJyVmN3ZUtEcWNHR2NLWitqOVZpeThq?=
 =?utf-8?B?eWtGRHl1QjhZZC9mMG9pamdYQ3R4YmcxU1gyb2F0b0I0K1o2alMrVFFDWHZm?=
 =?utf-8?B?VXlwVlU4REJuYWZTaGZMc01EZmRIb1FCM3g0QVZnaVY2QTJ4Mlg4Q3o2cXFl?=
 =?utf-8?B?QWxHU0RJYWU2SDlHbHEwbUtCVUdFeC8zVmdhMGZ5SjZIaFhiZUFFQUpzb01i?=
 =?utf-8?B?YWdQZnNEbCs0VG90QURaMkRzaFA1TTZlak9yQVlaMEN1cEdtbWF2T2dwbWxL?=
 =?utf-8?B?Yi9FQWdraG9Ddi96ZzFyaXprc2tzZFBpVnFTeU1DZlZBWUdBc3FpSVBqeG10?=
 =?utf-8?B?d0tBdjgxUnNpdkJ3WVJ4SXBGWm1IU0VPemh1NG5ZbDlBeGpZb2JrZFpGVE80?=
 =?utf-8?B?TXNWTy9OcUc1OFZEWFRXNDlTck5sVlBkSS93S1NKZFcrc1RqbDlTRTZnOGJk?=
 =?utf-8?B?ZVB4K0dYQlJFU2JBTmw2cXl3ZW91aUwza21LcXBReEU3aXNSd1QrY1NwNGlB?=
 =?utf-8?B?SHdsbDRnNnV2dDhGYStxZmlCcW90WWJHS2g0MGVCNGlITGFTazBhYjgvaGpt?=
 =?utf-8?B?ZkcrbkV0UWpLQ0JvRVFjR1p0cXJrTERJSU5UZWxrbUtFbXNSNkgxeHVBcXMw?=
 =?utf-8?B?MGZsOGNPL0V1SGlaaXRwMVdjcU5CTHpRL2xudXFISlRxN3FlSnFTMk4rNTlz?=
 =?utf-8?B?aFB0S21qdDVTY2xQNGFhWE00TjBTQm92Mnl1Wm5tbk54aGROWUhPZmQzWUtC?=
 =?utf-8?B?anhibHlNYWpyWTFZOXpUdTVXd0NEc3V4R1ZwKzZkdWpqZjhxL1VNVUphM0Fp?=
 =?utf-8?B?Q1FXbUU1MVZZQ3Z3bEJvNEtwVmFFaTN4T3JyOUhtb1R3VG82M0Z0bWFFd1Qw?=
 =?utf-8?B?UVprend1UlhzbGs5ZlVLakcrM3dCTWNqbmQ4bHlidWVRNDBFNno2NUp5M21z?=
 =?utf-8?B?d3JER1JEVytJUGVhQWxTOGM3a0l6NFhaV3dNY3ZRR2hCTzFNbzFONEtXK2dL?=
 =?utf-8?B?L2FwbmN5Znl3bS82Y1BjVlZFenJHSE03cFlqdkNOOVZPSGxlVGhtWEhoTWNQ?=
 =?utf-8?B?Z3NxRUdkWFcyUUtrd0FCL0tZZWJva3Judzh5Y083bGZiM0RuR3M2MFZQTFJO?=
 =?utf-8?B?c1VEWXY4WW4wVDdNL2JjU1huenRNWTRkQWJkUGhZL0hJaStnWmF4YVZZZzZO?=
 =?utf-8?B?QjVaWmdlWFZhQmlyNkh2R2VZN3lQc0xiYjhrdG5VZHByaDR0akZvWHZHckJa?=
 =?utf-8?B?bitZS1cyejZhRk85TUZYWWNBanpYT2p6YnlXWWxEekhGQzlWZXc4OW9RamZQ?=
 =?utf-8?B?NllLbVJPZ2hrZGRYa0Z6UGFoeXpCTGFoYmFSdnZQRzhoSWFrc3VCM1NZWFRj?=
 =?utf-8?B?aWcwSnFWNFZueEZOQTd4eTVhazR3SEVoOStPUDQxRmV4S01DZWowYXJjL1NX?=
 =?utf-8?B?TnhiL01CNk5EbnZLL2U1S0FxazFOSDlJY2p1bjhrSFRKUXphZFdvMjk4c1hr?=
 =?utf-8?B?aDBrbW1nelJkVk1vNC9pRkxxcVVOZndxdEU1V21sVW4xN2lDV254VC82eHRU?=
 =?utf-8?B?N25lMmJEa3RUQkN2U0NJU2d5YUcxVXd1dzZMTkZ4VTNRWEo4ZG5WcEYrVDJK?=
 =?utf-8?B?TDUzYjdLVHZyaHJJU3lJQjRPNFREMysyQ1haZ1AwbHR3SXBuS1BKQ0tza0Qv?=
 =?utf-8?B?cTlYMmhxRjVkcW5QZGpGVlNncDBZTC9EYnVYTXdzS3FvNUcwVjR2UndjMTBM?=
 =?utf-8?B?ZWtqdDlkQzZsQWZPanpFVW9kdVI4aFFseDVVbitoYTFwM0kwUE0xUFdRS0NY?=
 =?utf-8?B?RFdWSElZblFVdGVzdGpqMDJEdlVQYmg5Y2xUbi8wdnI5YzZJK05VV3NHNU05?=
 =?utf-8?B?aW95TTZpbmZwTEN6OE5pVFY0KzRnTHYyZGdjTDZ5dk5RSTF6SFBQS3Z3ajJs?=
 =?utf-8?B?VVRhV0JJVDR4aGlPK1dpb3o3aGJXanBLTUNHb3RhMDc0WWxGTVZnMTNXamRI?=
 =?utf-8?B?N2lGMXJBQXAzZ2txUGRGR0tKYyttK0xkYTArelB2d1pHY0xmYVRzUzZzSmxY?=
 =?utf-8?B?eHBDKzFHVzQvZXNOWHQ0RnpXTkd3UTRrTTMxZmg4cHhBWlU1ZEh6ZTduWWNh?=
 =?utf-8?Q?1y74aCby76xbNjywxM4fvuETCQSbgsV7roAR+5YFRU=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e2904f-ccc9-48a1-ebd1-08d9a4988849
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 22:22:07.9415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fQnoOQHSClbhUtcbj4BGppdEjWxIoAa129Of0fUkEopuab8A5Sn/2EjRLPXLoLVZWXNNqhG7RDgN4vTq9STPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6385
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 10 Nov 2021 22:22:13 -0000

On 11/10/2021 3:32 PM, corinna-cygwin@cygwin.com wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> As I told Takashi in PM, I will try to more often send patches to the
> cygwin-patches ML before pushing them, so there's a chance to chime in.

LGTM.

> This patch series is supposed to address the `rm -rf' problem reported
> in https://cygwin.com/pipermail/cygwin/2021-November/249837.html
> 
> It was always frustrating, having to allow DOS drive letter paths for
> backward compatibility.  This here is another case of ambiguity,
> triggered by the `isabspath' macro handling "X:" as absolute path, even
> without the trailing slash or backslash.
> 
> Check out the 2nd patch for a more detailed description.
> 
> While at it, I wonder if we might have a chance to fix these ambiguities
> in a better way.  For instance, consider this:
> 
>    $ mkdir -p test/c:
>    $ cd test
> 
> As non-admin:
> 
>    $ touch c:/foo
>    touch: cannot touch 'c:/foo': Permission denied
> 
> As admin, even worse:
> 
>    $ touch c:/foo
>    $ ls /cygdrive/c/foo
>    foo
> 
> As long as we support DOS paths as input, I have a hard time to see how
> to fix this, but maybe we can at least minimize the ambiguity somehow.

I can't immediately think of anything.  But is it really impossible to phase out 
DOS path support over a period of time?  We could start with a HEADS-UP, asking 
for comments, then a deprecation announcement, then something like the old 
dosfilewarning option, then a more forceful warning that can't be turned off, 
and finally removal of support.  This could be done over a period of several 
years (not sure how many).

We could also put lines like

   # C:/ on /c type ntfs (binary,posix=0)

into the default /etc/fstab.

Ken

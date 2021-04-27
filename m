Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2127.outbound.protection.outlook.com [40.107.94.127])
 by sourceware.org (Postfix) with ESMTPS id 7A5B23894417
 for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021 17:00:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7A5B23894417
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=kbrown@cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1Hcukt47djJXrrFMylaigTZj03SIPPmQObXvu/L9rAQg3JyWqlI3+mBn9CP/UqiYAJT9jbV/qtPg79oBqnhq5dVaEgdW/lZ6+AtHm4nvA5bsVr+wsbAYeVQvU0df79GwaWig6YgiicukV32g4QyO1jMUuRBumDOHWqHulSGkYcVs+eFQ2MYmaYmVgx5I3/Ecf8wFiFdEF5h3473x7X+e47bFED1XkuOFaMrOOSGaWm86H8CUhH9xNP5s+p9zPcz1gdSYWeP48viKg4JHbWaxeK+NLiqgKnS791MwI8cYHpdZKiFKBawOY4kR2Gcf1hXjyNxO5CbqZT1sHT7pWGF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHtKL3eDkZUTxE858pr0rr/jxXEhsDGZWicj/B/u2YY=;
 b=odk8VnPSagH4OpGBBP1sWMKiG8obBX7aKfUzo6zTeqajTKoZpS3v3pMdqMjlzh00CZQTV3iBFWzfbMIuWVwl4ZFzfKM7bw8g1dmNIu9hjtpVh4rNjcaxj9Xa2xTenOSDQWQ8abUXP4ocKKDuKAK7y09Cz+zgYM0VQ64U4Nc/ELAZqB+jdkTosDWJ+eTelV3HJHIepDD9ZyPqsd5JOx0sOD9lJSbk/v+lhrVOqOo+CdH6Fp4G+VVIy0pNob+Z0GgluvCzEs0NnG56e7LuLJCERCXmM0TvRbhxljD+jMDtFVEgeGjlAKD0xUcpEU0/rOVRjXsfWTxZsV62QT6FOKlq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHtKL3eDkZUTxE858pr0rr/jxXEhsDGZWicj/B/u2YY=;
 b=RR2wa4K1x0FqdDlbys2EpaTn+/X1jQeIE1Y6CLV9IuJByocB6+r3j+4+abcORh6AqVe80SpWv66uJ2AzDYm9LBG29YgSeABpV4/ubLV1+GI5HAKOyjFh+2w3dEnRrDVSgIguFJ95n7yU486MxgCMILc+MVp/EJ1phjbJyI9W51Q=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN3PR04MB2323.namprd04.prod.outlook.com (2a01:111:e400:7bb6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 17:00:30 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89%4]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 17:00:30 +0000
Subject: Re: [PATCH] Use automake (v5)
To: cygwin-patches@cygwin.com
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <74ea8f75-8bbb-8a58-66d3-cf6ae68db2c3@dronecode.org.uk>
 <dd2be414-edd1-5502-050a-ecaaa5920db5@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <62ca4187-f798-38b3-f5dd-b3844b99fcf5@cornell.edu>
Date: Tue, 27 Apr 2021 13:00:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <dd2be414-edd1-5502-050a-ecaaa5920db5@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BL1PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::15) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.8] (65.112.130.200) by
 BL1PR13CA0160.namprd13.prod.outlook.com (2603:10b6:208:2bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend
 Transport; Tue, 27 Apr 2021 17:00:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3f8eae0-1deb-4c6e-0c29-08d9099df6cc
X-MS-TrafficTypeDiagnostic: BN3PR04MB2323:
X-Microsoft-Antispam-PRVS: <BN3PR04MB232360CA1A5ECF0835641A4AD8419@BN3PR04MB2323.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6kLPitWxEIq/KtvwN4dSsq9kK5VFN1oZ49ZSaeHLZ5bcITDZX1tOKJWPOPWQs3I4ATfPvXR09gFyB2UKMPgsuW6//NeOtU43x5W9zSXtMoHPY7KrOUS/+dPwdsP3aJ68tL91/9/vwXdX1enSV3XFcAjtwuM4hqARjMDpQoScdasr+CB9U5+8jK4ruIr0dl6CUyUxXqDcBY9qnTOe5PlW056A5f00LJLZWRyX1qR+WI/daRr5RbxzETMCWgn0Br9VUM93dyJrcBa7Nm69qSSTa9Z7kJ47MqZ4et3CwNWBjPOH5Mim9lDG73I62EctFGwnOGJYyeHN8ttNbJ2+2M3QQxEMEpYJhjl+4TfRZ9BnBNy+L/nqgqNZBnrpDtzPkj6w1Te4UYiA14ZuXQ1GQxbhW0ltPxhD3nqmxTTmhE3mgLlvpAj6vfLJKVjAhlXMFYp56N9uREPCG+oAwl4fb0zrkFfD5TGRamvMoYx9RAbl8rKV3JPbeqlehkNB34XGxVD9Xx5pahUarpqQkzSpjZ/HmhmEMsbT/B1C9ko5JDYmcaGwaMmKeLkrtsnZ0egNpGGqyOFQ4SUn3LYwPodzbPnJZfTLB+y+XTAaUH9/fFG5kaHtLcNdVaTK/GrqvzXTLaB6zKb3f2XDUtQNGb92Uhkq3VyAFO1rBGSiMhL+AY2mrWFiilRImshLlgyrKt0x6zPeyswtpvkPYZ3vmpeyYMeiY+ECD+ZtX9xArSu8xv7ZLqemSxegLnlc2z7VNXoK/JK+5qyRHu+2s/P5PbzXRS8EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(26005)(38350700002)(186003)(66946007)(316002)(16526019)(38100700002)(83380400001)(956004)(31696002)(6486002)(5660300002)(66556008)(4744005)(75432002)(36756003)(478600001)(86362001)(52116002)(53546011)(16576012)(6916009)(2906002)(8936002)(31686004)(8676002)(2616005)(786003)(66476007)(45980500001)(43740500002)(460985005)(2480315003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?i53a62F94cMuVZe48Xc0c1U/i8PtVppkvQHY96ALW4naHBskfNcpO4Rp?=
 =?Windows-1252?Q?t0eAEaLTIfq95vc/OId4Z+II64k3R/uoy5BntijeIYsgc2Be8Jc1tWQx?=
 =?Windows-1252?Q?TND8lrXvncBQAAB3/y4/GlpN3pvblYumABuB0bQlcyFK2Dy0kCo0v60a?=
 =?Windows-1252?Q?AMiDAaK4eVZhzBbBN3h4ra4D5uGeCUhMdo90WKaWtmROEsm7ZpJXUuhx?=
 =?Windows-1252?Q?oN/jGgeHQ1WYqcuv1utsbt8kfM/c11OvLYbmDjT2gU5nlbqhOUOAhYAJ?=
 =?Windows-1252?Q?HYQBee8IB6JrY2Iapfd2b/ExdWWAKrrmvp1RMkO0Z6cMZU0EakS4XtXl?=
 =?Windows-1252?Q?A+YS+yHsfw46Lfau1UHd2Pw1VxsmcilnEM2zrcZ0OxqQWAIMtSTavQ6c?=
 =?Windows-1252?Q?8f+Aw+FcZUZISbClAYfyNXValE4kDmvMEdkgaL43lDeNDS/IjnRFeC8P?=
 =?Windows-1252?Q?2JJVJUf2gOVklm62ISMMlBWobxk9G2nYYDmOB4O0yG5q60gTr0HEAlpz?=
 =?Windows-1252?Q?bJDp5IllxM3P3NH9bYl1u0FlRCBtqxwKsqRWMKP99bXtSoQMjpPWugdY?=
 =?Windows-1252?Q?RC4LygydOe0utFKm8Ml6HdUpkttXSmC3Fnpz1kTmyYW9vTIlQmRrzHCF?=
 =?Windows-1252?Q?gA2/Dr6h69f0vs14nuaAtoYEYiVxjsAKLhBOMqENoaOC+JxXAFCMihr1?=
 =?Windows-1252?Q?cqR2Q/423LyZBQMElgURzv/nLV5oWO/hs1jmd3ADL2/o7WhLLSCsYkGX?=
 =?Windows-1252?Q?CFM2PXrWYAcZrWR0LZ2weC4rMZJAdCeL/BCP/pWZYf7ORE+VFcizLg+2?=
 =?Windows-1252?Q?esgaU57Y4afac4a9LjYZCDoDGF8INUkzh2zbnvMss66g6b7w/OE7uYZR?=
 =?Windows-1252?Q?2vWkFIn5qMaIC4tOHpaLk2q3HOK51k9PVHK/eZC2jmduvePCvIqXIT2d?=
 =?Windows-1252?Q?vqpLzsqytA9ng/8rNYbwC8ApzJAaL03hmkc+LYGhodmpVJmFdG/fEcbN?=
 =?Windows-1252?Q?qDWoUME5vLsOWkkfJgpOtfxEpM35+HKWrz1ft5hIiHLn4ry+9VBFvwq1?=
 =?Windows-1252?Q?v1jPQ1hzB8F2/sxncfZ4nYZ6B4YQHPXSzrl/0nLu4DWDgLkGvRttpUk+?=
 =?Windows-1252?Q?LSEmYTP3ohf2g6sqAeZxkWQ7TJtc3/DxMUffyLgnkzut88BwIXRMejMU?=
 =?Windows-1252?Q?jyGQux3KTsIdBG3KBAAAqY3dUcEw8SybgucGvJVLD6uZLn13X2En9/nK?=
 =?Windows-1252?Q?bzjtBqULXLH+2RkieDnpewCcyR7EL1Y6Dm2RkzufSAGs2rcA+JiNmVf+?=
 =?Windows-1252?Q?r4012tyxAQGEXmjtv87evolQ8KHz3UL3H+QnCoUW9+a5HzUxWYl9+5kB?=
 =?Windows-1252?Q?/s5Z4Kvp83jEXwhFwvF3Gsgy+8Xm9GSmPwFCho1U/pCP8DMbDlc3HpEU?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f8eae0-1deb-4c6e-0c29-08d9099df6cc
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 17:00:30.6108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP16Qd+CMQehCB/DXMGFr65bUvwQnRWdlUVAOjnNE7tvkx9gbHTXXaKPnYOg4Jp5h+BaYd7P9I69IMwgJjJy6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2323
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00, DKIM_INVALID,
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
X-List-Received-Date: Tue, 27 Apr 2021 17:00:35 -0000

On 4/27/2021 12:52 PM, Ken Brown wrote:
> On 4/27/2021 11:50 AM, Jon Turney wrote:
>> On 20/04/2021 21:13, Jon Turney wrote:
>>> For ease of reviewing, this patch doesn't contain changes to generated
>>> files which would be made by running ./autogen.sh.
>>   I pushed this patch.
>>
>> If you have an existing build directory, while you might get away with 
>> invoking 'make' at the top-level, I would recommend blowing it away and 
>> configuring again.
> 
> I'm confused about how the generated files are going to get regenerated when 
> necessary.  I see calls to autogen (which I guess is /usr/bin/autogen.exe from 
> the autogen package) in the Makefiles, but I don't see any calls to autogen.sh. 
> Is the latter no longer needed?

Oh, never mind.  The Makefiles just call autoconf, etc., as needed.

Ken

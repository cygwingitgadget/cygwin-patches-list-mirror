Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2102.outbound.protection.outlook.com [40.107.237.102])
 by sourceware.org (Postfix) with ESMTPS id 9050C383F850
 for <cygwin-patches@cygwin.com>; Wed, 13 Jan 2021 13:15:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9050C383F850
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS9hSTFUX39YHdhdSJMQURYGFqxPSDNZdp/2H2PzwChsUn2YgC4HWBh9zrpgDibbhgyP+9L/1bgpE6d545r3DEVj3PPYFjDc2pWP8ADktPvJrGFJQzEQQDKHXJ3k9zR0aAu3w4kTUrvcaWFbUsprA0gkwCbilCeJ+tIJ8T6GeELn9V7/Uq6paV50Nluq5VmEfsrrdfQwfUXZSGqRA+HeS8zWTzZ17uLchobgR39dQRrvZr9TZoEN6ukfXecTs41zMBQmp2DTnXY0DoFTEyVBAeDqR9aX86juT2ngwL16ofYwWUgkeiY40BBicIKKzUOGycOxOvFUA2rkEAKvkewqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smm5/96I+gJPzhoAw7MHK91scUrruN0z9Hx8AFwegvg=;
 b=QnLocKsmVpNtPv6V6md0+Yphcj38KOGK5V+jEu1iFOWs0N+k9bQFVaE4Pt8OK20VG0AzEiuhNkKBGnGPmB06sxw8mQsyhS5Hbc2P44hD12bItRcMID57joWleIprfXywfW9GY35yskyJAIVWZO0CUeFMR48oc9O6Q/JxYMSfFasO8Jfmn8jLLt8eRZUta9KsP0aQe/8KJ5moQlOsOjQi0iLlH+0SoEAZGDJs+BM5weSZX5F9/8RZyusKg8VDaaZaUJdiA1p78jXc0b2D6rwl2EL028oMlq8odjHzmTzMhkGv4/r6MPczGlXoqTU1rlja85SKf+C/MDNDChQnvgmpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5620.namprd04.prod.outlook.com (2603:10b6:408:a4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 13:15:32 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 13:15:32 +0000
Subject: Re: [PATCH] Cygwin: fstatat: call fstat64 instead of fstat
To: cygwin-patches@cygwin.com
References: <20210112194514.564-1-kbrown@cornell.edu>
 <20210113085639.GK59030@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <330f8a24-81cc-0d2a-08b9-2c3ec65035ed@cornell.edu>
Date: Wed, 13 Jan 2021 08:15:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20210113085639.GK59030@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR17CA0038.namprd17.prod.outlook.com
 (2603:10b6:405:75::27) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN6PR17CA0038.namprd17.prod.outlook.com (2603:10b6:405:75::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 13:15:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 899e6825-e630-4117-c11c-08d8b7c54e2d
X-MS-TrafficTypeDiagnostic: BN8PR04MB5620:
X-Microsoft-Antispam-PRVS: <BN8PR04MB562051BAB9276F1F1266A276D8A90@BN8PR04MB5620.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyHPycbHD8C9mZpGtKGt5aAKWFEtAqmf7KYhp7gmuD1arbp/22QZx+fdQ3zgaiHkQsSTC2TA19OH7MmQ+jnPzzhnwXpOLQCm3GF4v9l53vGw9VHz7JSfTsg92UwFXFqK0BExgVf6qNa1OU1KUxS2bzySEpOPRBzWp0EPQjllM5gbrd6l1cENQfjX4eUvN8bgmSmS3nRYwQI6dOKTXq3mMvKvKnapRQUNBF08f6NV/X2kp8LZE7tBpAATpSi7/bzqJKIsf8JrbwpBFloxNy40gDOHLA1g0cVy15nrrV6luuuU5+GxhfDb4eaJyktPVzW1X0CyU0VmKkbaDBhf+d2mx43woB2/YcOMChaxxFz71HQ71LUD5x+aILsrkeN5qWxIBuFOxl4TsGBIvxWcc//J1iy9tluFPS/KwjUtCl5aQBV+Wg7uT4EqrWkioz9LuGn/fOjAwCVoyt/0h2+qyzS7ZfRrm+J9n2uVK0+EwrMt/eY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(2616005)(31696002)(2906002)(786003)(16576012)(8676002)(52116002)(6916009)(956004)(316002)(558084003)(75432002)(31686004)(478600001)(5660300002)(6486002)(66556008)(53546011)(36756003)(66946007)(16526019)(26005)(86362001)(186003)(66476007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?V4nX+HFc/osOuM9vwlvW9R0uCd/2pml6rO1N34rsAsGupZiHBJH/M2HX?=
 =?Windows-1252?Q?q+xitDHg0T2U2fCf9pRN1kAp3yxDeLmsQCIRsadKHRBagU64cdiZ2cRn?=
 =?Windows-1252?Q?DrOhWGNX7aeGw1eanxmSgMA42PJMktvMpun9jQUSXRblj8OW/cDi4hx4?=
 =?Windows-1252?Q?n0oIa4ZABr2neXBw+OXqzW0gI3Wu6Z49W265FKN6sxN4hLC4eZp1/vDe?=
 =?Windows-1252?Q?BqD1/NDS0GyUUdpLva6q4J7mVgne4Fz0uIh72IFwHchbCvwXbxC1S1Y2?=
 =?Windows-1252?Q?An7XyK/1+6L8o4Uw9Gs2+IJkX/ZDIn7rOYhNZGMiHq4DTrGIkzKyLXZ8?=
 =?Windows-1252?Q?CgRG5pHerf9nk5zCby+2yowhFhJtLIP2RECZJJZ4JJ9nqbB/9RMcH5Ym?=
 =?Windows-1252?Q?4mRhlnR+g7Zn6dG1LmHm8dqrCvdVp8XD2gqRpHDuqxPRqMrXddUR9dJR?=
 =?Windows-1252?Q?vDgFnnSnQY4RTO0xQ7b2BAtu1XOjZ+ki5mQ9YPfim6Aaum1PNp2DPDBx?=
 =?Windows-1252?Q?HjovyCjFgekhV74fxNpx7DkcNUAH+ExAvZYQwB4xZbGLiKzVhBELJHW1?=
 =?Windows-1252?Q?XsrCPH+FyoEBgZPFuD04aqu5wfeXstZ5r/6MxLKnEl/z49HFJz/y6KLM?=
 =?Windows-1252?Q?vnBmO/VxWmIr7S5vXJ9OvTKAWjaddYMz8wZToL6rV3ek8qRRYzAOzVqs?=
 =?Windows-1252?Q?fxlxC5pNNhNLmfBPlYFLA8aUHCrUNcneQm6DeoRRl/Y+XQNEm9ivBdTP?=
 =?Windows-1252?Q?FYL//cQHcVy1vJOVzbVe+8kUury5Nj5h13xa0Nsz+fs8CQ120NMJKSby?=
 =?Windows-1252?Q?3+ya5Gcs5gK0ETlKABXRdWBFatm6NmURqKMRLPiOr/aVmDPUI9yEiK2w?=
 =?Windows-1252?Q?JD0S0C+5D8Sl4AL9DMQMbuTBko/DwoqT+s/ZKlHu69LY2EpvpHMHVInO?=
 =?Windows-1252?Q?alFtN9mDttLXpXQY50E3e/fzg9uRc6u8UDWE8tULh6P4rWSY+LdjD+tg?=
 =?Windows-1252?Q?xm6SzarNPzU4t86p6BxmkUBdU/Lyqqit1+3ZEyJFM6PkXbTz+wHk+AFd?=
 =?Windows-1252?Q?DozRbyNDH1Lc2H4K?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 13:15:31.9907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-Network-Message-Id: 899e6825-e630-4117-c11c-08d8b7c54e2d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ggeg/258DwT+sNAzkCt7hEa8VEoqF5M4VmNKRcnUborKgHWSi0PODHco5S0Pq3BwdYt3Uy1ntCJcNMWwDh2Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5620
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 13 Jan 2021 13:15:36 -0000

On 1/13/2021 3:56 AM, Corinna Vinschen via Cygwin-patches wrote:
> Hi Ken,
> 
> Happy New Year, btw :)

Thanks, same to you!

Ken

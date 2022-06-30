Return-Path: <kbrown@cornell.edu>
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2100.outbound.protection.outlook.com [40.107.102.100])
 by sourceware.org (Postfix) with ESMTPS id C53693857367
 for <cygwin-patches@cygwin.com>; Thu, 30 Jun 2022 15:45:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C53693857367
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocsrtYZ2jgza0r3dvkWvOx24tR8XSKBpSxIs5Q4wvXvoNRjW3p7npCG/oTuxYA3FtZBrJe9uC3/OJ6OmeRML9tcPShv05FTV/NkPW+rk3QzwfHE+dDTxrUe7kDG8HVaL0FmfbmnUbh6mn2ieJ358wE8p8iwP9V2LrT6vsFVJBHCTc0b/UNGFfMmE8Vql6nJK9XKT0jgRRi0+zkHC91JM7kGZylHNN69e2hIGc48mXN3HlB0kaHUEKLj50IAr15A8fVQnsEL6rps/hX3rgdG5m4n9I3F+hHuQV5X1Osc0q548//Ej6STPfWj8OBTMhQDFvVbaN/8JK0Zur5dRlUZF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s72wqPGh4EkfJ5dJ+dC1dV4Fh0tsvSafb4z24oVObkg=;
 b=LFkLsJgVooHeE/uTG8YjqAgHBB9LuGD2WSifnlSy/zAb8gPEytHB8hqmdIa6AsADwPs4vhP+GIZgIpFJgM4ciK6gnmnzPhJMN2vnzfkaN2j2AMSjGvTCJArlRWMu7z6TBCBTo5X8gr5oDiaVvXgXoAlsn9ggsSdb5hXO2i+jX8Qa2+oKQMO2whsBdT8baT78WwtOChURxuBXdYA1+7baBV2yqUhMYxitVBoCVQR/VhcSV62tTQWJ36XytBFhygzC2IWSCq0wODLuJm9XdoJJKEob76qhLJWQ8xegJJ0LcbGGxhgin4+oC9+dja2iF9LHAMYqNhGP0WQn0dr8sZiRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s72wqPGh4EkfJ5dJ+dC1dV4Fh0tsvSafb4z24oVObkg=;
 b=PEqGs00BhRBv+WIn2kehigPKuZBTyaag2Pc6Y+oc1B/EcrjqW+/4EM9fdMSGe+TsBVimI/HnQoitk8s7/aDI8vYHZAel2klwXDAbvST0WZLKQoO0rvXDkTc3n7B5z0JiqSSGZzZE47csme5+CXHri6wV5QGSLFPhI+vPN6cRLbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by CO2PR04MB2232.namprd04.prod.outlook.com (2603:10b6:102:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 15:45:32 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 15:45:32 +0000
Message-ID: <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
Date: Thu, 30 Jun 2022 11:45:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Cygwin: spawn: Treat empty path as the current directory.
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:208:15e::27) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eecaf0da-face-4433-8cce-08da5aaf90b3
X-MS-TrafficTypeDiagnostic: CO2PR04MB2232:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOtEWppqrGlt22UfiibZAc30YABzgvUF6m1kjuvDrkxJpr4dsLirfUtzxDm/79w5xw9paeJ23VQraJPMKNRENgN5c1u4C56qTvzAw1aQTb/+BuLYTnAfVGqlDexOGSojmWuezMTxq/LMdq/mCs5yaycUXZ2tNdGQzDff93EGaI4UJpo3SNtALl7jpdjAEt2l6Us8eWeu+S6hEXKNwGyUSZN06+9aYR1oFot/+WaBt3uCN/c1r47fiTnQsW7Pa7Q69+0Haz1VaOtez089Cj+I4v/yp899rcTIQnNQpFb7rwbwqSyrw2DIM8vXDjZzFNc5ZbZQJdZP6+X8rXyBXduGTWxhErOhgixy/lTWTNwyBIqGByBqN5Yrgxn86iw5JuqHM/KZBn4fYqUMGVjVeTqDe2DGcAsdxdwzdpe80h/+DI8zHdH4k8kTz6mKPR0AuFGBRpjtgeNWTGWwlq2i8ZjpzVNTpZ1/BjdF9M9ENsqQFqwlKD7BqNxQGSvW/9e8MKVg2WV9PqGhLxfPqhYV9ZhyTR8EYbh9rEjgCpkzJvFolNa8MDryvcN1OfYv/pqlUYIeDcO8TMpUAX8KW6BUhmNZVMNVMB3f0xO42B1kmbHGyZVGVyFVzo+ySfmUBJrXtkPgLKN4GhG04h/rCo48V81GtMviI/u5zIUUwFZ2Y+vtVS7UkE3iy8caa8syB1OlqvAN/FipKNNm7n/OzTHcccHw9c+z7iVOCWayIrAgrFVPgNGfenEbcAzFX9pasf3WQ404LrY3OM4Xmedd6lm+TKcxfABgjMDoRtWU71FlR6AjEGoCEG4pf+Txpn0BOoNMK3U4e/UW6m0cuduMHUnoLGWkolcYCw1AJcwuBT+jlTdkEDmxKY4GM/L0bfCy6LO9EkOPGX8+A7oUKO7TEXG4f7NiqBpWyigNhZ1l0jHDrMV3Ilk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(4744005)(6916009)(41300700001)(75432002)(2906002)(6666004)(41320700001)(6486002)(66476007)(966005)(5660300002)(316002)(786003)(8936002)(186003)(86362001)(478600001)(6512007)(2616005)(36756003)(31696002)(83380400001)(38100700002)(53546011)(6506007)(4326008)(8676002)(66556008)(66946007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzN0L3VwSkhUNjRrT250eFJiRmxaZTBxMVRQb1VVZ0xRV3lLU3JMaVRrbGVt?=
 =?utf-8?B?dmM0WVh2d2QwU3p1MUNVVjZBcHRoS0x4OVZBWEk2cXZWWUMwSUZzTUJGOERW?=
 =?utf-8?B?Y3BERDAwdGNNWXpZR2Vaa1BzQmdCeTBtU1lDN1A2VTZPRXlMditUeFMvVkhE?=
 =?utf-8?B?eU90MHRVWEhTdXRyenM1eTZqOUdCVnM3Wjc4dS9VWGhDVmRuenN4a2Rzd3B0?=
 =?utf-8?B?dEVpWVlCSmJVeHZMTHpleVUxbFplODJodzdGL0QvWlVoK0dtaCtLR0YzR0tw?=
 =?utf-8?B?NFFIM09MN29PQTM4dzdKRHNuTGpxbTcwVGtueFR0QjBjNXFoQ0Vabi9LRSs1?=
 =?utf-8?B?N2hMVTFIRGhDd01FZXlNaEV4cXh0Wm80WnUrREFDcWdQbXRGMEdYdm5kZkNk?=
 =?utf-8?B?Nml4QnpEVWgwVEtTSGFvdTJncHg0OW1waXY1cDJLNGhxMlp2dHlDdHFEZjFa?=
 =?utf-8?B?em4walppZlo5eFdnK3Jwb3BTODU0UnUzc2FOVW9Lb1E3dzV3V3pYakxaMXE0?=
 =?utf-8?B?OE1NK1IySTZaMHNFbTNxbll2NXVPalh4RGJPL3M5RGtkak5oUVhldSt1c1B2?=
 =?utf-8?B?eWMzSFhYMytSMXFmSjdMS1FWckZsbHc3M2VYamk1RGRrWHYvSG5mUmhCRTNP?=
 =?utf-8?B?YU5DZDZyZ3hnaDBNKzIvZUhjaDJRc1NRWXQ3dFhHeDVFWnBWMU53NlI5UkZm?=
 =?utf-8?B?NVdocmxPMHNjWmUxOGxRYytvTUxFWXBvMTVoZFlMbnJPYk9rZUh2RXR6cFMx?=
 =?utf-8?B?TGJzWXdtZGJ2MjBvczR6RmxuVlo0NkFxZS9NNVVqL09pQlJ4SS9NazJBeU9F?=
 =?utf-8?B?SnNDYjNWVTlHTXNJdzZ5N3MwMHJKWVFJWDBhOEIrdlE5VFNLT0xKZzlUTDR3?=
 =?utf-8?B?VDNJSlViL3RYYmd2cmVSUHMwSVB4eFV5aVBCNUZmTW9yNTFadk84UjRYcW5L?=
 =?utf-8?B?NjlxQXArcm02Vjk0dk16dG9ISGFKdzJwN1Nxc0NIUmhjVlhJVVU3dW1rcVdX?=
 =?utf-8?B?WStYQzlpekdVVk9Fd1NpcDIwTVhXbGk5ZUcvU3BsRUxuU2RWRFZpakxqNWh4?=
 =?utf-8?B?SXZyb1AzTUNvMVhBMGZpdTBrSkJrZEFiaUVUVlcrRFpKR0hzNW9FWXREcnpR?=
 =?utf-8?B?S1V0K0szNmVxbjNCVDVaR09FR3FDME96OGl0dis3aGNaeUZOU0ZWR3lreHFa?=
 =?utf-8?B?aDJNTE5mRC92cnRkOE8rUXVuQ2dKdXJOWm9HcEVXTHNBc1Jib3NwMmhOQlFS?=
 =?utf-8?B?OGFwRjErK3NrNmdNcTBZR0w1MzBWQm5kTkxyOXZDb1dXdVpkWjBZMnBnVHJH?=
 =?utf-8?B?cHF5M3VvS21qVHoxbFR5VldkR2lEN0tMOUVHYUwyWEg1R0pyS3FMVys3NmxK?=
 =?utf-8?B?dG1DaDF3VDFJNHRkcFZoaWM3TlArakVHK0pSRjRQdU9SMStWamJQVUpUcjA5?=
 =?utf-8?B?eWtoMGNCK29zL0tQLzlFem85S0VTSTlhK1VUdUkwVmJLamR4NnNiUWdydCtU?=
 =?utf-8?B?RStMcVR2bnQrc3hrYmg0WVpjeXRUZ201VDJUd0JCVkV4ZWFNempTK1Boa2Nj?=
 =?utf-8?B?bTZMcVB5RWQyR0hBVVNWdGc2MXUvdk9HQzRiY2RIejUvN0FwOUhzN2VpT2Vl?=
 =?utf-8?B?RlBOMHZzbXJwYkR1TXR2OXpCeEFUTEFLNEovOEtSNGxRbjkxdkhPVUF4bkJq?=
 =?utf-8?B?cXdiaHNZTG1NczgycjlUeHZQUlYxb2tzekhDY3paQmJ3RnRnU3lJbzFnaGp2?=
 =?utf-8?B?QVFGTVNvRkdNT203TUJ2akpKNmx3WWR0Q3EvYVVsd0lrTlNDRUlrMGJxSDJ0?=
 =?utf-8?B?azJYUHVoWjFBRnFpTG1MV0I5TFVhNGNmclVUY21hTTRJVEJkRUtwV0hKUGxC?=
 =?utf-8?B?dHRTUEF1K2o1clIwdHRwbjRvdlkrdUhOQnVFaUF0VlRxNUJjcjA5bTZsWHBs?=
 =?utf-8?B?NHJKR0ZxV1hvaUh6RmJ6TGFQdXpZazN3Q1czbUhvck0xUk5uVXMxZE9BczU4?=
 =?utf-8?B?bFRkcThFV0U2TEpkaUkwQmF4dHBFdFk0SFVQMXc3SExnclZNK2U4M2cxKy9z?=
 =?utf-8?B?Y1RLdkhHdVVmUUZzb0ErVXBqTmEwSUtxc2J4VzhjSERDR01kc1NZVHloZ0Nq?=
 =?utf-8?B?YzQzaDB3T0FaU3ZlbXhoOC9qRGVmRXB1aWpZMWkvZDNJSmhoVXozZHBVY3Zl?=
 =?utf-8?Q?Mj++geL/8g+0v2HcRjxFvtNbDZaM2zuGeEQWIBVQlvLI?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: eecaf0da-face-4433-8cce-08da5aaf90b3
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 15:45:32.0902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cv3JkUwX55gKk19eNUak5BmpB1YSgEpRmC7ER2oDmzypQiIvltEPI+1+HKL2vNBx8ZIYBEyp+Adah+MKxJckjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2232
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, KAM_SHORT,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP, T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 30 Jun 2022 15:45:36 -0000

On 6/27/2022 8:44 AM, Takashi Yano wrote:
> - With this patch, the empty path (empty element in PATH or PATH is
>    absent) is treated as the current directory as Linux does.
> Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251730.html

It might be a good idea to include a comment in the code and the commit message 
that this feature is being added for Linux compatibility but that it is 
deprecated.  According to https://man7.org/linux/man-pages/man7/environ.7.html,

               As a legacy feature, a zero-length prefix (specified as
               two adjacent colons, or an initial or terminating colon)
               is interpreted to mean the current working directory.
               However, use of this feature is deprecated, and POSIX
               notes that a conforming application shall use an explicit
               pathname (e.g., .)  to specify the current working
               directory.

Alternatively, maybe this is a case where we should prefer POSIX compliance to 
Linux compatibility.  Corinna, WDYT?

Ken

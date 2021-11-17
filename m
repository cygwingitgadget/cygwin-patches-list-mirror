Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2093.outbound.protection.outlook.com [40.107.92.93])
 by sourceware.org (Postfix) with ESMTPS id D39343858406
 for <cygwin-patches@cygwin.com>; Wed, 17 Nov 2021 15:09:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D39343858406
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp+6EOIbqGchnrC4rYVQ6bWFzwydf21gBzAVz+FzNlXmd3MQLkp00/OB4Y4IKVZURpy44S+SUrGS99qL4RzFlEIHtnMII9r8A4EVCRfKp1f4rZSmwKsWluiv8Yv0S4CzhNBFebd/PhcWWE4BibrTDGJG8MlBcgPn+n5gYG8x59dF14ClJpBZ7kT3EovycpZ0DgleCiomGdF4W5BdcHGBd6ncuiVF9aI6N3rF9CTp/p4XDQqShwy2G0ag5j7LekkhxF3M6gdD2iR/EfD8mu/A7Ahzqsq/+o+0FqmXYLDTp8dcg7uA8NqawybGvq2Qh/man+QgJy8R8QRm7ipXrUbb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0h4Ll3X+Fg20E0d2GxV5Wwqp9uh6b/F9glCZZ6DJP0=;
 b=VbjrlV+b/UDH/hKwyTZHuIRolGeZ+KnAO/DZNGL6YQ50m7HCYjkcURKDYguF9hHnz8h6MnQeeOhpcM9JVdei+36R9z/bngCCj1kNtkwdcArD3v2nWU9/vbmb2CGVaT/D6l5tpcAl3E29pG1t47xfKC4KwmSu7K2Jsz/vpRcsWuckl3wOBguHVhRaPVkqxq8rVjAV4YfLcyR7wtza0TGysBMSuiJb5/YJ2HpD+LhY1lNfkGzjUd/DSgOkth42Sy6yjzV38avAfs6oAqSREs2lRcAQ4wC4vsVHbT3Lucoln48ndX3tabu60qOmJDeXybMrCouwzVZa9aXJ9cffbzj07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0h4Ll3X+Fg20E0d2GxV5Wwqp9uh6b/F9glCZZ6DJP0=;
 b=TrNd9Q7oGD2VMz+hcTzXgIjrpfvlofnV0PTVj6v+e2upv+QoAb0DjlBXRClcMNPBAw0kdyG1jXpomY281+ZVjl3KjoSWxNF5Qvn+SKYTCElzH+8SPETK8yqbp+DxZ9ieaMmwZ17vRRwKuZowzb14QausX4IYSO54vlAFUkE8IIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0437.namprd04.prod.outlook.com (2603:10b6:404:96::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Wed, 17 Nov
 2021 15:09:20 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969%7]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 15:09:20 +0000
Message-ID: <ce2d178a-4a01-6041-3ca7-44a9df090222@cornell.edu>
Date: Wed, 17 Nov 2021 10:09:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] Cygwin: pipe: Suppress unnecessary
 set_pipe_non_blocking() call.
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20211117080827.1800-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20211117080827.1800-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:208:239::12) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
Received: from [IPV6:2603:7081:7e3f:3419:1c5d:e1a9:7b:59ab]
 (2603:7081:7e3f:3419:1c5d:e1a9:7b:59ab) by
 MN2PR08CA0007.namprd08.prod.outlook.com (2603:10b6:208:239::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Wed, 17 Nov 2021 15:09:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5a96083-d3d3-44fe-879b-08d9a9dc3b88
X-MS-TrafficTypeDiagnostic: BN6PR04MB0437:
X-Microsoft-Antispam-PRVS: <BN6PR04MB0437662B800135FB57FB8FC0D89A9@BN6PR04MB0437.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Atn7xEZ8KqN3wcoybIrWqZ49dPX285UqkFMKv5aEuA7FHyEwiGjll+aq0ICW65m3Q5hcxlL/Tmg5GN+J0/qbpvciRqu9KK1MBWtihKCLx8BITBeUsIEuBahWhebRzv7RbnWBQoagAgq93LtsFNzhgSBJXdhkf1KkBJoQ2i0avm1vxWM5rOpY4BJHBhiAYMYQWL2stVSb0TUKXWhLU0WDofX/HPzP0wOYQgr9Q3JJQUyQUxNIuv5orp0ap2JbtMLONBb/D9WyCearkY2gYxYmTM3X86zRxboYpPYAm7DMq+J0Cd+2s5xV/hXCQmVi6x+k8j8GEa9d/ofC7hQCDnCDT1QWOdQza6tamVYrVPu7pcAT1dhKVp9JYhiZ/IvEaCU+JmZOA45T8rI/3rCHor2o3DHGP1lh9uuoWWq6rywTu9k3xS1pOC88XVI5RkM39hf05khVva/yxuHOLUstkvpO1RYnpxF7eYF+9/q+YavyzIiDkxStdRT85EHV1/EwGr+qMjBXT5V/MCLo0l6TSi2eYSkXF8fneLrQHZi4sd5jOe+d7605MpPpWckFMTl0dqOQaIbDs5AA1d7aZcACzEiQ4y8M3hD0/0DE9FiHbegrfjdDSbwdqWplIcGd5dSentGm3yDTUh8xNU87KwHL1dCa8oeJqIzKqkIJnjE7Z2WZX575QeseMPmCSkJR4rx9bN/xWN4y2QAuCOX6CxACzlpQHens9yzqoNmoYi6x3tQXwnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(36756003)(31696002)(5660300002)(558084003)(508600001)(2616005)(8936002)(38100700002)(2906002)(53546011)(316002)(75432002)(66476007)(6916009)(66946007)(8676002)(6486002)(86362001)(786003)(31686004)(186003)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFcwRE5DL1RjMWFDSi9pNm8yRWRYcFFZQXBuRHRMZ1hhRHBYZGtMYTc5Q0wv?=
 =?utf-8?B?eWFTNHY1SEh2UVYwMG1XWklBY2x0WFpxdGNOWCtvcktuM0NKQkFiZjZDZWNj?=
 =?utf-8?B?V3BlZlRKMEp0MWtJU09zNlEwbHAwVlBQVmR3dTV4UDdmMXQrVXhFWUYyK3l6?=
 =?utf-8?B?NS9RTWxydytUeW9oWEVLaks1Y3pUZlNQVmwvMDV0VjdmenVpYTk4a1Z3YWpt?=
 =?utf-8?B?emJmRDRNRjk5ZEljeDVuL24vU3M1UXhsRnk3QWxkVzFBaDd3aUVHQ3NNRkNF?=
 =?utf-8?B?UWNaLzZKQlFBVk41RjVWTWRXUXFZYmRkS0d4NEgvWDhrUzhmNEg2cnp3RldK?=
 =?utf-8?B?cUk0K0UwbWZNRDRnMkZNUkZROHZBT05ZRVRvVDA1RDRpNFM5RGdTNVV6NGp2?=
 =?utf-8?B?WmtFd1JzQXJnWVViSTFTZUtZSjJTb29rK29DYk16N0luVGp4OGQ1M2VoRlEz?=
 =?utf-8?B?MWx3dk5QYkx6ZThjYWY5R0pLMEZyMUJZcTExRHU0NlBTbTFyV29tc1dpU3I0?=
 =?utf-8?B?ZXhqT3ZxNldaZGhzbis2ZFdVdVJSVWREak5ZeldsTlBnYkgreWZwM29IT1lv?=
 =?utf-8?B?dUFadUhuc1lrZEpuVnl6SWsvR3NVSGZ0UjhZbzczd3M5OFBsMHdVNUVVRGo1?=
 =?utf-8?B?NnVxVTVSNjZ4b01IRjJQKy9UVThPQURLcU9BS0FVdVhnMEpjcml3ZHlRaHpG?=
 =?utf-8?B?ZGlPYzdJNVV6c2ZxcXJtaXkrYm5MeUZsOWNYMXBlWHkvZEdSYXNjQ3Bhbi9y?=
 =?utf-8?B?TFk1TW1LVFZ0VU1CRmFTM0kxMEFtSTVxZjE2NnNPcStIKzBwdk4wWEUzZS90?=
 =?utf-8?B?RnhBM0ZncXo5RGp3K2d0L0ZVZ0JGWjFkZGkvcWthZXhxemM3VkhGbzA4MWVx?=
 =?utf-8?B?UnNzVWNRbDJHWFhEZGFtNzZaSTNDaUo1VlhRUytld0pmNy9jb0dSekpvZkE5?=
 =?utf-8?B?UG1HZDY4VnRHbUYzWDMwK0FCVWR6dU8rTHBXeFgrQWR1blE1cVBEaWJRZG5U?=
 =?utf-8?B?UXphei9ncDJXK0o3bWl6WUo1NkhJeWo1OXN1dlpCS1hLWEhFcjZkeDlpQjA1?=
 =?utf-8?B?TkJDMjdHb29CaEFGMnN1QzF0L0JUSEROMXZ3dDcvWVJYSlJuWnRqT1A4WU1z?=
 =?utf-8?B?b29SQWlPTlpmZHZ6QmVpZ2x6czZOaGFuVGRVenZXeHA2WjNsM3QrcFhMTXdR?=
 =?utf-8?B?VmJpbjA4ZFBNWEhkaHRubTV5TW9MM0JrSmY0azdINXNIVUlrYjdhcndIOGpT?=
 =?utf-8?B?TGpnTTVNUmNFY2U1bFpleW9wRVlnNUt6K25ZRW1DRHBRWVUzYitKTFBEUnBN?=
 =?utf-8?B?ejRiTkRkNEpKWXhuOEI2bFRBTFVJVWtlN2Y3Y1BkY281bHRvWGZKQVRXVjdm?=
 =?utf-8?B?TnNZVzQ3OGY2SitTajhOUE9tdUtycDUvcXd3NlAwaEtURE02elErbzFrcEcr?=
 =?utf-8?B?Qmc0blZjL0RsWnZVbXpPTTZNcU5ZU2lQRVNMcU56NWpweStTOFQyQmZOc0xr?=
 =?utf-8?B?Y0FSZEFISHRDY01tTkVRMWNVSmg5dHhtVFQwUFZXaXA5TFNYdldSejFqZk4r?=
 =?utf-8?B?cFBqdkNLWU1zc2tmenlZV3FKN05PdTAxRzF0YWtvV2Y4WGd3cXNyOXd4VDdU?=
 =?utf-8?B?UFFFN05xLzBYYVVON3B2WUZvZ2crK1dUTHR6cDY2SnE2UUpmeFR5elZjVXlU?=
 =?utf-8?B?YmtlKzdLNFpiM3I1OHZPaVNHRGRHMlVXZ0daZzBWbUhjdVVmZzhUZWhRQ3BQ?=
 =?utf-8?B?NG5NSzN2ZVE1ZHE1Z1Y3aUk2U0NkU0prSTFYWklSRFVlMG00VkdsVGxFK1RV?=
 =?utf-8?B?NEpaaUFsTVNTV2ZNV2xuQnAvdHFoRnBkRHNZSXlkb0FJUmloT1N5OWlMVEF1?=
 =?utf-8?B?N3dhM0xYL2ljc0JoT2t5aVpKYzFzUVFHZ2p1VjNVSHd4d05zRzRkVGdBREpN?=
 =?utf-8?B?dnBPVnIwS1RYbXhNTC9QckRlUmZrQXd4R0JycTVNd0hhL3I3anhkSGdaYTFX?=
 =?utf-8?B?NzFvY1NiSmFJNHJWQXFQSURXWGx0MzlRcS96cEpIV1FRWU5iMlFiSjNVOUo5?=
 =?utf-8?B?KzdLVU4rcmtTVGhTRzNCeEFtc2lVeVBoTUExNHBPQmV2V2JlbGtKbTNJT1Zw?=
 =?utf-8?B?WVJ3ZStDRDJ4OFJHbVJPM3NFaDZFUWZxbFl4eVgwTkN4N1J4WEVseDUwS1NJ?=
 =?utf-8?B?ZjRsWVVTQ1k3N3Z1dzR3T242SXBrcUxteXhUQkh5WXp6UEVwWktjT2gzeVJ6?=
 =?utf-8?Q?Maej0t7fJau5lYXnbaL/heSmJOxJL03xupDA0QdY10=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a96083-d3d3-44fe-879b-08d9a9dc3b88
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 15:09:20.7397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0hjTKT7g7R4bHXJg1ha6XMEaVXP0j12hCTo6zmcT5D+jmOQiVBMHPRVD+PM3898Uj39SDdXsaH5I2XZAt8qGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0437
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 17 Nov 2021 15:09:23 -0000

On 11/17/2021 3:08 AM, Takashi Yano wrote:
> - Call set_pipe_non_blocking(false) only if the pipe will be really
>    inherited to non-cygwin process.

LGTM, but Corinna should probably take a quick look too, since I'm not very 
familiar with this part of the code.

Ken

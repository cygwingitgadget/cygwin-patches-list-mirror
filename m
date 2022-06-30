Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2127.outbound.protection.outlook.com [40.107.220.127])
 by sourceware.org (Postfix) with ESMTPS id 8149B386F0D2
 for <cygwin-patches@cygwin.com>; Thu, 30 Jun 2022 16:04:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8149B386F0D2
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7T/zzWQzJmTL+AZH32pu8t9phrcogO2uCDrPno4Ient8TVEGtib5WcfE3wshEFnk3RmcaF9VESTm18LvhDmlkU/6LaBq7km4a/+G8//ourgS8ePEplprADy3cV1NMWTLEjXh+jIvOWFnwFvFpVTae3jBRFkYAOTLxXYacQfksT3vOA/rgFkDLrt408xIcHQ1MAF05t4Xp8chEJzBbxlGH5LMuDV4JMrhCdfFCXT7qGhdHGsrYQzqR3KhgRjkmC5buQimeMXKlKTWVS2dChfwMezu2TgMbkAVYLUIX9UWRHc0c0ng31k3IWU/tN5vu1tQwBm2wRTRLf/Ldqe9gdUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwpFVoL/GwzTOXOGtk6L5hvvERQwkfEcFZIkI3/82wg=;
 b=I2n9z51dsKGlPuAbE9h2TSi5rN32r8rvRROf6x/O4Cgn8Ukd6RqxbgV89hevt8500FkpjZmGUU8pXlQlM2uvf/0znKYhSiBVFzcoiKHujdiHHW9rY6GYTbJpS0UppLlYqcVCmbLss6MQJDN3zZ6WKz+tELu8iq+UE1eymo+w25qcHMTFpXL0J8Sjo6sIelim1FdZvo2OrzOvezfF1n/dsSG3HzrKqEjMQxzGfiaYCj2H9UAg+S3rJQkQOhV9ZZ6eYue7LGqVcnVMMLhtfhGZ4M2yCrEHsPFv2TCRdFaF5VhFVRepOquBITtlQNGGv4MxYeF5QTpIxX8WS259UuY0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwpFVoL/GwzTOXOGtk6L5hvvERQwkfEcFZIkI3/82wg=;
 b=bhXS45B4AyZe/On+GTNTqFTDmBMRuyTDORwyf3oLUAxFgutlZ8NV4N0swYFL/yomb47fsopFf7wXEwT84fzAMkDKVMTzpPSTY6g25nJm5qaObdDHRG7E2Z/hMWCNLOHvPtZmNc5OS6QxWCX0XhBfsgg4QkG+l5G1dbbdGvSZbh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by DM6PR04MB5978.namprd04.prod.outlook.com (2603:10b6:5:125::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 16:04:19 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 16:04:19 +0000
Message-ID: <b42b2a3b-d2b5-56ff-eb96-81cc7ff06881@cornell.edu>
Date: Thu, 30 Jun 2022 12:04:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Cygwin: poll: Fix a bug on inquiring same fd with
 different events.
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20220627015032.278-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20220627015032.278-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:208:23e::18) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95abebde-e63e-45b5-e848-08da5ab2305b
X-MS-TrafficTypeDiagnostic: DM6PR04MB5978:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAKMsIK9tIxAMN5E4zUBowUfINk6DUxc8z5F4Vey37Gicn2OWbfvNhKtroLeQeXd8TPJBOrEFHRgwkcdYzCbKsGDB9dqj5RpjYLwiM0V4LPycR5nXXmj1hIIdeZnSew8G5ypnyS/tjN8+zjl4wrBp9F8zv1fhEV09gtExx4T9CjDE19i+xWLsP5Dt/E4l6YGqOUPLm/AgCKroY3wRkbJeJc5rp5yfg9pKPEH/2pb2oKxx2Qplq74FXiWisZQmK/Qj+9BmlJDxQ8FPdEI8KMIQFmLzgvZsj9CvRqZUtrQVJdFc10e5i+c5ZKVLig7K1uuTOzS7rKGV8p4JYLbRppsMYKvFvp/3DIJn4wdwkjJPnvdEkXf+NU6mbGDAmVCKFcu9IcE4qH2yAIlrTUpg2JN2fpztpFvjX4h25JTBcBiClkcemmKD5QWqqH/k12wfhDsF8FNfBc5ABTj9G+3I7tsu1mQItx/bS39prgIGLPyOJ4FIrVWAKBXEdX3KLRBr4SbsTKArTo4TO11W05fPO0FBcLDE8G7VCBrbxX/O7Ai4BioWzWxJB8NoQRs32oa9G78PfYYKFQvN0qTIHMpu4SS+7GnwAbpxafD7/2eVPSPh4dIwJLyrOTX+fWkQP55atS/IQh+8qO4SBV6GRtTkXdH97eyF6WHj7NU5TNpV2t9ZSCFgttHPhoPnBsZuCVDsPhPbBpRjLro6hO00f7kH8ev59Dn7mYHXMzsSNOo9BzC53lLD4EdPxJ1V/4hEsKdfapER/CVvdC8TLzVz+8SzvGoHMzHgOqdSa4x9ghDtfjLauNkafN7FYPDoI22bbWa1ilkRssOgv9LbE0Ip6xeHTzwQfElU8HVezPCqrRDYppKvzSGxhDACaMGvVfgnqeH1VqD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(8676002)(75432002)(6486002)(8936002)(38100700002)(478600001)(31696002)(4744005)(186003)(2906002)(53546011)(966005)(786003)(31686004)(316002)(41320700001)(86362001)(6512007)(5660300002)(66476007)(2616005)(6916009)(36756003)(66556008)(6506007)(41300700001)(6666004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVYrQlJrRlcxUm11b29XQlFlekE0eUFyajA5QWhzVEZwY25ZQWdTeHBwRXlU?=
 =?utf-8?B?S0phK1p0RHU3OFFLR01OVE04N29lSWF1RzZkMzZLSUxPdk03dTNFaEJCS3Ju?=
 =?utf-8?B?WVl6Q1B6a0lTK0FPQkpXZTU0cE5oL2hlMVNqNk82d3MyVGUvbUEzdFg4UFlq?=
 =?utf-8?B?eUNEZkpVQ0dJM0YwQUtvb1NlWitWQVpETGh1SDR4QTNjeHBQNm5JeWhwMUJF?=
 =?utf-8?B?S3BNaU5aMHdqQldtYjdFb0E4SWkzYkVtNStieDZoTExTWkNGd0lBL0FGbHls?=
 =?utf-8?B?cEVYZ0JEOUdzTjBlTklMNUk3YllkanU0d3VtbWVWOERHbFNwZzBJZC9WVGdw?=
 =?utf-8?B?amowV0pWT0lXbUJvaGZnQmw4TnFjcFM0c1lQSmxycmpvVkhnRlZyd21YS3JK?=
 =?utf-8?B?Mi93c1F2RmxSSHJOUWcxYmVGbzZsVTVaWDZOSDdjQmFxaUErT3dyazYzN09Z?=
 =?utf-8?B?dTZyVFR5TFN2RFlRNTFzRThQbnhueHJlV2REQ0ZQeGM0RTJ0bG93MEEzaG9E?=
 =?utf-8?B?N0Q0RTB6b3NPTVd2bzBLWUJBbE54Q2ovSlRQMHFPTmE4Rk1IMnNqMm8wdWlD?=
 =?utf-8?B?ZWZSdXJxZ2Z1YlpFVkUzZjB0MFBQdXlPak5xeTZRUW42ZUV4b2lMdE9lNTB4?=
 =?utf-8?B?bDdDKzdFTGxra0d5U0lILzJXZVEyKzNuK3hQczcrMnlpRFZ4cDRXL0J2aWVu?=
 =?utf-8?B?R0lvL00yQlJkTGNzREZBMDNreUg4VzZ0VHdLT3dFajVjS01hRVMvRWNMV2ZF?=
 =?utf-8?B?Wk1jZnlnbC9QSmU2UUFOWERHQXNSY0szYS9QbU9kYTBsUUE3RU9pU0lWbnpj?=
 =?utf-8?B?SUQ5ZlNiUmlzYnQyY04vZXN5azZpRGhuRlFlRVpGUHIzYTlkOUx3cm9nbysy?=
 =?utf-8?B?YklIVlpsTzVrTE9Vb0tVbCt2eFREVG9Ta3dPTGc5QjBLd2lwaVFhZFJtMDdB?=
 =?utf-8?B?YW5iODlBT29VZllUTXhQN003M3NXUWR0OWdrcVNFVm1vVEZxOVZOOEk2QTg4?=
 =?utf-8?B?TUFuZ25KNE9ucFV3TDZhdzZHaWtJSDF0akw0MVNvYUcxYTVDcjAvVFY1ejd0?=
 =?utf-8?B?dWFXMWtEU0cwcTBoVW9rV1dORXBUMzFYRWR6cXQ0SFg3dnc5amRLOVg1Q2tn?=
 =?utf-8?B?U0pLMVluRmFubG1jUU1iY0V4OE9OTFl6aWw5WmxuY3FTM1NyeG9raHU2dkxS?=
 =?utf-8?B?NTF0M1BENmRXeDRYSSs2V3RwR3hzZ2g4ditMaWd6aTBOYm0wbzRXbmIvR3gy?=
 =?utf-8?B?QmIvUi80cFJZR0dPOHVMRUZDN1piUGdpbzRKejQ4YmZrRjUrOEc1aG4wQllt?=
 =?utf-8?B?OERnTFBia3FDL2EvMit2K3RzYkEvSVIwcGpDYURDS3UrUFBPTVVQTmNrMERD?=
 =?utf-8?B?TTYvZmRNWFdKRi9PU3ZkL0IzN285b1pKVEdQbFRRL2RzeXk1bHovemJDTW9T?=
 =?utf-8?B?NWFCYW5DU1NPZjQxYnZtTkZsYlBLcm1oeEZnYi9ZQkpja25wbzlZNTlaRzdH?=
 =?utf-8?B?RFp4ZGRPVlh1cEwzNUVzTWlMb0ZjSGVYVWF2QmhVMitSMGM0aUNGb0JacGp0?=
 =?utf-8?B?aXpDWDZubkQ5WC9hVTJ4L2hRZyt3L1hQWVZlY0tmWEJRL0w5eWQ3NDN2Q1Jz?=
 =?utf-8?B?TkpzN3hTdjQ4OEpHRXgrUG9uQWVBbDExbUt0eHRaOVVWdHlndFM1ZUdCRVp2?=
 =?utf-8?B?Nld4NnJhMW8ycGJIcHpQRGduSlhJMmIzR2RVWEduMmUzOStlUXl1QWVVRUpv?=
 =?utf-8?B?MHpINVFpMEZNb0E1dEVXLzV3VTRvQS9FUFNPZzEzQjZiM0crSWdVT2hmYzVt?=
 =?utf-8?B?ZmMvUzg4N2ZiTkttWVFnd1kxMTJjYlVjRExGZTFhcEZBSmNLNVNVZElPMFY0?=
 =?utf-8?B?OFgzZXlpdlZTdmZ5Y2RwL2N2bFR3Q1JuaHlpUzd4NzYvMmMvZHJqTGRBQnRH?=
 =?utf-8?B?ZUFFSGlDVXdmQTRYZGZFbXkvMTBFSWlqQmd6aU5rdEloSjBia0RuYkIzREFv?=
 =?utf-8?B?aHBNSERmYm1CVXl5cm9CVzNnQWRCdGRNSm5wNzl1VXZFTi9MUnJ5YXdXa25E?=
 =?utf-8?B?eGhwWWR4czJ1OFZ3OWlINlNySmo1bGNsOUQ0N0ZwaUZhdkJ4MkZrUFQwODkx?=
 =?utf-8?B?NnEyY1NXT3NmOVNTb1JxdmM0R0hUTUlOMElDNS9KSVM0b1Vuajd6aGhndFRx?=
 =?utf-8?Q?FSIewTNriF8bHcqmWnzPAK4T/i/TxCRPYHWcoH8jI+BT?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 95abebde-e63e-45b5-e848-08da5ab2305b
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 16:04:19.0698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LQxKvsi+GmDHe/SLfgP/lc+L2g/vy8eKIz0aNkqWWiqYyxTTKvzToSGwHEKd7ulKOhE11PORpdDB5OQpOprvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5978
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
X-List-Received-Date: Thu, 30 Jun 2022 16:04:25 -0000

On 6/26/2022 9:50 PM, Takashi Yano wrote:
> - poll() has a bug that it returns event which is not inquired if
>    events are inquired in multiple pollfd entries on the same fd at
>    the same time. This patch fixes the issue.
> Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251732.html

LGTM (but I haven't tested it).

Ken

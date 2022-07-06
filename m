Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
 by sourceware.org (Postfix) with ESMTPS id F18CB3858D28
 for <cygwin-patches@cygwin.com>; Wed,  6 Jul 2022 20:51:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F18CB3858D28
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOVqaob9Wx81zOCarwb7Xfvd4Smd1+McXX1+3MfA6g+kih+dbXWYTpw0RfsDOO8CVrffQYN5uydZfY9YmImY9VUpz8JCK7acUcNbEBAQPR3J1LfCySc2Iox0VsfKbZKBs87AmxZDeXFtTkVFb/5+rBeFD4tgNy4lG9NbJb2XbU4ddl0KD+bdkmyPqMU7x3OITGV4dF+IEG4PWiCuRsypnb++lwgSOproNp9Xjn/Q77CPnVkUBw+mvHO6D+htc1QGxfby+eVTXTaSZFfNZKMyXa8qZGv505dBs2/YQKfr+ryz2kr7x1a9A1gl7r1RT/d0+9K9VM7rK4/CItPxEVfQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKnBrzDiKejN8bxtQM0SC/Tvm+CdKoRQGEhLYZufQiw=;
 b=YvAbvXaA4ZWDt/P58NYNXtPAwrTZIc7xgiinF4cpqx4NTVX7GVn+8n3NM5AOJS5PwFvfWL/+l0wFvvvRsJOft2Ns4eGknzy1mUq98fhvRBfXIaW3nWEdLo6MSF89BTK348LTuYqx2dy1XuTOErd9yZNi0Z8R7NF12bJKZUrG3r0GXiKzSu+n0DHzZgpyf8Corrr0u74zG5I0uFMwRvKcUwFGiufGL9nY6LW5SCT/0d8HtUc/2jQkhWIg6x8h6SBRiUHJteqfe2FRWuw+otLhJQBQgNNYx1mJgLkL2mMWIIb6OsiBXtq6U6j3c+8ABnH5LvWk7R7IjJme/airWdn3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKnBrzDiKejN8bxtQM0SC/Tvm+CdKoRQGEhLYZufQiw=;
 b=NYiPodkT8iYHCkekm00YtEb6y/Y/pNZBjFY6XN2tvZEtHAkBkQz1ssGcM2bg/oa945z+qL2/hbnpUjecmvxtt00C6rXw2tV5m6e2lyf+9V+/HVHda2f2ULuph9352dACTdh2F643eSGj+Rkrq1iPxegy1JzYEDL+nPaGVtftpoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BYAPR04MB3895.namprd04.prod.outlook.com (2603:10b6:a02:b3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 20:51:32 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 20:51:31 +0000
Message-ID: <b3d8d4c2-59f6-e3c4-4394-1a77a6ad9c9d@cornell.edu>
Date: Wed, 6 Jul 2022 16:51:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Cygwin: redefine some macros for Linux compatibility
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <efb21775-c0c5-768f-e1fd-d38145fb2f0b@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <efb21775-c0c5-768f-e1fd-d38145fb2f0b@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0300.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::35) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c80da2-96df-4047-6f81-08da5f914e3e
X-MS-TrafficTypeDiagnostic: BYAPR04MB3895:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7+KNkvODNWFQJ4E+G7q338CSLKbnXIZNq7f8j6Byuqh7G0qDyF1/PA/qPr21XRzAg3sxZveXVWz2eXLV0i6nFcdrInbrdiagJruphIKTD9sNs3E+HFN96afhJub+Jrs7xHuFOjqltcm+9RbVAbkXIDIw/74lb0XCf5+yaQb9PSQOsa/dJ0jPmLenR8iVU4yxv93T3xZo487cW8GXHLMFeLT0IGxPZyQzx0SEfjJIDpEWMjB626gw4rF+YUrcg+BsFAKr20Cyn73zV9iP+PXnWIZiAQD5a15TAOlwrH+GP9ITjrSTcnEdxS2k2oZAPQbiJ/y/U8z6LsKmXBJ+4ttt8iUzn/73TUVjMU/49Ka47PUNYYl/qmWrQNmMiDZ2F++aGMlqr+VStbOMAElHYxfb3ZZpF7mTSYGUKe0DdMo+jU9dzC6cyImarvjvbaQo9bdqSYIvk6jHv/Lb9plIFyD5W6/CL8t6EKizoytF+6WVCqVnci30eFH8SkJDX/jhZW1p1KsS9FIIrRhPWuEHHbh2zene43zcYsu8eWMHEr3UiuxU1nErpxtFsw1/UrISF4iWHQqlMBipgL8wZ2r1oRbllaMSmc+LyVwt7f4dvQ97NcDbkYhNZC2j6rGSoDrP+Ln2i6dER7WWRxWUGead3CNdS60A7/nQpXLfcs+dpbdLa+igd5QLWK1UXKcAsY42uquTZwF+Z72offF1wNkIsjMXfcUIpnrQJk648P0CZy7f/kqjUYk+SdmkfTCWU4BTLEuz04LO5qcr9zcAkz9PGT5AvIhrVfiD88/ZWbvvOCw3sENHQjnZUc9dq7ibBbWEQyoQnn3shwQpGqOwR90UyTv4/7j0PjJaXCjrS8r0KzwFZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(186003)(2616005)(41320700001)(83380400001)(31686004)(316002)(8676002)(36756003)(38100700002)(6916009)(786003)(66946007)(66556008)(66476007)(478600001)(5660300002)(8936002)(6506007)(31696002)(6486002)(86362001)(4744005)(53546011)(75432002)(6512007)(2906002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjYxZ1YxQ1kxWktmUjlJd3k3U2NlUmh2d3lyTDRDMEVCRUloQWxPNG10U3kx?=
 =?utf-8?B?dXBJV0VBcE1DNlcwKzlmdXAzeC9nUWRSYy9YRXRodkxucHV5bGR4TEpYMFBD?=
 =?utf-8?B?a3ZhdmVCcGoyM0JNY01vK2FaSGJJMFJ4anB5MkxWVENhR1g4Sk5ibGRhaU8x?=
 =?utf-8?B?WUVFVThEZXMzMUZqVklzYkRFRk05WXlGTlJpOGtuMXVBc0ZBNjR0Rk9HL1Mx?=
 =?utf-8?B?YU9rRElRalRiWWFqaHZob1ZxdC8xWUIvVElZZ1lFM0c2Y1o3TmNNa3JBSUpq?=
 =?utf-8?B?MjVLMGdRNjhXdEtVekdaYUVMenY2ZGl5cjBZbVlacVUwaUJxdXd0NlhGaWNU?=
 =?utf-8?B?Z2d0RGJiMFIvQjd5UDhrbGJHcTN2MUZtRWZhdkdrVHhINUp5aEF2U2JBVEZK?=
 =?utf-8?B?N2NUZU9aMzA3MWd4UXJJTUxicWgrYkpPUHdheFJVemo3YzJOUzdaSWkzWkNY?=
 =?utf-8?B?Q1E3WXdBMFg4Yjg3ZHo3aS9jbk93ZWVzeUlrRThreFhVQTJ3UFRRQzFnNkNl?=
 =?utf-8?B?U05NRzhpK1NmYS9nOGZYU3RTU0cyaDB0S3lnK0x0ZGo3TkRsK2dFdDBuc1Vs?=
 =?utf-8?B?Vm5lNWtrZmROMkZNTWRJakw1Ym5Uam0wZ2JEK0FTQWlnUVE3Y2dxNk51THNO?=
 =?utf-8?B?eS83c0dPeHp5K0VHdVZXSytrYmh3bHRIUHlxaTZ5cnQvTS9zYU93SG92ZWlT?=
 =?utf-8?B?OFhYU0xxWW1udkdCYTF5ZVBXcmtxZmpKZ3JPL1I4dE5CZEM2YU15SGRqN20r?=
 =?utf-8?B?K3FHRWYvTjhRcVhLTjlzUXBMWUZHYkhRaE9XWjhGTy9UYjRhaVEvYXBZdWJs?=
 =?utf-8?B?SHMySUMzQXhYTHc3QnBMek9DbVJKeGh5L1J0bnJadkZ1YzMzL3RSMFlvRTRB?=
 =?utf-8?B?VDRGbCs4QWs1T05JRkppOTZlb2RNUlpaeW9XQ2dDS0tBdERvajBIWDdHVjF0?=
 =?utf-8?B?d0VBT25WOGpBWmt4UnE2djdsY05MdEtveGhYSE05dmRTQlJBTExrcStydFVI?=
 =?utf-8?B?dTBiV2sySEc4YjN1UVpzaEFQYVBMRys3OVVPamJBTkFmdE5iZ3lyS3FyL3VI?=
 =?utf-8?B?NmxZL3R3RDRYZWcwYThNd1NXN2w2aUVVQzNNbjhKYUNjZjgwMHozck5JRUJG?=
 =?utf-8?B?K3hEbGJLV0EwS2RIeXBaWmFscUFxY1JOVzFwYUJVK1laZmpVZldILzBXcUlq?=
 =?utf-8?B?NHVUV1A0RG0vdG5MN3B6Y3gzbWZpaUZQcU9KdlVTNE9NQzZicUNvOGVyVGhY?=
 =?utf-8?B?Rmdrbmw2WGRwRlNDTlBDUVlUbEc3UytodXU3Z0JhdkVUYVZoa2NaSjBoN3BZ?=
 =?utf-8?B?VFRNbnJJc3VBYWJtc3ZXSXcvZW03UFlxWXZ1QVFVaXovZmhEbXBSeXhNU1hv?=
 =?utf-8?B?Z1J3bFUzY1hrSzd4cmsrZ01FTTlJcjFBNVZEQ05zeEJtd3BSWVVMS20yd0Jy?=
 =?utf-8?B?SFRjcm0weUFIR0hMWFloS0F5NUl0bzh0T0k5dzYwM2dDQ3UrNkxYdGF4SzJn?=
 =?utf-8?B?NVRaOFRMS3h3UU5HMkc4aEtOeTlrV3ZNc00vWm1SOWJPTER6VG16TFZOa0d6?=
 =?utf-8?B?NTZaT0M5UU5ZYm42WGcrZVU1NGtlamhrWEdvNlUxYjJDeGtNM1R2aVBzaUIw?=
 =?utf-8?B?dWRVNm1XMHFrS3JmcC9yeThSTG1ObWJUOFVtQjBLMXZpeTNEVFQxSWRoRXZ2?=
 =?utf-8?B?ZWovQUJkNC9ORTlXMlJOT0UrdWlXV1llbWhlTDJ0VFMybEJRUDN0T3RBdHB3?=
 =?utf-8?B?UTU2QzVwelFPTlcyWm1VcVdzUDBNaXVNMnVwTXpPSy90MW5YMkNNeTJPUmhI?=
 =?utf-8?B?QzVSWGhPQkljYk12UjlPcUN5d3J4RG1pbEIyanB5clMzSHlmMGE3NEg1SFJu?=
 =?utf-8?B?QVFMNDJQU2h4M0FMMVlMWDA1Q1h5Z3JQZ1lCcFFvOVVGQitNSkhsblBmS0Iv?=
 =?utf-8?B?TVliWmtCaGd2WWlwNmJEMnFTQWYxNXVPL3E1WHhtdGhFNHMyS3pYTXMzbTBz?=
 =?utf-8?B?czAxZGFvek5aanZuRDdCUlBpTDZqTGpZM3d1T2Z3OEJXSVNqUWkrWW9nL3Rh?=
 =?utf-8?B?NzcrQnZ4NHA3N3gyb20zUmt1bFpwaFBZOTBHN2t4QlM1cCtJbys1OVpzVS84?=
 =?utf-8?B?anQ3VFRqU3NrSVVmZER1N1M4b1FqdjYvbzF1UzZZUDh5M3lYR3Q4Y3VpNEJk?=
 =?utf-8?Q?ETX7t/nMgxG7n8r43HVK4DHCDCQZ8EJMPOY6+uYPQxhe?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c80da2-96df-4047-6f81-08da5f914e3e
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 20:51:31.5676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AbAXvAkDud5ofDuwtZ68U4ZSuowpZMtdK5ZQFAhgLBHqkfyVK5Iw8Iu62TQXJB9xeaHDA4W7XOk4iKJIadfjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3895
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
X-List-Received-Date: Wed, 06 Jul 2022 20:51:37 -0000

On 7/6/2022 4:25 PM, Ken Brown wrote:
> Patch attached.
> 
> I wasn't sure whether the API bump was warranted for such a trivial change.  But 
> the fact is that some programs compiled prior to the patch will behave 
> differently if they are recompiled after the patch.  For example, emacs limits 
> the number of open subprocesses to FD_SETSIZE, so this number will change when 
> emacs is recompiled for Cygwin 3.4.0.  Is that a good enough reason to bump the 
> API?

Oh, wait a minute there's already been an API bump from 341 to 342, so I guess 
there's no need for another.  I could just add the FD_SETSIZE and NOFILE changes 
to the explanation for that bump.

Ken

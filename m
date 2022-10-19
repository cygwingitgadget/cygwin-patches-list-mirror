Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2137.outbound.protection.outlook.com [40.107.220.137])
	by sourceware.org (Postfix) with ESMTPS id CE5443858D39
	for <cygwin-patches@cygwin.com>; Wed, 19 Oct 2022 12:31:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CE5443858D39
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXRknuqeP3YNNqChTOV+aCAmNH5unIuHCoca+Rbo1TW78I6rV0P0Op7JJz5UH/GzhmpwZWSSEcZ3BJlabZx8LfyOZbdcQwO5wV1Qm9zxgN9FRIrjq6bhj2pEfYcQtfVeETNCxFP1wTLwH6v+Xa3MEeU6kwf8Uzz67CI8gvvcxw1T2p/RLD/m+neqFfNSyg0CKkylK+tEELRf/ws5o/bT77xX7vIl+gDg/yQ/+2Qnhy8yFK1yMCe6Mu70GUV06XArc5BLzEJMH1Fo4EWrSNwes7RV9GGhLSudCC7oNOQaEtCmqzSXgqdTAM9oRTSyBqryA6rW8sNo9PbyJUwkphaHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOdd7xmR6YjyiI3JdqyCyvSsyAuBzJZIgQH7G5J3OO4=;
 b=Xd/QZHUzu/HR4VIiVz0oFlbOvmdPjJDG8g1yasFzAJVk2jg8PDZgGE3c7C5C4GqcDsuB5dIrTCs55iq2uXDddOYwHaNYRROdnNXaxaIOGJ3tU3YzjhrgZ02LNmSwwpQIlajh+UT2A7YIY2Gbfbc7jaP91A3K3MTbBPve6YaW7PfMWOZjIcRjhaDk+kG1VAK/1tiRe3JqqL5soir9IrRslZeacvKvFY57l7ic3X67N9BeVw42WNZg9/PCKG9Idv1gif6UuuF4fqtsw1KTLNFJaREvPVXjq0K/c9tfZZdPxgW5083lCq/02ar8qxnSEflOkbVymkoAklvqrW4KT8/uTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOdd7xmR6YjyiI3JdqyCyvSsyAuBzJZIgQH7G5J3OO4=;
 b=hmopS/ohW5+QGagDu2EYg9HFK8E58ok4PMaPl7Gicrpsd7Ld9XYbNQpojIvLhdknjTgDt+mlxA/HXTIBwJVt9tmL3GFljDI/gJWx7f79ofKxg+Nw3jzcsWQ4olmTaFxGl1/hDjy3/9+1noemDQ0bk3/b5C3XqFVTauhb6Bae1hQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SA0PR04MB7322.namprd04.prod.outlook.com (2603:10b6:806:e2::7)
 by BL0PR04MB4964.namprd04.prod.outlook.com (2603:10b6:208:2a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 12:31:37 +0000
Received: from SA0PR04MB7322.namprd04.prod.outlook.com
 ([fe80::91f5:ea9:176e:ad14]) by SA0PR04MB7322.namprd04.prod.outlook.com
 ([fe80::91f5:ea9:176e:ad14%9]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 12:31:37 +0000
Message-ID: <7d0ba008-6789-abc6-d6c3-7289bd676800@cornell.edu>
Date: Wed, 19 Oct 2022 08:31:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] Cygwin: select: don't report read ready on a FIFO never,
 opened for writing
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <7163de6a-758b-5268-8ed1-eaa34fea7d94@cornell.edu>
 <Y07KMM0XyO6ua9/Q@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <Y07KMM0XyO6ua9/Q@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::29) To SA0PR04MB7322.namprd04.prod.outlook.com
 (2603:10b6:806:e2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR04MB7322:EE_|BL0PR04MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 2292cf8b-44ff-4960-0387-08dab1cddd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sYg19kXsPeMMn0oO9/6PhigILXqV9rFEbFQzIDTNBsnK9waJku9Avk05nVHZDpJgWs7wI8pypam9i2nywetBt4nskqXp3dJ0dKivTEosYGRcC7l7ai+S6RLKMEDzTrV+cmdKtDY6+z//UPq+vhbN8+e4vbXrJueWgvoGiGcV4bcmtYI+dvM4MJ7hRu2RpHlzzTNwkceuqzS6IjdqP0+mUbDIhZm26MqZm/3xTJ7Rb6KYYUhttg3mOgYExPlNia+VS077Pvz/evMUl63lCYJIJhjQernoyNldT0WQNM3FTIoMORXkniVpPeVeFtSlC2DmI+UqbpMA2uSKJlAxVKw7W7tmWg+E7MIFelrgicfA9Qr8a5YfjgjffS3qUPm9YbY0N7L3IDE2fa8oarEKL9+WztHnTt0+1ipSLib0BBUw4yKS/ASymaSX6xICWYM43anRfFk9qlfAHcMXG0nAmUndH3CmtDDogPmzXyTxlZrmgQ4Faxov52dRgCLZ+hpqsHv1iTAo1RRXvmP92YEYor1KOcl7zxIGg2Gx2wdEBTL5TFnm6DQo4ba+4HWNk1OfvBjhL0+X440oDsIRB9PsOE42g1J7NpbtSFQITFcsAU8Yz0MLMiP5Qmm7aqZKluQwxugFk+bCe4H6Sapw+72SC6UQH3fN3Gq1gAHr4ee8Ai53ilvw8wd6ziM9yYBJ0dDGQ1gOUIXkO91o5E85Wng92uinwMUUmRNeYaaNBbJIyYYnLgWOsedpuJAd+CYpRNDRS3us5AKiLaAGDdm98hRAumyRpIbbjWUowXnzd5T/9xQfx6Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7322.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199015)(6512007)(786003)(2616005)(186003)(66476007)(6486002)(316002)(6506007)(53546011)(66946007)(478600001)(66556008)(36756003)(75432002)(6916009)(83380400001)(86362001)(8676002)(2906002)(31696002)(41320700001)(4744005)(38100700002)(8936002)(31686004)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxPQWZJNEJuMVE2QXRYZk1remFQTG1iU3YrNEFRVnNhSE53SDcrMzR1K2h6?=
 =?utf-8?B?dVJEWEhSeWhISnNlTUhQQ21YQ0x0cnVFeG16aFBFWXZXUEt0bXVtdmlaNkg1?=
 =?utf-8?B?QThHUGVCMHFUMEEyOEtUSjZ3WUR6Z21sOUtRQXY1MkVhM3VEWnBGdnlRcXJt?=
 =?utf-8?B?cGpncEhqTW1zeXZEZ3dINWJBZHhpWlVwcU1Wdk14ZCtnRVRtMDNxTkpmSDBN?=
 =?utf-8?B?ZTN0bEVWT2FDVlBsRjBHZU5ObEIzbThjQW9jZm1XWXFVY1JYYWU2dnZDVThr?=
 =?utf-8?B?MnNrQjJnZmFoK2ZyWnlhT2Fvd25CcW9DVFZOZUxxK05McnpMTjljOGZ1ZzVh?=
 =?utf-8?B?dkpNM3pUNkJoZUd3QnEyTXBybkNBd2QwY2FGdnRxSkVVY2VSUEFrNFdoQnJa?=
 =?utf-8?B?TnVaOFhJMUEzOERuZktOdUZ3cXNRaDVtRzREd25KSkxhSnlRY1pVckVwRzFX?=
 =?utf-8?B?SE9jSXpXeXZSOURNRkNGdXNhQjNQLzZnRC9rTzdhbGsxZUtmVVlTK0x1NCt4?=
 =?utf-8?B?SjROaXVNNExRUGh1V1pVZGsxVVlmNGNmOExCS2g4V1ZiU2Ruc05zbTY3NFFY?=
 =?utf-8?B?REVkWEswbnVZeFR5NUpOSFQ5VisyZjdNQ0dobGFwSHJ5SlZna1JSdDRROW8x?=
 =?utf-8?B?UjU5RTNaWEFlNEhlU2JoSFlvMmwrbzdMQzc4Z1VoSy9Wc3ZRVHEzS3Zmd2d5?=
 =?utf-8?B?UlgyZy9yakxxZWxJVllDL21QZVdKemZZeE8yWWZ3d3ZpWXdHVmxCTnVTRHNM?=
 =?utf-8?B?WFAwMUpRZ21aSlg3cENidFluK0JmdE85amdmYnRNODU1ZG9PcnBDeVBpV0xM?=
 =?utf-8?B?dmVteTFiTUpXK3MrdENaZ0dDOUxFNno4L2NWUU1vZmlRaXJOa1ZxVnkycG11?=
 =?utf-8?B?bHUvd25mcGozd3ZBazhhRjRXYnd2YU9ZbFA3bWRua1NOOWhuM2dLSHVudVYv?=
 =?utf-8?B?ZjZYMkJkY3MwVHJiQXp0VXZjaDZjZWFpVEcwME9iU2t6YnE3U1k1U0dJQWZN?=
 =?utf-8?B?MFhjUTFpTWV1Z0sxNkhaaHJCQXJudTRWb2RYYm5GTTlKWDVLSWhXVFRON0lU?=
 =?utf-8?B?blZpbU41dFdhTUtJMzZIbkhMZTFBcmZWYStBUnNtTXVjSnFzUEQwUHRpUzE5?=
 =?utf-8?B?YTRRWWhrSlRRcGFYemorUTlLWUx4NnF2NUN4SS9HcmZiMklvRzRsWktBaUkz?=
 =?utf-8?B?U3Vab0pvS1BiZ3JXYzkyeGpyTXF1MHB5Z25yOXMyMWU1L2pnOGd0Z3RlMU4y?=
 =?utf-8?B?eDFtQUxVSGVvZC9aYXVTWHdKcGIvbEo4WklQY2VrWThPRm5YS05JYVoxOHhl?=
 =?utf-8?B?RkZXQWlnbEVJT0VlN1IvU3NUL0lEZkExQmpBc1RCeTE1WCs2U0FhTkhrS3V2?=
 =?utf-8?B?OEhHUk8zUmtMZDYvNUpiRmhneC9HbEl0UDUwZEtWd05SUTRvSW53cHZUVktL?=
 =?utf-8?B?WERaa0dJNmwraVFiSEhRMkt0cDc2NHVCQzlVenExOHVhemQ4ZEFNSzh3alVr?=
 =?utf-8?B?MXFhemtsTUxLenhWL3JNMXl0VFdRTDlMektUZkt1TDJYRytweVN3UC9icnVL?=
 =?utf-8?B?QVo3alFKQ1ZxS2tXaEM0ZmVyU2g2ZzhaSFhmb3YvTDBTeXpmbnpJSHdZOWtH?=
 =?utf-8?B?TDFUMFBmUUdydmJMdFhJM0FUKzdOWEErTDlteGp4eEpPVkRta2lkOVFHNFhN?=
 =?utf-8?B?cFNwd3kzWTJBUis0aTdPS1VzK2YwU24rM0JoZ0MxQWdVSHlIUGpWczlrU3Bh?=
 =?utf-8?B?SURXempDbmE3VCttZWVvZjNlbnpWZ2g2KzNLbTdnYklyNU5qdlhpanN6aTla?=
 =?utf-8?B?a3NOK0pvSWE2eFUyNm03L0o4amJVaUoyUmp4QVdKZTNwWmpnOWx1NnBhRUNw?=
 =?utf-8?B?d0Q0RW9YYUx5UGF2NDhWeEp2SkRHQW81UzMwdTBwSG03OHlOVlFyYTJwMUYr?=
 =?utf-8?B?My9yVjVIQk1LMWtWRjd6Yjdob2FGaUJ4RVVTUEVIYXpGUXFNQ3pVQ20zS0dv?=
 =?utf-8?B?dXVWYUVxQXptWURCMkgwQ3N0eDF0S1ZPRDgyNHRGcjhDMVdvK1RCVXVrOFNM?=
 =?utf-8?B?NkZrbS9xQnlmYjc3RzVQTkZib0ZvRGt5ZzRPMVBvZkpoSGEwdWJGSzMzN1Nw?=
 =?utf-8?B?SWdVSGRIM1MxMVhBdzdBaG5yTzdrQXBkbmt3OUl3dFhHcEpSR0ZkOCsvOXZj?=
 =?utf-8?Q?YZh5yqJx5YSTxnlJf2LzNr7FRMUtN53HSZE7g/RvU09a?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2292cf8b-44ff-4960-0387-08dab1cddd9a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7322.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 12:31:37.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeR4eDSNhjx4IFqNIwdw4F34nnj37jLrc/Rg8YOP1Bj8ExjVgvK/ZCGMiYyMeztGoXP6RV7vXeruo6lna+jRxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4964
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 10/18/2022 11:45 AM, Corinna Vinschen wrote:
> On Sep 23 11:31, Ken Brown wrote:
>> @@ -1043,6 +1043,8 @@ writer_shmem:
>>     set_pipe_non_blocking (get_handle (), flags & O_NONBLOCK);
>>     nwriters_lock ();
>>     inc_nwriters ();
>> +  if (!writer_opened () )
>> +    set_writer_opened ();
> 
> My personal preference would be to skip the writer_opened() check
> and just call set_writer_opened(), but that's just me.

I agree.  I've pushed it with that change.

Ken

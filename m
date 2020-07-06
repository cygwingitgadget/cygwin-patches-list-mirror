Return-Path: <kbrown@cornell.edu>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700097.outbound.protection.outlook.com [40.107.70.97])
 by sourceware.org (Postfix) with ESMTPS id C0EB43858D37
 for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2020 20:01:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C0EB43858D37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX04k6xi3HJ+pjqvU6lFUz+a6+tqhLRQMthl9EgVZYM88s+ZdEUli8Z20o6NRNoRKuTwJIwhIygAkSFMG6hoyGvR9j93PAFB7vDh2N9VvuC/70y4ACBWdgs1dW1hxUfarHh+CRQmCzqzUSDE7nFZ3bgPmFO5wYo1YYLIEePUMEaLhWaUz+v4iO5OoGTKhacYWmwNeoIA0l5YdhQtO3zskF0wM+QLTtYPRbBM1re94SsJ0Ujyfa+wcHLh9gbB7p+SY0IdQ6qtHVkDAcOwd2jQMvwH9BlQVk8RKWGRc8u0FvVD6rOC9nK8s9PA3yTowha7bXXjohB68mUOHKNLrBRkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvex0g0OjS/eskGIxaB6vXlYFDgSV17coLPFsaotT8o=;
 b=WKzmkbNrEAcSBkL0tV9fa8rVm4o5SEAE6NxY5FOFMHgBlHFr8FbjBOI/8hlfI2lGg7KvilPviyWYw31IcXF0ZgDhjXAHx3u76mNvbOpqZF0ZYWNkJLBLLa3gEI8hIKawcs8ZpuHf+zINqvamVbZGTlYqvwkHhxxRQwt6DwX44+xgWKaq1VuwCJsAIGtapm7qVgOvlulslEW6WqU7T43bOqzHABMCdy8tlrUjd7K0nWlcZjdSf9yptIPbqMlc+4eBP6djEIZPVUfFdATLaPqa/rMkZuP+8RK95UV4/QoDlEr5zfg+dBDZwM0bcYHSRmDW9IX42ZR3yw9lfcdAaVYQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5696.namprd04.prod.outlook.com (2603:10b6:208:fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Mon, 6 Jul
 2020 20:01:19 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::184d:a265:1d48:499a%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 20:01:19 +0000
Subject: Re: Cygwin 3.1.6
To: cygwin-patches@cygwin.com
References: <20200706195041.GI514059@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <5f9895b3-411b-0264-ed3d-8b576389f037@cornell.edu>
Date: Mon, 6 Jul 2020 16:01:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200706195041.GI514059@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:d4::41) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:30f0:e590:8455:3678]
 (2604:6000:b407:7f00:30f0:e590:8455:3678) by
 MN2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:d4::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Mon, 6 Jul 2020 20:01:18 +0000
X-Originating-IP: [2604:6000:b407:7f00:30f0:e590:8455:3678]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af7555a8-5e57-4d40-56e7-08d821e75930
X-MS-TrafficTypeDiagnostic: MN2PR04MB5696:
X-Microsoft-Antispam-PRVS: <MN2PR04MB56961F7E21709A0932261892D8690@MN2PR04MB5696.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/+mmkqWeFc/slzYBjfqx+4POobLp60X4oXB0HJ6jwnifN7VH215l0JvnyZK6+IR06sOR8LSKjP4CYXAPbaLJPu+gMFGiXW2XY00i4rQYX91xrJcWtZZZrzwHVwjx9YctAqTgc8P65CZHkQ+2EitNpVlSY3ji/7C7qVilQbAxLD+BzlX3vnv5pTI46Fu8Dy0y7ZWDhTC/6FPyTeUe/h0/e7ONS/oKByqJqtShwOoQ52OdMHC2g3GZCImzVT+BcmmhMR1+Zbz3kEsYEBT2vKIftRTwb0/vly0Jmh0XWbN614PUSR1HptzrfAZLURM6R5Yl89++1xuyCjaaWu68zbkPYuaOeI5XWOJAh92zy1K7PsJgArRUWh+nKiF7ZmY8ovnz1kzCY4Y1YOJ0HbMGD/ea5eCIIiFUeSYMkL0D1/QEqQdgoa1g/52Yzed8ikLmZl5w5Rn7R+fVOD5s4N0kxgS0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(8936002)(478600001)(2616005)(31686004)(86362001)(8676002)(7116003)(316002)(786003)(2906002)(6916009)(66476007)(31696002)(36756003)(6486002)(66556008)(53546011)(66946007)(966005)(52116002)(75432002)(4744005)(186003)(83380400001)(5660300002)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: K7iJuyG3SKTfUXuwNbO30HiaFPtMOIC01ThjYqo/v0Zm5OPUicJ35EoBod6j2bgOnXd1VfjKv/AU/cVwBdOv6CUS+01W1yM+t5nHFgUXG7NgBCdFqNt7XfcYwZLkV3GKLHmEgZvPtza/cg1s/pdEUBD0wQA6B8YoKyt0xSHODaJFm5RvYIB3Dh6gT0krX3eS3KM1lb5VKqNN+zZnabQTYuI+ZfrKGf41ePV7dfY98b0KLtTsmGKmVvzT41VsBBQgco5y5LT5EVJqsmndEYUfnoNQb881ztCIPkAR3H/KBUuurW1ap5uOxnXTVOCUe9ynU/UHDZKlzM74LlzkuZKDUbF27VwN5JgCF+hTOWe72gW2WjnCWakIAnosRErLBuq99ZYDx2zuPtnljKtfJh/uxnKBxB9m3+5q5uZIVOP2a5TdCf24zp7737ZuMzfO2cBy7freRCXonwgTo5teY4N3dWrtK/246qC+blrfZGYXCK39WSNnvX60s9KQ+Tk1qIQQ4fMeNB9wnnsGv8DGsRlMI88ONYq65Mt4rko8LtgseJA=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: af7555a8-5e57-4d40-56e7-08d821e75930
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 20:01:19.2126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+U1mfjcRvHASpSJtZNVO3qKbq3SxZYfkozpb9wfIbnZk/I5yxniWjA52zsHRv/cFl2FtCjG2brcsbmlm1hF8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5696
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, KAM_NUMSUBJECT,
 MSGID_FROM_MTA_HEADER, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 06 Jul 2020 20:01:25 -0000

On 7/6/2020 3:50 PM, Corinna Vinschen wrote:
> Hi guys,
> 
> Do you have anything in the loop which should go into 3.1.6?
> 
> Given https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=bb96bd0,
> I'd like to release 3.1.6 this week.

I'm working on some FIFO fixes, but it could be another week until they're done 
and thoroughly tested.  So I think you should go ahead, and the FIFO stuff can 
wait for 3.1.7.

Ken

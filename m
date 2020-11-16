Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2125.outbound.protection.outlook.com [40.107.220.125])
 by sourceware.org (Postfix) with ESMTPS id 4246A3857C61
 for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2020 13:37:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4246A3857C61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjMmXAxBIYILUB3zVbYMYyadYdh1f0xCaAfsdhUQ1//5ZUWNI5sf09OVZHHtgx8+m4CHqG6McqfgOGv9wvIWQgrQ0IlVghPxjsdadzdVd0LnfiJMF8cQqXVrPSu24NbdM+GDAJIbeABhDCpNMJdcHx5+hnyfpeEmRw96wCtHFxpxoEMEUblXnmuBWho/1LJerCuYa1SzIfFkDdszh6heDM+PjBWw006GbI47X0dGUsOvYwcGMj/oFlJ8GGRSnz80sDwCKYaIG0urHCKvxqDjZLb595FF9bIaMdju24OEkGeFLurlbmgToHZNcHKrAgqDISJnvK5vWnaLwSwmt3EHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJMkIm00pKCpgmzDRDnefQBtFsa2jwFHfrNl+I6brYA=;
 b=QwJRPO4wkbXch15fs5qXzE6rIcCib9uGScGSqZ8wlYL3+K2d1nfiOjgFQkVmlBEgcWNMwPhGbfn6//Pf1BCyoy2lbZ5T08AEFQsoMZmHVAFBSyiaUY4EHyP5V+KhKXhctTrgQ4a445kxznKk0AwbTVa028fcbpVe+z/pXtf2682xUAgRWrBWJZp3sUr4lTmtgHvBUoEKFU4id+hiOvqeJxN0/NzQHlBalfCf5cbQBqCToVCBbsiPE+xYndcP1GDizsFWvQkzClAqWfbjaH3Y3B749rWj7TkTEAuPcguRHFMaoIVqlOsy8fqss2Rw8lrlZ0uXZq9N9Hr7EZHoWb0iPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6045.namprd04.prod.outlook.com (2603:10b6:208:d6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 16 Nov
 2020 13:37:40 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8%6]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 13:37:40 +0000
Subject: Re: [PATCH] Cygwin: path_conv::eq_worker: add NULL pointer checks
To: cygwin-patches@cygwin.com
References: <20201114141625.24465-1-kbrown@cornell.edu>
 <20201116120816.GB41926@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <ed3d7938-2a0b-a805-9e64-c94a8954e237@cornell.edu>
Date: Mon, 16 Nov 2020 08:37:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201116120816.GB41926@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: BL1PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::23) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 BL1PR13CA0168.namprd13.prod.outlook.com (2603:10b6:208:2bd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend
 Transport; Mon, 16 Nov 2020 13:37:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6c807a2-1bd8-4b07-b3d2-08d88a34ca02
X-MS-TrafficTypeDiagnostic: MN2PR04MB6045:
X-Microsoft-Antispam-PRVS: <MN2PR04MB60454EF3455FFAB4E00D1977D8E30@MN2PR04MB6045.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OT74VxDRnAO1Ysl58GD47nTvO4i46/vwvk41xvpbvNf1GtqJRNbeBeee5jCJLHPjozfc45l5YvV2920+OlUoZ5mSlSsDXGL6Bh0h6DYVUYU0m4Ejoj3bu7bYfUqGTdelVSfpyDLToDd0lI1qsxDpxjqXWWVOBuBJLMCP9Dq6uWmWyC8uNU/JUJryfuzJyJPMjMnm9GA5x2xVykSWrKJ1XSKRF4QIHJ8gFM8UXtU5uBMJHDFglowz3yMb5kAxGdDqtPO8FYNwrf80OjTqfXX1jSCNqHIpxzNwwRXN6cL0F/7uhZkldFOUxuCllvlSiyIHpMW1m7Zsow/t6gRwYB/+YgNK7EvpZoBj7jt40iwbqqA7ojHOH4vfDKGcq41ij8kE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(16526019)(8676002)(2616005)(186003)(31686004)(786003)(316002)(956004)(6916009)(26005)(52116002)(31696002)(16576012)(2906002)(36756003)(8936002)(86362001)(53546011)(5660300002)(478600001)(6486002)(83380400001)(66556008)(66946007)(66476007)(75432002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7B+ksC0+t3aSLFlk+qFaptSn2DN0tB7QdJYaYhOlhkWAcYHUuuzTqeM0Kd8NnZuxlvx7iTqZXRaCui2DyBSanJT1jf7AG0BXTUmccl3Z5GODQAiumaZgDHyxf0WDnAPbKXUnBGujK2ocVd3Bb6zfbrwkabQBncezlsC+RWDDkz3OTAAXMQGvDTmw0KOcWaZUQptR+KcNwoMJYnjAnUUP2VT6sJo8uXU+o3mrYNh5Lp/GGFpY6lHr21/i8/3mnoJN5rACbLJ2iUeTnWJ6qWnlWT7I1nYLj9xoKfIdm/5elsxxleKBJl7ZC4ba6nuOtkWVrrw0dV4ygSDkfNJWZXt03p2/IbzrBntfwM7MFujiX3FSyu+zvqJt8TfypWgn41oB2QjXfrom07vwc7a/kVy4rwBbzuCB46Dil6NYPtIWi9wMOCCe4ukfpoQmH8hXlSdyGiO5cVwWN+m+/4eZ1IyEQYmM9heypGHrI200oFj7tzdmlLKxyPD/9FunzrXqQXK8gfunzB47rppSVQgfWHh3O9/o7HMEXWgT7yjTYvYzW8JDnxuYjsVC0vS0bHo+ovZyMX/B17rzEv3QEUg4O0LhW7jq6UCEtS1+/xjIn1rdrmxNSp/i7LW8gnzszWNb8KZnqX6MdOdODU9xKgE3NL93hg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c807a2-1bd8-4b07-b3d2-08d88a34ca02
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 13:37:40.8360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCBKDbPcea7KbZVGNK+uuIFahXawEIKqiD3J4s0GHf9msv9VJswsCVnCV4Aaw0ySA/2uL4zJgyqFkDmWxo+94Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6045
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
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
X-List-Received-Date: Mon, 16 Nov 2020 13:37:44 -0000

On 11/16/2020 7:08 AM, Corinna Vinschen wrote:
> On Nov 14 09:16, Ken Brown via Cygwin-patches wrote:
>> Don't call cstrdup on NULL pointers.
>> ---
>>   winsup/cygwin/path.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
>> index b94f13df8..0b3e72fc1 100644
>> --- a/winsup/cygwin/path.h
>> +++ b/winsup/cygwin/path.h
>> @@ -320,9 +320,11 @@ class path_conv
>>          contrast to statically allocated strings.  Calling device::dup()
>>          will duplicate the string if the source was allocated. */
>>       dev.dup ();
>> -    path = cstrdup (in_path);
>> +    if (in_path)
>> +      path = cstrdup (in_path);
>>       conv_handle.dup (pc.conv_handle);
>> -    posix_path = cstrdup(pc.posix_path);
>> +    if (pc.posix_path)
>> +      posix_path = cstrdup(pc.posix_path);
>>       if (pc.wide_path)
>>         {
>>   	wide_path = cwcsdup (uni_path.Buffer);
>> -- 
>> 2.29.2
> 
> LGTM.  How did you notice this?  Maybe a pointer to the problem
> in the log message may be helpful in future.

I noticed it in my attempts to do fhandler serialization/deserialization as 
we've discussed on cygwin-developers.  I was getting a crash when cloning an 
fhandler whose pc member had freed its strings.  I'll add something to the log 
message.

Ken

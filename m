Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2104.outbound.protection.outlook.com [40.107.237.104])
 by sourceware.org (Postfix) with ESMTPS id 9B72E3861010
 for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2020 17:49:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9B72E3861010
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOkjmjTYQzdjRuf86sf2QFJ3uKfxho7edfbGSIelV+vk5+rnuns0RDcbXRzKKPP185dboBOAj0lrpDBtbLz0Ul38ImJlRea1FFPLQdQwzLMFJg7L9duy5Eym82Rs7aUgO1YstEyQJULqDAAj6r0NId1hE6o10garzoPW2OwQ06OXaFSeUM2E0SMeqZsCrrF9IDCVl/Bu3P5FuKPgnVk97aYVlmTKYCtiCE7gZHdjs3WGdkZuuTuTtSFdjdbaUX9fWZp7PsYQnLKFyW3Xj0uQ6zSk7dKqsorJYfwS0pjm4oEtrvDAmgwTa4VqBcIP8My/T/iodqQMirtRRGv380SQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIiSqOqP1JYUkwID1F+1KTWAGag7G6PcqpzSeFuhPVs=;
 b=AlHUB43acrmddScBWUYi2PJzEQOw5d4EFUaFS0B68uj7JNcMet767wdwCqvv0hazDGRhUF16VjMcF+S+1siAJ1u0fN6n/IyYMxWP4lORo32ljfaZZj7WvAYwLTnrwABFxLrRxh9MIsnknUWctjUq6fqu2a2qBKdgeaQWOfugHmMi3jvD4TyY3Oqx9iR6XYrGxoWOJFBXq3T9OQZQKDnIWM3TusDHtko21GGFfxiIFBK8oaQNCoFKRUyx5DtetHcyNnJ5Srt8ADHNxUPzpSveQrSEV6p0AUDlL+xZYtQ49RlEqRxrEXOPlMjyHRST+bPzl7LSHaXc0BCnr2PW3QAEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5822.namprd04.prod.outlook.com (2603:10b6:208:3b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Mon, 9 Nov
 2020 17:49:40 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::113e:c874:1207:eca8%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 17:49:40 +0000
Subject: Re: [PATCH 11/11] Ensure temporary directory used by tests exists
To: cygwin-patches@cygwin.com
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
 <20201105194748.31282-12-jon.turney@dronecode.org.uk>
 <8e13e92f-7aca-65ee-8978-d0b6cd7b062f@cornell.edu>
 <bae783a3-1098-85da-c2b8-00a65db6e00c@dronecode.org.uk>
 <643396a1-21b0-88a6-3f6b-2eb2083821e7@cornell.edu>
 <666af9fa-194d-7b6e-a165-18f8d5169b94@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <2c5fbe84-338e-c470-68cf-cefaf5692613@cornell.edu>
Date: Mon, 9 Nov 2020 12:48:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
In-Reply-To: <666af9fa-194d-7b6e-a165-18f8d5169b94@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [68.175.129.7]
X-ClientProxiedBy: CH2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:610::35)
 To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 CH2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:610::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 17:49:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43ff9031-b865-4c4e-0807-08d884d7d540
X-MS-TrafficTypeDiagnostic: MN2PR04MB5822:
X-Microsoft-Antispam-PRVS: <MN2PR04MB58226F2BB0E45A293F736E56D8EA0@MN2PR04MB5822.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZFV/CjcXZHdn9m2/g93XvW97vfPBprE1Gj0qyOdjDPjL3iQ1nVUJFqcutk8jW4o2Q9fvkyBtz7DInAidYEN9roTp620I4OPCUXXSnamPZJ2mP5aX5i//H2vmULfWW9SfDBUTOIZ/0x+ge0K1ASjiUbTkRQEoAw3a9hKX08iuUW2h5lCxRG8lL+qyAZnR8QDHr1nIPNan06ydUE2JJXvfN3E58kN87YAFd8yOzv1H25jaAvnNYZw6VG3E+KYFjjVjP3jzVg9xWXDfpspkP6/IS04xK8JbhyI2Wjw+WqPvC9njIbgTj7XG1misqEuqmfVlFt9Wsm7D9Q+OUIPOLMifLR67KkqA5MGhLw7aWheTVJWFgDbkhN4rK80qwdQlFhK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(52116002)(26005)(6666004)(8936002)(66556008)(66476007)(66946007)(6486002)(8676002)(478600001)(2616005)(2906002)(31686004)(86362001)(956004)(83380400001)(16576012)(75432002)(31696002)(186003)(36756003)(5660300002)(53546011)(6916009)(786003)(16526019)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KPzEOrBIhpxA2xtRG46hWwgXkXJ18v/0SPt8Lq0QjqHCbKap2l7VvZUaEvgZK9j81/pSBCl90HYJ3cxvav8ZyZSNr+24LqPr+HU0Zo24u/pUg2p82/88hKhfI7dkfUtqIH+QSHM8u+I7lXICTyoDcMzRyHT7uP3/Y8UnSAWVMao5PSFZDYD4iVozDF3FmnULwJ6yJPTBptKUFDMWKkYhW8TOmhGpGmUCGjgPUqixFdUdbKZRSkSWGWcZuuYvxc1P+lgdTEj0Rd5eMYsUb4DXZUg9nHXQLwOo6SMgpV8XWrDnN8Q9VjcMyrz8dg7R4BvPEm6TZV+d+ialGSH6jGiMtHVftAxIDLn8ugLXv+8L3/BaH3IMTitegl9ReG2bQxEW2LruG80AYGDjOu8IdL6hQbaVab6SFnrmlJhXb2L4TwOsCVRw5Q3wO4/Nb2HYo/6IKWOEbHIyVMi5zxOr4EhIH5nCLqwNhAKN+4VlLl6mfnmjrOV6X5F6ye12fQnVVWmzkYKipih792Q6oEIUp4LYLZ1xxDfk/sfFurvEO9dNQTnjDmsUBZW2aln/uzBoHwfQaeylYchEfvV/k2vi8XNVX+e+uH8b23PJKcEG+nREA3QaMqDT7eXuN8Yb4meK8ZBwj/1GVPd4r/dog9J5JVyXCg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ff9031-b865-4c4e-0807-08d884d7d540
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 17:49:40.5672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSqkzpPhr7Vwv6jrpZSvDjKg6e/mNrndTpaubwJ31LIq5gdSAMWovB76YaDkSQIB95o0LwNt44OelIreTLYD3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5822
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00, DKIM_INVALID,
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
X-List-Received-Date: Mon, 09 Nov 2020 17:49:43 -0000

On 11/9/2020 11:25 AM, Jon Turney wrote:
> On 08/11/2020 19:27, Ken Brown via Cygwin-patches wrote:
>> On 11/8/2020 1:52 PM, Jon Turney wrote:
>>> On 08/11/2020 18:19, Ken Brown via Cygwin-patches wrote:
>>>> On 11/5/2020 2:47 PM, Jon Turney wrote:
>>>>> +# temporary directory to be used for files created by tests (as an absolute,
>>>>> +# /cygdrive path, so it can be understood by the test DLL, which will have
>>>>> +# different mount table)
>>>>> +tmpdir = $(shell cygpath -ma $(objdir)/testsuite/tmp/ | sed -e 
>>>>> 's#^\([A-Z]\):#/cygdrive/\L\1#')
>>>>
>>>> This isn't right if the cygdrive prefix is not 'cygdrive'.  Maybe use 
>>>> 'proc/cygdrive' instead of 'cygdrive'?
>>>>
>>>
>>> That's how I originally had it.  Unfortunately, test ltp/symlink01 relies on 
>>> the test directory being specified as a canonicalized pathname (i.e. is the 
>>> same after realpath()).
>>>
>>> Since there's no /etc/fstab in the the filesystem relative to the test DLL, I 
>>> think it should always be using the default cygdrive prefix?
>>
>> But there's a mkdir command that seems to be run in the context of the user 
>> running 'make check'.  If the cygdrive prefix is not 'cygdrive', 'make check' 
>> fails as follows:
>>
>> ERROR: tcl error sourcing 
>> /home/kbrown/src/cygdll/newlib-cygwin/winsup/testsuite/winsup.api/winsup.exp.
>> ERROR: can't create directory "/cygdrive": permission denied
>>      while executing
>> "file mkdir $tmpdir/$base"
>>
> 
> Ah, I see.
> 
> Maybe something like the attached is needed.

That fixes it, thanks.  I get

                 === winsup Summary ===

# of expected passes            253
# of unexpected failures        23
# of unexpected successes       1
# of expected failures          7

Is that consistent with what you see?  I especially like the unexpected success. 
  That made my day.

I think it's great that you're resurrecting the test suite.  Thanks for doing that.

I have my own suite of fifo tests that I run every time I change something, and 
it's very tedious to do it by hand.  Currently almost all of them are set up to 
run interactively.  For example, they might involve typing "echo blah > 
/tmp/myfifo" in one terminal and checking for a response in a second terminal. 
I'll have to figure out how to make them run non-interactively.

Ken

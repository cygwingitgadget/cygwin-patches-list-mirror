Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2130.outbound.protection.outlook.com [40.107.220.130])
 by sourceware.org (Postfix) with ESMTPS id 3132A385C426
 for <cygwin-patches@cygwin.com>; Mon, 18 May 2020 16:03:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3132A385C426
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZrS7zatFDmQYxvyyjC/UrzlSb8xzZv+GhUiC7h4nXbT24hp8cdGZPhGHU02YGixgEUtOijeaHpSEXrP027QE6pnS6kcKUpT5GmJAwtlpE1KYykP68BUsOKC63EjC2gfQi87YY+USyX82MamcbeVDX6BCD2WQUYJ9Mhf6EcdA9CADFFOUDD3OfP1Ft2+nxg9tnZrfDal7RfS3a/CqCpafllQsX/MWen3NEE5hxurUFQVQmR0LEEkcBjXTEnfVJJQfzVstDMWhQwvc1py2rnkFKNcMAvJ3rmx8dQZ2q88cqZCf9re32EzXFbdsMNZVwuYg3DWpTakn0jZ5EBHB0G2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3phBRcOkz0SWG4Uo9mqFZzPCX/lDz23rxXdaT2GvcvI=;
 b=K+VkzIUNBrkNG9NHe34/1UaG9B1OdkOGPS+01S8TrOal6sgd+Ck5Nbco8OMikgIQabzUwrh7iCvcIDbe23Knox/MUhXFbdSDmUGuEFe8Ny1kZ//Svna1Rv+B7lAA9skaGEI/NFzBEDihsb63JHraY7UzBCJH0X5ZeVxqg5EOs02TERQ9KIyfaAlYENRi6X+/Dh/OvLPjYtRSoyx9iMYhZuQ9b+XXQFeFoZV6fEY05Wr4wMHdIRKtoM03GCUO1dWDJALQjuOsTFB+pgaBrf+z+b9wqZviQed9wpKwCWonlST58p9tFRbn/1ge1MWikwGyqKI7JRYgJoy8PCxEraB/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from DM6PR04MB6075.namprd04.prod.outlook.com (2603:10b6:5:127::31)
 by DM6PR04MB4009.namprd04.prod.outlook.com (2603:10b6:5:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 16:03:48 +0000
Received: from DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4]) by DM6PR04MB6075.namprd04.prod.outlook.com
 ([fe80::f48b:4e13:94d7:f7c4%4]) with mapi id 15.20.3000.022; Mon, 18 May 2020
 16:03:48 +0000
Subject: Re: [PATCH 00/21] FIFO: Support multiple readers
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20200507202124.1463-1-kbrown@cornell.edu>
 <20200518142519.cb6d805fa92afe4dcb017b02@nifty.ne.jp>
 <20200518143657.4e9f732f5456174348688f69@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <912d46fc-3138-f3ec-f4d1-612433d9f128@cornell.edu>
Date: Mon, 18 May 2020 12:03:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200518143657.4e9f732f5456174348688f69@nifty.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:610:53::23) To DM6PR04MB6075.namprd04.prod.outlook.com
 (2603:10b6:5:127::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:650a:68f2:73c8:4345]
 (2604:6000:b407:7f00:650a:68f2:73c8:4345) by
 CH2PR17CA0013.namprd17.prod.outlook.com (2603:10b6:610:53::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Mon, 18 May 2020 16:03:47 +0000
X-Originating-IP: [2604:6000:b407:7f00:650a:68f2:73c8:4345]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9621e5a1-7de9-414c-502b-08d7fb450c9e
X-MS-TrafficTypeDiagnostic: DM6PR04MB4009:
X-Microsoft-Antispam-PRVS: <DM6PR04MB4009EB86927B04605CD7A734D8B80@DM6PR04MB4009.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /D8fBjWSN89XEGpdc2VAXCChowm4FXJLVx7BAqfrLqg0po7ptSpoJVaqBfHVvYahL6t++uwTEGBPJu5Ef2Uy4NNLQv9tQgFcQeY076M1tnWJD0oiY1DCbAzH/6dW4YCE8XQwp7Q/SJNSmrWb7bAR9/6+WjzMpgMPZcMAMNjwFGyswPiLBq4bJK1nYz7yUf79sBlXFYaGQotdxLkbXcbAlZ4Z+YxJQZXTlVZUZ2mvnjTEmrvinu1gdRBN3+27FRrM692UyqRm+xQK84wDMtr8VJIrAWG0IeLSmhTAl7Ffj1ii+C5D4fTCEHUfbH/qG2VoPtKuLzepcsKx/3Lr10sBFY4DFG6GDm4QcoFHAXXLPKWpbDa/AKAW3E6AFtq3a3stRa/3/fg57LfEeZbNW9ERJ7rSe8AKE92iprsT2SfdqKVA30d0+W8V6f0Qc9/SmQ4fxr8D6XVHSDKuEYcET/ciwEg4l8wS/FtDZUmvRMewYfSUX8318G9J8Cw9DWYVUaPf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6075.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(4744005)(186003)(75432002)(316002)(86362001)(31696002)(16526019)(786003)(478600001)(6916009)(2616005)(5660300002)(66556008)(66476007)(6486002)(66946007)(36756003)(8936002)(8676002)(52116002)(53546011)(31686004)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DinBxzJthFzAd5FiOQ3TG6mUjN+qRi8enSTK8FHThr2EJcGnMVzrMr+hWvFnfuX+KsxV7Yy/1g30ktU0wL6sulMADVJwuAUTcZSbMKXzX77caSktZlw/lUztTYTNWpkRaAa+E9PJ9xbCjbBcP9z6WO4Z3oDMnV2jWDXiBQNpNo7T7Zn4WcxP+25eyaP32aahD34MNJWTNR+sfql/mubzhVt433cG51ApkkssVN8F8OkWjHGq0VMdoUir2uoO29FTPERJwzbCiQcO6r8uyz22zapABJoeQVbKK2Lr0tZiUPeLSpfEkj3t9G9QcuAW+on5IAsBeDDK3RNi6A/AGQpqBcqLIZaU9hFuKyrZM4xuBmjEnoDyByuhp9oGcGjYeEAgEwA1NiFJXZ84Tu7Qt5pkDBKSzd39+2ehdu/VlXM0ef9fpTZCbxhMBA6ZzxN4qTqh2Bfqkj5FtA2RzQSsoiFwNp0rUoB+gZv+aG/b3f44NFtFBtpNQ++W5YYFllzgZP9Y/HSpYnX4MFUa4cCJv2jIinWgWZUwigPub8fQecziPmg=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9621e5a1-7de9-414c-502b-08d7fb450c9e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 16:03:48.0250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkUH6b5WSdlkQ1T6dNAJHJcA1Sw+nuEPo8XwfX3e+sV3Y/WrQcQUC4DfhnkoGtCJUWBMAWMAGBkdfJHJU7xAcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4009
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 18 May 2020 16:03:50 -0000

On 5/18/2020 1:36 AM, Takashi Yano via Cygwin-patches wrote:
> On Mon, 18 May 2020 14:25:19 +0900
> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
>> However, mc hangs by several operations.
>>
>> To reproduce this:
>> 1. Start mc with 'env SHELL=tcsh mc -a'
> 
> I mean 'env SHELL=/bin/tcsh mc -a'
> 
>> 2. Select a file using up/down cursor keys.
>> 3. Press F3 (View) key.

Thanks for the report.  I can reproduce the problem and will look into it.

Ken

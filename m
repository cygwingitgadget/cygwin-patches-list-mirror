Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
 by sourceware.org (Postfix) with ESMTPS id 3F5B43833012
 for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021 13:48:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3F5B43833012
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=kbrown@cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+RKWdIGntW0caHz2Of/M3aWvVbYU6WOAHv5FqUXLdXLaOJ4r4Go4/La8CY+a1X08IdDQ4kzcoUtpaBuvISj0bXU43+eTShaZFHW2vJYMMcFdMaD+qqNMawW/gPXl9tKTZxSqVGRdIXzP0OHBVEFynd5mupljLvQ/gmN2pkk2o9FF5Pi/T96V69FPNpdvZ06Jdo6QO/LqcgSnPFbPySB0Ia8bvhda1exhUKxj/9Me/U1RYBcsek5QMjCS6IbnIUmSt1ISs05m3nK7G3OtlAAPMv7G9X7ILmMBgKUcW7aLStkS0QVokBSIyun3YMTLcqQSAAChOgywrJhfQ3j3OVuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK75rdebOHGYgfxQXcr6eLLvtwIi4TOfK6HS247F0V0=;
 b=AyyC7ZqujrtTX8Nb0+wS+2D2ZBkFSSSYoA9SbLFVds8pCCznUkCSyfkJYBBpXVWEr5ePEhbd5A0vpcuwkBmzAf1XHwjIz29Vqnjkp2bO+X2QP6DDcCnbzcGyk9njN1cjItgQKKn+u8B0tl9XiYhwhEYHqiiaT7ljhLrdMYBUrqX7QBiM5uqcPqP5Hji8HQttfRYdrdIyLZspqEoh1/OKPl9rofCxMkbLc7ex1iJuD1hJTGnBFJMtYDez1zWGC1rAcxBwHipPGLeYJghvOM9mpBMlGnv9cwJQ5vscAe6ULm16LT/mmsgrV8t11TZmptC0MK6oAbiQdHdpSFKgivMR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK75rdebOHGYgfxQXcr6eLLvtwIi4TOfK6HS247F0V0=;
 b=CbNqrgpBEpdASKj3I3Bby64B9HFiNbYQDBJxrkpyeISQtnAWPd0GGpZVnKXIAPPx0ymfSe7pwi/NaJmFWN8aHWiQkqSsbyjGBp82D6Ib/LNBBf9nOvkRLW/CiM7i6VGn+dcOdgTXkAShVlUJBLw79MgOHG4QvXWY7Z1KyJU4A3w=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0242.namprd04.prod.outlook.com (2603:10b6:404:17::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 13:48:37 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89%4]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 13:48:37 +0000
Subject: Re: [PATCH] Cygwin: connect: implement resetting a connected DGRAM
 socket
To: cygwin-patches@cygwin.com
References: <20210426193701.19895-1-kbrown@cornell.edu>
 <YIgPbG6NoGqxyrAI@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <f46d381d-07bd-98eb-cfb0-e87f29dc8f8a@cornell.edu>
Date: Tue, 27 Apr 2021 09:48:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <YIgPbG6NoGqxyrAI@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BL1PR13CA0435.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::20) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.8] (65.112.130.200) by
 BL1PR13CA0435.namprd13.prod.outlook.com (2603:10b6:208:2c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend
 Transport; Tue, 27 Apr 2021 13:48:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e7a873a-38fb-4a9d-ad4e-08d909832878
X-MS-TrafficTypeDiagnostic: BN6PR04MB0242:
X-Microsoft-Antispam-PRVS: <BN6PR04MB02426582FE6DB5D00C958FE2D8419@BN6PR04MB0242.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLMn/OhFAjGgcWkqZVBj+aqaUMctKDJOqgEtTLZkGfQQ9l5XuY0vHwSTMXr1qdi9C9dVVcweEXrCp75QUGHOqiBjnKcMs6r3tD9hgHYSjdQLcyeZA7X090p6Ih+s4AcBWJaAMY2vo4mn3aVRuB6FF5GSvA/wdCD19H7N2+sDTbOvUcU2ukqJbgJfQSLMiUg4+jtcrWstTsM7Ylo7CHlL9d/l/255OEuoynZUdajCWaBqKVhfeE0JsNluN/qRvV4hAtod+4nCgTU2mJGGr8OKJXf09Jqy+wonjsyiY0Pre2jW0Fk5k60fKE7ncLyMhhldFqz7X84ZyV92OijxHo32hgc22wjXsr138atDkQ5koHkcEz4vDQ0i4EME0ODorMxN9ueaOVFn08dXkTIpJxsijKDeQzLz4hxfRkHyxxodawJYuNdcnlwl5ZJwkMAicFh4LvGpXIQo5FKM5t8ZZYcJnTNFVDlfmqgdyF2yTD9bgKYgSe3pp5U59M47Rz02aTgnp5MxLQHMns3eqTTchMM90+jLG2nJp8vuslnCEJtFhvZgUZQlQXbNNnTbVmNdFTL41jYRfh2rlYa2m+aADZXwZ7RuRpXSfxxSQp281EN00o4BdhLG3osiAIBg5TV4yRnaH5druuO0Z4hsfJM0YcaLUqu1V2kBss4M1AgDAuEuWAvI0AhFZPZBvbiH7I/+mpng6wVncj//vS1yU1o5nXwV0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(66556008)(36756003)(66476007)(186003)(16526019)(75432002)(66946007)(31686004)(8936002)(316002)(2616005)(478600001)(956004)(52116002)(16576012)(8676002)(786003)(31696002)(5660300002)(86362001)(2906002)(6916009)(83380400001)(53546011)(38100700002)(38350700002)(6486002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?UhEUSn9f192AbQ2wOcq5/JnXffWdO4SCf9ugjWzjSEmFfu6MhWgN/FRy?=
 =?Windows-1252?Q?CBgKlGgjdNQ7WMh9xrzSFuLrFKekINcYXvJK56Vdjbxzl3JkKtL6reWO?=
 =?Windows-1252?Q?2aLl3oJuHsrAAAZVvxG9fwUej4Qoj+i/8hC/UaMVd/QKP2YP/sKHaLwN?=
 =?Windows-1252?Q?26K0qHO0AQW9nSuh1DS9+VR6S7mv+0V7eYrYFHqEggzoRrY6iXwdo5th?=
 =?Windows-1252?Q?PO9pHtzFAS67q1yCCYEISv7ZbYCSf+WSVJYClAMs1Zf+j5d8j5r0sBff?=
 =?Windows-1252?Q?s7eFBrvr2y3Imd/InrMUMsUzW3m+iTWGW48S9DLWdBrGcIgH2QRGfZzF?=
 =?Windows-1252?Q?Zk6zlIgF/XXJIS8ertldc35cdCAvFE3PQX6DIpaTy5UNsuM6S8PsRa8n?=
 =?Windows-1252?Q?RJ5zNdfDrWjC21WFDxybr8U/SC2AOuNQSsXj+MLQ1rpdM3DLChEWQztM?=
 =?Windows-1252?Q?0hO8tf7sTvkZ1q8z4YoErX1jDA9/DJodGAJl0mCb6LNKu98qnBNt00Do?=
 =?Windows-1252?Q?wpXvtgR7J3sRp2bV0KDTyvKWesr/eckv0fWWQ+iPMJIP1DGM44BwJjtP?=
 =?Windows-1252?Q?UTtRDtolpcnang8w2X7YUdo8n9YIF4S/74VC3QJNROVIQ7tU1lic137A?=
 =?Windows-1252?Q?IeLcqZQM5elpTFJej5fmDfCkesWjZiXdDvEzyELBAtIdq1Tal74CfN/m?=
 =?Windows-1252?Q?yH/jE7fBqfNZ3IsFk6zSDuBkDQxpH3kpPe93QEBDEB531g8jGMTmcEfP?=
 =?Windows-1252?Q?nlUwQz89oIBfAt5EpoIqxztgvfGWrLnt2QTfre0vwVel9vm3yQ+iI1mY?=
 =?Windows-1252?Q?WFVtipIx/5pUiylzSwtvZu0FRlWryCuYww+rSnuL12JM/zYFI7Fvn9Hz?=
 =?Windows-1252?Q?WnpPUYr7E8Oczype2FDJn8yYz3uNVAJrqbvwpSe7G8y6ZzRLAuyHo29/?=
 =?Windows-1252?Q?uSL6ZO7wPTOQuUu0FZ5KZfN7brySL8KfTg6E98EDHGoon3uWRG8wL9Q9?=
 =?Windows-1252?Q?8wC8XbhIAIS9JXZQ+ONV1iLIBvYqL6uWx1oWw8IscTPoyrSKNwOvKmuJ?=
 =?Windows-1252?Q?CsmCoBSvdGSbAQchXgxo1SjZcjmR/3D1/jwPIk+LxEbMilm9tTRB8sux?=
 =?Windows-1252?Q?0L7V+Mi5h/KxAf33+3CDV/LpUMwp/O9HqUHZcG7F+4wNeAghsUuTI4r8?=
 =?Windows-1252?Q?ZZ32be6ABY7KcPR+a4slOJjoaFawqZquvBpiGfiY3bHNo3PMt829w7TZ?=
 =?Windows-1252?Q?Iw7QeuyG9eYbNqzpN00Uobo/y+Z2m4R6eH58Tv5NpJ6D+s5lhnt5sV5p?=
 =?Windows-1252?Q?eygRNJyQlnIC+cVP+R9KGEjLYhreu//dEQwd7s6iXUIy734AYPsUEofc?=
 =?Windows-1252?Q?8RoYuErdJlDtblhCn25Enqg+mVjI6OWydbk6NRY4M5UPb0SKPppssUIm?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7a873a-38fb-4a9d-ad4e-08d909832878
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 13:48:37.7237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u935Xpzr7BOTJKcltXiYYBI+qaxd9OgtcM+a9sT/hdahG+hmnIJTouaXvh54mOs2ZzN1FnwKzBwJ8wnVPIzx+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0242
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 27 Apr 2021 13:48:49 -0000

On 4/27/2021 9:19 AM, Corinna Vinschen wrote:
> On Apr 26 15:37, Ken Brown wrote:
>> Following POSIX and Linux, allow a connected DGRAM socket's connection
>> to be reset (so that the socket becomes unconnected).  This is done by
>> calling connect and specifing an address whose family is AF_UNSPEC.
>> ---
>>   winsup/cygwin/fhandler_socket_inet.cc  | 21 ++++++++++++++++--
>>   winsup/cygwin/fhandler_socket_local.cc | 30 +++++++++++++++++++++-----
>>   winsup/cygwin/fhandler_socket_unix.cc  |  7 ++++++
>>   winsup/cygwin/release/3.2.1            |  3 +++
>>   winsup/doc/new-features.xml            |  6 ++++++
>>   5 files changed, 60 insertions(+), 7 deletions(-)
> 
> LGTM.
> 
>> --- a/winsup/cygwin/release/3.2.1
>> +++ b/winsup/cygwin/release/3.2.1
>> @@ -1,6 +1,9 @@
>>   What's new:
>>   -----------
>>   
>> +- A connected datagram socket can now have its connection reset.  As
>> +  specified by POSIX and Linux, this is done by calling connect(2)
>> +  with an address structure whose family is AF_UNSPEC.
> 
> Isn't that just a bug, in theory?

I was thinking of it as a feature that hadn't been implemented yet.  But on 
second thought, I agree with you.  I'll change that.

Ken

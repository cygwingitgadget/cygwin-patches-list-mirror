Return-Path: <SRS0=GR0f=NE=cornell.edu=kbrown@sourceware.org>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:2416::701])
	by sourceware.org (Postfix) with ESMTPS id 1368A3865474
	for <cygwin-patches@cygwin.com>; Sun,  2 Jun 2024 19:22:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1368A3865474
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1368A3865474
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2416::701
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1717356169; cv=pass;
	b=b1eMtAsfluU6K1PDmFJokU7KER6w7Jpol9X+t8my6eQCyIkoTVmnoxi8i6QR6eSJak9qFKxAyI0VsZuLWXVTs2FrWQKSitHRoaCNxe3bUktwE9lqCacJlbaR1sl4LIa1TIRrZAmL18atXZsFNRe1AFIpNbPw4YOioSX15im00F0=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717356169; c=relaxed/simple;
	bh=TMgXL/X4fA1hE2ShkHh8yKOKxNl7Z7TndTicxxfBfL8=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=jwZs3u+OGlaHSVjhOWU9jSa3f8/2IIcoaTD2HPT4wk4H0GdLiQP2zyYe84NLFWIuP2k6TUDEVU/YYuL69hMsm/1EDrxXlB8yMb64rvPjQu763W1yDCHZQWLV3DqF6Q84/NY1Wp3NlFYXU8akAy4jTvjg25F95ZcjlWkQULLBUJA=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DosGgCGq1krFm3KCq0w25tAdjyg8JTOMg4hNOv5/wu9eTPvSSZsosNpcKHVonGyQekY45STUoJ7lslq5KQ+fOb7K7wUhOiHN2KQFQ5zZeNN4r+sbuTfqs4BSlyH4eJPENJIH9w7XOhfxGGTiXjU3IlT42l6SF8suSm/sPN6Fv3IYgFY/vX4yIazsXN3l3wJyk/g73pGtjZpCx4WiilC1dZsXw6ZE13CKd/GUmxnuzhLREjuceCbUKpNtKOq9s2a0ei/o65NzaT29/NxWFuH/qD8fbOWYH418Ck4mKykFR9CAA9a8vNYMsqb2RsTGqDV74DWmGr+UqteUYkSqnOkHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWbqEziKBD/WAyw7bGADg2SYj+Foqgpc7y5bmHRVBLo=;
 b=Hk+hJWZMvnerA1EEnpoxijAHl8d0d2o1e1srNfHaNjQTcfIAHky1r6tPxTrG8+5ag1f8txojrwm2fsJilfjV9BS8sbzDPvvnwa2mDHv3WJXXoDlwHpgIZLQqJJn1tnNDq+yDLZg6mfneaXFSdy8CbtyKq7ySwtANiS+ulqYze1Z75Ue5swZDBRB9vCTHE7EH9kij1OxrVTxbH+WBecNG0SZj2Da2mQQUwODAmIA5ivuxOLdOkjYwbCybMVOJJAGhq4gghx1rI0LiUWCXA0Xl6w/7Tj/meKOMo+YOLAoyIPW9iAgd+z+GFAXYV/kZz6Oz9Flmt7dc2GNLNbnlvdOSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWbqEziKBD/WAyw7bGADg2SYj+Foqgpc7y5bmHRVBLo=;
 b=SOcpFlUwPvlGehrZQUzD8Lsn8yLEeSDJGVpJ5uKEtgZ9VZhGR48kctIImPIfLvQa38i0YbDP/Ban3DV5edlKR7znA9K4giC8Duda5ecXjovl68Babm1F5PIoX4JkxKyrccLIbs0lwV7ZHVBF1lUTbfoX+yib56lvbsCLfcXYYTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by PH0PR04MB7850.namprd04.prod.outlook.com (2603:10b6:510:ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Sun, 2 Jun
 2024 19:22:44 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 19:22:44 +0000
Message-ID: <faafd9af-1d68-4153-b906-9b0fd5582c12@cornell.edu>
Date: Sun, 2 Jun 2024 15:22:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Cygwin: disable high-entropy VA for ldh
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Cc: Jeremy Drake <cygwin@jdrake.com>
References: <651f7e9a-8f59-7874-75ff-be82153e9dd8@jdrake.com>
 <20240602070342.b53b20f7361d58e338dc3618@nifty.ne.jp>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20240602070342.b53b20f7361d58e338dc3618@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::6) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|PH0PR04MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: e14a1f88-4adb-4ad1-9fbf-08dc833960cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2hYWmI3UzlEU3Z5TjRKK1VUVzZzSGc1eFhtTkl2cmUwdmZ4b1dFWEVYcGhr?=
 =?utf-8?B?b0hNejlON0pYeUhNOWhuOHlvWXQxZ2NkWTVNaWdDY0YzTFZOM3dxRFBOVUdK?=
 =?utf-8?B?SDZCTkdibkdnNG9rbTg3NlNmSHR6b2pvVGI4TndQUVNIRExtaUIzVDRtQmdN?=
 =?utf-8?B?eWRyZ0JneHdXM0wwTjhTeEJvSGNCMklzSXZwNkg2YjJZbnNadEFvMC8xd0Nq?=
 =?utf-8?B?UW9IQ3VRRHU2Nklwa3FMUkJiZlE0eFpXZWtKcFJVUWIzVzZSQk9xcHd6SlJL?=
 =?utf-8?B?Q1FSOGtsbU01dExsUEZFbFlhNWtaeFZRNlkrR0hWY0NUNTdZaWRwK2xJVEVt?=
 =?utf-8?B?K01zRmE3bjVEemUxbW43bm1hS2xtRzN4OW5RcStlck1UYXJ0YjNuRGJCQ25U?=
 =?utf-8?B?RXJEUStPNlIvcExkaXYvNldBRmVIMVA1amlFOEFnOVFEWXNqRDE2M0g4Q3c0?=
 =?utf-8?B?Q3FkZEkrZ0pCc3I5SjFrMHNVdmRjMlp1V2tVeHZEcTdYMlVOT2RkWnV3VVEw?=
 =?utf-8?B?SllvOC8wSVEvVW1lOENaWi9lNi9YdUtDdUtLcUVUbnJ4NitJVDErQm1NSnVI?=
 =?utf-8?B?Z2dQekNQWlhNRDJtRSt1MXEyaHUrUjZNbmFOVHRyZzVZaGpLKzJVQjRIdkg0?=
 =?utf-8?B?UDFnYWgzcU9VWTkzTmVXOVU4eWUxMHplWDJMUVdRMzhCWHNtaGYyRTdpclRU?=
 =?utf-8?B?N09OMk9XNXArZ2plNHBTRTRZamE5eFo3QWNEa3A2UFJXbitJc2tCODh0K054?=
 =?utf-8?B?YkNNQ1JyR1dXdStPZVM4NzRjb09rcjRyRXgyNGJObEtkR2hSR1JXT09rRDc5?=
 =?utf-8?B?ZEN0RHlELyttc2FTblhrRUdyQWlUcjN4ZFNLSUdNbnR0ZlN3SkMzQ1Bxb1gy?=
 =?utf-8?B?SjhyZDh3NTBINkdwOEt2UEZCWWdIZXpmRk11OGszcmczdVkvYVE4OW13RXRp?=
 =?utf-8?B?VHRXRnRtckRsSUY3QlQ0eDZ3T21JbWM1TldxMjQyNGxvUVZQN2Z4L0p2a3M5?=
 =?utf-8?B?RmVPZVZSdlZMV3pKa05oYWcxdUx3dlVBbzc5SDFYME13YkY3SHdMRkZRdW9R?=
 =?utf-8?B?c0l2dTZHVFBuaHlUMlFiWTF2VGtEM0JGdHFHdjlRNGpBUHpiRyt6N3FuWDVl?=
 =?utf-8?B?eit1aGVsaW1rcFgyamlmTFRBa3FTMVdyTTRUSWVrS2RNWkhrWXRFVVRzR2JT?=
 =?utf-8?B?ekZoT0lGNmd0MHd2N01GdU5ZMDNnR09QdWpoK3RDR2JsNWZzNFExOFpBRm1S?=
 =?utf-8?B?blBUQTkwVi9WQVQ1cEtweHNaNitkQ3A4M2FIbEx0bC9VUUkwK0pweDVvQUFi?=
 =?utf-8?B?KzUzQ3g3bUlWOUF5aFBVYVZUVTlUT3YxdzZEeFI4eTdMUUFySnprRGhUOC9H?=
 =?utf-8?B?cDM0TlE3dGNyeG9qZ2xaY0t0MjFmSkdxVmFmdU9aNlMwVGhXb0ZhSWp1WjJ3?=
 =?utf-8?B?NitiQVRlYkpteXRsakNYOGRKZ3FJV3ptSVNJcU9WV1NHTytlUzFtTXdoY3Fj?=
 =?utf-8?B?NGtKdXlRcW4vRjMzaHg3TitqZE8rYWxkTC9tdFA4amJMY1RManRTY2xQR3Q1?=
 =?utf-8?B?Q0pWNDVmSkxadmxZWmdUSmJkbG5oRHVwTnk5M2xTTWQ4QnFVMVo1ZlFSU1ZR?=
 =?utf-8?Q?AkJA9yV5nFNpDHJscyjh/At7G6fcPextax/rOOXupkaM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M05EQXdJVTNlaCtTaUdxY0QxL01QcWJISU1UVnVidWcxei9EYmZTQXdMbFBo?=
 =?utf-8?B?Uk9zNm5yd20zUDk5STRTMlhreXNlOXhuQVJiQUYxdU9nL0tOZVViUHNhai8v?=
 =?utf-8?B?U2toYTRLeDhJQmU5Tlo5S1hyN3lOS1h0c2poTzlXcTU2ZG0vQTM3VFRHcHNR?=
 =?utf-8?B?clNrSWVUR2FFWUtaU1FtZ1JqcjZIWUpQV1c3VGhkamtXV2NNWFZ0UUk0SlZs?=
 =?utf-8?B?alNiTWtJNmttT1F3YXlQemlMWGdhVmkzMkppM1lqSTJ3Slc1cnE3ak5JS3hD?=
 =?utf-8?B?UVphRURIT1ZIUEdJYXFPaFpVbVREZVlMOEFKZm5jZFZCRG4zR0E5M3o1bUoy?=
 =?utf-8?B?NkZCYllLTXlEQXUzTzMxV29LU0ZHeVdtSEdnRjA3Q0JvdUhHZ2tRNFdaWFdB?=
 =?utf-8?B?SGQ3Ykt6SlpnNis3OXRaKysyNnAwc3dPZVBJTVcvcVRsTyttZDFZT08ycUM1?=
 =?utf-8?B?K2R6V2dwRkFtbzI1ZUtTSVdLQm5WeVUyempLSWdmRFVrZDA0OTJBQTFHNFpB?=
 =?utf-8?B?dHByTjEyZEJNNnJuamp6T1RWdURBeUs2Vlo4QS95Nm9kM1U3Wk55RUdEeUZU?=
 =?utf-8?B?ZmRyQVhRQ2NNYjRnSTNybXJuZVcwYS9IaXhYK0t0MEhYcUlGbDhwNTFqN3du?=
 =?utf-8?B?WFRnTEhvRC9yenNLWTJibGlSWnBzRW5aMzFqeHMxN2VqYXlQWk9aUytRblEy?=
 =?utf-8?B?TTMxMlY0c3VvSzdTMlRNUjROeFQ3ZkVRenU4cXdnWFV5R3JIdEZJMnh2THhY?=
 =?utf-8?B?T3hDbUJFSEhidlF0NEcxdzhFTVhTOHRnYnhyTFZyeW5VU21McXRRcE1QdUgv?=
 =?utf-8?B?S2pkZWFscW15aTdQZHhnTTJsVG5rbnVleXU4M2RkanRuSlNvNU9MNDlmMXpy?=
 =?utf-8?B?V0p3UUhuR2hKeXNwVUE1REhJZEVwSXlhN1VTYWg5VFJBM0NYTDBTZDY3bWM1?=
 =?utf-8?B?Ym5seUNaN0RKNWdMQmxkMkRtUmRGZXRSaExYOXdWdzZHMG1LMS9HSndJajNx?=
 =?utf-8?B?QnQyMUlhMk90V3J1N2d0TitOdUd2cU16dkt2WFpzV0dsWkw5ZGdOWDlNV3dy?=
 =?utf-8?B?NHBzRlpjaU1QRDF0QTlMU25rQTFaS2t4bHpJa1VwU3k2dVFoMS9xMEg5dlo5?=
 =?utf-8?B?cjJuYmx6Q3p2L0dDUWRkL1dyMVA3WXVIdXpiZTN1d0Q0bnVsT2ZYazVjcWZY?=
 =?utf-8?B?N1NKTjdRQkx3TGJsZ2szUnBaZVVwbUNBdXg5dU10MDBlcXk0ZDhxVWgyWENo?=
 =?utf-8?B?Vk9zdEhudWRvWXdLaXpCSFJ3blBXWHd6YUZ1eG9TMWhRb1V5QTkwemtIUWx3?=
 =?utf-8?B?NHkzRWdxT2dmampPallZTjQwUkc0RnoyTmdWU2lFQWl4bTcrMWpFMkV0a3Ny?=
 =?utf-8?B?aGxtOFJwVW5STFZOMmxqaGRlbDBOVmhBT2pQUGd1Qm0zMWlFNjQvRUsxeTJN?=
 =?utf-8?B?Zytwb0NSVnRraVhXU3RzYTZXQmprMk82SEZoaTdPUVhpaVVGK1h6dnd0WG1H?=
 =?utf-8?B?SlV4azBzOHNpWkthamtUaitzbStsdEkwQmo2UGlPdDZMZ3RZTmpGY3hWVFFF?=
 =?utf-8?B?cmt4eTNqVWNjeXBXVjBkaXBTbHpLUjBreDBWWEU3V2FwMlMySllFQUt2cGlj?=
 =?utf-8?B?WmdwdFNFdWlXc2lVS0JMQXRBR2tuVU9YeW5nWGpjcDN5dEkwY2ZOUWxLSndO?=
 =?utf-8?B?bG1iVUxNYVBmM2ZvSml6R1hrYnBLZzR4TndTMDBBMTZUbDBBNEZtcTlFTHBD?=
 =?utf-8?B?T1pCL0hqSWlIUVR5d3N3MUd6MldqMFpHY0lteWpFRmtIZ0c5Yk5nZUVaRnpU?=
 =?utf-8?B?UzZnNGpyNmJ6Uy9PZFNKK3BlK0NUbmFPUFRoejV5Q3phQjkrdUlUcDZybXc0?=
 =?utf-8?B?UzhGZjFxMUtTUDhKTUhlUndaUE1lUEM0TWM2MzBhUXVSMkFTaWtXY2x6SXlZ?=
 =?utf-8?B?bDhVVHNrMC9LNkZ4WlY5UjdaMnRPb3dwZ2ZlY2pnN0tla2VPV0V3ZlZhcWF6?=
 =?utf-8?B?S3VldUtZWFMvNno1NjQxNi9oWVM0YjliRTJBaUoxWXZ1eW01MWNTSGxWdFRl?=
 =?utf-8?B?Tk14U2JneTdQeTlYM1JZcW42c0gxcnNDRU00K1Z0WjJZNXA1QzhkbFJJak5l?=
 =?utf-8?Q?NpxPbT1fHtjvMuBIpxR7kE6XA?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e14a1f88-4adb-4ad1-9fbf-08dc833960cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 19:22:44.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uO7KredpFoFzHcdS5MdFowm+hfaAZii8JBYyBM0mFHoyT1RKEmZaDOBeP+0iTbe0UeNkRSZGc4HSChENrCtaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7850
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/1/2024 6:03 PM, Takashi Yano wrote:
> Hi Ken,
> 
> On Tue, 28 May 2024 10:19:22 -0700 (PDT)
> Jeremy Drake wrote:
>> If ldd is run against a DLL which links to the Cygwin DLL, ldh will end
>> up loading the Cygwin DLL dynamically, much like cygcheck or strace.
>>
>> Addresses: https://cygwin.com/pipermail/cygwin/2024-May/255991.html
>> Fixes: 60675f1a7eb2 ("Cygwin: decouple shared mem regions from Cygwin DLL")
>> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
>> ---
>>   winsup/utils/mingw/Makefile.am | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/winsup/utils/mingw/Makefile.am b/winsup/utils/mingw/Makefile.am
>> index b89d89490a..07b9f928d4 100644
>> --- a/winsup/utils/mingw/Makefile.am
>> +++ b/winsup/utils/mingw/Makefile.am
>> @@ -53,6 +53,7 @@ cygcheck_LDADD = -lz -lwininet -lshlwapi -lpsapi -lntdll
>>   cygwin_console_helper_SOURCES = cygwin-console-helper.cc
>>
>>   ldh_SOURCES = ldh.cc
>> +ldh_LDFLAGS = ${AM_LDFLAGS} -Wl,--disable-high-entropy-va
>>
>>   strace_SOURCES = \
>>   	path.cc \
>> -- 
>> 2.45.1.windows.1
> 
> If this looks good to you too, shall I commit this patch?

You and Jeremy know much more about this than I do, but I've read 
through the thread leading to this patch, and it does look good to me. 
So I think you should go ahead (after adding a release note).

Ken

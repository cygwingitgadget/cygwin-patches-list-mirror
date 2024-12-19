Return-Path: <SRS0=LRyU=TM=cornell.edu=kbrown@sourceware.org>
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::5])
	by sourceware.org (Postfix) with ESMTPS id 4515D3858D20
	for <cygwin-patches@cygwin.com>; Thu, 19 Dec 2024 16:19:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4515D3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4515D3858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c111::5
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1734625194; cv=pass;
	b=lODScbynLz9cYvI9TJaZGe3770k+ZnFtNNP2TPEJKBb7GcJ9sqMMSQEOP728Lk/bw7iLEdxot52GrUI2HUHd26OTIrOy+YBEs17jalqc2dL5ynZG9avcM4irDpE0CCb1zlRl3OYt39MbtP9r4XIx6urM9h12BGrotiU7J0CTfcA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1734625194; c=relaxed/simple;
	bh=f7aCT2sjRnvCRGZ7gTihab0lu4TN5IMqF6nGGcHGhX8=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=SKbXkF51dJ0AZ7cDR84zDtGwQn959Wgg90j4ZJEdMmdn0evYwlsc4vAYkMEDo3JTvIJgWwHlvRzhjU1a6FlittZkbCLDK58rSoIpXGHJYu+l9O83S986w3cIDPNoRiURHlDullw99xod99XYOMcj+JxySVI3XcTzR3OVmB/OdJ8=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4515D3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=EnXS+Of1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUo2wzGzM6BYRz33orIJsV6dY4IN6di8dMv1zmmOabZfwFBIx7y7WQtFGOLDpGd4rKb3HXq3iFYx3aOGkPI5TbheVgxNb63PwsiUjBwI7l5IIekgeMKeoBFMXETW4QsfzT07e//LgRBmOElzXx+SXeX4xhi5ve+FsZsS4cjIcxWsBBhn3WJWZn/ko6BUMUHKhsgVNV783Yd7Hrvs5Nj1tzZ8CVWrjXjZy+JyELnYsibMf1mkQMU74aKacXNjIFmBEi57xpd5f6KDF8cZeXpGV5+MNUtUDypItjL7q6AvTf2JyaYuBnKThrA07Vv6F3Hk+BMkPHC06gluMQKlRqMimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eB3aCEl8eGQ8Us9eBlm7Ht8gU0ogqn1VicnZGsDfitg=;
 b=o03A4Fn7sITpeiYfqui3WHbvKzrgxXNFOMlns1REe12vOyI0QgAoPq3vKwcs9j3vj/talN86q1ciuqQgRZzmBdr4Idz4zAn9Gy5Le9p4ykTOPNxcwyeDavBht9yp90HgKy8WNdV22ZE0kKtwfImEkOV936sz4KkjWOgniP2t5ILinfRHlJnL3Fvn9sOBXo62utHIQLVqLwayvmtl8IbZzzCIsaGgCwyGZrqIN4Unw6MggJWsa0OI5X03NNga5V50W8ejf3pdpRzNlx8dhDIDTqRWzE7oAzh4h3VABHwF0SMFJntew0U/JlU2qbJxnUXPsKLtkJlk02UXlEnUQuQDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB3aCEl8eGQ8Us9eBlm7Ht8gU0ogqn1VicnZGsDfitg=;
 b=EnXS+Of1XNdMu4MtsLTAN7IsCqqQabJkbm6Q1idUC1qlsq+JVtLKc8e1Cb+Wk9sDfiBacenFeUDCoGpGJxK+ektt5tD6IWpU/N8vetrse79jmDLv4lqC4tYoxNajoUPwdz2cAEOFvQ2Noj/8TKvY39z13ExOP6VEt5RnGDSh4b8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by BY5PR04MB6755.namprd04.prod.outlook.com (2603:10b6:a03:22d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 16:19:52 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 16:19:52 +0000
Message-ID: <3c63a503-af61-4a6d-8bae-b9dbab839fce@cornell.edu>
Date: Thu, 19 Dec 2024 11:19:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: mmap fixes
To: cygwin-patches@cygwin.com
References: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
 <Z2PyzRoS2QeOrNem@calimero.vinschen.de>
 <c2b2c0ee-e848-4b1d-b41d-7568671b77e4@cornell.edu>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <c2b2c0ee-e848-4b1d-b41d-7568671b77e4@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::32) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|BY5PR04MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbc1631-72cf-4677-589f-08dd2048f7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzdsbjdoSW9JTld2dm5zTVF3NGpuY1FNR2c3RWpqaW9FcjZuRHc0N3p4WHhs?=
 =?utf-8?B?dFFsdmtIczNERTlhMzlaUkZ3Y0lHdUt3SUdYaVh3RXRVUzBjcCtUWVl6N21z?=
 =?utf-8?B?WFlTN1FOYUZGODVHMStHU1pRUDBFdVg5YjFseTVheTVWTFowRmRiSjY3MXJ5?=
 =?utf-8?B?Tm50R0h3bkRmSFQ3bnJLS0V6TEwzQStXaFVhQ3k3MUFrZnpmc0h2andpNGJS?=
 =?utf-8?B?V28wWkhwTWErMDdRNEV4SmFPUzJ4TVpTcHBwZ1JDVTMxYUh0Z09FOFJjN2lU?=
 =?utf-8?B?WGFqM1dZSUk2UXc1bEV4VXVmTC9pc0hBdTl5TVFpbm9DZk1Fck1LSXZxOGRY?=
 =?utf-8?B?ZGlXaGhMZlNwQUVmMUIvM3VpSGtuSmRoVUkydWdrZTdEQ3pzRExDUE9JVk81?=
 =?utf-8?B?Q0ZrREhaNy9wMlp0TFJiU1k0bjdoNUhzZm9hNHBuWUVLZ2FDdlcyS2JueFJz?=
 =?utf-8?B?NnpuVWltOU1EZExlamtzbnNraW8vc1poczNQYUM0dkRPVmE3RUgwYU5kQVhn?=
 =?utf-8?B?N2gvekZqZHN0TEJzUUNIckgwNlpDQytmcitaZkI2UGhlVk5iZjJSLy9naGxn?=
 =?utf-8?B?WGp3OUMzZktmdGEyaGtmSHA1UCs3aFVDdi9wazdFM21iZFV1OE92T2V6ajQv?=
 =?utf-8?B?c0JRVkU4eGlsSXB4YTVOSG5vTW55bitzWkpsRVJXTG05aVQyOG00cVBWWE9s?=
 =?utf-8?B?ZXVFaU9WMkVWb2pVaEFVRHFPSGsrWEVVK2k1WDZjSGpkVVRvOE90aXZKZWRj?=
 =?utf-8?B?RUlScUQ1ZmZiYkRuTTVTNkUyNXdXQzNZMWNPQmt6eUVIVFZxL3VQS0R6bnd4?=
 =?utf-8?B?NTdOWUxmWVRoVUVTN0labm9RREFPVXJSdFNYaDJtdXFkTFhRWnJkM0tyeWIw?=
 =?utf-8?B?Z25Sb2JUbmk3SGNSeE9iSmltS2VWMmlCR1Zna0FYZGFndXBZbkxQQU9Kdk5J?=
 =?utf-8?B?U3FWVWRpamV6YWdmbnEzSlFEb0NQKzBQUG9ibGljRWpwQ0t3YWFtVnNTYlZx?=
 =?utf-8?B?ZnF0aUhsaStEM3k5MW1TRnh1M3UzbHJKSU41aG5pRWNibFBibGRwYWlyZ1d3?=
 =?utf-8?B?MCtwRlBvR1ZGcEJUdjV4QmxGczJRZkkwdkFia2RReHFFbld2b0l1dWtzMEhF?=
 =?utf-8?B?ZGhEQUNYd0IrejhLSWZiYXVQZ1N2aURnVnBwaVlJK1JIemdWazVWelgyVVhF?=
 =?utf-8?B?em9BcXVxZ0FPRlI1UDQzK2FZd1JyaERYNXNQNDRNNFZ2K2hVRGkveldyTjkz?=
 =?utf-8?B?SlM1c1BVMkxhVnhPQVhYU09zZ2lwQzJjUGs1aHRXWTJ5Wjl3YVdPR0IwckJ2?=
 =?utf-8?B?UVNIWFRlemc2T1grMTFmenVrTVc1WVFDYVdhTFMwN0c4cU5yZzVnWGZRWVBU?=
 =?utf-8?B?VlZPdk1VVzR3ZmhlR01CV2dRQ2VWQ2REREhQOERWNml6UmdUNGpxMmpHaVUr?=
 =?utf-8?B?elR0cFpremZYckNtNE5mN1ZkL0k1N1BXMzZCZVpXUmZaeFd6QTFNWnFWUDlJ?=
 =?utf-8?B?VEdFVHVSMlVmWlYxbENscXF6V3VVWitINGZZNnJVODM5YklnYWZ6TkVIN1ls?=
 =?utf-8?B?RkZxUWVWNGEzTk5hbFViTitKS3hNaXYwTmlzeWZiUnhlU1dhdmNTUUwwYU9z?=
 =?utf-8?B?TklvSHNTMGNTbFRTUElyOHhmalFvcVZUVWNYLytEYXVqOWNKdks0STlNSEhK?=
 =?utf-8?B?d1hkQzBhYmNTMi9JU2piWlNMaU4yYTZPVG0ySVhvaFdhOVUwUHpZOERCbG44?=
 =?utf-8?B?SWhZcVkvODJ2Qy9HVU4zMTRjck5mTExiczBIOHFUaHp3SWJWRXRRcEpsSVJa?=
 =?utf-8?B?K1R5T05FWUdpZWFWMHZlQy83RUwrcURzaGk2TzhCWlVPUGVPYmF1bjhIMG1Z?=
 =?utf-8?Q?E2z8fRW030PSb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0VGWkk0bDRUL0dFSXhZdE0rZnZKNG9NQSt1S09KUC9Oc3YrckRnTkJVcWdW?=
 =?utf-8?B?eFBtZ0FQNkEvNFUvb3NVaHphK28vblNlRVF6M2R6UVdpRnQyTHBQVCsySHlk?=
 =?utf-8?B?OWxwS01UODYwbzNqalhCRmV3NE5ieU1SMEVITGNheWVyTU5OOGRWVWZvR3du?=
 =?utf-8?B?dXVOVDllYm0zOVhxd3hvTm5OWkREdkRBbUlxTXRCWXZPTTB0cDZWS21sZ3JR?=
 =?utf-8?B?bGRIU05sVkIrWmhoLzArd3VpNlFSWTIrRllRWlNtU1M5U2V1ZHVkamViUGlX?=
 =?utf-8?B?WDlkMStUQks1Rkt3M1REMUpTR0JtQ1RNcFdZR0lRMXkzWUM1RFRoUW50b1l6?=
 =?utf-8?B?Y0tVeVhYV0ViYlBUUzZkanZuUDJLWFJ3eEdVcU95aUhoTk9mTi9oajEreE96?=
 =?utf-8?B?Yy90ZmdwYkRPTC9UdW9NZ3RkZkc3aWNrcVlRaWdGUDJzeW93S1lvVkNiS3Q0?=
 =?utf-8?B?RHU2cndHbU9tU29xTGtxR1FEd0M0RzlBYlYzQkNxczdGaTFwUTM5SVQ2R1VL?=
 =?utf-8?B?clEzd2lyRGFieW5tNXI1V0JteEpBdS9KclVNODZHYzU2K1ZFQXFtY01sL2hL?=
 =?utf-8?B?UGpyelYrNi9oSmxKaVhRcVN6a1l0aWNkQmg0VE1rNDZDMkxUTW1qOWZHdHpR?=
 =?utf-8?B?UlhYTjlpYmgyNG9IVTFCSFB4Y3NLdFRNeTNkKzNicnpJT0V4cUVySTYybmRw?=
 =?utf-8?B?Y3VOMDV2Q1QrRXI1YThsSU5DSXQwTitJWTRRc2Z5UWpnZ0JDbUFvK2RUSUl2?=
 =?utf-8?B?dnVWNm1FRkpjYmFNTGNieWFCZnhaMFhPYzhZdXFQaGt0T0s1VTVDTDZ1UEEy?=
 =?utf-8?B?YTBMTkp2cDJEWTE1OUgrLzgvQ0tVOGwraDB3OHFTRHBVR2pGKzFzQUVKaXVX?=
 =?utf-8?B?QU9YU3dhS3VzZHNpanhybkxlOHhrN3NGY2ZTam9pOCtQY0k2YXhQd2kxQVdj?=
 =?utf-8?B?MW0yTCt4bzVoK3FOeGwvS25KNXYrcFg1SzNvVDljQmdDbDRHU3dJcmxXN3Ro?=
 =?utf-8?B?NDRkTzI1Z2hsUFRRRnVrQnVXR2M4YW9HdFI5MFBZQzhnV2xEZ3VZWEsvVlRR?=
 =?utf-8?B?RzYvZE9Xd1dhVXlUTkNFL2g2ZjRnd3llcE04ZGsyQkFkUnpHeWN3ZExoL2pk?=
 =?utf-8?B?NHlvcDFpbXpYdkJUSVk3SlVFOEYwemZaWGFwMVRuSW1wOFUyVXNDNEs5NE5v?=
 =?utf-8?B?WXlQUWQ0Vmp2REY3SlFVSFhic1dZVmhqazNnVGpGck1CeEtaNWRHYmxxdnJu?=
 =?utf-8?B?OFJDNHBsU2FpVEM5N1NKc2xIdTBvckMrUjBmNlFUazFXVGV0WGRqMjExUUZ0?=
 =?utf-8?B?Qm5iWXp6cDJublgwaGtPTmcwVkx2RFBrMG1BeFpKL1pTMUFvT3ZXVXlNMDFL?=
 =?utf-8?B?NmFxMEdXMzFvMW4zMkFvT2owa2FqY2YyWmJmYi9CVjEvVWM5czBnUHIxTjZi?=
 =?utf-8?B?Z05Ma0tqTW9lRXo2bjE0QlFlRUVmVjRLQmtMUWEzY1B3b2lhY3ZPckx5bVFL?=
 =?utf-8?B?M1RBTnpodmY2OEJyVjNkWGdjQ1ZDTmNBTUc0R0ZnZzdUZFllMG54bnRsSU5i?=
 =?utf-8?B?Y3d4Y29vUDJ2MWpxWUZ6VXdHbjBqMUdQMU5iRlJJbnhQRDB3Vm9HL0h2bTNM?=
 =?utf-8?B?QWk4MGl0QXMwaWo5VUJuMEFGOUlNQlVUQ0Fjb3BXMTg2TytvYW55blZIWXc0?=
 =?utf-8?B?cU9lajUrMTJLZS81NzFtbTEzaE9CSFJnY2dmYlVOZWZBclJSZVh4NzdHdXh2?=
 =?utf-8?B?dERvQ0VtT1BCSHE4R00xRi9TdUZjZUo4ZGphcmt6TUdSY2xNTjk3eDdmUTlW?=
 =?utf-8?B?RFFsbkJQTW1BV2RlQWdWWkhoOVlvdzJ2aGJmVndCdGxtZ1FFWmVGSG0zR0JX?=
 =?utf-8?B?R0hRdFppVVJ1WG10bFVORzRtaU5LVGRraG5jSVFZUEM5TUtYbnNldHBhaHBn?=
 =?utf-8?B?TlJDVXcxOWt5M2puZEx4dERKOGVMUlM1UWx5M21BcjJVWDVoRkNENzY3RGM5?=
 =?utf-8?B?dVAwU1Z1djVFcnQ2elZIZEd5TlR1SWg2WkJ2NzU5UE9uajhROEpxQmhmKy9o?=
 =?utf-8?B?dkFZbnF0M1h1bnI4MEdPRjZrc0VCME1YZHRxZTZNaE9sVDZKYjV4S2VJL2FB?=
 =?utf-8?Q?YB4TpuVTsa4LbUT5NHAHXwWgt?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbc1631-72cf-4677-589f-08dd2048f7a1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 16:19:52.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WaqGtTAmhtynwlvviQLf3IAK2ryv8a9SsIZm42n1/9OZ7kpq/5pTJ0tlcGjh0+faPjccSYbK8pUemkRL9fbSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6755
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_FILL_THIS_FORM_SHORT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I've pushed the two modified commits to both main and cygwin-3_5-branch. 
  When I pushed to main, I got back the following message from git:

remote:  Committer: Ken Brown <kbrown@server2.sourceware.org>
remote: Your name and email address were configured automatically based
remote: on your username and hostname. Please check that they are accurate.
remote: You can suppress this message by setting them explicitly.

I don't recall ever seeing this before, but it's been awhile since I've 
pushed to main.  Is this to be expected or did I do something wrong?  I 
do have my name and email address set in ~/.gitconfig:

$ cat ~/.gitconfig
[user]
         name = Ken Brown
         email = kbrown@cornell.edu
[...]

Ken

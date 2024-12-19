Return-Path: <SRS0=LRyU=TM=cornell.edu=kbrown@sourceware.org>
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	by sourceware.org (Postfix) with ESMTPS id BE4223858D35
	for <cygwin-patches@cygwin.com>; Thu, 19 Dec 2024 20:17:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BE4223858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BE4223858D35
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c105::5
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1734639437; cv=pass;
	b=wyYH1DupK++Ivwja/BktjlAsXo320qmJ/SWVf0zf16RTx4hTCKDV09RE7h4piu4GTRFvqD2L3AAyiH7X1+AQ029EAC8R0RlKjvU+CYbyH1G3GblqYU/Sixxrowwg9qP2zb+Ry1ob6t3XO/v7g/phP389WHf7ce2Q4jIX+P5LwV4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1734639437; c=relaxed/simple;
	bh=AUoX4/wgPEdmV1mTHYSLvDBPIhPgUE8nfpZ6+bta0xk=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=vw8zwUAx/T8OPWY3RrlYUzJb7t6EGyk8b6/Jk12uaxNCjmTWuAtuUKkmAN3AzRex+DJbompwuNpkiLatJzSlIGpEFSpDqgtZ4BIzCRwVfZqd3IHIXFnv/PSfUtqc8DfJd30ksCSkhmsJnhsRT5/B/Mo7P0u7e1/ohTsJmlo/Bbo=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeVvPQXQ5Em14H+amluYyzTaoJ8OV+mB829aMgb3NcUYLt00XrYJxwBfUdi3kycBMhz2hTL1k9wDqu2Az0rGnXZWnjzOsiKPc93nYIWmxudJrYUSJoHFv/gHPzp8Fbl1rkpq3nO6jeg/16Lx/KIScolhaIZ34dLdMzpgkTvyhSE01JZF4hxM0KoEzBzMcC6dVC3kbBhFwhl9BGYXf4Ny2usja9Q9b8stONvqG5S7J6iIURGq97V3ZJySNe9kb0nZJMMMseHdBe/Le8OHU90BT0PyWK8NAWGxl8P3QHxxNb5rxVw2fm6QFJwiu/z2krkc4SSGkie74spAnlUI8cF+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40AVLeYmmCgjm/FGmi5fJAik6iiLYIj5RazYw3+uyeY=;
 b=MfkcAqJLD/gsUFGANkrzBniXdp+lQ+wAHCu9/9JmGtvFZ+8ND32nKfcZK4SadS8wPp1bHSkG2vS+NhZbTSdUSoimqcAHYoarodKH8gE7rfp+eXiDPGzojopybVT0td0By1mL3Q/IFfIHDWbizRIflHQcaYNDiSIw0k5rGyPqw/yRwUn5TpJrIoP6XGEYYdeUEXyM/twYd0oglOf9Ae9tlhv0HHrHvsOFzez84iokPBMW7el04TFR55/F1Nbx/Yq+9MMPWAtUaeeD3gOosE8yrzAuUnmkk+bdCvHBjrm5VYmamioCHxpkzyo2ar+jHTt811iCgcjHaYqeLrbhO8vS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40AVLeYmmCgjm/FGmi5fJAik6iiLYIj5RazYw3+uyeY=;
 b=Bo0Od8DlwZiN1PRA9bIFx8jGKrJYK5GeNM+aQqJdZI4DrCJ62MpCD/W/R+OpXG9XrpkwpgoRQNXzIUmrg2y6jYitSOulO8KE9ioA98UZ4rZ1NAPnuuUPEtn+JdAAZ9D06E3EthbE8mx4ednqoFHy1fQgrQAAjNOF8yGGdbOcDWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DS1PR04MB9655.namprd04.prod.outlook.com (2603:10b6:8:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 20:16:46 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 20:16:46 +0000
Message-ID: <27078921-b49a-49d4-8cc4-527f172b143b@cornell.edu>
Date: Thu, 19 Dec 2024 15:16:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: mmap fixes
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
References: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
 <Z2PyzRoS2QeOrNem@calimero.vinschen.de>
 <c2b2c0ee-e848-4b1d-b41d-7568671b77e4@cornell.edu>
 <3c63a503-af61-4a6d-8bae-b9dbab839fce@cornell.edu>
 <Z2RXbRhvAkGrXS6I@calimero.vinschen.de>
 <d7a916ea-6bab-494f-8b16-c2310eae259b@cornell.edu>
 <5ab5b7d9-903f-4bd4-82c0-1826de2520e3@dronecode.org.uk>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <5ab5b7d9-903f-4bd4-82c0-1826de2520e3@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:36e::10) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DS1PR04MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: f89bbd9e-7981-46d9-1af4-08dd206a100f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TldhS2xvU2dlM3JUOWVUSEtzai94aEt5bkY1citqbmEwYVlXWm9leW5PTFFy?=
 =?utf-8?B?ZmpIWTVtc2M0SU1jMWhSdVcxK1FhdUkxNFRGWmpCcS8yZkZGZFZjelNSbXZM?=
 =?utf-8?B?ZzlYcHcxVjVsQkJleXlJVmlqZTArSDNVODVmS3VxSWY3WTJ4MFIzSFYyTFZx?=
 =?utf-8?B?Y0FLWTh5Q2U0d1Nvd2hDNnpkdUNaSzd3Q28wbTNPV1RtOWhmbEFna2hBS0k0?=
 =?utf-8?B?YVFpS1JRWUJKY2xtcE9kTzUyRFhFU09OME85Z0s0SHZzcmZ4TUlIQmdLdGlK?=
 =?utf-8?B?dUx1NEtkeTZOcTBoYkRKUXdKVXIyd1BuVlVrZFdqeVVudlRxNW9FbUlRTzdp?=
 =?utf-8?B?SWpYdUVJZUxsaHFKd0R2SWdDY3N3aERaSDVXdlJrMVptdFdrLzZwL25ISlZ5?=
 =?utf-8?B?Q0NVcVdSaFAzMkRVU2hoSUd1UExTTzI0c1l5eVVGck9GMGp2c1ROTzEra0hl?=
 =?utf-8?B?QmFxdkNSUlNJdXdqOThhWWgyS1J5bmNsNTZXNHZ3eDZsVU9oL3Z2eE9ZbnBG?=
 =?utf-8?B?MEF2OC9QazAvTFFsL0cxeXE2Mzh6K05qQytqeUFHcnFrWDJRQzJ4eU53Q2Zs?=
 =?utf-8?B?UHBYUTFua2VZN3hyWlJ2VTdZMTdFbmIrQ3VsOWRWQUJJa1krTVpiZFZwcWc3?=
 =?utf-8?B?T0N3YkVnbDZYYm1RbnFJcEFQTG56d1lKWWNibXZLUmFLMmliYmd0Mm94VEtH?=
 =?utf-8?B?RjVWY3Q1ZklaTWxtQTBuOUljeWYrQVRKVEI3T3BMVnV2cEhsaUdNcDRONjJS?=
 =?utf-8?B?eUgzQVp3NWdWU1h4eGNYYlExQndYeldDWm0vUFRnb0laOWVIU2VHVTdXc3JV?=
 =?utf-8?B?UmtYMWRLYXpxWEJPQlBvYUxrcGkyVGNpUzJiT254L25EcGVYZ1BmU1BYSTFQ?=
 =?utf-8?B?bk1OUjdjVnJYcGFkNDVHZ28yeVI1dC9ickVZVmVVLys0bVpuZU1XMkIzVEhm?=
 =?utf-8?B?dnVNUWJ5Vm9vZGNrVzlkS2VXYW5IWGRadEl5QkY4TUx1OFFaRVQrMERsL0Qr?=
 =?utf-8?B?SGt5N3p5SjVIUW5IT0E5NzczanBWUDRLZGYvSmxNanIzVFhPS2ZUZThIekVK?=
 =?utf-8?B?SHBGbkkyM3pFZTlMTmJOQjh6dkYrM21EYkRSZUswaXVsKzlsKy9zOFNoR0o2?=
 =?utf-8?B?T3ZHdHNkdnIwNFcwTDE5c05rYk16cmFQem1TN0xoSmVFREtRK2FMU2VKK2ZV?=
 =?utf-8?B?RFFRSmtnK3dtTzUzakNLNHIrYks2aGJyWXVOY3dJYWE1aU1oU0N1N0xKRFRn?=
 =?utf-8?B?azZKcUgvSDFrdzZnVTBEWUU5dTdOV2RtdjBaM1VWbGtOVU96c093SGJ4QXYr?=
 =?utf-8?B?Uy96SFpLTTNjaE43MmtEZng3eFk5NGVjZjExSCs2MDdnSXcxQWR3RmM0alNW?=
 =?utf-8?B?ZDdvTzFWZjBiTzNSZFJTZ0UxL3hSQUVvb3RVeGhZVnQvVlNvZkZ4OXBVbHFs?=
 =?utf-8?B?b1E0dzRBcWNTVlQwQXN0MFRvcURLanN2bGtaRTIxWHFaMm4zdDRwU2JRMWR0?=
 =?utf-8?B?dkVIVy9RME5yd0xLNytYcWQ0aVhiR0RoOElnYjQ3VVZSajlFWE02UHFmQ3cx?=
 =?utf-8?B?cUJZMHFXbXlkWnE3NURJSjRmMitaU1lMSEhuYmRHL1BWZlpLNGJ1MlJpVUNs?=
 =?utf-8?B?QmdaT2JnbXU3RjkrYlJBVjZDeDJFQTZGR0dVZVIwUUNqY1o1ZklOSGZZeEdN?=
 =?utf-8?B?UUpNUW9WOTBxblFzZWljSUNXZHhyaldsU1h6Q05sRFdLbEVmd1c1QlNlbjJz?=
 =?utf-8?B?WjVwaTNVblhJNlFEdkRJbmxHMUZtdHMxWTdhWDV2Wng1Q25YSDdqWG03RWtl?=
 =?utf-8?B?Q0lFaWN4TGo5dFBmUktCK0MyNVZST1V0c0JmOGsrY1NmVmdsQW5GK0p5a2w1?=
 =?utf-8?Q?iGeMOQnnXN+Su?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWI0RUs5SUljYlVTL29LQ05oc250Vmg2d1p1S1BLM1hpek9EZTk4ZG1oM3Iy?=
 =?utf-8?B?OTdXVmh2WDcvcmJjcmdaZkwyVmt4MVBqbmdJQ2hCV1VJZzNEQXJoL2g5OURw?=
 =?utf-8?B?Y0hjWERRYndteEVGMTZDTkw2QkZTMzByOFEveDgxeTV1VjRkRVByeVptSVE2?=
 =?utf-8?B?VFJYU0V4dzFDNTJPTWsxQWU0T0V0YXQ0NDZRdnh3WkV6YzRwWVJ2RGhSVGVI?=
 =?utf-8?B?Q212L1B1K2pKR1RYWWZnUEtDeE1uMTQwZUkzS2NFT1dlaitTU0dpSDlWajQ2?=
 =?utf-8?B?bjZUNVhpMnNYdm1BWTZJVjdEQUVFb0tZUFc0OVFZellYL25aVjYwbjRlVUxo?=
 =?utf-8?B?MUgxM0RjNHR1Q0kzaEVOUUpLSS82SktWd2RmaVhHNGVZRW53SW1PZm1nMDhU?=
 =?utf-8?B?U25YOWxqa3NhUWxjVWE1MTFxbXB4VTQ1YXlNUEVadEpCOW1pejI5ZjdUYkJI?=
 =?utf-8?B?UVpUNzdQaDhOMXA3YkdQRC9RSjFwRmJPWUUwZDBIMlNuSmFJSk5Ha1pmQ2dn?=
 =?utf-8?B?K2h5cjIvbUlmbExYNzBIa1RLQzI3bnVnNEp0YkUzdFEvT1pmWlg1OEdybHJs?=
 =?utf-8?B?WWMrZVJFZUxlUitOamRNWDdmSzBWdGRVL3FvRmJUSzJqSlJEd3pnVzNqM1E1?=
 =?utf-8?B?VkJReGUvclNEVTdtVENLbGdJaEtaWHdmYjlNTjVTZUNKSWpXcmRYQUxyL0dq?=
 =?utf-8?B?emZYSE5SNlhtZ3hqdEs0ZXNCS0VhemY5SmFZQWY3R24zbFRWcy9hT2NxMXdN?=
 =?utf-8?B?RXdoTFhKb3AwbTlEYm1SRnpKTStodDhGTDI1b2RnRUJUek1sR2R4RkRUYUJT?=
 =?utf-8?B?R3RsV2ZaRlVVSzZ0Q2NyelBuRVAveDVwYnJwb1g1bEIwSGZ4RlJxUnh0czRK?=
 =?utf-8?B?YkVzRFVJbzZUY1N0Tm5hWk9SU0RGelpHdFpzajRyb3B5U1JlYkZRMHJNdzZP?=
 =?utf-8?B?eGdCSGd1dkJjbGhzT0xqYkZzNGdZeEVzKzM2ZWNLa3NuSytvamMweTF0cGgw?=
 =?utf-8?B?QWtVOFZCRmFETElubno0cFZmNFhibGJGNmFNanpkdUl4MTBwaEJ6enM1eE1w?=
 =?utf-8?B?eXRBb0R0dG9ZNmFBZFF1VERaTVFYMmdqWGVRbUpRMEFYZ0hPYWh6Zmt3ekdq?=
 =?utf-8?B?VjkxZTNndkJJRnp4S2xZTi9zV3RRdXFGMExhU3UzdklEeXMrNGF4RmFROWxw?=
 =?utf-8?B?VFVpRG5yYzJSVHVRUmtMaHpkbENSOHd2K3ZkYkp6NEo3VFZjcUhMYytCU3dh?=
 =?utf-8?B?WGdsdm01Wk4xTE1veDYra3Jud2VwMnJWRGhiQUdtYnV0NEltQXFqdDlRVXNl?=
 =?utf-8?B?NG5MY012cE9PSDFUc0ZCelBzeTlpb1VtUDNPRzgzSVdQQTZRcHV4N05tcGdB?=
 =?utf-8?B?VUZGR3dyWk85a2VlTXg5alkvUTQvTHF4Q0NHS2VlUlNoOHVUZFpGVkIwSmow?=
 =?utf-8?B?aWhSREVPOGtnbmx6NnJoU1dtQVFHbmNEQklqZzZPV0xlK0xRYmJLam5uM1BC?=
 =?utf-8?B?SFRDUjRUc0lQMm50TWtiVlZEcWtzVTllYTBXcDkwTm5TbGh1ajlEWUoybkFT?=
 =?utf-8?B?REZVTndMb1QrMnoreERMQmVZRnRkVnJBbDFFK0FSNTFmMXpGb1NwUHpnbERZ?=
 =?utf-8?B?UWhKMVpvdm9GcGRwTDZRdElpU2pJZjlYcEFTeWhqdFBjOEZ2TzljSm81NDVN?=
 =?utf-8?B?MkorV2J4akIyQUUvZGxwNjR4eTJiN0ova0gxYVFpcHIyZy82Ri9lazRIZmdI?=
 =?utf-8?B?enowL1J6ekllNUJUNUNidGlFUlFTR0pwRXRSK0tkK2ZCL0lCOWNmZ2pkNjJB?=
 =?utf-8?B?WGR4c0NnN2JXcENvQ29kNHpDQStCc2pqYjhpTXZYVkpXV2tPUkJ0R283a25T?=
 =?utf-8?B?cytsQm1yQWp0QTB2QjEzN1BubmZmSU5lYnMwellUUDZJWVBLNngvUldzOUF4?=
 =?utf-8?B?NlVIMWUyL2tyT0V0bUppczcvWXpNV1dFcGsxRVlYQlNyWmc5cTNSb2NCa0dQ?=
 =?utf-8?B?QmFyTUZsQUVsREE5WlNrRGpIZ1R3WWJ3d0ZFWGQzUEVuTmZUVUhUTGxCR3Iy?=
 =?utf-8?B?VVYybU03VUZON01LR2tsNzc4S0ptRkdTVW1xcDAxL2g3MU1PV2kwQnRkbmZ1?=
 =?utf-8?Q?4nzPw3+VYdKohKkSVtgkYwUoC?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f89bbd9e-7981-46d9-1af4-08dd206a100f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 20:16:46.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JH5iFJRjZet+O5i/PlpohJ2fOMG1rvNysNzKmz8fQIfkZx2pApL+k1wRmt0W4CX0Qtwarrxm+YF96qMx3HdsQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9655
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/19/2024 3:01 PM, Jon Turney wrote:
> On 19/12/2024 19:50, Ken Brown wrote:
>> Maybe this has something to do with the way scallywag is invoked to do 
>> a build.  Jon, is the problem that I don't have a .gitconfig on 
>> sourceware?  In any case, I'm inclined to ignore this unless someone 
>> tells me I should fix it.
> 
> Yeah, the clue here is the "remote:".  All this is happening on sourceware.
> 
> The process of requesting a build from scallywag is kicked off by the 
> post-receive hook on sourceware generating a commit for you in the 
> cygwin packaging repository, updating the cygport. (See [1])
> 
> As you can see this commit has your automatically configured committer 
> identity.
> 
> No cause for concern or alarm. Although, I'm not sure why this might 
> have just started happening.
This is probably my first commit to main since you started the automatic 
builds.

Ken

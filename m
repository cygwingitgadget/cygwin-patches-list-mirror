Return-Path: <SRS0=8FaC=QP=cornell.edu=kbrown@sourceware.org>
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	by sourceware.org (Postfix) with ESMTPS id E8A2B3858288
	for <cygwin-patches@cygwin.com>; Tue, 17 Sep 2024 18:22:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E8A2B3858288
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E8A2B3858288
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c000::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1726597354; cv=pass;
	b=wc9Y+ihffGXXnefftuuBH+nzYQ+smA8cfjX3fzrZ/pKQ/fAjhsRiakH+u7EEybKcrsHOvK7sbdvTEkG0iMnQBbY2K+jyyNzdE8Yu83y5sc++KBx46a1sI1WK/qOeAjinyngaG7leWB4EDjqY+aVm2Nac/qMVOpNvoAJbVP7eH18=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726597354; c=relaxed/simple;
	bh=W6fSkEy/uyVj5VgecpVRBRbNXfgY+OfxP9iFx+wBHmI=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=B3+u5ewTYBT+Nir7bks7r4m3o83h8fqVfkwy3GWu9gROXaWqU46ywijr+rHgJJi6te0tDOmgaLgdUA0dfvaTJvWlRJVUqz6Dee4K95DaCqW/b5U11NiDXm6ngnnMoVuJPEZ2r0gNfgEuvHcpSAlU6AuNsu+Bnrt1eL40B57G8TU=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItzMvRVHGUdnWIQ1OGgJ3EFZRMCWFf2M09hiJUtMekdeYfBjxO3Db9GJPqgkEJpxlzpdtt2IyGjNT8BX7WLyibzydZR4wFjIKzLORlLZjFVcwqNF5Vbekrn3lu+qNrg+isxdk2SIRnLAFvT/AuFp+Nxr9AAPmxOm9YpXSnFQBame3LbplKghA+d9ZnKIkjPJ/VcDh2P0YRxpvxUWOOtIKHDSkRLKhPLT1iquwE5lUF+GESY+mjxnjO8B9jGhxwHm9pULBDZATuyu/z8+sU1zT0qQdgLbkOEy3lyeBakKT8GL1w4ox1VlWa2rpSY1tO4FwuVzOEm3zV69JLBJ+TeRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXW6N3HC/7WsRWZlwpMUFS5lzkllMUS6WK8uU3K70nw=;
 b=KFDBrXlWqSZwOrML/z8Ok8VbsW7JVAZy6fRLiW5ovEtbOeZCJHVnH/ylgOTsAWeCRmDz5EcJQO9jG414JSJfgQNIrxhka6wriWHQ+Cjw49/r1PETiJy+l8zsFvrSWcJB4qwD+2R9MExGH8Fz2mK/H3P6pDNhc/TYXpGphbONB0S0YF3oPvljQATW97paBqA4vGc9OPBUG0ejQMAsDVE3TZbjsBrHH9dseaCigYUZGpYdqiPeN0f0VyEYzJB0hH4s0chRnauQ0MgCDRma6ychrFYXPITFiLk4aGp8M/aLwvTYix9DpRKUS56srDW246/mw+BIPfCY8JU/roXKCgUJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXW6N3HC/7WsRWZlwpMUFS5lzkllMUS6WK8uU3K70nw=;
 b=QYsZ5CSbFchIAFoiAy/jdHeWlZCxT6wwbgEtjZsJd+Hf1ZQgTUbmVVZ6P9QA0rrbPgRh7KgynNm/fYWQzUo58ylIWzuaSriROwF2QzQX/teH9QSswG/8KATp3SXUqjYwU46lD/9RruidVhbk7L871DTClyigHJtYQ5Pih3tVluk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by BY5PR04MB6644.namprd04.prod.outlook.com (2603:10b6:a03:22f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Tue, 17 Sep
 2024 18:22:24 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 18:22:24 +0000
Message-ID: <7fb9a624-9a01-420c-913d-f7c70a04ea9f@cornell.edu>
Date: Tue, 17 Sep 2024 14:22:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4.2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
To: cygwin-patches@cygwin.com
References: <20240907024725.123-1-takashi.yano@nifty.ne.jp>
 <d197495e-b91e-4cfb-bc5e-84fbea62e6cb@cornell.edu>
 <20240917224901.b2569f125ffd15efd1992126@nifty.ne.jp>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20240917224901.b2569f125ffd15efd1992126@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::14) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|BY5PR04MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc6d840-82cf-4bfc-ceed-08dcd745adb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckZiZ284OXJFc1A2MzBmMndqMHlLUjdnRG1vWFdzSzJsSUlTVjhwTVIzY0ZC?=
 =?utf-8?B?ZEFzL2ZSc3JRNlFGNXRZMHhxOFRTTDkwSmdRZjNMVndRVU1RUU1kcm5WUTZ3?=
 =?utf-8?B?Z2grRDE1Tndac3ZBd0JoV3dmdTFhVUhab3lTSU05L1lPRktKL1FZcU1ER0FL?=
 =?utf-8?B?R1N4WFdLNlhEU1labVpObkQ0NWRQQ09rOElSOGdldEdvSTRDMDlMc3cxcW5N?=
 =?utf-8?B?V2FFVWJHTnF5ZFNjOW9YVEpnZERhZjFtL25wa2pyelNiTFFubktUT2VSR0JU?=
 =?utf-8?B?d1dPMkJzbkJYclQ5ZW1IR2FMbVhWZE8zSVhmcEF0aUJJSzhvVHlieDZTNFk5?=
 =?utf-8?B?Q2paLy9Xd2Q5ajdXQWEwZVR6cVFXdk1JK0FMd0JKb3g0RlZURHJRT21wM01W?=
 =?utf-8?B?dTZlaW95bXpRS0F4amRzOEJsRlF6R25wOXJLdjRCekpQcTJuWDlETzRkd284?=
 =?utf-8?B?OC9pbkVaUW1VbnZMcFFPdmV1TXBuM0d5RXJhT2hSSTloNHBmMzMrcE9aZnJ1?=
 =?utf-8?B?ME9rbEJqdDc3NTNUNDdTYzd1aVNjUmVueUM3OGpiWjhRZ1NPNjhWdEVPclR5?=
 =?utf-8?B?THlHOUs5M1VnTXlpcXR3TDFzZHVnbC9nbWR6YS9tdVNENUJWV2dDRHRhalIr?=
 =?utf-8?B?aXJXVnoyYlJGZGJpMlV1Q0g2aVhTZVFtc0x1V1hVajVvTE1oZ1ZkK0JqanpW?=
 =?utf-8?B?VG5EZStUZitsc3VlN3czMDBMaGgxa1N5RUhNVjVGYmJLNUZSK3N3RU8xOE1x?=
 =?utf-8?B?dGhiNytqYWN3R0NjVStpYnd1WUdFaG5iRnR0TFNKYlJjcWpmZ1MzSHhJRVlW?=
 =?utf-8?B?L0xqMXp6RUhTVU9Sdk9IM1Z1aDdSVlZVVlVlaGlYZzkvRDVJMnp2aE5XOFBW?=
 =?utf-8?B?ZmtZWmRHZEJvanJycjNBeEtLL0hRakhaNFRTNkI0R0l6QUF1dWgyRkJ0MFRP?=
 =?utf-8?B?MVA0cXVLT2pwMkdMS01GdkE5ZDIwY05lNDNVbE1SbGN3b1FUK2FJcitPSVU3?=
 =?utf-8?B?VGl6VlJBMHlvaHA2VHJORTd0Y244bk9TT2dCK3F2alZkOWgrQWpCUE90SFFa?=
 =?utf-8?B?NWtwaDFZQ05tMGZ3UGZSY1RRa0dvSmxON0o5Zm5NMlhrRjZQZG1SSzBaeXh1?=
 =?utf-8?B?S1dxcEdwSEUyUGZBb2hwTkVkK0gzcmUyMVNjbG8zTnRmTWhqY2RQd0pUNlFo?=
 =?utf-8?B?by9JenN3VUFTNlg2M2ZWa2NIbC90Mk1CS0VYazNvcWMrLzF0YlV2ZlFhQ2dZ?=
 =?utf-8?B?dGFPUDlsMmpMZDRIK1V0dlNYWDdqSk4zZjh6QitmdkRZVlRhVFV3bFJjZ3Nz?=
 =?utf-8?B?elhFMzVqdzFOWW5IbGZHTkswTnM5SEdCMXpHSURGOXJnSHdHZGt1NXd1TmQv?=
 =?utf-8?B?NnpEZlUwSmJMMG8yMHNoQ05FbWpTd3F6Z29sck1PYnk1VWxFaXdiZ0E0Si9m?=
 =?utf-8?B?S1RaeGFIWm9zWUx3Z0J4OFIxbk1ub2g5S1RRV0dnd3U4bWRLUllCa3l6Ujcz?=
 =?utf-8?B?eGVFQ0FzMVRkTHErSitjMWpwOStaYXg1ZWxKTENRMXMxeDZ6dFRhSXh2TXEy?=
 =?utf-8?B?MWxpNEtaa1F0aUtNQ1U1Mm5KQU5XbVpicm1ZcnhyMzFIQkUzSVVLaS96aHEx?=
 =?utf-8?B?bXY1L2Jxb0E1eVBmcXBVaitjNlJUZmw0OHhmZFFQdDBuS1ZzRVlPSUdndGhD?=
 =?utf-8?B?SzNjeW5QNHBydm1ZY1NPYjhlUVpTNytHUnpJQTBac0IrV25lUk5SYnlGUUNl?=
 =?utf-8?B?T0l0WnNuUWpmTDR1RVNRV1dyMGxpME9QUS9TaFlJOUZlS2pDNTF1V3ZSeC9R?=
 =?utf-8?B?elMxZWl5YXR1YzNjb2h2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmFQeTRLUlZJYzFsMS9PYWVOVmMxRUZNVitoZVdUNE12bW1venI2eHBhZ092?=
 =?utf-8?B?cGVReW9jVnZGR2RmRmt1QnhkbWltdkJqQ084aXFWUytHY0diQWg0dlBRdUlt?=
 =?utf-8?B?VDFrYjk3bzZheGZVSEhhUlNpREQxb0NUd3ltZzRSR1ZnaEo0bW5JMVVsOUVx?=
 =?utf-8?B?VGlLVkJHUnF3Q1FtSllqb2N4WCtITDJVZGFEL3F2dnJOZkdkQ1R5MTFwcURn?=
 =?utf-8?B?TExGTCtwN0dzek1NbERYek5VUE01S1ptSTlURU1Jb21RSnBaUzN1WXEzbkRH?=
 =?utf-8?B?VjNRbzdTcE5zU3JKRS9NcHRnTFFnRnpLM0ltZUpBZVl4RzhIb05uYWtOdWd0?=
 =?utf-8?B?MG5qTDhGamNjblZoOEo2VmJwdEJkOS9zakxpdGtUUm93V28yRmFaVjN5c0pF?=
 =?utf-8?B?Tk9nK3l4ekgyL0E4N1kvR043d29GQ0lFMGZOSEVrOTA5VnNlWjNGYXMycjlS?=
 =?utf-8?B?ZXFJQUQvT0RtZ01YMmFLNDJEdnBiR2QzQ1QzanpqbWZ4b0hRMUd0V045ZEE4?=
 =?utf-8?B?VnlaaWVkc3ZFajQyRCtrQ1J4ck9MVnNucVhGdk5xNVovbHBRbDlTdEpqKy9K?=
 =?utf-8?B?U09DYThFOHhkeUZabVoyZVBMT2tJY1lRakNQWGliZmpoeG40aWRmMDc0VTVi?=
 =?utf-8?B?UHB2bElsTE5QdENzZTErKzdOMndhb1g2SXRFdjJ5RnhOUmV3QmFpTUNHUlJs?=
 =?utf-8?B?RHg4c2JBa0lISGErRU5ybXlNVHluakhqcEVTUUpTVXd5amk2WGx1Y2o2eWNr?=
 =?utf-8?B?Ly9VM1FMN1VYclQ1Rnp4clRHc3RLcjAvMy8xR2pqeXNGWFNQOW9CQlEzQ0ho?=
 =?utf-8?B?MjY3eldnYWtRZXdlZWZHUlM1UVEwaG1ZNUk4WEJTYktXMnJQSWlGUndCWTdk?=
 =?utf-8?B?Q05pdnFEeEdQTG0rU2lzdlFqaTkvZWdNdllDNzFzWFFJN2pKd3FFRFZnbWFZ?=
 =?utf-8?B?akd1b0FmSjJWcmNVN2tMdDI1dVIrZGRRQStEMzYwMVI4YUlzcno1SkE2ZVBI?=
 =?utf-8?B?WkpDRU9XNDkzT0NDbUszTWpEZm53c1V2UUxLWkV5YUd0ekg3WldLTFE5VXhN?=
 =?utf-8?B?TEhUeE1ucENMdzBOa25iVC9pZXordWx4YjcwdXF4V1JEV0ZHdmVzekFoMEZ6?=
 =?utf-8?B?eGcxZmdvYi80eHRPeXVXclkwa0ZTVkhEdW9Ia2xEMU9ZdTUrS05BRVFqR1di?=
 =?utf-8?B?Q0hoYW54ZFBKVEQ5SS9KSDRZWnZQcElGbGdvYmZnaVFQRVFCNUFnaTk3NytB?=
 =?utf-8?B?UFByaDZxdDY3Z2lucEkweEp6SzJhK2MvdExqcDZIRFJsQk1sQmF2cXlGOFYr?=
 =?utf-8?B?QkhKNHRRcStIZG5kQ3p2YjNCejM3ZVhTUVkzdmJxTXVhTzJSelZFSEFsTFRY?=
 =?utf-8?B?cUhpOEtFOWp5WjlQQ0hpbGtEUTNDM3lGTldCdDZjcUNFQ1Fvdm1adzgrR013?=
 =?utf-8?B?N2VFNFU1L1gyS0ZRTWU0T2lRU3JJWWlOWGhyZVlvZmgrOS9LZDlvY2JuNVJx?=
 =?utf-8?B?UFl3QmV6TjVpRmxlNHRic1FrMTQ0Q2dUYlZpMHBBTVJIOWJwYnJsdHFoN21K?=
 =?utf-8?B?aE1DdHlockZIWlZjRTMzYlhUaDRVTUtyaWQ4bUdZdmZvNHFNM1R4N25ONjZP?=
 =?utf-8?B?Q3ByZ3RIYUs1VGdQeHo0Z0Y3ZkV5cEtVK0lMaXNRb0ZpbXZrTnYramM0TXFY?=
 =?utf-8?B?ckIvSlgyRW5xYUFDL1Q3V1ZLR0JVMGplemw0QktmdWwyZjV4VkU2MjNhS3I2?=
 =?utf-8?B?OEVMZnRZRXFNUk5ITTZhSjZPMUhNZTJqSi9UU2t4RG5tQ1RVYzBPWEgvb2Z3?=
 =?utf-8?B?cUtKZWRYVS9kSnhGQWVTT0RQTy9GUEtxb0J2Rk56cmJsdFlra1FOZm5LcHBD?=
 =?utf-8?B?cERocjRXRWVRcTNObHF4S21NY1ZkV1F6cWhmeTJnaFphYmJPNFpQQURMQUpa?=
 =?utf-8?B?dDdvN1VRMjQ1M0NqRURKR2pBcVNIc0w4ZG5ybWtPVk93SkZGR3ZjR0lVNkYw?=
 =?utf-8?B?SlNtTFE3WmszcmZ5Uk1RdXpIdzYrN2pBK20zWEhqS2ZNQnJTU1FWY0ZZRHVr?=
 =?utf-8?B?TEp4MHRvRHhqV1o0b29kSU51d1BoSjM0TjVNTXE1RWQ2WFY2eC9GY1BHUEZO?=
 =?utf-8?Q?NIPQ2JB+48Sib7xsT4dLYw/Em?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc6d840-82cf-4bfc-ceed-08dcd745adb2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 18:22:24.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPbOTmAqL22LP3mzrFuh1sgZvYo0pqi4+fmGx/iR8dAzQ4mHH8JsSGqNB2NwUo7ihCdf7SRLoy4Yen7p2sTw0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6644
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 9/17/2024 9:49 AM, Takashi Yano wrote:
>>> @@ -439,19 +396,45 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>>>      if (!len)
>>>        return 0;
>>>    
>>> -  if (reader_closed ())
>>> +  ssize_t avail = pipe_buf_size;
>>> +  bool real_non_blocking_mode = false;
>>> +  if (is_nonblocking ())
>>>        {
>>> -      set_errno (EPIPE);
>>> -      raise (SIGPIPE);
>>> -      return -1;
>>> +      FILE_PIPE_LOCAL_INFORMATION fpli;
>>> +      status = NtQueryInformationFile (get_handle (), &io, &fpli, sizeof fpli,
>>> +				       FilePipeLocalInformation);
>>> +      if (NT_SUCCESS (status))
>>> +	{
>>> +	  if (fpli.WriteQuotaAvailable != 0)
>>> +	    avail = fpli.WriteQuotaAvailable;
>>> +	  else /* WriteQuotaAvailable == 0 */
>>> +	    { /* Refer to the comment in select.cc: pipe_data_available(). */
>>> +	      /* NtSetInformationFile() in set_pipe_non_blocking(true) seems
>>> +		 to fail with STATUS_PIPE_BUSY if the pipe is not empty.
>>> +		 In this case, the pipe is really full if WriteQuotaAvailable
>>> +		 is zero. Otherwise, the pipe is empty. */
>>> +	      if (!((fhandler_pipe *)this)->set_pipe_non_blocking (true))
>>> +		{
>>> +		  /* Full */
>>> +		  set_errno (EAGAIN);
>>> +		  return -1;
>>> +		}
>>> +	      /* Restore the pipe mode to blocking. */
>>> +	      ((fhandler_pipe *)this)->set_pipe_non_blocking (false);
>>> +	      /* Pipe should be empty because reader is waiting the data. */
>>> +	    }
>>> +	}
>>> +      else if (((fhandler_pipe *)this)->set_pipe_non_blocking (true))
>>> +	/* The pipe space is unknown. */
>>> +	real_non_blocking_mode = true;
>> What if set_pipe_non_blocking (true) fails.  Do we really want to
>> continue, in which case we'll do a blocking write below?
> If we want to return an error for this case, what errno is appropriate,
> do you think? EIO?

This is a little tricky because there have actually been two errors if 
we get to this point.  I think EIO is fine except in one case: If one or 
both errors are due to a broken pipe, we need to use EPIPE (and raise 
SIGPIPE).  This is easy to test if the first call fails. To test the 
second, I guess you'd have to modify set_pipe_non_blocking so that it 
checks for a broken pipe if it fails.  Or maybe have it return a status 
code that callers can test if they want?  I'm not sure which approach is 
better.

Ken

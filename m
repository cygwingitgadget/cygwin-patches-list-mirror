Return-Path: <SRS0=VPvv=QQ=cornell.edu=kbrown@sourceware.org>
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::5])
	by sourceware.org (Postfix) with ESMTPS id 10EA63858C41
	for <cygwin-patches@cygwin.com>; Wed, 18 Sep 2024 14:03:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 10EA63858C41
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 10EA63858C41
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c111::5
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1726668206; cv=pass;
	b=COABoZChhERse5V1ncPacvhNgo+1UyRxEdHSEfVl9TvjjhGjKqWZRHLpqY+QXE4e7dhX1L5aw3SszNk/aNiVf2RPRMNGug1gYhEXH4BqCl4b9fjLfhx7UOAuz5syZTf/aUZloraVMTzfR0zQ9uDZs9DbbskgU5DLXskn2TH0V84=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726668206; c=relaxed/simple;
	bh=nZs/ClEJTJVFKNA/Z+Q3R1Ikq3Xv3vPWhWPlEuHX8Hw=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=nbR3ZDEBMPlzIjLc0jIGZcuWIbmT7n5vSWnhRLLSmyw62unpVYTLAPdxv8zrVzgMVhwsC1uUl6ZuhxBYH4tRsXGuVuo3NqfFl0HK1+/Yts8DvTJJj1h0evQ951CNm5iMbVO76VhG1gwq/2mFRe3aPZxSqJa6/XpVpaZxQwO0OCw=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Apq85RRIm9emLwy00pRnYCF2RpJceOfg9ir05gHlNNSxsLPnoG10w5TGJh4msqfGvR7wyYRZYw4L/srI4Oi2QdViFz5bm6Ew2ZwuO84ZLZ9mddSL6EZBrhkHo41kYOT0BGIzjxzGCQGj8Z9T01+ujWc3JgNCTzx0bPpNEdt68bodJnm4XqdPx3DoLB2Ekc32McgNaf66dCwzUOOnfeHfsUruvRG7tYby4Z2guQsMS+cQctr4FcCzDkg0zuu8Qlk2R2LcR/tljnjlXmia0e+cnDr1X9L3M0lQlA5tQoaHgh8Bizm508qcX72AINnI6lXAadmvgEpZvqvaOkxtbf/tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWbtOT16JfwvdW/3aQaxot2oudmoz2Y7zixsTHQ35xY=;
 b=wu8M1v1sVHJt7fvzoFGRM7MpGdNm9bWezlL9z4Dwaqqr6TWA9J/dHKRIaJtPYzwAn5yWMFnIRS/rTkK0Wi6xDg4wAgsO/1xZwzK3K9nPfv6xcMDATCB44HTMQKH0UXRBnJpgtk2sSx3KtLOzS1UcelGnE6ng+cVK/1OjGSZA/l99zGYEeI9d7fFOTGfNsi8hkzBQf74wqVuLlvAS6mq6a3Ifg+JwPgislBOawOAbSxN5D342bfhVG8j7EpWfpTDjYGeL34Vpd8zILO/HxSGllADCnHL80ApvGp43nQmEJr9wBz5Y/WMsMT+qIcXSksQrmh5gjFdJJwkmXbg33jduxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWbtOT16JfwvdW/3aQaxot2oudmoz2Y7zixsTHQ35xY=;
 b=Sr2kBa6zg3Eybri0ICsoOFYNqmgfg38dqufQMAY1NE6C5FbSiGZCvlVTuCnSPZGEVhu35OU1VuyRq5zFlfv64pfidOqHdHUOTXHzQiwsURnyDsZwz6PPiDZHVJa8d7EO3ZeQ9vLS7VW269HmfxFFlD+Br7Fs0u/aU8IIwi4D4m0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by MW4PR04MB7364.namprd04.prod.outlook.com (2603:10b6:303:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 14:03:18 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 14:03:18 +0000
Message-ID: <21841d53-184a-4a89-8b18-8804a540da5d@cornell.edu>
Date: Wed, 18 Sep 2024 10:03:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4.2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
To: cygwin-patches@cygwin.com
References: <20240907024725.123-1-takashi.yano@nifty.ne.jp>
 <d197495e-b91e-4cfb-bc5e-84fbea62e6cb@cornell.edu>
 <20240917224901.b2569f125ffd15efd1992126@nifty.ne.jp>
 <7fb9a624-9a01-420c-913d-f7c70a04ea9f@cornell.edu>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <7fb9a624-9a01-420c-913d-f7c70a04ea9f@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::14) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|MW4PR04MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: ac310f11-c83a-492b-ae4a-08dcd7eaa56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aitwby9HU3Rja096L0M1TUVXRmJNL0ZZZ2xQS0t2bDU2cHRlaGQ3cFhwalFv?=
 =?utf-8?B?UE9BTXdPeExWeitvTzZCOUxjUjF6R3ppYXJaTWE0Y21rSmdoL0gwYWtXU2Jh?=
 =?utf-8?B?dGQ5T2M3eU5VdzJqN1FURnMxcHQrc2c3UFVoWFhkYVdDNTdhWkJTRUE5Mkcz?=
 =?utf-8?B?TnlhL0p0dU5tS2YxV1VzdmVuSXZmbEhtamdOREJ4eWpIQk05TnhONTl3TmJP?=
 =?utf-8?B?ME5nL1gyNmZSbzRneGN0eGZiWGp6UG91UGJORUZHSlpXQUFmcHZMVys5dGFv?=
 =?utf-8?B?MGZNWTVtYitiU2wyNXdMeXI0bC9VZXRUdUE2a0JmU2VEQmt6TDA5RXZVN2FF?=
 =?utf-8?B?RDkyMFl5TjZLeWh3M3RndHZRV1B0R0tyWk13OHNhZEZBMXZFakhxWDlOK2V1?=
 =?utf-8?B?Y1dkUUNuUXlHT3pQSDE2bTF6ZG1sMWhSOW1EbFpMMTRGaUhBSkdQSkVIcHNL?=
 =?utf-8?B?RWY2TGtQZm1Cc3pLdlVSNE03bG5PenorYzFSam1VT0pDZXRDMXRTOWNHeUw3?=
 =?utf-8?B?MTdxdktBYlBXNGpLYmN2MlJXOTdvYnB4N0hVb3Q5b3VsVmJCYlBKSFRQU0tu?=
 =?utf-8?B?ZmQ1ZlJpeksxc1RnV1FCUXZYOExDVWJWYmNaSjNLSERFdDV3YzlKYzdKTjlS?=
 =?utf-8?B?NmdUT0YrNDdlaG1ENFlXeGtmbDVjMkdFL2lUKzFXYmVlODNVeGhEelpGY1pz?=
 =?utf-8?B?REtPYWxqNzBMY2xKSG9tY0tzcTE3cmNYbUxaejduUjh0VS95K29UUmgyTnpR?=
 =?utf-8?B?ZGNUeC80cEVpQ2V5SEZreGpFYXgyNXFXSk40ME1YWFcyOGhPVm9QenZFTzZM?=
 =?utf-8?B?YUZwdTZseHJyVDlKc2lDNWxaRzZsWExSSDBucHoyYk9lcEJsYXRHZjIyQWhk?=
 =?utf-8?B?Yi9XWGQ3MTVMNFdSaUtWWG9CdVpvbnYreHBhZjlhWmJPdS9qa21aeXlqek5W?=
 =?utf-8?B?czVscFpUVkVvOG43VjczYlhkOUxRdXVVKzd5TjZvaVBlRkpUT3g0T3AzenBV?=
 =?utf-8?B?cG9HSUYzTytpdUNETS91T1htQUcyVFZPclVsQm0vSVVNeDNtSTJIcy9HWjhZ?=
 =?utf-8?B?ZmJmTGk4cFF0V09wM0VER2t4VXZuSXl0WVJuNkxtdW93ZHdNcU9nWXJJNU9W?=
 =?utf-8?B?VGViYkpoU1lTdUU0K3Q2NTdjZjBYYkJzeS9xTzFFaDBpZ1QwbEtheU10dm9j?=
 =?utf-8?B?SEcxUHdzeU4xU1hnNlF3YnhxajczcWIyckNSTG1ndzg0Vmh6cjN4TkdmNXR0?=
 =?utf-8?B?dXpmV2gvRzRRVCtDQUsrSVhsQlFlcnVEUTFUbnY1a1VFZlBXWWh1WHJLYmtD?=
 =?utf-8?B?R3UrbEJONitlbTFzMFE4Z0greXJTLzFhYTBPZ0pMR0tGcjRDaWNmMjZDbXl5?=
 =?utf-8?B?R2ZRTk1iZ2xEV2REZ0l6dy9Fb0FyNmRqZjFaOFZ2U1JvSm80WWpYZksvQXVw?=
 =?utf-8?B?K3VZaGdaL3NXY1d2dmZWdm9FSytPOTRtS05LaUhjSTYyZ3BLK1dWVXgzbkYz?=
 =?utf-8?B?SW9kNmhrOXphd21lMFFjL09ZR3lpNmdJUjE3M1FKemtiekQvWEF3ZXNBSjNW?=
 =?utf-8?B?T1EyOVZMbHkxemxSQ2tMSnQ0emQ0RjR0NzhBWTFVRVJNVUtCTk1XVWtteklI?=
 =?utf-8?B?SzVDc3BHbTZRbmNBL1BJTHZVeGtlb3pqa3BkQzlibWFKSVlhODNYY0l5Y2pR?=
 =?utf-8?B?cFV4bkVzS2hvQmpSYnZENlE1VzVlTkNya0xpelVRY1VKYTI3VnZPY2U3a1BR?=
 =?utf-8?B?bWhiTXpmMFhWRXFQc0o0M2c4bkFIbzVGaVl3NEMxVUcyWEYxb25ZM2dJdkQ4?=
 =?utf-8?B?ckdlVm9nWjNhMnNBYjdQUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXpyVkxCZGxqSmdrdEZReG12TnFZd2NCODAzUDJlOFdCQmt3N2p5NXY5dzQ1?=
 =?utf-8?B?UG44T09ITXhLU3lZTitSS25LM0ZBYWpCUE1ZMWVGSE85RTJYcGI4eStBMEVU?=
 =?utf-8?B?T2cyYzJyUmt5WTdWNEtKT1lZaFBDZWw2SmNldGdvbHlTa3VTcTNjUFVQb2JK?=
 =?utf-8?B?TXd1ZkYyQzh1YTFXNGJidWdVSmxzZmJLb1lTRjE1a29IVHBOdHB1S3VGQkVo?=
 =?utf-8?B?L2RmTkQ1SDRpeTVVdnNrUzRHTk96N0NXM2pacCtZRFdTQ0tsRXRKRFlWRW1F?=
 =?utf-8?B?THVYZVVpK0RFLy9TNmg5bTl6ZTE5ZTlVcExoNThocGpWSytqMlIxMllqSHlT?=
 =?utf-8?B?WUxtbUs5NWtDRDVnS3gza0xPTDJUQmI2V2FwL1pvM2YwYngxN2RMR0E1MDZI?=
 =?utf-8?B?OXEyK0F6dG80WHlpSVpWeVlieVBYSHFybkY1M283UnVEcVNIT1dPNmV4VThV?=
 =?utf-8?B?RHdqMlNEd3J6MGhReHNjSEJ1TXMzUnRSTS9DUzQ0dklpYllOKzZBUmFOYjQ4?=
 =?utf-8?B?NHhzS0FFQjRZcWpadmlzbGpSVFVpR0xYRzRVK3pudzArOHRSK3Vra1p6S09B?=
 =?utf-8?B?NzVkUUlDY2VTRG1aSlhsNHJidk9YOVEvbC9vbHVjd3JBTkRjenVkS2hXeFB4?=
 =?utf-8?B?UVkrMFRpNENPREg0d2JiYWt1OUlvdml4cDVLOUNkZEFEdUFoWC9WNFZYOWlG?=
 =?utf-8?B?V3NoZEp4VHpFR2REY0FBVmVoY2NvK1pDeGU0WCt5WXlERDFpUExNNzJjMTgv?=
 =?utf-8?B?K3V2VkhFUHZYV1UrWTFlejVjbEpJYU40T3NreHVEbVNYMjZKTzVDY242NHRo?=
 =?utf-8?B?aFN6cjF4NGtLOUl3eEhUcHNCbEJNelVoZGg4UHM2QmVsb3ZFWGxlVGx0U3ZR?=
 =?utf-8?B?bjFnQzFUdU5PcEk0Wit3M1o4c2twZTNzb0E1Y3JZWEZNbzhIWGZPd3JxalVK?=
 =?utf-8?B?VUpPckdrUTVIRXRBQUx3b3l2WGkvNlBkSFlwdGZHbHpVZEZRN1ZOQ0ZoYVdy?=
 =?utf-8?B?V2RqTjU2eExrOVl2SU50OS9nbm94ZkN5UTcvUHJLSmJNZkJnNWNzU3RJWUJS?=
 =?utf-8?B?YlZlb2lhQ0o4ck02S0NWeTJCUlZudjEzT2NVZlFadUdMR2pEM2ZxQUJoTmJJ?=
 =?utf-8?B?dzM0R3ZQUWpFMFhwYUF2SVptQytwZVB1NStYb3BJV0lYU0FsdlZhWTczdS9U?=
 =?utf-8?B?WXp6UzJYN3lWc2RLMzM1SVJtLzZoaUJ6ZEczV3dCRUVueGNPcG1pTWVJS2xG?=
 =?utf-8?B?WUE3am42cHRSN05MbktuUVF3em1va1RSdU05c2R1eUxuN3Vsek1FWnpYREs5?=
 =?utf-8?B?dlZSOVcrU01OYm5HQ084eVJlWkF0SHd2TElkQUQ0R2Q1dVBpMFp5VGQ5MEVp?=
 =?utf-8?B?ZmFCTUtkaW16cUMvdFp1NWVoNm55b3VzMW9LTjE2V0tGMFUzZk9hdWhoMHgw?=
 =?utf-8?B?L0QvVWdZU0dCQUpzeXVJZWpZdUllVU5vS3pWdjlraGlEQmh4dDlUbDh4em12?=
 =?utf-8?B?ZDZGTCtYUnhVUmhobzY1R2t4TzEwbWFVYWt5TkJKKzJzbnBZNVpPS0JZK2hm?=
 =?utf-8?B?WFh5R3Y5Q1Q1QzU3UmwwNGgwWGtCMTc4WlVtNndDTEt5b0VwVmZiUlluQjMw?=
 =?utf-8?B?QldDejdVdVpTZmNiSzhCbDBPRFVpRFZ0R3BBNGxBbkU3aWlQd1BKOXlEVm5m?=
 =?utf-8?B?cjF3Z1FTaHhTa0UvNEZnankydWJhdmIra1BqYlNnZDY2enpYT3dVTTAwVFpa?=
 =?utf-8?B?UzF6aVJWaE9wZndDOURxWk9FSHp3WGxPSElEUGZHcnFPNjB2R0NkalZrZDVZ?=
 =?utf-8?B?c0Q1aWlFZ3RHblhOQkJwcmp6VERrSHY5OE0vQWZOSDF6cGUxSWpKaDVLcVc2?=
 =?utf-8?B?TnlUOFN3UVk4R1huTTJRbTlRT09lNEh5SzY0c3QxTFpYcmJhbzRlbE1nK1Bm?=
 =?utf-8?B?Um8xRit3NXpXNWJVMDBTQk9uTmNtRy93UFhBNGRqbzRqUWVmblhFVXhydEZC?=
 =?utf-8?B?VzhMWDYyMHVTdG51MDZwOXNQejFVcTdYT2xwbE5oVkZwS09uVEFXbFJuT044?=
 =?utf-8?B?K3ArbjdCS1BGbjFSaUd1WDdVUkh2M3E4ODVDR1FKMmswZzZhZnB4Y1p6NmFD?=
 =?utf-8?Q?aa4cyID05kcETJ6Qz4XdgOSZp?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ac310f11-c83a-492b-ae4a-08dcd7eaa56f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:03:17.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTfirX/JoI3tokWDr+wwwawfC8crjQHpT3lQh+qCbBD8NTWEWizrh99/XqgH+r0KEOFj2jULVN0i7fqwXQqJxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7364
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 9/17/2024 2:22 PM, Ken Brown wrote:
> On 9/17/2024 9:49 AM, Takashi Yano wrote:
>>>> @@ -439,19 +396,45 @@ fhandler_pipe_fifo::raw_write (const void 
>>>> *ptr, size_t len)
>>>>      if (!len)
>>>>        return 0;
>>>> -  if (reader_closed ())
>>>> +  ssize_t avail = pipe_buf_size;
>>>> +  bool real_non_blocking_mode = false;
>>>> +  if (is_nonblocking ())
>>>>        {
>>>> -      set_errno (EPIPE);
>>>> -      raise (SIGPIPE);
>>>> -      return -1;
>>>> +      FILE_PIPE_LOCAL_INFORMATION fpli;
>>>> +      status = NtQueryInformationFile (get_handle (), &io, &fpli, 
>>>> sizeof fpli,
>>>> +                       FilePipeLocalInformation);
>>>> +      if (NT_SUCCESS (status))
>>>> +    {
>>>> +      if (fpli.WriteQuotaAvailable != 0)
>>>> +        avail = fpli.WriteQuotaAvailable;
>>>> +      else /* WriteQuotaAvailable == 0 */
>>>> +        { /* Refer to the comment in select.cc: 
>>>> pipe_data_available(). */
>>>> +          /* NtSetInformationFile() in set_pipe_non_blocking(true) 
>>>> seems
>>>> +         to fail with STATUS_PIPE_BUSY if the pipe is not empty.
>>>> +         In this case, the pipe is really full if WriteQuotaAvailable
>>>> +         is zero. Otherwise, the pipe is empty. */
>>>> +          if (!((fhandler_pipe *)this)->set_pipe_non_blocking (true))
>>>> +        {
>>>> +          /* Full */
>>>> +          set_errno (EAGAIN);
>>>> +          return -1;
>>>> +        }
>>>> +          /* Restore the pipe mode to blocking. */
>>>> +          ((fhandler_pipe *)this)->set_pipe_non_blocking (false);
>>>> +          /* Pipe should be empty because reader is waiting the 
>>>> data. */

One other thing that I missed in my first review.  Is there a possible 
race condition here?  What if the pipe is empty now but another writer 
fills the pipe before we try to write?  Can that happen?  If so, maybe 
it's safer to leave the pipe non-blocking instead of restoring it to 
blocking.

>>>> +        }
>>>> +    }
>>>> +      else if (((fhandler_pipe *)this)->set_pipe_non_blocking (true))
>>>> +    /* The pipe space is unknown. */
>>>> +    real_non_blocking_mode = true;
>>> What if set_pipe_non_blocking (true) fails.  Do we really want to
>>> continue, in which case we'll do a blocking write below?
>> If we want to return an error for this case, what errno is appropriate,
>> do you think? EIO?
> 
> This is a little tricky because there have actually been two errors if 
> we get to this point.  I think EIO is fine except in one case: If one or 
> both errors are due to a broken pipe, we need to use EPIPE (and raise 
> SIGPIPE).  This is easy to test if the first call fails. To test the 
> second, I guess you'd have to modify set_pipe_non_blocking so that it 
> checks for a broken pipe if it fails.  Or maybe have it return a status 
> code that callers can test if they want?  I'm not sure which approach is 
> better.
> 
> Ken

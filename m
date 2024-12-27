Return-Path: <SRS0=8JuP=TU=cornell.edu=kbrown@sourceware.org>
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	by sourceware.org (Postfix) with ESMTPS id 5A01D3858CDB
	for <cygwin-patches@cygwin.com>; Fri, 27 Dec 2024 13:41:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5A01D3858CDB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5A01D3858CDB
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c110::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1735306884; cv=pass;
	b=B+eBmgwrXAaWephclY3J5J0rUO2+PZZGNahvbFCTzFcVJm9yFAPLSuRL2auOv2ySVVyxh/Q0HlFyVaJWv3c5BhnwY1tD2fZF49rKdyFzhg5D8KwWP8Cp4XBVpb2aTdYK4uq5R/aF/KjSjTOtN1LxqvmHlJi8L/se+01tMUw+UpI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1735306884; c=relaxed/simple;
	bh=BSEnCM9YNJ4Br8aXbgifltme/129KAgGUF5TeLk0iKc=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=f2eEgDgSxfWQRchw7J+bmEIwyHwJMJijFzNVnXeuuGUaG2z5bAFEElit6Kg2fgPLwmesi5lysQ9uZZqVQSZ81h9tkrKhtxYtKWvNqwya3Uw1h2kISl08XNhs6sVNP8k+OV+X4LAQtjTJ2fZgfN37NSAzp7ZaVO9/+y544HT7d9s=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5A01D3858CDB
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=FE4vvfO/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8EchPB6Ef4e3hWVgGBJlGglaZn9sHENiMK4H28lX7zyRoLh/u+7/Y0r02wF6Q+BGH63+fCH33hkO3ZYwNAP+hCPn9cA2eHZrUcxd9iT39YRH7MDK+vEL/FOlZ1P7zrFthcMICSteJi+l6dvZtiwtGalV5W9WEo2MsJSQKql8THKr/GvcBnLEK2UpmfxESaIBmdMt7KgzldT/a6GaOYHT1+J5qRddQ/lEoJOhPmHE4tMwdlJRphDNScvweZK7Rw3x14kb7kfYwxh4443Q+ZigFEW0lWsAN2M3kmyeeL259UAZXOux94mon6GoZoWaW84N3rROW9Dvy85qoQ4mDHB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qznUggsoEduykZOm92Wr/ojP44vodJDRUBfQdLdZ9A=;
 b=qSrL7apmTzDIG4zLEL/gTUHt5SxjFj0yoyhBVLHq/nblycxXh9CG4QBvdlarj3/AkYAmtB35LMt3k7rYrGswMNikmPBKfPgB8FPqXpIqmtYUA27rw1RuqnQ9ViaDeeRED41RhCFDQsEq8YcGJJ6qPV/JPebm042Whf9n/+fFPQVPVbhRljYNlpMFhvRlNDDwEYYrbw+fB1e3QX0dQ8oylwvLJMBfbEF0jxmiFRj7HwmPaivxwF9yieiOocVLymw/H9USbB1ptvmOIqf3hVh12mtuz0g6fFGcvMfdsOM2A9m2rNGDHlM1PfW1obmeWUEiSi7GmTdNprDecEB4GrOVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qznUggsoEduykZOm92Wr/ojP44vodJDRUBfQdLdZ9A=;
 b=FE4vvfO/fUj6wOUwjEQZyjHhGRubEyqp+nH0nZecZLmqJ7dGpF4fYfQtj2mcsY+kydQc8PcbiuBSE9BUgCW2bZ48i5lEjsFIlcawqM+lqhpOLOgY/d8F9HWdiUwwydUNxooAnvQWGNTPHA8mITTDxWkOxIi7QAZ/9GtaTdAMlOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DS1PR04MB9537.namprd04.prod.outlook.com (2603:10b6:8:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 13:41:12 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8272.013; Fri, 27 Dec 2024
 13:41:12 +0000
Message-ID: <4d727456-f09b-46f6-848a-2235b018f9e0@cornell.edu>
Date: Fri, 27 Dec 2024 08:41:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Fix mmap_is_attached_or_noreserve
To: cygwin-patches@cygwin.com
References: <72f53e43-5475-446d-abee-9ab3de71c25c@cornell.edu>
 <20241227210651.95954d8ac327145614f83f36@nifty.ne.jp>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20241227210651.95954d8ac327145614f83f36@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::28) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DS1PR04MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 94df90ec-5b7c-441a-94cb-08dd267c2078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajhHOHlVOHc5b3VETlNCTHh3N1BWbjkrZnF0ZVZxcmNLTFhnZVN0K20yZjZz?=
 =?utf-8?B?QmxUVTVTa1hkZVNuMVErMGs5dmdZSGN3ekZBOFVjcFl4N2dnRHZJUmIyMzFC?=
 =?utf-8?B?emJTQXJEVStQbm1Pck9janhOS1VpQkhVQWJ2OU9sUWJKTXMrQk9ZNUZianl6?=
 =?utf-8?B?YlhwSUZHWlhLMEpTcCtVRW1FUFAvdVhlN0FXTFhPMnNqckhuV0s4ZFV0bGlq?=
 =?utf-8?B?UFg4UzVpdzZ1UTErZnlNU2tJR1cxYXRDRzVlRnh6QzRPbHpiNDhMU2NuaUl3?=
 =?utf-8?B?NmhpRVpMb01GUEl6ZUxVL0xxcVBzTERyUXJHUFUvZk4wci9pSnZ0UlMzRjhm?=
 =?utf-8?B?RjRvN3VOaTBuRVZ0RnFEeGV2bTl2emF6cDNrS0QyOUU0aFpyeVZsd3cxTk96?=
 =?utf-8?B?TS93SUhmN3lCdURubTlObVRhblNLSm1ObktpQXk3NGNxdU1iSkNYVzUwcnRx?=
 =?utf-8?B?dnBRSUVhR1FKRnhkL1Y3aTFYWlNQQVMwS3ZxekFkRGlQcncvSFBydjZkVFA3?=
 =?utf-8?B?NklWR0hQaWJML1lINWhPTjBJN1BpWFU5Q0owV3M2U3N4VkRuc1Fsc0d5Y2ZE?=
 =?utf-8?B?c29LK0dXcnNGYm4vckkwYm1xaXZFR1o0WXRRZlZSU0FoMndmb1NYZFZ4LzY4?=
 =?utf-8?B?V3gxcXNJUTU0NDFESGM3cXpHMU9JYkl0c3IydnpGeUVGZXU0Q3c0N3QrTE9v?=
 =?utf-8?B?bHBza1NGajlQTFZoMGZXT3lPSUFJVHlQaUQzQWJUV1ozT0RLNVY0cFo1Q3BT?=
 =?utf-8?B?dkl2SEU1V3pqaW1YbWxuY0RDWXltM1NLNGQvZFBOTlhNa1FXWkhqNEVKS2dt?=
 =?utf-8?B?SkxMSnlZbEZWVXRjRzdpWktlM0dwVndZRnNKNy91WFB6aEtUdnBJVjUyM2RL?=
 =?utf-8?B?R2tvSm9zZDRxTVZPVzMySXBZMU1rUlZKWThJbElYaDRVZjhEdjM1TTBIeTNm?=
 =?utf-8?B?ZS9xdG9FNzBJWGRJbUcwSDlmS3l6eCtwR0RWckkvTkhPamtCZzlOV2xXV1BE?=
 =?utf-8?B?M1lRUkRIcitZQytiaU1UbW45cFZHekFGVWRlYitXVDU1NERwdE9uNVBwemF4?=
 =?utf-8?B?eXFzamVQRVptVkFsbXU4anAwZ1ZDZjQveEs2YUFXckxYU0UwbUtVYnVvZXFY?=
 =?utf-8?B?aXNaMTdxQ2UwMUNzcTRmaThuWVc3OHhnaUFHSDNrWmZOSFVKZ1BudHVXTkpm?=
 =?utf-8?B?TUZLSkZuR3QvRVNpSjkrRE4wZ0kvQ255c0htZGRDL3FEWDR3RE9la0wveEF0?=
 =?utf-8?B?Z2pDSVBGMzMwdlljMWJHamRSQ0xkN2xvb3V3bWs3LzVOdXZEL2xuRlFpZFFm?=
 =?utf-8?B?bUt0RXAyQ0oxZE15SXAwaFlCUG9JODhKZThmcGI5cVRsVTdla3dwMENEd243?=
 =?utf-8?B?ZGlTb054Rk9BLzNoNlp5ZVdoUXFwZVJHRUJQcnplUXRZUFVPdmJ4bGxyTjZw?=
 =?utf-8?B?MHpKS2VmamhMTDExMmpqZEExYXFGZm9CMkhpMGRoZEtKVjRZTklDWk12dUh1?=
 =?utf-8?B?QVZTRWVZSFl3a2M1TUlpNDQrem56SDc0TjhSb0VlOS9sT0ZJbFJTbUZ4UC9J?=
 =?utf-8?B?U1pxbENCeFZicWp2N0tSTDNoZ0tMb2JtYVhGa204TTcxdVFyS2pyUG51VkVK?=
 =?utf-8?B?UEQ5dEJQR3ZhdDFFMWtZRm1IaDMwZDdKYTBFSmFYM1lXNllORUs2bXhFMVA1?=
 =?utf-8?B?QVl6RERSTllmdDB3OFIxT1Y0UFNtYzg3Q0JmL0FzbUpqS0dHTjEveFFocTdV?=
 =?utf-8?B?alBoTmV4Ujlmbms1MHRocVNBY1J5d3hQdXgxWG1iS0hhenU0TmNFZVVxMW0v?=
 =?utf-8?B?VzlvRUFBUnVrRzlWbUdhT3gvK0hCdU81WG85SHhZZFdXU29BQU52eHNpbVQ2?=
 =?utf-8?Q?HIa4jJ1C/Pm6E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnFNdThwME91K1J4QjAydHBLWG9kUjdqSkNhNHM3bWV0a2pFa1hHaENuaTk1?=
 =?utf-8?B?b3YvU0dFYkVUdjJ0Q2lCVGdVQUMrYkRyd3g1YVBqSWhqcGRWdkRNdmIzUmly?=
 =?utf-8?B?cVRrVVhsclNZRUtRbTl5RlNyNEJKYmREZzBQWmtzRUt5d2YvaXlza1pQM0RZ?=
 =?utf-8?B?dXlxTnZHSTNPdTFEeHZJKzAxT2ZkU0VMMVVyckhZSWlZbzZkNllHdVI0YnND?=
 =?utf-8?B?WTl4by9GVjBiM2xxT1Y5R0pwQWptaEh5K3FxK3U2MlhyWVE5aEVqREQ2UUZp?=
 =?utf-8?B?Mi92azlLWkxNOWpSem9xaG5QUU1GZkljNHhLeW0zNFdEZWY2MHdBaG1MVmNJ?=
 =?utf-8?B?UjUwV3ZkZWxzSytXTkEvSDRnd3BlZEQ1ak9ORGhRdjE3WWxvSGgwaUxVd0da?=
 =?utf-8?B?YTVLNkRjUk5NUUNOSnhYSCtoRjljWmFRVVZVZVZGWlhLOE0zeVRYRXo1WWNH?=
 =?utf-8?B?aE8xNnlRSFUyY1dCTVhiV0ZYMnh3b1JhcFdQek1qdXlHYUw0WjdLc0lpVU1n?=
 =?utf-8?B?c2cwOFBGSGdxQ21Gak42cmlFYXZuVDRHSmZHajBUOTdaRHR6Z25UWVVPTTk1?=
 =?utf-8?B?THhKQUlwdlJEZ0E2SW0vMmp0ZXFJa2QveUFCK3ZTNjlTUXhURzNVV010Nm9H?=
 =?utf-8?B?NGkzZ2lMS2w1YUlPM0RTMFJOSnNyMjFMM2gyb3F1dGsrdXpzMU5tMXIzY1pO?=
 =?utf-8?B?M2thZVlEL0l4NlFLV05vbFBzZkdsSHJKQ2ZBQmVoRjIwVitFcHVtUUJmbnZs?=
 =?utf-8?B?M1l0cUtQVWpZVDBRcm1zaXBJWFExYTZmWGlYZzhwSDlQcDNvbk44NXlpM1lm?=
 =?utf-8?B?MUtqcTMzdHVKRTFPN1p1TjVhTUhEVnF2ZzZYQmtyNkdobWtuQUpPREhkTVkv?=
 =?utf-8?B?MGhseEFNNHkya0ZrWnJ3Q0VoU1ZRL0V4OHVPc0d5cm1PYW5vaHFpMWhaWDdV?=
 =?utf-8?B?S1Rzb2RhS0paQlpJakc1RUVhMTNNemZ1TEtvMlVEQTJpMm9hdE9qNFNETk1F?=
 =?utf-8?B?Z2pVeVhTRC9DMEZxV01UMDhJUmkrUmhlVWZqZHQ1dGp6d2djN0VqdDVpaGIy?=
 =?utf-8?B?Z0xSWXU4Q0N0Y21GSldJRURORFJzR0VPaVg1NVNyU2UrNWo5YWlRTGFJbkVx?=
 =?utf-8?B?Y2NjNFRjNUxZd3FIL0Q3RTVOY1l6UXBITitKeGRTRUpzSkdlcWRmQWlYMFdL?=
 =?utf-8?B?N2d1MUlMcHpJeENzakFJTUF0ZTFrNnNPZlZyQVhLeGlvUkhmQUUxdFZzZ0FR?=
 =?utf-8?B?U1JIRUZkaDJqTjlldjVxYitGM1gvZ0dWSzJVNldpaEdRMlpabFJZdkw4WWJ1?=
 =?utf-8?B?TDY2V1ZqWG1hUXU1TkRSWjJmem5OMndxMWdZTTFSREU0YXN5Mld4YkpEb1VZ?=
 =?utf-8?B?b2o2SG00Zkg3WDFFUzN2VnVCc1diRXQ4WUc2YzdYMG1iSXVXUnVsdFV2aXlE?=
 =?utf-8?B?YjUyN1dOMy9ndGNkbHR2Z3A2dkpkTjJEZUdkRm4zTkdzeUlKS0hjYWphclZj?=
 =?utf-8?B?UHdoa0VkNmFVRDJlQVY1cDJRbEpreHVPSTRnSW5VbXlOWmthdmRtZEJHYm5R?=
 =?utf-8?B?T2xnOHZYcGtVSTEzbzFLMjY1TVBiNDJXY0srUWx3OHEwM2plcitYcTE3VWNz?=
 =?utf-8?B?elI4bmlPbm5GU3o1R3lJSmpGUk5kbzhaTm9nbkhWM0xCdnNZQUlhRjRsVVd3?=
 =?utf-8?B?SzBac28vN3BHY0hNZy9vSlZoVHQ3T2l6VHNmaGNQWHFEME9keDJ5RldHUGVD?=
 =?utf-8?B?a2JxdzhHS2twWEpIY2thdGpzWU5uTHhDSEFpRWI4NmRUTzcrdzRKNnlVbExl?=
 =?utf-8?B?cHBTMEJNV1pvaEgyVUZUL0JRRTZpMENTeHQxQmVJT2JTOFBqKzhPZS95MlFk?=
 =?utf-8?B?c1l2QTY3QzFqNlo2RkZQL1VueitQQmQ4ci9lQktkMW5GWXd0Y3NjVkRFb1cy?=
 =?utf-8?B?TlB2WHd5dlYyVWhEUGtKZGtQdTB4ckJxR0Q1U2VNVW5PNkM1ZS9oRytmaDB2?=
 =?utf-8?B?SEFvbURDK29mMnFBZTJIQnZKQTNjUWxUZmF5U3lvU2dnb3VPNEpUL3cyaG5v?=
 =?utf-8?B?d014QlFRTExnVStWS2FxNnZNcmFTS1dudTQwVDFMU3RqUk9YSk8vYlR4bHVW?=
 =?utf-8?Q?ihtP9aFCQYVlBjFAaKEaITfpy?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 94df90ec-5b7c-441a-94cb-08dd267c2078
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 13:41:12.1052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4NFxcfSWqcjf6VxdqTuhnZrDeSQTW878PZNUN0C4o661C4svik4CZKKGs1iuxFJ0IlZR8WGLQ2NXmBmwMC/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9537
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 12/27/2024 7:06 AM, Takashi Yano wrote:
> On Thu, 26 Dec 2024 11:56:00 -0500
> Ken Brown wrote:
>> +  LIST_WRITE_LOCK ();
> 
> This patch atempt to acquire lock despite the lock has been
> already acquired. I think this is the cause of deadlock.
Thank you!!  I can't tell you how many times I went over the patch and 
didn't see that.

In the meantime, I've found a simpler solution to the problem.  I'll 
send a v2 patch later.

Ken

Return-Path: <SRS0=G+UD=QY=cornell.edu=kbrown@sourceware.org>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20710.outbound.protection.outlook.com [IPv6:2a01:111:f403:2009::710])
	by sourceware.org (Postfix) with ESMTPS id D68B73858D28
	for <cygwin-patches@cygwin.com>; Thu, 26 Sep 2024 14:32:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D68B73858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D68B73858D28
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2009::710
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1727361137; cv=pass;
	b=ZHU5xIun76uv8cZpdSQbeV2ClaAHonROiPBsyNfT3WEXIOy6c3hkADnUQuos7JdKw01QRFnN0bdhC4X181SvWgNdGr+VZ1yU3UIH60n8rYg5CxDym6FMa0Vm6KaMG5ZWN/EkYxp6sNiqEx19Rc81UDK8v4wQYDHshHNjbDMZiaI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1727361137; c=relaxed/simple;
	bh=Ed8St28QuyQwj9L7SLzsH+jQ9KsW0W6f7+PUQRZfaf4=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=MH8k9Uwg4vW9JOTjLkEIz6s2PnAkpLl6RPaQ7gBs0rfCnImI98K3e2JuquvLv0cc2wHJ+Yk599XhRzQYA+JkzHhGgatGaZJJYvNwkP3VZVKpe9/LubjgQJE2f5T3uvv0ydQkizdgc046xQN3cODwOYbqSOXGquXsffAQJ84HDNY=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4s7vy1/9KmnlFg6XuFTe2Wg3wWpwrHu0djy8p5eNf2CiQEO1piTm6saKTuBL4c+YdyPhGCdpYmSMb3krlBVWRYth4TT3ib0DLIx4+OdpcGafCW8L/cJDqWCxKh/MNzGerKGcqOc1npdTHJKgKcrB+Q+anCfzQIeLjrp/X+q3RNv8GkEQfcN1B/zmu5C0wxPUZv3fhNQIi6OFri10jdDGXVXSOWp4Dh1+ccWwn54OcWKQW1O7Sze0aUYRKM5X+XCJuAGoDIPhMOqW+TUAXMr8DU2VIFKBnbJLXSjI5Vh0+scb84IYto8pz9hoTgWBlAglTkD5fjAEanmHuZv4cftWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhTskIsY5KhG1yUaIj4ClKt6LNeLapcrtuktYsFPqEo=;
 b=n/4w/t7JV/hFeAbBe3LdxYzvRft+VwyPQODFLXFvEIf/XcjBe4Ks88KLLbQ0+y5CIeH/9NjQzZnLyP3ZvC0bVplFTnpNRQg1iTjlmkoPIO9ncoz1rDXnyzAtCdUeHbsjFt1qAXFK1qBobApOW6415paeawJ2Iytlv1QxpzQnmlKFUy2hYGYQZpPHACDYLCAaGfUeOhwREQX2aZMTP/cF9CnG88SoOLnD6vJmD+6ty+SneGwIJ725A913XpxZ5A3AxwYbavv9Gf4NocLW+mbrJ+kvELyKdyNZ0ZY35qp3m9+PfnaW8bUDq62XhQKTJM+mpPb+VgKF3pQVnhJRMfTzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhTskIsY5KhG1yUaIj4ClKt6LNeLapcrtuktYsFPqEo=;
 b=UpJloyp2R5daR5MwTkshuo+7XBPrbbsOcM+KaKsHRPpR07XMGDQKZHlWKRV2R3tDpkRdVTn6OL2oZMm8pXvGLfJQeHCQtvhPEBVCmg5GMFrOlipxGftZ+yAFume+mXxVqU1AqZOe8waH3+8qcQvWwHPudBykYjs4C6uNMmCh7+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by PH0PR04MB8227.namprd04.prod.outlook.com (2603:10b6:510:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 14:32:13 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 14:32:13 +0000
Message-ID: <5e5be0c4-a640-4c31-b35c-c3b7583f2388@cornell.edu>
Date: Thu, 26 Sep 2024 10:32:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
To: cygwin-patches@cygwin.com
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
 <0e6831d3-9c46-4467-af45-4f72555ea4ff@cornell.edu>
 <20240926210923.e754c56dc508baeab53f7bd2@nifty.ne.jp>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20240926210923.e754c56dc508baeab53f7bd2@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:208:23d::25) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|PH0PR04MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: ba29733b-4a3d-48ca-397b-08dcde380305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1FZcktqbTdyK2lGOUtzUGpWZXV2Q3lMQURBSzNXSTBtYnRqVjlKbTVrenJt?=
 =?utf-8?B?TVZyczhHRWJoN0NqcXRrRDRlZ25LRlRFL2ZwMXJSZDF1RFY5TW1ua1JJejNI?=
 =?utf-8?B?alBnRTROTFRjOCtyQWlaYzZmVDB6S1Z6NzZUaVIzL1gvTmFsOTkxeCtrRDd4?=
 =?utf-8?B?TjlJYXZXUWVZNG5YQWxHN3JsZGp3TnJ0Mks0bG45cWtVSE5MT0NJekpHdXM1?=
 =?utf-8?B?bHBJaiswclRzZ0NVN2NmZzFTejV0V2xQOVc0dHU4U1RHMUJHcy90Ym4vWERt?=
 =?utf-8?B?S2J3ME5pUEw3a1owNmNRR3lvTXcxQThkYnVRSDJiNytIU01DUDRFUTMzblhF?=
 =?utf-8?B?YVM4bjd3d000UXRvN3g2ZnpTZmYrL1hWb3ovU3llVVZGSWZzTi9KWVVHZnJG?=
 =?utf-8?B?eEdYYjRpbFhYMm5TVFp2YU1sUW5PaDJYM1FoUHNzTVdUVDl6b3hQWVJLYUhp?=
 =?utf-8?B?Sy9SVnluaktzMjF0K1dYZDBpNVZJTXBjcHRQa3RocTlmbS9YWEs5R1ZmZVVV?=
 =?utf-8?B?R2Nja1dNYjNSbHlnNXZJVXVMMTFYYjVwMGxKeitLMlRyNlVVdUdaK1VXck13?=
 =?utf-8?B?L0diVklTNGdvRWN3Z280cTU2THRIRnNJTTUzYmFYejkycTRJZHU3VW5LSWJD?=
 =?utf-8?B?a0Jwb1ErVFBocnFjb1NWam5wMzZjRzBQdFdnbEp0SmpTckk1Und4ODRIdXhK?=
 =?utf-8?B?VStHb0xTYzNsSHR3dE9NQnp5TjUxVEhYOTAxdzByRXVuSWZTUXRtRXJmRFpH?=
 =?utf-8?B?dk5tWmxnSkFrRVdZZE5WYjl4M0FsM2pmTkF5REJiQlJTM2d6M3JKY1JZN0ty?=
 =?utf-8?B?MWV2cnhIUTJXMU9uZnVvaThOUHZCV29CZTNHakJUR3JXVUc1MHlQOGEwL1RU?=
 =?utf-8?B?WU9LOGZZUlJ5akMvWThuOUMyRUR4WFkyMnpLZ3FubnlTdGxSK21DWlRla2Vk?=
 =?utf-8?B?MWNCbW1wVGZvYnVEUnZ2cFNSRE5peVRuQzd5UGtQVTZQQU5oY0hrNjFIUE5n?=
 =?utf-8?B?NFVCWGEvRURjbldkbWF0K0tUS093YXRncldJL0hGalpRMEdrTk1DVG1kcFVy?=
 =?utf-8?B?YndWbCtKK2FaZlEzNUs1ZVZEU2Fudm5lRGY4M3ZNREI4TUg3VnVPMndhV09Q?=
 =?utf-8?B?UEJTSkt0NEhCTmc1dXFBZ1VWSVY2RU5ab3IzdnBwSVMzK0Jjb29jVUJIV3Ji?=
 =?utf-8?B?a1FYd0czekVnTFFhcmw3SzRhUEs1MHRINVgwcXArRlIrOCthYnlURW91b3Br?=
 =?utf-8?B?WlhZaTdWMS8wK3dnMU42empOaTZNTWFqamVLcytUV1gvSEtFc3RrVG9vcW11?=
 =?utf-8?B?bE1QV1pzNmR6R3NMdi85eWFrV3FkMmZMaEtHSzRtN3VmS0t5clg0S0FVOTdZ?=
 =?utf-8?B?YW4wVDBzK1h6TmhLblREWG1rUE5nc3FROFJoNmxCREF1M3JiWURWSnlNZ1gw?=
 =?utf-8?B?Z0JOUm9XQ3QxUm1xWUcxUHhsSnFLYlhrWUt5cHNSTkRBMUxyYUZUVjJ1ejlY?=
 =?utf-8?B?eDBUamxOc0U3Umc3RmFCS3JjMzN5Z2Q5Ykk2QjZ3TU10VFlXOVdQTGwrSk1J?=
 =?utf-8?B?MGkrL0JpMlZKakhpRld4WHllV21QT2NvVUlzRE5JNzliVmR1WW5icVkzOFJp?=
 =?utf-8?B?aDdCLzVLZktCcEcvZHcreEQ2TnNOVFcvUkFydU9CeWdvYVFvU0tKcWhyalhw?=
 =?utf-8?B?bklSMm9pRXp0TWd4dHZvMDUvK1lFdnpqOFU1azYwWXNSYVN1bjdCWWxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFVXOG9qb3BGemQzZExLL290N0x3WkRUZk9uUzEzRXpkUyt1aHFpSHBxV1ow?=
 =?utf-8?B?dGE1Q0R5Njl1NDJ4aXY3SHhOeVJwMGNSMzJNYlpYQ084YjlJOUdPcnhzVy95?=
 =?utf-8?B?dmYxSjJQQlRRS1NxTW5WY3JNRmFxUk4yOXNCMjRWaG1VdHlPcDlKVWVTb1lU?=
 =?utf-8?B?VXB4bXRFdWl3b3dQZHNISXZnTUk5aXB5NXZIMGY4cnh3aWhvOEUwNWUyNkVa?=
 =?utf-8?B?dlhDYXNsTEliaWZTWTA4YlVFUERvWmx4Z0dMZUVUbHkxVlVKRlljWDFUeEtR?=
 =?utf-8?B?TDBNS1I3QStvcnBZUUl1SWRPSTg4RFNoSzVLUGU0TElIdE9rRlhEUmtVVnJa?=
 =?utf-8?B?Z3ljeERjc0pqS0hYNGRLY2tsem1KWituU01ENGdyaFpDZHlBLzFXVFhROFhK?=
 =?utf-8?B?eFFyUXlMaGpHSllVbXFhdWVzQWxxV0Vhc0NBTFdlQWcwNEJ2Um9lWmFOckph?=
 =?utf-8?B?S3ZoL3k5aFRKZ1h2YU9NbUNOQUxKMktIdjI1dXJXMlNLN2Vqd251dFB5Zlg0?=
 =?utf-8?B?Vk0zWCtRWTc1QWdEL1U4ZUZZbXNTUlpEa3ZHV1dVMDNVR1hwd1pOT2s3WW1v?=
 =?utf-8?B?MVBhTmxlcC9xY3RwYXlTY0FxQXQwbkdCeVl4WE1WVVp0bHJvNzArMGJrei9M?=
 =?utf-8?B?ZzhlcnVUeVBHYVNFejdQWUJaaThocnNGRWdsa0IxTy9tYUVJSXJHMlVSc3ZM?=
 =?utf-8?B?dU5PdFRzNExkRld6Y3U2NnRkd3ZBblZuV0o2Z1BDNVJIUFBkSm1MWFZWa3VX?=
 =?utf-8?B?czlPZSsvdkNncTZLaXMvMHpDZFNJaUlFZjM1Vm9RWmxjMVVmK1dqVS93Z3Q0?=
 =?utf-8?B?VmhveHdXZWxpYmdUOGwrZXRDd1pjVEJFMVBtZlh1WWZVVEN0Q2tEYkcwT1BL?=
 =?utf-8?B?WllPeG1TQ3h6c01TQ3JpTHZIVW9CL3VySGs3ZFdNeVdrNVBrYk1sV2w4WmRF?=
 =?utf-8?B?aGthRm9oeWtBTFJiVUdtN2JIV0R2elErbE1nRDZRMkJpaTZPRTlZcnIxOThi?=
 =?utf-8?B?cFJtbi9Od0NpeHh5akFZVmJiTmhkZnhkdE5rU3EvbVNSS0tHWk5tOENtN05Q?=
 =?utf-8?B?SC9YbEx4dHIrNHY5QVp6OGxBSU82Qms5OW5HRU9yRUpsYTlja0orNnAxcTF4?=
 =?utf-8?B?cU9DQ1hKRncvYmlpZk9iVTlTNnRJMGpJZ0xJRjcxK3kwS0RCa0piSEw5K2xV?=
 =?utf-8?B?emw3aE1UTTJzakx4K2VLM3MxUUJHQng0aUZsTXRRNWtPbUZXSWpDRFgvMElZ?=
 =?utf-8?B?V285czNXa2dQNTIxZTZIa2U1aTd1U2VBM1kvYVZ0OWYwRGNhYURjaFpXYkdv?=
 =?utf-8?B?OTFSbVFtbXk0NUVZUmV6bXk1clVrUUNQTjFwalNucTBtNjZUdzlTZ3NMdE94?=
 =?utf-8?B?ZVFBWkxIc1QxOHJHVXhoMlg3QW1vVFhtdmNmR3dsWEZINzZhZjI1cE5HQnZ0?=
 =?utf-8?B?Q0plTjFwNUhRK1FGYkxReG1ITDVjOEZJWkF3U1kwOS9kSmhPeTJTSW1vdWtY?=
 =?utf-8?B?cGE1RHZEUTBBRnlxQWZMYms2ajRXTjYrbjFZMko2SGdpM3BaSFR2SXdNQ3lk?=
 =?utf-8?B?VmZqYlloVFlhSG9qUFV3TCtKTGNYd0ZjWDRWMXVlaHlnU0hVNW1iaStaNnRq?=
 =?utf-8?B?TDVJMzQ3cmZBR3RvQXZDa0RwOHB5K1NFWjZRRXc4ZG1yK2FSK3BoSjhBK095?=
 =?utf-8?B?bnIwVEJicWVMU1VUU2o0VEJFYStUME92OUZVRVlac1ZLRURiMGRqV0d4NTMz?=
 =?utf-8?B?RitqL3pWMUxSdWdqQmhvRUxYdkJaR3RvQld6YU5YUXNEd0xYVXU3NkkzYm5M?=
 =?utf-8?B?ZjI3T0k0bUw1VHhJWTNIOGR6aTBDU0ljV3Jqb3VuaDZuRTNzQUtuYUFGK1NT?=
 =?utf-8?B?aUovRlFFWlQ4TWd6T2o3dDIzU2NxZ1lDRmFpNE1wd1BIVlByU3JWc0FDcHBQ?=
 =?utf-8?B?ZXlOaDUxUnpXVi9qNk82RzJVVjlwenVrb1pubTNsT25YdytHb2dkTjRHQnMy?=
 =?utf-8?B?T0lTTDg2czE5NzVmSlc5YzBjMExSaENwMFFIMGpzOVNSZHU5UzdMU3hBKzZ3?=
 =?utf-8?B?LzhqVlNMRFZJYURPeXlIeGFaWUxOVEVNbWhBWG90WFU3Skg3SHJsYy9tVzMx?=
 =?utf-8?Q?CneXw1i0JrH+GHKWDqnyyl3nL?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ba29733b-4a3d-48ca-397b-08dcde380305
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:32:13.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70HbSPZ9WTqhgUCIznRYcdKfwN95cYSyiN9aObsTgcpQHQONqH4S3Jp/0OECASoDyBo8SN7pi9M3KTpHycbe6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8227
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 9/26/2024 8:09 AM, Takashi Yano wrote:
> On Wed, 25 Sep 2024 16:11:12 -0400
> Ken Brown wrote:
>> On 9/21/2024 5:15 PM, Takashi Yano wrote:
>>> Previously, cygwin read pipe used non-blocking mode although non-
>>> cygwin app uses blocking-mode by default. Despite this requirement,
>>> if a cygwin app is executed from a non-cygwin app and the cygwin
>>> app exits, read pipe remains on non-blocking mode because of the
>>> commit fc691d0246b9. Due to this behaviour, the non-cygwin app
>>> cannot read the pipe correctly after that. Similarly, if a non-
>>> cygwin app is executed from a cygwin app and the non-cygwin app
>>> exits, the read pipe mode remains on blocking mode although cygwin
>>> read pipe should be non-blocking mode.
>>>
>>> These bugs were provoked by pipe mode toggling between cygwin and
>>> non-cygwin apps. To make management of pipe mode simpler, this
>>> patch has re-designed the pipe implementation. In this new
>>> implementation, both read and write pipe basically use only blocking
>>> mode and the behaviour corresponding to the pipe mode is simulated
>>> in raw_read() and raw_write(). Only when NtQueryInformationFile
>>> (FilePipeLocalInformation) fails for some reasons, the raw_read()/
>>> raw_write() cannot simulate non-blocking access. Therefore, the pipe
>>> mode is temporarily changed to non-blocking mode.
>>>
>>> Moreover, because the fact that NtSetInformationFile() in
>>> set_pipe_non_blocking(true) fails with STATUS_PIPE_BUSY if the pipe
>>> is not empty has been found, query handle is not necessary anymore.
>>> This allows the implementation much simpler than before.
>>>
>>> Addresses: https://github.com/git-for-windows/git/issues/5115
>>> Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
>>> Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
>>> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Ken Brown <kbrown@cornell.edu>
>>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>>> ---
>>>    winsup/cygwin/dtable.cc                 |   5 +-
>>>    winsup/cygwin/fhandler/pipe.cc          | 657 ++++++++----------------
>>>    winsup/cygwin/local_includes/fhandler.h |  44 +-
>>>    winsup/cygwin/local_includes/sigproc.h  |   1 -
>>>    winsup/cygwin/select.cc                 |  46 +-
>>>    winsup/cygwin/sigproc.cc                |  10 -
>>>    winsup/cygwin/spawn.cc                  |   4 -
>>>    7 files changed, 252 insertions(+), 515 deletions(-)
>> LGTM, but it's complicated enough that I could have missed something.
>> It will clearly need lots of testing.
>>
>> One trivial suggestion: For clarity, you should probably add the
>> initialization of pipe_mtx to the fhandler_pipe_fifo constructor,
>> although I think it's initialized to NULL by default.  Also, it wouldn't
>> hurt to add a comment in fhandler.h that pipe_mtx is only used in the
>> pipe case, i.e., it remains NULL for fifos.
> 
> Thank you for reviewing and advice.
> Do you mean testing enough before push? Or testing in the 3.6 branch
> before release?

I was thinking mainly about testing before pushing.

> Anyway, I'd like to wait corinna before push.
Good idea.

Ken

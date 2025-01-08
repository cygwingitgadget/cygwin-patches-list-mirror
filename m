Return-Path: <SRS0=+JKb=UA=cornell.edu=kbrown@sourceware.org>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071f.outbound.protection.outlook.com [IPv6:2a01:111:f403:2412::71f])
	by sourceware.org (Postfix) with ESMTPS id C0CB13858D35
	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2025 23:03:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C0CB13858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C0CB13858D35
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2412::71f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736377435; cv=pass;
	b=cGcFFVByxX7Y2jxyQmEoGpSB4UK2K2cwH7ro1u8iT97sZi77nRBI+bvO3noZX0SqJnM1mjs1BhvBpI0S/LXNofBwK2CV/AUDmSbn7qs6gk25qFo+MDtg+wzvFmDPsye4cURzyzSKZoLeIqtcV+sG9pgqnAE/3RujIKYRWi4GbJs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736377435; c=relaxed/simple;
	bh=ZK5ih1k0zLPIP6H51nZw6NbP8LL2CgNwWL5pZocTzdA=;
	h=DKIM-Signature:Message-ID:Date:To:From:Subject:MIME-Version; b=lUa2ny8owuRu1GSoEhALilsdbtV3z0H9NPVsz+s4rBZhMEnk//jSp8t3ftHP/w/lxd7Znww/zxchH5LJbjQ2C2P1VDO5u0r1k1MlmKlVgTOdr+nXPOe0l2yzF6umRB4O/1EBqPW914pNvBUT6ulQKH3Jz0wSgSe3g8PZVOLD+f4=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C0CB13858D35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=ctYIlBZb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL6fATqvOsaCtVT3+O9+XPBnMxvtV1Tj0mYKOcaHdzbOC6P8+WW+8cfdHz+2Iwt/2kKY+xHtoBchiL8K6gbhEBhIz7fVEkpmrv8+cfaqEyqwagzmPtA7rj2HXx+zlKg2v/vTnZDZv/0XuFk5h2xjqiaGgPEyRL6Z6jwDJK3KWZKxe6PQ0IbDFozTRycyOU6sAaIYRnhaRIoabOZ4Ftck0BxmVnd03AT58lH9uzjsPmKxvXxE+jd2ODWwbMVJnRz7Vxt1Q+UXYpXAjRbK9yDXZyBb8rB9XriH70uxulobfKIXhEow1mKSyQ3IKmdaxR+U5/xNVhuFoGDZmNIq6VREOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK5ih1k0zLPIP6H51nZw6NbP8LL2CgNwWL5pZocTzdA=;
 b=J7mn0qhR/tdDcc0+eJ7NhlyILibLAR+EjAJM0ci+bl0xRCjAEdIpxXOiW7Yuzl5T+5L2z/Xjn52VcxWbPiE4vA+Ju3qWEkXPj+ffMqalZCVqZTQR71OR5gFQXd6dZDW30s/33Tj55/elWdOq2vH4h6keWFY2Ic+EhcvcX5xseuORJy0y1Wy9I6p4hZuR2slvLpxpYOfFsrXl7HtJRm626EAPwkqV5icsnBoVr/EOaLiKqgpH4kqh3rcIyNjoWWH4ID0Ro2WO8bU2fgna4Xce3WnqzTLi+sBalTcT0jgwxPyucw8fBRpaHq50rdPIfY/sDXIaEYvRk298IDsHdk//vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK5ih1k0zLPIP6H51nZw6NbP8LL2CgNwWL5pZocTzdA=;
 b=ctYIlBZbDE/tirio7xFd6hrCSi1Vfoly29CnRCsM41MWccKT96omADOCLqxCHNzsm+0qGA2/V7gNkXEJLMvpiNei5sry/4q9ezuPCoLSZtRk6yN0CM9ks1QL723aoRjTYF+TvHdTy41JqE8mR51Y+cBGqQdf9d38K7IQignH40Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DS1PR04MB9654.namprd04.prod.outlook.com (2603:10b6:8:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 23:03:52 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 23:03:52 +0000
Content-Type: multipart/mixed; boundary="------------xMhmqfrBkrbw0TnhBALNr0IA"
Message-ID: <37f2bead-dd87-490b-82d1-ecb0854b50ef@cornell.edu>
Date: Wed, 8 Jan 2025 18:03:50 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 2/5] Cygwin: mmap: remove is_mmapped_region()
X-ClientProxiedBy: BN9PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:408:f9::9) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 470bb7d3-9437-4c7e-7ed8-08dd3038b7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1BhSTl3SmNsRjVwZFh6SnZxY01FS0ZkVUNVZ2o0a05ubVo2SzZaOU9EeG13?=
 =?utf-8?B?N1M5RlBQWWZ5blZWdStqbjFxTnpKalhDMWVhWVZBUGI2aU5HMjZHU0hPb3hU?=
 =?utf-8?B?YlNNYUE4TlNQNXV0WklDV0VsY2xyOVRjQStxQ0pReXU1bjZLZE1heGFIejNC?=
 =?utf-8?B?b1NUL1NaaFk4VklwQWNuVTcwSDdBOFNCZkt0OWtoQ2I2S1Z0bitNVHN3c1Jt?=
 =?utf-8?B?RHRLaUpmTDZYT0xZVlZwRU5meEwva2U5NlV4cFFkYVhpeWxWSzJST1YvcitG?=
 =?utf-8?B?Nm5XVGhNYVJUaGg4V21SSlFqamw3dGM2eTZTSXhDL2JtNHhIOXI5b1FBMTk5?=
 =?utf-8?B?bCtjOEljNDV1bVljQ1ovdmpzaC8zSmhaaXU0U2VQaUh5bjJBVis3aEgvSXY2?=
 =?utf-8?B?bEdvdzRmL1Q0bDQyUDFtd2I5bHpNZlNnWnltaW8vZkc1KzFCaWRPcW1BdDFK?=
 =?utf-8?B?N0o0Rmxxa1gyZjFQaTd1Y3AwV2NHZU1VeTBxdm1hT3VXSGNnWnFaNjNBTGZT?=
 =?utf-8?B?MlpibncraDNLbHQycTh1WVc1MEoxOFJocUtSWEZraWs5cis2TEljMEljZEQv?=
 =?utf-8?B?RjZKNnIrSEFFMWg0YU13MVdOYUM4QnBjeEtHQWFzWE1hc1BEMEJ2d1l1dTlz?=
 =?utf-8?B?RmxpNkVyWU8ya2pmd1ZHWXVGSHVFckUwV01wL3MwMXZJa1pHOUJLR01iRnI5?=
 =?utf-8?B?UTYyT043RVJkUEFScXpvZXZuSHkrN0pRcDhyRjRaaGFYQjlNZ2hHYjBSNDVi?=
 =?utf-8?B?ZWRvQUtmbWxrL1lGY1d0S3BnMlEzOTFSZTIwSUsxd1JueUZaVlk5MlFxbnlv?=
 =?utf-8?B?cmZHK28vNmVtUVloRXU0SkthUXlyeWJvVmNHQzNEaVFITVJBc3poeHRSd0Zy?=
 =?utf-8?B?RWNKdmVnbE9QNjlnQXZXTXprMnVKUC9lMlYxMW03THJMUFlBU0Y4T3h6OVh5?=
 =?utf-8?B?ZTFOV2tib0Z2OE5GYVdpTFZwNmxTcVEwa0JxOEFkdUZ5R2Y5c3BnMjZSOE5G?=
 =?utf-8?B?QWNwdlV2NGlnUDJTclRlRFJ1RjJSRllTc1picTB3cWhmVWJyN201MEJ2SHpa?=
 =?utf-8?B?Z2MyYkQ5UjlPYUkweFNoVUV4SVB2bE8yaUpwakI1NWQvM1hzUjErSWxaWjh0?=
 =?utf-8?B?ZWJOU2ZNaHMrT2R5N2IvUHYxSXF0RFBGUVVvNjRlbUZsTm10UW9ZV0ZWVGZM?=
 =?utf-8?B?ZEZxVVN6bG9PU2w1eUFaZTN3L3ZkZ2tKdERzcUxkWnM2L3BwRzhkQzY0VzNo?=
 =?utf-8?B?a0lZUWR2bzVydDBMeEU5SUpkNXJjb3J2S0E3ciszcldPelIwQzJyQ1kyOUpI?=
 =?utf-8?B?Z1ZFS1FUajRHYU5FS3hKRVcvWTJzNkRndXkvaUN3dFVyeFc5ekVPSDZQQ1Vi?=
 =?utf-8?B?UExvZW1mYmdxaldTcmppYkY3cC81c2NiaWhRS3lUT2NxY0NkSnpWbUE4SEdQ?=
 =?utf-8?B?SVUrc253TUtVcFV1S0EwT1UwZU9UL3A5SEJrRktFQ0k1SlJXZnVhL0U0NmdC?=
 =?utf-8?B?M1FBb1pEUDc0SUd1VWU3WDRQTFZmVndvSWlIY2hibEtDOUhqeE9INWl6S0t5?=
 =?utf-8?B?aVNldTF2RFRZcXRjMFNnS3NzYnBKeENMeGRxNVVJakdTQ0l3VTNXTVpNVjBK?=
 =?utf-8?B?UVcyQ1ljdWVReHg3SzZscHBscVpCYU1Ya1djcFUxcHRJNC83RitQU1A3VGx4?=
 =?utf-8?B?bjNyeEVweEpsZGJZMWl1WXdvbGdYcDFSa1psenV2TWhWM3B6VkJHRTVLT003?=
 =?utf-8?B?Ri9VRXVrVkIweW95cnZIVGdrSHJydjFEUlh1MVUxbkpqYTNpWDBQYXZjbUlP?=
 =?utf-8?B?R3lPd2FwU3ArREZmNURDV2xpVlY2aHY1Q3BhdXVTV1M4WWtud2hVT2tJakFp?=
 =?utf-8?Q?2L1Zio6IvTcgm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2tXU2Fqc0dDcEl5b2syWWdrKys4Yml0ajVheEhIZnd2QXdjcHE3U3BqTXlK?=
 =?utf-8?B?V2hJMXd4QjR5VGVKcXBKcGZhK3ZvZFg5UklvQjVFckFad0lRRENVaXEvRXVS?=
 =?utf-8?B?THJiV2ZHRjBIUlJiRjBRd0llSytJK3pRK250eVdyT1ZvSU95K3pjZ1hxb1I3?=
 =?utf-8?B?c09vckJaZHBVRElqcngyTFhkQm5WTGh2S21NREJTai9KeEs2ZmtML0ZLQkE1?=
 =?utf-8?B?VG4rM0ZlelQ0eTVib1NGWWw4UnlyQkx3N1BGeUxXTi96ZnQrMmkxbmVsUWYr?=
 =?utf-8?B?bXd3T3NDVElmUWsxam5RZStjckR4K2JMWmsxNlNuRUExSHhyU3hkS3FFc3M1?=
 =?utf-8?B?MDVnNjNqN1JkWU5OMWlyd2NQaTBIRG16UzJibDlSS2RXdytDeitzRWhDempy?=
 =?utf-8?B?b3BBb1JDQlZUblRMd2JpSXdEeHgzWmROUTg2SEJDYlJLMmxycWJmMFJTN3FW?=
 =?utf-8?B?MUFkSUlhdHEyT29hcUFULytjMXYwMzRBYjdJMnRUTzl2TmRqUk5HZ2htYXdN?=
 =?utf-8?B?ZXdXVXVzNHhZaGFVbm9NOENkU0J0eEl5dFRzYkpMRlMybkx2WmFvSUp0eXRz?=
 =?utf-8?B?SFUzU2Y2TmF0alY5dnVKNkFtK09Rc3JYZ0hDZUdWanVGUXpQM3h0di9PaFlk?=
 =?utf-8?B?bGxyNGFJcVhzaFpDTXc0S1Ric0FzVS9HcE1uUDRPMlppWUNpN3F4N1VBSWFP?=
 =?utf-8?B?Yk1GeTVzRnZSTldvOHgyVHU0Q24xOE1ZclZyZURhb1FXTzE5RDVmcTlxYUFl?=
 =?utf-8?B?eHdkUVdyKzlGL2srWWVaVTFCdWFxbUl5SUFYZ1MwMnJ6eEh4NXdTbVlISDIr?=
 =?utf-8?B?VGxYYU9CVzZqTVpudGtQZ3UrYzN4MHdSSUlLaExRQ0lDWGpUOGtqMFFsUXpm?=
 =?utf-8?B?MUpxdnhGb2tyWGc1VFVYWEFjNzlOVWFZbVRPbjFXZGQxTVNGM29UakFwTytu?=
 =?utf-8?B?M21ybmxTMXdrTkVWZDhFRHpXMFI3TGdSbmNlempqaU04aHFTb2o3TU9iM2ZO?=
 =?utf-8?B?aGs0R0g3dmVyaUZnSXd2S09mWGs5NnpqdmRtdDFkOHhMMWtEdHBzRlRqekt6?=
 =?utf-8?B?RTIwenZYb3dmaXBEU25jNlh2a1EzUEZiOHZHTGc0YUlrcEdna05FaVpCaGF1?=
 =?utf-8?B?TGxMMHJZVHAyd0JVbEFWTldoWXZzZW9INTd5MWpjc1liUzM0NC9BUklOUEp6?=
 =?utf-8?B?RXFCZ1NXbFh2THdZZ0M4YjlCS2Z3UTRVWnRsV08wWWZlQ2o2U3BvZHJPdVpl?=
 =?utf-8?B?K2hseTU4SHdGbnByNXlLTFVKTHRGaEFMU3pDUWZGSWFqQUpnbmRuTURyT1d3?=
 =?utf-8?B?ZE9mZ3haMFlBbGY0bldNa1J2bjJmaTJ6aG9WOXBiVHVTSENLeHkvSjlXTjc4?=
 =?utf-8?B?OENhTTRTcm9uSjkxS1o5V1F5emduMUpjanRBZVk5OE1FNHlybFBHQXJlNUZH?=
 =?utf-8?B?azR2ckRCV1dEdWlCaVFKR3BSbFNMN0RES2xpN3R1Q2JtZW1NcnZmY3RsS1FJ?=
 =?utf-8?B?MzA0dk9XcURtUEcvNkpVNjdaaGxqZ2h4K0JrczY2MFhuM1oveWlQSzdrTW1S?=
 =?utf-8?B?cUdqcHhQY3RCT09tR2VCMHRoUFJlNVRFTXgyeWk0bFB5clpNNWxvQlgrNHd5?=
 =?utf-8?B?QjNTR3FDdWxHbGZ3dzhSUkFhVDJTTjNDNVNra3hCQ1hxS3p6UnFYcVhDYVpP?=
 =?utf-8?B?aVlnK2pORFl1eDlYL1NoSG9tdFNQVEFuVTZKcFF4TXJ2eFRaaDUvc3lma0RH?=
 =?utf-8?B?MHNtOG95c1o3ajNzSk1oQmovYzgzbVZXUktqK3ZSaUVQVjZlY2RKVGFzeFA1?=
 =?utf-8?B?L2RGVDBNWjVlV0pLZXh4eHVqd01sOTRnbkZSc29HTkNKRTAyeVlaM0pEYmhj?=
 =?utf-8?B?akF1ci82SGVoeU95RTZRbzJ0TnZFSjFVSk5NOGFyaXdSOHhlaGFDU1lNNFNC?=
 =?utf-8?B?YzNjQUMxS2VLUHBWYWNSK29wNFpMRlpDa3BHTkd2cjV1ZkFxMXo2cmVmajJB?=
 =?utf-8?B?N1hmVElhNlVsYmZDOWtqUHB5WVprakpPbmZIejlSNEdDVkxjWFRVOVNKRUlI?=
 =?utf-8?B?eGxla3VTRjRzOUR1bGlEU0g2VGs5MkR1amdCamNyZXVKaEsxZnBZdVArb0hY?=
 =?utf-8?Q?hlqakeMD82sWLRIR5A0oSrZBt?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 470bb7d3-9437-4c7e-7ed8-08dd3038b7e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 23:03:51.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxVAEeE25j4FOy70H3H/YlIqSyZ82n0kFI3V5HgE4yVs/cEu1haUzZoVIQLk+E2V0LfjB6cW/liUz5MPx/hl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9654
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------xMhmqfrBkrbw0TnhBALNr0IA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
--------------xMhmqfrBkrbw0TnhBALNr0IA
Content-Type: text/plain; charset=UTF-8;
 name="0002-Cygwin-mmap-remove-is_mmapped_region.patch"
Content-Disposition: attachment;
 filename="0002-Cygwin-mmap-remove-is_mmapped_region.patch"
Content-Transfer-Encoding: base64

RnJvbSBkM2M2MmQ0OGY4NzA0NGQ3NjA3ZDgxNTU5YzU4YWUwNmRmNTgzOWFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
RnJpLCAyMCBEZWMgMjAyNCAxMjoxNzozNCAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggMi81XSBDeWd3
aW46IG1tYXA6IHJlbW92ZSBpc19tbWFwcGVkX3JlZ2lvbigpCgpUaGUgbGFzdCB1c2Ugd2FzIHJl
bW92ZWQgaW4gY29tbWl0IDI5YTEyNjMyMjc4MyAoIlNpbXBsaWZ5IHN0YWNrCmFsbG9jYXRpb24g
Y29kZSBpbiBjaGlsZCBhZnRlciBmb3JrIikuCgpTaWduZWQtb2ZmLWJ5OiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KLS0tCiB3aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL3dpbnN1
cC5oIHwgIDEgLQogd2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjICAgICAgICAgICAgICB8IDM0IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAzNSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL3dpbnN1cC5oIGIv
d2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy93aW5zdXAuaAppbmRleCAzODMxMzk2MmQ5NmMu
LjY4NDFkNGE1OWZiNCAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy93
aW5zdXAuaAorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL3dpbnN1cC5oCkBAIC0y
MzksNyArMjM5LDYgQEAgZW51bSBtbWFwX3JlZ2lvbl9zdGF0dXMKICAgICBNTUFQX05PUkVTRVJW
RV9DT01NSVRFRAogICB9OwogbW1hcF9yZWdpb25fc3RhdHVzIG1tYXBfaXNfYXR0YWNoZWRfb3Jf
bm9yZXNlcnZlICh2b2lkICphZGRyLCBzaXplX3QgbGVuKTsKLWJvb2wgaXNfbW1hcHBlZF9yZWdp
b24gKGNhZGRyX3Qgc3RhcnRfYWRkciwgY2FkZHJfdCBlbmRfYWRkcmVzcyk7CiAKIGV4dGVybiBp
bmxpbmUgYm9vbCBmbHVzaF9maWxlX2J1ZmZlcnMgKEhBTkRMRSBoKQogewpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjIGIvd2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjCmluZGV4
IGFjYWI4NWQxOWNmMC4uMTNlNjRjMjMyNTZjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL21t
L21tYXAuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjCkBAIC03MjIsNDAgKzcyMiw2
IEBAIG1tYXBfYXJlYXM6OmRlbF9saXN0IChtbWFwX2xpc3QgKm1sKQogICBjZnJlZSAobWwpOwog
fQogCi0vKiBUaGlzIGZ1bmN0aW9uIGFsbG93cyBhbiBleHRlcm5hbCBmdW5jdGlvbiB0byB0ZXN0
IGlmIGEgZ2l2ZW4gbWVtb3J5Ci0gICByZWdpb24gaXMgcGFydCBvZiBhbiBtbWFwcGVkIG1lbW9y
eSByZWdpb24uICovCi1ib29sCi1pc19tbWFwcGVkX3JlZ2lvbiAoY2FkZHJfdCBzdGFydF9hZGRy
LCBjYWRkcl90IGVuZF9hZGRyZXNzKQotewotICBzaXplX3QgbGVuID0gZW5kX2FkZHJlc3MgLSBz
dGFydF9hZGRyOwotCi0gIExJU1RfUkVBRF9MT0NLICgpOwotICBtbWFwX2xpc3QgKm1hcF9saXN0
ID0gbW1hcHBlZF9hcmVhcy5nZXRfbGlzdF9ieV9mZCAoLTEsIE5VTEwpOwotCi0gIGlmICghbWFw
X2xpc3QpCi0gICAgewotICAgICAgTElTVF9SRUFEX1VOTE9DSyAoKTsKLSAgICAgIHJldHVybiBm
YWxzZTsKLSAgICB9Ci0KLSAgbW1hcF9yZWNvcmQgKnJlYzsKLSAgY2FkZHJfdCB1X2FkZHI7Ci0g
IFNJWkVfVCB1X2xlbjsKLSAgYm9vbCBjb250YWluczsKLSAgYm9vbCByZXQgPSBmYWxzZTsKLQot
ICBMSVNUX0ZPUkVBQ0ggKHJlYywgJm1hcF9saXN0LT5yZWNzLCBtcl9uZXh0KQotICAgIHsKLSAg
ICAgIGlmIChyZWMtPm1hdGNoIChzdGFydF9hZGRyLCBsZW4sIHVfYWRkciwgdV9sZW4sIGNvbnRh
aW5zKSkKLQl7Ci0JICByZXQgPSB0cnVlOwotCSAgYnJlYWs7Ci0JfQotICAgIH0KLSAgTElTVF9S
RUFEX1VOTE9DSyAoKTsKLSAgcmV0dXJuIHJldDsKLX0KLQogLyogVGhpcyBmdW5jdGlvbiBpcyBj
YWxsZWQgZnJvbSBleGNlcHRpb25faGFuZGxlciB3aGVuIGEgc2VnbWVudGF0aW9uCiAgICB2aW9s
YXRpb24gaGFzIG9jY3VycmVkLiAgSXQgc2hvdWxkIGFsc28gYmUgY2FsbGVkIGZyb20gYWxsIEN5
Z3dpbgogICAgZnVuY3Rpb25zIHRoYXQgd2FudCB0byBzdXBwb3J0IHBhc3Npbmcgbm9yZXNlcnZl
IChhbm9ueW1vdXMpIG1tYXAKLS0gCjIuNDUuMQoK

--------------xMhmqfrBkrbw0TnhBALNr0IA--

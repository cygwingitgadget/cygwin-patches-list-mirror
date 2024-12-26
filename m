Return-Path: <SRS0=jJuW=TT=cornell.edu=kbrown@sourceware.org>
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	by sourceware.org (Postfix) with ESMTPS id 1F41D3858D20
	for <cygwin-patches@cygwin.com>; Thu, 26 Dec 2024 18:22:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1F41D3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1F41D3858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c000::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1735237360; cv=pass;
	b=cRkWULyqpzRK7eKWSMDNjZKWzECifNF1mBEvCZ16EGAnjvWw23Il9SBvaCn9/3I71dHkaSarbKg9pAOkSVQuaz+glufM8AdRB4m5G5s319ikkYHeQgML1JkmlHC7C8lBp1jQZGfGo/oQ9CPzIREFjGLFPKb4RLMCgfHuu5O/4M4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1735237360; c=relaxed/simple;
	bh=S2HE5ALxIGgcvKSUGGILdlXejsOSlzx2A4LL1CgOXZk=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=B7w1dx/85wCMddWuXpbR0wFIPq1vpwElIBK3wZoGWDrN5jRcYInOkFffrdQpknn9ZsDTU6vTDMM5MyixPiYOW0X38kTVD9iN/YNcb+2Tmwa5KA2KVxfYSbvScrnGxwYcd5Hadd5091klouUMY1DA2hrRbNNX+l7lFqHd7H0Nqoc=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1F41D3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=jJ7lK2yb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruoDrR7t6S4fRW69gNaXKBQ3YLYWlc0ZTRxjQyNRs2VQuSzPE7UxhpeKxS/GKlTIneWoXOFnSqZ4pAwlJTV1AA6XhoZRljcNAliYFNY1Gal9uvM73pvY+Rr03QDUk+ZTRk7BomR0s4KWi32Acsz8VGhXYlUNhT8UhvLmTf82BJ2JC8a7b3BsereZ7ny9vKzmB1gxvyBg9NyK8f82RhAICpAq2xhrD78F0qxIscUOPVpk05G5iMBz7XxeSkIFJvtlTtm9H65QUTt4nJ7YTnUbYWMtOcJIHdFuG8Q8JME4Oz6IiSh0RIEIfAoJtFiC+VbYBBMnmGeeZYIPlcp5A1qPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzg84rfmdIPp5qeTUBqWld7i+VpO0KbRAp6Qi1lPsK0=;
 b=vk6/XQi3RmgNcYn8sMdscdDLfmQLBxTzP9uBg27QC2mP8IOOD6AW7KqZ3efQVabiSmwSdXD99N0ZDqGtS/jaJD7pH05UA7V6pj6UkcTqpTfjJOefQdOCY12XYP/aD/WH/hE1ZGmzne5FQ3WJlBTHhoWbm9MGiBFzTwIFysShLYjXRxmD6wlqs/QRP4Wpo7/E08B46GE4ulQ9X9bjoaIfSU9PjFyNghXLgWPbdViOGkGHgYKaJfWpD22Ni60hkbjD1BtT3cQXJ7IYyu4Y/FXCGCQ0xlOQ8lHKTmleK0Of0Ivyvbtb4AUziwB4IJphbFApiyW7KFe3Rc36dI3XTGYWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hzg84rfmdIPp5qeTUBqWld7i+VpO0KbRAp6Qi1lPsK0=;
 b=jJ7lK2ybxJWparuEXt7e9J7v4H3j7my9+bZKSSaxFQg/0sApS0HVnNiyh6vhwUEgT2CTmO5UmqqIyLXZbKzajeMBD6sKh+uXKUP6pXzxOQyUKDeaBQI57ipGM+NsSXJZ1jquaZEB9i9fW/SxdEbQZlNq7junG0smeiEsUkqzUYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by CH0PR04MB8036.namprd04.prod.outlook.com (2603:10b6:610:f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Thu, 26 Dec
 2024 18:22:32 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8272.013; Thu, 26 Dec 2024
 18:22:32 +0000
Message-ID: <df03a35e-cc26-4bbe-a375-dee560caf524@cornell.edu>
Date: Thu, 26 Dec 2024 13:22:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Fix mmap_is_attached_or_noreserve
To: cygwin-patches@cygwin.com
References: <72f53e43-5475-446d-abee-9ab3de71c25c@cornell.edu>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <72f53e43-5475-446d-abee-9ab3de71c25c@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0002.namprd15.prod.outlook.com
 (2603:10b6:207:17::15) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|CH0PR04MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b248f6-c2ae-4d4d-e812-08dd25da439d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUo5cGFiZGNSeFhOUUxyaHdSdndYYkUyYmNJODNWOTc3SUgwK1VvbkpTYUNx?=
 =?utf-8?B?eml3ajJxYzB2L0E3M3M0SXFscTFpK05GK0VzdG5TQ0ZNNUxrUnpJZnBnZklX?=
 =?utf-8?B?cVRWZlFWTjFFdWR2aS9BcElxS015cjFHVUpCYmRDSnNYVFVkeVhZaHBPOE9l?=
 =?utf-8?B?SDlqeng2cmEzdmRCbkFNU3p1N2RxcXIxSmFDTDZMdjgrSzRTMVZwdE1ZU1M0?=
 =?utf-8?B?alZ4R1Nxc3NpalV3ckVJV3ZZQThKcUVEN3dpaWt2LytmanNTYVRsaTNiN2or?=
 =?utf-8?B?TTZZVVlFbkJYQU1WTG01dDNrVlVydE03T3c0Rkw1VG14UE14NzRYcyttSDZH?=
 =?utf-8?B?QUdmNkF5azFCclZ0OFA1WWw0MXp2ZGFUcEZUOHMxSzY0S2VpWEFEVERDZkx0?=
 =?utf-8?B?Ymd2bEI5cEVzcDJKM2wyaWRsaXhDSUh0Y1RTQ1RocFk0amhrTUdLa24rZ2RF?=
 =?utf-8?B?ZVZDeXdZMGJFNVNnWHRSVEhMQnkvZWZDMS9aVkFwdjlMYlliQnl5VjJPYU5R?=
 =?utf-8?B?M0xjMExJcEJiZWFXQmd5bkdVeW9PZ1FzVjRGVDF0UXo3SzBtNkN1UnBPNi9F?=
 =?utf-8?B?aGVWRGlpdzlmWFhCd3hsOVJFdHl2L2pncWMzc1ZwQVdiVnJ6M21Jenp3U3Fa?=
 =?utf-8?B?UjdXdDE5VldiUE9aSHBkNlp1NVY5akJ4U1l5VmlGUW5nZjJHTEQzY3RpU2tV?=
 =?utf-8?B?MkphWndvZCsrSWV2MWZQVEpFMHIxYmxacXp4T2pDbDNvZ0tkNTYyNWRoMVpO?=
 =?utf-8?B?T1NlTG5BcFZXbU9kYTkvckEzTWhqZ2J2UmVsNENrcXAxMWhJTS9OaGNaZVov?=
 =?utf-8?B?d1pxZnhoNEVKdGxCYSsrL1BwalZ5Vitqdlhma1VXTkVKMXdOeFloUUJZVDUx?=
 =?utf-8?B?MklEQ00xUGd4RUxKbkl6QXJmcmNpMWZWOUtjSFdlaVhBVjlRL0RjemZSNmxp?=
 =?utf-8?B?WnBlaU8rK3UxTmpEMEd0QjI1SGp5QVpyMnBPNXl6bHNyRGxMaFFrK3dLSlJi?=
 =?utf-8?B?dkQvby9GYkUwSWlrM2JNNUkxV2tNWjNxTU9NTjVKekJGSjhuN2I3QWppUENT?=
 =?utf-8?B?clBmMmlvWDJRSlNKd2wzOGVmRnlnTTdYMjdpTXh4YTNqTTZ2cDg4Q2hVekJh?=
 =?utf-8?B?d1RPM3hYRjBNczZYVHkycmRBR054eFloaWJmRmxpUGFWalNTRWV4amJXSjJX?=
 =?utf-8?B?WlcvOXZ6d1kyVEFxYlJaNjVjZytSWXorcGtGVjBHd3prbVVZb0x0Zm5NV045?=
 =?utf-8?B?MFE5NTczbDVWcEwzTkc3d1JtRVo2SE9VMWN3czVTZEJTYlpvR1M5dUdCQXhs?=
 =?utf-8?B?bnpPeTBEaFpuTGRIekVBL1prb2h2bWtZNHhrSTl0YitZbVZlcEs5dytPUTVV?=
 =?utf-8?B?c2JZWWl3Y2p3dnE4ZG96Y2FZa0JVbUVoU0V0cnQyL2pKUmRILzdBaEhZcVFE?=
 =?utf-8?B?TTVkb1dDdFk5M0c3YWlDdTY0VFVVSlM3RVZWVEtRY0t5a0M3QmxrRE9DSHY1?=
 =?utf-8?B?QVRobzRQckRKam5NWk1lbjdSS2lKRjZPaEFVcGxBZzRycGFoZ0UwMktMaGlD?=
 =?utf-8?B?UnhIby9pcEJxNVU1U3p5MTEyWkg0djlNOUZSUFlOelBoNmRyZWZFN3lEWHFW?=
 =?utf-8?B?dk1RdHBTT1lnL3QzNUFWYmdnZmcrVG1xZkFmZjRRMmpqZmZiWjFxRElucFBT?=
 =?utf-8?B?TENWV1JxeE01TSt3K1VWRkQ5VVBEMFdnZkRYaGt5YzF4ZUhFSGYxWG5pNW9S?=
 =?utf-8?B?ZkFlTWhmYlpqUUNQVnQwc0JhR3FBdjl3YmovUjYwTlJuUDZqdWs1SWc5T3NM?=
 =?utf-8?B?UEFacVpNVDl5ZisyUjhqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk1mcUFKTUlCa2tvdGVaVDVSOTN5RThvbnBEdGRUZUs1LzFYL09YeUV1Y0Zm?=
 =?utf-8?B?T200ZUg2SXBHWXI4K2M2MlZiTldOK2RoWDlkNkJybkg4VGpoTzZXWlcyNzdO?=
 =?utf-8?B?N1ZSTXhwZU9lZG12Z2F1a2YyU09JUjBGaW5LQXZmdVpnVm1NUXhLR3RmQ0gz?=
 =?utf-8?B?SmxMMW9TdjhMQ1EyUkpOQzZrcGJTZFNsd2QycGJVTUZuVjVsdlRUK1lYMlNW?=
 =?utf-8?B?OXU0SFhMSWtsNWVIRStLWXNsb0Z2d0hxWHdwV3VNYUM5V1B6akp4akJkVzgz?=
 =?utf-8?B?Vlgrcy8zTFg0aWExcVoyanhxN0prRjU4c05ucG1mWkd4RlI1bzhNVmhvcDVj?=
 =?utf-8?B?T3RYK1NJamNjS2M1Y3kwZ1pqWmg4b215aGNSMml6bGdIbDlsTXZFQm9jZndW?=
 =?utf-8?B?RXY5Q2QwRFZvR0l6Tlp2V2NJeXl6MDk5Q2dUdEl6M0lMd3lXZ3VvR0J4YmhL?=
 =?utf-8?B?Q2dPVk9IVCt1UzAzblErMlVXSnBoNzYwSHNDWEllbVJrNnB0bEVZbk1HT3dY?=
 =?utf-8?B?YVZndzB4TEpSR1ljYmVDQXFWeW5IbEZzaVBCRy9BbEhBUWtPSHI1YkdRVUJu?=
 =?utf-8?B?Vnp2a1NMbXRXVGlsYVJWNEttbVN3dFBxTHhjSlJ6SHpKZDVRNTIyRWwyQmJz?=
 =?utf-8?B?Nms2MFZRQk12RExoNkNIbU1VT0dmYVdMRUtXZCtUUjFBVEJ4Mlg2MUY3OWEz?=
 =?utf-8?B?OFJEdTlpa3VISEQ4RTJtdlVmY3NEQTlSZGJ2aXY2cG1QWk5RK24yVFFzczdK?=
 =?utf-8?B?UnIweVorbzRDblJJaGIrc0I3bWRTVTN4N0M1NXN2NVlJVjdmMTRyTXZHV3ov?=
 =?utf-8?B?MVRmTmE5VHp6eTRBSVIzVDJFZUk0bmc1QzlyT3lkSlpYQ1BET1EwT1pld2xJ?=
 =?utf-8?B?V3l3R000dkoxeW5qS1lVQkZWd1MvdzFmb2wwd2tuTVJVaHZJL2pLWWFjaTBk?=
 =?utf-8?B?NjZpTjV4elR2a0t4RUMxdjVqVmpESEpoalhnenlISXNmWnhmN3NDUzV3R3Jy?=
 =?utf-8?B?NkdVYVR5YmV1dS9BK0liRkhkOGNqektsVS9aSnEwbVJUcVFTZDF2OU14elVY?=
 =?utf-8?B?MU1nZ3ZVbXNWTlFBWVB6QXdtQTlEODdaRVczTEZqMXNDbWNSRElVR2s4UndC?=
 =?utf-8?B?NGhFVkZmSkY3SDZLUGNYeTk2SkxJTG9TV2xBcWJhRW9oQVBMOGt2R0creTA3?=
 =?utf-8?B?SE5QOUNka3FQMkxOWDF0Rk03MUhaQnZIWlJjM1g1aFFIU0tXY0JyYWs3WW1l?=
 =?utf-8?B?ZEhaSldPTEFOMlhpRllXL2ZmRFNBemxsdXBlVTFiWWpPcEF2ZkcxTWFnTlZY?=
 =?utf-8?B?dS9WLyt2ZGxUeEdkWmlEWEJzcnJoUXlWSzJSOGZubDJKQVkyc3N0TWVlakJs?=
 =?utf-8?B?a3hDUDVtZS9uY1JMeGtmMjdlOERmRVZxV1ZOTDZkZG1JYnZHRXRkNDZSQXRs?=
 =?utf-8?B?aXhZR0hkM3hScE5DTUZWSjBwdjAvRHVQVWtXSFJveHBzQWZSalhubHBvZFJ3?=
 =?utf-8?B?QWowcExuNld3QTZXWXFhcHV2akQ4RW1SZFdmZ3VWTjlsS2tHRUNhZ053OXRt?=
 =?utf-8?B?anRYNzFCSmpXaS9UOHFJR0NJWDNxY1ZmWEduUjNQZCtudWs2citDdnhFN2pj?=
 =?utf-8?B?QXBMVTdmTXlBL21uaEVZNFJ0R1U2ZXdoNUlQcVFyRnQwRVZOdzlwODVPdkFY?=
 =?utf-8?B?MStTNmVnT25RWFhSTVlOWlhaQ25XVHlXMWdNMEtyMlNNb2UxVUxKbUE3RXVt?=
 =?utf-8?B?WW9CRWpmcUQ2eGVRRmkreDJrTXB1RFVsc2lCMFVOeXRQV2NSTVJXdFJaRmkz?=
 =?utf-8?B?Zmtlckc0akpQVWtkMDdWa2czWFVNK2VRZGZpMm11enZ4RlJUR0lpK25pQ0tJ?=
 =?utf-8?B?b0VhNGg4SVJuc09mbDNLakpRRHlESXdGQzZEMXd0QWlpbFhTbzlIVllpTHUv?=
 =?utf-8?B?d1BTSVJGdHR1NnpiajVWQzV4NnMwWG5XMEFidDBDc3dNOURCTnRoYnA1OEh5?=
 =?utf-8?B?VXZyV3JSZE9lc0loUXhYMGFLaCsrMkZ6K2MwVE9mbHRQQWl1OXFGMzRkM0c4?=
 =?utf-8?B?dGVSV2U0QjM4SHg2dG1uYjR4ZWJ2aXpvYmZIWnV5dlU2b2hhTERJMGgyMjU5?=
 =?utf-8?Q?iCM01ZqFRdO1t18FA2M4dpNix?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b248f6-c2ae-4d4d-e812-08dd25da439d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 18:22:32.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDdapA7lt/o8Gv0xNblv/JjIafW+rVqMBbbfRU4WGBnYyyDcJUtGzwdi6dJTRTA07vpJKSSQ5SN43BME7s8wvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8036
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/26/2024 11:56 AM, Ken Brown wrote:
> The attached patch attempts to fix the problem reported here:
> 
>    https://cygwin.com/pipermail/cygwin-developers/2024-December/012725.html
> 
> The patch is not ready for prime time because I have been unable to test 
> it.  When I install the patch, mintty hangs on startup without showing 
> the bash prompt, and a grep process is left running.  I can kill the 
> grep process through the Windows Task Manager and then get a bash 
> prompt, but every command I try to run hangs and has to be killed 
> through the Task Manager.  In particular, I can't run the test cases 
> that I sent in the above report.
> 
> So either there's something wrong with the patch or else it triggers a 
> bug somewhere else.  I don't know how to debug this.
> 
> Takashi, do you think this could be related to the signal issues that 
> you've been working on?  The patch potentially eliminates some SIGBUS 
> signals that were raised incorrectly before, and it also potentially 
> causes some (correct) SIGBUS signals that were not raised before.
I tried applying my patch on top of cygwin 3.5.4, and the behavior is 
the same.  So it doesn't seem to be related to the recent signal issues.

Ken

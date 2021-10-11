Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2095.outbound.protection.outlook.com [40.107.94.95])
 by sourceware.org (Postfix) with ESMTPS id 565AB3858D28
 for <cygwin-patches@cygwin.com>; Mon, 11 Oct 2021 12:11:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 565AB3858D28
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk5qaSc3N3lztYmPLp5gQEqjWyQp8GpN41+dTHR1G1cl6XXDyxB0LIBPOa35bigxXpoWkQoO2mu/F8wdixBdBazmPEfS4rB088U1y89OfPQLVzgErxv3kNaRQv+JnWp6y4oacIaPx5O7NbRqgLN+MB2dp8SyMe6at/Tf+k2qf4QgyJh12oVMcbLvZrqXXCOevosBgZxAzpm+i/D2EUGjtBRNR5okoADqN7CIeJ2VIJNj6b3uuJWzq0B8deCGzw/Yq1DhNT9JvXd4IFOnPFO9jBCrtWw0af3N+KmMWk4XHpBIJGqOy0BTnYwiW0mh0NbjTbOgwfJoxunaj0mI2wx2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yyMjxEUAwmGF5jza5UnmXKwS2cJPw6DOSPGY6Z89nU=;
 b=A35LpSiO1DY/3fVsdGRlmvi070LorolIXWjbn2K2ewOl2/H/Qx10cuYmcspeft+y9PvBz3pLSIiXUXxwfzgyaXxu+9sVXsZv6pVFIZjyH2uX6uNZqIIq92SvZBHbpx4JpPEVnL3pcfO+/mygHiRDT1CsUXI0cut9t/rsPVum/7i5pOomEKj+xJgRLiOXTdO9Z+Jq57eGYI4YVI5JP/0bRXqRtjX0FPRw0paFRDzd6WRyuvfVh52w5uamjIc8vJeXSCCqgu1ZlNJdY7f0UGw1ZE9U07dMCXqbu13BxsUCH57vFMrMXllu1rZG2znztkB81XlnsmRUBCqKvYljngkCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yyMjxEUAwmGF5jza5UnmXKwS2cJPw6DOSPGY6Z89nU=;
 b=b6nthAPoQ4cHbLrmkNgiilJVAOu7tsvVWPgf4yIz4mXMNCb8I3xk/P+ScSZQCfJbpqrmMVRid71Tkz2XTIVHon3fejVt5t8tB4sc8/liEcLuN6c73ahTErXv+j1jbV2ekwzxkU5yVPFZ7KxJvOiyLNhRTGbJ2dGsDpbosExv3lI=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB4051.namprd04.prod.outlook.com (2603:10b6:406:cd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 12:11:27 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d1a8:b6b3:dfd1:b093]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::d1a8:b6b3:dfd1:b093%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 12:11:26 +0000
Message-ID: <ee8b46bd-f8f4-85da-be25-233c3cb60c71@cornell.edu>
Date: Mon, 11 Oct 2021 08:11:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
 <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
 <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
 <037a8027-8969-df1e-ccb5-6a736578cec5@cornell.edu>
 <6de24f8c-bd21-cd4f-18ff-ece3fef85b89@maxrnd.com>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <6de24f8c-bd21-cd4f-18ff-ece3fef85b89@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:208:32d::25) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
Received: from [192.168.1.211] (74.69.128.111) by
 BLAPR03CA0050.namprd03.prod.outlook.com (2603:10b6:208:32d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Mon, 11 Oct 2021 12:11:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91b895fa-8823-4952-b011-08d98cb03ffb
X-MS-TrafficTypeDiagnostic: BN7PR04MB4051:
X-Microsoft-Antispam-PRVS: <BN7PR04MB40511A444A09D1DB3F0F85D4D8B59@BN7PR04MB4051.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9kcgqPAJHGzKUPsPe6IAfFK+uU3P8hZ/AM3nKB0CpHKcMgJ28mhlQwv3ozMniTjJvGH0AoYVyKH2htBQw2ZCwUTzu2MS+WxmPxcjw0gLMu0FKkPCRlwN9ZAEVKg/a8cyDLK8JZ7MiOO4qeHrhJ1+hNrdAj9+2GAilWn/UB1cLcU/Wn4bWt8N9svOlVSugjs8kuiB52/Zl+pMEAiSEnG7yQwPkBaVdoYwAu5tUcyjHX2uNqX+j9GXwjQ5eXfWAV3aAyEydZvoEqtBuGlCiVXXI22JnyhXQefpTsibzEuxY+Me5IzHyFpPyQHoY2VzwNv2wdpgLB5LUNaiehAoaXAz2aV1V+hVDBLlNEpyjBD23w4sGYu21vlCA7JKohqQh8BveHxV6k+BCXNOCyFRf5bwpUsz9lAexIQ0S2Jk4KD1fF7USzkI9GtkA76Zc81+J+DVOW4xkDMm5cpyA0J2wEYACbHthrlyEq7aAEcNxxpJ9InB4N1sJeRrLrBANHO2RiUA2nmW1twEZpY+FAtPb1JfyNxPhQz7kSaJ8XS/sXWNTvqY68isNfOcqMLjVcR+2GPk5OyBryfHAYRAcc48hG+SvROiwrboLyVDzyqAq60y9tOizN9NWWuMEjVt69RHeYYckLJ2CEMPe9k1McnYVDJHbYNuOOp010v+NDzAB1RImtylVPk3R/hcVMv7smy2xbp1wSWradsouAsnvre3Dxz0W8WcS88AH/AMBQtPxFS8nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(6916009)(53546011)(31686004)(186003)(26005)(66556008)(38100700002)(83380400001)(4744005)(75432002)(956004)(6486002)(8676002)(16576012)(86362001)(786003)(316002)(36756003)(66476007)(5660300002)(2616005)(508600001)(31696002)(66946007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QitiWGZsaGQ1NlNxNEwzMURRY0lDTi92V0toaEtEU3B2TnF1bHdsY0VpaHdo?=
 =?utf-8?B?RWhHdVZSTzRuZ0xGODdxWXIwSlQvWC9vNnRZY20xYmtuVlRJbkpiSTJMRkRR?=
 =?utf-8?B?MWpYSUVidDAxaXZlUisxTm5Iak9iUkdNakhjOGhXblVFT0VialBRKzlJYVZD?=
 =?utf-8?B?SGJSRnExaTFyaXUybjNOZUN0Zm5nTEZqZnNBUDA1Y0gzZnVkbSsvTXBGWUYr?=
 =?utf-8?B?bnNsZXlhOUR2dlZzT2NFbkpJaFJJOTlkM05JWEtyN2F4UVlxYmlGWExBL3Uv?=
 =?utf-8?B?bWl0YXNMc3NlaFFBb24zdkRqVHJWbUdEU0prbDV6ZXMrYVBKUWd5cGRDbHNL?=
 =?utf-8?B?amY2V2hrTUlOWC9HL25kR3RtSjg5UFE3dGNiUWVjeGNzajZkNGRJU2lhOURm?=
 =?utf-8?B?MUhFL2JJTjZ5M2tJQ0NUUm9HQlRKOWtoZ3ZuRzZpT09FWkpDaHYyRkVPalNh?=
 =?utf-8?B?K0FCTUYxVWp1ZDhmZEIxcWRpaXFBcWhRRWNMazl0VWl2djREY2RJMWYyYjk1?=
 =?utf-8?B?K25XalBDcW5YU3E1L0wweXdKeXp1S1lsaHRWNndta3ZXbHlnMmszeDl0SDRa?=
 =?utf-8?B?N0w0b296bklUaGhNMnFxeHF3UkE4M0VWVVVoOXpzdlhNbWJvZ0R3bC9sY0U1?=
 =?utf-8?B?VWE5TDJXOVZkb2cxVjJuRm41NlNsMzVRRTBVRXNSdXhicUxqSjZjeTV0YXRp?=
 =?utf-8?B?S2NNK0JoNzhHTzJiay9HWkdmcmlLa1FOa2w3eGFjM0VWZURwY3F2bEdrWFk3?=
 =?utf-8?B?bVpyaGJsWUswRG1CWnNtRHhta05QdnhoZnZ6MlF3RkFpUGV6djc2K1JxQ2xy?=
 =?utf-8?B?MlVMQXJNQjdXVnkwOWFIdE5PWTFZOEduRHM3V1JBWXpjMzlEWW5GWkZpUUJS?=
 =?utf-8?B?SzZWQkR2M2xMK3JSNHlaQndJU0IxcDYzaElDNXFpQVFyYWU3a2pqUGpldlov?=
 =?utf-8?B?cjFnazJKcFhKSW1XZzJyY0d3OElsZlJuOTc2OENvbUZ0d0c2ektYZzR5Qm52?=
 =?utf-8?B?K1NwTzdZZ0tzRlVwMThObDdRakhGMzl6V2RkNU1JakRCOGxqMTdBUk9VU0Nu?=
 =?utf-8?B?TThXRFU0UUFjbGRhV0xwck1BUytGL0tDSmVicEZqK0o3ZUtsSkwvN0ZiaUFn?=
 =?utf-8?B?cUhhVGlzS1ErV1VuaUV5emY2ZWVJOXh4L1MyMnJjb3FHdzRGUmgxMGpxMWJw?=
 =?utf-8?B?cVhSQ2tHYkh3bUoxVENlZlJJQzNSWmdQYU9PN3Y5TDRDakVEcWZ5T0Jua1Aw?=
 =?utf-8?B?dWYvRmcwOGdXSTEvVVpUQ09QZmFvS05ZdDNBYXBKTDlSU3p5WE1EczROR1Zo?=
 =?utf-8?B?UHlxWG8xNjJoYTZOOU9uaVhyY0hBeDNnYTg0UGdCRXlTTk4wSVdwWE1mVTJ5?=
 =?utf-8?B?Y1kyV1F4UDRqVjkyb2U1dFFyU3hxd21oeGJwYWwyU2dTdmk4azRNN084czB2?=
 =?utf-8?B?WktqVGgxcDYzVUUrRE5GWitobC94UkV4ZkVPVE54SEI3MjRMQ3JsdFg5dlBN?=
 =?utf-8?B?aTNwU0FpK0QyNWhxWXdGY2J4MmFCTmZMNzhRWWdNUE1wN1FVK0RkN2FrTVZv?=
 =?utf-8?B?WHdUdEhHd3IrYTE3TGg5RVV6Q3RUSU5ITFBGYlZ2eEVIV0tPRnpNSSs3WEgy?=
 =?utf-8?B?SWt1ek40c0ZmTDdrTmh0NFllb1U1QU1hOWs0djlFTEdDZzgyZWpHcUZ2NjE5?=
 =?utf-8?B?ck1McVRyQmVwL3RRbGZjaEttM3E4bmR6Wk9jSlREOVcrQWRBM3IyMXN6VDRv?=
 =?utf-8?Q?JModt8gyGl5SQ72beXbgARarA/OGjWrDA4LeKDb?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b895fa-8823-4952-b011-08d98cb03ffb
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:11:26.7456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEDcysjPNQgmfZq9vyMv94xjC5lkeQvxIbIHBidje6bWLd92BxGjI1l81uPWXN9UgMjsyk0uwhggZy/WjeliwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4051
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 11 Oct 2021 12:11:29 -0000

On 10/11/2021 2:13 AM, Mark Geisert wrote:
> It's just that after submitting the patch I realized that, if we really are 
> going to support both Cygwin archs (x86_64 and i686), there is still the issue 
> of different cygcb_t layouts between Cygwin versions being ignored.
> 
> Specifically, the fhandler_clipboard::fstat routine can't tell which Cygwin 
> environment has set the clipboard contents.  My original patch takes care of 
> 32-bit and 64-bit, providing both are running Cygwin >= 3.3.0 (presumably).  
> What if it was a different version (pre 3.3.0) that set the contents?

I wonder if this is worth the trouble.  Right now we have a problem in which 
data written to /dev/clipboard in one arch can't be read in the other arch.  The 
fix will appear in Cygwin 3.3.0.  Do we really have to try to make the fix apply 
retroactively in case the user updates one arch but not the other?

Ken

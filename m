Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2092.outbound.protection.outlook.com [40.107.92.92])
 by sourceware.org (Postfix) with ESMTPS id 92C7E3857819
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 17:51:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 92C7E3857819
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktDLOL1+uBv8HjuxFfO4we5asOUk3fAg32SY/6iuk7WXFpO5E6VOjj5hECyOrkRTcx7d7shHk+Kg582/XAYPhxm3WHMjcNkrQh28DO0uxPr1sCpqMZRzwuvJVNvtiz7Qgpa40GtYSCoeATZYca1Wo8dxJZbkqkOdMO8oTobWk6/Vxrnf1kqzRHxdQYPt5EC5QvPU41JabtpItudBit+yQMLCqWS6EgT78oz6kubVnu8FSZdFXvocS34iH6jmdq5S2WDxYonkeMapBRCia00ca8qVOFdP5YVx3aaoNFvmac9d1vDFtKg/tGbb+4uyVQPFvv1NBRyM9Fsz57/TROUsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS1QmGhDlifV1B9oei50S4Yd89JGzCYRcn7BTSOPt/g=;
 b=fDowj7FBqc9z8t1FGArgNet1iCahHA+lFuMh4Laq0lVrg8Wv1dFLo0zK7JxoNen84JWjwGZMPDmhkfZMRpUxbKYqz3bNZXo6bgksEppPruzQWGyM2uRqTn8VSWhpxdnSwR8J9ig/L2cTZ64lteIVDsziRHTKU0fnfIHrWTbRfmftWAbSNKQ1WWXeB1lF/V3WRVGx6VXySvlJrPd9cK8BGW4wclVYNbPNCxJ4pRpuOf5vD+dHL+44AhN3W7Dx4hh5UNQo2jDK72aDZW99GhpoOBlEL4S09Wya8X91EfqdoKSZqofN0+Egll1rblPU/XaMOKUe4iHhvREbCktetclfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6161.namprd04.prod.outlook.com (2603:10b6:408:50::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 17:51:47 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%7]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 17:51:47 +0000
Subject: Re: [PATCH] Cygwin: document a recent bug fix
To: cygwin-patches@cygwin.com
References: <20210115174211.16619-1-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <4d7472d9-b00c-9bbb-e514-7eee07500211@cornell.edu>
Date: Fri, 15 Jan 2021 12:51:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20210115174211.16619-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:405:1::14) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN6PR10CA0004.namprd10.prod.outlook.com (2603:10b6:405:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Fri, 15 Jan 2021 17:51:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d7fea69-846b-4692-a358-08d8b97e3a8b
X-MS-TrafficTypeDiagnostic: BN8PR04MB6161:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6161999576B587DF847BC942D8A70@BN8PR04MB6161.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSV6Toz3y65oRYSb5nBk61jJJUUY2xXpSar6OlI7HoGWVPIXGAVQ1JHDheaV4FSgoYJTFcfb4+u39puEt8ZmgVyTYAZ5q6twFC281W95zzoaAGhJibqvUqqPC/22wF53T8kjvhXaFI+B2RD4SkT4hp1rCCPdHAnE/8SF07RdC7xpHOpFbxxqGxtQMi08yydG3Pksfx8Em1CZ+BPa90k5yRJWe8cz6tbdsLjSQE7oipTzWMvYNEVg3/u/VXfvcGDmsHTN4O6XqlmNC4Wk9cSdiVPv96zqqKzFzHdl4B31xn6GoKdQco3/p18UmmCAcY7acvO87/+0S/0pNE6Bf75rNviYYetV3qfBlTqB0mJt15Fqc4pZgqhfwlo0zP9CI1kaMPdsduA324PJyv9d7e6nZxr+OAe9hHTOxIWnUOjCXUD54Utjm3tv6SBs8xvu82A1gkG44HcV6xMsIfZK1RHckqlrTQf9uXWCWCOTwwedKDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(26005)(75432002)(66946007)(36756003)(5660300002)(558084003)(2616005)(52116002)(186003)(53546011)(16526019)(6916009)(2906002)(31696002)(66476007)(8676002)(86362001)(6486002)(83380400001)(16576012)(316002)(8936002)(956004)(786003)(66556008)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?HKWoWxpnkg4IPqhNhvBZBg2OcqshmPc2oIr3dT9d3XLbsck5+0OsCHX8?=
 =?Windows-1252?Q?1Wup9f1cCL5SzEUFWKR0Z+c2tqclHJnPxKyzjQ7LD67q+RRGD7Od3WvE?=
 =?Windows-1252?Q?AoobzwjIpWaP5p7MJwYeaB6ZnRJn2wjM3B7hUDDU1fu46FughRhQXm/V?=
 =?Windows-1252?Q?jmvm5+h6B7s66KEU4Uu+GkPr7dig/dco1f/q+bP3dzRdzgwTf4mWcd8A?=
 =?Windows-1252?Q?d2P7eWQa5SdHQQ4zT95YlC+eAiTRqDivrvPg4kdbOYduhJndoal9tIDu?=
 =?Windows-1252?Q?KBV3XYL82LnSMi+yUqps7j+dISUrlA2N7YcbwJnQYZ24Tyne0LSkfrpg?=
 =?Windows-1252?Q?rmfBzyjNOeatmwotTb1R1BdC6Ru8WKpfjL/DiBrJ+NLPlJxWq6cxI/n1?=
 =?Windows-1252?Q?grdmF4yQxN4PWSmhxeogi/BdVNOZPw6oBPI9q5J3O/PY5KFIW2ZKvdXD?=
 =?Windows-1252?Q?dZG0NlouChiZp1AIc/SBIfOH1gwhbbhrr9/bKoL09tweqVhVW+tDvAA2?=
 =?Windows-1252?Q?am4g+dkel9IFeRafmrt/BEk0fkm2MJpk+EOJHpBCDVzKjmSRyz8JaNq7?=
 =?Windows-1252?Q?X0FMkQSGjQBpQ2SV+ShBgkWYA/d85hjtjtfKbxx91xxIFscJRJ1NAfCB?=
 =?Windows-1252?Q?ATJy4uANSa73i3OicREBjYmnClIsIPH5WVmnEgeby0cwoBlut424iSao?=
 =?Windows-1252?Q?YwdvezfHmRIeqerTfrote55zBXSWos5yNZB1NIJNKT8D/S/EOodp7JMr?=
 =?Windows-1252?Q?H3DUyIabC7csJCo8vAzz2WktzMzCQGGnIeUVsTkKksTs739Jh8FlNSKl?=
 =?Windows-1252?Q?2UFw/8wrM/eYUGK+/FdCZZ6PMotTmpSw4CG7dgQPBxHyIiwvN7XCvHRy?=
 =?Windows-1252?Q?eOXyGjU2g1jLqshmTdVQVsxu1szQKl+DuNLlJ74sGLjF8dMoglnJmfVO?=
 =?Windows-1252?Q?UG1tispKxbr+LCJops2Hj+wgFj40RhsKsHaiEPBpIh2nYZ2KSAXTJAmt?=
 =?Windows-1252?Q?5Jk27xFR2lEg0F1+QoCyjxV1D+YUSMrdP0ZsxeXpMbpwLSFhdou3LdZX?=
 =?Windows-1252?Q?Jza1q58wVYiTOTEE?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7fea69-846b-4692-a358-08d8b97e3a8b
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:51:47.3602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /f5qBNT1C5UyepMiRJZBZ2Sqy8N9JUL1Q5AgE6XGyQJpcpPX1zrX8813YsOjw7izA9In5VzgQPTas76yi8wbHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6161
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Fri, 15 Jan 2021 17:51:49 -0000

On 1/15/2021 12:42 PM, Ken Brown via Cygwin-patches wrote:
> This documents commit b951adce, "Cygwin: add flag to indicate reparse
> points unknown to WinAPI".

Sorry, there's a mistake in the commit message.  A corrected version is on the way.

Ken

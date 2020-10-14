Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
 by sourceware.org (Postfix) with ESMTPS id 058CC38618D4
 for <cygwin-patches@cygwin.com>; Wed, 14 Oct 2020 16:39:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 058CC38618D4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU9WpwpqNnfJ9nsoS5iPH2LSDFXWiNbYHkL0YIy28Sla1h7rnO49DG/xiW6Pu+qaYBfwoFjXwY+ZbO/9HFshPwNyZBbOwm8q0opJ3g2B8vVqR2bW3l/R4ABQqptqPqZgzbdH6x4MsAouLTC8vLhWwknS6PTSdfASiz4xQLVBlJc9PO/Nx6JUPiCLUzG/ybAn1beMZN7mU7VOCOhi0Jik/OB0LytIxajoo1bBNEx18rmXccVcXVihCvhJ0Wzg/mt2KBbAsnTN2qELpZtb/4EyztJAn7wMoiDOCh+b27QoiXqRpExIBh9jDPZ6evYeNt+Mg8iGGDDP/1b941kfPGUzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81g8qO7p44/WkgZiNNPKn3EexV5wlXE2jmqurQZb2sU=;
 b=nYjc+6yNYjbVTq/UU7CZjlYa8n7jjRGvBXdrXP6H9Bxtw92/1K3o/loCj6mi86Fp5w2G2F9MC8/f21PLLkBMdWeQD4+C8QnT1aLn1vIAfprpIxlEyQniXD+IaF3IuotxyhEnksWAt5ykS/QgaUniBC5uBsyX0Sh62Smd086zj3z3OuY0fW97qvWUEAbZLHPWEvlKbUTUYcfty83c6Mw6a9XQ4xS41GlRdYWCSIk5ViTcRZuUkdyb18wH8B0AN4AGEwZDlmGkg23q1ifASl5sc5JAWB+huTbv37ys0x3xtrF+p+WB2HM2voSi7E6sgczi8h6zXx8tHsaXy23CjfJKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5933.namprd04.prod.outlook.com (2603:10b6:208:a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 16:39:09 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 16:39:09 +0000
Subject: Re: [PATCH v2 0/6] Some AF_UNIX fixes
To: cygwin-patches@cygwin.com
References: <20201004164948.48649-1-kbrown@cornell.edu>
 <87bd83c6-5333-6287-01ce-d91ffec83244@cornell.edu>
 <20201013114933.GJ26704@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <ea3b1e6a-8857-cd1f-349d-6fc64c2d1b77@cornell.edu>
Date: Wed, 14 Oct 2020 12:39:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201013114933.GJ26704@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2604:6000:b407:7f00:9542:5871:9b51:4d23]
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:9542:5871:9b51:4d23]
 (2604:6000:b407:7f00:9542:5871:9b51:4d23) by
 MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Wed, 14 Oct 2020 16:39:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 329b4dbf-d680-40a7-a71e-08d8705facb1
X-MS-TrafficTypeDiagnostic: MN2PR04MB5933:
X-Microsoft-Antispam-PRVS: <MN2PR04MB59338D9E349D5B775B39C3DCD8050@MN2PR04MB5933.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHeGA8AfP21DDlQ/854y59Ex/PBDQY02LPocveIa888zOg1Vr7glDIoJ5w69IXoZa9ruerltVRZVhlIi4jIQ0RXQn9xyJ17n1TFTQsBznlYKr8lLYmQEiihYRGQrO+aIzZU7l76jZuF6xSGRbxS6GDsDkEWIbNEmOZql9gpGudHTuf6S5ZcWv0/VX/HnzKZP9RJYu1yB53atNFQuipYgv1tv/c9L39F724RS4UxVdoF9kEZ+VNaKlzvpfXrlpDPcvCnpSDDdYnvGBBWI5EROJg7SlHkHCJqIFLyW2cBG5EllEN7vooxUBisVg/eH44WSPxs8SjNZb+sJ3uhQejZoj1d04A8MFqPqHEpF6rGWonE10TLoCHaGg4Gp1nk1HoPi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(86362001)(31696002)(83380400001)(8676002)(8936002)(316002)(786003)(6666004)(36756003)(31686004)(66946007)(66556008)(2906002)(5660300002)(66476007)(52116002)(6486002)(2616005)(75432002)(478600001)(186003)(53546011)(6916009)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qnke7urqiUP+kCQCLCwrbrRNkejOO+WotanXWcDIfZq4x0hnoJe2JDkfcp+p2E07Avk7/IxpZc/WxLl/i3VcB34cL/W3kt97TDqI+sEGDF5GRT6zLob64wgvjrMX4QibfohJNKTZbDtRpzxyMDk01XlsL12YvYosuaJzqDQf6pE8wGZP9p1SHMCi8KNW88x8ke+iNaqNrGr0/4btEjP/Xin1gqNzIIqMEE7LOXdjB/iXazvIpue4JCccUzKP9hxsyVRskTGiAB5WK/paveddLS/1IoPq1mk5/Kty5qQKrRNBc54z7Bp4jx2oFyDVNCnnftcCWR3YxH9fLRoGDxCvB2FybPFl52wUXifZMy0NVfBQzYTMF6YEAMqc4MfBvne8M55gb2dMAwsN2ExfjVPYR1lpUbIWM8GOlr6mQ9KA9r0MWlOzYfTWsfWdFQFpa7TnnvIGRf3diM51kU8YzYgbF8Mzau3Cpg/9/NLG87lUJD0Q8yCf8HV48CsleheqaPMOmHhJHIHMvCGAoDw/7dwYL3xDTQ0LC48TU/H79UVjX2AGkx3UhaELAItqeXuhNNsfrWQuFh+IPB6iopP3ucuc2S/hSWXjja4s/JW4Qm86ieU5oAHHMl+522j9CJ2gHr8tc4Uc3S75MGX6677/4ziBtWyh94a7C/7zB8tmRXZ82dm735oF7qg9ealfgsYUn7w2vwlyBaWZq3DUPdY5Yb6cIQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 329b4dbf-d680-40a7-a71e-08d8705facb1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 16:39:09.5882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOVYQJvjVzdDyWxlvar9n3fhwxdMSRxVhKZZy01Uzg8/DfkaFXKBqrSjJpXm5mkWKa9G188cr2kXCuXo+Zef0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5933
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 14 Oct 2020 16:39:15 -0000

On 10/13/2020 7:49 AM, Corinna Vinschen wrote:
> On Oct  8 17:36, Ken Brown via Cygwin-patches wrote:
>> On 10/4/2020 12:49 PM, Ken Brown via Cygwin-patches wrote:
>>> I'm about to push these.  Corinna, please check them when you return.
>>> The only difference between v2 and v1 is that there are a few more
>>> fixes.
>>>
>>> I'm trying to help get the AF_UNIX development going again.  I'm
>>> mostly working on the topic/af_unix branch.  But when I find bugs that
>>> exist on master, I'll push those to master and then merge master to
>>> topic/af_unix.
>>
>> FYI to Corinna and anyone else interested in AF_UNIX development.  After
>> pushing a few patches to the topic/af_unix branch I did some cleanup
>> (locally) and merged master into the topic branch.  I don't want to do a
>> forced push and risk messing up the branch, so I've created a new branch,
>> topic/af_unix_new, and will do all further work there until Corinna returns
>> and decides how we should proceed.
> 
> No, that's ok, just force push.

OK, I've done that now.  The branch contains a few sendmsg fixes, a first cut of 
a recvmsg implementation, and a merge from master.  I've done some testing of 
recvmsg, but many things are not yet tested.  I'll work on continued testing next.

Are you aware of any test suite that I could run?  I've been using examples from 
Kerrisk's book, because that's what I read to learn the basics of sockets.  But 
those are just examples and are not meant to be comprehensive.

Ken

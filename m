Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2101.outbound.protection.outlook.com [40.107.236.101])
 by sourceware.org (Postfix) with ESMTPS id 768BD3886C45
 for <cygwin-patches@cygwin.com>; Mon, 26 Jul 2021 21:02:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 768BD3886C45
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO5kvXjnzjku5TWtUHTekMvGsK6zI4OosuI2MTNvJhrpvHsiM/bUvyXoy0FuGnrwpL//jTX0ZDtfNJH5jNUoxqs15B4U+6k2C6R3hC7lgnwOBLHkcIfn38zWlGw4d/uGMMpaqvTP0SiVOZe8r/YZkiujJKQkPpGzLM8v3eFL1gaJvS1RO7a8EByxXpErtou2RPEO66Kf6JrshWUrGvN8bOORB4GN7iz9q6CtVJHpgG/rniTU3QV5h+9jCOO7xIkOvh/RtiW0COfu+e7OZHB54JMyB86JcAaagnxWa8wWf8An1QO9+15TBOy0cfJ+hEuFhn9C+UH9KY2QjiY7R9DCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPpaX4sa6vrHB/3JhGMCBnPstKGqROlz7VgF17HsZrI=;
 b=YjXAK6Yn12rQQ5/7VuIKduaNBZDRGhRS9AkojFjjTGlT8GeFkWMsRU6n1BUcWaDhi/YJ7GFv4KGT78XLDuz9Tjy5AryilDZEEubvtmxznQhchaIQTy0XY+aHGzhm/gbz5rVUzBwzbL0Qy4+3Kb0LcuLrXTRd0LjRFR0OzK94aujssvnb7NJJZmWEcZ5Vkf7gncBvSkgTkIPkkErCnVO27hTRG5PtV2kZuMlYSKMpA6E62x0cQWuVmzYw2FpMxjLQtmt6RE6TEu8XBwjKugsLe3Q26GZ+qoN9ji7MkwlpEpQ3pIQNfDgh4JLOfdUl8g7H781+EVRjx5S9ums/8+t1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPpaX4sa6vrHB/3JhGMCBnPstKGqROlz7VgF17HsZrI=;
 b=Psys6FTkqYXyuRK5HoElDD53z887AF/HoIW0bi8b2yblhZ64B0hOs88nFPbLdbfoVJ2CvJh8k+yMj/ECuSZOyp3p17z00ii4RmNUJVomcnhY4NEen9PJYQPw+s4OTuc1DupiU81Bsv3UYA8NJbk2mlH+3Vl8o5MmJpDMIabAmyg=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6161.namprd04.prod.outlook.com (2603:10b6:408:50::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 21:02:46 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::cda2:359c:cb66:5c42]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::cda2:359c:cb66:5c42%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 21:02:46 +0000
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 0/2] Fix getifaddrs problems
Message-ID: <4ac22273-23b7-5be4-7f4a-48f4766bfff8@cornell.edu>
Date: Mon, 26 Jul 2021 17:02:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:208:32e::33) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (24.194.34.31) by
 BLAPR03CA0148.namprd03.prod.outlook.com (2603:10b6:208:32e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Mon, 26 Jul 2021 21:02:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cb2798b-939e-4967-7782-08d95078b7f7
X-MS-TrafficTypeDiagnostic: BN8PR04MB6161:
X-Microsoft-Antispam-PRVS: <BN8PR04MB6161A50F6312948C9C34AD80D8E89@BN8PR04MB6161.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVkeAby7szs/Fauw2nBsDb+r9dxtv5wQARXdiBJzvyBJ7KV2EszNhDP850cguS8WOiUmBDX/JPu+B+Of0firgxxQrbQqhnT8TQILb64IPCsjH1qIPXE77/mhqerx79YOE1pbvzZ9fRESTyNYPpkk4+2uDiGUmPgtkO4wapdP44pI852qgaGH8hQLKvujB7U0KKQ3DmU3NTCWF2TRVVw7ANh2jRk++DJgmswfcvm3mISXtGxlfyro8hNai4vGr2KwdWyznWnA4juILuu/9Kx3zx/kETY/9XfyWy+D91KIF8FHSoEM2CEO69k3GV2gMKiKAh24xoNnU1NmbP/p3ksI8dnjrHSCRedVYDqN7aKaaXYAYkzEacHlIJ4B4XkoqjhXXIPifls2NTvYFk+6O95qYbDzQG7tPSAykYE8K67antyxbSy4cDjdccMpIf9Qlwg4kVQyyLnClUOOve8ZWNySNhj0q6ussqHpWS+IzXT6locFrK3f6MibyULkZkH2bNkzGKcd87EC6EsX/P7VtKQvxjRie8wDry8OjIuIc7l82i94S6LPaMXayauDq4UdB7DhGdbPXjHHxhXIoJAvmNaj944s7knTSU+YnJIthArHlIonga5WQLOjyNJIIlBtchD0RngucK/M+r5nzIkRN4dbL8MC0J9iBgcl1r6bpdBlW7dha7DdlLRjpDO3+ijYEB4yefVVmId4Wm8re0yuSjtU5aGTCAUWYnQYWJDdEdvYGYaxSdU4AcLj3il1LWHEsCoBLvHyRIR+XldYfjmM0MyAc7DKVXix1emxdWRworh1L/GlGtpsUbz3tvTR2vhdb8dq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(75432002)(966005)(316002)(66946007)(4744005)(86362001)(66556008)(478600001)(186003)(66476007)(786003)(26005)(83380400001)(16576012)(2906002)(6916009)(36756003)(2616005)(956004)(31686004)(6486002)(38100700002)(31696002)(8936002)(8676002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?p2jaBIzbnyaoDehKK3R3hwE/fSsxYdlkxJQs9Fse4GzGrzI/skGJM9U0?=
 =?Windows-1252?Q?Tf6KESWLsQfnaPuC/kL9skkQfXAgz0JYEpCsiHskW8rYXE7WA1PnZ2Ry?=
 =?Windows-1252?Q?WYjOcQOLYQ2ANu1EC4tP/weh1b3zOIbQL8a2j1nDwHP+c2kgQwv4A4dV?=
 =?Windows-1252?Q?gfBn1DGbf//iyPjFCI/NbBYjDLpPs8wgLjMdj64Ivu7ywY8m1HvDnZfp?=
 =?Windows-1252?Q?V+30UEjkzK7esRy/ajLHAo/8PT1agAMv/MLwskZrA9MzN8VN4xBP1P9K?=
 =?Windows-1252?Q?MTfTWBO0/MjPXm5jcRZ0Vw88IuMlubqvIkrAF9LROKaJCFShkNcBiWeo?=
 =?Windows-1252?Q?eKXhkQ4+UOj1A1WDbCh8G5IhliI4ssLTSzmEVcG1J25lrim+L1Qg0zu1?=
 =?Windows-1252?Q?cOyCWuhoOub7hVETWwmVOBBgTXBd5T4Ww8TG3M0ABf1pWDbVCx48R0zW?=
 =?Windows-1252?Q?b0Ru/1nLrZ0LJQE8kz9PxoYDWYepiJdXtL7qDmImDnVA8yzhNEZSpJKM?=
 =?Windows-1252?Q?L72M6Igq4nKkUe1XunqxLgOIteb41VsoNi/MKFqRUrY/bo42THSb91Cb?=
 =?Windows-1252?Q?ffuS0MoBPF/CesEL30f5dazQbivbd98KmiCho4cyDLN5M71dzmKmViDx?=
 =?Windows-1252?Q?S2BJQRD0h8E9oM1+ssoKqkT4ELEP9Foy1l2VWoexVD5FXYJmL3TkpjXY?=
 =?Windows-1252?Q?vceyZt+hH8FTMm/J4m9iY7DDOB8Up/KnxtMqa1N+cEOWJ2mBQ2fKmO7v?=
 =?Windows-1252?Q?0GLIM55LmVfqC7pDTm3P680OlYyQ0BvMDBe1LrxubBlD/AMGoQ5a/dwC?=
 =?Windows-1252?Q?5wckMCLyTEBU7ql9dUMqCi0LCGplCD0QKrQ70uxVVgZJ4/GVfYEaWKiL?=
 =?Windows-1252?Q?hooOwqI7yhkWXGQe12aFeBCKkPZDP5Ag7+C4CtL7tGpIIvFi1X1FGZLS?=
 =?Windows-1252?Q?PY+evPG6sV/sMaU4D90jb3UUDQQ98d9q2Cj877cj7qXK8OXTDTzBV7em?=
 =?Windows-1252?Q?OuSD03QshdJyhxuAH/oRFf8roED2R0y4i0E5FAjg8p6TZfmh2cYzwiF6?=
 =?Windows-1252?Q?1T93DJKArp1FgEB5rmvR46cHcL7hFJp8UGCxG63Qq0yITI/K3TQrvor7?=
 =?Windows-1252?Q?pakbAX8wm+s8mHGegnyNMJ87KbK6+A7/Zsq47hics7dgqRRXJDSJIubc?=
 =?Windows-1252?Q?D3LKtksJgBD+NGq69myTP6KjBPOjWd5bRedBXj7ruNJBG+dzFv/PqqsQ?=
 =?Windows-1252?Q?iizrdpXu1DAwwHO/RgwooArltXWDJ4FOfeeouulxWlNjYcwJQyfh4ux6?=
 =?Windows-1252?Q?J/GTUNv5KLOE8CF2ZImj3r3EHDL4r9WI0hDVEkm4naHvP1sbvY58yNP7?=
 =?Windows-1252?Q?leDtUPeSxzkIOvvOqa18eyvb/VeolkDSzJPsKoqkccpl5bLH6+JxhsOQ?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb2798b-939e-4967-7782-08d95078b7f7
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 21:02:46.3851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaJD14fy/PcczA311Yqx9z6Ww6q29XR0+RBUX/vxvWdMfJykvo7gjFYnlPPoFuSzRVrV5S8vbugVu2a/5vLL/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6161
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
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
X-List-Received-Date: Mon, 26 Jul 2021 21:02:50 -0000

The two patches in this series fix the two problems reported in

   https://cygwin.com/pipermail/cygwin/2021-July/248970.html

As I indicated in that message, I'm not 100% sure of the second patch.

Ken

Ken Brown (2):
   Cygwin: getifaddrs: fix address family for IPv6 netmasks
   Cygwin: getifaddrs: don't return a zero IPv4 address

  winsup/cygwin/net.cc | 30 ++++++++++++++++++++++++------
  1 file changed, 24 insertions(+), 6 deletions(-)

-- 
2.32.0

P.S. I'm sending the patches as attachments in the next two messages because my 
SMTP server uses an authentication method that is not compatible with git 
send-email.  If this gets to be annoying, I have a different email account that 
I could start using for patches.

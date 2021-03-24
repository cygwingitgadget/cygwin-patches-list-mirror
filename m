Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2134.outbound.protection.outlook.com [40.107.93.134])
 by sourceware.org (Postfix) with ESMTPS id 569083851C24
 for <cygwin-patches@cygwin.com>; Wed, 24 Mar 2021 20:58:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 569083851C24
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=kbrown@cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvTY7LYg1If3vwwoJ10D+SlpNUg6uOlyH6nkGXMvJuUIH578dCtR4rEewh5zNhXRI6gbY57w1taZ50gVhOBXTa1CaZ4efEglHfC75hUoGTfMlKzMBreZz3l7jU4s0ofmvOL2nhb16dGLi1Y7d2JgBDUr2+W7xkN1BCUj8xWL/1yE4VQTL1XOH25VBHpMJEdxdKgSDaz9yEEpFxEOwi04FM/MRBTjkHs6B3U6x5evOlGBgC8PMrzEmiYm5Mt+wm++sVl7jLuFgw4lktKk8DJtyAxnHSP0dhMX9LhJAr4okdp0rUj3YHp1h5d2RsuOXucPFIx0zD+/mvptwQDjCrS8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z5S+RxVCz/d4UldZ2jE4oc4A+U4EPuveWeRrhL+zfk=;
 b=NtenHuSn2eseJ9HiXen/8qNR/9naKscfF3njGL5kSA3yTmUX4fK4urDcm2clnY3mbnj/+Ln7F/GOmrlJ2Z41S3kdetbhd1S0lhZqX5yBznOn1iBFrZoH/M89mo++UTrxdQbnTvJJ4bldTgD8DZ21IZyEf9WFnlSrsRNVeDn9FDF+k2RfKSzsjuGPjrYBNLb4WYlxSkbBbHbVPmw7apOlM0TqSuTspSJn/eXxUZrqt2+GeF01rpItu07Y21zuWynuMTv5hWR9bizNO1tHDIqK439jArSEOnW9AJ1nRlnNtLMuFMtzbG7/W4MQ+WXKJ0O+1cWUOTJH/gEd8PQBwbMcbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z5S+RxVCz/d4UldZ2jE4oc4A+U4EPuveWeRrhL+zfk=;
 b=eJ30ydwYXKoPHs2/wrmpn2wte8OVJSBj/BsOZoe0VeFDw71iPAaHJlDUqJe8bgYO3m++fopC+lyZF5U1CD10WeJRXlWFN4zVzIifwtSflzzxx6jmy3uglp9jgvT/D+WQQNrwpVRAljX3tmtIHENb8kEdUy0xQa5ibXSp2qyPlZo=
Authentication-Results: cygwin.com; dkim=none (message not signed)
 header.d=none;cygwin.com; dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB3732.namprd04.prod.outlook.com (2603:10b6:404:d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 20:58:39 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::59f8:fcc4:f07e:9a89%4]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 20:58:39 +0000
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
 <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
 <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
 <nycvar.QRO.7.76.6.2103150408230.50@tvgsbejvaqbjf.bet>
 <69dc492e-cce9-1a1a-7d4b-92a58dbfe981@t-online.de>
 <nycvar.QRO.7.76.6.2103221603030.50@tvgsbejvaqbjf.bet>
 <830d2446-691e-957e-9531-856e58e79c08@t-online.de>
 <YFm1GF/90te95gh8@calimero.vinschen.de>
 <b20e45d8-26fd-3186-581b-a44a4ba971ca@t-online.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <e4ce7492-d6dd-2930-2059-888381ac3cff@cornell.edu>
Date: Wed, 24 Mar 2021 16:58:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <b20e45d8-26fd-3186-581b-a44a4ba971ca@t-online.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [24.194.34.31]
X-ClientProxiedBy: CH0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:610:ce::29) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (24.194.34.31) by
 CH0PR03CA0174.namprd03.prod.outlook.com (2603:10b6:610:ce::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24 via Frontend Transport; Wed, 24 Mar 2021 20:58:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fb51c3e-6ad1-42a9-3c82-08d8ef079967
X-MS-TrafficTypeDiagnostic: BN6PR04MB3732:
X-Microsoft-Antispam-PRVS: <BN6PR04MB37325267DF7CB8947E5EB56ED8639@BN6PR04MB3732.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjJSEysB5OcFWKfkyYRQ78HL+onIaqpnfuAJG+xVtSWgDBiuvA8gAkC4QICCPZR6r6UjGVFt0IdPAGbe8aZ/JkXMFjJlY0Hqc9AUA4BUfQ6Ll5yEuw400sTLQWRUk0CjQuKf2Pi0Jmn0y+/rUgybD+OvuWeV8qXf5TA0BSi66XaSZQxF8PhV/r3raxbwv4mMpA6NtME2mxnq6pABgwqdcV1i1bRNCBTYdSM2tWbwcBl/m0lwMN/AFw70TFf3/Rq0HX8KoXh4QpkyZ9Rag7lH6hF0vFgQY50oSkJgOcdiQtxNJgVxsid2TlER+rx1ELoYgX1+4RH3aHo4XeLq18nLlmgDTSXJa4qqHeGQ3rAUKbZs2TPqq7zmE8EPH1XjNRVsVpEDuP4SCn/mPtYByHaCJ9jBOwaFK44qfVZNDhNhQWiAWd4pLOG9BdOlGWlMXjOEBi9oeyfZo1nYFyS+DID366fmbe8YqIyMbwXOJBq+nKJR6ZFrkM94lEaOE3Bj6EgqSUVqIuQIi7WvP0j9vMb9vKPyiOWPLsQgb3NDRUi7kPfv35YKnDePqwMEWchZoOZ5xrHMrJ1sv9OxlwIeNb1sc2+I7KD3BJG6iEk7lMuvrDcv+TUk1nfBOR+gVYVbYPIVIB9QtKabmmDW6GhK3DO1mtADXbrL0jH/4ar2uSS1LUyqc9oe3W5jESFOmb84izUQCH4b0riOnzHWdoExFI+LKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(2906002)(6486002)(16526019)(53546011)(956004)(38100700001)(786003)(86362001)(2616005)(478600001)(31696002)(6916009)(186003)(66476007)(8936002)(52116002)(66946007)(31686004)(75432002)(36756003)(16576012)(5660300002)(66556008)(26005)(316002)(66574015)(8676002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?l5ug9JAXbAOLmJoPKrmL82aYJ9hNfslHY32IGLw0pD02zrNmXTtSxRg0?=
 =?Windows-1252?Q?HQQcnAcJFQ4+D/jHJCO4jqsIhAqqbQ++YDLXCU+y6qNKRFckngMu91//?=
 =?Windows-1252?Q?gQKGMTB2FPOZ8KWjM3TDupIiMt84ST8wVvzt1aupwO9+sBELqG4CiVHu?=
 =?Windows-1252?Q?/kUq6XthORF/+055s4Pii1+QyYwqJ07RGb1C4/5oIW0Ied/F2LN577DN?=
 =?Windows-1252?Q?rsQ4YSFOvSNuDoJqmw/ZEd9MDSgOis65AwgHdKOC2mDp04x9CeQMKTfK?=
 =?Windows-1252?Q?hezc/MU2WBPIKMBrj3a+LJNK1J+D+ypKNBmKTv/Z4VAzWNqQl1+mMPgI?=
 =?Windows-1252?Q?gzL5jGb/H6wq4cmnNB5eIc+oakORqux3iPcMkZZLiRp81pVREEXSVU7X?=
 =?Windows-1252?Q?3Sflcghsx2vm2mt8KRAx0giP1SZGjbDyQMFPMu2C5J+LyUzdDD5paJRD?=
 =?Windows-1252?Q?RNY/JqzVFO8X6mYV99ZN+LuKQgd6ttjCm+SaDWGNeKvaTjmDq+Awkt3v?=
 =?Windows-1252?Q?IVsEwo5dP/PIxQMIn4wPzHa9ampgjKFOhON2dEhfHSze9JIjhA92vr93?=
 =?Windows-1252?Q?jkulvUya73T4oA78kvVhxI78dZg7wzmOEKfSgoeozhIv6wXMpSNalIK6?=
 =?Windows-1252?Q?JGqHlvl5Bv4NYV8cdSRz8nFC37nBr6tLifuHEFahWI6ZkgY1f27NXe77?=
 =?Windows-1252?Q?s6iR8KlW0ClW9m3RhbTkATluCRLcYYTDfJLs8IiXu/LVuM5LTJcwXvuC?=
 =?Windows-1252?Q?WZKGPDhde20bbPi0oLjfAP7/rb0QF2/Uv+poTAFFgNQOR7kiPkc+fl+G?=
 =?Windows-1252?Q?Txavrr1rK/xg4Zf+XUHTB4ikGlHxdx6uH42OP6jmb7sPjISbOGL2sPu0?=
 =?Windows-1252?Q?5vClCxvuYpLTcwhMI+YY91ECMsy24bbDQjElazdcK2TMQaPoepaW9hzH?=
 =?Windows-1252?Q?6X/g90i1sSRUtDfQoxeyu251zFrPMTQhrkextci4cbVFx8y0a7/U1AUC?=
 =?Windows-1252?Q?bVqqrahnam3Uxnu6+8RfMGo/UXqGNO59JFxNOg7dHTW1Wil3TP5VXxNp?=
 =?Windows-1252?Q?22zHYcPHzLxSQF1tLdhfl4ZWuo0Mv7CAGLpAYzHzRDdy7ZZ4qUz52Uz9?=
 =?Windows-1252?Q?OyNKAsb3xKM9vdwnokqU8gfz7NL9Gl1luvCxzQm55So1vDWFnXNDqVrE?=
 =?Windows-1252?Q?Okj21K6a47juksgOW7FqclB6OaIlzZUNu2Ds9gaZxPFCh5URYr+e/x69?=
 =?Windows-1252?Q?v6Zvtbc8ilzT+yrTktIkGore5ZzhtfqxVgAnkPVprJdhwanHz9iWig6u?=
 =?Windows-1252?Q?w97/cYng4/9nTT+5fkU4THllP8qGs6qPxgw+Ybh6Y8WlZwvQ7s1IuMlX?=
 =?Windows-1252?Q?/IY/MXk2cyWCtTUAdPfU9mpsnFPSWPBk8PJUIwaQoqKC27LnYgyqOmea?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb51c3e-6ad1-42a9-3c82-08d8ef079967
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 20:58:39.2962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDq6ON5vf3OZVJP34s/am+n2hssOTCM5dVlmIv46cJlPjl95caKeo8rYDBIOPWIx80Fqqj5TPnfK8qkcmsqAeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB3732
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00, DKIM_INVALID,
 DKIM_SIGNED, KAM_DMARC_STATUS, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 24 Mar 2021 20:58:43 -0000

On 3/24/2021 2:55 PM, Hans-Bernhard Bröker wrote:
> Am 23.03.2021 um 10:30 schrieb Corinna Vinschen via Cygwin-patches:
>  > On Mar 22 22:54, Hans-Bernhard Bröker wrote:
>  >> Am 22.03.2021 um 16:22 schrieb Johannes Schindelin:
>  >>> One of those under-documented reparse point types is the WSL symbolic
>  >>> link, which you will notice are supported in Cygwin, removing quite some
>  >>> sway from your argument...
>  >>
>  >> I notice no such thing right now, running the currently available release
>  >> version 3.1.7:
>  >>
>  >> stat: cannot stat '//wsl$/Debian/home/hbbro/link_to_a': Input/output error
>  >
>  > What type of WSL symlink is that?
> 
> It's what WSL Debian creates when I 'ln -s' inside its own filesystem.
> 
> Windows' own "dir" command shows it as
> 
> 22.03.2021  22:34    <JUNCTION>     link_to_a [...]
> 
> But it cannot do anything else with it.  Even fsutil doesn't work on that thing:
> 
> C:\prg\test>fsutil reparsePoint query \\wsl$\Debian\home\hbbro
> Fehler:  Unzulässige Funktion.

Are you running WSL1 or WSL2?  I have WSL1, and the stat command such as the one 
you tried fails in the same way as yours.  Nevertheless, a symlink created under 
WSL is indeed recognized as such by Cygwin.  I verified this as follows:

1. Within WSL,

$ ln -s foo mysymlink
$ cp -a mysymlink /mnt/c/cygwin64/tmp

2. Within Cygwin,

$ stat /tmp/mysymlink
   File: /tmp/mysymlink -> foo
   Size: 3               Blocks: 0          IO Block: 65536  symbolic link
Device: 74d6767bh/1960212091d   Inode: 25614222880728371  Links: 1
Access: (0777/lrwxrwxrwx)  Uid: (197609/  kbrown)   Gid: (197121/    None)
Access: 2021-03-24 16:25:50.729219700 -0400
Modify: 2021-03-24 16:25:50.729219700 -0400
Change: 2021-03-24 16:27:13.979376200 -0400
  Birth: 2021-03-24 16:27:13.979376200 -0400

3. I then ran the stat command under gdb with a breakpoint at 
check_reparse_point_target and verified that Cygwin recognized /tmp/mysymlink as 
a WSL symlink (IO_REPARSE_TAG_LX_SYMLINK).

Someone with WSL2 should try a similar experiment to make sure that the symlink 
representation as a reparse point hasn't changed.

As to the failure of the stat command that you tried, I suspect it is related to 
the '\\wsl$' magic rather than anything to do with the symlink itself.  If you 
run that stat command under strace, you'll see that Cygwin calls NtCreateFile 
(\??\UNC\wsl$\...), which succeeds, and then calls 
NtFsControlFile(FSCTL_GET_REPARSE_POINT), which fails with STATUS_NOT_IMPLEMENTED.

Ken

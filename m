Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::71e])
 by sourceware.org (Postfix) with ESMTPS id 364D33838208
 for <cygwin-patches@cygwin.com>; Thu, 26 May 2022 19:16:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 364D33838208
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNHQWdyqX46zpf98svjrrlZ6RYUpfQjsL0jqkpV3e/UCsy/tkzDm5pLKbqffjZiDRdCZtx1k8Fv/i7WcqEcqB9JaYWnxQHgtWTk3Jg7gXWkGYlOQeM5VM8nS/RCwxi4r/HyvNbuuWpcQCHW/dUsVL4bRSbv4eKL+1b4kFKaTKhGKtHHLonhKYR7c0+h+AVU0UF/MWRX6heCFAJ+5EwztqoNzKNyUUZX/cLEFmqcZIDjdxJDmxDizuklNemLqbPplFXs1SvWBqZ1PLu9mUJm4Al4W1QAABy6kVb2UpiEJJhzWzkSwbG24+QtS4BGM1LyMJtg+FyTk2+a7EjoaFJ90Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jpGbtEYVElPmtkNE98wE7IfFXZVyXYyvWk53YqSarg=;
 b=U1iqnHcGS4h70mRhIh1UiPdr5fNuqW+yVY8PUjSdNlccSzIiDg65cfUSDxvc47lMT9LeDJOByYaI75yHMdDYMR8Vom++RL4GxGgiaY0nAfEO7SxTAr9bmPW0upVy40yIdMEn1qIk7FgLbOi4nZ3/S/8abZSEPKlwa8ey+oF3FvCM1qD1RffvLg6m66+L+CCwhusPwGbRWvPZ9iZKfBNbiAc0/K/S33zgFJmjZNDXDPkCp/oqdhy/gB86JnAzHT+fQGeFpG9yL2URoIGIhFq6et6WeA/KmMKnEJ6pz4PgXmiiDFRvNG0KWxKJnRkDOsvWNjBlkGM2KOr2FMkdm2ulHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jpGbtEYVElPmtkNE98wE7IfFXZVyXYyvWk53YqSarg=;
 b=VnjgxHclM6/71pNqcYDW8OmdeoxCb/MUKt6malbx2WG30kYu24je9tGjxINlmhS6VVyLVg6jFF4CssWcaKkgV17haFVEL23cJK0XsiMr2wTXnc7i6y3Ip9LOM5UwFvGyjA5Kp+btl2C0pdbg5MVgZ7ff2Z/udj1oq7AmrHTkRsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by DM5PR04MB0443.namprd04.prod.outlook.com (2603:10b6:3:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 19:16:54 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::ed45:6a5d:b109:673e%6]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 19:16:54 +0000
Message-ID: <20be5f5f-d371-a2d8-4579-c6e8b762e357@cornell.edu>
Date: Thu, 26 May 2022 15:16:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 0/7] Remove 32-bit code
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:208:234::16) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca4f817c-5ae7-4375-dfb3-08da3f4c4b24
X-MS-TrafficTypeDiagnostic: DM5PR04MB0443:EE_
X-Microsoft-Antispam-PRVS: <DM5PR04MB0443C440B80CD23E3C50EE99D8D99@DM5PR04MB0443.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJ6Fn1zVc/hO8bi0l2pGFtfOwKTF9LWvdj4kkeObY46xptMvBf5od/vfNPTclRdyMHvrwzQBKCdpd4eOpZaObsPAuZ0DrFusIFxyaHmQgrTQF+KGchkn8t36W9d0bV2pAuzMd+BE5rnMSdd0dadco8yMP9vN53EBX58ddzTqlKRBiiLqk2x8PPWivILp25E8BijDasgO79h6VIRGI64znaFw0zNtc750YynQtgIr/oXLdERASKKEC7P45Jt2wxGaPDQ4Dcvi2PhgfXDSQhV5Z1XoBUQNelEBh0gSMWZeaEIu9itJRiydSaZMGTczhEIQYBHm9sYnNise8yIvAcwYzUmUAPlt9amvaIF/S7+y4h3yJ2gazyMwJrEP1wZWoa24J+nUkEtOlYP4HQ3sLL9zderQIUgacNYHoySZnuaBRruy8EON6CHuPfNPnh3HWgZdsGCzc7yfveA8FYc9cY2+R607uvajtIObc11mVdjtb9kZvYwYJZl3ewiF7Kj8XlOLd7AG1JCF4V+i+bNm6iOQ7bzFU+oTBJiVIwb7959QmM5SOIzAZKnYCbwahLmjm7Y6p71PBRYrg12WJ0XemuZOxZyu7tNXdguAbwYX3D4BpfyJVpdJjl0QhMxvhSVLf6AVu/6EMDoWtt0OZFvNUysKLkf+JELbTZl2u4ZKDi6e//OA8PSZBh5kPQoxKaLbrmw/46aSU3OpzSJm0SnQMQeZz2TDc8SK6avb3NMLH3N4+5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(86362001)(38100700002)(31696002)(36756003)(8676002)(508600001)(316002)(786003)(6916009)(2906002)(2616005)(75432002)(5660300002)(6512007)(6506007)(83380400001)(8936002)(6486002)(31686004)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1RneVdxWTF5anYzUUVNNHhsaVJoUXJsQkFJR0FsdFNoM3pBdkZ3U2NsUUdY?=
 =?utf-8?B?Q2FFVmwvTGRFeG1oSkgvN2hjb1k2WWpKUWhWbHgzMUJPcVJQb0pMZFBLMDBx?=
 =?utf-8?B?ZjA0Q09jYWc1YmM5NlZHQitJRjBBWGlkMkRiNnNOdEFpL1FmNlgrQWUzL09q?=
 =?utf-8?B?eWtTT1MzSEo5bGprU2FBNnhST3o2TzVwc2U0V3dYYW1VWUk5TUh2Q0JMWU9K?=
 =?utf-8?B?NXVWS3dGc1ZtWlVaUTQ0c3RYWExWWU90U2FxQVJCTXJLZUVNTzdUT2FuWWNW?=
 =?utf-8?B?WEFUWVVIazZwdWpDK1l4em1aMnZJbm5SR1J5dGxzb3FoQ05pVzU3d0hydm1K?=
 =?utf-8?B?ajJNblpaZC9TNTF5OElvMGt0VXJEMVg5cjcwTVpjUm1IY2lpeUVWN3lRYkVl?=
 =?utf-8?B?aFJ3bVd1ZEpWQk9vMFJzOTZwWDZHaDI1aXFVMWZYekw0U2FHNHBycCsvT2hN?=
 =?utf-8?B?d0lESHlwejUxdjVhakhSYWZ1NUViRHlDTzdjek1vWDZBNjhkd0M4azdlbEpo?=
 =?utf-8?B?RFhEeGlYWkJnR1YyNFRLbDBqaUNvTjMyWU9KTGIzdkw2RFdKbStVd2ZmeTZR?=
 =?utf-8?B?aEFha285a1doUERjTC8xWGwxUUdHM1d4WVN6amRxcTMxL2pKZHNTTi9vdzhG?=
 =?utf-8?B?UjducW54anovOUNxNEJHQmVvOFVoODhOSUNpbVFxaVlIV3NOS1NJSFA1d2Zi?=
 =?utf-8?B?SHNvTmM4QndUOXQ4cnhGSExiRXk1blFBTk9CMmtqdkhlclUzZ01VTWJpT2xI?=
 =?utf-8?B?aWg1ZmhKRWFjYy9MbytvZG5ESkxRUHVjdk5BbGQ5VEhuZTlEQklDbFZwTWda?=
 =?utf-8?B?NHoyK0FSQUJLLytBamRzMEtrMWtuK1BlQVRESjJDZmczcXpITHMvSTFUVTh5?=
 =?utf-8?B?QjE4L0ltQXRRS2YvczR1U1Vxb2lZU1BrcXhwWWRTRmV2ZXZDc2NxZEVkdjJR?=
 =?utf-8?B?UkMrb3JNcisremlZLy9ZbmU4THh2S2JsOE41Uys4Zy9Wc1ZzZDZtNDUvSDRT?=
 =?utf-8?B?L1hkSXhlTTdISWd5WFU1TWRCbERvMWdNaWlCVGVHQlJjYkxldmsrNERTK0sw?=
 =?utf-8?B?aTBmUE9IRHZnRk9qRUtKOGVRSXBkSHllMFZsWkhidXd3ZmUrZk8rNW9Jd3Iw?=
 =?utf-8?B?aTBZQWlxdUg3TlBueWxWMmVlQzRFakl1ai9qZVBFZFFTSFJ6bmRaUzJSM0Jj?=
 =?utf-8?B?Z3FWNE05MkUwTSsvMVdhQUpuWHpzdmJ4aDEveHdpREdFS1JVQStWRjBFUGF5?=
 =?utf-8?B?RGFJSHp0b25nQ3JEMlI4VFhkTkRLS1JxeE9nVHBtajZGbHpuN2pZbllNbjZI?=
 =?utf-8?B?Y2tSN3hsWXhSeDNSQnlKMUxNWG1lMUEwMVpoT3NhanZCWE9peU56L09DOE8r?=
 =?utf-8?B?YjhoMG1venhyZ0M4dDVwSEsvUEhSTmhvYU1FUVpCcTE4Vk5ONGF5cnQ2Q0ox?=
 =?utf-8?B?TlhQRmJKTVB6OXBObWxVTVI5dm9nMEwzdkpFcVdTRTdJNldIWUFCU05zWFdW?=
 =?utf-8?B?bXJXYS8rZWNUaGtRZHh3enI2VDBBVGdvOW9TOURZaHpIRVRrLzZmVGFwNUx5?=
 =?utf-8?B?Y0NBRm5RdTErNStPWEduNE1WU1EvaklWTDBxSzNITHFoenVJVlh2SWk1SkFq?=
 =?utf-8?B?WmxBWGN6dGlObEUvSWhqLzgvaTNVTEhjMzRtUmxxTVNXRk44WkZMcEhWYVE3?=
 =?utf-8?B?c2cyMWxaYVE2N0Iwc01wa3REUExTdVBGcFB0d3hmUHByZWczRXV2bTE1OFV1?=
 =?utf-8?B?THcwQTF5UmFIKytoejZ6UGYxODNyVjVuRVo0RzFzYVdITHRKNnlpNEdLZkdO?=
 =?utf-8?B?Z3lhY0lRTmlhVHh3cGtvNHZ0bzlXVXR5cmswenhRNGJwVGlJMHVhcEVpM0Ey?=
 =?utf-8?B?dUFxcW5NajZHZzkzaUg2WWtwbHh1TEwvVStBbkVJUDF2UEVMUC9nSzZ1WWFR?=
 =?utf-8?B?RFBVYW9Hb01UbE1rWGoycjZYWXd5T3FMeFF0Rlc5b0JzYk8zOXVsVlJwY251?=
 =?utf-8?B?YUN6Vlh3QTUwTE1XbXFQdkFuZnhSQ1plVjdweWM5WXFha0FsMUNLMzY0MFZy?=
 =?utf-8?B?cTlhZXZEQ3ZOdlBjMVhWMGtKSXRFdUdiZnNSdUtFaDJYaDd0aDMxVFRLQXEz?=
 =?utf-8?B?dVdqckd0Z3ZoVE5NNEdBMzduNGRiRzJNeXNGK2tBRXozRy9raS81TCtxbDRn?=
 =?utf-8?B?ZmdOQzV5OVk1YkRMT1B4akhOUHRYYnlTRU44ZnpKTFF3K2lDVXlDK09uUW5U?=
 =?utf-8?B?RWYrNEMxZWlBaVh4UWhlT3ZHaVh5cy9iWTRlRnBXYk9nYkgrRUFyMWlKS0Nq?=
 =?utf-8?B?dzlENEtSQ252VFdsTVVNeHhqRWZvcE5kMkJSTEF3ZlR5N3JycG5uQytMa0p2?=
 =?utf-8?Q?lmhVrRgcCeNQ93ubjZ6iaRwcVIoK966hr60dH4YLP92N0?=
X-MS-Exchange-AntiSpam-MessageData-1: lJNNTM8lIWWgAg==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4f817c-5ae7-4375-dfb3-08da3f4c4b24
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 19:16:53.9462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaVUHaGXf0893OoBOt2qHubhrHdvhsvhcd3TA1ZxFe27eIstMzsNu4tAF0cglgmcmljO+8uxcsCt0f9AIIV56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0443
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, SPF_HELO_PASS,
 SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 26 May 2022 19:17:07 -0000

The patches in this series other than the second remove code that was used only 
in the 32-bit build.  The second patch does some code simpification that is 
possible as a result of the removal.  For example, we rename stat64 to stat. 
This eliminates the need to export stat as an alias for stat64, and it also 
eliminates the need to define a prototype of stat64 for use in the build of Cygwin.

Ken Brown (7):
   Cygwin: remove some 32-bit-only function definitions
   Cygwin: simplify some function names
   Cygwin: remove regparm.h
   Cygwin: remove some 32-bit only path conversion functions
   Cygwin: remove some 32-bit only environment code
   Cygwin: remove 32-bit only clipboard code
   Cygwin: remove miscellaneous 32-bit code

  newlib/libc/include/pwd.h                |   2 +-
  newlib/libc/include/sys/stat.h           |   2 +-
  newlib/libc/include/sys/unistd.h         |  16 +-
  newlib/libc/posix/posix_spawn.c          |  11 -
  winsup/cygwin/autoload.cc                | 136 ----------
  winsup/cygwin/child_info.h               |  14 +-
  winsup/cygwin/cpuid.h                    |  23 --
  winsup/cygwin/cygerrno.h                 |  11 +-
  winsup/cygwin/cygheap.cc                 |  42 ++-
  winsup/cygwin/cygheap.h                  |  18 +-
  winsup/cygwin/cygheap_malloc.h           |  24 +-
  winsup/cygwin/cygmalloc.h                |  25 +-
  winsup/cygwin/cygserver_ipc.h            |   4 +-
  winsup/cygwin/cygthread.h                |   4 +-
  winsup/cygwin/cygtls.cc                  |   2 -
  winsup/cygwin/cygtls.h                   |  26 +-
  winsup/cygwin/cygwait.h                  |   2 +-
  winsup/cygwin/dcrt0.cc                   |  41 +--
  winsup/cygwin/debug.cc                   |   6 +-
  winsup/cygwin/debug.h                    |  10 +-
  winsup/cygwin/dlfcn.cc                   |  23 --
  winsup/cygwin/dll_init.cc                |  36 ---
  winsup/cygwin/dll_init.h                 |   6 -
  winsup/cygwin/dtable.h                   |   4 +-
  winsup/cygwin/environ.cc                 |  31 +--
  winsup/cygwin/environ.h                  |  19 +-
  winsup/cygwin/errno.cc                   |   8 +-
  winsup/cygwin/exceptions.cc              |   4 +-
  winsup/cygwin/external.cc                |   7 -
  winsup/cygwin/fcntl.cc                   |  46 +---
  winsup/cygwin/fhandler.cc                |  18 +-
  winsup/cygwin/fhandler.h                 | 324 +++++++++++------------
  winsup/cygwin/fhandler_clipboard.cc      |  25 +-
  winsup/cygwin/fhandler_console.cc        |  14 +-
  winsup/cygwin/fhandler_cygdrive.cc       |   2 +-
  winsup/cygwin/fhandler_dev.cc            |   4 +-
  winsup/cygwin/fhandler_dev_fd.cc         |   2 +-
  winsup/cygwin/fhandler_disk_file.cc      |  30 +--
  winsup/cygwin/fhandler_dsp.cc            |   8 +-
  winsup/cygwin/fhandler_fifo.cc           |   6 +-
  winsup/cygwin/fhandler_floppy.cc         |   4 +-
  winsup/cygwin/fhandler_mqueue.cc         |   4 +-
  winsup/cygwin/fhandler_netdrive.cc       |   2 +-
  winsup/cygwin/fhandler_pipe.cc           |   8 +-
  winsup/cygwin/fhandler_proc.cc           |   4 +-
  winsup/cygwin/fhandler_process.cc        |   4 +-
  winsup/cygwin/fhandler_process_fd.cc     |   2 +-
  winsup/cygwin/fhandler_procnet.cc        |   4 +-
  winsup/cygwin/fhandler_procsys.cc        |   4 +-
  winsup/cygwin/fhandler_procsysvipc.cc    |   2 +-
  winsup/cygwin/fhandler_random.cc         |   2 +-
  winsup/cygwin/fhandler_raw.cc            |   6 +-
  winsup/cygwin/fhandler_registry.cc       |   2 +-
  winsup/cygwin/fhandler_serial.cc         |   4 +-
  winsup/cygwin/fhandler_signalfd.cc       |   4 +-
  winsup/cygwin/fhandler_socket.cc         |   4 +-
  winsup/cygwin/fhandler_socket_inet.cc    |  51 +---
  winsup/cygwin/fhandler_socket_local.cc   |  22 +-
  winsup/cygwin/fhandler_socket_unix.cc    |  10 +-
  winsup/cygwin/fhandler_tape.cc           |   6 +-
  winsup/cygwin/fhandler_timerfd.cc        |   4 +-
  winsup/cygwin/fhandler_tty.cc            |  14 +-
  winsup/cygwin/fhandler_virtual.cc        |   4 +-
  winsup/cygwin/fhandler_windows.cc        |   2 +-
  winsup/cygwin/fhandler_zero.cc           |   2 +-
  winsup/cygwin/fork.cc                    |   4 -
  winsup/cygwin/gcc_seh.h                  |   2 -
  winsup/cygwin/glob.cc                    |  38 +--
  winsup/cygwin/globals.cc                 |   6 -
  winsup/cygwin/grp.cc                     | 126 +--------
  winsup/cygwin/heap.cc                    |  52 +---
  winsup/cygwin/hookapi.cc                 |  25 +-
  winsup/cygwin/include/a.out.h            |   7 -
  winsup/cygwin/include/asm/bitsperlong.h  |   4 -
  winsup/cygwin/include/bits/wordsize.h    |   6 +-
  winsup/cygwin/include/cygwin/acl.h       |   2 -
  winsup/cygwin/include/cygwin/config.h    |  11 +-
  winsup/cygwin/include/cygwin/grp.h       |  17 --
  winsup/cygwin/include/cygwin/signal.h    |  59 -----
  winsup/cygwin/include/cygwin/stat.h      |  29 --
  winsup/cygwin/include/machine/_types.h   |   8 -
  winsup/cygwin/include/machine/types.h    |  11 -
  winsup/cygwin/include/sys/clipboard.h    |  23 +-
  winsup/cygwin/include/sys/cygwin.h       |  32 ---
  winsup/cygwin/include/sys/dirent.h       |  16 --
  winsup/cygwin/include/sys/mman.h         |   2 -
  winsup/cygwin/include/sys/strace.h       |  12 +-
  winsup/cygwin/init.cc                    |   3 -
  winsup/cygwin/ipc.cc                     |   2 +-
  winsup/cygwin/lib/_cygwin_crt0_common.cc |  11 -
  winsup/cygwin/libc/fts.c                 |   9 -
  winsup/cygwin/libc/minires.c             |   4 +-
  winsup/cygwin/libc/rcmd.cc               |  13 +-
  winsup/cygwin/libc/rexec.cc              |   4 +-
  winsup/cygwin/libstdcxx_wrapper.cc       |   7 -
  winsup/cygwin/miscfuncs.cc               | 100 +------
  winsup/cygwin/miscfuncs.h                |  16 +-
  winsup/cygwin/mktemp.cc                  |   4 +-
  winsup/cygwin/mmap.cc                    |  52 +---
  winsup/cygwin/mmap_alloc.cc              |   4 -
  winsup/cygwin/mmap_alloc.h               |   4 -
  winsup/cygwin/mount.h                    |   2 +-
  winsup/cygwin/net.cc                     |   8 -
  winsup/cygwin/ntdll.h                    |   2 -
  winsup/cygwin/ntea.cc                    |   4 +-
  winsup/cygwin/passwd.cc                  |  32 +--
  winsup/cygwin/path.cc                    | 182 +------------
  winsup/cygwin/path.h                     |  20 +-
  winsup/cygwin/perprocess.h               |   4 -
  winsup/cygwin/pinfo.cc                   |   2 +-
  winsup/cygwin/pinfo.h                    |  16 +-
  winsup/cygwin/posix_ipc.cc               |  10 +-
  winsup/cygwin/regparm.h                  |  19 --
  winsup/cygwin/sec_acl.cc                 | 139 ++--------
  winsup/cygwin/sec_helper.cc              |   2 +-
  winsup/cygwin/sec_posixacl.cc            |   8 +-
  winsup/cygwin/security.cc                |   4 +-
  winsup/cygwin/security.h                 |  43 ++-
  winsup/cygwin/shm.cc                     |   4 -
  winsup/cygwin/signal.cc                  |   8 +-
  winsup/cygwin/sigproc.cc                 |  23 +-
  winsup/cygwin/sigproc.h                  |  26 +-
  winsup/cygwin/smallprint.cc              |  32 ---
  winsup/cygwin/spawn.cc                   |   2 +-
  winsup/cygwin/strsig.cc                  |  14 +-
  winsup/cygwin/sync.h                     |  10 +-
  winsup/cygwin/syscalls.cc                | 316 ++++------------------
  winsup/cygwin/sysconf.cc                 |  16 --
  winsup/cygwin/thread.cc                  |   4 -
  winsup/cygwin/tty.cc                     |   2 +-
  winsup/cygwin/tty.h                      |   6 +-
  winsup/cygwin/uinfo.cc                   |  40 ---
  winsup/cygwin/wincap.h                   |   2 -
  winsup/cygwin/window.cc                  |   4 +-
  winsup/cygwin/winf.h                     |  10 +-
  winsup/cygwin/wininfo.h                  |   4 +-
  winsup/cygwin/winsup.h                   |  36 +--
  winsup/testsuite/winsup.api/cygload.cc   |   2 -
  138 files changed, 607 insertions(+), 2387 deletions(-)
  delete mode 100644 winsup/cygwin/regparm.h

-- 
2.36.1


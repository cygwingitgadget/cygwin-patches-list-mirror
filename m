Return-Path: <kbrown@cornell.edu>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2110.outbound.protection.outlook.com [40.107.223.110])
 by sourceware.org (Postfix) with ESMTPS id B097A385700F
 for <cygwin-patches@cygwin.com>; Sat, 30 Jan 2021 16:34:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B097A385700F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ30NnPPLe21ZyJO15nw8CKFs9EzWnMWHhNdNbeo/wsu8eHpG5jSbzbs5LtErcRzt7PN8AYdVHXCkjdo1Vh0JBkB70McCkupwmLyje+RToMKM1UPd6tBwhUfD6KAoWzFpptF/qBqXDZPe23dKUACjRJhp1c/6m9OVawYv/0fecEk0VP8eWZZTakJSM9BzEK7Dib4cqa2qG6M6l3UcaRjucHAY/HL4x0AFp465vXTrFOW3Q/tpWS0vLld4RhT3jvDFnS+OPqYHtJWala4R6XGM6uRrftStVvk7mFt6w1NCbI69on+cm0s+uy+tRWZnCReL3R5QrEZN3gAj+V6KbVjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfkRvvi9tG+hTDgghJTP8mB590o8o8TbuAYhHZ/btPY=;
 b=aKqITSA3z3wyMUCMXzgUOS+3kICCiiN4AuW2eOCv6Jn+Sw8tHuFp4byar4uADrlrlrpnQCCnj29q+hkZXVZDZHR6NWAIV0242VlZ3kEy9LuNJLPQui9xr9NS65ezMl0mHl9H137vRLx0N1s3OtBGEEq2f90YLYNy02xvDuZO4unKZsQm/5yth/vICFH3PuJyxxsDeGvrvGVFCASBc5EJSEXLII5gDXJ2AjnU9hxJ7Cuh/k5Sjw5hxVQxy+9d1/AjU2TVBu0OHhDX9SHycJMfYPv0dEzwxQ8qd/7x4Yelybz09TzsN7fTQGktM9LfUfwGgwDSZv76Uza6efkk5TYV+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6065.namprd04.prod.outlook.com (2603:10b6:408:55::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Sat, 30 Jan
 2021 16:34:57 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3805.023; Sat, 30 Jan 2021
 16:34:57 +0000
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/1] Recognizing native Windows AF_UNIX sockets
Date: Sat, 30 Jan 2021 11:34:35 -0500
Message-Id: <20210130163436.21257-1-kbrown@cornell.edu>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN6PR19CA0061.namprd19.prod.outlook.com
 (2603:10b6:404:e3::23) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (65.112.130.200) by
 BN6PR19CA0061.namprd19.prod.outlook.com (2603:10b6:404:e3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Sat, 30 Jan 2021 16:34:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c295a2ae-d5f3-4154-5371-08d8c53cfad0
X-MS-TrafficTypeDiagnostic: BN8PR04MB6065:
X-Microsoft-Antispam-PRVS: <BN8PR04MB606518614FD50D04299506B2D8B89@BN8PR04MB6065.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VO+T1aKaOH/nwr1Kap+kq03DpocEgZNV3kR4xMlph4RNjycc1imLVBul9Ah5dlx5/fkl+zaFMf+UUajWQvbJzIWGROj56BVLnRymWEvCjwcSZs2CPhZFMq0MsnAJ1ES//qli42CK7h59LOHOu8UaeoELwWNUbMD+RHdjtRfyH1zwtPYF2v3QuGcI3SJ+ih3SarzyllRprsaJSWy1lFcYnQa2FCrtXwXMemj07XZxKDNEOJg0JTjPuPnzNtGhYs7SAw2Uzw+9Dou7ZDUJbOAGgrxPXz47RL2v5V5iZuL03+WEEqeXqC5f3TPhGxJaPLCUYWu+HgjyF2zt/Xx+X5viajVL1MsaQ1PcJYdr3ZtGEgJhCTxF97qcMQyHwRj9MNeDZWVYeLUuCnNR62nwcsPBHWL7XKkKI1Ateq4Kib8XsJ4fasyKuB2EXzGo0o2sg1xUIVp4/X0jRyuOtWSyC6sgtnjJaQuVf6S2I+AURKhpTKSEY0CS9AKM/ioi1sH8wzsOGIDspm7YFfIZLGaT63V6WAG4tAJJ6O4do7Nqx5CZQj8FeGqWgD/o9Bp4WTo6bxTEkg/dzJBpLHqlqe5tOaiwPh8uFxlniqu/Y0vxvksgBTu7ER/4ROGVt4jUWxcE4gK2CFDSdh4YlI/rUuJflS3r/axS1ChWy1HqvQ+9MxBTssPzhIPA+yHzKzc5lDK896Oe9goLuvVfUkWBcWqW3he22g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(66556008)(966005)(66476007)(52116002)(5660300002)(1076003)(186003)(86362001)(16526019)(66946007)(75432002)(316002)(786003)(26005)(6512007)(69590400011)(956004)(6506007)(8676002)(2616005)(6486002)(6916009)(2906002)(83380400001)(6666004)(8936002)(36756003)(478600001)(460985005)(2480315003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C2C2hrGuk35Fai1/DKq2GGqYJD7TASQBZoO8fiHGBh8LsbDjzUre9b26fDbT?=
 =?us-ascii?Q?blyTcdkQw2aQXBEP1lIIkIBE3pckm1qi62Oyp88Wdao4urnDePUbiAtXgtVE?=
 =?us-ascii?Q?nB2o+WMrn+MjuKFsIp4I/7CmJj4iXrNj12DDmXihxIGW/omXouVPMkQAmO9D?=
 =?us-ascii?Q?H/PgmLQ2b3JGBMMn82InJOWZYLhc/mugbIRHGzLLfxqLCwd772aQv9UdZ/PQ?=
 =?us-ascii?Q?uNW+DC/uStbuQPZKRTvZShq4gicqygrNAE2Q5+gbWfDPTZPDsg7y9rQxxNEp?=
 =?us-ascii?Q?rjQyvTkWIPntZjWcdZs8D9jSwmAhp3BD6XAfSKP+1ZV9kciBgmTYAfhHfCa0?=
 =?us-ascii?Q?f/BlehrOufZCEfTmZjzWhnn7WObYYafsBf5UKyQKajya0nVCAKQJI1v5hShw?=
 =?us-ascii?Q?64PLBHZtsGnvp45x8WtvwAQ6HZ6nrXjCj+5FnDX+DRUXxjkY6JE2JuDpn3j3?=
 =?us-ascii?Q?uBm9Ni5RHmIt2d40wtP/c5hfqnX2g3L76wXDXaJRq4dFTsxGNlD6HLmWhXw9?=
 =?us-ascii?Q?hGzvEjg+R/Ba1CUXEQErto6CX1yHyBUU/c/CxpiwIEq6tjMjEPqdebmRt0Vi?=
 =?us-ascii?Q?a9pMD4xDSKXwDZ43cwhv3f5pDuncqKrhk3sHGRtju4EHzr0sgvEye9WwAV9T?=
 =?us-ascii?Q?o7Hh3yaiXUqBAyLdyfzOgmv6tJUGUG1QbDd+YCyUJ7sWJJzoyQw9SXPzzKHV?=
 =?us-ascii?Q?ZZbNIj/or8LjbmXibYcl4zp5hFZjSPUS6L/4Llm5dt+AXDakGEqm37NejIQ/?=
 =?us-ascii?Q?gan6SeF9wdW4QZXfygcyBYbrqbyIAhxZ6BrjNKy1/301kTdula3k5+Ba2EJD?=
 =?us-ascii?Q?Ae8vuhhM1z6NOLTINf4EPP8nYxPRWdBM9aW2lchKbVTM2raJBoU6zHhkSRQS?=
 =?us-ascii?Q?lAF+NL9bmgcBc/MGKXqeXjZjR7wFlnCqN+4soDnUuWSSWqtWFngnzgT40XR0?=
 =?us-ascii?Q?LZBBF8Jzw90cbmYncTIEiKCPfCk2ZTNxABoMYFtKXKGlvzLAQQBK3kzz+0p6?=
 =?us-ascii?Q?VpKEtBSQW6d72QbZLGJOfOaD64T2+9UYMKDefRGzU+BADP594psieDyrij/z?=
 =?us-ascii?Q?jEDPMX2D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c295a2ae-d5f3-4154-5371-08d8c53cfad0
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 16:34:57.1500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcVAXoHMXE5YYiqYm23Cl1debRpc6bJQQ+FN4A7Pn9SwQ/6wiihKRq0pk6kAP1sT4xNJ2Dbt3w+9nw/TBSSC2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6065
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER,
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
X-List-Received-Date: Sat, 30 Jan 2021 16:35:02 -0000

This patch attempts to fix the problem reported here:

  https://cygwin.com/pipermail/cygwin/2020-September/246362.html

See also the followup here:

  https://cygwin.com/pipermail/cygwin/2021-January/247666.html

The problem, briefly, is that on certain recent versions of Windows
10, including 2004 but not 1909, native Windows AF_UNIX sockets are
represented by reparse points that Cygwin doesn't recognize.  As a
result, tools like 'ls' and 'rm' don't work.

I will get access to a machine running 2004 so I can test my patch,
but I'm posting it now in case someone else wants to test it before I
can.  To test it, compile and run the program native_unix_socket.c
appended below, and then try to remove the file foo.sock that it
creates.  This should fail on W10 2004 without my patch, but it should
succeed like this with the patch:

$ gcc -o native_unix_socket native_unix_socket.c -lws2_32

$ ./native_unix_socket.exe
getsockname works
fam = 1, len = 11
offsetof clen = 9
strlen = 8
name = foo.sock

$ ls -l foo.sock
-rwxr-xr-x 1 kbrown None 0 2021-01-30 10:46 foo.sock*

$ rm foo.sock

$ ls -l foo.sock
ls: cannot access 'foo.sock': No such file or directory

$ cat native_unix_socket.c
/* https://cygwin.com/pipermail/cygwin/2020-September/246362.html

   gcc -o native_unix_socket native_unix_socket.c -lws2_32

*/

#define WIN32_LEAN_AND_MEAN

#include <windows.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <stddef.h>
#include <stdio.h>
/* #include <afunix.h> */

#define WIN32_LEAN_AND_MEAN

#define UNIX_PATH_MAX 108

typedef struct sockaddr_un
{
     ADDRESS_FAMILY sun_family;     /* AF_UNIX */
     char sun_path[UNIX_PATH_MAX];  /* pathname */
} SOCKADDR_UN, *PSOCKADDR_UN;

int __cdecl main(int argc, char *argv[])
{
    WSADATA wsadata;
    struct sockaddr_un addr;
    socklen_t len;
    int z = AF_UNIX;
    SOCKET s, s0;

    if (WSAStartup(MAKEWORD(2,2), &wsadata) != 0) {
        printf("STartup failed\n");
        return 0;
    }
    s0 = socket(AF_UNIX, SOCK_STREAM, 0);
    memset(&addr, 0, sizeof(addr));

    addr.sun_family = AF_UNIX;
    //strcpy(addr.sun_path, argv[1]);
    strcpy(addr.sun_path, "foo.sock");

    z = bind(s0, (const struct sockaddr *) &addr, strlen(addr.sun_path) + sizeof (addr.sun_family));
    if (z != 0) {
        printf("bind failed %ld\n", WSAGetLastError());
    }
    len = sizeof(addr);
    z = getsockname(s0, (struct sockaddr *)&addr, &len);
    if (z != 0) {
        printf("getsockname failed %ld\n", WSAGetLastError());
    } else {
        printf("getsockname works\n");
        printf("fam = %d, len = %d\n", addr.sun_family, len);
        int clen = len - offsetof(struct sockaddr_un, sun_path);
        printf("offsetof clen = %d\n", clen);
        printf("strlen = %zd\n", strlen(addr.sun_path));
        printf("name = %s\n", addr.sun_path);
    }
}

Ken Brown (1):
  Cygwin: recognize native Windows AF_UNIX sockets as reparse points

 winsup/cygwin/path.cc | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.30.0


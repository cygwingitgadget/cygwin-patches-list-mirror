Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2135.outbound.protection.outlook.com [40.107.93.135])
 by sourceware.org (Postfix) with ESMTPS id 60F0C385EC4E
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 18:43:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 60F0C385EC4E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJhdsfJMJ25WHIJxJ1PQP6cfODrjA9tH953O6PT3jHleLbF78Zui2ki/oxmZUmY7JM66fIg49r3MxzFbmgJgADar+5fnQ9wbX6cGVwmnfj4kwhVuQChcCLSbvW8wyx5fiNqqyGPwWIqf4eU7LLcu+OaF4qB+JYvRoiqobXcBlEcCtiIWwTwkWkRfgOV2D7dxj5oDm6Aakm6+Yk9Ps7qYWvioGONGFCWfCx+4E0JNPZWzB1F4nPf6nXbQr+LzXLrwvxD9x8bsogE7zt6j/IjypAWIPs/OCTeOVvG+4lrXiceabpeECkYa40ECvEoW5rDvU4Db8Q3D0FEbf3AEM4IShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwGyek7C28RhBqf03WzlU2YQzH1igoIvvgE9S1joxMw=;
 b=clwcOsWyEl44WPK56Obh0L175q9SmFvUmWCi7sWcorREnv5LkfoqHh2e7RUuBwBpA8GjJ0VUmLpVyS05HhiUqc8IvOtDaAUcA8Wjmr9SCP0WYTshAN3CeqnfY3DueLzUtaSHj4A+JvrZD4/M4NcZcJ4octhTGfWR+TGjL/rKqMq3SWZQF7fqgI0WxnHaXynCINF0Q43ShAMFLXGlXGmYv/wCQv/a51JAWh0aVg1ciwq8El+GVvJfI9x+bJkZ3lHxoO6yKTLWNAAmD7v3sKy/owhx/kKieK5waBr7xoM7tQOaXvfvR4Hvre5Og1a/Zh24WD2AI7BwVFC0Ak6sefCjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB6222.namprd04.prod.outlook.com (2603:10b6:208:d8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 18:43:11 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 18:43:11 +0000
Subject: Re: [PATCH 0/1] Fix MSG_WAITALL support
To: cygwin-patches@cygwin.com
References: <20201012180213.21748-1-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <d582c3d6-bd0c-f2c7-9fbc-38edb3511cdf@cornell.edu>
Date: Mon, 12 Oct 2020 14:43:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201012180213.21748-1-kbrown@cornell.edu>
Content-Type: multipart/mixed; boundary="------------F3120134E8EEECA6087CEB7F"
Content-Language: en-US
X-Originating-IP: [2604:6000:b407:7f00:946b:663a:1a3:dfd2]
X-ClientProxiedBy: MN2PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:208:23d::16) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2604:6000:b407:7f00:946b:663a:1a3:dfd2]
 (2604:6000:b407:7f00:946b:663a:1a3:dfd2) by
 MN2PR06CA0011.namprd06.prod.outlook.com (2603:10b6:208:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Mon, 12 Oct 2020 18:43:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf7eb897-09e4-41d4-31d5-08d86edeab63
X-MS-TrafficTypeDiagnostic: MN2PR04MB6222:
X-Microsoft-Antispam-PRVS: <MN2PR04MB622222E2E8078385E2736FF2D8070@MN2PR04MB6222.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyVgQXaP9bOAO1wknzylMm+2cqik0JMXUIFV0AHzLjC+Ljj4jB90EkdMqkbYuqXPxnFFuwrbQsp0DhexcrMrmK61US21beIEgNHzAY8VQCYR/GFUf4cnxEnrXGOf59bd791d2sVjSGxuR9uuZjeZV4wW7SCfYbvi8aE80VnMo5MslT6D6rFtJCNaLzf5DeBm7g7k1V4GyTFcR0c5qjrTAFxywhFCXkk1t7PjH7reSXE1H2wMUYVOUlWgDEEiQEMqxZ4jQnu5fgKXt6Hyc5eimS0WLDaicg8ZyVgeMRF/JcEM97pRay6XF2rzW4CNcIlb5AcUmo6RnxTEmJXY5hVNboqlEXGhWFhl3d8mJKorMnsj0FUSVsh0KZmIoyfxXPWj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(8936002)(33964004)(6486002)(75432002)(86362001)(36756003)(31686004)(83380400001)(5660300002)(31696002)(52116002)(478600001)(2906002)(6916009)(16526019)(786003)(186003)(235185007)(316002)(8676002)(53546011)(66946007)(66576008)(66556008)(66476007)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HQMVvV8Xcg0S7n219KVnaN2GyoSTZ27Rk7vD7++tXZoeGBWjIkejwRmPztxMWWZX7v3UU1K1iohaJQNHlzbbZLSbhF2yIaCg8mEDR1UUGAgtiUaomrzLAc2J/ItyrxyQcLZqHanPfj3k7YSvgakiB3NMRjE6P6++mFOxq46bdk9HU1gs2S0EgiTwsKItphmpR1iYYOL26LsdSMlRiotgc2US2F4tsuATM8GqCTJDjs9R/f5zQKkTKuXdVhFefrsFAmjAU0IDY7N3Hm1JYRCOW2PpHm/31cpU5t1cJB22vMbAXbu653XOV4RUIKWo30NWEX1DtFmBbXMPvyrweLvA39NZZe4WphQsXivogjVQCgajvmQV8VeKEnOIbA4K1qFnUe4/riXA+0ecwkDpPKMVfo8VDj/9Y74JnKORgw5sw6tAEfuMDqrA3IFNCUxtd1lTuWkP61E68Sp4Q5ihDWlBf1d0OQYzuh/ToY8FDDIUnnOuXYqIltVkt+AlZKLZyuYsyBr817zuvZRmptyvsO6aSnUiX471eE1iZnK30a+wu0RKPydBCY9tyTGd8JZa7Ow1H5tqk+nJerdCHVEz0za9WHx+G/wVuDekMybHUaud4Z2hdbodWq69yc2IiHo9waWo0PhzaX6a1QCke8orKZJsvEwm7RYNFrMyB6U5LLNT1p9ubqTfCOrOdOmuGoAJC2wrShBMDcG5S5Z01l33392RgA==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7eb897-09e4-41d4-31d5-08d86edeab63
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 18:43:11.2293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6yFbnKrpAmuw5x+FTi7F8koKwl4skqn+/yTDkxbQj4xL74Hv5KJMBinXXw2YQUxy/lwrGg55sYQLaUdyG7OxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6222
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 12 Oct 2020 18:43:14 -0000

--------------F3120134E8EEECA6087CEB7F
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/2020 2:02 PM, Ken Brown via Cygwin-patches wrote:
> It looks to me like there's been a bug in the MSG_WAITALL support for
> AF_INET and AF_LOCAL sockets ever since that support was first
> introduced 13 years ago in commit 023a2fa7.  If I'm right, MSG_WAITALL
> has never worked.
> 
> This patch fixes it.  I'll push it in a few days if no one sees
> anything wrong with it.
> 
> In a followup email I'll show how I tested it.

Attached are slight variants of the server/client programs from Section 57.2 of 
Kerrisk's book, "The Linux Programming Interface".  The only essential 
difference is that I've changed the server program to (a) use a small buffer 
(size 10 instead of 100) and (b) use 'recv' with the MSG_WAITALL flag instead of 
'read'.  The 'recv' call shouldn't return until it reads 10 bytes.

To test, run waitall_sv in one terminal and waitall_cl in a second.  Type 
something in the second terminal (followed by RET), and it should be echoed in 
the first.  But because of the MSG_WAITALL flag, the echoing shouldn't occur 
until 10 bytes have been written.  For example, if I type "abcd<RET>" in the 
second terminal and then do it again, I should see the following:

# Terminal 2:
$ ./waitall_cl
abcd
abcd

# Terminal 1:
$ ./waitall_sv
abcd
abcd

Here the echoing in Terminal 1 shouldn't occur until I've typed both "abcd" 
lines in Terminal 2.

[Note that there is a newline character after each "abcd", so "abcd<RET>" is 5 
bytes long, and the two lines together are 10 bytes long.]

Before I apply my patch, each line typed in Terminal 2 is immediately echoed in 
Terminal 1.  After I apply the patch, the echoing doesn't occur until I've typed 
both lines.

Ken

--------------F3120134E8EEECA6087CEB7F
Content-Type: text/plain; charset=UTF-8;
 name="waitall_sv.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="waitall_sv.c"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/un.h>
#include <sys/socket.h>

#define SV_SOCK_PATH "/tmp/waitall"

#define BUF_SIZE 10

#define BACKLOG 5

int
main ()
{
    struct sockaddr_un addr;
    int sfd, cfd;
    ssize_t nread;
    char buf[BUF_SIZE];

    if ((sfd = socket (AF_UNIX, SOCK_STREAM, 0)) < 0)
      {
	perror ("socket");
	exit (1);
      }
    if (remove (SV_SOCK_PATH) < 0 && errno != ENOENT)
      {
	perror ("remove");
        exit (1);
      }

    memset (&addr, 0, sizeof (struct sockaddr_un));
    addr.sun_family = AF_UNIX;
    strncpy (addr.sun_path, SV_SOCK_PATH, sizeof (addr.sun_path) - 1);

    if (bind (sfd, (struct sockaddr *) &addr, sizeof (struct sockaddr_un)) < 0)
      {
	perror ("bind");
	exit (1);
      }

    if (listen (sfd, BACKLOG) < 0)
      {
        perror ("listen");
	exit (1);
      }

    while (1)
      {
        cfd = accept (sfd, NULL, NULL);
        if (cfd < 0)
	  {
            perror ("accept");
	    exit (1);
	  }

        /* Transfer data from connected socket to stdout until EOF. */
        while ((nread = recv (cfd, buf, BUF_SIZE, MSG_WAITALL)) > 0)
	  if (write (STDOUT_FILENO, buf, nread) != nread)
	    {
	      perror ("partial/failed write");
	      exit (1);
	    }

        if (nread < 0)
	  {
            perror ("read");
	    exit (1);
	  }

        if (close (cfd) < 0)
	  {
            perror ("close");
	    exit (1);
	  }
      }
}

--------------F3120134E8EEECA6087CEB7F
Content-Type: text/plain; charset=UTF-8;
 name="waitall_cl.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="waitall_cl.c"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/un.h>
#include <sys/socket.h>

#define SV_SOCK_PATH "/tmp/waitall"

#define BUF_SIZE 100

int
main ()
{
    struct sockaddr_un addr;
    int sfd;
    ssize_t nread;
    char buf[BUF_SIZE];

    if ((sfd = socket (AF_UNIX, SOCK_STREAM, 0)) < 0)
      {
	perror ("socket");
	exit (1);
      }

    memset (&addr, 0, sizeof(struct sockaddr_un));
    addr.sun_family = AF_UNIX;
    strncpy (addr.sun_path, SV_SOCK_PATH, sizeof(addr.sun_path) - 1);

    if (connect (sfd, (struct sockaddr *) &addr,
		sizeof (struct sockaddr_un)) < 0)
      {
        perror ("connect");
	exit (1);
      }

    /* Copy stdin to socket. */
    while ((nread = read (STDIN_FILENO, buf, BUF_SIZE)) > 0)
      if (write (sfd, buf, nread) != nread)
	{
	  perror ("partial/failed write");
	  exit (1);
	}

    if (nread < 0)
      {
        perror ("read");
	exit (1);
      }
}

--------------F3120134E8EEECA6087CEB7F--

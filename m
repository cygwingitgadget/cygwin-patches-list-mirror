Return-Path: <cygwin-patches-return-9992-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108216 invoked by alias); 23 Jan 2020 16:31:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108196 invoked by uid 89); 23 Jan 2020 16:31:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-11.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM12-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam12on2109.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) (40.107.237.109) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 16:31:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=ERtLvRQhAgYgCrkdUcRk3i7VEMyjCaDki5M00i12zGP3+p1CzxieBJgfaUd6pVDLmEuPl3/IpMeNUW4Pt6OlGnk3/g6lpSOi9TqT80+U6mrU2lw0qynWvwbWw+LSF/qKKHZX+YnpaWenMoeXF0Wmm52gApZCa1delHdoPN0kls+1grXvQXcBUTuO77fgxL5U2MqdsyXCzUwvbCgvyQ5laOyHSfs60L/IIu0t6DrFk4tBsSBBhJdJYkQCcKcaLd/6GM7zTcO7v2XgkGp/vAZiUGVsv3lAw36IpwEAQyEA8PDY0ghmstbjSB7sI/o6HOGtHfpuZXSa+vy/Vx/QozCjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QLoF6Z66tPlN3LcYYvvMCuH7sF6f2Zx7FBlXTYQrtw0=; b=gAYrzPZBQwEloIkCkMmUmFm7zXH8+GZrYPN6mIymvR6pJURgepHz/ebKw8elWXjvPBfxZEp+tS1Fkkek172ZMro7RJ+7NPFED1Zmu50nQ4a3l2yWiTyTla3a3YHonE6FdXoZczMSzmrIDhCQdH/HRCuVGLfaecz4sH7N3AKwnM9pVeQzJGwzN8+FkFdNllH0/rt6CQa5BvB5wX+K7tg9cDEeJaPMTzLAJPkiNSe5YMB8JpSG0IzGeK6puGLZ8FXhMEfG9GV581/WNF48a6crZ5KCB8oTv4XtWEbCxmebhv6ADrSbtG9Jnl6ruWyvsujCSfnUuBIOC7uVeDekpIcsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QLoF6Z66tPlN3LcYYvvMCuH7sF6f2Zx7FBlXTYQrtw0=; b=EQDbFtz3Rkp6HevYMkuUr50J4+vmxoeri5+ihJ6TbO9yEXtFydQuQh7U4pDmI1nB/BZuLga42uYvLV5xFzu7H8IRLHfRHkLnGuKK9ic/SShtscU0/Ncaa7qq+GzaoOzw0i7+CxBwotN9mhK/bTYuPHyZH/2GRPvEc+terjEREVc=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6393.namprd04.prod.outlook.com (10.141.162.145) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Thu, 23 Jan 2020 16:31:03 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020 16:31:03 +0000
Received: from localhost.localdomain (23.31.190.121) by CH2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:610:51::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Thu, 23 Jan 2020 16:31:02 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 0/3] Fix the O_PATH support for FIFOs
Date: Thu, 23 Jan 2020 16:31:00 -0000
Message-ID: <20200123163015.12354-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:10000;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: oT9wcclKaPtv4Vadk8NvYjTyNK6LRPVHZ0IjVmlYddFYeeReLdN9LlWcr93RV3Gf1eCYA4X4CLe6wtb8CC6qlh4jnIfJdrWWO9AGgnwhazb+gbXUaUQ65yXf+7Ael33bOYdLyIqe85eJ6HPl6IzU6A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRtwyIe41dABzSwnG43NAqIu+63vTnIXZ8a/rOJN38z/r9iTHLSz8bHl/PqndKMQwGbqPZLE9tHMVXKaiigJvg==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00098.txt

Commit aa55d22c, "Cygwin: honor the O_PATH flag when opening a FIFO",
fixed a hang but otherwise didn't accomplish the purpose of the O_PATH
flag as stated in the Linux man page for open(2):

    Obtain a file descriptor that can be used for two purposes: to
    indicate a location in the filesystem tree and to perform
    operations that act purely at the file descriptor level.  The
    file itself is not opened, and other file operations (e.g.,
    read(2), write(2), fchmod(2), fchown(2), fgetxattr(2),
    ioctl(2), mmap(2)) fail with the error EBADF.

    [The man page goes on to describe operations that *can* be
    performed: close(2), fchdir(2), fstat(2),....]

    Opening a file or directory with the O_PATH flag requires no
    permissions on the object itself (but does require execute
    permission on the directories in the path prefix).

The first problem in the current implementation is that if open(2) is
called on a FIFO, fhandler_base::device_access_denied is called and
tries to open the FIFO with read access, which isn't supposed to be
required.  This is fixed by the first patch in this series.

The second patch makes fhandler_fifo::open call fhandler_base::open_fs
if O_PATH is set, so that we actually obtain a handle that can be used
for the purposes stated above.

The third page tweaks fhandler_fifo::fcntl and fhandler_fifo::dup so
that they work with O_PATH.

In a followup email I'll provide the program I used to test this
implementation.

Ken Brown (3):
  Cygwin: device_access_denied: return false if O_PATH is set
  Cygwin: re-implement fhandler_fifo::open with O_PATH
  Cygwin: FIFO: tweak fcntl and dup when O_PATH is set

 winsup/cygwin/fhandler.cc      |  3 +++
 winsup/cygwin/fhandler_fifo.cc | 15 ++++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

--=20
2.21.0

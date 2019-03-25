Return-Path: <cygwin-patches-return-9233-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80995 invoked by alias); 25 Mar 2019 23:06:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80969 invoked by uid 89); 25 Mar 2019 23:06:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1309
X-HELO: NAM05-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr720104.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) (40.107.72.104) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 25 Mar 2019 23:06:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=9ll7UVX32BPJmK6xJ6eGMcZC59PSINoubefIsmOudC0=; b=Q1P3b0ZQGPRcR5ehR23X4zLJhzE98u15lY/IHHoDGx45Ki9VVLPfiMyq89mm5O3BLxlawjXqwPMZTgZGhAM88dKlDvuMHDukmjXGb/TS/3zu0ugj+c4lHHT13sJOZUrOiunnN/Ir3/ajHTwB+vYgyoHc7nWQORLLw4enclkzR9s=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4649.namprd04.prod.outlook.com (20.176.105.214) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.19; Mon, 25 Mar 2019 23:06:08 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019 23:06:08 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 0/2] Add support for duplex FIFOs
Date: Mon, 25 Mar 2019 23:06:00 -0000
Message-ID: <20190325230556.2219-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00043.txt.bz2

The second patch in this series enables opening a FIFO with O_RDWR
access.  The underlying Windows named pipe is creted with duplex
access, and its handle is made the I/O handle of the first client.

While testing this, I had some mysterious crashes, which are fixed by
the first patch.

I tested the patch in two ways.

First, I went back to Kerrisk's server/client programs cited in
https://cygwin.com/ml/cygwin/2015-03/msg00047.html.  The server
program opens a FIFO twice, once with O_RDONLY access and once with
O_WRONLY access.  The fd from the second call is never used; the
purpose of that call is simply to make sure that attempts to read from
the FIFO will never indicate EOF.  I removed the second call and
instead opened the FIFO only once, with O_RDWR access.  The
server/client programs still worked as expected.

The second test was the following sequence of commands in a bash
shell:

$ mkfifo foo

$ exec 7<>foo

$ echo blah > foo

$ read bar <&7

$ echo $bar
blah

Ken

Ken Brown (2):
  Cygwin: FIFO: avoid crashes when cloning a client
  Cygwin: FIFO: add support for the duplex case

 winsup/cygwin/fhandler.h       |  7 ++-
 winsup/cygwin/fhandler_fifo.cc | 79 +++++++++++++++++++++++++++++-----
 2 files changed, 74 insertions(+), 12 deletions(-)

--=20
2.17.0

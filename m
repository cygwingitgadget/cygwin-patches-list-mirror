Return-Path: <cygwin-patches-return-9204-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112423 invoked by alias); 22 Mar 2019 19:30:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112394 invoked by uid 89); 22 Mar 2019 19:30:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*MI:edu, detection
X-HELO: NAM01-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr810099.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) (40.107.81.99) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Mar 2019 19:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=O+UU7teXWbO+AL+ffffMCoF5ectyxX6syoHH8CqxlVU=; b=rUmwU7J7P5iaN9ccdm9hWvw2kBHjYHGp+hbyMddAgjXJZKck3kq2Fb7+2gKy2tGA96M2TchUVMNnude3BeixtfTYYX5vnZtl+ZkgPDUOrI4s6/QHuYtIShr+odGx9lP/rZBbQAxkP85rJZTK0oq0JkiWAdjrFHStMvCAEx1pMGg=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5243.namprd04.prod.outlook.com (20.178.25.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Fri, 22 Mar 2019 19:30:36 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019 19:30:36 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH fifo 0/8] Allow a FIFO to have multiple writers
Date: Fri, 22 Mar 2019 19:30:00 -0000
Message-ID: <20190322193020.565-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 2
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00014.txt.bz2

Currently a FIFO can have only one writer.  A second attempt to open
the FIFO for writing blocks while fhandler_fifo::open waits for the
read_ready event to be signalled.

This patch series tries to fix the problem by having the reader open
multiple instances of the Windows named pipe underlying the FIFO.
When the FIFO is opened for reading, a 'listen_client' thread is
created that listens for clients (writers) to connect to the pipe.  It
creates new pipe instances as needed.

fhandler_fifo::raw_read loops through the connected writers, checking
for input.

I've tested it by running the fifo client and server programs from
Chapter 44 of the book "The Linux Programming Interface: Linux and
UNIX System Programming Handbook" by Michael Kerrisk.  (See
https://cygwin.com/ml/cygwin/2015-03/msg00047.html for simplified
versions of these programs.)  These work as on Linux.

I've also tried the test given in
http://www.cygwin.org/ml/cygwin/2015-12/msg00311.html.  It works as on
Linux also.

TODO:

 - Try to get the code to work for duplexers (FIFOs opened for reading
   and writing).  I haven't thought about this at all yet.

 - Think about what it would take to allow multiple readers.  I'm not
   very optimistic about this, but my impression is that the
   multiple-writer case is more important in practice.

Ken

Ken Brown (8):
  Cygwin: FIFO: stop using overlapped I/O
  Cygwin: FIFO: allow multiple writers
  Cygwin: FIFO: add a spinlock
  Cygwin: FIFO: improve EOF detection
  Cygwin: FIFO: update clone and dup
  Cygwin: FIFO: update fixup_after_fork
  Cygwin: FIFO: update set_close_on_exec
  Cygwin: FIFO: update select

 winsup/cygwin/fhandler.h       |  58 ++-
 winsup/cygwin/fhandler_fifo.cc | 732 +++++++++++++++++++++++++++------
 winsup/cygwin/select.cc        | 161 +++++++-
 winsup/cygwin/select.h         |   7 +
 4 files changed, 819 insertions(+), 139 deletions(-)

--=20
2.17.0

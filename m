Return-Path: <HBBroeker@T-Online.de>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
 by server2.sourceware.org (Postfix) with ESMTPS id 54561394B016
 for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2020 20:41:41 +0000 (GMT)
Received: from fwd05.aul.t-online.de (fwd05.aul.t-online.de [172.20.27.149])
 by mailout08.t-online.de (Postfix) with SMTP id 10B864184ECB
 for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2020 21:41:40 +0100 (CET)
Received: from localhost.localdomain
 (bpFlaMZUrhSdlqeWz5Bj3EurcAzUdzdCK3Z8Dh1g5akE2Gf8GEtC1nSlPflgMI4wB8@[79.228.65.18])
 by fwd05.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jB2jp-2MDcNU0; Sun, 8 Mar 2020 21:41:29 +0100
From: Hans-Bernhard Broeker <HBBroeker@T-Online.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] wpbuf class-ification
Date: Sun,  8 Mar 2020 21:41:12 +0100
Message-Id: <cover.1583611115.git.HBBroeker@T-Online.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ID: bpFlaMZUrhSdlqeWz5Bj3EurcAzUdzdCK3Z8Dh1g5akE2Gf8GEtC1nSlPflgMI4wB8
X-TOI-MSGID: 2c979c83-f3b3-4154-953e-17f7b303eb98
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 GIT_PATCH_2, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_NONE,
 SPOOFED_FREEMAIL autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 08 Mar 2020 20:41:42 -0000

Second shot at wpbuf class-ification.  Also no longer
request data from WriteConsoleA that is not used for anything.

Hans-Bernhard Broeker (2):
  Collect handling of wpixput and wpbuf into a helper class.
  Do not bother passing optional argument to WriteConsoleA.

 winsup/cygwin/fhandler_console.cc | 164 ++++++++++++++++--------------
 1 file changed, 85 insertions(+), 79 deletions(-)

-- 
2.21.0


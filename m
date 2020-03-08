Return-Path: <HBBroeker@t-online.de>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
 by server2.sourceware.org (Postfix) with ESMTPS id 70761381DCE4
 for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2020 13:47:12 +0000 (GMT)
Received: from fwd24.aul.t-online.de (fwd24.aul.t-online.de [172.20.26.129])
 by mailout07.t-online.de (Postfix) with SMTP id 2629D42C6BFE
 for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2020 14:47:11 +0100 (CET)
Received: from [192.168.178.26]
 (r1lrKEZGohLeyUnOqHs4vtkOBcV41BXzENZuWhCYxqhpAAjSpqCnC5vsj72DG6tZaa@[79.228.65.18])
 by fwd24.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jAwGj-4KE6ls0; Sun, 8 Mar 2020 14:47:01 +0100
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Subject: [PATCH 0/2] wpbuf class-ification
To: cygwin-patches@cygwin.com
Message-ID: <5d37ba22-e042-4966-6d38-baa22023a9c3@t-online.de>
Date: Sun, 8 Mar 2020 14:47:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-ID: r1lrKEZGohLeyUnOqHs4vtkOBcV41BXzENZuWhCYxqhpAAjSpqCnC5vsj72DG6tZaa
X-TOI-MSGID: ca3c7d74-e758-4892-b433-696a1c53b7f5
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 GIT_PATCH_2, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Sun, 08 Mar 2020 13:47:13 -0000

Second shot at wpbuf class-ification.  Also no longer
request data from WriteConsoleA that is not used for anything.

Hans-Bernhard Broeker (2):
   Collect handling of wpixput and wpbuf into a helper class.
   Do not bother passing optional argument to WriteConsoleA.

  winsup/cygwin/fhandler_console.cc | 164 ++++++++++++++++--------------
  1 file changed, 85 insertions(+), 79 deletions(-)

-- 
2.21.0


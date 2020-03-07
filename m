Return-Path: <HBBroeker@t-online.de>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
 by server2.sourceware.org (Postfix) with ESMTPS id C52ED393FC33
 for <cygwin-patches@cygwin.com>; Sat,  7 Mar 2020 20:04:33 +0000 (GMT)
Received: from fwd17.aul.t-online.de (fwd17.aul.t-online.de [172.20.27.64])
 by mailout05.t-online.de (Postfix) with SMTP id 336B1420866D
 for <cygwin-patches@cygwin.com>; Sat,  7 Mar 2020 21:04:32 +0100 (CET)
Received: from [192.168.178.26]
 (SgrK7YZdrh-ZYQ0DBHEM1CBuDzLN5XufDSFjoo4A3T42FTstEezITRwjydJOtDXZ+3@[79.228.65.18])
 by fwd17.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jAfgV-07lUdU0; Sat, 7 Mar 2020 21:04:31 +0100
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Subject: [PATCH 0/2] wpbuf class-ification
To: cygwin-patches@cygwin.com
Message-ID: <5a6f115d-d6b4-22c8-1584-51b82db97639@t-online.de>
Date: Sat, 7 Mar 2020 21:04:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-ID: SgrK7YZdrh-ZYQ0DBHEM1CBuDzLN5XufDSFjoo4A3T42FTstEezITRwjydJOtDXZ+3
X-TOI-MSGID: 4f5c1536-6125-492f-a250-7bba1d5347cc
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_50, FREEMAIL_FROM,
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
X-List-Received-Date: Sat, 07 Mar 2020 20:04:34 -0000

Second shot at wpbuf class-ification.  Also no longer
request data from WriteConsoleA that is not used for anything.

Hans-Bernhard Broeker (2):
   Collect handling of wpixput and wpbuf into a helper class.
   Do not bother passing optional argument to WriteConsoleA.

  winsup/cygwin/fhandler_console.cc | 164 ++++++++++++++++--------------
  1 file changed, 85 insertions(+), 79 deletions(-)

-- 
2.21.0


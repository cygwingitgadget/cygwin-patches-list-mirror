Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id 06A183857C5C
 for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022 16:32:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 06A183857C5C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
 by cmsmtp with ESMTP
 id 7MMVnVK3S5Rf17gXan9C55; Wed, 12 Jan 2022 16:32:02 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id 7gXZnLRCFUcbn7gXZnBMgd; Wed, 12 Jan 2022 16:32:02 +0000
X-Authority-Analysis: v=2.4 cv=OO00YAWB c=1 sm=1 tr=0 ts=61df0282
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=8VpDeP3kAAAA:8 a=IhITR0H2Is7bWmWTaesA:9
 a=QEXdDO2ut3YA:10 a=uar3UI-X7uIA:10 a=-E0vlWde17EA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=x58pXJj3Pl9T3GLWE5Uy:22
Message-ID: <23658f98-9edb-6119-a0d8-81cf58fe9d70@SystematicSw.ab.ca>
Date: Wed, 12 Jan 2022 09:32:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux 5.16
 Gobble Gobble flags
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20220112060431.7956-1-Brian.Inglis@SystematicSW.ab.ca>
 <Yd6q2CARZ3qNyo8H@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <Yd6q2CARZ3qNyo8H@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAgWmBNLpu3F8x9XZxESF5Kni7olmnRWHozckuRcBARi0fzqhBlRoaZ1ZKXZcUBL2xed4ylWmMEGiFxu4PUtJEPLgLy/UdlNvcNsZDhAT2gVNOMDVonG
 CXWiCvBSu928LhJDozWWM94DGatPXDyHxCNlCmiAud52FtvgJ8ROL7cZY2de77hjFw0jfbZZ0LnFzWCFRytHf6qVvtlpjR5YkLE=
X-Spam-Status: No, score=-1160.7 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 12 Jan 2022 16:32:04 -0000

On 2022-01-12 03:18, Corinna Vinschen wrote:
> On Jan 11 23:04, Brian Inglis wrote:
>> Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux 5.16 Gobble Gobble flags
> 
> Gobble Gobble?
> 
> Did I miss something or is that a preliminary subject line? :)

Linux 5.16 codename from rc3 which came out about US Thanksgiving; see 
bottom of thread:

https://lkml.kernel.org/lkml/163789349650.12632.8523698126811716771.pr-tracker-bot@kernel.org/t/#u

noticed:

https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.16-rc3

from scripts monitoring cpuid usage and cpuinfo changes across releases:

diff -pu linux-prev/Makefile linux-next/Makefile
--- linux-prev/Makefile	2021-10-31 14:53:10.000000000 -0600
+++ linux-next/Makefile	2022-01-11 07:45:05.000000000 -0700
@@ -1,9 +1,9 @@
  # SPDX-License-Identifier: GPL-2.0
  VERSION = 5
-PATCHLEVEL = 15
+PATCHLEVEL = 16
  SUBLEVEL = 0
  EXTRAVERSION =
-NAME = Trick or Treat
+NAME = Gobble Gobble
...

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]

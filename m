Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id DBD833954459
 for <cygwin-patches@cygwin.com>; Tue, 10 May 2022 14:44:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DBD833954459
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id o7R8nYcd0wtwGoR6Unl7P7; Tue, 10 May 2022 14:44:46 +0000
Received: from BWINGLISD.cg.shawcable.net. ([184.64.124.72])
 by cmsmtp with ESMTP
 id oR6VnVxitCg6joR6VngMYN; Tue, 10 May 2022 14:44:47 +0000
X-Authority-Analysis: v=2.4 cv=SMhR6cjH c=1 sm=1 tr=0 ts=627a7a5f
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=S4A3tALdysjMuqH8DHUA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH 0/1] fhandler_process.cc(format_process_stat): fix
 /proc/pid/stat issues
Date: Tue, 10 May 2022 08:44:41 -0600
Message-Id: <20220510144443.5555-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNgkGL3v1tBF26SancC811suKjw0h0KdWn64AK+uapH6U9V0GeH/1jJ5kE8i7WyJtPqLWNOuxHkoUjilqa3xqZJi4XrHsmOVrJKaW94r1NYhcTRADSIl
 Z5pHXOOLdN3WcLpaEnIFmC/qW6sfDEiNixs/a5e7fvRPqUqg9UhBb5YtWvaeDyyMytgXBYug5VBUFpB8IK/GUpg9IVl8h8R6fgLGOLkfrPHxZkRCt3Yyp6GQ
 7cDM1+jsWyuOUKwxbyubAIQRMi+gErsosVuBSy62rQo=
X-Spam-Status: No, score=-1164.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 10 May 2022 14:44:50 -0000

Noticed some issues with x86 32 bit procps and checked /proc/pid/stat which
looked misaligned compared to x86_64 64 bit, due to int64_t format mismatches.
There were also issues with the tty_nr encoding (uses ctty which has major in
top 16 bits and minor in bottom 16 bits, where tty_nr is specified to have
major in bits 15:8 and minor across 31:20 and 7:0) and rsslim units in bytes
not pages.
This patch fixes those issues.
Below are the old and new /proc/pid/stat values and decoded listings for 32
bit; only tty_nr and rsslim values changed in 64 bit; tty_nr listing decoding
was also changed after.

==> proc-pid-stat-old-32.log <==
1025 (bash) S 1024 1025 1025 8912896 -1 0 147513 147513 0 0 49546 0 45000 49546 45000 0 20 0 0 4115675647 0 7397376

==> proc-pid-stat-new-32.log <==
27991 (bash) S 1 27991 1025 34816 -1 0 9662 9662 0 0 312 562 312 562 20 0 0 0 5113740411 7241728 2901 1413120

==> proc-pid-stat-list-old-32.log <==
CLK_TCK 1000 PAGE_SIZE 65536 boot time 5110786.43
 1 pid                1025 process
 2 comm             (bash) executable
 3 state                 S ?
 4 ppid               1024 parent
 5 pgrp               1025 group
 6 session            1025 id
 7 tty_nr         136    0 15:8,31:20,7:0
 8 tpgid                -1 group
 9 flags                 0 sys
10 minflt           147425 minor
11 cminflt          147425 minorchild
12 majflt                0 major
13 cmajflt               0 majorchild
14 utime            49.546 user
15 stime             0.000 sys
16 cutime           44.984 userchild
17 cstime           49.546 syschild
18 priority          44984 0..39->-20..19
19 nice                  0 -20..19
20 num_threads          20 threads
21 itrealvalue           0 timer
22 starttime   59 3:39:46.430 start
23 vsize        4115675647 memory
24 rss                   0 pages
25 rsslim          7397376 limit

==> proc-pid-stat-list-new-32.log <==
CLK_TCK 1000 PAGE_SIZE 65536 boot time 5114365.42
 1 pid               27991 process
 2 comm             (bash) executable
 3 state                 S ?
 4 ppid                  1 parent
 5 pgrp              27991 group
 6 session            1025 id
 7 tty_nr         136    0 15:8,31:20,7:0
 8 tpgid                -1 group
 9 flags                 0 sys
10 minflt             9662 minor
11 cminflt            9662 minorchild
12 majflt                0 major
13 cmajflt               0 majorchild
14 utime             0.312 user
15 stime             0.562 sys
16 cutime            0.312 userchild
17 cstime            0.562 syschild
18 priority             20 0..39->-20..19
19 nice                  0 -20..19
20 num_threads           0 threads
21 itrealvalue           0 timer
22 starttime     10:25.009 start
23 vsize           7241728 memory
24 rss                2901 pages
25 rsslim          1413120 limit

Brian Inglis (1):
  fhandler_process.cc(format_process_stat): fix /proc/pid/stat issues

 winsup/cygwin/fhandler_process.cc | 33 +++++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)

-- 
2.36.0


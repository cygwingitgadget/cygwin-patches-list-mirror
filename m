Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id CB1A33858C74;
	Wed, 14 Sep 2022 02:52:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CB1A33858C74
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id Y9pNog2TpS8WrYIW0oHs36; Wed, 14 Sep 2022 02:52:40 +0000
Received: from BWINGLISD.cg.shawcable.net. ([184.64.124.72])
	by cmsmtp with ESMTP
	id YIW0o9xvGUAunYIW0omFTO; Wed, 14 Sep 2022 02:52:40 +0000
X-Authority-Analysis: v=2.4 cv=JLIoDuGb c=1 sm=1 tr=0 ts=632141f8
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=9pJ1AMZdf05kdrFBZ94A:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>,
	Cygwin Patches <Cygwin-Patches@Cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH 0/3] strftime, strptime: add %i, %q, %v, tests; tweak %Z docs
Date: Tue, 13 Sep 2022 20:52:33 -0600
Message-Id: <20220914025236.54080-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBAyPTQv5lqa24Oc5CuyJ2/B2EXd1o0bJTxOYFH0E7G6LI3j7MtR3snWmg6WllCEojMV61YlRpX5jDLabEP5VekqqlBTs/j8zxNfOWs71SabGb34AHn5
 tbnwdF+G8ukuRJRdsMr30EsTpRAaE3pRCM3kcDvmQYBxzDZDGSuXA9tNxcqtwNi2qr3gNW0cmm9sCYhTnVVxzjwAoxT/dpK/LSSs3Vnfaa+LngT7Ea1MibsK
 oXLSvU8YC85yYBzWiBQzBhI5USFUOi83Di/8aVYB/LnhAU4XIxjr8izp9ZrhRSa0JYEMP8bDCvaVmeMLF7Zwdw==
X-Spam-Status: No, score=-1163.8 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

[Please Reply All due to email issues]

newlib/libc/time/strftime.c(strftime): add %i, %q, %v, tests; tweak %Z docs
newlib/libc/time/strptime.c(strptime_l): add %i, %q, %v
winsup/cygwin/libc/strptime.cc(__strptime): add %i, %q, %v

%i year in century [00..99] Synonym for "%y". Non-POSIX extension. [tm_year]
%q GNU quarter of the year (from `<<1>>' to `<<4>>') [tm_mon]
%v OSX/Ruby VMS/Oracle date "%d-%b-%Y". Non-POSIX extension. [tm_mday, tm_mon, tm_year]
add %i %q %v tests
%Z clarify current time zone *abbreviation* not "name" [tm_isdst]

Brian Inglis (3):
  strftime.c(__strftime): add %i, %q, %v, tests; tweak %Z docs
  strptime.c(strptime_l): add %i, %q, %v
  strptime.cc(__strptime): add %i, %q, %v

 newlib/libc/time/strftime.c    | 67 ++++++++++++++++++++++++++++++++--
 newlib/libc/time/strptime.c    | 18 ++++++++-
 winsup/cygwin/libc/strptime.cc | 19 +++++++++-
 3 files changed, 99 insertions(+), 5 deletions(-)

-- 
2.37.2


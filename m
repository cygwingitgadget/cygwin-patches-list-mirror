Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A14B84CCCA25; Fri,  5 Dec 2025 19:42:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A14B84CCCA25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764963722;
	bh=PvfU3+j4qvfsbwUKcXjahtnIWR7nMyvqXwVgPLz3fyM=;
	h=From:To:Cc:Subject:Date:From;
	b=hIm6QRHdq+RdLDt46Dyw3bBXbRr3y1N3fUnqkR8ct0/L04tpSnIIXIxXFPZH2ETN+
	 QjGSODuFbicoWmh/xiYjbElqkseWXy+P4MxavnNWPdf/ZQAWKIj5joDetaJAI3zYoz
	 fE/dNz1DKv4JSHrfnI9HV1JWY2s4QsCIlvEU1jik=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C47EAA80CAF; Fri, 05 Dec 2025 20:42:00 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Marco Atzeri <marco.atzeri@gmail.com>
Subject: [PATCH 0/3] Cygwin: newgrp(1): fix POSIX compatibility
Date: Fri,  5 Dec 2025 20:41:57 +0100
Message-ID: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

As outlined in the thread starting at
https://cygwin.com/pipermail/cygwin/2025-December/259055.html,
newgrp(1) didn't allow numerical group IDs.  While this is in line with
the shadow-utils version of newgrp(1), it's not what POSIX allows.
Fix up the code and the documentation to be more in line with POSIX.

Corinna Vinschen (3):
  Cygwin: newgrp(1): improve POSIX compatibility
  Cygwin: doc: utils.xml: improve newgrp(1) documentation
  Cygwin: add release note for newgrp(1) fixes

 winsup/cygwin/release/3.6.6 |  3 +++
 winsup/doc/utils.xml        | 24 +++++++++++++-----------
 winsup/utils/newgrp.c       | 28 ++++++++++++++++++----------
 3 files changed, 34 insertions(+), 21 deletions(-)

-- 
2.51.1


Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C9D6A4BA2E20; Wed, 10 Dec 2025 17:32:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C9D6A4BA2E20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765387923;
	bh=oVxrp8yQM++sXK56yuCEy0eb46LGHj1RCxOnjhO8u+k=;
	h=From:To:Subject:Date:From;
	b=i7VY/Yssuag2Yn+tWz3kI7QMmR8qIhsa48qbvG4DqfrBQ5GGAKrM7vYS/leXXWDA7
	 Q34vBtWbZSZbvShho8qZBnheFO0FUhEEn0LHpI6VF8ofvEoN7hmJ4RF6tOnf/Wfd5i
	 S9LDzWjGx1zqBxmwUQr+daem8z/vWmzK0FR3hSDU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B8711A80D1A; Wed, 10 Dec 2025 18:32:01 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/3] Cygwin: newgrp(1): fix POSIX compatibility
Date: Wed, 10 Dec 2025 18:31:58 +0100
Message-ID: <20251210173201.193740-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
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
 winsup/doc/utils.xml        | 27 ++++++++++++++++-----------
 winsup/utils/newgrp.c       | 30 ++++++++++++++++++++----------
 3 files changed, 39 insertions(+), 21 deletions(-)

-- 
2.52.0


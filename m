Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D7FFB3857709; Tue, 18 Nov 2025 12:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D7FFB3857709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763469637;
	bh=h4AYfwe2oo6pM19GhwG0LRXKXci23AJuIMjjwomL8j0=;
	h=From:To:Subject:Date:From;
	b=FdNSPI0xkNaMVKY8Lw8YDi9MwguZjrLIiZbe/YRr/0s1ECMOr0Y26FsFmIRm+kf+A
	 6Mn8ZRC2iLdzj98J3NTnSn4ym+kIx8tAfefHwubFn+quj9OVYbifBeEPcRSfM/50aN
	 2sQRetv/j9o5nzYuEse6cUIMVk275rN/d2QE8/Xc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A9CCFA80CFD; Tue, 18 Nov 2025 13:40:34 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] Simplify creating invisible console
Date: Tue, 18 Nov 2025 13:40:32 +0100
Message-ID: <20251118124034.1097179-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Starting with Windows 11 24H2, the new function AllocConsoleWithOptions()
introduces what we're desperately missing since Windows 95: a simple
call to create an invisible console.

Reintroduce the old fhandler_console::create_invisible_console method we
have been using once up to Windows Vista, and use it now to call
AllocConsoleWithOptions() on systems supporting this shiny new function.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>

Corinna Vinschen (2):
  Cygwin: wincap: add wincap entry for Windows 11 24H2
  Cygwin: console: (re-)introduce simple creation of invisible console

 winsup/cygwin/autoload.cc               |  1 +
 winsup/cygwin/fhandler/console.cc       | 21 ++++++++++++--
 winsup/cygwin/local_includes/fhandler.h |  1 +
 winsup/cygwin/local_includes/wincap.h   |  2 ++
 winsup/cygwin/wincap.cc                 | 37 ++++++++++++++++++++++++-
 5 files changed, 58 insertions(+), 4 deletions(-)

-- 
2.51.1


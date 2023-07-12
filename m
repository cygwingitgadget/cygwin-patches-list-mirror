Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 591C03858C62; Wed, 12 Jul 2023 12:08:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 591C03858C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689163686;
	bh=GpK94OnJrvhuzJ+YUVe1mQFpculzerybNrt0P35YwLc=;
	h=From:To:Cc:Subject:Date:From;
	b=G5hkz3p4D7bhz91WFt/+7BCKZOKbxS2Z39mPVQk0yPn/Kv0pzpyaP99DjABmzgCwz
	 Z7MR/D7tiTsnELrS1jIyK9AV7kBG429j3vIa4ApejLyHSLeugROVBuMiZ7h9BpEZLc
	 emu/R+xA9sUtCd446UKJF//4yXUW5hsnmfpiJaF0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 92EA6A80CDB; Wed, 12 Jul 2023 14:08:04 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/5] Fix AT_EMPTY_PATH handling
Date: Wed, 12 Jul 2023 14:07:59 +0200
Message-Id: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

The GLIBC extension AT_EMPTY_PATH allows the functions fchownat
and fstatat to operate on dirfd alone, if the given pathname is an
empty string.  This also allows to operate on any file type, not
only directories.

Commit fa84aa4dd2fb4 broke this.  It only allows dirfd to be a
directory in calls to these two functions.

Fix that by handling AT_EMPTY_PATH right in gen_full_path_at.
A valid dirfd and an empty pathname is now a valid combination
and, noticably, this returns a valid path in path_ret.  That
in turn allows to remove the additional path generation code
from the callers.

Fixes: fa84aa4dd2fb ("Cygwin: fix errno values set by readlinkat")
Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>

Corinna Vinschen (5):
  Cygwin: gen_full_path_at: drop never reached code
  Define _AT_NULL_PATHNAME_ALLOWED
  Cygwin: use new _AT_NULL_PATHNAME_ALLOWED flag
  Cygwin: Fix and streamline AT_EMPTY_PATH handling
  Cygwin: add AT_EMPTY_PATH fix to release message

 newlib/libc/include/sys/_default_fcntl.h | 11 +++--
 winsup/cygwin/release/3.4.8              |  4 ++
 winsup/cygwin/syscalls.cc                | 61 ++++++------------------
 3 files changed, 25 insertions(+), 51 deletions(-)

-- 
2.40.1


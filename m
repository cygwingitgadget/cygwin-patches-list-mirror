Return-Path: <cygwin-patches-return-8852-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125725 invoked by alias); 13 Sep 2017 15:44:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125706 invoked by uid 89); 13 Sep 2017 15:44:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-27.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=D*qq.com, H*Ad:D*qq.com, HTo:U*cygwin-patches
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.19) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Sep 2017 15:44:46 +0000
Received: from virtualbox ([37.201.203.107]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNqfr-1dlp7a1jEB-007QQv; Wed, 13 Sep 2017 17:44:33 +0200
Date: Thu, 14 Sep 2017 13:44:00 -0000
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
cc: Sichen Zhao <1473996754@qq.com>
Subject: [PATCH] Fix possible segmentation fault in strnstr() on 64-bit systems
Message-ID: <54549d65d520d71e1d3038f2e8a1c2f8c0f1f70a.1505317436.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:AM2+YwEI/WI=:tbNIxm9ajdsfM3VEkL5ONp 1bhzl3F8CHnRhmq+rla24cyzxZOhICB2zeWOYMmaYvYcPIjyP7RqLkSdvDWPugvIH9hZtYqx6 u0bF7CYagJEfjSSxE2V2GvvBX0cQqrWeIKCIGf/1bD2A33A3gM6TbH//qbRDwTR8qXXEUbZU6 7jTKomHVN2175IhHI0dY+55rxIK6b0VimTcCMe99msAAkeoliG+Lr0Jokix1TyL4PKZkTxhA1 b3Gm3YKA7vpj5PdXBXTYlu1chAlc9fbX0+zYmOliNvaoAKudusrb/+Szr1oNIBslmogcKxaeh 4u7IePinRhTJlBI4AnefYgI/0obnrqPoyC+CraL6iarAx3aJKN3RpUZ/EXJJZgAJ/AS69JjTO PrYvS7FiVMMNW8kjsMubl25oySl62Q1l0PWIWKIAPsKttWAGfGcs3sx4bIF/1Nug2hWg91nIH 1BebHvva0YUq4VTKj5wG14WjWLxAMpNEira+5+js2OL2UPaTlss6AcqLadhZI0IMo/8D3ZnO4 lEI/+FZCnpQBDrJgV6GjJPGXmUKK0CoHcSngnnyTLP69j07eTufZKphAqjj5tGzr1oUyyavc1 vUMtHZa9VpM90w6+YLE7tLFQHlin0dnd9dU9fTMPT0beXgbKp7wTcZFkUZIo1MXXRi+z0sPaW 9v5bq0MXGd26KZrFC/edzHPDYJMSDed2WkHTCY+QNp/uZK00GbTfeqFSe45fYVhwi7BHdRL/6 xxvmv7Se8WYzVHpGBpLHKIG6OwOY5tP14xxp0rnkTGi00nExhEU87aHYJ32kyqLHKEZFPDFFq t6EFkv1IY9v/edeGIzHiL1sJJD2dUx/63GblruX6ZDdCZCCCB8=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00054.txt.bz2

As of f22054c94d (Modify strnstr.c., 2017-08-30), the strnstr()
implementation was replaced by a version that segfaults (at least
sometimes) on 64-bit systems.

The reason: the new implementation uses memmem(), and the prototype of
memmem() is missing because the _GNU_SOURCE constant is not defined
before including <string.h>. As a consequence its return type defaults
to int (and GCC spits out a warning).

On 64-bit systems, the int data type is too small, though, to hold a
full char *, hence the upper 32-bit are cut off and bad things happen
due to a bogus pointer being used to access memory.

Reported as https://github.com/Alexpux/MINGW-packages/issues/2879 in
the MSYS2 project.

Cc: Sichen Zhao <1473996754@qq.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-strnstr-segfault-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-strnstr-segfault-v1
 newlib/libc/string/strnstr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/newlib/libc/string/strnstr.c b/newlib/libc/string/strnstr.c
index ce32d0f73e..f6b007813f 100644
--- a/newlib/libc/string/strnstr.c
+++ b/newlib/libc/string/strnstr.c
@@ -31,6 +31,7 @@ QUICKREF
 */
 
 #undef __STRICT_ANSI__
+#define _GNU_SOURCE
 #include <_ansi.h>
 #include <string.h>
 

base-commit: 05cfd1aed8b262e82f62acc2de2858d2d2b6679c
-- 
2.14.1.windows.1.521.g18481b3d404

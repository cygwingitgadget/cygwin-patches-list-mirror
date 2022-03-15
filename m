Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (woodpecker.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 by sourceware.org (Postfix) with ESMTPS id 660A83858C78
 for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2022 03:27:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 660A83858C78
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gentoo.org
Received: by smtp.gentoo.org (Postfix, from userid 559)
 id 19DBA342AA4; Tue, 15 Mar 2022 03:20:47 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup: disable fortify source
Date: Mon, 14 Mar 2022 23:20:53 -0400
Message-Id: <20220315032053.10985-1-vapier@gentoo.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, SPF_HELO_PASS, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 15 Mar 2022 03:27:06 -0000

When using a compiler that automatically enables -D_FORTIFY_SOURCE,
building winsup fails with errors like below.  Since winsup is not
setup to compile itself with _FORTIFY_SOURCE, disable it for now.

make[4]: Entering directory '.../x86_64-pc-cygwin/winsup/cygwin'
  CC       libc/minires-os-if.o
In file included from .../newlib/newlib/libc/include/ssp/strings.h:34,
                 from .../newlib/newlib/libc/include/strings.h:77,
                 from .../newlib/newlib/libc/include/string.h:24,
                 from ../../../../../winsup/cygwin/string.h:12,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/guiddef.h:154,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/winnt.h:635,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/minwindef.h:163,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/windef.h:9,
                 from /usr/x86_64-pc-cygwin/usr/include/windows.h:69,
                 from ../../../../../winsup/cygwin/winlean.h:56,
                 from ../../../../../winsup/cygwin/winsup.h:84,
                 from ../../../../../winsup/cygwin/libc/minires-os-if.c:13:
.../newlib/winsup/cygwin/include/ssp/socket.h:9:1: error: conflicting types for 'recv';
  have 'ssize_t(int,  void *, size_t,  int)' {aka 'long int(int,  void *, long unsigned int,  int)'}
    9 | __ssp_redirect0(ssize_t, recv, \
      | ^~~~~~~~~~~~~~~
In file included from /usr/x86_64-pc-cygwin/usr/include/w32api/ws2tcpip.h:17,
                 from ../../../../../winsup/cygwin/libc/minires-os-if.c:14:
/usr/x86_64-pc-cygwin/usr/include/w32api/winsock2.h:1022:34: note: previous declaration of 'recv' with
  type 'int(SOCKET,  char *, int,  int)' {aka 'int(long long unsigned int,  char *, int,  int)'}
 1022 |   WINSOCK_API_LINKAGE int WSAAPI recv(SOCKET s,char *buf,int len,int flags);
      |                                  ^~~~
In file included from .../newlib/newlib/libc/include/ssp/strings.h:34,
                 from .../newlib/newlib/libc/include/strings.h:77,
                 from .../newlib/newlib/libc/include/string.h:24,
                 from ../../../../../winsup/cygwin/string.h:12,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/guiddef.h:154,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/winnt.h:635,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/minwindef.h:163,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/windef.h:9,
                 from /usr/x86_64-pc-cygwin/usr/include/windows.h:69,
                 from ../../../../../winsup/cygwin/winlean.h:56,
                 from ../../../../../winsup/cygwin/winsup.h:84,
                 from ../../../../../winsup/cygwin/libc/minires-os-if.c:13:
.../newlib/winsup/cygwin/include/ssp/socket.h:13:1: error: conflicting types for 'recvfrom';
  have 'ssize_t(int,  void *, size_t,  int,  struct sockaddr *, socklen_t *)' {aka 'long int(int,  void *, long unsigned int,  int,  struct sockaddr *, int *)'}
   13 | __ssp_redirect0(ssize_t, recvfrom, \
      | ^~~~~~~~~~~~~~~
In file included from /usr/x86_64-pc-cygwin/usr/include/w32api/ws2tcpip.h:17,
                 from ../../../../../winsup/cygwin/libc/minires-os-if.c:14:
/usr/x86_64-pc-cygwin/usr/include/w32api/winsock2.h:1023:34: note: previous declaration of 'recvfrom' with
  type 'int(SOCKET,  char *, int,  int,  struct sockaddr *, int *)' {aka 'int(long long unsigned int,  char *, int,  int,  struct sockaddr *, int *)'}
 1023 |   WINSOCK_API_LINKAGE int WSAAPI recvfrom(SOCKET s,char *buf,int len,int flags,struct sockaddr *from,int *fromlen);
      |                                  ^~~~~~~~
make[4]: *** [Makefile:1930: libc/minires-os-if.o] Error 1
  CC       gmon.o
../../../../../winsup/cygwin/gmon.c:60: error: "bzero" redefined [-Werror]
   60 | #define bzero(ptr,size) memset (ptr, 0, size);
      |
In file included from .../newlib/newlib/libc/include/strings.h:77,
                 from .../newlib/newlib/libc/include/string.h:24,
                 from ../../../../../winsup/cygwin/string.h:12,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/guiddef.h:154,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/winnt.h:635,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/minwindef.h:163,
                 from /usr/x86_64-pc-cygwin/usr/include/w32api/windef.h:9,
                 from /usr/x86_64-pc-cygwin/usr/include/windows.h:69,
                 from ../../../../../winsup/cygwin/winlean.h:56,
                 from ../../../../../winsup/cygwin/winsup.h:84,
                 from ../../../../../winsup/cygwin/gmon.h:69,
                 from ../../../../../winsup/cygwin/gmon.c:47:
.../newlib/newlib/libc/include/ssp/strings.h:43: note: this is the location of the previous definition
   43 | #define bzero(dst, len) \
      |
cc1: all warnings being treated as errors
---
 winsup/acinclude.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/acinclude.m4 b/winsup/acinclude.m4
index 7c900d70719a..ffd15aaaa86b 100644
--- a/winsup/acinclude.m4
+++ b/winsup/acinclude.m4
@@ -16,7 +16,7 @@ if test -z "$newlib_headers"; then
 fi
 newlib_headers="$target_builddir/newlib/targ-include $newlib_headers"
 
-AM_CPPFLAGS="-I${winsup_srcdir}/cygwin -I${target_builddir}/winsup/cygwin"
+AM_CPPFLAGS="-U_FORTIFY_SOURCE -I${winsup_srcdir}/cygwin -I${target_builddir}/winsup/cygwin"
 AM_CPPFLAGS="${AM_CPPFLAGS} -isystem ${cygwin_headers}"
 for h in ${newlib_headers}; do
     AM_CPPFLAGS="${AM_CPPFLAGS} -isystem $h"
-- 
2.34.1


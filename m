Return-Path: <cygwin-patches-return-3668-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19241 invoked by alias); 4 Mar 2003 13:32:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19232 invoked from network); 4 Mar 2003 13:32:22 -0000
Date: Tue, 04 Mar 2003 13:32:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: socket dup() patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20030304134025.GA1308@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_FvhQdxMKUigWvYZDQ4vsJw)"
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00317.txt.bz2


--Boundary_(ID_FvhQdxMKUigWvYZDQ4vsJw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 625

The attached patch fixes the vsftpd problem that I mentioned in the
following post:

    http://cygwin.com/ml/cygwin-developers/2003-02/msg00125.html

The patch just initializes fhandler_socket::type so that the following
patch functions properly after a socket has been dup()-ed:

    http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_socket.cc.diff?cvsroot=src&r1=1.79&r2=1.80

The attached test case, is3.cc, can be used to verify proper behavior.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_FvhQdxMKUigWvYZDQ4vsJw)
Content-type: text/plain; charset=us-ascii; NAME=fhandler_socket.cc.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=fhandler_socket.cc.diff
Content-length: 630

Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.84
diff -u -p -r1.84 fhandler_socket.cc
--- fhandler_socket.cc	1 Mar 2003 16:17:55 -0000	1.84
+++ fhandler_socket.cc	3 Mar 2003 22:41:35 -0000
@@ -383,6 +383,7 @@ fhandler_socket::dup (fhandler_base *chi
   fhs->set_io_handle (get_io_handle ());
   if (get_addr_family () == AF_LOCAL)
     fhs->set_sun_path (get_sun_path ());
+  fhs->set_socket_type (get_socket_type ());
 
   fhs->fixup_before_fork_exec (GetCurrentProcessId ());
   if (winsock2_active)

--Boundary_(ID_FvhQdxMKUigWvYZDQ4vsJw)
Content-type: text/plain; charset=us-ascii; NAME=fhandler_socket.cc.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=fhandler_socket.cc.ChangeLog
Content-length: 110

2003-03-04  Jason Tishler <jason@tishler.net>

	* fhandler_socket.cc (fhandler_socket::dup): Initialize type.

--Boundary_(ID_FvhQdxMKUigWvYZDQ4vsJw)
Content-type: text/plain; charset=us-ascii; NAME=is3.cc
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=is3.cc
Content-length: 767

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>

void
is_socket(int fd)
{
	struct stat buf;
	memset(&buf, 0, sizeof(buf));
	int status = fstat(fd, &buf);
	if (status < 0)
	{
		printf("fstat() failed with %d\n", errno);
		return;
	}

	if (S_ISSOCK(buf.st_mode))
		printf("fd %d is a socket\n", fd);
	else
		printf("fd %d is not a socket\n", fd);
}

int
main()
{
	int status = 0;

	int fd = socket(AF_INET, SOCK_STREAM, 0);
	if (fd < 0)
	{
		printf("socket() failed with %d\n", errno);
		return 1;
	}

	is_socket(fd);

	int fd2 = 13;
	status = dup2(fd, fd2);
	if (status < 0)
	{
		printf("dup2() failed with %d\n", errno);
		return 1;
	}

	is_socket(fd2);

	return 0;
}

--Boundary_(ID_FvhQdxMKUigWvYZDQ4vsJw)--

Return-Path: <cygwin-patches-return-3568-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29829 invoked by alias); 14 Feb 2003 19:27:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29797 invoked from network); 14 Feb 2003 19:27:10 -0000
Date: Fri, 14 Feb 2003 19:27:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: mprotect() missing break patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20030214193417.GA2608@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_meXJZEZE/hE3OyQwcd9k0Q)"
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00217.txt.bz2


--Boundary_(ID_meXJZEZE/hE3OyQwcd9k0Q)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 475

Corinna,

The attach patch adds a missing break statement that causes the
following under Windows 2000:

  347  190637 [main] vsftpd 2736 mprotect: mprotect (addr 1590000, len 4096, prot 1)
  113  191004 [main] vsftpd 2736 mprotect: -1 = mprotect (): Win32 error 87

For some reason, the above does not occur under NT 4.0.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_meXJZEZE/hE3OyQwcd9k0Q)
Content-type: text/plain; charset=us-ascii; NAME=mmap.cc.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=mmap.cc.diff
Content-length: 452

Index: mmap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mmap.cc,v
retrieving revision 1.70
diff -u -p -r1.70 mmap.cc
--- mmap.cc	7 Feb 2003 20:57:30 -0000	1.70
+++ mmap.cc	14 Feb 2003 19:17:24 -0000
@@ -909,6 +909,7 @@ mprotect (caddr_t addr, size_t len, int 
 	break;
       case PROT_READ:
 	new_prot = PAGE_READONLY;
+	break;
       case PROT_EXEC:
 	new_prot = PAGE_EXECUTE;
 	break;

--Boundary_(ID_meXJZEZE/hE3OyQwcd9k0Q)
Content-type: text/plain; charset=us-ascii; NAME=mmap.cc.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=mmap.cc.ChangeLog
Content-length: 90

2003-02-14  Jason Tishler  <jason@tishler.net>

	* mmap.cc (mprotect): Add missing break.

--Boundary_(ID_meXJZEZE/hE3OyQwcd9k0Q)--

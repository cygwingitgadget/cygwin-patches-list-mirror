Return-Path: <cygwin-patches-return-4830-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21424 invoked by alias); 8 Jun 2004 09:30:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21337 invoked from network); 8 Jun 2004 09:29:46 -0000
Message-ID: <40C5871E.9010801@msgid.corpit.ru>
Date: Tue, 08 Jun 2004 09:30:00 -0000
From: Egor Duda <deo@corpit.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
MIME-Version: 1.0
To: cygwin-patches@sourceware.org
Subject: make IPC_INFO visible to ipc system utilities only
Content-Type: multipart/mixed;
 boundary="------------060906060909070103030306"
X-SW-Source: 2004-q2/txt/msg00182.txt.bz2

This is a multi-part message in MIME format.
--------------060906060909070103030306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 383

Hi!

Currently IPC_INFO is defined whenever we include sys/sem.h, but struct
seminfo, which is returned by semctl(IPC_INFO) is defined only for
_KERNEL applications. This inconsistency breaks, for instance,
libmudflap builds. I believe there's no point to have IPC_INFO in
non-_KERNEL application as long as we can't get semctl(IPC_INFO) results
right anyway. Patch attached.

egor


--------------060906060909070103030306
Content-Type: text/plain;
 name="hide-ipc-info-def.ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hide-ipc-info-def.ChangeLog"
Content-length: 178

2004-Jun-08  Egor Duda <deo@corpit.ru>

	* include/cygwin/ipc.h: Make IPC_INFO visible only for ipc system
	utilities, to make it consistent with declaration of struct seminfo.


--------------060906060909070103030306
Content-Type: text/plain;
 name="hide-ipc-info-def.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hide-ipc-info-def.diff"
Content-length: 527

Index: include/cygwin/ipc.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/ipc.h,v
retrieving revision 1.6
diff -u -p -2 -r1.6 ipc.h
--- include/cygwin/ipc.h	3 Jun 2004 19:51:10 -0000	1.6
+++ include/cygwin/ipc.h	8 Jun 2004 07:27:29 -0000
@@ -49,5 +49,8 @@ struct ipc_perm
 #define IPC_SET  0x1001		/* Set options. */
 #define IPC_STAT 0x1002		/* Get options. */
+
+#ifdef _KERNEL
 #define IPC_INFO 0x1003		/* For ipcs(8). */
+#define
 
 #ifdef _KERNEL


--------------060906060909070103030306--

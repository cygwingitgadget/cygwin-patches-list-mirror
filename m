Return-Path: <cygwin-patches-return-3777-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4632 invoked by alias); 2 Apr 2003 15:17:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4424 invoked from network); 2 Apr 2003 15:17:39 -0000
Message-ID: <3E8AFF12.8040904@hekimian.com>
Date: Wed, 02 Apr 2003 15:17:00 -0000
X-Sybari-Trust: 220985dc 36b09be0 04609a3e 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  jbuehler@hekimian.com
Organization: Spirent Communications, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] fix for GetModuleFileName() hang when address is in ntdll.dll
 (NT4 SP5)
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00004.txt.bz2

2003-04-02  Joe Buehler  <jhpb@hekimian.com>

	* exceptions.cc (interruptible): avoid calling GetModuleFileName() on system DLL

Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.144
diff -u -r1.144 exceptions.cc
--- exceptions.cc	31 Mar 2003 21:27:06 -0000	1.144
+++ exceptions.cc	2 Apr 2003 15:15:58 -0000
@@ -651,6 +652,11 @@
      res = 1;
    else if (h == cygwin_hmodule)
      res = 0;
+  else if (((int)h & 0xf0000000) == 0x70000000)
+    /* GetModuleFileName() has been observed to hang when handed an address
+       in ntdll.dll (NT4 SP5), so test before calling, to see whether the
+       address looks like it is in a Windows system DLL. */
+    res = 0;
    else if (!GetModuleFileName (h, checkdir, windows_system_directory_length + 2))
      res = 0;
    else
-- 
Joe Buehler

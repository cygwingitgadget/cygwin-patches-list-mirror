Return-Path: <cygwin-patches-return-4333-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26924 invoked by alias); 31 Oct 2003 21:17:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26915 invoked from network); 31 Oct 2003 21:17:40 -0000
Message-ID: <3FA2D171.6080806@gmx.net>
Date: Fri, 31 Oct 2003 21:17:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] suspend all thread on SIGSTOP
Content-Type: multipart/mixed;
 boundary="------------020203060202080601080300"
X-SW-Source: 2003-q4/txt/msg00052.txt.bz2

This is a multi-part message in MIME format.
--------------020203060202080601080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 324

This time with attachment.

This patch suspends all threads on SIGSTOP and resumes them on SIGCONT. 
The corresponding functions in the pthread class are already committed.

Thomas

2003-10-31  Thomas Pfaff  <tpfaff@gmx.net>

	* exceptions.cc (sig_handle_tty_stop): Suspend all
	threads on SIGSTOP, resume them on SIGCONT.


--------------020203060202080601080300
Content-Type: text/plain;
 name="suspend_all_on_stop.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="suspend_all_on_stop.patch"
Content-length: 778

? suspend_all_on_stop.patch
Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.172
diff -u -p -r1.172 exceptions.cc
--- exceptions.cc	14 Oct 2003 09:21:55 -0000	1.172
+++ exceptions.cc	31 Oct 2003 20:48:59 -0000
@@ -622,10 +622,12 @@ sig_handle_tty_stop (int sig)
       if (ISSTATE (parent, PID_NOCLDSTOP))
 	sig_send (parent, SIGCHLD);
     }
+  pthread::suspend_all_except_self ();
   sigproc_printf ("process %d stopped by signal %d, myself->ppid_handle %p",
 		  myself->pid, sig, myself->ppid_handle);
   if (WaitForSingleObject (sigCONT, INFINITE) != WAIT_OBJECT_0)
     api_fatal ("WaitSingleObject failed, %E");
+  pthread::resume_all ();
   return;
 }
 }

--------------020203060202080601080300--

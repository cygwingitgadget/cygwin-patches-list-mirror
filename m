Return-Path: <cygwin-patches-return-2422-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 668 invoked by alias); 13 Jun 2002 22:29:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 585 invoked from network); 13 Jun 2002 22:29:51 -0000
Message-ID: <3D091A96.2090505@netscape.net>
Date: Thu, 13 Jun 2002 15:29:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Patch to calls.texinfo
Content-Type: multipart/mixed;
 boundary="------------060008060103090000040201"
X-SW-Source: 2002-q2/txt/msg00405.txt.bz2


--------------060008060103090000040201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 229

Chris,

I updated calls.texinfo to reflect the implimentation of pthreads 
functions that have been implemented.  You said no changelog entry was 
necessary for "Documentation", as such I have not included one.

Cheers,
Nicholas

--------------060008060103090000040201
Content-Type: text/plain;
 name="calls.texinfo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="calls.texinfo.diff"
Content-length: 2511

Index: calls.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/calls.texinfo,v
retrieving revision 1.3
diff -u -3 -p -u -p -r1.3 calls.texinfo
--- calls.texinfo   20 Jul 2000 11:04:33 -0000  1.3
+++ calls.texinfo   13 Jun 2002 22:24:34 -0000
@@ -405,12 +405,12 @@ net release.)}
 
 @item Synchronization (Section 11)
 @itemize @code
-@item pthread_cond_broadcast: P96 11.4.3.1 -- unimplemented
-@item pthread_cond_destroy: P96 11.4.2.1 -- unimplemented
-@item pthread_cond_init: P96 11.4.2.1 -- unimplemented
-@item pthread_cond_signal: P96 11.4.3.1 -- unimplemented
-@item pthread_cond_timedwait: P96 11.4.4.1 -- unimplemented
-@item pthread_cond_wait: P96 11.4.4.1 -- unimplemented
+@item pthread_cond_broadcast: P96 11.4.3.1
+@item pthread_cond_destroy: P96 11.4.2.1
+@item pthread_cond_init: P96 11.4.2.1
+@item pthread_cond_signal: P96 11.4.3.1
+@item pthread_cond_timedwait: P96 11.4.4.1
+@item pthread_cond_wait: P96 11.4.4.1
 @item pthread_condattr_destroy: P96 11.4.1.1 -- unimplemented
 @item pthread_condattr_getpshared: P96 11.4.1.1 -- unimplemented
 @item pthread_condattr_init: P96 11.4.1.1 -- unimplemented
@@ -451,18 +451,18 @@ net release.)}
 @item pthread_attr_getschedparam: P96 13.5.1.1 -- unimplemented
 @item pthread_attr_getschedpolicy: P96 13.5.1.1 -- unimplemented
 @item pthread_attr_getscope: P96 13.5.1.1 -- unimplemented
-@item pthread_attr_setinheritsched: P96 13.5.1.1 -- unimplemented
+@item pthread_attr_setinheritsched: P96 13.5.1.1
 @item pthread_attr_setschedparam: P96 13.5.1.1 -- unimplemented
 @item pthread_attr_setschedpolicy: P96 13.5.1.1 -- unimplemented
 @item pthread_attr_setscope: P96 13.5.1.1 -- unimplemented
-@item pthread_getschedparam: P96 13.5.2.1 -- unimplemented
+@item pthread_getschedparam: P96 13.5.2.1
 @item pthread_mutex_getprioceiling: P96 13.6.2.1 -- unimplemented
 @item pthread_mutex_setprioceiling: P96 13.6.2.1 -- unimplemented
 @item pthread_mutexattr_getprioceiling: P96 13.6.1.1 -- unimplemented
 @item pthread_mutexattr_getprotocol: P96 13.6.1.1 -- unimplemented
 @item pthread_mutexattr_setprioceiling: P96 13.6.1.1 -- unimplemented
 @item pthread_mutexattr_setprotocol: P96 13.6.1.1 -- unimplemented
-@item pthread_setschedparam: P96 13.5.2.1 -- unimplemented
+@item pthread_setschedparam: P96 13.5.2.1
 @item sched_get_priority_max: P96 13.3.6.1 -- unimplemented
 @item sched_get_priority_min: P96 13.3.6.1 -- unimplemented
 @item sched_getparam: P96 13.3.2.1 -- unimplemented

--------------060008060103090000040201--

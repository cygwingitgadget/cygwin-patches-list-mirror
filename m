Return-Path: <cygwin-patches-return-6577-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29941 invoked by alias); 26 Jul 2009 21:45:27 -0000
Received: (qmail 29928 invoked by uid 22791); 26 Jul 2009 21:45:26 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_66,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f174.google.com (HELO mail-qy0-f174.google.com) (209.85.221.174)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 26 Jul 2009 21:45:17 +0000
Received: by qyk4 with SMTP id 4so3220889qyk.18         for <cygwin-patches@cygwin.com>; Sun, 26 Jul 2009 14:45:14 -0700 (PDT)
Received: by 10.224.60.195 with SMTP id q3mr5393291qah.65.1248644714817;         Sun, 26 Jul 2009 14:45:14 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 5sm9379200qwg.35.2009.07.26.14.45.13         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Sun, 26 Jul 2009 14:45:14 -0700 (PDT)
Message-ID: <4A6CCE6A.6040509@users.sourceforge.net>
Date: Sun, 26 Jul 2009 21:45:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] remaining reference to CYGWIN=server
Content-Type: multipart/mixed;  boundary="------------010602020202090306060202"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00031.txt.bz2

This is a multi-part message in MIME format.
--------------010602020202090306060202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 84

posix.sgml still contains a reference to CYGWIN="server".  Patch attached.


Yaakov

--------------010602020202090306060202
Content-Type: text/plain;
 name="cygwin-api-std-notes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-api-std-notes.patch"
Content-length: 837

2009-07-26  Yaakov Selkowitz <yselkowitz@users.sourceforge.net>

	* posix.sgml (std-notes): Remove obsolete reference to CYGWIN=server.

Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.36
diff -u -r1.36 posix.sgml
--- posix.sgml	26 Jul 2009 09:34:35 -0000	1.36
+++ posix.sgml	26 Jul 2009 21:31:50 -0000
@@ -1408,8 +1408,6 @@
 <function>shmdt</function>, <function>shmget</function>,
 <function>msgctl</function>, <function>msgget</function>,
 <function>msgrcv</function> and <function>msgsnd</function> are only
-available when cygserver is running and the <envar>CYGWIN</envar>
-environment variable is set so that it contains the string
-<envar>server</envar>.</para>
+available when cygserver is running.</para>
 
 </sect1>

--------------010602020202090306060202--

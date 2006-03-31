Return-Path: <cygwin-patches-return-5810-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31029 invoked by alias); 31 Mar 2006 14:50:40 -0000
Received: (qmail 31010 invoked by uid 22791); 31 Mar 2006 14:50:39 -0000
X-Spam-Check-By: sourceware.org
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 31 Mar 2006 14:50:36 +0000
Received: from root by ciao.gmane.org with local (Exim 4.43) 	id 1FPKwy-0005WE-Ap 	for cygwin-patches@cygwin.com; Fri, 31 Mar 2006 16:50:08 +0200
Received: from c-24-10-50-211.hsd1.ca.comcast.net ([24.10.50.211])         by main.gmane.org with esmtp (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Fri, 31 Mar 2006 16:50:08 +0200
Received: from cinder_bdt by c-24-10-50-211.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Fri, 31 Mar 2006 16:50:08 +0200
To: cygwin-patches@cygwin.com
From:  Bryan D. Thomas <cinder_bdt@yahoo.com>
Subject:  wtf fix for sh prep
Date: Fri, 31 Mar 2006 14:50:00 -0000
Message-ID:  <loom.20060331T164407-365@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00119.txt.bz2

http://cygwin.com/acronyms/#KOTPPLAUOP

wtf didn't have this one.

wtf includes a version of OLOCA from 2003.  I downloaded the source package and
found how to get the new one, so I'm happy.  I did have to modify the makefile
to get it to work, though.

If this patch is accepted, maybe at the same time, a 2006 version of OLOCA would
go in?

Best Regards,
Bryan

$ ./wtf-0.0.4-6.sh prep
./wtf-0.0.4-6.sh: line 64: syntax error near unexpected token `&&'
./wtf-0.0.4-6.sh: line 64: `  && mkdirs )'

===================================================================
--- wtf-0.0.4-6.sh      2003-11-25 16:42:58.000000000 -0800
+++ wtf-new.sh  2006-03-31 06:38:42.953125000 -0800
@@ -60,8 +60,8 @@
   (cd ${topdir} && \
   tar xvjf ${src_orig_pkg} && \
   cd ${topdir} && \
-  patch -p0 < ${src_patch}
-  && mkdirs )
+  patch -p0 < ${src_patch} && \
+  mkdirs )
 }
 conf() {
   (cd ${objdir} && \

===================================================================


Return-Path: <cygwin-patches-return-6602-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27182 invoked by alias); 25 Aug 2009 02:43:49 -0000
Received: (qmail 27150 invoked by uid 22791); 25 Aug 2009 02:43:48 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.145)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 25 Aug 2009 02:43:40 +0000
Received: by qw-out-1920.google.com with SMTP id 4so1400241qwk.20         for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2009 19:43:37 -0700 (PDT)
Received: by 10.224.78.207 with SMTP id m15mr3535063qak.3.1251168217635;         Mon, 24 Aug 2009 19:43:37 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 6sm2520500qwk.7.2009.08.24.19.43.35         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Mon, 24 Aug 2009 19:43:36 -0700 (PDT)
Message-ID: <4A934FDC.1030803@users.sourceforge.net>
Date: Tue, 25 Aug 2009 02:43:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Update cygport README link
Content-Type: multipart/mixed;  boundary="------------000601050208010605020005"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00056.txt.bz2

This is a multi-part message in MIME format.
--------------000601050208010605020005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 121

cygport development moved from CVS to SVN some time ago, but setup.html 
still points to ViewCVS.

OK to apply?


Yaakov

--------------000601050208010605020005
Content-Type: text/plain;
 name="htdocs-setup-cygport-README.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="htdocs-setup-cygport-README.patch"
Content-length: 1878

Index: setup.html
===================================================================
RCS file: /cvs/cygwin/htdocs/setup.html,v
retrieving revision 1.114
diff -u -r1.114 setup.html
--- setup.html	2 Jul 2009 18:18:02 -0000	1.114
+++ setup.html	25 Aug 2009 02:32:40 -0000
@@ -466,7 +466,7 @@
 	</li>
       </ul>
       <h3>Method Three: cygport</h3>
-      <p>The technique of method two became popular to many maintainers, however it suffers from a number of drawbacks when applied on a wide scale.  The <tt>cygport</tt> <a href="http://cygwin-ports.cvs.sourceforge.net/*checkout*/cygwin-ports/cygport/README">README</a> explains a number of these problems.</p>
+      <p>The technique of method two became popular to many maintainers, however it suffers from a number of drawbacks when applied on a wide scale.  The <tt>cygport</tt> <a href="http://cygwin-ports.svn.sourceforge.net/viewvc/cygwin-ports/cygport/trunk/README">README</a> explains a number of these problems.</p>
       <p>The <tt>cygport</tt> framework is a response to these issues, and borrows concepts from the Gentoo portage system.  It separates the g-b-s into a small file containing the package-specific parts and moves the main script infrastructure into shared files.  For more information on using <tt>cygport</tt> consult the documentation and sample port files.</p>
       <p>Source packages created with <tt>cygport</tt> have a similar structure to those created with method two, except that they contain a '<tt>boffo-1.0-1.cygport</tt>' file in place of the '<tt>boffo-1.0-1.sh</tt>' script.  The binary package is built by running '<tt>cygport boffo-1.0-1 all</tt>' instead of '<tt>./boffo-1.0-1.sh all</tt>', and so on for <tt>prep</tt>, <tt>compile</tt>, <tt>package</tt>, <tt>finish</tt>, etc.</p>
       <h2><a id="postinstall" name="postinstall">Creating a package postinstall script</a></h2>

--------------000601050208010605020005--

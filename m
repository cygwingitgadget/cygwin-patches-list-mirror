Return-Path: <cygwin-patches-return-7709-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25853 invoked by alias); 23 Aug 2012 16:05:49 -0000
Received: (qmail 25832 invoked by uid 22791); 23 Aug 2012 16:05:47 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 23 Aug 2012 16:05:15 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.1.103]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 23 Aug 2012 17:04:27 +0100
Message-ID: <5036549C.7050509@dronecode.org.uk>
Date: Thu, 23 Aug 2012 16:05:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Add pointer to instructions for uninstalling cygwin LSA to uninstall FAQ
Content-Type: multipart/mixed; boundary="------------050306020505060006040904"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00030.txt.bz2

This is a multi-part message in MIME format.
--------------050306020505060006040904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 231


The uninstall instructions in the FAQ will fail if cygwin LSA is installed.

2012-08-23  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* faq-setup.xml (faq.setup.uninstall-all): Add pointer to instructions
	for uninstalling cyglsa.

--------------050306020505060006040904
Content-Type: text/plain; charset=windows-1252;
 name="uninstall-cyglsa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="uninstall-cyglsa.patch"
Content-length: 795

Index: doc/faq-setup.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-setup.xml,v
retrieving revision 1.28
diff -u -p -r1.28 faq-setup.xml
--- doc/faq-setup.xml	5 Jan 2011 16:02:00 -0000	1.28
+++ doc/faq-setup.xml	23 Aug 2012 15:33:52 -0000
@@ -450,6 +450,11 @@ well.
 of Cygwin is as follows:
 </para>
 <orderedlist>
+<listitem><para>
+If you installed Cygwin LSA authentication using the <literal>cyglsa-config</literal>
+script, follow the instructions in <ulink url="http://cygwin.com/ml/cygwin/2011-10/msg00113.html" />.
+</para>
+</listitem>
 <listitem><para>If you have any Cygwin services running, remove by repeating 
 the instructions in <ulink
 url="http://cygwin.com/faq/faq.setup.html#faq.setup.uninstall-service" /> for

--------------050306020505060006040904--

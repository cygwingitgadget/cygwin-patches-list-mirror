Return-Path: <cygwin-patches-return-6934-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16557 invoked by alias); 26 Jan 2010 19:28:19 -0000
Received: (qmail 16459 invoked by uid 22791); 26 Jan 2010 19:28:18 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f199.google.com (HELO mail-qy0-f199.google.com) (209.85.221.199)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 26 Jan 2010 19:28:11 +0000
Received: by qyk37 with SMTP id 37so1267273qyk.18         for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2010 11:28:09 -0800 (PST)
Received: by 10.220.127.66 with SMTP id f2mr2001223vcs.82.1264534073642;         Tue, 26 Jan 2010 11:27:53 -0800 (PST)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 26sm8152091vws.4.2010.01.26.11.27.52         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Tue, 26 Jan 2010 11:27:52 -0800 (PST)
Message-ID: <4B5F423E.1000903@users.sourceforge.net>
Date: Tue, 26 Jan 2010 19:28:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [COMMITTED] doc: d2u/u2d in cygutils
Content-Type: multipart/mixed;  boundary="------------030107000903020107020203"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00050.txt.bz2

This is a multi-part message in MIME format.
--------------030107000903020107020203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 184

In winsup/doc/faq-api.xml, d2u/u2d are incorrectly listed in the 
util-linux package.  They are, and have always been, part of cygutils.

Attached patch committed as obvious.


Yaakov

--------------030107000903020107020203
Content-Type: text/x-patch;
 name="faq-api-d2u.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="faq-api-d2u.patch"
Content-length: 852

2010-01-26  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* faq-api.xml: d2u/u2d are from cygutils, not util-linux.

Index: faq-api.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-api.xml,v
retrieving revision 1.5
diff -u -r1.5 faq-api.xml
--- faq-api.xml	31 Mar 2009 10:54:28 -0000	1.5
+++ faq-api.xml	26 Jan 2010 19:02:41 -0000
@@ -69,7 +69,7 @@
 (unfortunate exception: Notepad).  So we suggest to use binary mode
 as much as possible and only convert files from or to DOS text mode
 using tools specifically created to do that job, for instance, d2u and
-u2d from the util-linux package.
+u2d from the cygutils package.
 </para>
 <para>It is rather easy for the porter of a Unix package to fix the source
 code by supplying the appropriate file processing mode switches to the

--------------030107000903020107020203--

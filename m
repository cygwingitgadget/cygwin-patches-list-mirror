Return-Path: <cygwin-patches-return-6675-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1501 invoked by alias); 3 Oct 2009 13:19:11 -0000
Received: (qmail 1487 invoked by uid 22791); 3 Oct 2009 13:19:10 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f218.google.com (HELO mail-ew0-f218.google.com) (209.85.219.218)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 03 Oct 2009 13:19:05 +0000
Received: by ewy18 with SMTP id 18so1909222ewy.43         for <cygwin-patches@cygwin.com>; Sat, 03 Oct 2009 06:19:03 -0700 (PDT)
Received: by 10.211.154.17 with SMTP id g17mr930330ebo.32.1254575943093;         Sat, 03 Oct 2009 06:19:03 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 28sm98204eyg.20.2009.10.03.06.19.02         (version=SSLv3 cipher=RC4-MD5);         Sat, 03 Oct 2009 06:19:02 -0700 (PDT)
Message-ID: <4AC752B2.2060703@gmail.com>
Date: Sat, 03 Oct 2009 13:19:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Bloda update
Content-Type: multipart/mixed;  boundary="------------040108070107090905030905"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00006.txt.bz2

This is a multi-part message in MIME format.
--------------040108070107090905030905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 160


  As mentioned over on the main list:

winsup/doc/ChangeLog:

	* faq-using.xml (faq.using.bloda): Add Lenovo IPS Core Service.

  Ok?

    cheers,
      DaveK

--------------040108070107090905030905
Content-Type: text/x-c;
 name="bloda-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bloda-update.diff"
Content-length: 806

Index: winsup/doc/faq-using.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-using.xml,v
retrieving revision 1.26
diff -p -u -r1.26 faq-using.xml
--- winsup/doc/faq-using.xml	12 Aug 2009 22:03:18 -0000	1.26
+++ winsup/doc/faq-using.xml	3 Oct 2009 13:13:24 -0000
@@ -1100,6 +1100,7 @@ behaviour which affect the operation of 
 <listitem><para>Google Desktop</para></listitem>
 <listitem><para>Sophos Anti-Virus 7</para></listitem>
 <listitem><para>Bufferzone from Trustware</para></listitem>
+<listitem><para>Lenovo IPS Core Service (ipssvc)</para></listitem>
 </itemizedlist></para>
 <para>Sometimes these problems can be worked around, by temporarily or partially
 disabling the offending software.  For instance, it may be possible to disable

--------------040108070107090905030905--

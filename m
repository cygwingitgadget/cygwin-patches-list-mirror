Return-Path: <cygwin-patches-return-6597-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27134 invoked by alias); 12 Aug 2009 22:06:06 -0000
Received: (qmail 27024 invoked by uid 22791); 12 Aug 2009 22:06:05 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f217.google.com (HELO mail-ew0-f217.google.com) (209.85.219.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 12 Aug 2009 22:05:56 +0000
Received: by ewy17 with SMTP id 17so372531ewy.2         for <cygwin-patches@cygwin.com>; Wed, 12 Aug 2009 15:05:53 -0700 (PDT)
Received: by 10.210.10.14 with SMTP id 14mr51727ebj.26.1250114753608;         Wed, 12 Aug 2009 15:05:53 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 28sm842782eye.44.2009.08.12.15.05.52         (version=SSLv3 cipher=RC4-MD5);         Wed, 12 Aug 2009 15:05:53 -0700 (PDT)
Message-ID: <4A833FEA.4020809@gmail.com>
Date: Wed, 12 Aug 2009 22:06:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [committed] Typofix in faq.
Content-Type: multipart/mixed;  boundary="------------000002080008070604060409"
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
X-SW-Source: 2009-q3/txt/msg00051.txt.bz2

This is a multi-part message in MIME format.
--------------000002080008070604060409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 334


    Hi all,

  Courtesy notice; I just checked in the attached typo fix under the obvious rule.

winsup/cygwin/doc/ChangeLog:

	* faq-using.xml (faq.using.bloda): Typofix MacAfee -> McAfee.

  Not important enough to rebuild the website for, we'll just let it get swept
up next time there's a bigger change.

    cheers,
      DaveK

--------------000002080008070604060409
Content-Type: text/x-c;
 name="mcafee-typofix-applied.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mcafee-typofix-applied.diff"
Content-length: 1530

Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/doc/ChangeLog,v
retrieving revision 1.224
diff -p -u -r1.224 ChangeLog
--- ChangeLog	23 Jul 2009 08:49:06 -0000	1.224
+++ ChangeLog	12 Aug 2009 22:02:45 -0000
@@ -1,3 +1,7 @@
+2009-08-12  Dave Korn  <dave.korn.cygwin@gmail.com>
+
+	* faq-using.xml (faq.using.bloda): Typofix MacAfee -> McAfee.
+
 2009-07-23  Corinna Vinschen  <corinna@vinschen.de>
 
 	* faq-using.xml (faq.using.ipv6): Try to clarify OS specific support.
Index: faq-using.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-using.xml,v
retrieving revision 1.25
diff -p -u -r1.25 faq-using.xml
--- faq-using.xml	23 Jul 2009 08:49:06 -0000	1.25
+++ faq-using.xml	12 Aug 2009 22:02:45 -0000
@@ -1077,7 +1077,7 @@ behaviour which affect the operation of 
 <para>Among the software that has been found to cause difficulties are:</para>
 <para><itemizedlist>
 <listitem><para>Sonic Solutions burning software containing DLA component (when DLA disabled)</para></listitem>
-<listitem><para>Norton/MacAfee/Symantec antivirus or antispyware</para></listitem>
+<listitem><para>Norton/McAfee/Symantec antivirus or antispyware</para></listitem>
 <listitem><para>Logitech webcam software with "Logitech process monitor" service</para></listitem>
 <listitem><para>Kerio, Agnitum or ZoneAlarm Personal Firewall</para></listitem>
 <listitem><para>Iolo System Mechanic/AntiVirus/Firewall</para></listitem>

--------------000002080008070604060409--

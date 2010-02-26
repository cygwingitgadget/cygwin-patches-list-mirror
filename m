Return-Path: <cygwin-patches-return-6982-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9147 invoked by alias); 26 Feb 2010 05:51:46 -0000
Received: (qmail 9117 invoked by uid 22791); 26 Feb 2010 05:51:44 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f191.google.com (HELO mail-qy0-f191.google.com) (209.85.221.191)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 26 Feb 2010 05:51:39 +0000
Received: by qyk29 with SMTP id 29so1723939qyk.15         for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2010 21:51:37 -0800 (PST)
Received: by 10.224.103.69 with SMTP id j5mr200762qao.158.1267163497348;         Thu, 25 Feb 2010 21:51:37 -0800 (PST)
Received: from ?127.0.0.1? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 21sm1652077qyk.5.2010.02.25.21.51.35         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Thu, 25 Feb 2010 21:51:35 -0800 (PST)
Message-ID: <4B87616D.7050602@users.sourceforge.net>
Date: Fri, 26 Feb 2010 05:51:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define SIGPWR
References: <4B875901.6010906@users.sourceforge.net> <20100226052655.GA22741@ednor.casa.cgf.cx>
In-Reply-To: <20100226052655.GA22741@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------050006030007000506040002"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00098.txt.bz2

This is a multi-part message in MIME format.
--------------050006030007000506040002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 469

On 2010-02-25 23:26, Christopher Faylor wrote:
> On Thu, Feb 25, 2010 at 11:15:45PM -0600, Yaakov (Cygwin/X) wrote:
>> 2010-02-25  Yaakov Selkowitz<yselkowitz@users.sourceforge.net>
>>
>> 	* include/cygwin/signal.h: Define SIGPWR as synonym for SIGLOST.
>> 	* strsig.cc: Ditto.
>> 	* include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR.
>
> Looks good.  Please check in.
>
> cgf

Thanks, committed.  Corresponding patch for doc/new-features.sgml attached.


Yaakov

--------------050006030007000506040002
Content-Type: text/plain;
 name="doc-new-features-SIGPWR.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="doc-new-features-SIGPWR.patch"
Content-length: 775

2010-02-25  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* new-features.sgml (ov-new1.7.2): Add SIGPWR support.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.37
diff -u -r1.37 new-features.sgml
--- new-features.sgml	25 Feb 2010 16:27:39 -0000	1.37
+++ new-features.sgml	26 Feb 2010 05:48:59 -0000
@@ -74,6 +74,7 @@
 Support open(2) flags O_CLOEXEC and O_TTY_INIT flags.  Support fcntl
 flag F_DUPFD_CLOEXEC.  Support socket flags SOCK_CLOEXEC and SOCK_NONBLOCK.
 Add new Linux-compatible API calls accept4(2), dup3(2), and pipe2(2).
+Support the signal SIGPWR.
 </para></listitem>
 
 <listitem><para>Enhanced Windows console support.</para>

--------------050006030007000506040002--

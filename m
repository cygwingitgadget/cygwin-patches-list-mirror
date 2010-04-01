Return-Path: <cygwin-patches-return-7018-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27089 invoked by alias); 1 Apr 2010 02:25:01 -0000
Received: (qmail 27058 invoked by uid 22791); 1 Apr 2010 02:25:00 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_LOW,TW_RX
X-Spam-Check-By: sourceware.org
Received: from out3.smtp.messagingengine.com (HELO out3.smtp.messagingengine.com) (66.111.4.27)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 01 Apr 2010 02:24:55 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 5934BEA61D 	for <cygwin-patches@cygwin.com>; Wed, 31 Mar 2010 22:24:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute2.internal (MEProxy); Wed, 31 Mar 2010 22:24:54 -0400
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id A0D974C72DF; 	Wed, 31 Mar 2010 22:24:53 -0400 (EDT)
Message-ID: <4BB403D7.5030909@cwilson.fastmail.fm>
Date: Thu, 01 Apr 2010 02:25:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: FW: special font characters in rxvt
References: <4BABAE0A.7090903@bopp.net>  <2BF01EB27B56CC478AD6E5A0A28931F2D14369@A1DAL1SWPES19MB.ams.acs-inc.net>  <4BB3CD56.1040901@cwilson.fastmail.fm> <20100401002731.GB24706@ednor.casa.cgf.cx>
In-Reply-To: <20100401002731.GB24706@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------020304040706040409020603"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00001.txt.bz2

This is a multi-part message in MIME format.
--------------020304040706040409020603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 269

On 3/31/2010 8:27 PM, Christopher Faylor wrote:
> On Wed, Mar 31, 2010 at 06:31:50PM -0400, Charles Wilson wrote:
>> Good idea. How about this (followup to cygwin-patches):
> 
> I think you need to do a "cvs update".

Ah.  OK...how about this slight tweak...

--
Chuck

--------------020304040706040409020603
Content-Type: text/plain;
 name="discourage-rxvt.patch-tweak"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="discourage-rxvt.patch-tweak"
Content-length: 1482

? newlib/autoredo
? newlib/libc/libc.info
? newlib/libm/libm.info
? winsup/0000_patch
? winsup/0001_patch
? winsup/0002_patch
? winsup/0003_patch
? winsup/0004_patch
? winsup/0006_patch
? winsup/0007_patch
? winsup/0008_patch
? winsup/0009_patch
? winsup/0010_patch
? winsup/0010_patchA
? winsup/0011_patch
? winsup/0012_patch
? winsup/A-0000.patch
? winsup/A-0000a.patch
? winsup/A-0001-0002.patch
? winsup/A-0001.patch
? winsup/A-0002.patch
? winsup/B-0001.patch
? winsup/B-0002.patch
? winsup/B-0003.patch
? winsup/B-0004.patch
? winsup/cygwin/bob
? winsup/cygwin/cvsps.out
? winsup/cygwin/cygdll-build
Index: winsup/doc/setup-net.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/setup-net.sgml,v
retrieving revision 1.23
diff -u -p -r1.23 setup-net.sgml
--- winsup/doc/setup-net.sgml	31 Mar 2010 21:06:43 -0000	1.23
+++ winsup/doc/setup-net.sgml	1 Apr 2010 02:20:52 -0000
@@ -215,8 +215,9 @@ shows progress bars for the current task
 <para>
 You may choose to install shortcuts on the Desktop and/or Start Menu
 to start a <literal>bash</literal> shell. If you prefer to use a different
-shell or the native Windows version of <literal>mintty</literal> or <literal>rxvt</literal>, you can
-use these shortcuts as a guide to creating your own. 
+shell or terminal emulator such as <literal>mintty</literal> or
+<literal>xterm</literal>, you can use these shortcuts as a guide to
+creating your own. 
 </para>
 </sect2>
 

--------------020304040706040409020603--

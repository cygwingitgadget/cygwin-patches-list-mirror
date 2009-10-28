Return-Path: <cygwin-patches-return-6807-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28421 invoked by alias); 28 Oct 2009 02:25:21 -0000
Received: (qmail 28405 invoked by uid 22791); 28 Oct 2009 02:25:20 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.146)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 28 Oct 2009 02:25:13 +0000
Received: by qw-out-1920.google.com with SMTP id 4so80520qwk.20         for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2009 19:25:11 -0700 (PDT)
Received: by 10.224.105.73 with SMTP id s9mr8954177qao.78.1256696711432;         Tue, 27 Oct 2009 19:25:11 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 22sm287294qyk.2.2009.10.27.19.25.10         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Tue, 27 Oct 2009 19:25:10 -0700 (PDT)
Message-ID: <4AE7AB8A.308@users.sourceforge.net>
Date: Wed, 28 Oct 2009 02:25:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] Case-sensitive programs exist but cannot both be run
References: <4AD7F017.5080609@users.sourceforge.net> <20091016080302.GO27964@calimero.vinschen.de> <4AD832FB.2050901@users.sourceforge.net> <4AD8393C.6040805@lysator.liu.se> <20091016100210.GC31638@calimero.vinschen.de>
In-Reply-To: <20091016100210.GC31638@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------020502020308070407090902"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00138.txt.bz2

This is a multi-part message in MIME format.
--------------020502020308070407090902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 275

On 16/10/2009 05:02, Corinna Vinschen wrote:
> Something along the lines of "there's no way to determine which one of
> it will be started since starting applications is still case-insensitive
> due to WIndows limitations" might make sense.

Revised patch attached.


Yaakov

--------------020502020308070407090902
Content-Type: text/x-patch;
 name="doc-pathnames-programs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="doc-pathnames-programs.patch"
Content-length: 1581

2009-10-27  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* pathnames.sgml: Add limitation of case sensitivity with CreateProcess.

Index: pathnames.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/pathnames.sgml,v
retrieving revision 1.46
diff -u -r1.46 pathnames.sgml
--- pathnames.sgml	9 Oct 2009 11:19:18 -0000	1.46
+++ pathnames.sgml	28 Oct 2009 02:24:10 -0000
@@ -489,10 +489,14 @@
 </note>
 
 <para>After you set this registry value to 0, Cygwin will be case-sensitive
-by default on NTFS and NFS filesystems.  Be aware that using two filenames
-which only differ by case might result in some weird interoperability
-issues with native Win32 applications.  You're using case-sensitivity 
-at your own risk.  You have been warned!</para>
+by default on NTFS and NFS filesystems.  However, there are limitations: 
+while two <emphasis role='bold'>programs</emphasis> <filename>Abc.exe</filename>
+and <filename>aBc.exe</filename> can be created and accessed like other files,
+starting applications is still case-insensitive due to Windows limitations
+and so the program you try to launch may not be the one actually started.  Also,
+be aware that using two filenames which only differ by case might
+result in some weird interoperability issues with native Win32 applications.  
+You're using case-sensitivity at your own risk.  You have been warned! </para>
 
 <para>Even if you use case-sensitivity, it might be feasible to switch to
 case-insensitivity for certain paths for better interoperability with

--------------020502020308070407090902--

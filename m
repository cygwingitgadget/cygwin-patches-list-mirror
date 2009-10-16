Return-Path: <cygwin-patches-return-6774-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4384 invoked by alias); 16 Oct 2009 08:46:49 -0000
Received: (qmail 4364 invoked by uid 22791); 16 Oct 2009 08:46:47 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f187.google.com (HELO mail-qy0-f187.google.com) (209.85.221.187)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 16 Oct 2009 08:46:42 +0000
Received: by qyk17 with SMTP id 17so2092907qyk.2         for <cygwin-patches@cygwin.com>; Fri, 16 Oct 2009 01:46:40 -0700 (PDT)
Received: by 10.224.32.204 with SMTP id e12mr840585qad.256.1255682800670;         Fri, 16 Oct 2009 01:46:40 -0700 (PDT)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 6sm1819913qwk.4.2009.10.16.01.46.39         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Fri, 16 Oct 2009 01:46:39 -0700 (PDT)
Message-ID: <4AD832FB.2050901@users.sourceforge.net>
Date: Fri, 16 Oct 2009 08:46:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] Case-sensitive programs exist but cannot both be run
References: <4AD7F017.5080609@users.sourceforge.net> <20091016080302.GO27964@calimero.vinschen.de>
In-Reply-To: <20091016080302.GO27964@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------020005070202000209000709"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00105.txt.bz2

This is a multi-part message in MIME format.
--------------020005070202000209000709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 585

On 16/10/2009 03:03, Corinna Vinschen wrote:
> On Oct 15 23:01, Yaakov S wrote:
>> It appears that two EXEs can coexist (with the registry setting) but only
>> whichever one was so named first will be run:
>> [...]
>> Bug?  Limitation?  If it hurts, don't do that?
>
> Limitation.  While we can do everything with files using native NT
> calls, we can't use NtCreateProcess to create new processes.  We
> have to use CreateProcess, and there's no flag available which defines
> case-sensitivity for this call, unfortunately.

In that case, let's document it.  Patch attached.


Yaakov

--------------020005070202000209000709
Content-Type: text/plain;
 name="doc-pathnames-programs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="doc-pathnames-programs.patch"
Content-length: 1507

2009-10-16  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* pathnames.sgml: Add limitation of case sensitivity with CreateProcess.

Index: pathnames.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/pathnames.sgml,v
retrieving revision 1.46
diff -u -r1.46 pathnames.sgml
--- pathnames.sgml	9 Oct 2009 11:19:18 -0000	1.46
+++ pathnames.sgml	16 Oct 2009 08:43:44 -0000
@@ -489,10 +489,13 @@
 </note>
 
 <para>After you set this registry value to 0, Cygwin will be case-sensitive
-by default on NTFS and NFS filesystems.  Be aware that using two filenames
-which only differ by case might result in some weird interoperability
-issues with native Win32 applications.  You're using case-sensitivity 
-at your own risk.  You have been warned!</para>
+by default on NTFS and NFS filesystems.  However, there are limitations: 
+while two <emphasis role='bold'>programs</emphasis> <filename>Abc.exe</filename>
+and <filename>aBc.exe</filename> can be created and accessed like other files,
+trying to run either of them will always run whichever was so named first.  
+Also, be aware that using two filenames which only differ by case might
+result in some weird interoperability issues with native Win32 applications.  
+You're using case-sensitivity at your own risk.  You have been warned! </para>
 
 <para>Even if you use case-sensitivity, it might be feasible to switch to
 case-insensitivity for certain paths for better interoperability with

--------------020005070202000209000709--

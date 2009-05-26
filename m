Return-Path: <cygwin-patches-return-6523-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 634 invoked by alias); 26 May 2009 10:40:50 -0000
Received: (qmail 623 invoked by uid 22791); 26 May 2009 10:40:49 -0000
X-SWARE-Spam-Status: No, hits=-0.4 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_42
X-Spam-Check-By: sourceware.org
Received: from mail.sysgo.com (HELO mail.sysgo.com) (195.145.229.155)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 26 May 2009 10:40:44 +0000
Received: from donald.sysgo.com (unknown [172.20.1.30]) 	by mail.sysgo.com (Postfix) with ESMTP id AB2E37C6CE 	for <cygwin-patches@cygwin.com>; Tue, 26 May 2009 12:40:41 +0200 (CEST)
Received: from [172.22.55.10] (den.sysgo.com [172.22.55.10]) 	by donald.sysgo.com (Postfix) with ESMTP id 6332B269563 	for <cygwin-patches@cygwin.com>; Tue, 26 May 2009 12:40:43 +0200 (CEST)
Message-ID: <4A1BC73F.5090300@sysgo.com>
Date: Tue, 26 May 2009 10:40:00 -0000
From: David Engraf <david.engraf@sysgo.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Re: [1.5] ls -l on /cygdrive/d doesn't work
Content-Type: multipart/mixed;  boundary="------------030702080705080307090405"
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
X-SW-Source: 2009-q2/txt/msg00065.txt.bz2

This is a multi-part message in MIME format.
--------------030702080705080307090405
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1



--------------030702080705080307090405
Content-Type: message/rfc822;
 name="[PATCH] Re: [1.5] ls -l on /cygdrive/d doesn't work.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="[PATCH] Re: [1.5] ls -l on /cygdrive/d doesn't work.eml"
Content-length: 7734

Return-Path: <cygwin-return-150917-david.engraf=sysgo.com@cygwin.com>
Received: from donald.sysgo.com ([unix socket])
	by donald (Cyrus v2.1.16) with LMTP; Tue, 26 May 2009 12:26:22 +0200
X-Sieve: CMU Sieve 2.2
Received: from mail.sysgo.com (mail.sysgo.com [195.145.229.155])
	by donald.sysgo.com (Postfix) with ESMTP id 835B3268AAC
	for <david.engraf@sysgo.com>; Tue, 26 May 2009 12:26:22 +0200 (CEST)
Received: by mail.sysgo.com (Postfix, from userid 1001)
	id C484660008; Tue, 26 May 2009 12:26:20 +0200 (CEST)
Received: from mail.sysgo.com (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 4CE487C6E8
	for <david.engraf@sysgo.com>; Tue, 26 May 2009 12:26:12 +0200 (CEST)
Received: from sourceware.org (sourceware.org [209.132.176.174])
	by mail.sysgo.com (Postfix) with SMTP id 6DAE07C6D8
	for <david.engraf@sysgo.com>; Tue, 26 May 2009 12:26:11 +0200 (CEST)
Received: (qmail 22717 invoked by alias); 26 May 2009 10:18:46 -0000
Received: (qmail 22704 invoked by uid 22791); 26 May 2009 10:18:45 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_42
Received: from mail.sysgo.com (HELO mail.sysgo.com) (195.145.229.155)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 26 May 2009 10:18:40 +0000
Received: from donald.sysgo.com (unknown [172.20.1.30]) 	by mail.sysgo.com (Postfix) with ESMTP id E753B7C6D8; 	Tue, 26 May 2009 12:18:32 +0200 (CEST)
Received: from [172.22.55.10] (den.sysgo.com [172.22.55.10]) 	by donald.sysgo.com (Postfix) with ESMTP 	id 7FAE6268AAC; Tue, 26 May 2009 12:18:34 +0200 (CEST)
Message-ID: <4A1BC20E.9030903@sysgo.com>
Date: Tue, 26 May 2009 12:18:54 +0200
From: David Engraf <david.engraf@sysgo.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: [PATCH] Re: [1.5] ls -l on /cygdrive/d doesn't work
References: <4A1A94DB.1090807@sysgo.com> <4A1B9A10.3000203@sysgo.com>
In-Reply-To: <4A1B9A10.3000203@sysgo.com>
Content-Type: multipart/mixed;  boundary="------------080200030508020006000307"
X-IsSubscribed: yes
Mailing-List: contact cygwin-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin.cygwin.com>
List-Unsubscribe: <mailto:cygwin-unsubscribe-david.engraf=sysgo.com@cygwin.com>
List-Subscribe: <mailto:cygwin-subscribe@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin/>
List-Post: <mailto:cygwin@cygwin.com>
List-Help: <mailto:cygwin-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-owner@cygwin.com
Mail-Followup-To: cygwin@cygwin.com
Delivered-To: mailing list cygwin@cygwin.com
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mailgate.sysgo.com
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=SPF_HELO_PASS,TW_CP 
	autolearn=disabled version=3.0.3


--------------080200030508020006000307
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 3470

I have fixed the error in ntea.cc handling the return value of 
NTQueryEaFile. This patch is only needed for the 1.5 release. Maybe this 
error should be considered as critical due to uninitialized stack usage 
of the variable fea when the function returned an error.


2009-05-26 David Engraf <david.engraf@sysgo.com>

	* ntea.cc (read_ea): Fix error handling and avoid using
	uninitialized stack.


David Engraf schrieb:
> I think this error is located in the cygwin/ntea.cc read_ea function. 
> NtQueryEaFile fails due to unsupported extended attributes on fat32 and 
> iso9660 and ret is set to -1. After setting ret to -1 the function 
> checks fea->EaValueLength which is in my case 8313 (see log) due to an 
> uninitialized stack and read_ea return 8313. Now the calling function 
> (fhandler_base::fstat_helper) is using the uninitialized data for the 
> timestamp and file size and returns incorrect values.
> This error doesn't happen on the new 1.7 release, but I need a solution 
> for the stable version.
> 
> 
> if (!NT_SUCCESS (status))
>     {
>       ret = -1;
>       debug_printf ("%x = NtQueryEaFile (%s, %s), Win32 error %d",
>                     status, file, attrname, RtlNtStatusToDosError 
> (status));
>     }
>   if (!fea->EaValueLength)
>     ret = 0;
>   else
>     {
>       memcpy (attrbuf, fea->EaName + fea->EaNameLength + 1,
>               fea->EaValueLength);
>       ret = fea->EaValueLength;
>     }
> 
> 
> 
> David Engraf schrieb:
>> Hi,
>>
>> I have encountered a problem while listening the content of a CD. When 
>> I call "ls -l /cygdrive/d" the file size and creation/modification 
>> time is corrupted. This also happens on usb sticks formatted with 
>> fat32. Only ntfs formatted filesystems have the correct listening.
>> Attached is a strace log calling the function fstat on a file located 
>> on the specified filesystem.
>>
>> //ISO9660
>> get_file_attribute: file: d:\README.txt
>> read_ea: 1. chance, C0000010 = NtQueryEaFile (d:\README.txt, 
>> .UNIXATTR), Win32 error 1
>> read_ea: C0000010 = NtQueryEaFile (d:\README.txt, .UNIXATTR), Win32 
>> error 1
>> read_ea: 8313 = read_ea (0, d:\README.txt, .UNIXATTR, 22A9F0, 4)
>> fhandler_base::fstat_helper: 0 = fstat (, 0x22A9E0) st_atime=6B126FF 
>> st_size=-40681930227712, st_mode=0x22A9F061, 
>> st_ino=-4583408731929810241, sizeof=96
>> fstat64: 0 = fstat (3, 0x22A9E0)
>>
>>
>> //FAT32
>> get_file_attribute: file: e:\README.txt
>> read_ea: 1. chance, C000004F = NtQueryEaFile (e:\README.txt, 
>> .UNIXATTR), Win32 error 282
>> read_ea: C000004F = NtQueryEaFile (e:\README.txt, .UNIXATTR), Win32 
>> error 282
>> read_ea: 8313 = read_ea (0, e:\README.txt, .UNIXATTR, 22A9F0, 4)
>> fhandler_base::fstat_helper: 0 = fstat (, 0x22A9E0) st_atime=6D7072 
>> st_size=3328772759537140781, st_mode=0x22A9F061, 
>> st_ino=-3532118121688219773, sizeof=96
>> fstat64: 0 = fstat (3, 0x22A9E0)
>>
>>
>> //NTFS
>> get_file_attribute: file: c:\README.txt
>> read_ea: 0 = read_ea (6BC, c:\README.txt, .UNIXATTR, 22A410, 4)
>> fhandler_base::fstat_helper: 0 = fstat (, 0x22A400) st_atime=4A1A7CA3 
>> st_size=3088, st_mode=0x8124, st_ino=3096224743855743, sizeof=96
>> fstat64: 0 = fstat (6, 0x22A400)
>>
>>
>> Thank you
>>
> 

-- 
David Engraf
Product Engineer

SYSGO AG
Office Mainz
Am Pfaffenstein 14 / D-55270 Klein-Winternheim / Germany

Handelsregister: HRB Mainz 90 HRB 8066
Vorstand: Michael Tiedemann
Aufsichtsratsvorsitzender: Knut Degen
USt(VAT)-Id-Nr.: DE 149062328

--------------080200030508020006000307
Content-Type: text/x-diff;
 name="fix_ntea.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_ntea.patch"
Content-length: 778

--- cygwin-1.5.25-15/winsup/cygwin/ntea.cc_orig	2008-04-16 14:57:15.000000000 +0200
+++ cygwin-1.5.25-15/winsup/cygwin/ntea.cc	2009-05-26 12:05:39.000000000 +0200
@@ -85,13 +85,16 @@ read_ea (HANDLE hdl, const char *file, c
       debug_printf ("%x = NtQueryEaFile (%s, %s), Win32 error %d",
 		    status, file, attrname, RtlNtStatusToDosError (status));
     }
-  if (!fea->EaValueLength)
-    ret = 0;
   else
     {
-      memcpy (attrbuf, fea->EaName + fea->EaNameLength + 1,
-	      fea->EaValueLength);
-      ret = fea->EaValueLength;
+      if (!fea->EaValueLength)
+        ret = 0;
+      else
+        {
+          memcpy (attrbuf, fea->EaName + fea->EaNameLength + 1,
+	          fea->EaValueLength);
+          ret = fea->EaValueLength;
+        }
     }
 
 out:


--------------080200030508020006000307
Content-Type: text/plain; charset=us-ascii
Content-length: 218

--
Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
Problem reports:       http://cygwin.com/problems.html
Documentation:         http://cygwin.com/docs.html
FAQ:                   http://cygwin.com/faq/
--------------080200030508020006000307--

--------------030702080705080307090405--

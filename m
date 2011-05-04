Return-Path: <cygwin-patches-return-7300-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11190 invoked by alias); 4 May 2011 20:10:24 -0000
Received: (qmail 11147 invoked by uid 22791); 4 May 2011 20:10:15 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout03.t-online.de (HELO mailout03.t-online.de) (194.25.134.81)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 04 May 2011 20:10:01 +0000
Received: from fwd20.aul.t-online.de (fwd20.aul.t-online.de )	by mailout03.t-online.de with smtp 	id 1QHiOT-00063A-L7; Wed, 04 May 2011 22:09:57 +0200
Received: from [192.168.2.100] (SaP+bcZ-8hyp6P97DwDVRhlsX88MbgB1bflpSgx+ncStI88Ijj3S3R8mGwkqGiEw61@[79.224.116.155]) by fwd20.aul.t-online.de	with esmtp id 1QHiOO-1YmfFw0; Wed, 4 May 2011 22:09:52 +0200
Message-ID: <4DC1B292.70201@t-online.de>
Date: Wed, 04 May 2011 20:10:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.17) Gecko/20110123 SeaMonkey/2.0.12
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] False positive from access("/proc/registry/...", F_OK)
Content-Type: multipart/mixed; boundary="------------000701020307010407020502"
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
X-SW-Source: 2011-q2/txt/msg00066.txt.bz2

This is a multi-part message in MIME format.
--------------000701020307010407020502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 982

Corinna Vinschen wrote:
> On Apr 27 12:26, Christian Franke wrote:
>    
>> access("/proc/registry/...", F_OK) returns 0 for all (including
>> nonexistent) entries below a registry key which cannot be opened:
>>
>> ...
>>
>> Problem was likely introduced by fhandler_registry.cc change 1.52:
>>
>>   fhandler_registry::exists ()
>>   ...
>>     if (!val_only)
>>       hKey = open_key (path, KEY_READ, wow64, false);
>>   - if (hKey != (HKEY) INVALID_HANDLE_VALUE)
>>   + if (hKey != (HKEY) INVALID_HANDLE_VALUE || get_errno () == EACCES)
>>       file_type = 1;
>>     else
>>
>> open_key() returns INVALID_HANDLE_VALUE and EACCESS also if an upper
>> level key cannot be opened. The exists() function returns 1
>> (virt_directory) then, it should return 0 (virt_none).
>>      
> I don't remember anymore why I did that and naturally I also didn't
> write a comment.
>
> But what you say sounds right to me.  Please create a patch.
>
>    

Done, tested and attached.

Christian


--------------000701020307010407020502
Content-Type: text/x-patch;
 name="registry-fix-eacces.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="registry-fix-eacces.patch"
Content-length: 1273

2011-05-04  Christian Franke  <franke@computer.org>

	* fhandler_registry.cc (fhandler_registry::exists): Fix regression
	in EACCES handling.
	(fhandler_registry::open): Fix "%val" case.

diff --git a/winsup/cygwin/fhandler_registry.cc b/winsup/cygwin/fhandler_registry.cc
index f2e80ce..beeb0ed 100644
--- a/winsup/cygwin/fhandler_registry.cc
+++ b/winsup/cygwin/fhandler_registry.cc
@@ -317,10 +317,12 @@ fhandler_registry::exists ()
 
       if (!val_only)
 	hKey = open_key (path, KEY_READ, wow64, false);
-      if (hKey != (HKEY) INVALID_HANDLE_VALUE || get_errno () == EACCES)
+      if (hKey != (HKEY) INVALID_HANDLE_VALUE)
 	file_type = virt_directory;
       else
 	{
+	  /* Key does not exist or open failed with EACCESS,
+	     enumerate subkey and value names of parent key.  */
 	  hKey = open_key (path, KEY_READ, wow64, true);
 	  if (hKey == (HKEY) INVALID_HANDLE_VALUE)
 	    return virt_none;
@@ -797,7 +799,7 @@ fhandler_registry::open (int flags, mode_t mode)
 	handle = open_key (path, KEY_READ, wow64, false);
       if (handle == (HKEY) INVALID_HANDLE_VALUE)
 	{
-	  if (get_errno () != EACCES)
+	  if (val_only || get_errno () != EACCES)
 	    handle = open_key (path, KEY_READ, wow64, true);
 	  if (handle == (HKEY) INVALID_HANDLE_VALUE)
 	    {

--------------000701020307010407020502--

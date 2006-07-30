Return-Path: <cygwin-patches-return-5950-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10643 invoked by alias); 30 Jul 2006 13:25:06 -0000
Received: (qmail 10628 invoked by uid 22791); 30 Jul 2006 13:25:05 -0000
X-Spam-Check-By: sourceware.org
Received: from jerry.kiev.farlep.net (HELO jerry.kiev.farlep.net) (213.130.24.8)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 30 Jul 2006 13:25:01 +0000
Received: from ilya.kiev.farlep.net ([62.221.47.37]) 	by jerry.kiev.farlep.net with esmtps (TLSv1:AES256-SHA:256) 	(Exim 4.62 (FreeBSD)) 	(envelope-from <ilya@po4ta.com>) 	id 1G7BHt-000E7i-Ku 	for cygwin-patches@cygwin.com; Sun, 30 Jul 2006 16:24:57 +0300
Message-ID: <44CCB327.6010607@po4ta.com>
Date: Sun, 30 Jul 2006 13:25:00 -0000
From: Ilya <ilya@po4ta.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Bug fix and enchantment in cygpath.cc
References: <44CB2A70.9020807@po4ta.com> <20060730124524.GC8152@calimero.vinschen.de>
In-Reply-To: <20060730124524.GC8152@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------000606030702000704050000"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00045.txt.bz2

This is a multi-part message in MIME format.
--------------000606030702000704050000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 711

Corinna Vinschen wrote:
> On Jul 29 12:29, Ilya wrote:
>   
>> This patch is against cygpath.cc 1.42.
>> In 1.43 addressed bug was already fixed, but I believe my fix is a bit 
>> better.
>>
>> Current fix just returns filename, in case filename is for a nonexistent 
>> file.  I think that internal short to long file name conversion routine 
>> could be used in this case, because it deals ok with nonexistent files.
>>     
>
> If you could regenerate your patch so that it's against current CVS, I
> will take it, since its size will then be below the "trivial fix" rule.
> Please see http://cygwin.com/contrib.html, "Before you get started",
> second paragraph.
>
>
> Thanks,
> Corinna
>   
No problem :)


--------------000606030702000704050000
Content-Type: text/plain;
 name="cygpath.cc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygpath.cc.patch"
Content-length: 889

--- cygpath.cc.orig	2006-07-30 16:15:30.390625000 +0300
+++ cygpath.cc	2006-07-30 16:15:05.953125000 +0300
@@ -241,15 +241,24 @@ get_long_name (const char *filename, DWO
   len = GetLongPathName (filename, buf, MAX_PATH);
   if (len == 0)
     {
-      if (GetLastError () == ERROR_INVALID_PARAMETER)
+      DWORD err = GetLastError ();
+
+      if (err == ERROR_INVALID_PARAMETER)
 	{
 	  fprintf (stderr, "%s: cannot create long name of %s\n", prog_name,
-		   filename);
+	       	   filename);
 	  exit (2);
 	}
-      buf[0] = '\0';
-      strncat (buf, filename, MAX_PATH - 1);
-      len = strlen (buf);
+      else if (err == ERROR_FILE_NOT_FOUND)
+	{
+	  len = get_long_path_name_w32impl (filename, buf, MAX_PATH);
+	}
+      else
+	{
+	  buf[0] = 0;
+	  strncat (buf, filename, MAX_PATH - 1);
+	  len = strlen (buf);
+	}
     }
   sbuf = (char *) malloc (len + 1);
   if (!sbuf)

--------------000606030702000704050000
Content-Type: text/plain;
 name="ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog"
Content-length: 146

2006-07-03  Ilya Bobir  <ilya@po4ta.com>

	* cygpath.cc (get_long_name): Fallback to get_long_path_name_w32impl.
	Properly null-terminate 'buf'.


--------------000606030702000704050000--

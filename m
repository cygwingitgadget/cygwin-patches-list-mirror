Return-Path: <cygwin-patches-return-5347-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25072 invoked by alias); 10 Feb 2005 14:38:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24926 invoked from network); 10 Feb 2005 14:38:37 -0000
Received: from unknown (HELO pmesmtp04.mci.com) (199.249.20.36)
  by sourceware.org with SMTP; 10 Feb 2005 14:38:37 -0000
Received: from pmismtp02.mcilink.com ([166.38.62.37])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0IBP009EB9XLX1@firewall.mci.com> for cygwin-patches@cygwin.com;
 Thu, 10 Feb 2005 14:36:57 +0000 (GMT)
Received: from pmismtp02.mcilink.com by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0IBP00M019VLOX@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Thu, 10 Feb 2005 14:36:57 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.133.100])
 by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0IBP00MJ89WZDK@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Thu, 10 Feb 2005 14:36:35 +0000 (GMT)
Date: Thu, 10 Feb 2005 14:38:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
In-reply-to: <20050210104551.GX2597@cygbert.vinschen.de>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0IBP00MJ99WZDK@pmismtp02.mcilink.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Priority: Normal
X-SW-Source: 2005-q1/txt/msg00050.txt.bz2

That looks like it should do the trick.  I just ran this on a 
samba mounted FS, and FILE_PERSISTENT_ACLS is 
true, and it does support the touch using FILE_WRITE_ATTRIBUTES.
I have asked Andrew DeFaria to compile/run your test program
on his Clearcase volume, to see if it follows the same trend.
If it does, then I would say you have found the root cause, and 
your fix looks like it'll work.

On Thu, 10 Feb 2005 11:45:51 +0100, Corinna Vinschen wrote:

>On Feb  9 10:27, Mark Paulus wrote:
>> I'm not exactly giving up.  It's just that at this point it looks like
>> the fix will not be trivial, and since my company will not endorse
>> a Waiver, I'm limited in the scope of fixes I can provide.  However,
>> I am more than willing to provide any testing/debugging services
>> that are needed.  The other issue is that this does not seem to be
>> a huge issue, since it hasn't surfaced too much previous to this.

>True.  I guess that there are not a lot of people out there using HPFS
>anymore.  But if there's an easy solution, why not include it anyway?

>> rootdir: z:\
>> Volume Name        : <>
>> Serial Number      : 2834707476
>> Max Filenamelength : 254
>> Filesystemname     : <??SS>
>> Flags:
>>   FILE_CASE_SENSITIVE_SEARCH  : FALSE
>>   FILE_CASE_PRESERVED_NAMES   : TRUE
>>   FILE_UNICODE_ON_DISK        : FALSE
>>   FILE_PERSISTENT_ACLS        : FALSE
>>   FILE_FILE_COMPRESSION       : FALSE
>>   FILE_VOLUME_QUOTAS          : FALSE
>>   FILE_SUPPORTS_SPARSE_FILES  : FALSE
>>   FILE_SUPPORTS_REPARSE_POINTS: FALSE
>>   FILE_SUPPORTS_REMOTE_STORAGE: FALSE
>>   FILE_VOLUME_IS_COMPRESSED   : FALSE
>>   FILE_SUPPORTS_OBJECT_IDS    : FALSE
>>   FILE_SUPPORTS_ENCRYPTION    : FALSE
>>   FILE_NAMED_STREAMS          : FALSE
>>   FILE_READ_ONLY_VOLUME       : FALSE

>The filesystemname is [insert 4-letter word here], really.

>However, that let me rethink what I stated yesterday in my reply to
>Yitzchak.  The original patch, which introduced the usage of
>FILE_WRITE_ATTRIBUTES into utimes() made a decision based on the
>operating system.  Without looking into the original code, it was
>roughly like this:

>  if (wincap.has_specific_attribs ())
>    attrib = FILE_WRITE_ATTRIBUTES;
>  else
>    attrib = GENERIC_WRITE;

>wincap.has_specific_attribs () returned true for NT systems and false
>for 9x systems.  At one point I just removed that stuff since it turned
>out that 9x perfectly understood specific attribs and probably translated
>them into something like GENERIC_WRITE internally.

>But, isn't that something which can be easily coupled to the file system?
>It seems that using FILE_WRITE_ATTRIBUTES only makes sense on file systems
>supporting FILE_PERSISTENT_ACLS, regardless which OS is running, isn't it?
>So, what if we just use the has_acls() attribute of path_conv to make the
>decision?

>  if (win32.has_acls ())
>    attrib = FILE_WRITE_ATTRIBUTES;
>  else
>    attrib = GENERIC_WRITE;

>Thoughts?


>Corinna

>-- 
>Corinna Vinschen                  Please, send mails regarding Cygwin to
>Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
>Red Hat, Inc.



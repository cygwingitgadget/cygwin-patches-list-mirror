Return-Path: <cygwin-patches-return-5343-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20298 invoked by alias); 9 Feb 2005 17:28:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20060 invoked from network); 9 Feb 2005 17:28:10 -0000
Received: from unknown (HELO omzesmtp03.mci.com) (199.249.17.11)
  by sourceware.org with SMTP; 9 Feb 2005 17:28:10 -0000
Received: from pmismtp02.mcilink.com ([166.38.62.37])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0IBN000D3N667H@firewall.mci.com> for cygwin-patches@cygwin.com;
 Wed, 09 Feb 2005 17:27:42 +0000 (GMT)
Received: from pmismtp02.mcilink.com by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0IBN00001N65QM@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Wed, 09 Feb 2005 17:27:41 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.133.100])
 by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0IBN000F1N648O@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Wed, 09 Feb 2005 17:27:41 +0000 (GMT)
Date: Wed, 09 Feb 2005 17:28:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
In-reply-to: <20050209085228.GF2597@cygbert.vinschen.de>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0IBN000F2N658O@pmismtp02.mcilink.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Priority: Normal
X-SW-Source: 2005-q1/txt/msg00046.txt.bz2

I'm not exactly giving up.  It's just that at this point it looks like
the fix will not be trivial, and since my company will not endorse
a Waiver, I'm limited in the scope of fixes I can provide.  However,
I am more than willing to provide any testing/debugging services
that are needed.  The other issue is that this does not seem to be
a huge issue, since it hasn't surfaced too much previous to this.


rootdir: z:\
Volume Name        : <>
Serial Number      : 2834707476
Max Filenamelength : 254
Filesystemname     : <??SS>
Flags:
  FILE_CASE_SENSITIVE_SEARCH  : FALSE
  FILE_CASE_PRESERVED_NAMES   : TRUE
  FILE_UNICODE_ON_DISK        : FALSE
  FILE_PERSISTENT_ACLS        : FALSE
  FILE_FILE_COMPRESSION       : FALSE
  FILE_VOLUME_QUOTAS          : FALSE
  FILE_SUPPORTS_SPARSE_FILES  : FALSE
  FILE_SUPPORTS_REPARSE_POINTS: FALSE
  FILE_SUPPORTS_REMOTE_STORAGE: FALSE
  FILE_VOLUME_IS_COMPRESSED   : FALSE
  FILE_SUPPORTS_OBJECT_IDS    : FALSE
  FILE_SUPPORTS_ENCRYPTION    : FALSE
  FILE_NAMED_STREAMS          : FALSE
  FILE_READ_ONLY_VOLUME       : FALSE

On Wed, 09 Feb 2005 09:52:28 +0100, Corinna Vinschen wrote:

>On Feb  8 14:38, Mark Paulus wrote:
>> Well, all I can say, is "That's Uuuugggllleeeyyyyy".....
>> 
>> When I print fsname on the HPFS mounted volume, 
>> I get back '??SS'.  What the heck is that???  Somehow,
>> I'm guessing that's not something I want to be doing a 
>> string comparison on, for any kind of stability purpose.
>> 
>> Guess I'll live with not being able to 'touch' on mounted
>> HPFS volumes, and not do builds on that remote volume.
>> 
>> Sheesh, what a pain.  Thanks for the pointers, tho.

>Hey, why do you give up so quickly?  If it's not the one way, it might
>be another one.  For us unknowing folks which have no OS/2 box with
>HPFS to mount, would you mind to run the below application on your NT
>box and paste the output into the reply?  I'm curious to see the result.
>On NTFS, it looks like this:

>$ ./getvolinfo `pwd`
>rootdir: C:\
>Volume Name        : <>
>Serial Number      : 813830114
>Max Filenamelength : 255
>Filesystemname     : <NTFS>
>Flags:
>  FILE_CASE_SENSITIVE_SEARCH  : TRUE
>  FILE_CASE_PRESERVED_NAMES   : TRUE
>  FILE_UNICODE_ON_DISK        : TRUE
>  FILE_PERSISTENT_ACLS        : TRUE
>  FILE_FILE_COMPRESSION       : TRUE
>  FILE_VOLUME_QUOTAS          : TRUE
>  FILE_SUPPORTS_SPARSE_FILES  : TRUE
>  FILE_SUPPORTS_REPARSE_POINTS: TRUE
>  FILE_SUPPORTS_REMOTE_STORAGE: FALSE
>  FILE_VOLUME_IS_COMPRESSED   : FALSE
>  FILE_SUPPORTS_OBJECT_IDS    : TRUE
>  FILE_SUPPORTS_ENCRYPTION    : TRUE
>  FILE_NAMED_STREAMS          : TRUE
>  FILE_READ_ONLY_VOLUME       : FALSE


>Corinna




Return-Path: <cygwin-patches-return-5346-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21360 invoked by alias); 10 Feb 2005 14:34:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21235 invoked from network); 10 Feb 2005 14:34:27 -0000
Received: from unknown (HELO omzesmtp04.mci.com) (199.249.17.14)
  by sourceware.org with SMTP; 10 Feb 2005 14:34:27 -0000
Received: from pmismtp02.mcilink.com ([166.38.62.37])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0IBP00HMJ9TE0W@firewall.mci.com> for cygwin-patches@cygwin.com;
 Thu, 10 Feb 2005 14:34:27 +0000 (GMT)
Received: from pmismtp02.mcilink.com by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0IBP00M019SYLI@pmismtp02.mcilink.com>; Thu,
 10 Feb 2005 14:34:26 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.133.100])
 by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0IBP00MBU9T7DK@pmismtp02.mcilink.com>; Thu,
 10 Feb 2005 14:34:19 +0000 (GMT)
Date: Thu, 10 Feb 2005 14:34:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
In-reply-to: <20050209085228.GF2597@cygbert.vinschen.de>
To: "Andrew@DeFaria.com" <Andrew@DeFaria.com>,
 "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0IBP00MBW9T7DK@pmismtp02.mcilink.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Priority: Normal
X-SW-Source: 2005-q1/txt/msg00049.txt.bz2

I would also like to send this to Andrew DeFaria, since he
seems to have access to a ClearCase volume he was having
problems with.  

Andrew, could you compile and run the program below against
your Clearcase volume, and either return the results to 
cygwin-patches@cygwin.com, or to me, and I'll post them?

Thanks.


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

=================== SNIP =================== 
#include <stdio.h>
#include <string.h>
#define _WIN32_WINNT 0x0500
#include <windows.h>

#ifndef FILE_NAMED_STREAMS
#define FILE_NAMED_STREAMS 0x40000
#endif
#ifndef FILE_READ_ONLY_VOLUME
#define FILE_READ_ONLY_VOLUME 0x80000
#endif

int
main (int argc, char **argv)

  char winpath[256];
  char rootdir[256];
  char volname[256];
  char fsname[256];
  DWORD sernum = 0;
  DWORD maxlen = 0;
  DWORD flags = 0;

  if (argc < 2)
    {
      fprintf (stderr, "Doofi!\n");
      return 1;
    }
  cygwin_conv_to_full_win32_path (argv[1], winpath);
  if (!GetVolumePathName(winpath, rootdir, 256))
    {
      fprintf (stderr, "GetVolumePathName: %d\n", GetLastError ());
      return 1;
    }
  printf ("rootdir: %s\n", rootdir);
  if (!GetVolumeInformation (rootdir, volname, 256, &sernum,
  			     &maxlen, &flags, fsname, 256))
    {
      fprintf (stderr, "GetVolumeInformation: %d\n", GetLastError ());
      return 1;
    }
  printf ("Volume Name        : <%s>\n", volname);
  printf ("Serial Number      : %lu\n", sernum);
  printf ("Max Filenamelength : %lu\n", maxlen);
  printf ("Filesystemname     : <%s>\n", fsname);
  printf ("Flags:\n");

  printf ("  FILE_CASE_SENSITIVE_SEARCH  : %s\n",
  	  (flags & FILE_CASE_SENSITIVE_SEARCH) ? "TRUE" : "FALSE");

  printf ("  FILE_CASE_PRESERVED_NAMES   : %s\n",
  	  (flags & FILE_CASE_PRESERVED_NAMES) ? "TRUE" : "FALSE");

  printf ("  FILE_UNICODE_ON_DISK        : %s\n",
  	  (flags & FILE_UNICODE_ON_DISK) ? "TRUE" : "FALSE");

  printf ("  FILE_PERSISTENT_ACLS        : %s\n",
  	  (flags & FILE_PERSISTENT_ACLS) ? "TRUE" : "FALSE");

  printf ("  FILE_FILE_COMPRESSION       : %s\n",
  	  (flags & FILE_FILE_COMPRESSION) ? "TRUE" : "FALSE");

  printf ("  FILE_VOLUME_QUOTAS          : %s\n",
  	  (flags & FILE_VOLUME_QUOTAS) ? "TRUE" : "FALSE");

  printf ("  FILE_SUPPORTS_SPARSE_FILES  : %s\n",
  	  (flags & FILE_SUPPORTS_SPARSE_FILES) ? "TRUE" : "FALSE");

  printf ("  FILE_SUPPORTS_REPARSE_POINTS: %s\n",
  	  (flags & FILE_SUPPORTS_REPARSE_POINTS) ? "TRUE" : "FALSE");

  printf ("  FILE_SUPPORTS_REMOTE_STORAGE: %s\n",
  	  (flags & FILE_SUPPORTS_REMOTE_STORAGE) ? "TRUE" : "FALSE");

  printf ("  FILE_VOLUME_IS_COMPRESSED   : %s\n",
  	  (flags & FILE_VOLUME_IS_COMPRESSED) ? "TRUE" : "FALSE");

  printf ("  FILE_SUPPORTS_OBJECT_IDS    : %s\n",
  	  (flags & FILE_SUPPORTS_OBJECT_IDS) ? "TRUE" : "FALSE");

  printf ("  FILE_SUPPORTS_ENCRYPTION    : %s\n",
  	  (flags & FILE_SUPPORTS_ENCRYPTION) ? "TRUE" : "FALSE");

  printf ("  FILE_NAMED_STREAMS          : %s\n",
  	  (flags & FILE_NAMED_STREAMS) ? "TRUE" : "FALSE");

  printf ("  FILE_READ_ONLY_VOLUME       : %s\n",
  	  (flags & FILE_READ_ONLY_VOLUME) ? "TRUE" : "FALSE");
  return 0;

=================== SNAP =================== 

>-- 
>Corinna Vinschen                  Please, send mails regarding Cygwin to
>Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
>Red Hat, Inc.



Return-Path: <cygwin-patches-return-5341-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10181 invoked by alias); 9 Feb 2005 08:52:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10050 invoked from network); 9 Feb 2005 08:52:30 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.118.228)
  by sourceware.org with SMTP; 9 Feb 2005 08:52:30 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id C881357D77; Wed,  9 Feb 2005 09:52:28 +0100 (CET)
Date: Wed, 09 Feb 2005 08:52:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Message-ID: <20050209085228.GF2597@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20050208091029.GM19096@cygbert.vinschen.de> <0IBM0096T43FSM@pmismtp01.mcilink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0IBM0096T43FSM@pmismtp01.mcilink.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00044.txt.bz2

On Feb  8 14:38, Mark Paulus wrote:
> Well, all I can say, is "That's Uuuugggllleeeyyyyy".....
> 
> When I print fsname on the HPFS mounted volume, 
> I get back '??SS'.  What the heck is that???  Somehow,
> I'm guessing that's not something I want to be doing a 
> string comparison on, for any kind of stability purpose.
> 
> Guess I'll live with not being able to 'touch' on mounted
> HPFS volumes, and not do builds on that remote volume.
> 
> Sheesh, what a pain.  Thanks for the pointers, tho.

Hey, why do you give up so quickly?  If it's not the one way, it might
be another one.  For us unknowing folks which have no OS/2 box with
HPFS to mount, would you mind to run the below application on your NT
box and paste the output into the reply?  I'm curious to see the result.
On NTFS, it looks like this:

$ ./getvolinfo `pwd`
rootdir: C:\
Volume Name        : <>
Serial Number      : 813830114
Max Filenamelength : 255
Filesystemname     : <NTFS>
Flags:
  FILE_CASE_SENSITIVE_SEARCH  : TRUE
  FILE_CASE_PRESERVED_NAMES   : TRUE
  FILE_UNICODE_ON_DISK        : TRUE
  FILE_PERSISTENT_ACLS        : TRUE
  FILE_FILE_COMPRESSION       : TRUE
  FILE_VOLUME_QUOTAS          : TRUE
  FILE_SUPPORTS_SPARSE_FILES  : TRUE
  FILE_SUPPORTS_REPARSE_POINTS: TRUE
  FILE_SUPPORTS_REMOTE_STORAGE: FALSE
  FILE_VOLUME_IS_COMPRESSED   : FALSE
  FILE_SUPPORTS_OBJECT_IDS    : TRUE
  FILE_SUPPORTS_ENCRYPTION    : TRUE
  FILE_NAMED_STREAMS          : TRUE
  FILE_READ_ONLY_VOLUME       : FALSE


Corinna

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
{
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
}
=================== SNAP =================== 

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

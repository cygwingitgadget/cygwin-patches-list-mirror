Return-Path: <cygwin-patches-return-5344-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2038 invoked by alias); 10 Feb 2005 10:46:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1940 invoked from network); 10 Feb 2005 10:45:53 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.117.145)
  by sourceware.org with SMTP; 10 Feb 2005 10:45:53 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id A3B3C57D77; Thu, 10 Feb 2005 11:45:51 +0100 (CET)
Date: Thu, 10 Feb 2005 10:46:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Message-ID: <20050210104551.GX2597@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20050209085228.GF2597@cygbert.vinschen.de> <0IBN000F2N658O@pmismtp02.mcilink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0IBN000F2N658O@pmismtp02.mcilink.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00047.txt.bz2

On Feb  9 10:27, Mark Paulus wrote:
> I'm not exactly giving up.  It's just that at this point it looks like
> the fix will not be trivial, and since my company will not endorse
> a Waiver, I'm limited in the scope of fixes I can provide.  However,
> I am more than willing to provide any testing/debugging services
> that are needed.  The other issue is that this does not seem to be
> a huge issue, since it hasn't surfaced too much previous to this.

True.  I guess that there are not a lot of people out there using HPFS
anymore.  But if there's an easy solution, why not include it anyway?

> rootdir: z:\
> Volume Name        : <>
> Serial Number      : 2834707476
> Max Filenamelength : 254
> Filesystemname     : <??SS>
> Flags:
>   FILE_CASE_SENSITIVE_SEARCH  : FALSE
>   FILE_CASE_PRESERVED_NAMES   : TRUE
>   FILE_UNICODE_ON_DISK        : FALSE
>   FILE_PERSISTENT_ACLS        : FALSE
>   FILE_FILE_COMPRESSION       : FALSE
>   FILE_VOLUME_QUOTAS          : FALSE
>   FILE_SUPPORTS_SPARSE_FILES  : FALSE
>   FILE_SUPPORTS_REPARSE_POINTS: FALSE
>   FILE_SUPPORTS_REMOTE_STORAGE: FALSE
>   FILE_VOLUME_IS_COMPRESSED   : FALSE
>   FILE_SUPPORTS_OBJECT_IDS    : FALSE
>   FILE_SUPPORTS_ENCRYPTION    : FALSE
>   FILE_NAMED_STREAMS          : FALSE
>   FILE_READ_ONLY_VOLUME       : FALSE

The filesystemname is [insert 4-letter word here], really.

However, that let me rethink what I stated yesterday in my reply to
Yitzchak.  The original patch, which introduced the usage of
FILE_WRITE_ATTRIBUTES into utimes() made a decision based on the
operating system.  Without looking into the original code, it was
roughly like this:

  if (wincap.has_specific_attribs ())
    attrib = FILE_WRITE_ATTRIBUTES;
  else
    attrib = GENERIC_WRITE;

wincap.has_specific_attribs () returned true for NT systems and false
for 9x systems.  At one point I just removed that stuff since it turned
out that 9x perfectly understood specific attribs and probably translated
them into something like GENERIC_WRITE internally.

But, isn't that something which can be easily coupled to the file system?
It seems that using FILE_WRITE_ATTRIBUTES only makes sense on file systems
supporting FILE_PERSISTENT_ACLS, regardless which OS is running, isn't it?
So, what if we just use the has_acls() attribute of path_conv to make the
decision?

  if (win32.has_acls ())
    attrib = FILE_WRITE_ATTRIBUTES;
  else
    attrib = GENERIC_WRITE;

Thoughts?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

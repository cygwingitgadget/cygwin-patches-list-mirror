Return-Path: <cygwin-patches-return-5349-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13948 invoked by alias); 10 Feb 2005 15:56:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13892 invoked from network); 10 Feb 2005 15:56:35 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.117.145)
  by sourceware.org with SMTP; 10 Feb 2005 15:56:35 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 912A357D77; Thu, 10 Feb 2005 16:56:33 +0100 (CET)
Date: Thu, 10 Feb 2005 15:56:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Message-ID: <20050210155633.GB2597@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050208091029.GM19096@cygbert.vinschen.de> <0IBM0096T43FSM@pmismtp01.mcilink.com> <20050209085228.GF2597@cygbert.vinschen.de> <loom.20050210T160326-68@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050210T160326-68@post.gmane.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00052.txt.bz2

On Feb 10 15:10, Eric Blake wrote:
> Corinna Vinschen <vinschen <at> redhat.com> writes:
> > 
> > Hey, why do you give up so quickly?  If it's not the one way, it might
> > be another one.  For us unknowing folks which have no OS/2 box with
> > HPFS to mount, would you mind to run the below application on your NT
> > box and paste the output into the reply?  I'm curious to see the result.
> 
> If it helps, here's my quick results on a ClearCase drive m:, and a Windows 
> view to a Solaris filesystem on drive u: (I think it is using NFS).
> 
> $ scan m:
> rootdir: m:\
> Volume Name        : <CCase>
> Serial Number      : 36984713
> Max Filenamelength : 255
> Filesystemname     : <MVFS>
> Flags:
>   FILE_CASE_SENSITIVE_SEARCH  : TRUE
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
> $ scan u:
> rootdir: u:\
> Volume Name        : <eblake>
> Serial Number      : 316278793
> Max Filenamelength : 255
> Filesystemname     : <NTFS>
> Flags:
>   FILE_CASE_SENSITIVE_SEARCH  : TRUE
>   FILE_CASE_PRESERVED_NAMES   : TRUE
>   FILE_UNICODE_ON_DISK        : FALSE
>   FILE_PERSISTENT_ACLS        : TRUE
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

Huh?  It reports "NTFS" as filesystem?  Now, *that's* weird.  Especially
since none of the usual NTFS attributes are set.

Anyway, can you please test on both drives how they behave if utime
uses FILE_WRITE_ATTRIBUTES vs. GENERIC_WRITE?

The expected result would be that the clearcase volume chokes with
FILE_WRITE_ATTRIBUTES while the Solaris FS should work with it.
Otherwise we're sort of doomed.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

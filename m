Return-Path: <cygwin-patches-return-5338-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11696 invoked by alias); 8 Feb 2005 09:10:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11489 invoked from network); 8 Feb 2005 09:10:30 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.112.218)
  by sourceware.org with SMTP; 8 Feb 2005 09:10:30 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 2FFBD57D77; Tue,  8 Feb 2005 10:10:29 +0100 (CET)
Date: Tue, 08 Feb 2005 09:10:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Message-ID: <20050208091029.GM19096@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20050207171925.GG19096@cygbert.vinschen.de> <0IBK008D19EKWQ@pmismtp02.mcilink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0IBK008D19EKWQ@pmismtp02.mcilink.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00041.txt.bz2

On Feb  7 14:37, Mark Paulus wrote:
> So, what it really seems to boil down to is 
> for those filesystems that support doing timestamp 
> updating via FILE_WRITE_ATTRIBUTES (NTFS systems)
> we should use FILE_WRITE_ATTRIBUTES, and for those that
> don't (HPFS, etc), they should use GENERIC_WRITE?

Yes.  I'm wondering though, if that's the filesystem or OS/2 which
choke on FILE_WRITE_ATTRIBUTES.

> Unfortunately, during my brief perusal of MSDN, I didn't see
> an easy way to determine the file system type.  

Have a look into path.cc, fs_info::update ().  Test the filesystem
name in fs_info::update and add a flag to fs_info which tells us that
FILE_WRITE_ATTRIBUTES is supported (which is valid for NTFS and FAT,
btw.).


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

Return-Path: <cygwin-patches-return-5342-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11786 invoked by alias); 9 Feb 2005 08:54:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11743 invoked from network); 9 Feb 2005 08:54:37 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.118.228)
  by sourceware.org with SMTP; 9 Feb 2005 08:54:37 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 2AF9F57D79; Wed,  9 Feb 2005 09:54:36 +0100 (CET)
Date: Wed, 09 Feb 2005 08:54:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Message-ID: <20050209085436.GG2597@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20050207171925.GG19096@cygbert.vinschen.de> <0IBK008D19EKWQ@pmismtp02.mcilink.com> <20050208091029.GM19096@cygbert.vinschen.de> <20050208214915.GA2396@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208214915.GA2396@efn.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00045.txt.bz2

On Feb  8 13:49, Yitzchak Scott-Thoennes wrote:
> On Tue, Feb 08, 2005 at 10:10:29AM +0100, Corinna Vinschen wrote:
> > Have a look into path.cc, fs_info::update ().  Test the filesystem
> > name in fs_info::update and add a flag to fs_info which tells us that
> > FILE_WRITE_ATTRIBUTES is supported (which is valid for NTFS and FAT,
> > btw.).
> 
> How should the flag default for things other than NTFS, HPFS, and FAT?

I'm all for negative confinement.  FILE_WRITE_ATTRIBUTES unless proved
otherwise.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

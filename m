Return-Path: <cygwin-patches-return-5340-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18739 invoked by alias); 8 Feb 2005 21:49:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18720 invoked from network); 8 Feb 2005 21:49:14 -0000
Received: from unknown (HELO pop-a065d14.pas.sa.earthlink.net) (207.217.121.252)
  by sourceware.org with SMTP; 8 Feb 2005 21:49:14 -0000
Received: from user-2inif1s.dialup.mindspring.com ([165.121.60.60] helo=efn.org)
	by pop-a065d14.pas.sa.earthlink.net with smtp (Exim 3.33 #1)
	id 1CydEP-0006zh-00
	for cygwin-patches@cygwin.com; Tue, 08 Feb 2005 13:49:14 -0800
Received: by efn.org (sSMTP sendmail emulation); Tue, 8 Feb 2005 13:49:16 -0800
Date: Tue, 08 Feb 2005 21:49:00 -0000
From: Yitzchak Scott-Thoennes <sthoenna@efn.org>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Message-ID: <20050208214915.GA2396@efn.org>
References: <20050207171925.GG19096@cygbert.vinschen.de> <0IBK008D19EKWQ@pmismtp02.mcilink.com> <20050208091029.GM19096@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208091029.GM19096@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
Organization: bs"d
X-SW-Source: 2005-q1/txt/msg00043.txt.bz2

On Tue, Feb 08, 2005 at 10:10:29AM +0100, Corinna Vinschen wrote:
> On Feb  7 14:37, Mark Paulus wrote:
> > So, what it really seems to boil down to is 
> > for those filesystems that support doing timestamp 
> > updating via FILE_WRITE_ATTRIBUTES (NTFS systems)
> > we should use FILE_WRITE_ATTRIBUTES, and for those that
> > don't (HPFS, etc), they should use GENERIC_WRITE?
> 
> Yes.  I'm wondering though, if that's the filesystem or OS/2 which
> choke on FILE_WRITE_ATTRIBUTES.

Mark, are you also able to test with HPFS under WinNT?  (IIRC,
supported directly by NT 3.51 and by copying a 3.51 device driver
(pinball.sys?)  into NT4; google for more info.)
 
> > Unfortunately, during my brief perusal of MSDN, I didn't see
> > an easy way to determine the file system type.  
> 
> Have a look into path.cc, fs_info::update ().  Test the filesystem
> name in fs_info::update and add a flag to fs_info which tells us that
> FILE_WRITE_ATTRIBUTES is supported (which is valid for NTFS and FAT,
> btw.).

How should the flag default for things other than NTFS, HPFS, and FAT?

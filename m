Return-Path: <cygwin-patches-return-6022-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1700 invoked by alias); 3 Jan 2007 12:16:31 -0000
Received: (qmail 1685 invoked by uid 22791); 3 Jan 2007 12:16:30 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 03 Jan 2007 12:16:24 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B234F6D42FE; Wed,  3 Jan 2007 13:16:20 +0100 (CET)
Date: Wed, 03 Jan 2007 12:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Increase st_blksize to 64k
Message-ID: <20070103121620.GB4106@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com> <20070102184551.GA18182@trixie.casa.cgf.cx> <Pine.CYG.4.58.0701021301510.2464@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0701021301510.2464@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00003.txt.bz2

On Jan  2 13:49, Brian Ford wrote:
> On Tue, 2 Jan 2007, Christopher Faylor wrote:
> 
> > I don't see how replacing the constant "S_BLKSIZE" with what seems to be
> > an unrelated getpagesize () makes a lot of sense.
> 
> The st_blksize field represents the preferred I/O size (in bytes) for the
> corresponding file system.  Generally, this is the same as, or a multiple
> of the system page size for efficient cache management.  As such, I see
> nothing unusual about using that function.
> 
> The following document confirms my suspicion that at least NTFS buffered
> I/O is done in 64k chunks:
> 
> http://research.microsoft.com/BARC/Sequential_IO/seqio.doc
> 
> I believe this is a close enough parallel to the allocation granularity to
> justify using it directly.
> 
> > Assuming that this is a good idea, should S_BLKSIZE be changed directly?
> 
> No, S_BLKSIZE represents the actual size of a physical block on disk,
> and/or the size of the block units reported in the stat structure.
> S_BLKSIZE has historically been 512 bytes.
> 
> These are actually two different things.

Apparently S_BLKSIZE doesn't have much meaning anymore today.  It's not
even mentioned once in SUSv3.  On Linux, S_BLKSIZE is 512 while the
standard value in st_blksize on ext2/ext3 is 4096 (typically the value is
taken from the inode of the file, resp. from information stored in the
superblock of the FS).

Setting st_blksize to 64K might be a good idea for disk I/O if the value
is actually used by applications.  Do you have a specific example or a
test result from a Cygwin application which shows the advantage of
setting st_blksize to this value?  I assume there was some actual case
which led you to make this change ;)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

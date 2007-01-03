Return-Path: <cygwin-patches-return-6026-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18748 invoked by alias); 3 Jan 2007 15:44:10 -0000
Received: (qmail 18738 invoked by uid 22791); 3 Jan 2007 15:44:09 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 03 Jan 2007 15:43:55 +0000
Received: from mailgw01n.flightsafety.com (localhost [127.0.0.1]) 	by localhost (Postfix) with SMTP id 4388798C76 	for <cygwin-patches@cygwin.com>; Wed,  3 Jan 2007 10:44:19 -0500 (EST)
Received: from VXS3.flightsafety.com (internal-31-147.flightsafety.com [192.168.31.147]) 	by mailgw01n.flightsafety.com (Postfix) with ESMTP id DBB8098C7A 	for <cygwin-patches@cygwin.com>; Wed,  3 Jan 2007 10:44:18 -0500 (EST)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 3 Jan 2007 10:43:52 -0500
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 3 Jan 2007 09:43:51 -0600
Date: Wed, 03 Jan 2007 15:44:00 -0000
From: Brian Ford <Brian.Ford@FlightSafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: Increase st_blksize to 64k
In-Reply-To: <459BADB3.7080705@byu.net>
Message-ID: <Pine.CYG.4.58.0701030905330.2464@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com>  <20070102184551.GA18182@trixie.casa.cgf.cx>  <Pine.CYG.4.58.0701021301510.2464@PC1163-8460-XP.flightsafety.com>  <20070103121620.GB4106@calimero.vinschen.de> <459BADB3.7080705@byu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00007.txt.bz2

On Wed, 3 Jan 2007, Eric Blake wrote:

> coreutils has the following, in src/system.h, used by cp, install, mv, du,
> ls, stat...
[snip]
> For example, in cp, the following usage appears:
[snip]
> It sounds like we want to ensure that cygwin chooses ST_BLKSIZE at 64k
> (optimal I/O size) but ST_NBLOCKS/ST_NBLOCKSIZE at the disk granularity (512).

I got lost in all the code details you presented above, but I confess to
not trying very hard.  I don't think changing the block size to 512 bytes
is really necessary, though.

These are the examples that I had in mind:

newlib stdio http://cygwin.com/cgi-bin/cvsweb.cgi/src/newlib/libc/stdio/makebuf.c?rev=1.6&content-type=text/x-cvsweb-markup&cvsroot=src :

#ifdef HAVE_BLKSIZE
      size = st.st_blksize <= 0 ? BUFSIZ : st.st_blksize;
#else
      size = BUFSIZ;
#endif
[skip]
#ifdef HAVE_BLKSIZE
          fp->_blksize = st.st_blksize;
#else
          fp->_blksize = 1024;
#endif

which is used to size and fill the stdio buffer.

and coreutils cp
http://cvs.savannah.gnu.org/viewcvs/coreutils/src/copy.c?rev=1.223&root=coreutils&view=auto :

      /* Choose a suitable buffer size; it may be adjusted later.  */
      size_t buf_alignment = lcm (getpagesize (), sizeof (word));
      size_t buf_alignment_slop = sizeof (word) + buf_alignment - 1;
      size_t buf_size = ST_BLKSIZE (sb);
[skip]
      /* If not making a sparse file, try to use a more-efficient
	 buffer size.  */
      if (! make_holes)
	{
	  /* These days there's no point ever messing with buffers smaller
	     than 8 KiB.  It would be nice to configure SMALL_BUF_SIZE
	     dynamically for this host and pair of files, but there
doesn't
	     seem to be a good way to get readahead info portably.  */
	  enum { SMALL_BUF_SIZE = 8 * 1024 };

	  /* Compute the least common multiple of the input and output
	     buffer sizes, adjusting for outlandish values.  */
	  size_t blcm_max = MIN (SIZE_MAX, SSIZE_MAX) -
buf_alignment_slop;
	  size_t blcm = buffer_lcm (ST_BLKSIZE (src_open_sb), buf_size,
				    blcm_max);

	  /* Do not use a block size that is too small.  */
	  buf_size = MAX (SMALL_BUF_SIZE, blcm);

	  /* Do not bother with a buffer larger than the input file, plus
one
	     byte to make sure the file has not grown while reading it.
*/
	  if (S_ISREG (src_open_sb.st_mode) && src_open_sb.st_size <
buf_size)
	    buf_size = src_open_sb.st_size + 1;

	  /* However, stick with a block size that is a positive multiple
of
	     blcm, overriding the above adjustments.  Watch out for
	     overflow.  */
	  buf_size += blcm - 1;
	  buf_size -= buf_size % blcm;
	  if (buf_size == 0 || blcm_max < buf_size)
	    buf_size = blcm;
	}

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...


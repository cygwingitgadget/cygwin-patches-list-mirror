Return-Path: <cygwin-patches-return-6023-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22115 invoked by alias); 3 Jan 2007 13:20:19 -0000
Received: (qmail 22101 invoked by uid 22791); 3 Jan 2007 13:20:18 -0000
X-Spam-Check-By: sourceware.org
Received: from alnrmhc13.comcast.net (HELO alnrmhc13.comcast.net) (206.18.177.53)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 03 Jan 2007 13:20:12 +0000
Received: from [192.168.0.103] (c-67-186-254-72.hsd1.co.comcast.net[67.186.254.72])           by comcast.net (alnrmhc13) with ESMTP           id <20070103132010b1300q7plpe>; Wed, 3 Jan 2007 13:20:11 +0000
Message-ID: <459BADB3.7080705@byu.net>
Date: Wed, 03 Jan 2007 13:20:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.9) Gecko/20061207 Thunderbird/1.5.0.9 Mnenhy/0.7.4.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Increase st_blksize to 64k
References: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com> <20070102184551.GA18182@trixie.casa.cgf.cx> <Pine.CYG.4.58.0701021301510.2464@PC1163-8460-XP.flightsafety.com> <20070103121620.GB4106@calimero.vinschen.de>
In-Reply-To: <20070103121620.GB4106@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00004.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 1/3/2007 5:16 AM:
> 
> Setting st_blksize to 64K might be a good idea for disk I/O if the value
> is actually used by applications.  Do you have a specific example or a
> test result from a Cygwin application which shows the advantage of
> setting st_blksize to this value?  I assume there was some actual case
> which led you to make this change ;)

Did you read the original link?
http://sourceware.org/ml/cygwin/2006-12/msg00911.html

coreutils has the following, in src/system.h, used by cp, install, mv, du,
ls, stat...

/* Extract or fake data from a `struct stat'.
   ST_BLKSIZE: Preferred I/O blocksize for the file, in bytes.
   ST_NBLOCKS: Number of blocks in the file, including indirect blocks.
   ST_NBLOCKSIZE: Size of blocks used when calculating ST_NBLOCKS.  */
#ifndef HAVE_STRUCT_STAT_ST_BLOCKS
# define ST_BLKSIZE(statbuf) DEV_BSIZE
# if defined _POSIX_SOURCE || !defined BSIZE /* fileblocks.c uses BSIZE.  */
#  define ST_NBLOCKS(statbuf) \
  ((statbuf).st_size / ST_NBLOCKSIZE + ((statbuf).st_size % ST_NBLOCKSIZE
!= 0))
# else /* !_POSIX_SOURCE && BSIZE */
#  define ST_NBLOCKS(statbuf) \
  (S_ISREG ((statbuf).st_mode) \
   || S_ISDIR ((statbuf).st_mode) \
   ? st_blocks ((statbuf).st_size) : 0)
# endif /* !_POSIX_SOURCE && BSIZE */
#else /* HAVE_STRUCT_STAT_ST_BLOCKS */
/* Some systems, like Sequents, return st_blksize of 0 on pipes.
   Also, when running `rsh hpux11-system cat any-file', cat would
   determine that the output stream had an st_blksize of 2147421096.
   Conversely st_blksize can be 2 GiB (or maybe even larger) with XFS
   on 64-bit hosts.  Somewhat arbitrarily, limit the `optimal' block
   size to SIZE_MAX / 8 + 1.  (Dividing SIZE_MAX by only 4 wouldn't
   suffice, since "cat" sometimes multiplies the result by 4.)  If
   anyone knows of a system for which this limit is too small, please
   report it as a bug in this code.  */
# define ST_BLKSIZE(statbuf) ((0 < (statbuf).st_blksize \
                               && (statbuf).st_blksize <= SIZE_MAX / 8 + 1) \
                              ? (statbuf).st_blksize : DEV_BSIZE)
...

#ifndef ST_NBLOCKSIZE
# ifdef S_BLKSIZE
#  define ST_NBLOCKSIZE S_BLKSIZE
# else
#  define ST_NBLOCKSIZE 512
# endif
#endif

For example, in cp, the following usage appears:

#if HAVE_STRUCT_STAT_ST_BLOCKS
          /* Use a heuristic to determine whether SRC_NAME contains any sparse
             blocks.  If the file has fewer blocks than would normally be
             needed for a file of its size, then at least one of the blocks in
             the file is a hole.  */
          if (x->sparse_mode == SPARSE_AUTO && S_ISREG (src_open_sb.st_mode)
              && ST_NBLOCKS (src_open_sb) < src_open_sb.st_size /
ST_NBLOCKSIZE)
            make_holes = true;
#endif



It sounds like we want to ensure that cygwin chooses ST_BLKSIZE at 64k
(optimal I/O size) but ST_NBLOCKS/ST_NBLOCKSIZE at the disk granularity (512).

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFm62y84KuGfSFAYARAkOkAJ4iRSCq69/Vfa+rE1V/d4v3CBssMgCgl+Yc
PXdwJeLfT0+XeXQL+XahBik=
=WWJR
-----END PGP SIGNATURE-----

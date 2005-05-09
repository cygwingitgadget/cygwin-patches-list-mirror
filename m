Return-Path: <cygwin-patches-return-5438-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5692 invoked by alias); 9 May 2005 19:09:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4907 invoked from network); 9 May 2005 19:09:47 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 9 May 2005 19:09:47 -0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DVDRu-0003jk-Na
	for cygwin-patches@cygwin.com; Mon, 09 May 2005 20:57:52 +0200
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Mon, 09 May 2005 20:57:50 +0200
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Mon, 09 May 2005 20:57:50 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  Re: [Patch]: mkdir -p and network drives
Date: Mon, 09 May 2005 19:09:00 -0000
Message-ID:  <loom.20050509T200029-6@post.gmane.org>
References:  <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-SW-Source: 2005-q2/txt/msg00034.txt.bz2

Pierre A. Humblet <pierre <at> phumblet.no-ip.org> writes:
> 
> Here is a patch to allow mkdir -p to easily work with network
> drives and to allow future enumeration of computers and of
> network drives by ls -l.
> 
> It works by defining a new FH_NETDRIVE virtual handler for
> names such as // and //machine.
> This also makes chdir work without additional change.

I've just downloaded the 20050508 snapshot to play with this, and it still 
needs some work before coreutils-5.3.0-6 can be released.  But it is an 
improvement!

First, `ls -ld // //machine' show that these directories are mode 111 
(searchable, but not readable).  Yet opendir("//") and opendir("//machine") 
succeed, although POSIX requires that opendir(2) fail with EACCESS if the 
directory to be opened is not readable.

Second, the sequence chdir("//"), mkdir("machine") creates machine in the 
current directory.

$ cd //eblake/share
$ ls
$ ~/coreutils-cvs/src/mkdir -p //eblake/share/dir
$ ls -F
dir/  eblake/  share/

A relevant portion of the strace is included below.  Basically, mkdir
("//machine") (or chdir("//"), mkdir("machine")) needs to fail with EEXIST 
(because it is always assumed that //machine already exists) or with EACCESS 
(because there is no write access in //), rather than create a directory by 
that name somewhere else.

   69 4745479 [main] mkdir 10204 chdir: dir '//'
   62 4745541 [main] mkdir 10204 normalize_posix_path: src //
   66 4745607 [main] mkdir 10204 normalize_posix_path: // = normalize_posix_path
 (//)
   62 4745669 [main] mkdir 10204 mount_info::conv_to_win32_path: conv_to_win32_p
ath (//)
   61 4745730 [main] mkdir 10204 set_flags: flags: binary (0x2)
   74 4745804 [main] mkdir 10204 mount_info::conv_to_win32_path: src_path //, ds
t \\, flags 0x2, rc 0
   77 4745881 [main] mkdir 10204 build_fh_pc: fh 0x61831710
   67 4745948 [main] mkdir 10204 chdir: 0 = chdir() cygheap->cwd.posix '//' nati
ve '\\'
   67 4746015 [main] mkdir 10204 normalize_posix_path: src eblake
   61 4746076 [main] mkdir 10204 cwdstuff::get: posix //
   60 4746136 [main] mkdir 10204 cwdstuff::get: (//) = cwdstuff::get (0x22EAC0, 
260, 1, 0), errno 2
  132 4746268 [main] mkdir 10204 normalize_posix_path: //eblake = normalize_posi
x_path (eblake)
   67 4746335 [main] mkdir 10204 mount_info::conv_to_win32_path: conv_to_win32_p
ath (//eblake)
   67 4746402 [main] mkdir 10204 set_flags: flags: binary (0x2)
   61 4746463 [main] mkdir 10204 mount_info::conv_to_win32_path: src_path //ebla
ke, dst \\eblake, flags 0x2, rc 0
   64 4746527 [main] mkdir 10204 build_fh_pc: fh 0x61831710
   68 4746595 [main] mkdir 10204 cwdstuff::get: posix //
   72 4746667 [main] mkdir 10204 cwdstuff::get: (\\) = cwdstuff::get (0x22E4E0, 
260, 0, 0), errno 2
 1561 4748228 [main] mkdir 10204 mkdir: 0 = mkdir (eblake, 511)


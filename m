Return-Path: <cygwin-patches-return-7041-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18984 invoked by alias); 19 Jul 2010 16:46:11 -0000
Received: (qmail 18957 invoked by uid 22791); 19 Jul 2010 16:46:09 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 19 Jul 2010 16:46:01 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B56D36D42F4; Mon, 19 Jul 2010 18:45:58 +0200 (CEST)
Date: Mon, 19 Jul 2010 16:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: newlib@sourceware.org
Subject: Re: add mkostemp
Message-ID: <20100719164558.GN6944@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com, newlib@sourceware.org
Mail-Followup-To: cygwin-patches@cygwin.com, newlib@sourceware.org
References: <4C447CE5.4040808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C447CE5.4040808@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00001.txt.bz2

On Jul 19 10:27, Eric Blake wrote:
> Sed wants to use the glibc invention of mkostemp as enhanced by gnulib, in
> order to control the use of O_TEXT vs. O_BINARY vs. 0 (for native mount)
> mode[1].  glibc added this interface for other reasons as well - it is
> also useful to specify O_CLOEXEC, O_APPEND, and/or O_SYNC on some
> temporary files.  In glibc, the flags argument explicitly excludes
> O_ACCMODE bits, since temp files are already specified as O_RDWR, so I
> copied that pattern.  (man-pages 3.23 documents mkostemp since glibc 2.7,
> but fails to document mkostemps, even though it was added at the same time
> as mkstemps in glibc 2.11).
> 
> [1] http://lists.gnu.org/archive/html/bug-coreutils/2010-07/msg00114.html

Cool, so we just need mkostemp and then waiting for the next upstream
version of sed.

> Okay to commit, along with a corresponding patch to doc/new-features.sgml
> and a cygwin-specific patch to newlib's stdlib.h?

Yep.  Thanks for the patch.  I CCed the newlib list.  The change to
newlib's stdlib.h is preapproved (#ifndef __STRICT_ANSI__ just like
mkstemp et al).

Btw., would you mind to enhance newlib's libc/stdio/mktemp.c in the same
manner (_ELIX_LEVEL >= 4)?


Thanks,
Corinna

> 
> 2010-07-19  Eric Blake  <...>
> 
> 	* mktemp.cc (_gettemp): Add flags argument.  All callers updated.
> 	(mkostemp, mkostemps): New functions.
> 	* cygwin.din (mkostemp, mkostemps): Export.
> 	* posix.sgml: Document them.
> 	* include/cygwin/version.h: Bump version.
> 
>  winsup/cygwin/ChangeLog                |    8 ++++++++
>  winsup/cygwin/cygwin.din               |    2 ++
>  winsup/cygwin/include/cygwin/version.h |    3 ++-
>  winsup/cygwin/mktemp.cc                |   28 +++++++++++++++++++++-------
>  winsup/cygwin/posix.sgml               |    2 ++
>  5 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
> index f0ecd19..d9a67d7 100644
> --- a/winsup/cygwin/ChangeLog
> +++ b/winsup/cygwin/ChangeLog
> diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
> index fa5c77d..9253d2c 100644
> --- a/winsup/cygwin/cygwin.din
> +++ b/winsup/cygwin/cygwin.din
> @@ -995,6 +995,8 @@ mknod SIGFE
>  _mknod = mknod SIGFE
>  _mknod32 = mknod32 SIGFE
>  mknodat SIGFE
> +mkostemp SIGFE
> +mkostemps SIGFE
>  mkstemp SIGFE
>  _mkstemp = mkstemp SIGFE
>  mkstemps SIGFE
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
> index 3a95e51..9924e42 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -388,12 +388,13 @@ details. */
>        226: Export __locale_mb_cur_max.
>        227: Add pseudo_reloc_start, pseudo_reloc_end, image_base to per_process.
>        228: CW_STRERROR added.
> +      229: Add mkostemp, mkostemps.
>       */
> 
>       /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
> 
>  #define CYGWIN_VERSION_API_MAJOR 0
> -#define CYGWIN_VERSION_API_MINOR 228
> +#define CYGWIN_VERSION_API_MINOR 229
> 
>       /* There is also a compatibity version number associated with the
>  	shared memory regions.  It is incremented when incompatible
> diff --git a/winsup/cygwin/mktemp.cc b/winsup/cygwin/mktemp.cc
> index b8a1381..7770c3b 100644
> --- a/winsup/cygwin/mktemp.cc
> +++ b/winsup/cygwin/mktemp.cc
> @@ -10,7 +10,7 @@ See the copyright at the bottom of this file. */
>  #include <sys/stat.h>
>  #include <unistd.h>
> 
> -static int _gettemp(char *, int *, int, size_t);
> +static int _gettemp(char *, int *, int, size_t, int);
>  static uint32_t arc4random ();
> 
>  static const char padchar[] =
> @@ -20,30 +20,44 @@ extern "C" int
>  mkstemp(char *path)
>  {
>    int fd;
> -  return _gettemp(path, &fd, 0, 0) ? fd : -1;
> +  return _gettemp(path, &fd, 0, 0, O_BINARY) ? fd : -1;
>  }
> 
>  extern "C" char *
>  mkdtemp(char *path)
>  {
> -  return _gettemp(path, NULL, 1, 0) ? path : NULL;
> +  return _gettemp(path, NULL, 1, 0, 0) ? path : NULL;
>  }
> 
>  extern "C" int
>  mkstemps(char *path, int len)
>  {
>    int fd;
> -  return _gettemp(path, &fd, 0, len) ? fd : -1;
> +  return _gettemp(path, &fd, 0, len, O_BINARY) ? fd : -1;
> +}
> +
> +extern "C" int
> +mkostemp(char *path, int flags)
> +{
> +  int fd;
> +  return _gettemp(path, &fd, 0, 0, flags & ~O_ACCMODE) ? fd : -1;
> +}
> +
> +extern "C" int
> +mkostemps(char *path, int len, int flags)
> +{
> +  int fd;
> +  return _gettemp(path, &fd, 0, len, flags & ~O_ACCMODE) ? fd : -1;
>  }
> 
>  extern "C" char *
>  mktemp(char *path)
>  {
> -  return _gettemp(path, NULL, 0, 0) ? path : (char *) NULL;
> +  return _gettemp(path, NULL, 0, 0, 0) ? path : (char *) NULL;
>  }
> 
>  static int
> -_gettemp(char *path, int *doopen, int domkdir, size_t suffixlen)
> +_gettemp(char *path, int *doopen, int domkdir, size_t suffixlen, int flags)
>  {
>    char *start, *trv, *suffp;
>    char *pad;
> @@ -105,7 +119,7 @@ _gettemp(char *path, int *doopen, int domkdir, size_t suffixlen)
>      {
>        if (doopen)
>  	{
> -	  if ((*doopen = open (path, O_CREAT | O_EXCL | O_RDWR | O_BINARY,
> +	  if ((*doopen = open (path, O_CREAT | O_EXCL | O_RDWR | flags,
>  			       S_IRUSR | S_IWUSR)) >= 0)
>  	    return 1;
>  	  if (errno != EEXIST)
> diff --git a/winsup/cygwin/posix.sgml b/winsup/cygwin/posix.sgml
> index 6a3bc22..fdd7589 100644
> --- a/winsup/cygwin/posix.sgml
> +++ b/winsup/cygwin/posix.sgml
> @@ -1043,6 +1043,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
>      lsetxattr
>      memmem
>      mempcpy
> +    mkostemp
> +    mkostemps
>      pipe2
>      pow10
>      pow10f
> -- 
> 1.7.1
> 

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

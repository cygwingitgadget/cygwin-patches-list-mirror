From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: readlink() patch
Date: Sun, 03 Sep 2000 17:04:00 -0000
Message-id: <20000903200337.A22931@cygnus.com>
References: <119170270886.20000903213328@logos-m.ru>
X-SW-Source: 2000-q3/msg00051.html

On Sun, Sep 03, 2000 at 09:33:28PM +0400, Egor Duda wrote:
>Hi!
>
>  linux man says about readlink():
>
>========================================================================
>readlink  places  the contents of the symbolic link path in the buffer
>buf,  which  has size bufsiz. readlink does not append a NUL character
>to   buf.   It   will  truncate  the  contents  (to a length of bufsiz
>characters),  in  case  the  buffer  is  too  small to hold all of the 
>contents.
>========================================================================
>
>susv2  is  rather  vague  on  this subject, but there's no "buffer too
>small"  in  its  list  of  error  conditions.  i don't know what other
>standards  say  about  readlink. this patch is to make cygwin readlink
>behaving like linux one.

This is from my linux man page:

>READLINK(2)         Linux Programmer's Manual         READLINK(2)
>
>NAME
>       readlink - read value of a symbolic link
>
>SYNOPSIS
>       #include <unistd.h>
>
>       int readlink(const char *path, char *buf, size_t bufsiz);
>
>DESCRIPTION
>       readlink  places the contents of the symbolic link path in
>       the buffer buf, which has size bufsiz.  readlink does  not
>       append  a NUL character to buf.  It will truncate the con-
>       tents (to a length of  bufsiz  characters),  in  case  the
>       buffer is too small to hold all of the contents.
>
>RETURN VALUES
>       The  call  returns  the  count of characters placed in the
>       buffer if it succeeds, or a -1 if an error occurs, placing
>       the error code in errno.
>
>ERRORS
>       ENOTDIR A component of the path prefix is not a directory.
>
>       EINVAL  bufsiz is not positive.
>
>       ENAMETOOLONG
>               A pathname, or a component of a pathname, was  too
>               long.
>

To me, this means that removing ENAMETOOLONG is the wrong way to go.

cgf

From: Egor Duda <deo@logos-m.ru>
To: Chris Faylor <cygwin-patches@sourceware.cygnus.com>
Subject: Re: readlink() patch
Date: Sun, 03 Sep 2000 23:09:00 -0000
Message-id: <33215577994.20000904100834@logos-m.ru>
References: <119170270886.20000903213328@logos-m.ru> <20000903200337.A22931@cygnus.com>
X-SW-Source: 2000-q3/msg00052.html

Hi!

Monday, 04 September, 2000 Chris Faylor cgf@cygnus.com wrote:

CF> This is from my linux man page:

>>READLINK(2)         Linux Programmer's Manual         READLINK(2)
>>
>>NAME
>>       readlink - read value of a symbolic link
>>
>>SYNOPSIS
>>       #include <unistd.h>
>>
>>       int readlink(const char *path, char *buf, size_t bufsiz);
>>
>>DESCRIPTION
>>       readlink  places the contents of the symbolic link path in
>>       the buffer buf, which has size bufsiz.  readlink does  not
>>       append  a NUL character to buf.  It will truncate the con-
>>       tents (to a length of  bufsiz  characters),  in  case  the
>>       buffer is too small to hold all of the contents.
>>
>>RETURN VALUES
>>       The  call  returns  the  count of characters placed in the
>>       buffer if it succeeds, or a -1 if an error occurs, placing
>>       the error code in errno.
>>
>>ERRORS
>>       ENOTDIR A component of the path prefix is not a directory.
>>
>>       EINVAL  bufsiz is not positive.
>>
>>       ENAMETOOLONG
>>               A pathname, or a component of a pathname, was  too
>>               long.
>>

CF> To me, this means that removing ENAMETOOLONG is the wrong way to go.

susv2 says about ENANETOOLONG:

The readlink() function will fail if:

    [EACCES]
        Search permission is denied for a component of the path prefix of path.
    [EINVAL]
        The path argument names a file that is not a symbolic link. 
    [EIO]
        An I/O error occurred while reading from the file system. 
    [ENOENT]
        A component of path does not name an existing file or path is an
        empty string. 
    [ELOOP]
        Too many symbolic links were encountered in resolving path. 
    [ENAMETOOLONG]

        The length of path exceeds {PATH_MAX}, or a pathname component is
        longer than {NAME_MAX}. 
    [ENOTDIR]
        A component of the path prefix is not a directory. 

    The readlink() function may fail if: 

    [EACCES]
        Read permission is denied for the directory. 
    [ENAMETOOLONG]

        Pathname resolution of a symbolic link produced an intermediate
        result whose length exceeds {PATH_MAX}.

Note that there's no notions about buffer size here.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19


From: Earnie Boyd <earnie_boyd@yahoo.com>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: w32api and gcc -pedantic
Date: Fri, 13 Apr 2001 13:23:00 -0000
Message-id: <3AD76024.41E41C3A@yahoo.com>
References: <77639782278.20010413231057@logos-m.ru>
X-SW-Source: 2001-q2/msg00056.html

I'm reviewing the patch.  Looks ok on a cursory view but I'm getting
opinions from MinGW-dvlprs.

Earnie.

egor duda wrote:
> 
> Hi!
> 
>   w32api headers currently contain a number of anonymous structs and
> unions. So, gcc prints a bunch of warnings when invoked with -pedantic
> on program which #include <windows.h>. this patch is to avoid those
> warnings.
> 
> egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
> 
>   ------------------------------------------------------------------------
>                                     Name: w32api-pedantic-warnings.diff
>    w32api-pedantic-warnings.diff    Type: unspecified type (application/octet-stream)
>                                 Encoding: base64
> 
>                                          Name: w32api-pedantic-warnings.ChangeLog
>    w32api-pedantic-warnings.ChangeLog    Type: unspecified type (application/octet-stream)
>                                      Encoding: base64

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


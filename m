From: Earnie Boyd <earnie_boyd@yahoo.com>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: w32api and gcc -pedantic
Date: Tue, 17 Apr 2001 05:58:00 -0000
Message-id: <3ADC3E08.611AA3A0@yahoo.com>
References: <77639782278.20010413231057@logos-m.ru>
X-SW-Source: 2001-q2/msg00097.html

This patch has been committed.

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


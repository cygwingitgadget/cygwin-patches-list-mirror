From: Earnie Boyd <earnie_boyd@yahoo.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: X_OK redefinition protection.
Date: Fri, 20 Apr 2001 09:39:00 -0000
Message-id: <3AE06643.F33E065B@yahoo.com>
References: <3ADEFDEF.626A46EC@yahoo.com>
X-SW-Source: 2001-q2/msg00129.html

What's the status of this patch?

Earnie.

Earnie Boyd wrote:
> 
> I've also sent the sys-unistd file to newlib.
> 
> Earnie.
> 
>   ------------------------------------------------------------------------
> 2001-04-19  Earnie Boyd  <earnie@users.sourceforge.net>
> 
>         * include/sys/file.h (X_OK): Remove redefinition warnings when
>         including both sys/unistd.h and sys/file.h.  Make the definition
>         consistent with sys/unistd.h.
> 
> Index: file.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/include/sys/file.h,v
> retrieving revision 1.3
> diff -u -p -r1.3 file.h
> --- file.h      2001/04/18 21:10:15     1.3
> +++ file.h      2001/04/19 14:50:56
> @@ -23,16 +23,16 @@
>  #define L_XTND 2
> 
> 
> +#ifndef F_OK
>  #define        F_OK            0       /* does file exist */
> -#define        _X_OK           1       /* is it executable by caller */
> -#if defined (__CYGWIN__) || defined (__INSIDE_CYGWIN__)
> -# define X_OK  _X_OK   /* Check for execute permission. */
> -#else
> +#define        X_OK            1       /* is it executable by caller */
> +#if defined (__CYGWIN__) && !defined (__INSIDE_CYGWIN__)
>  # undef X_OK
>  extern const unsigned _cygwin_X_OK;
>  # define X_OK  _cygwin_X_OK
>  #endif
>  #define        W_OK            2       /* is it writable by caller */
>  #define        R_OK            4       /* is it readable by caller */
> +#endif /* ndef F_OK */
> 
>  #endif
> 
>   ------------------------------------------------------------------------
> 2001-04-19  Earnie Boyd  <earnie@users.sourceforge.net>
> 
>         * include/sys/unistd.h (X_OK): Remove redefinition warnings when
>         including both sys/unistd.h and Cygwin's sys/file.h.
> 
> Index: unistd.h
> ===================================================================
> RCS file: /cvs/src/src/newlib/libc/include/sys/unistd.h,v
> retrieving revision 1.20
> diff -u -p -r1.20 unistd.h
> --- unistd.h    2001/04/13 15:37:47     1.20
> +++ unistd.h    2001/04/19 14:50:31
> @@ -128,6 +128,7 @@ int     _EXFUN(readlink, (const char *__
>  int     _EXFUN(symlink, (const char *__name1, const char *__name2));
>  #endif
> 
> +#ifndef F_OK
>  # define       F_OK    0
>  # define       R_OK    4
>  # define       W_OK    2
> @@ -138,6 +139,7 @@ int     _EXFUN(symlink, (const char *__n
>  # define X_OK  _cygwin_X_OK
>  extern const unsigned _cygwin_X_OK;
>  #endif
> +#endif /* ndef F_OK */
> 
>  # define       SEEK_SET        0
>  # define       SEEK_CUR        1

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


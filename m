Return-Path: <cygwin-patches-return-7700-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27382 invoked by alias); 16 Aug 2012 09:34:38 -0000
Received: (qmail 25382 invoked by uid 22791); 16 Aug 2012 09:33:55 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 16 Aug 2012 09:33:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 069EE2C00CA; Thu, 16 Aug 2012 11:33:35 +0200 (CEST)
Date: Thu, 16 Aug 2012 09:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard pasting with small read() buffer
Message-ID: <20120816093334.GB20051@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <502ABB77.2080502@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <502ABB77.2080502@towo.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00021.txt.bz2

Hi Thomas,

thanks for the patch.   I have a few minor nits:

On Aug 14 22:56, Thomas Wolff wrote:
> --- sav/fhandler_clipboard.cc	2012-07-08 02:36:47.000000000 +0200
> +++ ./fhandler_clipboard.cc	2012-08-14 18:25:14.903255600 +0200
> @@ -222,6 +222,7 @@ fhandler_dev_clipboard::read (void *ptr,
>    UINT formatlist[2];
>    int format;
>    LPVOID cb_data;
> +  int rach;
>  
>    if (!OpenClipboard (NULL))
>      {
> @@ -243,12 +244,18 @@ fhandler_dev_clipboard::read (void *ptr,
>        cygcb_t *clipbuf = (cygcb_t *) cb_data;
>  
>        if (pos < clipbuf->len)
> -      	{
> +	{
>  	  ret = ((len > (clipbuf->len - pos)) ? (clipbuf->len - pos) : len);
>  	  memcpy (ptr, clipbuf->data + pos , ret);
>  	  pos += ret;
>  	}
>      }
> +  else if ((rach = get_readahead ()) >= 0)
> +    {
> +      /* Deliver from read-ahead buffer. */
> +      * (char *) ptr = rach;
> +      ret = 1;

See (*) below.

> +    }
>    else
>      {
>        wchar_t *buf = (wchar_t *) cb_data;
> @@ -256,25 +263,46 @@ fhandler_dev_clipboard::read (void *ptr,
>        size_t glen = GlobalSize (hglb) / sizeof (WCHAR) - 1;
>        if (pos < glen)
>  	{
> +	  /* If caller's buffer is too small to hold at least one 
> +	     max-size character, redirect algorithm to local 
> +	     read-ahead buffer, finally fill class read-ahead buffer 
> +	     with result and feed caller from there. */
> +	  char * _ptr = (char *) ptr;
> +	  size_t _len = len;

I would prefer to have local variable names here which don't just
differ by a leading underscore.  It's a bit confusing.  What about,
say, tmp_ptr/tmp_len, or use_ptr/use_len or something like that?

> +	  char cprabuf [8 + 1];	/* need this length for surrogates */
> +	  if (len < 8)
> +	    {
> +	      _ptr = cprabuf;
> +	      _len = 8;
> +	    }

8?  Why 8?  The size appears to be rather artificial.  The code should
use MB_CUR_MAX instead.

> +
>  	  /* Comparing apples and oranges here, but the below loop could become
>  	     extremly slow otherwise.  We rather return a few bytes less than
>  	     possible instead of being even more slow than usual... */
> -	  if (glen > pos + len)
> -	    glen = pos + len;
> +	  if (glen > pos + _len)
> +	    glen = pos + _len;
>  	  /* This loop is necessary because the number of bytes returned by
>  	     sys_wcstombs does not indicate the number of wide chars used for
>  	     it, so we could potentially drop wide chars. */
>  	  while ((ret = sys_wcstombs (NULL, 0, buf + pos, glen - pos))
>  		  != (size_t) -1
> -		 && ret > len)
> +		 && ret > _len)
>  	     --glen;
>  	  if (ret == (size_t) -1)
>  	    ret = 0;
>  	  else
>  	    {
> -	      ret = sys_wcstombs ((char *) ptr, (size_t) -1,
> +	      ret = sys_wcstombs ((char *) _ptr, (size_t) -1,
>  				  buf + pos, glen - pos);
>  	      pos = glen;
> +	      /* If using read-ahead buffer, copy to class read-ahead buffer
> +	         and deliver first byte. */
> +	      if (_ptr == cprabuf)
> +		{
> +		  puts_readahead (cprabuf, ret);
> +		  * (char *) ptr = get_readahead ();
> +		  ret = 1;

(*) Ok, that works, but wouldn't it be more efficient to do that in
a tiny loop along the lines of

		  int x;
		  ret = 0;
                  while (ret < len && (x = get_readahead ()) >= 0)
		    ptr++ = x;
		    ret++;

?


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

From: Corinna Vinschen <vinschen@cygnus.com>
To: Chris Faylor <cgf@cygnus.com>
Cc: cygwin-patches@sources.redhat.com
Subject: Re: preliminary patch3 for i18n: eliminate calls to wcstombs.
Date: Fri, 21 Jul 2000 13:27:00 -0000
Message-id: <3978B222.BFBF3CA8@cygnus.com>
References: <s1sn1jb45yi.fsf@jaist.ac.jp> <20000721155529.B26237@cygnus.com>
X-SW-Source: 2000-q3/msg00023.html

Chris Faylor wrote:
> 
> On Sat, Jul 22, 2000 at 04:51:49AM +0900, Kazuhiro Fujieda wrote:
> >The current implementation of wcstombs() can't convert a
> >wide-character string encoded by UNICODE to a correct multi-byte
> >string. So we should use WideCharToMultiByte instead of it.
> 
> Hmm.  I wonder if it wouldn't make sense to implement wcstombs using
> WideChartoMultiByte instead.

Yup.

However, using defines instead of the `magic' 256 is definitely a
good idea.

Corinna

-- 
Corinna Vinschen
Cygwin Developer
Cygnus Solutions, a Red Hat company

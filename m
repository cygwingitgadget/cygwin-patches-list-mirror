From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sources.redhat.com
Subject: Re: preliminary patch3 for i18n: eliminate calls to wcstombs.
Date: Fri, 21 Jul 2000 14:16:00 -0000
Message-id: <s1sk8ef422b.fsf@jaist.ac.jp>
References: <s1sn1jb45yi.fsf@jaist.ac.jp> <20000721155529.B26237@cygnus.com>
X-SW-Source: 2000-q3/msg00024.html

>>> On Fri, 21 Jul 2000 15:55:29 -0400
>>> Chris Faylor <cgf@cygnus.com> said:

> Hmm.  I wonder if it wouldn't make sense to implement wcstombs using
> WideChartoMultiByte instead.

I have already implemented it. But wcstombs() must be sensitive
to a locale selected by an application according to ISO C and
the Single Unix Specification. As for the inside of Cygwin, the
conversion must be always done in the system default locale.  So
we must use WideCharToMultiByte in any case.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology

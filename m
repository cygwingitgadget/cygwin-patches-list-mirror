From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: generating /etc/passwd and /etc/group for domians with users with cyrillic names
Date: Wed, 11 Apr 2001 01:35:00 -0000
Message-id: <20010411103530.H956@cygbert.vinschen.de>
References: <130292291322.20010409223921@logos-m.ru> <20010410184619.Y956@cygbert.vinschen.de> <s1s66gcqmks.fsf@jaist.ac.jp> <20010410223404.A24731@redhat.com> <s1s1yr0q6vv.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00030.html

On Wed, Apr 11, 2001 at 03:37:24PM +0900, Kazuhiro Fujieda wrote:
> >>> On Tue, 10 Apr 2001 22:34:04 -0400
> >>> Christopher Faylor <cgf@redhat.com> said:
> 
> > Would it make sense to augment newlib to do the right thing, then?
> 
> No, I'm afraid it wouldn't.
> 
> `wcstombs' must be sensitive to a locale selected by an
> application according to the ISO C standard.
> In this case, however, it must be sensitive to the system
> default locale of Windows.
> 
> I believe we should use WideCharToMultiByte for i18n of such
> Windows specific tools.

Thanks for the explanation. As I wrote, I was just curious.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: generating /etc/passwd and /etc/group for domians with users with cyrillic names
Date: Tue, 10 Apr 2001 09:46:00 -0000
Message-id: <20010410184619.Y956@cygbert.vinschen.de>
References: <130292291322.20010409223921@logos-m.ru>
X-SW-Source: 2001-q2/msg00025.html

On Mon, Apr 09, 2001 at 10:39:21PM +0400, egor duda wrote:
> Hi!
> 
>   currently, mkpasswd and mkgroup print garbage if user name or group
> name contains cyrillic symbols. attached patch fixes that.

Hi Egor,

I'm somewhat surprised about that patch and pretty curious.
I had a look into the patch and basically it changes two
things:

- calling WideCharToMultiByte instead of wcstombs
- drops using wcslen.

Why is that needed? What is the problem with the original functions?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

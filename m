From: Chris Faylor <cgf@cygnus.com>
To: Chris Faylor <cygwin-patches@sources.redhat.com>
Subject: Re: Just checked in a major change to cygwin
Date: Mon, 04 Sep 2000 20:20:00 -0000
Message-id: <20000904231936.A1326@cygnus.com>
References: <20000903003055.A14834@cygnus.com> <128221669273.20000904115006@logos-m.ru>
X-SW-Source: 2000-q3/msg00063.html

On Mon, Sep 04, 2000 at 11:50:06AM +0400, Egor Duda wrote:
>Hi!
>
>Sunday, 03 September, 2000 Chris Faylor cgf@cygnus.com wrote:
>
>CF> For the last several weeks, I've been working on giving cygwin it's own
>CF> "heap".  I use this heap to allocate memory that should be common to a
>CF> process's children.  This was one of the things that I desperately wanted
>CF> copy-on-write for but I ended up implementing my own crude version instead.
>
>stat("f:\\tmp\\bla-bla",...)   causes   exception   with  your  latest
>changes.
>
>in this line (path.cc:1025)
>
>rc = normalize_win32_path (cwd_win32 (TMPCWD), src_path, dst);
>
>alloca()  is  called  after  src_path  and dst are put on stack. patch
>attached.

Hmm.  I don't exactly understand why this is a problem.  It doesn't
cause me any problems but maybe this is because I am using a different
version of the compiler.

Anyway, I took a look at cwd handling again and did what I should have
done the first time.  I think that path.cc now is a little more sane
with respect to its handling of the current working directory.

I made enough changes that I probably broke something new but at least
I won't have to puzzle over 37 different places where getcwd_inner was
called.

cgf

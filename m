From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Tue, 27 Nov 2001 10:37:00 -0000
Message-ID: <000601c17772$7c5ecfd0$2101a8c0@d8rc020b>
References: <3C035977.BF151D0A@syntrex.com>
X-SW-Source: 2001-q4/msg00255.html
Message-ID: <20011127103700.ltMfr57QdXEeWX3QjdvJY3TijZuMhQNHnMFtTY4EOwk@z>

> "Gary R. Van Sickle" wrote:
> >
> > Ok, setup.exe seems to work much better with this patch
> applied (also attached):
>
> Yep, I'm the one that screwed this up. Here is how it was before
> my patch was applied.
>
>   do {
>     l = s->gets ();
>     if (_strnicmp (l, "Content-Length:", 15) == 0)
>       sscanf (l, "%*s %d", &file_size);
>   } while (*l);
>
>
> What about replacing this in your patch:
> > +  while (((l = s->gets ()) != 0) && (strlen(l) != 0))
> with
>   +  while (((l = s->gets ()) != 0) && *l)
>

Ah, better yet.  Jeez you guys are clever ;-).  But how about we make it:

	while (((l = s->gets ()) != 0) && (*l != '\0'))

in the interest of making it a bit more self-documenting?

[snip]

> You say it works much better now - I'm curios if it worked
> at all (I think not).
>

Well, right, as far as getting anything downloaded and installed, I clearly
wasn't getting anywhere before.  I would get an almost-empty list of mirrors
(just the one I had used before, the 'enter one manually' choice, and
sometimes a garbage entry), and then it would GPF on the next "Next".  This
patch gets me at least to the choose.cc dialog now, and everything looks
A-OK; I haven't tried it past that point yet.

I'll reroll the patch when I get off work tonight, unless somebody else
thinks it's critical/easy enough to beat me to the punch.

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337

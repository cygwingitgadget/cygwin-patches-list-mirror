From: Benjamin Riefenstahl <Benjamin.Riefenstahl@epost.de>
To: cygwin-patches@cygwin.com
Subject: Re: Console codepage
Date: Sun, 28 Jan 2001 13:26:00 -0000
Message-id: <m3vgqztllj.fsf@benny-ppc.crocodial.de>
References: <u7l3fv26h.fsf@mail.epost.de> <20010128154852.A20701@redhat.com>
X-SW-Source: 2001-q1/msg00040.html

Hi Christopher,

Christopher Faylor <cgf@redhat.com> writes:
> Please look at the "Contributing" link on the Cygwin web page.  I've
> gone to some pains to update it lately by showing examples of common
> problems with patch submissions.  Unfortunately, there were several
> problems with this submission.

O.k., I hope this one is better (see below). 

> In the meantime, however, please check out that page.  If you could
> send an assignment form, too, that would help make sure that the
> legalities are covered.

That will take some time, especially for a disclaimer from my company.

so long, benny


Changelog entry:

Sun Jan 28 22:05:00 2001  Benjamin Riefenstahl  <Benjamin.Riefenstahl@epost.de>

        * fhandler_console.cc: Add functions cp_convert, con_to_str,
        str_to_con.
        * fhandler_console.cc,fhandler.h: Add method
        fhandler_console::prepare_output.
        * fhandler_console.cc (fhandler_console::read): Replace
        OemToCharBuff with con_to_str.
        * fhandler_console.cc (fhandler_console::write_normal): Replace
        CharToOemBuff with fhandler_console::prepare_output.

Patch (cvs diff -up):

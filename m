From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Date: Tue, 27 Nov 2001 15:41:00 -0000
Message-ID: <000001c1779c$e1fe2fa0$2101a8c0@NOMAD>
References: <20011127230925.GA5830@redhat.com>
X-SW-Source: 2001-q4/msg00261.html
Message-ID: <20011127154100.BAFFEZVbhjKS1SeSa1Rh0Ve0lwZsP4wJRDQtUM0pIYI@z>

> On Wed, Nov 28, 2001 at 09:12:20AM +1100, Robert Collins wrote:
> >On Wed, 2001-11-28 at 05:42, Christopher Faylor wrote:

[snip]

> >I think *l is ok. As for 0 vs NULL, in C++ NULL is
> deprecated, 0 is the
> >correct test for an invalid pointer.
>
> References?  A simple google search for 'NULL C++ deprecated' didn't
> unearth this information.
>

I thought I was getting those Google responses a little faster than usual
;-).  All I could find was a statement by Mr. Stroustrup (sp) indicating
that it was a 'tradition' he liked and wanted to promulgate, nothing
whatsoever about it being deprecated.  (If anyone's wondering, "<ptr> != 0"
is a completely valid and portable construct syntactically).

> Regardless, I strenuously disagree with this.  It certainly is not
> deprecated in the Cygwin DLL.
>

I'm with Chris on this one, again from a self-documenting standpoint if
nothing else.

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337

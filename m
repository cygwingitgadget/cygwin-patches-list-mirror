From: "Gregory W. Bond" <bond@research.att.com>
To: alcocer@helixdigital.com
Cc: cygwin-patches@cygwin.com
Subject: [Fwd: ghostscript binmode weirdness]
Date: Mon, 10 Dec 2001 17:49:00 -0000
Message-ID: <3C15668E.83F92142@research.att.com>
X-SW-Source: 2001-q4/msg00299.html
Message-ID: <20011210174900.tzzm_lqyP892j82xptZnla-Q0L3LBlh9WmGZ9HlWKL0@z>

[resent - i needed to subscribe to cygwin-patches]

Here's the fix as a patch file, as requested.

Robert Collins wrote:

> Send a patch thats contains your fix to the Ghostscript maintainer, cc'd
> to cygwin-patches.
>
> Rob
> ===
> ----- Original Message -----
> From: "Gregory W. Bond" <bond@research.att.com>
> To: <cygwin@cygwin.com>
> Sent: Monday, December 10, 2001 8:32 AM
> Subject: Re: ghostscript binmode weirdness
>
> > ok - i fixed the problem in the ghostscript port - how do i go about
> > getting the fix back into the cygwin distro?
> >
> > p.s. the link you sent me to is very clear about what the
> CYGWIN=binmode
> > achieves - however, another part of the cywin manual (the one i
> happened
> > to be reading: http://cygwin.com/cygwin-ug-net/using-textbinary.html )
> is
> > not nearly so clear which led to my confusion
> >
> >
> > > On Fri, Dec 07, 2001 at 10:43:11AM -0500, Gregory W. Bond wrote:
> > > > thanks for the reply larry - i realize that fixing the ghostscript
> port would
> > > > be a solution, but my impression from reading the cygwin user
> manual is that
> > > > setting CYGWIN to binmode could serve as a workaround - in my case
> it didn't
> > > > and i don't understand why - i'm beginning to suspect that cygwin
> is ignoring
> > > > that i've set CYGWIN to binmode which would be a cygwin bug
> > >
> > > That's not what the CYGWIN=binmode setting is for.
> > >
> > > http://cygwin.com/cygwin-ug-net/using-cygwinenv.html
> > >
> > > The workaround you're talking about would be to use binary mount
> points.
> > >
> > > Corinna
> > >
> >

--
Gregory W. Bond
AT&T Labs - Research
180 Park Avenue, Rm. D273, Bldg. 103
P.O. Box 971, Florham Park, NJ, 07932-0971, USA
tel: (973) 360 7216 fax: (973) 360 8187
--- ghostscript-6.51/src/gp_unifn.c.orig	Mon Dec 10 20:35:18 2001
+++ ghostscript-6.51/src/gp_unifn.c	Sun Dec  9 15:06:52 2001
@@ -27,11 +27,11 @@
 
 /* Define the string to be concatenated with the file mode */
 /* for opening files without end-of-line conversion. */
-const char gp_fmode_binary_suffix[] = "";
+const char gp_fmode_binary_suffix[] = "b";
 
 /* Define the file modes for binary reading or writing. */
-const char gp_fmode_rb[] = "r";
-const char gp_fmode_wb[] = "w";
+const char gp_fmode_rb[] = "rb";
+const char gp_fmode_wb[] = "wb";
 
 /* Answer whether a file name contains a directory/device specification, */
 /* i.e. is absolute (not directory- or device-relative). */

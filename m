Return-Path: <cygwin-patches-return-1573-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18022 invoked by alias); 11 Dec 2001 11:58:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18005 invoked from network); 11 Dec 2001 11:58:02 -0000
Message-ID: <3C15F498.F7E5C88F@yahoo.com>
Date: Fri, 02 Nov 2001 18:29:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: CP List <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gregory W. Bond" <bond@research.att.com>
CC: alcocer@helixdigital.com, cygwin-patches@cygwin.com
Subject: Re: [Fwd: ghostscript binmode weirdness]
References: <3C15668E.83F92142@research.att.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2001-q4/txt/msg00105.txt.bz2

FYI, this is the wrong list for this patch.  Cygwin-patches is for
patches to the cygwin runtime not the cygwin apps.  The appropriate list
is cygwin-apps.

Earnie.

"Gregory W. Bond" wrote:
> 
> [resent - i needed to subscribe to cygwin-patches]
> 
> Here's the fix as a patch file, as requested.
> 
> Robert Collins wrote:
> 
> > Send a patch thats contains your fix to the Ghostscript maintainer, cc'd
> > to cygwin-patches.
> >
> > Rob
> > ===
> > ----- Original Message -----
> > From: "Gregory W. Bond" <bond@research.att.com>
> > To: <cygwin@cygwin.com>
> > Sent: Monday, December 10, 2001 8:32 AM
> > Subject: Re: ghostscript binmode weirdness
> >
> > > ok - i fixed the problem in the ghostscript port - how do i go about
> > > getting the fix back into the cygwin distro?
> > >
> > > p.s. the link you sent me to is very clear about what the
> > CYGWIN=binmode
> > > achieves - however, another part of the cywin manual (the one i
> > happened
> > > to be reading: http://cygwin.com/cygwin-ug-net/using-textbinary.html)
> > is
> > > not nearly so clear which led to my confusion
> > >
> > >
> > > > On Fri, Dec 07, 2001 at 10:43:11AM -0500, Gregory W. Bond wrote:
> > > > > thanks for the reply larry - i realize that fixing the ghostscript
> > port would
> > > > > be a solution, but my impression from reading the cygwin user
> > manual is that
> > > > > setting CYGWIN to binmode could serve as a workaround - in my case
> > it didn't
> > > > > and i don't understand why - i'm beginning to suspect that cygwin
> > is ignoring
> > > > > that i've set CYGWIN to binmode which would be a cygwin bug
> > > >
> > > > That's not what the CYGWIN=binmode setting is for.
> > > >
> > > > http://cygwin.com/cygwin-ug-net/using-cygwinenv.html
> > > >
> > > > The workaround you're talking about would be to use binary mount
> > points.
> > > >
> > > > Corinna
> > > >
> > >
> 
> --
> Gregory W. Bond
> AT&T Labs - Research
> 180 Park Avenue, Rm. D273, Bldg. 103
> P.O. Box 971, Florham Park, NJ, 07932-0971, USA
> tel: (973) 360 7216 fax: (973) 360 8187
> 
>   ------------------------------------------------------------------------
> --- ghostscript-6.51/src/gp_unifn.c.orig        Mon Dec 10 20:35:18 2001
> +++ ghostscript-6.51/src/gp_unifn.c     Sun Dec  9 15:06:52 2001
> @@ -27,11 +27,11 @@
> 
>  /* Define the string to be concatenated with the file mode */
>  /* for opening files without end-of-line conversion. */
> -const char gp_fmode_binary_suffix[] = "";
> +const char gp_fmode_binary_suffix[] = "b";
> 
>  /* Define the file modes for binary reading or writing. */
> -const char gp_fmode_rb[] = "r";
> -const char gp_fmode_wb[] = "w";
> +const char gp_fmode_rb[] = "rb";
> +const char gp_fmode_wb[] = "wb";
> 
>  /* Answer whether a file name contains a directory/device specification, */
>  /* i.e. is absolute (not directory- or device-relative). */

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


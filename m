Return-Path: <cygwin-patches-return-5028-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28269 invoked by alias); 6 Oct 2004 16:00:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28256 invoked from network); 6 Oct 2004 16:00:25 -0000
Message-ID: <4164168F.39CBC779@phumblet.no-ip.org>
Date: Wed, 06 Oct 2004 16:00:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about trailing (back)slash on mount entries
References: <n2m-g.ck100t.3vvcra7.1@buzzy-box.bavag> <20041006145931.GC29289@trixie.casa.cgf.cx> <41640F89.9AEEFD2A@phumblet.no-ip.org> <20041006154644.GE29973@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00029.txt.bz2



Christopher Faylor wrote:
> 
> On Wed, Oct 06, 2004 at 11:30:17AM -0400, Pierre A. Humblet wrote:
> >
> >Christopher Faylor wrote:
> >>
> >> On Wed, Oct 06, 2004 at 03:12:45PM +0200, Bas van Gompel wrote:
> >> >Another (hopefully trivial) patch, to help in trouble-shooting.
> >>
> >> Wasn't there another problem where "foo\/bar" type of entries were
> >> showing up?  Could you add a check for that, too?
> >
> >I while ago I have modified Cygwin to accept this kind of syntax.
> >Is there a remaining problem in the current release?
> >Otherwise I don't see the need to alarm the user.
> 
> It's just a warning.  This really shouldn't be in the mount table
> and it really should be corrected.

I don't think it's checking the mount table, it's checking the registry.
The entry will be cleaned up by the time it gets to the mount table.
What would be useful is a check that ::add_item will accept the registry
entry, i.e. won't return EINVAL or perhaps "path too long".
The relevant part of add_item is pasted below. It shows when EINVAL
is returned.

Pierre

mount_info::add_item (const char *native, const char *posix, unsigned mountflags, int reg_p)
{
  char nativetmp[CYG_MAX_PATH];
  char posixtmp[CYG_MAX_PATH];
  char *nativetail, *posixtail, error[] = "error";
  int nativeerr, posixerr;

  /* Something's wrong if either path is NULL or empty, or if it's
     not a UNC or absolute path. */

  if (native == NULL || !isabspath (native) ||
      !(is_unc_share (native) || isdrive (native)))
    nativeerr = EINVAL;
  else
    nativeerr = normalize_win32_path (native, nativetmp, &nativetail);

  if (posix == NULL || !isabspath (posix) ||
      is_unc_share (posix) || isdrive (posix))
    posixerr = EINVAL;
  else
    posixerr = normalize_posix_path (posix, posixtmp, &posixtail);

  debug_printf ("%s[%s], %s[%s], %p",
                native, nativeerr ? error : nativetmp,
                posix, posixerr ? error : posixtmp, mountflags);

  if (nativeerr || posixerr)
    {
      set_errno (nativeerr?:posixerr);
      return -1;
    }

  /* Make sure both paths do not end in /. */
  if (nativetail > nativetmp + 1 && nativetail[-1] == '\\')
    nativetail[-1] = '\0';
  if (posixtail > posixtmp + 1 && posixtail[-1] == '/')
    posixtail[-1] = '\0';

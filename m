Return-Path: <cygwin-patches-return-5030-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27496 invoked by alias); 7 Oct 2004 00:04:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27487 invoked from network); 7 Oct 2004 00:04:19 -0000
Message-ID: <n2m-g.ck27t3.3vvfbs7.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: warn about trailing (back)slash on mount entries
References: <n2m-g.ck100t.3vvcra7.1@buzzy-box.bavag> <20041006145931.GC29289@trixie.casa.cgf.cx> <41640F89.9AEEFD2A@phumblet.no-ip.org> <20041006154644.GE29973@trixie.casa.cgf.cx> <4164168F.39CBC779@phumblet.no-ip.org>
In-Reply-To: <4164168F.39CBC779@phumblet.no-ip.org>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Thu, 07 Oct 2004 00:04:00 -0000
X-SW-Source: 2004-q4/txt/msg00031.txt.bz2

Op Wed, 06 Oct 2004 12:00:15 -0400 schreef Pierre A. Humblet
in <4164168F.39CBC779@phumblet.no-ip.org>:
:
:
:  Christopher Faylor wrote:
: >
: > On Wed, Oct 06, 2004 at 11:30:17AM -0400, Pierre A. Humblet wrote:
: >>
: >> Christopher Faylor wrote:
: >>>
: >>> On Wed, Oct 06, 2004 at 03:12:45PM +0200, Bas van Gompel wrote:
: >>>> Another (hopefully trivial) patch, to help in trouble-shooting.
: >>>
: >>> Wasn't there another problem where "foo\/bar" type of entries were
: >>> showing up?  Could you add a check for that, too?

I think so.

Would it also be of interest to check for forward slashes in the
native-, and backslashes in the posix-path?

: >> I while ago I have modified Cygwin to accept this kind of syntax.
: >> Is there a remaining problem in the current release?
: >> Otherwise I don't see the need to alarm the user.
: >
: > It's just a warning.  This really shouldn't be in the mount table
: > and it really should be corrected.
:
:  I don't think it's checking the mount table, it's checking the registry.

Indeed.

:  The entry will be cleaned up by the time it gets to the mount table.

Is that a reason to not /attempt/ to ensure the entries in the registry
are correct? One might consider writing back the cleaned up entries to
the registry.

:  What would be useful is a check that ::add_item will accept the registry
:  entry, i.e. won't return EINVAL or perhaps "path too long".

mount_info::add_info is not available when running cygcheck, it being
a mingw app. (BYKT)

:  The relevant part of add_item is pasted below. It shows when EINVAL
:  is returned.

The resulting patch would not be trivial, so I can't be submitting it,
as long as i've not received any reply from the Red Hat legal team on
my query. (I don't want to cause the patch to become inadmissible.)

Sorry.

BTW: Any reason for not applying the trailing-slash patch? (If I were
to add any of the here discussed, I would expect to be (rightly) told
to split the patch into functionally distinct parts.)

L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re

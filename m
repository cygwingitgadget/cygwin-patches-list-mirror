Return-Path: <cygwin-patches-return-3176-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16009 invoked by alias); 14 Nov 2002 19:21:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16000 invoked from network); 14 Nov 2002 19:21:07 -0000
Date: Thu, 14 Nov 2002 11:21:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021114202105.N10395@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DD27B59.3FA8990@ieee.org> <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <3.0.5.32.20021113223509.0082c960@mail.attbi.com> <20021114110340.G10395@cygbert.vinschen.de> <3DD3B369.A530D7EE@ieee.org> <20021114173630.A20639@cygbert.vinschen.de> <3DD3D75C.99C07A78@ieee.org> <20021114182323.L10395@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114182323.L10395@cygbert.vinschen.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00127.txt.bz2

On Thu, Nov 14, 2002 at 06:23:23PM +0100, Corinna Vinschen wrote:
> On Thu, Nov 14, 2002 at 12:03:24PM -0500, Pierre A. Humblet wrote:
> > If you are emulated, you already have the token in the cygheap->user.
> > There is no need to open the thread, see how it's done e.g.in setegid.
> 
> Good point.
> 
> > You want to know if the file owner uid is in the group of the file gid.
> > Write a new routine scanning the /etc/group file until you find the gid.
> > Then scan the members of that group to see if the uid is in it.
> > That's it (well, there will be mutex too, against threads rereading /etc/group).
> 
> Also a good point.  I'm going to rewrite is_grp_member().

I've checked in a patch to getgroups32() and is_grp_member().

getgroups32() now only makes sense for the current user again.  It uses
the impersonation token if impersonated.

is_grp_member() calls getgroups32() only for the current user and
scans passwd and group otherwise, trying to be more efficient.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

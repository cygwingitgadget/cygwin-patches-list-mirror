Return-Path: <cygwin-patches-return-3163-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5545 invoked by alias); 13 Nov 2002 17:45:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5523 invoked from network); 13 Nov 2002 17:45:37 -0000
Message-ID: <3DD28FCB.DA9F052C@ieee.org>
Date: Wed, 13 Nov 2002 09:45:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
References: <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <20021113175002.Y10395@cygbert.vinschen.de> <3DD28CAF.4B7C19CE@ieee.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00114.txt.bz2

Oops, there is an error in our examples.
The Everyone permission should propagate.
Here is the correct output.

"Pierre A. Humblet" wrote:
> 
> Corinna Vinschen wrote:
> >
> > On Wed, Nov 13, 2002 at 11:18:33AM -0500, Pierre A. Humblet wrote:
> > > Corinna Vinschen wrote:
> > > > I think I found an easy (not necessaily fast) solution which doesn't
> > > > involve calling the PDC.  Basically we do already depend on /etc/group
> > > > heavily so we can do this here, too, IMHO:
> > >
> > > Yes, that works (most of the time) assuming that /etc/group was build with
> > > mkgroup -u.
> > > But still, I wouldn't do it, for many reasons:
> > > - it adds overhead to stat (), which is already slow
> >
> > It doesn't add any overhead which isn't already there.
> >
> If "already" is before the patch, it scans the group file instead of scanning
> the token groups. If "already" is after the patch, it scans the group file
> instead of scanning the token groups or doing nothing, depending if the uid
> of the file owner differs from the uid of the process.
> 
> >
> > The problem we're trying to circumvent is the following:
> >
> > Owner:  User_foo
> > Group:  Admins
> > ACL:    Admins rwx
> >         Everyone r--
> >
> > Following your suggestion we get:
> >
> > $ ls -l
> >  ---rwxr-- 1 User_foo Admins ... bar
> >
> > This doesn't reflect the real permissions of the user at all, not even
> > approximately.
> >
> > The current code creates:
> >
> > $ ls -l
> >  rwxrwxr-- 1 User_foo Admins ... bar
> >
> > which reflects the truth somewhat better *and* solves a lot of problems
> > we had in earlier implementations.
> 
> The fundamental problem is that there is not enough information to know
> the "real permissions" of the owner. Is User_foo a member of Admins or not,
> at the time she accesses the file ?
> 
> You make a lot of assumptions in your example. A more detailed description of
> the way the code works today (before patch) is this:
> 
> If the process running ls -l is a member of Admins:
>  rwxrwxr--
> If the process running ls -l in not a member of Admins:
>  ---rwxr--
> and that's the case *whether or not* User_foo is *nominally* a member of Admins.
> Note the dependency on the process running the command and the absence of
> dependency on what User_foo actually belongs to !!!
> 
> Your example implicitly assumes that User_foo is a member of Admins and
> the ls -l is run by a member of Admins.
> 
> With the current patch, the output of ls -l would be
>  r--rwxr--
> if ls -l is run by somebody else than User_foo
> It would be
>  rwxrwxr--
> if ls -l is run by User_foo if User_foo is *currently* a member of Admins, and
>  r--rwxr--
> if ls -l is run by User_foo if User_foo is NOT *currently* a member of Admins
> To me, that's slightly better than currently.
> 
> Note also that your example assumes implicitly that the ACL was not created
> by Cygwin. With the current patch,
> if the chmod is 774, the acl would be
>     User_foo  rwx
>     Admins    rwx
>     Everyone  r--
> if the chmod is 074, the acl would be
>     User_foo deny rwx
>     Admins   rwx
>     Everyone r--
if the chmod is 474 the acl would be
     User_foo deny -wx
     User_foo r__
     Admins   rwx
     Everyone r--

> So there is absolutely no dependency on whether User_foo is or isn't a member
> of Admins at the time she accesses the file. Everything is completely determined
> by the chmod and it is not necessary to scan the token groups.
> 
> Pierre

Return-Path: <cygwin-patches-return-3187-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11371 invoked by alias); 15 Nov 2002 17:29:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11361 invoked from network); 15 Nov 2002 17:29:31 -0000
Message-ID: <3DD52F08.44B62AAE@ieee.org>
Date: Fri, 15 Nov 2002 09:29:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
References: <3DD3B369.A530D7EE@ieee.org> <20021114173630.A20639@cygbert.vinschen.de> <3DD3D75C.99C07A78@ieee.org> <20021114182323.L10395@cygbert.vinschen.de> <20021114202105.N10395@cygbert.vinschen.de> <3.0.5.32.20021114220454.0082ca20@mail.attbi.com> <20021115105000.A24928@cygbert.vinschen.de> <3DD5053C.E50A33@ieee.org> <20021115160223.L24928@cygbert.vinschen.de> <3DD511B4.DBF3846E@ieee.org> <20021115180630.A31146@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00138.txt.bz2

Corinna Vinschen wrote:

> Yep.  But as far as I'm concerned we should drop that part of your
> patch until I could update ssh.

What about putting it in with #if 0 ?
It will then be easier to turn it on when ssh is ready.

Alternatively I could add it, but add a check for group 
sid is SYSTEM, and then skip the step. That would be very easy
to do, and to remove later when ssh is ready.
I like this best actually.
 
> > It's not a group_deny, it's an owner deny (which would go on top, so canonical
> > order is OK here).
> 
> Oops, thick fingers...
> 
> > Also if the owner is not in the group when alloc_sd is called, and is placed
> > in the group later, then the owner access mode of the file would change, which
> > isn't POSIX.
> > Let's look at it from another angle: what is gained by going through the trouble
> > of calling is_grp_member and possibly omitting the owner_deny?
> 
> Since is_grp_member() isn't that slow anymore, what does it hurt to
> get the situation right in the first place?  I'm somehow more and more
> convinced that this is just a matter of taste.

As far as I can see there is absolutely no advantage to calling  
is_grp_member() in alloc_sd() and by potentially omitting the owner_deny
we are making the situation worse! So here I am insistent!

> > The non canonical order is produced when the group has less permission
> > than everyone, which I agree is unlikely.
> 
> Yeah, my mind was on another issue.  Time for weekend.
> 
> > It's 100% OK with me to give preference to being nice!
> 
> Ok.  I'm really sorry that I'm making your live that hard but I assume
> you know that I'm just trying to find something as a best solution (if
> that's at all possible).

Sure, and it's reciprocal.

By the way could you ask your friend if large organizations really
use deny ACEs? Are there tools that insert them in ACLs? 

Have a relaxing weekend!

Pierre

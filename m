Return-Path: <cygwin-patches-return-3189-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29946 invoked by alias); 15 Nov 2002 17:56:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29933 invoked from network); 15 Nov 2002 17:56:12 -0000
Date: Fri, 15 Nov 2002 09:56:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021115185609.Q24928@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DD3D75C.99C07A78@ieee.org> <20021114182323.L10395@cygbert.vinschen.de> <20021114202105.N10395@cygbert.vinschen.de> <3.0.5.32.20021114220454.0082ca20@mail.attbi.com> <20021115105000.A24928@cygbert.vinschen.de> <3DD5053C.E50A33@ieee.org> <20021115160223.L24928@cygbert.vinschen.de> <3DD511B4.DBF3846E@ieee.org> <20021115180630.A31146@cygbert.vinschen.de> <3DD52F08.44B62AAE@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD52F08.44B62AAE@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00140.txt.bz2

On Fri, Nov 15, 2002 at 12:29:44PM -0500, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> 
> > Yep.  But as far as I'm concerned we should drop that part of your
> > patch until I could update ssh.
> 
> What about putting it in with #if 0 ?
> It will then be easier to turn it on when ssh is ready.
> 
> Alternatively I could add it, but add a check for group 
> sid is SYSTEM, and then skip the step. That would be very easy
> to do, and to remove later when ssh is ready.
> I like this best actually.

Good idea!  Me too.  But that must go into both functions,
get_attribute_from_acl() and alloc_sd().

> > Since is_grp_member() isn't that slow anymore, what does it hurt to
> > get the situation right in the first place?  I'm somehow more and more
> > convinced that this is just a matter of taste.
> 
> As far as I can see there is absolutely no advantage to calling  
> is_grp_member() in alloc_sd() and by potentially omitting the owner_deny
> we are making the situation worse! So here I am insistent!

Hmm.

> By the way could you ask your friend if large organizations really
> use deny ACEs? Are there tools that insert them in ACLs? 

Historically they are currently not using deny ACEs since they were
more or less unknown under NT4.  In the next months, they will
upgrade to 2K and the usage of deny ACEs is officially projected.

Greetings from him (Michael Hirmke), btw.!

> Have a relaxing weekend!

Thanks, you too,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

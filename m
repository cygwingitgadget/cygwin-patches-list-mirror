Return-Path: <cygwin-patches-return-3209-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31110 invoked by alias); 20 Nov 2002 15:04:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31101 invoked from network); 20 Nov 2002 15:04:38 -0000
Message-ID: <3DDBA495.C5A801A2@ieee.org>
Date: Wed, 20 Nov 2002 07:04:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec patch #4: passwd and group
References: <20021111145612.T10395@cygbert.vinschen.de> <3DCFC6BB.570DF472@ieee.org> <20021111174720.X10395@cygbert.vinschen.de> <3DCFE314.3B5B45AB@ieee.org> <20021111183423.A10395@cygbert.vinschen.de> <3DCFF8AE.66CBD751@ieee.org> <20021112144038.F10395@cygbert.vinschen.de> <3DD13433.D618DC4F@ieee.org> <20021112181849.K10395@cygbert.vinschen.de> <3.0.5.32.20021117224418.0083ac70@mail.attbi.com> <20021120114009.E24928@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00160.txt.bz2

Corinna Vinschen wrote:
> 
> Some questions and comments:
> 
> >
> >       * security.h: [...]. Undeclare internal_getpwent.
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                              You didn't.
Sorry, looks like I messed up my versions. It was done at some point.

> > -/* FIXME: should be static but this is called in uinfo_init outside this
> > -   file */
> > -void
> > +static void
> >  read_etc_group ()
> 
> Do I miss something?  I don't see that in this patch.

What do you mean? Your comment is in the middle of a patch.
If you are talking about the FIXME, it must be ancient. The problem
was gone before I did anything.

> > +
> > +      /* Complete /etc/group in memory if needed */
> > +      if (!getgrgid32 (myself->gid))
> 
> ?!? How is that supposed to work?  We're in group_state==initializing,
> therefore in getgrgid32(), read_etc_group() is called.  Isn't that
> somewhat dangerous?

Yes, I was hesitant to do it but never saw any problem. 
group_state.set_last_modified () has just been called, but even
if the file had been modified again I think we would be OK.
That will soon go away anyway, see below. 

> Didn't you propose to get rid of the LookupAccountSidA() calls?

Yes, I did. It wasn't clear to me that you agreed. 
 
> Ahem, I thought we agreed that we don't call external functions from
> inside Cygwin?  Never mind, there are still some of them which we have
> to eliminate, anyway.

I didn't know about that policy but it suits me fine. As we discussed,
internal calls to passwd/group functions should never reread the files,
so new entry points are called for. I was going to do that in a second
step, it wasn't a goal when I started.

> > +  if ((pw = getpwuid32 (uid)))
> 
> Same here.  Somehow it's a step in the wrong direction...
See above. The goal is to avoid (indirectly) calling WaitForSingleObject
for each line in the passwd file. 

How do you want to proceed? Apply this patch and undeclare internal_getpwent,
remove LookupAccountSidA(), apply your "I'd better like" and introduce
internal lookup functions in a few days, or prepare a single all-encompassing
patch in a few days?

Pierre

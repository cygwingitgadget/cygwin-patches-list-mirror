Return-Path: <cygwin-patches-return-2380-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11086 invoked by alias); 10 Jun 2002 14:15:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11072 invoked from network); 10 Jun 2002 14:15:14 -0000
Message-ID: <3D04B57B.E4E3E5C@ieee.org>
Date: Mon, 10 Jun 2002 07:15:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com> <20020610035228.GC6201@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00363.txt.bz2

Christopher Faylor wrote:

> >It is called in 3 cases:
> >a) Entry from Windows
> >b) From seteuid()
> 
> Yep.
> 
> >c) After CreateProcessAsUser()
> 
> Where is this?  I only see two calls in cygwin currently.

Sorry I was unclear. a) and c) happen in the child via a call
to uinfo_init. b) happens in the parent. 
> 
> The one in uinfo_init can't go away, can it?  If not, then I don't
> see any reason why we can't press it into service for both a and c.

Right, it must stay. But there is much less to be done in case c) 
[except possibly from sexecXX] than in case a), that's why I separate 
the two cases [I think we can avoid reading /etc/passwd in case c, 
I'll discuss that after testing the idea].
> 
> I don't understand why moving the initialization code from the child to
> the parent is a good thing. Theoretically, the parent can just start... 
We agree, it's not a good thing, and that's not quite what is done. 
The change would delay the initialization that is already done in the 
parent [from seteuid()] to the moment where it's needed, in spawn_guts() 
[if it is ever called, which in the case of mail servers is rare].
The reason that the 2nd function cannot be pushed to the child is 
the weird behavior of LookupAccountSid(). More generally, there is no 
practical way for an impersonated process to find its real identity 
(as Corinna knows too well) and thus to set its Windows environment.

The above should answer your previous question:
> Wait a minute.  Case c is the CreateProcessAsUser case.  Are you saying
> that spawn_guts would need to use both the first function and the second
> function?
but to be completely clear, spawn_guts() only calls the second, the
child calls the first through uinfo_init.

> I don't know about the sexec question.  Anyone know if there are (or
> were) any actual applications out there which use sexecve?  Isn't this
> just a cygwin invention?  I wonder if we should just nuke it from cygwin
> and see if anyone complains.  It would certainly simplify spawn.cc.

No objection !
> Other minor nits: You made at least one gratuitous formatting change
> (moving a '&&' to a previous line) and your choice of function names is
> not really in tune with most of the other cygwin function names.  The
> function names should at least be consistent with the other function
> names in the file.  
OK, I'll change that, of course.

Corinna also makes a point about reading the 4th character. I should 
have flagged the issue myself. Nothing bad happens if the 4th character
is outside the string (because strcmp is called anyway and it will stop
at the final 0), as long as it is in readable memory. Practically
speaking, I thought it would always be there. A completely clean code 
would call strcmp() several times.

Pierre

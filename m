Return-Path: <cygwin-patches-return-2274-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31241 invoked by alias); 31 May 2002 01:50:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31225 invoked from network); 31 May 2002 01:50:38 -0000
Message-ID: <20020531015038.75913.qmail@web20702.mail.yahoo.com>
Date: Thu, 30 May 2002 18:50:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Subject: Re: [MinGW-dvlpr] [Re]move  w32api/include/excpt.h
To: Danny Smith <danny_r_smith_2001@yahoo.co.nz>,
  cygwin-patches <cygwin-patches@cygwin.com>,
  mingw-dvlpr <mingw-dvlpr@lists.sourceforge.net>
In-Reply-To: <20020531004755.25499.qmail@web14505.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00257.txt.bz2

--- Danny Smith <danny_r_smith_2001@yahoo.co.nz> wrote:
> The w32api and mingw-runtime each conatin a file called excpt.h
> The one in the w32api just defines  __try, __except, __finally as
> no-ops and lets some code "at least" compile.  I would like to get rid of
> that
> file, so mingw has only one excpt.h and we don't have the perennial problem
> of one overwriting the other, depending on order of installation.
> 
> This patch puts the no-op defines in windef.h, so that they are still
> available to cygwin users of w32api and to mingw.  Alternative option
> is to put them in the mingw-runtime version of excpt.h and thus remove
> them from cygwin.
> 

I think this is a good compromise.

> I think they should go in the rubbish, but others may like to have code
> that compiles and links fine and then crashes at runtime.  
> 

Me too, so I think your __SEH_NOOP should be implemented.  That way the analyst
can decide.

> No, I don't mean to stir up a long debate over this, I just want to get rid
> of
> the file somehow.  
> 

I'm glad you have.  On a side note, have you looked at the SEH patch that was
on the mingw-users list a month or so ago?  I put it on my round tuit list but
that's a deep stack.

Earnie.

=====
Earnie Boyd
mailto:earnie_boyd@yahoo.com

---         <http://earniesystems.safeshopper.com>         ---
--- Cygwin: POSIX on Windows <http://gw32.freeyellow.com/> ---
---   Minimalist GNU for Windows <http://www.mingw.org/>   ---

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

Return-Path: <cygwin-patches-return-2275-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4478 invoked by alias); 31 May 2002 01:54:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4429 invoked from network); 31 May 2002 01:54:43 -0000
Message-ID: <20020531015443.95953.qmail@web20708.mail.yahoo.com>
Date: Thu, 30 May 2002 18:54:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Subject: Re: [MinGW-dvlpr] [Re]move  w32api/include/excpt.h
To: Steven Edwards <steven_ed4153@yahoo.com>,
  Danny Smith <danny_r_smith_2001@yahoo.co.nz>,
  cygwin-patches <cygwin-patches@cygwin.com>,
  mingw-dvlpr <mingw-dvlpr@lists.sourceforge.net>
In-Reply-To: <20020531013127.92260.qmail@web21106.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00258.txt.bz2


--- Steven Edwards <steven_ed4153@yahoo.com> wrote:
> > The w32api and mingw-runtime each conatin a file
> > called excpt.h
> > The one in the w32api just defines  __try, __except,
> > __finally as
> > no-ops and lets some code "at least" compile
> 
> Kinda off topic 

Not at all off topic.

> but is there a plan to add real
> Windows SEH support to Mingw? I know this is asked a
> lot but I've never really heard a good answer. 

When someone has time to work on it, or someone submits a patch, yes.

> Untill
> Mingw has it, ReactOS wont be able to use most Windows
> drivers.
> 

IIRC, I heard    ors that ReactOS was working on modifications for GCC and/or
binutils to accomplish that.

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

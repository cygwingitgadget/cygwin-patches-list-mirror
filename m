Return-Path: <cygwin-patches-return-2488-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17760 invoked by alias); 22 Jun 2002 15:03:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17729 invoked from network); 22 Jun 2002 15:03:22 -0000
Message-ID: <20020622150321.13099.qmail@web20708.mail.yahoo.com>
Date: Sat, 22 Jun 2002 08:03:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Subject: Re: Add FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>
To: Conrad Scott <Conrad.Scott@dsl.pipex.com>,
  Earnie Boyd <Cygwin-Patches@Cygwin.Com>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <00bc01c2197a$2e4edce0$6132bc3e@BABEL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00470.txt.bz2

I would use >= 0x0500

Earnie.
--- Conrad Scott <Conrad.Scott@dsl.pipex.com> wrote:
> "Earnie Boyd" <earnie_boyd@yahoo.com> wrote:
> > MSDN says that this is Win2000 SP2 and XP only.  So you need to
> guard it
> > with the appropriate WINVER constant.
> 
> Sorry about my earlier querulous email: I was blissfully ignorant of
> the whole WINVER system.
> 
> My problem now is to choose a relevant version number to check
> against. As far as I can dig out of MSDN, win2k has _WIN32_WINNT set
> to 0x0500 and XP has it set to 0x0501. So, unlike some earlier
> systems, there's no space for extra version numbers for service pack
> releases.
> 
> So, to guard a define that's only available in win2k SP2 and in XP,
> which value should I use? (win2k or XP?) or is there some other value
> that is available now for service pack version information?
> 
> // Conrad
> 
> 
> 


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

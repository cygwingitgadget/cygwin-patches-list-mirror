Return-Path: <cygwin-patches-return-4981-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7317 invoked by alias); 22 Sep 2004 18:50:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7304 invoked from network); 22 Sep 2004 18:50:22 -0000
Date: Wed, 22 Sep 2004 18:50:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance problem])
Message-ID: <20040922185116.GA7863@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040912144258.GB11786@cygbert.vinschen.de> <20040913180937.400E2E538@carnage.curl.com> <20040914091029.GC3757@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914091029.GC3757@cygbert.vinschen.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00133.txt.bz2

As a follow up on this, I just found that the problem with the Win32
native version of unison described in

  http://cygwin.com/ml/cygwin/2004-09/msg01131.html
  
is also a consequence of the new pipe code.  The hang only happens
with the new code, with the old pipe code it works fine.   And Karl
seems to be right, it only happens on XP SP2.  He tested on W2K and
XP pre SP1, I just tested on NT4 SP6 and could verify that it works
fine there, too.  That's really weird.


Corinna


On Sep 14 11:10, Corinna Vinschen wrote:
> On Sep 13 14:09, Bob Byrnes wrote:
> > On Sep 12,  4:42pm, Corinna Vinschen wrote:
> > -- Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
> > This all works most of the time.  But it interacts badly with the
> > POSIX atomic write requirements related to PIPE_BUF.  In particular,
> > select should say that a pipe is not writable when there is < PIPE_BUF
> > space available (and our implementation does this).
> 
> I reread the description of CreateNamedPipe in MSDN and now I'm wondering
> if exactly that, trying to mimic POSIX atomic writes, is the culprit of
> the problem.  MSDN states:
> [...]

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

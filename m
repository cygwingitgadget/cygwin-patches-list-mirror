Return-Path: <cygwin-patches-return-4963-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24421 invoked by alias); 14 Sep 2004 09:09:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24407 invoked from network); 14 Sep 2004 09:09:43 -0000
Date: Tue, 14 Sep 2004 09:09:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-ID: <20040914091029.GC3757@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040912144258.GB11786@cygbert.vinschen.de> <20040913180937.400E2E538@carnage.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913180937.400E2E538@carnage.curl.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00115.txt.bz2

On Sep 13 14:09, Bob Byrnes wrote:
> On Sep 12,  4:42pm, Corinna Vinschen wrote:
> -- Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
> This all works most of the time.  But it interacts badly with the
> POSIX atomic write requirements related to PIPE_BUF.  In particular,
> select should say that a pipe is not writable when there is < PIPE_BUF
> space available (and our implementation does this).

I reread the description of CreateNamedPipe in MSDN and now I'm wondering
if exactly that, trying to mimic POSIX atomic writes, is the culprit of
the problem.  MSDN states:

  "Whenever a pipe write operation occurs, the system first tries to charge
   the memory against the pipe write quota. If the remaining pipe write
   quota is enough to fulfill the request, the write operation completes
   immediately. If the remaining pipe write quota is too small to fulfill
   the request, the system will try to expand the buffers to accommodate
   the data using nonpaged pool reserved for the process. The write operation
   will block until the data is read from the pipe so that the additional
   buffer quota can be released. Therefore, if your specified buffer size
   is too small, the system will grow the buffer as needed, but the downside
   is that the operation will block."

I'm not sure if my interpretation is correct, but I'd guess that the OS
would also try to force a flush, as soon as the write buffer had to be
expanded beyond the write quota.  Our implementation of select *prevents*
the write buffer to be expanded...  Do you understand what I mean?

> > |                                         I guess this means that local
> > | pipes always do buffering as described in the previous paragraph, and
> > | this can't be disabled using FILE_FLAG_WRITE_THROUGH.
> > 
> > Did you try that?
> 
> I haven't yet, but I will.  Disabling buffering would fix the problem.

Just another random idea.  What if the pipe isn't called \\.\xxx but
instead \\${hostname}\xxx ?  Perhaps (but not likely) the pipe is then
treated as remote.

> Or if we could somehow control the buffering parameters (the high-water

Hmm, there's just this DefaultTimeout value which seems to be somewhat
unrelated.

> mark or the timer), that would also probably be sufficient.  In particular,
> setting the high-water mark to reserve PIPE_BUF bytes would be perfect.

The problem is that the buffer sizes given to CreateNamedPipe are just
*advisory* to the system.

> > Dunno if that's a *better* idea, but would it be reasonable to try changing
> > pipes to use overlapped I/O?
> 
> Maybe, but that seems complicated.  I'm hoping for something simpler.

Well, it's not *that* complicated.  But when reading MSDN, I'm entertaining
some doubt that it would really help for pipes.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

Return-Path: <cygwin-patches-return-4957-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5365 invoked by alias); 12 Sep 2004 14:42:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5215 invoked from network); 12 Sep 2004 14:42:13 -0000
Date: Sun, 12 Sep 2004 14:42:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-ID: <20040912144258.GB11786@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040910204850.AFD08E538@carnage.curl.com> <20040911182020.A6F2AE538@carnage.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911182020.A6F2AE538@carnage.curl.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00109.txt.bz2

On Sep 11 14:20, Bob Byrnes wrote:
> When the inbound transfer stalls, I see sftp performing a blocking
> read on the ssh->sftp pipe.  It seems to be reading 16k chunks (even
> though the default buffer size is supposed to be 32k ... see below).
> 
> ssh is using select to monitor both pipes and the socket, but the
> ssh->sftp pipe doesn't select writable for long periods of time,
> because NtQueryInformationFile reports that the pipe is full.
> That's odd: why isn't the data in transit within the pipe delivered
> to the reading sftp process?

Do I understand that right?  sftp is in the blocking read on the pipe,
there is data in the pipe and nevertheless read doesn't return?  That's
odd.

> But the docs also say that "Write-through mode ... affects only write
> operations on byte-type pipes and, then, only when the client and server
> processes are on different computers."  I guess this means that local
> pipes always do buffering as described in the previous paragraph, and
> this can't be disabled using FILE_FLAG_WRITE_THROUGH.

Did you try that?

> So, what should we do now?  We need a reliable way to tell if writes
> will block, for both select and nonblocking I/O.  I've been using
> NtQueryInformationFile to see how much space is available (analogous
> to use of PeekNamedPipe for reads), but we need to control how pipe
> buffering is done.
> 
> I'll do some experiments ... maybe we can use something like FlushFileBuffers
> before NtQueryInformationFile to induce data transfer to any pending reads on
> the other side of the pipe, although I'm concerned that this might block
> when there is no pending read, and that would be bad.
> 
> Other, better ideas would be most welcome!

Dunno if that's a *better* idea, but would it be reasonable to try changing
pipes to use overlapped I/O?  Or what if a read from a pipe always asks for
the number of available bytes using NtQueryInformationFile and then only
actually reads this number of bytes and returns that to the caller?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

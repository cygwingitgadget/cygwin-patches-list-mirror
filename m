Return-Path: <cygwin-patches-return-4960-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6772 invoked by alias); 13 Sep 2004 18:18:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6722 invoked from network); 13 Sep 2004 18:18:05 -0000
Date: Mon, 13 Sep 2004 18:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-ID: <20040913181937.GA21138@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040912144258.GB11786@cygbert.vinschen.de> <20040913180937.400E2E538@carnage.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913180937.400E2E538@carnage.curl.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00112.txt.bz2

On Mon, Sep 13, 2004 at 02:09:37PM -0400, Bob Byrnes wrote:
>>Or what if a read from a pipe always asks for the number of available
>>bytes using NtQueryInformationFile and then only actually reads this
>>number of bytes and returns that to the caller?
>>
>-- End of excerpt from Corinna Vinschen
>
>That's similar to nonblocking reads, and it might work, and I guess for
>blocking reads we would never attempt to read more than the size of the
>pipe minus PIPE_BUF.  If we don't want to return partial data, then we
>could redo reads until all of the data is delivered to the calling
>program, but I think partial reads should be OK.

The only problem with that scenario is that there is a race there where
you may end up reading fewer bytes than are actually on the pipe but
I guess that all pipe I/O is inherently racy to some extent.

cgf

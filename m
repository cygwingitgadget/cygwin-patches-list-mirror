Return-Path: <cygwin-patches-return-4335-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32258 invoked by alias); 31 Oct 2003 21:26:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32249 invoked from network); 31 Oct 2003 21:26:58 -0000
Date: Fri, 31 Oct 2003 21:26:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suspend all thread on SIGSTOP
Message-ID: <20031031212656.GB8668@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FA2D171.6080806@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA2D171.6080806@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00054.txt.bz2

On Fri, Oct 31, 2003 at 10:17:37PM +0100, Thomas Pfaff wrote:
>This time with attachment.
>
>This patch suspends all threads on SIGSTOP and resumes them on SIGCONT. 
>The corresponding functions in the pthread class are already committed.
>
>Thomas
>
>2003-10-31  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* exceptions.cc (sig_handle_tty_stop): Suspend all
>	threads on SIGSTOP, resume them on SIGCONT.

You can't suspend threads like this because SuspendThread can
hang in some situations, like when a thread is doing I/O.  That's why
there is a WaitForSingleObject here rather than just suspending the
thread.

It is not a perfect solution, obviously but this will just cause people
to complain about multi-threaded processes hanging after they hit CTRL-Z.

cgf

Return-Path: <cygwin-patches-return-2647-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11894 invoked by alias); 14 Jul 2002 18:26:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11880 invoked from network); 14 Jul 2002 18:26:58 -0000
Message-ID: <005301c22b64$56c7e4e0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <002a01c22b2f$07f9bda0$6132bc3e@BABEL> <20020714161750.GA26964@redhat.com>
Subject: Re: Protect handle issue-ettes
Date: Sun, 14 Jul 2002 11:26:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00095.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
>
> Huh?  The code in dll_crt0_1 is supposed to be called
> on a fork or an exec.  That's why I renamed it to
> debug_fixup_after_fork_exec.
> As far as I can tell it *is* called on a fork.
> strace confirms that.

Sorry Chris, I've obviously misunderstood something then.  I tried
calling setclexec() for one of the handles that was causing
trouble (the title_mutex) but it didn't change anything, while
removing the ProtectHandle call for it removed a whole lot of
warnings (as far as I can remember from this morning).

One thing that is confusing me is that if you call fcntl() to set
the close-on-exec flag for a file descriptor, this ends up calling
setclexec().  But if the clexec flag is honoured on fork (as well
as exec) how can this be right?

I'll go have another look at the code sometime soon and write some
test programs, since the volume of warnings in the cygserver
branch is a little distracting.

Thanks for the response,

// Conrad



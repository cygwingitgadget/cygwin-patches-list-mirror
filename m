Return-Path: <cygwin-patches-return-1582-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25464 invoked by alias); 13 Dec 2001 21:53:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25448 invoked from network); 13 Dec 2001 21:53:29 -0000
Date: Sat, 03 Nov 2001 15:49:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Message-ID: <20011213215355.GA20040@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <m33d2pam3l.fsf@appel.lilypond.org> <00d501c17d93$1936c990$0200a8c0@lifelesswks> <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3667ax540.fsf@appel.lilypond.org>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00114.txt.bz2

On Thu, Dec 13, 2001 at 09:00:31PM +0100, Jan Nieuwenhuizen wrote:
>"Robert Collins" <robert.collins@itdomain.com.au> writes:
>
>> I suspect that that is actually by design.Look at revision 1.2 of
>> desktop.cc and it has the same ,'s causing separate lines.
>
>So maybe it was very late when the code was designed :-)  Removing
>/etc/profile and running (the non-fixed) setup.exe, yields this
>snippet (as you can predict from looking at the code):
>
>export PS1='\[\033]0;\w\007
>\033[32m\]\u@\h \[\033[33m\w\033[0m\]
>$ '
>
>> I don't really have an opinion on whats right here,
>
>Ok.  I like having just a one-line prompt.

I believe that the prompt reflects DJ Delorie's prompt preference, which
was, apparently, two lines.

*I'd* prefer no prompt setting at all, actually.  I think that prompt
setting should be up to the user or the local sysadmin.  AFAICT, even
Red Hat doesn't try to make a prompt decision for you.

cgf

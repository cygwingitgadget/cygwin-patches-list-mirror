Return-Path: <cygwin-patches-return-4988-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21728 invoked by alias); 23 Sep 2004 12:30:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21618 invoked from network); 23 Sep 2004 12:30:45 -0000
Date: Thu, 23 Sep 2004 12:30:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance problem])
Message-ID: <20040923123136.GG12802@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040912144258.GB11786@cygbert.vinschen.de> <20040913180937.400E2E538@carnage.curl.com> <20040914091029.GC3757@cygbert.vinschen.de> <20040922185116.GA7863@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922185116.GA7863@cygbert.vinschen.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00140.txt.bz2

On Sep 22 20:51, Corinna Vinschen wrote:
> As a follow up on this, I just found that the problem with the Win32
> native version of unison described in
> 
>   http://cygwin.com/ml/cygwin/2004-09/msg01131.html
>   
> is also a consequence of the new pipe code.  The hang only happens
> with the new code, with the old pipe code it works fine.   And Karl
> seems to be right, it only happens on XP SP2.  He tested on W2K and
> XP pre SP1, I just tested on NT4 SP6 and could verify that it works
> fine there, too.  That's really weird.

It seems that NtQueryInformationFile doesn't return useful values
anymore under XP SP2.  I'm not quite sure though since it's the first
time I'm looking into this issue.

I added a bunch of new select_printf's to peek_pipe.  Two of them just
to guard entering and leaving peek_pipe, two of them print the values
of WriteQuotaAvailable and OutboundQuota returned by NtQueryInformationFile.

It turns out that what looks like a hang is actually an endless loop
which in strace looks like this on the write side of the pipe:

[select_pipe] ssh 756 peek_pipe: considering handle 0x694, from_select = 1
[select_pipe] ssh 756 peek_pipe: write_selected
[select_pipe] ssh 756 peek_pipe: Call NtQueryInformationFile
[select_pipe] ssh 756 peek_pipe: WriteQuotaAvailable = 1024
[select_pipe] ssh 756 peek_pipe: OutboundQuota = 16117632
[select_pipe] ssh 756 peek_pipe: return

[select_pipe] ssh 756 peek_pipe: considering handle 0x694, from_select = 1
[select_pipe] ssh 756 peek_pipe: write_selected
[select_pipe] ssh 756 peek_pipe: Call NtQueryInformationFile
[select_pipe] ssh 756 peek_pipe: WriteQuotaAvailable = 1024
[select_pipe] ssh 756 peek_pipe: OutboundQuota = 16117632
[select_pipe] ssh 756 peek_pipe: return

[...]

Since WriteQuotaAvailable is < PIPE_BUF and OutboundQuota is ... way
too big, gotone resp. s->write_ready never gets set.

This is just an analyzis of the situation.  So far I have no idea how
to solve that issue (except for reverting the pipe changes which sounds
a bit cowardly).

I also searched MSDN/KB as well as google but to no avail.  I'm wondering
if Microsoft decided to fill this officially undocumented structure with
different information for some purpose which is beyond the horizon of us
low folks...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

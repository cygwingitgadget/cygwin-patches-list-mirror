Return-Path: <cygwin-patches-return-5004-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3977 invoked by alias); 4 Oct 2004 15:21:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3967 invoked from network); 4 Oct 2004 15:21:21 -0000
Date: Mon, 04 Oct 2004 15:21:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance problem])
Message-ID: <20041004152225.GA22907@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040923123136.GG12802@cygbert.vinschen.de> <20040923162828.CA385E4F9@wildcard.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923162828.CA385E4F9@wildcard.curl.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00005.txt.bz2

On Sep 23 12:28, Bob Byrnes wrote:
> On Sep 23,  2:31pm, Corinna Vinschen wrote:
> -- Subject: Re: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance 
> >
> > It seems that NtQueryInformationFile doesn't return useful values
> > anymore under XP SP2.  I'm not quite sure though since it's the first
> > time I'm looking into this issue.
> > ...
> > [select_pipe] ssh 756 peek_pipe: WriteQuotaAvailable = 1024
> > [select_pipe] ssh 756 peek_pipe: OutboundQuota = 16117632
> > ...
> > Since WriteQuotaAvailable is < PIPE_BUF and OutboundQuota is ... way
> > too big, gotone resp. s->write_ready never gets set.
> > 
> -- End of excerpt from Corinna Vinschen

Oh oh.  While I just had another look into this issue, I found that my
debug output was somewhat wrong.

The correct results in this case using the native unison application is
the same endless loop. but with less weird numbers:

 ...
 [select_pipe] ssh 756 peek_pipe: WriteQuotaAvailable = 0
 [select_pipe] ssh 756 peek_pipe: OutboundQuota = 1024
 ...

So the NtQueryInformation results make more sense.  I'm terribly sorry
if my dumb fault led you on the wrong track :-(

But nevertheless the interaction with the native unison seems to work
fine, if the result of NtQueryInformation is ignored and the pipe is
always considered writeable.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

Return-Path: <cygwin-patches-return-4990-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4646 invoked by alias); 23 Sep 2004 16:28:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4613 invoked from network); 23 Sep 2004 16:28:29 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Thu, 23 Sep 2004 16:28:00 -0000
In-Reply-To: <20040923123136.GG12802@cygbert.vinschen.de>
       from Corinna Vinschen (Sep 23,  2:31pm)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance problem])
Message-Id: <20040923162828.CA385E4F9@wildcard.curl.com>
X-SW-Source: 2004-q3/txt/msg00142.txt.bz2

On Sep 23,  2:31pm, Corinna Vinschen wrote:
-- Subject: Re: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance 
>
> It seems that NtQueryInformationFile doesn't return useful values
> anymore under XP SP2.  I'm not quite sure though since it's the first
> time I'm looking into this issue.
> ...
> [select_pipe] ssh 756 peek_pipe: WriteQuotaAvailable = 1024
> [select_pipe] ssh 756 peek_pipe: OutboundQuota = 16117632
> ...
> Since WriteQuotaAvailable is < PIPE_BUF and OutboundQuota is ... way
> too big, gotone resp. s->write_ready never gets set.
> 
-- End of excerpt from Corinna Vinschen

I just tried some of my NtQueryInformationFile test programs on an
XP SP2 system, and they all seem to work correctly.

OutboundQuota is just the size of the pipe.  How do we know that the
cygwin ssh didn't really inherit a huge pipe from the win32-native
unison?

Also, OutboundQuota is only used in the cygwin select code to detect
and deal with tiny pipes ...

          /* If we somehow inherit a tiny pipe (size < PIPE_BUF), then consider
             the pipe writable only if it is completely empty, to minimize the
             probability that a subsequent write will block.  */
          else if (fpli.OutboundQuota < PIPE_BUF &&
                   fpli.WriteQuotaAvailable == fpli.OutboundQuota)

... so even if OutboundQuota were wrong, I don't see how a huge value
would cause incorrect behavior.

The real trouble here seems to be that WriteQuotaAvailable is so low,
which (if that is to be believed) indicates the pipe has almost filled.
This seems similar to the sftp problem, which I am still investigating;
I haven't made much progress during the past week because I've been
busy with other things at work, but I have learned a few new things
and I'll try to send another report as soon as I can construct a
coherent explanation.

--
Bob

Return-Path: <cygwin-patches-return-5022-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10258 invoked by alias); 6 Oct 2004 09:56:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10241 invoked from network); 6 Oct 2004 09:56:37 -0000
Date: Wed, 06 Oct 2004 09:56:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance problem])
Message-ID: <20041006095742.GT6702@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041004152225.GA22907@cygbert.vinschen.de> <20041005162633.4295AE556@wildcard.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005162633.4295AE556@wildcard.curl.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00023.txt.bz2

On Oct  5 12:26, Bob Byrnes wrote:
> But there is a strange twist:  When a read is pending on an empty pipe,
> then WriteQuotaAvailable is also decremented!  I can't imagine why this
> would be the case, but it is easy to demonstrate using a pair of small
> test programs that I wrote to experiment with pipe buffering.

Oh boy!

> I think my speculations about POSIX atomicity requirements related to
> PIPE_BUF were a red herring.  Ditto for hypothetical bizarre pipe
> buffering behavior.  The real problem here is NtQueryInformationFile.
> 
> I want to first try reversing the direction of the pipe.  We don't really
> care which end is the server or client, so we could easily modify our pipe
> creation code to make an outbound pipe, and if WriteQuotaAvailable from
> NtQueryInformationFile behaves sanely, then we're done.

Yep, that sounds interesting.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

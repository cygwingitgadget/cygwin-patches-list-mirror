Return-Path: <cygwin-patches-return-3951-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13548 invoked by alias); 12 Jun 2003 16:31:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13499 invoked from network); 12 Jun 2003 16:31:43 -0000
Date: Thu, 12 Jun 2003 16:31:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems on accessing Windows network resources
Message-ID: <20030612163141.GE30116@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030611230336.00807a30@mail.attbi.com> <20030612152149.GB30116@cygbert.vinschen.de> <3EE8A3DB.893CDD28@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE8A3DB.893CDD28@ieee.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00178.txt.bz2

On Thu, Jun 12, 2003 at 12:01:31PM -0400, Pierre A. Humblet wrote:
> If changing the type to return a value is likely to break
> existing applications, I would no do it.

I don't think so.  Well... it might in case the compiler's optimizer
relied somehow on the fact that the function didn't return a value
so far.  I'm not sure.  That disturbs me a bit.

> The feedback is meant for application writers or porters 
> who attempt to use the function in a way it was not designed 
> for.

What would that be?  You mean, when running under an impersonated
account, another new token and seteuid would fail on other systems
and therefore returning EPERM makes some sort of sense?  The (not
really big) problem I see with this approach is that the old
currently impersonated token is a token which might *have* appropriate
privileges so the EPERM would be somewhat misleading.

> The patch turns those calls into noops (with strace
> output), which should suffice in practice. 

I don't understand what you mean.  The call would nevertheless replace
the old token so what means "noop" here?

Except for the above point I think the patch is fine.  Just give me the
weekend for some testing, ok?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

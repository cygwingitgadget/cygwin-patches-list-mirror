Return-Path: <cygwin-patches-return-3952-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8670 invoked by alias); 12 Jun 2003 16:54:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8649 invoked from network); 12 Jun 2003 16:54:33 -0000
Message-ID: <3EE8B0BF.AA4DE8A0@ieee.org>
Date: Thu, 12 Jun 2003 16:54:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Problems on accessing Windows network resources
References: <3.0.5.32.20030611230336.00807a30@mail.attbi.com> <20030612152149.GB30116@cygbert.vinschen.de> <3EE8A3DB.893CDD28@ieee.org> <20030612163141.GE30116@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00179.txt.bz2

Corinna Vinschen wrote:
> 
> On Thu, Jun 12, 2003 at 12:01:31PM -0400, Pierre A. Humblet wrote:
> > If changing the type to return a value is likely to break
> > existing applications, I would no do it.
> 
> I don't think so.  Well... it might in case the compiler's optimizer
> relied somehow on the fact that the function didn't return a value
> so far.  I'm not sure.  That disturbs me a bit.

Same here.

> > The feedback is meant for application writers or porters
> > who attempt to use the function in a way it was not designed
> > for.
> 
> What would that be?  You mean, when running under an impersonated
> account, another new token and seteuid would fail on other systems
> and therefore returning EPERM makes some sort of sense?  

On recent Windows one can call LogonUser without privileges. Someone
could try to implement some kind of su. The problem would show up
when running that command twice.

> The (not
> really big) problem I see with this approach is that the old
> currently impersonated token is a token which might *have* appropriate
> privileges so the EPERM would be somewhat misleading.

I looked at all codes in errno.h and couln't find anything better.
POSIX says: " EPERM Operation not permitted. "
Cygwin doesn't permit that operation in some cases...

> > The patch turns those calls into noops (with strace
> > output), which should suffice in practice.
> 
> I don't understand what you mean.  The call would nevertheless replace
> the old token so what means "noop" here?

Nope, the old token isn't replaced (in the patch).

> Except for the above point I think the patch is fine.  Just give me the
> weekend for some testing, ok?

The more testing, the better.
I hope you also have other weekend plans!

Pierre

Return-Path: <cygwin-patches-return-3953-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28208 invoked by alias); 12 Jun 2003 17:01:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28190 invoked from network); 12 Jun 2003 17:01:43 -0000
Date: Thu, 12 Jun 2003 17:01:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems on accessing Windows network resources
Message-ID: <20030612170142.GG30116@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030611230336.00807a30@mail.attbi.com> <20030612152149.GB30116@cygbert.vinschen.de> <3EE8A3DB.893CDD28@ieee.org> <20030612163141.GE30116@cygbert.vinschen.de> <3EE8B0BF.AA4DE8A0@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE8B0BF.AA4DE8A0@ieee.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00180.txt.bz2

On Thu, Jun 12, 2003 at 12:56:31PM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > I don't understand what you mean.  The call would nevertheless replace
> > the old token so what means "noop" here?
> 
> Nope, the old token isn't replaced (in the patch).

Ouch, I misread the patch.  I'm not sure we really should do that.
Anyway, testing first...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

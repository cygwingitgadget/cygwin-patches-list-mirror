Return-Path: <cygwin-patches-return-3954-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8338 invoked by alias); 12 Jun 2003 17:30:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8302 invoked from network); 12 Jun 2003 17:30:23 -0000
Message-ID: <3EE8B927.59C9270C@ieee.org>
Date: Thu, 12 Jun 2003 17:30:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Problems on accessing Windows network resources
References: <3.0.5.32.20030611230336.00807a30@mail.attbi.com> <20030612152149.GB30116@cygbert.vinschen.de> <3EE8A3DB.893CDD28@ieee.org> <20030612163141.GE30116@cygbert.vinschen.de> <3EE8B0BF.AA4DE8A0@ieee.org> <20030612170142.GG30116@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00181.txt.bz2

Corinna Vinschen wrote:
> 
> On Thu, Jun 12, 2003 at 12:56:31PM -0400, Pierre A. Humblet wrote:
> > Corinna Vinschen wrote:
> > > I don't understand what you mean.  The call would nevertheless replace
> > > the old token so what means "noop" here?
> >
> > Nope, the old token isn't replaced (in the patch).
> 
> Ouch, I misread the patch.  I'm not sure we really should do that.

If the token is replaced and the application ever reverts to self
(e.g. during a fork or socket dup) and reimpersonates, you are in
for major confusion. There is at least another weird case.

Pierre

Return-Path: <cygwin-patches-return-3377-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5182 invoked by alias); 11 Jan 2003 13:20:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5173 invoked from network); 11 Jan 2003 13:20:49 -0000
Date: Sat, 11 Jan 2003 13:20:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: patch 3: sshd
Message-ID: <20030111142035.A11998@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>
References: <3DD15A2F.B79E5376@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD15A2F.B79E5376@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2003-q1/txt/msg00026.txt.bz2

On Tue, Nov 12, 2002 at 02:44:47PM -0500, Pierre A. Humblet wrote:
> > > It is literally a two line change in Cygwin to fix
> > > that, but unfortunately changing uids breaks sshd
> > > on Win95/98/ME.
> > 
> > Can we really do this?  Doesn't that potentially break something?
> 
> It makes Cygwin more unix-like, so it should be OK.
> I tested it and the only problem I found was sshd.

Btw., I applied that patch to 3.5p1-3 and I've send it to the openssh
developers list.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

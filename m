Return-Path: <cygwin-patches-return-2157-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7003 invoked by alias); 6 May 2002 10:09:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6987 invoked from network); 6 May 2002 10:09:10 -0000
Date: Mon, 06 May 2002 03:09:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: automatic TZ in non-english windows
Message-ID: <20020506120908.I9238@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000101c1f3a4$b25a8f30$010115ac@NEXUS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c1f3a4$b25a8f30$010115ac@NEXUS>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00141.txt.bz2

On Sat, May 04, 2002 at 09:48:42PM +0200, Norbert Schulze wrote:
> > ChangeLog:
> > 
> > 2002-04-28  Norbert Schulze  <norbert.schulze@web.de>
> > 
> >         * localtime.cc (tzsetwall): use wildabbr if generated 
> >         timezone name length < 3
> 
> After nearly one week of no response, what must I do that
> my patch gets finally committed?

Sorry about that.  Chris and I had a short mail exchange about
that patch.  What I'd like to see is just a bit more of an
explanation why the patch is needed.  Especially two points,
where in the common standards did you find that a timezone
string must be three chars to be valid and could you give
an example what else is stored at that point in non-english
OSes?

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

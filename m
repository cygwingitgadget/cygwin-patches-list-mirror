Return-Path: <cygwin-patches-return-1706-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28923 invoked by alias); 15 Jan 2002 14:09:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28862 invoked from network); 15 Jan 2002 14:09:17 -0000
Date: Tue, 15 Jan 2002 06:09:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: A few fixes to winsup/utils/cygpath.cc
Message-ID: <20020115150915.H2015@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <C2D7D58DBFE9D111B0480060086E96350689B7D8@mail_server.gft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7D58DBFE9D111B0480060086E96350689B7D8@mail_server.gft.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00063.txt.bz2

On Tue, Jan 15, 2002 at 03:01:20PM +0100, Schaible, Jorg wrote:
> >That is a reversed patch either.  That should help:
> 
> <sigh>
> Sorry again.
> 
> ==========================
> 2002-01-14  Joerg Schaible <joerg.schaible@gmx.de>
> 
> 	* cygpath.cc (doit): Empty file ignored using option -i

Thanks.  Applied with a minor tweak in the ChangeLog:

	* cygpath.cc (doit): Empty file ignored using option -i.
	                                                       ^
							    Full stop.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

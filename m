Return-Path: <cygwin-patches-return-2981-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10661 invoked by alias); 16 Sep 2002 16:50:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10643 invoked from network); 16 Sep 2002 16:50:47 -0000
Date: Mon, 16 Sep 2002 09:50:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: [PATCH] check for valid pthread_self pointer
In-reply-to: <1032176803.17676.135.camel@lifelesswks>
To: Robert Collins <rbcollins@cygwin.com>
Cc: cygwin-patches@cygwin.com
Mail-followup-to: Robert Collins <rbcollins@cygwin.com>,
 cygwin-patches@cygwin.com
Message-id: <20020916165427.GI424@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <Pine.WNT.4.44.0208071245020.353-200000@algeria.intern.net>
 <20020816112218.GA892@tishler.net> <1032176803.17676.135.camel@lifelesswks>
X-SW-Source: 2002-q3/txt/msg00429.txt.bz2

Rob,

On Mon, Sep 16, 2002 at 09:46:38PM +1000, Robert Collins wrote:
> On Fri, 2002-08-16 at 21:22, Jason Tishler wrote:
> > Rob,
> > 
> > On Wed, Aug 07, 2002 at 05:19:10PM +0200, Thomas Pfaff wrote:
> > > This patch should fix the problem with the ipc-daemon started as
> > > service and threads that are not created by pthread_create.
> > 
> > Please evaluate and commit if OK -- the PostgreSQL folks could really
> > use this.
> 
> BTW: they really should use pthread_create if they want to use threaded
> code with cygwin. But you knew that right?

Huh?  This is really a cygipc issue -- not a PostgreSQL issue.
Unfortunately, PostgreSQL is dependent on cygipc until cygserver
supports IPC.

Note that this problem only manifested itself when ipc-daemon was run as
true NT service as opposed to the command line or cygrunsrv.

Jason

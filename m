Return-Path: <cygwin-patches-return-1852-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26027 invoked by alias); 7 Feb 2002 15:04:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25993 invoked from network); 7 Feb 2002 15:04:54 -0000
Date: Thu, 07 Feb 2002 07:05:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: connect patch
Message-ID: <20020207160451.A14241@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020206180727.GA504@dothill.com> <20020207145625.X14241@cygbert.vinschen.de> <20020207144436.GA1264@dothill.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020207144436.GA1264@dothill.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00209.txt.bz2

On Thu, Feb 07, 2002 at 09:44:36AM -0500, Jason Tishler wrote:
> Corinna,
> 
> On Thu, Feb 07, 2002 at 02:56:25PM +0100, Corinna Vinschen wrote:
> > On Wed, Feb 06, 2002 at 01:07:28PM -0500, Jason Tishler wrote:
> > > Was this the right thing to do?
> > 
> > The patch isn't correct since it now calls fdsock() twice which allocates
> > a new fhandler even if the line before already had created one.
> > 
> > Better:
> > 
> >   fhandler_socket* res_fh = fdsock (fd, name, soc)->set_addr_family (af);
> >   if (af == AF_LOCAL)
> >     res_fh->set_sun_path (name);
> 
> Oops, I thought that the second call would only return a pointer to the
> previously created fhandler.
> 
> > However, I don't understand the need for that patch.  Does postgresql
> > call getsockname() before calling bind()?
> 
> I don't know, but I guess that it does.
> 
> > So, IMO, the correct way is to clean up cygwin_getsockname()
> > so that it always returns "something" instead of SEGVing.
> > 
> > Could you please test the below patch if that works with postgresql?
> 
> The above works great!

Thanks for the quick reply.  I've checked it in.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

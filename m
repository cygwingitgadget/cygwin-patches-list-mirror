Return-Path: <cygwin-patches-return-2183-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20284 invoked by alias); 13 May 2002 13:07:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20269 invoked from network); 13 May 2002 13:07:33 -0000
Message-ID: <20020513130713.35710.qmail@web20005.mail.yahoo.com>
Date: Mon, 13 May 2002 06:07:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: long-option kill patch
To: cygwin-patches@cygwin.com
In-Reply-To: <20020513052403.GA22985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00167.txt.bz2


--- Christopher Faylor <cgf@redhat.com> wrote:
> On Sun, May 12, 2002 at 08:30:09PM -0700, Joshua Daniel Franklin wrote:
> >Is there something wrong with the patch for kill.cc?
> >It's a very simple patch:
> >
> >http://www.cygwin.com/ml/cygwin-patches/2002-q2/msg00146.html
> >
> >I'd be happy to fix it if there is something wrong, but I'm
> >not psycic about what...
> 
> As I'd previously indicated, I preferred if the option processing was
> done via getopt.  I just checked in a patch to do that.  I also
> implemented the -l and -s options.
> 
> Sorry for not providing feedback, I'd had a partial implementation
> sitting in my sandbox and I just polished it off tonight.
> 

I'm impressed. After I saw the util-linux version of kill didn't use
getopt I gave up on it. Obviously, I'll stick with being an admin...

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com

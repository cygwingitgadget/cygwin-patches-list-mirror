Return-Path: <cygwin-patches-return-4375-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26223 invoked by alias); 14 Nov 2003 12:58:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26214 invoked from network); 14 Nov 2003 12:58:11 -0000
Date: Fri, 14 Nov 2003 12:58:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: thunking, the next step
Message-ID: <20031114125810.GV18706@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4C443.2040301@cygwin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB4C443.2040301@cygwin.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00094.txt.bz2

On Fri, Nov 14, 2003 at 11:02:11PM +1100, Robert Collins wrote:
> Ok, I've now integrated and generalised Ron's unicode support mini-patch.
> 
> So, here tis a version that, well the changelog explains the overview, 
> and io.h the detail.
> 
> Overhead wise, this is reasonably low:
> 1 strlen() per IO call minimum.

I'm wondering if we couldn't get rid of that strlen call.  These
functions already get a Windows path.  This path is constructed by a
call to path_conv::check().  check() already scans the path so it
should be simple to add a length field to path_conv, which could
be used when calling the IOThunkState constructor.

Right?  Wrong?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

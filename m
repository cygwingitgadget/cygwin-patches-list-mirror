Return-Path: <cygwin-patches-return-1728-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26062 invoked by alias); 17 Jan 2002 13:21:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26047 invoked from network); 17 Jan 2002 13:21:49 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A40@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: FW: fnmatch
Date: Thu, 17 Jan 2002 05:21:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2002-q1/txt/msg00085.txt.bz2

Yes.  I'll try to get to that today.

> -----Original Message-----
> From: Corinna Vinschen [mailto:cygwin-patches@cygwin.com] 
> Sent: Thursday, January 17, 2002 5:47 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: FW: fnmatch
> 
> 
> On Wed, Jan 16, 2002 at 09:58:25PM -0500, Mark Bradshaw wrote:
> > All right.  With blessings all around I'll do so.
> 
> So, if I understood correctly, you're going to contribute strptime().
> 
> I've just added fnmatch() from OpenBSD to Cygwin.  The only 
> change needed was adding a
> 
>   #include "winsup.h"
> 
> at the beginning to correctly use symbols from <ctype.h>.
> 
> Corinna
> 
> -- 
> Corinna Vinschen                  Please, send mails 
> regarding Cygwin to
> Cygwin Developer                                
> mailto:cygwin@cygwin.com
> Red Hat, Inc.
> 

Return-Path: <cygwin-patches-return-2041-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22947 invoked by alias); 10 Apr 2002 03:11:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22933 invoked from network); 10 Apr 2002 03:11:12 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2E79@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: patch: strptime
Date: Tue, 09 Apr 2002 20:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2002-q2/txt/msg00025.txt.bz2

Sorry.  I misunderstood what Corinna told me.  Thanks for fixing it for me.

> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com] 
> Sent: Tuesday, April 09, 2002 7:43 PM
> To: Mark Bradshaw
> Cc: 'newlib@sources.redhat.com'; cygwin-patches@cygwin.com
> Subject: Re: patch: strptime
> 
> 
> On Tue, Apr 09, 2002 at 03:52:18PM -0400, Mark Bradshaw wrote:
> >For cygwin:
> >2002-04-09  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
> >
> >	  * cygwin.din: Add strptime.
> >	  * include/cygwin/version.h: Increment minor version number.
> 
> I've checked this in with one fix.  You don't increment the 
> minor version number when a new function is added.  That 
> would have changed the cygwin version to 1.3.11.  Instead, 
> you increment the API minor number when you export a new 
> function.  This is what I've done.
> 
> cgf
> 

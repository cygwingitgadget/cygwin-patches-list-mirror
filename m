Return-Path: <cygwin-patches-return-1919-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30240 invoked by alias); 27 Feb 2002 18:07:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30200 invoked from network); 27 Feb 2002 18:07:11 -0000
Message-ID: <20020227180702.22136.qmail@web20004.mail.yahoo.com>
Date: Wed, 27 Feb 2002 10:07:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: version information for cygcheck
To: Warren Young <warren@etr-usa.com>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <3C7D0F96.48B764E8@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00276.txt.bz2


--- Warren Young <warren@etr-usa.com> wrote:
> Joshua Daniel Franklin wrote:
> > 
> >  -z, --version      output version information and exit
> > 
> > I used -z since -v is --verbose. It could also have no character
> > option if that would be better. 
> 
> Why not -V?

No no no. Makes much too much sense. You'd think I was adding version
information for the users or someting.

Lastest patch: 
corrects copyright dates
version now -V, not -z

I think this one's going to work, so here's a changelog:

2001-02-27  Joshua Daniel Franklin  <joshuadfranklin@yahoo.com>

* cygcheck.cc: added -V --version option, corrected -h to output to stdout




__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com

Return-Path: <cygwin-patches-return-1963-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16765 invoked by alias); 10 Mar 2002 00:48:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16741 invoked from network); 10 Mar 2002 00:48:50 -0000
Message-ID: <20020310004849.86224.qmail@web20001.mail.yahoo.com>
Date: Sat, 09 Mar 2002 18:17:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: getfacl.c help/version patch
To: cygwin-patches@cygwin.com
In-Reply-To: <20020309221259.GB21116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00320.txt.bz2

--- Christopher Faylor <cgf@redhat.com> wrote:
> Can I ask you to also take a look at the utils.sgml file and update the
> documentation there, too?  It should be self-explanatory.
> 
> If you feel like regularizing the presentation in this file so that all
> of the options are displayed in the same way that would be an added
> plus.

Yeah, I am meaning to do just one patch for utils.sgml after all the rest.
It appears that the "regular" way of showing options is to box up the
usage output. Everything except kill demonstrates options that way, but
after I standardize kill it will to. I can also add entries in utils.sgml
for dumper, getfacl, and setfacl. Is this what you had in mind?

Speaking of kill, by the way, I wrote a bash script to test signals and it
complained about SIGCLD (20) and SIGPOLL (23) like this:

./testkill.bash: trap: POLL: not a signal specification

Are these signals no longer defined? 

It also looks like I'm going to need to make more substantial changes to
kill.cc to get it to use getopt...and to get rid of that goto if possible.


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/

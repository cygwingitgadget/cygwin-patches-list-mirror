Return-Path: <cygwin-patches-return-1754-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17793 invoked by alias); 19 Jan 2002 20:39:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17779 invoked from network); 19 Jan 2002 20:39:53 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A89@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: New addition to cygwin: recvmsg and sendmsg
Date: Sat, 19 Jan 2002 12:39:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2002-q1/txt/msg00111.txt.bz2

> -----Original Message-----
> From: Corinna Vinschen [mailto:cygwin-patches@cygwin.com] 
> Sent: Saturday, January 19, 2002 11:19 AM
> To: cygpatch
> Subject: Re: New addition to cygwin: recvmsg and sendmsg
> 
> Thanks, Mark!  I applied it with *just* a few changes to the
> ChangeLog:
> 
>         * cygwin.din: Add recvmsg and sendmsg.
> 	* net.cc: Add cygwin_recvmsg and cygwin_sendmsg.
> 	* /usr/include/sys/socket.h: Add recvmsg and sendmsg.
> 
> Do you see the differences? Present tense, upper case after 
> the colon, full stop at the end of a sentence.

Got it.  One more thing to add to my growing list of Changelog do's and
don't's.  I swear, the day I submit a perfect changelog the world will come
to an end.  Or hell will freeze over.  Or AOL will buy Redhat.

> And there's something else important.  Adding new functions
> to the API requires us to bump CYGWIN_VERSION_API_MINOR in 
> include/cygwin/version.h.  I did that now but it would be
> nice(tm) if you could do that by yourself when you add a
> new function to the API next time (e.g strptime :-)).

Ok.  I'll remember that for next time.

Mark

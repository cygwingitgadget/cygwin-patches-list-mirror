Return-Path: <cygwin-patches-return-1676-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13075 invoked by alias); 12 Jan 2002 12:33:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13060 invoked from network); 12 Jan 2002 12:33:15 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D29E9@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: FW: [PATCH] mkpasswd.c - allows selection of specific user
Date: Sat, 12 Jan 2002 04:33:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2002-q1/txt/msg00033.txt.bz2

That's what I (a sys admin) thought too.  I like that.  I think I'll try the
brackets and see how it looks.

> -----Original Message-----
> From: Robert Collins [mailto:robert.collins@itdomain.com.au]
> Sent: Saturday, January 12, 2002 4:19 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
> 
> 
> ----- Original Message -----
> From: "Christopher Faylor" <cgf@redhat.com>
> > These are nice changes, but I have a few observations:
> 
> > 2) I don't think there is any reason to report the number if you
> >    are translating the text, so, I'd prefer:
> >
> >    mkpasswd: The user name could not be found
> 
> My 2c: keep the number. Put it in brackets or something. It's
> a _lot_ easier for sysadmins.
> 
> Rob
> 

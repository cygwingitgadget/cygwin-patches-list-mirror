Return-Path: <cygwin-patches-return-1563-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17572 invoked by alias); 4 Dec 2001 10:24:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17552 invoked from network); 4 Dec 2001 10:24:02 -0000
Date: Thu, 01 Nov 2001 18:42:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
Message-ID: <20011204112404.J10634@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <911C684A29ACD311921800508B7293BA037D2827@cnmail> <20011204042254.GB9987@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204042254.GB9987@redhat.com>; from cgf@redhat.com on Mon, Dec 03, 2001 at 11:22:54PM -0500
X-SW-Source: 2001-q4/txt/msg00095.txt.bz2

On Mon, Dec 03, 2001 at 11:22:54PM -0500, Christopher Faylor wrote:
> On Mon, Dec 03, 2001 at 09:24:47PM -0500, Mark Bradshaw wrote:
> >It just occurred to me that the patch I submitted for mkpasswd.c causes one
> >of its error messages to be a bit misleading.  If you ask mkpasswd for a
> >user that doesn't exist it will say:
> >"NetUserEnum() failed with error 2221.
> >That user doesn't exist."
> >
> >While the error number is correct, and the explanation on the second line is
> >right, it's not actually NetUserEnum that's been called to determine that.
> >I don't know if you care about this, but maybe the following patch could be
> >thrown in to make that error a bit more generic (and correct).
> 
> I agree that the user doesn't have to know about NetUserEnum but the
> error message should be something like "mkpasswd: user doesn't exist".
> 
> Some of the messages are like this already.  Are you interested in
> genercizing the rest of the mkpasswd warnings?
> 
> cgf

I agree.  It would be nice(tm) to have an error message as the above
"mkpasswd: user doesn't exist" or, if actually an error occurs, to
have a "mkpasswd: <Win32 error message>".  That's not only useful for
mkpasswd but for all tools calling Win32 error directly.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

Return-Path: <cygwin-patches-return-1675-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12846 invoked by alias); 12 Jan 2002 12:32:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12831 invoked from network); 12 Jan 2002 12:32:41 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D29E8@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] mkpasswd.c - allows selection of specific user
Date: Sat, 12 Jan 2002 04:32:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2002-q1/txt/msg00032.txt.bz2

> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com] 
> Sent: Friday, January 11, 2002 10:19 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
> 
> 
> On Fri, Jan 11, 2002 at 08:59:47PM -0500, Mark Bradshaw wrote:
> >Corinna,
> >  You probably don't remember this, but I had volunteered back in 
> >December to make the error messages in mkpasswd a bit more user 
> >friendly.  Well, I finally took a few free moments to take a stab at 
> >it.  I sprinkled a liberal dose of FormatMessage wherever error 
> >reporting was going on.  So before, where there'd be a message that 
> >basically said, "You got error number 12345", now it'll 
> print out the 
> >corresponding text.
> 
> These are nice changes, but I have a few observations:
> 
> 1) The ChangeLog needs work.  See http://cygwin.com/contrib.html .

Bleh.  It's always my Changelog.  I seem to be Changelog challenged, but I
used exactly the same format that I used last time.

> 2) I don't think there is any reason to report the number if you
>    are translating the text, so, I'd prefer:
> 
>    mkpasswd: The user name could not be found
> 
> 3) Rather than sprinkle FormatMessage throughout the code, couldn't
>    a single function be used instead.  It looks like mkpasswd just
>    needs some kind of generic error function which takes an argument
>    indicating whether to translate the Windows error or not.

Ok.  I'll do that.

> I look forward to getting these into cygwin.  Translating the 
> errors will reduce a lot of user confusion.
> 
> Btw, do you have an assignment on file with Red Hat?  I can't 
> remember. If not, you'll need to send in an assignment as 
> referenced in the above URL.

Yeah.  I did one for the -u option of mkpasswd.
